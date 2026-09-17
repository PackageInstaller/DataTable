local var_0_0 = {}
local var_0_1 = config._DEBUG and 0 or 1
local bubble_tip_data = require("data.bubble_tip_data")
local lab_recipe_data = require("data.lab_recipe_data")
local item_data = require("data.item_data")
local pop_layer_infos = require("controller.layerconfig.pop_layer_infos")
local bubble_tip_unlock_data = require("data.bubble_tip_unlock_data")
local var_0_7 = require("data.lab_recipe_data")
local lab_research_data = require("data.lab_research_data")
local task_data = require("data.task_data")
local var_0_10 = require("data.item_data")
local autopop_manager = require("controller.autopop_manager")

require("view.Sprite.ItemSprite")

local function var_0_12(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1 or cc.c3b(255, 150, 0)

	arg_1_0 = string.gsub(arg_1_0, "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*", {
		["}"] = "</span>",
		["{"] = "<span style=color: " .. string.format("rgb(%d, %d, %d)", var_1_0.r, var_1_0.g, var_1_0.b) .. ";>"
	})

	return "<p>" .. arg_1_0 .. "</p>"
end

local var_0_13 = {
	["88043001"] = L_BIANHUA_HIDE_TASK_TILE_88043001,
	["880411001"] = L_BIANHUA_HIDE_TASK_TILE_880411001,
	["890410002"] = L_BIANHUA_HIDE_TASK_TILE_890410002,
	["890412003"] = L_BIANHUA_HIDE_TASK_TILE_890412003,
	["88091035"] = L_BIANHUA_HIDE_TASK_TILE_88091035,
	["88091037"] = L_BIANHUA_HIDE_TASK_TILE_88091037
}

setmetatable(var_0_13, {
	__index = function(arg_2_0, arg_2_1)
		return "最伟大的外卖员"
	end
})

local var_0_14 = {
	cc.c3b(231, 243, 247),
	cc.c3b(123, 255, 132),
	cc.c3b(39, 255, 252),
	cc.c3b(255, 146, 243),
	cc.c3b(255, 150, 86),
	(cc.c3b(255, 55, 55))
}
local var_0_15 = {
	SchoolFileLayer = true,
	FightLayer = true,
	SchoolCinemaLayer = true,
	SchoolAreaLayer = true,
	LabMenuLayer = true,
	SchoolDeanOfficeLayer = true,
	SchoolSwimLayer = true,
	SchoolTrainLayer = true,
	DormitoryLayer = true,
	MainLayer = true,
	BirthdayPartyLayer = true
}
local var_0_16 = {}
local var_0_17 = {
	HandOfMidasLayer = true
}
local var_0_19 = 1
local var_0_20 = 2
local var_0_21 = {
	cc.p(640, 911),
	cc.p(640, 828),
	(cc.p(640, 745))
}
local var_0_22 = {
	cc.p(886, 911),
	cc.p(886, 828),
	(cc.p(886, 745))
}
local var_0_23 = 0.5
local var_0_24 = 1

function var_0_0:pushBackTipsEvent(arg_3_1)
	if not require("controller.level_manager"):isPlayerPassLevel(UNLOCK_TIPS) then
		return
	end

	if arg_3_1 then
		self:init()
		table.insert(self.eventQueue, (json.decode(arg_3_1)))

		if #self.eventQueue > 10 then
			while #self.eventQueue > 5 do
				table.remove(self.eventQueue, 3)
			end
		end
	end
end

function var_0_0:pushBackTipsEventWithClient(arg_4_1)
	if not require("controller.level_manager"):isPlayerPassLevel(UNLOCK_TIPS) then
		return
	end

	self:init()
	table.insert(self.eventQueue, arg_4_1)

	if #self.eventQueue > 10 then
		while #self.eventQueue > 5 do
			table.remove(self.eventQueue, 3)
		end
	end
end

local function var_0_25(arg_5_0)
	return ({
		[E_TIPS_UNLOCK_SERVANT_SLOT] = function(arg_6_0)
			return {
				tipsid = E_TIPS_UNLOCK_SERVANT_SLOT,
				param1 = arg_6_0
			}
		end,
		[E_TIPS_UNLOCK_HORCRUX_SLOT] = function(arg_7_0)
			return {
				tipsid = E_TIPS_UNLOCK_HORCRUX_SLOT,
				param1 = arg_7_0
			}
		end,
		[E_TIPS_UNLCOK_NEW_RECIPE] = function(arg_8_0)
			local var_8_0 = {}

			for iter_8_0, iter_8_1 in pairs(var_0_7) do
				if arg_8_0 == iter_8_1.recipe_open_limit then
					table.insert(var_8_0, {
						tipsid = E_TIPS_UNLCOK_NEW_RECIPE,
						itemid = iter_8_1.target
					})
				end
			end

			for iter_8_2, iter_8_3 in pairs(lab_research_data) do
				if arg_8_0 == iter_8_3.recipe_open_limit then
					table.insert(var_8_0, {
						tipsid = E_TIPS_UNLCOK_NEW_RECIPE,
						itemid = iter_8_3.target
					})
				end
			end

			return var_8_0
		end,
		[E_TIPS_UNLCOK_NEW_CHAPTER] = function(arg_9_0)
			return {
				tipsid = E_TIPS_UNLCOK_NEW_CHAPTER,
				param1 = arg_9_0
			}
		end,
		[E_TIPS_UNLOCK_PATROL] = function(arg_10_0)
			return {
				tipsid = E_TIPS_UNLOCK_PATROL,
				param1 = arg_10_0
			}
		end,
		[E_TIPS_TASK_COMPONENT] = function(arg_11_0)
			return {
				tipsid = E_TIPS_TASK_COMPONENT,
				param1 = arg_11_0
			}
		end,
		[E_TIPS_GET_BARRAGE_GIFT_RESULT] = function(arg_12_0)
			return {
				tipsid = E_TIPS_GET_BARRAGE_GIFT_RESULT,
				param1 = arg_12_0
			}
		end,
		[E_TIPS_TRIGGER_TILE] = function(arg_13_0)
			return
		end,
		[E_TIPS_NIANSHOU] = function(arg_14_0)
			return {
				tipsid = E_TIPS_NIANSHOU,
				param1 = arg_14_0
			}
		end
	})[arg_5_0]
end

local function var_0_26(arg_15_0)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(bubble_tip_unlock_data) do
		if iter_15_1.open_limit == arg_15_0 then
			local var_15_1 = var_0_25(iter_15_1.bubble_id)

			if iter_15_1.bubble_id == E_TIPS_UNLOCK_SERVANT_SLOT then
				table.insert(var_15_0, (var_15_1(iter_15_1.param1)))
			elseif iter_15_1.bubble_id == E_TIPS_UNLOCK_HORCRUX_SLOT then
				table.insert(var_15_0, (var_15_1(iter_15_1.param1)))
			elseif iter_15_1.bubble_id == E_TIPS_UNLCOK_NEW_CHAPTER then
				table.insert(var_15_0, (var_15_1(iter_15_1.param1)))
			elseif iter_15_1.bubble_id == E_TIPS_UNLOCK_PATROL then
				table.insert(var_15_0, (var_15_1(iter_15_1.param1)))
			end
		end
	end

	for iter_15_2, iter_15_3 in pairs({
		E_TIPS_UNLCOK_NEW_RECIPE
	}) do
		local var_15_2 = var_0_25(iter_15_3)(arg_15_0)

		if var_15_2 and next(var_15_2) then
			for iter_15_4, iter_15_5 in pairs(var_15_2) do
				table.insert(var_15_0, iter_15_5)
			end
		end
	end

	return var_15_0
end

local function var_0_27(arg_16_0, arg_16_1)
	local var_16_0 = {}
	local chapter_data = require("data.chapter_data")
	local levelmode_data = require("data.levelmode_data")
	local var_16_3
	local var_16_4
	local var_16_5
	local var_16_6
	local var_16_7
	local var_16_8

	if chapter_data[arg_16_0 .. "-" .. arg_16_1] then
		var_16_3 = chapter_data[arg_16_0 .. "-" .. arg_16_1].gold
		var_16_4 = chapter_data[arg_16_0 .. "-" .. arg_16_1].exp
		var_16_5 = chapter_data[arg_16_0 .. "-" .. arg_16_1].strengthpoint
	end

	if chapter_data[arg_16_0 .. "-" .. arg_16_1 - 1] then
		var_16_6 = chapter_data[arg_16_0 .. "-" .. arg_16_1 - 1].gold or var_16_3
		var_16_7 = chapter_data[arg_16_0 .. "-" .. arg_16_1 - 1].exp or var_16_4
		var_16_8 = chapter_data[arg_16_0 .. "-" .. arg_16_1 - 1].strengthpoint or var_16_5
	elseif levelmode_data[arg_16_0] and levelmode_data[arg_16_0].premode and chapter_data[levelmode_data[arg_16_0].premode .. "-1"] then
		var_16_6 = chapter_data[levelmode_data[arg_16_0].premode .. "-1"].gold or var_16_3
		var_16_7 = chapter_data[levelmode_data[arg_16_0].premode .. "-1"].exp or var_16_4
		var_16_8 = chapter_data[levelmode_data[arg_16_0].premode .. "-1"].strengthpoint or var_16_5
	end

	var_16_6 = var_16_6 or var_16_3
	var_16_7 = var_16_7 or var_16_4
	var_16_8 = var_16_8 or var_16_5

	if var_16_3 and var_16_6 < var_16_3 then
		table.insert(var_16_0, {
			tipsid = E_TIPS_HANGUP_UP,
			param1 = L_GOLD
		})
	end

	if var_16_4 and var_16_7 < var_16_4 then
		table.insert(var_16_0, {
			param1 = "经验值",
			tipsid = E_TIPS_HANGUP_UP
		})
	end

	if var_16_5 and var_16_8 < var_16_5 then
		table.insert(var_16_0, {
			tipsid = E_TIPS_HANGUP_UP,
			param1 = L_PLAYER_DATA_TYPE.Tech
		})
	end

	return var_16_0
end

function var_0_0:triggerWithPassLevel(arg_17_1, arg_17_2)
	self:init()

	if self.triggeredLevel[arg_17_1 * 1000 + arg_17_2 - 1] then
		return
	else
		self.triggeredLevel[arg_17_1 * 1000 + arg_17_2 - 1] = true
	end

	local var_17_0 = var_0_26(arg_17_1 * 1000 + arg_17_2 - 1)

	if var_17_0 and next(var_17_0) then
		for iter_17_0, iter_17_1 in pairs(var_17_0) do
			self:pushBackTipsEventWithClient(iter_17_1)
		end
	end

	local var_17_1 = var_0_27(arg_17_1, arg_17_2)

	if var_17_1 and next(var_17_1) then
		for iter_17_2, iter_17_3 in pairs(var_17_1) do
			self:pushBackTipsEventWithClient(iter_17_3)
		end
	end
end

function var_0_0:onCanBossFight()
	if require("controller.level_manager"):isPlayerPassLevel(1005) then
		self:pushBackTipsEventWithClient({
			tipsid = E_TIPS_CAN_BOSSFIGHT
		})
	end
end

function var_0_0:init()
	if not self.eventQueue then
		self.eventQueue = {}
		self.objQueue = {}
		self.curQueue = {}
		self.tempObjQueue = {}
		self.triggeredLevel = {}
		self.interval = 0.5
		self.time = 0
		self.status = var_0_19
		self.tag = 0
	end

	if not self.scheduler then
		self:startScheduler()
	end
end

function var_0_0.startScheduler(arg_20_0)
	arg_20_0.scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_21_0)
		arg_20_0:chechNewTips(arg_21_0)
		arg_20_0:updateShowingSpTime(arg_21_0)
	end, 0.1, false)
