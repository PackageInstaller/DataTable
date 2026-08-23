local DebugQAComp = class("DebugQAComp", require("app.fairyGUI.debug.UI_DebugQAComp"))

function DebugQAComp:ctor()
	self:_init()
end

function DebugQAComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_ACCOUNT_INFO_CALLBACK, self.onGetAccountInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_BIND_ACCOUNT_SUCCESS, self.onBindSuccess, self)
end

function DebugQAComp:_init()
	self.m_test:addClickListener(handler(self, self._onTestBattleClick))
	self.m_auto:addClickListener(handler(self, self._onAutoBtnClick))
	self.m_btn_share:addClickListener(handler(self, self._onShareBtnClick))
	self.m_btn_puzzle:addClickListener(handler(self, self._onPuzzleBtnClick))
	self.m_test_fight:addClickListener(handler(self, self._onTestFightClick))
	self.m_test_fight2:addClickListener(handler(self, self._onTestFight2Click))
	self.m_test_fight3:addClickListener(handler(self, self._onTestFight3Click))
	self.m_test_fight4:addClickListener(handler(self, self._onTestFight4Click))
	self.m_fogBtn:addClickListener(handler(self, self._onFogBtnClick))
	self.m_logUserData:addClickListener(handler(self, self._onLogUserClick))
	self.m_chaosBtn:addClickListener(handler(self, self.getIdStrByChaos))
	self:addEventListener(fgui.UIEventType.ClickLink, handler(self, self._onLinkTextClick))
	self.m_bindFaceBookBtn:addClickListener(handler(self, self.onBindFaceBook))
	self.m_bindTwitterBtn:addClickListener(handler(self, self.onBindTwitter))
	self.m_bindGtaBtn:addClickListener(handler(self, self.onBindGta))
	self.m_bindFaceBookBtn:setVisible(false)
	self.m_bindTwitterBtn:setVisible(false)
	self.m_bindGtaBtn:setVisible(false)
	self.m_checkRedBtn:addClickListener(handler(self, self._onCheckRedBtnClick))
	self.m_showUser:setVisible(false)
	g.core.platform.PlatformProxy:accountInfoJson()
	self.m_configPatchBtn:addClickListener(handler(self, self._onConfigPatchBtnClick))
end

function DebugQAComp:_onLinkTextClick(arg_4_1, arg_4_2)
	print("======================>_onLinkTextClick", arg_4_1:getDataValue())
end

function DebugQAComp:onBindFaceBook()
	g.core.platform.PlatformProxy:showAccountLinkJson("Facebook")
end

function DebugQAComp:onBindTwitter()
	g.core.platform.PlatformProxy:showAccountLinkJson("Twitter")
end

function DebugQAComp:onBindGta()
	g.core.platform.PlatformProxy:showAccountLinkJson("GTA")
end

function DebugQAComp:onGetAccountInfo(arg_8_1, arg_8_2)
	if not arg_8_2.data.gta or arg_8_2.data.gta == 0 then
		self.m_bindGtaBtn:setVisible(true)
	end

	if not arg_8_2.data.facebook or arg_8_2.data.facebook == 0 then
		self.m_bindFaceBookBtn:setVisible(true)
	end

	if not arg_8_2.data.twitter or arg_8_2.data.twitter == 0 then
		self.m_bindTwitterBtn:setVisible(true)
	end
end

function DebugQAComp:onBindSuccess(arg_9_1, arg_9_2)
	g.core.module.ModuleManager:tip("绑定成-->", arg_9_2)
end

function DebugQAComp:_onAutoBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.debug.pop.ProtoPop").new())
end

function DebugQAComp:_onTestBattleClick()
	g.core.module.ModuleManager:tip("测试战斗")

	do return end

	self:addPopup(require("app.view.module.debug.TestBattleLayer").new())
end

function DebugQAComp:_onTestFightClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.debug.pop.DebugMuiltFightPop").new())
end

function DebugQAComp:_onTestFight2Click()
	g.core.module.ModuleManager:tip("3v3")

	return
end

