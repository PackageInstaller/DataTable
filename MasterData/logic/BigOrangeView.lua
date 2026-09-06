-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bigorange/view/BigOrangeView.lua

module("logic.extensions.bigorange.view.BigOrangeView", package.seeall)

local BigOrangeView = class("BigOrangeView", ViewComponent)

function BigOrangeView:ctor()
	BigOrangeView.super.ctor(self)
end

function BigOrangeView:buildUI()
	BigOrangeView.super.buildUI(self)

	self._closeBtn = self:getBtn("bg/closeBtn")
	self._noticeBtn = self:getBtn("bg/noticeBtn")
	self._noticeBtnChange = self._noticeBtn.gameObject:GetComponent("UIImageSpriteChange")
	self._noticeNewFlag = self:getGo("bg/noticeBtn/newIcon")
	self._answerBtn = self:getBtn("bg/answerBtn")
	self._answerBtnChange = self._answerBtn.gameObject:GetComponent("UIImageSpriteChange")
	self._answerNewFlag = self:getGo("bg/answerBtn/newIcon")
	self._chatRoomBtn = self:getBtn("bg/chatRoomBtn")
	self._chatRoomBtnChange = self._chatRoomBtn.gameObject:GetComponent("UIImageSpriteChange")
	self._noticeCell = self:getGo("bg/noticeCell")
	self._noticeViewGo = self:getGo("bg/noticeView")
	self._noticeView = ScrollerList.create(self._noticeViewGo, self._noticeCell, GameUtil.handler(self._updateNoticeCell, self))
	self._orangeImage = self:getGo("bg/orangeImage")
	self._showImage = goutil.findChildComponent(self.mainGO, "bg/showImage", "UIImageSpriteChange")
	self._answerCell = self:getGo("bg/answerCell")
	self._answerView = self:getGo("bg/answerView")
	self._answerParent = goutil.findChildRectTransformComponent(self.mainGO, "bg/answerView/Viewport/Content")
	self._answerCell = self:getGo("bg/answerCell")
	self._typeDrop = DropDownAdapter.GetFrom(self.mainGO, "bg/type/Dropdown")
	self._chatContent = self:getInput("bg/content/input")
	self._chatContentIcon = self:getGo("bg/content/input/icon")
	self._chatContentLen = goutil.findChildTextComponent(self.mainGO, "bg/content/len")
	self._submitBtn = self:getBtn("bg/submitBtn")
	self._role = self:getGo("role")
	self._dialog = self:getGo("role/dialog")
	self._dialogText = goutil.findChildTextComponent(self._dialog, "Text")
	self._dialogBtn = self:getBtn("role/dialogBtn")
end

function BigOrangeView:bindEvents()
	BigOrangeView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._noticeBtn:AddClickListener(self._onClickNotice, self)
	self._answerBtn:AddClickListener(self._onClickAnswer, self)
	self._chatRoomBtn:AddClickListener(self._onClickChatRoom, self)
	self._submitBtn:AddClickListener(self._onClickSubmit, self)
	self._dialogBtn:AddClickListener(self._onClickDialog, self)
end

function BigOrangeView:unbindEvents()
	BigOrangeView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._noticeBtn:RemoveClickListener()
	self._answerBtn:RemoveClickListener()
	self._chatRoomBtn:RemoveClickListener()
	self._submitBtn:RemoveClickListener()
	self._dialogBtn:RemoveClickListener()
end

function BigOrangeView:destroyUI()
	BigOrangeView.super.destroyUI(self)
end

