local var_0_0 = class("OathHeroItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.selectController_ = arg_2_0.controller_:GetController("select")
	arg_2_0.oathLvStateController_ = arg_2_0.controller_:GetController("oathLv")
	arg_2_0.oathStateController_ = arg_2_0.controller_:GetController("oathState")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		manager.notify:Invoke(OATH_SELECT_HERO, arg_3_0.heroID)
	end)
end

function var_0_0.ChangeSelect(arg_5_0, arg_5_1)
	if arg_5_1 then
		arg_5_0.selectController_:SetSelectedState("select")
	else
		arg_5_0.selectController_:SetSelectedState("unselect")
	end
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	if arg_6_0.heroID then
		manager.redPoint:unbindUIandKey(arg_6_0.transform_, RedPointConst.OATH_HERO .. arg_6_0.heroID)
	end

	arg_6_0.heroID = arg_6_1

	arg_6_0:RefreshUI()
	manager.redPoint:bindUIandKey(arg_6_0.transform_, RedPointConst.OATH_HERO .. arg_6_0.heroID)
	arg_6_0:UpdateCanOathNotice()
end

function var_0_0.UpdateCanOathNotice(arg_7_0)
	local var_7_0 = manager.redPoint:getTipBoolean(RedPointConst.OATH_HERO_CAN_COMPLETE .. arg_7_0.heroID)

	SetActive(arg_7_0.canOathObj_, var_7_0)
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0:UpdateLvUI()
	arg_8_0:UpdateOathState()

	arg_8_0.oathName_.text = GetI18NText(HeroCfg[arg_8_0.heroID].suffix)
	arg_8_0.heroImg_.sprite = HeroTools.GetHeadSprite(arg_8_0.heroID)
end

function var_0_0.UpdateLvUI(arg_9_0)
	local var_9_0 = OathCollectionContentData:GetOathLevel(arg_9_0.heroID)

	if var_9_0 == 0 then
		arg_9_0.oathLvStateController_:SetSelectedState("begin")
	elseif var_9_0 >= OathConst.OATH_MAX_LV then
		arg_9_0.oathLvStateController_:SetSelectedState("max")
	else
		arg_9_0.oathLvStateController_:SetSelectedState("normal")
	end

	arg_9_0.oathLv_.text = OathTools.GetOathLvShowTips(var_9_0) or var_9_0
	arg_9_0.oathGrayLv_.text = OathTools.GetOathLvShowTips(var_9_0) or var_9_0
end

function var_0_0.UpdateOathState(arg_10_0)
	local var_10_0 = HeroData:GetHeroList()[arg_10_0.heroID]

	if OathCollectionContentData:GetOathState(arg_10_0.heroID) then
		arg_10_0.oathStateController_:SetSelectedState("noOath")
	else
		arg_10_0.oathStateController_:SetSelectedState("finishOath")
	end
end

function var_0_0.Dispose(arg_11_0)
	manager.redPoint:unbindUIandKey(arg_11_0.transform_, RedPointConst.OATH_HERO .. arg_11_0.heroID)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
