local var_0_0 = {}

GUIDEACTION_SNAP = 1
GUIDEACTION_EXPLAIN = 2
GUIDEACTION_TIPS = 3
GUIDEACTION_FINGER = 4
GUIDEACTION_ANI = 5
GUIDEACTION_ALERT = 6
GUIDEACTION_TALK = 7
TRIGGER_MANUAL = 0
TRIGGER_PASSLEVEL = 1
TRIGGER_LEVELUP = 2
TRIGGER_GETITEM = 3
TRIGGER_PUSHINBAG = 4
TRIGGER_PASSBEFOREBOSS = 5
TRIGGER_FAIL = 6
TRIGGER_FIGHT = 7
TRIGGER_SMALLBOSS = 8
TRIGGER_UNLOCKCHAPTER = 9
TRIGGER_GETITEM_BY_ID = 10
GUIDE_FIGHT_UI_CLASS = 100
GUIDE_FIGHT_USEXP_CLASS = 101

local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local GuideListenerExt = require("view.Layer.Guide.GuideListenerExt")
local GuideEventDispatcher = require("view.Layer.Guide.GuideEventDispatcher")
local guide_data = require("data.guide_data")
local guide_class_data = require("data.guide_class_data")

var_0_0.working = false
var_0_0.triggerTbl = {
	[TRIGGER_PASSLEVEL] = {},
	[TRIGGER_LEVELUP] = {},
	[TRIGGER_GETITEM] = {},
	[TRIGGER_PUSHINBAG] = {},
	[TRIGGER_PASSBEFOREBOSS] = {},
	[TRIGGER_FAIL] = {},
	[TRIGGER_FIGHT] = {},
	[TRIGGER_SMALLBOSS] = {},
	[TRIGGER_UNLOCKCHAPTER] = {},
	[TRIGGER_GETITEM_BY_ID] = {}
}
var_0_0.triggeredGuides = {
	scene = {},
	ListButtonLayer = {},
	TopcostLayer = {},
	PlotLayer = {}
}

local var_0_7 = false
local var_0_8 = false

local function var_0_9(arg_1_0, arg_1_1)
	if not arg_1_0 then
		return nil
	end

	local function var_1_0(arg_2_0)
		if type(arg_2_0) == "table" then
			for iter_2_0, iter_2_1 in pairs(arg_2_0) do
				local var_2_0 = var_1_0(iter_2_1)

				if var_2_0 then
					return var_2_0
				end
			end

			return nil
		elseif arg_2_0:getName() == arg_1_1 then
			return arg_2_0
		else
			return var_1_0(arg_2_0:getChildren())
		end
	end

	return var_1_0(arg_1_0)
end

local function var_0_10(arg_3_0)
	if not arg_3_0 then
		return nil
	end

	if tolua.isnull(arg_3_0) then
		return nil
	end

	return {
		obj = arg_3_0
	}
end

local function var_0_11(arg_4_0)
	local var_4_0, var_4_1 = arg_4_0:match("(.+),(.+)")

	return cc.p(tonumber(var_4_0), tonumber(var_4_1))
end

local function var_0_12(arg_5_0, arg_5_1)
	if guide_data[arg_5_1].shelter ~= 1 then
		return nil
	end

	if guide_data[arg_5_1].shelteruiname then
		if not arg_5_0 then
			return nil
		end

		local var_5_0 = var_0_9(arg_5_0, guide_data[arg_5_1].shelteruiname)

		if not var_5_0 then
			return nil
		end

		local var_5_1 = {}

		if guide_data[arg_5_1].shelterpos then
			var_5_1.offset = var_0_11(guide_data[arg_5_1].shelterpos)
		end

		if guide_data[arg_5_1].sheltersubuiname then
			var_5_0 = var_0_9(var_5_0, guide_data[arg_5_1].sheltersubuiname)

			if var_5_0 then
				var_5_1.obj = var_5_0

				return var_5_1
			else
				return nil
			end
		else
			var_5_1.obj = var_5_0

			return var_5_1
		end
	elseif guide_data[arg_5_1].shelterpos then
		return {
			pos = var_0_11(guide_data[arg_5_1].shelterpos)
		}
	end

	return nil
end

local function var_0_13(arg_6_0)
	if (guide_class_data[arg_6_0.class].guide_level or 1) ~= RoleDefault:getInstance():getIntegerForKey("guide_level", 1) then
		return true
	end

	return arg_6_0.proceed >= guide_class_data[arg_6_0.class].total
end

local function var_0_14(arg_7_0)
	local var_7_0

	for iter_7_0, iter_7_1 in ipairs(var_0_0.triggerTbl[arg_7_0.triggertype]) do
		if iter_7_1.class == arg_7_0.class then
			var_7_0 = iter_7_0

			break
		end
	end

	if var_7_0 then
		return table.remove(var_0_0.triggerTbl[arg_7_0.triggertype], var_7_0)
	else
		return nil
	end
end

local function var_0_15(arg_8_0)
	if playermodel.is_new_player_guide then
		return true
	end

	return guide_class_data[arg_8_0.class].skip_or_not
end

local function var_0_16(arg_9_0)
	local var_9_0 = arg_9_0.proceed

	for iter_9_0 = arg_9_0.proceed + 1, guide_class_data[arg_9_0.class].total do
		if not GuideListenerExt.check_guide_autofinish_condition(guide_class_data[arg_9_0.class]["guide_" .. iter_9_0]) then
			break
		end

		var_9_0 = iter_9_0
	end

	arg_9_0.proceed = var_9_0

	return var_0_13(arg_9_0)
end

