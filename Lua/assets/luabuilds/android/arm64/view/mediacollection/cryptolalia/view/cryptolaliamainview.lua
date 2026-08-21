local var_0_0 = class("CryptolaliaMainView")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	setmetatable(arg_1_0, {
		__index = function(arg_2_0, arg_2_1)
			local var_2_0 = rawget(arg_2_0, "class")

			if var_2_0[arg_2_1] then
				return var_2_0[arg_2_1] or arg_1_1[arg_2_1]
			end
		end
	})

	arg_1_0.downloadBtnAnim = arg_1_0.downloadBtn:GetComponent(typeof(Animation))

	return
end

function var_0_0.Flush(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_0.cryptolalia or arg_3_0.cryptolalia.id ~= arg_3_1.id then
		arg_3_0.shipName.text = arg_3_1:GetShipName()
		arg_3_0.nameTxt.text = arg_3_1:GetName()
		arg_3_0.descTxt.text = arg_3_1:GetDescription()

		arg_3_0.auditionTxt:SetText(arg_3_1:GetAuditionTitle())
		arg_3_0:LoadCryptolaliaSpriteForShipGroup(arg_3_1:GetShipGroupId())

		local var_3_0 = not arg_3_1:IsForever() and arg_3_1:IsLock()

		setActive(arg_3_0.timeLimit, var_3_0)
		arg_3_0:RemoveTimer()
		arg_3_0:AddTimer(arg_3_1, var_3_0)
	end

	arg_3_0.authorTxt.text = "CV:" .. arg_3_1:GetCvAuthor(arg_3_2)

	arg_3_0:FlushState(arg_3_1, arg_3_2, arg_3_3)

	arg_3_0.cryptolalia = arg_3_1

	return
end

function var_0_0.AddTimer(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 then
		local var_4_0 = ""

		arg_4_0.timer = Timer.New(function()
			local var_5_0 = arg_4_1:GetExpiredTimeStr()

			if var_4_0 ~= var_5_0 then
				var_4_0 = var_5_0
				arg_4_0.timeTxt.text = var_5_0
			end

			return
		end, 1, -1)

		arg_4_0.timer:Start()
		arg_4_0.timer.func()
	else
		arg_4_0.timeTxt.text = ""
	end

	return
end

function var_0_0.FlushState(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_3 then
		local var_6_0 = Cryptolalia.STATE_DOWNLOADING or arg_6_1:GetState(arg_6_2)

		setActive(arg_6_0.lockBtn, Cryptolalia.STATE_LOCK == var_6_0)
		setActive(arg_6_0.downloadBtn, Cryptolalia.STATE_DOWNLOADABLE == var_6_0)

		if arg_6_0.state and arg_6_0.state == Cryptolalia.STATE_LOCK and var_6_0 == Cryptolalia.STATE_DOWNLOADABLE then
			arg_6_0.downloadBtnAnim:Stop()
			arg_6_0.downloadBtnAnim:Play("anim_Cryptolalia_dowmload")
		end

		setSlider(arg_6_0.downloadingBtn, 0, 1, 0)
		setActive(arg_6_0.downloadingBtn, var_6_0 == Cryptolalia.STATE_DOWNLOADING)
		setActive(arg_6_0.playBtn, Cryptolalia.STATE_PLAYABLE == var_6_0)
		setActive(arg_6_0.deleteBtn, Cryptolalia.STATE_PLAYABLE == var_6_0)
		setText(arg_6_0.deleteBtn:Find("label"), i18n("cryptolalia_delete_res", arg_6_1:GetResSize(arg_6_2)))
		setActive(arg_6_0.stateBtn, Cryptolalia.STATE_PLAYABLE ~= var_6_0)
		setActive(arg_6_0.switchBtn, var_6_0 ~= Cryptolalia.STATE_DOWNLOADING and PLATFORM_CODE == PLATFORM_CH and arg_6_1:IsMultiVersion())

		local var_6_1 = Vector2(0, 0)
		local var_6_2 = Vector2(20, -9.2)
		local var_6_3 = arg_6_2 == Cryptolalia.LANG_TYPE_CH

		setAnchoredPosition(arg_6_0.switchBtn:Find("ch"), arg_6_2 == Cryptolalia.LANG_TYPE_CH and var_6_1 or var_6_2)
		setAnchoredPosition(arg_6_0.switchBtn:Find("jp"), var_6_3 and var_6_2 or var_6_1)
		setActive(arg_6_0.listBtn, var_6_0 ~= Cryptolalia.STATE_DOWNLOADING)

		arg_6_0.stateBtnTxt.text = Cryptolalia.STATE_LOCK == var_6_0 and i18n("cryptolalia_lock_res") or Cryptolalia.STATE_PLAYABLE ~= var_6_0 and i18n("cryptolalia_not_download_res") or ""
		arg_6_0.state = var_6_0

		return
	end
end

local function var_0_1(arg_7_0, arg_7_1, arg_7_2)
	LoadSpriteAtlasAsync("CryptolaliaShip/" .. arg_7_1, "cd", function(arg_8_0)
		if arg_7_0.exited then
			return
		end

		arg_7_0.cdImg.sprite = arg_8_0

		arg_7_0.cdImg:SetNativeSize()
		arg_7_2()

		return
	end)

	return
end

function var_0_0.LoadCryptolaliaSpriteForShipGroup(arg_13_0, arg_13_1)
	arg_13_0.cg.blocksRaycasts = false

	parallelAsync({
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
		arg_16_0.timer:Stop()

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
