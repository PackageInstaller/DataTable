class = var_0_10000

local var_0_0 = var_0_10000("IslandSceneMgr")
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
	packEx = var_1_10003

	local var_2_0 = var_1_10003(...)

	if arg_2_0:IsSceneType(arg_2_1) then
		local var_2_1 = arg_2_0:CreateScenePage(arg_2_2)

		arg_2_0:CheckOverflowAndDestory(var_2_1)

		if arg_2_0:IsNeedLoadingPage(arg_2_2) then
			pg = var_5

			local var_2_2 = var_5.SceneAnimMgr.GetInstance()

			var_5.CommonSceneChange(var_2_2, "Dorm3DLoading", function(arg_3_0)
				local var_3_0 = arg_2_0

				var_1.ClosePrevScenePage(var_3_0, function()
					local var_4_0 = arg_2_0
					local var_4_1 = var_0.Record

					IslandSceneContext = var_3_10002

					local var_4_2 = var_3_10002.New
					local var_4_3 = arg_2_2

					unpackEx = var_3_10004

					var_4_1(var_4_0, var_4_2(var_4_3, var_3_10004(var_2_0)), true)

					local var_4_4 = arg_2_0

					var_0.StartPage(var_4_4, var_2_1, var_2_0)
					arg_3_0()

					return
				end)

				return
			end)
		else
			arg_2_0:ClosePrevScenePage(function()
				local var_5_0 = arg_2_0
				local var_5_1 = var_0.Record

				IslandSceneContext = var_2_10002

				local var_5_2 = var_2_10002.New
				local var_5_3 = arg_2_2

				unpackEx = var_2_10004

				var_5_1(var_5_0, var_5_2(var_5_3, var_2_10004(var_2_0)), true)

				local var_5_4 = arg_2_0

				var_0.StartPage(var_5_4, var_2_1, var_2_0)

				return
			end)
		end

		return var_2_1
	else
		local var_2_3 = arg_2_0:CreateSubPage(arg_2_1, arg_2_2)
		local var_2_4, var_2_5 = arg_2_0:GetContext(arg_2_1)

		assert = var_7

		var_7(var_2_4, arg_2_1.__cname)
		var_2_4:AddSubPage(arg_2_2, var_2_5, arg_2_1.__cname, ...)
		arg_2_0:StartPage(var_2_3, var_2_0)

		local var_2_6 = arg_2_0.scene
		local var_2_7 = var_7.emit

		ISLAND_EVT = var_9

		var_2_7(var_2_6, var_9.SUB_PAGE_OPEN, arg_2_2.__cname)

		return var_2_3
	end

	return
end

function var_0_0.IsNeedLoadingPage(arg_6_0, arg_6_1)
	table = var_1_10002

	return var_1_10002.keyof(var_0_0.NEED_LONDING_PAGE_LIST, arg_6_1.__cname)
end

function var_0_0.GetContext(arg_7_0, arg_7_1)
	ipairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(arg_7_0.stack) do
		if iter_7_1.class.__cname == arg_7_1.__cname then
			return iter_7_1, #iter_7_1:GetSubPages()
		end
	end

	ipairs = var_2

	for iter_7_2, iter_7_3 in var_2(arg_7_0.stack) do
		_ = var_1_10007

		if var_1_10007.detect(iter_7_3:GetSubPages(), function(arg_8_0)
			return arg_8_0.class.__cname == arg_7_1.__cname
		end) then
			local var_7_0 = iter_7_3
			local var_7_1 = var_1_10007:GetLevel()

			return
		end
	end

	return nil
end

function var_0_0.GetPage(arg_9_0, arg_9_1)
	_ = var_1_10002

	local var_9_0

	if not var_1_10002.detect(arg_9_0.pages, function(arg_10_0)
		return arg_10_0.__cname == arg_9_1.__cname
	end) then
		_ = var_3
		var_9_0 = var_3.detect(arg_9_0.noStatePages, function(arg_11_0)
			return arg_11_0.__cname == arg_9_1.__cname
		end)
	end

	return var_9_0
end

function var_0_0.GetSubPage(arg_12_0, arg_12_1)
	_ = var_1_10002

	return (var_1_10002.detect(arg_12_0.subPages, function(arg_13_0)
		return arg_13_0.__cname == arg_12_1.__cname
	end))
