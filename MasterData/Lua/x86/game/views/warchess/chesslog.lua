local WarChessLog = class("WarChessLog", ReduxView)

function WarChessLog:UIName()
	return "Widget/System/WarChess_Battle/WarChessLog"
end

function WarChessLog:UIParent()
	return manager.ui.uiPop.transform
end

function WarChessLog:Init()
	self:InitUI()
	self:AddUIListener()
end

function WarChessLog:InitUI()
	self:BindCfgUI()

	self.scrollHelper = LuaList.New(handler(self, self.indexItem), self.viewportGo_, ChessLogItem)
end

function WarChessLog:UpdateData()
	self.itemList_ = {}

	for iter_5_0, iter_5_1 in ipairs(WarChessData:GetLogs()) do
		self.itemList_[iter_5_0] = iter_5_1.log
	end
end

function WarChessLog:indexItem(arg_6_1, arg_6_2)
	arg_6_2:RefreshUI(arg_6_1, self.itemList_[arg_6_1])
end

function WarChessLog:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function WarChessLog:OnEnter()
	self:UpdateData()
	self.scrollHelper:StartScroll(#self.itemList_)
end

function WarChessLog:OnExit()
	return
end

function WarChessLog:Dispose()
	self.scrollHelper:Dispose()
	WarChessLog.super.Dispose(self)
end

return WarChessLog
