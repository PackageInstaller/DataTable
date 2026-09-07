local IslandGameLimitLayer = class("IslandGameLimitLayer", import("view.base.BaseUI"))

IslandGameLimitLayer.limit_type_jiujiu = "IslandGameJiuJiuLimitUI"
IslandGameLimitLayer.limit_type_catch = "IslandGameCatchLimitUI"
IslandGameLimitLayer.limit_type_stone = "IslandGameStoneLimitUI"

local var_0_1 = "island_game_limit_help"
local var_0_2 = "island_game_limit_num"
local var_0_3 = "island_act_tips1"

function IslandGameLimitLayer:getUIName()
	return "IslandGameLimitUI"
end

function IslandGameLimitLayer:init()
	local var_2_0 = self.contextData.type or IslandGameLimitLayer.limit_type_jiujiu
	local var_2_1 = ActivityConst.ISLAND_GAME_ID

	self.itemConfig = Item.getConfigData(pg.activity_template[ActivityConst.ISLAND_GAME_ID].config_client.item_id)

	local var_2_2 = getProxy(MiniGameProxy):GetHubByHubId(pg.activity_template[var_2_1].config_id).count

	var_2_2 = var_2_2 or 0
	self.num = var_2_2
	self.dayLimit = pg.mini_game_hub[pg.activity_template[var_2_1].config_id].reborn_times
	self.allWindows = {}

	self:showWindow(var_2_0)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function IslandGameLimitLayer:showWindow(arg_3_1)
	if not self.allWindows[arg_3_1] then
		local var_3_0 = LoadAndInstantiateSync("ui", arg_3_1)

		self:prepareWindow(var_3_0)
		setParent(var_3_0, findTF(self._tf, "ad"))

		self.allWindows[arg_3_1] = var_3_0
	end

	for iter_3_0, iter_3_1 in pairs(self.allWindows) do
		setActive(iter_3_1, iter_3_0 == arg_3_1)
	end

	return
end

function IslandGameLimitLayer:prepareWindow(arg_4_1)
	onButton(self, findTF(arg_4_1, "ad"), function()
		self:closeView()

		return
	end, SFX_CANCEL)

	self.dropIcon = findTF(arg_4_1, "ad/icon/IconTpl")

	updateDrop(self.dropIcon, {
		id = self.itemConfig.id,
		type = DROP_TYPE_ITEM
	})
	setText(findTF(arg_4_1, "ad/name"), self.itemConfig.name)
	setText(findTF(arg_4_1, "ad/desc"), self.itemConfig.display)
	setText(findTF(arg_4_1, "ad/num"), i18n(var_0_2, self.num))
	setText(findTF(arg_4_1, "ad/help"), i18n(var_0_1, self.dayLimit))
	setText(findTF(arg_4_1, "ad/clickClose"), i18n(var_0_3))

	return
end

function IslandGameLimitLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return IslandGameLimitLayer
