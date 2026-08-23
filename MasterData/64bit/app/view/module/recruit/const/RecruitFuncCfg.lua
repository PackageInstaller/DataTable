local var_0_0 = {}
local var_0_1 = g.core.const.ConstMgr.DailyRecruitConst
local var_0_2 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_3 = g.core.model.User.recruitData
local RecruitConst = import(".RecruitConst")

function var_0_0.getRecruitActionParams(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		typeStr = "",
		numStr = ""
	}

	if RecruitConst.RECRUIT_TYPE.Base == arg_1_1 then
		var_1_0.typeStr = "Free"
	elseif RecruitConst.RECRUIT_TYPE.PREMIUM == arg_1_1 then
		var_1_0.typeStr = "Premium"
	end

	if var_1_0.typeStr == "" then
		var_1_0.typeStr = "Premium"
	end

	if arg_1_2 > 1 then
		var_1_0.numStr = "Ten"
		var_1_0.sizeStrs = {
			"_1334x750_5000",
			"_1334x750_5000",
			"_1334x750_5000",
			"_1334x750_5000",
			"_1334x750_5000"
		}
	else
		var_1_0.numStr = "Single"
		var_1_0.sizeStrs = {
			"_1334x750_3367",
			"_1334x750_3367",
			"_1334x750_3367",
			"_1334x750_3367",
			"_1334x750_3367"
		}
	end

	return var_1_0
end

function var_0_0:_sortList(arg_2_1)
	return self.priority > arg_2_1.priority
end

function var_0_0.getTabListCfgs(arg_3_0)
	return (var_0_0._getTabCfgAllList())
end

function var_0_0.getPrimaryList()
	local var_4_0 = {
		funcId = g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_GENERIAL
	}

	var_4_0.iconUrl1 = "ui://recruit/icon_zm_jiangou1"
	var_4_0.iconUrl2 = "ui://recruit/icon_zm_jiangou2"
	var_4_0.title = g.core.lang:get(108110)
	var_4_0.titleTip = g.core.lang:get(108111)
	var_4_0.tabType = "knight"
	var_4_0.subTree = {}

	for iter_4_0, iter_4_1 in ipairs({
		var_0_0._primaryCfg
	}) do
		iter_4_1(var_4_0.subTree)
	end

	for iter_4_2, iter_4_3 in pairs(var_4_0.subTree) do
		iter_4_3.ownerType = var_4_0.tabType
	end

	if #var_4_0.subTree > 0 then
		table.sort(var_4_0.subTree, var_0_0._sortList)

		var_4_0.priority = var_4_0.subTree[1].priority or 0
	else
		return
	end

	return var_4_0
end

function var_0_0.getDailyList()
	if g.core.common.ModuleUnlock:isModuleUnlock(var_0_2.DAILY_RECRUIT) and (g.core.platform.PlatformProxy:getCurChannel().name ~= require("app.core.platform.const.ChannelConst").ChannelNames.HUAWEI or g.core.model.User:getLevel() > 30) then
		local var_5_0 = {
			funcId = var_0_2.DAILY_RECRUIT
		}

		var_5_0.iconUrl1 = "ui://recruit/icon_zm_meirishilian1"
		var_5_0.iconUrl2 = "ui://recruit/icon_zm_meirishilian2"
		var_5_0.title = var_0_3:getDailyRecruitName()
		var_5_0.titleTip = g.core.lang:get(108651)
		var_5_0.tabType = RecruitConst.RECRUIT_TAB_TYPE.DAILY_RECRUIT
		var_5_0.packageName = "recruitDaily"
		var_5_0.redId = 453
		var_5_0.subTree = {}

		for iter_5_0, iter_5_1 in ipairs({
			var_0_0._dailyCfg
		}) do
			iter_5_1(var_5_0.subTree)
		end

		for iter_5_2, iter_5_3 in pairs(var_5_0.subTree) do
			iter_5_3.ownerType = var_5_0.tabType
		end

		if #var_5_0.subTree > 0 then
			var_5_0.priority = var_5_0.subTree[1].priority
		end

		return var_5_0
	end
end

function var_0_0._getTabCfgAllList()
	local var_6_0 = {}
	local var_6_1 = var_0_0._getBackRecruitCfgList()

	table.insert(var_6_0, var_0_0.getKnightCfg(var_6_1.knight))

	local var_6_2 = var_0_0.getDailyList()

	if var_6_2 and next(var_6_2) then
		table.insert(var_6_0, var_6_2)
	end

	local var_6_3 = var_0_0._getUniteTokenCfg()

	if var_6_3 then
		table.insert(var_6_0, var_6_3)
	end

	local var_6_4 = var_0_0._getArtifactCfg(var_6_1.artifact)

	if var_6_4 then
		table.insert(var_6_0, var_6_4)
	end

	local var_6_5 = var_0_0.getPetCfg()

	if var_6_5 then
		table.insert(var_6_0, var_6_5)
	end

	local var_6_6 = var_0_0.getSuccubaCfg()

	if var_6_6 then
		table.insert(var_6_0, var_6_6)
	end

	local var_6_7 = var_0_0.getKnightSoulCfg()

	if var_6_7 then
		table.insert(var_6_0, var_6_7)
	end

	local var_6_8 = var_0_0.getPreciousCfg()

	if var_6_8 then
		table.insert(var_6_0, var_6_8)
	end

	return var_6_0
end

