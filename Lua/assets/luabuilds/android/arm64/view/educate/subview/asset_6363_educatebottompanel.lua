local EducateBottomPanel = class("EducateBottomPanel", import("...base.BaseSubView"))

function EducateBottomPanel:getUIName()
	return "EducateBottomPanel"
end

function EducateBottomPanel:OnInit()
	self.contentTF = self._tf:Find("content")
	self.planBtn = self.contentTF:Find("btns/schedule")
	self.mapBtn = self.contentTF:Find("btns/map")

	setText(self.mapBtn:Find("tips/limit/Text"), i18n("child_option_limit"))

	self.schoolBtn = self.contentTF:Find("btns/enter_school")
	self.upgradeBtn = self.contentTF:Find("btns/system_upgrade")
	self.targetSetBtn = self.contentTF:Find("btns/target_set")
	self.endingBtn = self.contentTF:Find("btns/ending")
	self.resetBtn = self.contentTF:Find("btns/reset")

	self:addListener()

	self.targetSetDays = getProxy(EducateProxy):GetTaskProxy():GetTargetSetDays()

	self:Flush()

	return
end

function EducateBottomPanel:addListener()
	onButton(self, self.planBtn, function()
		self:emit(EducateBaseUI.EDUCATE_GO_SCENE, SCENE.EDUCATE_SCHEDULE)

		return
	end, SFX_PANEL)
	onButton(self, self.mapBtn, function()
		if isActive(self.mapBtn:Find("lock")) then
			return
		end

		self:emit(EducateBaseUI.EDUCATE_GO_SCENE, SCENE.EDUCATE_MAP)

		return
	end, SFX_PANEL)
	onButton(self, self.schoolBtn, function()
		self:emit(EducateBaseUI.EDUCATE_ON_MSG_TIP, {
			content = i18n("child_school_sure_tip"),
			onYes = function()
				setActive(self.schoolBtn, false)
				self:updateTargetSetBtn()

				if EducateConst.ENTER_NEW_STAGE_PERFORMS[2] then
					pg.PerformMgr.GetInstance():PlayOne(EducateConst.ENTER_NEW_STAGE_PERFORMS[2], function()
						self:playGuide("tb_9_1")
						self:onEnterVirtualStage()

						return
					end)
				else
					self:playGuide("tb_9_1")
					self:onEnterVirtualStage()
				end

				getProxy(EducateProxy):GetPlanProxy():ClearLocalPlansData()

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.upgradeBtn, function()
		self:emit(EducateBaseUI.EDUCATE_ON_MSG_TIP, {
			content = i18n("child_upgrade_sure_tip"),
			onYes = function()
				setActive(self.upgradeBtn, false)
				self:updateTargetSetBtn()

				local var_10_0 = EducateConst.ENTER_NEW_STAGE_PERFORMS[getProxy(EducateProxy):GetCharData():GetStage() + 1]

				if var_10_0 then
					pg.PerformMgr.GetInstance():PlayOne(var_10_0, function()
						self:onEnterVirtualStage()

						return
					end)
				else
					self:onEnterVirtualStage()
				end

				getProxy(EducateProxy):GetPlanProxy():ClearLocalPlansData()

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.targetSetBtn, function()
		self:emit(EducateBaseUI.EDUCATE_GO_SUBLAYER, Context.New({
			mediator = EducateTargetSetMediator,
			viewComponent = EducateTargetSetLayer
		}))

		return
	end, SFX_PANEL)
	onButton(self, self.endingBtn, function()
		self:emit(EducateBaseUI.EDUCATE_ON_MSG_TIP, {
			content = i18n("child_end_sure_tip"),
			onYes = function()
				pg.PerformMgr.GetInstance():PlayOne(EducateConst.FIRST_ENTER_END_PERFORM, function()
					self:emit(EducateMediator.ON_ENDING_TRIGGER)

					return
				end)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.resetBtn, function()
		self:emit(EducateBaseUI.EDUCATE_ON_MSG_TIP, {
			content = i18n("child_reset_sure_tip"),
			onYes = function()
				self:emit(EducateMediator.ON_GAME_RESET)

				return
			end
		})

		return
	end, SFX_PANEL)
	self._tf:GetComponent(typeof(Animation)):Play((self.contextData and self.contextData.isMainEnter or nil) and "anim_educate_bottom_in")

	return
end

function EducateBottomPanel:playGuide(arg_18_1)
	if not pg.NewStoryMgr.GetInstance():IsPlayed(arg_18_1) then
		pg.NewGuideMgr.GetInstance():Play(arg_18_1)
		pg.m02:sendNotification(GAME.STORY_UPDATE, {
			storyId = arg_18_1
		})
	end

	return
end

function EducateBottomPanel:onEnterVirtualStage()
	getProxy(EducateProxy):SetVirtualStage(true)
	self:emit(EducateMediator.ENTER_VIRTUAL_STAGE)

	return
end

function EducateBottomPanel:Flush()
	if not self:GetLoaded() then
		return
	end

	self.curTime = getProxy(EducateProxy):GetCurTime()
	self.status = getProxy(EducateProxy):GetGameStatus()

	local var_20_0 = getProxy(EducateProxy):InVirtualStage()

	setActive(self.mapBtn:Find("lock"), not EducateHelper.IsSystemUnlock(EducateConst.SYSTEM_GO_OUT) or var_20_0)
	setActive(self.planBtn, self.status ~= EducateConst.STATUES_ENDING and self.status ~= EducateConst.STATUES_RESET)
	setActive(self.mapBtn, self.status ~= EducateConst.STATUES_ENDING and self.status ~= EducateConst.STATUES_RESET)
	self:updateMapBtnTips()
	setActive(self.schoolBtn, self:isSchoolBtnShow() and not var_20_0)
	setActive(self.upgradeBtn, self:isUpgradeBtnShow() and not var_20_0)
	self:updateTargetSetBtn()
	setActive(self.endingBtn, self.status == EducateConst.STATUES_ENDING)
	setActive(self.resetBtn, self.status == EducateConst.STATUES_RESET)

	if isActive(self.schoolBtn) or isActive(self.upgradeBtn) or isActive(self.targetSetBtn) then
		setActive(self.planBtn, false)
	end

	return
end

function EducateBottomPanel:isSchoolBtnShow()
	return self.status == EducateConst.STATUES_PREPARE and EducateHelper.IsSameDay(self.curTime, self.targetSetDays[2])
end

function EducateBottomPanel:isUpgradeBtnShow()
	return self.status == EducateConst.STATUES_PREPARE and (EducateHelper.IsSameDay(self.curTime, self.targetSetDays[3]) or EducateHelper.IsSameDay(self.curTime, self.targetSetDays[4]))
end

function EducateBottomPanel:isTargetSetBtnShow()
	return self.status == EducateConst.STATUES_PREPARE and not isActive(self.schoolBtn) and not isActive(self.upgradeBtn)
end

function EducateBottomPanel:updateTargetSetBtn()
	local var_24_0 = self:isTargetSetBtnShow()

	setActive(self.targetSetBtn, var_24_0)

	if var_24_0 then
		setActive(self.mapBtn:Find("lock"), true)
	end

	return
end

function EducateBottomPanel:updateMapBtnTips()
	EducateTipHelper.GetSiteUnlockTipIds()

	local var_25_0 = getProxy(EducateProxy):GetShowSiteIds()

	setActive(self.mapBtn:Find("tips/new"), (underscore.any(var_25_0, function(arg_26_0)
		return EducateTipHelper.IsShowNewTip(EducateTipHelper.NEW_SITE, arg_26_0)
	end)))
	setActive(self.mapBtn:Find("tips/limit"), (underscore.any(var_25_0, function(arg_27_0)
		return underscore.any(getProxy(EducateProxy):GetOptionsBySiteId(arg_27_0), function(arg_28_0)
			return arg_28_0:IsShowLimit()
		end)
	end)))

	return
end

function EducateBottomPanel:OnDestroy()
	return
end

return EducateBottomPanel
