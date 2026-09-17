local MainCityBgSelectManager = class("MainCityBgSelectManager", (require("controller.base_manager")))

MainCityBgSelectManager.MULTITON_MSG = "MainCityBgSelectManager instancealready constructed!"

function MainCityBgSelectManager:ctor()
	MainCityBgSelectManager.super.ctor(self)

	self._defaultBackGroundId = 6300001
	self._useBackGroundId = nil
	self._allBackGroundData = {}
	self._colNum = 3

	for iter_1_0, iter_1_1 in pairs((require("data.background_unlock_data"))) do
		table.insert(self._allBackGroundData, iter_1_1)
	end

	self._modelData = require("data.model_data")
end

function MainCityBgSelectManager:getColNum()
	return self._colNum
end

function MainCityBgSelectManager:initBgData()
	if not self.bInit then
		local item_manager = require("controller.item_manager")
		local level_manager = require("controller.level_manager")
		local background_data = require("data.background_data")
		local item_background_data = require("data.item_background_data")

		for iter_3_0, iter_3_1 in pairs(self._allBackGroundData) do
			local var_3_4 = iter_3_1.id

			iter_3_1.haveNum = item_manager:getItemNumber(iter_3_1.id)

			if var_3_4 == self._defaultBackGroundId then
				iter_3_1.haveNum = iter_3_1.haveNum + 1
			end

			function iter_3_1.isUsing()
				return self:isUsing(var_3_4)
			end

			if iter_3_1.background_icon then
				iter_3_1.bgPath = "mainScenebg/" .. iter_3_1.background_icon
				iter_3_1.textureType = 0
			end

			if iter_3_1.trigger_type == 1 then
				iter_3_1.showTips = "通关章节解锁"

				if iter_3_1.trigger_param1 and iter_3_1.trigger_param2 then
					local var_3_5 = level_manager:getChapterName(iter_3_1.trigger_param1, iter_3_1.trigger_param2)
					local var_3_6 = level_manager:getDifficultByMode(iter_3_1.trigger_param1)

					iter_3_1.showTips = L_CLEAR_CHAPTER .. level_manager:formatSystemUnlockLevel(iter_3_1.trigger_param1 .. "-" .. iter_3_1.trigger_param2)
				end
			elseif iter_3_1.trigger_type == 2 then
				iter_3_1.cost = {
					currencytype = 0,
					price = iter_3_1.trigger_param1
				}
				iter_3_1.cost.iconPath = GetCurrencyIconPath(iter_3_1.cost.currencytype)
			end

			iter_3_1.name = ""

			if item_background_data[var_3_4] and item_background_data[var_3_4].name then
				iter_3_1.name = item_background_data[var_3_4].name
			end
		end
	end
end

function MainCityBgSelectManager:requestInitBackground(arg_5_1)
	require("network.network"):rpc("init_background", nil, function(arg_6_0)
		if arg_6_0.result == 1 then
			global_get(arg_6_0)
			self:handlerInfo(arg_6_0)

			if arg_5_1 then
				arg_5_1(arg_6_0)
			end
		end
	end)
end

function MainCityBgSelectManager:requestBuyBackGround(arg_7_1, arg_7_2)
	arg_7_1 = tonumber(arg_7_1)
	arg_7_2 = tonumber(arg_7_2)

	if arg_7_1 and arg_7_2 then
		require("controller.shop_manager"):shop_buy(arg_7_1, arg_7_2, function(arg_8_0)
			if arg_8_0 == 1 then
				self:updateAllBackGroundData()
				self:purchaseSuccessful()
			elseif arg_8_0 == 2 then
				require("controller.audio_manager"):playeffectMusicTest("sound/invalid")
			end
		end)
	end
end

function MainCityBgSelectManager:requestUnlockBackGround(arg_9_1, arg_9_2)
	arg_9_1 = tonumber(arg_9_1)

	if arg_9_1 then
		require("network.network"):rpc("unlock_background", {
			itemid = arg_9_1
		}, function(arg_10_0)
			if arg_10_0.result == 1 then
				local playermodel = require("model.playermodel")

				global_get(arg_10_0)

				playermodel.diamond = playermodel.diamond - arg_10_0.cost_diamond

				global_update_gold_stone_diamond(nil, nil, playermodel.diamond)
				self:updateAllBackGroundData()
				self:purchaseSuccessful()

				if arg_9_2 then
					arg_9_2(arg_10_0)
				end
			end
		end)
	end
