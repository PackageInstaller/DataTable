local HellaParkourEntrustItem = class("HellaParkourEntrustItem", ReduxView)

function HellaParkourEntrustItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HellaParkourEntrustItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function HellaParkourEntrustItem:InitUI()
	self:BindCfgUI()

	self.selectController = ControllerUtil.GetController(self.transform_, "select")
	self.lockController = ControllerUtil.GetController(self.transform_, "lock")
end

function HellaParkourEntrustItem:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		if self.callback_ then
			self.callback_(self.index)
		end
	end)
end

function HellaParkourEntrustItem:SetData(arg_6_1, arg_6_2)
	self.index = arg_6_1
	self.entrust_activity_id = arg_6_2
	self.m_name.text = GetI18NText(ActivityParkourCfg[arg_6_2].name)

	self:RefreshTime()

	local var_6_0 = ParkourData:GetParkourEntrustData(arg_6_2)

	for iter_6_0 = 1, 4 do
		if self["m_star" .. iter_6_0] then
			if var_6_0 then
				SetActive(self["m_star" .. iter_6_0], not not table.indexof(var_6_0.stars, iter_6_0))
			else
				SetActive(self["m_star" .. iter_6_0], false)
			end
		end
	end

	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_REWARD, arg_6_2))
end

function HellaParkourEntrustItem:RefreshTime()
	local var_7_0 = ActivityData:GetActivityData(self.entrust_activity_id)

	if var_7_0:IsActivitying() then
		self.lockController:SetSelectedIndex(0)
	else
		self.lockController:SetSelectedIndex(1)

		self.m_lockLab.text = manager.time:GetServerTime() >= var_7_0.stopTime and GetTips("TIME_OVER") or string.format(GetTips("SLAYER_TIME_TO_START"), manager.time:GetLostTimeStr(var_7_0.startTime))
	end
end

function HellaParkourEntrustItem:RegistCallBack(arg_8_1)
	self.callback_ = arg_8_1
end

function HellaParkourEntrustItem:SetSelectedIndex(arg_9_1)
	self.selectController:SetSelectedIndex(arg_9_1 == self.index and 1 or 0)
end

function HellaParkourEntrustItem:Dispose()
	manager.redPoint:unbindUIandKey(self.transform_)
	HellaParkourEntrustItem.super.Dispose(self)
end

return HellaParkourEntrustItem
