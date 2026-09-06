-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activityshop/agent/ActivityShopAgent.lua

module("logic.extensions.shop.agent.ActivityShopAgent", package.seeall)

local ActivityShopAgent = class("ActivityShopAgent", BaseAgent)

ActivityShopAgent.PM_GetAllShopItemInfoRes = "ActivityShopAgent_PM_GetAllShopItemInfoRes"
ActivityShopAgent.PM_BuyShopItemRes = "ActivityShopAgent_PM_BuyShopItemRes"

function ActivityShopAgent:ctor()
	return
end

function ActivityShopAgent:setExtId(extId)
	ActivityShopAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function ActivityShopAgent:sendPM_GetAllShopItemInfoReq(type, activityId, handler, handlerObj, errHandler)
	local req = ActivityShopExtension_pb.PM_GetAllShopItemInfoReq()

	req.type = type
	req.activityId = activityId

	self:sendMsg(req)
	self:addEventOnce(ActivityShopAgent.PM_GetAllShopItemInfoRes, handler, handlerObj, errHandler)
end

function ActivityShopAgent:handlePM_GetAllShopItemInfoRes(status, msg)
	forcePrint("=====RoleDataRequestor:_loadRequestRecallShop===back")
	self:dispatch(ActivityShopAgent.PM_GetAllShopItemInfoRes, status, msg)
end

function ActivityShopAgent:sendPM_BuyShopItemReq(type, activityId, itemId, count, couponUseInfo)
	local req = ActivityShopExtension_pb.PM_BuyShopItemReq()

	req.type = type
	req.activityId = activityId
	req.itemId = itemId
	req.count = count

	if couponUseInfo then
		req.couponUseInfo.couponId = couponUseInfo.couponId
		req.couponUseInfo.useCount = couponUseInfo.useCount
	end

	self:sendMsg(req)
end

function ActivityShopAgent:handlePM_BuyShopItemRes(status, msg)
	self:dispatch(ActivityShopAgent.PM_BuyShopItemRes, status, msg)
end

ActivityShopAgent.instance = ActivityShopAgent.New()

return ActivityShopAgent