end

function var_0_0.StartPage(arg_14_0, arg_14_1, arg_14_2)
	seriesAsync = var_1_10003

	var_1_10003({
		function(arg_15_0)
			local var_15_0 = arg_14_1
			local var_15_1 = var_1.Preload
			local var_15_2 = arg_15_0

			unpackEx = var_2_10004

			var_15_1(var_15_0, var_15_2, var_2_10004(arg_14_2))

			return
		end
	}, function()
		local var_16_0 = arg_14_1
		local var_16_1 = var_0.ExecuteAction
		local var_16_2 = "Show"

		unpackEx = var_2_10003

		var_16_1(var_16_0, var_16_2, var_2_10003(arg_14_2))

		return
	end)

	return
end

function var_0_0.CreateScenePage(arg_17_0, arg_17_1)
	_ = var_1_10002

	if var_1_10002.detect(arg_17_0.pages, function(arg_18_0)
		return arg_18_0.__cname == arg_17_1.__cname
	end) then
		table = var_3

		var_3.removebyvalue(arg_17_0.pages, var_2)
	end

	local var_17_0 = var_2 or arg_17_1.New(arg_17_0.scene, arg_17_0.scene.uiContainer)
	local var_17_1

	if not var_3.NeedCache(var_17_0) or not arg_17_0.pages then
		var_17_1 = arg_17_0.noStatePages
	end

	table = var_17_0

	var_17_0.insert(var_17_1, var_3)

	return var_3
end

function var_0_0.CreateSubPage(arg_19_0, arg_19_1, arg_19_2)
	_ = var_1_10003

	if var_1_10003.detect(arg_19_0.subPages, function(arg_20_0)
		return arg_20_0.__cname == arg_19_2.__cname
	end) then
		table = var_4

		var_4.removebyvalue(arg_19_0.subPages, var_3)
	end

	local var_19_0 = var_3 or arg_19_2.New(arg_19_0.scene, arg_19_0.scene.pageContainer)

	table = var_5

	var_5.insert(arg_19_0.subPages, var_19_0)

	return var_19_0
end

