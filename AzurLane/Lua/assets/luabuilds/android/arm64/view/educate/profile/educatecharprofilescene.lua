class = var_0_10000

local var_0_0 = "EducateCharProfileScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "EducateCharProfileUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_0, "adapt/top/back")

	local var_2_1 = arg_2_0._tf

	arg_2_0.homeBtn = var_1.Find(var_2_1, "adapt/top/home")

	local var_2_2 = arg_2_0._tf

	arg_2_0.paintingTr = var_1.Find(var_2_2, "main/mask/painting")

	local var_2_3 = arg_2_0._tf

	arg_2_0.chatTf = var_1.Find(var_2_3, "main/chat")

	local var_2_4 = arg_2_0.chatTf
	local var_2_5 = var_1.Find(var_2_4, "Text")
	local var_2_6 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.chatTxt = var_2_6(var_2_5, var_4(var_1_10006))
	UIItemList = var_1

	local var_2_7 = var_1.New
	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_3.Find(var_2_8, "main/tag")
	local var_2_10 = arg_2_0._tf

	arg_2_0.toggleUIItemList = var_2_7(var_2_9, var_4.Find(var_2_10, "main/tag/tpl"))
	UIItemList = var_1

	local var_2_11 = var_1.New
	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_3.Find(var_2_12, "main/list/content")
	local var_2_14 = arg_2_0._tf

	arg_2_0.wordUIItemList = var_2_11(var_2_13, var_4.Find(var_2_14, "main/list/content/tpl"))
	UIItemList = var_1

	local var_2_15 = var_1.New
	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_3.Find(var_2_16, "tab/list")
	local var_2_18 = arg_2_0._tf

	arg_2_0.tabItemList = var_2_15(var_2_17, var_4.Find(var_2_18, "tab/list/tpl"))
	EducateCharCvLoader = var_1
	arg_2_0.cvLoader = var_1.New()

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_1.GetComponent

	typeof = var_4
	Animation = var_2_18
	arg_2_0.animation = var_2_20(var_2_19, var_4(var_2_18))
	arg_2_0.timers = {}

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.backBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_BACK)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.homeBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.emit(var_5_0, var_0_1.ON_HOME)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)
	arg_3_0:InitTabs()
	arg_3_0:InitToggles()

	return
end

