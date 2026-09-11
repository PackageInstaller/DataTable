local NewHeroTeamInfoBaseView = class("NewHeroTeamInfoBaseView", ReduxView)

function NewHeroTeamInfoBaseView:UIName()
	return "Widget/System/Formation/FormationHeroUI"
end

function NewHeroTeamInfoBaseView:UIParent()
	return manager.ui.uiMain.transform
end

function NewHeroTeamInfoBaseView:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewHeroTeamInfoBaseView:InitUI()
	self:BindCfgUI()
	self:InitSubView()
	self:InitController()
	self:InitSelectMode()
end

function NewHeroTeamInfoBaseView:InitSubView()
	self.heroHeadList_ = LuaList.New(handler(self, self.HeadRenderer), self.uiListGo_, self:GetHeroHeadClass())
	self.filterView_ = self:GetFilterClass().New(self.filterGo_)

	self.filterView_:SetExtraSorter(handler(self, self.ExtraSorter))
	self.filterView_:SetListChangeHandler(handler(self, self.OnListChange))

	self.autoClearFilter_ = true
	self.heroInfoView_ = self:GetHeroInfoViewClass().New(self, self.heroInfoGo_)
end

function NewHeroTeamInfoBaseView:InitController()
	self.emptyController_ = self.controller_:GetController("empty")
	self.joinBtnController_ = self.btnPanelController_:GetController("join")
	self.infoBtnController_ = self.btnPanelController_:GetController("info")

	if self.multiModeControllerEx_ then
		self.selectModeController_ = self.multiModeControllerEx_:GetController("selectMode")
	end

	self.multiModeActiveController_ = self.controller_:GetController("multiModeActive")
end

function NewHeroTeamInfoBaseView:InitSelectMode()
	self.selectHeroMode_ = SectionSelectHeroConst.SELECT_HERO_MODE.SINGLE
end

function NewHeroTeamInfoBaseView:AddUIListener()
	self:AddBtnListener(self.infoBtn_, nil, handler(self, self.OnInfoBtnClick))
	self:AddBtnListener(self.joinBtn_, nil, handler(self, self.OnJoinClick))

	if self.multiModeBtn_ then
		self:AddBtnListener(self.multiModeBtn_, nil, handler(self, self.OnChangeMultiMode))
	end
end

function NewHeroTeamInfoBaseView:OnEnter()
	self:ProcessParams()
	self:Reset()
	self:SubViewOnEnter()
	self:GetHeroTeam()
	self:RefreshHeroDataList()
	self:RefreshUI()
end

function NewHeroTeamInfoBaseView:ReserveCameraEnter()
	manager.loadScene:SetSceneActive(SceneConst.SCENE_NAME.reserve, true)
	SectionSelectHeroScene.GetInstance():SetALlStateGoActive(false)
end

function NewHeroTeamInfoBaseView:ProcessCamera(arg_11_1)
	manager.reserveCamera:SwitchCamera(ReserveCameraConst.CAMERA_TYPE.hero, ReserveCameraConst.VIRTUAL_CAMERA[string.format("heroPos_%s", self.params_.selectHeroPos or 1)], {
		skinID = arg_11_1
	})
end

function NewHeroTeamInfoBaseView:OnTop()
	self:UpdateBar()
	manager.windowBar:RegistBackCallBack(function()
		self:Back(1, {
			isSorted = true
		})
	end)
end

function NewHeroTeamInfoBaseView:OnExit()
	self:SubViewOnExit()

	self.params_.curSelectHeroData = self.selectHeroData_
	self.selectHeroData_ = nil

	manager.windowBar:HideBar()
	manager.loadScene:SetSceneActive(SceneConst.SCENE_NAME.reserve, false)
	SectionSelectHeroScene.GetInstance():DestroyModels()
end

function NewHeroTeamInfoBaseView:Dispose()
	if self.filterView_ then
		self.filterView_:Dispose()

		self.filterView_ = nil
	end

	if self.heroHeadList_ then
		self.heroHeadList_:Dispose()

		self.heroHeadList_ = nil
	end

	if self.heroInfoView_ then
		self.heroInfoView_:Dispose()

		self.heroInfoView_ = nil
	end

	NewHeroTeamInfoBaseView.super.Dispose(self)
end

function NewHeroTeamInfoBaseView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function NewHeroTeamInfoBaseView:ProcessParams()
	self:ProcessBaseParams()
	self:ProcessReserveParams()
	self:ProcessProxyParams()
	self:ProcessCustomParams()
end

