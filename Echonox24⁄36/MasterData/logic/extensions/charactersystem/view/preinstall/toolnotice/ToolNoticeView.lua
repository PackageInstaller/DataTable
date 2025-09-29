-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preinstall/toolnotice/ToolNoticeView.lua

module("logic.extensions.charactersystem.view.preinstall.toolnotice.ToolNoticeView", package.seeall)

local M = class("ToolNoticeView", ViewComponent)

CharacterPreinstallEnum = {
	Delete = 1,
	Replace = 2
}

function M:buildUI()
	local param = self:getOpenParam()

	self._curEnum = param[1]
	self._preinstallTempList = param[2]
	self._handler = param[3]
	self._tips = param[4]
	self._preinstallList = {}
	self._preinstallNoticMoList = {}
	self._clickReturn = self:getBtn("1&universal_second_tips_common_bg_-1467035629")
	self._btnReturn = self:getBtn("1&universal_second_tips_common_bg_1201003252")
	self._clickNo = self:getBtn("5&btn_left_-1571983320")
	self._clickYes = self:getBtn("6&btn_right_1251431307")
	self._textNotic = self:getText("preset_notice_tips_2064853081")
	self._tempScroll = self:getGo("preset_notice_tips_1690136938")
	self._content = self:getGo("preset_notice_tips_-2142345728")
	self._contentRect = self:getRectTransform("preset_notice_tips_-2142345728")
	self._loopList = LoopListHelper.New(self._tempScroll)

	self._loopList:InitListView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	self._curEnum = nil
	self._preinstallTempList = nil
	self._handler = nil
	self._preinstallList = nil
	self._clickReturn = nil
	self._btnReturn = nil
	self._textNotic = nil

	self._loopList:Dispose()

	self._loopList = nil
	self._content = nil
	self._contentRect = nil
end

function M:onEnter()
	self:setEvent(true)
	self._loopList:ClearCells(true)
	self:onInitList()
end

function M:onExit()
	self:setEvent(false)
end

function M:bindEvents()
	self._clickReturn:AddClickListener(self._onClickClose, self)
	self._btnReturn:AddClickListener(self._onClickClose, self)
	self._clickNo:AddClickListener(self._onClickClose, self)
	self._clickYes:AddClickListener(self.openResolveItemTips, self)
end

function M:unbindEvents()
	self._clickReturn:RemoveClickListener()
	self._btnReturn:RemoveClickListener()
	self._clickNo:RemoveClickListener()
	self._clickYes:RemoveClickListener()
end

function M:_onClickClose()
	self:back()
end

function M:openResolveItemTips()
	self._handler:_confirmCallbackPreinstall()
	self:_onClickClose()
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:_handleItemChangedPush(e, msg)
	if msg and msg.optType == GameEnum.OptionType.ITEM_LOCK then
		self:refreshPreinstallLoopList()
	end
end

function M:onInitList()
	self:setNoticeText()
	self:setPreinstallList()
	self:refreshPreinstallLoopList()
	self:_setScrollMiddle()
end

function M:setNoticeText()
	if self._tips then
		self._textNotic.text = self._tips

		return
	end

	if self._curEnum == 1 then
		self._textNotic.text = lang("tip_character_preinstall_notice_deleted")
	elseif self._curEnum == 2 then
		self._textNotic.text = lang("tip_character_preinstall_notice_replace")
	end
end

function M:setPreinstallList()
	if self._preinstallTempList and #self._preinstallTempList ~= 0 then
		self._preinstallList = {}

		if self._curEnum == CharacterPreinstallEnum.Delete then
			for k, v in pairs(self._preinstallTempList) do
				local itemPrinstallList = CharacterPreinstallController.instance:getItemList(v:getUuid())

				if itemPrinstallList then
					self:setPreinstallListItemDelete(v:getUuid(), itemPrinstallList)
				end
			end

			self:setPreinstallNoticeMoList()
		elseif self._curEnum == CharacterPreinstallEnum.Replace then
			for k, v in pairs(self._preinstallTempList) do
				self:setPreinstallListItemReplace(v)
			end
		end
	end
