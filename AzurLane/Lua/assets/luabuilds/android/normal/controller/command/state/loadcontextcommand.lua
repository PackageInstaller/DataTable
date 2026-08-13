class = var_0_10000

local var_0_0 = "LoadContextCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

var_0_1.queue = {}

function var_0_1.execute(arg_1_0, arg_1_1)
	arg_1_0:load(arg_1_1:getBody())

	return
end

function var_0_1.load(arg_2_0, arg_2_1)
	table = var_1_10002

	var_1_10002.insert(var_0_1.queue, arg_2_1)

	if #var_0_1.queue == 1 then
		arg_2_0:loadNext()
	end

	return
end

function var_0_1.loadNext(arg_3_0)
	if #var_0_1.queue > 0 then
		local var_3_0 = var_0_1.queue[1]

		local function var_3_1()
			if var_3_0.callback then
				var_3_0.callback()
			end

			table = var_0

			var_0.remove(var_0_1.queue, 1)

			local var_4_0 = arg_3_0

			var_0.loadNext(var_4_0)

			return
		end

		local var_3_2 = var_3_0.type

		LOAD_TYPE_SCENE = var_1_10004

		if var_3_2 == var_1_10004 then
			var_1_10004 = arg_3_0

			arg_3_0.loadScene(var_1_10004, var_3_0.context, var_3_0.prevContext, var_3_0.isBack, var_3_1)
		else
			local var_3_3 = var_3_0.type

			LOAD_TYPE_LAYER = var_1_10004

			if var_3_3 == var_1_10004 then
				arg_3_0:loadLayer(var_3_0.context, var_3_0.parentContext, var_3_1)
			else
				assert = var_3_3

				var_3_3(false, "context load type not support: " .. var_3_0.type)
			end
		end
	end

	return
end

