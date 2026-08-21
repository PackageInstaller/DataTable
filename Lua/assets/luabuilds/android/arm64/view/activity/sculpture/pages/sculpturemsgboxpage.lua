local var_0_0 = class("SculptureMsgBoxPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "SculptureMsgboxUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.contentTxt = arg_2_0._tf:Find("frame/Text"):GetComponent(typeof(Text))
	arg_2_0.nextBtn = arg_2_0._tf:Find("frame/btn")
	arg_2_0.confirmBtn = arg_2_0._tf:Find("frame/btn_confrim")
	arg_2_0.consumeTr = arg_2_0._tf:Find("frame/consume")
	arg_2_0.consumeTxt = arg_2_0._tf:Find("frame/consume/Text"):GetComponent(typeof(Text))
	arg_2_0.consumeIcon = arg_2_0._tf:Find("frame/consume/icon"):GetComponent(typeof(Image))
	arg_2_0.role = arg_2_0._tf:Find("frame/role"):GetComponent(typeof(Image))
	arg_2_0.title = arg_2_0._tf:Find("frame/title/Text"):GetComponent(typeof(Image))

	setText(arg_2_0._tf:Find("frame/tip"), i18n("sculpture_close_tip"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		if arg_3_0.settings.onYes then
			arg_3_0.settings.onYes()
		end

		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.nextBtn, function()
		if arg_3_0.settings.onYes then
			arg_3_0.settings.onYes()
		end

		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_7_0, arg_7_1)
	var_0_0.super.Show(arg_7_0)

	arg_7_0.settings = arg_7_1
	arg_7_0.contentTxt.text = HXSet.hxLan(arg_7_1.content)

	setActive(arg_7_0.consumeTr, arg_7_1.consume)

	if arg_7_1.consume then
		arg_7_0.consumeTxt.text = arg_7_1.consume
		arg_7_0.consumeIcon.sprite = LoadSprite("props/" .. pg.activity_workbench_item[arg_7_1.consumeId].icon)
		rtf(arg_7_0.consumeIcon.gameObject).sizeDelta = Vector2(60, 60)
	else
		rtf(arg_7_0.consumeIcon.gameObject).sizeDelta = Vector2(0, 0)
	end

	if arg_7_1.iconName then
		arg_7_0:LoadChar(arg_7_1.iconName)
	else
		arg_7_0:ClearChar()
	end

	arg_7_0.title.sprite = arg_7_1.title and GetSpriteFromAtlas("ui/SculptureUI_atlas", arg_7_1.title) or GetSpriteFromAtlas("ui/SculptureUI_atlas", "item_title")

	arg_7_0.title:SetNativeSize()
	setActive(arg_7_0.nextBtn, arg_7_1.nextBtn)
	setActive(arg_7_0.confirmBtn, not arg_7_1.nextBtn)

	return
end

function var_0_0.LoadChar(arg_8_0, arg_8_1)
	if arg_8_0.charName == arg_8_1 then
		return
	end

	arg_8_0:ClearChar()
	PoolMgr.GetInstance():GetSpineChar("takegift_" .. arg_8_1, true, function(arg_9_0)
		arg_9_0.transform:SetParent(arg_8_0.role.gameObject.transform.parent)

		arg_9_0.transform.localScale = Vector3(0.8, 0.8, 0)
		arg_9_0.transform.localPosition = Vector3(550, -300, 0)

		arg_9_0:GetComponent(typeof(SpineAnimUI)):SetAction("gift_wait_" .. arg_8_1, 0)

		arg_8_0.charGo = arg_9_0

		return
	end)

	arg_8_0.charName = arg_8_1

	return
end

function var_0_0.ClearChar(arg_10_0)
	if arg_10_0.charName and arg_10_0.charGo then
		PoolMgr.GetInstance():ReturnSpineChar(arg_10_0.charName, arg_10_0.charGo)

		arg_10_0.charName = nil
		arg_10_0.charGo = nil
	end

	return
end

function var_0_0.OnDestroy(arg_11_0)
	arg_11_0:ClearChar()

	return
end

return var_0_0
