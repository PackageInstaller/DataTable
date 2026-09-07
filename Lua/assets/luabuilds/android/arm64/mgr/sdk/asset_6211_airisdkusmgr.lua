local var_0_0 = {}
local var_0_1 = AiriUSSdkMgr.inst
local var_0_2 = AiriUSSdkMgr.AiriSDKInst

AIRI_PLATFORM_FACEBOOK = "facebook"
AIRI_PLATFORM_TWITTER = "twitter"
AIRI_PLATFORM_YOSTAR = "yostar"
AIRI_PLATFORM_APPLE = "apple"
AIRI_PLATFORM_AMAZON = "amazon"
AIRI_PLATFORM_GPS = "gps"
AIRI_SDK_INITED = false
var_0_0.OnAiriBuying = -1
var_0_0.BuyingLimit = 60

function var_0_0.CheckAudit()
	return NetConst.getwayType == 1
end

function var_0_0.CheckPreAudit()
	return NetConst.GATEWAY_PORT == 30001 and NetConst.GATEWAY_HOST == "audit.us.yo-star.com"
end

function var_0_0.CheckPretest()
	return IsUnityEditor or var_0_0.CheckPreAudit()
end

function var_0_0.CheckGoogleSimulator()
	return NetConst.getwayType == 2
end

function var_0_0.GoSDkLoginScene()
	var_0_1:GoLoginScene()
	var_0_0.AiriInit()

	return
end

function var_0_0.AiriInit(arg_6_0)
	pg.UIMgr.GetInstance():LoadingOn()
	var_0_1:InitSdk()
	print("CSharpVersion:" .. tostring(CSharpVersion))

	return
end

function var_0_0.AiriLogin()
	pg.UIMgr.GetInstance():LoadingOn()
	var_0_1:Login()

	return
end

function var_0_0.LoginWithSocial(arg_8_0, arg_8_1, arg_8_2)
	pg.UIMgr.GetInstance():LoadingOn()

	if arg_8_0 == AIRI_PLATFORM_FACEBOOK then
		var_0_1:LoginWithFB()
	elseif arg_8_0 == AIRI_PLATFORM_TWITTER then
		var_0_1:LoginWithTW()
	elseif arg_8_0 == AIRI_PLATFORM_YOSTAR then
		var_0_1:LoginWithSDKAccount(arg_8_1, arg_8_2)
	elseif arg_8_0 == AIRI_PLATFORM_APPLE then
		var_0_1:LoginWithApple()
	elseif arg_8_0 == AIRI_PLATFORM_AMAZON then
		var_0_1:LoginWithAmazon()
	end

	return
end

function var_0_0.LoginWithTranscode(arg_9_0, arg_9_1)
	pg.UIMgr.GetInstance():LoadingOn()
	var_0_1:LoginWithTranscode(arg_9_0, arg_9_1)

	return
end

function var_0_0.TranscodeRequest()
	pg.UIMgr.GetInstance():LoadingOn()
	var_0_1:TranscodeRequest()

	return
end

function var_0_0.AiriBuy(arg_11_0, arg_11_1, arg_11_2)
	var_0_0.OnAiriBuying = Time.realtimeSinceStartup

	if arg_11_1 == "audit" then
		var_0_1:NewBuy(arg_11_0, Airisdk.BuyServerTag.audit, arg_11_2)
	elseif arg_11_1 == "preAudit" then
		var_0_1:NewBuy(arg_11_0, Airisdk.BuyServerTag.preAudit, arg_11_2)
	elseif arg_11_1 == "production" then
		var_0_1:NewBuy(arg_11_0, Airisdk.BuyServerTag.production, arg_11_2)
	elseif arg_11_1 == "test" then
		var_0_1:NewBuy(arg_11_0, Airisdk.BuyServerTag.test, arg_11_2)
	end

	return
end

