-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/authority/new/CharacterAuthorityUpgradeResultTips.lua

module("logic.extensions.charactersystem.view.authority.new.CharacterAuthorityUpgradeResultTips", package.seeall)

local M = class("CharacterAuthorityUpgradeResultTips", ViewComponent)

function M:buildUI()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Authority)

	self._btnClose = self:getBtnByPath("common_full_tips_bg/clickExit")
	self._imgLvPre = self:getImage("authority_upgrade_show_pane_copy_1625730507")
	self._imgLvNext = self:getImage("authority_upgrade_show_pane_copy_1075856297")
	self._attRoot = self:getUIComponent("authority_upgrade_show_pane_copy_98310397", UIComponentType.RectTransform)
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:destroyUI()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Authority)

	self._btnClose = nil
end

function M:onEnter()
	local info = self:getFirstParam()

	if not info then
		printError("info is null, auto close")
		self:close()

		return
	end

	self._openAniFinish = false

	self:setEvent(true)
	self:refreshView()
end

function M:onEnterFinished()
	ToolTipsMgr.showCharacterTopToast(lang("tip_authority_power_lv_unlock_success"), CommEnum.CharacterTopToastIcon.Succ, 1)
end

function M:onExit()
	self._openAniFinish = false

	self:setEvent(false)
end

function M:onExitFinished()
	GlobalDispatcher:dispatchEvent(EventType.HERO_POWER_UPGRADE_TIPS_CLOSE)
end

function M:setEvent(add)
	if add then
		self:registerLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
	else
		self:unregisterLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
	end
end

function M:_handleViewAniDoneEvent(key, tagName, reason)
	if tagName == "open" then
		self._openAniFinish = true
	end
end

function M:_onClickClose()
	if not self._openAniFinish then
		printWarn("open ani not finish, can not close")

		return
	end

	self:close()
end

function M:refreshView()
	local info = self:getFirstParam()
	local powerLvNext = math.ceil(info.nodeId / 5)
	local powerLvPre = powerLvNext > 1 and powerLvNext - 1 or powerLvNext

	IconLoader.setSprite(self._imgLvPre, IconType.Skinlib, CommEnum.AuthorityLv2NumIcon[powerLvPre])
	IconLoader.setSprite(self._imgLvNext, IconType.Skinlib, CommEnum.AuthorityLv2NumIcon[powerLvNext])

	local attDataLst = {}

	table.insert(attDataLst, {
		title = lang("tip_authority_upgrade_item_1"),
		content = info.powerLvUpNum
	})

	while self._attRoot.childCount < #attDataLst do
		goutil.cloneAndSetParent(self._attRoot:GetChild(0).gameObject, self._attRoot)
	end

	for i = 0, self._attRoot.childCount - 1 do
		local go = self._attRoot:GetChild(i).gameObject
		local data = attDataLst[i]
		local show = data ~= nil

		if show then
			local txtTitle = goutil.findChildTextComponent(go, "txtHint2")
			local txtContent = goutil.findChildTextComponent(go, "txtLevel")

			txtTitle.text = data.title
			txtContent.text = data.content
		end

		goutil.setActive(go, show)
	end
end

return M
