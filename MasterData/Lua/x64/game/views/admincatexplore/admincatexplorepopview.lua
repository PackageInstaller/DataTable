local AdminCatExplorePopView = class("AdminCatExplorePopView", ReduxView)
local var_0_1 = {
	4,
	8,
	10,
	12,
	20
}

function AdminCatExplorePopView:UIName()
	return "Widget/System/ExploreUI/ExplpreInfoUI"
end

function AdminCatExplorePopView:UIParent()
	return manager.ui.uiPop.transform
end

function AdminCatExplorePopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AdminCatExplorePopView:InitUI()
	self:BindCfgUI()

	self.hourList = {}

	for iter_4_0, iter_4_1 in ipairs(var_0_1) do
		self.hourList[iter_4_1] = self["hour" .. iter_4_1 .. "_"]
	end

	self.rewardList = LuaList.New(handler(self, self.SetRewardItem), self.rewardList_, CommonItemView)
	self.adminCatList = LuaList.New(handler(self, self.SetAdminCatItem), self.adminCatList_, AdminCatExploreItem)
end

function AdminCatExplorePopView:SetRewardItem(arg_5_1, arg_5_2)
	CommonTools.SetCommonData(arg_5_2, {
		id = ExploreAreaCfg[self.regionId].reward[arg_5_1][1],
		clickFun = function(self)
			ShowPopItem(POP_OTHER_ITEM, {
				self.id
			})
		end
	})
end

function AdminCatExplorePopView:SetAdminCatItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(self.catList[arg_7_1], arg_7_1 == self.selectAdminCat, handler(self, self.AdminCatItemRegisterFunction), arg_7_1)

	self.adminCatItemList[arg_7_1] = arg_7_2
end

function AdminCatExplorePopView:AdminCatItemRegisterFunction(arg_8_1)
	if self.catList[arg_8_1] == nil or self.catList[arg_8_1].canUse == false then
		return
	end

	for iter_8_0 = 1, #self.catList do
		local var_8_0 = self.adminCatItemList[iter_8_0]:GetStateController()

		if var_8_0:GetSelectedState() ~= "lock" then
			var_8_0:SetSelectedState(iter_8_0 == arg_8_1 and "sel" or "normal")

			self.selectAdminCat = arg_8_1
		end
	end
end

function AdminCatExplorePopView:AddUIListener()
	self:AddBtnListener(self.exploreBtn_, nil, function()
		if not GuideData:IsFinish(513) then
			self:Back()

			return
		end

		if AdminCatExploreData:GetDataByPara("exploringCount") >= ExploreLevelCfg[AdminCatExploreData:GetDataByPara("level")].amount then
			ShowTips("EXPLORE_BEGIN_CONDITION_3")

			return
		end

		if self.catList[self.selectAdminCat].canUse == false then
			ShowTips("EXPLORE_MIMIR_NO_EXIST")

			return
		end

		AdminCatExploreAction.AdminCatExplore(self.catList[self.selectAdminCat].id, self.selectHour, self.regionId)
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)

	for iter_9_0, iter_9_1 in pairs(self.hourList) do
		self:AddBtnListener(iter_9_1, nil, function()
			self:SetHourState(iter_9_0)
		end)
	end
end

function AdminCatExplorePopView:SetData(arg_14_1, arg_14_2)
	self.data = arg_14_1
	self.index = arg_14_2
end

function AdminCatExplorePopView:SetHourState(arg_15_1)
	if arg_15_1 > self.maxExploreHour then
		return
	end

	for iter_15_0 = 4, self.maxExploreHour do
		if self.hourList[iter_15_0] then
			ControllerUtil.GetController(self.hourList[iter_15_0].transform, "name"):SetSelectedState(iter_15_0 == arg_15_1 and "sel" or "normal")

			self.selectHour = arg_15_1
		end
	end
end

function AdminCatExplorePopView:UpdateView()
	self.adminCatItemList = {}
	self.regionMapImage_.sprite = pureGetSpriteWithoutAtlas("TextureBg/ExploreUI/" .. ExploreAreaCfg[self.regionId].icon)
	self.regionNameTxt_.text = GetI18NText(ExploreAreaCfg[self.regionId].area_name)
	self.regionDescTxt_.text = GetI18NText(ExploreAreaCfg[self.regionId].description)
	self.catList = AdminCatExploreData:SortAdminCatList(self.regionId)

	self.adminCatList:StartScroll((#self.catList > 6 or nil) and (#self.catList or 6))
	self.rewardList:StartScroll(#ExploreAreaCfg[self.regionId].reward)
	AdminCatExploreData:CalculateMaxExploreHour()
end

function AdminCatExplorePopView:OnExploreUpdate()
	ShowTips("EXPLORE_BEGIN")
	self:Back()
end

function AdminCatExplorePopView:SetLockHour()
	for iter_18_0, iter_18_1 in ipairs(var_0_1) do
		local var_18_0 = ControllerUtil.GetController(self.hourList[iter_18_1].transform, "name")

		if iter_18_1 > self.maxExploreHour then
			var_18_0:SetSelectedState("lock")
		else
			var_18_0:SetSelectedState(iter_18_1 == self.maxExploreHour and "sel" or "normal")
		end
	end
end

function AdminCatExplorePopView:OnEnter()
	self.selectAdminCat = 1
	self.regionId = self.params_.regionId

	self:UpdateView()

	self.maxExploreHour = AdminCatExploreData:GetDataByPara("maxExploreHour")
	self.selectHour = self.maxExploreHour

	self:SetLockHour()
end

function AdminCatExplorePopView:OnExit()
	manager.windowBar:HideBar()

	for iter_20_0, iter_20_1 in ipairs(self.adminCatItemList) do
		iter_20_1:OnExit()
	end

	self.adminCatItemList = {}
end

function AdminCatExplorePopView:Dispose()
	if self.rewardList then
		self.rewardList:Dispose()

		self.rewardList = nil
	end

	if self.adminCatList then
		self.adminCatList:Dispose()

		self.adminCatList = nil
	end

	AdminCatExplorePopView.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.hourList = {}
end

return AdminCatExplorePopView
