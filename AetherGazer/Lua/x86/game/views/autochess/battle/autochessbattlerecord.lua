local var_0_0 = require("cjson")
local var_0_1 = {}

var_0_1.injected = false

function var_0_1.InitBattleRecord(arg_1_0)
	if var_0_1._InjectInitBattleRecordFunc then
		local var_1_0 = var_0_1.SetupRecordData(arg_1_0)

		var_0_1._InjectInitBattleRecordFunc(var_1_0)
	end
end

function var_0_1.UpdateActionRecordState(arg_2_0, arg_2_1)
	if var_0_1._InjectUpdateActionRecordStateFunc then
		var_0_1._InjectUpdateActionRecordStateFunc(arg_2_0, arg_2_1)
	end
end

function var_0_1.SetupRecordData(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = #arg_3_0

	for iter_3_0 = 1, var_3_1 do
		local var_3_2 = arg_3_0[iter_3_0]
		local var_3_3 = {
			round = iter_3_0,
			name = string.format("【%s】轮次", iter_3_0),
			actionList = {}
		}

		table.insert(var_3_0, var_3_3)

		local var_3_4 = var_3_2.actionList

		for iter_3_1, iter_3_2 in ipairs(var_3_4) do
			local var_3_5 = {
				round = iter_3_0,
				actionId = iter_3_2.actionId,
				name = var_0_1.GetActionName(iter_3_2),
				desc = var_0_1.GetActionDesc(iter_3_2)
			}

			table.insert(var_3_3.actionList, var_3_5)
		end
	end

	return var_0_0.encode(var_3_0)
end

function var_0_1.GetActionName(arg_4_0)
	local var_4_0 = arg_4_0.actionType

	if var_4_0 == AutoChessConst.ACTION_TYPE.MOVE then
		return string.format("【%s】移动", arg_4_0.actionId)
	elseif var_4_0 == AutoChessConst.ACTION_TYPE.FIGHT then
		return string.format("【%s】攻击", arg_4_0.actionId)
	elseif var_4_0 == AutoChessConst.ACTION_TYPE.DEAD then
		return string.format("【%s】棋子阵亡", arg_4_0.actionId)
	elseif var_4_0 == AutoChessConst.ACTION_TYPE.EFFECT then
		return string.format("【%s】buff触发", arg_4_0.actionId)
	elseif var_4_0 == AutoChessConst.ACTION_TYPE.REFRESH then
		return string.format("【%s】刷新棋子", arg_4_0.actionId)
	elseif var_4_0 == AutoChessConst.ACTION_TYPE.REMOVE_BUFF then
		return string.format("【%s】移除buff", arg_4_0.actionId)
	elseif var_4_0 == AutoChessConst.ACTION_TYPE.SHOP_REFRESH then
		return string.format("【%s】商店刷新", arg_4_0.actionId)
	elseif var_4_0 == AutoChessConst.ACTION_TYPE.GLOBAL_ATTR then
		return string.format("【%s】全局属性", arg_4_0.actionId)
	elseif var_4_0 == AutoChessConst.ACTION_TYPE.REFRESH_BUFF then
		return string.format("【%s】刷新buff", arg_4_0.actionId)
	else
		return string.format("【%s】未知行为类型【%s】", arg_4_0.actionId, var_4_0)
	end
end

function var_0_1.GetActionDesc(arg_5_0)
	local var_5_0 = arg_5_0.actionType

	if var_5_0 == AutoChessConst.ACTION_TYPE.MOVE then
		local var_5_1 = ""

		for iter_5_0 = 1, #arg_5_0.moveDataList do
			local var_5_2 = arg_5_0.moveDataList[iter_5_0]

			var_5_1 = var_5_1 .. string.format("【%s】移动到【%s】", var_5_2.chessUniquiId, var_5_2.newPos)

			if iter_5_0 ~= #arg_5_0.moveDataList then
				var_5_1 = var_5_1 .. ","
			end
		end

		return var_5_1
	elseif var_5_0 == AutoChessConst.ACTION_TYPE.FIGHT then
		local var_5_3 = arg_5_0.fightDataList[1]
		local var_5_4 = arg_5_0.fightDataList[2]
		local var_5_5 = var_5_3.chessUniquiId
		local var_5_6 = var_5_4.chessUniquiId

		return string.format("【%s】和【%s】对撞, 【%s】血量变化【%s】, 【%s】血量变化【%s】", var_5_5, var_5_6, var_5_5, var_5_3.hpChange, var_5_6, var_5_4.hpChange)
	elseif var_5_0 == AutoChessConst.ACTION_TYPE.DEAD then
		local var_5_7 = ""

		for iter_5_1, iter_5_2 in ipairs(arg_5_0.deadChessList) do
			local var_5_8 = AutoChessData:GetChessData(iter_5_2)

			var_5_7 = var_5_7 .. string.format("棋子实例id【%s】, 棋子表id【%s】", var_5_8.uniqueId, var_5_8.chessId) .. "; "
		end

		return var_5_7
	elseif var_5_0 == AutoChessConst.ACTION_TYPE.EFFECT then
		if arg_5_0.actionEffectType == AutoChessConst.ACTION_EFFECT_TYPE.ADD_ATTR then
			local var_5_9 = "修改棋子属性\n"

			for iter_5_3, iter_5_4 in ipairs(arg_5_0.targetAttributeDataList) do
				var_5_9 = var_5_9 .. string.format("修改属性, 棋子实例id【%s】, 攻击力变化【%s】, 血量变化【%s】", iter_5_4.chessUid, iter_5_4.attrData.hp, iter_5_4.attrData.atk) .. "\n"
			end

			return var_5_9
		elseif arg_5_0.actionEffectType == AutoChessConst.ACTION_EFFECT_TYPE.DAMAGE then
			local var_5_10 = "造成伤害\n"

			for iter_5_5, iter_5_6 in ipairs(arg_5_0.targetHpChangeData) do
				var_5_10 = var_5_10 .. string.format("棋子实例id【%s】, 血量变化【%s】", iter_5_6.chessUid, iter_5_6.hpChange) .. "\n"
			end

			return var_5_10
		elseif arg_5_0.actionEffectType == AutoChessConst.ACTION_EFFECT_TYPE.SUMMON then
			local var_5_11 = "召唤棋子\n"

			for iter_5_7, iter_5_8 in ipairs(arg_5_0.chessDataList) do
				var_5_11 = var_5_11 .. string.format("棋子实例id【%s】, 棋子表id【%s】, 棋子位置【%s】", iter_5_8.uniqueId, iter_5_8.chessId, iter_5_8.index) .. "\n"
			end

			return var_5_11
		elseif arg_5_0.actionEffectType == AutoChessConst.ACTION_EFFECT_TYPE.ADD_BUFF or arg_5_0.actionEffectType == AutoChessConst.ACTION_EFFECT_TYPE.ADD_ATTR_BUFF then
			local var_5_12 = "添加buff\n"

			for iter_5_9, iter_5_10 in ipairs(arg_5_0.addBuffDataList) do
				var_5_12 = var_5_12 .. string.format("添加buff, buff实例id【%s】, buff表id【%s】, 目标uid【%s】", iter_5_10.targetBuffData.uniqueId, iter_5_10.targetBuffData.buffId, iter_5_10.targetUid) .. "\n"
			end

			return var_5_12
		elseif arg_5_0.actionEffectType == AutoChessConst.ACTION_EFFECT_TYPE.REMOVE_SHOP then
			local var_5_13 = "移除商店物品\n"

			for iter_5_11, iter_5_12 in ipairs(arg_5_0.removeShopIdList_) do
				var_5_13 = var_5_13 .. string.format("移除商店物品, 物品实例id【%s】", iter_5_12) .. "\n"
			end

			return var_5_13
		else
			local var_5_14 = AutoChessData:GetBuffData(arg_5_0.buffUid)

			return string.format("未知buff效果类型【%s】, 来源buff实例id【%s】, 来源buff表id【%s】", arg_5_0.actionEffectType, arg_5_0.buffUid, var_5_14 and var_5_14.buffId or "无")
		end
	elseif var_5_0 == AutoChessConst.ACTION_TYPE.REMOVE_BUFF then
		local var_5_15 = ""
		local var_5_16 = AutoChessData:GetBuffData(arg_5_0.buffUid)

		if var_5_16 then
			var_5_15 = var_5_15 .. string.format("移除buff, buff实例id【%s】, buff表id【%s】", arg_5_0.buffUid, var_5_16.buffId) .. "\n"
		else
			print("移除buff表现节点，目标" .. arg_5_0.buffUid .. "不存在, 可能是全局属性buff")
		end

		for iter_5_13, iter_5_14 in ipairs(arg_5_0.chessAttrChangeDataList) do
			var_5_15 = var_5_15 .. string.format("修改棋子属性, 棋子实例id【%s】, 攻击力变化【%s】, 血量变化【%s】", iter_5_14.chessUid, iter_5_14.attrData.atk, iter_5_14.attrData.hp) .. "\n"
		end

		for iter_5_15, iter_5_16 in ipairs(arg_5_0.globalAttrChangeDataList) do
			var_5_15 = var_5_15 .. string.format("修改全局属性, key【%s】, value【%s】", iter_5_16.key, iter_5_16.value) .. "\n"
		end

		return var_5_15
	else
		return ""
	end
end

function var_0_1.PrintRecord(arg_6_0)
	if not GameToSDK.IsEditorPlatform() then
		return
	end

	local var_6_0 = var_0_1.GetActionName(arg_6_0)
	local var_6_1 = var_0_1.GetActionDesc(arg_6_0)

	print(string.format("%s : %s", var_6_0, var_6_1))
end

return var_0_1
