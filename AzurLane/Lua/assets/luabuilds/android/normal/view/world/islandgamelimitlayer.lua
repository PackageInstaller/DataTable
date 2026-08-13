class = var_0_10000

local var_0_0 = "IslandGameLimitLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.limit_type_jiujiu = "IslandGameJiuJiuLimitUI"
var_0_1.limit_type_catch = "IslandGameCatchLimitUI"
var_0_1.limit_type_stone = "IslandGameStoneLimitUI"

local var_0_2 = "island_game_limit_help"
local var_0_3 = "island_game_limit_num"
local var_0_4 = "island_act_tips1"

function var_0_1.getUIName(arg_1_0)
	return "IslandGameLimitUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0

	if not arg_2_0.contextData.type then
		IslandGameLimitLayer = var_2_0
		var_2_0 = var_2_0.limit_type_jiujiu
	end

	ActivityConst = var_1_10002

	local var_2_1 = var_1_10002.ISLAND_GAME_ID

	pg = var_1_10003

	local var_2_2 = var_1_10003.activity_template[var_2_1].config_client.item_id

	Item = var_1_10004
	arg_2_0.itemConfig = var_1_10004.getConfigData(var_2_2)
	pg = var_4

	local var_2_3 = var_4.activity_template[var_2_1].config_id

	getProxy = var_5
	MiniGameProxy = var_1_10006

	local var_2_4 = var_5(var_1_10006)
	local var_2_5

	if not var_5.GetHubByHubId(var_2_4, var_2_3).count then
		var_2_5 = 0
	end

	arg_2_0.num = var_2_5
	pg = var_2_5
	arg_2_0.dayLimit = var_2_5.mini_game_hub[var_2_3].reborn_times
	arg_2_0.allWindows = {}

	arg_2_0:showWindow(var_2_0)

	pg = var_5

	local var_2_6 = var_5.UIMgr.GetInstance()

	var_5.BlurPanel(var_2_6, arg_2_0._tf)

	return
end

function var_0_1.showWindow(arg_3_0, arg_3_1)
	local var_3_0

	if not arg_3_0.allWindows[arg_3_1] then
		LoadAndInstantiateSync = var_3_0
		var_3_0 = var_3_0("ui", arg_3_1)

		arg_3_0:prepareWindow(var_3_0)

		setParent = var_3

		local var_3_1 = var_3_0

		findTF = var_5

		var_3(var_3_1, var_5(arg_3_0._tf, "ad"))

		arg_3_0.allWindows[arg_3_1] = var_3_0
	end

	pairs = var_3_0

	for iter_3_0, iter_3_1 in var_3_0(arg_3_0.allWindows) do
		setActive = var_1_10007

		var_1_10007(iter_3_1, iter_3_0 == arg_3_1)
	end

	return
end

function var_0_1.prepareWindow(arg_4_0, arg_4_1)
	onButton = var_1_10002

	local var_4_0 = arg_4_0

	findTF = var_1_10004

	local var_4_1 = var_1_10004(arg_4_1, "ad")

	local function var_4_2()
		local var_5_0 = arg_4_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_CANCEL = var_6

	var_1_10002(var_4_0, var_4_1, var_4_2, var_6)

	findTF = var_1_10002
	arg_4_0.dropIcon = var_1_10002(arg_4_1, "ad/icon/IconTpl")
	updateDrop = var_2

	local var_4_3 = arg_4_0.dropIcon
	local var_4_4 = {
		id = arg_4_0.itemConfig.id
	}

	DROP_TYPE_ITEM = var_5
	var_4_4.type = var_5

	var_2(var_4_3, var_4_4)

	setText = var_2
	findTF = var_4_3

	var_2(var_4_3(arg_4_1, "ad/name"), arg_4_0.itemConfig.name)

	setText = var_2
	findTF = var_3

	var_2(var_3(arg_4_1, "ad/desc"), arg_4_0.itemConfig.display)

	setText = var_2
	findTF = var_3

	local var_4_5 = var_3(arg_4_1, "ad/num")

	i18n = var_4

	var_2(var_4_5, var_4(var_0_3, arg_4_0.num))

	setText = var_2
	findTF = var_4_5

	local var_4_6 = var_4_5(arg_4_1, "ad/help")

	i18n = var_4

	var_2(var_4_6, var_4(var_0_2, arg_4_0.dayLimit))

	setText = var_2
	findTF = var_4_6

	local var_4_7 = var_4_6(arg_4_1, "ad/clickClose")

	i18n = var_4

	var_2(var_4_7, var_4(var_0_4))

	return
end

function var_0_1.willExit(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_6_0, arg_6_0._tf)

	return
end

return var_0_1
