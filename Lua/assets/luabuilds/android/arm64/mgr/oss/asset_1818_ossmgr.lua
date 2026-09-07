pg = pg or {}
pg.OSSMgr = singletonClass("OSSMgr")

function pg.OSSMgr:Ctor()
	if PLATFORM_CODE == PLATFORM_CH then
		self.instance = OSSStarter.ins
	end

	self.isIninted = false

	if self.instance then
		self.instance.debug = false
	end

	return
end

function pg.OSSMgr.InitConfig(arg_2_0)
	if PLATFORM_CODE == PLATFORM_CH then
		OSS_STS_URL = ""
		OSS_ENDPOINT = "oss-cn-hangzhou.aliyuncs.com"
		OSSBUCKETNAME = "blhx-dorm-oss"

		local var_2_0 = pg.SdkMgr.GetInstance()
		local var_2_1 = var_2_0:GetChannelUID()

		FOLDERNAME = getProxy(UserProxy).GetCacheGatewayInServerLogined(var_2_0) == PLATFORM_IPHONEPLAYER and "dorm_ios/" or (var_2_1 == "cps" or var_2_1 == "yun" or var_2_1 == "0") and "dorm_bili/" or "dorm_uo/"

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

function pg.OSSMgr:Init()
	self:InitConfig()

	if not self.isIninted then
		self.isIninted = true

		self:InitClinet()
	end

	return
end

function pg.OSSMgr:InitClinet(arg_4_1)
	local var_4_0

	if not self.instance then
		do return end

		var_4_0 = {}
	end

	var_4_0.mode = self.instance.initMode

	function var_4_0.callback(arg_5_0, arg_5_1)
		self:AddExpireTimer(arg_5_1)
		self.instance:InitWithArgs(unpack(arg_5_0))

		return
	end

	pg.m02:sendNotification(GAME.GET_OSS_ARGS, var_4_0)

	return
end

function pg.OSSMgr:UpdateLoad(arg_6_1, arg_6_2, arg_6_3)
	if not self.instance then
		arg_6_3()

		return
	end

	self.instance:UpdateLoad(OSSBUCKETNAME, FOLDERNAME .. arg_6_1, arg_6_2, arg_6_3)

	return
end

function pg.OSSMgr:AsynUpdateLoad(arg_7_1, arg_7_2, arg_7_3)
	if not self.instance then
		arg_7_3()

		return
	end

	self.instance:AsynUpdateLoad(OSSBUCKETNAME, FOLDERNAME .. arg_7_1, arg_7_2, arg_7_3)

	return
end

function pg.OSSMgr:DeleteObject(arg_8_1, arg_8_2)
	if not self.instance then
		arg_8_2()

		return
	end

	self.instance:DeleteObject(OSSBUCKETNAME, FOLDERNAME .. arg_8_1, arg_8_2)

	return
end

function pg.OSSMgr:GetSprite(arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
	if not self.instance then
		arg_9_6()

		return
	end

	self.instance:GetSprite(OSSBUCKETNAME, FOLDERNAME .. arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)

	return
end

function pg.OSSMgr:GetTexture2D(arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)
	if not self.instance then
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

	self.instance:GetTexture(OSSBUCKETNAME, FOLDERNAME .. arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)

	return
end

function pg.OSSMgr:AddExpireTimer(arg_11_1)
	self:RemoveExpireTimer()

	if not arg_11_1 or arg_11_1 == 0 then
		return
	end

	local var_11_0 = arg_11_1 - pg.TimeMgr.GetInstance():GetServerTime()

	if var_11_0 <= 0 then
		var_11_0 = 300
	end

	print("expireTime: ", var_11_0)

	self.timer = Timer.New(function()
		self:InitClinet()

		return
	end, var_11_0, 1)

	self.timer:Start()

	return
end

function pg.OSSMgr:RemoveExpireTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function pg.OSSMgr:Dispose()
	self:RemoveExpireTimer()

	return
end

return pg.OSSMgr
