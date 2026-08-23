local var_0_0 = g.core.config.knight_base_info
local var_0_1 = g.core.config.furniture_info
local var_0_2 = g.core.config.monster_team_info
local DebugCommon = require("app.view.module.debug.common.DebugCommon")
local BattlePath = require("app.view.battle.BattlePath")
local DebugSearchComp = class("DebugSearchComp", require("app.fairyGUI.debug.UI_DebugSearchComp"))

function DebugSearchComp:ctor()
	self._lastSearchStr = nil
	self._pType = ""
	self._searchPaths = {}

	self:_initView()
end

function DebugSearchComp:_initView()
	self.m_searchInput:addEventListener(fgui.UIEventType.Changed, handler(self, self._onInputChange))
	self.m_searchBtn:addClickListener(handler(self, self._onClickSearch))
end

function DebugSearchComp:updatePaths(arg_3_1, arg_3_2)
	self._searchPaths = {}
	self._pType = arg_3_1

	if arg_3_1 == "knightInfo" or arg_3_1 == "actorInfo" or arg_3_1 == "knightPicInfo" then
		for iter_3_0 = 1, var_0_0.getLength() do
			local var_3_0 = var_0_0.indexOf(iter_3_0)

			table.insert(self._searchPaths, var_3_0.name .. "_" .. var_3_0.id)
		end
	end

	if arg_3_1 == "monsterTeamInfo" then
		for iter_3_1 = 1, var_0_2.getLength() do
			local var_3_1 = var_0_2.indexOf(iter_3_1)

			table.insert(self._searchPaths, var_3_1.id .. "_" .. var_3_1.wave)
		end
	end

	if arg_3_1 == "knightSpine" then
		self._searchPaths = DebugCommon.getPathsWithExt("knight_spine", "skel", true)
	end

	if arg_3_1 == "succubaSpine" then
		local var_3_2 = {}

		for iter_3_2 = 1, g.core.config.succuba_info.getLength() do
			local var_3_3 = g.core.config.succuba_info.indexOf(iter_3_2)
			local var_3_4 = tostring(var_3_3.advance_id)

			var_3_2[var_3_4] = var_3_2[var_3_4] or var_3_3.advance_id
		end

		self._searchPaths = {}

		for iter_3_3, iter_3_4 in ipairs((DebugCommon.getPathsWithExt("knight_spine", "skel", true, true))) do
			if var_3_2[iter_3_4] then
				self._searchPaths[#self._searchPaths + 1] = iter_3_4
			end
		end
	end

	if arg_3_1 == "actorSpine" then
		self._searchPaths = DebugCommon.getPathsWithExt("battle/knight_spine", "skel", true)
	end

	if arg_3_1 == "battleData" then
		self._searchPaths = DebugCommon.getSrcPathsWithExt("battle/test", "lua", true)
	end

	if arg_3_1 == "storyBg" then
		self._searchPaths = DebugCommon.getPathsWithExt("bg/story", "jpg", false)
	end

	if arg_3_1 == "furnitureInfo" then
		for iter_3_5 = 1, var_0_1.getLength() do
			local var_3_5 = var_0_1.indexOf(iter_3_5)

			if var_3_5.basal_type ~= 1 then
				table.insert(self._searchPaths, var_3_5.id .. "_" .. var_3_5.name)
			end
		end
	end

	if arg_3_1 == "storyDialogJson" then
		self._searchPaths = DebugCommon.getPathsWithExt("story/dialog", "json", false)
	end

	if arg_3_1 == "channels" then
		for iter_3_6, iter_3_7 in pairs(require("app.core.platform.const.ChannelConst").ValueConst[2013001]) do
			for iter_3_8, iter_3_9 in pairs(iter_3_7) do
				table.insert(self._searchPaths, (iter_3_9.debugName or iter_3_9.name) .. "_" .. iter_3_6)
			end
		end

		table.sort(self._searchPaths, function(arg_4_0, arg_4_1)
			return tonumber(string.split(arg_4_0, "_")[2]) < tonumber(string.split(arg_4_1, "_")[2])
		end)
	end

	self._searchAll = true

	self:_onClickSearch()
end

function DebugSearchComp:setShowText(arg_5_1)
	self.m_searchInput:setTitle(arg_5_1)
	self:_onInputChange()
end

function DebugSearchComp:getCurId()
	local var_6_0 = self.m_searchInput:getTitle()

	if var_6_0 == "" then
		g.core.module.ModuleManager:tip("选项不能为空！")

		return false, 0
	end

	if self._pType == "knightInfo" or self._pType == "actorInfo" or self._pType == "knightPicInfo" then
		local var_6_1 = string.split(var_6_0, "_")

		if var_6_1[2] then
			return tonumber(var_6_1[2])
		end
	elseif self._pType == "monsterTeamInfo" then
		local var_6_2 = string.split(var_6_0, "_")

		return tonumber(var_6_2[1]), tonumber(var_6_2[2])
	end

	return tonumber(var_6_0)
end

function DebugSearchComp:getShowText(arg_7_1)
	if arg_7_1 == nil then
		arg_7_1 = true
	end

	local var_7_0 = self.m_searchInput:getTitle()

	if var_7_0 == "" then
		g.core.module.ModuleManager:tip("选项不能为空！")

		return false, 0
	end

	if self._pType == "knightInfo" or self._pType == "actorInfo" or self._pType == "knightPicInfo" then
		local var_7_1 = string.split(var_7_0, "_")

		if var_7_1[2] then
			local var_7_2 = var_0_0.get(tonumber(var_7_1[2]))

			if var_7_2 then
				if self._pType == "knightPicInfo" then
					return arg_7_1, tonumber(var_7_1[2])
				end

				local var_7_3 = self._pType == "knightInfo"
				local var_7_4

				if self._pType == "knightInfo" then
					var_7_4 = var_7_2.painted_id or var_7_2.fight_id
				end

				local var_7_5 = var_7_3 and "立绘" or "战斗小人"
				local var_7_6 = var_7_3 and g.core.common.Path:getSpineKnightPath(var_7_4) .. ".skel" or BattlePath.getSpineKnightPath(var_7_4) .. ".skel"
				local var_7_7 = cc.FileUtils:getInstance():isFileExist(var_7_6)
				local var_7_8

				if not var_7_7 then
					g.core.module.ModuleManager:tip(var_7_6 .. var_7_5 .. "资源文件不存在！")

					var_7_8 = var_7_3 and tonumber(var_7_1[2]) or var_7_4
				end

				return arg_7_1 and var_7_7, var_7_8
			end
		end

		return false, 0
	end

	if self._pType == "monsterTeamInfo" then
		local var_7_9 = string.split(var_7_0, "_")
		local var_7_10 = tonumber(var_7_9[1])
		local var_7_11 = var_0_2.get(var_7_10, (tonumber(var_7_9[2])))
		local var_7_12 = {}

		for iter_7_0 = 1, 6 do
			table.insert(var_7_12, var_7_11["monster_" .. iter_7_0])
		end

		return true, var_7_10, var_7_12
	end

	if self._pType == "knightSpine" then
		local var_7_13 = tonumber(var_7_0)
		local var_7_14 = g.core.common.Path:getSpineKnightPath(var_7_13) .. ".skel"
		local var_7_15 = cc.FileUtils:getInstance():isFileExist(var_7_14)

		if not var_7_15 then
			g.core.module.ModuleManager:tip(var_7_14 .. "立绘资源文件不存在！")
		end

		return arg_7_1 and var_7_15, var_7_13
	end

	if self._pType == "succubaSpine" then
		local var_7_16 = tonumber(var_7_0)
		local var_7_17 = g.core.common.Path:getSpineKnightPath(var_7_16) .. ".skel"
		local var_7_18 = cc.FileUtils:getInstance():isFileExist(var_7_17)

		if not var_7_18 then
			g.core.module.ModuleManager:tip(var_7_17 .. "立绘资源文件不存在！")
		end

		return arg_7_1 and var_7_18, var_7_16
	end

	if self._pType == "actorSpine" then
		local var_7_19 = tonumber(var_7_0)
		local var_7_20 = BattlePath.getSpineKnightPath(var_7_19) .. ".skel"
		local var_7_21 = cc.FileUtils:getInstance():isFileExist(var_7_20)

		if not var_7_21 then
			g.core.module.ModuleManager:tip(var_7_20 .. "战斗小人资源文件不存在！")
		end

		return arg_7_1 and var_7_21, var_7_19
	end

	if self._pType == "battleData" then
		local var_7_22 = BattlePath.getBattleDataPath(var_7_0)
		local var_7_23 = cc.FileUtils:getInstance():isFileExist(var_7_22)

		if not var_7_23 then
			g.core.module.ModuleManager:tip(var_7_22 .. "战斗数据不存在！")
		end

		return arg_7_1 and var_7_23, var_7_0
	end

	if self._pType == "furnitureInfo" then
		return arg_7_1, tonumber(string.split(var_7_0, "_")[1])
	end

	if self._pType == "storyBg" then
		return true, var_7_0
	end

	if self._pType == "channels" then
		return true, tonumber(string.split(var_7_0, "_")[2])
	end

	g.core.module.ModuleManager:tip("未知选项！")

	return false, 0
end

function DebugSearchComp:_onClickSearch()
	local var_8_0 = self.m_searchInput:getTitle()
	local var_8_1 = self._searchPaths

	if not self._searchAll and var_8_0 ~= "" and self._lastSearchStr ~= var_8_0 then
		self._lastSearchStr = var_8_0
		var_8_1 = {}

		for iter_8_0 = 1, #self._searchPaths do
			if string.match(self._searchPaths[iter_8_0], var_8_0) then
				table.insert(var_8_1, self._searchPaths[iter_8_0])
			end
		end
	else
		self._searchAll = false
		self._lastSearchStr = ""
	end

	self.m_searchInput:setItems(var_8_1)
	self.m_searchInput:refresh()
end

function DebugSearchComp:getSearchPathList()
	return self._searchPaths
end

function DebugSearchComp:_onInputChange()
	self:dispatchCompEvent("EVENT_DEBUG_INPUT_CHANGE", self._pType)
end

return DebugSearchComp
