-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/claw_doll/ClawDollOperationView.lua

module("logic.extensions.welfare.view.claw_doll.ClawDollOperationView", package.seeall)

local M = class("ClawDollOperationView", ViewComponent)
local json = require("cjson")
local coinId = CommEnum.CurrencyCodeEnum.ClawDollCoin

function M:buildUI()
	self._btnReturn = self:getBtn("0&title_view_-878360263")
	self._btnHome = self:getBtn("0&title_view_1398742689")
	self._goTop = self:getGo("clip_doll_view_-859044475")
	self._goLightArc = self:getGo("clip_doll_view_-742175628")
	self._btnClaw = self:getBtn("clip_doll_view_-1206809884")
	self._goBottom = self:getGo("clip_doll_view_-673642211")
	self._btnDrag = Astral.UIDragTrigger.Get(self._goTop)

	self._btnDrag:AddBeginDragListener(self._onBeginDrag, self)
	self._btnDrag:AddDragListener(self._onDrag, self)
	self._btnDrag:AddEndDragListener(self._onEndDrag, self)

	self._goClawMask = self:getGo("clip_doll_view_1838840721")
	self._goDragMask = self:getGo("clip_doll_view_246176888")
	self._goPanel = self:getGo("clip_doll_view_-1923174456")

	goutil.setActive(self._goPanel.gameObject, false)

	self._goHeroImgFirst = self:getUIComponent("clip_doll_view_1990205922", UIComponentType.RawImage)
	self._goHeroImgSecond = self:getUIComponent("clip_doll_view_-1533068900", UIComponentType.RawImage)
	self._bollIcon_1 = self:getBigBg("clip_doll_view_1487258071")
	self._bollIcon_2 = self:getBigBg("clip_doll_view_380324385")
	self._clickRetrun = self:getBtn("4&com_btn_2_-31477526")
	self._clickRetrunCanvasGroup = self._clickRetrun.gameObject:GetComponent(ComponentType.CanvasGroup)
	self._clickRetrunCanvasGroup.alpha = 0.5
	self._btnAgain = self:getBtn("3&btn_right_1251431307")
	self._btnAgainCanvasGroup = self._btnAgain.gameObject:GetComponent(ComponentType.CanvasGroup)
	self._btnAgainCanvasGroup.alpha = 0.5
	self._mask = self:getGo("clip_doll_view_-1913451049")
	self._topCurrency = self:getGo("5&top_currency_1050779625")

	goutil.setActive(self._topCurrency.gameObject, false)

	self.go_com_price = self:getGo("6&com_price_1317146225")
	self._costCell = PrefabReferenceUtil.createCurrencyCostLuaCell(self.go_com_price)
	self._bollColorList = ClawDollConfig.instance:getBollList()

	local cb_rt = self:getGo("1&common_blur_rt_-2028819737")

	self._screenshotBlurImage = cb_rt:GetComponent(ComponentType.RawImage)
	self._screenshotImage = CaptureScreenshotImage.Get(self._screenshotBlurImage.gameObject)
	self._uiGlassBlur = SpaceX.UIGlassBlurUtil.Get(self._screenshotBlurImage.gameObject)
	self._uiGlassBlur.enabled = false

	local goClipRoot = self:getGo("clip_doll_view_-1733749594")

	self._timeline = goClipRoot.gameObject:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))

	if self._timeline then
		self._timeline.playOnAwake = false
		self._timeline.initialTime = 0

		self._timeline:Stop()
	end

	self._photoUnitFirst = PhotoModel.Get(self._goHeroImgFirst.gameObject)
	self._photoUnitSecond = PhotoModel.Get(self._goHeroImgSecond.gameObject)

	self._photoUnitFirst:clear()
	self._photoUnitSecond:clear()
end

