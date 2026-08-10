local var_0_0 = class("WeekBossHeroView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Monster/V4_2_GodEaterUI_Monster_SelectroleUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.selectController_ = arg_4_0.transCon_:GetController("select")
	arg_4_0.tipBtnController_ = arg_4_0.tipsCon_:GetController("btn")
	arg_4_0.tipStatusController_ = arg_4_0.tipsCon_:GetController("status")
	arg_4_0.groupStatusController_ = {}
	arg_4_0.groupIconController_ = {}
	arg_4_0.groupRedController_ = {}
	arg_4_0.heroRedController_ = {}
	arg_4_0.skillAnim_ = {}
	arg_4_0.bigTalentAnim_ = {}

	for iter_4_0 = 1, 2 do
		arg_4_0.groupStatusController_[iter_4_0] = arg_4_0["groupCon_" .. iter_4_0]:GetController("status")
		arg_4_0.groupIconController_[iter_4_0] = arg_4_0["groupCon_" .. iter_4_0]:GetController("icon")
		arg_4_0.groupRedController_[iter_4_0] = arg_4_0["groupCon_" .. iter_4_0]:GetController("red")
		arg_4_0.heroRedController_[iter_4_0] = arg_4_0["heroCon_" .. iter_4_0]:GetController("red")
		arg_4_0.skillAnim_[iter_4_0] = arg_4_0["skillAnim_" .. iter_4_0]
		arg_4_0.bigTalentAnim_[iter_4_0] = arg_4_0["bigTalentAnim_" .. iter_4_0]
	end

	arg_4_0.showIndex_ = nil
	arg_4_0.talentList_ = {}

	for iter_4_1 = 1, 6 do
		local var_4_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_4_0, arg_4_0["talent_" .. iter_4_1])

		var_4_0.transform = arg_4_0["talent_" .. iter_4_1].transform
		var_4_0.lockCon = var_4_0.statusCon_:GetController("lock")
		var_4_0.selectCon = var_4_0.statusCon_:GetController("select")
		var_4_0.iconCon = var_4_0.statusCon_:GetController("icon")
		var_4_0.redCon = var_4_0.statusCon_:GetController("red")
		var_4_0.index = iter_4_1

		arg_4_0:AddBtnListener(var_4_0.btnClick_, nil, function()
			arg_4_0:OnSelectTalent(var_4_0, var_4_0.talentId)
		end)

		arg_4_0.talentList_[iter_4_1] = var_4_0
	end

	arg_4_0.talent2Item_ = {}
	arg_4_0.talentUpdateHandler_ = handler(arg_4_0, arg_4_0.OnTalentUpdate)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btnBattle_, nil, function()
		if arg_6_0.selectHero_ == nil then
			return
		end

		local var_7_0 = arg_6_0.params_.stageId
		local var_7_1 = arg_6_0.params_.activityId
		local var_7_2 = arg_6_0.params_.type
		local var_7_3 = {
			HeroStandardSystemCfg[arg_6_0.selectHero_].hero_id,
			0,
			0
		}
		local var_7_4 = {
			arg_6_0.selectHero_,
			0,
			0
		}

		WeekBossData:SetLastSelectHero(arg_6_0.selectHero_)

		local var_7_5 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.GOD_EATER_BATTLE, var_7_0, {
			heroList = var_7_3,
			heroTrialList = var_7_4,
			viewType = var_7_2,
			activityId = var_7_1
		})

		BattleController.GetInstance():LaunchBattle(var_7_5)
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnHero_1, nil, function()
		if arg_6_0.selectIndex_ == 1 or arg_6_0.selectHero_ == nil then
			return
		end

		arg_6_0:ChangeSelectHero(1)
		arg_6_0:RefreshTalent()
		arg_6_0:ResetStatus()
		arg_6_0:PlayTalentAnim()
		arg_6_0:RefreshRed(1)
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnHero_2, nil, function()
		if arg_6_0.selectIndex_ == 2 or arg_6_0.selectHero_ == nil then
			return
		end

		arg_6_0:ChangeSelectHero(2)
		arg_6_0:RefreshTalent()
		arg_6_0:ResetStatus()
		arg_6_0:PlayTalentAnim()
		arg_6_0:RefreshRed(2)
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnBigSkill_1, nil, function()
		arg_6_0:ShowAnim(1)
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnBigSkill_2, nil, function()
		arg_6_0:ShowAnim(2)
	end)
	arg_6_0:AddBtnListener(arg_6_0.equipBtn_, nil, function()
		WeekBossAction.ActiveTalent(arg_6_0.nowSelectIndex_, arg_6_0.nowTalentId_, arg_6_0.selectIndex_, arg_6_0.selectHero_)
	end)
	arg_6_0:AddBtnListener(arg_6_0.unloadBtn_, nil, function()
		WeekBossAction.ActiveTalent(arg_6_0.nowSelectIndex_, 0, arg_6_0.selectIndex_, arg_6_0.selectHero_)
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnMask_, nil, function()
		arg_6_0:ResetStatus()
	end)
