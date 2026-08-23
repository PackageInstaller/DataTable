local WarriorsOfFateData = class("WarriorsOfFateData")
local var_0_1 = g.core.config.scroll_set_info
local var_0_2 = g.core.config.scroll_main_growth_info
local var_0_3 = g.core.config.scroll_stage_growth_info
local var_0_4 = g.core.const.ConstMgr.WarriorsConst.MAIN
local var_0_5 = g.core.const.ConstMgr.WarriorsConst.GENERAL
local var_0_6 = g.core.const.ConstMgr.WarriorsConst.NIGHTMARE

function WarriorsOfFateData:ctor()
	self:initData()
end

function WarriorsOfFateData:initData()
	self._landInfos = {}
	self._chapterInfos = {}
	self._actChapterInfos = {}
	self._chapterNoLand = {}
	self._actChaptersNoLand = {}
	self._stageToLand = {}

	self:_init()
end

function WarriorsOfFateData:_init()
	self:_initLandInfos()
	self:_initChapterInfos()
	self:_initStageToLand()
end

function WarriorsOfFateData:_initLandInfos()
	for iter_4_0 = 1, var_0_1.getLength() do
		local var_4_0 = var_0_1.indexOf(iter_4_0)

		if var_4_0 and (var_4_0.tab_type == var_0_4 or var_4_0.tab_type == var_0_5) then
			if self._landInfos[var_4_0.tab_type] == nil then
				self._landInfos[var_4_0.tab_type] = {}
			end

			table.insert(self._landInfos[var_4_0.tab_type], self:getLandTable(var_4_0.tab_type).indexOf(tonumber(var_4_0.set_info_id)))
		end
	end
end

function WarriorsOfFateData:getCurWarriorsLandByType(arg_5_1, arg_5_2)
	for iter_5_0 = 1, var_0_1.getLength() do
		local var_5_0 = var_0_1.indexOf(iter_5_0)

		if var_5_0.tab_type == arg_5_1 and tonumber(var_5_0.set_info_id) == arg_5_2 then
			return var_5_0.set_pic_id
		end
	end
end

function WarriorsOfFateData:_initChapterInfos()
	self._chapterInfos = {
		[var_0_4] = {},
		[var_0_5] = {},
		[var_0_6] = {}
	}
	self._chapterNoLand = {
		[var_0_4] = {},
		[var_0_5] = {},
		[var_0_6] = {}
	}

	for iter_6_0 = 1, var_0_2.getLength() do
		local var_6_0 = var_0_2.indexOf(iter_6_0)

		if var_6_0.tab_type == var_0_4 or var_6_0.tab_type == var_0_5 or var_6_0.tab_type == var_0_6 then
			self._chapterInfos[var_6_0.tab_type][var_6_0.set_id] = self._chapterInfos[var_6_0.tab_type][var_6_0.set_id] or {}

			table.insert(self._chapterInfos[var_6_0.tab_type][var_6_0.set_id], var_6_0)
			table.insert(self._chapterNoLand[var_6_0.tab_type], var_6_0)
		end
	end
end

function WarriorsOfFateData:_initStageToLand()
	for iter_7_0 = 1, var_0_2.getLength() do
		local var_7_0 = var_0_2.indexOf(iter_7_0)

		if var_7_0.stage_id ~= 0 and (var_7_0.tab_type == var_0_4 or var_7_0.tab_type == var_0_5) then
			if self._stageToLand[var_7_0.tab_type] == nil then
				self._stageToLand[var_7_0.tab_type] = {}
			end

			self._stageToLand[var_7_0.tab_type][var_7_0.stage_id] = var_7_0.set_id
		end
	end
end

function WarriorsOfFateData:onS2CFlushRedPoint(arg_8_1)
	if not arg_8_1.scroll_hint then
		return
	end

	self:onScrollInfo(arg_8_1.scroll_hint)
end

