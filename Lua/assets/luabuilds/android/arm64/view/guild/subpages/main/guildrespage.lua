local var_0_0 = class("GuildResPage", import("....base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "GuildResPanel"
end

function var_0_0.Load(arg_2_0)
	if arg_2_0._state ~= var_0_0.STATES.NONE then
		return
	end

	arg_2_0._state = var_0_0.STATES.LOADING

	pg.UIMgr.GetInstance():LoadingOn()
	arg_2_0:Loaded((LoadAndInstantiateSync("UI", arg_2_0:getUIName(), true, false)))
	arg_2_0:Init()

	return
end

function var_0_0.OnLoaded(arg_3_0)
	arg_3_0.captailBg = arg_3_0._tf:Find("captail"):GetComponent(typeof(Image))
	arg_3_0.contributionBg = arg_3_0._tf:Find("contribution"):GetComponent(typeof(Image))
	arg_3_0.resCaptailTxt = arg_3_0._tf:Find("captail/Text"):GetComponent(typeof(Text))
	arg_3_0.resContributionTxt = arg_3_0._tf:Find("contribution/Text"):GetComponent(typeof(Text))
	arg_3_0.resourceLogBtn = arg_3_0._tf:Find("captail/log")

	setActive(arg_3_0._tf, true)

	return
end

function var_0_0.OnInit(arg_4_0)
	onButton(arg_4_0, arg_4_0.resourceLogBtn, function()
		arg_4_0:emit(GuildMainMediator.ON_FETCH_CAPITAL_LOG)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Update(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.resCaptailTxt.text = arg_6_2:getCapital()
	arg_6_0.resContributionTxt.text = arg_6_1:getResource(8)

	local var_6_0 = arg_6_2:getFaction()

	if arg_6_0.faction ~= var_6_0 then
		local var_6_1 = var_6_0 == GuildConst.FACTION_TYPE_BLHX and "blue" or "red"

		arg_6_0.contributionBg.sprite = GetSpriteFromAtlas("ui/GuildMainUI_atlas", "res_" .. (var_6_0 == GuildConst.FACTION_TYPE_BLHX and "blue" or "red"))
		arg_6_0.captailBg.sprite = GetSpriteFromAtlas("ui/GuildMainUI_atlas", "res_" .. var_6_1)
		arg_6_0.faction = var_6_0
	end

	return
end

function var_0_0.OnDestroy(arg_7_0)
	return
end

return var_0_0
