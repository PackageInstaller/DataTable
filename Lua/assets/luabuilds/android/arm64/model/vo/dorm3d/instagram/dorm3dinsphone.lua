local var_0_0 = class("Dorm3dInsPhone", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_1
	arg_1_0.isLock = true

	return
end

function var_0_0.ExtendsData(arg_2_0, arg_2_1)
	arg_2_0.time = arg_2_1.time
	arg_2_0.isRead = arg_2_1.read_flag == 1
	arg_2_0.isLock = false

	return
end

function var_0_0.Unlock(arg_3_0, arg_3_1)
	arg_3_0.time = arg_3_1
	arg_3_0.isRead = false
	arg_3_0.isLock = false

	return
end

function var_0_0.MarkRead(arg_4_0)
	arg_4_0.isRead = true

	return
end

function var_0_0.bindConfigTable(arg_5_0)
	return pg.dorm3d_ins_telephone_group
end

function var_0_0.ShouldTip(arg_6_0)
	return not arg_6_0.isLock and not arg_6_0.isRead
end

function var_0_0.IsLock(arg_7_0)
	return arg_7_0.isLock
end

function var_0_0.GetName(arg_8_0)
	return arg_8_0:getConfig("name")
end

function var_0_0.GetDesc(arg_9_0)
	return arg_9_0:getConfig("unlock_desc")
end

function var_0_0.GetContent(arg_10_0)
	return arg_10_0:getConfig("content")
end

function var_0_0.GetVideoData(arg_11_0)
	return {
		roomId = arg_11_0:GetContent()[1],
		groupIds = {
			arg_11_0:getConfig("ship_group")
		},
		specialId = arg_11_0:GetContent()[2]
	}
end

function var_0_0.GetType(arg_12_0)
	return arg_12_0:getConfig("type")
end

function var_0_0.GetDay(arg_13_0)
	local var_13_0 = math.floor((pg.TimeMgr.GetInstance():GetServerTime() - arg_13_0.time) / 0)

	return var_13_0 == 0 and i18n("dorm3d_privatechat_visit_time_now") or i18n("dorm3d_privatechat_visit_time", var_13_0)
end

return var_0_0
