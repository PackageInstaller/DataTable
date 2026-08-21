local var_0_0 = class("BackYardConst")

var_0_0.MAX_FLOOR_CNT = 2
var_0_0.SAME_ID_MODIFY_ID = 24
var_0_0.MAX_UPLOAD_THEME_CNT = 2
var_0_0.THEME_TEMPLATE_TYPE_SHOP = 1
var_0_0.THEME_TEMPLATE_TYPE_CUSTOM = 2
var_0_0.THEME_TEMPLATE_TYPE_COLLECTION = 3
var_0_0.THEME_TEMPLATE_USAGE_TYPE_SELF = 1
var_0_0.THEME_TEMPLATE_USAGE_TYPE_OTHER = 2
var_0_0.THEME_TEMPLATE_SHOP_REFRSH_CNT = 6
var_0_0.MAX_COLLECTION_CNT = 30
var_0_0.AUTO_REFRESH_THEME_TEMPLATE_TIME = 10
var_0_0.MANUAL_REFRESH_THEME_TEMPLATE_TIME = 10
var_0_0.DEBUG_THEME = true
var_0_0.MAX_USER_THEME = 5
var_0_0.DORM_UPDATE_TYPE_UPDATEFOOD = 2
var_0_0.DORM_UPDATE_TYPE_SHIP = 4
var_0_0.DORM_UPDATE_TYPE_NAME = 8
var_0_0.DORM_UPDATE_TYPE_LEVEL = 16
var_0_0.DORM_UPDATE_TYPE_FLOOR = 32
var_0_0.DORM_UPDATE_TYPE_FURNITURE = 64
var_0_0.DORM_UPDATE_TYPE_USEFOOD = 128
var_0_0.DORM_UPDATE_TYPE_EXTENDFOOD = 256
var_0_0.TIME_TYPE_ALL = 0
var_0_0.TIME_TYPE_WEEK = 1
var_0_0.TIME_TYPE_MONTH = 2
var_0_0.TIME_TYPE_YEAR = 3
var_0_0.MAX_MAP_SIZE = Vector2(23, 23)
var_0_0.MAX_FEAST_MAP_SIZE = Vector2(25, 25)

function var_0_0.ThemeSortIndex2ServerIndex(arg_1_0, arg_1_1)
	arg_1_1 = defaultValue(arg_1_1, true)
	arg_1_0 = defaultValue(arg_1_0, 1)

	if arg_1_0 == 1 then
		return 5
	elseif arg_1_0 == 2 and arg_1_1 then
		return 1
	elseif arg_1_0 == 2 and not arg_1_1 then
		return 2
	elseif arg_1_0 == 3 and arg_1_1 then
		return 4
	elseif arg_1_0 == 3 and not arg_1_1 then
		return 3
	end

	return
end

function var_0_0.ServerIndex2ThemeSortIndex(arg_2_0)
	if arg_2_0 == 5 then
		return 1, true
	elseif arg_2_0 == 4 then
		return 3, true
	elseif arg_2_0 == 3 then
		return 3, false
	elseif arg_2_0 == 2 then
		return 2, false
	elseif arg_2_0 == 1 then
		return 2, true
	end

	return
end

return var_0_0