function WarriorsOfFateData:onScrollInfo(arg_9_1)
	self._actChapterInfos[var_0_4] = {}
	self._actChapterInfos[var_0_5] = {}
	self._actChaptersNoLand[var_0_4] = {}
	self._actChaptersNoLand[var_0_5] = {}
	self._actChapterInfos[var_0_6] = {}
	self._actChaptersNoLand[var_0_6] = {}

	if arg_9_1.main_ids then
		for iter_9_0, iter_9_1 in ipairs(arg_9_1.main_ids) do
			local var_9_0 = var_0_2.get(iter_9_1)

			self._actChapterInfos[var_0_4][var_9_0.set_id] = self._actChapterInfos[var_0_4][var_9_0.set_id] or {}

			table.insert(self._actChapterInfos[var_0_4][var_9_0.set_id], var_9_0)
			table.insert(self._actChaptersNoLand[var_0_4], var_9_0)
		end
	end

	if arg_9_1.hero_ids then
		for iter_9_2, iter_9_3 in ipairs(arg_9_1.hero_ids) do
			local var_9_1 = var_0_2.get(iter_9_3)

			self._actChapterInfos[var_0_5][var_9_1.set_id] = self._actChapterInfos[var_0_5][var_9_1.set_id] or {}

			table.insert(self._actChapterInfos[var_0_5][var_9_1.set_id], var_9_1)
			table.insert(self._actChaptersNoLand[var_0_5], var_9_1)
		end
	end

	if arg_9_1.nightmare_ids then
		for iter_9_4, iter_9_5 in ipairs(arg_9_1.nightmare_ids) do
			local var_9_2 = var_0_2.get(iter_9_5)

			self._actChapterInfos[var_0_6][var_9_2.set_id] = self._actChapterInfos[var_0_6][var_9_2.set_id] or {}

			table.insert(self._actChapterInfos[var_0_6][var_9_2.set_id], var_9_2)
			table.insert(self._actChaptersNoLand[var_0_6], var_9_2)
		end
	end

	if arg_9_1.id and self:isKnightUp(arg_9_1.id) then
		g.core.model.User.formationData:freshMainAssctList()
	end
end

function WarriorsOfFateData:onScrollActivate(arg_10_1)
	if arg_10_1.type == var_0_4 or arg_10_1.type == var_0_5 or arg_10_1.type == var_0_6 then
		self._actChapterInfos[arg_10_1.type] = {}
		self._actChaptersNoLand[arg_10_1.type] = {}
		arg_10_1.ids = arg_10_1.ids or {}

		for iter_10_0, iter_10_1 in ipairs(arg_10_1.ids) do
			local var_10_0 = var_0_2.get(iter_10_1)

			self._actChapterInfos[arg_10_1.type][var_10_0.set_id] = self._actChapterInfos[arg_10_1.type][var_10_0.set_id] or {}

			table.insert(self._actChapterInfos[arg_10_1.type][var_10_0.set_id], var_10_0)
			table.insert(self._actChaptersNoLand[arg_10_1.type], var_10_0)
		end
	end
end

function WarriorsOfFateData:getLandInfos(arg_11_1)
	if not self._landInfos or not self._landInfos[arg_11_1] then
		return {}
	else
		local var_11_0 = {}

		for iter_11_0, iter_11_1 in pairs(self._landInfos[arg_11_1]) do
			if self._chapterInfos[arg_11_1][iter_11_0] then
				table.insert(var_11_0, iter_11_1)
			end
		end

		return var_11_0
	end
end

function WarriorsOfFateData:getChaptersByLand(arg_12_1, arg_12_2)
	local var_12_0 = table.values(self._chapterInfos[arg_12_1])

	if not var_12_0[arg_12_2] then
		return {}
	else
		return var_12_0[arg_12_2]
	end
end

function WarriorsOfFateData:getActLandNum(arg_13_1)
	local var_13_0 = 0
	local var_13_2 = #self:getLandInfos(arg_13_1)

	for iter_13_0 = 1, var_13_2 do
		if #self:getActChaptersByLand(arg_13_1, iter_13_0) > 0 or iter_13_0 == 1 or #self:getActChaptersByLand(arg_13_1, iter_13_0 - 1) == #self:getChaptersByLand(arg_13_1, iter_13_0 - 1) then
			var_13_0 = var_13_0 + 1
		else
			break
		end
	end

	return var_13_0, var_13_0 < var_13_2 and var_13_0 + 1 or var_13_0
