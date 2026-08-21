local var_0_0 = class("BossStarExchangeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Challenge_Boss/BossStarExchangeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.itemList_ = {}
	arg_3_0.refreshHandler_ = handler(arg_3_0, arg_3_0.RefreshReward)
	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.listGo_, BossStarExchangeItem)
end

function var_0_0.IndexItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.taskList_[arg_4_1]

	arg_4_2:SetData(arg_4_0.cfg_.reward[var_4_0], arg_4_0.curStarCnt_, var_4_0, arg_4_1 == #arg_4_0.taskList_)
end

function var_0_0.OnEnter(arg_5_0)
	manager.notify:RegistListener(BOSS_CHALLENGE_RECEIVE_STAR_REWARD, arg_5_0.refreshHandler_)
	arg_5_0:RefreshItem()
end

function var_0_0.OnExit(arg_6_0)
	manager.notify:RemoveListener(BOSS_CHALLENGE_RECEIVE_STAR_REWARD, arg_6_0.refreshHandler_)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.buttonClose_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.RefreshItem(arg_9_0)
	arg_9_0.cfg_ = BattleBossChallengeNormalData:GetBossChallengeCfg()
	arg_9_0.curStarCnt_ = StageTools.CalcBossChallengeStar()

	local var_9_0 = BattleBossChallengeNormalData:GetReceiveStarList()
	local var_9_1 = {}
	local var_9_2 = 0

	for iter_9_0 = 1, #arg_9_0.cfg_.reward do
		table.insert(var_9_1, iter_9_0)

		local var_9_3 = arg_9_0.cfg_.reward[iter_9_0][1]

		if var_9_3 <= arg_9_0.curStarCnt_ and not table.keyof(var_9_0, var_9_3) and var_9_2 == 0 then
			var_9_2 = iter_9_0
		end
	end

	arg_9_0.taskList_ = var_9_1

	arg_9_0.scrollHelper_:StartScroll(#arg_9_0.taskList_, var_9_2)
end

function var_0_0.RefreshReward(arg_10_0)
	arg_10_0.scrollHelper_:Refresh()
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)

	arg_11_0.refreshHandler_ = nil

	arg_11_0.scrollHelper_:Dispose()

	arg_11_0.itemList_ = nil
end

return var_0_0
