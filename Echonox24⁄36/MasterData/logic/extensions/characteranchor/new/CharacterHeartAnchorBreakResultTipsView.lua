-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characteranchor/new/CharacterHeartAnchorBreakResultTipsView.lua

module("logic.extensions.characteranchor.new.CharacterHeartAnchorBreakResultTipsView", package.seeall)

local M = class("CharacterHeartAnchorBreakResultTipsView", ViewComponent)

M.LightCode = 13

function M:buildUI()
	self._btnClose = self:getBtn("heart_anchor_break_view_770151614")
	self._guiAniAnchor = self:getUIComponent("heart_anchor_break_view_-1604837963", typeof(Astral.GUITimelineAniLua))
	self._txtAnchorBreak = self:getUIComponent("heart_anchor_break_view_522592511", UIComponentType.Text)
	self._rectTrAnchor = self:getUIComponent("heart_anchor_break_view_-886884861", UIComponentType.RectTransform)
	self._goBlackAnchor = self:getGo("heart_anchor_break_view_1276286083")
	self._breakPointNext = {}
	self._breakPointDone = {}

	for i = 1, 5 do
		table.insert(self._breakPointNext, goutil.findChild(self._rectTrAnchor.gameObject, string.format("imgDi/doing/break%s", i)).gameObject)

		local imgDone = goutil.findChildComponent(self._rectTrAnchor.gameObject, string.format("imgDi/done/break%s", i), UIComponentType.Image)

		imgDone.color = parsecolor("#FFFFFF")

		table.insert(self._breakPointDone, imgDone.gameObject)
	end

	self._goPanel2 = self:getGo("heart_anchor_break_view_-729428349")
	self._heroLoader = MultiResLoader.New()
	self._rawImageHero = self:getUIComponent("heart_anchor_break_view_216836033", UIComponentType.RawImage)
	self._canvasGroupHero = goutil.addComponentOnce(self._rawImageHero.gameObject, ComponentType.CanvasGroup)

	goutil.setActive(self._rawImageHero.gameObject, true)

	self._photoUnit = PhotoModel.Get(self._rawImageHero.gameObject)
	self._txtHeroName = self:getUIComponent("heart_anchor_break_view_756951179", UIComponentType.Text)
	self._txtDialogue = self:getUIComponent("heart_anchor_break_view_2144933036", UIComponentType.Text)
	self._goRootSkill = self:getGo("heart_anchor_break_view_-779211641")
	self._cellSkill = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self._goRootSkill, "skill_item_1"), SkillItem1)

	self._cellSkill:setClickListener(self._onClickSkill, self)

	self._txtSkillName = self:getUIComponent("heart_anchor_break_view_-785585718", UIComponentType.Text)
	self._txtSkillContent = self:getUIComponent("heart_anchor_break_view_930163138", UIComponentType.TextMeshProUGUI)
	self._goRootAttr = self:getGo("heart_anchor_break_view_1852779468")
	self._txtAttrUpgrade = self:getUIComponent("heart_anchor_break_view_1465096084", UIComponentType.Text)
	self._txtAttrPre = {}
	self._txtAttrNow = {}

	for i = 1, self._goRootAttr.transform.childCount - 1 do
		local tr = goutil.findChild(self._goRootAttr, string.format("hint%s", i))

		if tr then
			table.insert(self._txtAttrPre, goutil.findChildComponent(tr.gameObject, "txtNum1", UIComponentType.Text))
			table.insert(self._txtAttrNow, goutil.findChildComponent(tr.gameObject, "txtNum2", UIComponentType.Text))
		end
	end
end

function M:destroyUI()
	if self._photoUnit then
		self._photoUnit:clear()
	end

	self._photoUnit = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter(reasonType)
	self._openAniFinish = false

	self:setEvent(true)

	local info = self:getFirstParam() or {}

	self._heroId = info.heroId
	self._skinId = info.skinId
	self._curLv = info.curLv
	self._characterCO = CharacterConfig.instance:getCfgInfoByID(self._heroId)

	if Astral.OSDef.isEditor then
		printWarn(string.format("hero[%s] skin[%s] lv[%s]", self._heroId, self._skinId, self._curLv))
	end

	self:_refreshView()
	self:_refreshPointPre()
	self:_refreshHero(self._heroId, self._skinId)
	self:_playAnchorGuiAni(self._curLv)
end

function M:onEnterFinished()
	return
end

function M:onExit(reasonType)
	removetimer(self._onDelayShowLight, self)
	LightMgr.instance:turnOff(M.LightCode)

	local isNormalClose = reasonType ~= WindowType.WindowCloseReasonType.QuickCloseType

	self:setEvent(false)

	local info = self:getFirstParam() or {}

	if info.exitFunc then
		if info.exitHandler then
			info.exitFunc(info.exitHandler)
		else
			info.exitFunc()
		end
	end

	if self._photoUnit then
		self:_refreshPosition(false)
		self._photoUnit:clear()
	end

	self._heroLoader:clear()
