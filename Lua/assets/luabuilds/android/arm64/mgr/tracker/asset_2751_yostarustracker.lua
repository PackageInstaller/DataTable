local AiriUSTracker = class("AiriUSTracker")

AiriUSTracker.DEV_TOKEN = "2KtJzaeLzGnPUhtOY4-LYw"
AiriUSTracker.ANDROID_LINK_ID = "DE31AE06D3CE21EE3A9E1A1BCEB506E1"
AiriUSTracker.IOS_LINK_ID = "F7FE029D3F957A107D358D2BB93CA7E2"

function AiriUSTracker:Ctor()
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
	self.mapping[TRACKING_PURCHASE] = "purchase"
	self.mapping[TRACKING_2D_RETENTION] = "2d_retention"
	self.mapping[TRACKING_7D_RETENTION] = "7d_retention"

	return
end

function AiriUSTracker:Tracking(arg_2_1, arg_2_2, arg_2_3)
	if self.mapping[arg_2_1] == nil then
		return
	end

	if arg_2_1 == TRACKING_USER_LEVELUP then
		originalPrint("tracking lvl:" .. arg_2_3)

		local var_2_0 = YoStarUserEvent.New(self.mapping[arg_2_1])

		var_2_0:AddParam("lvl", arg_2_3)
		var_2_0:AddParam("user_id", arg_2_2)
		pg.SdkMgr.GetInstance():UserEventUpload(var_2_0)
	elseif arg_2_1 == TRACKING_PURCHASE_CLICK then
		local var_2_1 = YoStarUserEvent.New(self.mapping[arg_2_1])

		var_2_1:AddParam("user_id", arg_2_2)
		pg.SdkMgr.GetInstance():UserEventUpload(var_2_1)
	elseif arg_2_1 == TRACKING_PURCHASE_FIRST then
		originalPrint("order id : " .. arg_2_3)

		local var_2_2 = YoStarUserEvent.New(self.mapping[arg_2_1])

		var_2_2:AddParam("user_id", arg_2_2)
		var_2_2:AddParam("order_id", arg_2_3)
		pg.SdkMgr.GetInstance():UserEventUpload(var_2_2)
	elseif arg_2_1 == TRACKING_2D_RETENTION or arg_2_1 == TRACKING_7D_RETENTION then
		local var_2_3 = YoStarUserEvent.New(self.mapping[arg_2_1])

		var_2_3:AddParam("user_id", arg_2_2)
		pg.SdkMgr.GetInstance():UserEventUpload(var_2_3)
	elseif arg_2_1 ~= TRACKING_PURCHASE then
		local var_2_4 = YoStarUserEvent.New(self.mapping[arg_2_1])

		var_2_4:AddParam("user_id", arg_2_2)
		pg.SdkMgr.GetInstance():UserEventUpload(var_2_4)
	end

	if pg.SdkMgr.GetInstance():GetChannelUID() == "0" then
		if arg_2_1 == TRACKING_PURCHASE_CLICK then
			self:YS_S2S(AiriUSTracker.DEV_TOKEN, "DE31AE06D3CE21EE3A9E1A1BCEB506E1", "Azur Lane (Android) S2S_purchase_click", "", tostring((self:transMoney(pg.pay_data_display[arg_2_3].money))), pg.SdkMgr.GetInstance():GetDeviceId(), tostring(pg.TimeMgr.GetInstance():GetServerTime()))
		elseif arg_2_1 == TRACKING_PURCHASE_CLICK_MONTHLYCARD then
			self:YS_S2S(AiriUSTracker.DEV_TOKEN, "DE31AE06D3CE21EE3A9E1A1BCEB506E1", "Azur Lane (Android) S2S_purchase_click_monthlycard", "", tostring((self:transMoney(pg.pay_data_display[arg_2_3].money))), pg.SdkMgr.GetInstance():GetDeviceId(), tostring(pg.TimeMgr.GetInstance():GetServerTime()))
		elseif arg_2_1 == TRACKING_PURCHASE_CLICK_DIAMOND then
			self:YS_S2S(AiriUSTracker.DEV_TOKEN, "DE31AE06D3CE21EE3A9E1A1BCEB506E1", "Azur Lane (Android) S2S_purchase_click_diamond", "", tostring((self:transMoney(pg.pay_data_display[arg_2_3].money))), pg.SdkMgr.GetInstance():GetDeviceId(), tostring(pg.TimeMgr.GetInstance():GetServerTime()))
		elseif arg_2_1 == TRACKING_PURCHASE_CLICK_GIFTBAG then
			self:YS_S2S(AiriUSTracker.DEV_TOKEN, "DE31AE06D3CE21EE3A9E1A1BCEB506E1", "Azur Lane (Android) S2S_purchase_click_giftbag", "", tostring((self:transMoney(pg.pay_data_display[arg_2_3].money))), pg.SdkMgr.GetInstance():GetDeviceId(), tostring(pg.TimeMgr.GetInstance():GetServerTime()))
		elseif arg_2_1 == TRACKING_PURCHASE then
			self:YS_S2S(AiriUSTracker.DEV_TOKEN, "DE31AE06D3CE21EE3A9E1A1BCEB506E1", "Azur Lane (Android) S2S_purchase", "", tostring((self:transMoney(pg.pay_data_display[arg_2_3].money))), pg.SdkMgr.GetInstance():GetDeviceId(), tostring(pg.TimeMgr.GetInstance():GetServerTime()))
		end
	elseif arg_2_1 == TRACKING_PURCHASE_CLICK then
		YS2S.S2S(AiriUSTracker.DEV_TOKEN, "F7FE029D3F957A107D358D2BB93CA7E2", "Azur Lane (iOS) S2S_purchase_click", "", tostring((self:transMoney(pg.pay_data_display[arg_2_3].money))), pg.SdkMgr.GetInstance():GetDeviceId(), tostring(pg.TimeMgr.GetInstance():GetServerTime()))
	elseif arg_2_1 == TRACKING_PURCHASE_CLICK_MONTHLYCARD then
		YS2S.S2S(AiriUSTracker.DEV_TOKEN, "F7FE029D3F957A107D358D2BB93CA7E2", "Azur Lane (iOS) S2S_purchase_click_monthlycard", "", tostring((self:transMoney(pg.pay_data_display[arg_2_3].money))), pg.SdkMgr.GetInstance():GetDeviceId(), tostring(pg.TimeMgr.GetInstance():GetServerTime()))
	elseif arg_2_1 == TRACKING_PURCHASE_CLICK_DIAMOND then
		YS2S.S2S(AiriUSTracker.DEV_TOKEN, "F7FE029D3F957A107D358D2BB93CA7E2", "Azur Lane (iOS) S2S_purchase_click_diamond", "", tostring((self:transMoney(pg.pay_data_display[arg_2_3].money))), pg.SdkMgr.GetInstance():GetDeviceId(), tostring(pg.TimeMgr.GetInstance():GetServerTime()))
	elseif arg_2_1 == TRACKING_PURCHASE_CLICK_GIFTBAG then
		YS2S.S2S(AiriUSTracker.DEV_TOKEN, "F7FE029D3F957A107D358D2BB93CA7E2", "Azur Lane (iOS) S2S_purchase_click_giftbag", "", tostring((self:transMoney(pg.pay_data_display[arg_2_3].money))), pg.SdkMgr.GetInstance():GetDeviceId(), tostring(pg.TimeMgr.GetInstance():GetServerTime()))
	elseif arg_2_1 == TRACKING_PURCHASE then
		YS2S.S2S(AiriUSTracker.DEV_TOKEN, "F7FE029D3F957A107D358D2BB93CA7E2", "Azur Lane (iOS) S2S_purchase", "", tostring((self:transMoney(pg.pay_data_display[arg_2_3].money))), pg.SdkMgr.GetInstance():GetDeviceId(), tostring(pg.TimeMgr.GetInstance():GetServerTime()))
	end

	originalPrint("track done.")

	return
