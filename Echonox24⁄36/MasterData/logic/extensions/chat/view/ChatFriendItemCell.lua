-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/view/ChatFriendItemCell.lua

module("logic.extensions.chat.view.ChatFriendItemCell", package.seeall)

local M = class("ChatFriendItemCell")

function M:ctor(go)
	self._go = go
	self._registry = ViewElementsRegistry.New(go)

	self:_buildUI()
end

function M:_buildUI()
	self._imgDressUp = self:getImage("private_chat_item_-166302240")
	self._imgHeadIcon = self:getImage("0&head_item_1770823988")
	self._txtName = self:getText("private_chat_item_1051292601")
	self._txtRemark = self:getText("private_chat_item_1360291413")
	self._txtDesc = self:getText("private_chat_item_151876372")
	self._type1Go = self:getGo("private_chat_item_-1052306883")
	self._type2Go = self:getGo("private_chat_item_949235205")
	self._txtState = self:getText("private_chat_item_879343723")
	self._btnClick = self:getBtn("0&head_item_-759026212")
	self._btnClickItem = self:getBtn("private_chat_item_1491185796")

	local headLockGo = self:getGo("head_item_-765526646")

	headLockGo:SetActive(false)

	local redPointGo = self:getGo("1&red_point_-1414002736")

	redPointGo:SetActive(false)
	self:_bindEvents()
end

function M:_bindEvents()
	self._btnClick:AddClickListener(self._onClickBtnClick, self)
	self._btnClickItem:AddClickListener(self._onClickBtnClick, self)
end

function M:_unbindEvents()
	self._btnClick:RemoveClickListener()
	self._btnClickItem:RemoveClickListener()
end

function M:updateData(data)
	self._data = data

	local alias = data:getAlias()
	local itemCo = BackpackConfig.instance:getItemInfoByItemId(data:getPortrait())

	IconLoader.setSprite(self._imgHeadIcon, IconType.HeadIcon, itemCo.icon)

	self._txtName.text = data:getNickName()
	self._txtRemark.text = alias

	if not string.nilorempty(alias) then
		goutil.setActive(self._txtName.gameObject, false)
		goutil.setActive(self._txtRemark.gameObject, true)
	else
		goutil.setActive(self._txtName.gameObject, true)
		goutil.setActive(self._txtRemark.gameObject, false)
	end

	self._txtDesc.text = ""

	local content = data:getLastContent()

	ChatUtil.adaptForFixedWidth(self._txtDesc, content)

	local visitCardCO = BackpackConfig.instance:getItemInfoByItemId(data:getCard())

	if visitCardCO then
		IconLoader.setSprite(self._imgDressUp, IconType.PlayerCardSpecial1, visitCardCO.icon)
	end

	self._type1Go:SetActive(false)
	self._type2Go:SetActive(false)

	local lastLoginTime = data:getLastLoginTime()

	if lastLoginTime > 0 then
		self._type2Go:SetActive(true)

		local curTime = ServerTime.now() * 1000
		local offset = curTime - lastLoginTime
		local pastTimeStr = TextFormatter.formatFullPastTime(offset / 1000)

		if string.nilorempty(pastTimeStr) then
			pastTimeStr = lang("tip_one_minute_before")
		end

		self._txtState.text = pastTimeStr

		local grayMat = CommonPreloader.instance:getMaterialsCommAsset(CommonResPath.UIGray)

		self._imgHeadIcon.material = grayMat
	else
		self._type1Go:SetActive(true)

		self._imgHeadIcon.material = nil
	end
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self:_unbindEvents()
end

function M:_onClickBtnClick()
	local channelType = GameEnum.ChannelTypeEnum.Friend
	local targetId = self._data:getUserId()
	local params = {}

	params.index = channelType
	params.targetId = targetId

	GlobalDispatcher:dispatchEvent(EventType.CHAT_ENTER_PRIVATE, params)
end

return M