end

function WarriorsOfFateData:getActChaptersByLand(arg_14_1, arg_14_2)
	if self._actChapterInfos[arg_14_1] then
		local var_14_0 = table.values(self._actChapterInfos[arg_14_1])

		if var_14_0[arg_14_2] then
			return var_14_0[arg_14_2]
		else
			return {}
		end
	else
		return {}
	end
end

function WarriorsOfFateData:getActChaptersByType(arg_15_1)
	if not self._actChaptersNoLand[arg_15_1] then
		return {}
	else
		return self._actChaptersNoLand[arg_15_1]
	end
end

function WarriorsOfFateData:getStageInfoByType(arg_16_1)
	local var_16_0 = {}

	for iter_16_0 = 1, var_0_3.getLength() do
		local var_16_1 = var_0_3.indexOf(iter_16_0)

		if var_16_1.tab_type == arg_16_1 then
			table.insert(var_16_0, var_16_1)
		end
	end

	return var_16_0
end

function WarriorsOfFateData:getNextActStage(arg_17_1)
	for iter_17_0, iter_17_1 in pairs(self._chapterInfos[arg_17_1]) do
		for iter_17_2, iter_17_3 in ipairs(iter_17_1) do
			if iter_17_3.stage_id ~= 0 then
				if not self._actChaptersNoLand[arg_17_1][iter_17_3.id] then
					return iter_17_3.stage_id
				end
			end
		end
	end

	return #self:getStageInfoByType(arg_17_1)
end

function WarriorsOfFateData:getCurrentActStage(arg_18_1)
	local var_18_0 = 0
	local var_18_1 = 0
	local var_18_2 = 0

	for iter_18_0, iter_18_1 in pairs(self._chapterInfos[arg_18_1]) do
		for iter_18_2, iter_18_3 in ipairs(iter_18_1) do
			var_18_1 = var_18_1 + 1
			var_18_2 = var_18_2 + 1

			if self._actChaptersNoLand[arg_18_1][var_18_2] then
				var_18_0 = var_18_0 + 1
			end

			if iter_18_3.stage_id ~= 0 then
				if not self._actChaptersNoLand[arg_18_1][var_18_2] then
					return var_18_0, var_18_1, iter_18_3.stage_id
				end

				var_18_0 = 0
				var_18_1 = 0
			end
		end
	end

	return 0, 0, 0
end

function WarriorsOfFateData:getLandByStage(arg_19_1, arg_19_2)
	if self._stageToLand[arg_19_1][arg_19_2] then
		return self._stageToLand[arg_19_1][arg_19_2]
	else
		return 0
	end
end

function WarriorsOfFateData:getFunctionType(arg_20_1)
	local var_20_0 = g.core.config.scroll_main_growth_info.get(arg_20_1).stage_id

	if var_20_0 ~= 0 then
		return g.core.config.scroll_stage_growth_info.get(var_20_0).function_type
	end

	return 0
end

function WarriorsOfFateData:isKnightUp(arg_21_1)
	if self:getFunctionType(arg_21_1) == 1 then
		return true
	end

	return false
end

function WarriorsOfFateData:isKnightUpStar(arg_22_1)
	if self:getFunctionType(arg_22_1) == 2 then
		return true
	end

	return false
end

function WarriorsOfFateData:isActiveAttr(arg_23_1)
	if self:getFunctionType(arg_23_1) == 4 then
		return true
	end

	return false
end

function WarriorsOfFateData:getChapterById(arg_24_1)
	local var_24_0 = var_0_2.get(arg_24_1)
	local var_24_1, var_24_2 = g.core.lang:getAttr(var_24_0.attribute_type, var_24_0.attribute_value)

	return {
		name = g.core.lang:get(1218, {
			name = var_24_1
		}),
		value = var_24_2
	}
end