local function var_0_17(arg_10_0)
	table.insert(var_0_0.triggerTbl[arg_10_0.triggertype], arg_10_0)
end

local function var_0_18(arg_11_0)
	local var_11_0 = guide_data[arg_11_0].triggerlayer or "scene"

	var_0_0.triggeredGuides[var_11_0] = var_0_0.triggeredGuides[var_11_0] or {}
	var_0_0.triggeredGuides[var_11_0][arg_11_0] = var_11_0 == "ListButtonLayer" and guide_data[arg_11_0].executelayer or var_11_0 == "TopcostLayer" and guide_data[arg_11_0].executelayer or var_11_0 == "PlotLayer" and guide_data[arg_11_0].executelayer or true
end

local function var_0_19(arg_12_0)
	if (guide_data[arg_12_0].guide_level or 1) < RoleDefault:getInstance():getIntegerForKey("guide_level", 1) then
		return true
	end

	local var_12_1 = guide_class_data[guide_data[arg_12_0].guideclass]
	local time_check_manager = require("controller.time_check_manager")

	if guide_class_data[guide_data[arg_12_0].guideclass].starttime and var_12_1.starttime > time_check_manager:getCurTime() then
		return true
	end

	if var_12_1.endtime and var_12_1.endtime < time_check_manager:getCurTime() then
		return true
	end

	local var_12_3 = guide_data[arg_12_0].triggerlayer or "scene"

	if not var_0_0.triggeredGuides[var_12_3] then
		return false
	end

	if not var_0_0.triggeredGuides[var_12_3][arg_12_0] then
		return false
	end

	return true
end

local function var_0_20(arg_22_0)
	require("controller.goto_system_manager")
	goto_complete_system({
		jump_to_system = arg_22_0
	})
end

local var_0_21 = {
	[TRIGGER_PASSLEVEL] = function()
		for iter_13_0, iter_13_1 in pairs(var_0_0.triggerTbl[TRIGGER_PASSLEVEL]) do
			if level_manager:isPlayerPassLevel(iter_13_1.triggerparam) then
				var_0_0.insertNewTriggeredGuide(guide_class_data[iter_13_1.class]["guide_" .. iter_13_1.proceed + 1])
			end
		end
	end,
	[TRIGGER_LEVELUP] = function()
		for iter_15_0, iter_15_1 in pairs(var_0_0.triggerTbl[TRIGGER_LEVELUP]) do
			if iter_15_1.triggerparam <= playermodel.grade then
				var_0_0.insertNewTriggeredGuide(guide_class_data[iter_15_1.class]["guide_" .. iter_15_1.proceed + 1])
			end
		end
	end,
	[TRIGGER_GETITEM] = function(arg_16_0)
		for iter_16_0, iter_16_1 in pairs(var_0_0.triggerTbl[TRIGGER_GETITEM]) do
			if iter_16_1.triggerparam == arg_16_0 then
				var_0_0.insertNewTriggeredGuide(guide_class_data[iter_16_1.class]["guide_" .. iter_16_1.proceed + 1])
			end
		end
	end,
	[TRIGGER_PUSHINBAG] = function(arg_18_0)
		for iter_18_0, iter_18_1 in pairs(var_0_0.triggerTbl[TRIGGER_PUSHINBAG]) do
			if iter_18_1.triggerparam == arg_18_0 then
				var_0_0.insertNewTriggeredGuide(guide_class_data[iter_18_1.class]["guide_" .. iter_18_1.proceed + 1])
			end
		end
	end,
	[TRIGGER_PASSBEFOREBOSS] = function()
		for iter_14_0, iter_14_1 in pairs(var_0_0.triggerTbl[TRIGGER_PASSBEFOREBOSS]) do
			if level_manager:isPlayerPassBigBoss(iter_14_1.triggerparam) then
				var_0_0.insertNewTriggeredGuide(guide_class_data[iter_14_1.class]["guide_" .. iter_14_1.proceed + 1])
			end
		end
	end,
	[TRIGGER_FAIL] = function()
		for iter_19_0, iter_19_1 in pairs(var_0_0.triggerTbl[TRIGGER_FAIL]) do
			var_0_0.insertNewTriggeredGuide(guide_class_data[iter_19_1.class]["guide_" .. iter_19_1.proceed + 1])
		end
	end,
	[TRIGGER_SMALLBOSS] = function()
		for iter_20_0, iter_20_1 in pairs(var_0_0.triggerTbl[TRIGGER_SMALLBOSS]) do
			if level_manager:isPlayerPassSmallLevel(iter_20_1.triggerparam) then
				var_0_0.insertNewTriggeredGuide(guide_class_data[iter_20_1.class]["guide_" .. iter_20_1.proceed + 1])
			end
		end
	end,
	[TRIGGER_UNLOCKCHAPTER] = function()
		for iter_21_0, iter_21_1 in pairs(var_0_0.triggerTbl[TRIGGER_UNLOCKCHAPTER]) do
			if level_manager:isChapterCompleteUnlock(math.floor(iter_21_1.triggerparam / 1000), iter_21_1.triggerparam % 1000) then
				var_0_0.insertNewTriggeredGuide(guide_class_data[iter_21_1.class]["guide_" .. iter_21_1.proceed + 1])
			end
		end
	end,
	[TRIGGER_GETITEM_BY_ID] = function(arg_17_0)
		for iter_17_0, iter_17_1 in pairs(var_0_0.triggerTbl[TRIGGER_GETITEM_BY_ID]) do
			if iter_17_1.triggerparam == arg_17_0 then
				var_0_0.insertNewTriggeredGuide(guide_class_data[iter_17_1.class]["guide_" .. iter_17_1.proceed + 1])
			end
		end
	end
}

