local HellaParkourTargetItem = class("HellaParkourTargetItem", ReduxView)

function HellaParkourTargetItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HellaParkourTargetItem:Init()
	self:InitUI()
end

function HellaParkourTargetItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
end

function HellaParkourTargetItem:SetData(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self.m_lab.text = BattleInstance.GetStarMissionText(arg_4_3[1], arg_4_3[2], arg_4_3[3])

	if ParkourData:GetParkourStarState(arg_4_2, arg_4_1) then
		self.stateController:SetSelectedIndex(arg_4_4 and 2 or 0)
	else
		self.stateController:SetSelectedIndex(1)
	end
end

return HellaParkourTargetItem
