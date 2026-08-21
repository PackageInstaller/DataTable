-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataDraw.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResOpActivityDrawDetail = require("ClientData/ResOpActivityDrawDetail")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local ResDrawFakeRand = require("ClientData/ResDrawFakeRand")
local ActivityDataDraw = Class("ActivityDataDraw", ActivityDataBase)

function ActivityDataDraw:ctor()
	self.serverData = {
		lastDrawTick = 0,
		totalDrawCount = 0
	}
end

function ActivityDataDraw:CurAvatarCheckNew(oldValue, newValue)
	if oldValue and newValue then
		if newValue <= oldValue then
			self.skipCheckItemNew = true

			return
		else
			self.skipCheckItemNew = false
		end
	end

	CurAvatar:checkUpActivityNew()
end

function ActivityDataDraw:updateClientData(actId)
	self.actId = actId
	self.clientData = ResOpActivityDrawDetail[actId] or {}
	self.clientData.achieve = self:_clientDataAchievePostInit(self.clientData.achieve)
	self.poolId = self:getPoolId()

	if self.poolId then
		self.poolRandInfo = ResDrawFakeRand[self.poolId]

		if self.poolRandInfo and self.poolRandInfo.free_time then
			self.freeTicketCD = self.poolRandInfo.free_time * 3600
		end

		if not self.itemReddotInited and self.poolRandInfo.item_id then
			CurAvatar:registerItemChangedCallBack(self.poolRandInfo.item_id, Slot(self.CurAvatarCheckNew, self))

			self.itemReddotInited = true
		end
	end
end

function ActivityDataDraw:updateRoleData(roleData)
	local drawData = roleData.draw

	if drawData then
		self.serverData.totalDrawCount = drawData.count
		self.serverData.lastDrawTick = drawData.tick
		self.serverData.awardGotList = ClientUtils.getBitsListFromByteString(drawData.awarded)
		self.serverData.alreadyShared = drawData.shared == 1

		if drawData.hero_get_flag then
			self.serverData.heroGotList = ClientUtils.getBitsListFromByteString(drawData.hero_get_flag)
		end

		local drawCardMainDlg = UIManager.getUI("drawCardMainDlg", nil, false)

		if drawCardMainDlg then
			drawCardMainDlg:refreshPool()
		end
	end
end

function ActivityDataDraw:checkNew()
	local hasFreeTicket = false

	if self.freeTicketCD then
		hasFreeTicket = self:_checkFreeTicket()
	end

	local hasItemTicket

	hasItemTicket = (not self.skipCheckItemNew or false) and self:_checkItemTicket()

	local hasAwardToGet = self:focusAchieveState() == Const.ACT_ACHIEVE_STATE_ENOUGH
	local isNewOpened = false

	if self:checkIsOldRoleUpDraw() then
		local actObj = CurAvatar:getActivityObj(self.actId)

		if actObj and actObj:isNewOpened() and not self.skipCheckItemNew then
			isNewOpened = true
		end
	end

	return hasFreeTicket or hasItemTicket or hasAwardToGet or isNewOpened
end

function ActivityDataDraw:registerRDEvent()
	if self.actObject.redDotId then
		RedDotManager.setKeyRelation(self.actObject.redDotId, UIConst.RD_HINT_DRAWCARD)
	end
end

function ActivityDataDraw:unRegistRDEvent()
	if self.actObject.redDotId then
		RedDotManager.delKeyRelation(self.actObject.redDotId, UIConst.RD_HINT_DRAWCARD)
	end
end

function ActivityDataDraw:_checkFreeTicket()
	if not self.serverData or not self.serverData.lastDrawTick then
		return false
	end

	local needTick = self.serverData.lastDrawTick + self.freeTicketCD - ClientUtils.getServerTime()
	local hasFreeTicket = needTick <= 0

	if hasFreeTicket then
		ClientTimerManager.stopGlobalTimer("CustomDrawFreeTicket" .. self.actId)
	else
		ClientTimerManager.startGlobalTimer("CustomDrawFreeTicket" .. self.actId, needTick, Slot(self.CurAvatarCheckNew, self))
	end

	return hasFreeTicket
end

function ActivityDataDraw:_checkItemTicket()
	local itemEnough = false

	if self.poolRandInfo.item_id then
		local nowCount = CurAvatar:getItemNumById(self.poolRandInfo.item_id)

		if nowCount >= self.poolRandInfo.item_num then
			itemEnough = true
		end
	end

	return itemEnough
end

function ActivityDataDraw:getPoolId()
	if self.clientData and self.clientData.draw_id then
		return self.clientData.draw_id
	end
end

function ActivityDataDraw:_clientDataAchievePostInit(achieveData)
	local data = {}

	if achieveData then
		for i, awardInfo in ipairs(achieveData) do
			local count = awardInfo.count

			if count > 0 then
				table.insert(data, awardInfo)
			end
		end
	end

	return data
end

function ActivityDataDraw:getFocusAchieveIdx()
	local gotList = self.serverData.awardGotList or {}
	local focusIdx = #gotList + 1
	local achieveData = self.clientData.achieve

	if focusIdx > #achieveData then
		return #achieveData
	else
		return focusIdx
	end
end

function ActivityDataDraw:focusAchieveState()
	local focusIdx = self:getFocusAchieveIdx()
	local awardInfo = self.clientData.achieve[focusIdx]

	if awardInfo then
		local count = awardInfo.count
		local alreadyDrawCount = self.serverData.totalDrawCount

		if alreadyDrawCount < count then
			return Const.ACT_ACHIEVE_STATE_NOT_ENOUGH
		else
			local gotList = self.serverData.awardGotList

			if gotList[focusIdx] then
				return Const.ACT_ACHIEVE_STATE_GOT
			else
				return Const.ACT_ACHIEVE_STATE_ENOUGH
			end
		end
	end
end

function ActivityDataDraw:getUpHero()
	if self.clientData then
		return self.clientData.hero_id[1]
	end
end

function ActivityDataDraw:checkIsOldRoleUpDraw()
	local upHeros = self.clientData.hero_id

	if #upHeros > 1 then
		return true
	end

	return false
end

function ActivityDataDraw:hasShared()
	if self.serverData then
		return self.serverData.alreadyShared
	end
end

return ActivityDataDraw
