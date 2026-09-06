-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bulletscreen/view/BulletScreenView.lua

module("logic.extensions.bulletscreen.view.BulletScreenView", package.seeall)

local BulletScreenView = class("BulletScreenView", ViewComponent)

function BulletScreenView:ctor()
	BulletScreenView.super.ctor(self)

	self._isFadeIn = true
end

function BulletScreenView:unbindEvents()
	BulletScreenView.super.unbindEvents(self)
	self._btnSend:RemoveClickListener()
	self._closeButton:RemoveClickListener()
	self._bgBtn:RemoveClickListener()
	self._inputField:RemoveOnValueChanged()
	self._btnOk:RemoveClickListener()
	self._btnToggle:RemoveClickListener()
end

function BulletScreenView:bindEvents()
	BulletScreenView.super.bindEvents(self)
	self._btnSend:AddClickListener(self._onClickSend, self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._bgBtn:AddClickListener(self._onClickClose, self)
	self._inputField:AddOnValueChanged(self._onValueChanged, self)
	self._btnOk:AddClickListener(self._onClickOk, self)
	self._btnToggle:AddClickListener(self._onClickToggle, self)
end

function BulletScreenView:onExit()
	self:_clearTween()
	self._displayer:Clear()
	BulletScreenView.super.onExit(self)
	removetimer(self._onTick, self)
	GlobalDispatcher:removeListener(GlobalNotify.BulletSendSuccess, self._onBulletSendSuccess, self)
	GlobalDispatcher:removeListener(GlobalNotify.BulletScreenToggled, self._onBulletScreenToggled, self)
	GlobalDispatcher:removeListener(GlobalNotify.BulletScreenFade, self._tweenCanvasAlpha, self)
	GlobalDispatcher:removeListener(GlobalNotify.BulletKeyChanged, self._onBulletKeyChanged, self)
end

function BulletScreenView:buildUI()
	BulletScreenView.super.buildUI(self)

	self._displayer = self:getGo("displayer"):GetComponent("BulletScreenDisplayer")
	self._canvasGroup = self._displayer:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._btnSend = self:getBtn("bomleft/btnSend")
	self._mainCanvasGroup = self.mainGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._sendMainGo = self:getGo("sendbulletview")
	self._closeButton = Framework.ButtonAdapter.GetFrom(self._sendMainGo, "Nego_Main/Btn_Close")
	self._bgBtn = Framework.ButtonAdapter.GetFrom(self._sendMainGo, "Nego_Main/raycast")

	local Nego_Main = goutil.findChild(self._sendMainGo, "Nego_Main")

	self._btnOk = Framework.ButtonAdapter.GetFrom(self._sendMainGo, "Nego_Main/btnOk")
	self._inputField = Framework.InputFieldAdapter.GetFrom(Nego_Main, "inputField")
	self._txtLeftCount = goutil.findChildTextComponent(Nego_Main, "txtLeftCount")
	self._btnToggle = Framework.ButtonAdapter.GetFrom(self._sendMainGo, "Nego_Main/btnToggle")
	self._togOn = goutil.findChild(self._btnToggle.gameObject, "on")
	self._togOff = goutil.findChild(self._btnToggle.gameObject, "off")
end

function BulletScreenView:onEnter()
	BulletScreenView.super.onEnter(self)

	local enum, key = BulletScreenModel.instance:getCurKeys()
	local rootType = ViewRootType.FullScreen

	if enum == GameEnum.BulletScene.Formation then
		rootType = ViewRootType.Popup
	elseif enum == GameEnum.BulletScene.InBattle then
		rootType = ViewRootType.FullScreen
	end

	if rootType then
		local root = ViewMgr.instance:getRoot(rootType)

		goutil.addChildToParent(self.mainGO, root)
	end

	goutil.setActive(self._btnSend.gameObject, true)

	self._mainCanvasGroup.alpha = 1

	GlobalDispatcher:addListener(GlobalNotify.BulletSendSuccess, self._onBulletSendSuccess, self)
	GlobalDispatcher:addListener(GlobalNotify.BulletScreenToggled, self._onBulletScreenToggled, self)
	GlobalDispatcher:addListener(GlobalNotify.BulletScreenFade, self._tweenCanvasAlpha, self)
	GlobalDispatcher:addListener(GlobalNotify.BulletKeyChanged, self._onBulletKeyChanged, self)

	local isOn = BulletScreenController.instance:getOnOff()

	self:_onBulletScreenToggled(isOn)
	self:_onBulletKeyChanged()

	self._maxLen = 30

	self._inputField:SetCharacterLimit(self._maxLen)
	self:_updateBtnGray(true)
	self._inputField:SetText("")

	self._isEntered = true

	local isOn = BulletScreenController.instance:getOnOff()

	self:_updateToggle(isOn)

	self._lastSendTime = nil

	self:_onClickClose()
end

function BulletScreenView:_onBulletKeyChanged()
	local enum, key = BulletScreenModel.instance:getCurKeys()

	print("bullet key changed enum = " .. enum .. " key = " .. key)

	self._cfgs = BulletScreenModel.instance:getBulletsByKeys(enum, key)
	self._curShowIdx = 0
	self._tickedTime = 0

	BulletScreenController.instance:setStarTime()
	removetimer(self._onTick, self)
	settimer(0, self._onTick, self, true)
end

function BulletScreenView:_onClickClose()
	goutil.setActive(self._btnSend.gameObject, true)
	goutil.setActive(self._sendMainGo, false)
end

function BulletScreenView:_onBulletSendSuccess(text)
	self._displayer:AddBullet(text, true)
end

function BulletScreenView:_onBulletScreenToggled(isOn)
	self._canvasGroup.alpha = isOn and 1 or 0
end

function BulletScreenView:_onTick()
	self._tickedTime = self._tickedTime + UnityEngine.Time.deltaTime

	local i = self._curShowIdx + 1
	local maxCount = 5

	while i <= #self._cfgs and maxCount > 0 do
		local cfg = self._cfgs[i]

		if cfg.time <= self._tickedTime then
			self._curShowIdx = i

			self._displayer:AddBullet(cfg.content, cfg.isMe == true)

			maxCount = maxCount - 1

			if i == #self._cfgs then
				removetimer(self._onTick, self)
			end
		else
			break
		end

		i = i + 1
	end
end

function BulletScreenView:_onClickSend()
	print("click send bullet")
	goutil.setActive(self._btnSend.gameObject, false)
	goutil.setActive(self._sendMainGo, true)
end

function BulletScreenView:_tweenCanvasAlpha(isFadeIn)
	local startVal = isFadeIn and 1 or 0
	local endVal = isFadeIn and 0 or 1

	self._tweener = TweenUtil.ValueTo(startVal, endVal, 0.5, function(val)
		self._mainCanvasGroup.alpha = val
	end, function()
		self._tweener = nil
	end, self)
end

function BulletScreenView:_clearTween()
	if self._tweener then
		self._tweener:Kill(false)
	end

	self._tweener = nil
end

function BulletScreenView:_updateToggle(isOn)
	goutil.setActive(self._togOn, isOn)
	goutil.setActive(self._togOff, not isOn)
end

function BulletScreenView:_onValueChanged()
	local text = self._inputField:GetText()
	local newText = string.gsub(text, "\n", "")

	if newText ~= text then
		self._inputField:SetText(newText)
	else
		self:_updateBtnGray(string.nilorempty(text))

		local t = StringUtil.utf8split(text)
		local len = 0

		for i = 1, #t do
			if i > self._maxLen then
				break
			else
				len = len + 1
			end
		end

		self._txtLeftCount.text = string.format("%s/%s", len, self._maxLen)
	end
end

function BulletScreenView:_updateBtnGray(isGray)
	if self._isGray ~= isGray then
		self._isGray = isGray

		uGuiUtil.setGoGrayState(self._btnOk, isGray)

		self._isGray = isGray
	end
end

function BulletScreenView:_onClickOk()
	local text = self._inputField:GetText()

	if string.nilorempty(text) then
		FloatWordMgr.instance:show("发送弹幕不能为空")
	elseif ServerTime.now() - checknumber(self._lastSendTime) <= 5 then
		FloatWordMgr.instance:show("发送弹幕太频繁了，请休息一下")
	else
		local key, subKey = BulletScreenModel.instance:getCurKeys()
		local time = ServerTime.now() - BulletScreenController.instance:getStartTime()

		SurveyAgent.instance:sendPM_DanMuCheckAndSaveReq(tostring(key), tostring(subKey), time, text, function(msg)
			local content = msg.afterCheckContent

			GlobalDispatcher:dispatch(GlobalNotify.BulletSendSuccess, content)
			BulletScreenModel.instance:localAddBullet(key, subKey, content, time)
			FloatWordMgr.instance:show("发送成功")
			self._inputField:SetText("")

			self._lastSendTime = ServerTime.now()
		end)
	end
end

function BulletScreenView:_onClickToggle()
	local isOn = not BulletScreenController.instance:getOnOff()

	BulletScreenController.instance:setOnOff(isOn)
	GlobalDispatcher:dispatch(GlobalNotify.BulletScreenToggled, isOn)
	self:_updateToggle(isOn)
end

return BulletScreenView
