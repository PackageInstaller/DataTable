local var_0_0 = {}

manager.net:Bind(43001, function(arg_1_0)
	BattleEquipData:InitBattleEquipData(arg_1_0)
	manager.notify:CallUpdateFunc(BATTLE_EQUIP_UPDATE)
	var_0_0.UpdateRedPoint()
end)

function var_0_0.RequestBattleEquipInfo()
	manager.net:SendWithLoadingNew(43002, {}, 43003)
end

function var_0_0.ChangeUpSuit(arg_3_0)
	local var_3_0 = {
		equip_suit_id = arg_3_0
	}

	manager.net:SendWithLoadingNew(43004, var_3_0, 43005, var_0_0.OnChangeUpSuit)
end

function var_0_0.OnChangeUpSuit(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		BattleEquipData:ChangeUpSuitId(arg_4_1.equip_suit_id)
	end

	manager.notify:CallUpdateFunc(CHANGE_UP_SUIT, arg_4_0, arg_4_1)
end

function var_0_0.CaculateGuaranteeNum(arg_5_0, arg_5_1)
	local var_5_0 = BattleEquipStageCfg[arg_5_0]
	local var_5_1 = BattleInstance.GetHardLevel(arg_5_0)

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_2 = false

		for iter_5_2, iter_5_3 in ipairs(iter_5_1) do
			local var_5_3 = ItemCfg[iter_5_3[1]]

			if var_5_3 and ItemConst.ITEM_TYPE.EQUIP == var_5_3.type and EquipCfg[iter_5_3[1]].starlevel == 5 then
				var_5_2 = true
			end
		end

		if var_5_2 then
			BattleEquipData:SetGuaranteeNum(var_5_1, 0)
		else
			BattleEquipData:AddGuaranteeNum(var_5_1, 1)
		end
	end

	return rewards
end

function var_0_0.UpdateRedPoint()
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_EQUIP_SECTION) then
		manager.redPoint:setTip(RedPointConst.BATTLE_EQUIP, not RedPointData:GetIsRedPointOpen(RED_POINT_ID.BATTLE_EQUIP) and 1 or 0)
	end

	BattleEquipData:InitNewTagData()
end

return var_0_0
