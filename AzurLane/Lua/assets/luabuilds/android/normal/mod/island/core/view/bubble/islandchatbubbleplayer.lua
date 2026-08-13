class = var_0_10000

local var_0_0 = "IslandChatBubblePlayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("Mgr.Story.model.animation.StoryAnimtion"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0.tpl = arg_1_1
	arg_1_0.role = arg_1_2

	local var_1_0 = arg_1_0.tpl.transform

	arg_1_0.contentTr = var_3.Find(var_1_0, "content")

	local var_1_1 = arg_1_0.tpl.transform

	arg_1_0.emojiContainer = var_3.Find(var_1_1, "face")

	local var_1_2 = arg_1_0.tpl.transform

	arg_1_0.expressionContainer = var_3.Find(var_1_2, "expression")

	local var_1_3 = arg_1_0.contentTr
	local var_1_4 = var_3.Find(var_1_3, "Text")

	arg_1_0.contentTxt = var_3.GetComponent(var_1_4, "RichText")
	arg_1_0.isPlaying = false
	arg_1_0.canShowFlag = true

	return
end

function var_0_1.Play(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:Stop()

	arg_2_0.canShowFlag = true
	arg_2_0.isPlaying = true
	seriesAsync = var_3

	var_3({
		function(arg_3_0)
			local var_3_0 = arg_2_0

			var_1.ClearEmojiAndExpressionEmoji(var_3_0)

			local var_3_1 = arg_2_0

			var_1.ShowOrHide(var_3_1, true)

			local var_3_2 = arg_2_0

			var_1.UpdateBubble(var_3_2, arg_2_1, arg_3_0)

			return
		end,
		function(arg_4_0)
			local var_4_0 = arg_2_0

			var_1.WaitForNextOne(var_4_0, arg_2_1, arg_4_0)

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_2_0

			var_1.EneAction(var_5_0, arg_2_1)

			arg_2_0.isPlaying = false
			arg_2_0.canShowFlag = false

			arg_5_0()

			return
		end
	}, arg_2_2)

	return
end

function var_0_1.UpdateBubble(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:PlayCharatorAnimation(arg_6_1)

	local var_6_0 = arg_6_1:ExistEmoji()
	local var_6_1 = arg_6_1
	local var_6_2 = arg_6_1.GetEmojiType(var_6_1)

	setActive = var_6_1

	var_6_1(arg_6_0.contentTr, not var_6_0)

	setActive = var_6_1

	local var_6_3 = arg_6_0.emojiContainer
	local var_6_4

	if var_6_0 then
		::label_6_0::

		BubbleStep = var_6_4
		var_6_4 = var_6_2 == var_6_4.EMOJI_TYPE_CHAT
	end

	var_6_1(var_6_3, var_6_4)

	setActive = var_6_1

	local var_6_5 = arg_6_0.expressionContainer

	if var_6_0 then
		::label_6_1::

		BubbleStep = var_6_4
		var_6_4 = var_6_2 == var_6_4.EMOJI_TYPE_EXPRESSION
	end

	var_6_1(var_6_5, var_6_4)

	if var_6_0 then
		arg_6_0:UpdateEmoji(arg_6_1, arg_6_2)
	else
		arg_6_0:UpdateContent(arg_6_1, arg_6_2)
	end

	return
end

function var_0_1.UpdateContent(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1:GetSay() == "" then
		if arg_7_2 then
			arg_7_2()
		end

		return
	end

	arg_7_0.contentTxt.text = arg_7_0:GetContent(arg_7_0.contentTr, var_3)

	arg_7_2()

	return
end

function var_0_1.GetContent(arg_8_0, arg_8_1, arg_8_2)
	tf = var_1_10003

	local var_8_0 = var_1_10003(arg_8_1)
	local var_8_1 = var_3.Find(var_8_0, "Text")
	local var_8_2 = var_3.GetComponent(var_8_1, "RichText")

	var_8_2.supportRichText = false
	eachChild = var_4
	tf = var_5

	local var_8_3 = var_5(arg_8_1)

	var_4(var_5.Find(var_8_3, "Text"), function(arg_9_0)
		Destroy = var_2_10001

		var_2_10001(arg_9_0)

		return
	end)

	string = var_4

	local var_8_4 = var_4.gmatch
	local var_8_5 = arg_8_2

	ChatConst = var_6

	local var_8_6 = var_8_4(var_8_5, var_6.EmojiIconCodeMatch)
	local var_8_7 = false

	for iter_8_0 in var_8_6 do
		table = var_1_10010
		var_1_10010 = var_1_10010.contains
		pg = var_1_10011
		var_1_10011 = var_1_10011.emoji_small_template.all
		tonumber = var_1_10012

		if var_1_10010(var_1_10011, var_1_10012(iter_8_0)) then
			local var_8_8 = true

			pg = var_1_10010
			var_1_10010 = var_1_10010.emoji_small_template
			tonumber = var_1_10011
			var_1_10010 = var_1_10010[var_1_10011(iter_8_0)]
			LoadSprite = var_1_10011
			var_1_10011 = var_1_10011("emoji/" .. var_1_10010.pic .. "_small", nil)

			var_8_2:AddSprite(iter_8_0, var_1_10011)
		end
	end

	local var_8_9 = arg_8_2

	string = var_7

	local var_8_10 = var_7.gsub
	local var_8_11 = var_8_9

	ChatConst = iter_8_0

	return (var_8_10(var_8_11, iter_8_0.EmojiIconCodeMatch, function(arg_10_0)
		table = var_2_10001

		local var_10_0 = var_2_10001.contains

		pg = var_2_10002

		local var_10_1 = var_2_10002.emoji_small_template.all

		tonumber = var_2_10003

		if var_10_0(var_10_1, var_2_10003(arg_10_0)) then
			string = var_1

			return var_1.format("<icon name=%s w=1 h=1/>", arg_10_0)
		end

		return
	end))
end

function var_0_1.UpdateEmoji(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:ClearEmojiAndExpressionEmoji()

	local var_11_0, var_11_1 = arg_11_1:GetEmoji()

	BubbleStep = var_1_10005

	if var_11_1 == var_1_10005.EMOJI_TYPE_CHAT then
		arg_11_0:UpdateChatTypeEmoji(var_11_0, arg_11_2)
	else
		BubbleStep = var_5

		if var_11_1 == var_5.EMOJI_TYPE_EXPRESSION then
			arg_11_0:UpdateExpressionTypeEmoji(var_11_0, arg_11_2)
		end
	end

	return
end

function var_0_1.UpdateChatTypeEmoji(arg_12_0, arg_12_1, arg_12_2)
	pg = var_1_10003

	local var_12_0 = var_1_10003.emoji_template[arg_12_1]

	PoolMgr = var_1_10004

	local var_12_1 = var_1_10004.GetInstance()

	var_4.GetPrefab(var_12_1, "emoji/" .. var_12_0.pic, var_12_0.pic, true, function(arg_13_0)
		local var_13_0 = arg_13_0

		if arg_13_0.GetComponent(var_13_0, "Animator") then
			var_1.enabled = true
		end

		setParent = var_13_0

		var_13_0(arg_13_0, arg_12_0.emojiContainer, false)

		local var_13_1 = arg_13_0
		local var_13_2 = arg_13_0.GetComponent

		typeof = var_4
		CriManaEffectUI = var_5

		local var_13_3

		if var_13_2(var_13_1, var_4(var_5)) or var_1 then
			var_13_3 = arg_13_0.transform
			Vector3 = var_13_1
			var_13_3.localScale = var_13_1(0.72, 0.72, 1)
		else
			var_13_3 = arg_13_0.transform
			Vector3 = var_13_1
			var_13_3.localScale = var_13_1(0.72, 0.72, 1)
		end

		setAnchoredPosition3D = var_13_3

		local var_13_4 = arg_13_0

		Vector3 = var_4

		var_13_3(var_13_4, var_4(0, 9, 0))

		local var_13_5 = arg_13_0
		local var_13_6 = arg_13_0.GetComponent

		typeof = var_4
		Image = var_5

		if var_13_6(var_13_5, var_4(var_5)) then
			GetOrAddComponent = var_2

			local var_13_7 = arg_13_0

			typeof = var_4
			Outline = var_5

			local var_13_8 = var_2(var_13_7, var_4(var_5))

			Color = var_13_7
			var_13_8.effectColor = var_13_7.NewHex("707275")
			Vector2 = var_3
			var_13_8.effectDistance = var_3(2, -2)
		end

		arg_12_0.emojiGo = arg_13_0
		arg_12_0.template = var_12_0

		arg_12_2()

		return
	end)

	return
end

function var_0_1.ClearExpressionEmoji(arg_14_0)
	if arg_14_0.expressionTr then
		Object = var_1

		var_1.Destroy(arg_14_0.expressionTr)

		arg_14_0.expressionTr = nil
	end

	return
end

function var_0_1.UpdateExpressionTypeEmoji(arg_15_0, arg_15_1, arg_15_2)
	ResourceMgr = var_1_10003

	local var_15_0 = var_1_10003.Inst
	local var_15_1 = var_3.getAssetAsync
	local var_15_2 = "Island/emoji/" .. arg_15_1
	local var_15_3 = ""

	UnityEngine = var_1_10007

	var_15_1(var_15_0, var_15_2, var_15_3, var_1_10007.Events.UnityAction_UnityEngine_Object(function(arg_16_0)
		Object = var_2_10001

		local var_16_0 = var_2_10001.Instantiate(arg_16_0)

		setParent = var_2

		var_2(var_16_0, arg_15_0.expressionContainer, false)

		setAnchoredPosition3D = var_2

		local var_16_1 = var_16_0

		Vector3 = var_4

		var_2(var_16_1, var_4(0, 9, 0))

		arg_15_0.expressionTr = var_16_0

		arg_15_2()

		return
	end), true, true)

	return
end

function var_0_1.ClearEmoji(arg_17_0)
	if arg_17_0.emojiGo and arg_17_0.template then
		local var_17_0 = arg_17_0.emojiGo.transform

		Vector3 = var_1_10002
		var_17_0.localPosition = var_1_10002(0, 0, 0)

		local var_17_1 = arg_17_0.emojiGo.transform

		Vector3 = var_2
		var_17_1.localScale = var_2(1, 1, 1)
		GetOrAddComponent = var_17_1

		local var_17_2 = arg_17_0.emojiGo

		typeof = var_3
		Outline = var_4

		if var_17_1(var_17_2, var_3(var_4)) then
			Object = var_17_2

			var_17_2.Destroy(var_1)
		end

		PoolMgr = var_17_2

		local var_17_3 = var_17_2.GetInstance()

		var_2.ReturnPrefab(var_17_3, "emoji/" .. arg_17_0.template.pic, arg_17_0.template.pic, arg_17_0.emojiGo)
	end

	arg_17_0.emojiGo = nil
	arg_17_0.template = nil

	return
end

function var_0_1.WaitForNextOne(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_1:GetTime()

	arg_18_0:UnscaleDelayCall(var_18_0, arg_18_2)

	return
end

function var_0_1.PlayCharatorAnimation(arg_19_0, arg_19_1)
	if not arg_19_1:ExistAnimation() then
		return
	end

	local var_19_0 = arg_19_0.role
	local var_19_1 = arg_19_1:GetAnimation()
	local var_19_2 = var_19_0
	local var_19_3 = var_19_0.GetComponent

	typeof = var_1_10006
	Animator = var_1_10007

	local var_19_7

	if not var_19_3(var_19_2, var_1_10006(var_1_10007)) then
		local var_19_4 = var_19_0.transform
		local var_19_5 = var_5.GetChild(var_19_4, 0)
		local var_19_6 = var_5.GetComponent

		typeof = var_7
		Animator = var_1_10008
		var_19_7 = var_19_6(var_19_5, var_7(var_1_10008))
	end

	local var_19_8 = var_19_7:GetCurrentAnimatorStateInfo(0)

	if not var_5.IsName(var_19_8, var_19_1) then
		Animator = var_5

		local var_19_9 = var_5.StringToHash(var_19_1)

		for iter_19_0 = 1, var_19_7.layerCount do
			var_19_7:CrossFadeInFixedTime(var_19_9, 0.2, iter_19_0 - 1)
		end
	end

	return
end

function var_0_1.EneAction(arg_20_0, arg_20_1)
	arg_20_0:RemnoveTimer()

	local var_20_0, var_20_1 = arg_20_1:GetHideType()

	BubbleStep = var_1_10004

	if var_20_0 == var_1_10004.HIDE_TYPE_IMMEDIATELY then
		arg_20_0:ClearEmojiAndExpressionEmoji()
		arg_20_0:ShowOrHide(false)
	else
		BubbleStep = var_4

		if var_20_0 == var_4.HIDE_TYPE_NEVER then
			-- block empty
		else
			BubbleStep = var_4

			if var_20_0 == var_4.HIDE_TYPE_TIME then
				arg_20_0.timer = arg_20_0:CreateDelayTimer(var_20_1, function()
					IsNil = var_2_10000

					if not var_2_10000(arg_20_0.tpl) then
						local var_21_0 = arg_20_0

						var_0.ClearEmojiAndExpressionEmoji(var_21_0)

						local var_21_1 = arg_20_0

						var_0.ShowOrHide(var_21_1, false)
					end

					return
				end)
			end
		end
	end

	return
end

function var_0_1.RemnoveTimer(arg_22_0)
	if arg_22_0.timer then
		local var_22_0 = arg_22_0.timer

		var_1.Stop(var_22_0)

		arg_22_0.timer = nil
	end

	return
end

function var_0_1.ClearEmojiAndExpressionEmoji(arg_23_0)
	arg_23_0:ClearEmoji()
	arg_23_0:ClearExpressionEmoji()

	return
end

function var_0_1.Stop(arg_24_0)
	arg_24_0:RemnoveTimer()
	arg_24_0:ClearEmojiAndExpressionEmoji()
	arg_24_0:ClearAnimation()

	local var_24_0 = arg_24_0
	local var_24_1 = arg_24_0.ShowOrHide

	show = var_1_10003

	var_24_1(var_24_0, var_1_10003)

	arg_24_0.isPlaying = false
	arg_24_0.canShowFlag = true

	return
end

function var_0_1.IsPlaying(arg_25_0)
	return arg_25_0.isPlaying
end

function var_0_1.SetShowFlag(arg_26_0, arg_26_1)
	if arg_26_0:IsPlaying() then
		return
	end

	arg_26_0.canShowFlag = arg_26_1
	setActive = var_2

	var_2(arg_26_0.tpl, arg_26_1)

	return
end

function var_0_1.ShowOrHide(arg_27_0, arg_27_1)
	if arg_27_1 and not arg_27_0.canShowFlag then
		return
	end

	setActive = var_1_10002

	var_1_10002(arg_27_0.tpl, arg_27_1)

	return
end

function var_0_1.Dispose(arg_28_0)
	Object = var_1_10001

	var_1_10001.Destroy(arg_28_0.tpl)

	arg_28_0.tpl = nil
	arg_28_0.role = nil
	arg_28_0.contentTxt = nil
	arg_28_0.isPlaying = false
	arg_28_0.canShowFlag = true

	arg_28_0:RemnoveTimer()
	arg_28_0:ClearAnimation()

	return
end

return var_0_1
