local var_0_0 = class("ActivityMatrixSelectHeroView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIUI/SoloRoguelike/VolumeSoloRoguelikeSelectCharacterUI"
end

function var_0_0.UIBackCount(arg_2_0)
	return 2
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.heroList = LuaList.New(handler(arg_5_0, arg_5_0.IndexItem), arg_5_0.m_list, ActivityMatrixSelectHeroItem)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.m_btn, nil, function()
		local var_7_0 = ActivityMatrixCfg[arg_6_0.matrix_activity_id]
		local var_7_1 = var_7_0.hero_template_id
		local var_7_2 = -1
		local var_7_3 = false
		local var_7_4
		local var_7_5 = arg_6_0.heros[arg_6_0.selectIndex]

		if var_7_5.hero_type == 1 then
			local var_7_6 = ActivityMatrixHeroStandardTemplateCfg.get_id_list_by_template_id[var_7_1]

			for iter_7_0, iter_7_1 in ipairs(var_7_6) do
				local var_7_7 = ActivityMatrixHeroStandardTemplateCfg[iter_7_1]

				if var_7_7.hero_id == var_7_5.id then
					var_7_2 = var_7_7.standard_id

					break
				end
			end

			local var_7_8 = HeroData:GetHeroData(var_7_5.id)

			var_7_4 = #var_7_8.using_astrolabe > 0

			local var_7_9 = var_7_8.equip
			local var_7_10 = HeroTools.GetIsSuitNumCut(var_7_8)
			local var_7_11 = EquipTools.CountActiveSuit(var_7_9)

			for iter_7_2 = #var_7_11, 1, -1 do
				if var_7_11[iter_7_2].num < EquipTools.GetSuitNeedNum(var_7_11[iter_7_2].id, var_7_10) then
					table.remove(var_7_11, iter_7_2)
				end
			end

			var_7_3 = #var_7_11 > 0
		else
			var_7_2 = var_7_5.id

			local var_7_12 = TempHeroData:GetTempHeroDataByTempID(var_7_2)

			var_7_4 = #var_7_12.using_astrolabe > 0

			local var_7_13 = var_7_12.equip_list
			local var_7_14 = HeroTools.GetIsSuitNumCut(var_7_12)
			local var_7_15 = {}

			for iter_7_3, iter_7_4 in pairs(var_7_13) do
				if iter_7_4.equip_id ~= 0 then
					local var_7_16 = EquipCfg[iter_7_4.prefab_id]

					if var_7_15[var_7_16.suit] then
						var_7_15[var_7_16.suit].num = var_7_15[var_7_16.suit].num + 1
					else
						var_7_15[var_7_16.suit] = {
							num = 1,
							id = var_7_16.suit
						}
					end
				end
			end

			local var_7_17 = {}

			for iter_7_5, iter_7_6 in pairs(var_7_15) do
				table.insert(var_7_17, iter_7_6)
			end

			for iter_7_7 = #var_7_17, 1, -1 do
				if var_7_17[iter_7_7].num < EquipTools.GetSuitNeedNum(var_7_17[iter_7_7].id, var_7_14) then
					table.remove(var_7_17, iter_7_7)
				end
			end

			var_7_3 = #var_7_17 > 0
		end

		if not var_7_2 or var_7_2 == -1 then
			ShowTips("ERROR_NO_TEMPLATE")

			return
		end

		local var_7_18

		if not var_7_3 and not var_7_4 then
			var_7_18 = GetTips("ACTIVITY_MATRIX_LACK_ALL")
		elseif not var_7_3 then
			var_7_18 = GetTips("ACTIVITY_MATRIX_LACK_EQUIP")
		elseif not var_7_4 then
			var_7_18 = GetTips("ACTIVITY_MATRIX_LACK_ASTROLABE")
		end

		local var_7_19 = handler(arg_6_0, function()
			if var_7_0.type == 1 then
				ActivityMatrixAction.QueryStartMatrix({
					{
						hero_standard_system_id = var_7_2,
						hero_type = var_7_5.hero_type
					}
				}, arg_6_0.matrix_activity_id, {})
			elseif var_7_0.type == 2 then
				arg_6_0:Go("activityMatrixSelectAffix", {
					matrix_activity_id = arg_6_0.matrix_activity_id,
					select_hero_list = {
						{
							hero_standard_system_id = var_7_2,
							hero_type = var_7_5.hero_type
						}
					}
				})
			else
				ShowTips("ERROR_BAD_ARG")
			end
		end)

		if var_7_18 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = var_7_18,
				OkCallback = var_7_19
			})
		else
			var_7_19()
		end
	end)
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MATRIX_DESC")
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.matrix_activity_id = arg_10_0.params_.matrix_activity_id
	arg_10_0.selectIndex = -1

	local var_10_0 = ActivityMatrixCfg[arg_10_0.matrix_activity_id]

	if not var_10_0 then
		arg_10_0.heroList:StartScroll(0)

		return
	end

	arg_10_0.heros = {}

	local var_10_1 = var_10_0.hero_trial

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		table.insert(arg_10_0.heros, {
			hero_type = 2,
			id = iter_10_1
		})
	end

	local var_10_2 = var_10_0.race_list
	local var_10_3 = HeroData:GetHeroList()

	for iter_10_2, iter_10_3 in pairs(var_10_3) do
		local var_10_4 = HeroCfg[iter_10_2]

		if iter_10_3.unlock == 1 and var_10_4 and table.indexof(var_10_2, var_10_4.race) then
			table.insert(arg_10_0.heros, {
				hero_type = 1,
				id = iter_10_2
			})
		end
	end

	arg_10_0.heroList:StartScroll(#arg_10_0.heros)
	arg_10_0:RefreshUI()
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()
end

function var_0_0.RefreshUI(arg_12_0)
	if arg_12_0.selectIndex == -1 then
		arg_12_0.m_btn.interactable = false
	else
		arg_12_0.m_btn.interactable = true
	end
end

function var_0_0.IndexItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2:SetIndex(arg_13_1)

	local var_13_0 = arg_13_0.heros[arg_13_1]

	if var_13_0.hero_type == 1 then
		arg_13_2:SetData(var_13_0.id)
	else
		arg_13_2:SetStandardData(var_13_0.id)
	end

	arg_13_2:SetSelect(arg_13_0.selectIndex)
	arg_13_2:RegistCallBack(handler(arg_13_0, arg_13_0.OnHeroItemClick))
end

function var_0_0.OnHeroItemClick(arg_14_0, arg_14_1)
	arg_14_0.selectIndex = arg_14_1

	local var_14_0 = arg_14_0.heroList:GetItemList()

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		iter_14_1:SetSelect(arg_14_0.selectIndex)
	end

	arg_14_0:RefreshUI()
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.heroList:Dispose()
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
