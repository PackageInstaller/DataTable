class = var_0_10000

local var_0_0 = "LoveLetterDisplayLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "LoveLetterDisplayUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	pg = var_1_10002

	local var_2_0 = var_1_10002.PoolMgr.GetInstance()

	var_2.GetPrefab(var_2_0, "LoveLetterStyle/" .. arg_2_0.contextData.prefab, "", true, function(arg_3_0)
		arg_2_0.rtStyle = arg_3_0.transform

		arg_2_1()

		return
	end)

	return
end

var_0_1.optionsPath = {}

function var_0_1.SetLoveLetter(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	LoveLetterProxy = var_1_10003

	local var_4_0 = var_1_10002(var_1_10003)

	arg_4_0.ll = var_2.GetGroupData(var_4_0, arg_4_1)

	local var_4_1 = arg_4_0.ll

	arg_4_0.letterIds = var_2.GetDisplayLetterList(var_4_1)

	local var_4_2 = arg_4_0
	local var_4_3 = arg_4_0.ShowLetter
	local var_4_4

	if not arg_4_0.contextData.letterId then
		var_4_4 = arg_4_0.letterIds[1]
	end

	var_4_3(var_4_2, var_4_4)

	return
end

function var_0_1.init(arg_5_0)
	setParent = var_1_10001

	var_1_10001(arg_5_0.rtStyle, arg_5_0.rtPanel)

	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.rtBg

	local function var_5_2()
		local var_6_0 = arg_5_0

		var_0.closeView(var_6_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10005)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.rtStyle
	local var_5_5 = var_3.Find(var_5_4, "before")

	local function var_5_6()
		local var_7_0 = arg_5_0
		local var_7_1 = var_0.emit

		LoveLetterDisplayMediator = var_2_10002

		var_7_1(var_7_0, var_2_10002.ON_UNLOCK_LETTER, arg_5_0.letterId)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_3, var_5_5, var_5_6, var_5)
	arg_5_0:addRingDragListenter()
	arg_5_0:BlurPanel(arg_5_0._tf)

	return
end

function var_0_1.didEnter(arg_8_0)
	setText = var_1_10001

	local var_8_0 = arg_8_0.rtStyle
	local var_8_1 = var_2.Find(var_8_0, "after/bg/paper_root/name")
	local var_8_2 = arg_8_0.ll

	var_1_10001(var_8_1, var_3.GetName(var_8_2))

	return
end

