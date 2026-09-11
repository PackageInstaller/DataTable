local PolyhedronAstrolabeAdjustView = class("PolyhedronAstrolabeAdjustView", AstrolabeAdjustView)

function PolyhedronAstrolabeAdjustView:AddListeners()
	self:AddBtnListener(self.loadBtn_, nil, function()
		local var_2_0 = self.lastSelectItem_:GetItemInfo()

		if self.equipNum_ >= AstrolabeConst.ASTROLABE_MAX_NUM then
			ShowTips("TIP_ASTROLABE_NUM_MAX")

			return
		end

		if not self:GetLastIsEquiped(var_2_0.id, var_2_0.heroId) then
			ShowTips(string.format(GetTips("TIP_ASTROLABE_FRONT"), GetI18NText(HeroAstrolabeCfg[var_2_0.id - 1].suit_name), GetI18NText(HeroAstrolabeCfg[var_2_0.id - 1].name)))

			return
		end

		PolyhedronAction.AstrolabeEquip(var_2_0.heroId, var_2_0.id)
	end)
	self:AddBtnListener(self.unloadBtn_, nil, function()
		local var_3_0 = self.lastSelectItem_:GetItemInfo()

		if self:GetNextIsEquiped(var_3_0.id, var_3_0.heroId) then
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
	self:AddBtnListener(self.loadAllBtn_, nil, function()
		local var_5_0 = self.lastSelectItem_:GetItemInfo()

		PolyhedronAction.AstrolabeEquipAll(var_5_0.heroId, HeroAstrolabeCfg[var_5_0.id].hero_astrolabe_suit_id)
	end)
	self:AddBtnListener(self.unloadAllBtn_, nil, function()
		PolyhedronAction.AstrolabeUnloadAll(self.lastSelectItem_:GetItemInfo().heroId)
	end)
end

function PolyhedronAstrolabeAdjustView:RefreshState(arg_7_1)
	if arg_7_1.isEquiped then
		self.stateController_:SetSelectedState("equip")
	elseif HeroAstrolabeCfg[arg_7_1.id].pos == 3 then
		self.stateController_:SetSelectedState("all")
	else
		self.stateController_:SetSelectedState("one")
	end

	self.lockCon_:SetSelectedState("false")
end

function PolyhedronAstrolabeAdjustView:GetLastIsEquiped(arg_8_1, arg_8_2)
	if HeroAstrolabeCfg[arg_8_1].pos == 1 then
		return true
	else
		return AstrolabeTools.GetIsEquiped(PolyhedronData:GetHeroData(arg_8_2).using_astrolabe, arg_8_1 - 1)
	end

	return false
end

function PolyhedronAstrolabeAdjustView:GetNextIsEquiped(arg_9_1, arg_9_2)
	if HeroAstrolabeCfg[arg_9_1].pos == 3 then
		return false
	else
		return AstrolabeTools.GetIsEquiped(PolyhedronData:GetHeroData(arg_9_2).using_astrolabe, arg_9_1 + 1)
	end

	return false
end

return PolyhedronAstrolabeAdjustView