end

function AiriUSTracker:YS_S2S(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7)
	local var_3_0 = "https://www.googleadservices.com/pagead/conversion/app/1.0?"
	local var_3_1 = {
		dev_token = arg_3_1,
		link_id = arg_3_2
	}

	var_3_1.app_event_type = "custom"
	var_3_1.app_event_name = arg_3_3

	if arg_3_4 then
		var_3_1.app_event_data = arg_3_4
	end

	var_3_1.rdid = arg_3_6
	var_3_1.id_type = pg.SdkMgr.GetInstance():GetChannelUID() == "0" and "advertisingid" or "idfa"
	var_3_1.lat = "0"
	var_3_1.app_version = Application.version
	var_3_1.os_version = SystemInfo.operatingSystem
	var_3_1.sdk_version = "1.9.5r6"
	var_3_1.timestamp = arg_3_7 .. ".000001"
	var_3_1.value = arg_3_5
	var_3_1.currency_code = "USD"

	for iter_3_0, iter_3_1 in pairs(var_3_1) do
		var_3_0 = var_3_0 .. iter_3_0 .. "=" .. iter_3_1 .. "&"
	end

	originalPrint(var_3_0)
	VersionMgr.Inst:WebRequest(string.sub(var_3_0, 1, -2), function(arg_4_0, arg_4_1)
		originalPrint("code:" .. arg_4_0 .. " content:" .. arg_4_1)

		return
	end)

	return
end

function AiriUSTracker:transMoney(arg_5_1)
	return string.format("%.2f", arg_5_1 / 100)
end

return AiriUSTracker