function var_0_0.getBackRecruitIdList()
	local var_7_0 = {}
	local var_7_1 = {}

	if not g.core.model.User.userBackData:showEntrance() or g.core.utils.Rule.isHideRecruitActiveOfOpenServer() then
		return var_7_0, var_7_1
	end

	local var_7_3 = g.core.model.User.userBackData:getLostDay()

	for iter_7_0 = 1, g.core.config.back_turn_info.getLength() do
		local var_7_4 = g.core.config.back_turn_info.indexOf(iter_7_0)

		if var_7_3 >= var_7_4.day and var_7_3 < var_7_4.day_max then
			if var_7_4.recruit_id ~= 0 then
				var_7_0[#var_7_0 + 1] = var_7_4.recruit_id
			end

			if var_7_4.artifact_id ~= 0 then
				var_7_1[#var_7_1 + 1] = var_7_4.artifact_id
			end

			break
		end
	end

	return var_7_0, var_7_1
end

function var_0_0._getBackRecruitCfgList()
	local var_8_0 = {
		knight = {},
		artifact = {}
	}
	local var_8_1, var_8_2 = var_0_0.getBackRecruitIdList()

	local function var_8_3(arg_9_0)
		local var_9_0 = g.core.model.User.recruitData:getRecruitKnightCfgById(arg_9_0)
		local var_9_1 = g.core.model.User.recruitData:getDisplayInfoById(arg_9_0)
		local var_9_2 = {
			id = arg_9_0,
			funcId = var_9_0.function_id,
			compName = var_9_1.cfg.backcomp,
			type = var_9_0.type,
			iconUrl1 = "ui://recruit/" .. var_9_1.cfg.icon .. "1",
			iconUrl2 = "ui://recruit/" .. var_9_1.cfg.icon .. "2"
		}

		if var_9_1.cfg.bg then
			var_9_2.bgUrl = "bg/recruit/" .. var_9_1.cfg.bg or "bg/recruit/pic_zm_xianshi.jpg"
		end

		var_9_2.title = var_9_1.cfg.name
		var_9_2.titleTip = var_9_1.cfg.tab_title
		var_9_2.compData = {
			id = arg_9_0,
			recruitCfg = var_9_0,
			displayCfg = var_9_1,
			endTime = g.core.model.User.userBackData:getEndTime()
		}
		var_9_2.priority = var_9_1.cfg.priority

		g.core.model.User.recruitData:getDrawInfo(arg_9_0, nil, true)

		function var_9_2.show()
			return g.core.common.ServerTime:getTime() <= var_9_2.compData.endTime and g.core.common.ModuleUnlock:isModuleUnlock(var_9_0.function_id)
		end

		function var_9_2.isUnlock()
			return true
		end

		var_9_2.isRedPointShow = {}

		return var_9_2
	end

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		local var_8_4 = var_8_3(iter_8_1)

		var_8_4.redId = 917

		if var_8_4.show() then
			table.insert(var_8_0.knight, var_8_4)
		end
	end

	for iter_8_2, iter_8_3 in ipairs(var_8_2) do
		local var_8_5 = var_8_3(iter_8_3)

		if var_8_5.show() then
			var_8_5.redId = 918
			var_8_5.useLuck = true

			table.insert(var_8_0.artifact, var_8_5)
		end
	end

	return var_8_0
end

function var_0_0.getKnightCfg(arg_12_0)
	local var_12_0 = {
		funcId = g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_GENERIAL
	}

	var_12_0.iconUrl1 = "ui://recruit/icon_zm_jiangou1"
	var_12_0.iconUrl2 = "ui://recruit/icon_zm_jiangou2"
	var_12_0.title = g.core.lang:get(108110)
	var_12_0.titleTip = g.core.lang:get(108111)
	var_12_0.tabType = "knight"
	var_12_0.redId = 331
	var_12_0.packageName = "recruitKnight"
	var_12_0.subTree = arg_12_0 or {}

	for iter_12_0, iter_12_1 in ipairs({
		var_0_0._primaryCfg,
		var_0_0._primaryLimitCfg,
		var_0_0._getNormalKnightCfg,
		var_0_0._limitTimeCfg
	}) do
		iter_12_1(var_12_0.subTree)
	end

	for iter_12_2, iter_12_3 in pairs(var_12_0.subTree) do
		iter_12_3.ownerType = var_12_0.tabType
	end

	table.sort(var_12_0.subTree, var_0_0._sortList)

	var_12_0.priority = var_12_0.subTree[1].priority

	return var_12_0
end

function var_0_0._highCfg(arg_13_0)
	local var_13_0 = g.core.model.User.recruitData:getDisplayInfoById(100002)
	local var_13_1 = {
		id = g.core.model.User.recruitData:getRecruitKnightCfgById(100002).id,
		funcId = g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_ADVANCE
	}

	var_13_1.compName = "RecruitHighComp"
	var_13_1.iconUrl1 = "ui://recruit/icon_zm_chaoyanjiangou1"
	var_13_1.iconUrl2 = "ui://recruit/icon_zm_chaoyanjiangou2"
	var_13_1.title = var_13_0.cfg.name
	var_13_1.titleTip = var_13_0.cfg.tab_title
	var_13_1.type = RecruitConst.RECRUIT_TYPE.PREMIUM
	var_13_1.bgUrl = "bg/recruit/bg_zm_gaojizhaomubg.jpg"
	var_13_1.priority = var_13_0.cfg.priority
	var_13_1.useLuck = true

	function var_13_1.show()
		return g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_ADVANCE)
	end

	function var_13_1.isUnlock()
		return g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_ADVANCE, nil, true)
	end

	var_13_1.isRedPointShow = {}

	if var_13_1.show() then
		table.insert(arg_13_0, var_13_1)
	end
end

function var_0_0._getNormalKnightCfg(arg_16_0)
	local var_16_0 = {
		0,
		332
	}

	for iter_16_0, iter_16_1 in ipairs({
		100002,
		100030
	}) do
		local var_16_1 = g.core.model.User.recruitData:getDisplayInfoById(iter_16_1)
		local var_16_2 = {}
		local var_16_3 = g.core.model.User.recruitData:getRecruitKnightCfgById(iter_16_1)

		var_16_2.id = var_16_3.id
		var_16_2.funcId = var_16_3.function_id
		var_16_2.compName = var_16_1.cfg.backcomp
		var_16_2.type = var_16_3.type
		var_16_2.iconUrl1 = "ui://recruit/" .. var_16_1.cfg.icon .. "1"
		var_16_2.iconUrl2 = "ui://recruit/" .. var_16_1.cfg.icon .. "2"

		if var_16_1.cfg.bg then
			var_16_2.bgUrl = "bg/recruit/" .. var_16_1.cfg.bg or "bg/recruit/pic_zm_xianshi.jpg"
		end

		var_16_2.title = var_16_1.cfg.name
		var_16_2.titleTip = var_16_1.cfg.tab_title
		var_16_2.priority = var_16_1.cfg.priority
		var_16_2.useLuck = var_16_3.type ~= RecruitConst.RECRUIT_TYPE.NEW_LIMIT_KNIGHT_RECRUIT

		if var_16_0[iter_16_0] ~= 0 then
			var_16_2.redId = var_16_0[iter_16_0]
		end

		function var_16_2.show()
			return g.core.common.ModuleUnlock:isModuleShow(var_16_3.function_id) and not g.core.model.User.homeData:isCensorRecruit(var_16_3.id)
		end

		function var_16_2.isUnlock()
			return g.core.common.ModuleUnlock:isModuleUnlock(var_16_3.function_id, nil, true)
		end

		var_16_2.isRedPointShow = {}

		if var_16_2.show() then
			table.insert(arg_16_0, var_16_2)
		end
	end
end