function var_0_0.triggerGuide(arg_23_0, ...)
	if not config.open_guide then
		return
	end

	var_0_21[arg_23_0](...)
end

function var_0_0:updateGuides()
	if not config.open_guide then
		return false
	end

	if not var_0_0.working then
		return false
	end

	if var_0_7 then
		return false
	end

	if var_0_8 then
		return false
	end

	local var_24_0 = false

	for iter_24_0, iter_24_1 in pairs(var_0_0.triggeredGuides.scene) do
		if GuideListenerExt.check_guide_conditions(iter_24_0) then
			LayerManager:getGuideObj():addGuide(iter_24_0, {
				shelterconf = var_0_12(nil, iter_24_0)
			})

			var_24_0 = true
		end
	end

	if not self.__cname then
		return var_24_0
	end

	for iter_24_2, iter_24_3 in pairs(var_0_0.triggeredGuides.ListButtonLayer) do
		if iter_24_3 == self.__cname and GuideListenerExt.check_guide_conditions(iter_24_2) then
			local var_24_1 = var_0_12(LayerManager:getUIElement("ListButton"), iter_24_2)

			if guide_data[iter_24_2].uiname then
				local var_24_2 = var_0_9(LayerManager:getUIElement("ListButton"), guide_data[iter_24_2].uiname)

				if guide_data[iter_24_2].subuiname then
					var_24_2 = var_0_9(var_24_2, guide_data[iter_24_2].subuiname)
				end

				if var_24_2 then
					local var_24_3 = var_0_10(var_24_2)

					var_24_3.shelterconf = var_24_1

					LayerManager:getGuideObj():addGuide(iter_24_2, var_24_3)

					var_24_0 = true
				end
			else
				LayerManager:getGuideObj():addGuide(iter_24_2, {
					shelterconf = var_24_1
				})

				var_24_0 = true
			end
		end
	end

	for iter_24_4, iter_24_5 in pairs(var_0_0.triggeredGuides.TopcostLayer) do
		if iter_24_5 == self.__cname and GuideListenerExt.check_guide_conditions(iter_24_4) then
			local var_24_5 = var_0_12(LayerManager:getUIElement("TopcostLayer"), iter_24_4)

			if guide_data[iter_24_4].uiname then
				local var_24_6 = var_0_9(LayerManager:getUIElement("TopcostLayer"), guide_data[iter_24_4].uiname)

				if guide_data[iter_24_4].subuiname then
					var_24_6 = var_0_9(var_24_6, guide_data[iter_24_4].subuiname)
				end

				if var_24_6 then
					local var_24_7 = var_0_10(var_24_6)

					var_24_7.shelterconf = var_24_5

					LayerManager:getGuideObj():addGuide(iter_24_4, var_24_7)

					var_24_0 = true
				end
			else
				LayerManager:getGuideObj():addGuide(iter_24_4, {
					shelterconf = var_24_5
				})

				var_24_0 = true
			end
		end
	end

	for iter_24_6, iter_24_7 in pairs(var_0_0.triggeredGuides.PlotLayer) do
		if iter_24_7 == self.__cname and GuideListenerExt.check_guide_conditions(iter_24_6) then
			local var_24_9 = var_0_12(LayerManager:getPlotObj(), iter_24_6)

			if guide_data[iter_24_6].uiname then
				local var_24_10 = var_0_9(LayerManager:getPlotObj(), guide_data[iter_24_6].uiname)

				if guide_data[iter_24_6].subuiname then
					var_24_10 = var_0_9(var_24_10, guide_data[iter_24_6].subuiname)
				end

				if var_24_10 then
					local var_24_11 = var_0_10(var_24_10)

					var_24_11.shelterconf = var_24_9

					LayerManager:getGuideObj():addGuide(iter_24_6, var_24_11)

					var_24_0 = true
				end
			else
				LayerManager:getGuideObj():addGuide(iter_24_6, {
					shelterconf = var_24_9
				})

				var_24_0 = true
			end
		end
	end

	if not var_0_0.triggeredGuides[self.__cname] then
		return var_24_0
	end

	for iter_24_8, iter_24_9 in pairs(var_0_0.triggeredGuides[self.__cname]) do
		if GuideListenerExt.check_guide_conditions(iter_24_8) then
			local var_24_13 = var_0_12(self, iter_24_8)
			local var_24_14 = GuideListenerExt.getGuideUIFunc(iter_24_8)

			if var_24_14 then
				local var_24_15 = var_24_14(self)

				if var_24_15 then
					local var_24_16 = var_0_10(var_24_15)

					var_24_16.shelterconf = var_24_13

					LayerManager:getGuideObj():addGuide(iter_24_8, var_24_16)

					var_24_0 = true
				end
			elseif guide_data[iter_24_8].uiname then
				local var_24_17 = var_0_9(self, guide_data[iter_24_8].uiname)

				if guide_data[iter_24_8].subuiname then
					var_24_17 = var_0_9(var_24_17, guide_data[iter_24_8].subuiname)
				end

				if var_24_17 then
					local var_24_18 = var_0_10(var_24_17)

					var_24_18.shelterconf = var_24_13

					LayerManager:getGuideObj():addGuide(iter_24_8, var_24_18)

					var_24_0 = true
				end
			else
				LayerManager:getGuideObj():addGuide(iter_24_8, {
					shelterconf = var_24_13
				})

				var_24_0 = true
			end
		end
	end

	return var_24_0
end

