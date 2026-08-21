local var_0_0 = {}

manager.net:Bind(52001, function(arg_1_0)
	IllustratedData:InitData(arg_1_0)
	var_0_0.UpdateServantRedPoint()
	var_0_0.UpdateEquipRedPoint()
	var_0_0.UpdateEnemyRedPoint()
	var_0_0.UpdateWorldViewRedPoint()
	var_0_0.UpdateIllustrationRedPoint()
end)
manager.net:Bind(52009, function(arg_2_0)
	IllustratedData:ModifyEnemyInfo(arg_2_0.enemy_info)
	var_0_0.UpdateEnemyRedPoint()
end)
manager.net:Bind(52011, function(arg_3_0)
	IllustratedData:ModifyIllustrationInfo(arg_3_0.inbetweening_info)
	var_0_0.UpdateIllustrationRedPoint()
	manager.notify:CallUpdateFunc(ILLU_RECEIVE)
end)
manager.net:Bind(52013, function(arg_4_0)
	IllustratedData:ModifyAffixInfo(arg_4_0.affix_info)
	var_0_0.UpdateWorldViewRedPoint()
end)
manager.net:Bind(52027, function(arg_5_0)
	IllustratedData:ModifyPlotInfo(arg_5_0.plot_info)
end)
manager.net:Bind(52021, function(arg_6_0)
	IllustratedData:SaveLoadingSet(arg_6_0.id_list)
end)

function var_0_0.ModifyServantInfo(arg_7_0)
	IllustratedData:ModifyServantInfo(arg_7_0)
	var_0_0.UpdateServantRedPoint()
end

function var_0_0.ModifyEquipInfo(arg_8_0, arg_8_1)
	IllustratedData:ModifyEquipInfo(arg_8_0, arg_8_1)
	var_0_0.UpdateEquipRedPoint()
end

function var_0_0.ModifyPlot(arg_9_0)
	IllustratedData:ModifyPlot(arg_9_0)
end

function var_0_0.ReceiveIllustrationReward(arg_10_0)
	manager.net:SendWithLoadingNew(52004, {
		id_list = arg_10_0
	}, 52005, var_0_0.OnReceiveIllustrationReward)
end

function var_0_0.OnReceiveIllustrationReward(arg_11_0, arg_11_1)
	if not isSuccess(arg_11_0.result) then
		ShowTips(arg_11_0.result)
	else
		for iter_11_0, iter_11_1 in ipairs(arg_11_1.id_list) do
			IllustratedData:GetIllustrationInfo()[iter_11_1].is_receive = 1
		end

		var_0_0.UpdateIllustrationRedPoint()
		manager.notify:CallUpdateFunc(ILLU_RECEIVE_REWARD, arg_11_0, arg_11_1)
	end
end

function var_0_0.ViewIllustration(arg_12_0, arg_12_1)
	manager.net:SendWithLoadingNew(52014, {
		id = arg_12_0,
		type = arg_12_1
	}, 52015, var_0_0.OnViewIllustration)
end

function var_0_0.OnViewIllustration(arg_13_0, arg_13_1)
	if isSuccess(arg_13_0.result) then
		IllustratedData:ModifyView(arg_13_1.id, arg_13_1.type)

		local var_13_0 = arg_13_1.type

		if var_13_0 == CollectConst.INFORMATION then
			-- block empty
		elseif var_13_0 == CollectConst.ENEMY then
			var_0_0.UpdateEnemyRedPoint()
		elseif var_13_0 == CollectConst.SERVANT then
			var_0_0.UpdateServantRedPoint()
		elseif var_13_0 == CollectConst.EQUIP then
			var_0_0.UpdateEquipRedPoint()
		elseif var_13_0 == CollectConst.PLOT then
			-- block empty
		elseif var_13_0 == CollectConst.ILLUSTRATION then
			var_0_0.UpdateIllustrationRedPoint()
		elseif var_13_0 == CollectConst.WORLDVIEW then
			var_0_0.UpdateWorldViewRedPoint()
		end
	else
		ShowTips(arg_13_0.result)
	end
end

function var_0_0.SaveLoadingSet(arg_14_0)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_0) do
		table.insertto(var_14_0, arg_14_0[iter_14_0])
	end

	local var_14_1 = {
		all_id_list = var_14_0
	}

	manager.net:SendWithLoadingNew(52016, var_14_1, 52017, var_0_0.OnSaveLoadingSet)
end

function var_0_0.OnSaveLoadingSet(arg_15_0, arg_15_1)
	if isSuccess(arg_15_0.result) then
		IllustratedData:SaveLoadingSet(arg_15_1.all_id_list)
		manager.notify:CallUpdateFunc(SAVE_LOADING_SET)
	else
		ShowTips(arg_15_0.result)
	end
end

function var_0_0.ChangeLoadingSet(arg_16_0, arg_16_1)
	local var_16_0 = {
		type = arg_16_0,
		id = arg_16_1
	}

	manager.net:SendWithLoadingNew(52018, var_16_0, 52019, var_0_0.OnChangeLoadingSet)
end

function var_0_0.OnChangeLoadingSet(arg_17_0, arg_17_1)
	if isSuccess(arg_17_0.result) then
		IllustratedData:ChangeLoadingSet(arg_17_1.type, arg_17_1.id)
		manager.notify:CallUpdateFunc(SAVE_LOADING_SET)
	else
		ShowTips(arg_17_0.result)
	end
end

function var_0_0.UpdateServantRedPoint()
	local function var_18_0(arg_19_0)
		return arg_19_0.is_view == 0
	end

	local var_18_1 = IllustratedData:GetServantInfo()

	var_0_0.UpdateIlluRedPoint(RedPointConst.ILLU_SERVANT, var_18_1, var_18_0)
