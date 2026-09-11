local AdminCatExploreMainView = class("AdminCatExploreMainView", ReduxView)

function AdminCatExploreMainView:UIName()
	return "Widget/System/ExploreUI/ExploreHome"
end

function AdminCatExploreMainView:UIParent()
	return manager.ui.uiMain.transform
end

function AdminCatExploreMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AdminCatExploreMainView:InitUI()
	self:BindCfgUI()

	self.itemViewList = {}
end

function AdminCatExploreMainView:AddUIListener()
	self:AddBtnListener(self.cultureBtn_, nil, function()
		JumpTools.GoToSystem("/adminCatExploreCatCultivate", {})
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.GoToSystem("adminCatExploreReward", {})
	end)
	self:AddBtnListener(self.dispathBtn_, nil, function()
		local var_8_0 = {}
		local var_8_1 = {}
		local var_8_2 = {}

		AdminCatExploreData:CalculateMaxExploreHour()

		self.maxExploreHour = AdminCatExploreData:GetDataByPara("maxExploreHour")
		self.regionData = AdminCatExploreData:GetDataByPara("regionData")
		self.regionUnlockLevel = AdminCatExploreData:GetDataByPara("regionUnlockLevel")

		for iter_8_0, iter_8_1 in ipairs(ExploreAreaCfg.all) do
			if self.regionData[iter_8_1] == nil and (self.regionUnlockLevel[iter_8_1] == nil or self.level >= self.regionUnlockLevel[iter_8_1]) then
				table.insert(var_8_2, iter_8_1)
			end
		end

		for iter_8_2, iter_8_3 in pairs(var_8_2) do
			local var_8_3 = AdminCatExploreData:SortAdminCatList(iter_8_3)

			if var_8_3[1].canUse and var_8_3[1].recommend then
				var_8_0[iter_8_3] = var_8_3[1].id
				var_8_1[var_8_3[1].id] = iter_8_3
			end
		end

		local var_8_4 = {}

		for iter_8_4, iter_8_5 in ipairs(var_8_2) do
			if var_8_0[iter_8_5] then
				table.insert(var_8_4, {
					area = var_8_0[iter_8_5],
					id = iter_8_5,
					hour = self.maxExploreHour
				})
			else
				for iter_8_6, iter_8_7 in ipairs(AdminCatExploreData:SortAdminCatList(iter_8_5)) do
					if var_8_1[iter_8_7.id] == nil and iter_8_7.canUse then
						table.insert(var_8_4, {
							area = iter_8_5,
							id = iter_8_7.id,
							hour = self.maxExploreHour
						})

						var_8_1[iter_8_7.id] = iter_8_5
					end
				end
			end
		end

		if #var_8_4 == 0 then
			return
		end

		SetActive(self.dispathBtn_.gameObject, false)
		OperationRecorder.RecordButtonTouch("explore_meow_start_onekey")
		AdminCatExploreAction.AdminCatExploreAllExplore(var_8_4, 1)
	end)
	self:AddBtnListener(self.getBtn_, nil, function()
		local var_9_0 = {}

		self.regionData = AdminCatExploreData:GetDataByPara("regionData")

		for iter_9_0, iter_9_1 in pairs(self.regionData) do
			if iter_9_1.stopTime <= manager.time:GetServerTime() then
				table.insert(var_9_0, iter_9_0)
			end
		end

		if #var_9_0 == 0 then
			return
		end

		table.sort(var_9_0, function(arg_10_0, arg_10_1)
			return arg_10_0 < arg_10_1
		end)
		AdminCatExploreAction.AdminCatExploreAllFinish(var_9_0, 1)
		OperationRecorder.RecordButtonTouch("explore_meow_finish_onekey")
	end)
	self:AddBtnListener(self.storeBtn_, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.ADMIN_CAT_SHOP,
			showShops = {
				ShopConst.SHOP_ID.ADMIN_CAT_SHOP
			}
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
end

function AdminCatExploreMainView:UpdateBar()
	return
end

function AdminCatExploreMainView:UpdateView()
	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	SetActive(self.getBtn_.gameObject, false)

	for iter_13_0 = 1, 5 do
		if self.itemViewList[iter_13_0] == nil then
			self.itemViewList[iter_13_0] = AdminCatExploreRegionItem:New(self["regionItem" .. iter_13_0 .. "_"])
		end

		self.itemViewList[iter_13_0]:SetData(self.getBtn_.gameObject, iter_13_0)
		self.itemViewList[iter_13_0]:OnEnter()
	end

	self.level = AdminCatExploreData:GetDataByPara("level")
	self.exploreLevelImg_.sprite = pureGetSpriteWithoutAtlas("TextureBg/ExploreUI/icon_" .. self.level)

	local var_13_0 = ExploreLevelCfg[self.level]
	local var_13_1 = AdminCatExploreData:GetDataByPara("exp")
	local var_13_2 = AdminCatExploreData:GetDataByPara("maxLevel")
	local var_13_3 = AdminCatExploreData:GetDataByPara("exploringCount")

	self.queueTxt_.text = var_13_3 .. "/" .. ExploreLevelCfg[self.level].amount
	self.expImage_.fillAmount = var_13_2 == self.level and 1 or var_13_1 / var_13_0.exp
	self.exploreDay = AdminCatExploreData:GetDataByPara("exploreDay")
	self.exportFill_.fillAmount = self.exploreDay / 7
	self.rateTxt_.text = "x" .. AdminCatExploreData:GetDataByPara("rate")[self.exploreDay]
	self.expTxt_.text = var_13_2 == self.level and "0/0" or var_13_1 .. "/" .. var_13_0.exp
	self.unlockAdminCat = AdminCatExploreData:GetDataByPara("unlockAdminCat")

	local var_13_4 = 0

	for iter_13_1, iter_13_2 in pairs(self.unlockAdminCat) do
		var_13_4 = var_13_4 + 1
	end

	SetActive(self.dispathBtn_.gameObject, var_13_3 ~= var_13_4)

	self.updateTimer_ = Timer.New(function()
		AdminCatExploreData:UpdateRegionRedPoint()
	end, 1, -1, 1)

	self.updateTimer_:Start()
end

function AdminCatExploreMainView:OnGetWeeklyReward()
	self:UpdateView()
end

function AdminCatExploreMainView:OnEnter()
	if AdminCatExploreData:GetDataByPara("isFirstOpen") == 0 and GuideData:IsFinish(513) then
		JumpTools.OpenPageByJump("adminCatExploreFirstPop", {})
		AdminCatExploreAction.WeeklyFirstOpen()
	end

	manager.ui.cameraExtension.uiFov = 2

	self:UpdateView()
	self:BindRedPoint()
	AdminCatExploreData:UpdateQueueRedPoint()
end

function AdminCatExploreMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.EXPLORE_REWARD, {
		x = 70,
		y = 70
	})
	manager.redPoint:bindUIandKey(self.cultureBtn_.transform, RedPointConst.EXPLORE_UNLOCK_ADMIN_CAT, {
		x = 155,
		y = 60
	})
