local DormFriendVisitModule = class("DormFriendVisitModule", ReduxView)

function DormFriendVisitModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function DormFriendVisitModule:InitBtnController(arg_2_1, arg_2_2)
	local var_2_0 = ControllerUtil.GetController(arg_2_1.transform, "name")

	self.btnControllers[arg_2_2] = var_2_0

	return var_2_0
end

function DormFriendVisitModule:SwitchBtnController(arg_3_1)
	for iter_3_0, iter_3_1 in pairs(self.btnControllers) do
		iter_3_1:SetSelectedState(arg_3_1 == iter_3_0 and "false" or "true")
	end
end

function DormFriendVisitModule:InitUI()
	self.isShowing = true

	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexTemplate), self.uilistGo_, DormVisitItem)
	self.danceShareList = LuaList.New(handler(self, self.RenderDanceDIYDataItem), self.danceList_.gameObject, DanceDIYDataItem)
	self.listController = self.controllers_:GetController("tab")
	self.btnControllers = {}
	self.danceBtnController = self:InitBtnController(self.danceBtn_, "dance")
	self.houseBtnController = self:InitBtnController(self.houseBtn_, "house")

	self:SwitchBtnController("house")
	self:AddDragListener(self.uilistGo_, function()
		return
	end, function()
		return
	end, function()
		if self.loadingGo_.transform.sizeDelta.y < -1 * self.contentGo_.transform.anchoredPosition.y then
			if not self.refreshFlag then
				ShowTips(GetTips("DORM_RECOMMEND_CD"))

				return
			else
				self.refreshFlag = false

				self.refreshTimer:Start()
				DormAction:AskFurTemplateExhibitList(self.groupID)
			end
		end
	end)
	self:AddBtnListener(self.danceBtn_, nil, function()
		self:SwitchMode("dance")
	end)
	self:AddBtnListener(self.houseBtn_, nil, function()
		self:SwitchMode("house")
	end)
end

function DormFriendVisitModule:Refresh(arg_10_1)
	if arg_10_1 then
		self:SwitchMode(arg_10_1, true)
	else
		self:RefreshList(true)
	end
end

function DormFriendVisitModule:SwitchMode(arg_11_1, arg_11_2)
	self.mode = arg_11_1

	DormVisitTools:SetListIndex(1, arg_11_1)
	self:SwitchBtnController(arg_11_1)
	self:RefreshList(arg_11_2)
end

function DormFriendVisitModule:Show()
	DormVisitTools:SetListIndex(1)

	if self.isShowing == false then
		self.isShowing = true

		SetActive(self.gameObject_, true)
	end
end

function DormFriendVisitModule:Hide()
	if self.isShowing == true then
		self.isShowing = false

		SetActive(self.gameObject_, false)
	end
end

function DormFriendVisitModule:RefreshList(arg_14_1)
	if self.mode == "dance" then
		self.listController:SetSelectedState("dance")
		IdolTraineeTools.FetchSharedDIY(arg_14_1, IdolTraineeConst.shareCategory.Friends, function(arg_15_0)
			self:RefreshDanceList(arg_15_0)
		end)
	else
		self.listController:SetSelectedState("dorm")

		self.visitList = {}

		local var_14_0 = DormVisitTools:GetTemplateExhibitList(1)

		if var_14_0 then
			for iter_14_0, iter_14_1 in pairs(var_14_0) do
				table.insert(self.visitList, iter_14_0)
			end

			self.scrollHelper_:StartScroll(#self.visitList)
		end
	end
end

function DormFriendVisitModule:RefreshDanceList(arg_16_1)
	arg_16_1 = arg_16_1 or {}
	self.cachedBriefList = arg_16_1

	self.danceShareList:StartScroll(#self.cachedBriefList)
end

function DormFriendVisitModule:indexTemplate(arg_17_1, arg_17_2)
	arg_17_2:RefreshUI(self.visitList[arg_17_1], 1)
	arg_17_2:RegisterEnterCallBack(function(arg_18_0)
		SDKTools.SendMessageToSDK("backhome_dorm_visit_jump", {
			backhome_source = 2
		})
		DormVisitTools:SetListIndex(1)
		DormAction:AskSingleFurTemplateExhibit(arg_18_0)
	end)
end

function DormFriendVisitModule:RenderDanceDIYDataItem(arg_19_1, arg_19_2)
	arg_19_2:SetData(self.cachedBriefList[arg_19_1], true)
	arg_19_2:SetDisplayName(self.cachedBriefList[arg_19_1].name)
	arg_19_2:SetSelected(false)
	arg_19_2:SetOnClick(IdolTraineeTools.ViewSharedDIY)
end

function DormFriendVisitModule:Dispose()
	self.scrollHelper_:Dispose()
	self.danceShareList:Dispose()
	DormFriendVisitModule.super.Dispose(self)
end

return DormFriendVisitModule