function var_0_1.InitTabs(arg_6_0)
	NewEducateHelper = var_1_10001
	arg_6_0.characterList = var_1_10001.GetEducateCharacterList()
	arg_6_0.selectedCharacterId = arg_6_0.contextData.selectedCharacterId

	local var_6_0 = arg_6_0.tabItemList

	var_1.make(var_6_0, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_7_1 + 1
		local var_7_1 = arg_6_0.characterList[var_7_0]

		UIItemList = var_2_10005

		if arg_7_0 == var_2_10005.EventUpdate then
			setActive = var_5

			var_5(arg_7_2:Find("lock"), var_7_1:IsLock())

			setActive = var_5

			var_5(arg_7_2:Find("border/selected"), var_7_0 == arg_6_0.selectedCharacterId)

			setActive = var_5

			var_5(arg_7_2:Find("border/normal"), var_7_0 ~= arg_6_0.selectedCharacterId)
		else
			UIItemList = var_5

			if arg_7_0 == var_5.EventInit then
				GetImageSpriteFromAtlasAsync = var_5

				var_5("qicon/" .. var_7_1:GetDefaultFrame(), "", arg_7_2:Find("frame"))

				onButton = var_5

				var_5(arg_6_0, arg_7_2, function()
					local var_8_0 = var_7_1

					if var_0.IsLock(var_8_0) then
						pg = var_0

						local var_8_1 = var_0.TipsMgr.GetInstance()
						local var_8_2 = var_0.ShowTips

						i18n = var_3_10003

						var_8_2(var_8_1, var_3_10003("secretary_special_character_unlock"))

						return
					end

					if var_7_0 ~= arg_6_0.selectedCharacterId then
						arg_6_0.selectedCharacterId = var_7_0

						local var_8_3 = arg_6_0.tabItemList

						var_0.align(var_8_3, #arg_6_0.characterList)

						local var_8_4 = arg_6_0

						var_0.InitToggles(var_8_4)
					end

					return
				end)
			end
		end

		return
	end)

	local var_6_1 = arg_6_0.tabItemList

	var_1.align(var_6_1, #arg_6_0.characterList)

	return
end

function var_0_1.InitToggles(arg_9_0)
	local var_9_0 = arg_9_0.characterList[arg_9_0.selectedCharacterId]
	local var_9_1 = var_1.GetGroupList(var_9_0)

	table = var_2

	var_2.sort(var_9_1, function(arg_10_0, arg_10_1)
		return arg_10_0:GetSortWeight() < arg_10_1:GetSortWeight()
	end)

	local var_9_2 = arg_9_0.toggleUIItemList

	var_2.make(var_9_2, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = arg_9_0

			var_3.UpdateToggle(var_11_0, arg_11_2, var_9_1[arg_11_1 + 1])

			if arg_11_1 == 0 then
				local var_11_1 = arg_9_0

				var_11_1.isInit = true
				triggerToggle = var_11_1

				var_11_1(arg_11_2, true)
			end
		end

		return
	end)

	local var_9_3 = arg_9_0.toggleUIItemList

	var_2.align(var_9_3, #var_9_1)

	arg_9_0.isInit = false

	return
end

function var_0_1.UpdateToggle(arg_12_0, arg_12_1, arg_12_2)
	setImageSprite = var_1_10003

	local var_12_0 = arg_12_1:Find("sel/Text")

	GetSpriteFromAtlas = var_1_10006

	var_1_10003(var_12_0, var_1_10006("ui/EducateCharProfileUI_atlas", arg_12_2:GetSpriteName()), true)

	setImageSprite = var_1_10003

	local var_12_1 = arg_12_1:Find("Text")

	GetSpriteFromAtlas = var_6

	var_1_10003(var_12_1, var_6("ui/EducateCharProfileUI_atlas", arg_12_2:GetSpriteName()), true)

	setActive = var_1_10003

	local var_12_2 = arg_12_1:Find("lock")
	local var_12_3 = arg_12_2

	var_1_10003(var_12_2, arg_12_2.IsLock(var_12_3))

	onToggle = var_1_10003

	local var_12_4 = arg_12_0
	local var_12_5 = arg_12_1

	local function var_12_6(arg_13_0)
		if arg_13_0 then
			if not arg_12_0.isInit then
				local var_13_0 = arg_12_0.animation

				var_1.Play(var_13_0, "anim_educate_profile_change")

				arg_12_0.isInit = nil
			end

			local var_13_1 = arg_12_2
			local var_13_2 = var_1.GetShowId(var_13_1)
			local var_13_3 = arg_12_0

			var_2.ClearCurrentWord(var_13_3)

			local var_13_4 = arg_12_0

			var_2.InitPainting(var_13_4, var_13_2)

			local var_13_5 = arg_12_0

			var_2.InitWordList(var_13_5, var_13_2)
		end

		return
	end

	SFX_PANEL = var_12_3

	var_1_10003(var_12_4, var_12_5, var_12_6, var_12_3)

	return
end

function var_0_1.GetWordList(arg_14_0, arg_14_1)
	local var_14_0 = {}

	ipairs = var_1_10003
	pg = var_1_10005

	for iter_14_0, iter_14_1 in var_1_10003(var_1_10005.character_voice_special.all) do
		local var_14_1 = iter_14_1

		string = var_1_10009
		var_1_10009 = var_1_10009.find

		local var_14_2 = iter_14_1

		ShipWordHelper = var_1_10012

		if var_1_10009(var_14_2, var_1_10012.WORD_TYPE_MAIN) then
			string = var_1_10009
			var_1_10009 = var_1_10009.gsub

			local var_14_3 = iter_14_1

			ShipWordHelper = var_1_10012
			var_1_10009 = var_1_10009(var_14_3, var_1_10012.WORD_TYPE_MAIN, "")
			ShipWordHelper = var_1_10010
			var_14_1 = var_1_10010.WORD_TYPE_MAIN .. "_" .. var_1_10009
		end

		EducateCharWordHelper = var_1_10009

		if var_1_10009.ExistWord(arg_14_1, var_14_1) then
			table = var_1_10009

			var_1_10009.insert(var_14_0, iter_14_1)
		end
	end

	return var_14_0
end

function var_0_1.InitWordList(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:GetWordList(arg_15_1)

	pg = var_1_10003

	local var_15_1 = var_1_10003.secretary_special_ship[arg_15_1]

	arg_15_0:RemoveAllTimer()

	local var_15_2 = arg_15_0.wordUIItemList

	var_4.make(var_15_2, function(arg_16_0, arg_16_1, arg_16_2)
		UIItemList = var_2_10003

		if arg_16_0 == var_2_10003.EventUpdate then
			local var_16_0 = arg_15_0

			var_3.UpdateWordCard(var_16_0, arg_16_2, arg_15_1, var_15_0[arg_16_1 + 1], arg_16_1)
		end

		return
	end)

	local var_15_3 = arg_15_0.wordUIItemList

	var_4.align(var_15_3, #var_15_0)

	return
end

function var_0_1.UpdateWordCard(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = arg_17_1
	local var_17_1 = arg_17_1.Find(var_17_0, "bg")

	pg = var_1_10006

	local var_17_2 = var_1_10006.character_voice_special[arg_17_3]

	setText = var_17_0

	var_17_0(var_17_1:Find("Text"), var_17_2.voice_name)

	local var_17_3 = -1

	onButton = var_8

	local var_17_4 = arg_17_0
	local var_17_5 = var_17_1

	local function var_17_6()
		if arg_17_0.chatting then
			return
		end

		EducateCharWordHelper = var_0

		local var_18_0, var_18_1, var_18_2, var_18_3 = var_0.GetWordAndCV(arg_17_2, var_17_2.resource_key)

		seriesAsync = var_2_10004

		var_2_10004({
			function(arg_19_0)
				local var_19_0 = arg_17_0

				var_1.OnChatStart(var_19_0, var_17_1, var_18_2, arg_19_0)

				return
			end,
			function(arg_20_0)
				local var_20_0 = arg_17_0

				var_1.UpdateExpression(var_20_0, arg_17_2, var_17_2.resource_key)

				local var_20_1 = arg_17_0

				var_1.PlayCV(var_20_1, var_18_3, var_18_0, function(arg_21_0)
					var_17_3 = arg_21_0

					arg_20_0()

					return
				end)

				return
			end,
			function(arg_22_0)
				local var_22_0 = arg_17_0

				var_1.StartCharAnimation(var_22_0, var_17_3, arg_22_0)

				return
			end
		}, function()
			local var_23_0 = arg_17_0

			var_0.OnChatEnd(var_23_0)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10013

	var_8(var_17_4, var_17_5, var_17_6, var_1_10013)

	setActive = var_8

	var_8(var_17_1, false)

	local var_17_7 = arg_17_0.timers

	Timer = var_9

	local var_17_8 = var_9.New

	local function var_17_9()
		setActive = var_2_10000

		var_2_10000(var_17_1, true)

		local var_24_0 = arg_17_1
		local var_24_1 = var_0.GetComponent

		typeof = var_3
		Animation = var_2_10005

		local var_24_2 = var_24_1(var_24_0, var_3(var_2_10005))

		var_0.Play(var_24_2, "anim_educate_profile_tpl")

		return
	end

	math = var_17_6
	var_17_7[arg_17_4] = var_17_8(var_17_9, var_17_6.max(1e-05, arg_17_4 * 0.066), 1)

	local var_17_10 = arg_17_0.timers[arg_17_4]

	var_8.Start(var_17_10)

	return
end

function var_0_1.RemoveAllTimer(arg_25_0)
	pairs = var_1_10001

	for iter_25_0, iter_25_1 in var_1_10001(arg_25_0.timers) do
		iter_25_1:Stop()

		iter_25_1 = nil
	end

	arg_25_0.timers = {}

	return
end

function var_0_1.OnChatStart(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	arg_26_0.chatting = true

	local var_26_0 = arg_26_0.chatTxt

	var_26_0.text = arg_26_2
	triggerToggle = var_26_0

	var_26_0(arg_26_1:Find("state"), true)

	arg_26_0.selectedCard = arg_26_1

	arg_26_3()

	return
end

function var_0_1.UpdateExpression(arg_27_0, arg_27_1, arg_27_2)
	EducateCharWordHelper = var_1_10003

	if var_1_10003.GetExpression(arg_27_1, arg_27_2) and var_3 ~= "" then
		ShipExpressionHelper = var_1_10004
		var_1_10004 = var_1_10004.UpdateExpression
		findTF = var_6

		local var_27_0 = var_6(arg_27_0.paintingTr, "fitter")

		var_1_10004(var_6.GetChild(var_27_0, 0), arg_27_0.paintingName, var_3)
	else
		ShipExpressionHelper = var_1_10004

		local var_27_1 = var_1_10004.UpdateExpression

		findTF = var_6

		local var_27_2 = var_6(arg_27_0.paintingTr, "fitter")

		var_27_1(var_6.GetChild(var_27_2, 0), arg_27_0.paintingName, "")
	end

	return
end

function var_0_1.OnChatEnd(arg_28_0)
	arg_28_0:ClearCurrentWord()

	return
end

function var_0_1.PlayCV(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_0.cvLoader

	var_4.Play(var_29_0, arg_29_1, arg_29_2, 0, arg_29_3)

	return
end

function var_0_1.StartCharAnimation(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = 0.3
	local var_30_1 = arg_30_1 > 0 and arg_30_1 or 3

	LeanTween = var_1_10005

	local var_30_2 = var_1_10005.scale

	rtf = var_1_10007

	local var_30_3 = var_1_10007(arg_30_0.chatTf.gameObject)

	Vector3 = var_1_10008

	local var_30_4 = var_30_2(var_30_3, var_1_10008.New(1, 1, 1), var_30_0)
	local var_30_5 = var_5.setEase

	LeanTweenType = var_8

	local var_30_6 = var_30_5(var_30_4, var_8.easeOutBack)
	local var_30_7 = var_5.setOnComplete

	System = var_8

	var_30_7(var_30_6, var_8.Action(function()
		LeanTween = var_2_10000

		local var_31_0 = var_2_10000.scale

		rtf = var_2_10002

		local var_31_1 = var_2_10002(arg_30_0.chatTf.gameObject)

		Vector3 = var_2_10003

		local var_31_2 = var_31_0(var_31_1, var_2_10003.New(0, 0, 1), var_30_0)
		local var_31_3 = var_0.setEase

		LeanTweenType = var_3

		local var_31_4 = var_31_3(var_31_2, var_3.easeInBack)
		local var_31_5 = var_0.setDelay(var_31_4, var_30_0 + var_30_1)
		local var_31_6 = var_0.setOnComplete

		System = var_3

		var_31_6(var_31_5, var_3.Action(arg_30_2))

		return
	end))

	return
end

function var_0_1.InitPainting(arg_32_0, arg_32_1)
	arg_32_0:ReturnPainting()

	pg = var_2

	local var_32_0 = var_2.secretary_special_ship[arg_32_1]

	setPaintingPrefabAsync = var_1_10003

	var_1_10003(arg_32_0.paintingTr, var_32_0.painting, "tb3")

	arg_32_0.paintingName = var_32_0.painting

	return
end

function var_0_1.ReturnPainting(arg_33_0)
	if arg_33_0.paintingName then
		retPaintingPrefab = var_1

		var_1(arg_33_0.paintingTr, arg_33_0.paintingName)

		arg_33_0.paintingName = nil
	end

	return
end

function var_0_1.ClearCurrentWord(arg_34_0)
	arg_34_0.chatting = nil
	LeanTween = var_1

	var_1.cancel(arg_34_0.chatTf.gameObject)

	local var_34_0 = arg_34_0.chatTf

	Vector3 = var_1_10002
	var_34_0.localScale = var_1_10002.zero

	local var_34_1 = arg_34_0.cvLoader

	var_1.Stop(var_34_1)

	if not arg_34_0.selectedCard then
		return
	end

	local var_34_2 = arg_34_0.selectedCard

	arg_34_0.selectedCard = nil
	triggerToggle = var_2

	var_2(var_34_2:Find("state"), false)

	return
end

function var_0_1.onBackPressed(arg_35_0)
	var_0_1.super.onBackPressed(arg_35_0)

	return
end

function var_0_1.willExit(arg_36_0)
	arg_36_0:ClearCurrentWord()
	arg_36_0:RemoveAllTimer()
	arg_36_0:ReturnPainting()

	if arg_36_0.cvLoader then
		local var_36_0 = arg_36_0.cvLoader

		var_1.Dispose(var_36_0)

		arg_36_0.cvLoader = nil
	end

	return
end

return var_0_1
