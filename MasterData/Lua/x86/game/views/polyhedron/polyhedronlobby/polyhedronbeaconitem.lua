local PolyhedronBeaconItem = class("PolyhedronBeaconItem", ReduxView)

function PolyhedronBeaconItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
	self:AddUIListener()
end

function PolyhedronBeaconItem:initUI()
	self:BindCfgUI()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
	self.maskController_ = ControllerUtil.GetController(self.transform_, "mask")
end

function PolyhedronBeaconItem:AddUIListener()
	self:AddBtnListener(self.m_clickBtn, nil, function()
		if self.clickFunc then
			self.clickFunc(self.id, self)
		end
	end)
end

function PolyhedronBeaconItem:SetData(arg_5_1)
	self.id = arg_5_1
	self.m_icon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.BEACON_ICON_PATH .. PolyhedronBeaconCfg[self.id].icon)
	self.m_name.text = GetI18NText(PolyhedronBeaconCfg[self.id].name)
	self.m_des.text = GetI18NText(PolyhedronBeaconCfg[self.id].desc)
end

function PolyhedronBeaconItem:SetChoice(arg_6_1)
	self.selectController_:SetSelectedIndex(arg_6_1 and 1 or 0)
end

function PolyhedronBeaconItem:SetMask(arg_7_1)
	self.maskController_:SetSelectedIndex(arg_7_1 and 1 or 0)
end

function PolyhedronBeaconItem:RegistCallBack(arg_8_1)
	self.clickFunc = arg_8_1
end

return PolyhedronBeaconItem
