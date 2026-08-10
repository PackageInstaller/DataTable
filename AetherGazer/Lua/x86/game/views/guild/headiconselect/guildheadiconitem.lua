local var_0_0 = class("GuildHeadIconItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.id_ = arg_1_3

	local var_1_0 = ClubHeadIconCfg[arg_1_3]

	arg_1_0.imageIcon_.sprite = getSpriteViaConfig("ClubHeadIcon", var_1_0.iconName)
	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "name")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.transform_ = nil
	arg_2_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		manager.notify:Invoke(GUILD_SELECT_HEAD_ICON, arg_3_0.id_)
	end)
end

function var_0_0.SetSelect(arg_5_0, arg_5_1)
	if arg_5_1 then
		arg_5_0.controller_:SetSelectedState("true")
	else
		arg_5_0.controller_:SetSelectedState("false")
	end
end

return var_0_0