function var_0_0.updateNewSingleGuide(arg_25_0, arg_25_1)
	if guide_data[arg_25_0].triggertype == TRIGGER_PASSLEVEL then
		if not level_manager:isPlayerPassLevel(guide_data[arg_25_0].triggerparam) then
			return
		end
	elseif guide_data[arg_25_0].triggertype == TRIGGER_LEVELUP then
		if playermodel.grade < guide_data[arg_25_0].triggerparam then
			return
		end
	elseif guide_data[arg_25_0].triggertype == TRIGGER_PASSBEFOREBOSS then
		if not level_manager:isPlayerPassBigBoss(guide_data[arg_25_0].triggerparam) then
			return
		end
	elseif guide_data[arg_25_0].triggertype == TRIGGER_SMALLBOSS then
		if not level_manager:isPlayerPassSmallLevel(guide_data[arg_25_0].triggerparam) then
			return
		end
	elseif guide_data[arg_25_0].triggertype == TRIGGER_UNLOCKCHAPTER then
		if not level_manager:isChapterCompleteUnlock(math.floor(guide_data[arg_25_0].triggerparam / 1000), guide_data[arg_25_0].triggerparam % 1000) then
			return
		end
	elseif guide_data[arg_25_0].triggertype == TRIGGER_FAIL then
		-- block empty
	else
		return
	end

	if arg_25_1 then
		if var_0_19(arg_25_0) then
			return
		end

		var_0_18(arg_25_0)
	else
		var_0_0.insertNewTriggeredGuide(arg_25_0)
	end
end

function var_0_0.insertNewTriggeredGuide(arg_26_0)
	if not config.open_guide then
		return
	end

	if var_0_19(arg_26_0) then
		return
	end

	var_0_18(arg_26_0)

	if not var_0_0.working then
		return
	end

	if var_0_7 then
		return
	end

	if var_0_8 then
		return
	end

	if not GuideListenerExt.check_guide_conditions(arg_26_0) then
		return
	end

	local var_26_0 = guide_data[arg_26_0]

	if not guide_data[arg_26_0].triggerlayer then
		LayerManager:getGuideObj():addGuide(arg_26_0, {
			shelterconf = var_0_12(nil, arg_26_0)
		})
	elseif guide_data[arg_26_0].triggerlayer == "ListButtonLayer" then
		if LayerManager:getCurrentLayerObj().__cname == var_26_0.executelayer then
			local var_26_1 = var_0_12(LayerManager:getUIElement("ListButton"), arg_26_0)

			if var_26_0.uiname then
				local var_26_2 = var_0_9(LayerManager:getUIElement("ListButton"), var_26_0.uiname)

				if var_26_0.subuiname then
					var_26_2 = var_0_9(var_26_2, var_26_0.subuiname)
				end

				if var_26_2 then
					local var_26_3 = var_0_10(var_26_2)

					var_26_3.shelterconf = var_26_1

					LayerManager:getGuideObj():addGuide(arg_26_0, var_26_3)
				end
			else
				LayerManager:getGuideObj():addGuide(arg_26_0, {
					shelterconf = var_26_1
				})
			end
		end
	elseif guide_data[arg_26_0].triggerlayer == "TopcostLayer" then
		if LayerManager:getCurrentLayerObj().__cname == var_26_0.executelayer then
			local var_26_4 = var_0_12(LayerManager:getUIElement("TopcostLayer"), arg_26_0)

			if var_26_0.uiname then
				local var_26_5 = var_0_9(LayerManager:getUIElement("TopcostLayer"), var_26_0.uiname)

				if var_26_0.subuiname then
					var_26_5 = var_0_9(var_26_5, var_26_0.subuiname)
				end

				if var_26_5 then
					local var_26_6 = var_0_10(var_26_5)

					var_26_6.shelterconf = var_26_4

					LayerManager:getGuideObj():addGuide(arg_26_0, var_26_6)
				end
			else
				LayerManager:getGuideObj():addGuide(arg_26_0, {
					shelterconf = var_26_4
				})
			end
		end
	elseif guide_data[arg_26_0].triggerlayer == "PlotLayer" then
		if LayerManager:getCurrentLayerObj().__cname == var_26_0.executelayer then
			local var_26_7 = var_0_12(LayerManager:getPlotObj(), arg_26_0)

			if var_26_0.uiname then
				local var_26_8 = var_0_9(LayerManager:getPlotObj(), var_26_0.uiname)

				if var_26_0.subuiname then
					var_26_8 = var_0_9(var_26_8, var_26_0.subuiname)
				end

				if var_26_8 then
					local var_26_9 = var_0_10(var_26_8)

					var_26_9.shelterconf = var_26_7

					LayerManager:getGuideObj():addGuide(arg_26_0, var_26_9)
				end
			else
				LayerManager:getGuideObj():addGuide(arg_26_0, {
					shelterconf = var_26_7
				})
			end
		end
	else
		local var_26_10 = LayerManager:getCurrentLayerObj()

		if var_26_10.__cname == guide_data[arg_26_0].triggerlayer then
			local var_26_11 = var_0_12(var_26_10, arg_26_0)
			local var_26_12 = GuideListenerExt.getGuideUIFunc(arg_26_0)

			if var_26_12 then
				local var_26_13 = var_26_12(var_26_10)

				if var_26_13 then
					local var_26_14 = var_0_10(var_26_13)

					var_26_14.shelterconf = var_26_11

					LayerManager:getGuideObj():addGuide(arg_26_0, var_26_14)
				end
			elseif var_26_0.uiname then
				local var_26_15 = var_0_9(var_26_10, var_26_0.uiname)

				if var_26_0.subuiname then
					var_26_15 = var_0_9(var_26_15, var_26_0.subuiname)
				end

				if var_26_15 then
					local var_26_16 = var_0_10(var_26_15)

					var_26_16.shelterconf = var_26_11

					LayerManager:getGuideObj():addGuide(arg_26_0, var_26_16)
				end
			else
				LayerManager:getGuideObj():addGuide(arg_26_0, {
					shelterconf = var_26_11
				})
			end
		end
	end
