local IslandSceneMgr = class("IslandSceneMgr")
local var_0_1 = false
local var_0_2 = 1
local var_0_3 = 2

IslandSceneMgr.NEED_LONDING_PAGE_LIST = {
	"IslandCheaterTavernPrepareMainPage"
}

function IslandSceneMgr:Ctor(arg_1_1)
	self.scene = arg_1_1
	self.capacity = 2
	self.stack = {}
	self.noStatePages = {}
	self.pages = {}
	self.subPages = {}
	self.state = var_0_2
	self.gcCnt = 0

	return
end

function IslandSceneMgr:OpenPage(arg_2_1, arg_2_2, ...)
	local var_2_0 = packEx(...)

	if self:IsSceneType(arg_2_1) then
		local var_2_1 = self:CreateScenePage(arg_2_2)

		self:CheckOverflowAndDestory(var_2_1)

		if self:IsNeedLoadingPage(arg_2_2) then
			pg.SceneAnimMgr.GetInstance():CommonSceneChange("Dorm3DLoading", function(arg_3_0)
				self:ClosePrevScenePage(function()
					self:Record(IslandSceneContext.New(arg_2_2, unpackEx(var_2_0)), true)
					self:StartPage(var_2_1, var_2_0)
					arg_3_0()

					return
				end)

				return
			end)
		else
			self:ClosePrevScenePage(function()
				self:Record(IslandSceneContext.New(arg_2_2, unpackEx(var_2_0)), true)
				self:StartPage(var_2_1, var_2_0)

				return
			end)
		end

		return var_2_1
	else
		local var_2_2 = self:CreateSubPage(arg_2_1, arg_2_2)
		local var_2_3, var_2_4 = self:GetContext(arg_2_1)

		assert(var_2_3, arg_2_1.__cname)
		var_2_3:AddSubPage(arg_2_2, var_2_4, arg_2_1.__cname, ...)
		self:StartPage(var_2_2, var_2_0)
		self.scene:emit(ISLAND_EVT.SUB_PAGE_OPEN, arg_2_2.__cname)

		return var_2_2
	end

	return
end

function IslandSceneMgr:IsNeedLoadingPage(arg_6_1)
	return table.keyof(IslandSceneMgr.NEED_LONDING_PAGE_LIST, arg_6_1.__cname)
end

