local matrixBeaconOperateItem = class("matrixBeaconOperateItem", ReduxView)

function matrixBeaconOperateItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
	self:AddUIListener()
end

function matrixBeaconOperateItem:initUI()
	self:BindCfgUI()

	self.stateController_ = ControllerUtil.GetController(self.m_stateController, "state")
end

function matrixBeaconOperateItem:AddUIListener()
	self:AddBtnListener(self.m_unlockBtn, nil, function()
		MatrixAction.QueryUnlockBeacon(self.id)
	end)
end

function matrixBeaconOperateItem:Refresh(arg_5_1)
	self.id = arg_5_1
	self.transform_.name = arg_5_1

	self:UpdateView()
end

function matrixBeaconOperateItem:UpdateView()
	self.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/MatrixItem/MatrixArtifact/" .. MatrixBeaconCfg[self.id].icon)
	self.m_name.text = GetI18NText(MatrixBeaconCfg[self.id].name)
	self.m_des.text = GetI18NText(MatrixBeaconCfg[self.id].desc)

	if MatrixData:GetBeaconIsLock(self.id) then
		local var_6_0, var_6_1, var_6_2 = MatrixTools.GetBeaconIsUnlockCondition(self.id)

		if not var_6_0 then
			self.stateController_:SetSelectedIndex(0)

			var_6_1 = var_6_1 or 0
			var_6_2 = var_6_2 or 0
			self.m_processText.text = var_6_1 .. "/" .. var_6_2
			self.m_processImg.fillAmount = var_6_2 == 0 and 0 or var_6_1 / var_6_2
			self.m_lockTip.text = GetI18NText(ConditionCfg[MatrixBeaconCfg[self.id].new_condition].desc)
		else
			self.stateController_:SetSelectedIndex(2)
		end
	else
		self.stateController_:SetSelectedIndex(1)
	end
end

return matrixBeaconOperateItem
