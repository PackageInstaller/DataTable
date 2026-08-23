local LuaGcService = class("LuaGcService")

function LuaGcService:ctor()
	self._fullGcTime = 0
	self._stepGcTime = 0

	g.core.common.Scheduler:newSchedule(handler(self, self.update), 1)
end

function LuaGcService:update()
	if os.time() - self._stepGcTime >= 5 then
		self._stepGcTime = os.time()

		g.core.config:checkConfigDataClear(false)
		collectgarbage("step", 5)
	end

	if collectgarbage("count") >= 200000 and os.time() - self._fullGcTime >= g.core.const.ConstMgr.BASE_CONST.LUA_GC_COLLECT_DELTA then
		self._fullGcTime = os.time()

		collectgarbage("collect")
	end
end

function LuaGcService:resetFullGCTime()
	self._fullGcTime = 0
end

function LuaGcService:dumpAllG(arg_4_1)
	self._saveIndex = not self._saveIndex and 999 or self._saveIndex == 999 and 1 or not arg_4_1 and self._saveIndex + 1 or arg_4_1
	self._specialTable = {}
	self._specialTable["[_G].g.core.network.proto."] = 0
	self._specialTable["[_G].module.[function:environment].loaded.protobuf."] = 0
	self._specialTable["[_G].module.[function:environment].loaded.app.core.network.protocol"] = 0
	self._specialTable["[_G].module.[function:environment].loaded.app.core.network.ProtoBuilder."] = 0
	self._specialTable["[_G].module.[function:environment].loaded.app.core.common.Provider."] = 0
	self._specialTable["[_G].module.[function:environment].preload."] = 0
	self._specialTable["[_G].module.[function:environment].loaded.os."] = 0
	self._specialTable["[_G].module.[function:environment].loaded.pb."] = 0
	self._specialTable["[_G].module.[function:environment].loaded.math."] = 0
	self._specialTable["[_G].module.[function:environment].loaded.cjson."] = 0
	self._specialTable["[_G].module.[function:environment].loaded.string."] = 0
	self._specialTable["[_G].module.[function:environment].loaded.cc.utils."] = 0
	self._specialTable["[_G].module.[function:environment].loaded.upgrade.Env."] = 0
	self._specialTable["[_G].module.[function:environment].loaded.debug.watcher."] = 0
	self._specialTable["[_G].module.[function:environment].loaded.app.core.fairygui."] = 0
	self._specialTable["[_G].module.[function:environment].loaded.app.core.lang."] = 0
	self._specialTable["[_G].module.[function:environment].loaded.app.core.config.cfg"] = 0
	self._specialTable["[_G].module.[function:environment].loaded.app.core.config.ConfigProxy."] = 0
	self._specialTable["[_G].g.core.common.Path."] = 0
	self._specialTable["[_G].module.[function:environment].loaded.app.core.common.Path"] = 0
	self._specialTable["[_G].module.[function:environment].loaded.app.package.module."] = 0
	self._specialTable["[_G].module.[function:environment].loaded.app.view.entrance.ModuleEntrance."] = 0
	self._specialTable["[_G].module.[function:environment].loaded.app.view.battle.const.BattleConst."] = 0
	self._specialTable["[_G].module.[function:environment].loaded.app.view.common.const.FunctionConst."] = 0
	self._specialTable["[_G].g.core.platform.ServerListProxy._recommendList."] = 0
	self._specialTable["[_G].module.[function:environment].loaded.app.core.service.GuideService[class:GuideService]."] = 0
	self._specialTable["[_G].g.core.common.Color."] = 0
	self._specialTable["[_G].module.[function:environment].loaded.app.core.common.Color."] = 0
	self._specialTable["[_G].g.core.event.EventManager."] = 0
	self._specialTable["[_G].module.[function:environment].loaded.app.core.event.enum."] = 0
	self._specialTable["[_G].g.core.shader.ShaderMgr."] = 0
	self._specialTable["[_G].g.core.layer.LayerManager."] = 0
	self._specialTable["[_G].g.core.module.ModuleManager."] = 0
	self._specialTable["[_G].g.core.service.ServiceManager."] = 0
	self._specialTable["[_G].g.view.entrance.ModuleGotoProxy."] = 0
	self._specialTable["[_G].module.[function:environment].loaded.app.view.module.debug."] = 0
	self._specialTable["[_G].module.[function:environment].loaded.app.view.module.login.view.LoginLayer"] = 0
	self._specialTable["[_G].uf."] = 0
	self._specialTable["[_G].cc."] = 0
	self._specialTable["[_G].io."] = 0
	self._specialTable["[_G].gl."] = 0
	self._specialTable["[_G].pb."] = 0
	self._specialTable["[_G].os."] = 0
	self._specialTable["[_G].sp."] = 0
	self._specialTable["[_G].db."] = 0
	self._specialTable["[_G].bit."] = 0
	self._specialTable["[_G].jit."] = 0
	self._specialTable["[_G].csm."] = 0
	self._specialTable["[_G].ccs."] = 0
	self._specialTable["[_G].lfs."] = 0
	self._specialTable["[_G].json."] = 0
	self._specialTable["[_G].math."] = 0
	self._specialTable["[_G].fgui."] = 0
	self._specialTable["[_G].ccui."] = 0
	self._specialTable["[_G].ccexp."] = 0
	self._specialTable["[_G].tolua."] = 0
	self._specialTable["[_G].debug."] = 0
	self._specialTable["[_G].audio."] = 0
	self._specialTable["[_G].table."] = 0
	self._specialTable["[_G].string."] = 0
	self._specialTable["[_G].device."] = 0
	self._specialTable["[_G].display."] = 0
	self._specialTable["[_G].package."] = 0
	self._specialTable["[_G].protobuf."] = 0
	self._specialTable["[_G].coroutine."] = 0
	self._specialTable["[_G].transition."] = 0
	self._specialTable["[_G].cricocos2d."] = 0
	self._specialTable["[_G].Sprite."] = 0
	self._specialTable["[_G].CCSize."] = 0
	self._specialTable["[_G].CCRect."] = 0
	self._specialTable["[_G].CCPoint."] = 0
	self._specialTable["[_G].CCArray."] = 0
	self._specialTable["[_G].CCString."] = 0
	self._specialTable["[_G].PathData."] = 0
	self._specialTable["[_G].PathSearch."] = 0
	self._specialTable["[_G].WWiseHelper."] = 0
	self._specialTable["[_G].AudioEngine."] = 0
	self._specialTable["[_G].AnimationData."] = 0
	self._specialTable["[_G].ScriptHandlerMgr."] = 0
	self._specialTable["[_G].MsgProcessHandler."] = 0
	self._specialTable["[_G].FlashBones."] = 0
	self._specialTable["[_G].FlashMotion."] = 0
	self._specialTable["[_G].FlashLoader."] = 0
	self._specialTable["[_G].FlashFactory."] = 0
	self._specialTable["[_G].FlashAnimation."] = 0
	self._specialTable["[_G].FlashEffectNode."] = 0
	self._specialTable["[_G].FlashEffectSprite."] = 0
	self._specialTable["[_G].FlashSkeletonFactory."] = 0
	self._specialTable["[_G].sp.SkeletonRenderer."] = 0
	self._specialTable["[_G].sp.SkeletonAnimation."] = 0
	self._dumpList = {}

	local var_4_0 = self:createObjectInfoContainer()

	self:dumpAllGNew("", _G, var_4_0)

	self._resultList = {}

	self:OutputMemorySnapshot("", _G, nil, var_4_0)
