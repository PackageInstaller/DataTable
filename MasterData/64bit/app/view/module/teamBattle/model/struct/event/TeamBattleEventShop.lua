local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleEventShop = class("TeamBattleEventShop", (require("app.view.module.teamBattle.model.struct.event.TeamBattleEventStruct")))

function TeamBattleEventShop:ctor(arg_1_1)
	TeamBattleEventShop.super.ctor(self, arg_1_1)

	self._buyTimes = 0
	self._buyPosMap = {}
	self._refreshTimeL = 0
	self._productList = {}
end

function TeamBattleEventShop:updateEvent(arg_2_1)
	TeamBattleEventShop.super.updateEvent(self, arg_2_1)

	self._buyTimes = arg_2_1.buy_times
	self._buyPosMap = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.buy_poss or {}) do
		self._buyPosMap[iter_2_1] = true
	end

	self._refreshTimeL = arg_2_1.last_refresh_time
	self._productList = arg_2_1.goods_ids or {}
end

function TeamBattleEventShop:getEventInfo()
	local var_3_0 = TeamBattleEventShop.super.getEventInfo(self)

	var_3_0.productList = {}
	var_3_0.buyTimes = self._buyTimes
	var_3_0.refreshTimeL = self._refreshTimeL

	for iter_3_0, iter_3_1 in ipairs(self._productList) do
		var_3_0.productList[iter_3_0] = {
			id = iter_3_1,
			isBuy = self._buyPosMap[iter_3_0 - 1]
		}

		if self._cfg.id ~= TeamBattleConst.EVENT_TYPE.BUFF_SHOP then
			var_3_0.productList[iter_3_0].num = 999
		end
	end

	return var_3_0
end

function TeamBattleEventShop:onBuyItemByPos(arg_4_1)
	self._buyPosMap[arg_4_1] = true
end

return TeamBattleEventShop
