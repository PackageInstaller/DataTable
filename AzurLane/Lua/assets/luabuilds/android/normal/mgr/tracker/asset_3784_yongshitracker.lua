class = var_0_10000

local var_0_0 = var_0_10000("YongshiTracker")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.mapping = {}

	local var_1_0 = arg_1_0.mapping

	TRACKING_ROLE_CREATE = var_1_10002
	var_1_0[var_1_10002] = "role_create"

	local var_1_1 = arg_1_0.mapping

	TRACKING_ROLE_LOGIN = var_1_10002
	var_1_1[var_1_10002] = "role_login"

	local var_1_2 = arg_1_0.mapping

	TRACKING_TUTORIAL_COMPLETE_1 = var_1_10002
	var_1_2[var_1_10002] = "tutorial_complete_1"

	local var_1_3 = arg_1_0.mapping

	TRACKING_TUTORIAL_COMPLETE_2 = var_1_10002
	var_1_3[var_1_10002] = "tutorial_complete_2"

	local var_1_4 = arg_1_0.mapping

	TRACKING_TUTORIAL_COMPLETE_3 = var_1_10002
	var_1_4[var_1_10002] = "tutorial_complete_3"

	local var_1_5 = arg_1_0.mapping

	TRACKING_TUTORIAL_COMPLETE_4 = var_1_10002
	var_1_5[var_1_10002] = "tutorial_complete_4"

	local var_1_6 = arg_1_0.mapping

	TRACKING_USER_LEVELUP = var_1_10002
	var_1_6[var_1_10002] = "user_levelup"

	local var_1_7 = arg_1_0.mapping

	TRACKING_ROLE_LOGOUT = var_1_10002
	var_1_7[var_1_10002] = "role_logout"

	local var_1_8 = arg_1_0.mapping

	TRACKING_PURCHASE_FIRST = var_1_10002
	var_1_8[var_1_10002] = "purchase_first"

	local var_1_9 = arg_1_0.mapping

	TRACKING_PURCHASE_CLICK = var_1_10002
	var_1_9[var_1_10002] = "purchase_click"

	local var_1_10 = arg_1_0.mapping

	TRACKING_PURCHASE_CLICK_MONTHLYCARD = var_1_10002
	var_1_10[var_1_10002] = "purchase_click_monthlycard"

	local var_1_11 = arg_1_0.mapping

	TRACKING_PURCHASE_CLICK_GIFTBAG = var_1_10002
	var_1_11[var_1_10002] = "purchase_click_giftbag"

	local var_1_12 = arg_1_0.mapping

	TRACKING_PURCHASE_CLICK_DIAMOND = var_1_10002
	var_1_12[var_1_10002] = "purchase_click_diamond"

	local var_1_13 = arg_1_0.mapping

	TRACKING_2D_RETENTION = var_1_10002
	var_1_13[var_1_10002] = "2d_retention"

	local var_1_14 = arg_1_0.mapping

	TRACKING_7D_RETENTION = var_1_10002
	var_1_14[var_1_10002] = "7d_retention"

	return
end

function var_0_0.Tracking(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_0.mapping[arg_2_1] == nil then
		return
	end

	TRACKING_USER_LEVELUP = var_1_10005

	if arg_2_1 == var_1_10005 then
		originalPrint = var_1_10005

		var_1_10005("tracking lvl:" .. arg_2_3)

		YongshiUserEvent = var_1_10005

		local var_2_0 = var_1_10005.New(var_4)

		var_1_10005.AddParam(var_2_0, "lvl", arg_2_3)
		var_1_10005:AddParam("user_id", arg_2_2)

		pg = var_6

		local var_2_1 = var_6.SdkMgr.GetInstance()

		var_6.UserEventUpload(var_2_1, var_1_10005)

		goto label_2_0
	end

	TRACKING_PURCHASE_CLICK = var_1_10005

	if arg_2_1 == var_1_10005 then
		YongshiUserEvent = var_1_10005

		local var_2_2 = var_1_10005.New(var_4)

		var_1_10005.AddParam(var_2_2, "user_id", arg_2_2)

		pg = var_6

		local var_2_3 = var_6.SdkMgr.GetInstance()

		var_6.UserEventUpload(var_2_3, var_1_10005)

		goto label_2_0
	end

	TRACKING_PURCHASE_FIRST = var_1_10005

	if arg_2_1 == var_1_10005 then
		originalPrint = var_1_10005

		var_1_10005("order id : " .. arg_2_3)

		YongshiUserEvent = var_1_10005

		local var_2_4 = var_1_10005.New(var_4)

		var_1_10005.AddParam(var_2_4, "user_id", arg_2_2)
		var_1_10005:AddParam("order_id", arg_2_3)

		pg = var_6

		local var_2_5 = var_6.SdkMgr.GetInstance()

		var_6.UserEventUpload(var_2_5, var_1_10005)

		goto label_2_0
	end

	TRACKING_2D_RETENTION = var_1_10005

	if arg_2_1 ~= var_1_10005 then
		TRACKING_7D_RETENTION = var_1_10005

		if arg_2_1 == var_1_10005 then
			YongshiUserEvent = var_1_10005

			local var_2_6 = var_1_10005.New(var_4)

			var_1_10005.AddParam(var_2_6, "user_id", arg_2_2)

			pg = var_6

			local var_2_7 = var_6.SdkMgr.GetInstance()

			var_6.UserEventUpload(var_2_7, var_1_10005)
		else
			TRACKING_ROLE_LOGIN = var_1_10005

			if arg_2_1 == var_1_10005 then
				YongshiUserEvent = var_1_10005

				local var_2_8 = var_1_10005.New(var_4)

				var_1_10005.AddParam(var_2_8, "user_id", arg_2_2)

				local var_2_9 = var_1_10005
				local var_2_10 = var_1_10005.AddParam
				local var_2_11 = "airi_uid"

				pg = var_9

				var_2_10(var_2_9, var_2_11, var_9.SdkMgr.GetInstance().airi_uid)

				pg = var_2_10

				local var_2_12 = var_2_10.SdkMgr.GetInstance()

				var_6.UserEventUpload(var_2_12, var_1_10005)
			else
				YongshiUserEvent = var_1_10005

				local var_2_13 = var_1_10005.New(var_4)

				var_5.AddParam(var_2_13, "user_id", arg_2_2)

				pg = var_6

				local var_2_14 = var_6.SdkMgr.GetInstance()

				var_6.UserEventUpload(var_2_14, var_5)
			end
		end

		::label_2_0::

		return
	end
end

return var_0_0
