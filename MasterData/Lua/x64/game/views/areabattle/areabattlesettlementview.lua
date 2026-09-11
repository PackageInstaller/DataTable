NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local AreaBattleSettlementView = class("AreaBattleSettlementView", NewBattleSettlementView)

function AreaBattleSettlementView:IndexItem(arg_1_1, arg_1_2)
	local var_1_0 = clone(ItemTemplateData)

	var_1_0.id = self.rewardItemList[arg_1_1][1]
	var_1_0.number = self.rewardItemList[arg_1_1][2]

	function var_1_0:clickFun()
		ShowPopItemOnly(POP_OTHER_ITEM, {
			self.id,
			self.number
		})
	end

	arg_1_2:SetData(var_1_0)
end

function AreaBattleSettlementView:ShowContent()
	local var_3_0 = self.stageData:GetActivityID()

	self.areaCfg = {}

	self:BindCfgUI(Object.Instantiate(Asset.Load(ActivityAreaBattleData:GetPrefabByActivityID(ActivityCfg.get_id_list_by_sub_activity_list[var_3_0][1]) .. "BattleResultNormalContent_New"), self.contentContainer_), self.areaCfg)

	self.controller = {
		self.areaCfg.targetController1_:GetController("clear"),
		self.areaCfg.targetController2_:GetController("clear"),
		(self.areaCfg.targetController3_:GetController("clear"))
	}
	self.pointCon_ = self.areaCfg.pointController_:GetController("clear")

	local var_3_1 = self.stageData:GetStageId()
	local var_3_2

	for iter_3_0, iter_3_1 in pairs(ActivityAreaBattleData:GetDataByActivityID(ActivityCfg.get_id_list_by_sub_activity_list[var_3_0][1])[var_3_0].difficultList) do
		for iter_3_2, iter_3_3 in pairs(iter_3_1) do
			if iter_3_2 == var_3_1 then
				var_3_2 = iter_3_3
			end
		end
	end

	for iter_3_4 = 1, 3 do
		self.areaCfg[string.format("targetText%d_", iter_3_4)].text = string.format(GetTips("ACTIVITY_AREA_BATTLE_STAGE_CONDITION"), GameSetting.activity_area_battle_point_arg.value[4 - iter_3_4][1])

		if iter_3_4 <= var_3_2.point - 3 then
			self.controller[iter_3_4]:SetSelectedState("state1")

			self.areaCfg[string.format("targetText%d_", iter_3_4)].color = Color.New(0.9102, 0.9351, 0.9408, 1)
		else
			self.controller[iter_3_4]:SetSelectedState("state0")

			self.areaCfg[string.format("targetText%d_", iter_3_4)].color = Color.New(0.6768, 0.6853, 0.6882, 1)
		end
	end

	self.areaCfg.scoreTxt_.text = var_3_2.point

	self.pointCon_:SetSelectedState(var_3_2.point > 0 and "state1" or "state0")

	for iter_3_5, iter_3_6 in pairs((ActivityAreaBattleData:GetStageIdList())) do
		if iter_3_5 == var_3_1 then
			self.areaCfg.isFirst_ = iter_3_6.isFirst

			break
		end
	end

	SetActive(self.areaCfg.firstGo_, not self.areaCfg.isFirst_)
end

function AreaBattleSettlementView:Dispose()
	AreaBattleSettlementView.super.Dispose(self)
end

return AreaBattleSettlementView
