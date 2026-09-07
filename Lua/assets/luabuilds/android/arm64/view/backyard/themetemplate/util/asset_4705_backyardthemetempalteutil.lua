local BackYardThemeTempalteUtil = class("BackYardThemeTempalteUtil")
local var_0_1 = false
local var_0_2 = true
local var_0_3 = 1920
local var_0_4 = 1080

BackYardThemeTempalteUtil.TakeScale = 0.86
BackYardThemeTempalteUtil.HideGos = {}
BackYardThemeTempalteUtil.ScaleGos = {}
BackYardThemeTempalteUtil.loader = {}

local var_0_5 = 7

BackYardThemeTempalteUtil.caches = {}

local function var_0_7()
	return Application.persistentDataPath .. "/screen_scratch"
end

local function var_0_8(arg_3_0)
	return Application.persistentDataPath .. "/screen_scratch/" .. arg_3_0 .. ".png"
end

local function var_0_9(arg_4_0)
	return arg_4_0 .. ".png"
end

local function var_0_10(arg_5_0)
	if PathMgr.FileExists(arg_5_0) then
		return HashUtil.HashFile(arg_5_0)
	else
		return ""
	end

	return
end

local function var_0_11(arg_6_0, arg_6_1, arg_6_2)
	if not BackYardThemeTempalteUtil.FileExists(arg_6_0) then
		arg_6_2()

		return
	end

	pg.OSSMgr.GetInstance():GetTexture2D(var_0_9(arg_6_0), var_0_8(arg_6_0), false, var_0_3, var_0_4, function(arg_7_0, arg_7_1)
		if arg_7_0 and arg_7_1 then
			arg_6_2(arg_7_1)
		else
			arg_6_2()
		end

		return
	end)

	return
end

local function var_0_12(arg_8_0, arg_8_1, arg_8_2)
	if not var_0_2 then
		arg_8_2()

		return
	end

	local var_8_0 = var_0_8(arg_8_0)

	pg.OSSMgr.GetInstance():GetTexture2D(var_0_9(arg_8_0), var_8_0, true, var_0_3, var_0_4, function(arg_9_0, arg_9_1)
		if arg_9_0 and arg_9_1 and arg_8_1 == var_0_10(var_8_0) then
			arg_8_2(arg_9_1)
		else
			arg_8_2()
		end

		return
	end)

	return
end

local function var_0_13(arg_10_0, arg_10_1)
	if not var_0_2 then
		arg_10_1()

		return
	end

	local var_10_0 = var_0_8(arg_10_0)

	pg.OSSMgr.GetInstance():DeleteObject(var_0_9(arg_10_0), arg_10_1)

	return
end

local function var_0_14(arg_11_0, arg_11_1)
	if not var_0_2 then
		arg_11_1()

		return
	end

	pg.OSSMgr.GetInstance():AsynUpdateLoad(var_0_9(arg_11_0), var_0_8(arg_11_0), arg_11_1)

	return
end

function BackYardThemeTempalteUtil:FileExists()
	return PathMgr.FileExists((var_0_8(self)))
end

function BackYardThemeTempalteUtil:TakePreview(arg_13_1)
	BackYardThemeTempalteUtil.TakePhoto(self, arg_13_1)

	return
end

function BackYardThemeTempalteUtil:TakeIcon(arg_14_1)
	local var_14_0 = 426
	local var_14_1 = 320

	BackYardThemeTempalteUtil.TakePhoto(self, function(arg_15_0)
		local var_15_0

		if arg_15_0.width < var_14_0 or arg_15_0.height < var_14_1 then
			arg_14_1(arg_15_0)

			do return end

			var_15_0 = UnityEngine.Texture2D.New(var_14_0, var_14_1)
		end

		var_15_0:SetPixels((arg_15_0:GetPixels(arg_15_0.width * 0.5 - var_14_0 * 0.5, arg_15_0.height * 0.5 - var_14_1 * 0.5, var_14_0, var_14_1)))
		var_15_0:Apply()
		arg_14_1(var_15_0)

		return
	end)

	return
end

function BackYardThemeTempalteUtil:TakePhoto(arg_16_1)
	BLHX.Rendering.HotUpdate.ScreenShooterPass.TakePhoto(self, arg_16_1)

	return
end

function BackYardThemeTempalteUtil:SavePhoto(arg_17_1, arg_17_2, arg_17_3)
	seriesAsync({
		function(arg_18_0)
			ScreenShooter.SaveTextureToLocal(var_0_8(self .. "_icon"), arg_17_2, true)
			arg_18_0()

			return
		end,
		function(arg_19_0)
			onNextTick(arg_19_0)

			return
		end,
		function(arg_20_0)
			ScreenShooter.SaveTextureToLocal(var_0_8(self), arg_17_1, true)
			arg_20_0()

			return
		end
	}, function()
		if arg_17_3 then
			arg_17_3()
		end

		return
	end)

	return
