pg = pg or {}
pg.SceneMgr = singletonClass("SceneMgr")

function pg.SceneMgr.Ctor(arg_1_0)
	arg_1_0._cacheUI = {}
	arg_1_0._gcLimit = 7
	arg_1_0._gcCounter = 0

	return
end

function pg.SceneMgr:prepare(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = arg_2_2.mediator
	local var_2_1
	local var_2_2

	if self._cacheUI[arg_2_2.mediator.__cname] ~= nil then
		var_2_2 = self._cacheUI[arg_2_2.mediator.__cname]
		self._cacheUI[arg_2_2.mediator.__cname] = nil
		var_2_1 = arg_2_2.mediator.New(var_2_2)

		var_2_1:setContextData(arg_2_2.data)
		arg_2_1:registerMediator(var_2_1)
		arg_2_3(var_2_1)
	else
		var_2_2 = arg_2_2.viewComponent.New()

		assert(isa(var_2_2, BaseUI), "should be an instance of BaseUI: " .. var_2_2.__cname)
		var_2_2:setContextData(arg_2_2.data)

		local function var_2_4()
			var_2_2.event:disconnect(BaseUI.LOADED, var_2_4)

			var_2_1 = var_2_0.New(var_2_2)

			var_2_1:setContextData(arg_2_2.data)
			arg_2_1:registerMediator(var_2_1)
			arg_2_3(var_2_1)

			return
		end

		if var_2_2:isLoaded() then
			var_2_4()
		else
			var_2_2.event:connect(BaseUI.LOADED, var_2_4)
			var_2_2:load()
		end
	end

	return
end

function pg.SceneMgr.prepareLayer(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = {}
	local var_4_1 = {}

	if arg_4_2 ~= nil then
		if arg_4_2:getContextByMediator(arg_4_3.mediator) then
			originalPrint("mediator already exist: " .. arg_4_3.mediator.__cname)
			arg_4_4(var_4_1)

			return
		end

		table.insert(var_4_0, arg_4_3)
		arg_4_2:addChild(arg_4_3)
	else
		table.insertto(var_4_0, arg_4_3.children)
	end

	local var_4_2 = {}

	while #var_4_0 > 0 do
		local var_4_3 = table.remove(var_4_0, 1)

		table.insert(var_4_2, function(arg_5_0)
			local var_5_0 = arg_4_1:retrieveMediator(var_4_3.parent.mediator.__cname):getViewComponent()

			arg_4_0:prepare(arg_4_1, var_4_3, function(arg_6_0)
				arg_6_0.viewComponent:attach(var_5_0)
				table.insert(var_4_1, arg_6_0)
				arg_5_0()

				return
			end)

			return
		end)
		table.insertto(var_4_0, var_4_3.children)
	end

	seriesAsync(var_4_2, function()
		arg_4_4(var_4_1)

		return
	end)

	return
end

function pg.SceneMgr.enter(arg_8_0, arg_8_1, arg_8_2)
	if #arg_8_1 == 0 then
		arg_8_2()
	end

	local var_8_0 = #arg_8_1

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		local var_8_1 = iter_8_1.viewComponent

		if iter_8_1.viewComponent._isCachedView then
			iter_8_1.viewComponent:setVisible(true)
		end

		local function var_8_3()
			var_8_1.event:disconnect(BaseUI.AVALIBLE, var_8_3)

			var_8_0 = var_8_0 - 1

			if var_8_0 == 0 then
				arg_8_2()
			end

			return
		end

		iter_8_1.viewComponent.event:connect(BaseUI.AVALIBLE, nil)
		iter_8_1.viewComponent:enter()
	end

	return
end

function pg.SceneMgr.removeLayer(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = {
		arg_10_2
	}
	local var_10_1 = {}

	while #var_10_0 > 0 do
		local var_10_2 = table.remove(var_10_0, 1)

		if var_10_2.mediator then
			table.insert(var_10_1, var_10_2)
		end

		table.insertto(var_10_0, var_10_2.children)
	end

	if arg_10_2.parent == nil then
		table.remove(var_10_1, 1)
	else
		arg_10_2.parent:removeChild(arg_10_2)
	end

	local var_10_3 = {}

	for iter_10_0 = #var_10_1, 1, -1 do
		local var_10_4 = var_10_1[iter_10_0]
		local var_10_5 = arg_10_1:removeMediator(var_10_1[iter_10_0].mediator.__cname)

		table.insert(var_10_3, function(arg_11_0)
			if var_10_5 then
				arg_10_0:remove(var_10_5, function()
					var_10_4:onContextRemoved()
					arg_11_0()

					return
				end)
			else
				arg_11_0()
			end

			return
		end)
	end

	seriesAsync(var_10_3, arg_10_3)

	return
end

function pg.SceneMgr.removeLayerMediator(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = {
		arg_13_2
	}
	local var_13_2 = {}

	while #var_13_0 > 0 do
		local var_13_3 = table.remove(var_13_0, 1)

		if var_13_3.mediator then
			table.insert(var_13_2, var_13_3)
		end

		table.insertto(var_13_0, var_13_3.children)
	end

	if arg_13_2.parent ~= nil then
		arg_13_2.parent:removeChild(arg_13_2)
	end

	local var_13_4 = {}

	for iter_13_0 = #var_13_2, 1, -1 do
		local var_13_5 = arg_13_1:removeMediator(var_13_2[iter_13_0].mediator.__cname)

		if var_13_5 then
			local var_13_6 = var_13_5:getViewComponent()

			if var_13_6:CheckTempCache() then
				PoolMgr.GetInstance():KeepUICache(var_13_6:getUIName(), false)
			end

			table.insert(var_13_4, {
				mediator = var_13_5,
				context = var_13_2[iter_13_0]
			})
		end
	end

	arg_13_3(var_13_4)

	return
end

function pg.SceneMgr:remove(arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1:getViewComponent()

	if var_14_0 == nil then
		arg_14_2()
	end

	if var_14_0:needCache() and not self._cacheUI[arg_14_1.__cname] then
		var_14_0:setVisible(false)

		self._cacheUI[arg_14_1.__cname] = var_14_0
		var_14_0._isCachedView = true

		arg_14_2()
	else
		var_14_0._isCachedView = false

		self:removeView(var_14_0, arg_14_2)
	end

	return
end

function pg.SceneMgr.removeView(arg_15_0, arg_15_1, arg_15_2)
	arg_15_1._isCachedView = false

	arg_15_1.event:connect(BaseUI.DID_EXIT, function()
		arg_15_1.event:clear()
		arg_15_0:gc(arg_15_1)
		arg_15_2()

		return
	end)
	arg_15_1:exit()

	return
end

function pg.SceneMgr:clearCacheUI()
	parallelAsync(underscore(self._cacheUI):chain():values():map(function(arg_18_0)
		return function(arg_19_0)
			self:removeView(arg_18_0, arg_19_0)

			return
		end
	end):value(), function()
		self._cacheUI = {}

		return
	end)

	return
end

function pg.SceneMgr:gc(arg_21_1)
	table.clear(arg_21_1)

	arg_21_1.exited = true

	if arg_21_1:DontGC() then
		return
	end

	if arg_21_1:forceGC() or self._gcCounter >= self._gcLimit then
		self._gcCounter = 0

		gcAll(false)
	else
		self._gcCounter = self._gcCounter + 1

		GCThread.GetInstance():LuaGC(false)
	end

	return
end

return
