local var_0_0 = class("ValentineQteGameResultWindow")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0._tf = arg_1_1
	arg_1_0._parentTf = arg_1_1.parent
	arg_1_0.backBtn = arg_1_1:Find("back")
	arg_1_0.shareBtn = arg_1_1:Find("share")
	arg_1_0.scoreTxt = arg_1_1:Find("frame/score/Text"):GetComponent(typeof(Text))
	arg_1_0.perfectTxt = arg_1_1:Find("frame/content/Perfect/value/Text"):GetComponent(typeof(Text))
	arg_1_0.greatTxt = arg_1_1:Find("frame/content/Great/value/Text"):GetComponent(typeof(Text))
	arg_1_0.goodTxt = arg_1_1:Find("frame/content/Good/value/Text"):GetComponent(typeof(Text))
	arg_1_0.missTxt = arg_1_1:Find("frame/content/Miss/value/Text"):GetComponent(typeof(Text))
	arg_1_0.comboTxt = arg_1_1:Find("frame/content/Combo/value/Text"):GetComponent(typeof(Text))
	arg_1_0.chatTxt = arg_1_1:Find("chat/Text"):GetComponent(typeof(Text))
	arg_1_0.nameTxt = arg_1_1:Find("frame/Text"):GetComponent(typeof(Text))

	arg_1_0:Init()
	setText(arg_1_1:Find("frame/score/label"), i18n("Valentine_minigame_label1"))

	arg_1_0.nameTxt.text = getProxy(PlayerProxy):getRawData():GetName()

	setActive(arg_1_0.nameTxt.gameObject, false)

	return
end

function var_0_0.Init(arg_2_0)
	onButton(arg_2_0, arg_2_0.backBtn, function()
		if arg_2_0.callback then
			arg_2_0.callback()
		end

		arg_2_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.shareBtn, function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeValentineQte)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_5_0, arg_5_1, arg_5_2)
	pg.UIMgr.GetInstance():BlurPanel(arg_5_0._tf)

	arg_5_0.statistics = arg_5_1
	arg_5_0.callback = arg_5_2

	setActive(arg_5_0._tf, true)
	arg_5_0:Flush()

	return
end

function var_0_0.Flush(arg_6_0)
	arg_6_0.scoreTxt.text = arg_6_0.statistics.Score
	arg_6_0.perfectTxt.text = arg_6_0.statistics.Perfect
	arg_6_0.greatTxt.text = arg_6_0.statistics.Great
	arg_6_0.goodTxt.text = arg_6_0.statistics.Good
	arg_6_0.missTxt.text = arg_6_0.statistics.Miss
	arg_6_0.comboTxt.text = arg_6_0.statistics.Combo
	arg_6_0.chatTxt.text = arg_6_0:GetChatTxt(arg_6_0.statistics.Score)

	return
end

function var_0_0.GetChatTxt(arg_7_0, arg_7_1)
	local var_7_0

	for iter_7_0, iter_7_1 in ipairs(ValentineQteGameConst.CHAT_CONTENT) do
		if iter_7_1[1] <= arg_7_1 and arg_7_1 <= iter_7_1[2] then
			var_7_0 = iter_7_1[3]

			break
		end
	end

	if var_7_0 then
		return i18n("2025Valentine_minigame_" .. var_7_0)
	else
		return ""
	end

	return
end

function var_0_0.Hide(arg_8_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_8_0._tf, arg_8_0._parentTf)

	arg_8_0.callback = nil

	setActive(arg_8_0._tf, false)

	return
end

function var_0_0.Destroy(arg_9_0)
	arg_9_0:Hide()
	pg.DelegateInfo.Dispose(arg_9_0)

	return
end

return var_0_0
