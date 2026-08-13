class = var_0_10000

local var_0_0 = var_0_10000("ValentineQteGameResultWindow")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)

	arg_1_0._tf = arg_1_1
	arg_1_0._parentTf = arg_1_1.parent
	arg_1_0.backBtn = arg_1_1:Find("back")
	arg_1_0.shareBtn = arg_1_1:Find("share")

	local var_1_0 = arg_1_1:Find("frame/score/Text")
	local var_1_1 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.scoreTxt = var_1_1(var_1_0, var_4(var_1_10005))

	local var_1_2 = arg_1_1:Find("frame/content/Perfect/value/Text")
	local var_1_3 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.perfectTxt = var_1_3(var_1_2, var_4(var_1_10005))

	local var_1_4 = arg_1_1:Find("frame/content/Great/value/Text")
	local var_1_5 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.greatTxt = var_1_5(var_1_4, var_4(var_1_10005))

	local var_1_6 = arg_1_1:Find("frame/content/Good/value/Text")
	local var_1_7 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.goodTxt = var_1_7(var_1_6, var_4(var_1_10005))

	local var_1_8 = arg_1_1:Find("frame/content/Miss/value/Text")
	local var_1_9 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.missTxt = var_1_9(var_1_8, var_4(var_1_10005))

	local var_1_10 = arg_1_1:Find("frame/content/Combo/value/Text")
	local var_1_11 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.comboTxt = var_1_11(var_1_10, var_4(var_1_10005))

	local var_1_12 = arg_1_1:Find("chat/Text")
	local var_1_13 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.chatTxt = var_1_13(var_1_12, var_4(var_1_10005))

	local var_1_14 = arg_1_1:Find("frame/Text")
	local var_1_15 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.nameTxt = var_1_15(var_1_14, var_4(var_1_10005))

	arg_1_0:Init()

	setText = var_2

	local var_1_16 = arg_1_1
	local var_1_17 = arg_1_1.Find(var_1_16, "frame/score/label")

	i18n = var_1_16

	var_2(var_1_17, var_1_16("Valentine_minigame_label1"))

	local var_1_18 = arg_1_0.nameTxt

	getProxy = var_1_17
	PlayerProxy = var_4

	local var_1_19 = var_1_17(var_4)
	local var_1_20 = var_3.getRawData(var_1_19)

	var_1_18.text = var_3.GetName(var_1_20)
	setActive = var_1_18

	var_1_18(arg_1_0.nameTxt.gameObject, false)

	return
end

function var_0_0.Init(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.backBtn

	local function var_2_2()
		if arg_2_0.callback then
			arg_2_0.callback()
		end

		local var_3_0 = arg_2_0

		var_0.Hide(var_3_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10005)

	onButton = var_1_10001

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.shareBtn

	local function var_2_5()
		pg = var_2_10000

		local var_4_0 = var_2_10000.ShareMgr.GetInstance()
		local var_4_1 = var_0.Share

		pg = var_2_10002

		var_4_1(var_4_0, var_2_10002.ShareMgr.TypeValentineQte)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_3, var_2_4, var_2_5, var_1_10005)

	return
end

function var_0_0.Show(arg_5_0, arg_5_1, arg_5_2)
	pg = var_1_10003

	local var_5_0 = var_1_10003.UIMgr.GetInstance()

	var_3.BlurPanel(var_5_0, arg_5_0._tf)

	arg_5_0.statistics = arg_5_1
	arg_5_0.callback = arg_5_2
	setActive = var_3

	var_3(arg_5_0._tf, true)
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

	ipairs = var_1_10003
	ValentineQteGameConst = var_1_10004

	for iter_7_0, iter_7_1 in var_1_10003(var_1_10004.CHAT_CONTENT) do
		local var_7_1 = iter_7_1[1]
		local var_7_2 = iter_7_1[2]
		local var_7_3 = iter_7_1[3]

		if var_7_1 <= arg_7_1 and arg_7_1 <= var_7_2 then
			var_7_0 = var_7_3

			break
		end
	end

	if var_7_0 then
		i18n = var_3

		return var_3("2025Valentine_minigame_" .. var_7_0)
	else
		return ""
	end

	return
end

function var_0_0.Hide(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_8_0, arg_8_0._tf, arg_8_0._parentTf)

	arg_8_0.callback = nil
	setActive = var_1

	var_1(arg_8_0._tf, false)

	return
end

function var_0_0.Destroy(arg_9_0)
	arg_9_0:Hide()

	pg = var_1

	var_1.DelegateInfo.Dispose(arg_9_0)

	return
end

return var_0_0
