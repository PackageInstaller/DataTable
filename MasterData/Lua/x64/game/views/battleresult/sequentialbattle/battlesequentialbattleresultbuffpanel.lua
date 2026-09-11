local BattleSequentialBattleResultBuffPanel = class("BattleSequentialBattleResultBuffPanel", ReduxView)

function BattleSequentialBattleResultBuffPanel:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.buffItemList_ = {}
	self.emptyController_ = self.controllerEx_:GetController("empty")
end

function BattleSequentialBattleResultBuffPanel:SetData(arg_2_1)
	for iter_2_0 = 1, #arg_2_1 do
		self.buffItemList_[iter_2_0] = self.buffItemList_[iter_2_0] or SequentialBattleFactoryTeamBuff.New(self.buffItem_, self.buffParent_)

		self.buffItemList_[iter_2_0]:SetData(arg_2_1[iter_2_0])
	end

	if #arg_2_1 <= 0 then
		self.emptyController_:SetSelectedState("true")
	else
		self.emptyController_:SetSelectedState("false")
	end
end

function BattleSequentialBattleResultBuffPanel:Dispose()
	for iter_3_0, iter_3_1 in ipairs(self.buffItemList_) do
		iter_3_1:Dispose()
	end

	self.buffItemList_ = nil

	BattleSequentialBattleResultBuffPanel.super.Dispose(self)
end

function BattleSequentialBattleResultBuffPanel:AddListeners()
	return
end

return BattleSequentialBattleResultBuffPanel
