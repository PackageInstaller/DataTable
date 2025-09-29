-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/authority/new/CharacterAuthorityNodeUnlockView.lua

module("logic.extensions.charactersystem.view.authority.new.CharacterAuthorityNodeUnlockView", package.seeall)

local M = class("CharacterAuthorityNodeUnlockView", ViewComponent)
local kLightCode = 13
local kFov = 40
local kCameraPos = Vector3.New(-0.4, 0, -2)
local kHeroPos = Vector3.New(-0.4, 0, 0)
local kHeroRot = Vector3.New(0, 180, 0)
local kDefaultAnim = MainPerformEnum.AnimFullName.ChoukaIdle

function M:ctor()
	self._resMap = {}
end

function M:buildUI()
	self._btnClose = self:getBtn("authority_skill_unlock_view_1943826602")
	self._txtHeroName = self:getText("authority_skill_unlock_view_-1544977952", UIComponentType.Text)
	self._txtDialogue = self:getText("authority_skill_unlock_view_798248943", UIComponentType.Text)
	self._rawImageHero = self:getUIComponent("authority_skill_unlock_view_485344241", UIComponentType.RawImage)
	self._canvasGroupHero = self:getUIComponent("authority_skill_unlock_view_485344241", ComponentType.CanvasGroup)
	self._textNodeName1 = self:getText("authority_skill_unlock_view_1002620958")
	self._textNodeName2 = self:getText("authority_skill_unlock_view_1238832723")
	self._textNodeType = self:getText("authority_skill_unlock_view_1134016239")
	self._goNode = self:getGo("authority_skill_unlock_view_-2132995737")
	self._goSkillWidget = self:getGo("authority_skill_unlock_view_-542572069")
	self._textSkillName = self:getText("authority_skill_unlock_view_-1537042407")
	self._textSkillDesc = self:getUIComponent("authority_skill_unlock_view_-452078166", UIComponentType.TextMeshProUGUI)
	self._imgSkill = self:getImage("authority_skill_unlock_view_630374229")
	self._goSkillIcon = self:getGo("authority_skill_unlock_view_630374229")
	self._goSkillItem = self:getGo("1&skill_item_1_-706685850")
	self._btnSkillDesc = self:getBtn("authority_skill_unlock_view_-452078166")
	self._goChangeWidget = self:getGo("authority_skill_unlock_view_-30381351")
	self._goChangeItem = self:getGo("authority_skill_unlock_view_641472856")
	self._transfUpContent = self:getRectTransform("authority_skill_unlock_view_-30381351")
	self._goChangeMovie = self:getGo("authority_skill_unlock_view_-1760636492")

	local videoGo = self:getGo("authority_skill_unlock_view_-301192212")

	self._videoMgr = CriWareVideoMgr.Get(videoGo)
	self._photoSpace = PhotoSpace.Get(self._rawImageHero.gameObject)

	self._photoSpace:clear()
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnSkillDesc:AddClickListener(self._onClickSkillDesc, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnSkillDesc:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)

	local info = self:getFirstParam()

	self._heroId = info.heroId
	self._nodeId = info.nodeId
	self._isChangeNode = info.isChangeNode
	self._isSkillNode = not self._isChangeNode
	self._heroInfoCo = PastInfoConfig.instance:getCharacterInfo(self._heroId)
	self._heroData = HeroDepotModel.instance:getHeroInfoByID(self._heroId)
	self._nodeMo = CharacterAuthorityModel.instance:getHeroPowerNodeMO(self._heroId, self._nodeId)
	self._nodeCo = self._nodeMo:getConfig()

	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Authority)
	self:_refreshView()
	self:_refreshChange()
	self:_refreshSkill()
	self:_refreshHero()
end

function M:onExit()
	removetimer(self._onDelayShowLight, self)
	self:setEvent(false)
	LightMgr.instance:turnOff(kLightCode)
	self:_refreshPosition(false)
	table.clear(self._resMap)
	self._photoSpace:clear()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Authority)
end

function M:onExitFinished()
	GlobalDispatcher:dispatchEvent(EventType.HERO_POWER_UPGRADE_TIPS_CLOSE)
end

function M:_onDelayShowLight()
	LightMgr.instance:turnOn(kLightCode)
end

function M:destroyUI()
	self._videoMgr:DestroyMovie()

	self._videoMgr = nil

	if self._photoSpace then
		self._photoSpace:clear()
	end

	self._photoSpace = nil