function var_0_0._limitTimeCfg(arg_19_0)
	g.core.model.User.recruitData:setNormalArtifactCtrl(nil)

	if g.core.utils.Rule.isHideRecruitActiveOfOpenServer() then
		return
	end

	local var_19_0 = {}

	local function var_19_1(arg_20_0)
		local var_20_0 = arg_20_0:getInfo()
		local var_20_1 = var_20_0.sub_activity_id or arg_20_0:getActivityValue()
		local var_20_2 = g.core.model.User.recruitData:getRecruitKnightCfgById(var_20_1)
		local var_20_3 = var_20_2.type
		local var_20_4 = g.core.model.User.recruitData:getDisplayInfoById(var_20_1)
		local var_20_5 = {
			id = var_20_1,
			funcId = g.core.const.ConstMgr.FUNCTION_TYPE.GOLD_RECRUIT,
			compName = var_20_4.cfg.backcomp,
			type = var_20_2.type,
			iconUrl1 = "ui://recruit/" .. var_20_4.cfg.icon .. "1",
			iconUrl2 = "ui://recruit/" .. var_20_4.cfg.icon .. "2"
		}

		if var_20_4.cfg.bg then
			var_20_5.bgUrl = "bg/recruit/" .. var_20_4.cfg.bg or "bg/recruit/pic_zm_xianshi.jpg"
		end

		var_20_5.title = var_20_4.cfg.name
		var_20_5.titleTip = var_20_4.cfg.tab_title
		var_20_5.useLimitLuck = var_20_3 ~= RecruitConst.RECRUIT_TYPE.NEW_LIMIT_KNIGHT_RECRUIT
		var_20_5.compData = arg_20_0
		var_20_5.priority = var_20_4.cfg.priority
		var_20_5.redId = 332

		if var_20_2.up_content_value ~= 0 and var_20_2.up_content_value_2 == 0 then
			local var_20_6 = var_20_0.start_time or arg_20_0:getStartTime()

			table.insert(var_19_0, {
				id = var_20_2.id,
				startTime = var_20_6
			})
		end

		function var_20_5.show()
			return true
		end

		function var_20_5.isUnlock()
			return true
		end

		var_20_5.isRedPointShow = {}

		return var_20_5
	end

	local var_19_2 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE

	local function var_19_3(arg_23_0)
		if arg_23_0:getActivityType() == var_19_2.LIMIT_RECRUIT then
			local var_23_0 = arg_23_0:getInfo()

			if g.core.model.User.recruitData:getRecruitKnightCfgById(var_23_0.sub_activity_id or var_23_0.activity_value).function_id == RecruitConst.RECRUIT_FUNC_ID.KNIGHT_LIMIT_FUNC_ID then
				local var_23_1 = arg_23_0:isOpen() and g.core.common.ServerTime:getTime() < arg_23_0:getFinishTime()

				if var_23_1 then
					var_23_1 = g.core.common.ModuleUnlock:isModuleUnlock(g.core.model.User.recruitData:getRecruitKnightCfgById(arg_23_0:getInfo().sub_activity_id or arg_23_0:getActivityValue()).function_id)
				end

				return var_23_1
			else
				return false
			end
		end
	end

	local var_19_4 = g.core.model.User.recruitData:getRecruitListByFilter(var_19_3)

	for iter_19_0, iter_19_1 in ipairs((g.core.model.User.recruitData:getAllCrossData())) do
		if var_19_3(iter_19_1) then
			table.insert(var_19_4, iter_19_1)
		end
	end

	for iter_19_2, iter_19_3 in ipairs(var_19_4) do
		local var_19_5 = var_19_1(iter_19_3)

		if var_19_5.show() then
			table.insert(arg_19_0, var_19_5)
		end
	end

	if #var_19_0 > 0 then
		table.sort(var_19_0, function(arg_24_0, arg_24_1)
			if arg_24_0.startTime ~= arg_24_1.startTime then
				return arg_24_0.startTime > arg_24_1.startTime
			end

			return arg_24_0.id > arg_24_1.id
		end)
		g.core.model.User.recruitData:setNormalArtifactCtrl(var_19_0[1].id)
	end
end

function var_0_0._primaryLimitCfg(arg_25_0)
	if g.core.utils.Rule.isHideRecruitActiveOfOpenServer() then
		return
	end

	local function var_25_0(arg_26_0)
		local var_26_0 = arg_26_0:getInfo().sub_activity_id or arg_26_0:getActivityValue()
		local var_26_1 = g.core.model.User.recruitData:getRecruitKnightCfgById(var_26_0)
		local var_26_2 = g.core.model.User.recruitData:getDisplayInfoById(var_26_0)
		local var_26_3 = {
			id = var_26_0,
			funcId = var_26_1.function_id,
			compName = var_26_2.cfg.backcomp,
			type = var_26_1.type,
			iconUrl1 = "ui://recruit/" .. var_26_2.cfg.icon .. "1",
			iconUrl2 = "ui://recruit/" .. var_26_2.cfg.icon .. "2"
		}

		if var_26_2.cfg.bg then
			var_26_3.bgUrl = "bg/recruit/" .. var_26_2.cfg.bg or "bg/recruit/pic_zm_xianshi.jpg"
		end

		var_26_3.title = var_26_2.cfg.name
		var_26_3.titleTip = var_26_2.cfg.tab_title
		var_26_3.compData = arg_26_0
		var_26_3.priority = var_26_2.cfg.priority

		function var_26_3.show()
			return g.core.model.User.recruitData:checkPrimaryLimitRecruitHasLeftDrawCnt(var_26_0)
		end

		function var_26_3.isUnlock()
			return true
		end

		var_26_3.isRedPointShow = {}

		return var_26_3
	end

	local var_25_1 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE

	local function var_25_2(arg_29_0)
		if arg_29_0:getActivityType() == var_25_1.LIMIT_RECRUIT then
			local var_29_0 = arg_29_0:getInfo()

			if g.core.model.User.recruitData:getRecruitKnightCfgById(var_29_0.sub_activity_id or var_29_0.activity_value).function_id == g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_PRIMARY_LIMIT then
				local var_29_1 = arg_29_0:isOpen() and g.core.common.ServerTime:getTime() < arg_29_0:getFinishTime()

				if var_29_1 then
					var_29_1 = g.core.common.ModuleUnlock:isModuleUnlock(g.core.model.User.recruitData:getRecruitKnightCfgById(arg_29_0:getInfo().sub_activity_id or arg_29_0:getActivityValue()).function_id)
				end

				return var_29_1
			else
				return false
			end
		end
	end

	local var_25_3 = g.core.model.User.recruitData:getRecruitListByFilter(var_25_2)

	for iter_25_0, iter_25_1 in ipairs((g.core.model.User.recruitData:getAllCrossData())) do
		if var_25_2(iter_25_1) then
			table.insert(var_25_3, iter_25_1)
		end
	end

	for iter_25_2, iter_25_3 in ipairs(var_25_3) do
		local var_25_4 = var_25_0(iter_25_3)

		if var_25_4.show() then
			table.insert(arg_25_0, var_25_4)
		end
	end
end

function var_0_0._primaryCfg(arg_30_0)
	local function var_30_0(arg_31_0)
		local var_31_0 = g.core.config.recruit_novice_condition_info.get(arg_31_0:getInfo().sub_activity_id or arg_31_0:getActivityValue()).recruit_id
		local var_31_1 = g.core.model.User.recruitData:getRecruitKnightCfgById(var_31_0)
		local var_31_2 = g.core.model.User.recruitData:getDisplayInfoById(var_31_0)
		local var_31_3 = {}
		local var_31_4 = g.core.model.User.recruitData:getRecruitKnightCfgById(var_31_0)

		var_31_3.id = var_31_4.id
		var_31_3.funcId = g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_PRIMARY
		var_31_3.compName = "RecruitPrimaryComp"
		var_31_3.type = var_31_4.type
		var_31_3.iconUrl1 = "ui://recruit/icon_zm_shenhonganying1"
		var_31_3.iconUrl2 = "ui://recruit/icon_zm_shenhonganying2"
		var_31_3.bgUrl = "bg/recruit/bg_zm_xinshoushilian.jpg"
		var_31_3.title = var_31_2.cfg.name
		var_31_3.titleTip = var_31_2.cfg.tab_title
		var_31_3.compData = {
			finishTime = g.core.common.ServerTime:getTimeByCreateRole(g.core.config.parameter_info.get(15010).parameter)
		}
		var_31_3.priority = var_31_2.cfg.priority
		var_31_3.redId = 455

		function var_31_3.show()
			return not g.core.model.User.recruitData:checkPrimaryIsEnd()
		end

		function var_31_3.isUnlock()
			return g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_PRIMARY, nil, true)
		end

		var_31_3.isRedPointShow = {}

		return var_31_3
	end

	local var_30_1 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE

	for iter_30_0, iter_30_1 in ipairs((g.core.model.User.recruitData:getRecruitListByFilter(function(arg_34_0)
		if arg_34_0:getActivityType() == var_30_1.PRIMARY_RECRUIT then
			return true
		end
	end))) do
		local var_30_2 = var_30_0(iter_30_1)

		if var_30_2.show() then
			table.insert(arg_30_0, var_30_2)
		end
	end
