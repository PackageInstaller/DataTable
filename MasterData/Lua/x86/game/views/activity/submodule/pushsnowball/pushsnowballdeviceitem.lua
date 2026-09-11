local PushSnowBallDeviceItem = class("PushSnowBallDeviceItem", ReduxView)

function PushSnowBallDeviceItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function PushSnowBallDeviceItem:Init()
	self:InitUI()
	self:AddListeners()

	self.lockController_ = ControllerUtil.GetController(self.transform_, "lock")
	self.equipController_ = ControllerUtil.GetController(self.equipBtn_.transform, "isEquipped")
end

function PushSnowBallDeviceItem:SetData(arg_3_1, arg_3_2)
	self.index_ = arg_3_1
	self.id_ = arg_3_2
	self.cfg_ = PushSnowBallDeviceCfg[arg_3_2]

	manager.redPoint:bindUIandKey(self.bgTrs_, RedPointConst.ACTIVITY_PUSH_SNOWBALL_DEVICE_UNLOCK .. self.index_)
	self:RefreshUI()
end

function PushSnowBallDeviceItem:InitUI()
	self:BindCfgUI()
end

function PushSnowBallDeviceItem:AddListeners()
	self:AddBtnListener(self.equipBtn_, nil, function()
		PushSnowBallAction:SendEquipDevice(PushSnowBallData:GetSingleActivityID(), self.index_ == PushSnowBallData:GetSelectedDeviceID() and 0 or self.id_)
		saveData("PushSnowBall", "Device" .. self.id_ .. PushSnowBallData:GetActivityID() .. PlayerData:GetPlayerInfo().userID, true)
		manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_SNOWBALL_DEVICE_UNLOCK .. self.id_, 0)
	end)
end

function PushSnowBallDeviceItem:OnExit()
	manager.redPoint:unbindUIandKey(self.bgTrs_, RedPointConst.ACTIVITY_PUSH_SNOWBALL_DEVICE_UNLOCK .. self.index_)
end

function PushSnowBallDeviceItem:RefreshUI()
	self:RefreshItem()
	self:RefreshState()
end

function PushSnowBallDeviceItem:RefreshItem()
	self.titleText_.text = self.cfg_.name
	self.descText_.text = self.cfg_.desc
	self.lockText_.text = ConditionCfg[self.cfg_.condition_id].desc
	self.powerSliderImg_.fillAmount = self.cfg_.power_star / 5
	self.agilitySliderImg_.fillAmount = self.cfg_.agile_star / 5
	self.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Item_l/" .. self.cfg_.icon)
end

function PushSnowBallDeviceItem:RefreshState()
	local var_10_0 = PushSnowBallData:GetIsDeviceUnlockByID(self.cfg_.id)

	if var_10_0 then
		self.lockController_:SetSelectedState("unlock")
	else
		self.lockController_:SetSelectedState("lock")
	end

	self.equipController_:SetSelectedState(tostring(self.index_ == PushSnowBallData:GetSelectedDeviceID() and var_10_0))
end

function PushSnowBallDeviceItem:Dispose()
	if self.itemList_ then
		self.itemList_:Dispose()

		self.itemList_ = nil
	end

	PushSnowBallDeviceItem.super.Dispose(self)
end

return PushSnowBallDeviceItem
