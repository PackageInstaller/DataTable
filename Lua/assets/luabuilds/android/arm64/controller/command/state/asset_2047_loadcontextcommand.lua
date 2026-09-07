local LoadContextCommand = class("LoadContextCommand", pm.SimpleCommand)

LoadContextCommand.queue = {}

function LoadContextCommand:execute(arg_1_1)
	self:load(arg_1_1:getBody())

	return
end

function LoadContextCommand:load(arg_2_1)
	table.insert(LoadContextCommand.queue, arg_2_1)

	if #LoadContextCommand.queue == 1 then
		self:loadNext()
	end

	return
end

function LoadContextCommand:loadNext()
	if #LoadContextCommand.queue > 0 then
		local var_3_0 = LoadContextCommand.queue[1]

		local function var_3_1()
			if var_3_0.callback then
				var_3_0.callback()
			end

			table.remove(LoadContextCommand.queue, 1)
			self:loadNext()

			return
		end

		if LoadContextCommand.queue[1].type == LOAD_TYPE_SCENE then
			self:loadScene(LoadContextCommand.queue[1].context, LoadContextCommand.queue[1].prevContext, LoadContextCommand.queue[1].isBack, var_3_1)
		elseif LoadContextCommand.queue[1].type == LOAD_TYPE_LAYER then
			self:loadLayer(LoadContextCommand.queue[1].context, LoadContextCommand.queue[1].parentContext, var_3_1)
		else
			assert(false, "context load type not support: " .. LoadContextCommand.queue[1].type)
		end
	end

	return
end

function LoadContextCommand:loadScene(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	assert(isa(arg_5_1, Context), "should be an instance of Context")

	local var_5_0 = getProxy(ContextProxy)
	local var_5_1 = pg.SceneMgr.GetInstance()
	local var_5_2
	local var_5_3
	local var_5_4 = {}
	local var_5_5 = {
		function(arg_6_0)
			if arg_5_2 ~= nil then
				arg_5_1:extendData({
					fromMediatorName = arg_5_2.mediator.__cname
				})
				var_5_1:removeLayerMediator(self.facade, arg_5_2, function(arg_7_0)
					var_5_2 = arg_7_0

					arg_6_0()

					return
				end)
			else
				arg_6_0()
			end

			return
		end,
		function(arg_8_0)
			if var_5_2 then
				table.SerialIpairsAsync(var_5_2, function(arg_9_0, arg_9_1, arg_9_2)
					var_5_1:remove(arg_9_1.mediator, function()
						if arg_9_0 == #var_5_2 then
							arg_9_1.context:onContextRemoved()
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
				var_5_0:cleanContext()
			end

			var_5_0:pushContext(arg_5_1)
			arg_11_0()

			return
		end,
		function(arg_12_0)
			if arg_5_1 and arg_5_1.cleanChild then
				arg_5_1.children = {}
				arg_5_1.cleanChild = false
			end

			seriesAsync({
				function(arg_13_0)
					local var_13_0 = {}

					for iter_13_0, iter_13_1 in ipairs(arg_5_1:GetHierarchy()) do
						table.insertto(var_13_0, iter_13_1.viewComponent.New():preloadUIList())
					end

					parallelAsync(underscore.map(var_13_0, function(arg_14_0)
						return function(arg_15_0)
							PoolMgr.GetInstance():PreloadUI(arg_14_0, arg_15_0)

							return
						end
					end), arg_13_0)

					return
				end,
				function(arg_16_0)
					var_5_1:prepare(self.facade, arg_5_1, function(arg_17_0)
						self:sendNotification(GAME.START_LOAD_SCENE, arg_17_0)

						var_5_3 = arg_17_0

						arg_16_0()

						return
					end)

					return
				end,
				function(arg_18_0)
					var_5_1:prepareLayer(self.facade, nil, arg_5_1, function(arg_19_0)
						self:sendNotification(GAME.WILL_LOAD_LAYERS, #arg_19_0)

						var_5_4 = arg_19_0

						arg_18_0()

						return
					end)

					return
				end
			}, arg_12_0)

			return
		end,
		function(arg_20_0)
			if arg_5_1.cleanCacheUI then
				var_5_1:clearCacheUI()
			end

			var_5_1:enter(table.insertto({
				var_5_3
			}, var_5_4), arg_20_0)

			return
		end
	}

	pg.UIMgr.GetInstance():LoadingOn()
	seriesAsync(underscore.map(arg_5_1.irregularSequence and {
		1,
		2,
		3,
		4,
		5
	} or {
		1,
		3,
		4,
		2,
		5
	}, function(arg_21_0)
		return var_5_5[arg_21_0]
	end), function()
		existCall(arg_5_4)
		pg.UIMgr.GetInstance():LoadingOff()
		self:sendNotification(GAME.LOAD_SCENE_DONE, arg_5_1.scene)

		return
	end)

	return
end

function LoadContextCommand:loadLayer(arg_23_1, arg_23_2, arg_23_3)
	assert(isa(arg_23_1, Context), "should be an instance of Context")

	local var_23_0 = pg.SceneMgr.GetInstance()
	local var_23_1 = {}

	pg.UIMgr.GetInstance():LoadingOn()
	seriesAsync({
		function(arg_24_0)
			var_23_0:prepareLayer(self.facade, arg_23_2, arg_23_1, function(arg_25_0)
				self:sendNotification(GAME.WILL_LOAD_LAYERS, #arg_25_0)

				var_23_1 = arg_25_0

				arg_24_0()

				return
			end)

			return
		end,
		function(arg_26_0)
			var_23_0:enter(var_23_1, arg_26_0)

			return
		end
	}, function()
		existCall(arg_23_3)
		pg.UIMgr.GetInstance():LoadingOff()
		self:sendNotification(GAME.LOAD_LAYER_DONE, arg_23_1)

		return
	end)

	return
end

function LoadContextCommand:LoadLayerOnTopContext()
	pg.m02:sendNotification(GAME.LOAD_LAYERS, {
		parentContext = getProxy(ContextProxy):getCurrentContext(),
		context = self
	})

	return
end

function LoadContextCommand:RemoveLayerByMediator()
	local var_29_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(self)

	if var_29_0 then
		pg.m02:sendNotification(GAME.REMOVE_LAYERS, {
			context = var_29_0
		})

		return true
	end

	return
end

return LoadContextCommand