function var_0_0.LinkSocial(arg_12_0, arg_12_1, arg_12_2)
	var_0_0.SetAiriTimeout()

	if arg_12_0 == AIRI_PLATFORM_FACEBOOK then
		var_0_1:LinkSocial(Airisdk.LoginPlatform.FACEBOOK)
	elseif arg_12_0 == AIRI_PLATFORM_TWITTER then
		var_0_1:LinkSocial(Airisdk.LoginPlatform.TWITTER)
	elseif arg_12_0 == AIRI_PLATFORM_YOSTAR then
		var_0_1:LinkSocial(Airisdk.LoginPlatform.YOSTAR, arg_12_1, arg_12_2)
	elseif arg_12_0 == AIRI_PLATFORM_APPLE then
		var_0_1:LinkSocial(Airisdk.LoginPlatform.APPLE)
	elseif arg_12_0 == AIRI_PLATFORM_AMAZON then
		var_0_1:LinkSocial(Airisdk.LoginPlatform.AMAZON)
	end

	return
end

function var_0_0.UnlinkSocial(arg_13_0)
	var_0_0.SetAiriTimeout()

	if arg_13_0 == AIRI_PLATFORM_FACEBOOK then
		var_0_1:UnlinkSocial(Airisdk.LoginPlatform.FACEBOOK)
	elseif arg_13_0 == AIRI_PLATFORM_TWITTER then
		var_0_1:UnlinkSocial(Airisdk.LoginPlatform.TWITTER)
	elseif arg_13_0 == AIRI_PLATFORM_APPLE then
		var_0_1:UnlinkSocial(Airisdk.LoginPlatform.APPLE)
	elseif arg_13_0 == AIRI_PLATFORM_AMAZON then
		var_0_1:UnlinkSocial(Airisdk.LoginPlatform.AMAZON)
	elseif arg_13_0 == AIRI_PLATFORM_GPS then
		var_0_1:UnlinkSocial(Airisdk.LoginPlatform.GOOGLEPLAY)
	end

	return
end

function var_0_0.IsSocialLink(arg_14_0)
	if not var_0_0.GetIsPlatform() then
		return false
	end

	if arg_14_0 == AIRI_PLATFORM_FACEBOOK then
		return var_0_1:CheckPlatformLink(Airisdk.LoginPlatform.FACEBOOK)
	elseif arg_14_0 == AIRI_PLATFORM_TWITTER then
		return var_0_1:CheckPlatformLink(Airisdk.LoginPlatform.TWITTER)
	elseif arg_14_0 == AIRI_PLATFORM_YOSTAR then
		return var_0_1:CheckPlatformLink(Airisdk.LoginPlatform.YOSTAR)
	elseif arg_14_0 == AIRI_PLATFORM_APPLE then
		return var_0_1:CheckPlatformLink(Airisdk.LoginPlatform.APPLE)
	elseif arg_14_0 == AIRI_PLATFORM_AMAZON then
		return var_0_1:CheckPlatformLink(Airisdk.LoginPlatform.AMAZON)
	elseif arg_14_0 == AIRI_PLATFORM_GPS then
		return var_0_1:CheckPlatformLink(Airisdk.LoginPlatform.GOOGLEPLAY)
	end

	return false
end

function var_0_0.GetSocialName(arg_15_0)
	if arg_15_0 == AIRI_PLATFORM_FACEBOOK then
		return var_0_1.loginRet.FACEBOOK_NAME
	elseif arg_15_0 == AIRI_PLATFORM_TWITTER then
		return var_0_1.loginRet.TWITTER_NAME
	elseif arg_15_0 == AIRI_PLATFORM_YOSTAR then
		return var_0_1.loginRet.SDK_NAME
	elseif arg_15_0 == AIRI_PLATFORM_APPLE then
		return var_0_1.loginRet.APPLE_ID
	elseif arg_15_0 == AIRI_PLATFORM_AMAZON then
		return var_0_1.loginRet.AMAZON_NAME
	elseif arg_15_0 == AIRI_PLATFORM_GPS then
		return var_0_1.loginRet.GOOGLE_PLAY_GAME_NAME
	end

	return ""
end

function var_0_0.SetBirth(arg_16_0)
	pg.UIMgr.GetInstance():LoadingOn()
	var_0_1:SetBirth(arg_16_0)

	return
end

function var_0_0.GetIsBirthSet()
	return var_0_1:IsBirthSet()
end

function var_0_0.ClearAccountCache()
	var_0_1:ClearAccountCache()

	return
end

function var_0_0.GameShare(arg_19_0, arg_19_1)
	var_0_1:SystemShare(arg_19_0, arg_19_1)

	return
end

function var_0_0.VerificationCodeReq(arg_20_0)
	var_0_1:VerificationCodeReq(arg_20_0)

	AIRI_LAST_GEN_TIME = Time.realtimeSinceStartup

	return
