local CommissionInfoLayer = class("CommissionInfoLayer", import("...base.BaseUI"))

function CommissionInfoLayer:getUIName()
	if getProxy(SettingsProxy):IsMellowStyle() then
		return "CommissionInfoUI4Mellow"
	else
		return "CommissionInfoUI"
	end

	return
end

function CommissionInfoLayer:init()
	self.frame = self._tf:Find("frame")
	self.parentTr = self._tf.parent
	self.resourcesTF = self.frame:Find("resources")
	self.oilTF = self.resourcesTF:Find("canteen/bubble/Text"):GetComponent(typeof(Text))
	self.goldTF = self.resourcesTF:Find("merchant/bubble/Text"):GetComponent(typeof(Text))
	self.classTF = self.resourcesTF:Find("class/bubble/Text"):GetComponent(typeof(Text))
	self.classLockTF = self.resourcesTF:Find("class/lock")
	self.oilbubbleTF = self.resourcesTF:Find("canteen/bubble")
	self.goldbubbleTF = self.resourcesTF:Find("merchant/bubble")
	self.classbubbleTF = self.resourcesTF:Find("class/bubble")
	self.oilbubbleCG = GetOrAddComponent(self.oilbubbleTF, typeof(CanvasGroup))
	self.goldbubbleCG = GetOrAddComponent(self.goldbubbleTF, typeof(CanvasGroup))
	self.classbubbleCG = GetOrAddComponent(self.classbubbleTF, typeof(CanvasGroup))

	local var_2_0 = getProxy(NavalAcademyProxy):GetClassVO()

	self.classbubbleTF:Find("icon").GetComponent(var_2_0, typeof(Image)).sprite = LoadSprite(Item.getConfigData((var_2_0:GetResourceType())).icon)
	self.projectContainer = self.frame:Find("main/content")
	self.items = {
		CommissionInfoEventItem.New(self._tf:Find("frame/main/content/event"), self),
		CommissionInfoClassItem.New(self._tf:Find("frame/main/content/class"), self),
		CommissionInfoTechnologyItem.New(self._tf:Find("frame/main/content/technology"), self),
		CommissionInfoChapterAutoItem.New(self._tf:Find("frame/main/content/chapterauto"), self)
	}

	self:BlurPanel()

	self.linkBtnPanel = self._tf:Find("frame/link_btns/btns")
	self.activityInsBtn = self._tf:Find("frame/link_btns/btns/ins")
	self.activtyUrExchangeBtn = self._tf:Find("frame/link_btns/btns/urEx")
	self.activtyUrExchangeTxt = self._tf:Find("frame/link_btns/btns/urEx/Text"):GetComponent(typeof(Text))
	self.activtyUrExchangeCG = self.activtyUrExchangeBtn:GetComponent(typeof(CanvasGroup))
	self.activtyUrExchangeTip = self._tf:Find("frame/link_btns/btns/urEx/tip")
	self.activityCrusingBtn = self._tf:Find("frame/link_btns/btns/crusing")
	self.metaBossBtn = CommissionMetaBossBtn.New(self._tf:Find("frame/link_btns/btns/meta_boss"), self.event)

	return
end

function CommissionInfoLayer:BlurPanel()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function CommissionInfoLayer:UnBlurPanel()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self.parentTr)

	return
end

function CommissionInfoLayer:UpdataClassUnlock()
	setActive(self.classLockTF, not pg.SystemOpenMgr.GetInstance():isOpenSystem(self.playerVO.level, "ClassMediator"))

	return
end

function CommissionInfoLayer:UpdateUrItemEntrance()
	if pg.SystemOpenMgr.GetInstance():isOpenSystem(self.playerVO.level, "FragmentShop") and not LOCK_UR_SHIP then
		local var_6_0 = pg.gameset.urpt_chapter_max.description[2]
		local var_6_1 = getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])

		self.activtyUrExchangeTxt.text = var_6_1 .. "/" .. pg.gameset.urpt_chapter_max.description[2]
		self.activtyUrExchangeCG.alpha = var_6_1 == var_6_0 and 0.6 or 1

		setActive(self.activtyUrExchangeTip, NotifyTipHelper.ShouldShowUrTip())
		onButton(self, self.activtyUrExchangeBtn, function()
			self:emit(CommissionInfoMediator.ON_UR_ACTIVITY)

			return
		end, SFX_PANEL)
	else
		setActive(self.activtyUrExchangeBtn, false)
	end

	return
end

