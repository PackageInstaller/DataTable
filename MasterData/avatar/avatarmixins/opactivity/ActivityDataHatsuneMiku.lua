-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataHatsuneMiku.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResOpActivityHatsuneNode = require("ClientData/ResOpActivityHatsuneNode")
local ResOpActivityHatsuneLib = require("ClientData/ResOpActivityHatsuneLib")
local ResOpActivityHatsuneMisc = require("ClientData/ResOpActivityHatsuneMisc")
local ResShopExchg = require("ClientData/ResShopExchg")
local ResOpActivityShopDetail = require("ClientData/ResOpActivityShopDetail")
local ResItem = require("ClientData/ResItem")
local CommonBonusDlg = require("UI/Common/CommonBonusDlg")
local ActivityDataHatsuneMiku = Class("ActivityDataHatsuneMiku", ActivityDataBase)

function ActivityDataHatsuneMiku:ctor()
	self.cheerNum = 0
	self.serverData = {}
	self.awardLibStates = {}
	self.live2DBasePath = "UI/Live2D/"
	self.exchangeUIName = "exchangeConfirmBox"
end

function ActivityDataHatsuneMiku:updateClientData(actID)
	self.mainDlgName = "activityHatsuneMikuDlg"
	self.mainDlg = require("UI/OpActivity/Hatsune/ActivityHatsuneMikuDlg")
	self.OpState = self.mainDlg.OpState
	self.actID = actID
	self.allAwardsNode = ResOpActivityHatsuneNode[actID]

	local miscData = ResOpActivityHatsuneMisc[actID]

	self.miscData = miscData
	self.fireID = miscData.fire_id
	self.convertItemID = miscData.convert_item_id
	self.rewardType = miscData.reward_type
	self.operateTip = miscData.operate_tip
	self.achieveDaily = miscData.achieve_daily
	self.achieveLongtime = miscData.achieve_longtime
	self.achieves = {
		self.achieveLongtime,
		self.achieveDaily
	}

	for index, value in pairs(ResOpActivityHatsuneLib) do
		self.awardLibStates[index] = {}
	end

	self.cheerMax = self.allAwardsNode[#self.allAwardsNode].progress_need
	self.activityShop = miscData.activity_shop
	self.maxCheerOp = miscData.max_cheer_op
	self.relateShop = miscData.relate_shop

	local relateShopDetail = ResOpActivityShopDetail[self.relateShop]

	for key, value in pairs(relateShopDetail) do
		if value.index == miscData.free_index then
			self.freeID = key
		elseif value.index == miscData.single_index then
			self.singleOpID = key
		elseif value.index == miscData.exchange_index then
			self.exchangeID = key
		end
	end

	CurAvatar:addActivityRelated(self.relateShop, self.mainDlgName, self.actID)
	CurAvatar:addActivityRelated(self.achieveDaily, self.mainDlgName, self.actID)
	CurAvatar:addActivityRelated(self.achieveLongtime, self.mainDlgName, self.actID)
	CurAvatar:registerItemChangedCallBack(self:getCheerID(), Slot(self.onItemChanged, self))
end

function ActivityDataHatsuneMiku:updateRoleData(roleData, fromDataUpdate)
	local hatsune = roleData.hatsune

	if hatsune == nil then
		return
	end

	self.cheerNum = hatsune.cheer_num
	self.nodeDict = {}

	local nodeAwardedBytes = hatsune.node_awarded

	if nodeAwardedBytes ~= nil then
		local bitsList = ClientUtils.getBitsListFromByteString(nodeAwardedBytes)

		for i, achieveId in ipairs(bitsList) do
			self.nodeDict[achieveId] = true
		end
	end

	self.libs = hatsune.lib

	for index, value in pairs(self.libs) do
		local libID = value.lib_id
		local awardedIndexBytes = value.index_awarded

		if awardedIndexBytes ~= nil then
			local bitsList = ClientUtils.getBitsListFromByteString(awardedIndexBytes)

			for i, achieveId in ipairs(bitsList) do
				if self.awardLibStates[libID] == nil then
					-- block empty
				else
					self.awardLibStates[libID][achieveId] = true
				end
			end
		end
	end

	local activityHatsuneMikuDlg = UIManager.tryGetUI(self.mainDlgName)

	if activityHatsuneMikuDlg then
		activityHatsuneMikuDlg:refreshData()
	end
end

function ActivityDataHatsuneMiku:getLibState(libID, index)
	if self.awardLibStates[libID] and self.awardLibStates[libID][index] then
		return true
	else
		return false
	end
end

function ActivityDataHatsuneMiku:getCurNodeIndex()
	local index = 1

	for i = 1, #self.allAwardsNode do
		if self.nodeDict == nil or not self.nodeDict[i] then
			index = i

			break
		end
	end

	return index
end

function ActivityDataHatsuneMiku:getFreeNum()
	local shop = CurAvatar:getActivityObj(self.relateShop)

	if shop and self.freeID then
		local hasBuy = shop.actData:getHasBuyNum(self.freeID)
		local freeTotal = ResShopExchg[self.freeID].exchgmax

		return freeTotal - hasBuy
	else
		return 0
	end
end

function ActivityDataHatsuneMiku:getRemainFreeTime()
	local shop = CurAvatar:getActivityObj(self.relateShop)
	local leftTime = 0

	if not self.freeID or not shop or self.actObject:inFreeze() or not self.actObject:isValid() then
		return nil
	else
		local activityEndTime = shop:getRemainOpenTime()
		local freeItem = shop.actData.serverData[self.freeID]

		if freeItem then
			leftTime = freeItem.next_reset_time - ClientUtils.getServerTime()
		end

		if activityEndTime <= leftTime then
			return nil
		else
			return leftTime
		end
	end
end

function ActivityDataHatsuneMiku:getMultiNum()
	local cheerLeft = self:getHasCheerNum()
	local maxCount = self.maxCheerOp
	local costID = ResShopExchg[self.singleOpID].use[1].ID
	local opLeft = CurAvatar:getItemNumById(costID)
	local isFull = cheerLeft <= 0
	local multiNum

	if isFull then
		if opLeft > 1 and opLeft < maxCount then
			multiNum = opLeft
		else
			multiNum = maxCount
		end
	else
		multiNum = math.min(cheerLeft, maxCount)
	end

	return multiNum
end

function ActivityDataHatsuneMiku:getActivityShopID()
	local shopID = CurAvatar:getDynamicFakeActOpId(self.activity_shop)

	return shopID
end

function ActivityDataHatsuneMiku:freeCheer()
	local shopOpId = CurAvatar:getDynamicFakeActOpId(self.relateShop)
	local ui = UIManager.tryGetUI(self.mainDlgName)

	if ui then
		ui:setOpState(self.OpState.Free)
	end

	CurAvatar:activityRPC(Functor(RPC.opActGetAward, shopOpId, self.freeID, 1), self.actObject.opId)
end

function ActivityDataHatsuneMiku:cheerUp(num)
	local ui = UIManager.tryGetUI(self.mainDlgName)

	if ui then
		if num > 1 then
			ui:setOpState(self.OpState.Multi)
		else
			ui:setOpState(self.OpState.Single)
		end
	end

	local shopOpId = CurAvatar:getDynamicFakeActOpId(self.relateShop)

	CurAvatar:activityRPC(Functor(RPC.opActGetAward, shopOpId, self.singleOpID, num), self.actObject.opId)
end

function ActivityDataHatsuneMiku:tryCheerUp(goalNum)
	if self:checkMoney(goalNum) then
		self:cheerUp(goalNum)
	end
end

function ActivityDataHatsuneMiku:tryCheerUpDirect()
	local costID = ResShopExchg[self.singleOpID].use[1].ID
	local costNum = CurAvatar:getItemNumById(costID)
	local multiCost = self:getMultiNum()

	if multiCost <= costNum then
		self:tryCheerUp(multiCost)
	elseif costNum >= 1 then
		self:tryCheerUp(1)
	end
end

function ActivityDataHatsuneMiku:checkMoney(goalNum)
	local costID = ResShopExchg[self.singleOpID].use[1].ID
	local exchgCostID = ResShopExchg[self.exchangeID].use[1].ID
	local costNum = CurAvatar:getItemNumById(costID)
	local exchgCostNum = CurAvatar:getItemNumById(exchgCostID)
	local exchgGetNum = ResShopExchg[self.exchangeID].exchg[1].value
	local exchgGetID = ResShopExchg[self.exchangeID].exchg[1].key
	local exchgName = ResItem[exchgGetID].name
	local isFull = self:getHasCheerNum() <= 0
	local maxExchgScore = exchgCostNum * exchgGetNum

	if goalNum <= costNum then
		return true
	elseif not isFull then
		local numGet = goalNum - costNum
		local numCost = numGet / exchgGetNum
		local exchangeUI = UIManager.getUI(self.exchangeUIName, true, true)
		local data = {
			itemCost = exchgCostID,
			numCost = numCost,
			itemGet = costID,
			numGet = numGet,
			titleTxt = utils.format(Lang.get(43772), exchgName)
		}

		exchangeUI:setData(data, Functor(self.exchangeCB, self, data))
	else
		MsgManager.clientNotice(402)
	end

	return false
end

function ActivityDataHatsuneMiku:cheerTransformCB()
	if self.cheerTransformData ~= nil then
		local exchangeUI = UIManager.getUI(self.exchangeUIName, true)

		if exchangeUI then
			exchangeUI:setData(self.cheerTransformData)
			exchangeUI:setFlyConfig(true)
		end
	end

	self.cheerTransformData = nil
end

function ActivityDataHatsuneMiku:onCheerConvert(convert_cheer, award_id, num)
	local data = {
		itemCost = self.fireID,
		numCost = convert_cheer,
		itemGet = award_id,
		numGet = num,
		titleTxt = Lang.get(31335),
		descTxt = Lang.get(31336)
	}

	self.cheerTransformData = data
end

function ActivityDataHatsuneMiku:getLive2DCheerPath(index)
	return self.live2DBasePath .. self.miscData.live2d_paths[index].cheer_path or ""
end

function ActivityDataHatsuneMiku:getLive2DStandPath(index)
	return self.live2DBasePath .. self.miscData.live2d_paths[index].stand_path or ""
end

function ActivityDataHatsuneMiku:exchangeCB(data)
	local num = data.numCost
	local exchgCostID = ResShopExchg[self.exchangeID].use[1].ID
	local exchgCostNum = CurAvatar:getItemNumById(exchgCostID)

	if exchgCostNum < num then
		MsgManager.clientNotice(406)
	else
		local relateShopOpId = CurAvatar:getDynamicFakeActOpId(self.miscData.relate_shop)
		local ui = UIManager.tryGetUI(self.mainDlgName)

		if ui then
			ui:setOpState(self.OpState.Exchange)
		end

		CurAvatar:activityRPC(Functor(RPC.opActGetAward, relateShopOpId, self.exchangeID, num), self.actObject.opId)
	end
end

function ActivityDataHatsuneMiku:getHasCheerNum()
	local scoreLeft = self.cheerMax - self.cheerNum
	local cheerOpScore = ResShopExchg[self.singleOpID].exchg[1].value
	local cheerLeftCount = scoreLeft / cheerOpScore

	return cheerLeftCount
end

function ActivityDataHatsuneMiku:getExchangeNum()
	local cheerLeft = self:getHasCheerNum()
	local exchangeOpCheer = ResShopExchg[self.exchangeID].exchg[1].value
	local exchangeLeftCount = cheerLeft / exchangeOpCheer

	return exchangeLeftCount
end

function ActivityDataHatsuneMiku:checkRelateAchieve()
	local achieveObjs = {}

	for key, value in pairs(self.achieves) do
		local obj = CurAvatar:getActivityObj(value)

		table.insert(achieveObjs, obj)
	end

	for index, obj in ipairs(achieveObjs) do
		local actData = obj.actData

		if actData:checkNew() then
			return true
		end
	end

	return false
end

function ActivityDataHatsuneMiku:checkNodeAward()
	for key, node in pairs(self.allAwardsNode) do
		if self.cheerNum >= node.progress_need and not self.nodeDict[key] then
			return true
		end
	end

	return false
end

function ActivityDataHatsuneMiku:checkCheerUp(goalNum)
	local costID = ResShopExchg[self.singleOpID].use[1].ID
	local costNum = CurAvatar:getItemNumById(costID)

	if goalNum then
		return goalNum <= costNum
	else
		return costNum > 0
	end
end

function ActivityDataHatsuneMiku:checkNew()
	if self:checkRelateAchieve() then
		return true
	end

	if self:checkNodeAward() then
		return true
	end

	if self:getHasCheerNum() > 0 and not self.actObject:inFreeze() then
		if self:getFreeNum() > 0 then
			return true
		end

		if self:checkCheerUp() then
			return true
		end
	end

	return false
end

function ActivityDataHatsuneMiku:getNodeAward(nodeData, selected)
	if self.actObject:inFreeze() then
		RPC.opActHatsuneGetNodeAward(self.actObject.opId, nodeData.index, selected.index)
	else
		CurAvatar:activityRPC(Functor(RPC.opActHatsuneGetNodeAward, self.actObject.opId, nodeData.index, selected.index), self.actObject.opId)
	end
end

function ActivityDataHatsuneMiku:getCheerID()
	local costID = ResShopExchg[self.singleOpID].use[1].ID

	return costID
end

function ActivityDataHatsuneMiku:onItemChanged()
	self.actObject:checkNew()

	local activityHatsuneMikuDlg = UIManager.tryGetUI(self.mainDlgName)

	if activityHatsuneMikuDlg then
		activityHatsuneMikuDlg:refreshData()
	end
end

function ActivityDataHatsuneMiku:getAchieves()
	return self.achieves
end

function ActivityDataHatsuneMiku:getFullNoticeId()
	return self.miscData.full_notice_id
end

function ActivityDataHatsuneMiku:onStateChange(opActState)
	if self.actObject:inFreeze() then
		local mainDlg = UIManager.tryGetUI(self.mainDlgName)

		if mainDlg then
			mainDlg:refreshData()
		end
	elseif self.actObject.curState == Const.OPACT_STATE_CLOSE then
		local mainDlg = UIManager.tryGetUI(self.mainDlgName)

		if mainDlg then
			mainDlg:setVisible(false)
		end
	end
end

return ActivityDataHatsuneMiku
