local OutpostEquip = require("app.view.module.outpost.model.struct.OutpostEquip")
local OutpostEquipBuild = class("OutpostEquipBuild", (require("app.view.module.outpost.model.struct.build.OutpostBuildBaseStruct")))

function OutpostEquipBuild:ctor(arg_1_1, arg_1_2)
	self._equipIndex = {}
	self._equipItemList = {}
	self._levelToEquipIdsDic = {}

	OutpostEquipBuild.super.ctor(self, arg_1_1, arg_1_2)
end

function OutpostEquipBuild:_initBuild()
	self._tab = g.core.config.outpost_equip_building_info

	OutpostEquipBuild.super._initBuild(self)

	for iter_2_0 = 1, g.core.config.outpost_equip_info.getLength() do
		local var_2_0 = g.core.config.outpost_equip_info.indexOf(iter_2_0)

		if var_2_0.building_type == self._type then
			local var_2_1 = self._levelToEquipIdsDic[var_2_0.consumption_level]

			if not self._levelToEquipIdsDic[var_2_0.consumption_level] then
				var_2_1 = {}
				self._levelToEquipIdsDic[var_2_0.consumption_level] = var_2_1
			end

			var_2_1[#var_2_1 + 1] = var_2_0.id
		end
	end
end

function OutpostEquipBuild:canChangePos()
	return true
end

function OutpostEquipBuild:_updateByLevel()
	OutpostEquipBuild.super._updateByLevel(self)
	self:_updateEquipList()
end

function OutpostEquipBuild:getBuildInfo()
	return
end

function OutpostEquipBuild:addHoldKnightBySid(arg_6_1)
	self._knightSidDic[arg_6_1] = {
		time = g.core.common.ServerTime:getTime() + 1
	}
end

function OutpostEquipBuild:onEffect(arg_7_1)
	OutpostEquipBuild.super:onEffect(self, arg_7_1)

	if arg_7_1 then
		self:_doProduce(arg_7_1)
	end
end

function OutpostEquipBuild:_updateEquipList()
	self._equipItemList = {}
	self._equipIndex = {}

	for iter_8_0 = 1, self._level do
		for iter_8_1, iter_8_2 in ipairs(self._levelToEquipIdsDic[iter_8_0] or {}) do
			local var_8_1 = OutpostEquip.new()

			var_8_1:updateEquipByEquipId(iter_8_2)

			self._equipItemList[#self._equipItemList + 1] = var_8_1
			self._equipIndex[iter_8_2] = var_8_1
		end
	end
end

function OutpostEquipBuild:getEquipList(arg_9_1, arg_9_2)
	local var_9_0

	if arg_9_1 then
		var_9_0 = {}

		for iter_9_0, iter_9_1 in ipairs(self._equipItemList) do
			local var_9_1 = self:getEquipProductNum(iter_9_1:getCfg().id)
			local var_9_2 = false

			if not arg_9_2 then
				var_9_2 = true
			elseif iter_9_1:getCfg().equip_type == arg_9_2 then
				var_9_2 = true
			end

			if var_9_1 > 0 and var_9_2 then
				var_9_0[#var_9_0 + 1] = iter_9_1
			end
		end
	else
		var_9_0 = self._equipItemList
	end

	return var_9_0
end

function OutpostEquipBuild:getEquipById(arg_10_1)
	return self._equipIndex[arg_10_1]
end

function OutpostEquipBuild:getEquipProductNum(arg_11_1)
	return (self._orderDic[arg_11_1] or nil) and self._orderDic[arg_11_1].num
end

function OutpostEquipBuild:_doProduce(arg_12_1)
	self:_sendOrderProcessToSever(arg_12_1)
end

function OutpostEquipBuild:_sendOrderProcessToSever(arg_13_1)
	g.core.network.GameNetProxy:send_C2S_Outpost_Build_OrderProcess({
		build_tp = self._type,
		order_tp = arg_13_1.orderType,
		knight_id = arg_13_1.knightId,
		target_id = arg_13_1.itemId,
		target_num = arg_13_1.num
	})
end

return OutpostEquipBuild
