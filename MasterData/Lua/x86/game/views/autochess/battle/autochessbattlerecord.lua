local cjson = require("cjson")
local var_0_1 = {}

var_0_1.injected = false

function var_0_1.InitBattleRecord(arg_1_0)
	if var_0_1._InjectInitBattleRecordFunc then
		var_0_1._InjectInitBattleRecordFunc((var_0_1.SetupRecordData(arg_1_0)))
	end
end

function var_0_1.UpdateActionRecordState(arg_2_0, arg_2_1)
	if var_0_1._InjectUpdateActionRecordStateFunc then
		var_0_1._InjectUpdateActionRecordStateFunc(arg_2_0, arg_2_1)
	end
end

function var_0_1:SetupRecordData()
	local var_3_0 = {}

	for iter_3_0 = 1, #self do
		local var_3_1 = {
			round = iter_3_0,
			name = string.format("【%s】轮次", iter_3_0),
			actionList = {}
		}

		table.insert(var_3_0, var_3_1)

		for iter_3_1, iter_3_2 in ipairs(self[iter_3_0].actionList) do
			table.insert(var_3_1.actionList, {
				round = iter_3_0,
				actionId = iter_3_2.actionId,
				name = var_0_1.GetActionName(iter_3_2),
				desc = var_0_1.GetActionDesc(iter_3_2)
			})
		end
	end

	return cjson.encode(var_3_0)
end

function var_0_1:GetActionName()
	if self.actionType == AutoChessConst.ACTION_TYPE.MOVE then
		return string.format("【%s】移动", self.actionId)
	elseif self.actionType == AutoChessConst.ACTION_TYPE.FIGHT then
		return string.format("【%s】攻击", self.actionId)
	elseif self.actionType == AutoChessConst.ACTION_TYPE.DEAD then
		return string.format("【%s】棋子阵亡", self.actionId)
	elseif self.actionType == AutoChessConst.ACTION_TYPE.EFFECT then
		return string.format("【%s】buff触发", self.actionId)
	elseif self.actionType == AutoChessConst.ACTION_TYPE.REFRESH then
		return string.format("【%s】刷新棋子", self.actionId)
	elseif self.actionType == AutoChessConst.ACTION_TYPE.REMOVE_BUFF then
		return string.format("【%s】移除buff", self.actionId)
	elseif self.actionType == AutoChessConst.ACTION_TYPE.SHOP_REFRESH then
		return string.format("【%s】商店刷新", self.actionId)
	elseif self.actionType == AutoChessConst.ACTION_TYPE.GLOBAL_ATTR then
		return string.format("【%s】全局属性", self.actionId)
	elseif self.actionType == AutoChessConst.ACTION_TYPE.REFRESH_BUFF then
		return string.format("【%s】刷新buff", self.actionId)
	else
		return string.format("【%s】未知行为类型【%s】", self.actionId, self.actionType)
	end
end

