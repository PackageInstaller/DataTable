local BattleSequentialBattleResultFinishPanel = class("BattleSequentialBattleResultFinishPanel", ReduxView)

function BattleSequentialBattleResultFinishPanel:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.finishController_ = {}

	for iter_1_0 = 1, 4 do
		table.insert(self.finishController_, self[string.format("finishControllerEx%s_", iter_1_0)]:GetController("finish"))
	end
end

function BattleSequentialBattleResultFinishPanel:Dispose()
	BattleSequentialBattleResultFinishPanel.super.Dispose(self)
end

function BattleSequentialBattleResultFinishPanel:AddListeners()
	return
end

function BattleSequentialBattleResultFinishPanel:SetData(arg_4_1)
	for iter_4_0 = 1, 4 do
		if iter_4_0 <= arg_4_1 then
			self.finishController_[iter_4_0]:SetSelectedState("true")
		else
			self.finishController_[iter_4_0]:SetSelectedState("false")
		end
	end

	self.valueText_.text = string.format("%s/4", arg_4_1)
end

return BattleSequentialBattleResultFinishPanel