function WarriorsOfFateData:isHasActChapter(arg_25_1)
	if self._chapterNoLand[arg_25_1] and self._actChaptersNoLand[arg_25_1] and #self._chapterNoLand[arg_25_1] > #self._actChaptersNoLand[arg_25_1] and g.core.model.User.bagData:getOwnNum(self._chapterNoLand[arg_25_1][#self._actChaptersNoLand[arg_25_1] + 1].cost_type, self._chapterNoLand[arg_25_1][#self._actChaptersNoLand[arg_25_1] + 1].cost_value) >= self._chapterNoLand[arg_25_1][#self._actChaptersNoLand[arg_25_1] + 1].cost_size then
		return true
	end

	return false
end

function WarriorsOfFateData:getChapterAttrsById(arg_26_1)
	local var_26_0 = {}
	local var_26_1 = var_0_2.get(arg_26_1).stage_id

	if var_26_1 ~= 0 then
		local var_26_2 = g.core.config.scroll_stage_growth_info.get(var_26_1)

		for iter_26_0 = 1, 4 do
			if var_26_2["attribute_type_" .. iter_26_0] and var_26_2["attribute_type_" .. iter_26_0] ~= 0 then
				var_26_0[var_26_2["attribute_type_" .. iter_26_0]] = var_26_0[var_26_2["attribute_type_" .. iter_26_0]] or 0
				var_26_0[var_26_2["attribute_type_" .. iter_26_0]] = var_26_0[var_26_2["attribute_type_" .. iter_26_0]] + var_26_2["attribute_value_" .. iter_26_0]
			else
				break
			end
		end
	end

	local var_26_3 = {}

	for iter_26_1, iter_26_2 in pairs(var_26_0) do
		local var_26_4, var_26_5 = g.core.lang:getAttr(iter_26_1, iter_26_2)

		table.insert(var_26_3, {
			name = g.core.lang:get(1218, {
				name = var_26_4
			}),
			value = var_26_5
		})
	end

	return var_26_3
end

function WarriorsOfFateData:getInfoByFuncType(arg_27_1)
	local var_27_0 = 0
	local var_27_1 = 0
	local var_27_3 = 0

	for iter_27_0, iter_27_1 in pairs(self._chapterInfos[var_0_4]) do
		for iter_27_2, iter_27_3 in ipairs(iter_27_1) do
			var_27_0 = var_27_0 + 1
			var_27_1 = var_27_1 + 1

			if iter_27_3.stage_id ~= 0 then
				var_27_3 = g.core.config.scroll_stage_growth_info.get(iter_27_3.stage_id).function_type
			end

			local var_27_4

			if not self._actChapterInfos[var_0_4] or not self._actChapterInfos[var_0_4][iter_27_3.set_id] or not self._actChapterInfos[var_0_4][iter_27_3.set_id][iter_27_2] then
				if iter_27_3.stage_id ~= 0 and var_27_3 == arg_27_1 then
					return var_27_0 - 0, var_27_1, g.core.config.dungeon_land_info.get(iter_27_3.set_id)["chapter_" .. iter_27_2], iter_27_3.set_id
				end
			else
				if iter_27_3.stage_id ~= 0 and var_27_3 == arg_27_1 then
					var_27_1 = 0
				end

				var_27_4 = 0 + 1
			end
		end
	end

	return 0, 0, 0, 0
end

function WarriorsOfFateData:isMaxQuality(arg_28_1)
	local var_28_0 = {}

	for iter_28_0 = 1, g.core.config.scroll_stage_growth_info.getLength() do
		local var_28_1 = g.core.config.scroll_stage_growth_info.indexOf(iter_28_0)

		if var_28_1.function_type == 1 then
			table.insert(var_28_0, var_28_1)
		end
	end

	if arg_28_1 == #var_28_0 + 4 then
		return true
	end

	return false
end

function WarriorsOfFateData:isMaxStar(arg_29_1)
	local var_29_0 = {}

	for iter_29_0 = 1, g.core.config.scroll_stage_growth_info.getLength() do
		local var_29_1 = g.core.config.scroll_stage_growth_info.indexOf(iter_29_0)

		if var_29_1.function_type == 2 then
			table.insert(var_29_0, var_29_1)
		end
	end

	if arg_29_1 == #var_29_0 then
		return true
	end

	return false
end

