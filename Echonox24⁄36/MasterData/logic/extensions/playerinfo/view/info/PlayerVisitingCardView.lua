-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/PlayerVisitingCardView.lua

module("logic.extensions.playerinfo.view.info.PlayerVisitingCardView", package.seeall)

local M = class("PlayerVisitingCardView", DynamicFragmentView)

function M:buildUI()
	self._scrollView = LoopGridViewHelper.New(self:getGo("player_visiting_card_panel_664470090"))

	self._scrollView:InitGridView(0, self._updateData, self)

	self._imgHeadIcon = self:getImage("1&0&head_item_1770823988")
	self._imgHeadIconCard = self:getImage("3&head_item_1770823988")
	self._txtName = self:getText("1&player_info_preview_tips_1879998473")
	self._txtNameCard = self:getText("player_visiting_card_panel_-945647324")
	self._txtDesc = self:getText("1&player_info_preview_tips_1818738736")
	self._txtUnlockDesc = self:getText("1&player_info_preview_tips_1221177753")
	self._txtHeadIconName = self:getText("1&player_info_preview_tips_181164354")
	self._lockObj = self:getGo("1&0&head_item_-765526646")
	self._imgCard = self:getImage("1&player_info_preview_tips_1101775695")
	self._imgCardSpecial = self:getImage("player_visiting_card_panel_-2059000608")
	self._imgEffect = self:getImage("player_visiting_card_panel_289420910")
	self._guiAnimation = goutil.addComponentOnce(self._registry:getMainGO(), typeof(Astral.GUITimelineAniLua))

	goutil.setActive(self._lockObj, false)
end

function M:destroyUI()
	self._scrollView:Dispose()

	self._scrollView = nil
	self._imgHeadIcon = nil
	self._imgHeadIconCard = nil
	self._txtName = nil
	self._txtNameCard = nil
	self._txtDesc = nil
	self._txtUnlockDesc = nil
	self._txtHeadIconName = nil
	self._imgCard = nil
	self._imgCardSpecial = nil
end

function M:bindEvents()
	GlobalDispatcher:addEventListener(EventType.CHANGE_PLAYER_DISPLAYCARD_SUC, self._onChangeDisplayCardSuc, self)
end

function M:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.CHANGE_PLAYER_DISPLAYCARD_SUC, self._onChangeDisplayCardSuc, self)
end

function M:onEnter()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")

	local playerInfo = PlayerModel.instance:getPlayerCardInfo()

	self._txtName.text = PlayerModel.instance:getNickName()
	self._txtNameCard.text = PlayerModel.instance:getNickName()

	local cardCO = BackpackConfig.instance:getItemInfoByItemId(playerInfo.portrait)

	if cardCO then
		IconLoader.setSprite(self._imgHeadIcon, IconType.HeadIcon, cardCO.icon)
		IconLoader.setSprite(self._imgHeadIconCard, IconType.HeadIcon, cardCO.icon)
	end

	self._playerInfo = playerInfo
	self._curallCardList = {}
	self._curSelectCardId = playerInfo.displayCard

	self:_initPortraitData()
	self:_loadRightData(self._curSelectCardId)
	self._scrollView:SetListItemCount(#self._curallCardList, true)
end

function M:playDynamicPageTimeLineAni(animName)
	if self.mainGO.activeSelf and self._guiAnimation then
		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:PlayAniByName(animName)
	end
end

function M:onExit()
	self._scrollView:ClearCells()
	table.clear(self._curallCardList)
end

function M:_initPortraitData()
	local allPortraitMap = BackpackConfig.instance:getItemsInfoByTS(GameEnum.ItemTypeEnum.DisplayCard, 1)

	for _, v in pairs(allPortraitMap) do
		table.insert(self._curallCardList, {
			isUnlock = false,
			id = v.id,
			cfgdata = v
		})
	end

	local _curPortraitList = ItemModel.instance:getItemsByTS(GameEnum.ItemTypeEnum.DisplayCard, 1)

	if _curPortraitList then
		for i = 1, #_curPortraitList do
			for j = 1, #self._curallCardList do
				if _curPortraitList[i]:getItemId() == self._curallCardList[j].id then
					self._curallCardList[j].isUnlock = true
				end
			end
		end
	end

	table.sort(self._curallCardList, PlayerViewsUtil.sort)
end

function M:_loadRightData(cardId)
	local cardCO = BackpackConfig.instance:getItemInfoByItemId(cardId)

	if cardCO then
		IconLoader.setSprite(self._imgCard, IconType.PlayerCardMedium, cardCO.icon)
		IconLoader.setSprite(self._imgCardSpecial, IconType.PlayerCardSpecial1, cardCO.icon)
		IconLoader.setSprite(self._imgEffect, IconType.PlayerCardSpecial1, cardCO.icon)

		self._txtDesc.text = cardCO.desc
		self._txtUnlockDesc.text = cardCO.unlockdesc

		local isUsing = self._playerInfo.displayCard == cardId
		local isLock = false

		for i = 1, #self._curallCardList do
			if self._curallCardList[i].id == cardId then
				isLock = not self._curallCardList[i].isUnlock

				break
			end
		end

		self._txtHeadIconName.text = cardCO.name
	end

	table.sort(self._curallCardList, PlayerViewsUtil.sort)
end

function M:_updateData(curIndex)
	if curIndex < 0 then
		return nil
	end

	curIndex = curIndex + 1

	local item = self._scrollView:NewListViewItem("visiting_card_item")

	if self._curallCardList then
		local itemData = self._curallCardList[curIndex]

		if itemData then
			local shower = Astral.LuaComponentContainer.Add(item.gameObject, PlayerDisplayCardItem)

			shower:setCellData(itemData, curIndex, self._playerInfo.displayCard, self._curSelectCardId)
			shower:setClick(self._clickIcon, self)
		end
	end

	return item
end

function M:_onClickUse()
	if self._curSelectCardId ~= self._playerInfo.displayCard then
		PlayerAgent.instance:sendChangeDisplayCardRequest(self._curSelectCardId)
	end
end

function M:_clickIcon(cardId)
	if self._curSelectCardId == cardId then
		return
	end

	self._curSelectCardId = cardId

	self:_loadRightData(self._curSelectCardId)

	if self._scrollView then
		self._scrollView:RefreshAllShownItem()
	end

	self:_onClickUse()
end

function M:_onChangeDisplayCardSuc(key, displayCard)
	self._playerInfo.displayCard = displayCard

	self:_loadRightData(displayCard)

	if self._scrollView then
		self._scrollView:RefreshAllShownItem()
	end
end

return M
