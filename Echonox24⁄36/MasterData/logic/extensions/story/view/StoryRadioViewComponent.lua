-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryRadioViewComponent.lua

module("logic.extensions.story.view.StoryRadioViewComponent", package.seeall)

local M = class("StoryRadioViewComponent", ViewComponent)
local StoryRadioType = StoryConstDef.EStoryRadioType
local StoryRadioInfluence = StoryConstDef.EInfluence
local Attr2Icon = {
	"fhdt19",
	"fhdt20",
	"fhdt21",
	"fhdt22",
	"fhdt23",
	"fhdt24"
}
local AttrNum2Str = {
	"1",
	"2",
	"3",
	"4",
	"5",
	"6"
}
local kNormalOpenAnim = "story_main_view_newchoice_%s_open"
local kNormalCloseAnim = "story_main_view_newchoice_%s_close"
local kNormalChoiseAnim = "story_main_view_newchoice_yuan_%s_%s"
local FILLAMOUN_TIME = 2
local longClickTriggerTime = 0.01
local RewindTime = 0.3
local SHOW_TIPS_ANIMATION_TIME = 4

function M:buildUI()
	self._normalOptionPanel = self:getGo("story_main_view_-719354965")
	self._paotuanOptionPanel = self:getGo("story_main_view_1795691225")
	self._paotuanAnim = self._paotuanOptionPanel:GetComponent(ComponentType.Animation)
	self._paotuanAnimEvent = Astral.AnimationEventListener.Get(self._paotuanOptionPanel)
	self._isWrongAnswer = {}
	self._allOptionDesc = {}
	self._normalOptionMap = {}
	self._normalOptionLabs = {}
	self._normalOptionTrigger = {}
	self._normalOptionAnim = {}
	self._normalChoiceAnim = {}
	self._normalOptionAnimEvent = {}
	self._normalChoiceAnimEvent = {}
	self._isUnlockChoice = {}
	self._paotuanOptionMap = {}
	self._paotuanOptionLabs = {}
	self._paotuanOptionTrigger = {}
	self._playerIcon = goutil.findChildRawImageComponent(self.mainGO, "attrChoicePanel/maskHint/maskIcon")
	self._photoeffect = PhotoEffect.Get(self._playerIcon.gameObject)

	for i = 1, 4 do
		self._normalOptionMap[i] = goutil.findChild(self.mainGO, string.format("normalChoicePanel/choicePanel_%s", i))
		self._normalOptionAnim[i] = self._normalOptionMap[i].gameObject:GetComponent(ComponentType.Animation)
		self._normalChoiceAnim[i] = goutil.findChild(self._normalOptionMap[i], "Panel").gameObject:GetComponent(ComponentType.Animation)
		self._normalOptionAnimEvent[i] = Astral.AnimationEventListener.Get(self._normalOptionAnim[i].gameObject)
		self._normalChoiceAnimEvent[i] = Astral.AnimationEventListener.Get(self._normalChoiceAnim[i].gameObject)

		local obj = goutil.findChild(self.mainGO, string.format("attrChoicePanel/choicePanel_%s", i))
		local animationComp = obj:GetComponent(ComponentType.Animation)

		self._paotuanOptionMap[i] = {
			obj = obj,
			animationComp = animationComp
		}
	end

	self._warningHint = self:getGo("story_main_view_132411397")
	self._warningText = self:getUIComponent("story_main_view_1502747151", UIComponentType.TextMeshProUGUI)
	self._sixDimInfoFlag = UIPolygon.Get(self:getGo("story_main_view_1046008847"))
	self._playAtrrMap = {
		{
			txtLevel = goutil.findChildTextComponent(self.mainGO, "attrChoicePanel/sixdimensioninfo/power/txtLevel")
		},
		{
			txtLevel = goutil.findChildTextComponent(self.mainGO, "attrChoicePanel/sixdimensioninfo/agile/txtLevel")
		},
		{
			txtLevel = goutil.findChildTextComponent(self.mainGO, "attrChoicePanel/sixdimensioninfo/knowledge/txtLevel")
		},
		{
			txtLevel = goutil.findChildTextComponent(self.mainGO, "attrChoicePanel/sixdimensioninfo/communicate/txtLevel")
		},
		{
			txtLevel = goutil.findChildTextComponent(self.mainGO, "attrChoicePanel/sixdimensioninfo/insight/txtLevel")
		},
		{
			txtLevel = goutil.findChildTextComponent(self.mainGO, "attrChoicePanel/sixdimensioninfo/lucky/txtLevel")
		}
	}
	self._optionBg = self:getGo("story_main_view_-808069994")
	self._blurBg = self:getUIComponent("story_main_view_-2105080060", UIComponentType.RawImage)

	goutil.setActive(self._blurBg.gameObject, false)