function NewHeroTeamInfoBaseView:ProcessBaseParams()
	self.stageID_ = self.params_.stageID
	self.stageType_ = self.params_.stageType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
	self.activityID_ = self.params_.activityID
	self.params_.selectHeroPos = self.params_.selectHeroPos or 1

	if self.params_.reorder == nil then
		self.params_.reorder = true
	end

	self.reorder_ = self.params_.reorder

	if self.params_.hideInfoBtn == nil then
		self.params_.hideInfoBtn = false
	end

	self.hideInfoBtn_ = self.params_.hideInfoBtn

	if self.params_.canCleanTeam == nil then
		self.params_.canCleanTeam = false
	end

	self.canCleanTeam_ = self.params_.canCleanTeam

	if self.params_.canUseOwnHero == nil then
		self.params_.canUseOwnHero = true
	end

	self.canUseOwnHero_ = self.params_.canUseOwnHero

	if self.params_.canUseMultiMode == nil then
		self.params_.canUseMultiMode = SectionSelectHeroTools.CanUseMultiMode(self.stageType_, self.stageID_)
	end

	self.canUseMultiMode_ = self.params_.canUseMultiMode
end

function NewHeroTeamInfoBaseView:ProcessReserveParams()
	if not self.params_.reserveParams then
		self.params_.reserveParams = ReserveTools.GetReserveParams(self.stageType_, self.stageID_, self.activityID_)
	else
		self.params_.reserveParams.customData.activityID = self.params_.reserveParams.customData.activityID or self.activityID_
	end

	self.reserveParams_ = self.params_.reserveParams
end

function NewHeroTeamInfoBaseView:ProcessProxyParams()
	self.params_.heroDataType = self.params_.heroDataType or HeroConst.HERO_DATA_TYPE.DEFAULT
	self.heroDataType_ = self.params_.heroDataType
	self.params_.sectionProxy = self.params_.sectionProxy or SectionSelectHeroTools.GetProxy(self.params_, self.reserveParams_, self.heroDataType_)
	self.sectionProxy_ = self.params_.sectionProxy
	self.heroViewProxy_ = self.sectionProxy_:GetHeroViewProxy()
	self.heroViewProxyDic_ = {}
	self.heroViewProxyDic_[self.heroDataType_] = self.heroViewProxy_
end

function NewHeroTeamInfoBaseView:ProcessCustomParams()
	return
end

function NewHeroTeamInfoBaseView:Reset()
	if not self.params_.isBack then
		if self.filterView_ and self.autoClearFilter_ then
			self.filterView_:Reset(true)
			CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
		end

		self:ResetSelectMode()
	end
end

function NewHeroTeamInfoBaseView:SubViewOnEnter()
	self.filterView_:OnEnter(self.heroViewProxy_)

	if self.heroInfoView_ then
		self.heroInfoView_:OnEnter(self.heroViewProxy_)
	end
end

function NewHeroTeamInfoBaseView:SubViewOnExit()
	if self.filterView_ and self.filterView_.OnExit then
		self.filterView_:OnExit()
	end

	if #self.heroDataList_ <= 0 then
		HeroData:ResetSortValue()
		self.filterView_:Reset()
	end

	self.heroInfoView_:OnExit()
end

function NewHeroTeamInfoBaseView:ProcessHeroDataList(arg_25_1, arg_25_2, arg_25_3)
	if self.customHeroList_[self.params_.selectHeroPos][1] then
		self:ProcessCustomHeroData(arg_25_1, arg_25_2)
	else
		self:ProcessOwnHeroData(arg_25_1, arg_25_3)
		self:ProcessTrialHeroData(arg_25_1, arg_25_2)
	end
end

function NewHeroTeamInfoBaseView:RefreshHeroDataList()
	local var_26_0 = {}

	self.allTrialIDList_ = {}
	self.customHeroList_, self.canSwitchResctrictHeroList_ = SectionSelectHeroTools.GetRestrictHeroList(self.stageType_, self.stageID_)
	self.curCanSwitchRestrictHero_ = self.canSwitchResctrictHeroList_[self.params_.selectHeroPos] ~= ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID

	local var_26_3, var_26_4 = SectionSelectHeroTools.GetRestrictHeroPosDic(self.stageType_, self.stageID_)

	self:ProcessHeroDataList(var_26_0, var_26_4, var_26_3)

	for iter_26_0, iter_26_1 in pairs(self.heroViewProxyDic_) do
		iter_26_1:SetTempHeroList(self.allTrialIDList_)
	end

	self.heroDataList_ = var_26_0
end

