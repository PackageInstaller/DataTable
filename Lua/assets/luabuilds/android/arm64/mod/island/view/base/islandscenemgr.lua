local var_0_0 = class("IslandSceneMgr")
local var_0_1 = false
local var_0_2 = 1
local var_0_3 = 2

var_0_0.NEED_LONDING_PAGE_LIST = {
	"IslandCheaterTavernPrepareMainPage"
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.scene = arg_1_1
	arg_1_0.capacity = 2
	arg_1_0.stack = {}
	arg_1_0.noStatePages = {}
	arg_1_0.pages = {}
	arg_1_0.subPages = {}
	arg_1_0.state = var_0_2
	arg_1_0.gcCnt = 0

	return
end

function var_0_0.OpenPage(arg_2_0, arg_2_1, arg_2_2, ...)
	local var_2_0 = packEx(...)

	if arg_2_0:IsSceneType(arg_2_1) then
		local var_2_1 = arg_2_0:CreateScenePage(arg_2_2)

		arg_2_0:CheckOverflowAndDestory(var_2_1)

		if arg_2_0:IsNeedLoadingPage(arg_2_2) then
			pg.SceneAnimMgr.GetInstance():CommonSceneChange("Dorm3DLoading", function(arg_3_0)
				arg_2_0:ClosePrevScenePage(function()
					arg_2_0:Record(IslandSceneContext.New(arg_2_2, unpackEx(var_2_0)), true)
					arg_2_0:StartPage(var_2_1, var_2_0)
					arg_3_0()

					return
				end)

				return
			end)
		else
			arg_2_0:ClosePrevScenePage(function()
				arg_2_0:Record(IslandSceneContext.New(arg_2_2, unpackEx(var_2_0)), true)
				arg_2_0:StartPage(var_2_1, var_2_0)

				return
			end)
		end

		return var_2_1
	else
		local var_2_2 = arg_2_0:CreateSubPage(arg_2_1, arg_2_2)
		local var_2_3, var_2_4 = arg_2_0:GetContext(arg_2_1)

		assert(var_2_3, arg_2_1.__cname)
		var_2_3:AddSubPage(arg_2_2, var_2_4, arg_2_1.__cname, ...)
		arg_2_0:StartPage(var_2_2, (packEx(...)))
		arg_2_0.scene:emit(ISLAND_EVT.SUB_PAGE_OPEN, arg_2_2.__cname)

		return var_2_2
	end

	return
end

function var_0_0.IsNeedLoadingPage(arg_6_0, arg_6_1)
	return table.keyof(var_0_0.NEED_LONDING_PAGE_LIST, arg_6_1.__cname)
end

function var_0_0.GetContext(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.stack) do
		if iter_7_1.class.__cname == arg_7_1.__cname then
			return iter_7_1, #iter_7_1:GetSubPages()
		end
	end

	for iter_7_2, iter_7_3 in ipairs(arg_7_0.stack) do
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

function var_0_0.GetPage(arg_9_0, arg_9_1)
	return _.detect(arg_9_0.pages, function(arg_10_0)
		return arg_10_0.__cname == arg_9_1.__cname
	end) or _.detect(arg_9_0.noStatePages, function(arg_11_0)
		return arg_11_0.__cname == arg_9_1.__cname
	end)
end

function var_0_0.GetSubPage(arg_12_0, arg_12_1)
	return (_.detect(arg_12_0.subPages, function(arg_13_0)
		return arg_13_0.__cname == arg_12_1.__cname
	end))
end

function var_0_0.StartPage(arg_14_0, arg_14_1, arg_14_2)
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

function var_0_0.CreateScenePage(arg_17_0, arg_17_1)
	local var_17_0 = _.detect(arg_17_0.pages, function(arg_18_0)
		return arg_18_0.__cname == arg_17_1.__cname
	end)

	if var_17_0 then
		table.removebyvalue(arg_17_0.pages, var_17_0)
	end

	local var_17_1 = var_17_0 or arg_17_1.New(arg_17_0.scene, arg_17_0.scene.uiContainer)

	if var_17_1:NeedCache() then
		local var_17_2 = arg_17_0.pages or arg_17_0.noStatePages

		table.insert(var_17_2, var_17_1)

		return var_17_1
	end
end

function var_0_0.CreateSubPage(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = _.detect(arg_19_0.subPages, function(arg_20_0)
		return arg_20_0.__cname == arg_19_2.__cname
	end)

	if var_19_0 then
		table.removebyvalue(arg_19_0.subPages, var_19_0)
	end

	local var_19_1 = var_19_0 or arg_19_2.New(arg_19_0.scene, arg_19_0.scene.pageContainer)

	table.insert(arg_19_0.subPages, var_19_1)

	return var_19_1
end

function var_0_0.ClosePrevScenePage(arg_21_0, arg_21_1)
	if arg_21_0.stack[#arg_21_0.stack] then
		local var_21_0 = arg_21_0:GetPage(arg_21_0.stack[#arg_21_0.stack].class)

		if var_21_0 and var_21_0:GetLoaded() and var_21_0:isShowing() then
			var_21_0:Disable(arg_21_1)

			for iter_21_0, iter_21_1 in ipairs(arg_21_0.stack[#arg_21_0.stack]:GetSubPages()) do
				local var_21_1 = arg_21_0:GetSubPage(iter_21_1.class)

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

function var_0_0.CheckOverflowAndDestory(arg_22_0, arg_22_1)
	if #arg_22_0.pages > arg_22_0.capacity then
		local var_22_0 = arg_22_0:GetLongestNoUsePage(arg_22_1)
		local var_22_1 = arg_22_0:GetContext(var_22_0.class)

		if var_22_1 then
			var_22_1:DisabelDelRecordWhenClose()
		end

		arg_22_0:DestroyPage(var_22_0, nil, true)

		arg_22_0.gcCnt = arg_22_0.gcCnt + 1

		if arg_22_0.gcCnt % 5 == 0 then
			gcAll(false)

			arg_22_0.gcCnt = 0
		end
	end

	return
end

function var_0_0.GetLongestNoUsePage(arg_23_0, arg_23_1)
	local var_23_0 = 0

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.pages) do
		if arg_23_1 ~= iter_23_1 and not (function(arg_24_0)
			return arg_23_0:GetContext(arg_24_0.class) ~= nil
		end)(iter_23_1) then
			var_23_0 = iter_23_0

			break
		end
	end

	return arg_23_0.pages[math.max(var_23_0, 1)]
end

function var_0_0.ClosePage(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:CheckAndCloseSubPage(arg_25_1) or arg_25_0:CheckAndCloseNoStatePage(arg_25_1)

	if not var_25_0 then
		arg_25_0:CheckAndCloseScenePage(arg_25_1)
	end

	arg_25_0:Debug()

	return
end

function var_0_0.DestorySubPage(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:GetContext(arg_26_1)

	if not var_26_0 then
		return
	end

	for iter_26_0, iter_26_1 in ipairs(var_26_0:GetSubPages()) do
		local var_26_1 = arg_26_0:GetSubPage(iter_26_1.class)

		if var_26_1 and var_26_1:GetLoaded() then
			iter_26_1.__visible = false

			table.removebyvalue(arg_26_0.subPages, var_26_1)
			var_26_1:Destroy()
		end
	end

	return
end

function var_0_0.CheckAndCloseScenePage(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:GetContext(arg_27_1)

	if var_27_0 then
		local var_27_1 = arg_27_0:GetPage(var_27_0.class)

		if var_27_1 and var_27_1:GetLoaded() and var_27_1:isShowing() then
			if var_27_0:GetDelRecordWhenClose() then
				arg_27_0:DelRecord(var_27_0)
			end

			var_27_1:Disable()

			for iter_27_0, iter_27_1 in ipairs(var_27_0:GetSubPages()) do
				local var_27_2 = arg_27_0:GetSubPage(iter_27_1.class)

				if var_27_2 and var_27_2:GetLoaded() then
					var_27_2:Destroy()
					table.removebyvalue(arg_27_0.subPages, var_27_2)
				end
			end

			if var_27_0:GetOpenPrevWhenClose() then
				arg_27_0:OpenPrevScenePage()
			end
		end

		return var_27_1 ~= nil
	end

	return false
end

function var_0_0.OpenPrevScenePage(arg_28_0)
	if arg_28_0:IsDestroyed() then
		return
	end

	local var_28_0 = arg_28_0.stack[#arg_28_0.stack]

	if arg_28_0.stack[#arg_28_0.stack] then
		local var_28_1 = arg_28_0:GetPage(var_28_0.class)

		if var_28_1 and var_28_1:GetLoaded() and var_28_1:isShowing() then
			arg_28_0:Record(var_28_0)
			var_28_1:Enable()

			for iter_28_0, iter_28_1 in ipairs(var_28_0:GetSubPages()) do
				if iter_28_1.__visible then
					local var_28_2 = arg_28_0:GetSubPage(iter_28_1.class)

					if var_28_2:GetLoaded() then
						var_28_2:Disable()
					end
				end
			end
		else
			arg_28_0:DelRecord(var_28_0)

			local var_28_3 = arg_28_0:OpenPage(arg_28_0.scene, var_28_0.class, unpackEx(var_28_0:GetData()))

			for iter_28_2, iter_28_3 in ipairs(var_28_0:GetSubPages()) do
				if iter_28_3.__visible then
					arg_28_0:OpenPage(var_28_3, iter_28_3.class, unpackEx(iter_28_3:GetData()))
				end
			end
		end
	end

	return
end

function var_0_0.CheckAndCloseSubPage(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:GetContext(arg_29_1)

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
					local var_29_2 = arg_29_0:GetSubPage(iter_29_3.class)

					if var_29_2 and var_29_2:GetLoaded() then
						iter_29_3.__visible = false

						arg_29_0.scene:emit(ISLAND_EVT.SUB_PAGE_CLOSE, var_29_2.class.__cname)
						var_29_2:Disable()
					end
				end
			end

			return true
		end
	end

	return false
end

function var_0_0.CheckAndCloseNoStatePage(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:GetContext(arg_30_1)
	local var_30_1 = false

	if var_30_0 then
		local var_30_2 = _.detect(arg_30_0.noStatePages, function(arg_31_0)
			return arg_31_0.__cname == arg_30_1.__cname
		end)

		if var_30_2 then
			arg_30_0:DelRecord(var_30_0)
			arg_30_0:DestroyPage(var_30_2, var_30_0)
			arg_30_0:OpenPrevScenePage()

			var_30_1 = true
		end
	end

	return var_30_1
end

function var_0_0.DestroyPage(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	arg_32_2 = arg_32_2 or arg_32_0:GetContext(arg_32_1.class)

	if arg_32_2 then
		arg_32_2:DisabelOpenPrevWhenClose()

		for iter_32_0, iter_32_1 in ipairs(arg_32_2:GetSubPages()) do
			local var_32_0 = arg_32_0:GetSubPage(iter_32_1.class)

			if var_32_0 and var_32_0:GetLoaded() then
				var_32_0:Destroy()
				table.removebyvalue(arg_32_0.subPages, arg_32_1)
			end
		end
	end

	if arg_32_1:GetLoaded() then
		arg_32_1:Destroy(arg_32_3)

		if arg_32_1:NeedCache() then
			table.removebyvalue(arg_32_0.pages, arg_32_1)
		else
			table.removebyvalue(arg_32_0.noStatePages, arg_32_1)
		end
	end

	return
end

function var_0_0.Record(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_0:IsDestroyed() then
		return
	end

	local var_33_0 = _.detect(arg_33_0.stack, function(arg_34_0)
		return arg_34_0.class == arg_33_1.class
	end)

	if var_33_0 then
		table.removebyvalue(arg_33_0.stack, var_33_0)
		table.insert(arg_33_0.stack, arg_33_1)

		return
	end

	table.insert(arg_33_0.stack, arg_33_1)

	if #arg_33_0.stack == 1 then
		arg_33_0:OnAnyPageOpen(arg_33_1.class)
	end

	return
end

function var_0_0.DelRecord(arg_35_0, arg_35_1)
	if arg_35_0:IsDestroyed() then
		return
	end

	table.removebyvalue(arg_35_0.stack, arg_35_1)

	if #arg_35_0.stack == 0 then
		arg_35_0:OnAllPageClose()
	end

	return
end

function var_0_0.OnAnyPageOpen(arg_36_0, arg_36_1)
	arg_36_0.scene:emitCore(ISLAND_EVT.ANY_PAGE_OPENED, arg_36_1)
	arg_36_0.scene:TryDisVisible()

	return
end

function var_0_0.OnAllPageClose(arg_37_0)
	arg_37_0.scene:emitCore(ISLAND_EVT.ALL_PAGE_CLOSED)
	arg_37_0.scene:TryVisible()

	return
end

function var_0_0.IsAllPageClose(arg_38_0)
	return #arg_38_0.stack == 0
end

function var_0_0.IsSceneType(arg_39_0, arg_39_1)
	return arg_39_1.__cname == arg_39_0.scene.__cname
end

function var_0_0.OnBackPressed(arg_40_0)
	if arg_40_0.stack[#arg_40_0.stack] then
		local var_40_0 = arg_40_0:GetPage(arg_40_0.stack[#arg_40_0.stack].class)

		if var_40_0 and var_40_0:CanEsc() then
			var_40_0:Hide()
		end

		return true
	end

	return false
end

function var_0_0.IsDestroyed(arg_41_0)
	return arg_41_0.state == var_0_3
end

function var_0_0.Dispose(arg_42_0)
	arg_42_0.state = var_0_3

	for iter_42_0 = #arg_42_0.pages, 1, -1 do
		arg_42_0.pages[iter_42_0]:ActiveOrDisactive(false)
		arg_42_0:DestroyPage(arg_42_0.pages[iter_42_0])
	end

	for iter_42_1 = #arg_42_0.noStatePages, 1, -1 do
		arg_42_0.noStatePages[iter_42_1]:ActiveOrDisactive(false)
		arg_42_0:DestroyPage(arg_42_0.noStatePages[iter_42_1])
	end

	arg_42_0.stack = nil
	arg_42_0.noStatePages = nil
	arg_42_0.pages = nil
	arg_42_0.subPages = nil

	return
end

function var_0_0.Debug(arg_43_0)
	if not var_0_1 then
		return
	end

	local function var_43_0(arg_44_0)
		return table.concat(_.map(arg_44_0:GetSubPages(), function(arg_45_0)
			return arg_45_0.class.__cname
		end), ",")
	end

	print("\n" .. table.concat(_.map(arg_43_0.stack, function(arg_46_0)
		return arg_46_0.class.__cname .. ":[" .. var_43_0(arg_46_0) .. "]"
	end), "\n"))

	return
end

return var_0_0
