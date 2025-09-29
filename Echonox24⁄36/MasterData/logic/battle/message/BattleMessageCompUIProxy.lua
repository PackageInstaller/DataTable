-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/message/BattleMessageCompUIProxy.lua

module("logic.battle.message.BattleMessageCompUIProxy", package.seeall)

local M = class("BattleMessageCompUIProxy", IEffectComp)

function M:onResourceLoaded()
	self.mainGO = self.unit.loader:getInst()

	self:buildUI()
	self:_initPosition()
	self:_showNotify()
end

function M:onReuse()
	return
end

function M:onReset()
	GlobalDispatcher:removeEventListener(EventType.ON_CAMERA_ROTATION_UPDATE, self._doUIRotation, self)
	self:clear()
end

function M:onDestroy()
	self:onReset()
end

function M:setFollowUnit()
	return
end

function M:setMessage(messageMO)
	self._messageMO = messageMO
end

function M:buildUI()
	self._hasBuild = true
	self._contentGo = goutil.findChild(self.mainGO, "txtContent")
	self._contentTxt = goutil.findChildComponent(self.mainGO, "txtContent", typeof(TMPro.TMP_Text))
	self._goVoice = goutil.findChild(self.mainGO, "txtContent/imgVoice")
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._imgEmoji = goutil.findChild(self.mainGO, "imgEmoji"):GetComponent("SpriteRenderer")
	self._bgRender = goutil.findChild(self.mainGO, "Image1"):GetComponent("SpriteRenderer")
	self._bgVector2 = Vector2.New(5.24, 0.52)
end

function M:setVisible(status, playAnim)
	goutil.setActive(self.mainGO, status)

	if status and playAnim then
		-- block empty
	end
end

function M:_showNotify()
	goutil.setActive(self._imgEmoji.gameObject, false)

	local messageMO = self._messageMO
	local content = messageMO:getPreviewMsg(false, nil, true)
	local emoji = messageMO:getEmoji()

	self._lineCount = TextUtils.GetTMPLineCount(content, self._contentTxt)
	self._contentTxt.text = content
	self._hasEmoji = emoji and emoji > 0

	goutil.setActive(self._imgEmoji.gameObject, self._hasEmoji)

	if self._hasEmoji then
		self._imgEmoji.sprite = nil

		local cfg = ChatConfig.instance:getConfigByKey(ConfigName.ChatEmoji, emoji)

		IconLoader.setSprite(self._imgEmoji, IconType.ChatEmoji, cfg.icon, self._onImageLoaded, self)
	end

	local hasVoice = messageMO:hasVoice()

	goutil.setActive(self._goVoice, hasVoice)

	if hasVoice then
		messageMO:playVoice()
	end

	self:setVisible(true)
	self:_updateBgContent()
end

function M:_onImageLoaded()
	local image = self._imgEmoji.gameObject:GetComponent("Image")

	self._imgEmoji.sprite = image.sprite
end

function M:_initPosition()
	goutil.addChildToParent(self.mainGO, self.unit.mainGO)
	Astral.TransformUtil.SetLocalPos(self.unit.mainGO.transform, 0, 0, 0)

	local rotationY = BattleMgr.instance:getModel():getCameraRotation()

	Astral.TransformUtil.SetLocalRotation(self.mainGO.transform, 10, rotationY - 35, 0)
	GlobalDispatcher:addEventListener(EventType.ON_CAMERA_ROTATION_UPDATE, self._doUIRotation, self)
end

function M:_updateBgContent()
	local lineCount = self._lineCount
	local height = 0.52
	local posy = 0

	if self._hasEmoji then
		height = 1.2
		posy = 0.32 - 0.2 * lineCount
	else
		posy = -0.43

		if self._lineCount == 1 then
			height = 0.52
		elseif self._lineCount == 2 then
			height = 0.79
		elseif self._lineCount == 3 then
			height = 1.04
		end
	end

	RectTransformUtils.SetAnchoredPosition(self._contentGo.transform, -0.2, posy)
	self._bgVector2:Set(self._bgVector2.x, height)

	self._bgRender.size = self._bgVector2
end

function M:_dealTimelineListener(tagName)
	if tagName == "open" then
		-- block empty
	end
end

function M:_doUIRotation(_, time)
	local rotationY = BattleMgr.instance:getModel():getCameraRotation()
	local x, y, z = TransformUtils.GetEulerAngles(self.mainGO.transform, 0, 0, 0)

	self.mainGO.transform:DORotate(Vector3.New(x, rotationY - 35, z), time)
end

function M:clear()
	if self.mainGO and self._hasBuild then
		self._hasBuild = false

		goutil.destroy(self.mainGO)

		self.mainGO = false
	end
end

return M
