local MetaCharacterScene = class("MetaCharacterScene", import("...base.BaseUI"))

MetaCharacterScene.PAGES = {
	REPAIR = 3,
	ENERGY = 1,
	SYN = 4,
	TACTICS = 2
}
MetaCharacterScene.PAGES_EVENTS = {
	MetaCharacterMediator.ON_ENERGY,
	MetaCharacterMediator.ON_TACTICS,
	MetaCharacterMediator.ON_REPAIR,
	MetaCharacterMediator.ON_SYN
}
MetaCharacterScene.SCALE_ON_PITCH = {
	x = 1.7,
	y = 1.7
}
MetaCharacterScene.ON_SKILL = "MetaCharacterScene:ON_SKILL"

function MetaCharacterScene:getUIName()
	return "MetaCharacterUI"
end

function MetaCharacterScene:init()
	Input.multiTouchEnabled = false

	self:initUITextTips()
	self:initData()
	self:findUI()
	self:addListener()
	self:initMetaProgressList()
	self:initBannerList()

	return
end

function MetaCharacterScene:didEnter()
	self:overLayPanel(true)
	self:updateStart()
	self:autoOpenFunc()

	return
end

function MetaCharacterScene:willExit()
	Input.multiTouchEnabled = true

	self:overLayPanel(false)

	return
end

function MetaCharacterScene:initUITextTips()
	local var_5_0 = self._tf:Find("HidePanel/ScrollPanel/ListPanel/BannerTpl/ForScale")

	setText(var_5_0:Find("Empty/ActType/TipText"), i18n("meta_syn_rate"))
	setText(var_5_0:Find("Empty/BuildType/TipText"), i18n("meta_build"))
	setText(var_5_0:Find("Active/ActType/Text"), i18n("meta_repair_rate"))
	setText(var_5_0:Find("Active/BuildType/Text"), i18n("meta_build"))
	setText(self._tf:Find("HidePanel/PTPanel/Progress/Story/TipText1"), i18n("meta_story_tip_1"))
	setText(self._tf:Find("HidePanel/PTPanel/Progress/Story/TipText2"), i18n("meta_story_tip_2"))
	setText(self._tf:Find("HidePanel/ActTimeTip/Tip"), i18n("meta_acttime_limit"))

	return
end

function MetaCharacterScene:initData()
	self.metaProgressVOList = {}
	self.curMetaGroupID = nil
	self.curMetaProgress = nil
	self.toggleList = {}
	self.bannerTFList = {}
	self.curPageIndex = nil
	self.curMetaIndex = nil
	self.metaCharacterProxy = getProxy(MetaCharacterProxy)
	self.bayProxy = getProxy(BayProxy)
	self.indexDatas = {}

	return
end

function MetaCharacterScene:findUI()
	self.shipImg = self._tf:Find("HidePanel/ShipImg")
	self.shipNameImg = self._tf:Find("HidePanel/NameImg")
	self.noCharTF = self._tf:Find("BG/NoCharacter")
	self.indexBtn = self._tf:Find("blur_panel/adapt/top/index")
	self.hidePanel = self._tf:Find("HidePanel")
	self.scrollPanel = self.hidePanel:Find("ScrollPanel")
	self.bannerListPanel = self.scrollPanel:Find("ListPanel")
	self.bannerContainer = self.bannerListPanel:Find("Container")
	self.bannerTpl = self.bannerListPanel:Find("BannerTpl")
	self.actTimePanel = self.hidePanel:Find("ActTimeTip")
	self.actTimeText = self.actTimePanel:Find("Text")
	self.menuPanel = self.hidePanel:Find("MenuPanel")
	self.energyBtn = self.menuPanel:Find("EnergyBtn")
	self.repairBtn = self.menuPanel:Find("RepairBtn")
	self.tacticsBtn = self.menuPanel:Find("TacticsBtn")
	self.synBtn = self.menuPanel:Find("SynBtn")
	self.synDecorateTF = self.menuPanel:Find("SynDecorate")
	self.synBtnLimitTimeTF = self.synBtn:Find("Limit")
	self.synBtnLock = self.synBtn:Find("LockMask")
	self.ptPanel = self.hidePanel:Find("PTPanel")
	self.ptRedBarImg = self.ptPanel:Find("RedBar")
	self.ptPreviewBtn = self.ptPanel:Find("PreviewBtn")
	self.ptGetBtn = self.ptPanel:Find("SynBtn")
	self.ptGetBtnTag = self.ptGetBtn:Find("Tag")
	self.ptShowWayBtn = self.ptPanel:Find("ShowWayBtn")

	local var_7_0 = self.ptPanel:Find("Progress")

	self.ptProgressImg = var_7_0:Find("CircleProgress/ProgressImg")
	self.ptProgressScaleLine = var_7_0:Find("CircleProgress/ScaleLine")
	self.ptInfoPanel = var_7_0:Find("PT")
	self.ptProgressRedRightNumText = self.ptInfoPanel:Find("ProgressTextBG/PointRedText/RightNumText")
	self.ptProgressRedLeftNumText = self.ptInfoPanel:Find("ProgressTextBG/PointRedText/LeftNumText")
	self.ptProgressWhiteRightNumText = self.ptInfoPanel:Find("ProgressTextBG/PointText/RightNumText")
	self.ptProgressWhiteLeftNumText = self.ptInfoPanel:Find("ProgressTextBG/PointText/LeftNumText")
	self.ptIcon = self.ptInfoPanel:Find("PTProgressText/PTIcon")
	self.ptProgressRedText = self.ptInfoPanel:Find("PTProgressRedText")
	self.ptProgressWhiteText = self.ptInfoPanel:Find("PTProgressText")
	self.storyInfoPanel = var_7_0:Find("Story")

	local var_7_1 = self.storyInfoPanel:Find("TipText1")
	local var_7_2 = self.storyInfoPanel:Find("TipText2")

	self.storyNameText = self.storyInfoPanel:Find("StroyNameText")
	self.getShipBtn = var_7_0:Find("FinishBtn")
	self.goGetPanel = self.hidePanel:Find("GoGetPanel")
	self.goGetBtn = self.goGetPanel:Find("GoGetBtn")
	self.blurPanel = self._tf:Find("blur_panel")

	local var_7_3 = self.blurPanel:Find("adapt")

	self.backBtn = var_7_3:Find("top/back")
	self.helpBtn = var_7_3:Find("top/help")
	self.toggleBtnsTF = var_7_3:Find("left/Btns")
	self.toggleGroupSC = GetComponent(self.toggleBtnsTF, "ToggleGroup")
	self.toggleGroupSC.allowSwitchOff = true
	self.toggleList[1] = self.toggleBtnsTF:Find("Energy")
	self.toggleList[2] = self.toggleBtnsTF:Find("Tactics")
	self.toggleList[3] = self.toggleBtnsTF:Find("Repair")
	self.toggleList[4] = self.toggleBtnsTF:Find("Syn")
	self.synToggleLock = self.toggleBtnsTF:Find("SynLock")

	return
