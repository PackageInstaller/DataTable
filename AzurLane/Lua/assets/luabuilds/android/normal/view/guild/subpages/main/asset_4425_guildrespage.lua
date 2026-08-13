class = var_0_10000

local var_0_0 = "GuildResPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "GuildResPanel"
end

function var_0_1.Load(arg_2_0)
	if arg_2_0._state ~= var_0_1.STATES.NONE then
		return
	end

	arg_2_0._state = var_0_1.STATES.LOADING
	pg = var_1

	local var_2_0 = var_1.UIMgr.GetInstance()

	var_1.LoadingOn(var_2_0)

	LoadAndInstantiateSync = var_1

	local var_2_1 = var_1("UI", arg_2_0:getUIName(), true, false)

	arg_2_0:Loaded(var_2_1)
	arg_2_0:Init()

	return
end

function var_0_1.OnLoaded(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "captail")
	local var_3_2 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_3_0.captailBg = var_3_2(var_3_1, var_3(var_1_10004))

	local var_3_3 = arg_3_0._tf
	local var_3_4 = var_1.Find(var_3_3, "contribution")
	local var_3_5 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_3_0.contributionBg = var_3_5(var_3_4, var_3(var_1_10004))

	local var_3_6 = arg_3_0._tf
	local var_3_7 = var_1.Find(var_3_6, "captail/Text")
	local var_3_8 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_3_0.resCaptailTxt = var_3_8(var_3_7, var_3(var_1_10004))

	local var_3_9 = arg_3_0._tf
	local var_3_10 = var_1.Find(var_3_9, "contribution/Text")
	local var_3_11 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_3_0.resContributionTxt = var_3_11(var_3_10, var_3(var_1_10004))

	local var_3_12 = arg_3_0._tf

	arg_3_0.resourceLogBtn = var_1.Find(var_3_12, "captail/log")
	setActive = var_1

	var_1(arg_3_0._tf, true)

	return
end

function var_0_1.OnInit(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.resourceLogBtn

	local function var_4_2()
		local var_5_0 = arg_4_0
		local var_5_1 = var_0.emit

		GuildMainMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.ON_FETCH_CAPITAL_LOG)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10005)

	return
end

function var_0_1.Update(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.resCaptailTxt.text = arg_6_2:getCapital()
	arg_6_0.resContributionTxt.text = arg_6_1:getResource(8)

	local var_6_0 = arg_6_2:getFaction()

	if arg_6_0.faction ~= var_6_0 then
		GuildConst = var_4

		local var_6_1 = var_6_0 == var_4.FACTION_TYPE_BLHX and "blue" or "red"
		local var_6_2 = arg_6_0.contributionBg

		GetSpriteFromAtlas = var_6
		var_6_2.sprite = var_6("ui/GuildMainUI_atlas", "res_" .. var_6_1)

		local var_6_3 = arg_6_0.captailBg

		GetSpriteFromAtlas = var_6
		var_6_3.sprite = var_6("ui/GuildMainUI_atlas", "res_" .. var_6_1)
		arg_6_0.faction = var_6_0
	end

	return
end

function var_0_1.OnDestroy(arg_7_0)
	return
end

return var_0_1
