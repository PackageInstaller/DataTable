local HellaParkourLoseItem = class("HellaParkourLoseItem", ReduxView)

function HellaParkourLoseItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HellaParkourLoseItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function HellaParkourLoseItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
	self.selectController = ControllerUtil.GetController(self.transform_, "select")
end

function HellaParkourLoseItem:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		if self.callback_ then
			self.callback_(self.index, true)
		end
	end)
end

function HellaParkourLoseItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.index = arg_6_1
	self.parkour_activity_id = arg_6_2
	self.itemid = arg_6_3
	self.m_icon.sprite = ItemTools.getItemSprite(arg_6_3)

	self:UpdateState()
end

function HellaParkourLoseItem:UpdateState()
	if not table.indexof(ParkourData:GetParkCollect(self.parkour_activity_id), self.itemid) then
		self.stateController:SetSelectedIndex(2)
	elseif table.indexof(ParkourData:GetCollectRedList(self.parkour_activity_id), self.itemid) then
		self.stateController:SetSelectedIndex(1)
	else
		self.stateController:SetSelectedIndex(0)
	end
end

function HellaParkourLoseItem:RegistCallBack(arg_8_1)
	self.callback_ = arg_8_1
end

function HellaParkourLoseItem:SetSelectedIndex(arg_9_1)
	self.selectController:SetSelectedIndex(arg_9_1 == self.index and 1 or 0)
end

return HellaParkourLoseItem