function var_0_1.ChangeLetter(arg_9_0, arg_9_1)
	table = var_1_10002

	local var_9_0 = var_1_10002.indexof(arg_9_0.letterIds, arg_9_0.letterId) + arg_9_1

	math = var_3

	if var_9_0 ~= var_3.clamp(var_9_0, 1, #arg_9_0.letterIds) then
		pg = var_3

		local var_9_1 = var_3.TipsMgr.GetInstance()
		local var_9_2 = var_3.ShowTips

		i18n = var_5

		var_9_2(var_9_1, var_5("loveactivity_ui_15"))
	else
		arg_9_0:ShowLetter(arg_9_0.letterIds[var_9_0])
	end

	return
end

function var_0_1.ShowLetter(arg_10_0, arg_10_1)
	arg_10_0.letterId = arg_10_1

	local var_10_0 = arg_10_0.contextData

	var_10_0.letterId = arg_10_0.letterId
	setText = var_10_0

	local var_10_1 = arg_10_0.rtStyle
	local var_10_2 = var_3.Find(var_10_1, "after/bg/paper_root/content")

	getProxy = var_10_1
	LoveLetterProxy = var_5

	local var_10_3 = var_10_1(var_5)

	var_10_0(var_10_2, var_4.GetLoveLetterContent(var_10_3, arg_10_1))

	table = var_10_0

	local var_10_4 = var_10_0.indexof(arg_10_0.letterIds, arg_10_0.letterId)

	UIItemList = var_3

	var_3.StaticAlign(arg_10_0.rtPointsContainer, arg_10_0.rtPointsTpl, #arg_10_0.letterIds, function(arg_11_0, arg_11_1, arg_11_2)
		arg_11_1 = arg_11_1 + 1
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			setActive = var_3

			var_3(arg_11_2:Find("short"), arg_11_1 ~= var_10_4)

			setActive = var_3

			var_3(arg_11_2:Find("long"), arg_11_1 == var_10_4)

			setActive = var_3

			local var_11_0 = arg_11_2:Find("short/pick_up")
			local var_11_1 = arg_10_0.ll

			var_3(var_11_0, not var_5.GetLetterUnlock(var_11_1, arg_10_0.letterIds[arg_11_1]))
		end

		return
	end)

	local var_10_5 = arg_10_0
	local var_10_6 = arg_10_0.UpdateLetterDisplay
	local var_10_7 = arg_10_0.ll

	var_10_6(var_10_5, var_5.GetLetterUnlock(var_10_7, arg_10_0.letterId))

	return
end

function var_0_1.DoOpenLetter(arg_12_0)
	onButton = var_1_10001

	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.rtAnim
	local var_12_2 = var_3.Find(var_12_1, "click")

	local function var_12_3()
		local var_13_0 = arg_12_0.clickCall
		local var_13_1 = arg_12_0

		var_13_1.clickCall = nil
		existCall = var_13_1

		var_13_1(var_13_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_12_0, var_12_2, var_12_3, var_5)

	GetOrAddComponent = var_1_10001

	local var_12_4 = var_1_10001(arg_12_0._tf, "EventTriggerListener")

	var_12_4.enabled = false
	setActive = var_12_4

	var_12_4(arg_12_0.rtPointsContainer, false)

	pg = var_12_4

	local var_12_5 = var_12_4.UIMgr.GetInstance()

	var_1.LoadingOn(var_12_5)

	local var_12_6 = {}

	table = var_12_5

	var_12_5.insert(var_12_6, function(arg_14_0)
		local var_14_0 = arg_12_0.ll
		local var_14_1 = var_1.GetDisplayInfo(var_14_0)

		parallelAsync = var_14_0

		var_14_0({
			function(arg_15_0)
				pg = var_3_10001

				local var_15_0 = var_3_10001.PoolMgr.GetInstance()

				var_1.GetPrefab(var_15_0, "loveletteranim/loveletteranim", "", true, function(arg_16_0)
					arg_12_0.rtAnimation = arg_16_0.transform

					arg_15_0()

					return
				end)

				return
			end,
			function(arg_17_0)
				LoadSpriteAtlasAsync = var_3_10001

				var_3_10001("bg/" .. arg_12_0.contextData.bg, "", function(arg_18_0)
					arg_12_0.spriteBg = arg_18_0

					arg_17_0()

					return
				end)

				return
			end,
			function(arg_19_0)
				LoadSpriteAtlasAsync = var_3_10001

				var_3_10001("loveletterstyleatlas/mail_" .. arg_12_0.contextData.prefab, "", function(arg_20_0)
					arg_12_0.spriteMail = arg_20_0

					arg_19_0()

					return
				end)

				return
			end,
			function(arg_21_0)
				LoadSpriteAtlasAsync = var_3_10001

				var_3_10001("loveletterstyleatlas/" .. var_14_1.hand, "", function(arg_22_0)
					arg_12_0.spriteHand = arg_22_0

					arg_21_0()

					return
				end)

				return
			end,
			function(arg_23_0)
				LoadSpriteAtlasAsync = var_3_10001

				var_3_10001("loveletterstyleatlas/" .. var_14_1.kiss, "", function(arg_24_0)
					arg_12_0.spriteKiss = arg_24_0

					arg_23_0()

					return
				end)

				return
			end
		}, function()
			setParent = var_3_10000

			local var_25_0 = arg_12_0.rtAnimation
			local var_25_1 = arg_12_0.rtAnim

			var_3_10000(var_25_0, var_2.Find(var_25_1, "content"))

			setImageSprite = var_3_10000

			local var_25_2 = arg_12_0.rtAnimation

			var_3_10000(var_1.Find(var_25_2, "bg_root/bg"), arg_12_0.spriteBg)

			setImageSprite = var_3_10000

			local var_25_3 = arg_12_0.rtAnimation

			var_3_10000(var_1.Find(var_25_3, "fx_letter_in/deco_letter/deco_letter_1"), arg_12_0.spriteMail)

			setImageSprite = var_3_10000

			local var_25_4 = arg_12_0.rtAnimation

			var_3_10000(var_1.Find(var_25_4, "fx_letter_in/deco_letter/lip_01"), arg_12_0.spriteKiss, true)

			setImageSprite = var_3_10000

			local var_25_5 = arg_12_0.rtAnimation

			var_3_10000(var_1.Find(var_25_5, "hand/hand_deco"), arg_12_0.spriteHand, true)

			local var_25_6 = arg_12_0.rtAnimation
			local var_25_7 = var_0.GetComponent

			typeof = var_2
			DftAniEvent = var_3

			local var_25_8 = var_25_7(var_25_6, var_2(var_3))

			var_0.SetEndEvent(var_25_8, function(arg_26_0)
				local var_26_0 = arg_12_0.nextCall
				local var_26_1 = arg_12_0

				var_26_1.nextCall = nil
				existCall = var_26_1

				var_26_1(var_26_0, arg_26_0)

				return
			end)

			eachChild = var_0

			local var_25_9 = arg_12_0.rtAnimation

			var_0(var_1.Find(var_25_9, "letter_style/root"), function(arg_27_0, arg_27_1)
				setActive = var_4_10002

				var_4_10002(arg_27_0, arg_27_0.name == arg_12_0.contextData.prefab)

				if arg_27_0.name == arg_12_0.contextData.prefab then
					setText = var_2

					local var_27_0 = arg_27_0:Find("after/bg/paper_root/name")
					local var_27_1 = arg_12_0.ll

					var_2(var_27_0, var_4.GetName(var_27_1))

					setText = var_2

					local var_27_2 = arg_27_0
					local var_27_3 = arg_27_0.Find(var_27_2, "after/bg/paper_root/content")

					getProxy = var_27_2
					LoveLetterProxy = var_5

					local var_27_4 = var_27_2(var_5)

					var_2(var_27_3, var_4.GetLoveLetterContent(var_27_4, arg_12_0.contextData.letterId))
				end

				return
			end)
			arg_14_0()

			return
		end)

		return
	end)

	table = var_2

	var_2.insert(var_12_6, function(arg_28_0)
		setPaintingPrefab = var_2_10001

		local var_28_0 = arg_12_0.rtAnimation
		local var_28_1 = var_2.Find(var_28_0, "painting_root/paint")
		local var_28_2 = arg_12_0.ll

		var_2_10001(var_28_1, var_3.GetPainting(var_28_2), "mainNormal", nil, nil, arg_28_0)

		return
	end)

	table = var_2

	var_2.insert(var_12_6, function(arg_29_0)
		pg = var_2_10001

		local var_29_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_29_0)

		setActive = var_1

		var_1(arg_12_0.rtAnim, true)

		function arg_12_0.nextCall()
			setActive = var_3_10000

			local var_30_0 = arg_12_0.rtAnim

			var_3_10000(var_1.Find(var_30_0, "click"), true)

			return
		end

		local var_29_1 = arg_12_0

		var_29_1.clickCall = arg_29_0
		setActive = var_29_1

		local var_29_2 = arg_12_0.rtAnim

		var_29_1(var_2.Find(var_29_2, "click"), false)

		quickPlayAnimation = var_29_1

		var_29_1(arg_12_0.rtAnimation, "anim_LoveLetterDisplayUI_fadein_01")

		return
	end)

	table = var_2

	var_2.insert(var_12_6, function(arg_31_0)
		setActive = var_2_10001

		var_2_10001(arg_12_0.rtAnim, true)

		function arg_12_0.nextCall()
			setActive = var_3_10000

			local var_32_0 = arg_12_0.rtAnim

			var_3_10000(var_1.Find(var_32_0, "click"), true)

			return
		end

		local var_31_0 = arg_12_0

		var_31_0.clickCall = arg_31_0
		setActive = var_31_0

		local var_31_1 = arg_12_0.rtAnim

		var_31_0(var_2.Find(var_31_1, "click"), false)

		quickPlayAnimation = var_31_0

		var_31_0(arg_12_0.rtAnimation, "anim_LoveLetterDisplayUI_fadein_02")

		return
	end)

	table = var_2

	var_2.insert(var_12_6, function(arg_33_0)
		setActive = var_2_10001

		var_2_10001(arg_12_0.rtAnim, true)

		local var_33_0 = arg_12_0

		var_33_0.nextCall = arg_33_0
		setActive = var_33_0

		local var_33_1 = arg_12_0.rtAnim

		var_33_0(var_2.Find(var_33_1, "click"), false)

		quickPlayAnimation = var_33_0

		var_33_0(arg_12_0.rtAnimation, "anim_LoveLetterDisplayUI_fadeout_01")

		return
	end)

	seriesAsync = var_2

	var_2(var_12_6, function()
		setActive = var_2_10000

		var_2_10000(arg_12_0.rtAnim, false)

		setActive = var_2_10000

		var_2_10000(arg_12_0.rtPointsContainer, true)

		local var_34_0 = arg_12_0

		var_0.UpdateLetterDisplay(var_34_0, true)

		GetOrAddComponent = var_0
		var_0(arg_12_0._tf, "EventTriggerListener").enabled = true

		return
	end)

	return
