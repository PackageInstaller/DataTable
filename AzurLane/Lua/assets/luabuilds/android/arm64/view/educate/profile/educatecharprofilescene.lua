local var_0_0 = class("EducateCharProfileScene", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "EducateCharProfileUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.backBtn = arg_2_0._tf:Find("adapt/top/back")
	arg_2_0.homeBtn = arg_2_0._tf:Find("adapt/top/home")
	arg_2_0.paintingTr = arg_2_0._tf:Find("main/mask/painting")
	arg_2_0.chatTf = arg_2_0._tf:Find("main/chat")
	arg_2_0.chatTxt = arg_2_0.chatTf:Find("Text"):GetComponent(typeof(Text))
	arg_2_0.toggleUIItemList = UIItemList.New(arg_2_0._tf:Find("main/tag"), arg_2_0._tf:Find("main/tag/tpl"))
	arg_2_0.wordUIItemList = UIItemList.New(arg_2_0._tf:Find("main/list/content"), arg_2_0._tf:Find("main/list/content/tpl"))
	arg_2_0.tabItemList = UIItemList.New(arg_2_0._tf:Find("tab/list"), arg_2_0._tf:Find("tab/list/tpl"))
	arg_2_0.cvLoader = EducateCharCvLoader.New()
	arg_2_0.animation = arg_2_0._tf:GetComponent(typeof(Animation))
	arg_2_0.timers = {}

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0.backBtn, function()
		arg_3_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.homeBtn, function()
		arg_3_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_PANEL)
	arg_3_0:InitTabs()
	arg_3_0:InitToggles()

	return
end