end

function var_0_0.finishGuide(arg_27_0)
	if guide_data[arg_27_0].triggertype == TRIGGER_MANUAL then
		return var_0_0.finishGuideManual(arg_27_0)
	elseif guide_data[arg_27_0].triggertype == TRIGGER_FIGHT then
		return var_0_0.finishGuideFight(arg_27_0)
	end

	AnalyticManager.guideProceed({
		guideID = tostring(arg_27_0)
	})

	var_0_0.triggeredGuides[guide_data[arg_27_0].triggerlayer or "scene"][arg_27_0] = nil

	local var_27_0 = var_0_14({
		class = guide_data[arg_27_0].guideclass,
		triggertype = guide_data[arg_27_0].triggertype
	})

	if not var_27_0 then
		playermodel:setPlayerGuide(guide_data[arg_27_0].guideclass)

		return
	end

	var_27_0.proceed = var_27_0.proceed + 1

	playermodel:setPlayerGuide(guide_data[arg_27_0].guideclass, nil, var_27_0.proceed)

	if var_0_16(var_27_0) then
		if guide_data[arg_27_0].finishjump then
			var_0_20(guide_data[arg_27_0].finishjump)
		else
			var_0_0.triggerOtherContinueGuide(arg_27_0)
		end

		return
	end

	local var_27_1 = guide_class_data[var_27_0.class]["guide_" .. var_27_0.proceed + 1]

	var_27_0.triggertype = guide_data[guide_class_data[var_27_0.class]["guide_" .. var_27_0.proceed + 1]].triggertype
	var_27_0.triggerparam = guide_data[var_27_1].triggerparam

	var_0_17(var_27_0)

	if guide_data[arg_27_0].finishjump then
		var_0_0.updateNewSingleGuide(var_27_1, true)
		var_0_20(guide_data[arg_27_0].finishjump)
	else
		var_0_0.updateNewSingleGuide(var_27_1)
		var_0_0.triggerOtherContinueGuide(arg_27_0)

		if guide_data[arg_27_0].finishevent then
			GuideEventDispatcher.dispatchEvent(guide_data[arg_27_0].finishevent, guide_data[arg_27_0].finisheventparam)
		end
	end
end

function var_0_0.triggerOtherContinueGuide(arg_28_0)
	if not config.open_guide then
		return
	end

	if not var_0_0.working then
		return
	end

	if var_0_7 then
		return
	end

	if var_0_8 then
		return
	end

	local var_28_0 = guide_data[arg_28_0].continueguide

	if not guide_data[arg_28_0].continueguide then
		return
	end

	if not var_0_19(var_28_0) then
		return
	end

	if not GuideListenerExt.check_guide_conditions(var_28_0) then
		return
	end

	local var_28_1 = guide_data[var_28_0]

	if not guide_data[var_28_0].triggerlayer then
		LayerManager:getGuideObj():addGuide(var_28_0, {
			shelterconf = var_0_12(nil, var_28_0)
		})
	elseif guide_data[var_28_0].triggerlayer == "ListButtonLayer" then
		if LayerManager:getCurrentLayerObj().__cname == var_28_1.executelayer then
			local var_28_2 = var_0_12(LayerManager:getUIElement("ListButton"), var_28_0)

			if var_28_1.uiname then
				local var_28_3 = var_0_9(LayerManager:getUIElement("ListButton"), var_28_1.uiname)

				if var_28_1.subuiname then
					var_28_3 = var_0_9(var_28_3, var_28_1.subuiname)
				end

				if var_28_3 then
					local var_28_4 = var_0_10(var_28_3)

					var_28_4.shelterconf = var_28_2

					LayerManager:getGuideObj():addGuide(var_28_0, var_28_4)
				end
			else
				LayerManager:getGuideObj():addGuide(var_28_0, {
					shelterconf = var_28_2
				})
			end
		end
	elseif guide_data[var_28_0].triggerlayer == "TopcostLayer" then
		if LayerManager:getCurrentLayerObj().__cname == var_28_1.executelayer then
			local var_28_5 = var_0_12(LayerManager:getUIElement("TopcostLayer"), var_28_0)

			if var_28_1.uiname then
				local var_28_6 = var_0_9(LayerManager:getUIElement("TopcostLayer"), var_28_1.uiname)

				if var_28_1.subuiname then
					var_28_6 = var_0_9(var_28_6, var_28_1.subuiname)
				end

				if var_28_6 then
					local var_28_7 = var_0_10(var_28_6)

					var_28_7.shelterconf = var_28_5

					LayerManager:getGuideObj():addGuide(var_28_0, var_28_7)
				end
			else
				LayerManager:getGuideObj():addGuide(var_28_0, {
					shelterconf = var_28_5
				})
			end
		end
	elseif guide_data[var_28_0].triggerlayer == "PlotLayer" then
		if LayerManager:getCurrentLayerObj().__cname == var_28_1.executelayer then
			local var_28_8 = var_0_12(LayerManager:getPlotObj(), var_28_0)

			if var_28_1.uiname then
				local var_28_9 = var_0_9(LayerManager:getPlotObj(), var_28_1.uiname)

				if var_28_1.subuiname then
					var_28_9 = var_0_9(var_28_9, var_28_1.subuiname)
				end

				if var_28_9 then
					local var_28_10 = var_0_10(var_28_9)

					var_28_10.shelterconf = var_28_8

					LayerManager:getGuideObj():addGuide(var_28_0, var_28_10)
				end
			else
				LayerManager:getGuideObj():addGuide(var_28_0, {
					shelterconf = var_28_8
				})
			end
		end
	else
		local var_28_11 = LayerManager:getCurrentLayerObj()

		if var_28_11.__cname == guide_data[var_28_0].triggerlayer then
			local var_28_12 = var_0_12(var_28_11, var_28_0)

			if var_28_1.uiname then
				local var_28_13 = var_0_9(var_28_11, var_28_1.uiname)

				if var_28_1.subuiname then
					var_28_13 = var_0_9(var_28_13, var_28_1.subuiname)
				end

				if var_28_13 then
					local var_28_14 = var_0_10(var_28_13)

					var_28_14.shelterconf = var_28_12

					LayerManager:getGuideObj():addGuide(var_28_0, var_28_14)
				end
			else
				LayerManager:getGuideObj():addGuide(var_28_0, {
					shelterconf = var_28_12
				})
			end
		end
	end