end

function M:destroyUI()
	table.clear(self._isWrongAnswer)
	table.clear(self._normalOptionMap)
	table.clear(self._normalOptionLabs)
	table.clear(self._normalOptionTrigger)
	table.clear(self._paotuanOptionMap)
	table.clear(self._paotuanOptionLabs)
	table.clear(self._paotuanOptionTrigger)
	table.clear(self._allOptionDesc)
	table.clear(self._isUnlockChoice)
end

function M:bindEvents()
	self._paotuanAnimEvent:AddListener(self._onPaoTuanAnimEvent, self)

	for i = 1, 4 do
		self._normalOptionAnimEvent[i]:AddListener(function()
			self:_onNormalAnimEvent(i)
		end)
		self._normalChoiceAnimEvent[i]:AddListener(function()
			self:_onNormalChoiceAnimEvent(i)
		end)
	end
end

function M:_onNormalAnimEvent(index)
	self:_hideNormalOption()
	self:setVisible(false)
	StoryViewStateModel.instance:clear()

	self._isPlayChoseAnim = false
end

function M:_onNormalChoiceAnimEvent(index)
	self:_onClickNormalFinish()
	self:_playNormalAnim(index, false)
end

function M:_onPaoTuanAnimEvent(animEvent)
	StoryViewStateModel.instance:clear()
	self:setVisible(false)
end

function M:_playNormalAnim(index, isOpen)
	self._normalOptionAnim[index]:Stop()

	local animationName = false

	if isOpen then
		animationName = string.format(kNormalOpenAnim, index)
	else
		animationName = string.format(kNormalCloseAnim, index)
	end

	self._normalOptionAnim[index]:Play(animationName)
end

function M:playNormalChoiceAnim(index)
	self._isPlayChoseAnim = true

	local len = self._curOptionLen

	self._normalChoiceAnim[len]:Stop()
	self._normalChoiceAnim[len]:Play(string.format(kNormalChoiseAnim, len, index))
end

function M:_playPaoTuanChoiceAnim(isSuc, index)
	printError("播放顺序选项", index)
end

function M:_trySaveWrongAnswer(index)
	local isWrongAnswer = self._isWrongAnswer[index] or false

	self:_recordHistory(index, isWrongAnswer)

	if isWrongAnswer then
		local _storyEntry = StoryController.instance:getCurStoryEntry()

		if _storyEntry then
			StoryModel.instance:cacheWrongOption(_storyEntry:_GetCurrShotId(), self.m_questionFlag)
		end
	else
		StoryModel.instance:clearWrongOption()
	end
end

function M:_onPlayHuDieAnim()
	self:_onShowLeftTopTip()
end

function M:_onShowLeftTopTip()
	self:_onChoice(true, self._curIndex)
end

function M:_showWarnTip(index)
	goutil.setActive(self._warningHint, true)

	local length = self._curOptionLen
	local curAttrType = self._paotuanOptionMap[length].attrTypes[index] or 0
	local curAttrValue = self._paotuanOptionMap[length].attrValues[index] or 0

	for aK, aV in ipairs(self._playerCardAttributeMap) do
		if aV.id == curAttrType then
			curAttrValue = aV.level

			break
		end
	end

	if curAttrType > 0 then
		local nameTip = RoguelikeConst.AttrType2Name[curAttrType - 1]
		local curAttrStr = AttrNum2Str[curAttrValue]

		curAttrStr = curAttrStr or curAttrValue > #AttrNum2Str and "6" or "1"
		self._warningText.text = langF("tip_story_warnging_tip", nameTip, Attr2Icon[curAttrType] or "fhdt19", curAttrStr)
	end