end

function var_0_1.UpdateLetterDisplay(arg_35_0, arg_35_1)
	setActive = var_1_10002

	local var_35_0 = arg_35_0.rtStyle

	var_1_10002(var_3.Find(var_35_0, "after"), arg_35_1)

	setActive = var_1_10002

	local var_35_1 = arg_35_0.rtStyle

	var_1_10002(var_3.Find(var_35_1, "before"), not arg_35_1)

	setButtonEnabled = var_1_10002

	local var_35_2 = arg_35_0.rtStyle

	var_1_10002(var_3.Find(var_35_2, "before"), not arg_35_1)

	if not arg_35_1 then
		setLoveLetterMedal = var_1_10002

		local var_35_3 = arg_35_0.rtStyle
		local var_35_4 = var_3.Find(var_35_3, "before/medal")

		setmetatable = var_35_3

		local var_35_5 = {}

		table = var_1_10006

		local var_35_6 = var_1_10006.indexof

		pg = var_1_10007
		var_35_5.level = var_35_6(var_1_10007.lover_letter_content.get_id_list_by_ship_group[arg_35_0.ll.groupId], arg_35_0.contextData.letterId)

		var_1_10002(var_35_4, var_35_3(var_35_5, {
			__index = arg_35_0.ll
		}))
	end

	return
