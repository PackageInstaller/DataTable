local SummerChessBoardEmergencyView = class("SummerChessBoardEmergencyView", ReduxView)

function SummerChessBoardEmergencyView:UIName()
	return "Widget/System/Summer2024/Summer2024_ChessBoard/popUI/Summer2024_EmergencyPopUI"
end

function SummerChessBoardEmergencyView:UIParent()
	return manager.ui.uiPop.transform
end

function SummerChessBoardEmergencyView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SummerChessBoardEmergencyView:InitUI()
	self:BindCfgUI()

	self.taskItem = SummerChessBoardActivityTaskItem.New(self.questGo_)
end

function SummerChessBoardEmergencyView:AddUIListener()
	self:AddBtnListener(self.fullscreenBtn_, nil, function()
		JumpTools.Back()
	end)
end

function SummerChessBoardEmergencyView:OnTop()
	manager.windowBar:SwitchBar({})

	local var_7_0 = SummerChessBoardData:GetBreakOutEventAndRedData()

	if var_7_0 == nil or var_7_0 == 0 then
		JumpTools.Back()
	end
end

function SummerChessBoardEmergencyView:OnEnter()
	saveData("SummerChessBoard", USER_ID .. "EmergencyTime", manager.time:GetServerTime())
	self:InitData()
	self:RefreshUI()
end

function SummerChessBoardEmergencyView:InitData()
	self.eventID = SummerChessBoardData:GetBreakOutEventAndRedData()
end

function SummerChessBoardEmergencyView:RefreshUI()
	if not self.eventID then
		return
	end

	self.titleText_.text = ActivityEmergencyCfg[self.eventID].desc_name
	self.textText_.text = ActivityEmergencyCfg[self.eventID].desc

	self.taskItem:SetData(self.eventID)
end

function SummerChessBoardEmergencyView:OnExit()
	manager.windowBar:HideBar()
end

function SummerChessBoardEmergencyView:Dispose()
	if self.taskItem then
		self.taskItem:Dispose()

		self.taskItem = nil
	end

	self.super.Dispose(self)
end

return SummerChessBoardEmergencyView
