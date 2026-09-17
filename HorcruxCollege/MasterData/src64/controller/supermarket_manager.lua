local var_0_0 = {}
local network = require("network.network")
local item_manager = require("controller.item_manager")
local item_data = require("data.item_data")
local recharge_data = require("data.recharge_data")
local supermarket_tab_data = require("data.supermarket_tab_data")
local activity_roulette_data = require("data.activity_roulette_data")
local playermodel = require("model.playermodel")
local alert_manager = require("controller.alert_manager")
local activity_manager = require("controller.activity_manager")
local shop_timelimit_data = require("data.shop.shop_timelimit_data")
local var_0_11 = require("data.recharge_data")
local hexie_manager = require("controller.hexie_manager")
local time_check_manager = require("controller.time_check_manager")
local var_0_14 = 1
local var_0_15 = 2
local var_0_16 = 3
local var_0_17 = 4
local var_0_18 = 5
local var_0_19 = 106
local var_0_20 = 108
local var_0_21 = {
	newbee_card = 20001,
	gold_card = 20003,
	returnback_card = 20002,
	quartercard = 90,
	month_card = 1,
	yearcard = 365,
	forevercard = 9
}
local var_0_22 = 9999
local var_0_23 = 3
local var_0_24 = 2
local var_0_25 = {
	[6800202] = "public/currency/6800202.png",
	[SHOP_CURRENCY_GOLD] = IMAGE_GOLD,
	[SHOP_CURRENCY_DIAMOND] = IMAGE_DIAMOND,
	[SHOP_CURRENCY_HORNOR] = "public/currency/arenascene_dot_1.png",
	[SHOP_CURRENCY_EXPLORECOIN] = "public/currency/explorecoin.png",
	[BLACK_CARD] = "public/currency/1500001_1.png",
	[BLACK_SP_CARD] = "public/currency/1500002_1.png",
	[SHOP_CURRENCY_RMB] = "public/currency/rmb_white.png",
	[85000006] = "equipment/" .. item_data[85000006].image_id .. ".png",
	diamond = IMAGE_DIAMOND
}

setmetatable(var_0_25, {
	__index = function(arg_1_0, arg_1_1)
		return "public/currency/" .. item_data[arg_1_1].image_id .. ".png"
	end
})

local var_0_26 = {
	[SHOP_CURRENCY_GOLD] = function()
		return playermodel.gold
	end,
	[SHOP_CURRENCY_DIAMOND] = function()
		return playermodel.diamond
	end,
	[SHOP_CURRENCY_HORNOR] = function()
		return playermodel.honor
	end,
	[SHOP_CURRENCY_EXPLORECOIN] = function()
		return playermodel.explorecoin
	end,
	[SHOP_CURRENCY_RMB] = function()
		return 0
	end
}

setmetatable(var_0_26, {
	__index = function(arg_7_0, arg_7_1)
		return function()
			return item_manager:getItemNumber(arg_7_1)
		end
	end
})

function var_0_0.get_supermarket_list(arg_9_0, arg_9_1, arg_9_2)
	network:rpc("get_supermarket_list", {}, function(arg_10_0)
		if arg_9_2 and arg_9_2.registerUIRefCallback then
			arg_9_2.registerUIRefCallback()
		end

		if not arg_9_0.ui_ref then
			return
		end

		if arg_9_1 then
			arg_9_1(arg_10_0)
		end
	end)
end

function var_0_0:remove_new_tag()
	if supermarket_tab_data[self.curSelectTab].type == var_0_14 then
		return
	end

	if supermarket_tab_data[self.curSelectTab].type == var_0_15 then
		return
	end

	network:rpc("remove_new_tag", {
		tabid = self.curSelectTab
	}, function()
		return
	end)
end

function var_0_0.registerUIRef(arg_13_0, arg_13_1)
	arg_13_0.ui_ref = arg_13_1

	activity_manager:registerEventListener("supermarket_manager", activity_manager.activityEventId.UPDATE_ACTIVITY_STATUS_ALERT, function()
		arg_13_0:updateTotalRechargeReddot()
		arg_13_0:updateRouletteReddot()
	end)
end

