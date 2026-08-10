local var_0_0 = class("IlluServantManualItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.iconImg_.immediate = true
	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.transform_, "conName")
	arg_3_0.raceController_ = ControllerUtil.GetController(arg_3_0.transform_, "race")
	arg_3_0.rareController_ = ControllerUtil.GetController(arg_3_0.transform_, "rare")
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1)
	arg_4_0.info_ = arg_4_1
	arg_4_0.ID_ = arg_4_1.id
	arg_4_0.nameText_.text = GetI18NText(arg_4_1.name)
	arg_4_0.iconImg_.spriteSync = "TextureConfig/WeaponServant/IlluServant/" .. arg_4_0.ID_

	if arg_4_1.isUnlock then
		arg_4_0.controller_:SetSelectedState("unlock")

		arg_4_0.view_ = IllustratedData:GetIsView(arg_4_0.ID_, 3)

		manager.redPoint:SetRedPointIndependent(arg_4_0.transform_, arg_4_0.view_ == 0)
	else
		arg_4_0.controller_:SetSelectedState("lock")
		manager.redPoint:SetRedPointIndependent(arg_4_0.transform_, false)
	end

	arg_4_0.raceController_:SetSelectedState(WeaponServantCfg[arg_4_0.ID_].race)
	arg_4_0.rareController_:SetSelectedState(WeaponServantCfg[arg_4_0.ID_].starlevel)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.itemBtn_, nil, function()
		if arg_5_0.info_.isUnlock and arg_5_0.view_ == 0 then
			IllustratedAction.ViewIllustration(arg_5_0.ID_, CollectConst.SERVANT)
		end

		arg_5_0:Go("/showServantView", {
			stage = 5,
			state = "onlydetail",
			id = arg_5_0.ID_
		})
	end)
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
