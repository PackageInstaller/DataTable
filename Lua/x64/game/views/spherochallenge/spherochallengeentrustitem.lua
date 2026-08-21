local var_0_0 = class("SPHeroChallengeEntrustItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.awardItem = CommonItemView.New(arg_3_0.awarditemGo_1)
	arg_3_0.needMaterialItem = CommonItemView.New(arg_3_0.needitemGo_1)
	arg_3_0.rankController = arg_3_0.controller:GetController("rank")
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1)
	if arg_4_1 then
		local var_4_0 = ActivityHeroChallengeTaskCfg[arg_4_1.id]

		if var_4_0 then
			arg_4_0.id = arg_4_1.id
			arg_4_0.index = arg_4_1.index
			arg_4_0.timeText_.text = GetTips("ACTIVITY_HERO_CHALLENGE_ENTRUST_TIME") .. manager.time:DescCdTime3(var_4_0.time * 60)
			arg_4_0.entrustnameText_.text = var_4_0.name
			arg_4_0.entrustdescText_.text = var_4_0.desc

			local var_4_1 = {
				id = var_4_0.reward_list[1][1],
				number = var_4_0.reward_list[1][2],
				clickFun = function(arg_5_0)
					ShowPopItem(POP_ITEM, {
						arg_5_0.id,
						arg_5_0.num
					})
				end
			}

			arg_4_0.awardItem:SetData(var_4_1)

			local var_4_2 = {
				id = var_4_0.cost[1][1],
				number = var_4_0.cost[1][2],
				clickFun = function(arg_6_0)
					ShowPopItem(POP_ITEM, {
						arg_6_0.id,
						arg_6_0.num
					})
				end
			}

			arg_4_0.needMaterialItem:SetData(var_4_2)
			arg_4_0.rankController:SetSelectedState(tostring(var_4_0.task_level))
		else
			Debug.LogError("委托item传入的id未获取到配置" .. arg_4_1.id)
		end
	end
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.startBtn_, nil, function()
		local var_8_0 = SPHeroChallengeData:GetCurActivityInfo():GetNextExtrustIndex()

		if var_8_0 then
			local var_8_1 = {
				index = var_8_0,
				entrustID = arg_7_0.id
			}

			if ActivityHeroChallengeTaskCfg[arg_7_0.id].task_level == SpHeroChallengeConst.entrustMaxLevel then
				ShowMessageBox({
					isTop = true,
					content = GetTips("ACTIVITY_HERO_CHALLENGE_ENTRUST_CONFIRM"),
					OkCallback = function()
						SPHeroChallengeAction:DispatchEntrust(var_8_1)
					end
				})
			else
				SPHeroChallengeAction:DispatchEntrust(var_8_1)
			end
		else
			ShowTips("ACTIVITY_HERO_CHALLENGE_ENTRUST_FULL")
		end
	end)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.awardItem:Dispose()
	arg_10_0.needMaterialItem:Dispose()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
