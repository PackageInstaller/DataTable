local YongshiTracker = class("YongshiTracker")

function YongshiTracker:Ctor()
	self.mapping = {}
	self.mapping[TRACKING_ROLE_CREATE] = "role_create"
	self.mapping[TRACKING_ROLE_LOGIN] = "role_login"
	self.mapping[TRACKING_TUTORIAL_COMPLETE_1] = "tutorial_complete_1"
	self.mapping[TRACKING_TUTORIAL_COMPLETE_2] = "tutorial_complete_2"
	self.mapping[TRACKING_TUTORIAL_COMPLETE_3] = "tutorial_complete_3"
	self.mapping[TRACKING_TUTORIAL_COMPLETE_4] = "tutorial_complete_4"
	self.mapping[TRACKING_USER_LEVELUP] = "user_levelup"
	self.mapping[TRACKING_ROLE_LOGOUT] = "role_logout"
	self.mapping[TRACKING_PURCHASE_FIRST] = "purchase_first"
	self.mapping[TRACKING_PURCHASE_CLICK] = "purchase_click"
	self.mapping[TRACKING_PURCHASE_CLICK_MONTHLYCARD] = "purchase_click_monthlycard"
	self.mapping[TRACKING_PURCHASE_CLICK_GIFTBAG] = "purchase_click_giftbag"
	self.mapping[TRACKING_PURCHASE_CLICK_DIAMOND] = "purchase_click_diamond"
	self.mapping[TRACKING_2D_RETENTION] = "2d_retention"
	self.mapping[TRACKING_7D_RETENTION] = "7d_retention"

	return
end

function YongshiTracker:Tracking(arg_2_1, arg_2_2, arg_2_3)
	if self.mapping[arg_2_1] == nil then
		return
	end

	if arg_2_1 == TRACKING_USER_LEVELUP then
		originalPrint("tracking lvl:" .. arg_2_3)

		local var_2_0 = YongshiUserEvent.New(self.mapping[arg_2_1])

		var_2_0:AddParam("lvl", arg_2_3)
		var_2_0:AddParam("user_id", arg_2_2)
		pg.SdkMgr.GetInstance():UserEventUpload(var_2_0)
	elseif arg_2_1 == TRACKING_PURCHASE_CLICK then
		local var_2_1 = YongshiUserEvent.New(self.mapping[arg_2_1])

		var_2_1:AddParam("user_id", arg_2_2)
		pg.SdkMgr.GetInstance():UserEventUpload(var_2_1)
	elseif arg_2_1 == TRACKING_PURCHASE_FIRST then
		originalPrint("order id : " .. arg_2_3)

		local var_2_2 = YongshiUserEvent.New(self.mapping[arg_2_1])

		var_2_2:AddParam("user_id", arg_2_2)
		var_2_2:AddParam("order_id", arg_2_3)
		pg.SdkMgr.GetInstance():UserEventUpload(var_2_2)
	elseif arg_2_1 == TRACKING_2D_RETENTION or arg_2_1 == TRACKING_7D_RETENTION then
		local var_2_3 = YongshiUserEvent.New(self.mapping[arg_2_1])

		var_2_3:AddParam("user_id", arg_2_2)
		pg.SdkMgr.GetInstance():UserEventUpload(var_2_3)
	elseif arg_2_1 == TRACKING_ROLE_LOGIN then
		local var_2_4 = YongshiUserEvent.New(self.mapping[arg_2_1])

		var_2_4:AddParam("user_id", arg_2_2)
		var_2_4:AddParam("airi_uid", pg.SdkMgr.GetInstance().airi_uid)
		pg.SdkMgr.GetInstance():UserEventUpload(var_2_4)
	else
		local var_2_5 = YongshiUserEvent.New(self.mapping[arg_2_1])

		var_2_5:AddParam("user_id", arg_2_2)
		pg.SdkMgr.GetInstance():UserEventUpload(var_2_5)
	end

	return
end

return YongshiTracker
