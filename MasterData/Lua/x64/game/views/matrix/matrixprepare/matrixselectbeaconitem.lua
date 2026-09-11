local MatrixSelectBeaconItem = class("MatrixSelectBeaconItem", ReduxView)

function MatrixSelectBeaconItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index = 0

	self:initUI()
	self:AddUIListener()
end

function MatrixSelectBeaconItem:initUI()
	self:BindCfgUI()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
	self.maskController_ = ControllerUtil.GetController(self.transform_, "mask")
end

function MatrixSelectBeaconItem:AddUIListener()
	self:AddBtnListener(self.m_clickBtn, nil, function()
		if self.clickFunc then
			self.clickFunc(self.id, self)
		end
	end)
end

function MatrixSelectBeaconItem:Refresh(arg_5_1)
	self.id = arg_5_1
	self.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/MatrixItem/MatrixArtifact/" .. MatrixBeaconCfg[self.id].icon)
	self.m_name.text = GetI18NText(MatrixBeaconCfg[self.id].name)
	self.m_des.text = GetI18NText(MatrixBeaconCfg[self.id].desc)
end

function MatrixSelectBeaconItem:SetChoice(arg_6_1)
	self.selectController_:SetSelectedIndex(arg_6_1 and 1 or 0)
end

function MatrixSelectBeaconItem:SetMask(arg_7_1)
	self.maskController_:SetSelectedIndex(arg_7_1 and 1 or 0)
end

function MatrixSelectBeaconItem:RegistCallBack(arg_8_1)
	self.clickFunc = arg_8_1
end

return MatrixSelectBeaconItem