end

function M:onExitFinished()
	return
end

function M:setEvent(add)
	if add then
		self:registerLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
	else
		self:unregisterLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
	end
end

function M:_handleViewAniDoneEvent(key, tagName, reason)
	if tagName == "open" then
		self._openAniFinish = true
	elseif tagName == "point" then
		self:_refreshPointCur()
	elseif tagName == "hero" then
		self:_playVoiec()
	end
end

function M:_onClickClose()
	if not self._openAniFinish then
		return
	end

	self:close()
end

function M:_onClickSkill()
	return
end

function M:_refreshView()
	local curLevel = self._curLv
	local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(self._heroId)

	self._txtHeroName.text = heroInfoCO and heroInfoCO.name or ""

	local cfgAudio = CharacterAudioConfig.instance:getCharacterAudioCOByHeroIdAndAudioId(self._heroId, CharacterInfoEnum.VoiceResKey.tupo)

	self._txtDialogue.text = cfgAudio and cfgAudio.qipaoContent or ""
	self._txtAnchorBreak.text = CommEnum.Num2RomeNum[curLevel]

	local cfgBreakAttrCO = HeroBreakConfig.instance:getAttrCO(self._heroId, curLevel)

	if cfgBreakAttrCO then
		if cfgBreakAttrCO.attrGrowEnhance > 0 then
			local num_cur = math.floor(cfgBreakAttrCO.attrGrowEnhance * 100)
			local num_pre = 0

			if curLevel - 1 > 0 then
				for _lv = 1, curLevel - 1 do
					local _cfg = HeroBreakConfig.instance:getAttrCO(self._heroId, _lv)

					if _cfg.attrGrowEnhance > 0 then
						num_pre = num_pre + math.floor(_cfg.attrGrowEnhance * 100)
					end
				end
			end

			local num_cur_total = num_cur + num_pre

			for _, _txt in ipairs(self._txtAttrPre) do
				_txt.text = string.format("+%s%%", num_pre)
			end

			for _, _txt in ipairs(self._txtAttrNow) do
				_txt.text = string.format("+%s%%", num_cur_total)
			end

			self._txtAttrUpgrade.text = langF("tips_heart_anchor_break_attr_upgrade", num_cur)

			goutil.setActive(self._goRootSkill, false)
			goutil.setActive(self._goRootAttr, true)
		elseif cfgBreakAttrCO.skillId > 0 or cfgBreakAttrCO.skillIdForShow > 0 then
			local _desc, _name, _mo

			if cfgBreakAttrCO.skillIdForShow > 0 then
				_mo = SkillEnhanceMO.getSharedMO(cfgBreakAttrCO.skillIdForShow)
				_desc = _mo:getDescription()
				_name = _mo:getName()
			else
				_mo = SkillEnhanceMO.getSharedMO(cfgBreakAttrCO.skillId)

				if cfgBreakAttrCO.skillEnhanceId > 0 then
					local skillEnhanceCOWrapper = ActiveSkillConfig.instance:getSkillEnhanceCOWrapper(cfgBreakAttrCO.skillEnhanceId)

					_desc = skillEnhanceCOWrapper:getDescription(true)
					_name = skillEnhanceCOWrapper:getName()
				else
					_desc = _mo:getDescription()
					_name = _mo:getName()
				end
			end

			self._txtSkillName.text = _name
			self._txtSkillContent.text = _desc

			self._cellSkill:setSkillEnhanceMO(self._heroId, _mo)
			SkillEnhanceMO.releaseSharedMO(_mo)
			goutil.setActive(self._goRootSkill, true)
			goutil.setActive(self._goRootAttr, false)
		else
			goutil.setActive(self._goRootSkill, false)
			goutil.setActive(self._goRootAttr, false)
		end
	end
end

function M:_refreshPointPre()
	local curLevel = self._curLv
	local preLevel = curLevel - 1

	for i = 1, 5 do
		local isBreak = i <= preLevel
		local isReadyBreak = i == curLevel
		local goNext = self._breakPointNext[i]
		local goDone = self._breakPointDone[i]

		goutil.setActive(goNext, isReadyBreak)
		goutil.setActive(goDone, isBreak and not isReadyBreak)
	end
end

function M:_refreshPointCur()
	local curLevel = self._curLv

	for i = 1, 5 do
		local isBreak = i <= curLevel
		local goNext = self._breakPointNext[i]
		local goDone = self._breakPointDone[i]

		goutil.setActive(goNext, false)
		goutil.setActive(goDone, isBreak)
	end
end

