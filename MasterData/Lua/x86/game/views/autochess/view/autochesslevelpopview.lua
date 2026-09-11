local AutoChessLevelPopView = class("AutoChessLevelPopView", ReduxView)

function AutoChessLevelPopView:UIName()
	return "Widget/System/Activity_Xihe/Activity_Xihe_RankPopUI"
end

function AutoChessLevelPopView:UIParent()
	return manager.ui.uiPop.transform
end

function AutoChessLevelPopView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function AutoChessLevelPopView:InitUI()
	self:BindCfgUI()

	self.levelList_ = LuaList.New(handler(self, self.IndexItem), self.levelListGo_, AutoChessLevelPopItemView)
end

function AutoChessLevelPopView:AddUIListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function AutoChessLevelPopView:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(self.groupedRankIdList_[arg_7_1], self.groupedRankIdList_[arg_7_1 + 1], self.totalScore_)
end

function AutoChessLevelPopView:OnEnter()
	self.totalScore_ = AutoChessCardData:GetRankScore()

	local var_8_0 = clone(AutoChessRankCfg.all)

	table.remove(var_8_0, 1)

	self.groupedRankIdList_ = {}

	for iter_8_0 = 1, #var_8_0, 3 do
		local var_8_1 = {}

		for iter_8_1 = iter_8_0, math.min(iter_8_0 + 2, #var_8_0) do
			table.insert(var_8_1, var_8_0[iter_8_1])
		end

		table.insert(self.groupedRankIdList_, var_8_1)
	end

	self.levelList_:StartScroll(#self.groupedRankIdList_)
end

function AutoChessLevelPopView:Dispose()
	if self.levelList_ then
		self.levelList_:Dispose()
	end

	self.levelList_ = {}

	AutoChessLevelPopView.super.Dispose(self)
end

return AutoChessLevelPopView