function NewHeroTeamInfoBaseView:ProcessCustomHeroData(arg_27_1, arg_27_2)
	if self.curCanSwitchRestrictHero_ == true then
		while 1 <= #self.customHeroList_[self.params_.selectHeroPos] and 2 <= #self.customHeroList_[self.params_.selectHeroPos] do
			self:InsertHeroDataList(arg_27_1, self.customHeroList_[self.params_.selectHeroPos][1], self.customHeroList_[self.params_.selectHeroPos][2], HeroConst.HERO_DATA_TYPE.TRIAL)

			if self.canSwitchResctrictHeroList_[self.params_.selectHeroPos] == ReserveConst.RESTRICT_HERO_SWITCH_MODE.OWN_AND_TRIAL and HeroTools.GetHeroIsUnlock(self.customHeroList_[self.params_.selectHeroPos][1]) then
				self:InsertHeroDataList(arg_27_1, self.customHeroList_[self.params_.selectHeroPos][1], 0, self.heroDataType_)
			end
		end
	else
		for iter_27_0, iter_27_1 in pairs(arg_27_2) do
			self:InsertHeroDataList(arg_27_1, HeroStandardSystemCfg[iter_27_0].hero_id, iter_27_0, HeroConst.HERO_DATA_TYPE.TRIAL)
		end
	end
end

function NewHeroTeamInfoBaseView:ProcessOwnHeroData(arg_28_1, arg_28_2)
	for iter_28_0, iter_28_1 in pairs(self:GetHeroList()) do
		if not arg_28_2[iter_28_1] then
			self:InsertHeroDataList(arg_28_1, iter_28_1, 0, self.heroDataType_)
		end
	end
end

function NewHeroTeamInfoBaseView:ProcessTrialHeroData(arg_29_1, arg_29_2)
	for iter_29_0, iter_29_1 in pairs((self:GetTrialHeroList())) do
		if not arg_29_2[iter_29_1] then
			self:InsertHeroDataList(arg_29_1, HeroStandardSystemCfg[iter_29_1].hero_id, iter_29_1, HeroConst.HERO_DATA_TYPE.TRIAL)
		end
	end
end

function NewHeroTeamInfoBaseView:InsertHeroDataList(arg_30_1, arg_30_2, arg_30_3, arg_30_4)
	table.insert(arg_30_1, {
		id = arg_30_2,
		trialID = arg_30_3,
		type = arg_30_4,
		heroViewProxy = self:GetHeroViewProxy(arg_30_4)
	})

	if arg_30_3 and arg_30_3 ~= 0 then
		table.insert(self.allTrialIDList_, arg_30_3)
	end
end

function NewHeroTeamInfoBaseView:GetSelectHeroData()
	if self.params_.isEnter then
		self.params_.isEnter = false

		local var_31_0 = self.heroTeam_[self.params_.selectHeroPos] or 0
		local var_31_1 = self.heroTrialList_[self.params_.selectHeroPos] or 0

		if var_31_0 ~= 0 then
			for iter_31_0, iter_31_1 in ipairs(self.heroDataList_) do
				if iter_31_1.id == var_31_0 and iter_31_1.trialID == var_31_1 then
					return iter_31_1, iter_31_0
				end
			end
		end
	end

	if self.params_.curSelectHeroData and self.params_.curSelectHeroData.id ~= 0 then
		for iter_31_2, iter_31_3 in ipairs(self.heroDataList_) do
			if iter_31_3.id == self.params_.curSelectHeroData.id and iter_31_3.trialID == self.params_.curSelectHeroData.trialID then
				return self.params_.curSelectHeroData, iter_31_2
			end
		end
	end

	if self.selectHeroData_ then
		for iter_31_4, iter_31_5 in ipairs(self.heroDataList_) do
			if iter_31_5.id == self.selectHeroData_.id and iter_31_5.trialID == self.selectHeroData_.trialID then
				return self.selectHeroData_, iter_31_4
			end
		end
	end

	for iter_31_6, iter_31_7 in ipairs(self.heroDataList_) do
		if not self:IsInTeam(iter_31_7.id, iter_31_7.trialID) and not self:IsHeroLock(iter_31_7.id, iter_31_7.trialID) then
			return iter_31_7, iter_31_6
		end
	end

	if #self.heroDataList_ > 0 then
		return self.heroDataList_[1], 1
	end

	return nil, 1
end

function NewHeroTeamInfoBaseView:RefreshUI()
	self.filterView_:SetHeroIdList(self.heroDataList_)
end

function NewHeroTeamInfoBaseView:RefreshSelectModeUI()
	self:RefreshMultiModeBtn()

	if self.selectHeroMode_ == SectionSelectHeroConst.SELECT_HERO_MODE.SINGLE then
		self:RefreshSingleModeUI()
	else
		self:RefreshMultiModeUI()
	end
end

function NewHeroTeamInfoBaseView:RefreshSingleModeUI()
	self:RefreshSingleModeHeadItem()
	self:UpdateHeroView()
	self:RefreshJoinBtn()
end

function NewHeroTeamInfoBaseView:RefreshSingleModeHeadItem()
	for iter_35_0, iter_35_1 in pairs(self.heroHeadList_:GetItemList()) do
		iter_35_1:SetSelected(iter_35_1.heroId_ == self.selectHeroData_.id and iter_35_1.trialID_ == self.selectHeroData_.trialID)
	end
