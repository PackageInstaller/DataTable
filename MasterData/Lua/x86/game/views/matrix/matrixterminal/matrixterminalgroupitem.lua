local MartixTerminalGroupItem = class("MartixTerminalGroupItem", ReduxView)

function MartixTerminalGroupItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
end

function MartixTerminalGroupItem:initUI()
	self:BindCfgUI()

	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")
	self.countController_ = ControllerUtil.GetController(self.transform_, "count")
	self.rowController_ = ControllerUtil.GetController(self.transform_, "row")
	self.items = {}

	for iter_2_0 = 1, 3 do
		table.insert(self.items, MatrixTerminalTalentItem.New(self["m_item" .. iter_2_0]))
	end
end

function MartixTerminalGroupItem:Refresh(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = arg_3_2.list
	local var_3_1 = arg_3_2.row
	local var_3_2 = math.min(#arg_3_2.list, 3)

	if arg_3_2.type == 1 then
		self.stateController_:SetSelectedIndex(0)
		self.rowController_:SetSelectedIndex(0)
	else
		self.stateController_:SetSelectedIndex(1)
		self.rowController_:SetSelectedIndex(var_3_1 and 1 or 0)
	end

	self.countController_:SetSelectedIndex(var_3_2)

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		if self.items[iter_3_0] then
			self.items[iter_3_0]:Refresh(iter_3_1, arg_3_3, arg_3_4, arg_3_5)
		end
	end

	self:SetItemScrollMask(false)
end

function MartixTerminalGroupItem:SetChoice(arg_4_1)
	for iter_4_0, iter_4_1 in pairs(self.items) do
		iter_4_1:SetChoice(arg_4_1)
	end
end

function MartixTerminalGroupItem:RefreshData(arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in pairs(self.items) do
		iter_5_1:RefreshData(arg_5_1, arg_5_2)
	end
end

function MartixTerminalGroupItem:RegistCallBack(arg_6_1)
	for iter_6_0, iter_6_1 in pairs(self.items) do
		iter_6_1:RegistCallBack(arg_6_1)
	end
end

function MartixTerminalGroupItem:SetItemScrollMask(arg_7_1)
	for iter_7_0, iter_7_1 in pairs(self.items) do
		iter_7_1:SetScrollEnable(arg_7_1)
	end
end

function MartixTerminalGroupItem:Dispose()
	for iter_8_0, iter_8_1 in pairs(self.items) do
		iter_8_1:Dispose()
	end

	MartixTerminalGroupItem.super.Dispose(self)
end

return MartixTerminalGroupItem
