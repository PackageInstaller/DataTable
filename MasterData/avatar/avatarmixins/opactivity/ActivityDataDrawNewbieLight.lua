-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataDrawNewbieLight.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResOpActivityDrawNewbieCampDetail = require("ClientData/ResOpActivityDrawNewbieCampDetail")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local ResDrawFakeRand = require("ClientData/ResDrawFakeRand")
local ResRandClient = require("ClientData/ResRandClient")
local ActivityDataDrawNewbieLight = Class("ActivityDataDrawNewbieLight", ActivityDataBase)

function ActivityDataDrawNewbieLight:ctor()
	self.serverData = {
		totalDrawCount = 0
	}
end

function ActivityDataDrawNewbieLight:CurAvatarCheckNew(oldValue, newValue)
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

function ActivityDataDrawNewbieLight:updateClientData(actId)
	self.actId = actId
	self.clientData = ResOpActivityDrawNewbieCampDetail[actId] or {}
	self.randReplaceId = self.clientData.related_rand_replace_id
	self.poolId = self:getPoolId()

	if self.poolId then
		self.poolRandInfo = ResDrawFakeRand[self.poolId]

		if not self.itemReddotInited and self.poolRandInfo.item_id then
			CurAvatar:registerItemChangedCallBack(self.poolRandInfo.item_id, Slot(self.CurAvatarCheckNew, self))

			self.itemReddotInited = true
		end
	end
end

function ActivityDataDrawNewbieLight:updateRoleData(roleData)
	local drawData = roleData.draw_newbie_camp

	if drawData then
		self.serverData.totalDrawCount = drawData.count

		local drawCardMainDlg = UIManager.getUI("drawCardMainDlg", nil, false)

		if drawCardMainDlg then
			drawCardMainDlg:refreshPool()
		end
	end
end

function ActivityDataDrawNewbieLight:checkNew()
	local hasItemTicket

	hasItemTicket = (not self.skipCheckItemNew or false) and self:_checkItemTicket()

	return hasItemTicket
end

function ActivityDataDrawNewbieLight:registerRDEvent()
	if self.actObject.redDotId then
		RedDotManager.setKeyRelation(self.actObject.redDotId, UIConst.RD_HINT_DRAWCARD)
	end
end

function ActivityDataDrawNewbieLight:unRegistRDEvent()
	if self.actObject.redDotId then
		RedDotManager.delKeyRelation(self.actObject.redDotId, UIConst.RD_HINT_DRAWCARD)
	end
end

function ActivityDataDrawNewbieLight:_checkItemTicket()
	local itemEnough = false

	if self.poolRandInfo.item_id then
		local nowCount = CurAvatar:getItemNumById(self.poolRandInfo.item_id)

		if nowCount >= self.poolRandInfo.item_num then
			itemEnough = true
		end
	end

	return itemEnough
end

function ActivityDataDrawNewbieLight:getMainUpHeroId()
	local data = {}
	local groupId = self.clientData.related_rand_replace_group[1]

	data.groupId = groupId
	data.heroId = 0
	self.randReplaceActObj = CurAvatar:getActivityObj(self.randReplaceId)

	if self.randReplaceActObj and self.randReplaceActObj:isValid() then
		local randReplaceData = self.randReplaceActObj.actData.randReplaceData
		local index = 0

		for i, data in pairs(randReplaceData or {}) do
			if data.group_id == groupId then
				index = data.index
			end
		end

		local heroId = self.randReplaceActObj.actData:getHeroId(groupId, index)

		data.heroId = heroId or 0
	end

	return data
end

function ActivityDataDrawNewbieLight:getOtherHeroIds()
	local groupId1 = self.clientData.related_rand_replace_group[2]
	local groupId2 = self.clientData.related_rand_replace_group[3]
	local data = {
		{
			heroId = 0,
			groupId = groupId1
		},
		{
			heroId = 0,
			groupId = groupId2
		}
	}

	self.randReplaceActObj = CurAvatar:getActivityObj(self.randReplaceId)

	if self.randReplaceActObj and self.randReplaceActObj:isValid() then
		local randReplaceData = self.randReplaceActObj.actData.randReplaceData
		local index1 = 0
		local index2 = 0

		for i, data in pairs(randReplaceData or {}) do
			if data.group_id == groupId1 then
				index1 = data.index
			end

			if data.group_id == groupId2 then
				index2 = data.index
			end
		end

		local heroId1 = self.randReplaceActObj.actData:getHeroId(groupId1, index1)
		local heroId2 = self.randReplaceActObj.actData:getHeroId(groupId2, index2)

		data[1].heroId = heroId1
		data[2].heroId = heroId2
	end

	return data
end

function ActivityDataDrawNewbieLight:getAllUpHeros()
	local data1 = self:getMainUpHeroId()
	local data2 = self:getOtherHeroIds()

	return {
		data1.heroId,
		data2[1].heroId,
		data2[2].heroId
	}
end

function ActivityDataDrawNewbieLight:getAllSelectHeroIds(groupId)
	self.randReplaceActObj = CurAvatar:getActivityObj(self.randReplaceId)

	if self.randReplaceActObj and self.randReplaceActObj:isValid() then
		local allHeroIds = self.randReplaceActObj.actData:getAllHeroIds(groupId)
		local heroIds = {}

		for i, v in ipairs(allHeroIds) do
			table.insert(heroIds, v.heroId)
		end

		return heroIds
	end

	return {}
end

function ActivityDataDrawNewbieLight:getRandReplaceGroupAndIndex(groupId, heroId)
	self.randReplaceActObj = CurAvatar:getActivityObj(self.randReplaceId)

	if self.randReplaceActObj and self.randReplaceActObj:isValid() then
		local allHeroIds = self.randReplaceActObj.actData:getAllHeroIds(groupId)

		for i, v in ipairs(allHeroIds) do
			if v.heroId == heroId then
				return self.randReplaceActObj.opId, groupId, v.index
			end
		end
	end
end

function ActivityDataDrawNewbieLight:isMainUpHeroGroup(groupId)
	return groupId == self.clientData.related_rand_replace_group[1]
end

function ActivityDataDrawNewbieLight:getPoolId()
	if self.clientData and self.clientData.draw_pool_id then
		return self.clientData.draw_pool_id
	end
end

function ActivityDataDrawNewbieLight:checkIsOldRoleUpDraw()
	return false
end

function ActivityDataDrawNewbieLight:hasShared()
	return true
end

function ActivityDataDrawNewbieLight:getlimitIdGroup(...)
	local limitIdGroup = {}

	for i, id in pairs(self.clientData.condition_id or {}) do
		limitIdGroup[id] = true
	end

	return limitIdGroup
end

function ActivityDataDrawNewbieLight:isUnLock()
	for i, id in pairs(self.clientData.condition_id or {}) do
		local isUnlock = CurAvatar:checkActivityConditionLimit(id)

		if not isUnlock then
			return false
		end
	end

	return true
end

function ActivityDataDrawNewbieLight:getUpHero()
	local heroData = self:getMainUpHeroId()

	return heroData.heroId
end

return ActivityDataDrawNewbieLight
