-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/view/new/CharacterHeartAnchorCarryItemInfoTips.lua

module("logic.extensions.characterinformation.view.new.CharacterHeartAnchorCarryItemInfoTips", package.seeall)

local M = class("CharacterHeartAnchorCarryItemInfoTips", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtnByPath("middle_tips_common_bg/clickExit")
	self._btnClose2 = self:getBtnByPath("middle_tips_common_bg/btnClose")
	self._txtTitle = self:getUIComponent("carryitem_info_tips_678500947", UIComponentType.TextMeshProUGUI)
	self._txtName = self:getUIComponent("carryitem_info_tips_-1174688457", UIComponentType.TextMeshProUGUI)
	self._imgIcon = self:getImage("carryitem_info_tips_-445439387")
	self._scroll = self:getUIComponent("carryitem_info_tips_-1813903675", UIComponentType.ScrollRect)
	self._txtContent = self:getUIComponent("carryitem_info_tips_1484817841", UIComponentType.TextMeshProUGUI)
	self._txtContentDetail = self:getUIComponent("carryitem_info_tips_657792707", UIComponentType.TextMeshProUGUI)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnClose2:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnClose2:RemoveClickListener()
end

function M:onEnter(reasonType)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_HeartAnchor)
	self:setEvent(true)

	local info = self:getFirstParam()
	local heroId = info.heroId
	local itemId = info.carryItemId

	printWarn(heroId, itemId)

	local cfg = CharacterUnlockContentConfig.instance:getCarryItem(heroId, itemId)

	if not cfg then
		self:close()

		return
	end

	CharacterInformationModel.instance:setReadPastInfo(heroId, itemId)

	local imgPath = cfg.icon

	if not string.nilorempty(imgPath) then
		IconLoader.setSprite(self._imgIcon, IconType.CharacterHeartAnchorCarryItem, imgPath)
	end

	local name = cfg.name

	name = StringUtil.replaceTMPBlackBlock(name)
	self._txtTitle.text = name
	self._txtName.text = name

	local descStr = cfg.desc

	if not string.nilorempty(descStr) then
		descStr = StringUtil.replaceAllRed(descStr)
		descStr = StringUtil.replaceAllSup(descStr)
		descStr = StringUtil.replaceTMPBlackBlock(descStr)
	end

	self._txtContent.text = descStr

	local detailStr = cfg.detail

	if not string.nilorempty(detailStr) then
		detailStr = StringUtil.replaceAllRed(detailStr)
		detailStr = StringUtil.replaceAllSup(detailStr)
		detailStr = StringUtil.replaceTMPBlackBlock(detailStr)
		detailStr = self:_addLineFeed(detailStr)
	end

	self._txtContentDetail.text = detailStr
	self._scroll.verticalNormalizedPosition = 1
end

function M:onEnterFinished()
	return
end

function M:onExit(reasonType)
	self:setEvent(false)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_HeartAnchor)
end

function M:onExitFinished()
	return
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:_onClickClose()
	self:close()
end

function M:_addLineFeed(str)
	if string.nilorempty(str) then
		return str
	end

	local returnStr = string.gsub(str, "\r\n\r\n", "&&&&&")

	returnStr = string.gsub(returnStr, "\r\n", "\r\n\n")
	returnStr = string.gsub(returnStr, "&&&&&", "\r\n\n")

	return returnStr
end

return M
