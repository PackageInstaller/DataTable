-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/PlayerSelectSkinView.lua

module("logic.extensions.playerinfo.view.info.PlayerSelectSkinView", package.seeall)

local M = class("PlayerSelectSkinView", ViewComponent)

function M:buildUI()
	self._skinScrollGo = self:getGo("player_select_skin_516858779")
	self._skinScroll = LoopListHelper.New(self._skinScrollGo)

	self._skinScroll:InitListView(0, self._updateCell, self)

	self._btnWear = self:getBtn("player_select_skin_286372588")
	self._btnBuy = self:getBtn("player_select_skin_727316238")
	self._buyInfoGo = self:getGo("player_select_skin_499991779")
	self._txtBuyCost = self:getText("player_select_skin_1486059728")
	self._gainTipGo = self:getGo("player_select_skin_909408518")
	self._txtGainTip = self:getText("player_select_skin_1645218798")
	self._usingTipsGo = self:getGo("player_select_skin_1804082410")
	self._txtDesc = self:getText("player_select_skin_495289591")
	self._txtName = self:getText("player_select_skin_-1753839420")
end

function M:bindEvents()
	self._btnWear:AddClickListener(self._onClickWear, self)
	self._btnBuy:AddClickListener(self._onClickBuy, self)
end

function M:unbindEvents()
	self._btnWear:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
end

function M:onEnter()
	local info = self:getFirstParam()

	self._callBackFunc = info.callBackFunc
	self._callBackHandle = info.callBackHandle
	self._curSkinId = info.skinId
	self._curHeroId = info.heroId
	self._curSelectSkin = info.skinId
	self._curSkinList = info.skinList
	self._index = 0
	self._curSkinMo = false

	for i = 1, #self._curSkinList do
		if self._curSkinList[i]:getId() == info.skinId then
			self._index = i

			break
		end
	end

	self._skinScroll:SetListItemCount(#self._curSkinList, true)
	self:_loadBottomInfo()
end

function M:onExit()
	self._skinScroll:ClearCells()
end

function M:destroyUI()
	self._skinScrollGo = nil

	self._skinScroll:Dispose()

	self._skinScroll = nil
	self._btnWear = nil
	self._btnBuy = nil
	self._buyInfoGo = nil
	self._txtBuyCost = nil
	self._gainTipGo = nil
	self._txtGainTip = nil
	self._usingTipsGo = nil
	self._txtDesc = nil
end

function M:_onClickWear()
	if self._callBackFunc then
		self._callBackFunc(self._callBackHandle, self._curSelectSkin)
	end

	self:close()
end

function M:_onClickBuy()
	if self._curNum < self._curNeedNum then
		FloatWordMgr.instance:show("道具不足")

		return
	end

	local dialog = Dialog.showMessage("提示", "确定购买皮肤？")

	dialog:setConfirmListener(self._onSendBuySkin, self)
end

function M:_onSendBuySkin()
	printWarn("直接购买功能已删除, 请打开商城来购买")
end

function M:_loadBottomInfo()
	local skinMo = HeroSkinModel.instance:getSkinMo(self._curHeroId, self._curSelectSkin)

	if not skinMo then
		return
	end

	self._curSkinMo = skinMo
	self._txtName.text = skinMo:getName()

	local heroMO = HeroDepotModel.instance:getHeroInfoByID(self._curHeroId)

	if heroMO then
		self._txtDesc.text = string.format(skinMo:getDesc(), heroMO:getName())
	end

	local isWear = self._curSkinId == self._curSelectSkin

	if isWear then
		goutil.setActive(self._usingTipsGo, true)
		goutil.setActive(self._btnWear.gameObject, false)
		goutil.setActive(self._buyInfoGo, false)
		goutil.setActive(self._gainTipGo, false)

		self._txtGainTip.text = ""
	elseif skinMo:getIsUnlock() then
		goutil.setActive(self._usingTipsGo, false)
		goutil.setActive(self._btnWear.gameObject, true)
		goutil.setActive(self._buyInfoGo, false)

		self._txtGainTip.text = ""

		goutil.setActive(self._gainTipGo, false)
	else
		goutil.setActive(self._usingTipsGo, false)
		goutil.setActive(self._btnWear.gameObject, false)

		if skinMo:getType() == 3 then
			self._txtGainTip.text = ""

			goutil.setActive(self._gainTipGo, false)

			self._curNum = 0
			self._curNeedNum = 0

			goutil.setActive(self._buyInfoGo, true)

			if skinMo:getCost() then
				for _, v in pairs(skinMo:getCost()) do
					if _ == 1 then
						self._curNeedNum = v.num
						self._curNum = ItemModel.instance:getItemCountByItemId(v.id)
						self._txtBuyCost.text = string.format("<color=%s>%s</color>", self:_getColor(self._curNum, self._curNeedNum), self._curNeedNum)

						local itemCo = BackpackConfig.instance:getItemInfoByItemId(v.id)
						local showType = self:_getMoneyShowType(v.id)
						local moneyInfo = MoneyUtil.getMoneyInfoByShowType(showType)

						for k, v in ipairs(moneyInfo.moneyCodes) do
							IconLoader.setSprite(self._imgCostIcon, IconType.Skinlib, v.src)
						end

						GlobalDispatcher:dispatchEvent(EventType.SET_TOP_COST_STATE_EVENT, true, showType)

						break
					end
				end
			elseif enableErrorLog then
				printError("商店类型皮肤未配置价格")
			end
		else
			goutil.setActive(self._gainTipGo, true)
			goutil.setActive(self._buyInfoGo, false)

			self._txtGainTip.text = skinMo:getWayDesc()
		end
	end
end

function M:_getColor(cur, need)
	return need <= cur and "#EEEEEE" or "#FF0000"
end

function M:_updateCell(curIndex)
	if curIndex < 0 then
		return nil
	end

	curIndex = curIndex + 1

	local item = self._skinScroll:NewListViewItem("player_skin_item")

	if self._curSkinList then
		local itemData = self._curSkinList[curIndex]

		if itemData then
			local shower = Astral.LuaComponentContainer.Add(item.gameObject, PlayerSkinItem)

			shower:setCellData(itemData, curIndex, self._curSkinId, self._curSelectSkin)
			shower:setClick(self._clickSkin, self)
		end
	end

	return item
end

function M:_clickSkin(skinId)
	self._curSelectSkin = skinId

	self._skinScroll:RefreshAllShownItem()
	self:_loadBottomInfo()
end

return M