end

function var_0_0.OpenYostarHelp()
	local var_21_0 = getProxy(PlayerProxy):getData()
	local var_21_1 = getProxy(ServerProxy):getLastServer(getProxy(UserProxy):getData().uid)
	local var_21_2 = pg.TimeMgr.GetInstance():STimeDescS(var_21_0.registerTime, "%Y-%m-%d %H:%M:%S")
	local var_21_3 = math.modf(var_21_0.rmb / 100)

	originalPrint("uid:" .. var_21_0.id .. ",name:" .. var_21_0.name .. ",level" .. var_21_0.level .. ",serverId:" .. var_21_1.id .. " - " .. var_21_1.name .. ",rmb:" .. var_21_3 .. ",createTime:" .. var_21_2)
	var_0_1:OpenHelp(tostring(var_21_0.id), var_21_0.name, tostring(var_21_1.id .. " - " .. var_21_1.name), var_21_3, var_21_2)

	return
end

function var_0_0.GetYostarUid()
	return var_0_1.loginRet.UID
end

function var_0_0.GetDeviceId()
	return var_0_2:GetDeviceID()
end

function var_0_0.GetLoginType()
	return var_0_1.loginType
end

function var_0_0.GetIsPlatform()
	return var_0_1.isPlatform
end

function var_0_0.GetChannelUID()
	originalPrint("channelUID : " .. var_0_1.channelUID)

	return var_0_1.channelUID
end

function var_0_0.UserEventUpload(arg_27_0)
	if var_0_0.GetIsPlatform() then
		var_0_1:UserEventUpload(arg_27_0)
	end

	return
end

function var_0_0.ShowSurvey(arg_28_0, arg_28_1)
	if var_0_0.GetIsPlatform() then
		var_0_2:UserEventUpload(arg_28_0, tostring(getProxy(PlayerProxy):getData().id), arg_28_1)
	end

	return
end

function var_0_0.Survey(arg_29_0)
	Application.OpenURL(arg_29_0)

	return
end

function var_0_0.OnAndoridBackPress()
	PressBack()

	return
end

function var_0_0.BindCPU()
	return
end

function var_0_0.CheckAiriCanBuy()
	if var_0_0.OnAiriBuying == -1 or Time.realtimeSinceStartup - var_0_0.OnAiriBuying > var_0_0.BuyingLimit then
		return true
	else
		return false
	end

	return
end

function var_0_0.AccountDelete()
	pg.UIMgr.GetInstance():LoadingOn()
	var_0_1:AccountDeleteReq()

	return
end

function var_0_0.AccountReborn()
	pg.UIMgr.GetInstance():LoadingOn()
	var_0_1:AccountRebornReq()

	return
end

function var_0_0.ConfirmLinkGooglePlayGame()
	var_0_1:ConfirmLinkGooglePlayGame()

	return
end

function var_0_0.ConfirmUnLinkGooglePlayGame()
	var_0_1:ConfirmUnLinkGooglePlayGame()

	return
end

function var_0_0.BindYostarPass()
	var_0_1:BindYostarPassReq()

	return
end

function GoLoginScene()
	print("US do nothing")

	return
end

function AiriInitResult(arg_39_0)
	pg.UIMgr.GetInstance():LoadingOff()

	if var_0_0.AiriResultCodeHandler(arg_39_0.R_CODE) then
		AIRI_SDK_INITED = true

		OnAppPauseForSDK(false)
		AiriGoLogin()
	end

	return
end

function AiriGoLogin(arg_40_0)
	pg.m02:sendNotification(GAME.GO_SCENE, SCENE.LOGIN, {
		loginPlatform = arg_40_0
	})
	gcAll()

	return
end

