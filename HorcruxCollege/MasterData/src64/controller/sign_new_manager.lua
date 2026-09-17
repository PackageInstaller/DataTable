local SignNewManager = class("SignNewManager", (require("controller.base_manager")))

SignNewManager.MULTITON_MSG = "SignNewManager instancealready constructed!"

local privilege_data = require("data.privilege_data")

function SignNewManager:ctor()
	SignNewManager.super.ctor(self)

	self._data = {}
	self._mendcost = 80
end

function SignNewManager:requestInfo(arg_2_1)
	return
end

function SignNewManager:requestSign(arg_3_1)
	require("controller.sign_manager"):signResult(nil, arg_3_1, function(arg_4_0)
		if arg_4_0.result == 1 then
			global_gain({
				gold = arg_4_0.gold,
				diamond = arg_4_0.diamond,
				items = arg_4_0.items
			})
			self:signSuccess(arg_4_0)
		end
	end)
end

function SignNewManager:requestSupplement(arg_5_1, arg_5_2)
	local item_manager = require("controller.item_manager")
	local var_5_1 = {
		totaltimes = 3,
		remaintimes = 1,
		costtype = "diamond",
		own = require("model.playermodel").diamond,
		surecallback = function()
			require("controller.sign_manager"):signResult(arg_5_1, arg_5_2, function(arg_7_0)
				if arg_7_0.result == 1 then
					global_gain({
						gold = arg_7_0.gold,
						diamond = arg_7_0.diamond,
						items = arg_7_0.items
					})
					self:supplementSuccess(arg_7_0)
				end
			end)
		end,
		labels = {
			titleNewImage = "public/title/title_mend_sign.png",
			button = L_MEND_SIGN_BUTTON
		}
	}

	if self._mendcost.diamond then
		var_5_1.cost = self._mendcost.diamond
		var_5_1.labels.des = L_IS_MEND_SIGN
	elseif self._mendcost.itemid then
		var_5_1.costitem = self._mendcost
		var_5_1.labels.des = L_IS_MEND_SIGN2
	else
		var_5_1.labels.des = L_IS_MEND_SIGN3
	end

	LayerManager:pushInLayer("PopDoLayer", var_5_1)
end

function SignNewManager:requestExtraRewardInfo()
	require("network.network"):rpc("get_recharge_info", {
		client = config.clientmode
	}, function(arg_9_0)
		self._extraInfo = {}

		for iter_9_0 = 1, #arg_9_0.products do
			self._extraInfo[arg_9_0.products[iter_9_0].id] = arg_9_0.products[iter_9_0]
		end

		self:updateExtraRewardBg()
	end)
end

function SignNewManager:requestAccumulateAward(arg_10_1, arg_10_2)
	require("controller.sign_manager"):accuAwardResult(arg_10_1, arg_10_2, function(arg_11_0)
		if arg_11_0.result == 1 then
			global_gain({
				gold = arg_11_0.gold,
				diamond = arg_11_0.diamond,
				items = arg_11_0.items
			})
			self:accumulateAwardSuccess(arg_11_0)
		end
	end)
end

function SignNewManager:requestOtherMonthcardReward(arg_12_1, arg_12_2)
	require("network.network"):rpc("get_other_monthcard_reward", {
		rechargeid = arg_12_1
	}, function(arg_13_0)
		if arg_13_0.result == 1 then
			global_gain({
				gold = arg_13_0.gold,
				sp = arg_13_0.sp,
				diamond = arg_13_0.diamond,
				items = arg_13_0.items
			})

			self._extraInfo[arg_12_1].lastreward = true

			self:otherMonthcardRewardSuccess()
		elseif arg_13_0.result == 2 then
			global_ShowBlockWords("今日已领取")
		elseif arg_13_0.result == 3 then
			global_ShowBlockWords("已过期")
		end

		if arg_12_2 then
			arg_12_2(arg_13_0)
		end
	end)
end

function SignNewManager:handlerInfo(arg_14_1)
	return
end

function SignNewManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function SignNewManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function SignNewManager:getSignAccuTimeFromServeComplete(arg_17_1)
	self._mendcost = arg_17_1.mendcost

	if self.layer then
		self.layer:getSignAccuTimeFromServeComplete(arg_17_1)
	end
end

function SignNewManager:captureScreenGaussBlurComplete(arg_18_1)
	if self.layer then
		self.layer:captureScreenGaussBlurComplete(arg_18_1)
	end
end

function SignNewManager:signSuccess(arg_19_1)
	self._mendcost = arg_19_1.mendcost

	if self.layer then
		self.layer:signSuccess(arg_19_1)
	end
end

function SignNewManager:supplementSuccess(arg_20_1)
	self._mendcost = arg_20_1.mendcost

	if self.layer then
		self.layer:supplementSuccess(arg_20_1)
	end
end

function SignNewManager:accumulateAwardSuccess(arg_21_1)
	if self.layer then
		self.layer:accumulateAwardSuccess(arg_21_1)
	end
end

function SignNewManager:updateExtraRewardBg()
	if self.layer then
		self.layer:updateExtraRewardBg()
	end
end

function SignNewManager:getExtraInfo()
	return self._extraInfo
end

function SignNewManager:otherMonthcardRewardSuccess()
	if self.layer then
		self.layer:otherMonthcardRewardSuccess()
	end
end

function SignNewManager:getSignRate()
	return 1
end

return SignNewManager