end

function var_0_0._dailyCfg(arg_35_0)
	local var_35_0 = {}

	var_35_0.id = var_0_1.DISPLAY_RECRUIT_ID
	var_35_0.funcId = var_0_2.DAILY_RECRUIT
	var_35_0.compName = "DailyRecruitMainComp"
	var_35_0.type = var_0_3:getRecruitKnightCfgById(var_0_3:getDailyRecruitInfo().recruit_knight_id).type
	var_35_0.iconUrl1 = "ui://recruit/icon_zm_meirishilian3"
	var_35_0.iconUrl2 = "ui://recruit/icon_zm_meirishilian4"
	var_35_0.title = var_0_3:getDailyRecruitName()
	var_35_0.titleTip = g.core.lang:get(108651)
	var_35_0.priority = var_0_3:getDisplayInfoById(var_0_1.DISPLAY_RECRUIT_ID).cfg.priority
	var_35_0.redId = 453

	function var_35_0.show()
		if not g.core.common.ModuleUnlock:isModuleShow(var_35_0.funcId, nil, true) then
			return false
		end

		return true
	end

	function var_35_0.isUnlock()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_35_0.funcId, nil, true)
	end

	table.insert(arg_35_0, var_35_0)
end

function var_0_0._getUniteTokenCfg()
	local var_38_0 = {
		funcId = g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_UNITE_TOKEN_NORMAL
	}

	var_38_0.iconUrl1 = "ui://recruit/icon_zm_jianding1"
	var_38_0.iconUrl2 = "ui://recruit/icon_zm_jianding2"
	var_38_0.title = g.core.lang:get(108112)
	var_38_0.titleTip = g.core.lang:get(108113)
	var_38_0.tabType = "unite"
	var_38_0.redId = 333
	var_38_0.packageName = "recruitUniteToken"
	var_38_0.subTree = {}

	for iter_38_0, iter_38_1 in ipairs({
		var_0_0._uniteTokenNormalCfg,
		var_0_0._uniteTokenLimitCfg
	}) do
		iter_38_1(var_38_0.subTree)
	end

	for iter_38_2, iter_38_3 in pairs(var_38_0.subTree) do
		iter_38_3.ownerType = var_38_0.tabType
	end

	table.sort(var_38_0.subTree, var_0_0._sortList)

	if #var_38_0.subTree < 1 then
		return
	end

	var_38_0.priority = var_38_0.subTree[1].priority

	return var_38_0
end

function var_0_0._uniteTokenNormalCfg(arg_39_0)
	local var_39_0 = g.core.model.User.recruitData:getDisplayInfoById(100011)
	local var_39_1 = {}
	local var_39_2 = g.core.model.User.recruitData:getRecruitKnightCfgById(100011)

	var_39_1.id = var_39_2.id
	var_39_1.funcId = g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_UNITE_TOKEN_NORMAL
	var_39_1.type = var_39_2.type
	var_39_1.compName = "RecruitUniteTokenComp"
	var_39_1.iconUrl1 = "ui://recruit/icon_zm_gudaijingpo1"
	var_39_1.iconUrl2 = "ui://recruit/icon_zm_gudaijingpo2"
	var_39_1.title = var_39_0.cfg.name
	var_39_1.titleTip = var_39_0.cfg.tab_title
	var_39_1.bgUrl = "bg/recruit/bg_zm_putongguwu.jpg"
	var_39_1.uniteTokenShopId = 14
	var_39_1.priority = var_39_0.cfg.priority
	var_39_1.luckHelpId = 20000
	var_39_1.redId = 407

	function var_39_1.show()
		return g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_UNITE_TOKEN_NORMAL)
	end

	function var_39_1.isUnlock()
		return g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_UNITE_TOKEN_NORMAL, nil, true)
	end

	var_39_1.isRedPointShow = {}

	if var_39_1.show() then
		table.insert(arg_39_0, var_39_1)
	end
end

function var_0_0._uniteTokenLimitCfg(arg_42_0)
	local function var_42_0(arg_43_0)
		local var_43_0 = arg_43_0:getInfo().sub_activity_id or arg_43_0:getActivityValue()
		local var_43_1 = g.core.model.User.recruitData:getDisplayInfoById(var_43_0)
		local var_43_2 = {
			id = var_43_0,
			funcId = g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_UNITE_TOKEN_LIMIT,
			compName = var_43_1.cfg.backcomp,
			type = g.core.model.User.recruitData:getRecruitKnightCfgById(var_43_0).type
		}

		var_43_2.iconUrl1 = "ui://recruit/icon_zm_shenmijingpo1"
		var_43_2.iconUrl2 = "ui://recruit/icon_zm_shenmijingpo2"

		if var_43_1.cfg.bg then
			var_43_2.bgUrl = "bg/recruit/" .. var_43_1.cfg.bg or "bg/recruit/pic_zm_xianshi.jpg"
		end

		var_43_2.title = var_43_1.cfg.name
		var_43_2.titleTip = var_43_1.cfg.tab_title
		var_43_2.uniteTokenShopId = 15
		var_43_2.compData = arg_43_0
		var_43_2.priority = var_43_1.cfg.priority
		var_43_2.luckHelpId = 20001
		var_43_2.redId = 334

		function var_43_2.show()
			return true
		end

		function var_43_2.isUnlock()
			return true
		end

		var_43_2.isRedPointShow = {}

		return var_43_2
	end

	local var_42_1 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE

	local function var_42_2(arg_46_0)
		if arg_46_0:getActivityType() == var_42_1.LIMIT_RECRUIT then
			local var_46_0 = arg_46_0:getInfo()

			if g.core.model.User.recruitData:getRecruitKnightCfgById(var_46_0.sub_activity_id or var_46_0.activity_value).function_id == RecruitConst.RECRUIT_FUNC_ID.UNITE_TOKEN_LIMIT_FUNC_ID then
				local var_46_1 = arg_46_0:isOpen() and g.core.common.ServerTime:getTime() < arg_46_0:getFinishTime()

				if var_46_1 then
					var_46_1 = g.core.common.ModuleUnlock:isModuleUnlock(g.core.model.User.recruitData:getRecruitKnightCfgById(arg_46_0:getInfo().sub_activity_id or arg_46_0:getActivityValue()).function_id)
				end

				return var_46_1
			else
				return false
			end
		end
	end

	local var_42_3 = g.core.model.User.recruitData:getRecruitListByFilter(var_42_2)

	for iter_42_0, iter_42_1 in ipairs((g.core.model.User.recruitData:getAllCrossData())) do
		if var_42_2(iter_42_1) then
			table.insert(var_42_3, iter_42_1)
		end
	end

	for iter_42_2, iter_42_3 in ipairs(var_42_3) do
		local var_42_4 = var_42_0(iter_42_3)

		if var_42_4.show() then
			table.insert(arg_42_0, var_42_4)
		end
	end