function BigOrangeView:onEnter()
	BigOrangeView.super.onEnter(self)
	SurveyController.instance:reportBehavior(200396)

	self._noticeInfos = BigOrangeConfig.instance:getNotice()

	for i, value in ipairs(self._noticeInfos) do
		value.newFlag = not GameUtil.getUserData(BigOrangeConfig.SAVEFLAG .. value.title)
	end

	self._answerInfos = BigOrangeConfig.instance:getAnswer()
	self._answerCells = self._answerCells or {}
	self._cellCreatePosY = 0

	for i, value in ipairs(self._answerInfos) do
		value.newFlag = not GameUtil.getUserData(BigOrangeConfig.SAVEFLAG .. value.question)

		if self._answerCells[i] == nil then
			self._answerCells[i] = goutil.cloneAndSetParent(self._answerCell, self._answerParent)

			self:_updateAnswerCell(self._answerCells[i], value, i)
		end
	end

	goutil.setActive(self._noticeNewFlag, self:_btnNewFlag(self._noticeInfos))
	goutil.setActive(self._answerNewFlag, self:_btnNewFlag(self._answerInfos))
	self._noticeView:reloadData(self._noticeInfos)
	self._typeDrop:ClearOptions()

	for i, value in ipairs(BigOrangeConfig.instance:getType()) do
		self._typeDrop:AddOptions(value.types)
	end

	self._chatContent:AddOnValueChanged(self._onValueChanged, self)

	self._chatContentLen.text = "字数限制(0/500)"
	self._roleShow = PhotoEffect.Get(self._role)
	self._curShowSpine = StorySpinePlayer.New()

	local rect = self._role:GetComponent("RectTransform").rect
	local ratio = UnityEngine.Screen.height / 720

	self._roleShow:setEffectLoadedCallback(function(go)
		self._curShowAnim = go:GetComponent("SkeletonAnimation")

		self._curShowSpine:setSpine(self._curShowAnim)
	end)
	self._roleShow:showEffectsFullScreen({
		GameUrl.getLihuiSpineUrl("80021_dachengzi_lihui")
	}, rect.width * ratio, rect.height * ratio)
	self._roleShow:setCameraPosition(-0.31, 2.04, -8.42)
	self:_onClickNotice()

	self._role:GetComponent("RawImage").material = nil

	self:_blurScreen()

	self._dialogContent = BigOrangeConfig.instance:getDialog()
end

function BigOrangeView:onEnterFinished()
	BigOrangeView.super.onEnterFinished(self)
end

function BigOrangeView:onExit()
	BigOrangeView.super.onExit(self)
	self._chatContent:RemoveOnValueChanged()
	removetimer(self._playDialog, self)
	goutil.setActive(self._dialog, false)
	self._roleShow:clear()

	self._roleShow = nil

	self._noticeView:dispose()
end

function BigOrangeView:onExitFinished()
	if self._blurCamera then
		AMBlurScreenEffect.UnBlur(self._blurCamera)

		self._blurCamera = nil
	end

	BigOrangeView.super.onExitFinished(self)
end

function BigOrangeView:_updateNoticeCell(view, cell, data)
	uGuiUtil.setSpriteToImage(cell.gameObject, uGuiUtil.SpriteType.BigBg, "ui/bigbg/bigorange/" .. data.titleBG)

	local newIcon = goutil.findChild(cell.gameObject, "newIcon")

	goutil.setActive(newIcon, data.newFlag)
	Framework.ButtonAdapter.Get(cell.gameObject):AddClickListener(function()
		GameUtil.saveUserData(BigOrangeConfig.SAVEFLAG .. data.title, true)

		self._noticeInfos[cell.data].newFlag = false

		goutil.setActive(newIcon, false)

		data.newFlag = false

		goutil.setActive(self._noticeNewFlag, self:_btnNewFlag(self._noticeInfos))
		UIStateManager.instance:push(ViewName.BigOrangeNoticeView, data.id)
	end)

	local time = string.split(data.duration, "#")

	time[1] = GameUtil.string2date(time[1])
	time[2] = GameUtil.string2date(time[2])
	goutil.findChildTextComponent(cell.gameObject, "txtTime").text = string.format("%d/%d/%d-%d/%d/%d", time[1].year, time[1].month, time[1].day, time[2].year, time[2].month, time[2].day)
end

function BigOrangeView:_updateAnswerCell(cell, data, i)
	local newIcon = goutil.findChild(cell, "newIcon")

	goutil.setActive(cell, true)
	goutil.setActive(newIcon, data.newFlag)

	goutil.findChildTextComponent(cell, "time").text = data.questionTime

	local contentText = goutil.findChildTextComponent(cell, "content")

	contentText.text = data.question

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(contentText.gameObject:GetComponent(goutil.Type_RectTransform))
	GameUtil.setAnchoredPos(cell, 5, self._cellCreatePosY)

	local contentPos = GameUtil.getAnchoredPos(contentText)

	GameUtil.setHeight(cell, -1 * contentPos.y + GameUtil.getHeight(contentText.gameObject) + 10)

	self._cellCreatePosY = self._cellCreatePosY + contentPos.y - GameUtil.getHeight(contentText.gameObject) - 20

	GameUtil.setHeight(self._answerParent.gameObject, -self._cellCreatePosY)
	Framework.ButtonAdapter.Get(cell.gameObject):AddClickListener(function()
		GameUtil.saveUserData(BigOrangeConfig.SAVEFLAG .. data.question, true)

		self._answerInfos[i].newFlag = false

		goutil.setActive(newIcon, false)

		data.newFlag = false

		goutil.setActive(self._answerNewFlag, self:_btnNewFlag(self._answerInfos))
		UIStateManager.instance:push(ViewName.BigOrangeAnswerView, data.id)
	end)