function CommissionInfoLayer:updateCrusingEntrance()
	local var_8_0 = getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_CRUSING)

	if var_8_0 and not var_8_0:isEnd() then
		setActive(self.activityCrusingBtn, true)

		local var_8_1 = var_8_0:GetCrusingInfo()
		local var_8_2 = math.floor((var_8_0.stopTime - pg.TimeMgr.GetInstance():GetServerTime()) / 0)

		if var_8_2 <= pg.gameset.world_cruise_due_days.key_value then
			setActive(self.activityCrusingBtn:Find("LastDay"), true)
			setText(self.activityCrusingBtn:Find("LastDay/text"), i18n("guild_left_supply_day", var_8_2))
		else
			setActive(self.activityCrusingBtn:Find("LastDay"), false)
		end

		setText(self.activityCrusingBtn:Find("Text"), var_8_1.phase .. "/" .. #var_8_1.awardList)
		setActive(self.activityCrusingBtn:Find("tip"), #var_8_0:GetCrusingUnreceiveAward() > 0)
	else
		setActive(self.activityCrusingBtn, false)
	end

	onButton(self, self.activityCrusingBtn, function()
		self:emit(CommissionInfoMediator.ON_CRUSING)

		return
	end, SFX_PANEL)

	return
end

function CommissionInfoLayer:NotifyIns()
	setActive(self.activityInsBtn, false)

	return
end

function CommissionInfoLayer:UpdateLinkPanel()
	local var_11_0 = false

	for iter_11_0 = 1, self.linkBtnPanel.childCount do
		if isActive(self.linkBtnPanel:GetChild(iter_11_0 - 1)) then
			var_11_0 = true

			break
		end
	end

	setActive(self.linkBtnPanel.parent, var_11_0)

	return
end

function CommissionInfoLayer:didEnter()
	onButton(self, self.oilbubbleTF, function()
		if not getProxy(PlayerProxy):getRawData():CanGetResource(PlayerConst.ResOil) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("player_harvestResource_error_fullBag"))

			return
		end

		self:PlayGetResAnimation(self.oilbubbleTF, function()
			self:emit(CommissionInfoMediator.GET_OIL_RES)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self, self.goldbubbleTF, function()
		if not getProxy(PlayerProxy):getRawData():CanGetResource(PlayerConst.ResGold) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("player_harvestResource_error_fullBag"))

			return
		end

		self:PlayGetResAnimation(self.goldbubbleTF, function()
			self:emit(CommissionInfoMediator.GET_GOLD_RES)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self, self.classbubbleTF, function()
		if not getProxy(NavalAcademyProxy):GetClassVO():CanGetRes() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("player_harvestResource_error_fullBag"))

			return
		end

		self:PlayGetResAnimation(self.classbubbleTF, function()
			self:emit(CommissionInfoMediator.GET_CLASS_RES)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		if self.contextData.inFinished then
			return
		end

		self.isPaying = true

		self:PlayUIAnimation(self._tf, "exit", function()
			self:emit(CommissionInfoLayer.ON_CLOSE)

			self.isPaying = false

			return
		end)

		return
	end, SOUND_BACK)
	onButton(self, self.classLockTF, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("no_open_system_tip", pg.open_systems_limited[9].name, pg.open_systems_limited[9].level))

		return
	end, SFX_PANEL)
	self:InitItems()
	self:UpdataClassUnlock()
	self:UpdateUrItemEntrance()
	self:updateCrusingEntrance()
	self.metaBossBtn:Flush()

	return
end

function CommissionInfoLayer:PlayGetResAnimation(arg_22_1, arg_22_2)
	self.isPaying = true

	local var_22_0 = arg_22_1:GetComponent(typeof(DftAniEvent))

	var_22_0:SetEndEvent(nil)
	var_22_0:SetEndEvent(function()
		var_22_0:SetEndEvent(nil)
		arg_22_2()

		self.isPaying = false

		return
	end)
	arg_22_1:GetComponent(typeof(Animation)):Play("anim_commission_bubble_get")

	return
end

function CommissionInfoLayer:InitItems()
	for iter_24_0, iter_24_1 in ipairs(self.items) do
		iter_24_1:Init()
	end

	return
end

function CommissionInfoLayer:OnUpdateEventInfo()
	self.items[1]:Update()

	return
end

function CommissionInfoLayer:OnUpdateClass()
	self.items[2]:Update()

	return
end

function CommissionInfoLayer:OnUpdateTechnology()
	self.items[3]:Update()

	return
end

function CommissionInfoLayer:OnUpdateChapterAuto()
	self.items[4]:Update()

	return
end

function CommissionInfoLayer:setPlayer(arg_29_1)
	self.playerVO = arg_29_1

	self:UpdateOilRes(arg_29_1)
	self:UpdateGoldRes(arg_29_1)
	self:UpdateClassRes()

	return
end

function CommissionInfoLayer:OnPlayerUpdate(arg_30_1)
	if arg_30_1.oilField ~= self.playerVO.oilField then
		self:UpdateOilRes(arg_30_1)
	end

	if arg_30_1.goldField ~= self.playerVO.goldField then
		self:UpdateGoldRes(arg_30_1)
	end

	if arg_30_1.expField ~= self.playerVO.expField then
		self:UpdateClassRes()
	end

	self.playerVO = arg_30_1

	return
end

function CommissionInfoLayer:UpdateOilRes(arg_31_1)
	self.oilbubbleCG.alpha = 1
	self.oilbubbleTF.localScale = Vector3.one

	setActive(self.oilbubbleTF, arg_31_1.oilField ~= 0)

	self.oilTF.text = arg_31_1.oilField

	return
end

function CommissionInfoLayer:UpdateGoldRes(arg_32_1)
	self.goldbubbleCG.alpha = 1
	self.goldbubbleTF.localScale = Vector3.one

	setActive(self.goldbubbleTF, arg_32_1.goldField ~= 0)

	self.goldTF.text = arg_32_1.goldField

	return
end

function CommissionInfoLayer:UpdateClassRes()
	local var_33_0 = getProxy(NavalAcademyProxy):GetClassVO():GetGenResCnt()

	self.classbubbleCG.alpha = 1
	self.classbubbleTF.localScale = Vector3.one

	setActive(self.classbubbleTF, var_33_0 > 0)

	self.classTF.text = var_33_0

	return
end

function CommissionInfoLayer:onBackPressed()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)
	triggerButton(self._tf)

	return
end

function CommissionInfoLayer:willExit()
	self:UnBlurPanel()

	for iter_35_0, iter_35_1 in ipairs(self.items) do
		iter_35_1:Dispose()
	end

	self.items = nil

	self.metaBossBtn:Dispose()

	self.metaBossBtn = nil

	return
end

return CommissionInfoLayer