function var_0_0.InitTabs(arg_6_0)
	arg_6_0.characterList = NewEducateHelper.GetEducateCharacterList()
	arg_6_0.selectedCharacterId = arg_6_0.contextData.selectedCharacterId

	arg_6_0.tabItemList:make(function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_7_1 + 1
		local var_7_1 = arg_6_0.characterList[arg_7_1 + 1]

		if arg_7_0 == UIItemList.EventUpdate then
			setActive(arg_7_2:Find("lock"), arg_6_0.characterList[arg_7_1 + 1]:IsLock())
			setActive(arg_7_2:Find("border/selected"), arg_7_1 + 1 == arg_6_0.selectedCharacterId)
			setActive(arg_7_2:Find("border/normal"), arg_7_1 + 1 ~= arg_6_0.selectedCharacterId)
		elseif arg_7_0 == UIItemList.EventInit then
			GetImageSpriteFromAtlasAsync("qicon/" .. arg_6_0.characterList[arg_7_1 + 1]:GetDefaultFrame(), "", arg_7_2:Find("frame"))
			onButton(arg_6_0, arg_7_2, function()
				if var_7_1:IsLock() then
					pg.TipsMgr.GetInstance():ShowTips(i18n("secretary_special_character_unlock"))

					return
				end

				if var_7_0 ~= arg_6_0.selectedCharacterId then
					arg_6_0.selectedCharacterId = var_7_0

					arg_6_0.tabItemList:align(#arg_6_0.characterList)
					arg_6_0:InitToggles()
				end

				return
			end)
		end

		return
	end)
	arg_6_0.tabItemList:align(#arg_6_0.characterList)

	return
end

function var_0_0.InitToggles(arg_9_0)
	local var_9_0 = arg_9_0.characterList[arg_9_0.selectedCharacterId]:GetGroupList()

	table.sort(var_9_0, function(arg_10_0, arg_10_1)
		return arg_10_0:GetSortWeight() < arg_10_1:GetSortWeight()
	end)
	arg_9_0.toggleUIItemList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			arg_9_0:UpdateToggle(arg_11_2, var_9_0[arg_11_1 + 1])

			if arg_11_1 == 0 then
				arg_9_0.isInit = true

				triggerToggle(arg_11_2, true)
			end
		end

		return
	end)
	arg_9_0.toggleUIItemList:align(#var_9_0)

	arg_9_0.isInit = false

	return
end

function var_0_0.UpdateToggle(arg_12_0, arg_12_1, arg_12_2)
	setImageSprite(arg_12_1:Find("sel/Text"), GetSpriteFromAtlas("ui/EducateCharProfileUI_atlas", arg_12_2:GetSpriteName()), true)
	setImageSprite(arg_12_1:Find("Text"), GetSpriteFromAtlas("ui/EducateCharProfileUI_atlas", arg_12_2:GetSpriteName()), true)
	setActive(arg_12_1:Find("lock"), arg_12_2:IsLock())
	onToggle(arg_12_0, arg_12_1, function(arg_13_0)
		if arg_13_0 then
			if not arg_12_0.isInit then
				arg_12_0.animation:Play("anim_educate_profile_change")

				arg_12_0.isInit = nil
			end

			local var_13_0 = arg_12_2:GetShowId()

			arg_12_0:ClearCurrentWord()
			arg_12_0:InitPainting(var_13_0)
			arg_12_0:InitWordList(var_13_0)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.GetWordList(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(pg.character_voice_special.all) do
		local var_14_0 = iter_14_1

		if string.find(iter_14_1, ShipWordHelper.WORD_TYPE_MAIN) then
			var_14_0 = ShipWordHelper.WORD_TYPE_MAIN .. "_" .. string.gsub(iter_14_1, ShipWordHelper.WORD_TYPE_MAIN, "")
		end

		if EducateCharWordHelper.ExistWord(arg_14_1, var_14_0) then
			table.insert({}, iter_14_1)
		end
	end

	return {}
end

function var_0_0.InitWordList(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:GetWordList(arg_15_1)

	arg_15_0:RemoveAllTimer()
	arg_15_0.wordUIItemList:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			arg_15_0:UpdateWordCard(arg_16_2, arg_15_1, var_15_0[arg_16_1 + 1], arg_16_1)
		end

		return
	end)
	arg_15_0.wordUIItemList:align(#arg_15_0:GetWordList(arg_15_1))

	return
end

function var_0_0.UpdateWordCard(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = arg_17_1:Find("bg")

	setText(var_17_0:Find("Text"), pg.character_voice_special[arg_17_3].voice_name)

	local var_17_1 = -1

	onButton(arg_17_0, var_17_0, function()
		if arg_17_0.chatting then
			return
		end

		local var_18_0, var_18_1, var_18_2, var_18_3 = EducateCharWordHelper.GetWordAndCV(arg_17_2, var_0.resource_key)

		seriesAsync({
			function(arg_19_0)
				arg_17_0:OnChatStart(var_17_0, var_18_2, arg_19_0)

				return
			end,
			function(arg_20_0)
				arg_17_0:UpdateExpression(arg_17_2, var_0.resource_key)
				arg_17_0:PlayCV(var_18_3, var_18_0, function(arg_21_0)
					var_17_1 = arg_21_0

					arg_20_0()

					return
				end)

				return
			end,
			function(arg_22_0)
				arg_17_0:StartCharAnimation(var_17_1, arg_22_0)

				return
			end
		}, function()
			arg_17_0:OnChatEnd()

			return
		end)

		return
	end, SFX_PANEL)
	setActive(var_17_0, false)

	arg_17_0.timers[arg_17_4] = Timer.New(function()
		setActive(var_17_0, true)
		arg_17_1:GetComponent(typeof(Animation)):Play("anim_educate_profile_tpl")

		return
	end, math.max(1e-05, arg_17_4 * 0.066), 1)

	arg_17_0.timers[arg_17_4]:Start()

	return
end

function var_0_0.RemoveAllTimer(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.timers) do
		iter_25_1:Stop()

		iter_25_1 = nil
	end

	arg_25_0.timers = {}

	return
end

function var_0_0.OnChatStart(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	arg_26_0.chatting = true
	arg_26_0.chatTxt.text = arg_26_2

	triggerToggle(arg_26_1:Find("state"), true)

	arg_26_0.selectedCard = arg_26_1

	arg_26_3()

	return
end

function var_0_0.UpdateExpression(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = EducateCharWordHelper.GetExpression(arg_27_1, arg_27_2)

	if var_27_0 and var_27_0 ~= "" then
		ShipExpressionHelper.UpdateExpression(findTF(arg_27_0.paintingTr, "fitter"):GetChild(0), arg_27_0.paintingName, var_27_0)
	else
		ShipExpressionHelper.UpdateExpression(findTF(arg_27_0.paintingTr, "fitter"):GetChild(0), arg_27_0.paintingName, "")
	end

	return
end

function var_0_0.OnChatEnd(arg_28_0)
	arg_28_0:ClearCurrentWord()

	return
end

function var_0_0.PlayCV(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	arg_29_0.cvLoader:Play(arg_29_1, arg_29_2, 0, arg_29_3)

	return
end

function var_0_0.StartCharAnimation(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_1 > 0 and arg_30_1 or 3

	LeanTween.scale(rtf(arg_30_0.chatTf.gameObject), Vector3.New(1, 1, 1), 0.3):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
		LeanTween.scale(rtf(arg_30_0.chatTf.gameObject), Vector3.New(0, 0, 1), var_0):setEase(LeanTweenType.easeInBack):setDelay(var_0 + var_30_0):setOnComplete(System.Action(arg_30_2))

		return
	end))

	return
end

function var_0_0.InitPainting(arg_32_0, arg_32_1)
	arg_32_0:ReturnPainting()
	setPaintingPrefabAsync(arg_32_0.paintingTr, pg.secretary_special_ship[arg_32_1].painting, "tb3")

	arg_32_0.paintingName = pg.secretary_special_ship[arg_32_1].painting

	return
end

function var_0_0.ReturnPainting(arg_33_0)
	if arg_33_0.paintingName then
		retPaintingPrefab(arg_33_0.paintingTr, arg_33_0.paintingName)

		arg_33_0.paintingName = nil
	end

	return
end

function var_0_0.ClearCurrentWord(arg_34_0)
	arg_34_0.chatting = nil

	LeanTween.cancel(arg_34_0.chatTf.gameObject)

	arg_34_0.chatTf.localScale = Vector3.zero

	arg_34_0.cvLoader:Stop()

	if not arg_34_0.selectedCard then
		return
	end

	arg_34_0.selectedCard = nil

	triggerToggle(var_34_0:Find("state"), false)

	return
end

function var_0_0.onBackPressed(arg_35_0)
	var_0_0.super.onBackPressed(arg_35_0)

	return
end

function var_0_0.willExit(arg_36_0)
	arg_36_0:ClearCurrentWord()
	arg_36_0:RemoveAllTimer()
	arg_36_0:ReturnPainting()

	if arg_36_0.cvLoader then
		arg_36_0.cvLoader:Dispose()

		arg_36_0.cvLoader = nil
	end

	return
end

return var_0_0
