local var_0_0 = class("LoveLetterDisplayLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "LoveLetterDisplayUI"
end

function var_0_0.preload(arg_2_0, arg_2_1)
	pg.PoolMgr.GetInstance():GetPrefab("LoveLetterStyle/" .. arg_2_0.contextData.prefab, "", true, function(arg_3_0)
		arg_2_0.rtStyle = arg_3_0.transform

		arg_2_1()

		return
	end)

	return
end

var_0_0.optionsPath = {}

function var_0_0.SetLoveLetter(arg_4_0, arg_4_1)
	arg_4_0.ll = getProxy(LoveLetterProxy):GetGroupData(arg_4_1)
	arg_4_0.letterIds = arg_4_0.ll:GetDisplayLetterList()

	local var_4_0 = arg_4_0.contextData.letterId or arg_4_0.letterIds[1]

	arg_4_0:ShowLetter(var_4_0)

	return
end

function var_0_0.init(arg_5_0)
	setParent(arg_5_0.rtStyle, arg_5_0.rtPanel)
	onButton(arg_5_0, arg_5_0.rtBg, function()
		arg_5_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_5_0, arg_5_0.rtStyle:Find("before"), function()
		arg_5_0:emit(LoveLetterDisplayMediator.ON_UNLOCK_LETTER, arg_5_0.letterId)

		return
	end, SFX_PANEL)
	arg_5_0:addRingDragListenter()
	arg_5_0:BlurPanel(arg_5_0._tf)

	return
end

function var_0_0.didEnter(arg_8_0)
	setText(arg_8_0.rtStyle:Find("after/bg/paper_root/name"), arg_8_0.ll:GetName())

	return
end

function var_0_0.ChangeLetter(arg_9_0, arg_9_1)
	local var_9_0 = table.indexof(arg_9_0.letterIds, arg_9_0.letterId) + arg_9_1

	if var_9_0 ~= math.clamp(var_9_0, 1, #arg_9_0.letterIds) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("loveactivity_ui_15"))
	else
		arg_9_0:ShowLetter(arg_9_0.letterIds[var_9_0])
	end

	return
end

function var_0_0.ShowLetter(arg_10_0, arg_10_1)
	arg_10_0.letterId = arg_10_1
	arg_10_0.contextData.letterId = arg_10_0.letterId

	setText(arg_10_0.rtStyle:Find("after/bg/paper_root/content"), getProxy(LoveLetterProxy):GetLoveLetterContent(arg_10_1))

	local var_10_0 = table.indexof(arg_10_0.letterIds, arg_10_0.letterId)

	UIItemList.StaticAlign(arg_10_0.rtPointsContainer, arg_10_0.rtPointsTpl, #arg_10_0.letterIds, function(arg_11_0, arg_11_1, arg_11_2)
		arg_11_1 = arg_11_1 + 1

		if arg_11_0 == UIItemList.EventUpdate then
			setActive(arg_11_2:Find("short"), arg_11_1 ~= var_10_0)
			setActive(arg_11_2:Find("long"), arg_11_1 == var_10_0)
			setActive(arg_11_2:Find("short/pick_up"), not arg_10_0.ll:GetLetterUnlock(arg_10_0.letterIds[arg_11_1]))
		end

		return
	end)
	arg_10_0:UpdateLetterDisplay(arg_10_0.ll:GetLetterUnlock(arg_10_0.letterId))

	return
end

function var_0_0.DoOpenLetter(arg_12_0)
	onButton(arg_12_0, arg_12_0.rtAnim:Find("click"), function()
		arg_12_0.clickCall = nil

		existCall(arg_12_0.clickCall)

		return
	end, SFX_PANEL)

	GetOrAddComponent(arg_12_0._tf, "EventTriggerListener").enabled = false

	setActive(arg_12_0.rtPointsContainer, false)
	pg.UIMgr.GetInstance():LoadingOn()
	table.insert({}, function(arg_14_0)
		local var_14_0 = arg_12_0.ll:GetDisplayInfo()

		parallelAsync({
			function(arg_15_0)
				pg.PoolMgr.GetInstance():GetPrefab("loveletteranim/loveletteranim", "", true, function(arg_16_0)
					arg_12_0.rtAnimation = arg_16_0.transform

					arg_15_0()

					return
				end)

				return
			end,
			function(arg_17_0)
				LoadSpriteAtlasAsync("bg/" .. arg_12_0.contextData.bg, "", function(arg_18_0)
					arg_12_0.spriteBg = arg_18_0

					arg_17_0()

					return
				end)

				return
			end,
			function(arg_19_0)
				LoadSpriteAtlasAsync("loveletterstyleatlas/mail_" .. arg_12_0.contextData.prefab, "", function(arg_20_0)
					arg_12_0.spriteMail = arg_20_0

					arg_19_0()

					return
				end)

				return
			end,
			function(arg_21_0)
				LoadSpriteAtlasAsync("loveletterstyleatlas/" .. var_14_0.hand, "", function(arg_22_0)
					arg_12_0.spriteHand = arg_22_0

					arg_21_0()

					return
				end)

				return
			end,
			function(arg_23_0)
				LoadSpriteAtlasAsync("loveletterstyleatlas/" .. var_14_0.kiss, "", function(arg_24_0)
					arg_12_0.spriteKiss = arg_24_0

					arg_23_0()

					return
				end)

				return
			end
		}, function()
			setParent(arg_12_0.rtAnimation, arg_12_0.rtAnim:Find("content"))
			setImageSprite(arg_12_0.rtAnimation:Find("bg_root/bg"), arg_12_0.spriteBg)
			setImageSprite(arg_12_0.rtAnimation:Find("fx_letter_in/deco_letter/deco_letter_1"), arg_12_0.spriteMail)
			setImageSprite(arg_12_0.rtAnimation:Find("fx_letter_in/deco_letter/lip_01"), arg_12_0.spriteKiss, true)
			setImageSprite(arg_12_0.rtAnimation:Find("hand/hand_deco"), arg_12_0.spriteHand, true)
			arg_12_0.rtAnimation:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_26_0)
				arg_12_0.nextCall = nil

				existCall(arg_12_0.nextCall, arg_26_0)

				return
			end)
			eachChild(arg_12_0.rtAnimation:Find("letter_style/root"), function(arg_27_0, arg_27_1)
				setActive(arg_27_0, arg_27_0.name == arg_12_0.contextData.prefab)

				if arg_27_0.name == arg_12_0.contextData.prefab then
					setText(arg_27_0:Find("after/bg/paper_root/name"), arg_12_0.ll:GetName())
					setText(arg_27_0:Find("after/bg/paper_root/content"), getProxy(LoveLetterProxy):GetLoveLetterContent(arg_12_0.contextData.letterId))
				end

				return
			end)
			arg_14_0()

			return
		end)

		return
	end)
	table.insert({}, function(arg_28_0)
		setPaintingPrefab(arg_12_0.rtAnimation:Find("painting_root/paint"), arg_12_0.ll:GetPainting(), "mainNormal", nil, nil, arg_28_0)

		return
	end)
	table.insert({}, function(arg_29_0)
		pg.UIMgr.GetInstance():LoadingOff()
		setActive(arg_12_0.rtAnim, true)

		function arg_12_0.nextCall()
			setActive(arg_12_0.rtAnim:Find("click"), true)

			return
		end

		arg_12_0.clickCall = arg_29_0

		setActive(arg_12_0.rtAnim:Find("click"), false)
		quickPlayAnimation(arg_12_0.rtAnimation, "anim_LoveLetterDisplayUI_fadein_01")

		return
	end)
	table.insert({}, function(arg_31_0)
		setActive(arg_12_0.rtAnim, true)

		function arg_12_0.nextCall()
			setActive(arg_12_0.rtAnim:Find("click"), true)

			return
		end

		arg_12_0.clickCall = arg_31_0

		setActive(arg_12_0.rtAnim:Find("click"), false)
		quickPlayAnimation(arg_12_0.rtAnimation, "anim_LoveLetterDisplayUI_fadein_02")

		return
	end)
	table.insert({}, function(arg_33_0)
		setActive(arg_12_0.rtAnim, true)

		arg_12_0.nextCall = arg_33_0

		setActive(arg_12_0.rtAnim:Find("click"), false)
		quickPlayAnimation(arg_12_0.rtAnimation, "anim_LoveLetterDisplayUI_fadeout_01")

		return
	end)
	seriesAsync({}, function()
		setActive(arg_12_0.rtAnim, false)
		setActive(arg_12_0.rtPointsContainer, true)
		arg_12_0:UpdateLetterDisplay(true)

		GetOrAddComponent(arg_12_0._tf, "EventTriggerListener").enabled = true

		return
	end)

	return