function M:destroyUI()
	self._btnReturn = nil
	self._bollColorList = {}

	self._btnDrag:RemoveBeginDragListener()
	self._btnDrag:RemoveDragListener()
	self._btnDrag:RemoveEndDragListener()

	if self._photoUnitFirst then
		self._photoUnitFirst:clear()
	end

	self._photoUnitFirst = nil

	if self._photoUnitSecond then
		self._photoUnitSecond:clear()
	end

	self._photoUnitSecond = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	self._btnClaw:AddClickListener(self._onClickClaw, self)
	self._clickRetrun:AddClickListener(self._onClickReturnListener, self)
	self._btnAgain:AddClickListener(self._againClipDoll, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnHome:RemoveClickListener()
	self._btnClaw:RemoveClickListener()
	self._clickRetrun:RemoveClickListener()
	self._btnAgain:RemoveClickListener()
end

function M:onEnter()
	MainScenePerformUtil.setBgHeroShow(false, true, true)

	self._length = false

	self:_setEvent(true)
	self._costCell:updateData(coinId)
end

function M:onExit()
	self:_setEvent(false)

	if self._photoUnitFirst then
		self:_refreshPositionFirst(false)
		self._photoUnitFirst:clear()
	end

	if self._photoUnitSecond then
		self:_refreshPositionSecond(false)
		self._photoUnitSecond:clear()
	end

	self._screenshotImage:Clear()
	self._bollIcon_1:ClearImage()
	self._bollIcon_2:ClearImage()
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.CLAW_DOLL_BTNINTERACT_CLAW, self._refreshHeroShow, self)
		GlobalDispatcher:addEventListener(EventType.CLAW_DOLL_BTNINTERACT_DRAG, self._onClawInteractable, self)
		GlobalDispatcher:addEventListener(EventType.TOP_MONEY_ITEM_ADD_CLICK, self._handleToCoinItemAddClick, self)
		GlobalDispatcher:addEventListener(EventType.GAIN_ITEM_VIEW_CLOSE, self._refreshCoinText, self)
	else
		GlobalDispatcher:removeEventListener(EventType.CLAW_DOLL_BTNINTERACT_CLAW, self._refreshHeroShow, self)
		GlobalDispatcher:removeEventListener(EventType.CLAW_DOLL_BTNINTERACT_DRAG, self._onClawInteractable, self)
		GlobalDispatcher:removeEventListener(EventType.TOP_MONEY_ITEM_ADD_CLICK, self._handleToCoinItemAddClick, self)
		GlobalDispatcher:removeEventListener(EventType.GAIN_ITEM_VIEW_CLOSE, self._refreshCoinText, self)
	end
end

function M:onInitPosition()
	self._initTopPosition = Vector2.New(0, 0)
	self._initBottomPosition = Vector2.New(0, 0)
	self._poleDirection = Vector2.New(0, 0)
	self._initSliderDirection = Vector2.New(0, 0)
	self._moveDirection = Vector2.New(0, 0)
	self._tempstart = Vector2.New(0, 0)
	self._sliderLength = 0
	self._sliderSize = 0
end

function M:_onBeginDrag(eventData)
	self._initTopPosition = self._goTop.transform.localPosition
	self._tempstart = eventData.position
end

function M:_onDrag(eventData)
	self._poleDirection = eventData.position - self._tempstart
	self._sliderLength = self._poleDirection.magnitude
	self._sliderSize = Mathf.Clamp(self._sliderLength, 0, RectTransformUtils.GetHeight(self._goBottom.transform) * 0.3)
	self._initSliderDirection = self._poleDirection.normalized

	local tempV2 = self._initSliderDirection * self._sliderSize
	local tempV3 = Vector3.New(tempV2.x, tempV2.y, 0)

	self._moveDirection = self._initTopPosition + tempV3
	self._goTop.transform.localPosition = Vector3.New(self._moveDirection.x, self._moveDirection.y, self._moveDirection.z)

	GlobalDispatcher:dispatchEvent(EventType.ClAW_DOLL_CLAWMOVE, self._initSliderDirection)
end

function M:_onEndDrag(eventData)
	self._goTop.transform.localPosition = self._initTopPosition
	self._initSliderDirection = Vector2.zero

	GlobalDispatcher:dispatchEvent(EventType.ClAW_DOLL_CLAWMOVE, self._initSliderDirection)
end

function M:_onClickClaw()
	GlobalDispatcher:dispatchEvent(EventType.CLAW_DOLL_ROPECHANGE, true)
	self:_onClawInteractable(1, true)
