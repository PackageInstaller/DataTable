local MatrixTerminalTalentItem = class("MatrixTerminalTalentItem", ReduxView)

function MatrixTerminalTalentItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:initUI()
	self:AddUIListener()
end

function MatrixTerminalTalentItem:initUI()
	self:BindCfgUI()

	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")
end

function MatrixTerminalTalentItem:AddUIListener()
	self:AddBtnListener(self.m_clickBtn, nil, function()
		if self.clickFunc then
			self.clickFunc(self.id, self)
		end
	end)
end

function MatrixTerminalTalentItem:Refresh(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self.id = arg_5_1

	self.selectController_:SetSelectedIndex(arg_5_1 == arg_5_3 and 1 or 0)
	self:RefreshData(arg_5_2, arg_5_4)
end

function MatrixTerminalTalentItem:RefreshData(arg_6_1, arg_6_2)
	if not self.id then
		return
	end

	local var_6_0 = arg_6_1[self.id] or 0
	local var_6_1 = MatrixTerminalGiftCfg[self.id]
	local var_6_2 = getSpriteWithoutAtlas("TextureConfig/MatrixItem/MatrixTerminal/" .. MatrixTerminalGiftCfg[self.id].icon)

	self.m_grayIcon.sprite = var_6_2
	self.m_icon.sprite = var_6_2

	if var_6_1.limit_level > MatrixData:GetTerminalLevel() or var_6_1.pre_id ~= 0 and (arg_6_1[var_6_1.pre_id] or 0) == 0 then
		self.stateController_:SetSelectedIndex(0)

		return
	end

	local var_6_3 = #var_6_1.effect_id_list

	if #var_6_1.effect_id_list <= var_6_0 then
		self.stateController_:SetSelectedIndex(2)

		self.m_levelLab.text = "MAX"
	else
		self.m_levelLab.text = var_6_0 .. "/" .. var_6_3

		self.stateController_:SetSelectedIndex(arg_6_2 < (var_6_1.cost[var_6_0 + 1] or 0) and 2 or 1)
	end
end

function MatrixTerminalTalentItem:RegistCallBack(arg_7_1)
	self.clickFunc = arg_7_1
end

function MatrixTerminalTalentItem:SetChoice(arg_8_1)
	self.selectController_:SetSelectedIndex(self.id == arg_8_1 and 1 or 0)
end

function MatrixTerminalTalentItem:SetScrollEnable(arg_9_1)
	self.m_scroll.enabled = arg_9_1
end

function MatrixTerminalTalentItem:Dispose()
	MatrixTerminalTalentItem.super.Dispose(self)
end

return MatrixTerminalTalentItem