function var_0_0.ClosePrevScenePage(arg_21_0, arg_21_1)
	if arg_21_0.stack[#arg_21_0.stack] then
		if arg_21_0:GetPage(var_2.class) and var_3:GetLoaded() and var_3:isShowing() then
			var_3:Disable(arg_21_1)

			ipairs = var_4

			for iter_21_0, iter_21_1 in var_4(var_2:GetSubPages()) do
				if arg_21_0:GetSubPage(iter_21_1.class) and var_9:GetLoaded() then
					var_9:Disable()
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

		if arg_22_0:GetContext(var_22_0.class) then
			var_3:DisabelDelRecordWhenClose()
		end

		arg_22_0:DestroyPage(var_22_0, nil, true)

		arg_22_0.gcCnt = arg_22_0.gcCnt + 1

		if arg_22_0.gcCnt % 5 == 0 then
			gcAll = var_4

			var_4(false)

			arg_22_0.gcCnt = 0
		end
	end

	return
end

function var_0_0.GetLongestNoUsePage(arg_23_0, arg_23_1)
	local function var_23_0(arg_24_0)
		local var_24_0 = arg_23_0

		return var_1.GetContext(var_24_0, arg_24_0.class) ~= nil
	end

	local var_23_1 = 0

	ipairs = var_1_10004

	for iter_23_0, iter_23_1 in var_1_10004(arg_23_0.pages) do
		if arg_23_1 ~= iter_23_1 and not var_23_0(iter_23_1) then
			var_23_1 = iter_23_0

			break
		end
	end

	math = var_4

	local var_23_2 = var_4.max(var_23_1, 1)

	return arg_23_0.pages[var_23_2]
end

function var_0_0.ClosePage(arg_25_0, arg_25_1)
	local var_25_0

	if not arg_25_0:CheckAndCloseSubPage(arg_25_1) then
		var_25_0 = arg_25_0:CheckAndCloseNoStatePage(arg_25_1)
	end

	if not var_25_0 then
		arg_25_0:CheckAndCloseScenePage(arg_25_1)
	end

	arg_25_0:Debug()

	return
end

function var_0_0.DestorySubPage(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0

	if not arg_26_0.GetContext(var_26_0, arg_26_1) then
		return
	end

	ipairs = var_26_0

	for iter_26_0, iter_26_1 in var_26_0(var_2:GetSubPages()) do
		if arg_26_0:GetSubPage(iter_26_1.class) and var_8:GetLoaded() then
			iter_26_1.__visible = false
			table = var_9

			var_9.removebyvalue(arg_26_0.subPages, var_8)
			var_8:Destroy()
		end
	end

	return
end

function var_0_0.CheckAndCloseScenePage(arg_27_0, arg_27_1)
	if arg_27_0:GetContext(arg_27_1) then
		if arg_27_0:GetPage(var_2.class) and var_3:GetLoaded() and var_3:isShowing() then
			local var_27_0 = var_2:GetOpenPrevWhenClose()

			if var_2:GetDelRecordWhenClose() then
				arg_27_0:DelRecord(var_2)
			end

			var_3:Disable()

			ipairs = var_6

			for iter_27_0, iter_27_1 in var_6(var_2:GetSubPages()) do
				if arg_27_0:GetSubPage(iter_27_1.class) and var_11:GetLoaded() then
					var_11:Destroy()

					table = var_12

					var_12.removebyvalue(arg_27_0.subPages, var_11)
				end
			end

			if var_27_0 then
				arg_27_0:OpenPrevScenePage()
			end
		end

		return var_3 ~= nil
	end

	return false
end

function var_0_0.OpenPrevScenePage(arg_28_0)
	if arg_28_0:IsDestroyed() then
		return
	end

	if arg_28_0.stack[#arg_28_0.stack] then
		if arg_28_0:GetPage(var_1.class) and var_2:GetLoaded() and var_2:isShowing() then
			arg_28_0:Record(var_1)
			var_2:Enable()

			ipairs = var_3

			for iter_28_0, iter_28_1 in var_3(var_1:GetSubPages()) do
				if iter_28_1.__visible then
					local var_28_0 = arg_28_0:GetSubPage(iter_28_1.class)

					if var_8.GetLoaded(var_28_0) then
						var_8:Disable()
					end
				end
			end
		else
			arg_28_0:DelRecord(var_1)

			local var_28_1 = arg_28_0
			local var_28_2 = arg_28_0.OpenPage
			local var_28_3 = arg_28_0.scene
			local var_28_4 = var_1.class

			unpackEx = iter_28_1

			local var_28_5 = var_28_2(var_28_1, var_28_3, var_28_4, iter_28_1(var_1:GetData()))

			ipairs = var_28_1

			for iter_28_2, iter_28_3 in var_28_1(var_1:GetSubPages()) do
				if iter_28_3.__visible then
					local var_28_6 = arg_28_0
					local var_28_7 = arg_28_0.OpenPage
					local var_28_8 = var_28_5
					local var_28_9 = iter_28_3.class

					unpackEx = var_1_10013

					var_28_7(var_28_6, var_28_8, var_28_9, var_1_10013(iter_28_3:GetData()))
				end
			end
		end
	end

	return
end

function var_0_0.CheckAndCloseSubPage(arg_29_0, arg_29_1)
	if arg_29_0:GetContext(arg_29_1) then
		local var_29_0 = -1

		ipairs = var_4

		for iter_29_0, iter_29_1 in var_4(var_2:GetSubPages()) do
			if iter_29_1.class.__cname == arg_29_1.__cname then
				var_29_0 = iter_29_1:GetLevel()

				break
			end
		end

		if 0 <= var_29_0 then
			ipairs = var_4

			for iter_29_2, iter_29_3 in var_4(var_2:GetSubPages()) do
				if var_29_0 == iter_29_3:GetLevel() and (iter_29_3:GetSubPageParentName() == arg_29_1.__cname or iter_29_3.class.__cname == arg_29_1.__cname) and arg_29_0:GetSubPage(iter_29_3.class) and var_9:GetLoaded() then
					iter_29_3.__visible = false

					local var_29_1 = arg_29_0.scene
					local var_29_2 = var_10.emit

					ISLAND_EVT = var_1_10012

					var_29_2(var_29_1, var_1_10012.SUB_PAGE_CLOSE, var_9.class.__cname)
					var_9:Disable()
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
		_ = var_4

		if var_4.detect(arg_30_0.noStatePages, function(arg_31_0)
			return arg_31_0.__cname == arg_30_1.__cname
		end) then
			arg_30_0:DelRecord(var_30_0)
			arg_30_0:DestroyPage(var_4, var_30_0)
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

		ipairs = var_4

		for iter_32_0, iter_32_1 in var_4(arg_32_2:GetSubPages()) do
			if arg_32_0:GetSubPage(iter_32_1.class) and var_9:GetLoaded() then
				var_9:Destroy()

				table = var_10

				var_10.removebyvalue(arg_32_0.subPages, arg_32_1)
			end
		end
	end

	if arg_32_1:GetLoaded() then
		arg_32_1:Destroy(arg_32_3)

		if arg_32_1:NeedCache() then
			table = var_4

			var_4.removebyvalue(arg_32_0.pages, arg_32_1)
		else
			table = var_4

			var_4.removebyvalue(arg_32_0.noStatePages, arg_32_1)
		end
	end

	return
end

function var_0_0.Record(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_0:IsDestroyed() then
		return
	end

	_ = var_3

	if var_3.detect(arg_33_0.stack, function(arg_34_0)
		return arg_34_0.class == arg_33_1.class
	end) then
		table = var_4

		var_4.removebyvalue(arg_33_0.stack, var_3)

		table = var_4

		var_4.insert(arg_33_0.stack, arg_33_1)

		return
	end

	table = var_4

	var_4.insert(arg_33_0.stack, arg_33_1)

	if #arg_33_0.stack == 1 then
		arg_33_0:OnAnyPageOpen(arg_33_1.class)
	end

	return
end

function var_0_0.DelRecord(arg_35_0, arg_35_1)
	if arg_35_0:IsDestroyed() then
		return
	end

	table = var_2

	var_2.removebyvalue(arg_35_0.stack, arg_35_1)

	if #arg_35_0.stack == 0 then
		arg_35_0:OnAllPageClose()
	end

	return
end

function var_0_0.OnAnyPageOpen(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0.scene
	local var_36_1 = var_2.emitCore

	ISLAND_EVT = var_1_10004

	var_36_1(var_36_0, var_1_10004.ANY_PAGE_OPENED, arg_36_1)

	local var_36_2 = arg_36_0.scene

	var_2.TryDisVisible(var_36_2)

	return
end

function var_0_0.OnAllPageClose(arg_37_0)
	local var_37_0 = arg_37_0.scene
	local var_37_1 = var_1.emitCore

	ISLAND_EVT = var_1_10003

	var_37_1(var_37_0, var_1_10003.ALL_PAGE_CLOSED)

	local var_37_2 = arg_37_0.scene

	var_1.TryVisible(var_37_2)

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
		if arg_40_0:GetPage(var_1.class) and var_2:CanEsc() then
			var_2:Hide()
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
		local var_42_0 = arg_42_0.pages[iter_42_0]

		var_5.ActiveOrDisactive(var_42_0, false)
		arg_42_0:DestroyPage(var_5)
	end

	for iter_42_1 = #arg_42_0.noStatePages, 1, -1 do
		local var_42_1 = arg_42_0.noStatePages[iter_42_1]

		var_5.ActiveOrDisactive(var_42_1, false)
		arg_42_0:DestroyPage(var_5)
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
		_ = var_2_10001

		local var_44_0 = var_2_10001.map(arg_44_0:GetSubPages(), function(arg_45_0)
			return arg_45_0.class.__cname
		end)

		table = var_2

		return var_2.concat(var_44_0, ",")
	end

	_ = var_1_10002

	local var_43_1 = var_1_10002.map(arg_43_0.stack, function(arg_46_0)
		return arg_46_0.class.__cname .. ":[" .. var_43_0(arg_46_0) .. "]"
	end)

	table = var_3

	local var_43_2 = var_3.concat(var_43_1, "\n")

	print = var_4

	var_4("\n" .. var_43_2)

	return
end

return var_0_0