function var_0_0:unregisterUIRef()
	alert_manager:unregister_alert(ALERT_SUPERMARKET_NEW)

	if self.groupList then
		for iter_15_0, iter_15_1 in pairs(self.groupList) do
			for iter_15_2, iter_15_3 in pairs(iter_15_1.tablist) do
				if iter_15_3.reddot == var_0_24 then
					alert_manager:register_alert(ALERT_SUPERMARKET_NEW)
				end
			end
		end
	end

	alert_manager:unregister_alert(ALERT_SUPERMARKET_FREE)

	if self.groupList then
		for iter_15_4, iter_15_5 in pairs(self.groupList) do
			for iter_15_6, iter_15_7 in pairs(iter_15_5.tablist) do
				if iter_15_7.reddot == var_0_23 then
					alert_manager:register_alert(ALERT_SUPERMARKET_FREE)
				end
			end
		end
	end

	self.ui_ref = nil
	self.curSelectTab = nil
	self.curSelectGroup = nil
	self.reddotTouchCache = nil

	activity_manager:releaseEventListenerByName("supermarket_manager")
end

function var_0_0:initData(arg_16_1, arg_16_2)
	self:get_supermarket_list(function(arg_17_0)
		table.sort(arg_17_0.list, function(arg_18_0, arg_18_1)
			return (arg_18_0.order or 0) < (arg_18_1.order or 0)
		end)

		for iter_17_0, iter_17_1 in pairs(arg_17_0.list) do
			table.sort(iter_17_1.tablist, function(arg_19_0, arg_19_1)
				return (arg_19_0.order or 0) < (arg_19_1.order or 0)
			end)
		end

		self:setGroupList(arg_17_0.list, arg_16_2)

		if arg_16_1 then
			arg_16_1()
		end
	end, arg_16_2)
end

local function var_0_27()
	if DeviceManager.platform == "windows" then
		return true
	end

	if not ({
		["270001"] = true,
		["270051"] = true,
		["270050"] = true,
		["270049"] = true
	})[require("controller.account_manager"):getChannel()] then
		return false
	end

	if not FySDK or not FySDK.haveSubscribeAPI then
		return false
	end

	return true
end

local function var_0_28(arg_21_0, arg_21_1)
	if arg_21_1 and arg_21_1.tab then
		local var_21_0 = {
			[arg_21_1.tab] = true
		}

		if arg_21_1.tablist then
			for iter_21_0, iter_21_1 in pairs(arg_21_1.tablist) do
				var_21_0[iter_21_1] = true
			end
		end

		for iter_21_2, iter_21_3 in ipairs(arg_21_0) do
			local var_21_1 = {}

			for iter_21_4, iter_21_5 in ipairs(arg_21_0[iter_21_2].tablist) do
				if not var_21_0[iter_21_5.id] then
					table.insert(var_21_1, iter_21_4)
				end
			end

			for iter_21_6 = #var_21_1, 1, -1 do
				table.remove(arg_21_0[iter_21_2].tablist, var_21_1[iter_21_6])
			end
		end
	else
		for iter_21_7, iter_21_8 in ipairs(arg_21_0) do
			local var_21_2 = {}

			for iter_21_9, iter_21_10 in ipairs(iter_21_8.tablist) do
				if iter_21_10.end_show_time and global_get_time_by_date(iter_21_10.end_show_time) < time_check_manager:getCurTime() then
					table.insert(var_21_2, iter_21_9)
				end
			end

			for iter_21_11 = #var_21_2, 1, -1 do
				table.remove(iter_21_8.tablist, var_21_2[iter_21_11])
			end
		end
	end
end

local function var_0_29(arg_22_0)
	if var_0_27() then
		return
	end

	for iter_22_0, iter_22_1 in ipairs(arg_22_0) do
		local var_22_0 = {}

		for iter_22_2, iter_22_3 in ipairs(iter_22_1.tablist) do
			if iter_22_3.type == 105 then
				table.insert(var_22_0, iter_22_2)
			end
		end

		for iter_22_4 = #var_22_0, 1, -1 do
			table.remove(iter_22_1.tablist, var_22_0[iter_22_4])
		end
	end
end

