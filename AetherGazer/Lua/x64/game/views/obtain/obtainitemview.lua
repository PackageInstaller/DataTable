local var_0_0 = class("ObtainItemView", ObtainBaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	var_0_0.super.Init(arg_2_0)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.starController_ = ControllerUtil.GetController(arg_3_0.starControllerTrs_, "star")
	arg_3_0.effect_ = arg_3_0:FindCom("Effect_distortion_add", "", arg_3_0.rareEffect_)
end

function var_0_0.SetInfo(arg_4_0, arg_4_1)
	local var_4_0 = ItemCfg[arg_4_1]

	if not var_4_0 then
		return
	end

	arg_4_0.iconImage_.sprite = ItemTools.getItemSprite(arg_4_1)
	arg_4_0.itemName_.text = ItemTools.getItemName(arg_4_1)

	local var_4_1 = math.min(var_4_0.display_rare, 5)

	arg_4_0.starController_:SetSelectedIndex(var_4_1)

	if var_4_1 == 5 then
		manager.audio:SetObtainGoldSelectorLabel()
	elseif var_4_1 == 4 then
		manager.audio:SetObtainPurpleSelectorLabel()
	else
		manager.audio:SetObtainBlueSelectorLabel()
	end

	local var_4_2 = var_4_0.display_rare or 0
	local var_4_3

	if var_4_2 <= 3 then
		var_4_3 = Color.New(0.2588235, 0.6078432, 1)
	elseif var_4_2 == 4 then
		var_4_3 = Color.New(0.9333333, 0, 1)
	else
		var_4_3 = Color.New(1, 0.7411765, 0.1764706)
	end

	arg_4_0.nameBg_.color = var_4_3
	arg_4_0.effect_._MainColor = var_4_3
end

function var_0_0.GetTimeLineEndTime(arg_5_0)
	return 0.8
end

return var_0_0
