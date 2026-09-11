local BackHomeEnterView = class("BackHomeEnterView", ReduxView)

function BackHomeEnterView:UIName()
	return "UI/BackHouseUI/BackHouseUI"
end

function BackHomeEnterView:UIParent()
	return manager.ui.uiMain.transform
end

function BackHomeEnterView:OnCtor()
	return
end

function BackHomeEnterView:Init()
	self:InitUI()
	self:AddUIListener()
end

function BackHomeEnterView:InitUI()
	self:BindCfgUI()
end

function BackHomeEnterView:AddUIListener()
	self:AddBtnListenerScale(self.canteenBtn_, nil, function()
		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.Canteen then
			CanteenTools:SwitchCanteenBgm(DormEnum.RestaurantMode.Start)
			JumpTools.OpenPageByJump("/restaurantMain")
		else
			BackHomeTools:GotoBackHomeRoom(DormConst.CANTEEN_ID)
		end
	end)
	self:AddBtnListenerScale(self.dormBtn_, nil, function()
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	end)
	self:AddBtnListenerScale(self.lockBtn_, nil, function()
		return
	end)
end

function BackHomeEnterView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.Main then
			JumpTools.OpenPageByJump("/home")
		else
			BackHomeTools:BackHomeGotoMain()
		end
	end)
	manager.windowBar:RegistHomeCallBack(function()
		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.Main then
			JumpTools.OpenPageByJump("/home")
		else
			BackHomeTools:BackHomeGotoMain()
		end
	end)
	manager.redPoint:bindUIandKey(self.dormBtn_.transform, RedPointConst.DORM)
	manager.redPoint:bindUIandKey(self.canteenBtn_.transform, RedPointConst.CANTEEN)
end

function BackHomeEnterView:OnExit()
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(self.dormBtn_.transform, RedPointConst.DORM)
	manager.redPoint:unbindUIandKey(self.canteenBtn_.transform, RedPointConst.CANTEEN)
end

function BackHomeEnterView:Dispose()
	BackHomeEnterView.super.Dispose(self)
end

return BackHomeEnterView
