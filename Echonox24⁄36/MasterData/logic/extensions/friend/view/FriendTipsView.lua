-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/FriendTipsView.lua

module("logic.extensions.friend.view.FriendTipsView", package.seeall)

local M = class("FriendTipsView", ViewComponent)

function M:buildUI()
	local _passEventGo = self:getGo("empty_mask_tips_29887572")

	self._passEvent = _passEventGo.gameObject:GetComponent(ComponentType.PassEvent)
	self._imgHeadIcon = self:getImage("0&head_item_1770823988")
	self._imgHeadIconGray = self:getImage("0&head_item_2073113669")
	self._txtName = self:getText("friend_handle_tips_1697558767")
	self._txtRemark = self:getText("friend_handle_tips_208711325")
	self._txtLv = self:getText("friend_handle_tips_332257990")
	self._btnRemark = self:getBtn("friend_handle_tips_390326139")
	self._btnCallingCard = self:getBtn("friend_handle_tips_1927379168")
	self._btnChat = self:getBtn("friend_handle_tips_1278894845")
	self._btnAddFriends = self:getBtn("friend_handle_tips_798735814")
	self._btnDeleteFriends = self:getBtn("friend_handle_tips_571159537")
	self._btnBlacklist = self:getBtn("friend_handle_tips_302921154")
	self._btnInform = self:getBtn("friend_handle_tips_236654529")
	self._addNormal = goutil.findChild(self._btnAddFriends.gameObject, "normal")
	self._addDone = goutil.findChild(self._btnAddFriends.gameObject, "done")

	local headLockGo = self:getGo("head_item_-765526646")

	headLockGo:SetActive(false)

	self._screenshotBlurImage = goutil.findChildRawImageComponent(self.mainGO, "mask/common_blur_rt")
	self._screenshotImage = CaptureScreenshotImage.Get(self._screenshotBlurImage.gameObject)
	self._timelineTask = TimelineTask.New()
end

function M:bindEvents()
	self._btnRemark:AddClickListener(self._onClickBtnRemark, self)
	self._btnCallingCard:AddClickListener(self._onClickBtnCallingCard, self)
	self._btnChat:AddClickListener(self._onClickBtnChat, self)
	self._btnAddFriends:AddClickListener(self._onClickBtnAddFriends, self)
	self._btnDeleteFriends:AddClickListener(self._onClickBtnDeleteFriends, self)
	self._btnBlacklist:AddClickListener(self._onClickBtnBlacklist, self)
	self._btnInform:AddClickListener(self._onClickBtnInform, self)
	GlobalDispatcher:addEventListener(EventType.FRIEND_SET_ALIAS_SUCCESS, self._refreshView, self)
	GlobalDispatcher:addEventListener(EventType.FRIEND_APPLY_SUCCESS, self._refreshView, self)
end

function M:unbindEvents()
	self._btnRemark:RemoveClickListener()
	self._btnCallingCard:RemoveClickListener()
	self._btnChat:RemoveClickListener()
	self._btnAddFriends:RemoveClickListener()
	self._btnDeleteFriends:RemoveClickListener()
	self._btnBlacklist:RemoveClickListener()
	self._btnInform:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.FRIEND_SET_ALIAS_SUCCESS, self._refreshView, self)
	GlobalDispatcher:removeEventListener(EventType.FRIEND_APPLY_SUCCESS, self._refreshView, self)
end

function M:onEnter()
	local params = self:getFirstParam() or {}

	self._friendMo = params.baseData.friendMo
	self._msgMo = params.baseData.msgMo

	local isPassEvent = params.isPassEvent

	self._passEvent.isPassEvent = isPassEvent

	self:_refreshView()
end

function M:onEnterFinished()
	self:_initBlurEffect()
end

function M:onExit()
	self._timelineTask:clear()
	self._screenshotImage:Clear()
end

function M:destroyUI()
	return
end

function M:_refreshView()
	if not self._friendMo then
		return
	end

	local itemCo = BackpackConfig.instance:getItemInfoByItemId(self._friendMo:getPortrait())

	IconLoader.setSprite(self._imgHeadIcon, IconType.HeadIcon, itemCo.icon)
	IconLoader.setSprite(self._imgHeadIconGray, IconType.HeadIcon, itemCo.icon)

	local isFriend = FriendModel.instance:isInRelationType(GameEnum.RelationTypeEnum.Friend, self._friendMo:getUserId())

	self._btnChat.gameObject:SetActive(isFriend)
	self._btnDeleteFriends.gameObject:SetActive(isFriend)
	self._txtRemark.gameObject:SetActive(isFriend)

	self._txtName.text = self._friendMo:getNickName()
	self._txtLv.text = string.format("Lv.%d", self._friendMo:getLv())

	local lastLoginTime = self._friendMo:getLastLoginTime()
	local alias = self._friendMo:getAlias()

	if string.nilorempty(alias) then
		alias = lang("tip_remark")
	end

	self._txtRemark.text = alias

	self._btnRemark.gameObject:SetActive(isFriend)
	self._btnAddFriends.gameObject:SetActive(not isFriend)

	local isApply = self._friendMo:getRelationShip() == GameEnum.RelationTypeEnum.Apply

	goutil.setActive(self._addNormal, not isApply)
	goutil.setActive(self._addDone, isApply)
	goutil.setActive(self._imgHeadIcon.gameObject, lastLoginTime == 0)
	goutil.setActive(self._imgHeadIconGray.gameObject, lastLoginTime > 0)