end

function var_0_0.triggerManualGuide(arg_29_0)
	if guide_data[arg_29_0].triggertype ~= TRIGGER_MANUAL then
		return
	end

	var_0_0.insertNewTriggeredGuide(arg_29_0)
end

function var_0_0.finishGuideManual(arg_30_0)
	var_0_0.triggeredGuides[guide_data[arg_30_0].triggerlayer or "scene"][arg_30_0] = nil
end

function var_0_0.init(arg_31_0, arg_31_1)
	for iter_31_0, iter_31_1 in pairs(arg_31_1) do
		if guide_class_data[iter_31_1.class] and not var_0_16(iter_31_1) and var_0_15(iter_31_1) then
			table.insert(var_0_0.triggerTbl[guide_data[guide_class_data[iter_31_1.class]["guide_" .. iter_31_1.proceed + 1]].triggertype], {
				class = iter_31_1.class,
				proceed = iter_31_1.proceed,
				triggertype = guide_data[guide_class_data[iter_31_1.class]["guide_" .. iter_31_1.proceed + 1]].triggertype,
				triggerparam = guide_data[guide_class_data[iter_31_1.class]["guide_" .. iter_31_1.proceed + 1]].triggerparam
			})
		end
	end

	var_0_21[TRIGGER_PASSLEVEL]()
	var_0_21[TRIGGER_LEVELUP]()
	var_0_21[TRIGGER_PASSBEFOREBOSS]()
	var_0_21[TRIGGER_SMALLBOSS]()
	var_0_21[TRIGGER_UNLOCKCHAPTER]()
end

function var_0_0.isGuideFinish(arg_32_0, arg_32_1)
	for iter_32_0, iter_32_1 in pairs(var_0_0.triggerTbl[arg_32_0]) do
		if iter_32_1.class == arg_32_1 then
			return var_0_16({
				class = iter_32_1.class,
				proceed = iter_32_1.proceed
			})
		end
	end

	return true
end

function var_0_0.reset(arg_33_0)
	var_0_0.triggerTbl = {
		[TRIGGER_PASSLEVEL] = {},
		[TRIGGER_LEVELUP] = {},
		[TRIGGER_GETITEM] = {},
		[TRIGGER_PUSHINBAG] = {},
		[TRIGGER_PASSBEFOREBOSS] = {},
		[TRIGGER_FAIL] = {},
		[TRIGGER_FIGHT] = {},
		[TRIGGER_SMALLBOSS] = {},
		[TRIGGER_UNLOCKCHAPTER] = {},
		[TRIGGER_GETITEM_BY_ID] = {}
	}
	var_0_0.triggeredGuides = {
		scene = {},
		ListButtonLayer = {},
		TopcostLayer = {},
		PlotLayer = {}
	}
end

function var_0_0.startCommonGuide()
	var_0_0.working = true
end

function var_0_0.stopCommonGuide()
	var_0_0.working = false
end

function var_0_0.getGuideClassInfo(arg_36_0)
	for iter_36_0, iter_36_1 in pairs(var_0_0.triggerTbl) do
		for iter_36_2, iter_36_3 in ipairs(iter_36_1) do
			if iter_36_3.class == arg_36_0 then
				return iter_36_3.proceed
			end
		end
	end

	return guide_class_data[arg_36_0].total
end

function var_0_0.swallowEvent(arg_37_0)
	LayerManager:getGuideObj():swallowEvent(arg_37_0)
end

function var_0_0.cleanCurGuides()
	LayerManager:getGuideObj():cleanCurGuides()
end

function var_0_0.lockGuideTrigger(arg_39_0)
	var_0_7 = arg_39_0
end

function var_0_0.lockGuideTriggerManual(arg_40_0)
	var_0_8 = arg_40_0
end

function var_0_0.showAllGuides(arg_41_0)
	LayerManager:getGuideObj():showAllGuides(arg_41_0)
end

function var_0_0.showAllGuidesWithFullScreen(arg_42_0)
	LayerManager:getGuideObj():showAllGuidesWithFullScreen(arg_42_0)
end

function var_0_0.showGuidesInRect(arg_43_0, arg_43_1)
	LayerManager:getGuideObj():showGuidesInRect(arg_43_0, arg_43_1)
end

function var_0_0.checkCondition()
	return
end

function var_0_0.checkSpecific()
	return
end

