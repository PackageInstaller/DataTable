-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/forum/ForumReplyItem.lua

module("logic.extensions.controlaction.view.forum.ForumReplyItem", package.seeall)

local M = class("ForumReplyItem")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()
end

function M:_buildUI()
	self._headIcon = goutil.findChildImageComponent(self._mainGo, "content1/headIcon")
	self._txtName = goutil.findChildTextComponent(self._mainGo, "content1/txtName")
	self._txtLevel = goutil.findChildTextComponent(self._mainGo, "content1/txtLevel")
	self._txtTime = goutil.findChildTextComponent(self._mainGo, "content1/txtTime")
	self._txtFloor = goutil.findChildTextComponent(self._mainGo, "content1/txtFloor")
	self._txtContent = goutil.findChildTextComponent(self._mainGo, "txtContent")
	self._txtLikeCount = goutil.findChildComponent(self._mainGo, "bottom/txtGoodNum", UIComponentType.TextMeshProUGUI)
	self._btnClick = Astral.ButtonAdapter.Get(goutil.findChild(self._mainGo, "bottom/btnGood"))
	self._likeFlagGo = goutil.findChild(self._mainGo, "bottom/btnGood/type1")
	self._unlikeFlagGo = goutil.findChild(self._mainGo, "bottom/btnGood/type2")

	self:_bindEvents()
end

function M:_bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
	GlobalDispatcher:addEventListener(EventType.CONTROLACTION_FORUM_POSTLIKE, self._refreshLike, self)
end

function M:_unbindEvents()
	self._btnClick:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.CONTROLACTION_FORUM_POSTLIKE, self._refreshLike, self)
end

function M:_onClick()
	if self._replyPostMo:isLike() then
		ControlActionAgent.instance:sendCancelLikePostRequest(self._replyPostMo:getId(), self._replyPostMo:getFloor())
	else
		ControlActionAgent.instance:sendLikePostRequest(self._replyPostMo:getId(), self._replyPostMo:getFloor())
	end
end

function M:refresh(data)
	self._replyPostMo = data

	local postCo = self._replyPostMo:getReplyPostCo()
	local playerCo = self._replyPostMo:getPlayerCo()

	IconLoader.setSprite(self._headIcon, IconType.ControlActionHead, playerCo.icon)

	self._txtName.text = playerCo.name
	self._txtLevel.text = string.format("[%s]", playerCo.levelDesc)
	self._txtContent.text = postCo.desc
	self._txtTime.text = ControlActionUtil.getTimeStr(self._replyPostMo:getTime())
	self._txtFloor.text = self._replyPostMo:getFloor() .. "F"

	self:_refreshLike()
end

function M:_refreshLike()
	self._txtLikeCount.text = self._replyPostMo:getLikeCount()

	goutil.setActive(self._likeFlagGo, self._replyPostMo:isLike())
	goutil.setActive(self._unlikeFlagGo, not self._replyPostMo:isLike())
end

function M:OnDestroy()
	self:_unbindEvents()
	IconLoader.clearSprite(self._headIcon)
end

return M