end

function var_0_0._getArtifactCfg(arg_47_0)
	local var_47_0 = {
		funcId = g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_UNITE_TOKEN_NORMAL
	}

	var_47_0.iconUrl1 = "ui://recruit/icon_zm_tiaopin1"
	var_47_0.iconUrl2 = "ui://recruit/icon_zm_tiaopin2"
	var_47_0.title = g.core.lang:get(108406)
	var_47_0.titleTip = g.core.lang:get(108411)
	var_47_0.tabType = RecruitConst.RECRUIT_TAB_TYPE.ARTIFACT_TAB
	var_47_0.packageName = "recruitArtifact"
	var_47_0.redId = 327
	var_47_0.subTree = arg_47_0 or {}

	for iter_47_0, iter_47_1 in ipairs({
		var_0_0._getNormalArtifactCfg,
		var_0_0._getLimitArtifactCfg
	}) do
		iter_47_1(var_47_0.subTree)
	end

	for iter_47_2, iter_47_3 in pairs(var_47_0.subTree) do
		iter_47_3.ownerType = var_47_0.tabType
	end

	table.sort(var_47_0.subTree, var_0_0._sortList)

	if #var_47_0.subTree < 1 then
		return
	end

	var_47_0.priority = var_47_0.subTree[1].priority

	return var_47_0
end

function var_0_0._getNormalArtifactCfg(arg_48_0)
	local var_48_0 = {
		329,
		328
	}

	for iter_48_0, iter_48_1 in ipairs({
		100007,
		100031
	}) do
		local var_48_1 = g.core.model.User.recruitData:getDisplayInfoById(iter_48_1)
		local var_48_2 = {}
		local var_48_3 = g.core.model.User.recruitData:getRecruitKnightCfgById(iter_48_1)

		var_48_2.id = var_48_3.id
		var_48_2.funcId = var_48_3.function_id
		var_48_2.compName = var_48_1.cfg.backcomp
		var_48_2.type = var_48_3.type
		var_48_2.iconUrl1 = "ui://recruit/" .. var_48_1.cfg.icon .. "1"
		var_48_2.iconUrl2 = "ui://recruit/" .. var_48_1.cfg.icon .. "2"

		if var_48_1.cfg.bg then
			var_48_2.bgUrl = "bg/recruit/" .. var_48_1.cfg.bg or "bg/recruit/pic_zm_xianshi.jpg"
		end

		var_48_2.title = var_48_1.cfg.name
		var_48_2.titleTip = var_48_1.cfg.tab_title
		var_48_2.priority = var_48_1.cfg.priority
		var_48_2.redId = var_48_0[iter_48_0]
		var_48_2.useLuck = var_48_3.type ~= RecruitConst.RECRUIT_TYPE.ARTIFACT_BASE

		function var_48_2.show()
			return g.core.common.ModuleUnlock:isModuleShow(var_48_2.funcId) and not g.core.model.User.homeData:isCensorRecruit(var_48_3.id)
		end

		function var_48_2.isUnlock()
			return g.core.common.ModuleUnlock:isModuleUnlock(var_48_2.funcId, nil, true)
		end

		var_48_2.isRedPointShow = {}

		if var_48_2.show() then
			table.insert(arg_48_0, var_48_2)
		end
	end
end

function var_0_0._getLimitArtifactCfg(arg_51_0)
	local function var_51_0(arg_52_0)
		local var_52_0 = arg_52_0:getInfo().sub_activity_id or arg_52_0:getActivityValue()
		local var_52_1 = g.core.model.User.recruitData:getDisplayInfoById(var_52_0)
		local var_52_2 = {
			id = var_52_0,
			funcId = g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_ARTIFACT_LIMIT,
			compName = var_52_1.cfg.backcomp,
			type = g.core.model.User.recruitData:getRecruitKnightCfgById(var_52_0).type
		}
		local var_52_3 = var_52_1.cfg.icon

		if not var_52_1.cfg.icon or #var_52_3 < 1 or var_52_3 == "0" then
			var_52_3 = "icon_zm_shenmijingpo"
		end

		var_52_2.iconUrl1 = "ui://recruit/" .. var_52_3 .. "1"
		var_52_2.iconUrl2 = "ui://recruit/" .. var_52_3 .. "2"

		if var_52_1.cfg.bg then
			var_52_2.bgUrl = "bg/recruit/" .. var_52_1.cfg.bg or "bg/recruit/pic_zm_xianshi.jpg"
		end

		var_52_2.title = var_52_1.cfg.name
		var_52_2.titleTip = var_52_1.cfg.tab_title
		var_52_2.compData = arg_52_0
		var_52_2.priority = var_52_1.cfg.priority
		var_52_2.redId = 328
		var_52_2.useLuck = true

		function var_52_2.show()
			return true
		end

		function var_52_2.isUnlock()
			return true
		end

		var_52_2.isRedPointShow = {}

		return var_52_2
	end

	local var_51_1 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE

	local function var_51_2(arg_55_0)
		if arg_55_0:getActivityType() == var_51_1.LIMIT_RECRUIT then
			local var_55_0 = arg_55_0:getInfo()

			if g.core.model.User.recruitData:getRecruitKnightCfgById(var_55_0.sub_activity_id or var_55_0.activity_value).function_id == g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_ARTIFACT_LIMIT then
				local var_55_1 = arg_55_0:isOpen() and g.core.common.ServerTime:getTime() < arg_55_0:getFinishTime()

				if var_55_1 then
					var_55_1 = g.core.common.ModuleUnlock:isModuleUnlock(g.core.model.User.recruitData:getRecruitKnightCfgById(arg_55_0:getInfo().sub_activity_id or arg_55_0:getActivityValue()).function_id)
				end

				return var_55_1
			else
				return false
			end
		end
	end

	local var_51_3 = g.core.model.User.recruitData:getRecruitListByFilter(var_51_2)

	for iter_51_0, iter_51_1 in ipairs((g.core.model.User.recruitData:getAllCrossData())) do
		if var_51_2(iter_51_1) then
			table.insert(var_51_3, iter_51_1)
		end
	end

	for iter_51_2, iter_51_3 in ipairs(var_51_3) do
		local var_51_4 = var_51_0(iter_51_3)

		if var_51_4.show() then
			table.insert(arg_51_0, var_51_4)
		end
	end
end

function var_0_0.getPetCfg()
	local var_56_0 = {
		funcId = g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_GENERIAL
	}

	var_56_0.iconUrl1 = "ui://recruit/icon_yzsl_yuanzhishou1"
	var_56_0.iconUrl2 = "ui://recruit/icon_yzsl_yuanzhishou2"
	var_56_0.title = g.core.lang:get(108429)
	var_56_0.titleTip = g.core.lang:get(108430)
	var_56_0.tabType = g.core.const.ConstMgr.RecruitConst.RECRUIT_TAB_TYPE.PET_TAB
	var_56_0.packageName = "recruitPet"
	var_56_0.subTree = {}

	for iter_56_0, iter_56_1 in ipairs({
		var_0_0._petBaseCfg,
		var_0_0._getLimitPetCfg
	}) do
		iter_56_1(var_56_0.subTree)
	end

	for iter_56_2, iter_56_3 in pairs(var_56_0.subTree) do
		iter_56_3.ownerType = var_56_0.tabType
	end

	if #var_56_0.subTree < 1 then
		return
	end

	table.sort(var_56_0.subTree, var_0_0._sortList)

	var_56_0.priority = var_56_0.subTree[1].priority

	return var_56_0
