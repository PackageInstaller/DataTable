-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/view/new/CharacterHeartAnchorImpressionUpgradeResultTips.lua

module("logic.extensions.characterinformation.view.new.CharacterHeartAnchorImpressionUpgradeResultTips", package.seeall)

local M = class("CharacterHeartAnchorImpressionUpgradeResultTips", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtnByPath("common_full_tips_bg/clickExit")

	goutil.setActive(self._btnClose.gameObject, false)

	self._txtLvBefore = self:getText("heart_anchor_upgrade_tips_-887920709")
	self._txtLvAfter = self:getText("heart_anchor_upgrade_tips_342473912")
	self._rootUnlock = self:getUIComponent("heart_anchor_upgrade_tips_33538128", UIComponentType.RectTransform)
	self._goUnlockItem = self:getGo("heart_anchor_upgrade_tips_1295353289")

	goutil.setActive(self._goUnlockItem, false)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter(reasonType)
	self:setEvent(true)

	local info = self:getFirstParam()
	local lvBefore = info.lvBefore
	local lvAfter = info.lvAfter
	local heroData = HeroDepotModel.instance:getHeroInfoByID(info.heroId)

	if not heroData then
		self:close()

		return
	end

	self._heroId = info.heroId
	self._isPlaying = true
	self._txtLvBefore.text = lvBefore
	self._txtLvAfter.text = lvAfter

	self:_refreshUnlockItems(lvBefore, lvAfter)
end

function M:onEnterFinished()
	return
end

function M:onExit(reasonType)
	self:setEvent(false)
end

function M:onExitFinished()
	TacitModel.instance:popCacheItemMoList()
end

function M:setEvent(add)
	if add then
		self:registerLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
	else
		self:unregisterLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._handleViewAniDoneEvent, self)
	end
end

function M:_handleViewAniDoneEvent(key, tagName, reason)
	self._isPlaying = false
end

function M:_onClickClose()
	if self._isPlaying then
		printWarn("正在演出，不能关闭")

		return
	end

	self:close()
end

function M:_refreshUnlockItems(lvBefore, lvAfter)
	local unlockLst = CharacterUnlockContentConfig.instance:getFavorUnlockIds(self._heroId, lvAfter, lvBefore)

	if Astral.OSDef.isEditor then
		TableUtil.dump(unlockLst)
	end

	while self._rootUnlock.childCount < #unlockLst do
		local go = goutil.cloneAndSetParent(self._goUnlockItem, self._rootUnlock)
	end

	for i = 0, self._rootUnlock.childCount - 1 do
		local show = i < #unlockLst
		local go = self._rootUnlock:GetChild(i)

		goutil.setActive(go.gameObject, show)

		if show then
			local id = unlockLst[i + 1]
			local strName = ""
			local prefix = lang("tip_tacit_upgrade_item_prefix_info")

			if id > 3000 then
				local cfg = CharacterAudioConfig.instance:getCharacterAudioCOByHeroIdAndAudioId(self._heroId, id - 3000)

				strName = cfg and cfg.audioName or ""
				prefix = lang("tip_tacit_upgrade_item_prefix_voice")
			elseif id > 100 and id < 200 then
				local spfile = PastInfoConfig.instance:getCharacterInfoSpfile(self._heroId, id)

				strName = spfile and spfile.title or ""
			elseif id > 200 and id < 300 then
				local cfg = PastInfoConfig.instance:getInfo(id)

				strName = cfg and cfg.name or ""
			elseif id < 100 then
				local cfg = PastInfoConfig.instance:getInfo(id)

				strName = cfg and cfg.name or ""
			end

			local txtName = goutil.findChildTextComponent(go, "txtAttribute")

			if string.nilorempty(strName) then
				txtName.text = strName
			else
				txtName.text = string.format("%s-%s", prefix, strName)
			end
		end
	end
end

return M
