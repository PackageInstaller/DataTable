-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/widgets/RogueJudgeCardSmall.lua

module("logic.extensions.roguelike.view.widgets.RogueJudgeCardSmall", package.seeall)

local M = class("RogueJudgeCardSmall")
local kChangeCardOffsetY = 150
local CardSlotItem = class("CardSlotItem")

function CardSlotItem:ctor(go)
	self._go = go
	self._goEmpty = goutil.findChild(go, "add")
	self._goNormal = goutil.findChild(go, "icon")
	self._imgIcon = goutil.findChildImageComponent(go, "icon")
	self._imgIconNum = goutil.findChildImageComponent(go, "icon/imgNum")
end

function CardSlotItem:setActive(isActive)
	goutil.setActive(self._goEmpty, isActive)
	goutil.setActive(self._goNormal, isActive)
	goutil.setActive(self._go, isActive)
end

function CardSlotItem:updateData(data)
	goutil.setActive(self._goEmpty, data.isEmpty)
	goutil.setActive(self._goNormal, not data.isEmpty)
	goutil.setActive(self._go, true)

	if data.icon and data.icon ~= "" then
		IconLoader.setSprite(self._imgIcon, IconType.DynSpriteAtlas_Dice, data.icon)
		IconLoader.setSprite(self._imgIconNum, IconType.DynSpriteAtlas_Dice, string.format("dice_num_%s", data.level))
	end

	if data.color then
		local color = data.color == 1 and "#7CABBC" or "#C64949"

		TextUtils.SetColor(self._imgIcon, color)
		TextUtils.SetColor(self._imgIconNum, color)
	end
end

function M:ctor(container)
	local go = container.gameObject

	self._go = go
	self._rectTransform = go:GetComponent(UIComponentType.RectTransform)

	local path = "drag/pos/"

	self._txtName = goutil.findChildTextComponent(go, path .. "content/txtName")
	self._txtAttr = goutil.findChildTextComponent(go, path .. "content/txtAttribute")
	self._txtEffect = goutil.findChildComponent(go, path .. "content/txtEffect", UIComponentType.TextMeshProUGUI)
	self._imgIcon = goutil.findChildImageComponent(go, path .. "content/icon")
	self._txtInCd = goutil.findChildTextComponent(go, path .. "content/txtInCd")
	self._goSelect = goutil.findChild(go, path .. "content/select")
	self._goQuality = goutil.findChild(go, path .. "content/imgQuality")
	self._imgQuality = Astral.ImageDynIcon.Get(self._goQuality)
	self._imgDiceIcon = goutil.findChildImageComponent(go, path .. "content/diceIcon")
	self._goDiceIconBg = goutil.findChild(go, path .. "content/Image2")
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, path .. "content/click"))

	self._btnClick:AddClickListener(self.onClickCallback, self)

	self._originLocalPos = go.transform.localPosition
	self._goCamp = goutil.findChild(go, path .. "content/camp")
	self._imgCampIcon = goutil.findChildImageComponent(go, path .. "content/camp/campIcon")
	self._goLock = goutil.findChild(go, path .. "content/lock")
	self._goDrag = goutil.findChild(go, "drag")
	self._traDrag = self._goDrag:GetComponent(UIComponentType.RectTransform)
	self._canvasGroup = self._traDrag:GetComponent(ComponentType.CanvasGroup)
	self._btnDrag = UIPassableDragTrigger.Get(self._goDrag)

	self._btnDrag:AddBeginDragListener(self._onBeginDrag, self)
	self._btnDrag:AddDragListener(self._onDrag, self)
	self._btnDrag:AddEndDragListener(self._onEndDrag, self)

	local longClickTriggerTime = 0.5

	self._btnLong = OnceLongPressTrigger.Get(self._btnClick.gameObject)

	self._btnLong:SetTriggerTime(longClickTriggerTime)
	self._btnLong:AddLongPressListener(self._onLongPress, self)
	self._btnLong:AddLongPressExitListener(self._onLongPressExit, self)

	self._animation = go:GetComponent(ComponentType.Animation)
	self._goTeach = goutil.findChild(go, path .. "content/sliderTeach")
	self._traPos = goutil.findChild(go, path).transform
	self._goParticle = goutil.findChild(go, path .. "content/UIParticle")
	self._txtEntryEffect = goutil.findChildComponent(go, path .. "content/txtEntryEffect", UIComponentType.TextMeshProUGUI)
	self._txtThrowDice = goutil.findChildTextComponent(go, path .. "content/txtContent_1")
	self._traLeftAddition = goutil.findChild(go, path .. "content/leftList").transform
	self._traRightAddition = goutil.findChild(go, path .. "content/rightList").transform
	self._goRightAdditionItem = goutil.findChild(go, path .. "content/rightList/intensify_1")

	self:initCardSlots()
end

function M:playAnimation(aniName)
	if not goutil.isNil(self._animation) then
		self._animation:Play(aniName)
	end