end

function var_0_0._petBaseCfg(arg_57_0)
	local var_57_0 = g.core.model.User.recruitData:getDisplayInfoById(100012)
	local var_57_1 = {}
	local var_57_2 = g.core.model.User.recruitData:getRecruitKnightCfgById(100012)

	var_57_1.id = var_57_2.id
	var_57_1.funcId = var_57_2.function_id
	var_57_1.iconUrl1 = "ui://recruit/" .. var_57_0.cfg.icon .. "1"
	var_57_1.iconUrl2 = "ui://recruit/" .. var_57_0.cfg.icon .. "2"
	var_57_1.title = var_57_0.cfg.name
	var_57_1.titleTip = var_57_0.cfg.tab_title
	var_57_1.compName = var_57_0.cfg.backcomp
	var_57_1.type = g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.PET_BASE

	if var_57_0.cfg.bg then
		var_57_1.bgUrl = "bg/recruit/" .. var_57_0.cfg.bg .. ".jpg" or "bg/recruit/pic_zm_xianshi.jpg"
	end

	var_57_1.priority = var_57_0.cfg.priority
	var_57_1.useLuck = true

	function var_57_1.show()
		return g.core.common.ModuleUnlock:isModuleShow(var_57_1.funcId)
	end

	function var_57_1.isUnlock()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_57_1.funcId, nil, true)
	end

	var_57_1.isRedPointShow = {}

	if var_57_1.show() then
		table.insert(arg_57_0, var_57_1)
	end
end

function var_0_0._getLimitPetCfg(arg_60_0)
	local function var_60_0(arg_61_0)
		local var_61_0 = arg_61_0:getInfo().sub_activity_id or arg_61_0:getActivityValue()
		local var_61_1 = g.core.model.User.recruitData:getDisplayInfoById(var_61_0)
		local var_61_2 = {
			id = var_61_0,
			funcId = g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_PET_LIMIT,
			compName = var_61_1.cfg.backcomp,
			type = g.core.model.User.recruitData:getRecruitKnightCfgById(var_61_0).type,
			iconUrl1 = "ui://recruit/" .. var_61_1.cfg.icon .. "1",
			iconUrl2 = "ui://recruit/" .. var_61_1.cfg.icon .. "2"
		}

		if var_61_1.cfg.bg then
			var_61_2.bgUrl = "bg/recruit/" .. var_61_1.cfg.bg .. ".jpg" or "bg/recruit/pic_zm_xianshi.jpg"
		end

		var_61_2.title = var_61_1.cfg.name
		var_61_2.titleTip = var_61_1.cfg.tab_title
		var_61_2.compData = arg_61_0
		var_61_2.priority = var_61_1.cfg.priority
		var_61_2.redId = 328
		var_61_2.useLimitLuck = true
		var_61_2.luckHelpId = 20002

		function var_61_2.show()
			return true
		end

		function var_61_2.isUnlock()
			return true
		end

		var_61_2.isRedPointShow = {}

		return var_61_2
	end

	local var_60_1 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE

	local function var_60_2(arg_64_0)
		if arg_64_0:getActivityType() == var_60_1.LIMIT_RECRUIT then
			local var_64_0 = arg_64_0:getInfo()

			if g.core.model.User.recruitData:getRecruitKnightCfgById(var_64_0.sub_activity_id or var_64_0.activity_value).function_id == g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_PET_LIMIT then
				local var_64_1 = arg_64_0:isOpen() and g.core.common.ServerTime:getTime() < arg_64_0:getFinishTime()

				if var_64_1 then
					var_64_1 = g.core.common.ModuleUnlock:isModuleUnlock(g.core.model.User.recruitData:getRecruitKnightCfgById(arg_64_0:getInfo().sub_activity_id or arg_64_0:getActivityValue()).function_id)
				end

				return var_64_1
			else
				return false
			end
		end
	end

	local var_60_3 = g.core.model.User.recruitData:getRecruitListByFilter(var_60_2)

	for iter_60_0, iter_60_1 in ipairs((g.core.model.User.recruitData:getAllCrossData())) do
		if var_60_2(iter_60_1) then
			table.insert(var_60_3, iter_60_1)
		end
	end

	for iter_60_2, iter_60_3 in ipairs(var_60_3) do
		local var_60_4 = var_60_0(iter_60_3)

		if var_60_4.show() then
			table.insert(arg_60_0, var_60_4)
		end
	end
end

function var_0_0.getKnightSoulCfg()
	local var_65_0 = {
		funcId = g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_KNIGHT_SOUL_BASE
	}

	var_65_0.iconUrl1 = "ui://recruit/icon_zm_mingxing1"
	var_65_0.iconUrl2 = "ui://recruit/icon_zm_mingxing2"
	var_65_0.title = g.core.lang:get(108470)
	var_65_0.titleTip = g.core.lang:get(108463)
	var_65_0.redId = 732
	var_65_0.tabType = g.core.const.ConstMgr.RecruitConst.RECRUIT_TAB_TYPE.KNIGHT_SOUL_TAB
	var_65_0.packageName = "recruitKnightSoul"
	var_65_0.subTree = {}

	for iter_65_0, iter_65_1 in ipairs({
		var_0_0._knightSoulBaseCfg,
		var_0_0._knightSoulLimitCfg
	}) do
		iter_65_1(var_65_0.subTree)
	end

	for iter_65_2, iter_65_3 in pairs(var_65_0.subTree) do
		iter_65_3.ownerType = var_65_0.tabType
	end

	if #var_65_0.subTree < 1 then
		return
	end

	table.sort(var_65_0.subTree, var_0_0._sortList)

	var_65_0.priority = var_65_0.subTree[1].priority

	return var_65_0
end

function var_0_0._knightSoulBaseCfg(arg_66_0)
	local var_66_0 = g.core.model.User.recruitData:getDisplayInfoById(100017)
	local var_66_1 = {}
	local var_66_2 = g.core.model.User.recruitData:getRecruitKnightCfgById(100017)

	var_66_1.id = var_66_2.id
	var_66_1.funcId = var_66_2.function_id
	var_66_1.iconUrl1 = "ui://recruit/" .. var_66_0.cfg.icon .. "1"
	var_66_1.iconUrl2 = "ui://recruit/" .. var_66_0.cfg.icon .. "2"
	var_66_1.title = var_66_0.cfg.name
	var_66_1.titleTip = var_66_0.cfg.tab_title
	var_66_1.compName = var_66_0.cfg.backcomp
	var_66_1.type = g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.KNIGHT_SOUL_RECRUIT

	if var_66_0.cfg.bg then
		var_66_1.bgUrl = "bg/recruit/" .. var_66_0.cfg.bg or "bg/recruit/pic_zm_xianshi.jpg"
	end

	var_66_1.priority = var_66_0.cfg.priority
	var_66_1.redId = 724

	function var_66_1.show()
		return g.core.common.ModuleUnlock:isModuleShow(var_66_1.funcId)
	end

	function var_66_1.isUnlock()
		return g.core.common.ModuleUnlock:isModuleUnlock(var_66_1.funcId, nil, true)
	end

	var_66_1.isRedPointShow = {}

	if var_66_1.show() then
		table.insert(arg_66_0, var_66_1)
	end