end

function MetaCharacterScene:addListener()
	onButton(self, self.backBtn, function()
		if self.curPageIndex then
			self:enterMenuPage(false)
			self:emit(MetaCharacterScene.PAGES_EVENTS[self.curPageIndex], nil, false)

			if self.curPageIndex == MetaCharacterScene.PAGES.REPAIR then
				self:backFromRepair()
			else
				self:backFromNotRepair()
			end
		else
			self:closeView()
		end

		return
	end, SFX_CANCEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.meta_help.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.indexBtn, function()
		self:openIndexLayer()

		return
	end, SFX_PANEL)
	onButton(self, self.goGetBtn, function()
		local var_12_0 = self:getCurMetaProgressVO()

		if var_12_0:isPassType() then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.CRUSING)
		elseif var_12_0:isBuildType() then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.GETBOAT, {
				page = BuildShipScene.PAGE_BUILD,
				projectName = BuildShipScene.PROJECTS.ACTIVITY
			})
		end

		return
	end, SFX_PANEL)
	onButton(self, self.ptPreviewBtn, function()
		self:emit(MetaCharacterMediator.OPEN_PT_PREVIEW_LAYER, self:getCurMetaProgressVO())

		return
	end, SFX_PANEL)
	onButton(self, self.ptGetBtn, function()
		local var_14_0 = self:getCurMetaProgressVO()
		local var_14_1 = var_14_0:getMetaProgressPTState()

		if var_14_1 == MetaProgress.STATE_CAN_AWARD then
			local var_14_2, var_14_3 = self:getOneStepPTAwardLevelAndCount()

			pg.m02:sendNotification(GAME.GET_META_PT_AWARD, {
				groupID = var_14_0.id,
				targetCount = var_14_3
			})
		elseif var_14_1 == MetaProgress.STATE_LESS_PT then
			local var_14_5 = nowWorld()

			pg.TipsMgr.GetInstance():ShowTips(i18n((var_14_5 or nil) and var_14_5:IsSystemOpen(WorldConst.SystemWorldBoss) and "meta_pt_notenough" or "meta_boss_unlock"))
		elseif var_14_1 == MetaProgress.STATE_LESS_STORY then
			pg.TipsMgr.GetInstance():ShowTips(i18n("meta_story_lock"))
		end

		return
	end, SFX_PANEL)
	onButton(self, self.ptShowWayBtn, function()
		local var_15_1 = nowWorld()

		pg.TipsMgr.GetInstance():ShowTips(i18n((var_15_1 or nil) and var_15_1:IsSystemOpen(WorldConst.SystemWorldBoss) and "meta_pt_notenough" or "meta_boss_unlock"))

		return
	end, SFX_PANEL)
	onButton(self, self.getShipBtn, function()
		local var_16_0 = self:getCurMetaProgressVO()
		local var_16_1, var_16_2 = var_16_0.metaPtData:GetResProgress()

		pg.m02:sendNotification(GAME.GET_META_PT_AWARD, {
			groupID = var_16_0.id,
			targetCount = var_16_2
		})

		return
	end, SFX_PANEL)
	onButton(self, self.synToggleLock, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

		return
	end, SFX_PANEL)
	onButton(self, self.synBtnLock, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

		return
	end)
	onButton(self, self.repairBtn:Find("RepairBtn"), function()
		self:switchPage(MetaCharacterScene.PAGES.REPAIR)

		return
	end, SFX_PANEL)
	onButton(self, self.energyBtn, function()
		self.isMainOpenLayerTag = true

		self:switchPage(MetaCharacterScene.PAGES.ENERGY)

		return
	end, SFX_PANEL)
	onButton(self, self.tacticsBtn, function()
		self.isMainOpenLayerTag = true

		self:switchPage(MetaCharacterScene.PAGES.TACTICS)

		return
	end, SFX_PANEL)
	onButton(self, self.synBtn, function()
		if not isActive(self.synBtnLock) then
			self.isMainOpenLayerTag = true

			self:switchPage(MetaCharacterScene.PAGES.SYN)
		end

		return
	end, SFX_PANEL)

	for iter_8_0, iter_8_1 in ipairs(self.toggleList) do
		onToggle(self, iter_8_1, function(arg_23_0)
			if self.curPageIndex == iter_8_0 and arg_23_0 == true then
				return
			end

			local var_23_0 = self:getCurMetaProgressVO():getShip()

			if self.curPageIndex == iter_8_0 and arg_23_0 == false then
				self:enterMenuPage(false)
				self:emit(MetaCharacterScene.PAGES_EVENTS[iter_8_0], var_23_0.id, false)
			end

			if self.curPageIndex ~= iter_8_0 and arg_23_0 == true then
				self:enterMenuPage(true)

				self.curPageIndex = iter_8_0

				self:emit(MetaCharacterScene.PAGES_EVENTS[iter_8_0], var_23_0.id, true)
			end

			return
		end)
	end

	return