end

function var_0_1.addRingDragListenter(arg_36_0)
	GetOrAddComponent = var_1_10001

	local var_36_0 = var_1_10001(arg_36_0._tf, "EventTriggerListener")
	local var_36_1
	local var_36_2 = 0
	local var_36_3

	var_36_0:AddBeginDragFunc(function()
		var_36_2 = 0
		var_36_1 = nil

		return
	end)
	var_36_0:AddDragFunc(function(arg_38_0, arg_38_1)
		local var_38_0 = arg_38_1.position

		if not var_36_1 then
			var_36_1 = var_38_0
		end

		var_36_2 = var_38_0.x - var_36_1.x

		return
	end)
	var_36_0:AddDragEndFunc(function(arg_39_0, arg_39_1)
		if arg_36_0.isBlock then
			return
		end

		if var_36_2 < -50 then
			local var_39_0 = arg_36_0

			var_2.ChangeLetter(var_39_0, 1)
		elseif var_36_2 > 50 then
			local var_39_1 = arg_36_0

			var_2.ChangeLetter(var_39_1, -1)
		end

		return
	end)

	return
end

function var_0_1.willExit(arg_40_0)
	if arg_40_0.rtStyle then
		eachChild = var_1

		local var_40_0 = arg_40_0.rtStyle

		var_1(var_2.Find(var_40_0, "before/medal"), function(arg_41_0, arg_41_1)
			returnLoveLetterMedal = var_2_10002

			var_2_10002(arg_41_0)

			return
		end)

		pg = var_1

		local var_40_1 = var_1.PoolMgr.GetInstance()

		var_1.ReturnPrefab(var_40_1, "LoveLetterStyle/" .. arg_40_0.contextData.prefab, "", arg_40_0.rtStyle.gameObject)

		arg_40_0.rtStyle = nil
	end

	if arg_40_0.rtAnimation then
		retPaintingPrefab = var_1

		local var_40_2 = arg_40_0.rtAnimation
		local var_40_3 = var_2.Find(var_40_2, "painting_root/paint")
		local var_40_4 = arg_40_0.ll

		var_1(var_40_3, var_3.GetPainting(var_40_4), "mainNormal")

		pg = var_1

		local var_40_5 = var_1.PoolMgr.GetInstance()

		var_1.ReturnPrefab(var_40_5, "loveletteranim/loveletteranim", "", arg_40_0.rtAnimation.gameObject)

		arg_40_0.rtAnimation = nil
	end

	return
end

return var_0_1