function var_0_1.loadScene(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	assert = var_1_10005
	isa = var_1_10006

	local var_5_0 = arg_5_1

	Context = var_1_10008

	var_1_10005(var_1_10006(var_5_0, var_1_10008), "should be an instance of Context")

	getProxy = var_1_10005
	ContextProxy = var_6

	local var_5_1 = var_1_10005(var_6)

	pg = var_6

	local var_5_2 = var_6.SceneMgr.GetInstance()
	local var_5_3
	local var_5_4
	local var_5_5 = {}
	local var_5_6 = {
		function(arg_6_0)
			if arg_5_2 ~= nil then
				local var_6_0 = arg_5_1

				var_1.extendData(var_6_0, {
					fromMediatorName = arg_5_2.mediator.__cname
				})

				local var_6_1 = var_5_2

				var_1.removeLayerMediator(var_6_1, arg_5_0.facade, arg_5_2, function(arg_7_0)
					var_5_3 = arg_7_0

					arg_6_0()

					return
				end)
			else
				arg_6_0()
			end

			return
		end,
		function(arg_8_0)
			if var_5_3 then
				table = var_1

				var_1.SerialIpairsAsync(var_5_3, function(arg_9_0, arg_9_1, arg_9_2)
					local var_9_0 = var_5_2

					var_3.remove(var_9_0, arg_9_1.mediator, function()
						if arg_9_0 == #var_5_3 then
							local var_10_0 = arg_9_1.context

							var_0.onContextRemoved(var_10_0)
						end

						arg_9_2()

						return
					end)

					return
				end, arg_8_0)
			else
				arg_8_0()
			end

			return
		end,
		function(arg_11_0)
			if arg_5_1.cleanStack then
				local var_11_0 = var_5_1

				var_1.cleanContext(var_11_0)
			end

			local var_11_1 = var_5_1

			var_1.pushContext(var_11_1, arg_5_1)
			arg_11_0()

			return
		end,
		function(arg_12_0)
			if arg_5_1 and arg_5_1.cleanChild then
				arg_5_1.children = {}
				arg_5_1.cleanChild = false
			end

			local var_12_0 = {
				function(arg_13_0)
					local var_13_0 = {}

					ipairs = var_3_10002

					local var_13_1 = arg_5_1

					for iter_13_0, iter_13_1 in var_3_10002(var_3.GetHierarchy(var_13_1)) do
						local var_13_2 = iter_13_1.viewComponent.New()

						table = var_3_10008

						var_3_10008.insertto(var_13_0, var_13_2:preloadUIList())
					end

					parallelAsync = var_2
					underscore = var_3

					var_2(var_3.map(var_13_0, function(arg_14_0)
						return function(arg_15_0)
							PoolMgr = var_5_10001

							local var_15_0 = var_5_10001.GetInstance()

							var_1.PreloadUI(var_15_0, arg_14_0, arg_15_0)

							return
						end
					end), arg_13_0)

					return
				end,
				function(arg_16_0)
					local var_16_0 = var_5_2

					var_1.prepare(var_16_0, arg_5_0.facade, arg_5_1, function(arg_17_0)
						local var_17_0 = arg_5_0
						local var_17_1 = var_1.sendNotification

						GAME = var_4_10003

						var_17_1(var_17_0, var_4_10003.START_LOAD_SCENE, arg_17_0)

						var_5_4 = arg_17_0

						arg_16_0()

						return
					end)

					return
				end,
				function(arg_18_0)
					local var_18_0 = var_5_2

					var_1.prepareLayer(var_18_0, arg_5_0.facade, nil, arg_5_1, function(arg_19_0)
						local var_19_0 = arg_5_0
						local var_19_1 = var_1.sendNotification

						GAME = var_4_10003

						var_19_1(var_19_0, var_4_10003.WILL_LOAD_LAYERS, #arg_19_0)

						var_5_5 = arg_19_0

						arg_18_0()

						return
					end)

					return
				end
			}

			seriesAsync = var_2

			var_2(var_12_0, arg_12_0)

			return
		end,
		function(arg_20_0)
			if arg_5_1.cleanCacheUI then
				local var_20_0 = var_5_2

				var_1.clearCacheUI(var_20_0)
			end

			local var_20_1 = var_5_2
			local var_20_2 = var_1.enter

			table = var_2_10003

			var_20_2(var_20_1, var_2_10003.insertto({
				var_5_4
			}, var_5_5), arg_20_0)

			return
		end
	}

	pg = var_11

	local var_5_7 = var_11.UIMgr.GetInstance()

	var_11.LoadingOn(var_5_7)

	underscore = var_11

	local var_5_8 = var_11.map
	local var_5_9

	if not arg_5_1.irregularSequence or not {
		1,
		2,
		3,
		4,
		5
	} then
		var_5_9 = {
			1,
			3,
			4,
			2,
			5
		}
	end

	local var_5_10 = var_5_8(var_5_9, function(arg_21_0)
		return var_5_6[arg_21_0]
	end)

	seriesAsync = var_5_9

	var_5_9(var_5_10, function()
		existCall = var_2_10000

		var_2_10000(arg_5_4)

		pg = var_2_10000

		local var_22_0 = var_2_10000.UIMgr.GetInstance()

		var_0.LoadingOff(var_22_0)

		local var_22_1 = arg_5_0
		local var_22_2 = var_0.sendNotification

		GAME = var_2_10002

		var_22_2(var_22_1, var_2_10002.LOAD_SCENE_DONE, arg_5_1.scene)

		return
	end)

	return
end

function var_0_1.loadLayer(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	assert = var_1_10004
	isa = var_1_10005

	local var_23_0 = arg_23_1

	Context = var_1_10007

	var_1_10004(var_1_10005(var_23_0, var_1_10007), "should be an instance of Context")

	pg = var_1_10004

	local var_23_1 = var_1_10004.SceneMgr.GetInstance()
	local var_23_2 = {}
	local var_23_3 = {
		function(arg_24_0)
			local var_24_0 = var_23_1

			var_1.prepareLayer(var_24_0, arg_23_0.facade, arg_23_2, arg_23_1, function(arg_25_0)
				local var_25_0 = arg_23_0
				local var_25_1 = var_1.sendNotification

				GAME = var_3_10003

				var_25_1(var_25_0, var_3_10003.WILL_LOAD_LAYERS, #arg_25_0)

				var_23_2 = arg_25_0

				arg_24_0()

				return
			end)

			return
		end,
		function(arg_26_0)
			local var_26_0 = var_23_1

			var_1.enter(var_26_0, var_23_2, arg_26_0)

			return
		end
	}

	pg = var_7

	local var_23_4 = var_7.UIMgr.GetInstance()

	var_7.LoadingOn(var_23_4)

	seriesAsync = var_7

	var_7(var_23_3, function()
		existCall = var_2_10000

		var_2_10000(arg_23_3)

		pg = var_2_10000

		local var_27_0 = var_2_10000.UIMgr.GetInstance()

		var_0.LoadingOff(var_27_0)

		local var_27_1 = arg_23_0
		local var_27_2 = var_0.sendNotification

		GAME = var_2_10002

		var_27_2(var_27_1, var_2_10002.LOAD_LAYER_DONE, arg_23_1)

		return
	end)

	return
end

function var_0_1.LoadLayerOnTopContext(arg_28_0)
	getProxy = var_1_10001
	ContextProxy = var_1_10002

	local var_28_0 = var_1_10001(var_1_10002)
	local var_28_1 = var_1.getCurrentContext(var_28_0)

	pg = var_28_0

	local var_28_2 = var_28_0.m02
	local var_28_3 = var_3.sendNotification

	GAME = var_1_10005

	var_28_3(var_28_2, var_1_10005.LOAD_LAYERS, {
		parentContext = var_28_1,
		context = arg_28_0
	})

	return
end

function var_0_1.RemoveLayerByMediator(arg_29_0)
	getProxy = var_1_10001
	ContextProxy = var_1_10002

	local var_29_0 = var_1_10001(var_1_10002)
	local var_29_1 = var_1.getCurrentContext(var_29_0)

	if var_1.getContextByMediator(var_29_1, arg_29_0) then
		pg = var_29_1

		local var_29_2 = var_29_1.m02
		local var_29_3 = var_3.sendNotification

		GAME = var_1_10005

		var_29_3(var_29_2, var_1_10005.REMOVE_LAYERS, {
			context = var_2
		})

		return true
	end

	return
end

return var_0_1