end

local function var_0_15(arg_22_0)
	return _.detect(BackYardThemeTempalteUtil.caches, function(arg_23_0)
		return arg_23_0.name == arg_22_0
	end)
end

local function var_0_16(arg_24_0, arg_24_1, arg_24_2)
	local function var_24_0(arg_25_0)
		if arg_25_0 then
			BackYardThemeTempalteUtil.CheckCache()
			table.insert(BackYardThemeTempalteUtil.caches, {
				name = arg_24_0,
				asset = arg_25_0
			})
		end

		arg_24_2(arg_25_0)

		return
	end

	if not arg_24_1 or arg_24_1 == "" then
		var_24_0(nil)
	elseif BackYardThemeTempalteUtil.FileExists(arg_24_0) and arg_24_1 == var_0_10(var_0_8(arg_24_0)) then
		var_0_11(arg_24_0, arg_24_1, var_24_0)
	else
		var_0_12(arg_24_0, arg_24_1, var_24_0)
	end

	return
end

function BackYardThemeTempalteUtil:GetTexture(arg_26_1, arg_26_2)
	local var_26_0 = var_0_15(self)

	if var_26_0 then
		arg_26_2(var_26_0.asset)

		return
	end

	var_0_16(self, arg_26_1, arg_26_2)

	return
end

function BackYardThemeTempalteUtil:GetNonCacheTexture(arg_27_1, arg_27_2)
	if not arg_27_1 or arg_27_1 == "" then
		arg_27_2(nil)
	elseif BackYardThemeTempalteUtil.FileExists(self) and arg_27_1 == var_0_10(var_0_8(self)) then
		var_0_11(self, arg_27_1, arg_27_2)
	else
		var_0_12(self, arg_27_1, arg_27_2)
	end

	return
end

function BackYardThemeTempalteUtil:UploadTexture(arg_28_1)
	var_0_14(self, arg_28_1)

	return
end

function BackYardThemeTempalteUtil:DeleteTexture(arg_29_1)
	var_0_13(self, arg_29_1)

	return
end

function BackYardThemeTempalteUtil:GetMd5()
	return var_0_10((var_0_8(self)))
end

function BackYardThemeTempalteUtil:GetIconMd5()
	return BackYardThemeTempalteUtil.GetMd5(self .. "_icon")
end

function BackYardThemeTempalteUtil.CheckCache()
	if #BackYardThemeTempalteUtil.caches >= var_0_5 then
		BackYardThemeTempalteUtil.ClearCache(1)
		gcAll(false)
	end

	return
end

function BackYardThemeTempalteUtil.CheckSaveDirectory()
	local var_33_0 = var_0_7()

	if not System.IO.Directory.Exists(var_33_0) then
		System.IO.Directory.CreateDirectory(var_33_0)
	end

	return
end

function BackYardThemeTempalteUtil:ClearCaches()
	if not BackYardThemeTempalteUtil.caches or #BackYardThemeTempalteUtil.caches == 0 then
		return
	end

	for iter_34_0, iter_34_1 in ipairs(self) do
		for iter_34_2 = #BackYardThemeTempalteUtil.caches, 1, -1 do
			if BackYardThemeTempalteUtil.caches[iter_34_2].name == iter_34_1 then
				BackYardThemeTempalteUtil.ClearCache(iter_34_2, destroy)
			end
		end
	end

	return
end

function BackYardThemeTempalteUtil:ClearCache(arg_35_1)
	local var_35_0 = table.remove(BackYardThemeTempalteUtil.caches, self)

	if arg_35_1 and not IsNil(var_35_0.asset) then
		Object.Destroy(var_35_0.asset)
	end

	return
end

function BackYardThemeTempalteUtil.ClearAllCacheAsyn()
	for iter_36_0, iter_36_1 in pairs(BackYardThemeTempalteUtil.caches) do
		if not IsNil(iter_36_1.asset) then
			Object.Destroy(iter_36_1.asset)
		end
	end

	BackYardThemeTempalteUtil.caches = {}

	gcAll(false)

	return
end

function BackYardThemeTempalteUtil.ClearAllCache()
	BackYardThemeTempalteUtil.loader = {}

	BackYardThemeTempalteUtil.ClearAllCacheAsyn()

	return
end

return BackYardThemeTempalteUtil