end

function M:setEvent(add)
	return
end

function M:_onClickClose()
	self:close()
end

function M:_onClickSkillDesc()
	local skillId = self._nodeCo.skillId
	local skillEnhanceMO = SkillEnhanceMO.New(skillId)

	if skillEnhanceMO then
		skillEnhanceMO:rebuild()
		ToolTipsMgr.showSkillBuffTagSideTips(skillEnhanceMO, self._textSkillDesc.gameObject, true)
	end
end

function M:_refreshView()
	self._txtHeroName.text = self._heroInfoCo.name

	local cfgAudio = CharacterAudioConfig.instance:getCharacterAudioCOByHeroIdAndAudioId(self._heroId, CharacterInfoEnum.VoiceResKey.tupo)

	self._txtDialogue.text = cfgAudio and cfgAudio.qipaoContent or ""
	self._textNodeName1.text = self._nodeCo.simpleName
	self._textNodeName2.text = self._nodeCo.simpleName

	if goutil.isNil(self._goAuthorityNode) then
		self._goAuthorityNode = self:getResInstance(ResName.CharacterSystem_Authority_Node)

		goutil.addChildToParent(self._goAuthorityNode, self._goNode)
		GameUtils.setAnchorXY(self._goAuthorityNode.transform, 0, 0)

		local goIcon = goutil.findChild(self._goAuthorityNode, "bigPoint/unLock/imgIcon")

		self._imgAuthorityIcon = goIcon:GetComponent(typeof(UnityEngine.UI.Image))

		local goNormal = goutil.findChild(self._goAuthorityNode, "normalPoint")
		local goUnlock = goutil.findChild(self._goAuthorityNode, "bigPoint/unLock")

		self._goYinengIcon = goutil.findChild(self._goAuthorityNode, "bigPoint/unLock/iconYineng")

		goutil.setActive(goNormal, false)
		goutil.setActive(goUnlock, true)
	end
end

function M:_refreshChange()
	goutil.setActive(self._goChangeItem, self._isChangeNode)
	goutil.setActive(self._goChangeWidget, self._isChangeNode)
	goutil.setActive(self._goChangeMovie, self._isChangeNode)
	goutil.setActive(self._goYinengIcon, self._isChangeNode)

	if self._isChangeNode then
		local attrs = MultiFunctionUtil.getHeroAttrs(self._heroData)
		local nameStrs = string.split(self._nodeCo.name, " ")

		self._textNodeType.text = nameStrs[2] or ""

		local detailTextLst = self._nodeMo:getNodeDetailTextLst()

		IconLoader.setSprite(self._imgAuthorityIcon, IconType.DynSpriteAtlas_CharacterSystem_Authority, "qhd_icon_yineng")

		while self._transfUpContent.childCount < #detailTextLst do
			goutil.cloneAndSetParent(self._transfUpContent:GetChild(0).gameObject, self._transfUpContent)
		end

		for i = 0, self._transfUpContent.childCount - 1 do
			local go = self._transfUpContent:GetChild(i).gameObject
			local show = i < #detailTextLst

			if show then
				local txtName = goutil.findChildTextComponent(go, "Text1")
				local txtBefore = goutil.findChildTextComponent(go, "txtNum1")
				local txtAfter = goutil.findChildTextComponent(go, "txtNum2")
				local img1Go = goutil.findChild(go, "Image1")

				txtName.text = detailTextLst[i + 1].name

				local attrValue = detailTextLst[i + 1].val
				local isContain = string.find(attrValue, "Lv") or string.find(attrValue, "%%")

				goutil.setActive(img1Go, isContain == nil)
				goutil.setActive(txtBefore.gameObject, isContain == nil)

				if isContain then
					txtAfter.text = attrValue
				else
					for _, v in ipairs(attrs) do
						local co = AttributeDefineConfig.instance:getAttributePartDefineCO(v.code)
						local attrName = co and co.name or ""

						if attrName == detailTextLst[i + 1].name then
							attrValue = v.value
						end
					end

					txtBefore.text = attrValue - detailTextLst[i + 1].val
					txtAfter.text = attrValue
				end
			end

			goutil.setActive(go, show)
		end

		local videoPath = GameUrl.getVideoUrl(self._nodeCo.videoName)

		self._videoMgr:PlayForSeek(videoPath, 0, true, true)
		self._videoMgr:SetVolume(0, true)
	end