end

function NewHeroTeamInfoBaseView:RefreshJoinBtn()
	self.joinBtn_.interactable = true

	if self:IsPosLocked(self.params_.selectHeroPos) then
		self.joinBtnController_:SetSelectedState("lock")

		self.joinBtn_.interactable = false
	elseif self:IsHeroLock(self.selectHeroData_.id, self.selectHeroData_.trialID) then
		self.joinBtnController_:SetSelectedState("lock")

		self.joinBtn_.interactable = false
	elseif self:IsSameHeroInTeam(self.selectHeroData_.id) and not self:IsInTeam(self.selectHeroData_.id, self.selectHeroData_.trialID) then
		if self.heroTeam_[self.params_.selectHeroPos] ~= self.selectHeroData_.id then
			self.joinBtnController_:SetSelectedState("lock")

			self.joinBtn_.interactable = false
		else
			self.joinBtnController_:SetSelectedState("change")
		end
	elseif self.heroTeam_[self.params_.selectHeroPos] == 0 then
		if self:IsInTeam(self.selectHeroData_.id, self.selectHeroData_.trialID) then
			self.joinBtnController_:SetSelectedState("change")
		else
			self.joinBtnController_:SetSelectedState("add")
		end
	elseif self.selectHeroData_.id == self.heroTeam_[self.params_.selectHeroPos] then
		if self.customHeroList_[self.params_.selectHeroPos][1] and self.curCanSwitchRestrictHero_ == true then
			self.joinBtnController_:SetSelectedState("cantRemove")

			self.joinBtn_.interactable = false
		else
			local var_36_0 = 0

			for iter_36_0, iter_36_1 in pairs(self.heroTeam_) do
				if iter_36_1 ~= 0 then
					var_36_0 = var_36_0 + 1
				end
			end

			if var_36_0 == 1 and not self.canCleanTeam_ then
				self.joinBtn_.interactable = false

				self.joinBtnController_:SetSelectedState("cantRemove")
			else
				self.joinBtnController_:SetSelectedState("out")
			end
		end
	else
		self.joinBtnController_:SetSelectedState("change")
	end
end

function NewHeroTeamInfoBaseView:UpdateHeroView()
	self:UpdateHeroModel()
	self:UpdateHeroInfoView()
end

function NewHeroTeamInfoBaseView:UpdateHeroModel()
	local var_38_1 = self:GetHeroUsingSkinId()

	self:LoadHeroModel(var_38_1)
	self:ProcessCamera(var_38_1)
end

function NewHeroTeamInfoBaseView:GetHeroUsingSkinId()
	return self.selectHeroData_.heroViewProxy:GetHeroBattleUsingSkinInfo(self.selectHeroData_.id, {
		self.selectHeroData_.trialID
	}).id
end

function NewHeroTeamInfoBaseView:LoadHeroModel(arg_40_1)
	local var_40_0 = self.params_.selectHeroPos or 1

	SectionSelectHeroScene.GetInstance():OnlyDisplayModel(var_40_0)
	SectionSelectHeroScene.GetInstance():LoadTargetModelEx(var_40_0, arg_40_1, function(arg_41_0, arg_41_1)
		if not arg_41_1 then
			SectionSelectHeroScene.GetInstance():DisposeVfx(arg_41_0)
		end

		if self.selectHeroData_.heroViewProxy:IsHeroOath(self.selectHeroData_.id) then
			SectionSelectHeroScene.GetInstance():AttachOathRing(arg_41_0)
		end
	end)
end

function NewHeroTeamInfoBaseView:UpdateHeroInfoView()
	self.heroInfoView_:SetProxy(self.selectHeroData_.heroViewProxy)
	self.heroInfoView_:SetHeroInfo((self:GetHeroViewProxyData()))
	self.heroInfoView_:UpdateView()
end

function NewHeroTeamInfoBaseView:GetHeroViewProxyData()
	return (self.selectHeroData_.heroViewProxy:GetHeroData(self.selectHeroData_.id, {
		self.selectHeroData_.trialID
	}))
end

function NewHeroTeamInfoBaseView:RefreshMultiModeUI()
	self:RefreshMultiModeHeadItem()
	self:UpdateHeroView()
	self:RefreshMultiJoinBtn()
end

function NewHeroTeamInfoBaseView:RefreshMultiModeHeadItem()
	for iter_45_0, iter_45_1 in pairs(self.heroHeadList_:GetItemList()) do
		iter_45_1:SetSelected(iter_45_1.heroId_ == self.selectHeroData_.id and iter_45_1.trialID_ == self.selectHeroData_.trialID)
		iter_45_1:SetMultiPos(self:IsInTeam(iter_45_1.heroId_, iter_45_1.trialID_))
	end
end

