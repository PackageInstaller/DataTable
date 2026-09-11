local VolumeSlayerItem = class("VolumeSlayerItem", ReduxView)

function VolumeSlayerItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function VolumeSlayerItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function VolumeSlayerItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "lock")
	self.selectController = ControllerUtil.GetController(self.transform_, "select")
	self.scoreController = ControllerUtil.GetController(self.transform_, "score")
end

function VolumeSlayerItem:AddUIListener()
	self:AddBtnListener(self.m_regionBtn, nil, function()
		if self.callback_ then
			self.callback_(self.index)
		end
	end)
end

function VolumeSlayerItem:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self:BindRedPoint(arg_6_3)

	self.slayer_activity_id = arg_6_2
	self.region_activity_id = arg_6_3
	self.index = arg_6_1
	self.m_name.text = GetI18NText(ActivitySlayerCfg[arg_6_3].name)

	local var_6_0 = SlayerData:GetPoint(self.slayer_activity_id, self.region_activity_id)

	self.m_maxPointLab.text = var_6_0

	if var_6_0 == 0 then
		self.scoreController:SetSelectedIndex(0)
	else
		self.scoreController:SetSelectedIndex(1)
	end

	self:RefreshTime()
end

function VolumeSlayerItem:RefreshTime()
	local var_7_0 = ActivityData:GetActivityData(self.region_activity_id)

	if var_7_0 and var_7_0:IsActivitying() then
		self.stateController:SetSelectedIndex(0)
	else
		self.stateController:SetSelectedIndex(1)

		self.m_countDownLab.text = manager.time:GetServerTime() >= var_7_0.stopTime and GetTips("TIME_OVER") or string.format(GetTips("SLAYER_TIME_TO_START"), manager.time:GetLostTimeStr(var_7_0.startTime))
	end
end

function VolumeSlayerItem:SetSelectedIndex(arg_8_1)
	self.selectController:SetSelectedIndex(arg_8_1 == self.index and 1 or 0)
end

function VolumeSlayerItem:RegistCallBack(arg_9_1)
	self.callback_ = arg_9_1
end

function VolumeSlayerItem:Dispose()
	self:UnbindRedPoint()
	VolumeSlayerItem.super.Dispose(self)
end

function VolumeSlayerItem:BindRedPoint(arg_11_1)
	if self.region_activity_id == nil then
		manager.redPoint:bindUIandKey(self.transform_, (string.format("%s_%s", RedPointConst.SLYAER_REGIONS, arg_11_1)))
	elseif self.region_activity_id ~= arg_11_1 then
		manager.redPoint:unbindUIandKey(self.transform_, (string.format("%s_%s", RedPointConst.SLYAER_REGIONS, self.region_activity_id)))
		manager.redPoint:bindUIandKey(self.transform_, (string.format("%s_%s", RedPointConst.SLYAER_REGIONS, arg_11_1)))
	end
end

function VolumeSlayerItem:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.transform_, (string.format("%s_%s", RedPointConst.SLYAER_REGIONS, self.region_activity_id)))
end

return VolumeSlayerItem