function var_0_0.isNeedGuideFight()
	for iter_46_0, iter_46_1 in pairs(var_0_0.triggerTbl[TRIGGER_FIGHT]) do
		if iter_46_1.proceed < guide_class_data[iter_46_1.class].total and level_manager:isPlayerPassLevel(guide_data[guide_class_data[iter_46_1.class]["guide_" .. iter_46_1.proceed + 1]].triggerparam) then
			return true
		end
	end

	return false
end

function var_0_0.isFightGuideFinish()
	for iter_47_0, iter_47_1 in pairs(var_0_0.triggerTbl[TRIGGER_FIGHT]) do
		if iter_47_1.proceed < guide_class_data[iter_47_1.class].total then
			return false
		end
	end

	return true
end

local function var_0_22(arg_48_0)
	for iter_48_0, iter_48_1 in pairs(var_0_0.triggerTbl[TRIGGER_FIGHT]) do
		if iter_48_1.class == arg_48_0 then
			return iter_48_1
		end
	end
end

function var_0_0.triggerGuideFight(arg_49_0, arg_49_1)
	if not arg_49_0 or not arg_49_1 then
		return
	end

	local var_49_0 = var_0_22(arg_49_0)

	if not var_49_0 then
		return
	end

	if var_0_13(var_49_0) then
		return
	end

	local var_49_1 = guide_class_data[arg_49_0]["guide_" .. var_49_0.proceed + 1]

	if not level_manager:isPlayerPassLevel(guide_data[guide_class_data[arg_49_0]["guide_" .. var_49_0.proceed + 1]].triggerparam) then
		return
	end

	if guide_data[var_49_1].uiname then
		local var_49_2
		local var_49_3

		if guide_data[var_49_1].triggerlayer == "FightLayer" then
			local var_49_4 = LayerManager:getUIElement("FightLayer")

			if not var_49_4 then
				return
			end

			var_49_2 = var_0_9(var_49_4, guide_data[var_49_1].uiname)

			if not var_49_2 then
				return
			end

			if guide_data[var_49_1].subuiname then
				var_49_2 = var_0_9(var_49_2, guide_data[var_49_1].subuiname)
			end

			var_49_3 = var_0_12(var_49_4, var_49_1)
		elseif guide_data[var_49_1].triggerlayer == "SmallFightLayer" then
			local var_49_5 = LayerManager:getUIElement("SmallFightLayer")

			if not var_49_5 then
				return
			end

			var_49_2 = var_0_9(var_49_5, guide_data[var_49_1].uiname)

			if not var_49_2 then
				return
			end

			if guide_data[var_49_1].subuiname then
				var_49_2 = var_0_9(var_49_2, guide_data[var_49_1].subuiname)
			end

			var_49_3 = var_0_12(var_49_5, var_49_1)
		else
			var_49_2 = var_0_9(arg_49_1, guide_data[var_49_1].uiname)

			if not var_49_2 then
				return
			end

			if guide_data[var_49_1].subuiname then
				var_49_2 = var_0_9(var_49_2, guide_data[var_49_1].subuiname)
			end

			var_49_3 = var_0_12(arg_49_1, var_49_1)
		end

		if not var_49_2 then
			return
		end

		FightManager.pauseBattleField()

		local var_49_6 = var_0_10(var_49_2)

		var_49_6.shelterconf = var_49_3

		LayerManager:getGuideObj():addGuide(var_49_1, var_49_6)
	else
		local var_49_7 = guide_data[var_49_1].triggerlayer == "FightLayer" and var_0_12(LayerManager:getUIElement("FightLayer"), var_49_1) or guide_data[var_49_1].triggerlayer == "SmallFightLayer" and var_0_12(LayerManager:getUIElement("SmallFightLayer"), var_49_1) or var_0_12(nil, var_49_1)
		local var_49_8 = {
			shelterconf = var_49_7
		}

		FightManager.pauseBattleField()
		LayerManager:getGuideObj():addGuide(var_49_1, var_49_8)
	end
end

function var_0_0.triggerGuideTowerFight(arg_50_0, arg_50_1)
	if not arg_50_0 or not arg_50_1 then
		return
	end

	local var_50_0 = var_0_22(arg_50_0)

	if not var_50_0 then
		return
	end

	if var_0_13(var_50_0) then
		return
	end

	local var_50_1 = guide_class_data[arg_50_0]["guide_" .. var_50_0.proceed + 1]

	if not level_manager:isPlayerPassLevel(guide_data[guide_class_data[arg_50_0]["guide_" .. var_50_0.proceed + 1]].triggerparam) then
		return
	end

	if guide_data[var_50_1].uiname then
		local var_50_2
		local var_50_3

		if guide_data[var_50_1].triggerlayer == "FightLayer" then
			local var_50_4 = LayerManager:getUIElement("FightLayer")

			if not var_50_4 then
				return
			end

			var_50_2 = var_0_9(var_50_4, guide_data[var_50_1].uiname)

			if not var_50_2 then
				return
			end

			if guide_data[var_50_1].subuiname then
				var_50_2 = var_0_9(var_50_2, guide_data[var_50_1].subuiname)
			end

			var_50_3 = var_0_12(var_50_4, var_50_1)
		elseif guide_data[var_50_1].triggerlayer == "SmallFightLayer" then
			local var_50_5 = LayerManager:getUIElement("SmallFightLayer")

			if not var_50_5 then
				return
			end

			var_50_2 = var_0_9(var_50_5, guide_data[var_50_1].uiname)

			if not var_50_2 then
				return
			end

			if guide_data[var_50_1].subuiname then
				var_50_2 = var_0_9(var_50_2, guide_data[var_50_1].subuiname)
			end

			var_50_3 = var_0_12(var_50_5, var_50_1)
		else
			var_50_2 = var_0_9(arg_50_1, guide_data[var_50_1].uiname)

			if not var_50_2 then
				return
			end

			if guide_data[var_50_1].subuiname then
				var_50_2 = var_0_9(var_50_2, guide_data[var_50_1].subuiname)
			end

			var_50_3 = var_0_12(arg_50_1, var_50_1)
		end

		if not var_50_2 then
			return
		end

		local var_50_6 = var_0_10(var_50_2)

		var_50_6.shelterconf = var_50_3

		LayerManager:getGuideObj():addGuide(var_50_1, var_50_6)
	else
		local var_50_7 = guide_data[var_50_1].triggerlayer == "FightLayer" and var_0_12(LayerManager:getUIElement("FightLayer"), var_50_1) or guide_data[var_50_1].triggerlayer == "SmallFightLayer" and var_0_12(LayerManager:getUIElement("SmallFightLayer"), var_50_1) or var_0_12(nil, var_50_1)
		local var_50_8 = {
			shelterconf = var_50_7
		}

		FightManager.pauseBattleField()
		LayerManager:getGuideObj():addGuide(var_50_1, var_50_8)
	end
