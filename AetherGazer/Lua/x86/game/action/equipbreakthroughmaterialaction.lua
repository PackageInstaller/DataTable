local var_0_0 = {}

manager.net:Bind(35001, function(arg_1_0)
	EquipBreakThroughMaterialData:InitData(arg_1_0)
end)
manager.net:Bind(35003, function(arg_2_0)
	EquipBreakThroughMaterialData:UpdateMapData(arg_2_0)
end)

function var_0_0.RequireEquipBTMaterialData(arg_3_0, arg_3_1)
	manager.net:SendWithLoadingNew(35100, {
		difficulty = arg_3_0
	}, 35101, function(arg_4_0)
		if isSuccess(arg_4_0.result) then
			arg_3_1(arg_4_0)
		else
			ShowTips(arg_4_0.result)
		end
	end)
end

function var_0_0.ChooseBuff(arg_5_0, arg_5_1, arg_5_2)
	manager.net:SendWithLoadingNew(35104, {
		id = arg_5_0,
		buff_id = arg_5_1
	}, 35105, function(arg_6_0)
		if isSuccess(arg_6_0.result) then
			arg_5_2(arg_6_0)
		else
			ShowTips(arg_6_0.result)
		end
	end)
end

function var_0_0.ChooseHeal(arg_7_0, arg_7_1)
	manager.net:SendWithLoadingNew(35106, {
		id = arg_7_0
	}, 35107, function(arg_8_0)
		if isSuccess(arg_8_0.result) then
			arg_7_1(arg_8_0)
		else
			ShowTips(arg_8_0.result)
		end
	end)
end

function var_0_0.ResetMap(arg_9_0)
	manager.net:SendWithLoadingNew(35102, {}, 35103, function(arg_10_0)
		if isSuccess(arg_10_0.result) then
			arg_9_0(arg_10_0)
		else
			ShowTips(arg_10_0.result)
		end
	end)
end

function var_0_0.SendReceiveReward(arg_11_0, arg_11_1)
	manager.net:SendWithLoadingNew(35108, {
		id_list = arg_11_0
	}, 35109, function(arg_12_0)
		if isSuccess(arg_12_0.result) then
			local var_12_0 = {}

			getReward(mergeReward(arg_12_0.reward_list))
			EquipBreakThroughMaterialData:ReceiveReward(arg_11_0)
			arg_11_1(arg_12_0)
		else
			ShowTips(arg_12_0.result)
		end
	end)
end

function var_0_0.SaveComboSkillID(arg_13_0, arg_13_1)
	manager.net:SendWithLoadingNew(35110, {
		id = arg_13_0
	}, 35111, function(arg_14_0)
		if isSuccess(arg_14_0.result) then
			EquipBreakThroughMaterialData:SetComboSkillID(arg_13_0)
			arg_13_1()
		else
			ShowTips(arg_14_0.result)
		end
	end)
end

function var_0_0.CheckTimeout()
	if EquipBreakThroughMaterialData:GetSelectModeID() == 0 then
		var_0_0.EquipBTMaterialBackEntrace()
	end
end

function var_0_0.EquipBTMaterialBackEntrace()
	ShowMessageBox({
		ButtonType = "SingleBtn",
		title = GetTips("PROMPT"),
		content = GetTips("EQUIP_BREAK_THROUGH_REFRESH_DATA"),
		OkCallback = function()
			gameContext:OverrideUrl("/equipBreakThroughMaterialMap", "/equipBreakThroughMaterialMode", nil, "home")
			gameContext:Go("/equipBreakThroughMaterialMode")
		end,
		MaskCallback = function()
			gameContext:OverrideUrl("/equipBreakThroughMaterialMap", "/equipBreakThroughMaterialMode", nil, "home")
			gameContext:Go("/equipBreakThroughMaterialMode")
		end
	})
end

function var_0_0.EnterEquipBTMaterial()
	if EquipBreakThroughMaterialData:GetSelectModeID() ~= 0 then
		gameContext:Go("/equipBreakThroughMaterialMap")
	else
		gameContext:Go("/equipBreakThroughMaterialMode")
	end
end

return var_0_0
