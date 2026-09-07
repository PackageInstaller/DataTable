local NewCommanderScene = class("NewCommanderScene", import("..base.BaseUI"))

function NewCommanderScene:getUIName()
	return "GetCommanderUI"
end

function NewCommanderScene:init()
	self.bgTF = self._tf:Find("main/bg")
	self.clickTF = self._tf:Find("click")
	self.paintTF = self._tf:Find("main/paint")
	self.paintTFCG = self.paintTF:GetComponent(typeof(CanvasGroup))
	self.infoTF = self._tf:Find("main/info")
	self.leftPanel = self._tf:Find("left_panel")
	self.lockBtn = self._tf:Find("left_panel/btns/lock")
	self.unlockBtn = self._tf:Find("left_panel/btns/unlock")
	self.shareBtn = self._tf:Find("left_panel/btns/share")
	self.nameTF = self.infoTF:Find("content/name/value"):GetComponent(typeof(Text))
	self.nationTF = self.infoTF:Find("content/nation/value"):GetComponent(typeof(Text))
	self.rarityTF = self.infoTF:Find("content/rarity/value"):GetComponent(typeof(Image))
	self.skillTF = self.infoTF:Find("content/skill/value"):GetComponent(typeof(Text))
	self.abilitysTF = self.infoTF:Find("content/abilitys/attrs")
	self.talentsTF = self.infoTF:Find("content/talents")
	self.talentsList = UIItemList.New(self.talentsTF, self.talentsTF:Find("talent"))
	self.dateTF = self.infoTF:Find("content/copyright/Text")
	self.treePanel = CommanderTreePage.New(self._tf, self.event)
	self.msgbox = CommanderMsgBoxPage.New(self._tf, self.event)
	self.antor = self._tf:GetComponent(typeof(Animator))
	self.skipBtn = self._tf:Find("skip")
	self.getEffect = self._tf:Find("main/effect")
	self.skipAnim = true

	if pg.NewGuideMgr.GetInstance():IsBusy() then
		self.skipAnim = false
	end

	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	setText(self._tf:Find("main/info/content/abilitys/attrs/command/name/Text"), i18n("commander_command_ability"))
	setText(self._tf:Find("main/info/content/abilitys/attrs/tactic/name/Text"), i18n("commander_tactical_ability"))
	setText(self._tf:Find("main/info/content/abilitys/attrs/support/name/Text"), i18n("commander_logistics_ability"))
	setText(self._tf:Find("main/info/content/copyright/title"), i18n("commander_get_commander_coptyright"))

	return
end

function NewCommanderScene:openTreePanel(arg_3_1)
	local function var_3_0()
		self.treePanel:ActionInvoke("Show", arg_3_1)

		return
	end

	if self.treePanel:GetLoaded() then
		var_3_0()
	else
		self.treePanel:Load()
		self.treePanel:CallbackInvoke(var_3_0)
	end

	return
end

function NewCommanderScene:closeTreePanel()
	self.treePanel:ActionInvoke("closeTreePanel")

	return
end

function NewCommanderScene:onUIAnimEnd(arg_6_1)
	self.antor:SetBool("play", true)

	self.isAnim = true

	setActive(self.clickTF, self.skipAnim)

	local var_6_0 = self._tf:GetComponent(typeof(DftAniEvent))

	var_6_0:SetTriggerEvent(function(arg_7_0)
		if self.contextData.commander:isSSR() then
			self:playerEffect()
		end

		var_6_0:SetTriggerEvent(nil)

		return
	end)
	var_6_0:SetEndEvent(function()
		self.isAnim = false

		setActive(self.clickTF, true)
		var_6_0:SetEndEvent(nil)
		arg_6_1()

		return
	end)

	return
end

function NewCommanderScene:playerEffect()
	PoolMgr.GetInstance():GetUI("AL_zhihuimiao_zhipian", true, function(arg_10_0)
		self.effect = arg_10_0

		SetParent(arg_10_0, self._tf)
		setActive(arg_10_0, true)

		return
	end)

	return
end

function NewCommanderScene:openMsgBox(arg_11_1)
	self.isShowMsgBox = true

	local function var_11_0()
		self.msgbox:ActionInvoke("Show", arg_11_1)

		return
	end

	if self.msgbox:GetLoaded() then
		var_11_0()
	else
		self.msgbox:Load()
		self.msgbox:CallbackInvoke(var_11_0)
	end

	return
end

function NewCommanderScene:closeMsgBox()
	self.isShowMsgBox = nil

	self.msgbox:ActionInvoke("Hide")

	return
end

