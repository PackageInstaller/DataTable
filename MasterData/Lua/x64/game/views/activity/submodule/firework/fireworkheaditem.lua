local FireWorkHeadItem = class("FireWorkHeadItem", ReduxView)

function FireWorkHeadItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function FireWorkHeadItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function FireWorkHeadItem:InitUI()
	self:BindCfgUI()

	self.selectController = ControllerUtil.GetController(self.transform_, "select")
	self.lockController = ControllerUtil.GetController(self.transform_, "lock")
	self.stateController = ControllerUtil.GetController(self.transform_, "state")
end

function FireWorkHeadItem:AddUIListener()
	self:AddBtnListener(nil, nil, function()
		if not ActivityTools.GetActivityIsOpenWithTip(self.id) then
			return
		end

		if self.callback_ then
			self.callback_(self.id)
		end
	end)
end

function FireWorkHeadItem:SetData(arg_6_1)
	self.id = arg_6_1
	self.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/EmptyDream/letter_role_title/role_small/" .. ActivityFireWorkCfg[arg_6_1].icon)

	self:RefrenTime()

	if FireWorkData:GetInvited(self.id) then
		self.stateController:SetSelectedIndex(1)
	else
		self.stateController:SetSelectedIndex(0)
	end

	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.FIRE_WORK, self.id))
end

function FireWorkHeadItem:OnExit()
	manager.redPoint:unbindUIandKey(self.transform_)
end

function FireWorkHeadItem:RefrenTime()
	if ActivityData:GetActivityIsOpen(self.id) then
		self.lockController:SetSelectedIndex(0)
	else
		self.lockController:SetSelectedIndex(1)

		local var_8_0 = ActivityData:GetActivityData(self.id)

		self.m_lockLab.text = var_8_0 and manager.time:GetServerTime() < var_8_0.startTime and string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_8_0.startTime)) or GetTips("TIME_OVER")
	end
end

function FireWorkHeadItem:UpdateSelect(arg_9_1)
	self.selectController:SetSelectedIndex(arg_9_1 == self.id and 1 or 0)
end

function FireWorkHeadItem:RegistCallBack(arg_10_1)
	self.callback_ = arg_10_1
end

function FireWorkHeadItem:Dispose()
	manager.redPoint:unbindUIandKey(self.transform_)
	FireWorkHeadItem.super.Dispose(self)
end

return FireWorkHeadItem