end

function M:_hideWarnTip()
	goutil.setActive(self._warningHint, false)
end

function M:unbindEvents()
	self._paotuanAnimEvent:RemoveListener()

	for i = 1, 4 do
		self._normalOptionAnimEvent[i]:RemoveListener()
		self._normalChoiceAnimEvent[i]:RemoveListener()
	end

	for index, clickTrigger in pairs(self._normalOptionTrigger) do
		clickTrigger:RemoveClickListener()
	end

	for index, clickTrigger in pairs(self._paotuanOptionTrigger) do
		clickTrigger:RemoveClickListener()
	end
end

function M:onEnter()
	StoryDispatcher:addEventListener(StoryNotifyName.UIBranchEnter, self.OnBranchUI, self)
	StoryDispatcher:addEventListener(StoryNotifyName.UIBranchExit, self._onCloseRadio, self)
end

function M:OnBranchUI(evt, optionType, questionFlag, dataList)
	self.m_radioType = optionType
	self.m_questionFlag = questionFlag

	local length = #dataList

	self._curOptionLen = length
	self._optionTb = dataList
	self._isPlayAtrrAnim = false

	self:_showOptionInfo()
end

function M:_onCloseRadio()
	return
end

function M:_showOptionInfo()
	self._isPlayNormalChoiceAnim = false
	self._isPlayChoseAnim = false
	self._isLongPressOn = false

	local optionType = self.m_radioType

	goutil.setActive(self._normalOptionPanel, optionType == StoryRadioType.Normal)
	goutil.setActive(self._paotuanOptionPanel, false)
	StoryFacde.instance:setSkipState(false)
	StoryDispatcher:dispatchEvent(StoryNotifyName.UIDialogVisibleSwitch, true)
	self:_blurOptionBg()

	if optionType == StoryRadioType.Normal then
		self:_showNormalOption()
	elseif optionType == StoryRadioType.Attribute then
		self:_showPaoTuanOption()
	else
		printError("未支持的选项类型", optionType)
	end
end

function M:onExit()
	self._photoeffect:clear()
	self:_setPointEffect(true)
	self._paotuanAnim:Stop()
	goutil.setActive(self._optionBg, false)
	goutil.setActive(self._normalOptionPanel, false)
	goutil.setActive(self._paotuanOptionPanel, false)
	self:_hideNormalOption()
	removetimer(self._hideWarnTip, self)
	StoryFacde.instance:setSkipState(true)
	StoryDispatcher:removeEventListener(StoryNotifyName.UIBranchEnter, self.OnBranchUI, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.UIBranchExit, self._onCloseRadio, self)
end

function M:setVisible(visible)
	if not visible then
		self._isPlayAtrrAnim = false

		table.clear(self._optionTb)
		table.clear(self._isWrongAnswer)
		table.clear(self._allOptionDesc)
		goutil.setActive(self._normalOptionPanel, visible)
		goutil.setActive(self._paotuanOptionPanel, visible)
		StoryFacde.instance:setSkipState(true)
		goutil.setActive(self._blurBg.gameObject, false)

		for i = 1, 4 do
			goutil.setActive(self._normalOptionMap[i], false)
			goutil.setActive(self._paotuanOptionMap[i].obj, false)
		end
	end
end

function M:_blurOptionBg()
	self:_setPointEffect(false)
	self:_onBlurFinish()
end

function M:_setPointEffect(active)
	GlobalDispatcher:dispatchEvent(EventType.SHOW_POINTER_EFFECT, active)
end

function M:_onBlurFinish()
	goutil.setActive(self._blurBg.gameObject, false)

	self._blurBg.enabled = true

	if self.m_radioType == StoryRadioType.Attribute then
		goutil.setActive(self._paotuanOptionPanel, true)
		self._paotuanAnim:Stop()

		local length = self._curOptionLen

		self._paotuanAnim:Play(string.format("story_main_view_rungroup_open%s", length))
	end

	self:_setPointEffect(true)