end

function MainCityBgSelectManager:handlerInfo(arg_11_1)
	self:updateLayer()
end

function MainCityBgSelectManager:updateShowGirl(arg_12_1, arg_12_2)
	if arg_12_2 and tonumber(arg_12_2) then
		self._useBackGroundId = tonumber(arg_12_2)
	elseif self._modelData[arg_12_1] and self._modelData[arg_12_1].backgroundid_main then
		self._useBackGroundId = self._modelData[arg_12_1].backgroundid_main
	end
end

function MainCityBgSelectManager:setBackGroundId(arg_13_1, arg_13_2)
	if arg_13_1 then
		arg_13_1 = tonumber(arg_13_1)

		require("model.playermodel"):setBackGround(arg_13_1, function(arg_14_0)
			if arg_14_0 == 1 then
				self._useBackGroundId = arg_13_1

				self:setBackGroundIdSuccessful()

				if arg_13_2 then
					arg_13_2(arg_14_0)
				end
			end
		end)
	end
end

function MainCityBgSelectManager:getBackGroundId()
	self._useBackGroundId = self._useBackGroundId or require("model.playermodel").background or self._defaultBackGroundId

	return self._useBackGroundId
end

function MainCityBgSelectManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function MainCityBgSelectManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function MainCityBgSelectManager:purchaseSuccessful()
	if self.layer then
		self.layer:purchaseSuccessful()
	end
end

function MainCityBgSelectManager:updateBackGround()
	if self.layer then
		self.layer:updateBackGround()
	end
end

function MainCityBgSelectManager:setBackGroundIdSuccessful()
	if self.layer then
		self.layer:setBackGroundIdSuccessful()
	end
end

function MainCityBgSelectManager:updateBuyLayout()
	if self.layer then
		self.layer:updateBuyLayout()
	end
end

function MainCityBgSelectManager:isUsing(arg_22_1)
	arg_22_1 = tonumber(arg_22_1)

	if arg_22_1 then
		return arg_22_1 == self:getBackGroundId()
	end

	return false
end

function MainCityBgSelectManager:getShowInfo()
	self:initBgData()
	self:sortAllBackGroundData()

	local var_23_0 = {}

	for iter_23_0 = 1, math.ceil(#self._allBackGroundData / self._colNum) do
		local var_23_1 = {}

		for iter_23_1 = 1, self._colNum do
			if self._allBackGroundData[(iter_23_0 - 1) * self._colNum + iter_23_1] then
				table.insert(var_23_1, self._allBackGroundData[(iter_23_0 - 1) * self._colNum + iter_23_1])
			end
		end

		table.insert(var_23_0, var_23_1)
	end

	return var_23_0
end

function MainCityBgSelectManager:updateAllBackGroundData()
	local item_manager = require("controller.item_manager")

	for iter_24_0, iter_24_1 in pairs(self._allBackGroundData) do
		iter_24_1.haveNum = item_manager:getItemNumber(iter_24_1.id)
	end
end

function MainCityBgSelectManager:sortAllBackGroundData()
	local function var_25_0(arg_26_0, arg_26_1)
		return arg_26_1 <= arg_26_0
	end

	local function var_25_1(arg_27_0, arg_27_1)
		return (arg_27_0 and 1 or 0) >= (arg_27_1 and 1 or 0)
	end

	local function var_25_2(arg_28_0, arg_28_1)
		return arg_28_0 < arg_28_1
	end

	table.sort(self._allBackGroundData, function(arg_29_0, arg_29_1)
		local var_29_0 = arg_29_0.isUsing()
		local var_29_1 = arg_29_1.isUsing()

		if var_29_0 ~= var_29_1 then
			return var_25_1(var_29_0, var_29_1)
		end

		if arg_29_0.haveNum ~= arg_29_1.haveNum then
			return var_25_0(arg_29_0.haveNum, arg_29_1.haveNum)
		end

		if arg_29_0.sort and arg_29_1.sort then
			return var_25_2(arg_29_0.sort, arg_29_1.sort)
		end

		return false
	end)
end

return MainCityBgSelectManager
