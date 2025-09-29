-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/skin/CharacterSkinView.lua

module("logic.extensions.charactersystem.view.skin.CharacterSkinView", package.seeall)

local M = class("CharacterSkinView", ViewComponent)
local ScrollHeight1 = 174
local ScrollHeight2 = 216
local RotateFactor = 0.12
local CamMovFactorY = 0.0014
local MinCamY = 0.4
local MaxCamY = 1.6
local MinFov = 8
local MaxFov = 32
local FovFactor = -1
local coinId = CommEnum.CurrencyCodeEnum.HcjjCode

function M:ctor()
	self:_resetFields()

	self._singleDragPos = Vector3.New()
	self._beginDragPos = Vector3.New()
end

function M:_resetFields()
	self._heroId = nil
	self._skinId = nil
	self._heroCO = nil
	self._heroInfoCO = nil
	self._skinInfoUIData1 = nil
	self._skinInfoUIData2 = nil
	self._skinDataList = nil
	self._skinData = nil
	self._hasHero = nil
	self._skinLoopList = nil
	self._singleSkin = nil
	self._adjutantUnit = nil
	self._originFov = nil
	self._raycastProxy = nil
	self._compositeTouch = nil
	self._multiTouch = nil
	self._singleDragPos = nil
	self._beginDragPos = nil
	self._camVertDraggable = nil
	self._singleDraggable = nil
	self._dragYTotal = nil
end