end

function M:_checkBattleQuestion()
	local question = self.m_questionFlag

	self._questionKey = false

	if question > 0 then
		if StoryModel.instance:checkBattleQuestionExist(question) then
			return
		end

		self._questionKey = question
	end
end

function M:_showNormalOption()
	self:_checkBattleQuestion()

	for index, clickTrigger in pairs(self._normalOptionTrigger) do
		clickTrigger:RemoveClickListener()
	end

	local length = self._curOptionLen
	local options = self._optionTb

	for i = 1, 4 do
		goutil.setActive(self._normalOptionMap[i], i == length)

		if i == length then
			self:_playNormalAnim(i, true)

			for j = 1, length do
				local content = options[j].radioContext

				content = StoryUtils.replaceUserNameFlag(content)

				local nextGroupId = options[j].nextGroupId

				self._normalOptionTrigger[j] = Astral.UIClickTrigger.Get(goutil.findChild(self._normalOptionMap[i], string.format("Panel/btnChoice%s", j)))
				self._normalOptionLabs[j] = goutil.findChildComponent(self._normalOptionTrigger[j].gameObject, "Text", UIComponentType.TextMeshProUGUI)

				if not self._allOptionDesc[j] then
					self._allOptionDesc[j] = {}
				end

				self._allOptionDesc[j].content = content
				self._isWrongAnswer[j] = options[j].isError
				self._allOptionDesc[j].nextGroupId = nextGroupId
				self._normalOptionLabs[j].text = content
			end
		end
	end

	for index, clickTrigger in pairs(self._normalOptionTrigger) do
		local isWrongAnser = self._isWrongAnswer[index] or false

		clickTrigger:AddClickListener(self._onClickChoice, self, {
			index,
			isWrongAnser
		})
	end
end

function M:_updateChoiceSign(index)
	local isBattleAnswer = false
	local isChapterAnswer = false
	local tempAnswer = ""

	if self._questionKey then
		local question = self._questionKey

		tempAnswer = string.format("%s#%s", self._questionKey, index)

		if question < 500001 then
			isBattleAnswer = BattleConfig.instance:getBattleAnswer(tempAnswer)
		else
			isChapterAnswer = DungeonConfig.instance:getMainlineDungeonUnlockCOByAnswer(tempAnswer)
		end
	end

	return isBattleAnswer, isChapterAnswer
end

function M:_hideNormalOption()
	for _, v in ipairs(self._normalOptionMap) do
		goutil.setActive(v, false)
	end
end

function M:talkOptionActive()
	for _, v in ipairs(self._normalOptionMap) do
		if v.activeSelf then
			return true
		end
	end

	return false
end

function M:isOptionActive()
	if self._normalOptionPanel.activeSelf or self._paotuanOptionPanel.activeSelf then
		return true
	end

	return false
end

