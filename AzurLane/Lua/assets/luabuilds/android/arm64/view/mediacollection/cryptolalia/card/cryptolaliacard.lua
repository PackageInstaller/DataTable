local var_0_0 = class("CryptolaliaCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.iconImg = arg_1_0._tf:Find("icon"):GetComponent(typeof(Image))
	arg_1_0.nameTxt = arg_1_0._tf:Find("name"):GetComponent(typeof(Text))
	arg_1_0.shipNameTxt = arg_1_0._tf:Find("shipname"):GetComponent(typeof(Text))
	arg_1_0.timeTxt = arg_1_0._tf:Find("time"):GetComponent(typeof(Text))
	arg_1_0.timeCG = arg_1_0._tf:Find("time"):GetComponent(typeof(CanvasGroup))
	arg_1_0.selected = arg_1_0._tf:Find("selected")
	arg_1_0.stateBtn = arg_1_0._tf:Find("name/state"):GetComponent(typeof(Image))
	arg_1_0.stateIcon = arg_1_0._tf:Find("name/state/icon"):GetComponent(typeof(Image))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.cryptolalia = arg_2_1

	local var_2_0 = arg_2_1:ShipIcon()

	PoolMgr.GetInstance():GetSprite("SquareIcon/" .. var_2_0, var_2_0, true, function(arg_3_0)
		if arg_2_0.exited then
			return
		end

		arg_2_0.iconImg.sprite = arg_3_0

		return
	end)

	local var_2_1 = arg_2_0:GetColor(arg_2_3)

	arg_2_0.nameTxt.text = setColorStr(arg_2_1:GetName(), var_2_1)

	local var_2_2 = arg_2_1:GetShipName()

	if utf8.len(var_2_2) >= 11 then
		var_2_2 = utf8.sub(var_2_2, 1, 11) .. "..."
	end

	arg_2_0.shipNameTxt.text = setColorStr(var_2_2, var_2_1)
	arg_2_0.timeCG.alpha = arg_2_3 and 1 or 0.7
	arg_2_0.timeTxt.text = not arg_2_1:IsForever() and arg_2_1:IsLock() and setColorStr(arg_2_1:GetExpiredTimeStr(), var_2_1) or ""

	setActive(arg_2_0.selected, arg_2_3)

	local var_2_3 = arg_2_1:IsLock()
	local var_2_4 = var_2_3 or not arg_2_1:IsDownloadAllRes()

	setActive(arg_2_0.stateBtn, var_2_4)

	if var_2_4 then
		local var_2_5 = arg_2_0:_GetColor(arg_2_3)

		arg_2_0.stateBtn.color = var_2_5
		arg_2_0.stateIcon.color = var_2_5
		arg_2_0.stateIcon.sprite = GetSpriteFromAtlas("ui/CryptolaliaUI_atlas", var_2_3 and "list_panel_lock" or "list_panel_download")
	end

	return
end

function var_0_0.GetColor(arg_4_0, arg_4_1)
	return arg_4_1 and "#C33A4A" or "#363737"
end

function var_0_0._GetColor(arg_5_0, arg_5_1)
	return arg_5_1 and Color.New(0.764, 0.227, 0.29) or Color.New(0.211, 0.215, 0.215)
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.exited = true

	return
end

return var_0_0