function M:buildUI()
	self._guiAnimation = self.mainGO:GetComponent(typeof(Astral.GUITimelineAniLua))
	self._textTitle = self:getText("1&title_view_-788888785")
	self._btnReturn = self:getBtn("2&title_view_-878360263")
	self._btnHide = self:getBtn("6&com_btn_3_437414469")
	self._textHide = self:getText("6&com_btn_3_1380422008")
	self._btnSee = self:getBtn("8&com_btn_3_437414469")
	self._textSee = self:getText("8&com_btn_3_1380422008")
	self._btnSkinPreview = self:getBtn("7&com_btn_3_437414469")
	self._textPreview = self:getText("7&com_btn_3_1380422008")
	self._btnUse = self:getBtn("13&btn_middle_-31477526")
	self._goMaskNormal = self:getGo("character_fashion_view_1866730575")
	self._goMaskPreview = self:getGo("character_fashion_view_648567070")
	self._canvasInAirtightPreview = goutil.findChildComponent(self.mainGO, "preview_heartanchor_hint", ComponentType.CanvasGroup)
	self._canvasInAirtightPreview.alpha = 0

	goutil.setActive(self._canvasInAirtightPreview.gameObject, true)

	self._goAnchorPreview = self:getGo("10&preview_btn_group_1427983253")
	self._btnPreviewAnchor = self:getBtn("10&preview_btn_group_-154828406")
	self._btnClosePreviewAnchor = self:getBtn("10&preview_btn_group_-707336513")
	self._goUsing = self:getGo("14&btn_middle_-31477526")
	self._goSkinOwned = self:getGo("character_fashion_view_1715251933")
	self._goActivityAccess = self:getGo("character_fashion_view_-1985897844")
	self._goBuy = self:getGo("character_fashion_view_-1522961148")
	self._goUse = self:getGo("13&btn_middle_-31477526")
	self._goSkinPreview = self:getGo("7&com_btn_3_437414469")
	self._goTitleView = self:getGo("2&title_view_-478490097")
	self._goInfoPanel1 = self:getGo("character_fashion_view_1749862780")
	self._goInfoPanel2 = self:getGo("character_fashion_view_-96934967")
	self._goBaseInfo = self:getGo("6&role_combat_-1916846192")
	self._goBtnList = self:getGo("character_fashion_view_1061849785")
	self._textCharacterName = self:getText("6&role_combat_-2105291515")
	self._textPower = self:getText("6&role_combat_2049200865")
	self.go_com_price = self:getGo("15&com_price_1317146225")
	self._costCell = PrefabReferenceUtil.createCurrencyCostLuaCell(self.go_com_price)
	self._textActivityAccess = self:getText("character_fashion_view_-1985897844")
	self._goRoleCombat = self:getGo("2&role_combat_-1916846192")
	self._roleCombatCell = Astral.SimpleLuaComponentContainer.Add(self._goRoleCombat, RoleCombatCell)
	self._imgCareerSign = self:getImage("6&0&career_-612455418")
	self._imgCareerSign2 = self:getImage("2&0&career_-612455418")
	self._skinIconScroll = self:getGo("character_fashion_view_-355501757")
	self._goSee = self._btnSee.gameObject
	self._goHide = self._btnHide.gameObject
	self._skinInfoUIData1 = {}
	self._skinInfoUIData2 = {}

	self:_buildSkinInfoPanelUI(self._goInfoPanel1, self._skinInfoUIData1)
	self:_buildSkinInfoPanelUI(self._goInfoPanel2, self._skinInfoUIData2)
	ScrollRectDraggableCtrl.Add(self._skinInfoUIData1.scrollRect.gameObject)
	ScrollRectDraggableCtrl.Add(self._skinInfoUIData2.scrollRect.gameObject)

	self._skinLoopList = LoopGridViewHelper.New(self._skinIconScroll)

	self._skinLoopList:InitGridView(0, self._onSkinCellUpdate, self)

	self._goDrag = self:getGo("character_fashion_view_1749175856")

	goutil.setActive(self._goDrag, false)

	self._raycastProxy = RaycastProxy.Get(self._goDrag)

	self._raycastProxy:SetBeginDragListener(self._onBeginDrag, self)
	self._raycastProxy:SetDragListener(self._onDrag, self)
	self._raycastProxy:SetEndDragListener(self._onEndDrag, self)

	self._compositeTouch = UICompositeTouch.Get(self._goDrag)
	self._multiTouch = MultiTouchChecker.New()

	self._multiTouch:AddMultiDragListener(self._onMultiDragListener, self)
	self._compositeTouch:AddChecker(self._multiTouch)
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnHide:AddClickListener(self._onClickHideUI, self)
	self._btnSee:AddClickListener(self._onClickSeeUI, self)
	self._btnSkinPreview:AddClickListener(self._onClickSkinPreview, self)
	self._btnUse:AddClickListener(self._onClickUse, self)
	self._btnPreviewAnchor:AddClickListener(self._onClickPreviewAnchor, self)
	self._btnClosePreviewAnchor:AddClickListener(self._onClickClosePreviewAnchor, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnHide:RemoveClickListener()
	self._btnSee:RemoveClickListener()
	self._btnSkinPreview:RemoveClickListener()
	self._btnUse:RemoveClickListener()
	self._btnPreviewAnchor:RemoveClickListener()
	self._btnClosePreviewAnchor:RemoveClickListener()
end

function M:onEnter()
	local param = self:getFirstParam()

	self._heroId = param.heroId
	self._skinId = HeroSkinEnum.DefaultSkin

	if self._viewPresentor:getIsBackOpen() then
		self._skinId = HeroSkinModel.instance:getCurSkin()
	elseif param.skinId then
		self._skinId = param.skinId
	end

	self._jumpFromView = param.jumpFromView
	self._jumpSkinId = param.skinId
	self._showType = param.showType or HeroSkinEnum.ShowType.SingleSkin
	self._singleSkin = self._showType == HeroSkinEnum.ShowType.SingleSkin
	self._openByMainSystem = param.openByMainSystem or false

	goutil.setActive(self._goInfoPanel1, not self._singleSkin)
	goutil.setActive(self._goInfoPanel2, self._singleSkin)
	self:_setEvent(true)
	self._costCell:updateData(coinId)
	self:_refreshData()
	self:_updateView()

	if self._hasHero then
		HeroSkinAgent.instance:sendHeroSkinInfoRequest(self._heroId)
	end

	if not self._openByMainSystem or self._viewPresentor:getIsBackOpen() then
		MainScenePerformUtil.setBgHeroShow(false, true)
		MainScenePerformUtil.setElementShow(MainPerformEnum.ElementIdAirtightClock, false)
		MainScenePerformUtil.setElementShow(MainPerformEnum.ElementIdTelevision, false)

		if MainScenePerformUtil.getMainSceneCamGo(SceneType.Room) then
			local camCode = MainScenePerformUtil.getCamCode(self._viewPresentor:getViewName(), MainPerformEnum.SkinTabIndex.SkinMainView, self._heroId)

			MainScenePerformUtil.tweenMainSceneCam(camCode, 0, DG.Tweening.Ease.OutQuint)
		end
	else
		local modelId = CharacterUtil.getModelId(self._heroId, self._skinId)

		MainScenePerformUtil.viewCamCtrl(self._viewPresentor:getViewName(), MainPerformEnum.SkinTabIndex.SkinMainView, true, true, self._heroId, modelId)
	end

	HeroSkinModel.instance:setCurSkin(self._skinId)

	if self:_isModelPreview() then
		self._textTitle.text = lang("tip_hero_skin_check_btn")

		self:_enterViewSkinMode()
		goutil.setActive(self._goTitleView, true)
	else
		self._textTitle.text = lang("tip_hero_skin")

		self._guiAnimation:PlayAniByName("open1")

		if not self._openByMainSystem then
			self:_refreshHeroModel()
		end
	end

	self:_refreshGoMask()
	removetimer(self._onDelayEnableMagicaCloth, self)
	settimer(0.3, self._onDelayEnableMagicaCloth, self, false)
	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_SET_HQ_SHADOW)
	self:_refreshAirtightBtnStatus()
