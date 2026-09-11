NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local BattleSequentialBattleResultView = class("BattleSequentialBattleResultView", NewBattleSettlementView)

function BattleSequentialBattleResultView:UIName()
	return SequentialBattleUICfg[SequentialBattleUICfg.get_id_list_by_main_activity_id[SequentialBattleChapterCfg[self.params_.stageData:GetActivityID()].main_id][1]].battle_result_prefab
end

function BattleSequentialBattleResultView:InitUI()
	BattleSequentialBattleResultView.super.InitUI(self)

	self.finishAllController_ = self.controllerEx_:GetController("finishAll")
	self.buffView_ = BattleSequentialBattleResultBuffPanel.New(self.buffPanel_)
	self.finishView_ = BattleSequentialBattleResultFinishPanel.New(self.finishPanel_)
end

function BattleSequentialBattleResultView:RenderView()
	BattleSequentialBattleResultView.super.RenderView(self)
	self.buffView_:SetData(self.params_.stageData:GetStageAffix())

	local var_3_0 = SequentialBattleData:GetCurrentFinishStageIndex(self.params_.stageData:GetActivityID())

	if var_3_0 >= 4 then
		self.finishAllController_:SetSelectedState("true")
	else
		self.finishAllController_:SetSelectedState("false")
	end

	self.finishView_:SetData(var_3_0)
end

function BattleSequentialBattleResultView:ShowContent()
	return
end

function BattleSequentialBattleResultView:AddListener()
	BattleSequentialBattleResultView.super.AddListener(self)
	self:AddBtnListener(self.exitBtn_, nil, function()
		self:CloseFunc()
	end)
	self:AddBtnListener(self.confirm2Btn_, nil, function()
		self:OnClickNextStage()
	end)
end

function BattleSequentialBattleResultView:OnClickNextStage()
	local var_8_0 = self.params_.stageData:GetActivityID()
	local var_8_1 = SequentialBattleData:GetCurrentFinishStageIndex(var_8_0) + 1

	BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE, SequentialBattleChapterCfg[var_8_0].stage_id[var_8_1], var_8_0, (ReserveParams.New(ReserveConst.RESERVE_TYPE.SEQUENTIAL_BATTLE, var_8_0, var_8_1, {
		stageType = BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE,
		stageID = SequentialBattleChapterCfg[var_8_0].stage_id[var_8_1],
		activityID = var_8_0
	})))))
end

function BattleSequentialBattleResultView:Dispose()
	self.buffView_:Dispose()

	self.buffView_ = nil

	self.finishView_:Dispose()

	self.finishView_ = nil

	BattleSequentialBattleResultView.super.Dispose(self)
end

return BattleSequentialBattleResultView
