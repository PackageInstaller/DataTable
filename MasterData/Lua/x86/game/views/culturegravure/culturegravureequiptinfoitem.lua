local CultureGravureEquiptInfoItem = class("CultureGravureEquiptInfoItem", ReduxView)

function CultureGravureEquiptInfoItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CultureGravureEquiptInfoItem:Init()
	self:InitUI()

	self.posNumController_ = ControllerUtil.GetController(self.transform_, "num")
	self.posController_ = {}

	for iter_2_0 = 1, 3 do
		self.posController_[iter_2_0] = ControllerUtil.GetController(self["posStateTrs" .. iter_2_0 .. "_"], "pos")
	end
end

function CultureGravureEquiptInfoItem:SetData(arg_3_1, arg_3_2)
	self.index_ = arg_3_1
	self.equipIDList_ = arg_3_2

	table.sort(self.equipIDList_, function(arg_4_0, arg_4_1)
		return EquipCfg[arg_4_0].pos < EquipCfg[arg_4_1].pos
	end)
	self:RefreshUI()
end

function CultureGravureEquiptInfoItem:InitUI()
	self:BindCfgUI()
end

function CultureGravureEquiptInfoItem:SetCallBack(arg_6_1)
	self.callback = arg_6_1
end

function CultureGravureEquiptInfoItem:RefreshUI()
	self.nameText_.text = EquipSuitCfg[EquipCfg[self.equipIDList_[1]].suit].name

	self.posNumController_:SetSelectedState(#self.equipIDList_)

	for iter_7_0 = 1, #self.equipIDList_ do
		self.posController_[iter_7_0]:SetSelectedState(EquipCfg[self.equipIDList_[iter_7_0]].pos)
	end
end

function CultureGravureEquiptInfoItem:Dispose()
	CultureGravureEquiptInfoItem.super.Dispose(self)
end

return CultureGravureEquiptInfoItem