function DebugQAComp:_onTestFight3Click()
	g.core.module.ModuleManager:tip("平衡测试2")

	return
end

function DebugQAComp:_onTestFight4Click()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.debug.pop.DebugMuiltFightPop2").new())
end

function DebugQAComp:_onShareBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHARE_LAYER)
end

function DebugQAComp:_onPuzzleBtnClick()
	local var_17_1 = self.m_txt_puzzle:getText()

	g.core.module.ModuleManager:pushModule(g.view.entrance.PUZZLE_GAME, {
		level = (var_17_1 and tonumber(var_17_1) ~= nil or nil) and tonumber(var_17_1)
	})
end

function DebugQAComp:_onLogUserClick()
	if self.m_showUser:isVisible() then
		self.m_showUser:setVisible(false)

		return
	end

	self.m_showUser:setVisible(true)

	local var_18_0 = clone(g.core.model.User:getUserData()) or {}

	dump(var_18_0)

	local var_18_1 = {}

	for iter_18_0, iter_18_1 in pairs(var_18_0) do
		if type(iter_18_1) == "number" or type(iter_18_1) == "string" then
			table.insert(var_18_1, iter_18_0 .. " : " .. iter_18_1)
		end
	end

	self.m_userText:setText(table.concat(var_18_1, "\n"), false, true)
end

function DebugQAComp:_onFogBtnClick()
	g.core.model.User.fogNightmareData:getAutoPlay():setForceOpenAuto(true)
end

function DebugQAComp:_onCheckRedBtnClick()
	local var_20_0 = tonumber(self.m_txt_red:getText())

	if var_20_0 then
		local var_20_1 = g.core.model.User.redPointData:getRedPointStruct(var_20_0)

		if var_20_1 then
			local var_20_2 = var_20_1:debugTraceRedPoint({})

			if var_20_2 then
				g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
					title = g.core.lang:get(111026),
					desc = var_20_2
				}), {
					touchDisappear = true
				})
			end
		end
	end
end

function DebugQAComp:onShow()
	self:setVisible(true)
end

function DebugQAComp:onHide()
	self:setVisible(false)
end

function DebugQAComp:_onConfigPatchBtnClick()
	local var_23_0 = ""

	for iter_23_0, iter_23_1 in ipairs((self:getAllConfigName())) do
		var_23_0 = var_23_0 .. self:getConfigPatch(iter_23_1) .. "\n"
	end

	local var_23_1 = io.open("localPatch/tabPatch.lua", "w")

	if var_23_1 then
		var_23_1:write((string.format("local patch = {}\n\nfunction patch:onFetchConfigFinish(version)\n %s \n end\n return patch", var_23_0)))
		io.close(var_23_1)
		print("写入完毕...")
	else
		print("patch 文件创建失败，请检查文件夹")
	end
end