end

function var_0_0.OnTop(arg_15_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("GOD_EATER_GAME_TIPS_4")
	manager.windowBar:RegistBackCallBack(function()
		if arg_15_0.params_.backCb then
			arg_15_0.params_.backCb()
		end

		arg_15_0.isBackEnterView_ = arg_15_0.params_.type == "dailyMonster"

		arg_15_0:Back()
	end)
end

function var_0_0.OnEnter(arg_17_0)
	arg_17_0.trackGo_, arg_17_0.virtualCameras_ = EatGodBattleTools.GetVirtualCameras()

	arg_17_0:SetCamera()

	arg_17_0.heroList_ = WeekBossData:GetHeroList()
	arg_17_0.lastSelectHeroId_ = WeekBossData:GetLastSelectHero()

	arg_17_0:LoadHeroModels()

	local var_17_0 = arg_17_0.params_.isBoss and "hideEffect" or "hide"

	EatGodBattleTools.SetBackGroundStatus(var_17_0, 1)

	arg_17_0.animTimer = Timer.New(function()
		arg_17_0:PlayTalentAnim()
	end, 0.45, 1)

	arg_17_0.animTimer:Start()
	manager.notify:RegistListener(TALENT_UPDATE, arg_17_0.talentUpdateHandler_)
end

function var_0_0.SetCamera(arg_19_0)
	arg_19_0.cinemachineBrain_ = manager.ui.mainCamera:GetComponent("CinemachineBrain")

	if not arg_19_0.cinemachineBrain_ then
		arg_19_0.cinemachineBrain_ = manager.ui:AddMainCameraCom(typeof(CinemachineBrain))
	end

	arg_19_0.cinemachineBrain_.m_CustomBlends = Asset.Load("UI/HeroCamera/CameraData/I19_MainCamera_Blends")
	arg_19_0.cinemachineBrain_.enabled = true
	arg_19_0.virtualCameras_[1].Priority = 0
	arg_19_0.virtualCameras_[2].Priority = 100
end

function var_0_0.LoadHeroModels(arg_20_0)
	arg_20_0.loadAsyncIndex_ = {}
	arg_20_0.heroModel_ = {}

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.heroList_) do
		if iter_20_1 ~= 0 and HeroStandardSystemCfg[iter_20_1] then
			local var_20_0 = HeroStandardSystemCfg[iter_20_1].hero_id
			local var_20_1 = SkinCfg[var_20_0]

			arg_20_0.loadAsyncIndex_[iter_20_0] = manager.resourcePool:AsyncLoad("Char/" .. var_20_1.ui_modelId, ASSET_TYPE.TPOSE, function(arg_21_0)
				arg_20_0.heroModel_[iter_20_0] = arg_21_0
			end)
		end
	end

	local var_20_2 = table.indexof(arg_20_0.heroList_, arg_20_0.lastSelectHeroId_) or 2

	arg_20_0.loadTimer_ = FrameTimer.New(function()
		if arg_20_0.heroModel_[1] and arg_20_0.heroModel_[2] then
			arg_20_0:ChangeSelectHero(var_20_2)
			arg_20_0:RefreshTalent()
			arg_20_0:RefreshRed(1)
			arg_20_0:RefreshRed(2)
			arg_20_0.loadTimer_:Stop()

			arg_20_0.loadTimer_ = nil
		end
	end, 1, -1)

	arg_20_0.loadTimer_:Start()
end

function var_0_0.DestroyHeroModels(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.heroModel_) do
		manager.resourcePool:DestroyOrReturn(iter_23_1, ASSET_TYPE.TPOSE)
	end

	for iter_23_2, iter_23_3 in pairs(arg_23_0.loadAsyncIndex_) do
		manager.resourcePool:StopAsyncQuest(arg_23_0.loadAsyncIndex_[iter_23_2])
	end

	arg_23_0.loadAsyncIndex_ = nil
	arg_23_0.heroModel_ = nil
end

