class = var_0_10000

local var_0_0 = "YoumiyaStrongholdActPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_1.Find(var_1_0, "panel/go_btn")

	onButton = var_1_0

	local var_1_2 = arg_1_0
	local var_1_3 = var_1_1

	local function var_1_4()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_2_2 = var_2_10002.OPEN_LAYER

		Context = var_2_10003

		local var_2_3 = var_2_10003.New
		local var_2_4 = {}

		YoumiyaStrongholdMediator = var_2_10005
		var_2_4.mediator = var_2_10005
		YoumiyaStrongholdLayer = var_2_10005
		var_2_4.viewComponent = var_2_10005

		var_2_1(var_2_0, var_2_2, var_2_3(var_2_4))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_0(var_1_2, var_1_3, var_1_4, var_1_10006)

	setActive = var_1_0

	local var_1_5 = arg_1_0._tf
	local var_1_6 = var_3.Find(var_1_5, "panel/go_btn/tip")

	YoumiyaStrongholdLayer = var_1_5

	var_1_0(var_1_6, var_1_5.ShouldShowTip())

	for iter_1_0 = 1, 3 do
		setText = var_1_10006

		local var_1_7 = arg_1_0._tf
		local var_1_8 = var_7.Find
		local var_1_9 = "bg/"

		tostring = var_1_10010

		local var_1_10 = var_1_8(var_1_7, var_1_9 .. var_1_10010(iter_1_0) .. "/name")

		i18n = var_1_7

		var_1_10006(var_1_10, var_1_7("yumia_base_name_" .. iter_1_0))
	end

	setText = var_2

	local var_1_11 = arg_1_0._tf
	local var_1_12 = var_3.Find(var_1_11, "panel/go_btn/text")

	i18n = var_1_11

	var_2(var_1_12, var_1_11("yumia_stronghold_1"))

	return
end

return var_0_1
