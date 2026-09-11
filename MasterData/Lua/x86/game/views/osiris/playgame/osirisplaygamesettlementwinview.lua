NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local OsirisPlayGameSettlementWinView = class("OsirisPlayGameSettlementWinView", NewBattleSettlementView)

function OsirisPlayGameSettlementWinView:UIName()
	return "Widget/System/BattleResult/Common/BattleResultWinUI_Osiris"
end

function OsirisPlayGameSettlementWinView:Init()
	self.super.Init(self)

	self.lookCon_ = self.controllerEx_:GetController("look")
end

function OsirisPlayGameSettlementWinView:OnEnter()
	self.super.OnEnter(self)
	self:RefreshLook()
end

function OsirisPlayGameSettlementWinView:RefreshLook()
	if ActivityGeneralityStageCfg[ActivityGeneralityStageCfg.get_id_list_by_stage_id[self.stageId][1]].rank_activity > 0 then
		self.lookCon_:SetSelectedIndex(1)
		self.btnController:SetSelectedIndex(0)

		local var_4_0 = OsirisPlayGameData:GetCurStageInfo()

		if var_4_0.stage_id == self.stageId then
			self.numText_.text = var_4_0.point
		end
	else
		self.lookCon_:SetSelectedIndex(0)
		self.btnController:SetSelectedIndex(2)
	end
end

function OsirisPlayGameSettlementWinView:onRenderMissionContent()
	return
end

function OsirisPlayGameSettlementWinView:CloseFunc()
	OperationRecorder.Record(self.class.__cname, "closeCombat")
	self:ShowVitalityBox(function()
		self:ShowEquipBox(function()
			BattleInstance.QuitBattle(self.params_.stageData, false)
		end)
	end)
end

return OsirisPlayGameSettlementWinView
