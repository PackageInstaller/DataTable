-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/forum/ForumView.lua

module("logic.extensions.controlaction.view.forum.ForumView", package.seeall)

local M = class("ForumView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnClose = self:getBtn("regulatory_forum_panel_1165691078")
	self._btnSmall = self:getBtn("regulatory_forum_panel_1451150280")
	self._imgScretGo = self:getGo("regulatory_forum_panel_210605413")
	self._imgNormalGo = self:getGo("regulatory_forum_panel_1801901116")
	self._btnReturn = self:getBtn("regulatory_forum_panel_262308036")
	self._btnTop = self:getBtn("regulatory_forum_panel_707807239")
	self._txtTitle = self:getText("regulatory_forum_panel_1895353644")
	self._themePostPanelGo = self:getGo("regulatory_forum_panel_983524053")
	self._replyPanelGo = self:getGo("regulatory_forum_panel_1633025180")
	self._themeListGo = self:getGo("regulatory_forum_panel_511416881")
	self._themePostItem = self:getGo("0&regulatory_forum_post_item_-1827002570")
	self._replyListGo = self:getGo("regulatory_forum_panel_-1896909524")
	self._replyPostItem = self:getGo("1&regulatory_forum_comment_item_-347024155")
	self._contentListGo = self._themePostPanelGo.transform.parent.gameObject

	goutil.addComponentOnce(self._contentListGo, UIComponentType.EmptyRaycast)

	local passEvent = goutil.addComponentOnce(self._contentListGo, ComponentType.PassEvent)

	passEvent.isPassEvent = true
	self._beginPosition = Vector2.New()
	self._dragTrigger = Astral.UIDragTrigger.Get(self._contentListGo)

	goutil.addChildToParent(self._themePostItem, self._themePostPanelGo)
	goutil.addChildToParent(self._replyPostItem, self._replyPanelGo)
	goutil.setActive(self._themePostItem, false)
	goutil.setActive(self._replyPostItem, false)

	self._headIcon = self:getImage("regulatory_forum_panel_-1392670293")
	self._shareIcon = self:getImage("regulatory_forum_panel_-298283321")
	self._btnClickImage = self:getBtn("regulatory_forum_panel_1410668792")
	self._txtName = self:getText("regulatory_forum_panel_1481421122")
	self._txtLevel = self:getText("regulatory_forum_panel_-1677677274")
	self._txtTime = self:getText("regulatory_forum_panel_-1164241890")
	self._txtFloor = self:getText("regulatory_forum_panel_-177107056")
	self._txtContent = self:getText("regulatory_forum_panel_505714716")

	local likeCountGo = self:getGo("regulatory_forum_panel_1312953076")

	self._txtLikeCount = likeCountGo:GetComponent(UIComponentType.TextMeshProUGUI)
	self._btnLike = self:getBtn("regulatory_forum_panel_22456993")
	self._likeFlagGo = goutil.findChild(self._btnLike.gameObject, "type1")
	self._unlikeFlagGo = goutil.findChild(self._btnLike.gameObject, "type2")
	self._bigImageGo = self:getGo("regulatory_forum_panel_801777147")
	self._shareBigIcon = self:getImage("regulatory_forum_panel_394858064")
	self._btnCloseImage = self:getBtn("regulatory_forum_panel_1996194980")
end

function M:destroyUI()
	self._loopGridHelper = nil
end

function M:bindEvents()
	self._btnTop:AddClickListener(self._onClickToTop, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnSmall:AddClickListener(self._onClickSmall, self)
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnLike:AddClickListener(self._onClickLike, self)
	self._btnClickImage:AddClickListener(self._onClickImage, self)
	self._btnCloseImage:AddClickListener(self._onCloseImage, self)
	self._dragTrigger:AddBeginDragListener(self._onBeginDrag, self)
	self._dragTrigger:AddEndDragListener(self._onEndDrag, self)
	GlobalDispatcher:addEventListener(EventType.CONTROLACTION_FORUMDATA_FINISH, self._refresh, self)
	GlobalDispatcher:addEventListener(EventType.CONTROLACTION_FORUM_POSTCLICK, self._handlePostClick, self)
	GlobalDispatcher:addEventListener(EventType.CONTROLACTION_FORUM_POSTREPLY, self._handleReplyPost, self)
	GlobalDispatcher:addEventListener(EventType.CONTROLACTION_FORUM_POSTLIKE, self._refreshLike, self)
end

function M:unbindEvents()
	self._btnTop:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnSmall:RemoveClickListener()
	self._btnReturn:RemoveClickListener()
	self._btnLike:RemoveClickListener()
	self._btnClickImage:RemoveClickListener()
	self._btnCloseImage:RemoveClickListener()
	self._dragTrigger:RemoveBeginDragListener()
	self._dragTrigger:RemoveEndDragListener()
	GlobalDispatcher:removeEventListener(EventType.CONTROLACTION_FORUMDATA_FINISH, self._refresh, self)
	GlobalDispatcher:removeEventListener(EventType.CONTROLACTION_FORUM_POSTCLICK, self._handlePostClick, self)
	GlobalDispatcher:removeEventListener(EventType.CONTROLACTION_FORUM_POSTREPLY, self._handleReplyPost, self)
	GlobalDispatcher:removeEventListener(EventType.CONTROLACTION_FORUM_POSTLIKE, self._refreshLike, self)
end

function M:onEnter()
	if ControlActionUtil.isInGuide() then
		self:_refresh()
	else
		ControlActionAgent.instance:sendGetPostListRequest()
	end
end

function M:onExit()
	self:_handlePostClick(nil, false)
	IconLoader.clearSprite(self._headIcon)
	IconLoader.clearSprite(self._shareIcon)
	IconLoader.clearSprite(self._shareBigIcon)
end

function M:_refresh()
	if ControlActionUtil.isInGuide() then
		self._moList = ControlActionModel.instance:getGuideThemePostList()
	else
		self._moList = ControlActionModel.instance:getThemePostMoList()
	end

	goutil.clearChildren(self._themeListGo)

	for i, postMo in ipairs(self._moList) do
		local obj = goutil.clone(self._themePostItem, "item" .. i)

		goutil.setActive(obj, true)
		goutil.addChildToParent(obj, self._themeListGo)

		local view = Astral.LuaComponentContainer.Add(obj, ForumViewItem)

		view:refresh(postMo)
	end
end

function M:_handlePostClick(e, isOpen)
	goutil.setActive(self._themePostPanelGo, not isOpen)
	goutil.setActive(self._replyPanelGo, isOpen)
	goutil.setActive(self._btnTop.gameObject, isOpen)
end

function M:_handleReplyPost(e, themePostMo)
	self:_handlePostClick(nil, true)

	if ControlActionUtil.isInGuide() then
		self._replyPostMoList = ControlActionModel.instance:getGuideReplyPostList(themePostMo)
	else
		self._replyPostMoList = ControlActionModel.instance:getReplyPostMoList()
	end

	self:_setReplyMainPost(self._replyPostMoList[1])
	self:_clearChildren(self._replyListGo)

	for i = 2, #self._replyPostMoList do
		local obj = goutil.clone(self._replyPostItem, "item" .. i - 1)

		goutil.setActive(obj, true)
		goutil.addChildToParent(obj, self._replyListGo)

		local view = Astral.LuaComponentContainer.Add(obj, ForumReplyItem)
		local postMo = self._replyPostMoList[i]

		view:refresh(postMo)
	end

	Astral.TransformUtil.SetLocalPosY(self._replyPanelGo.transform.parent, 256)
	RectTransformUtils.ForceRebuildLayoutImmediate(self._replyPanelGo.transform)
end

function M:_setReplyMainPost(mainPostMo)
	self._mainPostMo = mainPostMo

	local themePostCo = ControlActionConfig.instance:getThemePostCfg(mainPostMo:getCode())
	local playerCo = mainPostMo:getPlayerCo()

	IconLoader.setSprite(self._headIcon, IconType.ControlActionHead, playerCo.icon)

	if themePostCo.theme_picture ~= "" then
		goutil.setActive(self._shareIcon.transform.parent.gameObject, true)
		IconLoader.setSprite(self._shareIcon, IconType.ControlActionBig, themePostCo.theme_picture)
		IconLoader.setSprite(self._shareBigIcon, IconType.ControlActionBig, themePostCo.theme_picture)
	else
		goutil.setActive(self._shareIcon.transform.parent.gameObject, false)
	end

	self._txtTitle.text = themePostCo.title
	self._txtName.text = playerCo.name
	self._txtLevel.text = string.format("[%s]", playerCo.levelDesc)

	local inAirtightTime, inTimeByItem, hour, minute, second, airtightEndTS = AirtightRoomController.instance:getAirtightTimeInfo(tonumber(mainPostMo:getTime()))
	local timestr = string.format("%s:%s:%s", ControlActionUtil.formatNumber(hour), ControlActionUtil.formatNumber(minute), ControlActionUtil.formatNumber(second))
	local isTop = ControlActionModel.instance:getThemePostIsTop(mainPostMo:getId())
	local isIn = AirtightRoomController.instance:getIsInAirtightTime()

	self._txtTime.text = timestr
	self._txtContent.text = themePostCo.content
	self._txtLikeCount.text = mainPostMo:getLikeCount()
	self._txtFloor.text = mainPostMo:getFloor() .. "F"

	goutil.setActive(self._likeFlagGo, mainPostMo:isLike())
	goutil.setActive(self._unlikeFlagGo, not mainPostMo:isLike())
	goutil.setActive(self._imgScretGo, isTop and isIn)
	goutil.setActive(self._imgNormalGo, isTop and not isIn)
end

function M:_clearChildren(container)
	local trs = container.transform
	local count = trs.childCount

	for i = count, 2, -1 do
		local child = trs:GetChild(i - 1)

		UnityEngine.GameObject.Destroy(child.gameObject)
	end
end

function M:_onClickToTop()
	local ease = DG.Tweening.Ease.Linear

	self._contentListGo.transform:DOLocalMoveY(256.5, 0.5):SetEase(ease):SetAutoKill(true)
end

function M:_onClickClose()
	self:_handlePostClick(nil, false)
	ViewMgr.instance:close(ViewName.ControlActionForum)
	GlobalDispatcher:dispatchEvent(EventType.CONTROLACTION_CLOSE, 2)
end

function M:_onClickSmall()
	ViewMgr.instance:close(ViewName.ControlActionForum)
end

function M:_onClickLike()
	if self._mainPostMo:isLike() then
		ControlActionAgent.instance:sendCancelLikePostRequest(self._mainPostMo:getId(), self._mainPostMo:getFloor())
	else
		ControlActionAgent.instance:sendLikePostRequest(self._mainPostMo:getId(), self._mainPostMo:getFloor())
	end
end

function M:_onClickImage()
	goutil.setActive(self._bigImageGo, true)
end

function M:_onCloseImage()
	goutil.setActive(self._bigImageGo, false)
end

function M:_refreshLike()
	self._txtLikeCount.text = self._mainPostMo:getLikeCount()

	goutil.setActive(self._likeFlagGo, self._mainPostMo:isLike())
	goutil.setActive(self._unlikeFlagGo, not self._mainPostMo:isLike())
end

function M:_onClickReturn()
	self:_handlePostClick(nil, false)

	if ControlActionUtil.isInGuide() then
		self:_refresh()
	else
		ControlActionAgent.instance:sendGetPostListRequest()
	end
end

function M:_onBeginDrag(evt)
	self._beginPosition:Set(0, 0)
	self._beginPosition:Add(evt.position)
end

function M:_onEndDrag(evt)
	if ControlActionUtil.isInGuide() then
		local position = evt.position
		local deltaY = position.y - self._beginPosition.y

		if deltaY >= 10 then
			if self._contentListGo.transform.localPosition.y >= 600 then
				GlobalDispatcher:dispatchEvent(EventType.SWIPE_FINISH_EVENT)
			end
		elseif deltaY <= -10 and self._contentListGo.transform.localPosition.y < 360 then
			GlobalDispatcher:dispatchEvent(EventType.SWIPE_FINISH_EVENT)
		end
	end
end

return M