function NewCommanderScene:didEnter()
	self:updateInfo()
	onButton(self, self.shareBtn, function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeCommander, pg.ShareMgr.PANEL_TYPE_PINK)

		return
	end, SFX_PANEL)
	onButton(self, self.skipBtn, function(arg_16_0)
		if self.isAnim then
			return
		end

		getProxy(CommanderProxy).hasSkipFlag = true

		self:DoExit()

		return
	end, SFX_CANCEL)
	onButton(self, self.lockBtn, function()
		self:emit(NewCommanderMediator.ON_LOCK, self.contextData.commander.id, 1 - getProxy(CommanderProxy):getCommanderById(self.contextData.commander.id):getLock())

		return
	end, SFX_PANEL)
	onButton(self, self.unlockBtn, function()
		self:emit(NewCommanderMediator.ON_LOCK, self.contextData.commander.id, 1 - getProxy(CommanderProxy):getCommanderById(self.contextData.commander.id):getLock())

		return
	end, SFX_PANEL)
	onButton(self, self.clickTF, function()
		if self.isAnim then
			self.antor:SetBool("play", false)

			if self.contextData.commander:isSSR() and not self.effect then
				self:playerEffect()
			end

			self.isAnim = nil
		else
			self:DoExit()
		end

		return
	end, SFX_CANCEL)

	return
end

function NewCommanderScene:DoExit()
	if self.contextData.commander:ShouldTipLock() then
		self:openMsgBox({
			content = i18n("commander_lock_tip"),
			onYes = function()
				self:emit(NewCommanderMediator.ON_LOCK, self.contextData.commander.id, 1)
				self:emit(NewCommanderScene.ON_CLOSE)

				return
			end,
			onNo = function()
				self:emit(NewCommanderScene.ON_CLOSE)

				return
			end
		})
	else
		self:emit(NewCommanderScene.ON_CLOSE)
	end

	return
end

function NewCommanderScene:updateLockState()
	local var_23_0 = getProxy(CommanderProxy):getCommanderById(self.contextData.commander.id):getLock()

	setActive(self.lockBtn, var_23_0 ~= 0)
	setActive(self.unlockBtn, var_23_0 == 0)

	return
end

function NewCommanderScene:updateInfo(arg_24_1)
	self:updateLockState(self.contextData.commander:getLock())

	self.nameTF.text = self.contextData.commander:getName()
	self.nationTF.text = Nation.Nation2Name(self.contextData.commander:getConfig("nationality"))
	self.skillTF.text = self.contextData.commander:getSkills()[1]:getConfig("name")

	LoadImageSpriteAsync("CommanderRarity/" .. Commander.rarity2Print(self.contextData.commander:getRarity()), self.rarityTF, true)
	setCommanderPaintingPrefab(self.paintTF, self.contextData.commander:getPainting(), "get")

	self.painting = self.contextData.commander

	self:updateAbilitys()
	self:updateTalents()
	setText(self.dateTF, pg.TimeMgr.GetInstance():CurrentSTimeDesc("%y%m%d"))

	if arg_24_1 then
		arg_24_1()
	end

	return
end

function NewCommanderScene:updateAbilitys()
	local var_25_0 = self.contextData.commander:getAbilitys()

	eachChild(self.abilitysTF, function(arg_26_0)
		local var_26_0 = var_25_0[go(arg_26_0).name]

		setText(arg_26_0:Find("slider/point"), var_26_0.value)

		arg_26_0:Find("slider"):GetComponent(typeof(Slider)).value = var_26_0.value / CommanderConst.MAX_ABILITY

		return
	end)

	return
end

function NewCommanderScene:updateTalents()
	local var_27_0 = self.contextData.commander:getTalents()

	self.talentsList:make(function(arg_28_0, arg_28_1, arg_28_2)
		if arg_28_0 == UIItemList.EventUpdate then
			local var_28_0 = var_27_0[arg_28_1 + 1]

			setActive(arg_28_2:Find("empty"), not var_27_0[arg_28_1 + 1])
			setActive(arg_28_2:Find("icon"), var_27_0[arg_28_1 + 1])

			if var_27_0[arg_28_1 + 1] then
				GetImageSpriteFromAtlasAsync("CommanderTalentIcon/" .. var_27_0[arg_28_1 + 1]:getConfig("icon"), "", arg_28_2:Find("icon"))
			end

			onButton(self, arg_28_2, function()
				self:openTreePanel(var_28_0)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.talentsList:align(3)

	return
end

function NewCommanderScene:onBackPressed()
	if self.isShowMsgBox then
		self:closeMsgBox()

		return
	end

	return
end

function NewCommanderScene:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, pg.UIMgr.GetInstance().UIMain)
	self.treePanel:Destroy()
	self.msgbox:Destroy()
	retCommanderPaintingPrefab(self.paintTF, self.painting:getPainting())

	if self.effect then
		PoolMgr.GetInstance():ReturnUI("AL_zhihuimiao_zhipian", self.effect)
	end

	if self.contextData.onExit then
		self.contextData.onExit()
	end

	return
end

return NewCommanderScene
