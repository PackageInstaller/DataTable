-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echocardpack/view/EchoCardUnpackView.lua

module("logic.extensions.echocardpack.view.EchoCardUnpackView", package.seeall)

local M = class("EchoCardUnpackView", ViewComponent)
local unpackState = EchoCardPackController.UnpackState
local audioNames = {
	[GameEnum.QualityEnum.D] = CriwareAudioEnum.ui_canxiang_b,
	[GameEnum.QualityEnum.C] = CriwareAudioEnum.ui_canxiang_b,
	[GameEnum.QualityEnum.B] = CriwareAudioEnum.ui_canxiang_b,
	[GameEnum.QualityEnum.A] = CriwareAudioEnum.ui_canxiang_a,
	[GameEnum.QualityEnum.S] = CriwareAudioEnum.ui_canxiang_s
}

function M:buildUI()
	self._goRt = self:getGo("echocard_unpacking_view_-949610261")
	self._modelComp = Astral.LuaComponentContainer.Add(self._goRt, EchoCardUnpackModelComponent)
	self._rawImg = self._goRt:GetComponent(UIComponentType.RawImage)
	self._shakeComp = Astral.LuaComponentContainer.Add(self.mainGO, EchoCardUnpackShakeComponent)
	self._go_h = self:getGo("echocard_unpacking_view_-1946281728")
	self._group_h = self._go_h:GetComponent(ComponentType.CanvasGroup)
	self._btnSkip_h = self:getBtn("echocard_unpacking_view_-860655107")
	self._goLine_h = self:getGo("echocard_unpacking_view_18737405")
	self._goLineImage_h = self:getGo("echocard_unpacking_view_1217339607")
	self._goCutIn_h = self:getGo("echocard_unpacking_view_-1675737858")
	self._groupCutIn_h = self._goCutIn_h:GetComponent(ComponentType.CanvasGroup)
	self._goCutBtn_h = self:getGo("echocard_unpacking_view_619354088")
	self._goCutBtnEffect_h = self:getGo("echocard_unpacking_view_-1204717958")
	self._goFivePos_h = self:getGo("echocard_unpacking_view_560378377")
	self._goOnePos_h = self:getGo("echocard_unpacking_view_-1573933676")
	self._goShakeTip_h = self:getGo("echocard_unpacking_view_-952667775")
	self._dragTrigger_h = Astral.UIDragTrigger.Get(self._goCutBtn_h)
	self._go_v = self:getGo("echocard_unpacking_view_1952708799")
	self._group_v = self._go_v:GetComponent(ComponentType.CanvasGroup)
	self._btnSkip_v = self:getBtn("echocard_unpacking_view_963455849")
	self._goLine_v = self:getGo("echocard_unpacking_view_2118188279")
	self._goLineImage_v = self:getGo("echocard_unpacking_view_1119585396")
	self._goCutIn_v = self:getGo("echocard_unpacking_view_156896907")
	self._groupCutIn_v = self._goCutIn_v:GetComponent(ComponentType.CanvasGroup)
	self._goCutBtn_v = self:getGo("echocard_unpacking_view_1168070084")
	self._goCutBtnEffect_v = self:getGo("echocard_unpacking_view_737161890")
	self._goFivePos_v = self:getGo("echocard_unpacking_view_1617513925")
	self._goOnePos_v = self:getGo("echocard_unpacking_view_1030656252")
	self._dragTrigger_v = Astral.UIDragTrigger.Get(self._goCutBtn_v)
	self._imgCutIns = {}

	local imgCutIn_v = self._goCutIn_v:GetComponent(UIComponentType.Image)
	local imgCutIn_h = self._goCutIn_h:GetComponent(UIComponentType.Image)

	table.insert(self._imgCutIns, imgCutIn_v)
	table.insert(self._imgCutIns, imgCutIn_h)

	for i = 1, 3 do
		local imgCutInV = goutil.findChildComponent(self._goCutIn_v, "imgCutIn_" .. i, UIComponentType.Image)

		table.insert(self._imgCutIns, imgCutInV)

		local imgCutInH = goutil.findChildComponent(self._goCutIn_h, "imgCutIn_" .. i, UIComponentType.Image)

		table.insert(self._imgCutIns, imgCutInH)
	end

	self._groupCutIn_h.alpha = 1
	self._groupCutIn_v.alpha = 1
end

function M:destroyUI()
	self._rawImg.material = nil

	self._modelComp:destroyUI()

	if self._resource then
		self._resource:Release()
	end
end

