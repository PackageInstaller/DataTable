-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/view/CharacterInformationView.lua

module("logic.extensions.characterinformation.view.CharacterInformationView", package.seeall)

local M = class("CharacterInformationView", ViewComponent)
local kViewUrls = {
	"ui/views/charactersystem/information/role_file_tips.prefab",
	"ui/views/charactersystem/information/role_voice_tips.prefab",
	"ui/views/charactersystem/information/role_expression_tips.prefab"
}
local kViewClass = {
	CharacterPastInfoView,
	CharacterVoiceView,
	CharacterExpressionView
}
local kSystemOpenEnumList = {
	[2] = GameEnum.SystemEnum.RoleVoice,
	[3] = GameEnum.SystemEnum.RoleExpression
}

function M:buildUI()
	self._imgBg = self:getImage("role_information_panel_-818493748")
	self._roleImgGo = self:getGo("role_infomation_panel_-378354664")
	self._roleImgTran = self:getUIComponent("role_infomation_panel_-378354664", UIComponentType.RectTransform)

	self:initPhotoUnit()

	self._tabComp = Astral.LuaComponentContainer.Add(self:getGo("right_tab_content_-399612422"), RightTabComp)

	local adapter = DynamicPagerAdapter.New()

	for index, _ in ipairs(kViewUrls) do
		adapter:registerView(kViewUrls[index], kViewClass[index])
		self._tabComp:setActiveTabIndex(index)
	end

	self._viewPager = ViewPager.New(self:getGo("role_infomation_panel_1879006813"))

	self._viewPager:setViewPresentor(self._viewPresentor)
	self._viewPager:setAdapter(adapter)
	self._viewPager:setPageChangeCallBack(self._onPageChange, self)
	self._tabComp:setSystemOpenLst(kSystemOpenEnumList)

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self._viewPager)
	self._toggleTabControl:setSystemOpen(kSystemOpenEnumList)
	self._toggleTabControl:addToggleTab(self._tabComp:getToggleTab(1))
	self._toggleTabControl:addToggleTab(self._tabComp:getToggleTab(2))
	self._toggleTabControl:addToggleTab(self._tabComp:getToggleTab(3))

	self._name1Txt = self:getText("role_infomation_panel_1369686116")
	self._name2Txt = self:getText("role_infomation_panel_1234785271")
	self._cvNameTxt = self:getText("role_infomation_panel_790779509")
	self._campIcon = self:getImage("role_infomation_panel_166126107")
	self._organizationNameTxt = self:getText("role_infomation_panel_-959963927")
	self._photoCenterPointGo = self:getGo("role_infomation_panel_1012392735")
	self._expressionPhotoCentrPointGo = self:getGo("role_infomation_panel_-1609194873")
	self._dragTrigger = Astral.UIDragTrigger.Get(self:getGo("role_infomation_panel_1505351904"))
	self._beginPosition = Vector2.New()
	self._rolePlotGo = self:getGo("dialogue_-1584339662")
	self._animationRolePlot = self:getUIComponent("dialogue_-1584339662", ComponentType.Animation)
	self._txtRolePlotContent = self:getText("dialogue_-471327988")

	self._rolePlotGo:SetActive(false)

	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._animEventListener = Astral.AnimationEventListener.Get(self._animationRolePlot.gameObject)
end

function M:initPhotoUnit()
	self._photoUnit = nil

	local rawImg = self._roleImgGo:GetComponent(UIComponentType.RawImage)

	rawImg.texture = CharacterSystemModel.instance:getRawImgRole().texture
	self._imgBg.sprite = CharacterSystemModel.instance:getBigImgBg().image.sprite
	self._useOtherPhotoUnit = true
end

function M:destroyUI()
	self._viewPager:clear()
	self._viewPager:destroy()
	self._toggleTabControl:destroy()

	self._animationRolePlot = nil
	self._viewPager = nil
	self._toggleTabControl = nil
	self._photoCenterPointGo = nil
end

function M:_onPageChange(index)
	return
end

function M:bindEvents()
	GlobalDispatcher:addEventListener(EventType.HERO_INFO_EXPRESSION_SPINE_CHANGE, self._refreshSpineByExpression, self)
	GlobalDispatcher:addEventListener(EventType.HERO_INFO_TAB_CHANGE, self._refreshRolePlot, self)
	GlobalDispatcher:addEventListener(EventType.HERO_INFO_SET_CAN_SWITCH_HERO, self._handleSetCanSwitchHero, self)
	GlobalDispatcher:addEventListener(EventType.FW_VIEW_CLOSE_EVENT, self._handleViewCloseEvent, self)
	self._dragTrigger:AddBeginDragListener(self._onBeginDrag, self)
	self._dragTrigger:AddEndDragListener(self._onEndDrag, self)
	self._animEventListener:AddListener(self._dealAnimEvent, self)
	AnimationUtils.AddEvent(self._animationRolePlot, "roleplot_close", "OnAnimationEvent", 11)