function NewHeroTeamInfoBaseView:RefreshMultiJoinBtn()
	self.joinBtn_.interactable = true

	self.joinBtnController_:SetSelectedState("add")
end

function NewHeroTeamInfoBaseView:RefreshInfoBtn()
	if self.hideInfoBtn_ or HeroTools.NeedHideInfo(self.selectHeroData_.id) or HeroTools.IsNPC(self.selectHeroData_.id) then
		self.infoBtnController_:SetSelectedState("off")
	else
		self.infoBtnController_:SetSelectedState("on")
	end
end

function NewHeroTeamInfoBaseView:RefreshMultiModeBtn()
	if self.multiModeActiveController_ then
		self.multiModeActiveController_:SetSelectedState(self.canUseMultiMode_ and "on" or "off")
	end

	if self.selectModeController_ then
		self.selectModeController_:SetSelectedState(self.selectHeroMode_ == SectionSelectHeroConst.SELECT_HERO_MODE.SINGLE and "single" or "multi")
	end
end

function NewHeroTeamInfoBaseView:OnChangeMultiMode()
	if self.selectHeroMode_ == SectionSelectHeroConst.SELECT_HERO_MODE.SINGLE then
		self:SwitchSelectMode(SectionSelectHeroConst.SELECT_HERO_MODE.MULTI)
	else
		self:SwitchSelectMode(SectionSelectHeroConst.SELECT_HERO_MODE.SINGLE)
	end

	self:RecordMultiButtonTouch()
end

function NewHeroTeamInfoBaseView:SwitchSelectMode(arg_50_1)
	self.selectHeroMode_ = arg_50_1

	if self.selectHeroMode_ == SectionSelectHeroConst.SELECT_HERO_MODE.SINGLE then
		self:SwitchToSingleMode()
	else
		self:SwitchToMultiMode()
	end

	self:RefreshSelectModeUI()
end

function NewHeroTeamInfoBaseView:SwitchToMultiMode()
	self:ResetMultiModeTeam()
	self.heroHeadList_:Refresh()
end

function NewHeroTeamInfoBaseView:ResetMultiModeTeam()
	self.multiModeHeroList_ = deepClone(self.heroTeam_)
	self.multiModeTrialList_ = deepClone(self.heroTrialList_)
end

function NewHeroTeamInfoBaseView:SwitchToSingleMode()
	self.heroHeadList_:Refresh()
end

function NewHeroTeamInfoBaseView:RefreshMultiModeTeam(arg_54_1)
	local var_54_0, var_54_1, var_54_2 = self:IsInTeam(arg_54_1.id, arg_54_1.trialID)

	if var_54_0 then
		self.multiModeHeroList_[var_54_2] = 0
		self.multiModeTrialList_[var_54_2] = 0
	else
		local var_54_3, var_54_4 = self:CheckMultiModeCanAddHero(arg_54_1)

		if not var_54_3 then
			if var_54_4 then
				ShowTips(var_54_4)
			end

			return
		end

		local var_54_5 = self:FindMultiModeNextValidTeamPos()

		if var_54_5 then
			self.multiModeHeroList_[var_54_5] = arg_54_1.id
			self.multiModeTrialList_[var_54_5] = arg_54_1.trialID
		end
	end
end

function NewHeroTeamInfoBaseView:CheckMultiModeCanAddHero(arg_55_1)
	local var_55_0 = true
	local var_55_1 = ""

	if self:IsHeroLock(arg_55_1.id, arg_55_1.trialID) then
		var_55_0 = false
		var_55_1 = nil
	elseif self:IsMultiModeTeamFull() then
		var_55_0 = false
		var_55_1 = "THE_TEAM_IS_FULL"
	elseif self:IsSameHeroInTeam(arg_55_1.id) then
		var_55_0 = false
		var_55_1 = "SELECT_SAME_HERO"
	end

	return var_55_0, var_55_1
end

function NewHeroTeamInfoBaseView:FindMultiModeNextValidTeamPos()
	for iter_56_0, iter_56_1 in ipairs(self.multiModeHeroList_) do
		if iter_56_1 == 0 and not self.lockStateList_[iter_56_0] then
			return iter_56_0
		end
	end

	return nil
end

function NewHeroTeamInfoBaseView:IsMultiModeTeamFull()
	for iter_57_0, iter_57_1 in ipairs(self.multiModeHeroList_) do
		if iter_57_1 == 0 and not self.lockStateList_[iter_57_0] then
			return false
		end
	end

	return true
end

function NewHeroTeamInfoBaseView:ResetSelectMode()
	self.selectHeroMode_ = SectionSelectHeroConst.SELECT_HERO_MODE.SINGLE

	self:RefreshMultiModeBtn()
end