end

function M:_refreshSkill()
	if self._isSkillNode then
		local nameStrs = string.split(self._nodeCo.name, " ")

		self._textNodeType.text = nameStrs[2] or ""

		local skillId = self._nodeCo.skillId
		local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)
		local iconName = ActiveSkillCOUtil.getSkillIcon(skillCOWrapper:getSkillCO())

		IconLoader.setSprite(self._imgSkill, IconType.SkillIcon, iconName)
		IconLoader.setSprite(self._imgAuthorityIcon, IconType.SkillIcon, iconName)

		self._textSkillName.text = skillCOWrapper:getName()
		self._textSkillDesc.text = skillCOWrapper:getDescription()
	end

	goutil.setActive(self._goSkillWidget, self._isSkillNode)
	goutil.setActive(self._goSkillIcon, self._isSkillNode)
	goutil.setActive(self._imgAuthorityIcon.gameObject, self._isSkillNode)
end

function M:_refreshHero()
	self:_showPhoto(false)

	local modelId = self:_getModelId()

	self._modelCO = ModelConfig.instance:getModelConfig(modelId)
	self._modelPath = GameUrl.getMainSceneMeshModelUrl(self._modelCO.mainSceneResName)
	self._idleAnimPath = GameUrl.getMainSceneMeshModelClipUrl(self._modelCO.mainSceneResName, kDefaultAnim)
	self._resList = {
		self._modelPath,
		self._idleAnimPath
	}

	self._photoSpace:show(nil, nil, 1300, 1300)
	self._photoSpace:setModelLoadCallback(self._resLoaded, self._allResLoaded, self)
	self._photoSpace:addResList(self._resList)
	self._photoSpace:setCameraTag(SceneTag.RTCamera)
	self._photoSpace:setCameraFov(kFov)
	self._photoSpace:setCameraPosition(kCameraPos)
	self._photoSpace:setCameraPostProcessing(true, SceneLayer.Default_Value)
	self:_refreshPosition(true)
end

function M:_resLoaded(res)
	self._resMap = self._resMap or {}
	self._resMap[res.ResPath] = {
		res = res
	}
end

function M:_getResource(path)
	return self._resMap[path]
end

function M:_allResLoaded()
	local modelResData = self:_getResource(self._modelPath)
	local modelGo = goutil.clone(modelResData.res:GetMainAsset())

	modelResData.go = modelGo

	local height = CharacterCOUtil.getHeroHeight(self._modelCO.height)

	Astral.TransformUtil.SetLocalPos(modelGo.transform, kHeroPos.x, height, kHeroPos.z)
	Astral.TransformUtil.SetLocalRotation(modelGo.transform, kHeroRot.x, kHeroRot.y, kHeroRot.z)

	local animationPlayer = AnimationPlayer.Get(modelGo)
	local animRes = self:_getResource(self._idleAnimPath)

	if animRes then
		local animClip = animRes.res:GetMainAsset()

		animationPlayer:ReplaceClip(kDefaultAnim, animClip)
		animationPlayer:PlayAnimation(kDefaultAnim, true, true)
		animationPlayer:Evaluate()
	end

	local modelId = self:_getModelId()
	local xinMao = Astral.SimpleLuaComponentContainer.Add(modelGo.gameObject, UnitCompHeroXinMao)

	xinMao:setInfo(modelId, modelGo.gameObject)
	self._photoSpace:showTarget(modelGo, true)
	self:_showPhoto(true)
	self:_playVoice()
	removetimer(self._onDelayShowLight, self)
	settimer(1, self._onDelayShowLight, self, false)
end

function M:_refreshPosition(isOn)
	local producer = self._photoSpace:getProducer()

	if producer then
		if not isOn then
			local pos = PhotoUtil.GetPosition(producer.counter)

			GameUtils.setPos(producer.producerContainer, pos.x, pos.y, pos.z)
		else
			GameUtils.setPos(producer.producerContainer, 500, 500, 0)
		end
	end
end

function M:_getModelId()
	local heroMO = HeroDepotModel.instance:getHeroInfoByID(self._heroId)

	return heroMO:getModelId()
end

function M:_playVoice()
	local voiceRes = string.format("speech_%s_tupo", self._heroId)

	CriwareAudioFacade.instance:playVoiceByName(voiceRes)
end

function M:_showPhoto(active)
	self._canvasGroupHero.alpha = active and 1 or 0
end

return M
