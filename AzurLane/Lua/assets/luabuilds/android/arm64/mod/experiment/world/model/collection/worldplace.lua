local var_0_0 = class("WorldPlace")
local var_0_1 = {
	i18n1("碧蓝"),
	i18n1("铁血"),
	i18n1("塞壬")
}
local var_0_2 = pg.world_collection_place_template

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.number = arg_1_1.number or 0
	arg_1_0.unlock = false
	arg_1_0.config = var_0_2[arg_1_0.configId]

	assert(arg_1_0.config)

	return
end

function var_0_0.setUnlock(arg_2_0, arg_2_1)
	arg_2_0.unlock = arg_2_1

	return
end

function var_0_0.isUnlock(arg_3_0)
	return arg_3_0.unlock
end

function var_0_0.getNumber(arg_4_0)
	return arg_4_0.number
end

function var_0_0.getDesc(arg_5_0)
	if arg_5_0:isUnlock() then
		return arg_5_0.config.description_known
	else
		return arg_5_0.config.description_unknown
	end

	return
end

function var_0_0.getCamp(arg_6_0)
	return var_0_1[tonumber(arg_6_0.config.type)]
end

function var_0_0.getName(arg_7_0)
	if arg_7_0:isUnlock() then
		return arg_7_0.config.name
	else
		return arg_7_0.config.name_unknown
	end

	return
end

function var_0_0.getIconPath(arg_8_0)
	if arg_8_0:isUnlock() then
		return "shipYardIcon/abeikelongbi"
	else
		return "shipYardIcon/unknown"
	end

	return
end

function var_0_0.getFullViewImg(arg_9_0)
	return "levelmap/map_1"
end

return var_0_0