function var_0_1:GetActionDesc()
	if self.actionType == AutoChessConst.ACTION_TYPE.MOVE then
		local var_5_0 = ""

		for iter_5_0 = 1, #self.moveDataList do
			var_5_0 = var_5_0 .. string.format("【%s】移动到【%s】", self.moveDataList[iter_5_0].chessUniquiId, self.moveDataList[iter_5_0].newPos)

			if iter_5_0 ~= #self.moveDataList then
				var_5_0 = var_5_0 .. ","
			end
		end

		return var_5_0
	elseif self.actionType == AutoChessConst.ACTION_TYPE.FIGHT then
		return string.format("【%s】和【%s】对撞, 【%s】血量变化【%s】, 【%s】血量变化【%s】", self.fightDataList[1].chessUniquiId, self.fightDataList[2].chessUniquiId, self.fightDataList[1].chessUniquiId, self.fightDataList[1].hpChange, self.fightDataList[2].chessUniquiId, self.fightDataList[2].hpChange)
	elseif self.actionType == AutoChessConst.ACTION_TYPE.DEAD then
		local var_5_1 = ""

		for iter_5_1, iter_5_2 in ipairs(self.deadChessList) do
			local var_5_2 = AutoChessData:GetChessData(iter_5_2)

			var_5_1 = var_5_1 .. string.format("棋子实例id【%s】, 棋子表id【%s】", var_5_2.uniqueId, var_5_2.chessId) .. "; "
		end

		return var_5_1
	elseif self.actionType == AutoChessConst.ACTION_TYPE.EFFECT then
		if self.actionEffectType == AutoChessConst.ACTION_EFFECT_TYPE.ADD_ATTR then
			local var_5_3 = "修改棋子属性\n"

			for iter_5_3, iter_5_4 in ipairs(self.targetAttributeDataList) do
				var_5_3 = var_5_3 .. string.format("修改属性, 棋子实例id【%s】, 攻击力变化【%s】, 血量变化【%s】", iter_5_4.chessUid, iter_5_4.attrData.hp, iter_5_4.attrData.atk) .. "\n"
			end

			return var_5_3
		elseif self.actionEffectType == AutoChessConst.ACTION_EFFECT_TYPE.DAMAGE then
			local var_5_4 = "造成伤害\n"

			for iter_5_5, iter_5_6 in ipairs(self.targetHpChangeData) do
				var_5_4 = var_5_4 .. string.format("棋子实例id【%s】, 血量变化【%s】", iter_5_6.chessUid, iter_5_6.hpChange) .. "\n"
			end

			return var_5_4
		elseif self.actionEffectType == AutoChessConst.ACTION_EFFECT_TYPE.SUMMON then
			local var_5_5 = "召唤棋子\n"

			for iter_5_7, iter_5_8 in ipairs(self.chessDataList) do
				var_5_5 = var_5_5 .. string.format("棋子实例id【%s】, 棋子表id【%s】, 棋子位置【%s】", iter_5_8.uniqueId, iter_5_8.chessId, iter_5_8.index) .. "\n"
			end

			return var_5_5
		elseif self.actionEffectType == AutoChessConst.ACTION_EFFECT_TYPE.ADD_BUFF or self.actionEffectType == AutoChessConst.ACTION_EFFECT_TYPE.ADD_ATTR_BUFF then
			local var_5_6 = "添加buff\n"

			for iter_5_9, iter_5_10 in ipairs(self.addBuffDataList) do
				var_5_6 = var_5_6 .. string.format("添加buff, buff实例id【%s】, buff表id【%s】, 目标uid【%s】", iter_5_10.targetBuffData.uniqueId, iter_5_10.targetBuffData.buffId, iter_5_10.targetUid) .. "\n"
			end

			return var_5_6
		elseif self.actionEffectType == AutoChessConst.ACTION_EFFECT_TYPE.REMOVE_SHOP then
			local var_5_7 = "移除商店物品\n"

			for iter_5_11, iter_5_12 in ipairs(self.removeShopIdList_) do
				var_5_7 = var_5_7 .. string.format("移除商店物品, 物品实例id【%s】", iter_5_12) .. "\n"
			end

			return var_5_7
		else
			local var_5_8 = AutoChessData:GetBuffData(self.buffUid)

			return string.format("未知buff效果类型【%s】, 来源buff实例id【%s】, 来源buff表id【%s】", self.actionEffectType, self.buffUid, (var_5_8 or nil) and (var_5_8.buffId or "无"))
		end
	elseif self.actionType == AutoChessConst.ACTION_TYPE.REMOVE_BUFF then
		local var_5_9 = ""
		local var_5_10 = AutoChessData:GetBuffData(self.buffUid)

		if var_5_10 then
			var_5_9 = var_5_9 .. string.format("移除buff, buff实例id【%s】, buff表id【%s】", self.buffUid, var_5_10.buffId) .. "\n"
		else
			print("移除buff表现节点，目标" .. self.buffUid .. "不存在, 可能是全局属性buff")
		end

		for iter_5_13, iter_5_14 in ipairs(self.chessAttrChangeDataList) do
			var_5_9 = var_5_9 .. string.format("修改棋子属性, 棋子实例id【%s】, 攻击力变化【%s】, 血量变化【%s】", iter_5_14.chessUid, iter_5_14.attrData.atk, iter_5_14.attrData.hp) .. "\n"
		end

		for iter_5_15, iter_5_16 in ipairs(self.globalAttrChangeDataList) do
			var_5_9 = var_5_9 .. string.format("修改全局属性, key【%s】, value【%s】", iter_5_16.key, iter_5_16.value) .. "\n"
		end

		return var_5_9
	else
		return ""
	end
end

function var_0_1.PrintRecord(arg_6_0)
	if not GameToSDK.IsEditorPlatform() then
		return
	end

	print(string.format("%s : %s", var_0_1.GetActionName(arg_6_0), (var_0_1.GetActionDesc(arg_6_0))))
end

return var_0_1
