pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.SceneMgr = var_0_10001("SceneMgr")

local var_0_1 = var_0.SceneMgr

function var_0_1.Ctor(arg_1_0)
	arg_1_0._cacheUI = {}
	arg_1_0._gcLimit = 7
	arg_1_0._gcCounter = 0

	return
end

function var_0_1.prepare(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = arg_2_2.mediator
	local var_2_1 = arg_2_2.viewComponent
	local var_2_2
	local var_2_3

	if arg_2_0._cacheUI[var_2_0.__cname] ~= nil then
		var_2_3 = arg_2_0._cacheUI[var_2_0.__cname]
		arg_2_0._cacheUI[var_2_0.__cname] = nil
		var_1_10010 = var_2_0.New(var_2_3)

		var_2_2.setContextData(var_1_10010, arg_2_2.data)

		var_1_10010 = arg_2_1

		arg_2_1.registerMediator(var_1_10010, var_2_2)
		arg_2_3(var_2_2)
	else
		var_2_3 = var_2_1.New()
		assert = var_8
		isa = var_1_10010

		local var_2_4 = var_2_3

		BaseUI = var_1_10013

		var_8(var_1_10010(var_2_4, var_1_10013), "should be an instance of BaseUI: " .. var_2_3.__cname)
		var_2_3:setContextData(arg_2_2.data)

		local var_2_5

		local function var_2_6()
			local var_3_0 = var_2_3.event
			local var_3_1 = var_0.disconnect

			BaseUI = var_2_10003

			var_3_1(var_3_0, var_2_10003.LOADED, var_2_6)

			var_2_2 = var_2_0.New(var_2_3)

			local var_3_2 = var_2_2

			var_0.setContextData(var_3_2, arg_2_2.data)

			local var_3_3 = arg_2_1

			var_0.registerMediator(var_3_3, var_2_2)
			arg_2_3(var_2_2)

			return
		end

		if var_2_3:isLoaded() then
			var_2_6()
		else
			local var_2_7 = var_2_3.event
			local var_2_8 = var_9.connect

			BaseUI = var_12

			var_2_8(var_2_7, var_12.LOADED, var_2_6)
			var_2_3:load()
		end
	end

	return
end

function var_0_1.prepareLayer(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = {}
	local var_4_1 = {}

	if arg_4_2 ~= nil then
		if arg_4_2:getContextByMediator(arg_4_3.mediator) then
			originalPrint = var_1_10007

			var_1_10007("mediator already exist: " .. arg_4_3.mediator.__cname)
			arg_4_4(var_4_1)

			return
		end

		table = var_1_10007

		var_1_10007.insert(var_4_0, arg_4_3)
		arg_4_2:addChild(arg_4_3)
	else
		table = var_1_10007

		var_1_10007.insertto(var_4_0, arg_4_3.children)
	end

	local var_4_2 = {}

	::label_4_0::

	local var_4_3 = #var_4_0

	if 0 < var_4_3 then
		repeat
			table = var_4_3
			var_4_3 = var_4_3.remove(var_4_0, 1)
			table = var_9

			var_9.insert(var_4_2, function(arg_5_0)
				local var_5_0 = var_4_3.parent
				local var_5_1 = arg_4_1
				local var_5_2 = var_2.retrieveMediator(var_5_1, var_5_0.mediator.__cname)
				local var_5_3 = var_2.getViewComponent(var_5_2)
				local var_5_4 = arg_4_0

				var_4.prepare(var_5_4, arg_4_1, var_4_3, function(arg_6_0)
					local var_6_0 = arg_6_0.viewComponent

					var_1.attach(var_6_0, var_5_3)

					table = var_1

					var_1.insert(var_4_1, arg_6_0)
					arg_5_0()

					return
				end)

				return
			end)

			table = var_9

			var_9.insertto(var_4_0, var_4_3.children)

			goto label_4_0
		until true
	end

	seriesAsync = var_4_3

	var_4_3(var_4_2, function()
		arg_4_4(var_4_1)

		return
	end)

	return
end

function var_0_1.enter(arg_8_0, arg_8_1, arg_8_2)
	if #arg_8_1 == 0 then
		arg_8_2()
	end

	local var_8_0 = #arg_8_1

	ipairs = var_1_10004

	for iter_8_0, iter_8_1 in var_1_10004(arg_8_1) do
		if iter_8_1.viewComponent._isCachedView then
			var_9:setVisible(true)
		end

		local var_8_1

		local function var_8_2()
			local var_9_0 = var_0.event
			local var_9_1 = var_0.disconnect

			BaseUI = var_2_10003

			var_9_1(var_9_0, var_2_10003.AVALIBLE, var_8_2)

			var_8_0 = var_8_0 - 1

			if var_8_0 == 0 then
				arg_8_2()
			end

			return
		end

		local var_8_3 = var_9.event
		local var_8_4 = var_11.connect

		BaseUI = var_1_10014

		var_8_4(var_8_3, var_1_10014.AVALIBLE, var_8_2)
		var_9:enter()
	end

	return
end

function var_0_1.removeLayer(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = {
		arg_10_2
	}
	local var_10_1 = {}

	while #var_10_0 > 0 do
		table = var_6

		if var_6.remove(var_10_0, 1).mediator then
			table = var_7

			var_7.insert(var_10_1, var_6)
		end

		table = var_7

		var_7.insertto(var_10_0, var_6.children)
	end

	if arg_10_2.parent == nil then
		table = var_6

		var_6.remove(var_10_1, 1)
	else
		local var_10_2 = arg_10_2.parent

		var_6.removeChild(var_10_2, arg_10_2)
	end

	local var_10_3 = {}

	for iter_10_0 = #var_10_1, 1, -1 do
		local var_10_4 = var_10_1[iter_10_0]
		local var_10_5 = arg_10_1:removeMediator(var_10_4.mediator.__cname)

		table = var_1_10013

		var_1_10013.insert(var_10_3, function(arg_11_0)
			if var_10_5 then
				local var_11_0 = arg_10_0

				var_1.remove(var_11_0, var_10_5, function()
					local var_12_0 = var_10_4

					var_0.onContextRemoved(var_12_0)
					arg_11_0()

					return
				end)
			else
				arg_11_0()
			end

			return
		end)
	end

	seriesAsync = var_7

	var_7(var_10_3, arg_10_3)

	return
end

function var_0_1.removeLayerMediator(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = {
		arg_13_2
	}
	local var_13_1 = {}
	local var_13_2 = {}

	while #var_13_0 > 0 do
		table = var_7

		if var_7.remove(var_13_0, 1).mediator then
			table = var_8

			var_8.insert(var_13_2, var_7)
		end

		table = var_8

		var_8.insertto(var_13_0, var_7.children)
	end

	if arg_13_2.parent ~= nil then
		local var_13_3 = arg_13_2.parent

		var_7.removeChild(var_13_3, arg_13_2)
	end

	local var_13_4 = {}

	for iter_13_0 = #var_13_2, 1, -1 do
		local var_13_5 = var_13_2[iter_13_0]

		if arg_13_1:removeMediator(var_13_5.mediator.__cname) then
			local var_13_6 = var_13:getViewComponent()

			if var_14.CheckTempCache(var_13_6) then
				PoolMgr = var_15

				local var_13_7 = var_15.GetInstance()

				var_15.KeepUICache(var_13_7, var_14:getUIName(), false)
			end

			table = var_15

			var_15.insert(var_13_4, {
				mediator = var_13,
				context = var_13_5
			})
		end
	end

	arg_13_3(var_13_4)

	return
end

function var_0_1.remove(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1:getViewComponent() == nil then
		arg_14_2()
	end

	if var_3:needCache() and not arg_14_0._cacheUI[arg_14_1.__cname] then
		var_3:setVisible(false)

		arg_14_0._cacheUI[arg_14_1.__cname] = var_3
		var_3._isCachedView = true

		arg_14_2()
	else
		var_3._isCachedView = false

		arg_14_0:removeView(var_3, arg_14_2)
	end

	return
end

function var_0_1.removeView(arg_15_0, arg_15_1, arg_15_2)
	arg_15_1._isCachedView = false

	local var_15_0 = arg_15_1.event
	local var_15_1 = var_3.connect

	BaseUI = var_1_10006

	var_15_1(var_15_0, var_1_10006.DID_EXIT, function()
		local var_16_0 = arg_15_1.event

		var_0.clear(var_16_0)

		local var_16_1 = arg_15_0

		var_0.gc(var_16_1, arg_15_1)
		arg_15_2()

		return
	end)
	arg_15_1:exit()

	return
end

function var_0_1.clearCacheUI(arg_17_0)
	parallelAsync = var_1_10001
	underscore = var_1_10003

	local var_17_0 = var_1_10003(arg_17_0._cacheUI)
	local var_17_1 = var_3.chain(var_17_0)
	local var_17_2 = var_3.values(var_17_1)
	local var_17_3 = var_3.map(var_17_2, function(arg_18_0)
		return function(arg_19_0)
			local var_19_0 = arg_17_0

			var_1.removeView(var_19_0, arg_18_0, arg_19_0)

			return
		end
	end)

	var_1_10001(var_3.value(var_17_3), function()
		arg_17_0._cacheUI = {}

		return
	end)

	return
end

function var_0_1.gc(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1:forceGC()

	table = var_1_10003

	var_1_10003.clear(arg_21_1)

	arg_21_1.exited = true

	if arg_21_1:DontGC() then
		return
	end

	if var_21_0 or arg_21_0._gcCounter >= arg_21_0._gcLimit then
		arg_21_0._gcCounter = 0
		gcAll = var_3

		var_3(false)
	else
		arg_21_0._gcCounter = arg_21_0._gcCounter + 1
		GCThread = var_3

		local var_21_1 = var_3.GetInstance()

		var_3.LuaGC(var_21_1, false)
	end

	return
end

return
