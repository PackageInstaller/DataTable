local var_0_0 = class("KagutsuchiWorkEntrustHeroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.selController = ControllerUtil.GetController(arg_2_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.heroItemBtn_, nil, function()
		if arg_3_0.onClickHandler_ then
			arg_3_0.onClickHandler_(arg_3_0.heroID, arg_3_0.heroData)
		end
	end)
end

function var_0_0.SetClickHandler(arg_5_0, arg_5_1)
	if arg_5_1 then
		arg_5_0.onClickHandler_ = arg_5_1
	end
end

function var_0_0.SetHeroData(arg_6_0, arg_6_1)
	arg_6_0.heroID = arg_6_1
end

function var_0_0.GetHeroData(arg_7_0)
	return HeroData:GetHeroData(arg_7_0.heroID)
end

function var_0_0.TrySetSelected(arg_8_0, arg_8_1)
	if arg_8_0:IsLocked() or arg_8_0:IsLevelLimited() or arg_8_0:IsEntrusted() then
		return false
	end

	arg_8_0.selected_ = arg_8_1

	return arg_8_0.selected_
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = arg_9_0:GetHeroData()
	local var_9_1 = arg_9_0.heroID
	local var_9_2 = HeroCfg[var_9_1]

	arg_9_0.heroIcon_.sprite = HeroTools.GetHeadSprite(var_9_1)
	arg_9_0.raceIcon_.sprite = HeroTools.GetHeroRaceIcon(var_9_1)
	arg_9_0.levelText_.text = var_9_0.level
	arg_9_0.imageLv_.sprite = getSprite("Atlas/Common", "star_" .. var_9_2.rare)

	if arg_9_0:IsLocked() then
		arg_9_0.selController:SetSelectedState("absence")
	elseif arg_9_0:IsLevelLimited() then
		arg_9_0.selController:SetSelectedState("levelLimited")
	elseif arg_9_0:IsEntrusted() then
		arg_9_0.selController:SetSelectedState("entrusted")
	elseif arg_9_0.selected_ then
		arg_9_0.selController:SetSelectedState("selected")
	else
		arg_9_0.selController:SetSelectedState("unselected")
	end
end

function var_0_0.IsLocked(arg_10_0)
	return arg_10_0:GetHeroData().unlock == 0
end

function var_0_0.IsLevelLimited(arg_11_0)
	return arg_11_0:GetHeroData().level < KagutsuchiWorkData:GetMinEntrustHeroLevel()
end

function var_0_0.IsEntrusted(arg_12_0)
	return KagutsuchiWorkData:IsEntrusted(arg_12_0.heroID)
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