end

function M:_onClickBtnRemark()
	local relationType = GameEnum.RelationTypeEnum.Friend
	local targetId = self._friendMo:getUserId()
	local friendMo = FriendModel.instance:getUser(relationType, targetId)

	if not friendMo then
		FloatWordMgr.instance:show(lang("tip_not_friend"))
		self:close()

		return
	end

	ViewMgr.instance:open(ViewName.FriendChangeAlias, self._friendMo)
end

function M:_onClickBtnCallingCard()
	PlayerAgent.instance:sendGetPlayerCardInfoRequest(self._friendMo:getUserId())
	self:close()
end

function M:_onClickBtnChat()
	local relationType = GameEnum.RelationTypeEnum.Friend
	local targetId = self._friendMo:getUserId()
	local friendMo = FriendModel.instance:getUser(relationType, targetId)

	if not friendMo then
		FloatWordMgr.instance:show(lang("tip_not_friend"))
		self:close()

		return
	end

	self:close()

	if not ViewMgr.instance:isOpen(ViewName.ChatMain) then
		local channelType = GameEnum.ChannelTypeEnum.Friend

		ChatMainFacade.instance:openChatMainView(channelType, targetId)
	end
end

function M:_onClickBtnAddFriends()
	if self._friendMo:getRelationShip() == GameEnum.RelationTypeEnum.Apply then
		return
	end

	local cur = FriendModel.instance:getUserCountByType(GameEnum.RelationTypeEnum.Friend)
	local max = ConstConfig.instance:getNumValueByKey("MaxFriendNum")

	if max <= cur then
		FloatWordMgr.instance:show(lang("tip_friend_full"))

		return
	end

	local userId = self._friendMo:getUserId()

	FriendAgent.instance:sendApplyFriendRequest(userId)
end

function M:_onClickBtnDeleteFriends()
	local relationType = GameEnum.RelationTypeEnum.Friend
	local targetId = self._friendMo:getUserId()
	local friendMo = FriendModel.instance:getUser(relationType, targetId)

	if not friendMo then
		FloatWordMgr.instance:show(lang("tip_not_friend"))
		self:close()

		return
	end

	local function confirmCallback()
		FriendAgent.instance:sendRemoveFriendRequest(self._friendMo:getUserId())
		self:close()
	end

	local name = self._friendMo:getNickName()
	local content = string.format(lang("tip_delete_friend"), name)
	local dialog = Dialog.showMessage(lang("tip_title"), content)

	dialog:setConfirmListener(confirmCallback, self)
end

function M:_onClickBtnBlacklist()
	if self._friendMo:getRelationShip() == GameEnum.RelationTypeEnum.Block then
		FloatWordMgr.instance:show(lang("tip_add_back_list"))

		return
	end

	local cur = FriendModel.instance:getUserCountByType(GameEnum.RelationTypeEnum.Block)
	local max = ConstConfig.instance:getNumValueByKey("MaxBlockNum")

	if max <= cur then
		FloatWordMgr.instance:show(lang("tip_back_list_full"))

		return
	end

	local function confirmCallback()
		FriendAgent.instance:sendBlockUserRequest(self._friendMo:getUserId())
		self:close()
	end

	local name = self._friendMo:getNickName()
	local content

	if self._friendMo:getRelationShip() == GameEnum.RelationTypeEnum.Friend then
		content = string.format(lang("tip_add_back_list_relieve"), name, name)
	else
		content = string.format(lang("tip_add_back_list_not_receive"), name, name)
	end

	local dialog = Dialog.showMessage(lang("tip_title"), content)

	dialog:setConfirmListener(confirmCallback, self)
end

function M:_onClickBtnInform()
	local data = {
		playerId = self._friendMo:getUserId()
	}

	if self._msgMo then
		data.content = self._msgMo:getContent()
	end

	ReportFacade.instance:openReportView(data)
end

function M:_initBlurEffect()
	local uiRoot = ViewMgr.instance:getUIRoot()
	local rectTransform = uiRoot.transform
	local width = rectTransform.rect.width
	local height = rectTransform.rect.height

	self._screenshotImage:Build(width, height)
	self._timelineTask:addTask(0, self._tCaptureFrame, self)
	self._timelineTask:addTask(0, self._tShowCaptureFrame, self)
	self._timelineTask:start()
end

function M:_tCaptureFrame()
	self._screenshotImage:CaptureFrame(self._onCaptureFinish, self)
end

function M:_tShowCaptureFrame()
	local viewName = self._viewPresentor and self._viewPresentor:getViewName() or "BlurBgView"

	GlobalDispatcher:dispatchEvent(EventType.ON_BLUR_BG_CAPTURE_FINISH, viewName)
end

function M:_onCaptureFinish()
	local downSample = self._downSample or 4
	local iteration = self._iteration or 4
	local renderTexture = SpaceX.CommandBufferEffectUtils.Blur(self._screenshotBlurImage.texture, CommonPreloader.instance:getMaterialsCommAsset(CommonResPath.BlurMat), downSample, iteration)

	self._screenshotImage:SetRenderTexture(renderTexture)
end

return M
