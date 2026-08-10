local var_0_0 = class("BattleSettlementMissionModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_0:InstView(arg_1_1)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.InstView(arg_2_0, arg_2_1)
	local var_2_0 = "Widget/System/BattleResult/Common/Module/BattleResultNormalContent"

	return (Object.Instantiate(Asset.Load(var_2_0), arg_2_1))
end

function var_0_0.BuildContext(arg_3_0)
	arg_3_0.controller = {
		arg_3_0.targetController1_:GetController("clear"),
		arg_3_0.targetController2_:GetController("clear"),
		(arg_3_0.targetController3_:GetController("clear"))
	}
	arg_3_0.rewardItemList = {}
	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.RenderAwardItem), arg_3_0.rewardList_, CommonItemView)
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:BuildContext()
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.OnExit(arg_6_0)
	return
end

function var_0_0.RenderView(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_3
	local var_7_1 = {}

	for iter_7_0 = 1, 3 do
		if var_7_0 ~= nil and var_7_0[iter_7_0] ~= nil then
			local var_7_2 = ThreeStarConditionCfg[var_7_0[iter_7_0].id]
			local var_7_3

			if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == arg_7_1 then
				var_7_3 = BattleStageData:GetStageData()[arg_7_2]
			elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == arg_7_1 then
				var_7_3 = BattleBossChallengeNormalData:GetStarList(arg_7_2)
			end

			local var_7_4 = false

			if var_7_3 and var_7_3.stars and var_7_3.stars[iter_7_0] == 1 then
				var_7_4 = true
			end

			local var_7_5 = var_7_0[iter_7_0].isComplete or var_7_4

			arg_7_0[string.format("targetText%d_", iter_7_0)].text = GetI18NText(BattleInstance.GetStarMissionText(var_7_0[iter_7_0].id, var_7_0[iter_7_0].xData, var_7_0[iter_7_0].yData))

			if var_7_5 then
				arg_7_0.controller[iter_7_0]:SetSelectedState("state1")

				arg_7_0[string.format("targetText%d_", iter_7_0)].color = Color.New(0.9102, 0.9351, 0.9408, 1)
			else
				arg_7_0.controller[iter_7_0]:SetSelectedState("state0")

				arg_7_0[string.format("targetText%d_", iter_7_0)].color = Color.New(0.6768, 0.6853, 0.6882, 1)
			end

			var_7_1[iter_7_0] = var_7_5 and 1 or 0
		else
			arg_7_0.controller[iter_7_0]:SetSelectedState("no info")
		end
	end

	BattleInstance.RecordThreeStar(arg_7_0.stageType, arg_7_0.stageId, var_7_1)
end

function var_0_0.RenderRewards(arg_8_0, arg_8_1)
	local var_8_0 = {}

	if arg_8_1 then
		for iter_8_0, iter_8_1 in pairs(arg_8_1) do
			table.insert(var_8_0, iter_8_1)
		end

		var_8_0 = formatRewardCfgList(var_8_0)
		var_8_0 = mergeReward(var_8_0)
		var_8_0 = sortReward(var_8_0)
	end

	arg_8_0.rewardItemList = var_8_0

	arg_8_0.scrollHelper_:StartScroll(#var_8_0, 1)
end

function var_0_0.RenderAwardItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.rewardItemList[arg_9_1]

	if ItemCfg[var_9_0.id] and ItemConst.ITEM_TYPE.EQUIP == ItemCfg[var_9_0.id].type then
		var_9_0.race = EquipCfg[var_9_0.id] and EquipCfg[var_9_0.id].race or 0
	end

	local var_9_1 = clone(ItemTemplateData)

	var_9_1.id = var_9_0.id
	var_9_1.number = var_9_0.num
	var_9_1.race = var_9_0.race

	function var_9_1.clickFun(arg_10_0)
		ShowPopItemOnly(POP_OTHER_ITEM, {
			arg_10_0.id,
			arg_10_0.number
		}, {
			isSettlement = true
		})
	end

	arg_9_2:SetData(var_9_1)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