end

function M:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.HERO_INFO_EXPRESSION_SPINE_CHANGE, self._refreshSpineByExpression, self)
	GlobalDispatcher:removeEventListener(EventType.HERO_INFO_TAB_CHANGE, self._refreshRolePlot, self)
	GlobalDispatcher:removeEventListener(EventType.HERO_INFO_SET_CAN_SWITCH_HERO, self._handleSetCanSwitchHero, self)
	GlobalDispatcher:removeEventListener(EventType.FW_VIEW_CLOSE_EVENT, self._handleViewCloseEvent, self)
	self._dragTrigger:RemoveBeginDragListener()
	self._dragTrigger:RemoveEndDragListener()
	self._animEventListener:RemoveListener()
	AnimationUtils.RemoveEvent(self._animationRolePlot, "roleplot_close", "OnAnimationEvent", 11)
end

function M:_dealAnimEvent(animationEvent)
	local functionName = animationEvent.functionName
	local paramArr = string.split(animationEvent.stringParameter, "#")
	local clipName = paramArr[1]
	local frame = tonumber(paramArr[2])

	if clipName == "roleplot_close" and frame == 11 then
		self._rolePlotGo:SetActive(false)
	end
end

function M:_handleSetCanSwitchHero(e, canSwitch)
	self:_setCanSwitchHero(canSwitch)
end

function M:_handleViewCloseEvent(e, viewName, opTyp)
	if viewName == ViewName.CharacterMainSystemViewNew and self._photoUnit and self._photoUnit._photo and self._photoUnit._photo.producer and self._photoUnit._photo.producer.producerContainer then
		goutil.setActive(self._photoUnit._photo.producer.producerContainer, true)
	end
end

function M:_setCanSwitchHero(canSwitchHero)
	self._canSwitchHero = canSwitchHero
end

function M:_getCanSwitchHero()
	return self._canSwitchHero
end

function M:_getHeroByIndex(index, next)
	self._heroData = self._heroList[index]

	HeroDepotModel.instance:setViewPageMo({
		hero = self._heroData,
		index = index,
		list = self._heroList
	})
	self:_refreshView(true, next)
	self:_refreshRolePlot(nil, false)
	GlobalDispatcher:dispatchEvent(EventType.CHARACTER_VIEW_SWITCH)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
	self:playDynamicPageTimeLineAniOpen()
end

function M:playDynamicPageTimeLineAniOpen()
	local index = self._viewPager:getPage()
	local view = self._viewPager:getAdapter():getView(index)

	if view and view.playGuiOpenAni then
		view:playGuiOpenAni()
	end
end

function M:_onBeginDrag(evt)
	self._beginPosition:Set(0, 0)
	self._beginPosition:Add(evt.position)
end

function M:_onEndDrag(evt)
	if not self:_getCanSwitchHero() then
		return
	end

	local position = evt.position
	local deltaX = position.x - self._beginPosition.x

	if deltaX >= 10 then
		if self._index > 1 then
			self._index = self._index - 1

			self:_getHeroByIndex(self._index, false)
		end
	elseif deltaX <= -10 and self._index < self._maxHeroCount then
		self._index = self._index + 1

		self:_getHeroByIndex(self._index, true)
	end
end

function M:_refreshView(showEnter, next)
	self._heroInfoCO = PastInfoConfig.instance:getCharacterInfo(self._heroData:getId())

	local orgInfoCO = PastInfoConfig.instance:getOrgInfo(self._heroInfoCO.organization)

	self:_refreshSpine(showEnter, next)

	self._name1Txt.text = self._heroInfoCO.code
	self._name2Txt.text = self._heroInfoCO.name
	self._cvNameTxt.text = "CV." .. self._heroInfoCO.CV
	self._organizationNameTxt.text = orgInfoCO.name

	IconLoader.setSprite(self._campIcon, IconType.CharacterInfoCamp, orgInfoCO.OrganizationId)
end

function M:onEnter()
	self._viewPager:clear()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)

	local viewPageMo = HeroDepotModel.instance:getViewPageMo()

	self._heroData = viewPageMo and viewPageMo.hero or false
	self._index = viewPageMo and viewPageMo.index or false
	self._heroList = viewPageMo and viewPageMo.list or false
	self._maxHeroCount = self._heroList and #self._heroList or 0
	self._isExpression = false

	self:_setCanSwitchHero(true)

	local tab = 1

	self._toggleTabControl:selectTab(tab)
	self:_refreshView(false, false)
	VolumeMgr.instance:turnOn(VolumeName.RoleInfo)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
	VolumeMgr.instance:turnOn(VolumeName.Character, ViewName.CharacterInformation)
	self._tabComp:onEnter()
end

