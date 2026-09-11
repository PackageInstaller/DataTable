local PolyhedronBeaconOperateItem = class("PolyhedronBeaconOperateItem", ReduxView)

function PolyhedronBeaconOperateItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
	self:AddUIListener()
end

function PolyhedronBeaconOperateItem:initUI()
	self:BindCfgUI()

	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")
end

function PolyhedronBeaconOperateItem:AddUIListener()
	self:AddBtnListener(self.m_unlockBtn, nil, function()
		PolyhedronAction.QueryUnlockBeacon(self.id)
	end)
end

function PolyhedronBeaconOperateItem:SetData(arg_5_1)
	self.id = arg_5_1
	self.transform_.name = arg_5_1

	self:Refresh()
end

function PolyhedronBeaconOperateItem:Refresh()
	self.m_icon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.BEACON_ICON_PATH .. PolyhedronBeaconCfg[self.id].icon)
	self.m_name.text = GetI18NText(PolyhedronBeaconCfg[self.id].name)
	self.m_des.text = GetI18NText(PolyhedronBeaconCfg[self.id].desc)

	if PolyhedronData:GetBeaconIsLock(self.id) then
		local var_6_0, var_6_1, var_6_2 = PolyhedronTools.GetBeaconIsUnlockCondition(self.id)

		if not var_6_0 then
			self.stateController_:SetSelectedIndex(1)

			var_6_1 = var_6_1 or 0
			var_6_2 = var_6_2 or 0
			self.m_processText.text = var_6_1 .. "/" .. var_6_2
			self.m_processImg.fillAmount = var_6_2 == 0 and 0 or var_6_1 / var_6_2
			self.m_lockTip.text = GetI18NText(ConditionCfg[PolyhedronBeaconCfg[self.id].condition].desc)
		else
			self.stateController_:SetSelectedIndex(2)
		end
	else
		self.stateController_:SetSelectedIndex(0)
	end
end

return PolyhedronBeaconOperateItem