end

function var_0_0.finishGuideFight(arg_51_0)
	AnalyticManager.guideProceed(arg_51_0)

	local var_51_0 = var_0_14({
		class = guide_data[arg_51_0].guideclass,
		triggertype = TRIGGER_FIGHT
	})

	if not var_51_0 then
		FightManager.resumeBattleField()
		playermodel:setPlayerGuide(guide_data[arg_51_0].guideclass)

		return
	end

	var_51_0.proceed = var_51_0.proceed + 1

	playermodel:setPlayerGuide(guide_data[arg_51_0].guideclass, nil, var_51_0.proceed)

	if var_0_16(var_51_0) then
		FightManager.resumeBattleField()

		return
	end

	local var_51_1 = guide_class_data[var_51_0.class]["guide_" .. var_51_0.proceed + 1]

	var_0_17(var_51_0)

	if not var_0_0.updateNextFightGuide(var_51_1) then
		FightManager.resumeBattleField()
	end
end

function var_0_0.updateNextFightGuide(arg_52_0)
	if not level_manager:isPlayerPassLevel(guide_data[arg_52_0].triggerparam) then
		return false
	end

	if guide_data[arg_52_0].uiname then
		local var_52_0
		local var_52_1

		if guide_data[arg_52_0].triggerlayer == "FightLayer" then
			local var_52_2 = LayerManager:getUIElement("FightLayer")

			if not var_52_2 then
				return false
			end

			var_52_0 = var_0_9(var_52_2, guide_data[arg_52_0].uiname)

			if not var_52_0 then
				return false
			end

			if guide_data[arg_52_0].subuiname then
				var_52_0 = var_0_9(var_52_0, guide_data[arg_52_0].subuiname)
			end

			var_52_1 = var_0_12(var_52_2, arg_52_0)
		elseif guide_data[arg_52_0].triggerlayer == "SmallFightLayer" then
			local var_52_3 = LayerManager:getUIElement("SmallFightLayer")

			if not var_52_3 then
				return false
			end

			var_52_0 = var_0_9(var_52_3, guide_data[arg_52_0].uiname)

			if not var_52_0 then
				return false
			end

			if guide_data[arg_52_0].subuiname then
				var_52_0 = var_0_9(var_52_0, guide_data[arg_52_0].subuiname)
			end

			var_52_1 = var_0_12(var_52_3, arg_52_0)
		else
			local var_52_4 = FightManager.getPlayerItem(1)

			if not var_52_4 then
				return false
			end

			var_52_0 = var_0_9(var_52_4, guide_data[arg_52_0].uiname)

			if not var_52_0 then
				return false
			end

			if guide_data[arg_52_0].subuiname then
				var_52_0 = var_0_9(var_52_0, guide_data[arg_52_0].subuiname)
			end

			var_52_1 = var_0_12(var_52_4, arg_52_0)
		end

		if not var_52_0 then
			return false
		end

		local var_52_5 = var_0_10(var_52_0)

		var_52_5.shelterconf = var_52_1

		LayerManager:getGuideObj():addGuide(arg_52_0, var_52_5)
	else
		local var_52_6 = guide_data[arg_52_0].triggerlayer == "FightLayer" and var_0_12(LayerManager:getUIElement("FightLayer"), arg_52_0) or guide_data[arg_52_0].triggerlayer == "SmallFightLayer" and var_0_12(LayerManager:getUIElement("SmallFightLayer"), arg_52_0) or var_0_12(nil, arg_52_0)

		;({}).shelterconf = var_52_6

		LayerManager:getGuideObj():addGuide(arg_52_0, var_52_6)
	end

	return true
end

function var_0_0:convertToGuideSpace(arg_53_1)
	local var_53_0 = self:convertToWorldSpace(arg_53_1)

	return cc.p(var_53_0.x - GameDisplay.fix_x, var_53_0.y - GameDisplay.fix_y)
end

var_0_0.center = cc.p(GameDisplay.origin_design_x / 2, GameDisplay.origin_design_y / 2)
var_0_0.fullrect = cc.rect(-GameDisplay.fix_x, -GameDisplay.fix_y, GameDisplay.width, GameDisplay.height)

function var_0_0.removeNewPlayerGuide()
	for iter_54_0, iter_54_1 in pairs(var_0_0.triggerTbl) do
		for iter_54_2 = #iter_54_1, 1, -1 do
			if not guide_class_data[iter_54_1[iter_54_2].class].skip_or_not then
				table.remove(iter_54_1, iter_54_2)
			end
		end
	end
end

return var_0_0