end

function M:onExit(reasonTyp)
	removetimer(self._onDelayEnableMagicaCloth, self)
	self:_setEvent(false)

	local isNormalClose = reasonTyp ~= WindowType.WindowCloseReasonType.QuickCloseType

	if isNormalClose then
		AirtightRoomController.instance:setPreviewState(nil)
	end

	MainScenePerformUtil.setHeroMagicalClothEnable(MainPerformEnum.ElementPointAdjutant, false)
	self._skinLoopList:ClearCells()

	if not self._openByMainSystem then
		MainScenePerformUtil.removeUnitByPoint(MainPerformEnum.ElementPointAdjutant)
		MainScenePerformUtil.tweenMainSceneCam(0, 0, DG.Tweening.Ease.OutQuint)

		local heroId, skinId = MainScenePerformUtil.getDisplayAdjutantHeroId()
		local prefix = MainPerformEnum.AnimPrefix.XiangQing
		local mixDuration
		local isChange = false

		MainScenePerformUtil.changeHeroReq(MainPerformEnum.ElementPointAdjutant, heroId, skinId, true, prefix, mixDuration, isChange)
	end

	removetimer(self._discountTimer, self)
	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_SET_HQ_SHADOW)
end

function M:destroyUI()
	self._raycastProxy:RemoveBeginDragListener()
	self._raycastProxy:RemoveDragListener()
	self._raycastProxy:RemoveEndDragListener()
	self._compositeTouch:ClearCheckerList()
	self._skinLoopList:Dispose()
	self:_resetFields()
end

function M:_setEvent(isOn)
	if isOn then
		GlobalDispatcher:addEventListener(EventType.REFRESH_HERO_SKIN_EVENT, self._onSkinDataChange, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_CAM_INIT, self._handleMainSceneCamInit, self)
		GlobalDispatcher:addEventListener(EventType.REFRESH_ALL_UNLOCK_SKIN_EVENT, self._onSkinUnlockInfo, self)
		GlobalDispatcher:addEventListener(EventType.REFRESH_GOODSITEM_DATA, self._onGoodsRefresh, self)
		GlobalDispatcher:addEventListener(EventType.SCENE_FLOW_ENTER_FINISH, self._handleSceneFlowEnterFinish, self)
		GlobalDispatcher:addEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.REFRESH_HERO_SKIN_EVENT, self._onSkinDataChange, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_CAM_INIT, self._handleMainSceneCamInit, self)
		GlobalDispatcher:removeEventListener(EventType.REFRESH_ALL_UNLOCK_SKIN_EVENT, self._onSkinUnlockInfo, self)
		GlobalDispatcher:removeEventListener(EventType.REFRESH_GOODSITEM_DATA, self._onGoodsRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.SCENE_FLOW_ENTER_FINISH, self._handleSceneFlowEnterFinish, self)
		GlobalDispatcher:removeEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
	end
end

function M:_handleAritightStateChange(e, isInAirtightTime, airtightEndTS)
	self:_refreshAirtightBtnStatus()
end

