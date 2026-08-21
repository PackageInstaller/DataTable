-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataShop.lua

local ResOpActivityShopDetail = require("ClientData/ResOpActivityShopDetail")
local ResOpActivityShopMisc = require("ClientData/ResOpActivityShopMisc")
local ResOpActivityShopLevel = require("ClientData/ResOpActivityShopLevel")
local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResOpActivityConditionLimit = require("ClientData/ResOpActivityConditionLimit")
local ResShopExchg = require("ClientData/ResShopExchg")
local ShopItem = require("UI/MainState/Trade/ShopItem")
local ActivityDataShop = Class("ActivityDataShop", ActivityDataBase)

function ActivityDataShop:ctor()
	self.serverData = {}
	self.shopLevel = 0
end

function ActivityDataShop:updateClientData(actId)
	self.actId = actId
	self.clientData = ResOpActivityShopDetail[actId] or {}
	self.indexData = {}
	self.miscData = ResOpActivityShopMisc[actId]

	if self.miscData then
		self.maxRound = self.miscData.max_round
	end

	self.shopItemMaxRound = 0

	for exchgid, data in pairs(self.clientData) do
		if data.index then
			self.indexData[data.index] = data
		end

		if (data.round or 0) > self.shopItemMaxRound then
			self.shopItemMaxRound = data.round
		end
	end

	self.shopLevelDetailData = ResOpActivityShopLevel[actId]

	self:checkLinkedShop()
end

function ActivityDataShop:updateRoleData(roleData)
	self.serverData = {}

	local svrData = roleData.shop.item

	if svrData then
		for idx, data in ipairs(svrData) do
			self.serverData[data.exchgid] = data.counter
		end
	end

	self.nowRealRound = roleData.shop.round or 0
	self.nowRound = math.min(self.shopItemMaxRound, roleData.shop.round or 0)
	self.shopLevel = roleData.shop.level
	self.shopLevelProgress = roleData.shop.item_cost
end

function ActivityDataShop:linkedHasNew()
	local hasNum = CurAvatar:getItemNumById(self.miscData.item_id)
	local linkNeedMaxNum = 0

	for _, exchgid in ipairs(self.linkedNodes) do
		local nowNode = self:getNowLinkedNode(exchgid)

		if nowNode then
			linkNeedMaxNum = math.max(linkNeedMaxNum, self:itemCostNum(nowNode))
		end
	end

	if linkNeedMaxNum > 0 then
		if linkNeedMaxNum <= hasNum then
			return true
		else
			return false
		end
	end

	return nil
end

function ActivityDataShop:checkNew()
	if self.miscData.check_version and VersionUtils.getEngineVersion() <= self.miscData.check_version then
		return false
	end

	if self.miscData and self.miscData.item_id then
		local hasNum = CurAvatar:getItemNumById(self.miscData.item_id)

		if self.hasLinkShop then
			local linkedHasNew = self:linkedHasNew()

			if linkedHasNew ~= nil then
				return linkedHasNew
			end
		end

		if self.miscData.rd_item_num and hasNum >= self.miscData.rd_item_num then
			return true
		end
	end

	if self.shopLevelDetailData then
		for level, levelData in ipairs(self.shopLevelDetailData) do
			if level > self.shopLevel then
				if (self.shopLevelProgress or 0) >= levelData.up_need then
					return true
				else
					return false
				end
			end
		end
	end

	return false
end

function ActivityDataShop:getHasBuyNum(exchgid)
	local counter = self.serverData[exchgid]

	if counter and ClientUtils.getServerTime() < counter.next_reset_time then
		return counter.count
	end

	return 0
end

function ActivityDataShop:boughtOver(exchgid)
	return self:getHasBuyNum(exchgid) >= ResShopExchg[exchgid].exchgmax
end

function ActivityDataShop:itemCostNum(exchgid)
	local data = ResShopExchg[exchgid]

	return data.use[1].discount or 1
end

local function sortGroupFunc(a, b)
	if a:isSoldOut() and not b:isSoldOut() then
		return false
	elseif b:isSoldOut() and not a:isSoldOut() then
		return true
	end

	if a.shopLevel ~= b.shopLevel then
		return a.shopLevel > b.shopLevel
	else
		return a.index < b.index
	end
end

function ActivityDataShop:getCurShopItem()
	local nowItems = {}

	for exchgid, data in pairs(self.clientData) do
		if (self.nowRound or 0) == (data.round or 0) and (self.shopLevel or 0) >= (data.level or 0) then
			local hasBuy = self:getHasBuyNum(exchgid)
			local shopItem = self:_createItemInfo(0, exchgid, hasBuy)

			if shopItem then
				shopItem.index = data.index or 0

				table.insert(nowItems, shopItem)

				shopItem.shopLevel = data.level or 0
			end
		end
	end

	table.sort(nowItems, sortGroupFunc)

	return nowItems
end

function ActivityDataShop:_createItemInfo(shopID, shopItemID, hasBoughtNum, ignorCondition)
	if ResShopExchg[shopItemID] then
		if not ignorCondition and ResShopExchg[shopItemID].condition_id and ConditionLimitManager.inLimitState(ResShopExchg[shopItemID].condition_id) then
			return nil
		end

		return ShopItem(shopID, shopItemID, hasBoughtNum, nil, self.actId)
	end
end

function ActivityDataShop:isCurRoundBuyOver()
	for exchgid, data in pairs(self.clientData) do
		if (self.nowRound or 0) == (data.round or 0) and (self.shopLevel or 0) >= (data.level or 0) and ResShopExchg[exchgid] and ResShopExchg[exchgid].exchgmax then
			local hasBuy = self:getHasBuyNum(exchgid)

			if hasBuy < ResShopExchg[exchgid].exchgmax then
				return false
			end
		end
	end

	return true