end

function M:_onClickReturn()
	local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_clawdoll_return"))

	dialog:setConfirmListener(function()
		self:close()
		SceneFace.instance:backScene()
	end, self)
end

function M:_onClickHome()
	local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_clawdoll_return"))

	dialog:setConfirmListener(function()
		self:close()
		GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
	end, self)
end

function M:_onPlayTimeline()
	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Anim)
	goutil.setActive(self._mask.gameObject, true)
	self:_setScreenshot()
	self._timeline:Play()

	self._clickRetrunCanvasGroup.alpha = 0.5
	self._btnAgainCanvasGroup.alpha = 0.5

	local num = ClawDollController.instance:getCurCoinNumber(ClawDollActivityView.CONFIGID)
	local isEnterScene = num >= 1
	local color = isEnterScene and "FFFFFF" or "c93b3b"

	self._costCell:setCostCount(1, color)
	goutil.setActive(self._topCurrency.gameObject, true)
	settimer(1.2, self._canClick, self, false)
end

function M:_canClick()
	self._timeline:Stop()
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Anim)

	self._clickRetrunCanvasGroup.alpha = 1
	self._btnAgainCanvasGroup.alpha = 1

	goutil.setActive(self._mask.gameObject, false)
end

function M:_setScreenshot()
	self._screenshotImage:Build(0, 0)
	self._screenshotImage:CaptureFrame(self._onCaptureFinish, self)
end

function M:_handleToCoinItemAddClick()
	local tempList = ClawDollController.instance:getDollInMachineList(ClawDollActivityView.CONFIGID)

	if #tempList > 0 then
		local minMulti = 1
		local targetId = 1104
		local alwaysShowTips = true
		local forceShowWhenJumpOpen
		local titleStr = lang("tip_exchange_title_clawdoll")

		CurrencyExchangeController.instance:showTipsNormal(targetId, minMulti, alwaysShowTips, forceShowWhenJumpOpen, titleStr)
	else
		FloatWordMgr.instance:show(lang("claw_doll_boll_empty"))
	end
end

function M:_refreshCoinText()
	local num = ClawDollController.instance:getCurCoinNumber(ClawDollActivityView.CONFIGID)
	local isEnterScene = num >= 1
	local color = isEnterScene and "FFFFFF" or "c93b3b"

	self._costCell:setCostCount(1, color)
end

function M:_onCaptureFinish()
	local downSample = self._downSample or 4
	local iteration = self._iteration or 2

	self._renderTexture = SpaceX.CommandBufferEffectUtils.Blur(self._screenshotBlurImage.texture, CommonPreloader.instance:getMaterialsCommAsset(CommonResPath.BlurMat), downSample, iteration)

	self._screenshotImage:SetRenderTexture(self._renderTexture)
	self._uiGlassBlur:OnlyBlurScene()
	self._uiGlassBlur:UpdateBlurArag(downSample, iteration)
	self._uiGlassBlur:CaptureAndBlur()

	self._screenshotBlurImage.enabled = true
end

function M:_changeIcon(dollId)
	local type = self:_getBollType(dollId)
	local info = self._bollColorList[type]

	if info ~= nil then
		self._bollIcon_1:SetImage(GameUrl.getBigBgUrlWelfare(info.imageFirst))
		self._bollIcon_2:SetImage(GameUrl.getBigBgUrlWelfare(info.imageSecond))
	end
end

function M:_getBollType(dollID)
	local info = BackpackConfig.instance:getItemInfoByItemId(dollID)
	local infoJson = json.decode(info.exInfo)
	local dollType = infoJson.bollType

	if dollType == nil or dollType == "" then
		return 0
	end

	return dollType
end

function M:_onClickReturnListener()
	if self._renderTexture then
		UnityEngine.RenderTexture.ReleaseTemporary(self._renderTexture)
	end

	self._renderTexture = nil

	self:close()
	SceneFace.instance:backScene()
end

