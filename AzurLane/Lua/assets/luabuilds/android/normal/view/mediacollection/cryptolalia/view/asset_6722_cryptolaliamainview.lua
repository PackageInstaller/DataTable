class = var_0_10000

local var_0_0 = var_0_10000("CryptolaliaMainView")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	setmetatable = var_1_10002

	var_1_10002(arg_1_0, {
		__index = function(arg_2_0, arg_2_1)
			rawget = var_2_10002

			local var_2_0

			if not var_2_10002(arg_2_0, "class")[arg_2_1] or not var_2[arg_2_1] then
				var_2_0 = arg_1_1[arg_2_1]
			end

			return var_2_0
		end
	})

	local var_1_0 = arg_1_0.downloadBtn
	local var_1_1 = var_2.GetComponent

	typeof = var_4
	Animation = var_5
	arg_1_0.downloadBtnAnim = var_1_1(var_1_0, var_4(var_5))

	return
end

function var_0_0.Flush(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_0.cryptolalia or arg_3_0.cryptolalia.id ~= arg_3_1.id then
		arg_3_0.shipName.text = arg_3_1:GetShipName()
		arg_3_0.nameTxt.text = arg_3_1:GetName()
		arg_3_0.descTxt.text = arg_3_1:GetDescription()

		local var_3_0 = arg_3_0.auditionTxt

		var_4.SetText(var_3_0, arg_3_1:GetAuditionTitle())
		arg_3_0:LoadCryptolaliaSpriteForShipGroup(arg_3_1:GetShipGroupId())

		local var_3_1 = arg_3_1
		local var_3_2

		if not arg_3_1.IsForever(var_3_1) then
			var_3_1 = arg_3_1
			var_3_2 = arg_3_1.IsLock(var_3_1)
		else
			var_3_2 = false
		end

		if false then
			var_3_2 = true
		end

		setActive = var_3_1

		var_3_1(arg_3_0.timeLimit, var_3_2)
		arg_3_0:RemoveTimer()
		arg_3_0:AddTimer(arg_3_1, var_3_2)
	end

	arg_3_0.authorTxt.text = "CV:" .. arg_3_1:GetCvAuthor(arg_3_2)

	arg_3_0:FlushState(arg_3_1, arg_3_2, arg_3_3)

	arg_3_0.cryptolalia = arg_3_1

	return
end

function var_0_0.AddTimer(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 then
		local var_4_0 = ""

		Timer = var_1_10004
		arg_4_0.timer = var_1_10004.New(function()
			local var_5_0 = arg_4_1
			local var_5_1 = var_0.GetExpiredTimeStr(var_5_0)

			if var_4_0 ~= var_5_1 then
				var_4_0 = var_5_1
				arg_4_0.timeTxt.text = var_5_1
			end

			return
		end, 1, -1)

		local var_4_1 = arg_4_0.timer

		var_4.Start(var_4_1)
		arg_4_0.timer.func()
	else
		arg_4_0.timeTxt.text = ""
	end

	return
end

function var_0_0.FlushState(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_3 then
		Cryptolalia = var_1_10004

		local var_6_0

		if not var_1_10004.STATE_DOWNLOADING then
			var_1_10005 = arg_6_1
			var_6_0 = arg_6_1.GetState(var_1_10005, arg_6_2)
		end

		setActive = var_1_10005

		local var_6_1 = arg_6_0.lockBtn

		Cryptolalia = var_1_10007

		var_1_10005(var_6_1, var_1_10007.STATE_LOCK == var_6_0)

		setActive = var_1_10005

		local var_6_2 = arg_6_0.downloadBtn

		Cryptolalia = var_7

		var_1_10005(var_6_2, var_7.STATE_DOWNLOADABLE == var_6_0)

		local var_6_3

		if arg_6_0.state then
			var_6_3 = arg_6_0.state
			Cryptolalia = var_6_2

			if var_6_3 == var_6_2.STATE_LOCK then
				Cryptolalia = var_6_3

				if var_6_0 == var_6_3.STATE_DOWNLOADABLE then
					local var_6_4 = arg_6_0.downloadBtnAnim

					var_6_3.Stop(var_6_4)

					local var_6_5 = arg_6_0.downloadBtnAnim

					var_6_3.Play(var_6_5, "anim_Cryptolalia_dowmload")
				end
			end
		end

		setSlider = var_6_3

		var_6_3(arg_6_0.downloadingBtn, 0, 1, 0)

		setActive = var_6_3

		local var_6_6 = arg_6_0.downloadingBtn

		Cryptolalia = var_7

		var_6_3(var_6_6, var_6_0 == var_7.STATE_DOWNLOADING)

		setActive = var_6_3

		local var_6_7 = arg_6_0.playBtn

		Cryptolalia = var_7

		var_6_3(var_6_7, var_7.STATE_PLAYABLE == var_6_0)

		setActive = var_6_3

		local var_6_8 = arg_6_0.deleteBtn

		Cryptolalia = var_7

		var_6_3(var_6_8, var_7.STATE_PLAYABLE == var_6_0)

		setText = var_6_3

		local var_6_9 = arg_6_0.deleteBtn
		local var_6_10 = var_6.Find(var_6_9, "label")

		i18n = var_6_9

		var_6_3(var_6_10, var_6_9("cryptolalia_delete_res", arg_6_1:GetResSize(arg_6_2)))

		setActive = var_6_3

		local var_6_11 = arg_6_0.stateBtn

		Cryptolalia = var_7

		var_6_3(var_6_11, var_7.STATE_PLAYABLE ~= var_6_0)

		setActive = var_6_3

		local var_6_12 = arg_6_0.switchBtn

		Cryptolalia = var_7

		local var_6_13

		if var_6_0 ~= var_7.STATE_DOWNLOADING then
			PLATFORM_CODE = var_7
			PLATFORM_CH = var_8

			if var_7 == var_8 then
				var_6_13 = arg_6_1:IsMultiVersion()

				goto label_6_0
			end
		end

		var_6_13 = false

		if false then
			var_6_13 = true
		end

		::label_6_0::

		var_6_3(var_6_12, var_6_13)

		Vector2 = var_6_3

		local var_6_14 = var_6_3(0, 0)

		Vector2 = var_6

		local var_6_15 = var_6(20, -9.2)

		Cryptolalia = var_7

		local var_6_16 = arg_6_2 == var_7.LANG_TYPE_CH

		setAnchoredPosition = var_8

		local var_6_17 = arg_6_0.switchBtn

		var_8(var_9.Find(var_6_17, "ch"), var_6_16 and var_6_14 or var_6_15)

		setAnchoredPosition = var_8

		local var_6_18 = arg_6_0.switchBtn

		var_8(var_9.Find(var_6_18, "jp"), var_6_16 and var_6_15 or var_6_14)

		setActive = var_8

		local var_6_19 = arg_6_0.listBtn

		Cryptolalia = var_10

		var_8(var_6_19, var_6_0 ~= var_10.STATE_DOWNLOADING)

		Cryptolalia = var_8

		local var_6_20

		if var_8.STATE_LOCK == var_6_0 then
			var_6_20 = arg_6_0.stateBtnTxt
			i18n = var_6_19
			var_6_20.text = var_6_19("cryptolalia_lock_res")
		else
			Cryptolalia = var_6_20

			if var_6_20.STATE_PLAYABLE ~= var_6_0 then
				local var_6_21 = arg_6_0.stateBtnTxt

				i18n = var_6_19
				var_6_21.text = var_6_19("cryptolalia_not_download_res")
			else
				arg_6_0.stateBtnTxt.text = ""
			end
		end

		arg_6_0.state = var_6_0

		return
	end
end

local function var_0_1(arg_7_0, arg_7_1, arg_7_2)
	LoadSpriteAtlasAsync = var_1_10003

	var_1_10003("CryptolaliaShip/" .. arg_7_1, "cd", function(arg_8_0)
		if arg_7_0.exited then
			return
		end

		arg_7_0.cdImg.sprite = arg_8_0

		local var_8_0 = arg_7_0.cdImg

		var_1.SetNativeSize(var_8_0)
		arg_7_2()

		return
	end)

	return
end

local function var_0_2(arg_9_0, arg_9_1, arg_9_2)
	LoadSpriteAtlasAsync = var_1_10003

	var_1_10003("CryptolaliaShip/" .. arg_9_1, "name", function(arg_10_0)
		if arg_9_0.exited then
			return
		end

		arg_9_0.cdSignatureImg.sprite = arg_10_0

		local var_10_0 = arg_9_0.cdSignatureImg

		var_1.SetNativeSize(var_10_0)
		arg_9_2()

		return
	end)

	return
end

local function var_0_3(arg_11_0, arg_11_1, arg_11_2)
	LoadSpriteAtlasAsync = var_1_10003

	var_1_10003("CryptolaliaShip/" .. arg_11_1, "name", function(arg_12_0)
		if arg_11_0.exited then
			return
		end

		arg_11_0.signatureImg.sprite = arg_12_0

		local var_12_0 = arg_11_0.signatureImg

		var_1.SetNativeSize(var_12_0)
		arg_11_2()

		return
	end)

	return
end

function var_0_0.LoadCryptolaliaSpriteForShipGroup(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.cg

	var_13_0.blocksRaycasts = false
	parallelAsync = var_13_0

	var_13_0({
		function(arg_14_0)
			var_0_1(arg_13_0, arg_13_1, arg_14_0)

			return
		end
	}, function()
		arg_13_0.cg.blocksRaycasts = true

		return
	end)

	return
end

function var_0_0.RemoveTimer(arg_16_0)
	if arg_16_0.timer then
		local var_16_0 = arg_16_0.timer

		var_1.Stop(var_16_0)

		arg_16_0.timer = nil
	end

	return
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0.exited = true

	arg_17_0:RemoveTimer()

	return
end

return var_0_0