function AiriLogin(arg_41_0)
	pg.UIMgr.GetInstance():LoadingOff()

	local function var_41_0()
		pg.m02:sendNotification(GAME.PLATFORM_LOGIN_DONE, {
			user = User.New({
				type = 1,
				arg1 = PLATFORM_YOSTARUS,
				arg2 = arg_41_0.UID,
				arg3 = arg_41_0.ACCESS_TOKEN
			})
		})

		return
	end

	if var_0_0.AiriYoStarPassMigrateHandler(arg_41_0) then
		return
	end

	if var_0_0.AiriResultCodeHandler(arg_41_0.R_CODE) then
		var_41_0()
	else
		if var_0_0.AiriPGSResultCodeHandler(arg_41_0.R_CODE, function()
			var_41_0()

			return
		end) then
			return
		end

		if arg_41_0.R_CODE:ToInt() == 9 then
			local var_41_1 = tonumber(string.sub(arg_41_0.R_DELETETIME, 1, string.len(arg_41_0.R_DELETETIME) - 3))

			if pg.TimeMgr.GetInstance():GetServerTime() < var_41_1 then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					modal = true,
					content = i18n("box_account_reborn_content", (pg.TimeMgr.GetInstance():CTimeDescC(var_41_1, "%Y-%m-%d %H:%M:%S"))),
					onYes = function()
						var_0_0.AccountReborn()

						return
					end
				})
			end
		else
			originalPrint("AiriLogin failed")
		end
	end

	return
end

function AiriTranscodeResult(arg_45_0)
	pg.UIMgr.GetInstance():LoadingOff()

	if var_0_0.AiriResultCodeHandler(arg_45_0.R_CODE) then
		pg.m02:sendNotification(GAME.ON_GET_TRANSCODE, {
			transcode = arg_45_0.MIGRATIONCODE
		})
	end

	return
end

function AiriBuyResult(arg_46_0)
	var_0_0.OnAiriBuying = -1

	pg.UIMgr.GetInstance():LoadingOff()

	if var_0_0.AiriResultCodeHandler(arg_46_0.R_CODE) then
		getProxy(ShopsProxy):removeWaitTimer()
		pg.m02:sendNotification(GAME.CHARGE_CONFIRM, {
			payId = arg_46_0.EXTRADATA,
			bsId = arg_46_0.ORDERID
		})
	else
		getProxy(ShopsProxy):removeWaitTimer()
		pg.m02:sendNotification(GAME.CHARGE_FAILED, {
			payId = arg_46_0.EXTRADATA
		})
	end

	return
end

function SetBirthResult(arg_47_0)
	pg.UIMgr.GetInstance():LoadingOff()

	if var_0_0.AiriResultCodeHandler(arg_47_0.R_CODE) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("set_birth_success"))
	end

	return
end

function LinkSocialResult(arg_48_0)
	var_0_0.EndAiriTimeout()

	if var_0_0.AiriResultCodeHandler(arg_48_0.R_CODE) then
		pg.m02:sendNotification(GAME.ON_SOCIAL_LINKED)
	end

	return
end

function UnlinkSocialResult(arg_49_0)
	var_0_0.EndAiriTimeout()

	if var_0_0.AiriResultCodeHandler(arg_49_0.R_CODE) then
		pg.m02:sendNotification(GAME.ON_SOCIAL_UNLINKED)
	elseif var_0_0.AiriPGSResultCodeHandler(arg_49_0.R_CODE) then
		return
	end

	return
end

function VerificationCodeResult(arg_50_0)
	pg.UIMgr.GetInstance():LoadingOff()

	if var_0_0.AiriResultCodeHandler(arg_50_0.R_CODE) then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			content = i18n("verification_code_req_tip2")
		})
	end

	return
end

function OnAppPauseForSDK(arg_51_0)
	if not AIRI_SDK_INITED then
		return
	end

	if arg_51_0 then
		var_0_2:OnPause()
	else
		var_0_2:OnResume()
	end

	return
end

function AccountDeleteResult(arg_52_0, arg_52_1, arg_52_2, arg_52_3, arg_52_4)
	pg.UIMgr.GetInstance():LoadingOff()

	if var_0_0.AiriResultCodeHandler({
		ToInt = function()
			return arg_52_0
		end
	}) then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			modal = true,
			hideNo = true,
			content = i18n("box_account_del_success_content", (pg.TimeMgr.GetInstance():CTimeDescC(tonumber(string.sub(arg_52_3, 1, string.len(arg_52_3) - 3)), "%Y-%m-%d %H:%M:%S"))),
			onYes = function()
				pg.m02:sendNotification(GAME.LOGOUT, {
					code = 0
				})

				return
			end,
			onClose = function()
				pg.m02:sendNotification(GAME.LOGOUT, {
					code = 0
				})

				return
			end
		})
	end

	return