function var_0_0:setGroupList(arg_23_1, arg_23_2)
	var_0_28(arg_23_1, arg_23_2)
	var_0_29(arg_23_1)

	local var_23_0 = 1

	while arg_23_1[var_23_0] do
		if next(arg_23_1[var_23_0].tablist) then
			var_23_0 = var_23_0 + 1
		else
			table.remove(arg_23_1, var_23_0)
		end
	end

	if not arg_23_2 or not arg_23_2.tab then
		self:addShopRecommendPageView(arg_23_1)
	end

	self.groupList = arg_23_1
end

function var_0_0:getGroupList()
	return self.groupList
end

function var_0_0:getCurSelectGroup(...)
	return self.curSelectGroup or group or 1
end

function var_0_0:getCurSelectTab(...)
	local var_26_0 = self.curSelectTab

	if not self.curSelectTab then
		if self.groupList[self:getCurSelectGroupIndex()] and self.groupList[self:getCurSelectGroupIndex()].tablist[1] then
			var_26_0 = self.groupList[self:getCurSelectGroupIndex()].tablist[1].id or self.groupList[1].tablist[1].id
		end
	end

	return var_26_0
end

function var_0_0:getCurSelectGroupIndex(...)
	local var_27_0 = self:getCurSelectGroup()

	if self.groupList then
		for iter_27_0, iter_27_1 in pairs(self.groupList) do
			if iter_27_1.id == var_27_0 and next(iter_27_1.tablist) then
				return iter_27_0
			end
		end
	end

	return 1
end

function var_0_0:getReddotTab(...)
	local var_28_1 = {}
	local var_28_2 = {}

	if self.groupList then
		for iter_28_0, iter_28_1 in pairs(self.groupList) do
			for iter_28_2, iter_28_3 in pairs(iter_28_1.tablist) do
				if iter_28_3.reddot then
					if iter_28_3.reddot == var_0_24 then
						var_28_2[iter_28_3.id] = true
					elseif iter_28_3.reddot == var_0_23 then
						var_28_1[iter_28_3.id] = true
					end
				end
			end
		end
	end

	if next(var_28_2) then
		local var_28_3

		for iter_28_4, iter_28_5 in pairs(var_28_2) do
			var_28_3 = var_28_3 or iter_28_4

			if (supermarket_tab_data[iter_28_4].reddot_order or 10000) < (supermarket_tab_data[var_28_3].reddot_order or 10000) then
				var_28_3 = iter_28_4
			end
		end

		return var_28_3
	elseif next(var_28_1) then
		local var_28_5

		for iter_28_6, iter_28_7 in pairs(var_28_1) do
			var_28_5 = var_28_5 or iter_28_6

			if (supermarket_tab_data[iter_28_6].reddot_order or 10000) < (supermarket_tab_data[var_28_5].reddot_order or 10000) then
				var_28_5 = iter_28_6
			end
		end

		return var_28_5
	end

	return nil
end

function var_0_0:setCurSelectGroup(arg_29_1)
	if self.groupList then
		for iter_29_0, iter_29_1 in pairs(self.groupList) do
			if iter_29_1.id == arg_29_1 then
				self.curSelectGroup = arg_29_1

				return
			end
		end
	end

	self.curSelectGroup = self.curSelectGroup or 1
end

function var_0_0:getTabID(arg_30_1)
	if not arg_30_1 then
		return nil
	end

	if not self.groupList then
		return nil
	end

	for iter_30_0, iter_30_1 in pairs(self.groupList) do
		for iter_30_2, iter_30_3 in pairs(iter_30_1.tablist) do
			if arg_30_1 == iter_30_3.id then
				return iter_30_1.id
			end
		end
	end
end

function var_0_0:setCurSelectTab(arg_31_1, arg_31_2)
	local var_31_0
	local var_31_1 = self:getTabID(arg_31_1)

	if var_31_1 then
		self:setCurSelectGroup(var_31_1)

		var_31_0 = arg_31_1
	elseif arg_31_2 then
		local var_31_2 = self:getTabID(arg_31_2)

		if var_31_2 then
			self:setCurSelectGroup(var_31_2)

			var_31_0 = arg_31_2
		end
	end

	local var_31_3

	if not var_31_0 then
		::label_31_0::

		var_31_3 = self.groupList and self.groupList[self:getCurSelectGroupIndex()].tablist[1].id
	end

	self.curSelectTab = var_31_3

	if self.groupList then
		local var_31_4

		for iter_31_0, iter_31_1 in pairs(self.groupList) do
			for iter_31_2, iter_31_3 in pairs(iter_31_1.tablist) do
				if self.curSelectTab == iter_31_3.id then
					var_31_4 = true
				end
			end
		end

		if not var_31_4 then
			self.curSelectTab = self.groupList[self:getCurSelectGroupIndex()].tablist[1].id
		end
	end

	if self.curSelectTab == var_0_22 then
		return
	end

	self:remove_new_tag()
