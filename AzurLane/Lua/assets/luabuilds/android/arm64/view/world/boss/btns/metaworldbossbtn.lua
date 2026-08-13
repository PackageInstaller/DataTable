class = var_0_10000

local var_0_0 = var_0_10000("MetaWorldbossBtn")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg = var_1_10003

	var_1_10003.DelegateInfo.New(arg_1_0)

	arg_1_0.event = arg_1_2
	arg_1_0.metaBtn = arg_1_1

	local var_1_0 = arg_1_1:Find("Text")
	local var_1_1 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.metaProgress = var_1_1(var_1_0, var_6(var_1_10008))
	arg_1_0.metaTip = arg_1_1:Find("tip")

	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.metaBtn

	local function var_2_2()
		WorldBossConst = var_2_10000

		local var_3_0 = var_2_10000.GetCurrBossGroup()
		local var_3_1 = arg_2_0.event
		local var_3_2 = var_1.emit

		WorldBossMediator = var_2_10004

		var_3_2(var_3_1, var_2_10004.GO_META, var_3_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10006)
	arg_2_0:Update()

	return
end

function var_0_0.Update(arg_4_0)
	WorldBossConst = var_1_10001

	local var_4_0 = var_1_10001.GetCurrBossGroup()

	setActive = var_1_10002

	local var_4_1 = arg_4_0.metaTip

	MetaCharacterConst = var_1_10005

	var_1_10002(var_4_1, var_1_10005.isMetaSynRedTag(var_4_0))

	return
end

function var_0_0.Dispose(arg_5_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_5_0)

	return
end

return var_0_0
