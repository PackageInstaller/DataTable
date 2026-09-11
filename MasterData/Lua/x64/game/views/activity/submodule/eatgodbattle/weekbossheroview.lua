local WeekBossHeroView = class("WeekBossHeroView", ReduxView)

function WeekBossHeroView:UIName()
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Monster/V4_2_GodEaterUI_Monster_SelectroleUI"
end

function WeekBossHeroView:UIParent()
	return manager.ui.uiMain.transform
end

function WeekBossHeroView:Init()
	self:InitUI()
	self:AddUIListener()
end

function WeekBossHeroView:InitUI()
	self:BindCfgUI()

	self.selectController_ = self.transCon_:GetController("select")
	self.tipBtnController_ = self.tipsCon_:GetController("btn")
	self.tipStatusController_ = self.tipsCon_:GetController("status")
	self.groupStatusController_ = {}
	self.groupIconController_ = {}
	self.groupRedController_ = {}
	self.heroRedController_ = {}
	self.skillAnim_ = {}
	self.bigTalentAnim_ = {}

	for iter_4_0 = 1, 2 do
		self.groupStatusController_[iter_4_0] = self["groupCon_" .. iter_4_0]:GetController("status")
		self.groupIconController_[iter_4_0] = self["groupCon_" .. iter_4_0]:GetController("icon")
		self.groupRedController_[iter_4_0] = self["groupCon_" .. iter_4_0]:GetController("red")
		self.heroRedController_[iter_4_0] = self["heroCon_" .. iter_4_0]:GetController("red")
		self.skillAnim_[iter_4_0] = self["skillAnim_" .. iter_4_0]
		self.bigTalentAnim_[iter_4_0] = self["bigTalentAnim_" .. iter_4_0]
	end

	self.showIndex_ = nil
	self.talentList_ = {}

	for iter_4_1 = 1, 6 do
		local var_4_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_4_0, self["talent_" .. iter_4_1])

		var_4_0.transform = self["talent_" .. iter_4_1].transform
		var_4_0.lockCon = var_4_0.statusCon_:GetController("lock")
		var_4_0.selectCon = var_4_0.statusCon_:GetController("select")
		var_4_0.iconCon = var_4_0.statusCon_:GetController("icon")
		var_4_0.redCon = var_4_0.statusCon_:GetController("red")
		var_4_0.index = iter_4_1

		self:AddBtnListener(var_4_0.btnClick_, nil, function()
			self:OnSelectTalent(var_4_0, var_4_0.talentId)
		end)

		self.talentList_[iter_4_1] = var_4_0
	end

	self.talent2Item_ = {}
	self.talentUpdateHandler_ = handler(self, self.OnTalentUpdate)
end

function WeekBossHeroView:AddUIListener()
	self:AddBtnListener(self.btnBattle_, nil, function()
		if self.selectHero_ == nil then
			return
		end

		local var_7_0 = self.params_.stageId

		WeekBossData:SetLastSelectHero(self.selectHero_)
		BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.GOD_EATER_BATTLE, var_7_0, {
			heroList = {
				HeroStandardSystemCfg[self.selectHero_].hero_id,
				0,
				0
			},
			heroTrialList = {
				self.selectHero_,
				0,
				0
			},
			viewType = self.params_.type,
			activityId = self.params_.activityId
		})))
	end)
	self:AddBtnListener(self.btnHero_1, nil, function()
		if self.selectIndex_ == 1 or self.selectHero_ == nil then
			return
		end

		self:ChangeSelectHero(1)
		self:RefreshTalent()
		self:ResetStatus()
		self:PlayTalentAnim()
		self:RefreshRed(1)
	end)
	self:AddBtnListener(self.btnHero_2, nil, function()
		if self.selectIndex_ == 2 or self.selectHero_ == nil then
			return
		end

		self:ChangeSelectHero(2)
		self:RefreshTalent()
		self:ResetStatus()
		self:PlayTalentAnim()
		self:RefreshRed(2)
	end)
	self:AddBtnListener(self.btnBigSkill_1, nil, function()
		self:ShowAnim(1)
	end)
	self:AddBtnListener(self.btnBigSkill_2, nil, function()
		self:ShowAnim(2)
	end)
	self:AddBtnListener(self.equipBtn_, nil, function()
		WeekBossAction.ActiveTalent(self.nowSelectIndex_, self.nowTalentId_, self.selectIndex_, self.selectHero_)
	end)
	self:AddBtnListener(self.unloadBtn_, nil, function()
		WeekBossAction.ActiveTalent(self.nowSelectIndex_, 0, self.selectIndex_, self.selectHero_)
	end)
	self:AddBtnListener(self.btnMask_, nil, function()
		self:ResetStatus()
	end)