end

function ActivityDataShop:isOver()
	if self.maxRound and self.maxRound > 1 then
		return false
	end

	if self.clientData then
		for exchgid, data in pairs(self.clientData) do
			if ResShopExchg[exchgid] and ResShopExchg[exchgid].exchgmax then
				local hasBuy = self:getHasBuyNum(exchgid)

				if hasBuy < ResShopExchg[exchgid].exchgmax then
					return false
				end
			end
		end

		return true
	end

	return false
end

function ActivityDataShop:getNextLevelProgress()
	local levelInfo = {}

	levelInfo.level = self.shopLevel or 0
	levelInfo.maxLevel = 0
	levelInfo.prePro = 0
	levelInfo.nextPro = 0
	levelInfo.nowPro = self.shopLevelProgress or 0

	if self.shopLevelDetailData then
		levelInfo.maxLevel = #self.shopLevelDetailData

		if levelInfo.level < levelInfo.maxLevel then
			for level, levelData in ipairs(self.shopLevelDetailData) do
				if level == self.shopLevel then
					levelInfo.prePro = levelData.up_need
				elseif level > self.shopLevel then
					levelInfo.nextPro = levelData.up_need

					break
				end
			end
		end
	end

	return levelInfo
end

function ActivityDataShop:isShopItemUnlock(exchgid)
	local detailData = self.clientData[exchgid]

	if detailData and detailData.act_condition then
		return CurAvatar:checkActivityConditionLimit(detailData.act_condition)
	else
		return true
	end
end

function ActivityDataShop:checkLinkedShop()
	self.hasLinkShop = false

	for exchgid, data in pairs(self.clientData) do
		local act_condition = data.act_condition
		local condData = ResOpActivityConditionLimit[act_condition]

		if condData and condData.type == Const.ACT_CONDITION_TYPE_SHOP and condData.templ_id == self.actId then
			self.hasLinkShop = true

			local needNode = condData.param1

			if needNode and self.clientData[needNode] then
				self.clientData[needNode].afterNode = exchgid
				data.preNode = needNode
			end
		end
	end

	if self.hasLinkShop then
		self.linkedNodes = {}
		self.singleNodes = {}

		for index, data in ipairs(self.indexData) do
			if not data.preNode then
				if data.afterNode then
					table.insert(self.linkedNodes, data.exchgid)
				else
					table.insert(self.singleNodes, data.exchgid)
				end
			end
		end
	end
end

function ActivityDataShop:getLinkedNodes()
	return self.linkedNodes, self.singleNodes
end

function ActivityDataShop:getNextNodeId(nodeId)
	local nData = self.clientData[nodeId]

	if nData and nData.afterNode then
		return nData.afterNode
	end
end

function ActivityDataShop:getNowLinkedNode(nodeId)
	for index = 1, 100 do
		if self:getShopItemState(nodeId) == Const.ACT_SHOP_STATE_NML then
			return nodeId
		else
			nodeId = self:getNextNodeId(nodeId)

			if not nodeId then
				break
			end
		end
	end
end

function ActivityDataShop:linkedNodeAllOver()
	for _, nodeId in ipairs(self.linkedNodes) do
		for index = 1, 100 do
			if self:getShopItemState(nodeId) ~= Const.ACT_SHOP_STATE_FINISH then
				return false
			else
				nodeId = self:getNextNodeId(nodeId)

				if not nodeId then
					break
				end
			end
		end
	end

	return true
end

function ActivityDataShop:getNodeShopItem(nodeId)
	local nData = self.clientData[nodeId]

	if nData then
		local hasBuy = self:getHasBuyNum(nodeId)
		local shopItem = self:_createItemInfo(0, nodeId, hasBuy)

		if shopItem then
			shopItem.index = nData.index or 0
		end

		return shopItem
	end
end

function ActivityDataShop:getShopItemState(exchgid)
	local hasBuy = self:getHasBuyNum(exchgid)

	if hasBuy >= ResShopExchg[exchgid].exchgmax then
		return Const.ACT_SHOP_STATE_FINISH
	end

	local aData = self.clientData[exchgid]

	if aData and aData.act_condition then
		local isUnlock, lockDesc = CurAvatar:checkActivityConditionLimit(aData.act_condition)

		if not isUnlock then
			return Const.ACT_SHOP_STATE_LOCK, lockDesc
		end
	end

	return Const.ACT_SHOP_STATE_NML
end

function ActivityDataShop:onShopItemBuy(item, fromUI, gridType, gridPath)
	if not item:canBuy() then
		local hint = item:getClickHint()

		if hint ~= nil then
			MsgManager.notice(hint)
		end
	else
		local actState, lockDesc = self:getShopItemState(item.id)

		if actState == Const.ACT_SHOP_STATE_LOCK then
			MsgManager.notice(lockDesc or Lang.get(55415))

			return
		end

		local ui = UIManager.getUI("shopBuyBox")

		ui:showShopItem(item, fromUI, Slot(self.onBuyCB, self), gridType or UIConst.ActivityShopCellChild, gridPath or "System/Common/Grid/GridTokenStoreItem")

		if fromUI then
			ui:bindWindow(fromUI)
		end
	end
end

function ActivityDataShop:onBuyCB(exchgid, count)
	RPC.opActGetAward(self.actObject.opId, exchgid, count)
end

return ActivityDataShop