end

function MetaCharacterScene:resetToggleList()
	for iter_24_0, iter_24_1 in ipairs(self.toggleList) do
		setActive(iter_24_1:Find("On"), false)
		setActive(iter_24_1:Find("Off"), true)
	end

	return
end

function MetaCharacterScene:initMetaProgressList()
	self.metaProgressVOList = self:getMetaProgressListForShow()

	self:fillMetaProgressList()

	return
end

function MetaCharacterScene:fillMetaProgressList()
	if #self.metaProgressVOList < 5 then
		for iter_26_0 = #self.metaProgressVOList + 1, 5 do
			table.insert(self.metaProgressVOList, false)
		end
	end

	return
end

function MetaCharacterScene:initBannerList()
	self.scrollUIItemList = UIItemList.New(self.bannerContainer, self.bannerTpl)

	self.scrollUIItemList:make(function(arg_28_0, arg_28_1, arg_28_2)
		if arg_28_0 == UIItemList.EventUpdate then
			table.insert(self.bannerTFList, arg_28_2)
			self:updateBannerTF(self.metaProgressVOList[arg_28_1 + 1], arg_28_2, arg_28_1 + 1)
		end

		return
	end)

	return
end

function MetaCharacterScene:updateBannerTF(arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_2
	local var_29_1 = arg_29_2:Find("ForScale")
	local var_29_2 = var_29_1:Find("WillCome")
	local var_29_3 = var_29_1:Find("Empty")
	local var_29_4 = var_29_1:Find("Active")

	if arg_29_1 then
		local var_29_5 = arg_29_1:isInAct()

		setActive(var_29_3:Find("ActType/Tag"), var_29_5)
		setActive(var_29_3:Find("BuildType/Tag"), var_29_5)
		setActive(var_29_4:Find("ActType/Tag"), var_29_5)
		setActive(var_29_4:Find("BuildType/Tag"), var_29_5)
	end

	if arg_29_1 then
		local var_29_6 = Ship.New({
			configId = tonumber(arg_29_1.configId .. 1)
		}):getName()
		local var_29_7 = var_29_1:Find("Empty/ActType/ShipNameMask/ShipNameText")

		setText(nil, var_29_6)
		setScrollText(var_29_7, var_29_6)
		setActive(var_29_7, true)

		local var_29_9 = var_29_1:Find("Empty/BuildType/ShipNameMask/ShipNameText")

		setText(var_29_9, var_29_6)
		setScrollText(var_29_9, var_29_6)
		setActive(var_29_9, true)

		local var_29_10 = var_29_1:Find("Empty/PassType/ShipNameMask/ShipNameText")

		setText(var_29_10, var_29_6)
		setScrollText(var_29_10, var_29_6)
		setActive(var_29_10, true)

		local var_29_11 = var_29_1:Find("Active/ActType/ShipNameMask/ShipNameText")

		setText(var_29_11, var_29_6)
		setScrollText(var_29_11, var_29_6)
		setActive(var_29_11, true)

		local var_29_12 = var_29_1:Find("Active/BuildType/ShipNameMask/ShipNameText")

		setText(var_29_12, var_29_6)
		setScrollText(var_29_12, var_29_6)
		setActive(var_29_12, true)

		local var_29_13 = var_29_1:Find("Active/PassType/ShipNameMask/ShipNameText")

		setText(var_29_13, var_29_6)
		setScrollText(var_29_13, var_29_6)
		setActive(var_29_13, true)
	end

	if arg_29_1 == false then
		setActive(var_29_2, true)
		setActive(var_29_3, false)
		setActive(var_29_4, false)
	else
		setActive(var_29_2, false)

		local var_29_14 = arg_29_1:isUnlocked()

		setActive(var_29_3, not var_29_14)
		setActive(var_29_4, var_29_14)

		local var_29_15 = arg_29_1:isPtType()
		local var_29_16 = arg_29_1:isPassType()
		local var_29_17 = arg_29_1:isBuildType()

		if not var_29_14 then
			local var_29_18 = var_29_1:Find("Empty/ActType")
			local var_29_19 = var_29_1:Find("Empty/BuildType")
			local var_29_20 = var_29_1:Find("Empty/PassType")

			setActive(var_29_18, var_29_15)
			setActive(var_29_19, var_29_17)
			setActive(var_29_20, var_29_16)

			local var_29_21, var_29_22 = arg_29_1:getBannerPathAndName()
			local var_29_23 = LoadSprite(var_29_21, var_29_22)

			setImageSprite(var_29_18, var_29_23)
			setImageSprite(var_29_19, var_29_23)
			setImageSprite(var_29_20, var_29_23)

			local var_29_25

			if var_29_15 then
				setText(var_29_18:Find("NumText"), string.format("%d", arg_29_1:getSynRate() * 100) .. "%")

				local var_29_24 = var_29_18:Find("Slider")

				setSlider(var_29_24, 0, 1, arg_29_1:getSynRate())
				setActive(var_29_24, false)

				var_29_25 = {}
			end

			var_29_25.configId = pg.ship_strengthen_meta[arg_29_1.configId].ship_id

			local var_29_26 = Ship.New(var_29_25)
			local var_29_27 = var_29_26:getStar()
			local var_29_28 = UIItemList.New(var_29_1:Find("Empty/Stars"), (var_29_1:Find("Empty/StarTpl")))

			var_29_28:make(function(arg_30_0, arg_30_1, arg_30_2)
				if arg_30_0 == UIItemList.EventUpdate then
					arg_30_1 = arg_30_1 + 1

					setActive(arg_30_2:Find("On"), arg_30_1 <= var_29_27)
				end

				return
			end)
			var_29_28:align((var_29_26:getMaxStar()))
		else
			local var_29_29 = var_29_1:Find("Active/ActType")

			setActive(var_29_29, var_29_15)
			setActive(var_29_1:Find("Active/BuildType"), var_29_17)
			setActive(var_29_1:Find("Active/PassType"), var_29_16)

			local var_29_30, var_29_31 = arg_29_1:getBannerPathAndName()
			local var_29_32 = LoadSprite(var_29_30, var_29_31)

			setImageSprite(var_29_1:Find("Active"), LoadSprite(var_29_30, var_29_31))

			local var_29_33 = arg_29_1:getShip()
			local var_29_34 = var_29_33:getMetaCharacter()

			if var_29_15 then
				setText(var_29_29:Find("NumText"), string.format("%d", var_29_34:getRepairRate() * 100) .. "%")

				local var_29_35 = var_29_29:Find("Slider")

				setSlider(var_29_35, 0, 1, var_29_34:getRepairRate())
				setActive(var_29_35, false)
			end

			local var_29_36 = var_29_33:getMaxStar()
			local var_29_37 = var_29_33:getStar()
			local var_29_38 = UIItemList.New(var_29_1:Find("Active/Stars"), (var_29_1:Find("Active/StarTpl")))

			var_29_38:make(function(arg_31_0, arg_31_1, arg_31_2)
				if arg_31_0 == UIItemList.EventUpdate then
					arg_31_1 = arg_31_1 + 1

					setActive(arg_31_2:Find("On"), arg_31_1 <= var_29_37)
				end

				return
			end)
			var_29_38:align(var_29_36)
		end
	end

	onButton(self, arg_29_2, function()
		if self.curMetaIndex ~= arg_29_3 then
			if self.curMetaIndex and self.curMetaIndex > 0 then
				self:changeBannerOnClick(self.bannerTFList[self.curMetaIndex], false)
			end

			self.curMetaIndex = arg_29_3

			self:changeBannerOnClick(var_29_0, true)
			self:updateMain()
		end

		return
	end, SFX_PANEL)

	if arg_29_1 == false then
		setButtonEnabled(arg_29_2, false)
	else
		setButtonEnabled(arg_29_2, true)
	end

	return
end

function MetaCharacterScene:changeBannerOnClick(arg_33_1, arg_33_2)
	local var_33_0 = arg_33_1:GetComponent("LayoutElement")
	local var_33_1 = arg_33_1:Find("ForScale")

	if arg_33_2 == true then
		setLocalScale(var_33_1, MetaCharacterScene.SCALE_ON_PITCH)

		var_33_0.preferredWidth = 338.3
		var_33_0.preferredHeight = 102
	else
		setLocalScale(var_33_1, Vector2.one)

		var_33_0.preferredWidth = 199
		var_33_0.preferredHeight = 60
	end

	setActive(var_33_1:Find("SelectedTag"), arg_33_2)

	return
end

function MetaCharacterScene:updateBannerShipName(arg_34_1)
	local var_34_0 = arg_34_1:Find("ForScale")
	local var_34_1 = isActive((var_34_0:Find("SelectedTag")))

	setActive(var_34_0:Find("Empty/ActType/ShipNameText"), var_34_1)
	setActive(var_34_0:Find("Empty/BuildType/ShipNameText"), var_34_1)
	setActive(var_34_0:Find("Active/ActType/ShipNameText"), var_34_1)
	setActive(var_34_0:Find("Active/BuildType/ShipNameText"), var_34_1)
	setActive(var_34_0:Find("Empty/ActType/TipText"), not var_34_1)
	setActive(var_34_0:Find("Empty/BuildType/TipText"), not var_34_1)
	setActive(var_34_0:Find("Active/ActType/Text"), not var_34_1)
	setActive(var_34_0:Find("Active/BuildType/Text"), not var_34_1)

	return
end

function MetaCharacterScene:updateBannerUIList()
	self.bannerTFList = {}

	self.scrollUIItemList:align(#self.metaProgressVOList)

	return
end

function MetaCharacterScene:updateStart()
	local var_36_0 = false

	for iter_36_0, iter_36_1 in ipairs(self.metaProgressVOList) do
		if iter_36_1 ~= false then
			var_36_0 = true

			break
		end
	end

	setActive(self.indexBtn:Find("On"), not self:isDefaultStatus())
	setActive(self.noCharTF, not var_36_0)
	setActive(self.hidePanel, var_36_0)

	if not var_36_0 then
		return
	end

	self:resetBannerListScale()
	self:updateBannerUIList()

	self.curMetaIndex = nil

	if var_36_0 then
		triggerButton(self.bannerTFList[1])
	end

	return
end

function MetaCharacterScene:resetBannerListScale()
	for iter_37_0, iter_37_1 in ipairs(self.bannerTFList) do
		local var_37_0 = iter_37_1:GetComponent("LayoutElement")

		setLocalScale(iter_37_1:Find("ForScale"), Vector2.one)

		var_37_0.preferredWidth = 199
		var_37_0.preferredHeight = 60
	end

	return
end

function MetaCharacterScene:updateMain(arg_38_1)
	local var_38_0 = self:getCurMetaProgressVO()
	local var_38_1 = var_38_0:isUnlocked()

	setActive(self.menuPanel, var_38_1)
	setActive(self.ptPanel, not var_38_1)
	setActive(self.goGetPanel, not var_38_1)
	self:updateActTimePanel()

	if not var_38_1 then
		local var_38_2 = var_38_0:isPtType()

		setActive(self.ptPanel, var_38_2)
		setActive(self.goGetPanel, var_38_0:isPassType() or var_38_0:isBuildType())

		if var_38_2 then
			self:updatePTPanel(arg_38_1)
		end
	else
		self:TryPlayGuide()
	end

	self:updateRedPoints()

	local var_38_3, var_38_4 = var_38_0:getPaintPathAndName()

	setImageSprite(self.shipImg, LoadSprite(var_38_3, var_38_4), true)

	local var_38_5, var_38_6 = var_38_0:getBGNamePathAndName()

	setImageSprite(self.shipNameImg, LoadSprite(var_38_5, var_38_6), true)
	setLocalPosition(self.shipImg, {
		x = MetaCharacterConst.UIConfig[var_38_0.id][1],
		y = MetaCharacterConst.UIConfig[var_38_0.id][2]
	})
	setLocalScale(self.shipImg, {
		x = MetaCharacterConst.UIConfig[var_38_0.id][3],
		y = MetaCharacterConst.UIConfig[var_38_0.id][4]
	})

	return
end

function MetaCharacterScene:TryPlayGuide()
	pg.SystemGuideMgr.GetInstance():PlayByGuideId("NG0024")

	return
end

function MetaCharacterScene:updateActTimePanel()
	local var_40_0 = self:getCurMetaProgressVO()
	local var_40_1 = var_40_0:isInAct()

	setActive(self.actTimePanel, not var_40_0:isUnlocked() and var_40_1)
	setActive(self.synBtnLimitTimeTF, var_40_1)

	if var_40_1 then
		setText(self.actTimeText, (string.format("%d.%d.%d-%d.%d.%d", var_40_0.timeConfig[1][1][1], var_40_0.timeConfig[1][1][2], var_40_0.timeConfig[1][1][3], var_40_0.timeConfig[2][1][1], var_40_0.timeConfig[2][1][2], var_40_0.timeConfig[2][1][3])))
		setText(self.synBtnLimitTimeTF:Find("Text"), i18n("meta_pt_left", (pg.TimeMgr.GetInstance():DiffDay(pg.TimeMgr.GetInstance():GetServerTime(), (pg.TimeMgr.GetInstance():parseTimeFromConfig(var_40_0.timeConfig[2]))))))
	end

	return
end

function MetaCharacterScene:updatePTPanel(arg_41_1)
	local var_41_0 = self:getCurMetaProgressVO()
	local var_41_1 = var_41_0:getSynRate()
	local var_41_2 = tonumber(tostring(var_41_1 * 100))

	setImageSprite(self.ptIcon, LoadSprite(var_41_0:getPtIconPath()))
	setFillAmount(self.ptProgressImg, var_41_1)
	setActive(self.ptProgressScaleLine, var_41_1 < 1)

	self.ptProgressScaleLine.localEulerAngles = Vector3(0, 0, 24 * var_41_1)

	local var_41_3 = string.format("%d", var_41_2)
	local var_41_4 = string.format("%2d", (var_41_2 - math.floor(var_41_2)) * 100)

	var_41_4 = (var_41_2 - math.floor(var_41_2)) * 100 == 0 and var_41_4 .. "0%" or var_41_4 .. "%"

	setText(self.ptProgressRedLeftNumText, var_41_3)
	setText(self.ptProgressWhiteLeftNumText, var_41_3)
	setText(self.ptProgressRedRightNumText, var_41_4)
	setText(self.ptProgressWhiteRightNumText, var_41_4)

	local var_41_5, var_41_6, var_41_7 = var_41_0.metaPtData:GetResProgress()

	setText(self.ptProgressRedText, (var_41_7 >= 1 and setColorStr(var_41_5, COLOR_GREEN) or setColorStr(var_41_5, COLOR_RED)) .. "/" .. var_41_6)
	setText(self.ptProgressWhiteText, (var_41_7 >= 1 and setColorStr(var_41_5, COLOR_GREEN) or setColorStr(var_41_5, COLOR_RED)) .. "/" .. var_41_6)

	local var_41_8 = var_41_0:getMetaProgressPTState()

	if var_41_8 == MetaProgress.STATE_CAN_FINISH then
		setActive(self.ptRedBarImg, true)
		setActive(self.ptPreviewBtn, false)
		setActive(self.ptGetBtn, false)
		setActive(self.ptShowWayBtn, false)
		setActive(self.ptInfoPanel, false)
		setActive(self.storyInfoPanel, false)
		setActive(self.getShipBtn, true)
	elseif var_41_8 == MetaProgress.STATE_CAN_AWARD then
		setActive(self.ptRedBarImg, false)
		setActive(self.ptPreviewBtn, true)
		setActive(self.ptGetBtn, true)
		setActive(self.ptShowWayBtn, false)
		setActive(self.ptGetBtnTag, true)
		setActive(self.ptInfoPanel, true)
		setActive(self.storyInfoPanel, false)
		setActive(self.getShipBtn, false)
		setImageAlpha(self.ptPreviewBtn, 0)
		setImageAlpha(self.ptGetBtn, 0)
		setImageAlpha(self.ptGetBtnTag, 0)
		setImageAlpha(self.ptShowWayBtn, 0)
	elseif var_41_8 == MetaProgress.STATE_LESS_STORY then
		setActive(self.ptRedBarImg, true)
		setActive(self.ptPreviewBtn, true)
		setActive(self.ptGetBtn, true)
		setActive(self.ptShowWayBtn, false)
		setActive(self.ptGetBtnTag, false)
		setActive(self.ptInfoPanel, false)
		setActive(self.storyInfoPanel, true)
		setActive(self.getShipBtn, false)
		setText(self.storyNameText, (var_41_0:getCurLevelStoryName()))
	elseif var_41_8 == MetaProgress.STATE_LESS_PT then
		setActive(self.ptRedBarImg, false)
		setActive(self.ptPreviewBtn, true)
		setActive(self.ptGetBtn, false)
		setActive(self.ptShowWayBtn, true)
		setActive(self.ptGetBtnTag, false)
		setActive(self.ptInfoPanel, true)
		setActive(self.storyInfoPanel, false)
		setActive(self.getShipBtn, false)
		setImageAlpha(self.ptPreviewBtn, 0)
		setImageAlpha(self.ptGetBtn, 0)
		setImageAlpha(self.ptShowWayBtn, 0)
	end

	if var_41_1 > 0 and not arg_41_1 then
		if var_41_8 == MetaProgress.STATE_CAN_AWARD or var_41_8 == MetaProgress.STATE_LESS_PT then
			local var_41_9 = math.min(var_41_1, 1)

			self:managedTween(LeanTween.value, nil, go(self.ptPanel), 0, var_41_1, var_41_9):setOnUpdate(System.Action_float(function(arg_42_0)
				setFillAmount(self.ptProgressImg, arg_42_0)
				setActive(self.ptProgressScaleLine, arg_42_0 < 1)

				self.ptProgressScaleLine.localEulerAngles = Vector3(0, 0, 24 * arg_42_0)

				local var_42_0 = string.format("%d", arg_42_0 * 100)
				local var_42_1 = string.format("%2d", (arg_42_0 * 100 - math.floor(arg_42_0 * 100)) * 100)

				var_42_1 = (arg_42_0 * 100 - math.floor(arg_42_0 * 100)) * 100 == 0 and var_42_1 .. "0%" or var_42_1 .. "%"

				setText(self.ptProgressRedLeftNumText, var_42_0)
				setText(self.ptProgressWhiteLeftNumText, var_42_0)
				setText(self.ptProgressRedRightNumText, var_42_1)
				setText(self.ptProgressWhiteRightNumText, var_42_1)

				return
			end)):setOnComplete(System.Action(function()
				setFillAmount(self.ptProgressImg, var_41_1)
				setActive(self.ptProgressScaleLine, var_41_1 < 1)

				self.ptProgressScaleLine.localEulerAngles = Vector3(0, 0, 24 * var_41_1)

				local var_43_0 = string.format("%d", var_41_2)
				local var_43_1 = string.format("%2d", (var_41_2 - math.floor(var_41_2)) * 100)

				var_43_1 = (var_41_2 - math.floor(var_41_2)) * 100 == 0 and var_43_1 .. "0%" or var_43_1 .. "%"

				setText(self.ptProgressRedLeftNumText, var_43_0)
				setText(self.ptProgressWhiteLeftNumText, var_43_0)
				setText(self.ptProgressRedRightNumText, var_43_1)
				setText(self.ptProgressWhiteRightNumText, var_43_1)
				self:managedTween(LeanTween.value, nil, go(self.ptPanel), 0, 1, var_41_9 / 2):setOnUpdate(System.Action_float(function(arg_44_0)
					setImageAlpha(self.ptPreviewBtn, arg_44_0)
					setImageAlpha(self.ptGetBtn, arg_44_0)
					setImageAlpha(self.ptGetBtnTag, arg_44_0)
					setImageAlpha(self.ptShowWayBtn, arg_44_0)

					return
				end)):setOnComplete(System.Action(function()
					setImageAlpha(self.ptPreviewBtn, 1)
					setImageAlpha(self.ptGetBtn, 1)
					setImageAlpha(self.ptGetBtnTag, 1)
					setImageAlpha(self.ptShowWayBtn, 1)

					return
				end))

				return
			end))
		end
	else
		setImageAlpha(self.ptPreviewBtn, 1)
		setImageAlpha(self.ptGetBtn, 1)
		setImageAlpha(self.ptGetBtnTag, 1)
		setImageAlpha(self.ptShowWayBtn, 1)
	end

	return
end

function MetaCharacterScene:updateRedPoints()
	local var_46_0 = self:getCurMetaProgressVO()
	local var_46_1 = var_46_0.id
	local var_46_2 = MetaCharacterConst.isMetaRepairRedTag(var_46_0.id)

	setActive(self.repairBtn:Find("RepairBtn/Tag"), var_46_2)
	setActive(self.repairBtn:Find("Finish"), not MetaCharacterConst.filteMetaRepairAble(var_46_0))

	local var_46_3 = MetaCharacterConst.isMetaEnergyRedTag(var_46_1)

	setActive(self.energyBtn:Find("Tag"), var_46_3)
	setActive(self.energyBtn:Find("Finish"), not MetaCharacterConst.filteMetaEnergyAble(var_46_0))
	setActive(self.tacticsBtn:Find("Finish"), not MetaCharacterConst.filteMetaTacticsAble(var_46_0))

	local var_46_4 = MetaCharacterConst.isMetaTacticsRedTag(var_46_1)

	if var_46_0.metaShipVO then
		local var_46_5 = self.metaCharacterProxy:getMetaTacticsInfoByShipID(var_46_0.metaShipVO.id):getTacticsStateForShow()

		setActive(self.tacticsBtn:Find("Tag"), false)
		setActive(self.tacticsBtn:Find("Learnable"), var_46_5 == MetaTacticsInfo.States.LearnAble)
		setActive(self.tacticsBtn:Find("Learning"), var_46_5 == MetaTacticsInfo.States.Learning)
		setActive(self.tacticsBtn:Find("LearnFinish"), var_46_5 == MetaTacticsInfo.States.LearnFinished and var_46_4)
	else
		setActive(self.tacticsBtn:Find("Tag"), false)
		setActive(self.tacticsBtn:Find("Learnable"), false)
		setActive(self.tacticsBtn:Find("Learning"), false)
		setActive(self.tacticsBtn:Find("LearnFinish"), false)
	end

	local var_46_6 = var_46_0:isPtType()
	local var_46_7 = var_46_0:isInAct()
	local var_46_8 = var_46_0:isInArchive()

	setActive(self.synDecorateTF, var_46_6)
	setActive(self.synBtn, var_46_6)
	setActive(self.synBtnLock, var_46_6 and not var_46_7 and not var_46_8)
	setActive(self.toggleList[4], var_46_6)
	setActive(self.synToggleLock, var_46_6 and not var_46_7 and not var_46_8)

	local var_46_9

	if var_46_6 then
		var_46_9 = MetaCharacterConst.isMetaSynRedTag(var_46_1)

		setActive(self.synBtn:Find("Tag"), var_46_9)
	end

	setActive(self.synBtn:Find("Finish"), not MetaCharacterConst.filteMetaSynAble(var_46_0))
	setActive(self.toggleList[MetaCharacterScene.PAGES.REPAIR]:Find("Tip"), var_46_2)
	setActive(self.toggleList[MetaCharacterScene.PAGES.ENERGY]:Find("Tip"), var_46_3)
	setActive(self.toggleList[MetaCharacterScene.PAGES.TACTICS]:Find("Tip"), var_46_4)
	setActive(self.toggleList[MetaCharacterScene.PAGES.SYN]:Find("Tip"), var_46_9)

	for iter_46_0, iter_46_1 in ipairs(self.metaProgressVOList) do
		local var_46_10 = self.bannerTFList[iter_46_0]:Find("ForScale/RedPoint")

		if iter_46_1 then
			setActive(var_46_10, MetaCharacterConst.isMetaBannerRedPoint(iter_46_1.id))
		else
			setActive(var_46_10, false)
		end
	end

	return
end

function MetaCharacterScene:getCurMetaProgressVO()
	return self.metaProgressVOList[self.curMetaIndex]
end

function MetaCharacterScene:refreshBannerTF()
	self:updateBannerTF(self:getCurMetaProgressVO(), self.bannerTFList[self.curMetaIndex], self.curMetaIndex)

	return
end

function MetaCharacterScene:enterMenuPage(arg_49_1)
	setActive(self.hidePanel, not arg_49_1)
	setActive(self.indexBtn, not arg_49_1)
	setActive(self.toggleBtnsTF, arg_49_1)

	self.toggleGroupSC.allowSwitchOff = not arg_49_1

	return
end

function MetaCharacterScene:switchPage(arg_50_1)
	if not self.curPageIndex then
		setActive(self.toggleBtnsTF, true)
		triggerToggle(self.toggleList[arg_50_1], true)
	end

	return
end

function MetaCharacterScene:backFromRepair()
	setActive(self.menuPanel, false)
	self:managedTween(LeanTween.alpha, nil, self.shipImg, 1, 0.3):setFrom(0):setOnComplete(System.Action(function()
		setActive(self.menuPanel, true)
		setActive(self.hidePanel, true)

		return
	end))

	return
end

function MetaCharacterScene:backFromNotRepair()
	setActive(self.menuPanel, false)
	self:managedTween(LeanTween.moveX, nil, rtf(self.shipImg), MetaCharacterConst.UIConfig[self:getCurMetaProgressVO().id][1], 0.3):setFrom(-250):setOnComplete(System.Action(function()
		setActive(self.menuPanel, true)
		setActive(self.hidePanel, true)

		return
	end))

	return
end

function MetaCharacterScene:autoOpenFunc()
	if self.contextData.autoOpenShipConfigID then
		local var_55_0 = MetaCharacterConst.GetMetaShipGroupIDByConfigID(self.contextData.autoOpenShipConfigID)

		for iter_55_0, iter_55_1 in ipairs((self:getMetaProgressListForShow())) do
			if iter_55_1 and iter_55_1.id == var_55_0 then
				triggerButton(self.bannerTFList[iter_55_0])

				self.contextData.autoOpenShipConfigID = nil
			end
		end
	end

	if self.contextData.autoOpenTactics then
		triggerButton(self.tacticsBtn)

		self.contextData.autoOpenTactics = nil
	end

	if self.contextData.autoOpenEnergy then
		triggerButton(self.energyBtn)

		self.contextData.autoOpenEnergy = nil
	end

	if self.contextData.autoOpenSyn then
		if self:getCurMetaProgressVO():isUnlocked() then
			triggerButton(self.synBtn)
		end

		self.contextData.autoOpenSyn = nil
	end

	if self.contextData.lastPageIndex then
		triggerToggle(self.toggleList[self.contextData.lastPageIndex], true)

		self.contextData.lastPageIndex = nil
	end

	return
end

function MetaCharacterScene:openIndexLayer()
	self.indexDatas = self.indexDatas or {}

	self:emit(MetaCharacterMediator.OPEN_INDEX_LAYER, {
		indexDatas = Clone(self.indexDatas),
		customPanels = {
			minHeight = 650,
			typeIndex = {
				mode = CustomIndexLayer.Mode.AND,
				options = ShipIndexConst.TypeIndexs,
				names = ShipIndexConst.TypeNames
			},
			rarityIndex = {
				mode = CustomIndexLayer.Mode.AND,
				options = ShipIndexConst.MetaRarityIndexs,
				names = ShipIndexConst.MetaRarityNames
			},
			extraIndex = {
				mode = CustomIndexLayer.Mode.OR,
				options = ShipIndexConst.MetaExtraIndexs,
				names = ShipIndexConst.MetaExtraNames
			}
		},
		groupList = {
			{
				dropdown = false,
				titleENTxt = "indexsort_typeeng",
				titleTxt = "indexsort_type",
				tags = {
					"typeIndex"
				}
			},
			{
				dropdown = false,
				titleENTxt = "indexsort_rarityeng",
				titleTxt = "indexsort_rarity",
				tags = {
					"rarityIndex"
				}
			},
			{
				dropdown = false,
				titleENTxt = "indexsort_indexeng",
				titleTxt = "indexsort_extraindex",
				tags = {
					"extraIndex"
				}
			}
		},
		callback = function(self)
			if not isActive(self._tf) then
				return
			end

			self.indexDatas.typeIndex = self.typeIndex
			self.indexDatas.rarityIndex = self.rarityIndex
			self.indexDatas.extraIndex = self.extraIndex
			self.metaProgressVOList = self:getMetaProgressListForShow()

			self:fillMetaProgressList()
			self:updateStart()

			return
		end
	})

	return
end

function MetaCharacterScene:isDefaultStatus()
	return (not self.indexDatas.typeIndex or self.indexDatas.typeIndex == ShipIndexConst.TypeAll) and (not self.indexDatas.rarityIndex or self.indexDatas.rarityIndex == ShipIndexConst.RarityAll) and (not self.indexDatas.extraIndex or self.indexDatas.extraIndex == ShipIndexConst.MetaExtraAll)
end

function MetaCharacterScene:overLayPanel(arg_59_1)
	if arg_59_1 == true then
		self:OverlayPanel(self.blurPanel)
	elseif arg_59_1 == false then
		self:UnOverlayPanel(self.blurPanel, self._tf)
	end

	return
end

function MetaCharacterScene:getMetaProgressListForShow()
	local var_60_0 = {}
	local var_60_1
	local var_60_2

	for iter_60_0, iter_60_1 in ipairs((self.metaCharacterProxy:getMetaProgressVOList())) do
		if MetaCharacterConst.filteMetaByType(iter_60_1, self.indexDatas.typeIndex) and MetaCharacterConst.filteMetaByRarity(iter_60_1, self.indexDatas.rarityIndex) and MetaCharacterConst.filteMetaExtra(iter_60_1, self.indexDatas.extraIndex) and iter_60_1:isShow() then
			if iter_60_1:isPtType() and iter_60_1:isInAct() then
				var_60_1 = iter_60_1
			elseif iter_60_1:isPassType() and iter_60_1:isInAct() then
				var_60_2 = iter_60_1
			else
				local var_60_4

				if iter_60_1:isBuildType() and iter_60_1:isInAct() then
					var_60_4 = iter_60_1
				else
					table.insert(var_60_0, iter_60_1)
				end
			end
		end
	end

	if nil then
		table.insert(var_60_0, 1, nil)
	end

	if var_60_2 then
		table.insert(var_60_0, 1, var_60_2)
	end

	if var_60_1 then
		table.insert(var_60_0, 1, var_60_1)
	end

	return var_60_0
end

function MetaCharacterScene:filteMetaProgressList()
	local var_61_0 = {}

	for iter_61_0, iter_61_1 in ipairs((self:getMetaProgressListForShow())) do
		if MetaCharacterConst.filteMetaByType(iter_61_1, self.indexDatas.typeIndex) and MetaCharacterConst.filteMetaByRarity(iter_61_1, self.indexDatas.rarityIndex) and MetaCharacterConst.filteMetaExtra(iter_61_1, self.indexDatas.extraIndex) then
			table.insert(var_61_0, iter_61_1)
		end
	end

	return var_61_0
end

function MetaCharacterScene:getOneStepPTAwardLevelAndCount()
	local var_62_0 = self:getCurMetaProgressVO()
	local var_62_1 = var_62_0.metaPtData:GetResProgress()
	local var_62_2 = var_62_0:getStoryIndexList()
	local var_62_3 = 0

	for iter_62_0 = 1, var_62_0.unlockPTLevel - 1 do
		local var_62_4 = false
		local var_62_5 = false

		if var_62_1 >= var_62_0.metaPtData.targets[iter_62_0] then
			var_62_4 = true
		end

		if var_62_2[iter_62_0] == 0 then
			var_62_5 = true
		elseif pg.NewStoryMgr.GetInstance():IsPlayed(var_62_2[iter_62_0]) then
			var_62_5 = true
		end

		if var_62_4 and var_62_5 then
			var_62_3 = iter_62_0
		else
			break
		end
	end

	return var_62_3, var_62_0.metaPtData.targets[var_62_3]
end

return MetaCharacterScene
