local HellaSlayerItem = class("HellaSlayerItem", ReduxView)

function HellaSlayerItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HellaSlayerItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function HellaSlayerItem:InitUI()
	self:BindCfgUI()

	self.lineController = ControllerUtil.GetController(self.transform_, "line")
	self.stateController = ControllerUtil.GetController(self.m_regionTrans, "state")
	self.selectController = ControllerUtil.GetController(self.m_regionTrans, "select")
end

function HellaSlayerItem:AddUIListener()
	self:AddBtnListener(self.m_regionBtn, nil, function()
		if self.callback_ then
			self.callback_(self.index)
		end
	end)
end

function HellaSlayerItem:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self.slayer_activity_id = arg_6_2
	self.region_activity_id = arg_6_3
	self.index = arg_6_1

	if arg_6_1 == 1 then
		self.lineController:SetSelectedIndex(1)

		self.m_region.anchoredPosition = Vector3.New(0, -80, 0)
	elseif arg_6_1 % 2 == 0 then
		self.lineController:SetSelectedIndex(2)

		self.m_region.anchoredPosition = Vector3.New(0, 140, 0)
	elseif arg_6_1 % 2 == 1 then
		self.lineController:SetSelectedIndex(3)

		self.m_region.anchoredPosition = Vector3.New(0, -240, 0)
	else
		self.lineController:SetSelectedIndex(0)
	end

	if arg_6_4 then
		self.lineController:SetSelectedIndex(0)
	end

	self.m_name.text = GetI18NText(ActivitySlayerCfg[arg_6_3].name)
	self.m_maxPointLab.text = SlayerData:GetPoint(self.slayer_activity_id, self.region_activity_id)

	self:RefreshTime()
end

function HellaSlayerItem:RefreshTime()
	local var_7_0 = ActivityData:GetActivityData(self.region_activity_id)

	if var_7_0 and var_7_0:IsActivitying() then
		self.stateController:SetSelectedIndex(1)
	else
		self.stateController:SetSelectedIndex(0)

		self.m_countDownLab.text = manager.time:GetServerTime() >= var_7_0.stopTime and GetTips("TIME_OVER") or string.format(GetTips("SLAYER_TIME_TO_START"), manager.time:GetLostTimeStr(var_7_0.startTime))
	end
end

function HellaSlayerItem:SetSelectedIndex(arg_8_1)
	self.selectController:SetSelectedIndex(arg_8_1 == self.index and 1 or 0)
end

function HellaSlayerItem:RegistCallBack(arg_9_1)
	self.callback_ = arg_9_1
end

function HellaSlayerItem:Dispose()
	HellaSlayerItem.super.Dispose(self)
end

return HellaSlayerItem