function NewHeroTeamInfoBaseView:GetTargetScrollIndex()
	local var_59_0 = 1

	for iter_59_0, iter_59_1 in ipairs(self.heroDataList_) do
		if iter_59_1.id == self.selectHeroData_.id and iter_59_1.trialID == self.selectHeroData_.trialID then
			var_59_0 = iter_59_0

			break
		end
	end

	return var_59_0
end

function NewHeroTeamInfoBaseView:SelectHero(arg_60_1)
	if self.selectHeroMode_ == SectionSelectHeroConst.SELECT_HERO_MODE.SINGLE then
		self:SingleModeSelectHero(arg_60_1)
	else
		self:MultiModeSelectHero(arg_60_1)
	end
end

function NewHeroTeamInfoBaseView:SingleModeSelectHero(arg_61_1)
	self.selectHeroData_ = arg_61_1

	self:RefreshSingleModeUI()
	self:RefreshInfoBtn()
end

function NewHeroTeamInfoBaseView:MultiModeSelectHero(arg_62_1)
	self.selectHeroData_ = arg_62_1

	self:RefreshMultiModeUI()
	self:RefreshInfoBtn()
end

function NewHeroTeamInfoBaseView:MultiModeChangeTeam(arg_63_1)
	self:RefreshMultiModeTeam(arg_63_1)
	self:MultiModeSelectHero(arg_63_1)
end

function NewHeroTeamInfoBaseView:GetHeroTeam()
	self.heroTeam_, self.lockStateList_, self.lockHeroList_, self.heroTrialList_ = self.sectionProxy_:CustomGetTeamData()
end

function NewHeroTeamInfoBaseView:GetHeroList()
	return (self.canUseOwnHero_ ~= false or nil) and HeroTools.Sort(HeroData:GetHeroList())
end

function NewHeroTeamInfoBaseView:OnInfoBtnClick()
	local var_66_0 = "/newHero"
	local var_66_1 = {
		isEnter = true
	}

	if self.selectHeroData_.trialID ~= 0 then
		var_66_1.hid = self.selectHeroData_.trialID or self.selectHeroData_.id
	end

	if self.selectHeroData_.trialID ~= 0 then
		var_66_1.type = HeroConst.HERO_DATA_TYPE.TRIAL or self.heroDataType_
	end

	var_66_1.tempHeroList = self:GetValidTrailList()

	self:Go(var_66_0, var_66_1)
end

function NewHeroTeamInfoBaseView:GetValidTrailList()
	local var_67_0 = {}

	if self.selectHeroData_.trialID ~= 0 then
		for iter_67_0, iter_67_1 in pairs(self.allTrialIDList_) do
			if not HeroTools.IsNPC(HeroStandardSystemCfg[iter_67_1].hero_id) and not HeroTools.NeedHideInfo(HeroStandardSystemCfg[iter_67_1].hero_id) then
				table.insert(var_67_0, iter_67_1)
			end
		end
	end

	return var_67_0
end

function NewHeroTeamInfoBaseView:OnJoinClick()
	local var_68_0
	local var_68_1
	local var_68_2

	if self.selectHeroMode_ == SectionSelectHeroConst.SELECT_HERO_MODE.SINGLE then
		var_68_0, var_68_1, var_68_2 = self:TryToChangeSingleHero(self.selectHeroData_.id, self.selectHeroData_.trialID, self.params_.selectHeroPos)
	else
		var_68_0, var_68_1, var_68_2 = self:TryToChangeMultiHero()
	end

	if var_68_0 then
		self:TryToReoerderTeam(var_68_1, var_68_2)
		self:TryToChangeTeam(var_68_1, var_68_2)
	end
end

function NewHeroTeamInfoBaseView:TryToChangeSingleHero(arg_69_1, arg_69_2, arg_69_3)
	local var_69_0 = true
	local var_69_1, var_69_2 = self:IsSameHeroInTeam(arg_69_1)
	local var_69_3 = deepClone(self.heroTeam_)
	local var_69_4 = deepClone(self.heroTrialList_)

	if var_69_1 then
		if var_69_2 == arg_69_3 then
			if arg_69_1 == var_69_3[var_69_2] then
				if arg_69_2 == var_69_4[var_69_2] then
					self:RemoveHero(var_69_2, var_69_3, var_69_4)
				else
					var_69_0 = self:AddHero(arg_69_3, arg_69_1, arg_69_2, var_69_3, var_69_4)

					if not var_69_0 then
						return var_69_0
					end

					SectionSelectHeroVoiceManager.GetInstance():SetNeedApperanceVoiceHeroId(arg_69_1)
				end
			end
		else
			self:Swap(var_69_2, arg_69_3, var_69_3)
			self:Swap(var_69_2, arg_69_3, var_69_4)
			SectionSelectHeroVoiceManager.GetInstance():SetNeedApperanceVoiceHeroId(arg_69_1)
		end
	else
		var_69_0 = self:AddHero(arg_69_3, arg_69_1, arg_69_2, var_69_3, var_69_4)

		if not var_69_0 then
			return var_69_0
		end

		SectionSelectHeroVoiceManager.GetInstance():SetNeedApperanceVoiceHeroId(arg_69_1)
	end

	return var_69_0, var_69_3, var_69_4