end

function var_0_0:unScheduler()
	if self.scheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduler)

		self.scheduler = nil
	end
end

function var_0_0:chechNewTips(arg_23_1)
	if autopop_manager:getAchievementStatus() ~= var_0_19 then
		return
	end

	if #self.eventQueue < 1 then
		return
	end

	local function var_23_0(arg_24_0)
		for iter_24_0, iter_24_1 in pairs(self.curQueue) do
			if iter_24_1.tipsid == arg_24_0 then
				self.curQueue[iter_24_0] = self.eventQueue[1]

				return iter_24_0
			end
		end
	end

	self.time = self.time + arg_23_1

	if self.time < self.interval then
		return
	else
		self.time = 0
	end

	local var_23_1 = 1

	while self.eventQueue[var_23_1] do
		if not self:isEverywhereDisplay(self.eventQueue[var_23_1].tipsid) and not self:isShowTipsLayer() then
			var_23_1 = var_23_1 + 1
		else
			local var_23_2

			if self:isCanRepeat(self.eventQueue[var_23_1].tipsid) then
				for iter_23_0, iter_23_1 in pairs(self.objQueue) do
					if iter_23_1.id and iter_23_1.id == self.eventQueue[var_23_1].tipsid then
						var_23_2 = self.objQueue[iter_23_0]
					end
				end
			end

			if self:isCanRepeat(self.eventQueue[var_23_1].tipsid) and var_23_2 then
				self:updateSp(var_23_2, self.curQueue[var_23_0(self.eventQueue[var_23_1].tipsid)])
			else
				table.insert(self.curQueue, #self.curQueue + 1, self.eventQueue[var_23_1])

				local var_23_3 = self:createSp(self.curQueue[#self.curQueue])

				var_23_3:setVisible(false)

				var_23_3.id = self.curQueue[#self.curQueue].tipsid

				self:pushShowList(var_23_3)
			end

			table.remove(self.eventQueue, var_23_1)

			break
		end
	end
end

function var_0_0.isEverywhereDisplay(arg_25_0, arg_25_1)
	return bubble_tip_data[arg_25_1].everywhere == 1
end

function var_0_0.isCanRepeat(arg_26_0, arg_26_1)
	return bubble_tip_data[arg_26_1].can_repeat == 1
end

function var_0_0.createSp(arg_27_0, arg_27_1)
	local var_27_0 = ccui.ImageView:create("bubble/bg_bubble.png", var_0_1)

	var_27_0:setAnchorPoint(cc.p(1, 0))

	local var_27_1 = RichTextPro:create()

	var_27_1:setMaxWidth(160)
	var_27_1:setSize(22)
	var_27_1:setLineSpace(0)
	var_27_1:setColor(cc.c3b(231, 243, 247))
	var_27_1:setName("richText")

	local var_27_2 = arg_27_1.tipsid

	var_27_0.gotoSystemId = bubble_tip_data[arg_27_1.tipsid].jump_id

	var_27_0:setTouchEnabled(true)
	var_27_0:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_28_0.gotoSystemId then
			return
		end

		arg_28_0:setTouchEnabled(false)
		require("controller.goto_system_manager")

		local var_28_0 = {
			jump_to_system = arg_28_0.gotoSystemId
		}

		var_28_0.config = system_jump_config[SYSTEMID[arg_28_0.gotoSystemId]] and system_jump_config[SYSTEMID[arg_28_0.gotoSystemId]].config

		if var_28_0.config then
			if var_28_0.config.exitCallbackType == "function" then
				var_28_0.config.exitCallback = nil
			elseif var_28_0.config.exitCallbackType == "string" then
				var_28_0.config = "MainLayer"
			end
		end

		goto_complete_system(var_28_0)
	end)

	local var_27_3 = {
		[E_TIPS_LAB_COMPLETE] = function()
			var_27_1:setText((var_0_12(string.gsub(bubble_tip_data[var_27_2].des, "param1", item_data[var_0_7[arg_27_1.recipeid].target].name), var_0_14[item_data[var_0_7[arg_27_1.recipeid].target].equip_quality])))

			local var_29_0 = bubble_tip_data[var_27_2].icon_scale or 1
			local var_29_1 = ItemSmallSprite:createSmallItem()

			var_29_1:setScale(var_29_0)
			var_29_1:updateSmallItemByItemid(var_0_7[arg_27_1.recipeid].target)
			var_29_1:setPosition(cc.p(30, var_27_0:getContentSize().height / 2))
			var_29_1:setName("itemSp")
			var_27_0:addChild(var_29_1)
		end,
		[E_TIPS_PATROL_COMPLETE] = function()
			local var_30_0 = bubble_tip_data[var_27_2].icon_scale or 1
			local var_30_1 = ccui.ImageView:create("bubble/" .. bubble_tip_data[var_27_2].icon .. ".png", var_0_1)

			var_30_1:setPosition(cc.p(30, var_27_0:getContentSize().height / 2))
			var_30_1:setScale(var_30_0)
			var_27_0:addChild(var_30_1)
			var_27_1:setText((var_0_12(string.gsub(bubble_tip_data[var_27_2].des, "param1", arg_27_1.array), cc.c3b(39, 255, 252))))
		end,
		[E_TIPS_UNLOCK_SERVANT_SLOT] = function()
			local var_31_0 = bubble_tip_data[var_27_2].icon_scale or 1
			local var_31_1 = ccui.ImageView:create("bubble/" .. bubble_tip_data[var_27_2].icon .. ".png", var_0_1)

			var_31_1:setPosition(cc.p(30, var_27_0:getContentSize().height / 2))
			var_31_1:setScale(var_31_0)
			var_27_0:addChild(var_31_1)
			var_27_1:setText((var_0_12(string.gsub(bubble_tip_data[var_27_2].des, "param1", arg_27_1.param1), cc.c3b(39, 255, 252))))
		end,
		[E_TIPS_UNLOCK_HORCRUX_SLOT] = function()
			local var_32_0 = bubble_tip_data[var_27_2].icon_scale or 1
			local var_32_1 = ccui.ImageView:create("bubble/" .. bubble_tip_data[var_27_2].icon .. ".png", var_0_1)

			var_32_1:setPosition(cc.p(30, var_27_0:getContentSize().height / 2))
			var_32_1:setScale(var_32_0)
			var_27_0:addChild(var_32_1)
			var_27_1:setText((var_0_12(string.gsub(bubble_tip_data[var_27_2].des, "param1", arg_27_1.param1), cc.c3b(39, 255, 252))))
		end,
		[E_TIPS_UNLCOK_NEW_RECIPE] = function()
			var_27_1:setText((var_0_12(string.gsub(bubble_tip_data[var_27_2].des, "param1", item_data[arg_27_1.itemid].name), var_0_14[item_data[arg_27_1.itemid].equip_quality])))

			local var_33_0 = bubble_tip_data[var_27_2].icon_scale or 1
			local var_33_1 = ItemSmallSprite:createSmallItem()

			var_33_1:setScale(var_33_0)
			var_33_1:updateSmallItemByItemid(arg_27_1.itemid)
			var_33_1:setPosition(cc.p(30, var_27_0:getContentSize().height / 2))
			var_33_1:setName("itemSp")
			var_27_0:addChild(var_33_1)
		end,
		[E_TIPS_UNLCOK_NEW_CHAPTER] = function()
			local var_34_0 = bubble_tip_data[var_27_2].icon_scale or 1
			local var_34_1 = ccui.ImageView:create("bubble/" .. bubble_tip_data[var_27_2].icon .. ".png", var_0_1)

			var_34_1:setPosition(cc.p(30, var_27_0:getContentSize().height / 2))
			var_34_1:setScale(var_34_0)
			var_27_0:addChild(var_34_1)
			var_27_1:setText((var_0_12(string.gsub(bubble_tip_data[var_27_2].des, "param1", arg_27_1.param1), cc.c3b(39, 255, 252))))
		end,
		[E_TIPS_GET_MONEY] = function()
			var_27_1:setText((var_0_12(string.gsub(bubble_tip_data[var_27_2].des, "param1", arg_27_1.param1), cc.c3b(39, 255, 252))))

			local var_35_0 = bubble_tip_data[var_27_2].icon_scale or 1
			local var_35_1 = ItemSmallSprite:createSmallItem()

			var_35_1:setScale(var_35_0)
			var_35_1:updateSmallItemByItemid("gold")
			var_35_1:setPosition(cc.p(30, var_27_0:getContentSize().height / 2))
			var_35_1:setName("itemSp")
			var_27_0:addChild(var_35_1)
		end,
		[E_TIPS_UNLOCK_PATROL] = function()
			local var_36_0 = bubble_tip_data[var_27_2].icon_scale or 1
			local var_36_1 = ccui.ImageView:create("bubble/" .. bubble_tip_data[var_27_2].icon .. ".png", var_0_1)

			var_36_1:setPosition(cc.p(30, var_27_0:getContentSize().height / 2))
			var_36_1:setScale(var_36_0)
			var_27_0:addChild(var_36_1)
			var_27_1:setText((var_0_12(string.gsub(bubble_tip_data[var_27_2].des, "param1", arg_27_1.param1), cc.c3b(39, 255, 252))))
		end,
		[E_TIPS_TASK_COMPONENT] = function()
			local var_37_0 = bubble_tip_data[var_27_2].icon_scale or 1
			local var_37_1 = ccui.ImageView:create("bubble/" .. bubble_tip_data[var_27_2].icon .. ".png", var_0_1)

			var_37_1:setPosition(cc.p(30, var_27_0:getContentSize().height / 2))
			var_37_1:setScale(var_37_0)
			var_27_0:addChild(var_37_1)
			var_27_1:setText((var_0_12(string.gsub(bubble_tip_data[var_27_2].des, "param1", task_data[arg_27_1.taskid].name), cc.c3b(39, 255, 252))))
		end,
		[E_TIPS_GET_BARRAGE_GIFT_RESULT] = function()
			local var_38_0 = bubble_tip_data[var_27_2].icon_scale or 1
			local var_38_1 = ccui.ImageView:create("bubble/" .. bubble_tip_data[var_27_2].icon .. ".png", var_0_1)

			var_38_1:setPosition(cc.p(30, var_27_0:getContentSize().height / 2))
			var_38_1:setScale(var_38_0)
			var_27_0:addChild(var_38_1)
			var_27_1:setText((var_0_12(string.gsub(string.gsub(bubble_tip_data[var_27_2].des, "param1", item_data[arg_27_1.itemid].name), "param2", arg_27_1.num), cc.c3b(39, 255, 252))))
		end,
		[E_TIPS_TRIGGER_TILE] = function()
			local var_39_0 = bubble_tip_data[var_27_2].icon_scale or 1
			local var_39_1 = ccui.ImageView:create("bubble/" .. bubble_tip_data[var_27_2].icon .. ".png", var_0_1)

			var_39_1:setPosition(cc.p(30, var_27_0:getContentSize().height / 2))
			var_39_1:setScale(var_39_0)
			var_27_0:addChild(var_39_1)
			var_27_1:setText((var_0_12(string.gsub(bubble_tip_data[var_27_2].des, "param1", var_0_13[arg_27_1.tile]), cc.c3b(39, 255, 252))))
		end,
		[E_TIPS_NIANSHOU] = function()
			local var_40_0 = bubble_tip_data[var_27_2].icon_scale or 1
			local var_40_1 = ccui.ImageView:create("bubble/" .. bubble_tip_data[var_27_2].icon .. ".png", var_0_1)

			var_40_1:setPosition(cc.p(30, var_27_0:getContentSize().height / 2))
			var_40_1:setScale(var_40_0)
			var_27_0:addChild(var_40_1)
			var_27_1:setText((var_0_12(string.gsub(string.gsub(bubble_tip_data[var_27_2].des, "param1", item_data[arg_27_1.itemid].name), "param2", arg_27_1.num), cc.c3b(39, 255, 252))))
		end,
		[E_TIPS_GET_MEDAL] = function()
			local var_41_0 = tonumber(task_data[arg_27_1.taskid].medal_id)

			var_27_1:setText((var_0_12(bubble_tip_data[var_27_2].des .. "：" .. var_0_10[var_41_0].name, cc.c3b(39, 255, 252))))

			if not bubble_tip_data[var_27_2].icon_scale then
				-- block empty
			end

			local var_41_2 = arg_27_0:createMedalItem(var_41_0)

			var_41_2:setScale(0.7)
			var_41_2:setPosition(cc.p(80, var_27_0:getContentSize().height / 2))
			var_41_2:setName("itemSp")
			var_27_0:addChild(var_41_2)
		end,
		[E_TIPS_ACHIEVEMENT] = function()
			var_27_1:setText((string.format("<p><span style=color: rgb(0, 0, 0);>%s</span></p>", task_data[arg_27_1.taskid].name)))
			var_27_1:setSize(20)

			local var_42_1 = tonumber(task_data[arg_27_1.taskid].medal_id)

			if var_42_1 then
				local var_42_2 = arg_27_0:createMedalItem(var_42_1)

				var_42_2:setScale(0.7)
				var_42_2:setPosition(cc.p(45, var_27_0:getContentSize().height / 2))
				var_42_2:setName("itemSp")
				var_27_0:addChild(var_42_2)
			end

			var_27_0:loadTexture("bubble/bg_achievement.png", var_0_1)
		end,
		[E_TIPS_HANGUP_UP] = function()
			local var_43_0 = bubble_tip_data[var_27_2].icon_scale or 1
			local var_43_1 = ccui.ImageView:create("bubble/" .. bubble_tip_data[var_27_2].icon .. ".png", var_0_1)

			var_43_1:setPosition(cc.p(30, var_27_0:getContentSize().height / 2))
			var_43_1:setScale(var_43_0)
			var_27_0:addChild(var_43_1)
			var_27_1:setText((var_0_12(string.gsub(bubble_tip_data[var_27_2].des, "param1", arg_27_1.param1), cc.c3b(39, 255, 252))))
		end,
		[E_TIPS_CAN_BOSSFIGHT] = function()
			local var_44_0 = string.gsub(bubble_tip_data[var_27_2].des, "param1", "")
			local var_44_1 = bubble_tip_data[var_27_2].icon_scale or 1
			local var_44_2 = ccui.ImageView:create("bubble/" .. bubble_tip_data[var_27_2].icon .. ".png", var_0_1)

			var_44_2:setPosition(cc.p(30, var_27_0:getContentSize().height / 2))
			var_44_2:setScale(var_44_1)
			var_44_2:setVisible(false)
			var_27_0:addChild(var_44_2)
			var_27_1:setText((var_0_12("", cc.c3b(39, 255, 252))))
			var_27_0:loadTexture("bubble/bg_bossfight.png", var_0_1)
		end,
		[E_TIPS_GET_BOND] = function()
			var_27_1:setText((string.format("<p><span style=color: rgb(0, 0, 0);>%s</span></p>", arg_27_1.title .. arg_27_1.type)))
			var_27_1:setSize(20)
			var_27_0:loadTexture("bubble/bg_achievement.png", var_0_1)
		end
	}

	if var_27_3[arg_27_1.tipsid] then
		var_27_3[arg_27_1.tipsid]()
	end

	if var_27_1:getContentHeight() > 30 then
		var_27_1:setPosition(cc.p(80, var_27_0:getContentSize().height / 2 + 35))
	else
		var_27_1:setPosition(cc.p(80, var_27_0:getContentSize().height / 2 + 25))
	end

	if arg_27_1.tipsid == E_TIPS_GET_MEDAL then
		var_27_1:setPosition(120, var_27_0:getContentSize().height / 2 + 18)
	end

	var_27_0:addChild(var_27_1, 2)

	return var_27_0
end

function var_0_0.updateSp(arg_46_0, arg_46_1, arg_46_2)
	if arg_46_1:getChildByName("richText") then
		arg_46_1:getChildByName("richText"):removeFromParent()
	end

	arg_46_1.time = var_0_24

	local var_46_0 = RichTextPro:create()

	var_46_0:setMaxWidth(160)
	var_46_0:setSize(22)
	var_46_0:setLineSpace(0)
	var_46_0:setColor(cc.c3b(231, 243, 247))
	var_46_0:setName("richText")

	local var_46_1 = arg_46_2.tipsid
	local var_46_2 = {
		[E_TIPS_LAB_COMPLETE] = function()
			var_46_0:setText((var_0_12(string.gsub(bubble_tip_data[var_46_1].des, "param1", item_data[var_0_7[arg_46_2.recipeid].target].name), var_0_14[item_data[var_0_7[arg_46_2.recipeid].target].equip_quality])))
			arg_46_1:getChildByName("itemSp"):updateSmallItemByItemid(var_0_7[arg_46_2.recipeid].target)
		end,
		[E_TIPS_PATROL_COMPLETE] = function()
			var_46_0:setText((var_0_12(string.gsub(bubble_tip_data[var_46_1].des, "param1", arg_46_2.array), cc.c3b(39, 255, 252))))
		end,
		[E_TIPS_UNLOCK_SERVANT_SLOT] = function()
			var_46_0:setText((var_0_12(string.gsub(bubble_tip_data[var_46_1].des, "param1", arg_46_2.param1), cc.c3b(39, 255, 252))))
		end,
		[E_TIPS_UNLOCK_HORCRUX_SLOT] = function()
			var_46_0:setText((var_0_12(string.gsub(bubble_tip_data[var_46_1].des, "param1", arg_46_2.param1), cc.c3b(39, 255, 252))))
		end,
		[E_TIPS_UNLCOK_NEW_RECIPE] = function()
			var_46_0:setText((var_0_12(string.gsub(bubble_tip_data[var_46_1].des, "param1", item_data[arg_46_2.itemid].name), var_0_14[item_data[arg_46_2.itemid].equip_quality])))
			arg_46_1:getChildByName("itemSp"):updateSmallItemByItemid(arg_46_2.itemid)
		end,
		[E_TIPS_UNLCOK_NEW_CHAPTER] = function()
			var_46_0:setText((var_0_12(string.gsub(bubble_tip_data[var_46_1].des, "param1", arg_46_2.param1), cc.c3b(39, 255, 252))))
		end,
		[E_TIPS_GET_MONEY] = function()
			var_46_0:setText((var_0_12(string.gsub(bubble_tip_data[var_46_1].des, "param1", arg_46_2.param1), cc.c3b(39, 255, 252))))
		end,
		[E_TIPS_UNLOCK_PATROL] = function()
			var_46_0:setText((var_0_12(string.gsub(bubble_tip_data[var_46_1].des, "param1", arg_46_2.param1), cc.c3b(39, 255, 252))))
		end,
		[E_TIPS_TASK_COMPONENT] = function()
			var_46_0:setText((var_0_12(string.gsub(bubble_tip_data[var_46_1].des, "param1", task_data[arg_46_2.taskid].name), cc.c3b(39, 255, 252))))
		end,
		[E_TIPS_GET_BARRAGE_GIFT_RESULT] = function()
			var_46_0:setText((var_0_12(string.gsub(string.gsub(bubble_tip_data[var_46_1].des, "param1", item_data[arg_46_2.itemid].name), "param2", arg_46_2.num), cc.c3b(39, 255, 252))))
		end,
		[E_TIPS_TRIGGER_TILE] = function()
			var_46_0:setText((var_0_12(string.gsub(bubble_tip_data[var_46_1].des, "param1", var_0_13[arg_46_2.tile]), cc.c3b(39, 255, 252))))
		end,
		[E_TIPS_NIANSHOU] = function()
			var_46_0:setText((var_0_12(string.gsub(string.gsub(bubble_tip_data[var_46_1].des, "param1", item_data[arg_46_2.itemid].name), "param2", arg_46_2.num), cc.c3b(39, 255, 252))))
		end,
		[E_TIPS_GET_MEDAL] = function()
			var_46_0:setText((var_0_12(bubble_tip_data[var_46_1].des .. "：" .. var_0_10[tonumber(task_data[arg_46_2.taskid].medal_id)].name, cc.c3b(39, 255, 252))))
		end,
		[E_TIPS_ACHIEVEMENT] = function()
			var_46_0:setText((var_0_12(bubble_tip_data[var_46_1].des .. "：" .. var_0_10[tonumber(task_data[arg_46_2.taskid].medal_id)].name, cc.c3b(0, 0, 0))))
		end,
		[E_TIPS_HANGUP_UP] = function()
			var_46_0:setText((var_0_12(string.gsub(bubble_tip_data[var_46_1].des, "param1", arg_46_2.param1), cc.c3b(39, 255, 252))))
		end,
		[E_TIPS_CAN_BOSSFIGHT] = function()
			local var_62_0 = var_0_12(string.gsub(bubble_tip_data[var_46_1].des, "param1", ""), cc.c3b(39, 255, 252))

			var_46_0:setText("")
		end
	}

	if var_46_2[arg_46_2.tipsid] then
		var_46_2[arg_46_2.tipsid]()
	end

	arg_46_1:addChild(var_46_0, 2)

	if arg_46_1:getChildByName("richText"):getContentHeight() > 30 then
		arg_46_1:getChildByName("richText"):setPosition(cc.p(80, arg_46_1:getContentSize().height / 2 + 35))
	else
		arg_46_1:getChildByName("richText"):setPosition(cc.p(80, arg_46_1:getContentSize().height / 2 + 25))
	end

	if arg_46_2.tipsid == E_TIPS_GET_MEDAL then
		arg_46_1:getChildByName("richText"):setPosition(cc.p(120, arg_46_1:getContentSize().height / 2 + 18))
	end
end

function var_0_0:runSpAction()
	self.isRunning = true

	local var_63_0 = table.remove(self.objQueue, 1)

	var_63_0:setPosition(var_0_22[1])
	var_63_0:runAction(cc.Sequence:create(cc.MoveBy:create(var_0_23, cc.p(-var_63_0:getContentSize().width, 0)), cc.DelayTime:create(var_0_24), cc.CallFunc:create(function()
		if #self.objQueue > 0 then
			self:runSpAction()
		else
			self.isRunning = false
		end
	end), cc.RemoveSelf:create()))
end

function var_0_0:pushShowList(arg_65_1)
	if self.isRunning then
		table.insert(self.objQueue, #self.objQueue, arg_65_1)
	elseif #self.objQueue == 0 then
		table.insert(self.objQueue, arg_65_1)
		self:runSpAction()
	else
		self:runSpAction()
	end

	arg_65_1:setVisible(true)
	LayerManager:getTipsLayer():addChild(arg_65_1)
end

function var_0_0:registerTimeFinish(arg_66_1)
	table.insert(self.tempObjQueue, arg_66_1)
end

function var_0_0:updateShowingSpTime(arg_67_1)
	while self.tempObjQueue[1] do
		self.tempObjQueue[1].time = self.tempObjQueue[1].time or var_0_24
		self.tempObjQueue[1].time = self.tempObjQueue[1].time - arg_67_1

		local var_67_0

		if self.tempObjQueue[1].time <= 0 then
			if not self.tempObjQueue[1].removeFlage then
				table.remove(self.tempObjQueue, 1)

				self.tempObjQueue[1].removeFlage = true
			end

			if self.tempObjQueue[1].callback then
				self.tempObjQueue[1].callback()
			end
		else
			var_67_0 = 1 + 1
		end
	end
end

function var_0_0:isShowTipsLayer()
	local var_68_0 = LayerManager:getActiveLayerName()

	if var_0_17[LayerManager:getCurrentLayerName()] and self.status == var_0_19 then
		return true
	end

	if var_68_0 == "FightLayer" and FightLayer and FightLayer.getInstance() then
		if FightLayer.getInstance():getShowStat() == 0 then
			return false
		end
	end

	if var_0_15[var_68_0] and self.status == var_0_19 then
		if LayerManager:isShowPopLayer() then
			local var_68_1 = LayerManager:getCurrentLayerName()

			if pop_layer_infos[var_68_1].hideUI and not var_0_16[var_68_1] then
				return false
			else
				return true
			end
		end

		return true
	end

	return false
end

function var_0_0.resume(arg_69_0)
	arg_69_0.status = var_0_19
end

function var_0_0.pause(arg_70_0)
	arg_70_0.status = var_0_20
end

function var_0_0.test(arg_71_0)
	local var_71_0 = {
		{
			tipsid = 212,
			param1 = 20000
		},
		{
			tipsid = E_TIPS_UNLOCK_PATROL,
			param1 = L_TEST_DATA
		},
		{
			taskid = 113001,
			tipsid = E_TIPS_TASK_COMPONENT
		}
	}
	local var_71_1 = 1
	local var_71_2 = cc.Node:create()

	var_71_2:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
		var_71_1 = var_71_1 % #var_71_0 + 1

		if var_71_1 < 50 then
			arg_71_0:pushBackTipsEvent((json.encode(var_71_0[var_71_1])))
		end
	end))))

	local var_71_3 = cc.Node:create()

	var_71_3:runAction(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		global_basic_scene:addChild(var_71_2)
	end)))
	global_basic_scene:addChild(var_71_3)
