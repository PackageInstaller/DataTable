local var_0_0 = {
	PAGE = {
		EQUIPMENT = 2,
		DETAIL = 1,
		INTENSIFY = 3,
		CORE = 7,
		UPGRADE = 4,
		REMOULD = 6,
		FASHION = 5
	}
}

var_0_0.currentPage = nil
var_0_0.SUB_VIEW_PAGE = {
	var_0_0.PAGE.DETAIL,
	var_0_0.PAGE.EQUIPMENT,
	var_0_0.PAGE.INTENSIFY,
	var_0_0.PAGE.UPGRADE,
	var_0_0.PAGE.FASHION
}
var_0_0.SUB_LAYER_PAGE = {
	var_0_0.PAGE.REMOULD,
	var_0_0.PAGE.CORE
}

function var_0_0.IsSubLayerPage(arg_1_0)
	return table.contains(var_0_0.SUB_LAYER_PAGE, arg_1_0)
end

var_0_0.SWITCH_TO_PAGE = "ShipViewConst.switch_to_page"
var_0_0.LOAD_PAINTING = "ShipViewConst.load_painting"
var_0_0.LOAD_PAINTING_BG = "ShipViewConst.load_painting_bg"
var_0_0.HIDE_SHIP_WORD = "ShipViewConst.hide_ship_word"
var_0_0.SET_CLICK_ENABLE = "ShipViewConst.set_click_enable"
var_0_0.SHOW_CUSTOM_MSG = "ShipViewConst.show_custom_msg"
var_0_0.HIDE_CUSTOM_MSG = "ShipViewConst.hide_custom_msg"
var_0_0.DISPLAY_HUNTING_RANGE = "ShipViewConst.display_hunting_range"
var_0_0.PAINT_VIEW = "ShipViewConst.paint_view"
var_0_0.SHOW_EXP_ITEM_USAGE = "ShipViewConst.SHOW_EXP_ITEM_USAGE"

return var_0_0