end

function AdminCatExploreMainView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.EXPLORE_REWARD)
	manager.redPoint:unbindUIandKey(self.cultureBtn_.transform, RedPointConst.EXPLORE_UNLOCK_ADMIN_CAT)
end

function AdminCatExploreMainView:OnExploreUpdate()
	self:UpdateView()
end

function AdminCatExploreMainView:OnExit()
	self:UnbindRedPoint()

	manager.ui.cameraExtension.uiFov = 30

	if self.itemViewList then
		for iter_20_0, iter_20_1 in pairs(self.itemViewList) do
			iter_20_1:OnExit()
		end
	end

	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	manager.windowBar:HideBar()
end

function AdminCatExploreMainView:Hide()
	SetActive(self.gameObject_, false)
end

function AdminCatExploreMainView:Show()
	SetActive(self.gameObject_, true)
end

function AdminCatExploreMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		NAVI_BAR,
		54,
		55,
		56
	})
	manager.windowBar:SetBarCanClick(54, true)
	manager.windowBar:SetBarCanClick(55, true)
	manager.windowBar:SetBarCanClick(56, true)
	manager.windowBar:SetGameHelpKey("EXPLORE_EXPLAIN")
end

function AdminCatExploreMainView:Dispose()
	if self.itemViewList then
		for iter_24_0, iter_24_1 in pairs(self.itemViewList) do
			iter_24_1:Dispose()
		end

		self.itemViewList = nil
	end

	AdminCatExploreMainView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return AdminCatExploreMainView