function DebugQAComp:getAllConfigName()
	local var_24_0 = {}

	for iter_24_0 in io.popen("dir /b /s " .. self:filterSpecialStr(self:getFileContent("patchPath.txt"), true)):lines() do
		local var_24_1 = iter_24_0:split("\\")

		if string.find(var_24_1[#var_24_1], ".lua") and not string.find(var_24_1[#var_24_1], "_data.lua") and not string.find(var_24_1[#var_24_1], "_key.lua") then
			var_24_0[#var_24_0 + 1] = var_24_1[#var_24_1]:gsub(".lua", "")
		end
	end

	return var_24_0
end

function DebugQAComp:getConfigPatch(arg_25_1)
	local var_25_0, var_25_1, var_25_2 = self:compareTwoConfig(loadstring((self:removeNextCordContent((self:insertPrivateFunc(self:getFileContent("localPatch/old/" .. arg_25_1 .. ".lua"), arg_25_1, "old")))))(), (loadstring((self:removeNextCordContent((self:insertPrivateFunc(self:getFileContent("localPatch/new/" .. arg_25_1 .. ".lua"), arg_25_1, "new")))))()))

	if table.nums(var_25_0) < 1 then
		print(string.format("warnning--------------->表%s无差异,如果没有达到预期，请检查表或通知小雨点...", arg_25_1))

		return ""
	end

	local var_25_3 = g.core.lang:getByString("\tlocal #configName# = require \"app.core.config.cfg.#configName#\" \n\tlocal d = #configName#._data \n\t", {
		configName = arg_25_1
	})
	local var_25_4 = ""

	for iter_25_0, iter_25_1 in pairs(var_25_0) do
		var_25_4 = var_25_4 .. g.core.lang:getByString("d[#idx#] = {#data#}\n\t", {
			idx = iter_25_0,
			data = table.concat(iter_25_1, ",")
		})
	end

	local var_25_5 = ""

	for iter_25_2, iter_25_3 in ipairs(var_25_1) do
		local var_25_6

		if iter_25_2 == 1 then
			var_25_5 = g.core.lang:getByString("\tlocal id = #configName#._patchKey\n\t", {
				configName = arg_25_1
			})
			var_25_6 = var_25_5
		end

		var_25_5 = var_25_5 .. g.core.lang:getByString("id[#id#] = #idx#\n\t", iter_25_3)
	end

	return var_25_3 .. (var_25_4 .. "\n" .. var_25_5) .. table.concat({
		"\n\t",
		arg_25_1,
		".patchClearOriginData()\n"
	})
end

function DebugQAComp:compareTwoConfig(arg_26_1, arg_26_2)
	local var_26_0 = arg_26_1.getInitData()
	local var_26_1 = arg_26_1.get_index_data()
	local var_26_2 = {}

	for iter_26_0, iter_26_1 in pairs((arg_26_1.getKeyMap())) do
		var_26_2[iter_26_1] = iter_26_0
	end

	local var_26_3 = {}
	local var_26_4 = {}
	local var_26_5 = {}
	local var_26_6 = 1
	local var_26_7 = arg_26_2.getStrLMap()
	local var_26_8 = arg_26_1.getStrLMap()

	for iter_26_2, iter_26_3 in pairs((arg_26_2.get_index_data())) do
		local var_26_9 = {
			iter_26_2
		}

		if type(iter_26_2) == "string" then
			var_26_9 = iter_26_2:split("_")
		end

		local var_26_10 = arg_26_2.get(unpack(var_26_9))
		local var_26_11 = {}
		local var_26_12

		if arg_26_1.get(unpack(var_26_9)) then
			var_26_11 = arg_26_1.get(unpack(var_26_9))
			var_26_12 = var_26_1[iter_26_2]
		else
			if arg_26_1.indexOf(iter_26_3) then
				var_26_12 = arg_26_1.getLength() + var_26_6
				var_26_6 = var_26_6 + 1
			else
				var_26_12 = iter_26_3
				var_26_6 = var_26_6 + 1
			end

			var_26_5[#var_26_5 + 1] = type(iter_26_2) == "string" and {
				idx = var_26_12,
				id = "\"" .. iter_26_2 .. "\""
			} or {
				idx = var_26_12,
				id = iter_26_2
			}
		end

		local var_26_13 = 0
		local var_26_14 = false
		local var_26_15 = {}
		local var_26_16 = {}

		if var_26_0 ~= nil then
			var_26_16[1] = var_26_13
		end

		for iter_26_4, iter_26_5 in ipairs(var_26_2) do
			local var_26_17 = var_26_10[iter_26_5]
			local var_26_18

			if var_26_0 then
				var_26_18 = var_26_0[iter_26_4]
			end

			if var_26_17 ~= var_26_11[iter_26_5] then
				var_26_14 = true
			end

			var_26_13 = var_26_13 + 2^(iter_26_4 - math.floor(iter_26_4 / 30) - 1)

			if type(var_26_17) == "string" then
				var_26_17 = self:filterSpecialStr(var_26_17, true)
				var_26_17 = string.format("\"%s\"", var_26_17)
			end

			if var_26_7[iter_26_5] then
				local var_26_19 = var_26_10
				local var_26_20

				if var_26_17 == var_26_11[iter_26_5] then
					var_26_19 = var_26_11
					var_26_20 = {}
				end

				var_26_20.value = var_26_17

				function var_26_20.getKey()
					return string.format("\"%s\"", var_26_19[iter_26_5])
				end

				var_26_17 = var_26_20
			end

			var_26_15[#var_26_15 + 1] = var_26_17

			if var_26_18 ~= nil then
				if iter_26_4 % 30 == 0 then
					var_26_16[#var_26_16 + 1] = var_26_13
					var_26_13 = 0
				else
					var_26_16[#var_26_16] = var_26_13
				end
			end
		end

		if var_26_14 then
			for iter_26_6, iter_26_7 in ipairs(var_26_16) do
				var_26_15[#var_26_15 + 1] = 1073741823
			end

			var_26_3[var_26_12] = var_26_15
			var_26_4[iter_26_2] = true
		end
	end

	for iter_26_8, iter_26_9 in pairs(var_26_7) do
		var_26_7[iter_26_8] = nil
	end

	for iter_26_10, iter_26_11 in pairs(var_26_8) do
		var_26_8[iter_26_10] = nil
	end

	for iter_26_12, iter_26_13 in pairs(var_26_3) do
		for iter_26_14, iter_26_15 in pairs(iter_26_13) do
			if type(iter_26_15) == "table" and iter_26_15.getKey then
				iter_26_13[iter_26_14] = iter_26_15.getKey()
			end
		end
	end

	return var_26_3, var_26_5, var_26_4
end

function DebugQAComp:getFileContent(arg_28_1)
	local var_28_0 = io.open(arg_28_1)
	local var_28_1 = ""

	if var_28_0 then
		var_28_1 = var_28_0:read("*a")

		io.close(var_28_0)
	end

	return var_28_1
end

function DebugQAComp:insertPrivateFunc(arg_29_1, arg_29_2, arg_29_3)
	arg_29_1 = string.gsub(arg_29_1, "loadCfg%(\"core%.config%.cfg%.([^\"]+)_data\"%)", function(arg_30_0)
		return "require(\"localPatch." .. arg_29_3 .. "." .. arg_30_0 .. "_data\")"
	end)
	arg_29_1 = string.gsub(arg_29_1, "loadCfg%(\"core%.config%.cfg%.([^\"]+)_key\"%)", function(arg_31_0)
		return "require(\"localPatch." .. arg_29_3 .. "." .. arg_31_0 .. "_key\")"
	end)

	local var_29_0 = string.match(arg_29_1, "return%s*" .. arg_29_2)

	arg_29_1 = arg_29_1:gsub(var_29_0, string.format("function %s.getInitData() \n return __init_data \n end\n", arg_29_2) .. string.format("function %s.getIdIdx() \n return %s._getKey() \n end\n", arg_29_2, arg_29_2) .. string.format("function %s.getKeyMap() \n return __key_map \n end\n", arg_29_2) .. string.format("function %s.getStrLMap() \n return __strL_map \n end\n", arg_29_2) .. var_29_0)

	return arg_29_1
end

function DebugQAComp:removeNextCordContent(arg_32_1)
	arg_32_1 = arg_32_1:gsub("local prefix = string.sub", "--local prefix = string.sub")
	arg_32_1 = arg_32_1:gsub("status, next_record = pcall", "--status, next_record = pcall")

	return arg_32_1
end

function DebugQAComp:filterSpecialStr(arg_33_1, arg_33_2)
	if arg_33_2 then
		arg_33_1 = string.gsub(arg_33_1, "\n", "")
		arg_33_1 = string.gsub(arg_33_1, "\t", "")
		arg_33_1 = string.gsub(arg_33_1, " ", "")
	else
		arg_33_1 = string.gsub(arg_33_1, "\n", "\\n")
		arg_33_1 = string.gsub(arg_33_1, "\t", "\\t")
	end

	return arg_33_1
end

function DebugQAComp:getIdStrByChaos()
	local var_34_0 = self.m_txt_chaos:getText()

	if not var_34_0 or #var_34_0 < 2 then
		return
	end

	self.m_txt_uid:setText((g.core.common.GlobalFunc.getIdStrByChaosCode(var_34_0)))
end

return DebugQAComp
