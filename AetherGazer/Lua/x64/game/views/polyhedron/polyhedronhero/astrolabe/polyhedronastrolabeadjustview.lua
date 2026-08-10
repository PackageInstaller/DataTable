local var_0_0 = class("PolyhedronAstrolabeAdjustView", AstrolabeAdjustView)

function var_0_0.AddListeners(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.loadBtn_, nil, function()
		local var_2_0 = arg_1_0.lastSelectItem_:GetItemInfo()

		if arg_1_0.equipNum_ >= AstrolabeConst.ASTROLABE_MAX_NUM then
			ShowTips("TIP_ASTROLABE_NUM_MAX")

			return
		end

		if not arg_1_0:GetLastIsEquiped(var_2_0.id, var_2_0.heroId) then
			local var_2_1 = HeroAstrolabeCfg[var_2_0.id - 1]

			ShowTips(string.format(GetTips("TIP_ASTROLABE_FRONT"), GetI18NText(var_2_1.suit_name), GetI18NText(var_2_1.name)))

			return
		end

		PolyhedronAction.AstrolabeEquip(var_2_0.heroId, var_2_0.id)
	end)
	arg_1_0:AddBtnListener(arg_1_0.unloadBtn_, nil, function()
		local var_3_0 = arg_1_0.lastSelectItem_:GetItemInfo()
		local var_3_1 = HeroAstrolabeCfg[var_3_0.id]

		if arg_1_0:GetNextIsEquiped(var_3_0.id, var_3_0.heroId) then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("TIP_ASTROLABE_UNINSTALL"),
				OkCallback = function()
					PolyhedronAction.AstrolabeUnload(var_3_0.heroId, var_3_0.id)
				end
			})
		else
			PolyhedronAction.AstrolabeUnload(var_3_0.heroId, var_3_0.id)
		end
	end)
	arg_1_0:AddBtnListener(arg_1_0.loadAllBtn_, nil, function()
		local var_5_0 = arg_1_0.lastSelectItem_:GetItemInfo()
		local var_5_1 = HeroAstrolabeCfg[var_5_0.id]

		PolyhedronAction.AstrolabeEquipAll(var_5_0.heroId, var_5_1.hero_astrolabe_suit_id)
	end)
	arg_1_0:AddBtnListener(arg_1_0.unloadAllBtn_, nil, function()
		local var_6_0 = arg_1_0.lastSelectItem_:GetItemInfo()

		PolyhedronAction.AstrolabeUnloadAll(var_6_0.heroId)
	end)
end

function var_0_0.RefreshState(arg_7_0, arg_7_1)
	local var_7_0 = HeroAstrolabeCfg[arg_7_1.id]

	if arg_7_1.isEquiped then
		arg_7_0.stateController_:SetSelectedState("equip")
	elseif var_7_0.pos == 3 then
		arg_7_0.stateController_:SetSelectedState("all")
	else
		arg_7_0.stateController_:SetSelectedState("one")
	end

	arg_7_0.lockCon_:SetSelectedState("false")
end

function var_0_0.GetLastIsEquiped(arg_8_0, arg_8_1, arg_8_2)
	if HeroAstrolabeCfg[arg_8_1].pos == 1 then
		return true
	else
		local var_8_0 = PolyhedronData:GetHeroData(arg_8_2)

		return AstrolabeTools.GetIsEquiped(var_8_0.using_astrolabe, arg_8_1 - 1)
	end

	return false
end

function var_0_0.GetNextIsEquiped(arg_9_0, arg_9_1, arg_9_2)
	if HeroAstrolabeCfg[arg_9_1].pos == 3 then
		return false
	else
		local var_9_0 = PolyhedronData:GetHeroData(arg_9_2)

		return AstrolabeTools.GetIsEquiped(var_9_0.using_astrolabe, arg_9_1 + 1)
	end

	return false
end

return var_0_0