function M:_againClipDoll()
	local bool = self:_canEnterActivity()

	if not bool then
		FloatWordMgr.instance:show(lang("tip_activity_over"))

		return
	end

	local bollList = ClawDollController.instance:getDollInMachineList(ClawDollActivityView.CONFIGID)

	if bollList ~= nil and #bollList ~= 0 then
		local num = ClawDollController.instance:getCurCoinNumber(ClawDollActivityView.CONFIGID)
		local isEnterScene = num >= 1

		if not isEnterScene then
			FloatWordMgr.instance:show(lang("tip_claw_doll_nocoin"))
		else
			goutil.setActive(self._goPanel.gameObject, false)
			goutil.setActive(self._topCurrency.gameObject, false)
			self._screenshotImage:Clear()
			self._uiGlassBlur:ClearBlurBg()
			self._uiGlassBlur:ClearCapture()

			if self._renderTexture then
				UnityEngine.RenderTexture.ReleaseTemporary(self._renderTexture)
			end

			self._renderTexture = nil
		end
	else
		FloatWordMgr.instance:show(lang("claw_doll_boll_empty"))
	end
end

function M:_canEnterActivity()
	local cfgId = ClawDollActivityView.CONFIGID
	local actId = ClawDollController.instance:getActivityId(cfgId)
	local actMo = ActivityModel.instance:getActivityById(actId)
	local bool = actMo:getIsActivityOpen()

	return bool
end

function M:_onClawInteractable(e, msg)
	goutil.setActive(self._goClawMask, msg)
	goutil.setActive(self._goDragMask, msg)
	goutil.setActive(self._goBottom, not msg)
	goutil.setActive(self._btnClaw.gameObject, not msg)
end

function M:_refreshHeroShow(e, msg)
	local dollPath = ClawDollController.instance:getDollPath(msg.aConfigId, msg.doll)

	if dollPath then
		self._photoUnitFirst:setModelLoadCallback(function(e, inst, a)
			Astral.GameObjectUtil.SetLayerRecursively(inst, SceneLayer.Unit_Value)
		end, self)
		self._photoUnitFirst:updateRes(dollPath)
		self._photoUnitFirst:setCameraPostProcessing(true, SceneLayer.Unit_Value)
		self._photoUnitFirst:setCameraCullingLayer(SceneLayer.Unit_Value)
		self._photoUnitFirst:setCameraTag(SceneTag.RTCamera)
		self:_refreshPositionFirst(true)
		self._photoUnitFirst:setCameraPosition(0, 0.16, 3.5)
		self._photoUnitFirst:setRotation(0, 180, 0)
		self._photoUnitSecond:setModelLoadCallback(function(e, inst, a)
			Astral.GameObjectUtil.SetLayerRecursively(inst, SceneLayer.Unit_Value)
			self:_changeIcon(msg.doll)
			self:_onPlayTimeline()
		end, self)
		self._photoUnitSecond:updateRes(dollPath)
		self._photoUnitSecond:setCameraPostProcessing(true, SceneLayer.Unit_Value)
		self._photoUnitSecond:setCameraCullingLayer(SceneLayer.Unit_Value)
		self._photoUnitSecond:setCameraTag(SceneTag.RTCamera)
		self:_refreshPositionSecond(true)
		self._photoUnitSecond:setCameraPosition(0, 0.16, 3.5)
		self._photoUnitSecond:setRotation(0, 180, 0)
	end
end

function M:_refreshPositionFirst(turnOn)
	local producer = self._photoUnitFirst:getProducer()

	if self._photoUnitFirst and producer then
		if not turnOn then
			local pos = PhotoUtil.GetPosition(producer.counter)

			GameUtils.setPos(producer.producerContainer, pos.x, pos.y, pos.z)
		else
			GameUtils.setPos(producer.producerContainer, 500, 500, 0)
		end
	end
end

function M:_refreshPositionSecond(turnOn)
	local producer = self._photoUnitSecond:getProducer()

	if self._photoUnitSecond and producer then
		if not turnOn then
			local pos = PhotoUtil.GetPosition(producer.counter)

			GameUtils.setPos(producer.producerContainer, pos.x, pos.y, pos.z)
		else
			GameUtils.setPos(producer.producerContainer, 500, 500, 0)
		end
	end
end

return M