end

function AccountRebornResult(arg_56_0, arg_56_1)
	pg.UIMgr.GetInstance():LoadingOff()

	if var_0_0.AiriResultCodeHandler({
		ToInt = function()
			return arg_56_0
		end
	}) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("tip_account_del_reborn"))
	end

	return
end

function BindYostarPassResult(arg_58_0, arg_58_1)
	if var_0_0.AiriResultCodeHandler({
		ToInt = function()
			return arg_58_0
		end
	}) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("new_airi_error_code_0"))
	end

	return
end

function OnYoStarMessageReceivedRespone(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
	warning("OnYoStarMessageReceivedRespone")

	return
end

function var_0_0:AiriResultCodeHandler()
	local var_61_0 = self:ToInt()

	if var_61_0 == 0 then
		return true
	else
		if table.contains({
			100233,
			100201,
			100202,
			100203,
			100204,
			100205,
			100206,
			100214
		}, var_61_0) then
			return false
		end

		if var_61_0 == 14 then
			var_0_0.ClearAccountCache()
		end

		originalPrint("SDK Error Code:" .. var_61_0)

		local var_61_1 = var_0_2:GetSDKRecommendedErrorMsg(var_61_0, Airisdk.LanguageType.MSG_EN)

		if var_61_1 and string.len(var_61_1) > 0 then
			pg.TipsMgr.GetInstance():ShowTips(var_61_1)
		else
			local var_61_2 = i18n("new_airi_error_code_" .. var_61_0)

			if string.find(var_61_2, "UndefinedLanguage") then
				pg.TipsMgr.GetInstance():ShowTips(i18n("new_airi_error_code_other") .. ":" .. var_61_0)
			else
				pg.TipsMgr.GetInstance():ShowTips(var_61_2 .. ":" .. var_61_0)
			end
		end
	end

	return false
end

function var_0_0:AiriPGSResultCodeHandler(arg_62_1)
	local var_62_0 = self:ToInt()

	originalPrint("AiriPGSResultCodeHandler", tostring(var_62_0))

	if var_62_0 == 100201 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("pgs_login_binding_exist2"),
			onYes = function()
				var_0_0.ConfirmLinkGooglePlayGame()

				return
			end
		})

		return true
	elseif var_62_0 == 100202 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("pgs_login_binding_exist1"),
			onYes = function()
				var_0_0.ConfirmLinkGooglePlayGame()

				return
			end
		})

		return true
	elseif var_62_0 == 100203 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("pgs_login_binding_exist3"),
			onYes = function()
				var_0_0.ConfirmLinkGooglePlayGame()

				return
			end
		})

		return true
	elseif var_62_0 == 100204 then
		arg_62_1()

		return true
	elseif var_62_0 == 100205 then
		return true
	elseif var_62_0 == 100206 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			content = i18n("pgs_login_tip"),
			onYes = function()
				pg.m02:sendNotification(GAME.ON_SOCIAL_LINKED)

				return
			end,
			onClose = function()
				pg.m02:sendNotification(GAME.ON_SOCIAL_LINKED)

				return
			end
		})

		return true
	elseif var_62_0 == 100214 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("pgs_unbind_tip2"),
			onYes = function()
				var_0_0.ConfirmUnLinkGooglePlayGame()

				return
			end
		})

		return true
	else
		return false
	end

	return
end

function var_0_0:AiriYoStarPassMigrateHandler()
	if table.contains({
		0,
		100204,
		100206
	}, self.R_CODE:ToInt()) and self.SHOW_MIGRATE_PAGE == 1 then
		var_0_0.BindYostarPass()

		return true
	else
		return false
	end

	return
end

var_0_0.ON_AIRI_LOADING = false

function var_0_0.SetAiriTimeout()
	pg.UIMgr.GetInstance():LoadingOn()

	var_0_0.ON_AIRI_LOADING = true

	onDelayTick(function()
		if var_0_0.ON_AIRI_LOADING then
			pg.UIMgr.GetInstance():LoadingOff()

			var_0_0.ON_AIRI_LOADING = false
		end

		return
	end, 15)

	return
end

function var_0_0.EndAiriTimeout()
	var_0_0.ON_AIRI_LOADING = false

	pg.UIMgr.GetInstance():LoadingOff()

	return
end

return var_0_0
