local var_0_0 = class("SculptureMiniMsgBoxPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "SculptureMiniMsgBoxUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.contentTxt = arg_2_0._tf:Find("frame/Text"):GetComponent(typeof(Text))
	arg_2_0.confirmBtn = arg_2_0._tf:Find("frame/btns/btn_confrim")
	arg_2_0.btnImg = arg_2_0.confirmBtn:GetComponent(typeof(Image))
	arg_2_0.cancelBtn = arg_2_0._tf:Find("frame/btns/btn_cancel")

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		arg_3_0:Hide()

		if arg_3_0.settings.onYes then
			arg_3_0.settings.onYes()
		end

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf, function()
		if arg_3_0.settings.model then
			return
		end

		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.cancelBtn, function()
		if arg_3_0.settings.model then
			return
		end

		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_7_0, arg_7_1)
	var_0_0.super.Show(arg_7_0)

	arg_7_0.settings = arg_7_1
	arg_7_0.contentTxt.text = HXSet.hxLan(arg_7_1.content)

	SetParent(arg_7_0._tf, pg.UIMgr.GetInstance().OverlayMain)

	local var_7_0 = arg_7_1.yes_text or "btn_confrim"

	arg_7_0.btnImg.sprite = GetSpriteFromAtlas("ui/SculptureUI_atlas", var_7_0)

	if arg_7_1.effect then
		arg_7_0:LoadEffect()
	end

	setActive(arg_7_0.cancelBtn, arg_7_1.showNo)

	return
end

function var_0_0.Hide(arg_8_0)
	var_0_0.super.Hide(arg_8_0)

	if arg_8_0.effectGo then
		Object.Destroy(arg_8_0.effectGo)

		arg_8_0.effectGo = nil
	end

	return
end

function var_0_0.LoadEffect(arg_9_0)
	local var_9_0 = "liwucaijian_caidai"

	if not arg_9_0.effectGo then
		ResourceMgr.Inst:getAssetAsync("ui/" .. "liwucaijian_caidai", "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_10_0)
			if arg_9_0.exited then
				return
			end

			arg_9_0.effectGo = Object.Instantiate(arg_10_0, arg_9_0._tf)
			arg_9_0.effectGo.name = var_9_0

			return
		end), true, true)
	else
		setActive(arg_9_0.effectGo, false)
		setActive(arg_9_0.effectGo, true)
	end

	return
end

function var_0_0.OnDestroy(arg_11_0)
	if arg_11_0:isShowing() then
		arg_11_0:Hide()
	end

	return
end

return var_0_0