function M:_buildSkinInfoPanelUI(goPanel, skinInfoUIData)
	skinInfoUIData.scrollRect = goutil.findChild(goPanel, "scroll"):GetComponent(UIComponentType.ScrollRect)
	skinInfoUIData.textSkinName = goutil.findChildTextComponent(goPanel, "titleHint/Image1/txtName")
	skinInfoUIData.textSkinContent = goutil.findChildTextComponent(goPanel, "scroll/viewPort/content/detailContent/txtContent")

	local goDetail = goutil.findChild(goPanel, "scroll/viewPort/content/detailList")

	skinInfoUIData.goDetail = goDetail
	skinInfoUIData.goAppearance = goutil.findChild(goDetail, "appearance")
	skinInfoUIData.textAppearance = goutil.findChildTextComponent(goDetail, "appearance/txtContent")
	skinInfoUIData.goEffect = goutil.findChild(goDetail, "effect")
	skinInfoUIData.textEffect = goutil.findChildTextComponent(goDetail, "effect/txtContent")
	skinInfoUIData.goDubbing = goutil.findChild(goDetail, "dubbing")
	skinInfoUIData.textDubbing = goutil.findChildTextComponent(goDetail, "dubbing/txtContent")
	skinInfoUIData.goAction = goutil.findChild(goDetail, "action")
	skinInfoUIData.textAction = goutil.findChildTextComponent(goDetail, "action/txtContent")
	skinInfoUIData.line = goutil.findChild(goDetail, "imgLine")
end

function M:_onSkinDataChange()
	self:_refreshData()
	self:_updateView()
end

function M:_onGoodsRefresh()
	HeroSkinAgent.instance:sendGetAllHeroSkinInfoRequest()
end

function M:_onSkinUnlockInfo()
	self:_refreshData()
	self:_updateView()
end

function M:_onClickReturn()
	if self._jumpFromView == ViewName.StoreMainViewViewPresentor then
		StoreMainFacade.instance:jumpToSkinStore(self._jumpSkinId)
		self:close()
	elseif self:_isModelPreview() then
		self:_exitViewSkinMode()
		ViewMgr.instance:close(self._viewPresentor:getViewName(), true, WindowType.WindowCloseReasonType.QuickCloseType)
	else
		self:back()
	end
end

function M:_onClickHideUI()
	self:_enterViewSkinMode()
	self:_refreshGoMask()
end

function M:_onClickSeeUI()
	self:_exitViewSkinMode()
	self:_refreshGoMask()
end

function M:_isModelPreview()
	return self._showType == HeroSkinEnum.ShowType.ModelPreview
end

function M:_showUI(isShow)
	local modelPreview = self:_isModelPreview()

	goutil.setActive(self._goHide, isShow and not modelPreview)
	goutil.setActive(self._goSee, not isShow and not modelPreview)
	goutil.setActive(self._goAnchorPreview, modelPreview or isShow)
	goutil.setActive(self._goDrag, not isShow)
	goutil.setActive(self._goTitleView, isShow)
	goutil.setActive(self._goInfoPanel1, isShow and not self._singleSkin)
	goutil.setActive(self._goInfoPanel2, isShow and self._singleSkin)
	goutil.setActive(self._goBaseInfo, isShow)
	self:_showBattlePreviewBtn(isShow)
end

function M:_enterViewSkinMode()
	self:_showUI(false)
	MainScenePerformUtil.heroAnimSeqPlay(self._heroId, MainPerformEnum.AnimPrefix.ChouKa, 0)

	self._adjutantUnit = MainScenePerformUtil.getUnitHeroByPoint(MainPerformEnum.ElementPointAdjutant)

	if self._adjutantUnit then
		local skinTransform = HeroSkinConfig.instance:getSkinPreviewTransform(self._heroId)

		self._adjutantUnit.meshModel:setTransform(skinTransform.pos, skinTransform.rot)
	end

	local modelId = CharacterUtil.getModelId(self._heroId, self._skinId)
	local elementId = MainPerformConfig.instance:getHeroElementId(self._heroId, MainPerformEnum.ElementPointAdjutant, self._skinId)

	MainScenePerformUtil.setElementShow(elementId, false)
	MainScenePerformUtil.setElementShow(MainPerformEnum.ElementIdAirtightClock, false)
	MainScenePerformUtil.setElementShow(MainPerformEnum.ElementIdTelevision, false)
	MainScenePerformUtil.viewCamCtrl(self._viewPresentor:getViewName(), MainPerformEnum.SkinTabIndex.SkinPreview, true, true, self._heroId, modelId)
	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_HERO_CHANGE_EFF, self._heroId)
	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_LIGHT_ENABLE_ROTATE, true)
end