end

function LuaGcService:createObjectInfoContainer()
	local var_5_0 = {}
	local var_5_1 = {}

	setmetatable(var_5_1, {
		__mode = "k"
	})

	local var_5_2 = {}

	setmetatable(var_5_2, {
		__mode = "k"
	})

	var_5_0.m_cObjectReferenceCount = var_5_1
	var_5_0.m_cObjectAddressToName = var_5_2
	var_5_0.m_nStackLevel = -1
	var_5_0.m_strShortSrc = "None"
	var_5_0.m_nCurrentLine = -1

	return var_5_0
end

function LuaGcService:dumpAllGNew(arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_2 then
		return
	end

	arg_6_1 = arg_6_1 or ""

	local var_6_0 = false

	for iter_6_0, iter_6_1 in pairs(self._specialTable) do
		if string.find(arg_6_1, iter_6_0, 1, true) then
			var_6_0 = true
			self._specialTable[iter_6_0] = iter_6_1 + 1

			return
		end
	end

	if not var_6_0 then
		table.insert(self._dumpList, "+ " .. arg_6_1)
	end

	arg_6_3 = arg_6_3 or self:createObjectInfoContainer()

	if arg_6_3.m_nStackLevel > 0 then
		local var_6_1 = debug.getinfo(arg_6_3.m_nStackLevel, "Sl")

		if var_6_1 then
			arg_6_3.m_strShortSrc = var_6_1.short_src
			arg_6_3.m_nCurrentLine = var_6_1.currentline
		end

		arg_6_3.m_nStackLevel = -1
	end

	local var_6_2 = arg_6_3.m_cObjectReferenceCount
	local var_6_3 = arg_6_3.m_cObjectAddressToName
	local var_6_4 = type(arg_6_2)

	if var_6_4 == "table" then
		if rawget(arg_6_2, "__cname") then
			if type(arg_6_2.__cname) == "string" then
				arg_6_1 = arg_6_1 .. "[class:" .. arg_6_2.__cname .. "]"
			end
		elseif rawget(arg_6_2, "class") then
			if type(arg_6_2.class) == "string" then
				arg_6_1 = arg_6_1 .. "[class:" .. arg_6_2.class .. "]"
			end
		elseif rawget(arg_6_2, "_className") and type(arg_6_2._className) == "string" then
			arg_6_1 = arg_6_1 .. "[class:" .. arg_6_2._className .. "]"
		end

		if arg_6_2 == _G then
			arg_6_1 = arg_6_1 .. "[_G]"
		end

		local var_6_5 = false
		local var_6_6 = false
		local var_6_7 = getmetatable(arg_6_2)

		if var_6_7 then
			local var_6_8 = rawget(var_6_7, "__mode")

			if var_6_8 then
				if string.find(var_6_8, "k") then
					var_6_5 = true
				end

				if string.find(var_6_8, "v") then
					var_6_6 = true
				end
			end
		end

		if var_6_2[arg_6_2] then
			var_6_2[arg_6_2] = var_6_2[arg_6_2] + 1 or 1
		end

		if var_6_3[arg_6_2] then
			return
		end

		var_6_3[arg_6_2] = arg_6_1

		for iter_6_2, iter_6_3 in pairs(arg_6_2) do
			local var_6_9 = type(iter_6_2)

			if var_6_9 == "table" then
				if not var_6_5 then
					self:dumpAllGNew(arg_6_1 .. ".[table:key.table]", iter_6_2, arg_6_3)
				end

				if not var_6_6 then
					self:dumpAllGNew(arg_6_1 .. ".[table:value]", iter_6_3, arg_6_3)
				end
			elseif var_6_9 == "function" then
				if not var_6_5 then
					self:dumpAllGNew(arg_6_1 .. ".[table:key.function]", iter_6_2, arg_6_3)
				end

				if not var_6_6 then
					self:dumpAllGNew(arg_6_1 .. ".[table:value]", iter_6_3, arg_6_3)
				end
			elseif var_6_9 == "thread" then
				if not var_6_5 then
					self:dumpAllGNew(arg_6_1 .. ".[table:key.thread]", iter_6_2, arg_6_3)
				end

				if not var_6_6 then
					self:dumpAllGNew(arg_6_1 .. ".[table:value]", iter_6_3, arg_6_3)
				end
			elseif var_6_9 == "userdata" then
				if not var_6_5 then
					self:dumpAllGNew(arg_6_1 .. ".[table:key.userdata]", iter_6_2, arg_6_3)
				end

				if not var_6_6 then
					self:dumpAllGNew(arg_6_1 .. ".[table:value]", iter_6_3, arg_6_3)
				end
			else
				self:dumpAllGNew(arg_6_1 .. "." .. iter_6_2, iter_6_3, arg_6_3)
			end
		end

		if var_6_7 then
			self:dumpAllGNew(arg_6_1 .. ".[metatable]", var_6_7, arg_6_3)
		end
	elseif var_6_4 == "function" then
		local var_6_10 = debug.getinfo(0, "Su")

		if var_6_2[arg_6_2] then
			var_6_2[arg_6_2] = var_6_2[arg_6_2] + 1 or 1
		end

		if var_6_3[arg_6_2] then
			return
		end

		var_6_3[arg_6_2] = arg_6_1 .. "[line:" .. tostring(var_6_10.linedefined) .. "@file:" .. var_6_10.short_src .. "]"

		for iter_6_4 = 1, var_6_10.nups do
			local var_6_11, var_6_12 = debug.getupvalue(arg_6_2, iter_6_4)
			local var_6_13 = type(var_6_12)

			if var_6_13 == "table" then
				self:dumpAllGNew(arg_6_1 .. ".[ups:table:" .. var_6_11 .. "]", var_6_12, arg_6_3)
			elseif var_6_13 == "function" then
				self:dumpAllGNew(arg_6_1 .. ".[ups:function:" .. var_6_11 .. "]", var_6_12, arg_6_3)
			elseif var_6_13 == "thread" then
				self:dumpAllGNew(arg_6_1 .. ".[ups:thread:" .. var_6_11 .. "]", var_6_12, arg_6_3)
			elseif var_6_13 == "userdata" then
				self:dumpAllGNew(arg_6_1 .. ".[ups:userdata:" .. var_6_11 .. "]", var_6_12, arg_6_3)
			end
		end

		if debug.getfenv then
			local var_6_14 = debug.getfenv(arg_6_2)

			if var_6_14 then
				self:dumpAllGNew(arg_6_1 .. ".[function:environment]", var_6_14, arg_6_3)
			end
		end
	elseif var_6_4 == "thread" then
		if var_6_2[arg_6_2] then
			var_6_2[arg_6_2] = var_6_2[arg_6_2] + 1 or 1
		end

		if var_6_3[arg_6_2] then
			return
		end

		var_6_3[arg_6_2] = arg_6_1

		if debug.getfenv then
			local var_6_15 = debug.getfenv(arg_6_2)

			if var_6_15 then
				self:dumpAllGNew(arg_6_1 .. ".[thread:environment]", var_6_15, arg_6_3)
			end
		end

		local var_6_16 = getmetatable(arg_6_2)

		if var_6_16 then
			self:dumpAllGNew(arg_6_1 .. ".[thread:metatable]", var_6_16, arg_6_3)
		end
	elseif var_6_4 == "userdata" then
		if var_6_2[arg_6_2] then
			var_6_2[arg_6_2] = var_6_2[arg_6_2] + 1 or 1
		end

		if var_6_3[arg_6_2] then
			return
		end

		var_6_3[arg_6_2] = arg_6_1

		if debug.getfenv then
			local var_6_17 = debug.getfenv(arg_6_2)

			if var_6_17 then
				self:dumpAllGNew(arg_6_1 .. ".[userdata:environment]", var_6_17, arg_6_3)
			end
		end

		local var_6_18 = getmetatable(arg_6_2)

		if var_6_18 then
			self:dumpAllGNew(arg_6_1 .. ".[userdata:metatable]", var_6_18, arg_6_3)
		end
	elseif var_6_4 == "string" then
		if var_6_2[arg_6_2] then
			var_6_2[arg_6_2] = var_6_2[arg_6_2] + 1 or 1
		end

		if var_6_3[arg_6_2] then
			return
		end

		var_6_3[arg_6_2] = arg_6_1 .. "[" .. var_6_4 .. "]"
	end
end

function LuaGcService:OutputMemorySnapshot(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if not arg_7_4 then
		return
	end

	local var_7_0

	if arg_7_3 then
		var_7_0 = arg_7_3.m_cObjectReferenceCount or nil
	end

	local var_7_1 = arg_7_4.m_cObjectReferenceCount
	local var_7_2 = arg_7_4.m_cObjectAddressToName
	local var_7_3 = {}
	local var_7_4 = 0

	for iter_7_0 in pairs(arg_7_4.m_cObjectReferenceCount) do
		var_7_4 = var_7_4 + 1
		var_7_3[var_7_4] = iter_7_0
	end

	table.sort(var_7_3, function(arg_8_0, arg_8_1)
		return var_7_1[arg_8_0] > var_7_1[arg_8_1]
	end)

	if arg_7_3 then
		table.insert(self._resultList, "--------------------------------------------------------")
		table.insert(self._resultList, "-- This is compared memory information.")
		table.insert(self._resultList, "--------------------------------------------------------")
		table.insert(self._resultList, "-- Collect base memory reference at line:" .. tostring(arg_7_3.m_nCurrentLine) .. "@file:" .. arg_7_3.m_strShortSrc)
		table.insert(self._resultList, "-- Collect compared memory reference at line:" .. tostring(arg_7_4.m_nCurrentLine) .. "@file:" .. arg_7_4.m_strShortSrc)
	else
		table.insert(self._resultList, "--------------------------------------------------------")
		table.insert(self._resultList, "-- Collect memory reference at line:" .. tostring(arg_7_4.m_nCurrentLine) .. "@file:" .. arg_7_4.m_strShortSrc)
	end

	table.insert(self._resultList, "--------------------------------------------------------")
	table.insert(self._resultList, "-- [Table/Function/String Address/Name]\t[Reference Path]\t[Reference Count]")
	table.insert(self._resultList, "--------------------------------------------------------")

	if arg_7_1 and arg_7_2 then
		if type(arg_7_2) == "string" then
			table.insert(self._resultList, "-- From Root Object: \"" .. tostring(arg_7_2) .. "\" (" .. arg_7_1 .. ")")
		else
			table.insert(self._resultList, "-- From Root Object: " .. self:GetOriginalToStringResult(arg_7_2) .. " (" .. arg_7_1 .. ")")
		end
	end

	for iter_7_1, iter_7_2 in ipairs(var_7_3) do
		if not arg_7_3 or not var_7_0[iter_7_2] then
			if type(iter_7_2) == "string" then
				local var_7_5 = tostring(iter_7_2)
				local var_7_6, var_7_7 = string.find(var_7_5, "string: \".*\"")

				if not arg_7_3 then
					if var_7_6 ~= nil then
						if var_7_7 == nil then
							table.insert(self._resultList, "string: \"" .. string.gsub(var_7_5, "([\n\r])", "\\n") .. "\"\t" .. var_7_2[iter_7_2] .. "\t" .. tostring(var_7_1[iter_7_2]))

							goto label_7_0
						end
					end
				end

				table.insert(self._resultList, tostring(iter_7_2) .. "\t" .. var_7_2[iter_7_2] .. "\t" .. tostring(var_7_1[iter_7_2]))
			else
				table.insert(self._resultList, self:GetOriginalToStringResult(iter_7_2) .. "\t" .. var_7_2[iter_7_2] .. "\t" .. tostring(var_7_1[iter_7_2]))
			end
		end

		::label_7_0::
	end
end

function LuaGcService:GetOriginalToStringResult(arg_9_1)
	if not arg_9_1 then
		return ""
	end

	local var_9_0 = getmetatable(arg_9_1)

	if not var_9_0 then
		return tostring(arg_9_1)
	end

	local var_9_1 = ""
	local var_9_2 = rawget(var_9_0, "__tostring")

	if var_9_2 then
		rawset(var_9_0, "__tostring", nil)

		var_9_1 = tostring(arg_9_1)

		rawset(var_9_0, "__tostring", var_9_2)
	else
		var_9_1 = tostring(arg_9_1)
	end

	return var_9_1
end

function LuaGcService:saveAllGLog()
	local var_10_0 = io.open(device.writablePath .. "debug_G_log_" .. self._saveIndex .. ".txt", "w")
	local var_10_1 = {}

	for iter_10_0 = 1, #self._dumpList do
		if var_10_0 then
			var_10_0:write(self._dumpList[iter_10_0])
			var_10_0:write("\n")
		end

		table.insert(var_10_1, self._dumpList[iter_10_0])
	end

	if var_10_0 then
		var_10_0:close()
	end
end

function LuaGcService:saveAllGResult()
	local var_11_0 = io.open(device.writablePath .. "debug_G_result_" .. self._saveIndex .. ".txt", "w")
	local var_11_1 = {}

	for iter_11_0 = 1, #self._resultList do
		if var_11_0 then
			var_11_0:write(self._resultList[iter_11_0])
			var_11_0:write("\n")
		end

		table.insert(var_11_1, self._resultList[iter_11_0])
	end

	if var_11_0 then
		var_11_0:close()
	end
end

return LuaGcService
