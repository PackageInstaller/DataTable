NewBattleScoreResultView = import("game.views.battleResult.score.NewBattleScoreResultView")

local var_0_0 = class("MultHeartDemonResultView", NewBattleScoreResultView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Resident/Acitvity_SoloHeartDemon/SoloHeartDemon_BattleResultWinUI"
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.heroModule = {
		MultHeartDemonWinHeadItem.New(arg_2_0.heroHead1Obj_),
		MultHeartDemonWinHeadItem.New(arg_2_0.heroHead2Obj_),
		(MultHeartDemonWinHeadItem.New(arg_2_0.heroHead3Obj_))
	}
end

function var_0_0.AddListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.confirmBtn_, nil, function()
		arg_3_0:CloseFunc()
	end)
	arg_3_0:AddBtnListener(arg_3_0.statisticsBtn_, nil, function()
		arg_3_0:GoToBattleStatistics()
	end)
	arg_3_0:AddBtnListener(arg_3_0.exitBtn_, nil, function()
		OperationRecorder.Record(arg_3_0.class.__cname, "closeCombat")
		ShowMessageBox({
			isTop = true,
			content = GetTips("MULTI_HEART_DEMON_NOT_SAVE_CONFIRM_TIPS"),
			OkCallback = function()
				arg_3_0:ShowVitalityBox(function()
					arg_3_0:ShowEquipBox(function()
						BattleInstance.QuitBattle(arg_3_0.params_.stageData)
					end)
				end)
			end
		})
	end)
	arg_3_0:OnAddListner()
end

function var_0_0.CloseFunc(arg_10_0)
	local function var_10_0()
		arg_10_0:ShowVitalityBox(function()
			arg_10_0:ShowEquipBox(function()
				BattleInstance.QuitBattle(arg_10_0.params_.stageData)
				MultHeartDemonAction.SaveBattle({
					activity_id = arg_10_0.stageData:GetActivityID(),
					stage_id = arg_10_0.stageId
				})
			end)
		end)
	end

	OperationRecorder.Record(arg_10_0.class.__cname, "closeCombat")

	if _G.SkipTip.SkipActivityMultiDemonContinueConfirm then
		var_10_0()
	else
		ShowMessageBox({
			isTop = true,
			content = GetTips("MULTI_HEART_DEMON_SAVE_CONFIRM_TIPS"),
			OkCallback = var_10_0,
			ToggleCallback = function(arg_14_0)
				_G.SkipTip.SkipActivityMultiDemonContinueConfirm = arg_14_0
			end
		})
	end
end

function var_0_0.SaveData(arg_15_0)
	MultHeartDemonAction.SaveBattle({
		activity_id = arg_15_0.stageData:GetActivityID(),
		stage_id = arg_15_0.stageId
	})
end

local function var_0_1(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0
	local var_16_1

	return (arg_16_0 == 0 and 0 or 1 / (arg_16_2 / arg_16_0 + arg_16_3 / arg_16_0)) + (arg_16_1 == 0 and 0 or 1 / (arg_16_2 / arg_16_1 + arg_16_3 / arg_16_1))
end

function var_0_0.RefreshHeroS(arg_17_0)
	local var_17_0, var_17_1 = arg_17_0.stageData:GetHeroTeam()
	local var_17_2 = 1
	local var_17_3 = var_17_0[var_17_2]
	local var_17_4 = MultHeartDemonData:GetDataByPara("difficultyData")
	local var_17_5 = var_17_4[arg_17_0.stageData:GetDifficult()].heroIdList

	for iter_17_0, iter_17_1 in ipairs(var_17_5) do
		if var_17_3 == iter_17_1 then
			var_17_2 = iter_17_0
		end
	end

	local var_17_6 = var_17_4[arg_17_0.stageData:GetDifficult()].heroHPList or {}
	local var_17_7 = HeroViewDataProxy.New(1)

	for iter_17_2 = 1, 3 do
		if iter_17_2 == 1 then
			local var_17_8 = arg_17_0.stageData:GetHeroDataByPos(iter_17_2)
			local var_17_9 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua

			arg_17_0.heroModule[1]:ShowCaptain(true)

			local var_17_10, var_17_11 = var_17_9.currentHP[0]:tonum2()
			local var_17_12, var_17_13 = var_17_9.MaxHP[0]:tonum2()
			local var_17_14 = var_0_1(var_17_10, var_17_11, var_17_12, var_17_13) * 100

			if var_17_14 > 1 then
				var_17_14 = math.round(var_17_14)
			else
				var_17_14 = var_17_14 > 0 and 1 or 0
			end

			arg_17_0.heroModule[iter_17_2]:SetHp(var_17_14)
			arg_17_0.heroModule[1]:SetHeroData({
				star = 0,
				id = var_17_8.id,
				using_skin = var_17_8.using_skin
			})
		else
			local var_17_15 = (var_17_2 + iter_17_2 - 1) % 3 == 0 and 3 or (var_17_2 + iter_17_2 - 1) % 3

			if HeroStandardSystemCfg[var_17_5[var_17_15]] then
				arg_17_0.heroModule[iter_17_2]:SetHp(var_17_6[var_17_5[var_17_15]] == nil and 100 or 0)
				arg_17_0.heroModule[iter_17_2]:ShowCaptain(false)
				arg_17_0.heroModule[iter_17_2]:SetHeroData({
					star = 0,
					id = HeroStandardSystemCfg[var_17_5[var_17_15]].hero_id,
					using_skin = HeroStandardSystemCfg[var_17_5[var_17_15]].skin_id
				})
			else
				arg_17_0.heroModule[iter_17_2]:SetHeroData({
					star = 0,
					id = var_17_5[var_17_15],
					using_skin = var_17_7:GetHeroUsingSkinInfo(var_17_5[var_17_15]).id
				})
				arg_17_0.heroModule[iter_17_2]:SetHp(var_17_6[var_17_5[var_17_15]] == nil and 100 or 0)
				arg_17_0.heroModule[iter_17_2]:ShowCaptain(false)
			end
		end
	end
end

function var_0_0.ShowContent(arg_18_0)
	local var_18_0 = "Widget/System/BattleResult/Common/Module/BattleChallengeContent"
	local var_18_1 = Object.Instantiate(Asset.Load(var_18_0), arg_18_0.contentContainer_)

	arg_18_0.areaCfg = {}

	arg_18_0:BindCfgUI(var_18_1, arg_18_0.areaCfg)

	arg_18_0.areaCfg.scoreTitleTxt_.text = GetTips("MULTI_HEART_DEMON_TITLE_SCORE")
	arg_18_0.areaCfg.scoreText_.text = MultHeartDemonData:GetDataByPara("battleScore")
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0:RemoveExpTween()

	for iter_19_0 = 1, 3 do
		arg_19_0.heroModule[iter_19_0]:Dispose()
	end

	if arg_19_0.missionView then
		arg_19_0.missionView:Dispose()
	end

	arg_19_0.spriteRef = nil

	arg_19_0:RemoveAllListeners()
	arg_19_0:RemoveAllEventListener()
	ReduxFactory.GetInstance():OnManagedObjDisposed(arg_19_0)
	arg_19_0:CheckListenersLeak()
	arg_19_0:DisposeImageWrap()
end

return var_0_0