function M:_exitViewSkinMode()
	self:_showUI(true)

	local animName = MainPerformEnum.AnimFullName.XiangQingIdle

	MainScenePerformUtil.heroAnimPlay(self._heroId, animName, true, true, 0)
	self:_refreshHeroModel()

	self._adjutantUnit = MainScenePerformUtil.getUnitHeroByPoint(MainPerformEnum.ElementPointAdjutant)

	if self._adjutantUnit then
		self._adjutantUnit.meshModel:resetTransform()
	end

	MainScenePerformUtil.viewCamCtrl(self._viewPresentor:getViewName(), MainPerformEnum.SkinTabIndex.SkinMainView, true, true, self._heroId)
	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_LIGHT_ENABLE_ROTATE, false)
end

function M:_onClickSkinPreview()
	local info = {
		multiCount = 1,
		afflatusBuff = false,
		isShowPlot = false,
		dungeonCode = CharacterSkinUtil.getSkinDungeonId(self._heroId, self._skinId),
		gamePlay = BattleEnum.GamePlayType.NORMAL
	}

	DungeonController.instance:startDungeonBattle(info)
end

function M:_onClickBuy()
	StoreController.instance:buySkinGoods(self._skinId)
end

function M:_onClickUse()
	local voiceRes = string.format("speech_%s_huanzhuan", self._heroId)

	CriwareAudioFacade.instance:playVoiceByName(voiceRes)
	HeroSkinAgent.instance:sendHeroSkinSetRequest(self._heroId, self._skinId)
end

function M:_onToggleAirtight(toggle, isOn)
	local state = isOn and true or false

	AirtightRoomController.instance:setPreviewState(state)
end

function M:_switchAnchor(isOn)
	local state

	if isOn then
		state = true
	end

	AirtightRoomController.instance:setPreviewState(state)
	self:_refreshAirtightBtnStatus(0.3)
end

function M:_refreshAirtightBtnStatus(duration)
	duration = duration or 0

	local isOpen = AirtightRoomUtil.isSystemOpen(false)
	local previewState = AirtightRoomModel.instance:getPreviewState()
	local inTime = AirtightRoomController.instance:getIsInAirtightTime(nil, nil, nil, false)

	goutil.setActive(self._btnPreviewAnchor.gameObject, not inTime)
	goutil.setActive(self._btnClosePreviewAnchor.gameObject, inTime and previewState == true)
	MainScenePerformUtil.showCanvas(self._canvasInAirtightPreview, inTime and previewState == true, duration)
end

function M:_onClickPreviewAnchor()
	self:_switchAnchor(true)
end

function M:_onClickClosePreviewAnchor()
	self:_switchAnchor(false)
end

function M:_updateView()
	self:_updateBaseInfo()
	self:_updateSkinList()
	self:_updateInfoPanel()
end

function M:_refreshData()
	self._hasHero = HeroDepotModel.instance:hasHero(self._heroId)
	self._heroCO = CharacterConfig.instance:getCharacterItemInfo(self._heroId)
	self._heroInfoCO = PastInfoConfig.instance:getCharacterInfo(self._heroId)
	self._skinData = HeroSkinModel.instance:getSkinMo(self._heroId, self._skinId)
end

function M:_updateInfoPanel()
	self:_updateSkinInfo(self._skinInfoUIData1)
	self:_updateSkinInfo(self._skinInfoUIData2)
end

function M:_updateSkinInfo(skinInfoUIData)
	skinInfoUIData.textSkinName.text = self._skinData:getName()

	if self._skinData:getIsDefault() then
		skinInfoUIData.textSkinContent.text = langF(self._skinData:getDesc(), self._heroInfoCO.name)
	else
		skinInfoUIData.textSkinContent.text = self._skinData:getDesc()
	end

	self:_setSkinLabel(skinInfoUIData.goAppearance, skinInfoUIData.textAppearance, HeroSkinEnum.SkinLabelType.Appearance)
	self:_setSkinLabel(skinInfoUIData.goEffect, skinInfoUIData.textEffect, HeroSkinEnum.SkinLabelType.Effect)
	self:_setSkinLabel(skinInfoUIData.goDubbing, skinInfoUIData.textDubbing, HeroSkinEnum.SkinLabelType.Dubbing)
	self:_setSkinLabel(skinInfoUIData.goAction, skinInfoUIData.textAction, HeroSkinEnum.SkinLabelType.Action)
	goutil.setActive(skinInfoUIData.line, skinInfoUIData.goAppearance.activeSelf or skinInfoUIData.goEffect.activeSelf or skinInfoUIData.goDubbing.activeSelf or skinInfoUIData.goAction.activeSelf)
