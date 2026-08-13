pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.OSSMgr = var_0_10001("OSSMgr")
pg = var_0

local var_0_1 = var_0.OSSMgr

function var_0_1.Ctor(arg_1_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CH = var_1_10002

	if var_1_10001 == var_1_10002 then
		OSSStarter = var_1_10001
		arg_1_0.instance = var_1_10001.ins
	end

	arg_1_0.isIninted = false

	if arg_1_0.instance then
		arg_1_0.instance.debug = false
	end

	return
end

function var_0_1.InitConfig(arg_2_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CH = var_1_10002

	if var_1_10001 == var_1_10002 then
		var_1_10001 = ""
		var_1_10001 = OSS_STS_URL
		var_1_10001 = "oss-cn-hangzhou.aliyuncs.com"
		var_1_10001 = OSS_ENDPOINT
		var_1_10001 = "blhx-dorm-oss"
		pg = OSSBUCKETNAME
		var_1_10002 = var_1_10001.SdkMgr.GetInstance()
		var_1_10002 = var_1_10001.GetChannelUID(var_1_10002) == "cps" or var_1_10001 == "yun" or var_1_10001 == "0"
		getProxy = var_1_10003
		UserProxy = var_1_10004

		local var_2_0 = var_1_10003(var_1_10004)
		local var_2_1 = var_3.GetCacheGatewayInServerLogined(var_2_0)

		PLATFORM_IPHONEPLAYER = var_2_0

		if var_2_1 == var_2_0 then
			var_2_0 = "dorm_ios/"
			var_2_0 = FOLDERNAME
		elseif var_1_10002 then
			var_2_0 = "dorm_bili/"
			var_2_0 = FOLDERNAME
		else
			var_2_0 = "dorm_uo/"
			var_2_0 = FOLDERNAME
		end

		print = var_2_0

		local var_2_2 = "FOLDERNAME: "

		FOLDERNAME = var_1_10006

		var_2_0(var_2_2, var_1_10006)
	else
		PLATFORM_CODE = var_1_10001
		PLATFORM_US = var_1_10002

		if var_1_10001 == var_1_10002 then
			var_1_10001 = ""
			var_1_10001 = OSS_STS_URL
			var_1_10001 = "oss-us-east-1.aliyuncs.com"
			var_1_10001 = OSS_ENDPOINT
			var_1_10001 = "blhx-photo"
			var_1_10001 = OSSBUCKETNAME
			var_1_10001 = "dorm_us/"
			var_1_10001 = FOLDERNAME
		else
			PLATFORM_CODE = var_1_10001
			PLATFORM_CHT = var_1_10002

			if var_1_10001 == var_1_10002 then
				var_1_10001 = ""
				var_1_10001 = OSS_STS_URL
				var_1_10001 = "oss-ap-southeast-1.aliyuncs.com"
				var_1_10001 = OSS_ENDPOINT
				var_1_10001 = "blhx-gameupload-sts"
				var_1_10001 = OSSBUCKETNAME
				var_1_10001 = "dorm_tw/"
				var_1_10001 = FOLDERNAME
			else
				PLATFORM_CODE = var_1_10001
				PLATFORM_KR = var_1_10002

				if var_1_10001 == var_1_10002 then
					var_1_10001 = ""
					var_1_10001 = OSS_STS_URL
					var_1_10001 = "ap-northeast-2"
					var_1_10001 = OSS_ENDPOINT
					var_1_10001 = "blhx-s3-houzhai-upload"
					var_1_10001 = OSSBUCKETNAME
					var_1_10001 = "dorm_kr/"
					var_1_10001 = FOLDERNAME
				else
					PLATFORM_CODE = var_1_10001
					PLATFORM_JP = var_1_10002

					if var_1_10001 == var_1_10002 then
						local var_2_3 = ""
						local var_2_4 = OSS_STS_URL
						local var_2_5 = "ap-northeast-1"
						local var_2_6 = OSS_ENDPOINT
						local var_2_7 = "blhx-dorm-jp"
						local var_2_8 = OSSBUCKETNAME
						local var_2_9 = "dorm_jp/"
						local var_2_10 = FOLDERNAME
					end
				end
			end
		end
	end

	return
end

function var_0_1.Init(arg_3_0)
	arg_3_0:InitConfig()

	if not arg_3_0.isIninted then
		arg_3_0.isIninted = true

		arg_3_0:InitClinet()
	end

	return
end

function var_0_1.InitClinet(arg_4_0, arg_4_1)
	if not arg_4_0.instance then
		return
	end

	local var_4_0 = arg_4_0.instance.initMode

	local function var_4_1(arg_5_0, arg_5_1)
		local var_5_0 = arg_4_0

		var_2.AddExpireTimer(var_5_0, arg_5_1)

		local var_5_1 = arg_4_0.instance
		local var_5_2 = var_2.InitWithArgs

		unpack = var_4

		var_5_2(var_5_1, var_4(arg_5_0))

		return
	end

	pg = var_1_10004

	local var_4_2 = var_1_10004.m02
	local var_4_3 = var_4.sendNotification

	GAME = var_1_10006

	var_4_3(var_4_2, var_1_10006.GET_OSS_ARGS, {
		mode = var_4_0,
		callback = var_4_1
	})

	return
end

function var_0_1.UpdateLoad(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_0.instance then
		arg_6_3()

		return
	end

	OSSBUCKETNAME = var_4

	local var_6_0 = arg_6_0.instance
	local var_6_1 = var_5.UpdateLoad
	local var_6_2 = var_4

	FOLDERNAME = var_1_10008

	var_6_1(var_6_0, var_6_2, var_1_10008 .. arg_6_1, arg_6_2, arg_6_3)

	return
end

function var_0_1.AsynUpdateLoad(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if not arg_7_0.instance then
		arg_7_3()

		return
	end

	OSSBUCKETNAME = var_4

	local var_7_0 = arg_7_0.instance
	local var_7_1 = var_5.AsynUpdateLoad
	local var_7_2 = var_4

	FOLDERNAME = var_1_10008

	var_7_1(var_7_0, var_7_2, var_1_10008 .. arg_7_1, arg_7_2, arg_7_3)

	return
end

function var_0_1.DeleteObject(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0.instance then
		arg_8_2()

		return
	end

	OSSBUCKETNAME = var_3

	local var_8_0 = arg_8_0.instance
	local var_8_1 = var_4.DeleteObject
	local var_8_2 = var_3

	FOLDERNAME = var_1_10007

	var_8_1(var_8_0, var_8_2, var_1_10007 .. arg_8_1, arg_8_2)

	return
end

function var_0_1.GetSprite(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
	if not arg_9_0.instance then
		arg_9_6()

		return
	end

	OSSBUCKETNAME = var_7

	local var_9_0 = arg_9_0.instance
	local var_9_1 = var_8.GetSprite
	local var_9_2 = var_7

	FOLDERNAME = var_1_10011

	var_9_1(var_9_0, var_9_2, var_1_10011 .. arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)

	return
end

function var_0_1.GetTexture2D(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)
	local var_10_0

	if not arg_10_0.instance then
		PathMgr = var_10_0

		if var_10_0.FileExists(arg_10_2) == false then
			arg_10_6(false)

			return
		end

		System = var_10_0
		var_10_0 = var_10_0.IO.File.ReadAllBytes(arg_10_2)
		UnityEngine = var_8

		local var_10_1 = var_8.Texture2D.New
		local var_10_2 = arg_10_4
		local var_10_3 = arg_10_5

		TextureFormat = var_1_10011

		local var_10_4 = var_10_1(var_10_2, var_10_3, var_1_10011.ARGB32, false)

		Tex2DExtension = var_10_2

		var_10_2.LoadImage(var_10_4, var_10_0)
		arg_10_6(true, var_10_4)

		return
	end

	OSSBUCKETNAME = var_10_0

	local var_10_5 = arg_10_0.instance
	local var_10_6 = var_8.GetTexture
	local var_10_7 = var_10_0

	FOLDERNAME = var_1_10011

	var_10_6(var_10_5, var_10_7, var_1_10011 .. arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)

	return
end

function var_0_1.AddExpireTimer(arg_11_0, arg_11_1)
	arg_11_0:RemoveExpireTimer()

	if not arg_11_1 or arg_11_1 == 0 then
		return
	end

	pg = var_2

	local var_11_0 = var_2.TimeMgr.GetInstance()
	local var_11_1

	if arg_11_1 - var_2.GetServerTime(var_11_0) <= 0 then
		var_11_1 = 300
	end

	print = var_3

	var_3("expireTime: ", var_11_1)

	Timer = var_3
	arg_11_0.timer = var_3.New(function()
		local var_12_0 = arg_11_0

		var_0.InitClinet(var_12_0)

		return
	end, var_11_1, 1)

	local var_11_2 = arg_11_0.timer

	var_3.Start(var_11_2)

	return
end

function var_0_1.RemoveExpireTimer(arg_13_0)
	if arg_13_0.timer then
		local var_13_0 = arg_13_0.timer

		var_1.Stop(var_13_0)

		arg_13_0.timer = nil
	end

	return
end

function var_0_1.Dispose(arg_14_0)
	arg_14_0:RemoveExpireTimer()

	return
end

return var_0_1