function IslandSceneMgr:GetContext(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(self.stack) do
		if iter_7_1.class.__cname == arg_7_1.__cname then
			return iter_7_1, #iter_7_1:GetSubPages()
		end
	end

	for iter_7_2, iter_7_3 in ipairs(self.stack) do
		local var_7_0 = _.detect(iter_7_3:GetSubPages(), function(arg_8_0)
			return arg_8_0.class.__cname == arg_7_1.__cname
		end)

		if var_7_0 then
			local var_7_2 = var_7_0:GetLevel()

			return
		end
	end

	return nil
end

function IslandSceneMgr:GetPage(arg_9_1)
	return _.detect(self.pages, function(arg_10_0)
		return arg_10_0.__cname == arg_9_1.__cname
	end) or _.detect(self.noStatePages, function(arg_11_0)
		return arg_11_0.__cname == arg_9_1.__cname
	end)
end

function IslandSceneMgr:GetSubPage(arg_12_1)
	return (_.detect(self.subPages, function(arg_13_0)
		return arg_13_0.__cname == arg_12_1.__cname
	end))
end

function IslandSceneMgr:StartPage(arg_14_1, arg_14_2)
	seriesAsync({
		function(arg_15_0)
			arg_14_1:Preload(arg_15_0, unpackEx(arg_14_2))

			return
		end
	}, function()
		arg_14_1:ExecuteAction("Show", unpackEx(arg_14_2))

		return
	end)

	return
end

function IslandSceneMgr:CreateScenePage(arg_17_1)
	local var_17_0 = _.detect(self.pages, function(arg_18_0)
		return arg_18_0.__cname == arg_17_1.__cname
	end)

	if var_17_0 then
		table.removebyvalue(self.pages, var_17_0)
	end

	local var_17_1 = var_17_0 or arg_17_1.New(self.scene, self.scene.uiContainer)

	table.insert((var_17_1:NeedCache() or nil) and (self.pages or self.noStatePages), var_17_1)

	return var_17_1
end

function IslandSceneMgr:CreateSubPage(arg_19_1, arg_19_2)
	local var_19_0 = _.detect(self.subPages, function(arg_20_0)
		return arg_20_0.__cname == arg_19_2.__cname
	end)

	if var_19_0 then
		table.removebyvalue(self.subPages, var_19_0)
	end

	local var_19_1 = var_19_0 or arg_19_2.New(self.scene, self.scene.pageContainer)

	table.insert(self.subPages, var_19_1)

	return var_19_1
end

function IslandSceneMgr:ClosePrevScenePage(arg_21_1)
	if self.stack[#self.stack] then
		local var_21_0 = self:GetPage(self.stack[#self.stack].class)

		if var_21_0 and var_21_0:GetLoaded() and var_21_0:isShowing() then
			var_21_0:Disable(arg_21_1)

			for iter_21_0, iter_21_1 in ipairs(self.stack[#self.stack]:GetSubPages()) do
				local var_21_1 = self:GetSubPage(iter_21_1.class)

				if var_21_1 and var_21_1:GetLoaded() then
					var_21_1:Disable()
				end
			end
		else
			arg_21_1()
		end
	else
		arg_21_1()
	end

	return
end

function IslandSceneMgr:CheckOverflowAndDestory(arg_22_1)
	if #self.pages > self.capacity then
		local var_22_0 = self:GetLongestNoUsePage(arg_22_1)
		local var_22_1 = self:GetContext(var_22_0.class)

		if var_22_1 then
			var_22_1:DisabelDelRecordWhenClose()
		end

		self:DestroyPage(var_22_0, nil, true)

		self.gcCnt = self.gcCnt + 1

		if self.gcCnt % 5 == 0 then
			gcAll(false)

			self.gcCnt = 0
		end
	end

	return
end

function IslandSceneMgr:GetLongestNoUsePage(arg_23_1)
	local function var_23_0(arg_24_0)
		return self:GetContext(arg_24_0.class) ~= nil
	end

	local var_23_1 = 0

	for iter_23_0, iter_23_1 in ipairs(self.pages) do
		if arg_23_1 ~= iter_23_1 and not var_23_0(iter_23_1) then
			var_23_1 = iter_23_0

			break
		end
	end

	return self.pages[math.max(var_23_1, 1)]
end

function IslandSceneMgr:ClosePage(arg_25_1)
	if not (self:CheckAndCloseSubPage(arg_25_1) or self:CheckAndCloseNoStatePage(arg_25_1)) then
		self:CheckAndCloseScenePage(arg_25_1)
	end

	self:Debug()

	return
end

function IslandSceneMgr:DestorySubPage(arg_26_1)
	local var_26_0 = self:GetContext(arg_26_1)

	if not var_26_0 then
		return
	end

	for iter_26_0, iter_26_1 in ipairs(var_26_0:GetSubPages()) do
		local var_26_1 = self:GetSubPage(iter_26_1.class)

		if var_26_1 and var_26_1:GetLoaded() then
			iter_26_1.__visible = false

			table.removebyvalue(self.subPages, var_26_1)
			var_26_1:Destroy()
		end
	end

	return
end

function IslandSceneMgr:CheckAndCloseScenePage(arg_27_1)
	local var_27_0 = self:GetContext(arg_27_1)

	if var_27_0 then
		local var_27_1 = self:GetPage(var_27_0.class)

		if var_27_1 and var_27_1:GetLoaded() and var_27_1:isShowing() then
			if var_27_0:GetDelRecordWhenClose() then
				self:DelRecord(var_27_0)
			end

			var_27_1:Disable()

			for iter_27_0, iter_27_1 in ipairs(var_27_0:GetSubPages()) do
				local var_27_2 = self:GetSubPage(iter_27_1.class)

				if var_27_2 and var_27_2:GetLoaded() then
					var_27_2:Destroy()
					table.removebyvalue(self.subPages, var_27_2)
				end
			end

			if var_27_0:GetOpenPrevWhenClose() then
				self:OpenPrevScenePage()
			end
		end

		return var_27_1 ~= nil
	end

	return false
end

function IslandSceneMgr:OpenPrevScenePage()
	if self:IsDestroyed() then
		return
	end

	local var_28_0 = self.stack[#self.stack]

	if self.stack[#self.stack] then
		local var_28_1 = self:GetPage(var_28_0.class)

		if var_28_1 and var_28_1:GetLoaded() and var_28_1:isShowing() then
			self:Record(var_28_0)
			var_28_1:Enable()

			for iter_28_0, iter_28_1 in ipairs(var_28_0:GetSubPages()) do
				if iter_28_1.__visible then
					local var_28_2 = self:GetSubPage(iter_28_1.class)

					if var_28_2:GetLoaded() then
						var_28_2:Disable()
					end
				end
			end
		else
			self:DelRecord(var_28_0)

			local var_28_3 = self:OpenPage(self.scene, var_28_0.class, unpackEx(var_28_0:GetData()))

			for iter_28_2, iter_28_3 in ipairs(var_28_0:GetSubPages()) do
				if iter_28_3.__visible then
					self:OpenPage(var_28_3, iter_28_3.class, unpackEx(iter_28_3:GetData()))
				end
			end
		end
	end

	return
end

function IslandSceneMgr:CheckAndCloseSubPage(arg_29_1)
	local var_29_0 = self:GetContext(arg_29_1)

	if var_29_0 then
		local var_29_1 = -1

		for iter_29_0, iter_29_1 in ipairs(var_29_0:GetSubPages()) do
			if iter_29_1.class.__cname == arg_29_1.__cname then
				var_29_1 = iter_29_1:GetLevel()

				break
			end
		end

		if var_29_1 >= 0 then
			for iter_29_2, iter_29_3 in ipairs(var_29_0:GetSubPages()) do
				if var_29_1 == iter_29_3:GetLevel() and (iter_29_3:GetSubPageParentName() == arg_29_1.__cname or iter_29_3.class.__cname == arg_29_1.__cname) then
					local var_29_2 = self:GetSubPage(iter_29_3.class)

					if var_29_2 and var_29_2:GetLoaded() then
						iter_29_3.__visible = false

						self.scene:emit(ISLAND_EVT.SUB_PAGE_CLOSE, var_29_2.class.__cname)
						var_29_2:Disable()
					end
				end
			end

			return true
		end
	end

	return false
end

function IslandSceneMgr:CheckAndCloseNoStatePage(arg_30_1)
	local var_30_0 = self:GetContext(arg_30_1)
	local var_30_1 = false

	if var_30_0 then
		local var_30_2 = _.detect(self.noStatePages, function(arg_31_0)
			return arg_31_0.__cname == arg_30_1.__cname
		end)

		if var_30_2 then
			self:DelRecord(var_30_0)
			self:DestroyPage(var_30_2, var_30_0)
			self:OpenPrevScenePage()

			var_30_1 = true
		end
	end

	return var_30_1
end

function IslandSceneMgr:DestroyPage(arg_32_1, arg_32_2, arg_32_3)
	arg_32_2 = arg_32_2 or self:GetContext(arg_32_1.class)

	if arg_32_2 then
		arg_32_2:DisabelOpenPrevWhenClose()

		for iter_32_0, iter_32_1 in ipairs(arg_32_2:GetSubPages()) do
			local var_32_0 = self:GetSubPage(iter_32_1.class)

			if var_32_0 and var_32_0:GetLoaded() then
				var_32_0:Destroy()
				table.removebyvalue(self.subPages, arg_32_1)
			end
		end
	end

	if arg_32_1:GetLoaded() then
		arg_32_1:Destroy(arg_32_3)

		if arg_32_1:NeedCache() then
			table.removebyvalue(self.pages, arg_32_1)
		else
			table.removebyvalue(self.noStatePages, arg_32_1)
		end
	end

	return
end

function IslandSceneMgr:Record(arg_33_1, arg_33_2)
	if self:IsDestroyed() then
		return
	end

	local var_33_0 = _.detect(self.stack, function(arg_34_0)
		return arg_34_0.class == arg_33_1.class
	end)

	if var_33_0 then
		table.removebyvalue(self.stack, var_33_0)
		table.insert(self.stack, arg_33_1)

		return
	end

	table.insert(self.stack, arg_33_1)

	if #self.stack == 1 then
		self:OnAnyPageOpen(arg_33_1.class)
	end

	return
end

function IslandSceneMgr:DelRecord(arg_35_1)
	if self:IsDestroyed() then
		return
	end

	table.removebyvalue(self.stack, arg_35_1)

	if #self.stack == 0 then
		self:OnAllPageClose()
	end

	return
end

function IslandSceneMgr:OnAnyPageOpen(arg_36_1)
	self.scene:emitCore(ISLAND_EVT.ANY_PAGE_OPENED, arg_36_1)
	self.scene:TryDisVisible()

	return
end

function IslandSceneMgr:OnAllPageClose()
	self.scene:emitCore(ISLAND_EVT.ALL_PAGE_CLOSED)
	self.scene:TryVisible()

	return
end

function IslandSceneMgr:IsAllPageClose()
	return #self.stack == 0
end

function IslandSceneMgr:IsSceneType(arg_39_1)
	return arg_39_1.__cname == self.scene.__cname
end

function IslandSceneMgr:OnBackPressed()
	if self.stack[#self.stack] then
		local var_40_0 = self:GetPage(self.stack[#self.stack].class)

		if var_40_0 and var_40_0:CanEsc() then
			var_40_0:Hide()
		end

		return true
	end

	return false
end

function IslandSceneMgr:IsDestroyed()
	return self.state == var_0_3
end

function IslandSceneMgr:Dispose()
	self.state = var_0_3

	for iter_42_0 = #self.pages, 1, -1 do
		self.pages[iter_42_0]:ActiveOrDisactive(false)
		self:DestroyPage(self.pages[iter_42_0])
	end

	for iter_42_1 = #self.noStatePages, 1, -1 do
		self.noStatePages[iter_42_1]:ActiveOrDisactive(false)
		self:DestroyPage(self.noStatePages[iter_42_1])
	end

	self.stack = nil
	self.noStatePages = nil
	self.pages = nil
	self.subPages = nil

	return
end

function IslandSceneMgr:Debug()
	if not var_0_1 then
		return
	end

	local function var_43_0(arg_44_0)
		return table.concat(_.map(arg_44_0:GetSubPages(), function(arg_45_0)
			return arg_45_0.class.__cname
		end), ",")
	end

	print("\n" .. table.concat(_.map(self.stack, function(arg_46_0)
		return arg_46_0.class.__cname .. ":[" .. var_43_0(arg_46_0) .. "]"
	end), "\n"))

	return
end

return IslandSceneMgr