function M:onExit(closeReasonType)
	VolumeMgr.instance:turnOff(VolumeName.RoleInfo)
	self._guiAnimation:StopTimelineAni()

	if closeReasonType ~= WindowType.WindowCloseReasonType.QuickCloseType then
		self._guiAnimation:PlayAniByName("close")
		self:playDynamicPageTimeLineAni("close")
	else
		self:playDynamicPageTimeLineAni(nil)
	end

	VolumeMgr.instance:turnOff(VolumeName.Character, ViewName.CharacterInformation)
	self._tabComp:onExit()

	local faceCO = ExpressionConfig.instance:getConfigByModelIdAndExpressionId(self._heroData:getModelId(), self._heroData:getExpression())

	self._photoUnit:setFace(faceCO.expressionRes)
end

function M:playDynamicPageTimeLineAni(animName)
	local index = self._viewPager:getPage()
	local view = self._viewPager:getAdapter():getView(index)

	if view and view.playGuiAni then
		view:playGuiAni(animName)
	end
end

function M:_contractHideUI(name, active)
	return
end

function M:_refreshSpineByExpression(_, isExpression)
	self._isExpression = isExpression

	self:_refreshSpinePos()
end

function M:_refreshRolePlot(_, isInVoiceView, data)
	local faceStr = ExpressionConfig.instance:getDefaultFace(self._heroData:getModelId())

	faceStr = faceStr or "changtai"

	if isInVoiceView then
		self._rolePlotGo:SetActive(isInVoiceView)
		self._animationRolePlot:Stop()
		self._animationRolePlot:Play("roleplot_open")

		self._txtRolePlotContent.text = data.qipaoContent
		faceStr = ExpressionConfig.instance:getFaceResByName(self._heroData:getModelId(), data.expressionName)

		self._photoUnit:setFace(faceStr)
	else
		self._animationRolePlot:Stop()
		self._animationRolePlot:Play("roleplot_close")
	end
end

function M:_refreshSpine(showEnter, next)
	local transform

	if self._isExpression then
		transform = self._expressionPhotoCentrPointGo.transform
	else
		transform = self._photoCenterPointGo.transform
	end

	local cutCenterPos = {
		transform.anchoredPosition.x,
		transform.anchoredPosition.y,
		transform.localScale.x,
		transform.localScale.y
	}
	local paramTable = {
		isShowEgg = true,
		photo = self._photoUnit,
		modelId = self._heroData:getModelId(),
		cutCenterPos = cutCenterPos,
		iconType = IconType.CharacterSystem,
		heroId = self._heroData:getId()
	}

	paramTable.isShowEnter = showEnter
	paramTable.needIgnore = true
	paramTable.needTweenScale = true

	self._photoUnit:setLightCode(LightName.UICharacter)
	self._photoUnit:setShowEnterFromLeft(not next)
	SpineCutShowLoader.showSpineLihuiPhoto(paramTable)
	self._photoUnit:setCameraPostProcessing(true, SceneLayer.UI3D_Value)
end

function M:_refreshSpinePos()
	local transform

	if self._isExpression then
		transform = self._expressionPhotoCentrPointGo.transform
	else
		transform = self._photoCenterPointGo.transform
	end

	local cutCenterPos = {
		transform.anchoredPosition.x,
		transform.anchoredPosition.y,
		transform.localScale.x,
		transform.localScale.y
	}
	local paramTable = {
		isShowEgg = true,
		isShowEnter = false,
		photo = self._photoUnit,
		modelId = self._heroData:getModelId(),
		cutCenterPos = cutCenterPos,
		iconType = IconType.CharacterSystem,
		heroId = self._heroData:getId()
	}

	paramTable.needIgnore = true
	paramTable.needTweenScale = true

	local cutInfo = SpineCutShowLoader.getSpineLiHuiParam(paramTable)
	local localx, localy, scalex, scaley = cutInfo[1], cutInfo[2], cutInfo[3], cutInfo[4]
	local roleUnit = self._photoUnit:getUnit()

	roleUnit.go.transform:DOKill(false)

	local orgPosX = Astral.TransformUtil.GetLocalPosX(roleUnit.go.transform)
	local orgPosY = Astral.TransformUtil.GetLocalPosY(roleUnit.go.transform)
	local samePos = math.floor(orgPosX * 100) == math.floor(localx * 100)

	if samePos and math.floor(orgPosY * 100) == math.floor(localy * 100) then
		samePos = false
	end

	if samePos then
		return
	end

	roleUnit.go.transform:DOScale(scalex, 0.25):SetEase(DG.Tweening.Ease.Linear)
	roleUnit.go.transform:DOLocalMoveX(localx, 0.25):SetEase(DG.Tweening.Ease.Linear)
	roleUnit.go.transform:DOLocalMoveY(localy, 0.25):SetEase(DG.Tweening.Ease.Linear)
end

return M
