local var_0_0 = class("AcademyCourse", import(".BaseVO"))

var_0_0.MaxStudyTime = 43200

function var_0_0.Ctor(arg_1_0)
	arg_1_0.proficiency = 0

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.class_upgrade_group
end

function var_0_0.getConfig(arg_3_0, arg_3_1)
	return arg_3_0:bindConfigTable()[pg.TimeMgr.GetInstance():GetServerWeek()][arg_3_1]
end

function var_0_0.update(arg_4_0, arg_4_1)
	arg_4_0.proficiency = arg_4_1.proficiency

	return
end

function var_0_0.GetProficiency(arg_5_0)
	return arg_5_0.proficiency
end

function var_0_0.getExtraRate(arg_6_0)
	local var_6_0 = pg.TimeMgr.GetInstance()

	return var_6_0:GetServerWeek() == 7 and 2 or 1
end

function var_0_0.SetProficiency(arg_7_0, arg_7_1)
	arg_7_0.proficiency = arg_7_1

	return
end

return var_0_0