end

function NewHeroTeamInfoBaseView:RemoveHero(arg_70_1, arg_70_2, arg_70_3)
	arg_70_2[arg_70_1] = 0
	arg_70_3[arg_70_1] = 0
end

function NewHeroTeamInfoBaseView:AddHero(arg_71_1, arg_71_2, arg_71_3, arg_71_4, arg_71_5)
	arg_71_4[arg_71_1] = arg_71_2
	arg_71_5[arg_71_1] = arg_71_3

	return true
end

function NewHeroTeamInfoBaseView:Swap(arg_72_1, arg_72_2, arg_72_3)
	arg_72_3[arg_72_2], arg_72_3[arg_72_1] = arg_72_3[arg_72_1], arg_72_3[arg_72_2]
end

function NewHeroTeamInfoBaseView:TryToReoerderTeam(arg_73_1, arg_73_2)
	if self:IsNeedReorder() then
		self:ReorderHeroTeam(arg_73_1, arg_73_2, self.canSwitchResctrictHeroList_)
	end
end

function NewHeroTeamInfoBaseView:IsNeedReorder()
	return self.canSwitchResctrictHeroList_[self.params_.selectHeroPos] == ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID and self.reorder_ == true
end

function NewHeroTeamInfoBaseView:TryToChangeMultiHero()
	local var_75_0 = true
	local var_75_1 = {}
	local var_75_2 = {}

	for iter_75_0, iter_75_1 in ipairs(self.multiModeHeroList_) do
		var_75_0 = self:AddHero(iter_75_0, iter_75_1, self.multiModeTrialList_[iter_75_0], var_75_1, var_75_2)

		if not var_75_0 then
			return var_75_0
		end
	end

	return var_75_0, var_75_1, var_75_2
end

function NewHeroTeamInfoBaseView:TryToChangeTeam(arg_76_1, arg_76_2)
	self:ChangeTeam(arg_76_1, arg_76_2)
	self:OnChangeTeamSuccess()
end

function NewHeroTeamInfoBaseView:ChangeTeam(arg_77_1, arg_77_2)
	self.sectionProxy_:ChangeHeroTeam(arg_77_1, arg_77_2)
end

function NewHeroTeamInfoBaseView:OnChangeTeamSuccess()
	self:Back(1, {
		isSorted = true
	})
end

function NewHeroTeamInfoBaseView:IsInTeam(arg_79_1, arg_79_2)
	local var_79_0 = {}
	local var_79_1 = {}

	if self.selectHeroMode_ == SectionSelectHeroConst.SELECT_HERO_MODE.SINGLE then
		var_79_0 = self.heroTeam_
		var_79_1 = self.heroTrialList_
	else
		var_79_0 = self.multiModeHeroList_
		var_79_1 = self.multiModeTrialList_
	end

	return SectionSelectHeroTools.IsInTeam(arg_79_1, arg_79_2, var_79_0, var_79_1)
end

function NewHeroTeamInfoBaseView:IsSameHeroInTeam(arg_80_1)
	return SectionSelectHeroTools.IsSameHeroInTeam(arg_80_1, self.selectHeroMode_ == SectionSelectHeroConst.SELECT_HERO_MODE.SINGLE and self.heroTeam_ or self.multiModeHeroList_)
end

function NewHeroTeamInfoBaseView:ReorderHeroTeam(arg_81_1, arg_81_2, arg_81_3)
	SectionSelectHeroTools.ReorderHeroTeam(arg_81_1, arg_81_2, arg_81_3)
end

function NewHeroTeamInfoBaseView:IsPosLocked(arg_82_1)
	return self.lockStateList_[arg_82_1] == true
end

function NewHeroTeamInfoBaseView:IsHeroLock(arg_83_1, arg_83_2)
	return table.keyof(self.lockHeroList_, arg_83_1) ~= nil or table.keyof(self.lockHeroList_, arg_83_2) ~= nil
end

function NewHeroTeamInfoBaseView:GetHeroHeadClass()
	return SectionHeroTeamHeadItem
end