end

function M:_setSkinLabel(goLabel, textLabel, skinLabelType)
	local skinLabelCO = self._skinData:getLabelCO(skinLabelType)

	goutil.setActive(goLabel, skinLabelCO ~= nil)

	if skinLabelCO then
		textLabel.text = skinLabelCO.desc
	end
end

function M:_updateSkinList()
	if self._singleSkin then
		return
	end

	if self._jumpFromView == ViewName.StoreMainViewViewPresentor then
		self._skinDataList = HeroSkinModel.instance:getSaleSkinListByHero(self._heroId)
	else
		self._skinDataList = HeroSkinModel.instance:getSkinListByHeroId(self._heroId)
	end

	table.sort(self._skinDataList, HeroSkinModel.instance.skinSortFunc)
	self._skinLoopList:SetListItemCount(#self._skinDataList, true)
	self._skinLoopList:RefreshAllShownItem()
end

function M:_onSkinCellUpdate(cellIndex)
	cellIndex = cellIndex + 1

	local skinData = self._skinDataList[cellIndex]
	local item = self._skinLoopList:NewListViewItem("backpack_item")
	local shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, CharacterSkinIconItem)

	shower:setHandler(self)
	shower:updateData(skinData)
	shower:setSelect(self._skinId == skinData:getId())

	return item
end

function M:_showBattlePreviewBtn(isShow)
	local dungeonCode = CharacterSkinUtil.getSkinDungeonId(self._heroId, self._skinId)
	local hasDungeon = DungeonConfig.instance:getDungeonCfgById(dungeonCode) ~= nil

	goutil.setActive(self._goSkinPreview, isShow and hasDungeon and not self._singleSkin and not self:_isModelPreview())
end

function M:_updateBaseInfo()
	removetimer(self._discountTimer, self)

	self._textCharacterName.text = self._heroInfoCO.name

	local isUnlock = self._skinData:getIsUnlock()
	local isWearing = self._skinData:getIsWear()
	local skinGoodsCo = StoreConfig.instance:getSkinGoodsCo(self._skinId)
	local isSale = self:_isSale(skinGoodsCo) and self._skinData:getIsShowBag()

	goutil.setActive(self._goBuy, not isUnlock and isSale)
	goutil.setActive(self._goActivityAccess, not isUnlock and not isSale)
	goutil.setActive(self._goSkinOwned, isUnlock and not self._hasHero)
	goutil.setActive(self._goUsing, isWearing)
	goutil.setActive(self._goUse, isUnlock and not isWearing and self._hasHero)
	self:_showBattlePreviewBtn(true)

	if isSale then
		local costItems = self:_getCostItem(skinGoodsCo.cost)
		local discountCostItems = self:_getCostItem(skinGoodsCo.discountCost)
		local hasDiscount = discountCostItems and StoreUtil.isGoodsInDiscountTime(skinGoodsCo) or false
		local costStr = hasDiscount and discountCostItems[1].num or costItems and costItems[1].num or ""

		self._costCell:setCostCount(costStr)

		if hasDiscount then
			local remainTime = StoreUtil.getRemainedTime(skinGoodsCo.discountStartTime, skinGoodsCo.discountEndTime)

			settimer(remainTime, self._discountTimer, self, false)
		end
	end

	local scrollHeight = not isUnlock and isSale and ScrollHeight1 or ScrollHeight2

	RectTransformUtils.SetSize(self._skinInfoUIData1.scrollRect.transform, 400, scrollHeight)

	self._textActivityAccess.text = self._skinData:getWayDesc()

	if self._hasHero then
		local heroData = HeroDepotModel.instance:getHeroInfoByID(self._heroId)

		self._textPower.text = heroData:getAttribute(BattleExtension_pb.Attribute.FIGHTING_CAPACITY)
	end

	IconLoader.setSprite(self._imgCareerSign, IconType.Skinlib, CommEnum.Career2IconNoDi[self._heroCO.career])
	IconLoader.setSprite(self._imgCareerSign2, IconType.Skinlib, CommEnum.Career2IconNoDi[self._heroCO.career])
	self._roleCombatCell:updateSign(self._heroId)
	self._roleCombatCell:setOwned(self._hasHero)

	self._textSee.text = lang("tip_hero_skin_see_btn")
	self._textHide.text = lang("tip_hero_skin_check_btn")
	self._textPreview.text = lang("tip_hero_skin_battle_btn")