function M:bindEvents()
	self._btnSkip_h:AddClickListener(self._onClickSkip, self)
	self._btnSkip_v:AddClickListener(self._onClickSkip, self)
	self._dragTrigger_h:AddBeginDragListener(self._onBeginDrag, self)
	self._dragTrigger_h:AddDragListener(self._onDrag, self)
	self._dragTrigger_h:AddEndDragListener(self._onEndDrag, self)
	self._dragTrigger_v:AddBeginDragListener(self._onBeginDrag, self)
	self._dragTrigger_v:AddDragListener(self._onDrag, self)
	self._dragTrigger_v:AddEndDragListener(self._onEndDrag, self)
end

function M:unbindEvents()
	self._btnSkip_h:RemoveClickListener()
	self._btnSkip_v:RemoveClickListener()
	self._dragTrigger_h:RemoveBeginDragListener()
	self._dragTrigger_h:RemoveDragListener()
	self._dragTrigger_h:RemoveEndDragListener()
	self._dragTrigger_v:RemoveBeginDragListener()
	self._dragTrigger_v:RemoveDragListener()
	self._dragTrigger_v:RemoveEndDragListener()
end

function M:_setEvents(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ECHO_UNPACK_STATE_CHANGE, self._handleUnpackStateChange, self)
		GlobalDispatcher:addEventListener(EventType.ECHO_UNPACK_SHOW_NEXT, self._handleUnpackShowNext, self)
		GlobalDispatcher:addEventListener(EventType.ECHO_UNPACK_SHOW_CUT_IN, self._handleUnpackShowCuteIn, self)
		GlobalDispatcher:addEventListener(EventType.ECHO_UNPACK_HV_STATE_CHANGE, self._handleUnpackHVChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ECHO_UNPACK_STATE_CHANGE, self._handleUnpackStateChange, self)
		GlobalDispatcher:removeEventListener(EventType.ECHO_UNPACK_SHOW_NEXT, self._handleUnpackShowNext, self)
		GlobalDispatcher:removeEventListener(EventType.ECHO_UNPACK_SHOW_CUT_IN, self._handleUnpackShowCuteIn, self)
		GlobalDispatcher:removeEventListener(EventType.ECHO_UNPACK_HV_STATE_CHANGE, self._handleUnpackHVChange, self)
	end
end

function M:onEnter()
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_canxiangkabao_into, nil, nil, nil)
	EchoCardPackController.instance:setModelInitState(false)
	EchoCardPackController.instance:setSkipState(false)
	EchoCardPackController.instance:setHorizontalState(true)

	self._hasCutPack = false

	self:_setEvents(true)
	self._modelComp:onEnter()
	self._shakeComp:onEnter()

	self._unpackNum = EchoCardPackController.instance:getUnpackNum()

	self:_initCutData()
	self:_updateCutIn()
	self:_setLineState(true)
	self:_handleUnpackStateChange()
end

function M:onEnterFinished()
	self._modelComp:onEnterFinished()
end

function M:onExit()
	self:_setEvents(false)
	self._modelComp:onExit()
	self._shakeComp:onExit()

	if self._tweenerHV then
		self._tweenerHV:Kill(false)
	end

	removetimer(self._onpCutInAnimationEnd, self)
	removetimer(self._moveCutBtnEffect, self)
	removetimer(self._moveToEnd, self)
	removetimer(self._moveToStart, self)
	removetimer(self._startShowCutIn, self)

	for i = 1, #self._imgCutIns do
		IconLoader.clearSprite(self._imgCutIns[i])
	end
end

function M:_initCutData()
	local isHorizontal = EchoCardPackController.instance:getHorizontalState()

	self._curShowDirection = isHorizontal

	if self._unpackNum == 5 then
		self._moveDistance = 650

		local targetGo = isHorizontal and self._goFivePos_h or self._goFivePos_v

		self._cutBtnX, self._cutBtnY = GameUtils.getLocalPos(targetGo)

		GameUtils.setUIWidth(self._goLineImage_h.transform, 700)
		GameUtils.setUIWidth(self._goLineImage_v.transform, 700)
	else
		self._moveDistance = 300

		local targetGo = isHorizontal and self._goOnePos_h or self._goOnePos_v

		self._cutBtnX, self._cutBtnY = GameUtils.getLocalPos(targetGo)

		GameUtils.setUIWidth(self._goLineImage_h.transform, 350)
		GameUtils.setUIWidth(self._goLineImage_v.transform, 350)
	end

	if isHorizontal then
		GameUtils.setLocalPos(self._goCutBtn_h, self._cutBtnX, self._cutBtnY, 0)
		GameUtils.setLocalPos(self._goCutBtnEffect_h, self._cutBtnX, self._cutBtnY, 0)
	else
		GameUtils.setLocalPos(self._goCutBtn_v, self._cutBtnX, self._cutBtnY, 0)
		GameUtils.setLocalPos(self._goCutBtnEffect_v, self._cutBtnX, self._cutBtnY, 0)
	end

	self._lineTransform = isHorizontal and self._goLine_h.transform or self._goLine_v.transform