end

function WeekBossHeroView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("GOD_EATER_GAME_TIPS_4")
	manager.windowBar:RegistBackCallBack(function()
		if self.params_.backCb then
			self.params_.backCb()
		end

		self.isBackEnterView_ = self.params_.type == "dailyMonster"

		self:Back()
	end)
end

function WeekBossHeroView:OnEnter()
	self.trackGo_, self.virtualCameras_ = EatGodBattleTools.GetVirtualCameras()

	self:SetCamera()

	self.heroList_ = WeekBossData:GetHeroList()
	self.lastSelectHeroId_ = WeekBossData:GetLastSelectHero()

	self:LoadHeroModels()
	EatGodBattleTools.SetBackGroundStatus(self.params_.isBoss and "hideEffect" or "hide", 1)

	self.animTimer = Timer.New(function()
		self:PlayTalentAnim()
	end, 0.45, 1)

	self.animTimer:Start()
	manager.notify:RegistListener(TALENT_UPDATE, self.talentUpdateHandler_)
end

function WeekBossHeroView:SetCamera()
	self.cinemachineBrain_ = manager.ui.mainCamera:GetComponent("CinemachineBrain") or manager.ui:AddMainCameraCom(typeof(CinemachineBrain))
	self.cinemachineBrain_.m_CustomBlends = Asset.Load("UI/HeroCamera/CameraData/I19_MainCamera_Blends")
	self.cinemachineBrain_.enabled = true
	self.virtualCameras_[1].Priority = 0
	self.virtualCameras_[2].Priority = 100
end

function WeekBossHeroView:LoadHeroModels()
	self.loadAsyncIndex_ = {}
	self.heroModel_ = {}

	for iter_20_0, iter_20_1 in ipairs(self.heroList_) do
		if iter_20_1 ~= 0 and HeroStandardSystemCfg[iter_20_1] then
			self.loadAsyncIndex_[iter_20_0] = manager.resourcePool:AsyncLoad("Char/" .. SkinCfg[HeroStandardSystemCfg[iter_20_1].hero_id].ui_modelId, ASSET_TYPE.TPOSE, function(arg_21_0)
				self.heroModel_[iter_20_0] = arg_21_0
			end)
		end
	end

	local var_20_0 = table.indexof(self.heroList_, self.lastSelectHeroId_) or 2

	self.loadTimer_ = FrameTimer.New(function()
		if self.heroModel_[1] and self.heroModel_[2] then
			self:ChangeSelectHero(var_20_0)
			self:RefreshTalent()
			self:RefreshRed(1)
			self:RefreshRed(2)
			self.loadTimer_:Stop()

			self.loadTimer_ = nil
		end
	end, 1, -1)

	self.loadTimer_:Start()
end

function WeekBossHeroView:DestroyHeroModels()
	for iter_23_0, iter_23_1 in pairs(self.heroModel_) do
		manager.resourcePool:DestroyOrReturn(iter_23_1, ASSET_TYPE.TPOSE)
	end

	for iter_23_2, iter_23_3 in pairs(self.loadAsyncIndex_) do
		manager.resourcePool:StopAsyncQuest(self.loadAsyncIndex_[iter_23_2])
	end

	self.loadAsyncIndex_ = nil
	self.heroModel_ = nil
end

function WeekBossHeroView:OnSelectTalent(arg_24_1, arg_24_2)
	self:RefreshTips(arg_24_2)

	if self.nowTalentId_ == arg_24_2 then
		return
	end

	if self.selectTalent_ then
		self.selectTalent_.selectCon:SetSelectedState("off")
	end

	self.selectTalent_ = arg_24_1
	self.nowTalentId_ = arg_24_2

	self.selectTalent_.selectCon:SetSelectedState("on")

	if WeekBossData:GetTalentUnlock(arg_24_2) then
		saveData("weekBossHero" .. self.selectHero_, tostring(arg_24_2), 1)
		self:RefreshRed(self.selectIndex_)
	end
