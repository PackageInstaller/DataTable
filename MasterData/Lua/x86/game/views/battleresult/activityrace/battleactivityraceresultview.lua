local BattleActivityRaceResultView = class("BattleActivityRaceResultView", (import("game.views.battleResult.multiple.BattleMultipleResultView")))

function BattleActivityRaceResultView:UIName()
	return "UI/BattleResult/ActivityRaceMultipletUI"
end

function BattleActivityRaceResultView:Init()
	self:InitUI()
	self:AddListener()

	self.heroItemView_ = {}
	self.rewardList_ = LuaList.New(handler(self, self.RewardRenderer), self.rewardUIList_, CommonItem)
	self.affixList_ = LuaList.New(handler(self, self.AffixRenderer), self.affixUIList_, ActivityRaceAffixResultItem)
end

function BattleActivityRaceResultView:OnEnter()
	self.stageData = self.params_.stageData
	self.stageId = self.stageData:GetStageId()
	self.stageType = self.stageData:GetType()

	BattleInstance.hideBattlePanel()
	self:RefreshUI()

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(self.params_.rewardList) do
		for iter_3_2, iter_3_3 in ipairs(iter_3_1) do
			var_3_0[iter_3_3[1]] = var_3_0[iter_3_3[1]] or {}
			var_3_0[iter_3_3[1]][1] = iter_3_3[1]

			if var_3_0[iter_3_3[1]][2] == nil then
				var_3_0[iter_3_3[1]][2] = 0
			end

			var_3_0[iter_3_3[1]][2] = var_3_0[iter_3_3[1]][2] + iter_3_3[2]
		end
	end

	self.rewardDataList_ = {}

	for iter_3_4, iter_3_5 in pairs(var_3_0) do
		self.rewardDataList_[1] = iter_3_5
	end

	self.rewardList_:StartScroll(#self.rewardDataList_, 1)
	self.affixList_:StartScroll(#self.params_.affixList, 1)

	if self.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function()
				self:CloseFunc()
			end
		})
	end
end

function BattleActivityRaceResultView:Dispose()
	self.affixList_:Dispose()

	self.affixList_ = nil

	self.rewardList_:Dispose()

	self.rewardList_ = nil

	BattleActivityRaceResultView.super.Dispose(self)
end

function BattleActivityRaceResultView:RewardRenderer(arg_6_1, arg_6_2)
	arg_6_2:RefreshData(formatReward(self.rewardDataList_[arg_6_1]))
	arg_6_2:RegistCallBack(function()
		ShowPopItem(POP_OTHER_ITEM, self.rewardDataList_[arg_6_1])
	end)
end

function BattleActivityRaceResultView:AffixRenderer(arg_8_1, arg_8_2)
	arg_8_2:SetData(self.params_.affixList[arg_8_1])
end

return BattleActivityRaceResultView