function M:_showPaoTuanOption()
	goutil.setActive(self._warningHint, false)
	self:_checkBattleQuestion()
	self:_loadPlayMaskInfo()

	local playerCardAttributeMap = {}
	local playerInfo = PlayerModel.instance:getPlayerCardInfo()

	if playerInfo then
		playerCardAttributeMap = playerInfo.attribute
	else
		for i = 1, 6 do
			local attribute = PlayerExtension_pb.PlayerCardAttribute()

			attribute.id = i
			attribute.level = math.random(1, 6)

			table.insert(playerCardAttributeMap, attribute)
		end
	end

	self._playerCardAttributeMap = playerCardAttributeMap

	local attrInOptionTb = {}
	local question = self.m_questionFlag > 0
	local options = self._optionTb
	local length = self._curOptionLen

	for i = 1, 4 do
		goutil.setActive(self._paotuanOptionMap[i].obj, i == length)

		if i == length then
			self._paotuanOptionMap[i].isLocks = {}
			self._paotuanOptionMap[i].attrTypes = {}
			self._paotuanOptionMap[i].attrValues = {}
			self._paotuanOptionMap[i].optionEffectTypes = {}
			self._paotuanOptionMap[i].optionDescs = {}

			for j = 1, length do
				local attrChoiceRoot = self._paotuanOptionMap[i].obj

				self._paotuanOptionTrigger[j] = Astral.UIClickTrigger.Get(goutil.findChild(attrChoiceRoot, string.format("choice%s", j)))

				local attrObj = goutil.findChild(attrChoiceRoot, string.format("choice%s/optionDes/txtDesc/dice_attribute", j))
				local attrIcon = goutil.findChildImageComponent(attrChoiceRoot, string.format("choice%s/optionDes/txtDesc/dice_attribute/icon", j))
				local attrLab = goutil.findChildTextComponent(attrChoiceRoot, string.format("choice%s/optionDes/txtDesc/dice_attribute/txtLevel", j))
				local effectObj = goutil.findChild(attrChoiceRoot, string.format("choice%s/labelDes", j))
				local effectLab = goutil.findChildTextComponent(attrChoiceRoot, string.format("choice%s/labelDes/txtDes", j))
				local effectLabPanel = goutil.findChildComponent(attrChoiceRoot, string.format("choice%s/labelDes", j), ComponentType.CanvasGroup)

				self._paotuanOptionLabs[j] = goutil.findChildComponent(attrChoiceRoot, string.format("choice%s/optionDes/txtDesc", j), UIComponentType.TextMeshProUGUI)

				local content = tonumber(options[j].nextGroupId) > 0 and options[j].radioContext or ""

				content = StoryUtils.replaceUserNameFlag(content)
				self._paotuanOptionLabs[j].text = content

				local curAttrType = options[j].attrUnLockType
				local curAttr = options[j].attrUnlockValue
				local optionEffectType = options[j].influence

				self._isWrongAnswer[j] = options[j].isError
				self._paotuanOptionMap[i].attrTypes[j] = curAttrType
				self._paotuanOptionMap[i].attrValues[j] = curAttr
				self._paotuanOptionMap[i].optionEffectTypes[j] = optionEffectType
				self._paotuanOptionMap[i].optionDescs[j] = content

				goutil.setActive(effectObj, optionEffectType ~= StoryRadioInfluence.None)

				if optionEffectType == StoryRadioInfluence.Battle then
					effectLab.text = lang("tip_story_attr_option_battle")
				elseif optionEffectType == StoryRadioInfluence.Branch then
					effectLab.text = lang("tip_story_attr_option_chapater")
				end

				local canUnlock = false
				local unlockDescInfo = ""
				local playerAttrValue = curAttr

				if curAttrType > 0 then
					for aK, aV in ipairs(playerCardAttributeMap) do
						if aV.id == curAttrType then
							playerAttrValue = aV.level
							canUnlock = curAttr <= aV.level
							self._isUnlockChoice[j] = canUnlock

							break
						end
					end

					self._paotuanOptionMap[i].isLocks[j] = canUnlock

					IconLoader.setSprite(attrIcon, IconType.DynSpriteAtlas_Plot, string.format("dice_%s", curAttrType))
					TextUtils.SetColor(self._paotuanOptionLabs[j], canUnlock and "#E8E7E7" or "#858585")
					TextUtils.SetColor(attrLab, canUnlock and "#E8E7E7" or "#858585")
					Astral.ColorUtil.SetImageColor(attrIcon, canUnlock and "#E8E7E7" or "#858585")

					effectLabPanel.alpha = canUnlock and 1 or 0.4

					local needAttrStr = AttrNum2Str[curAttr]

					needAttrStr = needAttrStr or curAttr > #AttrNum2Str and "6" or "1"
					attrLab.text = canUnlock and needAttrStr or string.format("%s/%s", playerAttrValue, needAttrStr)
					unlockDescInfo = langF("tip_story_record_option_desc", Attr2Icon[curAttrType], needAttrStr)

					table.insert(attrInOptionTb, {
						attrType = curAttrType,
						attrValue = curAttr
					})
					goutil.setActive(attrObj, true)
				else
					self._paotuanOptionMap[i].isLocks[j] = true

					goutil.setActive(attrObj, false)
				end

				if not self._allOptionDesc[j] then
					self._allOptionDesc[j] = {}
				end

				self._allOptionDesc[j].content = content .. unlockDescInfo
				self._allOptionDesc[j].unlockType = tonumber(optionEffectType)
			end
		end
	end

	self:_showPlayAtrr(playerCardAttributeMap, attrInOptionTb)

	for index, clickTrigger in pairs(self._paotuanOptionTrigger) do
		local isWrongAnser = self._isWrongAnswer[index] or false

		clickTrigger:AddClickListener(self._onClickChoiceAttr, self, {
			index,
			isWrongAnser
		})
	end

	self:_tryTriggerGuide()