end

function var_0_0.UpdateLetterDisplay(arg_35_0, arg_35_1)
	setActive(arg_35_0.rtStyle:Find("after"), arg_35_1)
	setActive(arg_35_0.rtStyle:Find("before"), not arg_35_1)
	setButtonEnabled(arg_35_0.rtStyle:Find("before"), not arg_35_1)

	if not arg_35_1 then
		setLoveLetterMedal(arg_35_0.rtStyle:Find("before/medal"), setmetatable({
			level = table.indexof(pg.lover_letter_content.get_id_list_by_ship_group[arg_35_0.ll.groupId], arg_35_0.contextData.letterId)
		}, {
			__index = arg_35_0.ll
		}))
	end

	return
end

function var_0_0.addRingDragListenter(arg_36_0)
	local var_36_0 = GetOrAddComponent(arg_36_0._tf, "EventTriggerListener")
	local var_36_1
	local var_36_2 = 0

	var_36_0:AddBeginDragFunc(function()
		var_36_2 = 0
		var_36_1 = nil

		return
	end)
	var_36_0:AddDragFunc(function(arg_38_0, arg_38_1)
		var_36_1 = var_36_1 or arg_38_1.position
		var_36_2 = arg_38_1.position.x - var_36_1.x

		return
	end)
	var_36_0:AddDragEndFunc(function(arg_39_0, arg_39_1)
		if arg_36_0.isBlock then
			return
		end

		if var_36_2 < -50 then
			arg_36_0:ChangeLetter(1)
		elseif var_36_2 > 50 then
			arg_36_0:ChangeLetter(-1)
		end

		return
	end)

	return
end

function var_0_0.willExit(arg_40_0)
	if arg_40_0.rtStyle then
		eachChild(arg_40_0.rtStyle:Find("before/medal"), function(arg_41_0, arg_41_1)
			returnLoveLetterMedal(arg_41_0)

			return
		end)
		pg.PoolMgr.GetInstance():ReturnPrefab("LoveLetterStyle/" .. arg_40_0.contextData.prefab, "", arg_40_0.rtStyle.gameObject)

		arg_40_0.rtStyle = nil
	end

	if arg_40_0.rtAnimation then
		retPaintingPrefab(arg_40_0.rtAnimation:Find("painting_root/paint"), arg_40_0.ll:GetPainting(), "mainNormal")
		pg.PoolMgr.GetInstance():ReturnPrefab("loveletteranim/loveletteranim", "", arg_40_0.rtAnimation.gameObject)

		arg_40_0.rtAnimation = nil
	end

	return
end

return var_0_0
