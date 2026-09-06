-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bargain/model/BargainModel.lua

module("logic.extensions.bargain.model.BargainModel", package.seeall)

local BargainModel = class("BargainModel", BaseModel)

function BargainModel:ctor()
	return
end

function BargainModel:onInit()
	self:onReset()
end

function BargainModel:onReset()
	self._activityId = 0
	self._goods = {}
	self._userState = 0
end

function BargainModel:getActivityId()
	if self._activityId == 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.FriendBargain)
	end

	return self._activityId
end

function BargainModel:setBargainInfo(msg)
	self._goods = GameUtil.pbToTable(msg.goods)
	self._userState = msg.userState
	self._activityId = msg.activityId
end

function BargainModel:setGoodsInfo(msg)
	info = self._goods[msg.goodsId]

	if info then
		info.curPrice = -1
	end
end

function BargainModel:getGoodsLength()
	return #self._goods
end

function BargainModel:getBargainInfo(goodsId)
	local info = self._goods[goodsId]

	if info then
		return info
	end

	return {}
end

function BargainModel:getFriendInfo()
	local friendList = FriendModel.instance:getGroupDatas(GameEnum.FriendGroup.Friend)
	local list = {}

	for i, v in ipairs(friendList) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		if a:getIsOnline() and b:getIsOnline() then
			return a:getCurFetter() > b:getCurFetter()
		end

		return a:getIsOnline()
	end)

	return list
end

BargainModel.instance = BargainModel.New()

return BargainModel