end

function M:setPreinstallListItemDelete(uuid, itemPrinstallList)
	for k, v in ipairs(itemPrinstallList) do
		if self._preinstallList[v.id] == nil then
			local info = {}

			info.name = v.name
			info.heroId = v.hero

			local tempTable = {}

			tempTable[1] = uuid
			info.uuidList = tempTable
			self._preinstallList[v.id] = info
		else
			local length = #self._preinstallList[v.id].uuidList

			self._preinstallList[v.id].uuidList[length + 1] = uuid
		end
	end
end

function M:setPreinstallNoticeMoList()
	local count = 0
	local tempcount = 0
	local temp = {}

	for k, v in pairs(self._preinstallList) do
		tempcount = tempcount + 1

		table.sort(v.uuidList, function(a, b)
			local equip_a = ItemModel.instance:getItemDataByUuid(a)
			local equip_b = ItemModel.instance:getItemDataByUuid(b)
			local position_a = equip_a:getPart()
			local position_b = equip_b:getPart()

			if position_a < position_b then
				return true
			end

			return false
		end)

		temp[tempcount] = v
	end

	table.sort(temp, function(a, b)
		if a.heroId < b.heroId then
			return true
		end

		return false
	end)

	for k, v in ipairs(temp) do
		local tempTable = {}

		tempTable.name = v.name
		tempTable.heroId = v.heroId
		tempTable.list = v.uuidList

		local noticeMo = ToolNoticemMo.New()

		noticeMo:setItemMo(tempTable)

		count = count + 1
		self._preinstallNoticMoList[count] = noticeMo
	end
end

function M:setPreinstallListItemReplace(info)
	local isExitList = false

	for k, v in ipairs(self._preinstallNoticMoList) do
		if v:getHeroId() == info.heroID then
			v:addCellList(info.itemUuid)

			isExitList = true

			break
		end
	end

	if not isExitList then
		local length = #self._preinstallNoticMoList
		local tempTable = {}
		local heroData = HeroDepotModel.instance:getHeroInfoByID(info.heroID)

		if heroData then
			tempTable.name = heroData:getName()
			tempTable.heroId = info.heroID
			tempTable.list = {}

			local noticeMo = ToolNoticemMo.New()

			noticeMo:setItemMo(tempTable)
			noticeMo:addCellList(info.itemUuid)

			self._preinstallNoticMoList[length + 1] = noticeMo
		end
	end
end

function M:refreshPreinstallLoopList()
	local count = self._preinstallNoticMoList and #self._preinstallNoticMoList or 0

	self._loopList:ClearCells()
	self._loopList:SetListItemCount(count, false)
	self._loopList:RefreshAllShownItem()
end

function M:_onCellUpdate(curIndex, row, column)
	curIndex = #self._preinstallNoticMoList - curIndex

	local class = ToolNoticeItemCell
	local item = self._loopList:NewListViewItem("presetItem")
	local noticeMo = self._preinstallNoticMoList[curIndex]
	local shower = Astral.LuaComponentContainer.Get(item.gameObject, class)

	shower = shower or Astral.LuaComponentContainer.Add(item.gameObject, class)

	shower:updateData(noticeMo)

	return item
end

function M:_setScrollMiddle()
	if self._content then
		RectTransformUtils.ForceRebuildLayoutImmediate(self._contentRect)

		local itemSum = 0
		local cellSum = 0
		local widthSum = 0

		for k, v in ipairs(self._preinstallNoticMoList) do
			itemSum = itemSum + 1
			cellSum = cellSum + v:getCellListSize()
		end

		if itemSum <= 2 and cellSum <= 5 then
			for i = 1, self._content.transform.childCount - 1 do
				local childObj = self._content.transform:GetChild(i).gameObject
				local width = RectTransformUtils.GetWidth(childObj.transform)

				widthSum = widthSum + width
			end

			RectTransformUtils.SetWidth(self._tempScroll.transform, widthSum)
		end
	end
end

return M