end

function var_0_0.UpdateEquipRedPoint()
	local function var_20_0(arg_21_0)
		return arg_21_0.is_view == 0
	end

	local var_20_1 = IllustratedData:GetEquipInfo()

	var_0_0.UpdateIlluRedPoint(RedPointConst.ILLU_EQUIP, var_20_1, var_20_0)
end

function var_0_0.UpdateEnemyRedPoint()
	local var_22_0 = IllustratedData:GetEnemyInfo()

	for iter_22_0, iter_22_1 in pairs(MonsterCfg.get_id_list_by_race) do
		local var_22_1 = false

		for iter_22_2, iter_22_3 in pairs(var_22_0) do
			if MonsterCfg[iter_22_3.id].race == iter_22_0 and iter_22_3.is_view == 0 then
				var_22_1 = true

				break
			end
		end

		manager.redPoint:setTip(RedPointConst["ILUU_ENEMY" .. iter_22_0], var_22_1 and 1 or 0)
	end

	local function var_22_2(arg_23_0)
		return arg_23_0.is_view == 0
	end

	var_0_0.UpdateIlluRedPoint(RedPointConst.ILUU_ENEMY, var_22_0, var_22_2)
end

function var_0_0.UpdateWorldViewRedPoint()
	local function var_24_0(arg_25_0)
		return arg_25_0.is_view == 0
	end

	local var_24_1 = IllustratedData:GetAffixInfo()

	var_0_0.UpdateIlluRedPoint(RedPointConst.ILLU_WORLDVIEW, var_24_1, var_24_0)
end

function var_0_0.UpdateIlluRedPoint(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = getData("IlluRedPoint", arg_26_0)

	if not var_26_0 then
		var_26_0 = {}

		for iter_26_0, iter_26_1 in pairs(arg_26_1) do
			if arg_26_2(iter_26_1) then
				if not var_26_0[1] then
					var_26_0[1] = 1
				else
					var_26_0[2] = (var_26_0[2] or 0) + 1
				end
			end
		end

		var_26_0[1] = var_26_0[1] or 0
		var_26_0[2] = var_26_0[2] or 0

		saveData("IlluRedPoint", arg_26_0, var_26_0)
	else
		local var_26_1 = var_26_0[2]
		local var_26_2 = 0

		for iter_26_2, iter_26_3 in pairs(arg_26_1) do
			if arg_26_2(iter_26_3) then
				var_26_2 = var_26_2 + 1
			end
		end

		if var_26_1 < var_26_2 then
			var_26_0[1] = 1
			var_26_0[2] = var_26_2

			saveData("IlluRedPoint", arg_26_0, var_26_0)
		else
			var_26_0[2] = var_26_2

			saveData("IlluRedPoint", arg_26_0, var_26_0)
		end
	end

	manager.redPoint:setTip(arg_26_0, var_26_0[1])
end

function var_0_0.SetIlluRedPoint(arg_27_0)
	manager.redPoint:setTip(arg_27_0, 0)

	local var_27_0

	local function var_27_1(arg_28_0)
		return arg_28_0.is_view == 0
	end

	if arg_27_0 == RedPointConst.ILLU_WORLDVIEW then
		var_27_0 = IllustratedData:GetAffixInfo()
	elseif arg_27_0 == RedPointConst.ILLU_EQUIP then
		var_27_0 = IllustratedData:GetEquipInfo()
	elseif arg_27_0 == RedPointConst.ILLU_SERVANT then
		var_27_0 = IllustratedData:GetServantInfo()
	elseif arg_27_0 == RedPointConst.ILUU_ENEMY then
		var_27_0 = IllustratedData:GetEnemyInfo()
	else
		error("为实现的类型")
	end

	local var_27_2 = 0

	for iter_27_0, iter_27_1 in pairs(var_27_0) do
		if var_27_1(iter_27_1) then
			var_27_2 = var_27_2 + 1
		end
	end

	saveData("IlluRedPoint", arg_27_0, {
		0,
		var_27_2
	})
end

function var_0_0.UpdateIllustrationRedPoint()
	local var_29_0 = IllustratedData:GetIllustrationInfo()

	for iter_29_0 = 1, 6 do
		manager.redPoint:setTip(RedPointConst["ILLU_ILLUSTRATION" .. iter_29_0], 0)
	end

	for iter_29_1, iter_29_2 in pairs(var_29_0) do
		if iter_29_2.is_receive == 0 then
			manager.redPoint:setTip(RedPointConst["ILLU_ILLUSTRATION" .. CollectPictureCfg[iter_29_2.id].type], 1)
		end
	end
end

manager.net:Bind(12029, function(arg_30_0)
	IllustratedData:SetBgm(arg_30_0.id)
end)

function var_0_0.QuerySetBgm(arg_31_0)
	manager.net:SendWithLoadingNew(12026, {
		id = arg_31_0
	}, 12027, var_0_0.OnQuerySetBgmBack)
end

function var_0_0.OnQuerySetBgmBack(arg_32_0, arg_32_1)
	if isSuccess(arg_32_0.result) then
		local var_32_0 = IllustratedData:GetBgm()

		IllustratedData:SetBgm(arg_32_1.id)

		local var_32_1 = HomeSceneSettingData:GetCurScene()

		if HomeSceneSettingCfg[var_32_1].default_music ~= arg_32_1.id and var_32_0 ~= 0 then
			local var_32_2 = SettingData:GetHomeSceneSettingData()

			SettingAction.ChangeHomeSceneSetting("home_scene_scene_bgm", 0)
		end

		manager.notify:CallUpdateFunc(SET_BGM_SUCCESS)
	else
		ShowTips(arg_32_0.result)
	end
end

return var_0_0