end

function var_0_0:getCurTabList()
	return self.groupList[self:getCurSelectGroupIndex()].tablist
end

function var_0_0:getCurrencyList()
	return self.currencyList or {
		SHOP_CURRENCY_DIAMOND,
		6800601
	}
end

function var_0_0:updateCurrencyList(arg_34_1)
	if arg_34_1 and next(arg_34_1) then
		self.currencyList = arg_34_1
	else
		local var_34_0 = self:getCurSelectTab()
		local var_34_1 = supermarket_tab_data[var_34_0].param or param_str

		self.currencyList = supermarket_tab_data[var_34_0].type == var_0_16 and {
			activity_roulette_data[var_34_1 .. "_1"].need_item,
			SHOP_CURRENCY_DIAMOND,
			6800601
		} or {
			SHOP_CURRENCY_DIAMOND,
			6800601
		}
	end

	if not self.ui_ref then
		return
	end

	self.ui_ref:updateTitle()
end

function var_0_0.getCurrencyPath(arg_35_0, arg_35_1)
	return var_0_25[arg_35_1]
end

function var_0_0.getCurrencyNum(arg_36_0, arg_36_1)
	return var_0_26[arg_36_1]()
end

function var_0_0:getCurMainViewSpriteType()
	local var_37_0 = self:getCurSelectTab()

	if self.groupList then
		for iter_37_0, iter_37_1 in pairs(self.groupList[self:getCurSelectGroupIndex()].tablist) do
			if iter_37_1.id == var_37_0 then
				return iter_37_1.type or 1
			end
		end
	end

	return 1
end

function var_0_0:getCurMainViewSpriteParam()
	local var_38_0 = self:getCurSelectTab()

	if self.groupList then
		for iter_38_0, iter_38_1 in pairs(self.groupList) do
			for iter_38_2, iter_38_3 in pairs(iter_38_1.tablist) do
				if iter_38_3.id == var_38_0 then
					if iter_38_3.type == var_0_14 then
						local var_38_1 = {}

						var_38_1.selectType = iter_38_3.param or iter_38_3.param_str

						return var_38_1
					elseif iter_38_3.type == var_0_18 then
						local var_38_2 = {}

						var_38_2.groupid = iter_38_3.param or iter_38_3.param_str

						return var_38_2
					elseif iter_38_3.type == var_0_17 then
						local var_38_3 = {}

						var_38_3.activityid = iter_38_3.param or iter_38_3.param_str

						return var_38_3
					else
						return iter_38_3.param or iter_38_3.param_str
					end
				end
			end
		end
	end
end

function var_0_0:is_show_reddot_by_group(arg_39_1)
	local var_39_0 = {}

	if self.groupList then
		for iter_39_0, iter_39_1 in pairs(self.groupList) do
			for iter_39_2, iter_39_3 in pairs(iter_39_1.tablist) do
				if iter_39_3.reddot then
					var_39_0[iter_39_1.id] = math.max(var_39_0[iter_39_1.id] or 0, iter_39_3.reddot)
				end
			end
		end
	end

	return var_39_0[arg_39_1]
end

function var_0_0:is_show_reddot_by_tab(arg_40_1)
	if self.groupList then
		for iter_40_0, iter_40_1 in pairs(self.groupList) do
			for iter_40_2, iter_40_3 in pairs(iter_40_1.tablist) do
				if iter_40_3.id == arg_40_1 then
					return iter_40_3.reddot
				end
			end
		end
	end
end

function var_0_0:setReddotTouchStat()
	local var_41_0 = self:getCurSelectTab()

	if self.groupList then
		for iter_41_0, iter_41_1 in pairs(self.groupList) do
			for iter_41_2, iter_41_3 in pairs(iter_41_1.tablist) do
				if iter_41_3.id == var_41_0 and iter_41_3.reddot ~= 3 then
					iter_41_3.reddot = nil
				end
			end
		end
	end