function WarriorsOfFateData:getChapterTable(arg_30_1)
	if not arg_30_1 then
		return
	end

	if arg_30_1 == var_0_4 then
		return g.core.config.dungeon_chapter_info
	elseif arg_30_1 == var_0_5 then
		return g.core.config.biography_chapter_info
	end
end

function WarriorsOfFateData:getLandTable(arg_31_1)
	if not arg_31_1 then
		return
	end

	if arg_31_1 == var_0_4 then
		return g.core.config.dungeon_land_info
	elseif arg_31_1 == var_0_5 then
		return g.core.config.biography_land_info
	end
end

function WarriorsOfFateData:getNightmarePages()
	return (table.values(self._chapterInfos[var_0_6] or {}))
end

function WarriorsOfFateData:getNightmarePage(arg_33_1)
	return self:getNightmarePages()[arg_33_1] or {}
end

function WarriorsOfFateData:getNightmareScroll(arg_34_1, arg_34_2)
	return self:getNightmarePage(arg_34_1)[arg_34_2]
end

function WarriorsOfFateData:getNightmarePagesNum()
	return #self:getNightmarePages()
end

function WarriorsOfFateData:getActNightmarePage(arg_36_1)
	return (self._actChapterInfos[g.core.const.ConstMgr.WarriorsConst.NIGHTMARE] or {})[arg_36_1] or {}
end

function WarriorsOfFateData:getActNightmareScrollNum()
	return #(self._actChaptersNoLand[g.core.const.ConstMgr.WarriorsConst.NIGHTMARE] or {})
end

function WarriorsOfFateData:isActNightmareScroll(arg_38_1)
	for iter_38_0, iter_38_1 in ipairs((self:getActNightmarePage(arg_38_1.set_id))) do
		if iter_38_1.id == arg_38_1.id then
			return true
		end
	end

	return false
end

function WarriorsOfFateData:isHasCanActNightmare(arg_39_1, arg_39_2)
	local function var_39_0(arg_40_0, arg_40_1)
		for iter_40_0, iter_40_1 in ipairs(arg_40_0) do
			if arg_40_1 == iter_40_1.id then
				return true
			end
		end

		return false
	end

	local var_39_1 = table.values(self._chapterInfos[var_0_6])

	arg_39_1 = arg_39_1 or 1
	arg_39_2 = arg_39_2 or #var_39_1

	for iter_39_0 = arg_39_1, arg_39_2 do
		for iter_39_1, iter_39_2 in ipairs(var_39_1[iter_39_0]) do
			local var_39_2 = g.core.common.Goods:convert({
				type = iter_39_2.cost_type,
				value = iter_39_2.cost_value,
				size = iter_39_2.cost_size
			})

			if not var_39_0(self._actChapterInfos[var_0_6][iter_39_2.set_id] or {}, iter_39_2.id) and g.core.model.bag:getOwnNum(var_39_2.type, var_39_2.value) >= iter_39_2.cost_size then
				return true, iter_39_0
			end
		end
	end

	return false, nil
end

function WarriorsOfFateData:isHasCanActNRight(arg_41_1)
	return self:isHasCanActNightmare(arg_41_1 + 1)
end

function WarriorsOfFateData:isHasCanActNLeft(arg_42_1)
	return self:isHasCanActNightmare(1, arg_42_1 - 1)
end

function WarriorsOfFateData:getCanActNightmarePage()
	local var_43_0, var_43_1 = self:isHasCanActNightmare(1, #table.values(self._chapterInfos[var_0_6]))

	return var_43_1 and var_43_1 - 1 or 0
end

function WarriorsOfFateData:checkWarriors(arg_44_1)
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.KINGDOM_FATE) then
		return false, 0
	end

	return arg_44_1 and arg_44_1.type and self:isHasActChapter(arg_44_1.type) or self:isHasActChapter(1) or self:isHasActChapter(2)
end

function WarriorsOfFateData:checkWarriorsWar()
	return self:isHasActChapter(1) or self:isHasActChapter(2)
end

function WarriorsOfFateData:checkWarriorsMain()
	return (self:isHasActChapter(1))
end

function WarriorsOfFateData:checkWarriorsGeneral()
	return (self:isHasActChapter(2))
end

return WarriorsOfFateData
