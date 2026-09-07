local BackYardDecorationFurniturePage = class("BackYardDecorationFurniturePage", import(".BackYardDecorationBasePage"))

BackYardDecorationFurniturePage.SELECTED_FURNITRUE = "BackYardDecorationFurniturePage:SELECTED_FURNITRUE"

local function var_0_1(arg_1_0)
	BackYardDecorationFurniturePage.PageTypeList = BackYardDecorationFurniturePage.PageTypeList or {
		0,
		1,
		7,
		2,
		3,
		4,
		5,
		6,
		8
	}

	return BackYardDecorationFurniturePage.PageTypeList[arg_1_0]
end

function BackYardDecorationFurniturePage:getUIName()
	return "BackYardDecorationFurniturePage"
end

function BackYardDecorationFurniturePage:OnFurnitureUpdated(arg_3_1)
	for iter_3_0, iter_3_1 in pairs(self.cards) do
		if iter_3_1.furniture:getConfig("id") == arg_3_1:getConfig("id") then
			local var_3_0, var_3_1 = self:GetPutCntByConfigId(self.dorm, arg_3_1:getConfig("id"))

			iter_3_1:Flush(arg_3_1, var_3_0, var_3_1)
		end
	end

	return
end

function BackYardDecorationFurniturePage:GetPutCntByConfigId(arg_4_1, arg_4_2)
	local var_4_0 = 0
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_1:GetThemeList()) do
		local var_4_2 = iter_4_1:GetSameFurnitureCnt(arg_4_2)

		var_4_0 = var_4_0 + var_4_2

		if var_4_2 > 0 then
			table.insert(var_4_1, iter_4_0)
		end
	end

	local var_4_3 = 0

	if #var_4_1 > 1 then
		var_4_3 = getProxy(DormProxy).floor
	elseif #var_4_1 == 1 then
		var_4_3 = var_4_1[1]
	end

	return var_4_0, var_4_3
end

function BackYardDecorationFurniturePage:OnDisplayList()
	self.displays = self:GetDisplays()

	self:SortDisplays()

	return
end

function BackYardDecorationFurniturePage:SortDisplays()
	if not self.contextData.filterPanel:GetLoaded() then
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in ipairs(self.displays) do
			var_6_0[iter_6_1.id] = iter_6_1:GetOwnCnt() <= self:GetPutCntByConfigId(self.dorm, iter_6_1.configId) and 0 or 1
		end

		local var_6_1 = self.orderMode

		table.sort(self.displays, function(arg_7_0, arg_7_1)
			local var_7_0 = var_6_0[arg_7_0.id]
			local var_7_1 = var_6_0[arg_7_1.id]

			if var_6_0[arg_7_0.id] == var_6_0[arg_7_1.id] then
				local var_7_2 = arg_7_0.newFlag and 1 or 0
				local var_7_3 = arg_7_1.newFlag and 1 or 0

				if (arg_7_0.newFlag and 1 or 0) == (arg_7_1.newFlag and 1 or 0) then
					if var_6_1 == BackYardDecorationFilterPanel.ORDER_MODE_ASC then
						return arg_7_0.id < arg_7_1.id
					elseif var_6_1 == BackYardDecorationFilterPanel.ORDER_MODE_DASC then
						return arg_7_0.id > arg_7_1.id
					end
				else
					return var_7_3 < var_7_2
				end
			else
				return var_7_0 < var_7_1
			end

			return
		end)
		self:SetTotalCount()
	else
		self.contextData.filterPanel:setFilterData(self:GetDisplays())
		self.contextData.filterPanel:filter()
		self:OnFilterDone((self.contextData.filterPanel:GetFilterData()))
	end

	return
end

function BackYardDecorationFurniturePage:OnOrderModeUpdated()
	self:SortDisplays()

	return
end

function BackYardDecorationFurniturePage:change2ScrPos(arg_9_1)
	return (LuaHelper.ScreenToLocal(self:GetComponent("RectTransform"), arg_9_1, (GameObject.Find("UICamera"):GetComponent("Camera"))))
end