end

function M:_loadPlayMaskInfo()
	local playerIcon = 2301006
	local info = PlayerModel.instance:getPlayerCardInfo()

	if info then
		local portraitCO = BackpackConfig.instance:getItemInfoByItemId(info.portrait)

		if portraitCO then
			playerIcon = portraitCO.icon
		end
	end

	local maskPath = string.format("zhuguanmianju3d/%s.prefab", playerIcon)

	self._photoeffect:clear()
	self._photoeffect:setEffectLoadedCallback(self._loadMaskDone, self)
	self._photoeffect:showEffects(maskPath)
	self._photoeffect:setCameraPerspective(43)
	self._photoeffect:setCameraPosition(0, -0.02, -0.1)
	self._photoeffect:setCameraTag(SceneTag.RTCamera)
end

function M:_loadMaskDone(inst, res)
	local tweenAnim = inst:GetComponent("AutoTweenAnim_ForArtist")

	if tweenAnim then
		tweenAnim.enabled = false
	end
end

function M:_tryTriggerGuide()
	local question = self.m_questionFlag

	if question > 0 then
		GlobalDispatcher:dispatchEvent(EventType.STORY_ACTIVE_ATT_OPTION, question)
	end
end

function M:_showPlayAtrr(playerCardAttributeMap, attrInOptionTb)
	for aK, aV in ipairs(playerCardAttributeMap) do
		local curPlayAttrInfo = self._playAtrrMap[aV.id]
		local hasFind = false
		local optionNeedValue = 0

		for i = 1, #attrInOptionTb do
			if attrInOptionTb[i].attrType == aV.id then
				hasFind = true
				optionNeedValue = attrInOptionTb[i].attrValue

				break
			end
		end

		curPlayAttrInfo.txtLevel.text = AttrNum2Str[aV.level]

		self._sixDimInfoFlag:InitPolygon(self:_getRealIndex(aV.id), aV.level / 6)
	end
end