end

function var_0_0._knightSoulLimitCfg(arg_69_0)
	local function var_69_0(arg_70_0)
		local var_70_0 = arg_70_0:getInfo().sub_activity_id or arg_70_0:getActivityValue()
		local var_70_1 = g.core.model.User.recruitData:getDisplayInfoById(var_70_0)
		local var_70_2 = {
			id = var_70_0,
			funcId = g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_KNIGHT_SOUL_LIMIT,
			compName = var_70_1.cfg.backcomp,
			type = g.core.model.User.recruitData:getRecruitKnightCfgById(var_70_0).type,
			iconUrl1 = "ui://recruit/" .. var_70_1.cfg.icon .. "1",
			iconUrl2 = "ui://recruit/" .. var_70_1.cfg.icon .. "2"
		}

		if var_70_1.cfg.bg then
			var_70_2.bgUrl = "bg/recruit/" .. var_70_1.cfg.bg or "bg/recruit/pic_zm_xianshi.jpg"
		end

		var_70_2.title = var_70_1.cfg.name
		var_70_2.titleTip = var_70_1.cfg.tab_title
		var_70_2.compData = arg_70_0
		var_70_2.priority = var_70_1.cfg.priority
		var_70_2.redId = 731

		function var_70_2.show()
			return true
		end

		function var_70_2.isUnlock()
			return true
		end

		var_70_2.isRedPointShow = {}

		return var_70_2
	end

	local var_69_1 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE

	for iter_69_0, iter_69_1 in ipairs((g.core.model.User.recruitData:getRecruitListByFilter(function(arg_73_0)
		if arg_73_0:getActivityType() == var_69_1.LIMIT_RECRUIT then
			local var_73_0 = arg_73_0:getInfo()

			if g.core.model.User.recruitData:getRecruitKnightCfgById(var_73_0.sub_activity_id or var_73_0.activity_value).function_id == g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_KNIGHT_SOUL_LIMIT then
				local var_73_1 = arg_73_0:isOpen() and g.core.common.ServerTime:getTime() < arg_73_0:getFinishTime()

				if var_73_1 then
					var_73_1 = g.core.common.ModuleUnlock:isModuleUnlock(g.core.model.User.recruitData:getRecruitKnightCfgById(arg_73_0:getInfo().sub_activity_id or arg_73_0:getActivityValue()).function_id)
				end

				return var_73_1
			else
				return false
			end
		end
	end))) do
		local var_69_2 = var_69_0(iter_69_1)

		if var_69_2.show() then
			table.insert(arg_69_0, var_69_2)
		end
	end
end

function var_0_0.getPreciousCfg()
	local var_74_0 = {
		funcId = g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_PRECIOUS
	}

	var_74_0.iconUrl1 = "ui://recruit/icon_zm_mibao1"
	var_74_0.iconUrl2 = "ui://recruit/icon_zm_mibao2"
	var_74_0.title = g.core.lang:get(108473)
	var_74_0.titleTip = g.core.lang:get(108474)
	var_74_0.redId = 761
	var_74_0.tabType = g.core.const.ConstMgr.RecruitConst.RECRUIT_TAB_TYPE.PRECIOUS_TAB
	var_74_0.packageName = "recruitPrecious"
	var_74_0.subTree = {}

	for iter_74_0, iter_74_1 in ipairs({
		var_0_0._preciousBaseCfg,
		var_0_0._preciousLimitCfg
	}) do
		iter_74_1(var_74_0.subTree)
	end

	for iter_74_2, iter_74_3 in pairs(var_74_0.subTree) do
		iter_74_3.ownerType = var_74_0.tabType
	end

	if #var_74_0.subTree < 1 then
		return
	end

	table.sort(var_74_0.subTree, var_0_0._sortList)

	var_74_0.priority = var_74_0.subTree[1].priority

	return var_74_0
end

function var_0_0.getSuccubaCfg()
	local var_75_0 = {
		funcId = g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_NORMAL_SUCCUBA
	}

	var_75_0.iconUrl1 = "ui://recruit/icon_zm_mnjiangou1"
	var_75_0.iconUrl2 = "ui://recruit/icon_zm_mnjiangou2"
	var_75_0.title = g.core.lang:get(431301)
	var_75_0.titleTip = g.core.lang:get(431302)
	var_75_0.redId = 926
	var_75_0.tabType = g.core.const.ConstMgr.RecruitConst.RECRUIT_TAB_TYPE.SUCCUBA_TAB
	var_75_0.packageName = "recruitSuccuba"
	var_75_0.subTree = {}

	for iter_75_0, iter_75_1 in ipairs({
		var_0_0._normalSuccubaCfg
	}) do
		iter_75_1(var_75_0.subTree)
	end

	for iter_75_2, iter_75_3 in pairs(var_75_0.subTree) do
		iter_75_3.ownerType = var_75_0.tabType
	end

	if #var_75_0.subTree < 1 then
		return
	end

	table.sort(var_75_0.subTree, var_0_0._sortList)

	var_75_0.priority = var_75_0.subTree[1].priority

	return var_75_0
end

function var_0_0._normalSuccubaCfg(arg_76_0)
	local var_76_0 = g.core.model.User.recruitData:getDisplayInfoById(100096)
	local var_76_1 = {
		id = g.core.model.User.recruitData:getRecruitKnightCfgById(100096).id,
		funcId = g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_NORMAL_SUCCUBA
	}

	var_76_1.compName = "RecruitSuccubaNormal"
	var_76_1.iconUrl1 = "ui://recruit/icon_mnzm_lingxingjianyue1"
	var_76_1.iconUrl2 = "ui://recruit/icon_mnzm_lingxingjianyue2"
	var_76_1.title = var_76_0.cfg.name
	var_76_1.titleTip = var_76_0.cfg.tab_title
	var_76_1.type = RecruitConst.RECRUIT_TYPE.RECRUIT_SUCCUBA
	var_76_1.bgUrl = "bg/recruit/bg_mnzm_kachi01.jpg"
	var_76_1.priority = var_76_0.cfg.priority
	var_76_1.useLuck = false

	function var_76_1.show()
		return g.core.common.ModuleUnlock:isModuleShow(g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_NORMAL_SUCCUBA)
	end

	function var_76_1.isUnlock()
		return g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.RECRUIT_NORMAL_SUCCUBA, nil, true)
	end

	var_76_1.isRedPointShow = {}

	if var_76_1.show() then
		table.insert(arg_76_0, var_76_1)
	end

	return var_76_1
end