end

function BigOrangeView:_switch(index)
	self._dialogType = index

	goutil.setActive(self._noticeViewGo, index == 1)
	goutil.setActive(self._showImage.gameObject, index ~= 1)
	goutil.setActive(self._orangeImage, index ~= 1)
	goutil.setActive(self._answerView, index == 2)
	goutil.setActive(self._typeDrop.transform.parent.gameObject, index == 3)
	goutil.setActive(self._chatContent.transform.parent.gameObject, index == 3)
	goutil.setActive(self._submitBtn.gameObject, index == 3)
end

function BigOrangeView:_btnNewFlag(list)
	for i, v in ipairs(list) do
		if v.newFlag then
			return true
		end
	end

	return false
end

function BigOrangeView:_onClickNotice()
	self._noticeBtnChange:SetState(1)
	self._answerBtnChange:SetState(0)
	self._chatRoomBtnChange:SetState(0)
	self:_switch(1)

	if self._curShowSpine then
		self._curShowSpine:setSpine(self._curShowAnim, {
			"idle1",
			"idle"
		})
	end
end

function BigOrangeView:_onClickAnswer()
	self._noticeBtnChange:SetState(0)
	self._answerBtnChange:SetState(1)
	self._chatRoomBtnChange:SetState(0)
	self._showImage:SetState(0)
	self:_switch(2)

	if self._curShowSpine then
		self._curShowSpine:setSpine(self._curShowAnim, {
			"idle3"
		})
	end
end

function BigOrangeView:_onClickChatRoom()
	self._noticeBtnChange:SetState(0)
	self._answerBtnChange:SetState(0)
	self._chatRoomBtnChange:SetState(1)
	self._showImage:SetState(1)
	self:_switch(3)

	if self._curShowSpine then
		self._curShowSpine:setSpine(self._curShowAnim, {
			"idle2"
		})
	end
end

function BigOrangeView:_onClickSubmit()
	local text = self._chatContent:GetText()

	if text == "" then
		FloatWordMgr.instance:show("您还没有填写任何内容呢~")

		return
	end

	SurveyAgent.instance:sendPM_BigOrangeTalkCheckAndSaveReq(BigOrangeConfig.instance:getTypeById(self._typeDrop:GetValue() + 1).types, self._chatContent:GetText(), function()
		FloatWordMgr.instance:show("提交成功，大橙子会认真阅读你的反馈的，还有机会获得精选留言回复哦")
		self._chatContent:SetText("")
	end)
end

function BigOrangeView:_onClickDialog()
	math.randomseed(os.time())
	removetimer(self._playDialog, self)
	goutil.setActive(self._dialog, true)

	self._dialogText.text = self._dialogContent[self._dialogType][math.random(#self._dialogContent[self._dialogType])].content

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._dialogText.gameObject:GetComponent(goutil.Type_RectTransform))
	GameUtil.setWidth(self._dialog, GameUtil.getWidth(self._dialogText.gameObject) + 10)
	GameUtil.setHeight(self._dialog, GameUtil.getHeight(self._dialogText.gameObject) + 55)
	settimer(5, self._playDialog, self, false)
end

function BigOrangeView:_onValueChanged()
	local text = self._chatContent:GetText()

	goutil.setActive(self._chatContentIcon, text == "")

	local strLen = string.utf8len(text)

	if strLen < 500 then
		self._chatContentLen.text = string.format("字数限制(%d/500)", strLen)
	else
		self._chatContent:SetText(AssignmentDetailsController:sub(text, 1, 500))

		self._chatContentLen.text = "字数限制(500/500)"
	end
end

function BigOrangeView:_playDialog()
	goutil.setActive(self._dialog, false)
end

function BigOrangeView:_blurScreen()
	local _background = self._closeBtn.gameObject:GetComponent("RawImage")
	local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()

	self._blurCamera = mainCamera:getCamera().gameObject

	if self._blurCamera then
		if AMBlurScreenEffect.finalTexture then
			_background.texture = AMBlurScreenEffect.finalTexture
		else
			AMBlurScreenEffect.BlurWithRawImage(self._blurCamera, _background, 0.2, 1, 3, 0.98)
		end
	end
end

return BigOrangeView