end

function var_0_0:updateRechargeReddot(arg_42_1)
	local function var_42_0(arg_43_0)
		for iter_43_0, iter_43_1 in pairs(arg_43_0) do
			if iter_43_1.type == 9 then
				if playermodel.rechargeamount > var_0_11[iter_43_1.id].need_total_recharge then
					if var_0_11[iter_43_1.id].dropid and iter_43_1.have_bought < iter_43_1.buy_limit then
						return true
					end

					if var_0_11[iter_43_1.id].dropid_ext and iter_43_1.have_bought < iter_43_1.buy_limit then
						return true
					end
				end
			elseif iter_43_1.type == 11 then
				if iter_43_1.have_bought < iter_43_1.buy_limit then
					return true
				end
			elseif iter_43_1.id == var_0_21.newbee_card or iter_43_1.id == var_0_21.returnback_card or iter_43_1.id == var_0_21.gold_card then
				if iter_43_1.remain and iter_43_1.remain > 0 and not iter_43_1.lastreward then
					return true
				end
			elseif iter_43_1.type == 8 and iter_43_1.price_diamond and iter_43_1.price_diamond == 0 and iter_43_1.have_bought < iter_43_1.buy_limit and playermodel.grade >= var_0_11[iter_43_1.id].buy_grade_limit then
				return true
			end
		end
	end

	local function var_42_1(arg_44_0)
		for iter_44_0, iter_44_1 in pairs(arg_44_0) do
			if iter_44_1.new_tag == var_0_24 then
				return iter_44_1.new_tag
			end
		end
	end

	if self.groupList then
		for iter_42_0, iter_42_1 in pairs(self.groupList) do
			for iter_42_2, iter_42_3 in pairs(iter_42_1.tablist) do
				if iter_42_3.type == var_0_14 then
					iter_42_3.reddot = arg_42_1[iter_42_3.param] and var_42_0(arg_42_1[iter_42_3.param]) and var_0_23 or arg_42_1[iter_42_3.param] and var_42_1(arg_42_1[iter_42_3.param]) and var_0_24 or nil
				end
			end
		end
	end

	if not tolua.isnull(self.ui_ref) then
		self.ui_ref:updateReddot()
	end
end

function var_0_0:updateShopTimelimitReddot(arg_45_1)
	local function var_45_0(arg_46_0)
		for iter_46_0, iter_46_1 in pairs(arg_46_0) do
			if iter_46_1.rechargeid and var_0_11[iter_46_1.rechargeid] and var_0_11[iter_46_1.rechargeid].type == 11 and iter_46_1.have_bought < iter_46_1.buy_limit then
				return true
			end
		end
	end

	local function var_45_1(arg_47_0)
		for iter_47_0, iter_47_1 in pairs(arg_47_0) do
			if iter_47_1.new_tag == var_0_24 then
				return iter_47_1.new_tag
			end
		end
	end

	if arg_45_1[1] and arg_45_1[1].group then
		if self.groupList then
			for iter_45_0, iter_45_1 in pairs(self.groupList) do
				for iter_45_2, iter_45_3 in pairs(iter_45_1.tablist) do
					if iter_45_3.type == var_0_18 and iter_45_3.param == arg_45_1[1].group then
						iter_45_3.reddot = var_45_0(arg_45_1) and var_0_23 or var_45_1(arg_45_1) and var_0_24 or nil
					end
				end
			end
		end
	end

	if not tolua.isnull(self.ui_ref) then
		self.ui_ref:updateReddot()
	end
end

function var_0_0:updateTotalRechargeReddot()
	if self.groupList then
		for iter_48_0, iter_48_1 in pairs(self.groupList) do
			for iter_48_2, iter_48_3 in pairs(iter_48_1.tablist) do
				if iter_48_3.type == var_0_17 then
					if iter_48_3.reddot == var_0_23 then
						iter_48_3.reddot = nil
					end

					if iter_48_3.reddot ~= var_0_24 and activity_manager:getAlertStatus(iter_48_3.param, "total_recharge") then
						iter_48_3.reddot = var_0_23
					end
				end
			end
		end
	end

	if not tolua.isnull(self.ui_ref) then
		self.ui_ref:updateReddot()
	end