function M:_onClickChoiceAttr(evt, param)
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_juqing_dialogselect)

	if self._isPlayAtrrAnim then
		return
	end

	local index = param[1]

	self:_trySaveWrongAnswer(index)

	self._isPlayChoseAnim = true
	self._curClickNormalIndex = index
	self._curIndex = index

	if not self._curIndex then
		return
	end

	local length = self._curOptionLen
	local canUnlock = self._paotuanOptionMap[length].isLocks[index]

	if not canUnlock then
		self:_showWarnTip(index)
		removetimer(self._hideWarnTip, self)
		settimer(0.5, self._hideWarnTip, self, false)

		return
	end

	local isUserJump = StoryModel.instance:getUserJump()
	local hasHuDieEffect = false

	self:_trySaveWrongAnswer(self._curIndex)
	self._paotuanOptionMap[length].animationComp:Stop()
	self._paotuanOptionMap[length].animationComp:Play(string.format("story_main_view_choice_btn_open%s", index))

	self._isPlayAtrrAnim = true

	StoryDispatcher:dispatchEvent(StoryNotifyName.OnFinishAttrOption)

	local optionDesc = ""
	local question = self.m_questionFlag

	if question > 0 then
		local tempAnswer = string.format("%s#%s", question, self._curIndex)

		if question >= 500001 then
			optionDesc = lang("tip_story_unlock_chapater_title")

			if not GuideModel.instance:hasPlotAnswer(tonumber(question), tonumber(self._curIndex)) then
				local isChapterAnswer = DungeonConfig.instance:getMainlineDungeonUnlockCOByAnswer(tempAnswer)

				if isChapterAnswer then
					GlobalDispatcher:dispatchEvent(EventType.FIRST_UNLOCK_CHAPTER_BY_STORY)

					hasHuDieEffect = true

					ViewMgr.instance:openSpecialView(ViewName.StoryUnlockTipView, {
						index = 2,
						desc = optionDesc,
						callBack = isUserJump and self._onPlayHuDieAnim or false,
						handle = self
					})
				end
			end
		elseif question > 0 and question < 500000 then
			optionDesc = lang("tip_story_unlock_battle_title")
			hasHuDieEffect = true

			ViewMgr.instance:openSpecialView(ViewName.StoryUnlockTipView, {
				index = 1,
				desc = optionDesc,
				callBack = isUserJump and self._onPlayHuDieAnim or false,
				handle = self
			})
		end
	end

	if not isUserJump or not hasHuDieEffect then
		self:_onShowLeftTopTip()
	end
end

function M:_onClickChoice(eventData, param)
	if self._isPlayChoseAnim then
		return
	end

	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_juqing_dialogselect)

	local index = param[1]

	self:_trySaveWrongAnswer(index)

	self._isPlayChoseAnim = true
	self._curClickNormalIndex = index

	self:playNormalChoiceAnim(index)
end

function M:_recordHistory(index, isError)
	local data = self._allOptionDesc[index]

	if not data then
		return
	end

	local historyData = {}
	local changeIcon = ""

	if data.unlockType and data.unlockType > 0 then
		changeIcon = data.unlockType == 1 and "[jqzdan]" or "[jqdztb]"
	end

	local _storyEntry = StoryController.instance:getCurStoryEntry()

	if not _storyEntry then
		return
	end

	historyData.index = _storyEntry:_GetCurrIndex()
	historyData.content = string.format("<color=#ff696d>%s%s</color>", data.content or "", data.unlockInfo and changeIcon .. data.unlockInfo or "")
	historyData.content = StoryUtils.replaceUserNameFlag(historyData.content)
	historyData.name = string.format("<color=#ff696d>%s</color>", lang("tip_story_record_option"))
	historyData.isOption = true
	historyData.isError = isError

	StoryModel.instance:addHistory(historyData)
end

function M:_onClickNormalFinish()
	if self._curClickNormalIndex then
		self:_onChoice(false, self._curClickNormalIndex)
	end
end

function M:_onChoice(isPaotuan, index)
	if self._questionKey then
		StoryModel.instance:setBattleEvent(self._questionKey, index)

		self._questionKey = false
	end

	local data = self._optionTb[index]

	if data then
		local nextGroupId = tonumber(data.nextGroupId)

		if nextGroupId > 0 then
			StoryController.instance:getCurStoryEntry():SwitchShot(data.nextGroupId)
		end
	end

	if isPaotuan and self._paotuanOptionPanel.activeSelf then
		self._paotuanAnim:Stop()
		self._paotuanAnim:Play("story_main_view_rungroup_close")
	end
end

function M:_showNext()
	if self._callback then
		self._callback(self._handle)

		self._callback = nil
		self._handle = nil
	end

	if self._isJump then
		StoryMgr.instance:doNext(self._stepId)

		return
	end
end

function M:_onClickHistory()
	StoryFacde.instance:setHistoryVisible(true)
end

function M:_getRealIndex(idx)
	if idx == 1 then
		return 2
	elseif idx == 2 then
		return 1
	elseif idx == 6 then
		return 3
	elseif idx == 5 then
		return 4
	elseif idx == 3 then
		return 0
	elseif idx == 4 then
		return 5
	end
end

function M:hasAttrOption()
	return self._paotuanOptionPanel.activeSelf
end

return M