end

function var_0_0.createMedalItem(arg_74_0, arg_74_1)
	local var_74_0 = {
		cc.c4b(240, 240, 240, 150),
		cc.c4b(54, 255, 82, 150),
		cc.c4b(56, 122, 255, 150),
		cc.c4b(255, 12, 246, 150),
		cc.c4b(255, 84, 0, 150),
		cc.c4b(255, 84, 0, 150)
	}
	local var_74_1 = item_data[arg_74_1]
	local var_74_2 = ccui.ImageView:create((item_data[itemid].bg or nil) and ("equipment/" .. item_data[itemid].bg .. ".png" or ({
		"equipment/medal1.png",
		"equipment/medal2.png",
		"equipment/medal3.png",
		"equipment/medal4.png",
		"equipment/medal5.png",
		"equipment/medal6.png"
	})[var_74_1.equip_quality]))
	local var_74_3 = cc.Label:createWithTTF(var_74_1.name, FONT_DES, 54)

	var_74_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_74_3:setPosition(cc.p(var_74_2:getContentSize().width / 2 + 5, var_74_2:getContentSize().height / 2 - 5))
	var_74_3:enableOutline(var_74_0[var_74_1.equip_quality], 1)
	var_74_3:enableShadow(var_74_0[var_74_1.equip_quality], cc.size(0, 0))
	var_74_3:setVisible(var_74_1.only_bg ~= 1)
	var_74_2:addChild(var_74_3)

	local var_74_4 = ccui.ImageView:create("bubble/tag_bg.png", var_0_1)

	var_74_4:setPosition(cc.p(var_74_2:getContentSize().width / 2 + 5, var_74_2:getContentSize().height / 2 - 5))
	var_74_2:addChild(var_74_4, -1)

	return var_74_2
end

return var_0_0