function BackYardDecorationFurniturePage:OnLoaded()
	self:bind(BackYardDecorationPutlistPage.SELECTED_FURNITRUE, function()
		self:ClearMark()

		return
	end)
	self:bind(BackYardDecrationLayer.INNER_SELECTED_FURNITRUE, function(arg_12_0, arg_12_1)
		self:Selected(arg_12_1)

		return
	end)

	self.scrollRect = self._tf:GetComponent("LScrollRect")

	local function var_10_0()
		if self.timer then
			self.timer:Stop()

			self.timer = nil
		end

		return
	end

	local function var_10_1(arg_14_0)
		self.timer = Timer.New(arg_14_0, 0.8, 1)

		self.timer:Start()

		return
	end

	local function var_10_2(arg_15_0)
		local var_15_0 = BackYardDecorationFurniturePage.change2ScrPos(self._tf:Find("content"), arg_15_0.position)
		local var_15_1

		for iter_15_0, iter_15_1 in pairs(self.cards) do
			local var_15_2 = Vector2(iter_15_1._tf.localPosition.x + iter_15_1._bg.rect.width / 2, iter_15_1._tf.localPosition.y + iter_15_1._bg.rect.height / 2)
			local var_15_3 = Vector2(iter_15_1._tf.localPosition.x + iter_15_1._bg.rect.width / 2, iter_15_1._tf.localPosition.y - iter_15_1._bg.rect.height / 2)

			if var_15_0.x > Vector2(iter_15_1._tf.localPosition.x - iter_15_1._bg.rect.width / 2, iter_15_1._tf.localPosition.y - iter_15_1._bg.rect.height / 2).x and var_15_0.x < var_15_3.x and var_15_0.y > var_15_3.y and var_15_0.y < var_15_2.y then
				var_15_1 = iter_15_1

				break
			end
		end

		return var_15_1
	end

	local var_10_3 = GetOrAddComponent(self._tf, typeof(EventTriggerListener))

	var_10_3:AddPointDownFunc(function(arg_16_0, arg_16_1)
		self.downPosition = arg_16_1.position

		local var_16_0 = var_10_2(arg_16_1)

		if var_16_0 then
			var_10_0()
			var_10_1(function()
				self.lock = true

				self.contextData.furnitureDescMsgBox:ExecuteAction("SetUp", var_16_0.furniture, var_16_0._tf.position)

				return
			end)
		end

		return
	end)
	var_10_3:AddPointUpFunc(function(arg_18_0, arg_18_1)
		var_10_0()

		if self.lock then
			self.contextData.furnitureDescMsgBox:ExecuteAction("Hide")
			onNextTick(function()
				self.lock = false

				return
			end)
		else
			if Vector2.Distance(arg_18_1.position, self.downPosition) > 1 then
				return
			end

			local var_18_0 = var_10_2(arg_18_1)

			if var_18_0 and var_18_0:HasMask() and var_18_0.furniture:isPaper() then
				self:emit(BackYardDecorationMediator.REMOVE_PAPER, var_18_0.furniture)
			elseif var_18_0 and not var_18_0:HasMask() then
				self:emit(BackYardDecorationMediator.ADD_FURNITURE, (Clone(var_18_0.furniture)))
			elseif var_18_0 and var_18_0:HasMask() then
				self:ClearMark()

				self.selectedId = var_18_0.furniture.id

				var_18_0:UpdateMark(self.selectedId)
				self:emit(BackYardDecorationMediator.ON_SELECTED_FURNITRUE, var_18_0.furniture.id)
				self:emit(BackYardDecorationFurniturePage.SELECTED_FURNITRUE)
			end
		end

		return
	end)

	return
end

function BackYardDecorationFurniturePage:ClearMark()
	for iter_20_0, iter_20_1 in pairs(self.cards) do
		iter_20_1:UpdateMark(-1)
	end

	self.selectedId = nil

	return
end

function BackYardDecorationFurniturePage:Selected(arg_21_1)
	self:ClearMark()

	for iter_21_0, iter_21_1 in pairs(self.cards) do
		if iter_21_1.furniture.id == arg_21_1 then
			iter_21_1:UpdateMark(arg_21_1)
		end
	end

	self.selectedId = arg_21_1

	return
end

function BackYardDecorationFurniturePage:OnInitItem(arg_22_1)
	self.cards[arg_22_1] = BackYardDecorationCard.New(arg_22_1)

	return
end

function BackYardDecorationFurniturePage:OnUpdateItem(arg_23_1, arg_23_2)
	local var_23_0 = self.cards[arg_23_2]

	if not self.cards[arg_23_2] then
		self:OnInitItem(arg_23_2)

		var_23_0 = self.cards[arg_23_2]
	end

	local var_23_1 = self.lastDiaplys[arg_23_1 + 1]

	if not self.lastDiaplys[arg_23_1 + 1] then
		return
	end

	local var_23_2, var_23_3 = self:GetPutCntByConfigId(self.dorm, var_23_1:getConfig("id"))

	var_23_0:Update(var_23_1, var_23_2, var_23_3, self.selectedId or -1)
	var_23_0:PlayEnterAnimation()

	return
end

function BackYardDecorationFurniturePage:GetDisplays()
	local var_24_0 = {}
	local var_24_1 = self.dorm:GetPurchasedFurnitures()

	for iter_24_0, iter_24_1 in ipairs(pg.furniture_data_template.get_id_list_by_tag[var_0_1(self.pageType)] or {}) do
		if var_24_1[iter_24_1] then
			table.insert(var_24_0, var_24_1[iter_24_1])
		end
	end

	return var_24_0
end

function BackYardDecorationFurniturePage:OnFilterDone(arg_25_1)
	self.displays = arg_25_1

	self:SetTotalCount()

	return
end

function BackYardDecorationFurniturePage:SetTotalCount()
	if not self.searchKey or self.searchKey == "" then
		self.lastDiaplys = self.displays
	else
		self.lastDiaplys = {}

		for iter_26_0, iter_26_1 in ipairs(self.displays) do
			if iter_26_1:isMatchSearchKey(self.searchKey) then
				table.insert(self.lastDiaplys, iter_26_1)
			end
		end
	end

	self.scrollRect.enabled = true

	self.scrollRect:SetTotalCount(#self.lastDiaplys)

	return
end

function BackYardDecorationFurniturePage:OnSearchKeyChanged()
	self:SetTotalCount()

	return
end

function BackYardDecorationFurniturePage:OnDestroy()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	for iter_28_0, iter_28_1 in pairs(self.cards or {}) do
		iter_28_1:Dispose()
	end

	self.cards = nil

	return
end

return BackYardDecorationFurniturePage
