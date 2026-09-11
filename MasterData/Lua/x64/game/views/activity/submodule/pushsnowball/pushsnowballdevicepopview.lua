local PushSnowBallDevicePopView = class("PushSnowBallDevicePopView", ReduxView)

function PushSnowBallDevicePopView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballDevicePopUI"
end

function PushSnowBallDevicePopView:UIParent()
	return manager.ui.uiPop.transform
end

function PushSnowBallDevicePopView:Init()
	self:InitUI()
	self:AddUIListener()

	self.refreshHandler_ = handler(self, function()
		self:RefreshUI()
	end)
end

function PushSnowBallDevicePopView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.deviceList_, PushSnowBallDeviceItem)
end

function PushSnowBallDevicePopView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function PushSnowBallDevicePopView:OnEnter()
	self:RefreshUI()
	manager.notify:RegistListener(PUSH_SNOWBALL_EQUIP_DEVICE, self.refreshHandler_)
end

function PushSnowBallDevicePopView:RefreshUI()
	self.deviceDataList_ = PushSnowBallDeviceCfg.all

	self.uiList_:StartScroll(#self.deviceDataList_)
end

function PushSnowBallDevicePopView:IndexItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(arg_10_1, self.deviceDataList_[arg_10_1])
end

function PushSnowBallDevicePopView:OnExit()
	manager.notify:RemoveListener(PUSH_SNOWBALL_EQUIP_DEVICE, self.refreshHandler_)
end

function PushSnowBallDevicePopView:Dispose()
	PushSnowBallDevicePopView.super.Dispose(self)

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end
end

return PushSnowBallDevicePopView
