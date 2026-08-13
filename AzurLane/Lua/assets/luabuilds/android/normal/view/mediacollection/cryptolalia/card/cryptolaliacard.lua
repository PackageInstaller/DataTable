class = var_0_10000

local var_0_0 = var_0_10000("CryptolaliaCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_2.Find(var_1_0, "icon")
	local var_1_2 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.iconImg = var_1_2(var_1_1, var_4(var_1_10005))

	local var_1_3 = arg_1_0._tf
	local var_1_4 = var_2.Find(var_1_3, "name")
	local var_1_5 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.nameTxt = var_1_5(var_1_4, var_4(var_1_10005))

	local var_1_6 = arg_1_0._tf
	local var_1_7 = var_2.Find(var_1_6, "shipname")
	local var_1_8 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.shipNameTxt = var_1_8(var_1_7, var_4(var_1_10005))

	local var_1_9 = arg_1_0._tf
	local var_1_10 = var_2.Find(var_1_9, "time")
	local var_1_11 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.timeTxt = var_1_11(var_1_10, var_4(var_1_10005))

	local var_1_12 = arg_1_0._tf
	local var_1_13 = var_2.Find(var_1_12, "time")
	local var_1_14 = var_2.GetComponent

	typeof = var_4
	CanvasGroup = var_1_10005
	arg_1_0.timeCG = var_1_14(var_1_13, var_4(var_1_10005))

	local var_1_15 = arg_1_0._tf

	arg_1_0.selected = var_2.Find(var_1_15, "selected")

	local var_1_16 = arg_1_0._tf
	local var_1_17 = var_2.Find(var_1_16, "name/state")
	local var_1_18 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.stateBtn = var_1_18(var_1_17, var_4(var_1_10005))

	local var_1_19 = arg_1_0._tf
	local var_1_20 = var_2.Find(var_1_19, "name/state/icon")
	local var_1_21 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005
	arg_1_0.stateIcon = var_1_21(var_1_20, var_4(var_1_10005))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.cryptolalia = arg_2_1

	local var_2_0 = arg_2_1
	local var_2_1 = arg_2_1.ShipIcon(var_2_0)

	PoolMgr = var_2_0

	local var_2_2 = var_2_0.GetInstance()

	var_5.GetSprite(var_2_2, "SquareIcon/" .. var_2_1, var_2_1, true, function(arg_3_0)
		if arg_2_0.exited then
			return
		end

		arg_2_0.iconImg.sprite = arg_3_0

		return
	end)

	local var_2_3 = arg_2_0:GetColor(arg_2_3)
	local var_2_4 = arg_2_0.nameTxt

	setColorStr = var_7
	var_2_4.text = var_7(arg_2_1:GetName(), var_2_3)

	local var_2_5 = arg_2_1
	local var_2_6 = arg_2_1.GetShipName(var_2_5)

	utf8 = var_2_5

	local var_2_7 = var_2_5.len(var_2_6)

	if 11 <= var_2_7 then
		utf8 = var_2_7
		var_2_6 = var_2_7.sub(var_2_6, 1, 11) .. "..."
	end

	local var_2_8 = arg_2_0.shipNameTxt

	setColorStr = var_8
	var_2_8.text = var_8(var_2_6, var_2_3)
	arg_2_0.timeCG.alpha = arg_2_3 and 1 or 0.7

	local var_2_10

	if not arg_2_1:IsForever() then
		local var_2_9 = arg_2_1

		if arg_2_1.IsLock(var_2_9) then
			var_2_10 = arg_2_0.timeTxt
			setColorStr = var_2_9
			var_2_10.text = var_2_9(arg_2_1:GetExpiredTimeStr(), var_2_3)

			goto label_2_0
		end
	end

	var_2_10 = arg_2_0.timeTxt
	var_2_10.text = ""

	::label_2_0::

	setActive = var_2_10

	var_2_10(arg_2_0.selected, arg_2_3)

	local var_2_11, var_2_12

	if not arg_2_1:IsLock() then
		::label_2_1::

		var_2_11 = arg_2_1
		var_2_12 = not arg_2_1.IsDownloadAllRes(var_2_11)
	end

	setActive = var_2_11

	var_2_11(arg_2_0.stateBtn, var_2_12)

	if var_2_12 then
		local var_2_13 = arg_2_0:_GetColor(arg_2_3)

		arg_2_0.stateBtn.color = var_2_13
		arg_2_0.stateIcon.color = var_2_13

		local var_2_14 = var_7 and "list_panel_lock" or "list_panel_download"
		local var_2_15 = arg_2_0.stateIcon

		GetSpriteFromAtlas = var_1_10012
		var_2_15.sprite = var_1_10012("ui/CryptolaliaUI_atlas", var_2_14)
	end

	return
end

function var_0_0.GetColor(arg_4_0, arg_4_1)
	return arg_4_1 and "#C33A4A" or "#363737"
end

function var_0_0._GetColor(arg_5_0, arg_5_1)
	if arg_5_1 then
		Color = var_1_10002

		if not var_1_10002.New(0.764, 0.227, 0.29) then
			Color = var_1_10002
			var_1_10002 = var_1_10002.New(0.211, 0.215, 0.215)
		end

		return var_1_10002
	end
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.exited = true

	return
end

return var_0_0
