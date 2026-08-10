NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local var_0_0 = class("AreaBattleSettlementView", NewBattleSettlementView)

function var_0_0.IndexItem(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_0.rewardItemList[arg_1_1]
	local var_1_1 = clone(ItemTemplateData)

	var_1_1.id = var_1_0[1]
	var_1_1.number = var_1_0[2]

	function var_1_1.clickFun(arg_2_0)
		ShowPopItemOnly(POP_OTHER_ITEM, {
			arg_2_0.id,
			arg_2_0.number
		})
	end

	arg_1_2:SetData(var_1_1)
end

function var_0_0.ShowContent(arg_3_0)
	local var_3_0 = arg_3_0.stageData:GetActivityID()
	local var_3_1 = ActivityCfg.get_id_list_by_sub_activity_list[var_3_0][1]
	local var_3_2 = ActivityAreaBattleData:GetPrefabByActivityID(var_3_1) .. "BattleResultNormalContent_New"
	local var_3_3 = Object.Instantiate(Asset.Load(var_3_2), arg_3_0.contentContainer_)

	arg_3_0.areaCfg = {}

	arg_3_0:BindCfgUI(var_3_3, arg_3_0.areaCfg)

	arg_3_0.controller = {
		arg_3_0.areaCfg.targetController1_:GetController("clear"),
		arg_3_0.areaCfg.targetController2_:GetController("clear"),
		(arg_3_0.areaCfg.targetController3_:GetController("clear"))
	}
	arg_3_0.pointCon_ = arg_3_0.areaCfg.pointController_:GetController("clear")

	local var_3_4 = ActivityAreaBattleData:GetDataByActivityID(var_3_1)[var_3_0]
	local var_3_5 = arg_3_0.stageData:GetStageId()
	local var_3_6

	for iter_3_0, iter_3_1 in pairs(var_3_4.difficultList) do
		for iter_3_2, iter_3_3 in pairs(iter_3_1) do
			if iter_3_2 == var_3_5 then
				var_3_6 = iter_3_3
			end
		end
	end

	for iter_3_4 = 1, 3 do
		arg_3_0.areaCfg[string.format("targetText%d_", iter_3_4)].text = string.format(GetTips("ACTIVITY_AREA_BATTLE_STAGE_CONDITION"), GameSetting.activity_area_battle_point_arg.value[4 - iter_3_4][1])

		if iter_3_4 <= var_3_6.point - 3 then
			arg_3_0.controller[iter_3_4]:SetSelectedState("state1")

			arg_3_0.areaCfg[string.format("targetText%d_", iter_3_4)].color = Color.New(0.9102, 0.9351, 0.9408, 1)
		else
			arg_3_0.controller[iter_3_4]:SetSelectedState("state0")

			arg_3_0.areaCfg[string.format("targetText%d_", iter_3_4)].color = Color.New(0.6768, 0.6853, 0.6882, 1)
		end
	end

	arg_3_0.areaCfg.scoreTxt_.text = var_3_6.point

	arg_3_0.pointCon_:SetSelectedState(var_3_6.point > 0 and "state1" or "state0")

	local var_3_7 = ActivityAreaBattleData:GetStageIdList()

	for iter_3_5, iter_3_6 in pairs(var_3_7) do
		if iter_3_5 == var_3_5 then
			arg_3_0.areaCfg.isFirst_ = iter_3_6.isFirst

			break
		end
	end

	SetActive(arg_3_0.areaCfg.firstGo_, not arg_3_0.areaCfg.isFirst_)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