end

function M:_discountTimer()
	self:_updateBaseInfo()
end

function M:_isSale(skinGoodsCo)
	return skinGoodsCo and skinGoodsCo.isOnline
end

function M:_getCostItem(costStr)
	if not string.nilorempty(costStr) then
		return StoreUtil.formatText(costStr)
	end

	return nil
end

function M:onClickSkinItem(heroSkinData)
	if self._skinId == heroSkinData:getId() then
		return
	end

	self._skinData = heroSkinData
	self._skinId = self._skinData:getId()

	self:_updateBaseInfo()
	self:_updateInfoPanel()
	self._skinLoopList:RefreshAllShownItem()
	self:_refreshHeroModel()

	self._skinInfoUIData1.scrollRect.verticalNormalizedPosition = 1

	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_character, nil, nil, nil)
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_enter, nil, nil, nil)
	HeroSkinModel.instance:setCurSkin(self._skinId)
end

function M:_refreshHeroModel()
	MainScenePerformUtil.removeUnitByPoint(MainPerformEnum.ElementPointAdjutant)

	local prefix = MainPerformEnum.AnimPrefix.XiangQing

	MainScenePerformUtil.changeHeroReq(MainPerformEnum.ElementPointAdjutant, self._heroId, self._skinId, true, prefix, nil, false)

	local elementId = MainPerformConfig.instance:getHeroElementId(self._heroId, MainPerformEnum.ElementPointAdjutant, self._skinId)

	MainScenePerformUtil.showElementHideOtherSamePointElement(elementId, MainPerformEnum.ElementPointAdjutant)
end

function M:_refreshGoMask()
	local modelPreview = self:_isModelPreview()

	goutil.setActive(self._goMaskNormal, not modelPreview)
	goutil.setActive(self._goMaskPreview, modelPreview)
end

function M:_onBeginDrag(x, y, pointerId)
	self._singleDraggable = true
	self._dragYTotal = 0

	self._singleDragPos:Set(x, y)
	self._beginDragPos:Set(x, y)
end

function M:_onDrag(x, y, pointerId)
	if self._singleDraggable then
		local degree = (self._singleDragPos.x - x) * RotateFactor

		self._adjutantUnit.meshModel:rotate(degree)

		if math.abs(self._beginDragPos.y - y) > self:_distance(15) then
			self._camVertDraggable = true
		end

		if self._camVertDraggable then
			self._dragYTotal = self._dragYTotal + math.abs(self._singleDragPos.y - y)

			local factor = Mathf.Clamp(self._dragYTotal / self:_distance(15), 0, 1) * CamMovFactorY
			local deltaY = (self._singleDragPos.y - y) * factor
			local camX, camY, camZ = MainScenePerformUtil.getCamPos()

			camY = Mathf.Clamp(camY + deltaY, MinCamY, MaxCamY)

			MainScenePerformUtil.setCamLocalPos(camX, camY, camZ)
		end

		self._singleDragPos:Set(x, y)
	end
end

function M:_onEndDrag(x, y, pointerId)
	self._camVertDraggable = false
end

function M:_onMultiDragListener(centerX, centerY, scale, distance, isFirstMultiDrag)
	self._singleDraggable = false

	local curFov = MainScenePerformUtil.getMainSceneCamFov()
	local fov = Mathf.Clamp((scale - 1) * FovFactor * curFov + curFov, MinFov, MaxFov)

	MainScenePerformUtil.setMainSceneCamFov(fov)
end

function M:_distance(percent)
	return ViewMgr.instance:getUIHeight() * percent * 0.01
end

function M:_handleMainSceneCamInit()
	local camCode = MainScenePerformUtil.getCamCode(self._viewPresentor:getViewName(), MainPerformEnum.SkinTabIndex.SkinMainView, self._heroId)

	MainScenePerformUtil.tweenMainSceneCam(camCode, 0, DG.Tweening.Ease.OutQuint)
end

function M:_handleSceneFlowEnterFinish()
	self:_refreshHeroModel()
end

function M:_onDelayEnableMagicaCloth()
	MainScenePerformUtil.setHeroMagicalClothEnable(MainPerformEnum.ElementPointAdjutant, true)
end

return M