function M:_refreshHero(heroId, skinId)
	local modelId = self:_getModelId(heroId, skinId)

	self._modelData = nil

	if modelId then
		self._modelData = ModelConfig.instance:getModelData(modelId)
	end

	if not self._modelData then
		return
	end

	self._heroLoader:clear()

	local resPath = self._modelData:getMainModelResPath()
	local idleAnimClip = GameUrl.getMainSceneMeshModelClipUrl(self._modelData:mainSceneResName(), MainPerformEnum.AnimFullName.ChoukaIdle)

	self._heroLoader:addResPath(resPath)
	self._heroLoader:addResPath(idleAnimClip)
	self._heroLoader:load(self._onAllHeroLoaded, false, self)
end

function M:getHeroResource(resPath)
	return self._heroLoader:getResource(resPath)
end

function M:_onAllHeroLoaded()
	if not self._heroLoader:isAllSuccess() then
		if enableErrorLog then
			printError("preload hero resource failed!")
		end

		return
	end

	local characterCO = self._characterCO
	local modelData = self._modelData
	local idleAnimClip = GameUrl.getMainSceneMeshModelClipUrl(modelData:mainSceneResName(), MainPerformEnum.AnimFullName.ChoukaIdle)
	local resPath = GameUrl.getMainSceneMeshModelUrl(modelData:mainSceneResName())

	self._photoUnit:setRTDepth(0)
	self._photoUnit:setModelLoadCallback(function(handler, inst, res)
		local heightLevel = modelData:height()
		local heightFix = CharacterCOUtil.getHeroHeight(heightLevel)

		Astral.TransformUtil.SetLocalPos(inst.transform, -0.4, heightFix, 0)
		Astral.TransformUtil.SetLocalRotation(inst.transform, 0, 180, 0)

		local _animationPlayer = AnimationPlayer.Get(inst.gameObject)
		local _animState = MainPerformEnum.AnimFullName.ChoukaIdle
		local animClipRes = self:getHeroResource(idleAnimClip)

		if animClipRes then
			local animClip = animClipRes:GetMainAsset()

			_animationPlayer:ReplaceClip(_animState, animClip)
			_animationPlayer:PlayAnimation(_animState, true, true)
		end

		local modelId = modelData:modelId()
		local xinMao = Astral.SimpleLuaComponentContainer.Add(inst.gameObject, UnitCompHeroXinMao)

		xinMao:setInfo(modelId, inst.gameObject, function(_handler, xinMaoInst)
			Astral.GameObjectUtil.SetLayerRecursively(xinMaoInst, SceneLayer.UI3D_Value)
		end, self)
		removetimer(self._onDelayShowLight, self)
		settimer(1, self._onDelayShowLight, self, false)
	end, self)
	self._photoUnit:updateResWithSize(resPath, nil, 1300, 1300, nil)
	self._photoUnit:setCameraTag(SceneTag.RTCamera)
	self._photoUnit:setCameraPostProcessing(true, SceneLayer.Default_Value)
	self._photoUnit:setCameraPosition(-0.4, 0, -2)
	self._photoUnit:setCameraFov(40)
	self:_refreshPosition(true)
end

function M:_onDelayShowLight()
	LightMgr.instance:turnOn(M.LightCode)
end

function M:_refreshPosition(turnOn)
	local producer = self._photoUnit:getProducer()

	if self._photoUnit and producer then
		if not turnOn then
			local pos = PhotoUtil.GetPosition(producer.counter)

			GameUtils.setPos(producer.producerContainer, pos.x, pos.y, pos.z)
		else
			GameUtils.setPos(producer.producerContainer, 500, 500, 0)
		end
	end
end

function M:_getModelId(heroId, skinId)
	local modelId

	if skinId and skinId > 0 then
		local skinCo = HeroSkinConfig.instance:getInfo(skinId)

		if skinCo then
			modelId = skinCo.module
		end
	else
		local entityCO = BattleConfigUtil.getEntityConfig(heroId)

		if entityCO then
			modelId = entityCO.modelId
		else
			printError(string.format("无法找到[%s]的配置", heroId))
		end
	end

	return modelId
end

function M:_playVoiec()
	local voiceRes = string.format("speech_%s_tupo", self._heroId)

	CriwareAudioFacade.instance:playVoiceByName(voiceRes)
end

function M:_playAnchorGuiAni(lv)
	if not lv then
		return
	end

	if not self._guiAniAnchor or goutil.isNil(self._guiAniAnchor) then
		return
	end

	self._guiAniAnchor:ClearAllBinding()
	self._guiAniAnchor:StopTimelineAni()
	self._guiAniAnchor:SetAniTime(0)
	self._guiAniAnchor:PlayAniByName(tostring(lv), Astral.GUITimeLineMode.TimeToStart)
end

return M