end

function M:_switchHV()
	local isHorizontal = EchoCardPackController.instance:getHorizontalState()

	if self._tweenerHV then
		self._tweenerHV:Kill(false)
	end

	goutil.setActive(self._go_h, true)
	goutil.setActive(self._go_v, true)

	local curAlpha = isHorizontal and self._group_h.alpha or self._group_v.alpha

	self._tweenerHV = DoTweenUtil.ToWithEase(curAlpha, 1, 0.4, DG.Tweening.Ease.OutQuad, function(value)
		self._group_h.alpha = isHorizontal and value or 1 - value
		self._group_v.alpha = isHorizontal and 1 - value or value
	end)

	self._tweenerHV:OnComplete(function()
		goutil.setActive(self._go_h, isHorizontal)
		goutil.setActive(self._go_v, not isHorizontal)
	end)
	self._tweenerHV:SetTarget(self.mainGO)
end

function M:_setLineState(value)
	goutil.setActive(self._goLineImage_h, value)
	goutil.setActive(self._goCutBtnEffect_h, value)
	goutil.setActive(self._goLineImage_v, value)
	goutil.setActive(self._goCutBtnEffect_v, value)
end

function M:_onBeginDrag(eventData)
	self:_setLineState(false)
	removetimer(self._moveToEnd, self)
	removetimer(self._moveToStart, self)
	removetimer(self._moveCutBtnEffect, self)

	self._hasCutPack = true

	local maxQuality = EchoCardPackController.instance:getMaxQuality()

	CriwareAudioFacade.instance:playOnceSEbyId(audioNames[maxQuality], nil, nil, nil)

	self._lastTime = os.clock()
end

function M:_onDrag(eventData)
	local curPos = goutil.screenToLocalPos(eventData.position, self._lineTransform)

	self._moveValue = (curPos.x - self._cutBtnX) / self._moveDistance

	if self._moveValue > 0.5 then
		goutil.setActive(self._goLine_h, false)
		goutil.setActive(self._goLine_v, false)
		settimer(0.001, self._moveToEnd, self, true)
	else
		self._modelComp:setGuiAnimationsTime(self._moveValue)
	end

	self:_playAudio()
end

function M:_onEndDrag(eventData)
	local curPos = goutil.screenToLocalPos(eventData.position, self._lineTransform)

	self._moveValue = (curPos.x - self._cutBtnX) / self._moveDistance

	if self._moveValue > 0.5 then
		goutil.setActive(self._goLine_h, false)
		goutil.setActive(self._goLine_v, false)
		settimer(0.001, self._moveToEnd, self, true)
	else
		settimer(0.001, self._moveToStart, self, true)
	end
end

function M:_moveToEnd()
	self._moveValue = self._moveValue + Time.deltaTime * 1

	if self._moveValue >= 1 then
		removetimer(self._moveToEnd, self)

		self._moveValue = 1

		GlobalDispatcher:dispatchEvent(EventType.ECHO_UNPACK_SHOW_CUT_IN)
	end

	self._modelComp:setGuiAnimationsTime(self._moveValue)
end

function M:_moveToStart()
	self._moveValue = self._moveValue - Time.deltaTime * 10

	if self._moveValue <= 0 then
		removetimer(self._moveToStart, self)

		self._moveValue = 0
	end

	self._modelComp:setGuiAnimationsTime(self._moveValue)
end

function M:_playAudio()
	local now = os.clock()

	if self._lastTime and now - self._lastTime < 0.2 then
		return
	end

	self._lastTime = now

	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_canxiang_huadong, nil, nil, nil)
end

function M:_onClickSkip()
	if not EchoCardPackController.instance:getModelInitState() then
		return
	end

	goutil.setActive(self._btnSkip_h.gameObject, false)
	goutil.setActive(self._btnSkip_v.gameObject, false)
	EchoCardPackController.instance:setSkipState(true)
	GlobalDispatcher:dispatchEvent(EventType.ECHO_UNPACK_SHOW_CUT_IN)
end

function M:_handleUnpackStateChange()
	local state = EchoCardPackController.instance:getUnpackState()
	local isHorizontal = EchoCardPackController.instance:getHorizontalState()

	goutil.setActive(self._go_h, state ~= unpackState.UnpackEnd and isHorizontal)
	goutil.setActive(self._go_v, state ~= unpackState.UnpackEnd and not isHorizontal)
	goutil.setActive(self._goLine_h, state == unpackState.InOrder)
	goutil.setActive(self._goLine_v, state == unpackState.InOrder)
	goutil.setActive(self._goShakeTip_h, state == unpackState.UnInOrder)

	if state == unpackState.InOrder then
		self:_showCutBtnEffect()
	else
		removetimer(self._moveCutBtnEffect, self)
	end