function var_0_0.OnSelectTalent(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0:RefreshTips(arg_24_2)

	if arg_24_0.nowTalentId_ == arg_24_2 then
		return
	end

	if arg_24_0.selectTalent_ then
		arg_24_0.selectTalent_.selectCon:SetSelectedState("off")
	end

	arg_24_0.selectTalent_ = arg_24_1
	arg_24_0.nowTalentId_ = arg_24_2

	arg_24_0.selectTalent_.selectCon:SetSelectedState("on")

	if WeekBossData:GetTalentUnlock(arg_24_2) then
		saveData("weekBossHero" .. arg_24_0.selectHero_, tostring(arg_24_2), 1)
		arg_24_0:RefreshRed(arg_24_0.selectIndex_)
	end
end

function var_0_0.ChangeSelectHero(arg_25_0, arg_25_1)
	arg_25_0.selectController_:SetSelectedState(arg_25_1)

	arg_25_0.selectHero_ = arg_25_0.heroList_[arg_25_1]
	arg_25_0.selectIndex_ = arg_25_1

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.heroModel_) do
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

	arg_25_0:PlayEffect()
end

function var_0_0.PlayEffect(arg_26_0)
	manager.audio:PlayUIAudioByVoice("hero_change")
	LuaForUtil.PlayEffect(arg_26_0.heroModel_[arg_26_0.selectIndex_].transform, "Effect/tongyong/fx_appear_UI", Vector3(0, 0, 0), Vector3(1, 1, 1), Vector3(0, 0, 0), Vector3(0, 0, 0), false, 1, 0, 0.8)
end

function var_0_0.RefreshTalent(arg_27_0)
	arg_27_0.talent2Item_ = {}
	arg_27_0.equipedTalent_ = WeekBossData:GetSelectTalent(arg_27_0.selectHero_)

	local var_27_0 = table.indexof(arg_27_0.heroList_, arg_27_0.selectHero_)
	local var_27_1 = ActivityGodEaterWeekBossCfg[arg_27_0.selectIndex_]

	for iter_27_0, iter_27_1 in ipairs(arg_27_0.equipedTalent_) do
		local var_27_2 = iter_27_1 == 0

		arg_27_0.groupStatusController_[iter_27_0]:SetSelectedState(var_27_2 and "empty" or table.indexof(var_27_1.talent_list[iter_27_0], iter_27_1))
		arg_27_0.groupIconController_[iter_27_0]:SetSelectedIndex(var_27_0 - 1)
	end

	for iter_27_2, iter_27_3 in ipairs(var_27_1.talent_list) do
		for iter_27_4, iter_27_5 in ipairs(iter_27_3) do
			local var_27_3 = (iter_27_2 - 1) * 3 + iter_27_4

			arg_27_0.talentList_[var_27_3].talentId = iter_27_5

			arg_27_0.talentList_[var_27_3].lockCon:SetSelectedState(tostring(not WeekBossData:GetTalentUnlock(iter_27_5)))
			arg_27_0.talentList_[var_27_3].iconCon:SetSelectedIndex(var_27_0 - 1)

			arg_27_0.talent2Item_[iter_27_5] = arg_27_0.talentList_[var_27_3]
		end
	end
end

function var_0_0.RefreshRed(arg_28_0, arg_28_1)
	local var_28_0 = ActivityGodEaterWeekBossCfg[arg_28_1]
	local var_28_1 = false

	for iter_28_0, iter_28_1 in ipairs(var_28_0.talent_list) do
		local var_28_2 = false

		for iter_28_2, iter_28_3 in ipairs(iter_28_1) do
			local var_28_3 = (iter_28_0 - 1) * 3 + iter_28_2
			local var_28_4 = WeekBossData:GetTalentUnlock(iter_28_3) and getData("weekBossHero" .. arg_28_0.heroList_[arg_28_1], tostring(iter_28_3)) == nil

			arg_28_0.talentList_[var_28_3].redCon:SetSelectedState(tostring(var_28_4 and var_28_0.hero_id == arg_28_0.selectHero_))

			if var_28_4 then
				var_28_2 = true
			end
		end

		arg_28_0.groupRedController_[iter_28_0]:SetSelectedState(tostring(var_28_2 and var_28_0.hero_id == arg_28_0.selectHero_))

		if var_28_2 then
			var_28_1 = true
		end
	end

	arg_28_0.heroRedController_[arg_28_1]:SetSelectedState(tostring(var_28_1))
end

function var_0_0.PlayTalentAnim(arg_29_0)
	for iter_29_0, iter_29_1 in ipairs(arg_29_0.bigTalentAnim_) do
		iter_29_1:Play("UI_bigskill01_cx", -1, 0)
	end
