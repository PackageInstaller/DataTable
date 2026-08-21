local var_0_0 = class("ObtainWeaponView", ObtainBaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	var_0_0.super.Init(arg_2_0)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.weaponImg_.immediate = true
	arg_3_0.starController_ = ControllerUtil.GetController(arg_3_0.starControllerTrs_, "star")
	arg_3_0.AdaptImg_ = arg_3_0:FindCom("AdaptImage", nil, arg_3_0.weaponImg_.transform)
end

function var_0_0.Show(arg_4_0, arg_4_1)
	arg_4_0.item = arg_4_1

	local var_4_0 = arg_4_1.id

	if arg_4_0.gameObject_ then
		SetActive(arg_4_0.gameObject_, true)
	end

	if arg_4_1.draw_rebate and arg_4_1.draw_rebate ~= 0 then
		SetActive(arg_4_0.rebateGo_, true)

		arg_4_0.rebateLab_.text = "x" .. arg_4_1.draw_rebate
	else
		SetActive(arg_4_0.rebateGo_, false)
	end

	if arg_4_0.playableDirector_ then
		arg_4_0.playableDirector_:Evaluate()
		arg_4_0.playableDirector_:Play()
	end

	arg_4_0:SetInfo(var_4_0)
end

function var_0_0.SetInfo(arg_5_0, arg_5_1)
	local var_5_0 = ItemCfg[arg_5_1]
	local var_5_1 = WeaponServantCfg[arg_5_1]

	if not var_5_0 or not var_5_1 then
		return
	end

	arg_5_0.weaponImg_.spriteSync = "TextureConfig/WeaponServant/Portrait/" .. arg_5_1

	arg_5_0.AdaptImg_:AdaptImg()

	arg_5_0.nameText_.text = ItemTools.getItemName(arg_5_1)

	local var_5_2 = RaceEffectCfg[var_5_1.race]

	arg_5_0.camp_.sprite = getSprite("Atlas/CampItemAtlas", var_5_2.icon)

	local var_5_3 = math.min(var_5_0.display_rare, 5)

	arg_5_0.starController_:SetSelectedIndex(var_5_3)

	if var_5_3 == 5 then
		manager.audio:SetObtainGoldSelectorLabel()
	elseif var_5_3 == 4 then
		manager.audio:SetObtainPurpleSelectorLabel()
	else
		manager.audio:SetObtainBlueSelectorLabel()
	end
end

function var_0_0.GetTimeLineEndTime(arg_6_0)
	return 2.5
end

function var_0_0.Hide(arg_7_0)
	var_0_0.super.Hide(arg_7_0)

	arg_7_0.weaponImg_.sprite = nil
end

return var_0_0
