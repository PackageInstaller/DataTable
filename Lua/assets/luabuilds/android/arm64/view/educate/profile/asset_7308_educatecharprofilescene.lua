local EducateCharProfileScene = class("EducateCharProfileScene", import("view.base.BaseUI"))

function EducateCharProfileScene:getUIName()
	return "EducateCharProfileUI"
end

function EducateCharProfileScene:init()
	self.backBtn = self._tf:Find("adapt/top/back")
	self.homeBtn = self._tf:Find("adapt/top/home")
	self.paintingTr = self._tf:Find("main/mask/painting")
	self.chatTf = self._tf:Find("main/chat")
	self.chatTxt = self.chatTf:Find("Text"):GetComponent(typeof(Text))
	self.toggleUIItemList = UIItemList.New(self._tf:Find("main/tag"), self._tf:Find("main/tag/tpl"))
	self.wordUIItemList = UIItemList.New(self._tf:Find("main/list/content"), self._tf:Find("main/list/content/tpl"))
	self.tabItemList = UIItemList.New(self._tf:Find("tab/list"), self._tf:Find("tab/list/tpl"))
	self.cvLoader = EducateCharCvLoader.New()
	self.animation = self._tf:GetComponent(typeof(Animation))
	self.timers = {}

	return
end

function EducateCharProfileScene:didEnter()
	onButton(self, self.backBtn, function()
		self:emit(EducateCharProfileScene.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(self, self.homeBtn, function()
		self:emit(EducateCharProfileScene.ON_HOME)

		return
	end, SFX_PANEL)
	self:InitTabs()
	self:InitToggles()

	return
end

function EducateCharProfileScene:InitTabs()
	self.characterList = NewEducateHelper.GetEducateCharacterList()
	self.selectedCharacterId = self.contextData.selectedCharacterId

	self.tabItemList:make(function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_7_1 + 1
		local var_7_1 = self.characterList[arg_7_1 + 1]

		if arg_7_0 == UIItemList.EventUpdate then
			setActive(arg_7_2:Find("lock"), self.characterList[arg_7_1 + 1]:IsLock())
			setActive(arg_7_2:Find("border/selected"), arg_7_1 + 1 == self.selectedCharacterId)
			setActive(arg_7_2:Find("border/normal"), arg_7_1 + 1 ~= self.selectedCharacterId)
		elseif arg_7_0 == UIItemList.EventInit then
			GetImageSpriteFromAtlasAsync("qicon/" .. self.characterList[arg_7_1 + 1]:GetDefaultFrame(), "", arg_7_2:Find("frame"))
			onButton(self, arg_7_2, function()
				if var_7_1:IsLock() then
					pg.TipsMgr.GetInstance():ShowTips(i18n("secretary_special_character_unlock"))

					return
				end

				if var_7_0 ~= self.selectedCharacterId then
					self.selectedCharacterId = var_7_0

					self.tabItemList:align(#self.characterList)
					self:InitToggles()
				end

				return
			end)
		end

		return
	end)
	self.tabItemList:align(#self.characterList)

	return
end

function EducateCharProfileScene:InitToggles()
	local var_9_0 = self.characterList[self.selectedCharacterId]:GetGroupList()

	table.sort(var_9_0, function(arg_10_0, arg_10_1)
		return arg_10_0:GetSortWeight() < arg_10_1:GetSortWeight()
	end)
	self.toggleUIItemList:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			self:UpdateToggle(arg_11_2, var_9_0[arg_11_1 + 1])

			if arg_11_1 == 0 then
				self.isInit = true

				triggerToggle(arg_11_2, true)
			end
		end

		return
	end)
	self.toggleUIItemList:align(#var_9_0)

	self.isInit = false

	return
end

function EducateCharProfileScene:UpdateToggle(arg_12_1, arg_12_2)
	setImageSprite(arg_12_1:Find("sel/Text"), GetSpriteFromAtlas("ui/EducateCharProfileUI_atlas", arg_12_2:GetSpriteName()), true)
	setImageSprite(arg_12_1:Find("Text"), GetSpriteFromAtlas("ui/EducateCharProfileUI_atlas", arg_12_2:GetSpriteName()), true)
	setActive(arg_12_1:Find("lock"), arg_12_2:IsLock())
	onToggle(self, arg_12_1, function(arg_13_0)
		if arg_13_0 then
			if not self.isInit then
				self.animation:Play("anim_educate_profile_change")

				self.isInit = nil
			end

			local var_13_0 = arg_12_2:GetShowId()

			self:ClearCurrentWord()
			self:InitPainting(var_13_0)
			self:InitWordList(var_13_0)
		end

		return
	end, SFX_PANEL)

	return
end

function EducateCharProfileScene:GetWordList(arg_14_1)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(pg.character_voice_special.all) do
		if EducateCharWordHelper.ExistWord(arg_14_1, (string.find(iter_14_1, ShipWordHelper.WORD_TYPE_MAIN) or nil) and ShipWordHelper.WORD_TYPE_MAIN .. "_" .. string.gsub(iter_14_1, ShipWordHelper.WORD_TYPE_MAIN, "")) then
			table.insert(var_14_0, iter_14_1)
		end
	end

	return var_14_0
end

function EducateCharProfileScene:InitWordList(arg_15_1)
	local var_15_0 = self:GetWordList(arg_15_1)

	self:RemoveAllTimer()
	self.wordUIItemList:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			self:UpdateWordCard(arg_16_2, arg_15_1, var_15_0[arg_16_1 + 1], arg_16_1)
		end

		return
	end)
	self.wordUIItemList:align(#var_15_0)

	return
end

function EducateCharProfileScene:UpdateWordCard(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = arg_17_1:Find("bg")
	local var_17_1 = pg.character_voice_special[arg_17_3]

	setText(var_17_0:Find("Text"), pg.character_voice_special[arg_17_3].voice_name)

	local var_17_2 = -1

	onButton(self, var_17_0, function()
		if self.chatting then
			return
		end

		local var_18_0, var_18_1, var_18_2, var_18_3 = EducateCharWordHelper.GetWordAndCV(arg_17_2, var_17_1.resource_key)

		seriesAsync({
			function(arg_19_0)
				self:OnChatStart(var_17_0, var_18_2, arg_19_0)

				return
			end,
			function(arg_20_0)
				self:UpdateExpression(arg_17_2, var_17_1.resource_key)
				self:PlayCV(var_18_3, var_18_0, function(arg_21_0)
					var_17_2 = arg_21_0

					arg_20_0()

					return
				end)

				return
			end,
			function(arg_22_0)
				self:StartCharAnimation(var_17_2, arg_22_0)

				return
			end
		}, function()
			self:OnChatEnd()

			return
		end)

		return
	end, SFX_PANEL)
	setActive(var_17_0, false)

	self.timers[arg_17_4] = Timer.New(function()
		setActive(var_17_0, true)
		arg_17_1:GetComponent(typeof(Animation)):Play("anim_educate_profile_tpl")

		return
	end, math.max(1e-05, arg_17_4 * 0.066), 1)

	self.timers[arg_17_4]:Start()

	return
end

function EducateCharProfileScene:RemoveAllTimer()
	for iter_25_0, iter_25_1 in pairs(self.timers) do
		iter_25_1:Stop()

		iter_25_1 = nil
	end

	self.timers = {}

	return
end

function EducateCharProfileScene:OnChatStart(arg_26_1, arg_26_2, arg_26_3)
	self.chatting = true
	self.chatTxt.text = arg_26_2

	triggerToggle(arg_26_1:Find("state"), true)

	self.selectedCard = arg_26_1

	arg_26_3()

	return
end

function EducateCharProfileScene:UpdateExpression(arg_27_1, arg_27_2)
	local var_27_0 = EducateCharWordHelper.GetExpression(arg_27_1, arg_27_2)

	if var_27_0 and var_27_0 ~= "" then
		ShipExpressionHelper.UpdateExpression(findTF(self.paintingTr, "fitter"):GetChild(0), self.paintingName, var_27_0)
	else
		ShipExpressionHelper.UpdateExpression(findTF(self.paintingTr, "fitter"):GetChild(0), self.paintingName, "")
	end

	return
end

function EducateCharProfileScene:OnChatEnd()
	self:ClearCurrentWord()

	return
end

function EducateCharProfileScene:PlayCV(arg_29_1, arg_29_2, arg_29_3)
	self.cvLoader:Play(arg_29_1, arg_29_2, 0, arg_29_3)

	return
end

function EducateCharProfileScene:StartCharAnimation(arg_30_1, arg_30_2)
	local var_30_0 = 0.3
	local var_30_1 = arg_30_1 > 0 and arg_30_1 or 3

	LeanTween.scale(rtf(self.chatTf.gameObject), Vector3.New(1, 1, 1), 0.3):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
		LeanTween.scale(rtf(self.chatTf.gameObject), Vector3.New(0, 0, 1), var_30_0):setEase(LeanTweenType.easeInBack):setDelay(var_30_0 + var_30_1):setOnComplete(System.Action(arg_30_2))

		return
	end))

	return
end

function EducateCharProfileScene:InitPainting(arg_32_1)
	self:ReturnPainting()
	setPaintingPrefabAsync(self.paintingTr, pg.secretary_special_ship[arg_32_1].painting, "tb3")

	self.paintingName = pg.secretary_special_ship[arg_32_1].painting

	return
end

function EducateCharProfileScene:ReturnPainting()
	if self.paintingName then
		retPaintingPrefab(self.paintingTr, self.paintingName)

		self.paintingName = nil
	end

	return
end

function EducateCharProfileScene:ClearCurrentWord()
	self.chatting = nil

	LeanTween.cancel(self.chatTf.gameObject)

	self.chatTf.localScale = Vector3.zero

	self.cvLoader:Stop()

	if not self.selectedCard then
		return
	end

	self.selectedCard = nil

	triggerToggle(self.selectedCard:Find("state"), false)

	return
end

function EducateCharProfileScene:onBackPressed()
	EducateCharProfileScene.super.onBackPressed(self)

	return
end

function EducateCharProfileScene:willExit()
	self:ClearCurrentWord()
	self:RemoveAllTimer()
	self:ReturnPainting()

	if self.cvLoader then
		self.cvLoader:Dispose()

		self.cvLoader = nil
	end

	return
end

return EducateCharProfileScene
