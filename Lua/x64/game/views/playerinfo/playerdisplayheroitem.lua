local var_0_0 = class("PlayerDisplayHeroItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index_ = arg_1_2

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.lockedController_ = ControllerUtil.GetController(arg_2_0.transform_, "locked")
	arg_2_0.campController_ = ControllerUtil.GetController(arg_2_0.transform_, "camp")
	arg_2_0.gradeController_ = ControllerUtil.GetController(arg_2_0.transform_, "grade")
	arg_2_0.sizeController_ = ControllerUtil.GetController(arg_2_0.transform_, "size")
	arg_2_0.selectedController_ = ControllerUtil.GetController(arg_2_0.transform_, "selected")
	arg_2_0.hpController_ = ControllerUtil.GetController(arg_2_0.transform_, "hp")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.selfBtn_, nil, function()
		ForeignInfoAction:TryToCheckForeignHeroInfo(arg_3_0.userID_, arg_3_0.data_.hero_id, 1, function()
			JumpTools.OpenPageByJump("/newHero", {
				isEnter = true,
				isForeign = true,
				notShowBar = true,
				hid = arg_3_0.data_.hero_id
			}, ViewConst.SYSTEM_ID.PLAYER_INFO)
		end)
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.SetHeroData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.userID_ = arg_7_1
	arg_7_0.data_ = arg_7_2

	arg_7_0:UpdataView()
end

function var_0_0.UpdataView(arg_8_0)
	arg_8_0.headIcon_.sprite = getSpriteViaConfig("HeroLittleIcon", arg_8_0.data_.using_skin == 0 and arg_8_0.data_.hero_id or arg_8_0.data_.using_skin)

	arg_8_0.headIcon_:SetNativeSize()
	arg_8_0.campController_:SetSelectedState(HeroCfg[arg_8_0.data_.hero_id].race)

	local var_8_0 = HeroStarCfg[arg_8_0.data_.star]
	local var_8_1 = var_8_0 ~= nil and var_8_0.star or 1

	arg_8_0.gradeController_:SetSelectedState(var_8_1)
	arg_8_0.lockedController_:SetSelectedState("false")
	arg_8_0.sizeController_:SetSelectedState("short")
	arg_8_0.selectedController_:SetSelectedState("false")
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
