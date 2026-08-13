class = var_0_10000

local var_0_0 = "MainBannerView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.MainBaseView"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	BannerScrollRect = var_3

	local var_1_0 = var_3.New

	findTF = var_5

	local var_1_1 = var_5(arg_1_1, "mask/content")

	findTF = var_6
	arg_1_0.scrollSnap = var_1_0(var_1_1, var_6(arg_1_1, "dots"))
	BulletinBoardMgr = var_3
	arg_1_0.downloadmgr = var_3.Inst
	arg_1_0.rawImages = {}

	return
end

function var_0_1.Init(arg_2_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_2_0 = var_1_10001(var_1_10003)
	local var_2_1 = var_1.getBannerDisplays(var_2_0)

	arg_2_0:UpdateItems(var_2_1)

	arg_2_0.banners = var_2_1

	return
end

function var_0_1.Refresh(arg_3_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)
	local var_3_1 = var_1.getBannerDisplays(var_3_0)

	if #arg_3_0.banners ~= #var_3_1 then
		arg_3_0:Clear()
		arg_3_0:Init()
	else
		local var_3_2 = arg_3_0.scrollSnap

		var_2.Resume(var_3_2)
	end

	return
end

function var_0_1.UpdateItems(arg_4_0, arg_4_1)
	for iter_4_0 = 0, #arg_4_1 - 1 do
		local var_4_0 = arg_4_1[iter_4_0 + 1]
		local var_4_1 = arg_4_0.scrollSnap
		local var_4_2 = var_7.AddChild(var_4_1)

		arg_4_0:UpdateItemImage(var_4_0, var_4_2)

		local var_4_5

		if var_4_0.type == 3 then
			tonumber = var_8

			if var_8(var_4_0.param) == nil then
				getProxy = var_8
				ActivityProxy = var_10

				local var_4_3 = var_8(var_10)
				local var_4_4 = var_8.readyToAchieveByType

				ActivityConst = var_11
				var_4_5 = var_4_4(var_4_3, var_11.ACTIVITY_TYPE_LEVELAWARD)

				goto label_4_0
			end
		end

		var_4_5 = false

		if false then
			var_4_5 = true
		end

		::label_4_0::

		setActive = var_4_1
		findTF = var_11

		var_4_1(var_11(var_4_2, "red"), var_4_5)

		onButton = var_4_1

		local var_4_6 = arg_4_0
		local var_4_7 = var_4_2

		local function var_4_8()
			local var_5_0 = arg_4_0

			var_0.Tracking(var_5_0, var_4_0.id)

			MainBaseActivityBtn = var_0

			var_0.Skip(arg_4_0, var_4_0)

			return
		end

		SFX_MAIN = var_14

		var_4_1(var_4_6, var_4_7, var_4_8, var_14)
	end

	local var_4_9 = arg_4_0.scrollSnap

	var_2.SetUp(var_4_9)

	return
end

function var_0_1.GetItemPicPath(arg_6_0, arg_6_1)
	PLATFORM_CODE = var_1_10002
	PLATFORM_CH = var_1_10003

	if var_1_10002 == var_1_10003 then
		HXSet = var_1_10002

		if var_1_10002.isHx() then
			pg = var_2

			local var_6_0 = var_2.SdkMgr.GetInstance()
			local var_6_1 = var_2.GetChannelUIDIncludeHarmony(var_6_0)
			local var_6_2

			if not arg_6_1.pic_hx then
				var_6_2 = {}
			end

			if #var_6_2 <= 0 then
				return arg_6_1.pic
			end

			_ = var_4

			if not var_4.detect(var_6_2, function(arg_7_0)
				return arg_7_0[1] == var_6_1
			end) then
				return arg_6_1.pic
			end

			local var_6_3

			if not var_4[2] then
				var_6_3 = arg_6_1.pic
			end

			do return var_6_3 end
			return
		end
	end

	return arg_6_1.pic
end

function var_0_1.UpdateItemImage(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_2:Find("texture")
	local var_8_1 = arg_8_2
	local var_8_2 = arg_8_2.Find(var_8_1, "image")
	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.GetItemPicPath(var_8_3, arg_8_1)

	StringStartsWith = var_8_1

	local var_8_5

	if not var_8_1(var_8_4, "https://") then
		StringStartsWith = var_8_5
		var_8_5 = var_8_5(var_8_4, "http://")
	end

	setActive = var_8_3

	var_8_3(var_8_0, var_8_5)

	setActive = var_8_3

	var_8_3(var_8_2, not var_8_5)

	if var_8_5 then
		local var_8_6 = arg_8_0.downloadmgr

		var_8_3 = var_8_3.GetTexture

		local var_8_7 = "main_banner"
		local var_8_8 = "1"
		local var_8_9 = var_8_4

		UnityEngine = var_1_10013

		var_8_3(var_8_6, var_8_7, var_8_8, var_8_9, var_1_10013.Events.UnityAction_UnityEngine_Texture(function(arg_9_0)
			if not arg_8_0.exited then
				IsNil = var_1

				if var_1(var_8_0) then
					return
				end

				local var_9_0 = var_8_0
				local var_9_1 = var_1.GetComponent

				typeof = var_2_10004
				RawImage = var_2_10006

				local var_9_2 = var_9_1(var_9_0, var_2_10004(var_2_10006))

				var_9_2.texture = arg_9_0
				table = var_2_10002

				var_2_10002.insert(arg_8_0.rawImages, var_9_2)

				return
			end
		end))
	else
		LoadImageSpriteAsync = var_8_3

		var_8_3("activitybanner/" .. var_8_4, var_8_2)
	end

	return
end

function var_0_1.Tracking(arg_10_0, arg_10_1)
	pg = var_1_10002

	local var_10_0 = var_1_10002.GameTrackerMgr.GetInstance()
	local var_10_1 = var_2.Record

	GameTrackerBuilder = var_1_10005

	var_10_1(var_10_0, var_1_10005.BuildTouchBanner(arg_10_1))

	return
end

function var_0_1.GetDirection(arg_11_0)
	Vector2 = var_1_10001

	return var_1_10001(1, 0)
end

function var_0_1.Disable(arg_12_0)
	local var_12_0 = arg_12_0.scrollSnap

	var_1.Pause(var_12_0)

	return
end

function var_0_1.Clear(arg_13_0)
	local var_13_0 = arg_13_0.scrollSnap

	var_1.Reset(var_13_0)

	return
end

function var_0_1.Dispose(arg_14_0)
	var_0_1.super.Dispose(arg_14_0)

	ipairs = var_1

	for iter_14_0, iter_14_1 in var_1(arg_14_0.rawImages) do
		iter_14_1.texture = nil
	end

	arg_14_0.rawImages = nil

	arg_14_0:Clear()

	local var_14_0 = arg_14_0.scrollSnap

	var_1.Dispose(var_14_0)

	arg_14_0.scrollSnap = nil
	arg_14_0.exited = true
	arg_14_0.downloadmgr = nil

	return
end

return var_0_1
