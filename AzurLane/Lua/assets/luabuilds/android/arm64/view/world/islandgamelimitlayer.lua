local var_0_0 = class("IslandGameLimitLayer", import("view.base.BaseUI"))

var_0_0.limit_type_jiujiu = "IslandGameJiuJiuLimitUI"
var_0_0.limit_type_catch = "IslandGameCatchLimitUI"
var_0_0.limit_type_stone = "IslandGameStoneLimitUI"

local var_0_1 = "island_game_limit_help"
local var_0_2 = "island_game_limit_num"
local var_0_3 = "island_act_tips1"

function var_0_0.getUIName(arg_1_0)
	return "IslandGameLimitUI"
end

function var_0_0.init(arg_2_0)
	local var_2_0 = arg_2_0.contextData.type or IslandGameLimitLayer.limit_type_jiujiu
	local var_2_1 = ActivityConst.ISLAND_GAME_ID

	arg_2_0.itemConfig = Item.getConfigData(pg.activity_template[ActivityConst.ISLAND_GAME_ID].config_client.item_id)

	local var_2_2 = getProxy(MiniGameProxy):GetHubByHubId(pg.activity_template[var_2_1].config_id).count

	var_2_2 = var_2_2 or 0
	arg_2_0.num = var_2_2
	arg_2_0.dayLimit = pg.mini_game_hub[pg.activity_template[var_2_1].config_id].reborn_times
	arg_2_0.allWindows = {}

	arg_2_0:showWindow(var_2_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)

	return
end

function var_0_0.showWindow(arg_3_0, arg_3_1)
	if not arg_3_0.allWindows[arg_3_1] then
		local var_3_0 = LoadAndInstantiateSync("ui", arg_3_1)

		arg_3_0:prepareWindow(var_3_0)
		setParent(var_3_0, findTF(arg_3_0._tf, "ad"))

		arg_3_0.allWindows[arg_3_1] = var_3_0
	end

	for iter_3_0, iter_3_1 in pairs(arg_3_0.allWindows) do
		setActive(iter_3_1, iter_3_0 == arg_3_1)
	end

	return
end

function var_0_0.prepareWindow(arg_4_0, arg_4_1)
	onButton(arg_4_0, findTF(arg_4_1, "ad"), function()
		arg_4_0:closeView()

		return
	end, SFX_CANCEL)

	arg_4_0.dropIcon = findTF(arg_4_1, "ad/icon/IconTpl")

	updateDrop(arg_4_0.dropIcon, {
		id = arg_4_0.itemConfig.id,
		type = DROP_TYPE_ITEM
	})
	setText(findTF(arg_4_1, "ad/name"), arg_4_0.itemConfig.name)
	setText(findTF(arg_4_1, "ad/desc"), arg_4_0.itemConfig.display)
	setText(findTF(arg_4_1, "ad/num"), i18n(var_0_2, arg_4_0.num))
	setText(findTF(arg_4_1, "ad/help"), i18n(var_0_1, arg_4_0.dayLimit))
	setText(findTF(arg_4_1, "ad/clickClose"), i18n(var_0_3))

	return
end

function var_0_0.willExit(arg_6_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_6_0._tf)

	return
end

return var_0_0
