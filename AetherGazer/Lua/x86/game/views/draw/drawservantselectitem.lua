local var_0_0 = class("DrawServantSelectItem", ReduxView)

local function var_0_1(arg_1_0)
	return DrawData:GetPollUpID(arg_1_0)
end

function var_0_0.OnCtor(arg_2_0, arg_2_1)
	arg_2_0.gameObject_ = arg_2_1
	arg_2_0.transform_ = arg_2_1.transform

	arg_2_0:Init()
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.chooseController = arg_4_0.controller_:GetController("choose")
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.id_ = arg_5_2
	arg_5_0.servantID_ = arg_5_3
	arg_5_0.nameText_.text = ""
	arg_5_0.suffixText_.text = ItemTools.getItemName(arg_5_3)
	arg_5_0.campImg_.sprite = HeroTools.GetRaceIcon(WeaponServantCfg[arg_5_0.servantID_].race)
	arg_5_0.groupbgImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/ServantUpSelect/" .. arg_5_0.id_)
end

function var_0_0.ShowSelect(arg_6_0, arg_6_1)
	if arg_6_1 == arg_6_0.id_ then
		arg_6_0.chooseController:SetSelectedState("true")
	else
		arg_6_0.chooseController:SetSelectedState("false")
	end
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.groupbgBtn_, nil, function()
		if arg_7_0.clickHandler_ then
			arg_7_0.clickHandler_(arg_7_0.id_)
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.lookBtn_, nil, function()
		if arg_7_0.servantID_ then
			arg_7_0:Go("/showServantView", {
				state = "onlydetail",
				id = arg_7_0.servantID_
			})
		end
	end)
end

function var_0_0.RegisterListener(arg_10_0, arg_10_1)
	arg_10_0.clickHandler_ = arg_10_1
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