end

function var_0_0:updateRouletteReddot()
	if self.groupList then
		for iter_49_0, iter_49_1 in pairs(self.groupList) do
			for iter_49_2, iter_49_3 in pairs(iter_49_1.tablist) do
				if iter_49_3.type == var_0_16 then
					if iter_49_3.reddot == var_0_23 then
						iter_49_3.reddot = nil
					end

					if iter_49_3.reddot ~= var_0_24 and activity_manager:getAlertStatus(iter_49_3.param, "roulette") then
						iter_49_3.reddot = var_0_23
					end
				end
			end
		end
	end

	if not tolua.isnull(self.ui_ref) then
		self.ui_ref:updateReddot()
	end
end

function var_0_0:updateLimitedTimePackageReddot(arg_50_1)
	if self.groupList then
		for iter_50_0, iter_50_1 in pairs(self.groupList) do
			for iter_50_2, iter_50_3 in pairs(iter_50_1.tablist) do
				if iter_50_3.type == var_0_19 and iter_50_3.param == arg_50_1.group then
					if arg_50_1.bRed then
						iter_50_3.reddot = var_0_23

						break
					end

					iter_50_3.reddot = nil

					break
				end
			end
		end
	end

	if not tolua.isnull(self.ui_ref) then
		self.ui_ref:updateReddot()
	end
end

function var_0_0.isShopTimeLimitValid(arg_51_0, arg_51_1)
	local var_51_0 = time_check_manager:getCurTime()

	if arg_51_1.start_time and var_51_0 < global_get_time_by_date(arg_51_1.start_time) then
		return false
	end

	if arg_51_1.finish_time and var_51_0 > global_get_time_by_date(arg_51_1.finish_time) then
		return false
	end

	if arg_51_1.showchannel then
		local var_51_1 = require("controller.account_manager"):getChannel()

		if var_51_1 == "palmpi" then
			return true
		end

		local var_51_2 = false

		string.gsub(v.showchannel, "([^,]+)", function(arg_52_0)
			if arg_52_0 == var_51_1 then
				var_51_2 = true
			end
		end)

		do return var_51_2 end
		return
	end

	return true
end

function var_0_0:getAllShopTimeLimitList()
	local var_53_0 = {}

	for iter_53_0, iter_53_1 in pairs(shop_timelimit_data) do
		if self:isShopTimeLimitValid(iter_53_1) then
			if iter_53_1.rechargeid then
				iter_53_1.price = var_0_11[iter_53_1.rechargeid].rmb
			end

			var_53_0[iter_53_1.group] = var_53_0[iter_53_1.group] or {}

			table.insert(var_53_0[iter_53_1.group], iter_53_1)
		end
	end

	return var_53_0
end

function var_0_0.getShopTimeLimitGroupByID(arg_54_0, arg_54_1)
	if not shop_timelimit_data[arg_54_1] then
		return nil
	end

	return shop_timelimit_data[arg_54_1].group
end

function var_0_0.getShopTimeLimitFinishTime(arg_55_0, arg_55_1)
	if not shop_timelimit_data[arg_55_1] then
		return nil
	end

	if shop_timelimit_data[arg_55_1].follow_activity == 176 then
		return activity_manager:get_module_finishtime(176, "bp") or "2020-01-01 00:00:00"
	end

	return shop_timelimit_data[arg_55_1].finish_time
end

function var_0_0.addShopRecommendPageView(arg_56_0, arg_56_1)
	for iter_56_0, iter_56_1 in ipairs(arg_56_1) do
		if iter_56_1.id == 1 and not hexie_manager:isChannelInShenheTime() then
			table.insert(iter_56_1.tablist, 1, {
				param = "商城推荐页",
				order = -999999,
				type = var_0_20,
				id = var_0_22
			})
		end
	end
end

function var_0_0:getGroupByTab(arg_57_1)
	for iter_57_0, iter_57_1 in ipairs(self.groupList) do
		for iter_57_2, iter_57_3 in ipairs(iter_57_1.tablist) do
			if arg_57_1 == iter_57_3.id then
				return iter_57_1.id
			end
		end
	end
end

return var_0_0
