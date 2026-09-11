local BattleSettlementMissionModule = class("BattleSettlementMissionModule", ReduxView)

function BattleSettlementMissionModule:OnCtor(arg_1_1)
	self.gameObject_ = self:InstView(arg_1_1)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function BattleSettlementMissionModule:InstView(arg_2_1)
	return (Object.Instantiate(Asset.Load("Widget/System/BattleResult/Common/Module/BattleResultNormalContent"), arg_2_1))
end

function BattleSettlementMissionModule:BuildContext()
	self.controller = {
		self.targetController1_:GetController("clear"),
		self.targetController2_:GetController("clear"),
		(self.targetController3_:GetController("clear"))
	}
	self.rewardItemList = {}
	self.scrollHelper_ = LuaList.New(handler(self, self.RenderAwardItem), self.rewardList_, CommonItemView)
end

function BattleSettlementMissionModule:Init()
	self:BindCfgUI()
	self:BuildContext()
end

function BattleSettlementMissionModule:OnEnter()
	return
end

function BattleSettlementMissionModule:OnExit()
	return
end

function BattleSettlementMissionModule:RenderView(arg_7_1, arg_7_2, arg_7_3)
	local var_7_1 = {}

	for iter_7_0 = 1, 3 do
		if arg_7_3 ~= nil and arg_7_3[iter_7_0] ~= nil then
			local var_7_3

			if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == arg_7_1 then
				var_7_3 = BattleStageData:GetStageData()[arg_7_2]
			elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == arg_7_1 then
				var_7_3 = BattleBossChallengeNormalData:GetStarList(arg_7_2)
			end

			local var_7_4 = arg_7_3[iter_7_0].isComplete or not not (var_7_3 and var_7_3.stars and var_7_3.stars[iter_7_0] == 1)

			self[string.format("targetText%d_", iter_7_0)].text = GetI18NText(BattleInstance.GetStarMissionText(arg_7_3[iter_7_0].id, arg_7_3[iter_7_0].xData, arg_7_3[iter_7_0].yData))

			if var_7_4 then
				self.controller[iter_7_0]:SetSelectedState("state1")

				self[string.format("targetText%d_", iter_7_0)].color = Color.New(0.9102, 0.9351, 0.9408, 1)
			else
				self.controller[iter_7_0]:SetSelectedState("state0")

				self[string.format("targetText%d_", iter_7_0)].color = Color.New(0.6768, 0.6853, 0.6882, 1)
			end

			var_7_1[iter_7_0] = var_7_4 and 1 or 0
		else
			self.controller[iter_7_0]:SetSelectedState("no info")
		end
	end

	BattleInstance.RecordThreeStar(self.stageType, self.stageId, var_7_1)
end

function BattleSettlementMissionModule:RenderRewards(arg_8_1)
	local var_8_0 = {}

	if arg_8_1 then
		for iter_8_0, iter_8_1 in pairs(arg_8_1) do
			table.insert(var_8_0, iter_8_1)
		end

		var_8_0 = formatRewardCfgList(var_8_0)
		var_8_0 = mergeReward(var_8_0)
		var_8_0 = sortReward(var_8_0)
	end

	self.rewardItemList = var_8_0

	self.scrollHelper_:StartScroll(#var_8_0, 1)
end

function BattleSettlementMissionModule:RenderAwardItem(arg_9_1, arg_9_2)
	local var_9_0 = self.rewardItemList[arg_9_1]

	if ItemCfg[self.rewardItemList[arg_9_1].id] and ItemConst.ITEM_TYPE.EQUIP == ItemCfg[var_9_0.id].type then
		if EquipCfg[var_9_0.id] then
			var_9_0.race = EquipCfg[var_9_0.id].race or 0
		end
	end

	local var_9_1 = clone(ItemTemplateData)

	var_9_1.id = var_9_0.id
	var_9_1.number = var_9_0.num
	var_9_1.race = var_9_0.race

	function var_9_1:clickFun()
		ShowPopItemOnly(POP_OTHER_ITEM, {
			self.id,
			self.number
		}, {
			isSettlement = true
		})
	end

	arg_9_2:SetData(var_9_1)
end

function BattleSettlementMissionModule:Dispose()
	self.scrollHelper_:Dispose()
	BattleSettlementMissionModule.super.Dispose(self)
end

return BattleSettlementMissionModule
