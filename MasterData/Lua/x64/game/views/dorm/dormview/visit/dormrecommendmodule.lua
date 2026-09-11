local DormRecommendModule = class("DormRecommendModule", ReduxView)

function DormRecommendModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function DormRecommendModule:InitBtnController(arg_2_1, arg_2_2)
	local var_2_0 = ControllerUtil.GetController(arg_2_1.transform, "name")

	self.btnControllers[arg_2_2] = var_2_0

	return var_2_0
end

function DormRecommendModule:SwitchBtnController(arg_3_1)
	for iter_3_0, iter_3_1 in pairs(self.btnControllers) do
		iter_3_1:SetSelectedState(arg_3_1 == iter_3_0 and "false" or "true")
	end
end

function DormRecommendModule:InitUI()
	self.isShowing = true
	self.mode = "all"

	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexTemplate), self.uilistGo_, DormVisitPictureItem)
	self.danceShareList = LuaList.New(handler(self, self.RenderDanceDIYDataItem), self.danceList_.gameObject, DanceDIYDataItem)
	self.listController = self.controllers_:GetController("category")
	self.btnControllers = {}
	self.allBtnController = self:InitBtnController(self.allBtn_, "all")
	self.publicBtnController = self:InitBtnController(self.exBtn_, "public")
	self.privateBtnController = self:InitBtnController(self.innerBtn_, "private")
	self.danceBtnController = self:InitBtnController(self.danceBtn_, "dance")

	self:SwitchBtnController("all")
	self:AddListener()
end

function DormRecommendModule:Refresh(arg_5_1)
	if arg_5_1 then
		self:SwitchMode(arg_5_1, true)
	else
		self:RefreshList(true)
	end
end

function DormRecommendModule:SwitchMode(arg_6_1, arg_6_2)
	self.mode = arg_6_1

	DormVisitTools:SetListIndex(2, arg_6_1)
	self:SwitchBtnController(arg_6_1)
	self:RefreshList(arg_6_2)
end

function DormRecommendModule:AddListener()
	self:AddBtnListener(self.allBtn_, nil, function()
		self:OnAllBtnClick()
	end)
	self:AddBtnListener(self.exBtn_, nil, function()
		self:OnPublicBtnClick()
	end)
	self:AddBtnListener(self.innerBtn_, nil, function()
		self:OnPrivateBtnClick()
	end)
	self:AddBtnListener(self.danceBtn_, nil, function()
		self:OnDanceBtnClick()
	end)
	self:AddBtnListener(self.refreshBtn_, nil, function()
		self:OnRefreshBtnClick()
	end)
end

function DormRecommendModule:RefreshList(arg_13_1)
	if self.mode == "dance" then
		self.listController:SetSelectedState("dance")
		IdolTraineeTools.FetchSharedDIY(arg_13_1, IdolTraineeConst.shareCategory.Random, function(arg_14_0)
			self:RefreshDanceList(arg_14_0)
		end)
	else
		self.listController:SetSelectedState("house")

		self.fullVisitList = self.fullVisitList or {}
		self.visitList = {}

		if arg_13_1 then
			self.fullVisitList = {}

			local var_13_0 = DormVisitTools:GetTemplateExhibitList(2)

			if var_13_0 then
				for iter_13_0, iter_13_1 in pairs(var_13_0) do
					table.insert(self.fullVisitList, {
						id = iter_13_0,
						data = iter_13_1
					})
				end
			end
		end

		for iter_13_2, iter_13_3 in ipairs(self.fullVisitList) do
			if self.mode == "all" then
				table.insert(self.visitList, iter_13_3.id)
			elseif self.mode == "public" then
				if BackHomeCfg[iter_13_3.data.architecture_id].type == DormConst.BACKHOME_TYPE.PublicDorm then
					table.insert(self.visitList, iter_13_3.id)
				end
			elseif self.mode == "private" and BackHomeCfg[iter_13_3.data.architecture_id].type ~= DormConst.BACKHOME_TYPE.PublicDorm then
				table.insert(self.visitList, iter_13_3.id)
			end
		end

		self.scrollHelper_:StartScroll(#self.visitList)
	end
end

function DormRecommendModule:RefreshDanceList(arg_15_1)
	arg_15_1 = arg_15_1 or {}

	print(self.cachedBriefList, arg_15_1)

	self.cachedBriefList = arg_15_1

	self.danceShareList:StartScroll(#self.cachedBriefList)
end

function DormRecommendModule:indexTemplate(arg_16_1, arg_16_2)
	arg_16_2:RefreshUI(self.visitList[arg_16_1], 2)
end

function DormRecommendModule:RenderDanceDIYDataItem(arg_17_1, arg_17_2)
	arg_17_2:SetData(self.cachedBriefList[arg_17_1], true)
	arg_17_2:SetDisplayName(self.cachedBriefList[arg_17_1].name)
	arg_17_2:SetSelected(false)
	arg_17_2:SetOnClick(IdolTraineeTools.ViewSharedDIY)
end

function DormRecommendModule:OnAllBtnClick()
	self:SwitchMode("all")
end

function DormRecommendModule:OnPublicBtnClick()
	self:SwitchMode("public")
end

function DormRecommendModule:OnPrivateBtnClick()
	self:SwitchMode("private")
end

function DormRecommendModule:OnDanceBtnClick()
	self:SwitchMode("dance")
end

function DormRecommendModule:OnRefreshBtnClick()
	DormAction:AskFurTemplateExhibitList(2)
end

function DormRecommendModule:Show()
	DormVisitTools:SetListIndex(2)

	if self.isShowing == false then
		self.isShowing = true

		SetActive(self.gameObject_, true)
	end
end

function DormRecommendModule:Hide()
	if self.isShowing == true then
		self.isShowing = false

		SetActive(self.gameObject_, false)
	end
end

function DormRecommendModule:Dispose()
	self.scrollHelper_:Dispose()
	self.danceShareList:Dispose()
	DormRecommendModule.super.Dispose(self)
end

return DormRecommendModule