function NewHeroTeamInfoBaseView:HeadRenderer(arg_85_1, arg_85_2)
	local var_85_0 = self.heroDataList_[arg_85_1].id
	local var_85_1 = self.heroDataList_[arg_85_1].trialID

	arg_85_2:SetStageID(self.stageID_)
	arg_85_2:SetSectionHeroData(self.heroDataList_[arg_85_1])
	arg_85_2:RegisterClickListener(function()
		if self.selectHeroMode_ == SectionSelectHeroConst.SELECT_HERO_MODE.SINGLE then
			self:SingleModeSelectHero(self.heroDataList_[arg_85_1])
		else
			self:MultiModeChangeTeam(self.heroDataList_[arg_85_1])
		end
	end)
	arg_85_2:SetHeroLock(self:IsHeroLock(var_85_0, var_85_1))
	arg_85_2:SetSelected(arg_85_2.heroId_ == self.selectHeroData_.id and arg_85_2.trialID_ == self.selectHeroData_.trialID)

	if self.selectHeroMode_ == SectionSelectHeroConst.SELECT_HERO_MODE.SINGLE then
		arg_85_2:SetInTeamFlag(self:IsInTeam(var_85_0, var_85_1))
		arg_85_2:SetMultiPos(false)
	else
		arg_85_2:SetInTeamFlag(false)
		arg_85_2:SetMultiPos(self:IsInTeam(var_85_0, var_85_1))
	end
end

function NewHeroTeamInfoBaseView:GetHeroViewProxy(arg_87_1)
	self.heroViewProxyDic_[arg_87_1] = self.heroViewProxyDic_[arg_87_1] or HeroViewDataProxy.New(arg_87_1)

	return self.heroViewProxyDic_[arg_87_1]
end

function NewHeroTeamInfoBaseView:GetFilterClass()
	return NewHeroListFilterView
end

function NewHeroTeamInfoBaseView:ExtraSorter(arg_89_1, arg_89_2, arg_89_3, arg_89_4)
	local var_89_0, var_89_1, var_89_2 = SectionSelectHeroTools.IsInTeam(arg_89_1.id, arg_89_1.trialID, self.heroTeam_, self.heroTrialList_)
	local var_89_3, var_89_4, var_89_5 = SectionSelectHeroTools.IsInTeam(arg_89_2.id, arg_89_2.trialID, self.heroTeam_, self.heroTrialList_)

	if var_89_0 ~= var_89_3 then
		if var_89_0 and not var_89_3 then
			return true, true
		elseif not var_89_0 and var_89_3 then
			return true, false
		else
			return true, var_89_2 < var_89_5
		end
	end

	if arg_89_1.trialID ~= 0 or arg_89_2.trialID ~= 0 then
		if arg_89_1.trialID ~= 0 and arg_89_2.trialID ~= 0 then
			if arg_89_3 == 0 and arg_89_1.star ~= arg_89_2.star then
				if self.curOrder_ == "desc" then
					return true, arg_89_1.star > arg_89_2.star
				else
					return true, arg_89_1.star < arg_89_2.star
				end
			end

			local var_89_6 = getHeroPower(arg_89_1.trialID, true)
			local var_89_7 = getHeroPower(arg_89_2.trialID, true)

			if var_89_6 ~= var_89_7 then
				if arg_89_4 == "desc" then
					return true, var_89_7 < var_89_6
				else
					return true, var_89_6 < var_89_7
				end
			else
				return true, arg_89_1.trialID > arg_89_2.trialID
			end
		else
			return true, arg_89_1.trialID > arg_89_2.trialID
		end
	end

	return false, false
end

function NewHeroTeamInfoBaseView:OnListChange(arg_90_1, arg_90_2)
	self.heroDataList_ = arg_90_2
	self.selectHeroData_, scrollIndex = self:GetSelectHeroData()

	self.heroHeadList_:StartScroll(#self.heroDataList_, scrollIndex)

	if #self.heroDataList_ == 0 then
		self.emptyController_:SetSelectedState("true")
	else
		self.emptyController_:SetSelectedState("false")

		if self.selectHeroData_ then
			self:SelectHero(self.selectHeroData_)
		end
	end
end

function NewHeroTeamInfoBaseView:OnHeroSort(arg_91_1, arg_91_2, arg_91_3, arg_91_4, arg_91_5)
	self.filterView_:RefreshSort(arg_91_1, arg_91_2, arg_91_3, arg_91_4, arg_91_5)
	HeroData:SaveSortValue(arg_91_1, arg_91_2, arg_91_3, arg_91_4, arg_91_5)
end

function NewHeroTeamInfoBaseView:GetTrialHeroList()
	return GetTrialHeroList(self.stageType_, self.stageID_, self.activityID_)
end

function NewHeroTeamInfoBaseView:GetHeroInfoViewClass()
	return SectionHeroInfoView
end

function NewHeroTeamInfoBaseView:RecordMultiButtonTouch()
	OperationRecorder.RecordButtonTouch({
		button_name = self.selectHeroMode_ == SectionSelectHeroConst.SELECT_HERO_MODE.SINGLE and "combat_team_edit_morehero_close" or "combat_team_edit_morehero_open",
		stage_id = self.stageID_
	})
end

return NewHeroTeamInfoBaseView