end

function var_0_0.CheckAutoSelect(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0.equipedTalent_[arg_30_1]

	arg_30_0.nowSelectIndex_ = arg_30_1

	if var_30_0 ~= 0 then
		arg_30_0.tipStatusController_:SetSelectedState(arg_30_1 == 1 and "up" or "down")
		arg_30_0:OnSelectTalent(arg_30_0.talent2Item_[var_30_0], var_30_0)
	end
end

function var_0_0.RefreshTips(arg_31_0, arg_31_1)
	arg_31_0.tipStatusController_:SetSelectedState(arg_31_0.nowSelectIndex_ == 1 and "up" or "down")

	local var_31_0 = TalentTreeCfg[arg_31_1]

	arg_31_0.talentNameText_.text = var_31_0.name
	arg_31_0.talentDescText_.text = var_31_0.desc

	if not WeekBossData:GetTalentUnlock(arg_31_1) then
		arg_31_0.tipBtnController_:SetSelectedState("lock")

		arg_31_0.lockDesc_.text = WeekBossData:GetTalentLockDesc(arg_31_1)
	elseif arg_31_0.equipedTalent_[arg_31_0.nowSelectIndex_] == arg_31_1 then
		arg_31_0.tipBtnController_:SetSelectedState("unload")
	else
		arg_31_0.tipBtnController_:SetSelectedState("equip")
	end
end

function var_0_0.OnTalentUpdate(arg_32_0)
	arg_32_0:ResetStatus()

	local var_32_0 = ActivityGodEaterWeekBossCfg[arg_32_0.selectIndex_]

	arg_32_0.equipedTalent_ = WeekBossData:GetSelectTalent(arg_32_0.selectHero_)

	for iter_32_0, iter_32_1 in ipairs(arg_32_0.equipedTalent_) do
		local var_32_1 = iter_32_1 == 0

		arg_32_0.groupStatusController_[iter_32_0]:SetSelectedState(var_32_1 and "empty" or table.indexof(var_32_0.talent_list[iter_32_0], iter_32_1))
	end
end

function var_0_0.ShowAnim(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0.showIndex_

	if var_33_0 then
		arg_33_0:ResetStatus()

		if var_33_0 == arg_33_1 then
			return
		else
			arg_33_0.tipStatusController_:SetSelectedState("hide")
			arg_33_0.skillAnim_[var_33_0]:Play("UI_smallskill_xs")
		end
	end

	arg_33_0.showIndex_ = arg_33_1

	SetActive(arg_33_0.skillAnim_[arg_33_1].gameObject, true)
	arg_33_0.skillAnim_[arg_33_0.showIndex_]:Play("UI_smallskill_cx")
	arg_33_0:CheckAutoSelect(arg_33_1)
end

function var_0_0.ResetStatus(arg_34_0)
	arg_34_0.nowTalentId_ = nil

	if arg_34_0.selectTalent_ then
		arg_34_0.selectTalent_.selectCon:SetSelectedState("off")

		arg_34_0.selectTalent_ = nil
	end

	arg_34_0.tipStatusController_:SetSelectedState("hide")

	if arg_34_0.showIndex_ then
		SetActive(arg_34_0.skillAnim_[arg_34_0.showIndex_].gameObject, false)

		arg_34_0.showIndex_ = nil
	end
end

function var_0_0.OnExit(arg_35_0)
	manager.ui:ResetMainCamera()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(TALENT_UPDATE, arg_35_0.talentUpdateHandler_)
	arg_35_0:DestroyHeroModels()
	arg_35_0:ResetStatus()

	if arg_35_0.animTimer then
		arg_35_0.animTimer:Stop()

		arg_35_0.animTimer = nil
	end

	arg_35_0.groupStatusController_[1]:SetSelectedState("hide")
	arg_35_0.groupStatusController_[2]:SetSelectedState("hide")

	if arg_35_0.isBackEnterView_ then
		arg_35_0.isBackEnterView_ = false

		EatGodBattleTools.ResetCamera()
		EatGodBattleTools.UnloadBackScene()
	end

	if arg_35_0.loadTimer_ then
		arg_35_0.loadTimer_:Stop()

		arg_35_0.loadTimer_ = nil
	end
end

function var_0_0.Dispose(arg_36_0)
	EatGodBattleTools.ResetCamera()
	EatGodBattleTools.UnloadBackScene()
	var_0_0.super.Dispose(arg_36_0)
end

return var_0_0
