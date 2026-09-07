local BackYardConst = class("BackYardConst")

BackYardConst.MAX_FLOOR_CNT = 2
BackYardConst.SAME_ID_MODIFY_ID = 24
BackYardConst.MAX_UPLOAD_THEME_CNT = 2
BackYardConst.THEME_TEMPLATE_TYPE_SHOP = 1
BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM = 2
BackYardConst.THEME_TEMPLATE_TYPE_COLLECTION = 3
BackYardConst.THEME_TEMPLATE_USAGE_TYPE_SELF = 1
BackYardConst.THEME_TEMPLATE_USAGE_TYPE_OTHER = 2
BackYardConst.THEME_TEMPLATE_SHOP_REFRSH_CNT = 6
BackYardConst.MAX_COLLECTION_CNT = 30
BackYardConst.AUTO_REFRESH_THEME_TEMPLATE_TIME = 10
BackYardConst.MANUAL_REFRESH_THEME_TEMPLATE_TIME = 10
BackYardConst.DEBUG_THEME = true
BackYardConst.MAX_USER_THEME = 5
BackYardConst.DORM_UPDATE_TYPE_UPDATEFOOD = 2
BackYardConst.DORM_UPDATE_TYPE_SHIP = 4
BackYardConst.DORM_UPDATE_TYPE_NAME = 8
BackYardConst.DORM_UPDATE_TYPE_LEVEL = 16
BackYardConst.DORM_UPDATE_TYPE_FLOOR = 32
BackYardConst.DORM_UPDATE_TYPE_FURNITURE = 64
BackYardConst.DORM_UPDATE_TYPE_USEFOOD = 128
BackYardConst.DORM_UPDATE_TYPE_EXTENDFOOD = 256
BackYardConst.TIME_TYPE_ALL = 0
BackYardConst.TIME_TYPE_WEEK = 1
BackYardConst.TIME_TYPE_MONTH = 2
BackYardConst.TIME_TYPE_YEAR = 3
BackYardConst.MAX_MAP_SIZE = Vector2(23, 23)
BackYardConst.MAX_FEAST_MAP_SIZE = Vector2(25, 25)

function BackYardConst:ThemeSortIndex2ServerIndex(arg_1_1)
	arg_1_1 = defaultValue(arg_1_1, true)
	self = defaultValue(self, 1)

	if self == 1 then
		return 5
	elseif self == 2 and arg_1_1 then
		return 1
	elseif self == 2 and not arg_1_1 then
		return 2
	elseif self == 3 and arg_1_1 then
		return 4
	elseif self == 3 and not arg_1_1 then
		return 3
	end

	return
end

function BackYardConst:ServerIndex2ThemeSortIndex()
	if self == 5 then
		return 1, true
	elseif self == 4 then
		return 3, true
	elseif self == 3 then
		return 3, false
	elseif self == 2 then
		return 2, false
	elseif self == 1 then
		return 2, true
	end

	return
end

return BackYardConst
