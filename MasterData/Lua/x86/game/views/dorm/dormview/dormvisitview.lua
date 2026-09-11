local DormVisitView = class("DormVisitView", ReduxView)

function DormVisitView:UIName()
	return "Widget/BackHouseUI/Dorm/DormVisitUI"
end

function DormVisitView:UIParent()
	return manager.ui.uiMain.transform
end

function DormVisitView:BuildContext()
	self.page = {
		{
			obj = self.friendObj_,
			module = DormFriendVisitModule
		},
		{
			obj = self.recommendObj_,
			module = DormRecommendModule
		},
		{
			obj = self.praiseObj_,
			module = DormMypraiseModule
		}
	}
end

function DormVisitView:GetPageInst(arg_4_1, arg_4_2)
	local var_4_0 = self.page[arg_4_1]
	local var_4_1

	if self.page[arg_4_1].entity == nil then
		var_4_0.entity = var_4_0.module.New((Object.Instantiate(var_4_0.obj, self.contentRoot_.transform)))
		var_4_1 = true
	end

	if var_4_1 or arg_4_2 then
		if arg_4_1 == self.groupID then
			var_4_0.entity:Show()
		else
			var_4_0.entity:Hide()
		end
	end

	return var_4_0.entity
end

function DormVisitView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormVisitView:InitUI()
	self:BindCfgUI()
	self:BuildContext()
end

function DormVisitView:OnEnter()
	self.enterType = self.params_.enterType
	self.back = self.params_.back or nil

	self:RegisterEvents()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if self.back == "chooseRoom" then
			JumpTools.OpenPageByJump("/dormChooseRoomView")

			return
		elseif self.back == "back" then
			JumpTools.Back()

			return
		end

		local var_8_0 = BackHomeDataManager:GetCurSystem()

		if var_8_0 == DormEnum.DormSystemType.Canteen then
			JumpTools.OpenPageByJump("/restaurantMain")
		elseif var_8_0 == DormEnum.DormSystemType.Dormitory then
			if self.enterType == "quick" then
				JumpTools.OpenPageByJump("/dorm")
			else
				JumpTools.OpenPageByJump("/dormChooseRoomView")
			end
		elseif var_8_0 == DormEnum.DormSystemType.Main then
			JumpTools.OpenPageByJump("/dormChooseRoomView")
		elseif var_8_0 == DormEnum.DormSystemType.CricketBattle then
			JumpTools.OpenPageByJump("/idolTraineeCamp")
		end
	end)

	local var_7_0 = 3
	local var_7_1

	if DormVisitTools:GetListIndex() then
		var_7_0 = DormVisitTools:GetListIndex().index
		var_7_1 = DormVisitTools:GetListIndex().subIndex
	end

	self:SelGroup(self.groupID or var_7_0, var_7_1)
end

function DormVisitView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()

	self.enterType = nil
end

function DormVisitView:AddUIListener()
	for iter_10_0 = 1, 3 do
		self:AddToggleListener(self["tog_" .. iter_10_0], function(arg_11_0)
			if arg_11_0 then
				self:SelGroup(iter_10_0)
			end
		end)
	end
end

function DormVisitView:SelGroup(arg_12_1, arg_12_2)
	if self.groupID ~= arg_12_1 then
		self.groupID = arg_12_1
		self["tog_" .. self.groupID].isOn = true

		for iter_12_0 = 1, 3 do
			local var_12_0 = self:GetPageInst(iter_12_0, true)
		end
	end

	self:RefreshView(arg_12_2)
end

function DormVisitView:RefreshView(arg_13_1)
	self:GetPageInst(self.groupID):Refresh(arg_13_1)
end

function DormVisitView:RegisterEvents()
	self:RegistEventListener(DORM_REFRESH_TEMPLATE_EXHI, function(arg_15_0, arg_15_1)
		self.page[3].entity:Refresh()
	end)
end

function DormVisitView:Dispose()
	for iter_16_0 = 1, 3 do
		if self.page[iter_16_0].entity then
			self.page[iter_16_0].entity:Dispose()

			self.page[iter_16_0].entity = nil
		end
	end

	DormVisitView.super.Dispose(self)
end

return DormVisitView