end

function M:_showCutBtnEffect()
	removetimer(self._moveCutBtnEffect, self)

	if self._hasCutPack then
		return
	end

	settimer(0.001, self._moveCutBtnEffect, self, true)

	self._effectX = self._cutBtnX
end

function M:_moveCutBtnEffect()
	self._effectX = self._effectX + Time.deltaTime * 100

	if self._effectX >= self._cutBtnX + self._moveDistance then
		self._effectX = self._cutBtnX
	end

	local isHorizontal = EchoCardPackController.instance:getHorizontalState()

	if isHorizontal then
		GameUtils.setLocalPos(self._goCutBtnEffect_h, self._effectX, self._cutBtnY, 0)
	else
		GameUtils.setLocalPos(self._goCutBtnEffect_v, self._effectX, self._cutBtnY, 0)
	end
end

function M:_handleUnpackShowNext()
	return
end

function M:_handleUnpackHVChange()
	local isHorizontal = EchoCardPackController.instance:getHorizontalState()

	if self._curShowDirection == isHorizontal then
		return
	end

	self:_initCutData()
	self:_switchHV()
	self._modelComp:switchHV()
end

function M:_handleUnpackShowCuteIn()
	local num = EchoCardPackController.instance:getUnpackNum()
	local time = num == 5 and 0.3 or 0.1

	removetimer(self._startShowCutIn, self)
	settimer(time, self._startShowCutIn, self, false)
end

function M:_startShowCutIn()
	if not self._hasQualityS then
		EchoCardPackController.instance:setUnpackState(unpackState.UnpackEnd)
		GlobalDispatcher:dispatchEvent(EventType.ECHO_UNPACK_STATE_CHANGE)

		return
	end

	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_canxiang_cutin_s, nil, nil, nil)
	goutil.setActive(self._goCutIn_h, true)
	goutil.setActive(self._goCutIn_v, true)
	EchoCardPackController.instance:setShowCutInState(true)
	removetimer(self._onpCutInAnimationEnd, self)
	settimer(1.1, self._onpCutInAnimationEnd, self, false)
end

function M:_onpCutInAnimationEnd()
	EchoCardPackController.instance:setShowCutInState(false)
	EchoCardPackController.instance:setUnpackState(unpackState.UnpackEnd)
	GlobalDispatcher:dispatchEvent(EventType.ECHO_UNPACK_STATE_CHANGE)
end

function M:_updateCutIn()
	self._results = EchoCardPackController.instance:getCacheResult()
	self._hasQualityS = false

	local itemId

	for i = 1, #self._results do
		local data = self._results[i]

		if data.itemData:getQuality() == GameEnum.QualityEnum.S then
			self._hasQualityS = true

			if data.isNew then
				itemId = data.itemData:getItemId()

				break
			end

			itemId = itemId or data.itemData:getItemId()
		end
	end

	if self._hasQualityS then
		local url = string.format("%s_cutin", itemId)

		self._loadNum = 0

		for i = 1, #self._imgCutIns do
			IconLoader.setSprite(self._imgCutIns[i], IconType.EchoCardUnpack, url, self._updateCutInMatTexture, self)
		end
	end
end

function M:_updateCutInMatTexture()
	self._loadNum = self._loadNum + 1

	if self._loadNum < 4 then
		return
	end

	for i = 1, #self._imgCutIns do
		self._imgCutIns[i].material:SetTexture("_BaseMap", self._imgCutIns[i].mainTexture)
	end
end

function M:_initRawImgMat()
	getres("materials/comm/ui_default_model.mat", function(res)
		if res.IsSuccess then
			res:Retain()

			self._resource = res

			local mat = goutil.clone(res:GetMainAsset())

			self._rawImg.material = mat
		end
	end, nil)
end

function M:_checkCutInImage()
	if not Astral.OSDef.isEditor then
		return
	end

	local list = BackpackConfig.instance:getConfig(ConfigName.EchoItem)
	local ids = ""

	for k, config in pairs(list) do
		if config.quality == GameEnum.QualityEnum.S then
			local fullPath = UnityEngine.Application.dataPath .. "/GameAssets/shared/ui/dynicon/echo_cutin/" .. config.id .. "_cutin.png"

			if not io.exists(fullPath) then
				ids = ids .. "  " .. config.id
			end
		end
	end

	if ids ~= "" then
		printError(ids .. "   这些S级缺少Cutin图")
	end
end

return M