end

function WeekBossHeroView:ChangeSelectHero(arg_25_1)
	self.selectController_:SetSelectedState(arg_25_1)

	self.selectHero_ = self.heroList_[arg_25_1]
	self.selectIndex_ = arg_25_1

	for iter_25_0, iter_25_1 in ipairs(self.heroModel_) do
		if iter_25_0 == arg_25_1 then
			iter_25_1.transform.localEulerAngles = WeekBossConst.HeroModelTransform[2].rotation
			iter_25_1.transform.localPosition = WeekBossConst.HeroModelTransform[2].position
			iter_25_1.transform.localScale = SectionSelectHeroConst.HeroModelTransform[2].scale
		else
			iter_25_1.transform.localEulerAngles = WeekBossConst.HeroModelTransform[1].rotation
			iter_25_1.transform.localPosition = WeekBossConst.HeroModelTransform[1].position
			iter_25_1.transform.localScale = SectionSelectHeroConst.HeroModelTransform[1].scale
		end
	end

	self:PlayEffect()
end

function WeekBossHeroView:PlayEffect()
	manager.audio:PlayUIAudioByVoice("hero_change")
	LuaForUtil.PlayEffect(self.heroModel_[self.selectIndex_].transform, "Effect/tongyong/fx_appear_UI", Vector3(0, 0, 0), Vector3(1, 1, 1), Vector3(0, 0, 0), Vector3(0, 0, 0), false, 1, 0, 0.8)
end

function WeekBossHeroView:RefreshTalent()
	self.talent2Item_ = {}
	self.equipedTalent_ = WeekBossData:GetSelectTalent(self.selectHero_)

	local var_27_0 = table.indexof(self.heroList_, self.selectHero_)
	local var_27_1 = ActivityGodEaterWeekBossCfg[self.selectIndex_]

	for iter_27_0, iter_27_1 in ipairs(self.equipedTalent_) do
		self.groupStatusController_[iter_27_0]:SetSelectedState(iter_27_1 == 0 and "empty" or table.indexof(var_27_1.talent_list[iter_27_0], iter_27_1))
		self.groupIconController_[iter_27_0]:SetSelectedIndex(var_27_0 - 1)
	end

	for iter_27_2, iter_27_3 in ipairs(var_27_1.talent_list) do
		for iter_27_4, iter_27_5 in ipairs(iter_27_3) do
			self.talentList_[(iter_27_2 - 1) * 3 + iter_27_4].talentId = iter_27_5

			self.talentList_[(iter_27_2 - 1) * 3 + iter_27_4].lockCon:SetSelectedState(tostring(not WeekBossData:GetTalentUnlock(iter_27_5)))
			self.talentList_[(iter_27_2 - 1) * 3 + iter_27_4].iconCon:SetSelectedIndex(var_27_0 - 1)

			self.talent2Item_[iter_27_5] = self.talentList_[(iter_27_2 - 1) * 3 + iter_27_4]
		end
	end
end

function WeekBossHeroView:RefreshRed(arg_28_1)
	local var_28_0 = false

	for iter_28_0, iter_28_1 in ipairs(ActivityGodEaterWeekBossCfg[arg_28_1].talent_list) do
		local var_28_1 = false

		for iter_28_2, iter_28_3 in ipairs(iter_28_1) do
			local var_28_2 = WeekBossData:GetTalentUnlock(iter_28_3) and getData("weekBossHero" .. self.heroList_[arg_28_1], tostring(iter_28_3)) == nil

			self.talentList_[(iter_28_0 - 1) * 3 + iter_28_2].redCon:SetSelectedState(tostring(var_28_2 and ActivityGodEaterWeekBossCfg[arg_28_1].hero_id == self.selectHero_))

			if var_28_2 then
				var_28_1 = true
			end
		end

		self.groupRedController_[iter_28_0]:SetSelectedState(tostring(var_28_1 and ActivityGodEaterWeekBossCfg[arg_28_1].hero_id == self.selectHero_))

		if var_28_1 then
			var_28_0 = true
		end
	end

	self.heroRedController_[arg_28_1]:SetSelectedState(tostring(var_28_0))
