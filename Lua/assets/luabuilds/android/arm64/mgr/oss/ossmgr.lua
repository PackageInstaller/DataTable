pg = pg or {}
pg.OSSMgr = singletonClass("OSSMgr")

function pg.OSSMgr.Ctor(arg_1_0)
	if PLATFORM_CODE == PLATFORM_CH then
		arg_1_0.instance = OSSStarter.ins
	end

	arg_1_0.isIninted = false

	if arg_1_0.instance then
		arg_1_0.instance.debug = false
	end

	return
end

function pg.OSSMgr.InitConfig(arg_2_0)
	local var_2_9000

	if PLATFORM_CODE == PLATFORM_CH then
		OSS_STS_URL = ""
		OSS_ENDPOINT = "oss-cn-hangzhou.aliyuncs.com"
		OSSBUCKETNAME = "blhx-dorm-oss"

		local var_2_0 = pg.SdkMgr.GetInstance()
		local var_2_1 = var_2_0.GetChannelUID(var_2_9000)
		local var_2_2 = var_2_1 == "cps" or var_2_1 == "yun" or var_2_1 == "0"

		FOLDERNAME = getProxy(UserProxy).GetCacheGatewayInServerLogined(var_2_0) == PLATFORM_IPHONEPLAYER and "dorm_ios/" or var_2_2 and "dorm_bili/" or "dorm_uo/"

		print("FOLDERNAME: ", FOLDERNAME)
	elseif PLATFORM_CODE == PLATFORM_US then
		OSS_STS_URL = ""
		OSS_ENDPOINT = "oss-us-east-1.aliyuncs.com"
		OSSBUCKETNAME = "blhx-photo"
		FOLDERNAME = "dorm_us/"
	elseif PLATFORM_CODE == PLATFORM_CHT then
		OSS_STS_URL = ""
		OSS_ENDPOINT = "oss-ap-southeast-1.aliyuncs.com"
		OSSBUCKETNAME = "blhx-gameupload-sts"
		FOLDERNAME = "dorm_tw/"
	elseif PLATFORM_CODE == PLATFORM_KR then
		OSS_STS_URL = ""
		OSS_ENDPOINT = "ap-northeast-2"
		OSSBUCKETNAME = "blhx-s3-houzhai-upload"
		FOLDERNAME = "dorm_kr/"
	elseif PLATFORM_CODE == PLATFORM_JP then
		OSS_STS_URL = ""
		OSS_ENDPOINT = "ap-northeast-1"
		OSSBUCKETNAME = "blhx-dorm-jp"
		FOLDERNAME = "dorm_jp/"
	end

	return
end

function pg.OSSMgr.Init(arg_3_0)
	arg_3_0:InitConfig()

	if not arg_3_0.isIninted then
		arg_3_0.isIninted = true

		arg_3_0:InitClinet()
	end

	return
end

function pg.OSSMgr.InitClinet(arg_4_0, arg_4_1)
	if not arg_4_0.instance then
		return
	end

	;({}).mode = arg_4_0.instance.initMode
	;({}).callback = function(arg_5_0, arg_5_1)
		arg_4_0:AddExpireTimer(arg_5_1)
		arg_4_0.instance:InitWithArgs(unpack(arg_5_0))

		return
	end

	pg.m02:sendNotification(GAME.GET_OSS_ARGS, {})

	return
end

function pg.OSSMgr.UpdateLoad(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_0.instance then
		arg_6_3()

		return
	end

	arg_6_0.instance:UpdateLoad(OSSBUCKETNAME, FOLDERNAME .. arg_6_1, arg_6_2, arg_6_3)

	return
end

function pg.OSSMgr.AsynUpdateLoad(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if not arg_7_0.instance then
		arg_7_3()

		return
	end

	arg_7_0.instance:AsynUpdateLoad(OSSBUCKETNAME, FOLDERNAME .. arg_7_1, arg_7_2, arg_7_3)

	return
end

function pg.OSSMgr.DeleteObject(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0.instance then
		arg_8_2()

		return
	end

	arg_8_0.instance:DeleteObject(OSSBUCKETNAME, FOLDERNAME .. arg_8_1, arg_8_2)

	return
end

function pg.OSSMgr.GetSprite(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
	if not arg_9_0.instance then
		arg_9_6()

		return
	end

	arg_9_0.instance:GetSprite(OSSBUCKETNAME, FOLDERNAME .. arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)

	return
end

function pg.OSSMgr.GetTexture2D(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)
	if not arg_10_0.instance then
		local var_10_0

		if PathMgr.FileExists(arg_10_2) == false then
			arg_10_6(false)

			do return end

			var_10_0 = UnityEngine.Texture2D.New(arg_10_4, arg_10_5, TextureFormat.ARGB32, false)
		end

		Tex2DExtension.LoadImage(var_10_0, (System.IO.File.ReadAllBytes(arg_10_2)))
		arg_10_6(true, var_10_0)

		return
	end

	arg_10_0.instance:GetTexture(OSSBUCKETNAME, FOLDERNAME .. arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)

	return
end

function pg.OSSMgr.AddExpireTimer(arg_11_0, arg_11_1)
	arg_11_0:RemoveExpireTimer()

	if not arg_11_1 or arg_11_1 == 0 then
		return
	end

	local var_11_0 = pg.TimeMgr.GetInstance()
	local var_11_1 = arg_11_1 - var_11_0:GetServerTime()

	if var_11_1 <= 0 then
		var_11_1 = 300
	end

	print("expireTime: ", var_11_1)

	arg_11_0.timer = Timer.New(function()
		arg_11_0:InitClinet()

		return
	end, var_11_1, 1)

	arg_11_0.timer:Start()

	return
end

function pg.OSSMgr.RemoveExpireTimer(arg_13_0)
	if arg_13_0.timer then
		arg_13_0.timer:Stop()

		arg_13_0.timer = nil
	end

	return
end

function pg.OSSMgr.Dispose(arg_14_0)
	arg_14_0:RemoveExpireTimer()

	return
end

return pg.OSSMgr