function var_0_0._preciousBaseCfg(arg_79_0)
	for iter_79_0, iter_79_1 in ipairs((g.core.model.User.recruitData:getPreciousBaseList())) do
		local var_79_0 = g.core.model.User.recruitData:getDisplayInfoById(iter_79_1)
		local var_79_1 = {}
		local var_79_2 = g.core.model.User.recruitData:getRecruitKnightCfgById(iter_79_1)

		var_79_1.id = var_79_2.id
		var_79_1.funcId = var_79_2.function_id
		var_79_1.iconUrl1 = "ui://recruit/" .. var_79_0.cfg.icon .. "1"
		var_79_1.iconUrl2 = "ui://recruit/" .. var_79_0.cfg.icon .. "2"
		var_79_1.title = var_79_0.cfg.name
		var_79_1.titleTip = var_79_0.cfg.tab_title
		var_79_1.compName = var_79_0.cfg.backcomp
		var_79_1.type = g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.PRECIOUS

		if var_79_0.cfg.bg then
			var_79_1.bgUrl = "bg/recruit/" .. var_79_0.cfg.bg or "bg/recruit/pic_zm_xianshi.jpg"
		end

		var_79_1.priority = var_79_0.cfg.priority
		var_79_1.compData = {
			id = iter_79_1
		}
		var_79_1.useLuck = true

		function var_79_1.show()
			return g.core.common.ModuleUnlock:isModuleShow(var_79_1.funcId)
		end

		function var_79_1.isUnlock()
			return g.core.common.ModuleUnlock:isModuleUnlock(var_79_1.funcId, nil, true)
		end

		var_79_1.isRedPointShow = {}

		if var_79_1.show() then
			table.insert(arg_79_0, var_79_1)
		end
	end
end

function var_0_0._preciousLimitCfg(arg_82_0)
	local function var_82_0(arg_83_0)
		local var_83_0 = arg_83_0:getInfo().sub_activity_id or arg_83_0:getActivityValue()
		local var_83_1 = g.core.model.User.recruitData:getRecruitKnightCfgById(var_83_0)
		local var_83_2 = g.core.model.User.recruitData:getDisplayInfoById(var_83_0)
		local var_83_3 = {
			id = var_83_0,
			actId = arg_83_0:getActivityValue(),
			funcId = var_83_1.function_id,
			compName = var_83_2.cfg.backcomp,
			type = var_83_1.type,
			iconUrl1 = "ui://recruit/" .. var_83_2.cfg.icon .. "1",
			iconUrl2 = "ui://recruit/" .. var_83_2.cfg.icon .. "2"
		}

		if var_83_2.cfg.bg then
			var_83_3.bgUrl = "bg/recruit/" .. var_83_2.cfg.bg or "bg/recruit/pic_zm_xianshi.jpg"
		end

		var_83_3.title = var_83_2.cfg.name
		var_83_3.titleTip = var_83_2.cfg.tab_title
		var_83_3.compData = {
			activityData = arg_83_0
		}
		var_83_3.priority = var_83_2.cfg.priority

		local var_83_4, var_83_5, var_83_6, var_83_7 = g.core.common.ServerTime:getLeftTimeParts((arg_83_0:getFinishTime()))

		var_83_3.redId = var_83_4 > 100 and 766 or 762
		var_83_3.useLuck = true

		function var_83_3.show()
			return true
		end

		function var_83_3.isUnlock()
			return true
		end

		var_83_3.isRedPointShow = {}

		return var_83_3
	end

	local var_82_1 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE

	for iter_82_0, iter_82_1 in ipairs((g.core.model.User.recruitData:getRecruitListByFilter(function(arg_86_0)
		if arg_86_0:getActivityType() == var_82_1.LIMIT_RECRUIT then
			local var_86_0 = arg_86_0:getInfo()

			if g.core.model.User.recruitData:getRecruitKnightCfgById(var_86_0.sub_activity_id or var_86_0.activity_value).type == RecruitConst.RECRUIT_TYPE.PRECIOUS then
				local var_86_1 = arg_86_0:isOpen() and g.core.common.ServerTime:getTime() < arg_86_0:getFinishTime()

				if var_86_1 then
					var_86_1 = g.core.common.ModuleUnlock:isModuleUnlock(g.core.model.User.recruitData:getRecruitKnightCfgById(arg_86_0:getInfo().sub_activity_id or arg_86_0:getActivityValue()).function_id)
				end

				return var_86_1
			else
				return false
			end
		end
	end))) do
		local var_82_2 = var_82_0(iter_82_1)

		if var_82_2.show() then
			table.insert(arg_82_0, var_82_2)
		end
	end
end

function var_0_0:addBtnTip(arg_87_1, arg_87_2)
	local var_87_0 = self:getChild("recruitTipText")

	if not var_87_0 then
		var_87_0 = fgui.GBasicTextField:create()

		var_87_0:setPivot(1, 0.5, true)
		var_87_0:setColor(g.core.common.Color.A6)
		var_87_0:enableOutline(2, g.core.common.Color.A2)
		var_87_0:setFontSize(18)

		local var_87_1 = self:getSize()
		local var_87_2 = cc.p(var_87_1.width - 20, var_87_1.height - 26)
		local var_87_3

		if self.m_recruitTwentyBtn and self.m_recruitTwentyBtn:isVisible() then
			var_87_3 = self.m_recruitTwentyBtn
		elseif self.m_recruitTenBtn then
			var_87_3 = self.m_recruitTenBtn
		end

		if var_87_3 then
			local var_87_4 = self.m_recruitTenBtn:getPosition()
			local var_87_5 = self.m_recruitTenBtn:getSize()

			if arg_87_2 then
				var_87_2.x = var_87_4.x + var_87_5.width + 2
				var_87_2.y = var_87_4.y + var_87_5.height + 10
			else
				var_87_2.x = var_87_4.x + var_87_5.width + 2
				var_87_2.y = var_87_4.y - 2
			end
		end

		var_87_0:setPosition(var_87_2)
		var_87_0:addRelation(self, require("app.core.fairygui.RelationType").Right_Right)
		var_87_0:addRelation(self, require("app.core.fairygui.RelationType").Bottom_Bottom)
		var_87_0:setName("recruitTipText")
		self:addChild(var_87_0)
	end

	if arg_87_1 == RecruitConst.RECRUIT_TAB_TYPE.KNIGHT_TAB then
		var_87_0:setText(g.core.lang:get(108480))
	elseif arg_87_1 == RecruitConst.RECRUIT_TAB_TYPE.UNITE_TAB then
		var_87_0:setText(g.core.lang:get(108481))
	elseif arg_87_1 == RecruitConst.RECRUIT_TAB_TYPE.ARTIFACT_TAB then
		var_87_0:setText(g.core.lang:get(108482))
	elseif arg_87_1 == RecruitConst.RECRUIT_TAB_TYPE.PET_TAB then
		var_87_0:setText(g.core.lang:get(108483))
	elseif arg_87_1 == RecruitConst.RECRUIT_TAB_TYPE.KNIGHT_SOUL_TAB then
		var_87_0:setText(g.core.lang:get(108484))
	elseif arg_87_1 == RecruitConst.RECRUIT_TAB_TYPE.PRECIOUS_TAB then
		var_87_0:setText(g.core.lang:get(108487))
	elseif arg_87_1 == RecruitConst.RECRUIT_TAB_TYPE.SUCCUBA_TAB then
		var_87_0:setText(g.core.lang:get(431303))
	else
		var_87_0:setText("")
	end

	var_87_0:setOpacity(0)
	var_87_0:stopAllFGActions()
	var_87_0:runFGAction(fgui.FFadeIn:create(0.5))

	return var_87_0
end

return var_0_0