end

function M:_onLongPress(isLongPressOn)
	if self._longPressCallback ~= nil then
		self._longPressCallback(isLongPressOn)
	end
end

function M:_onLongPressExit(isExit)
	if self._longPressExitCallback ~= nil then
		self._longPressExitCallback(isExit)
	end
end

function M:initCardSlots()
	self._cardSlots = {}

	for i = 1, 3 do
		local go = goutil.findChild(self._traLeftAddition.gameObject, "intensify_" .. i)

		table.insert(self._cardSlots, CardSlotItem.New(go))
	end

	self._rightSlots = {}

	for i = 1, 3 do
		local go = goutil.findChild(self._traRightAddition.gameObject, "intensify_" .. i)

		table.insert(self._rightSlots, CardSlotItem.New(go))
	end
end

function M:showTeach(isShow)
	goutil.setActive(self._goTeach, isShow)
end

function M:onClickCallback()
	if self._cantUse and not self._isDisplay then
		return
	end

	if self._selectCallback then
		self._selectCallback()
	end
end

function M:OnDestroy()
	self._btnClick:RemoveClickListener()
	self._btnDrag:RemoveBeginDragListener()
	self._btnDrag:RemoveDragListener()
	self._btnDrag:RemoveEndDragListener()
	self._btnDrag:SetPassToGameObject(nil)

	self._selectCallback = nil
	self._useCallback = nil
	self._longPressCallback = nil
	self._longPressExitCallback = nil
	self._dragCallback = nil
	self._beginDragCallback = nil
end

function M:_onBeginDrag(eventData)
	if not self._isSelect and not self._cantUse then
		self:onClickCallback()

		return true
	end

	if self._cantUse or not self._isSelect then
		return true
	end

	if self._beginDragCallback ~= nil then
		self._beginDragCallback(eventData)
	end

	self:showTeach(false)

	self._originPos = self._traDrag.position
	self._orginDragEventPosition = eventData.position

	local x, y = RectTransformUtils.ScreenPointToLocalPointInRectangle(self._traDrag, eventData.position.x, eventData.position.y, eventData.pressEventCamera, 0, 0)

	self._originDragPos = Vector2.New(x, y)

	if self._selectCallback then
		self._selectCallback()
	end

	return true
end

function M:_onDrag(eventData)
	if self._cantUse or self._inRise or not self._isSelect or self._originDragPos == nil then
		return true
	end

	if self._dragCallback ~= nil then
		self._dragCallback(eventData)
	end

	RectTransformUtils.ScreenPointToWorldPointInRectangle(self._traDrag, eventData.pressEventCamera, eventData.position - self._originDragPos)

	return true
end

function M:_onEndDrag(eventData)
	if self._cantUse or self._inRise or not self._isSelect or self._originDragPos == nil then
		return true
	end

	local offsetY = eventData.position.y - self._orginDragEventPosition.y

	if offsetY > kChangeCardOffsetY and self._useCallback then
		ViewBlockMgr.instance:blockClick(true, ViewName.RogueMap)
		self._traDrag:DOMove(self._center.transform.position, 0.8):SetEase(DG.Tweening.Ease.OutQuart)
		settimer(0.2, function()
			if not goutil.isNil(self._animation) then
				self._animation:Play("readjust_item_disappear")
			end
		end, self, false)
		settimer(1, function()
			self:onMoveFinish()
		end, self, false)
		settimer(0.5, function()
			self._useCallback()
		end, self, false)
	else
		self._traDrag.localPosition = Vector3.zero
	end

	self._originDragPos = nil

	return true
end

function M:onMoveFinish()
	ViewBlockMgr.instance:blockClick(false, ViewName.RogueMap)

	self._traDrag.localPosition = Vector3.zero
end

function M:setRise(isRise, ignoreAni)
	local pos = isRise and Vector3.New(self._originLocalPos.x, self._originLocalPos.y + 50, self._originLocalPos.z) or self._originLocalPos

	self._go.transform.localPosition = pos

	if not ignoreAni and not goutil.isNil(self._animation) then
		self._animation:Play(isRise and "readjust_item_select" or "readjust_item_close")
	end

	self._inRise = true

	settimer(0.5, function()
		self._inRise = false
	end, self, false)

	if isRise then
		-- block empty
	end
end

function M:showByCardId(actionId, qua6List)
	local co = RoguelikeConfig.instance:getRoleActionById(actionId)
	local data = {}

	data.name = co.name

	local pattern = RoguelikeUtil.instance:convertCAttrType2SType(co.attr)
	local attrLevel = CharacterCOUtil.qua2Score(qua6List[co.attr])
	local attrText = string.format("<color=#%s>%s</color>", RoguelikeConst.ATTR_COLOR[qua6List[co.attr]], attrLevel)

	data.attr = RoguelikeConst.AttrType2Name[pattern]
	data.attrLevel = 0
	data.effect = RoguePredictionUtil.instance:predictionRoleActionRang(nil, nil, co, 0, nil)
	data.pattern = co.attr
	data.isDisplay = true
	data.slotCount = RoguelikeUtil.instance:getCardSlotCount(qua6List[co.attr])
	data.throwDiceText = string.format("投掷%sx%d", RoguelikeConst.GetAttrGraphic(pattern, 20), qua6List[co.attr])

	self:updateData(data)
