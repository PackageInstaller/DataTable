class = var_0_10000

local var_0_0 = "ChapterChampionNormal"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".LevelCellData"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.row = arg_1_1.pos.row
	arg_1_0.column = arg_1_1.pos.column
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.attachmentId = arg_1_0.id
	arg_1_0.attachment = arg_1_1.attachment
	arg_1_0.flag = arg_1_1.flag
	arg_1_0.data = arg_1_1.data

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.expedition_data_template
end

function var_0_1.getPrefab(arg_3_0)
	return arg_3_0:getConfig("icon")
end

function var_0_1.getFleetType(arg_4_0)
	FleetType = var_1_10001

	return var_1_10001.Normal
end

function var_0_1.getPoolType(arg_5_0)
	if arg_5_0:getConfig("icon_type") == 1 then
		ChapterConst = var_5_0

		local var_5_0

		if not var_5_0.TemplateEnemy then
			ChapterConst = var_5_0
			var_5_0 = var_5_0.TemplateChampion
		end

		return var_5_0
	end
end

function var_0_1.getScale(arg_6_0)
	return arg_6_0:getConfig("scale")
end

function var_0_1.inAlertRange(arg_7_0, arg_7_1, arg_7_2)
	_ = var_1_10003

	return var_1_10003.any(arg_7_0:getConfig("alert_range"), function(arg_8_0)
		return arg_8_0[1] + arg_7_0.row == arg_7_1 and arg_8_0[2] + arg_7_0.column == arg_7_2
	end)
end

return var_0_1
