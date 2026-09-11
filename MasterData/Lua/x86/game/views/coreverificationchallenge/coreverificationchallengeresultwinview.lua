NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")

local CoreVerificationChallengeResultWinView = class("CoreVerificationChallengeResultWinView", NewBattleSettlementView)

function CoreVerificationChallengeResultWinView:UIName()
	return "Widget/System/Core_verification_new/Core_verification_ResultWinUI"
end

function CoreVerificationChallengeResultWinView:Init()
	self.super.Init(self)

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.uiList_, CoreVerificationChallengeResultWinItem)
end

function CoreVerificationChallengeResultWinView:OnEnter()
	self.super.OnEnter(self)
	self:RederAffix()

	self.titleTxt_.text = GetI18NText(CoreVerificationChallengeTools.GetModeCfg()[self.stageId].stage_name)
end

function CoreVerificationChallengeResultWinView:IndexItem(arg_4_1, arg_4_2)
	arg_4_2:RefreshUI(self.affixList[arg_4_1])
end

function CoreVerificationChallengeResultWinView:RederAffix()
	self.affixList = {}

	local var_5_0 = CoreVerificationChallengeTools.GetModeCfg()[self.stageId]

	for iter_5_0, iter_5_1 in ipairs(var_5_0.stage_buff) do
		table.insert(self.affixList, {
			type = 1,
			buff_id = iter_5_1[1]
		})
	end

	for iter_5_2, iter_5_3 in ipairs(var_5_0.stage_debuff) do
		table.insert(self.affixList, {
			type = 2,
			buff_id = iter_5_3[1]
		})
	end

	self.scrollHelper_:StartScroll(#self.affixList)
end

function CoreVerificationChallengeResultWinView:RenderTitleView()
	return
end

function CoreVerificationChallengeResultWinView:onRenderMissionContent()
	return
end

function CoreVerificationChallengeResultWinView:CloseFunc()
	OperationRecorder.Record(self.class.__cname, "closeCombat")
	self:ShowVitalityBox(function()
		self:ShowEquipBox(function()
			BattleInstance.QuitBattle(self.params_.stageData, false)
		end)
	end)
end

function CoreVerificationChallengeResultWinView:Dispose()
	if self.scrollHelper_ then
		self.scrollHelper_:Dispose()

		self.scrollHelper_ = nil
	end

	self.super.Dispose(self)
end

return CoreVerificationChallengeResultWinView