end

function M:showByMonsterCard()
	return
end

function M:updateData(data)
	self._txtName.text = data.name
	self._txtAttr.text = data.attr

	if data.attrLevel > 0 then
		self._imgQuality:SetImage(GameUrl.getRoguelikeBigDynamic(data.co.bgIcon))
		IconLoader.setSprite(self._imgDiceIcon, IconType.DynSpriteAtlas_Dice, string.format("pt_img_000%s", data.attrLevel))
	else
		self._imgQuality:SetImage(GameUrl.getRoguelikeBigDynamic(data.co.bgIcon))
		IconLoader.setSprite(self._imgDiceIcon, IconType.DynSpriteAtlas_Dice, "pt_img_wenhao")
	end

	self._txtEffect.text = StringUtil.replaceAllGraphicTmpText(data.effect)
	self._selectCallback = data.selectCallback
	self._useCallback = data.useCallback
	self._longPressCallback = data.longPressCallback
	self._longPressExitCallback = data.longPressExitCallback
	self._dragCallback = data.dragCallback
	self._beginDragCallback = data.beginDragCallback
	self._isBan = data.isBan
	self._isInCd = data.isInCd
	self._center = data.center
	self._useTimeOut = data.useTimeOut
	self._isDisplay = data.isDisplay

	goutil.setActive(self._txtEntryEffect.gameObject, data.entryEffectText ~= nil and data.entryEffectText ~= "")

	for k, v in pairs(self._cardSlots) do
		v:setActive(false)
	end

	for k, v in pairs(self._rightSlots) do
		v:setActive(false)
	end

	local cardEntries = data.cardEntries or {}
	local rightEntries = {}
	local leftEntries = {}

	for i = 1, #cardEntries do
		local entryCo = RoguelikeConfig.instance:getCardEntryById(cardEntries[i])

		if entryCo and entryCo.type == 2 then
			table.insert(rightEntries, cardEntries[i])
		else
			table.insert(leftEntries, cardEntries[i])
		end
	end

	goutil.setActive(self._traRightAddition.gameObject, #rightEntries > 0)

	for i = 1, data.slotCount or 0 do
		local data = {}
		local entryCo = i <= #leftEntries and RoguelikeConfig.instance:getCardEntryById(leftEntries[i]) or nil

		data.isEmpty = i > #leftEntries or entryCo ~= nil and entryCo.type == 2

		if entryCo then
			data.icon = entryCo.icon
			data.level = entryCo.level
			data.color = entryCo.color
		end

		self._cardSlots[i]:updateData(data)
	end

	for i = 1, #rightEntries do
		local item = self._rightSlots[i]

		if item ~= nil then
			local data = {}

			data.isEmpty = false

			local entryCo = RoguelikeConfig.instance:getCardEntryById(rightEntries[#rightEntries - i + 1])

			if entryCo then
				data.icon = entryCo.icon
				data.level = entryCo.level
				data.color = entryCo.color
			end

			item:updateData(data)
		end
	end

	self._cantUse = self._isBan or self._isInCd or self._useTimeOut or data.isDisplay

	goutil.setActive(self._goLock, data.isInCd or data.isBan or data.useTimeOut)

	self._txtInCd.text = data.isInCd and data.cd or ""

	if data.useTimeOut then
		self._txtInCd.text = lang("使用次数耗尽")
	end

	goutil.setActive(self._txtInCd.gameObject, data.isInCd or data.useTimeOut)

	self._isSelect = true

	self:setSelect(false, true)
	self:showTeach(false)
	IconLoader.setSprite(self._imgIcon, IconType.DynSpriteAtlas_Dice, string.format("dice_%s", data.pattern))
	self:setActive(true)
end

function M:resetState()
	Astral.TransformUtil.SetAnchoredPos(self._traPos, 0, 0)
	Astral.TransformUtil.SetLocalScale(self._traPos, 1, 1, 1)

	self._go.transform.sizeDelta = Vector2.New(200, 260)

	goutil.setActive(self._goParticle, false)

	self._canvasGroup.alpha = 1
end

function M:setSelect(isSelect, ignoreAni)
	if self._isSelect == isSelect then
		return
	end

	goutil.setActive(self._goSelect, isSelect)
	self:setRise(isSelect, ignoreAni)

	self._isSelect = isSelect

	if not isSelect then
		self:showTeach(false)
	end
end

function M:setGoSelect(isSelect)
	return
end

function M:getIsSelect()
	return self._isSelect
end

function M:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function M:getTransform()
	return self._go.transform
end

return M