end

function WeekBossHeroView:PlayTalentAnim()
	for iter_29_0, iter_29_1 in ipairs(self.bigTalentAnim_) do
		iter_29_1:Play("UI_bigskill01_cx", -1, 0)
	end
end

function WeekBossHeroView:CheckAutoSelect(arg_30_1)
	local var_30_0 = self.equipedTalent_[arg_30_1]

	self.nowSelectIndex_ = arg_30_1

	if var_30_0 ~= 0 then
		self.tipStatusController_:SetSelectedState(arg_30_1 == 1 and "up" or "down")
		self:OnSelectTalent(self.talent2Item_[var_30_0], var_30_0)
	end
end

function WeekBossHeroView:RefreshTips(arg_31_1)
	self.tipStatusController_:SetSelectedState(self.nowSelectIndex_ == 1 and "up" or "down")

	self.talentNameText_.text = TalentTreeCfg[arg_31_1].name
	self.talentDescText_.text = TalentTreeCfg[arg_31_1].desc

	if not WeekBossData:GetTalentUnlock(arg_31_1) then
		self.tipBtnController_:SetSelectedState("lock")

		self.lockDesc_.text = WeekBossData:GetTalentLockDesc(arg_31_1)
	elseif self.equipedTalent_[self.nowSelectIndex_] == arg_31_1 then
		self.tipBtnController_:SetSelectedState("unload")
	else
		self.tipBtnController_:SetSelectedState("equip")
	end
end

function WeekBossHeroView:OnTalentUpdate()
	self:ResetStatus()

	local var_32_0 = ActivityGodEaterWeekBossCfg[self.selectIndex_]

	self.equipedTalent_ = WeekBossData:GetSelectTalent(self.selectHero_)

	for iter_32_0, iter_32_1 in ipairs(self.equipedTalent_) do
		self.groupStatusController_[iter_32_0]:SetSelectedState(iter_32_1 == 0 and "empty" or table.indexof(var_32_0.talent_list[iter_32_0], iter_32_1))
	end
end

function WeekBossHeroView:ShowAnim(arg_33_1)
	if self.showIndex_ then
		self:ResetStatus()

		if self.showIndex_ == arg_33_1 then
			return
		else
			self.tipStatusController_:SetSelectedState("hide")
			self.skillAnim_[self.showIndex_]:Play("UI_smallskill_xs")
		end
	end

	self.showIndex_ = arg_33_1

	SetActive(self.skillAnim_[arg_33_1].gameObject, true)
	self.skillAnim_[self.showIndex_]:Play("UI_smallskill_cx")
	self:CheckAutoSelect(arg_33_1)
end

function WeekBossHeroView:ResetStatus()
	self.nowTalentId_ = nil

	if self.selectTalent_ then
		self.selectTalent_.selectCon:SetSelectedState("off")

		self.selectTalent_ = nil
	end

	self.tipStatusController_:SetSelectedState("hide")

	if self.showIndex_ then
		SetActive(self.skillAnim_[self.showIndex_].gameObject, false)

		self.showIndex_ = nil
	end
end

function WeekBossHeroView:OnExit()
	manager.ui:ResetMainCamera()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(TALENT_UPDATE, self.talentUpdateHandler_)
	self:DestroyHeroModels()
	self:ResetStatus()

	if self.animTimer then
		self.animTimer:Stop()

		self.animTimer = nil
	end

	self.groupStatusController_[1]:SetSelectedState("hide")
	self.groupStatusController_[2]:SetSelectedState("hide")

	if self.isBackEnterView_ then
		self.isBackEnterView_ = false

		EatGodBattleTools.ResetCamera()
		EatGodBattleTools.UnloadBackScene()
	end

	if self.loadTimer_ then
		self.loadTimer_:Stop()

		self.loadTimer_ = nil
	end
end

function WeekBossHeroView:Dispose()
	EatGodBattleTools.ResetCamera()
	EatGodBattleTools.UnloadBackScene()
	WeekBossHeroView.super.Dispose(self)
end

return WeekBossHeroView
