-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/badge/controller/BadgeController.lua

module("logic.extensions.badge.controller.BadgeController", package.seeall)

local BadgeController = class("BadgeController", BaseController)

BadgeController.CHANGEBADGE = "CHANGEBADGE"

function BadgeController:ctor()
	BadgeController.super.ctor(self)
end

function BadgeController:onInit()
	BadgeController.super.onInit(self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialGet, self.checkBadgeRedPoind, self)
end

function BadgeController:onReset()
	BadgeController.super.onReset(self)
end

function BadgeController:getBadgeInfo(callBack)
	BadgeAgent.instance:sendPM_LoadAllBadgeReq(nil, function(msg)
		BadgeModel.instance:setBadgeInfo(msg.info)
		self:checkBadgeRedPoind()
		GameUtil.callBack(callBack)
	end)
end

function BadgeController:getBadgeMaxNum()
	local define = BadgeConfig.instance:getDefine()

	if define then
		local num = 0

		for k, v in pairs(define) do
			if type(v) == "table" and v.active then
				num = num + 1
			end
		end

		return num
	else
		return 0
	end
end

function BadgeController:getBadgeTypeInfo()
	local result = {}

	for i, value in ipairs(BadgeConfig.instance:getType()) do
		table.insert(result, value)
	end

	return result
end

function BadgeController:getReplaceableBadge()
	local cardInfo, result = RoleModel.instance:getCardInfoMo(RoleModel.CardBelong.My), {}
	local allBadgeIds = BadgeModel.instance:getBadgeIds()

	for i, iv in ipairs(allBadgeIds) do
		local flag = true

		for j, jv in ipairs(cardInfo.badgeIds) do
			if iv == jv.left then
				flag = false

				break
			end
		end

		if flag then
			table.insert(result, BadgeConfig.instance:getDefineById(iv))
		end
	end

	table.sort(result, function(a, b)
		if a.rank ~= b.rank then
			return a.rank > b.rank
		else
			return a.id < b.id
		end
	end)

	return result
end

function BadgeController:changeBadge(oldBadgeId, newBadgeId)
	local cardInfo = RoleModel.instance:getCardInfoMo(RoleModel.CardBelong.My)

	if oldBadgeId then
		for i, value in ipairs(cardInfo.badgeIds) do
			if value.left == oldBadgeId then
				if newBadgeId then
					local var_10_0 = {
						left = newBadgeId
					}

					var_10_0.right = BadgeModel.instance:getBadgeInfoById(newBadgeId).level or 1
					cardInfo.badgeIds[i] = var_10_0

					break
				end

				table.remove(cardInfo.badgeIds, i)

				break
			end
		end
	else
		local var_10_1 = {
			left = newBadgeId
		}

		var_10_1.right = BadgeModel.instance:getBadgeInfoById(newBadgeId).level or 1

		table.insert(cardInfo.badgeIds, var_10_1)
	end

	local badgeIds = {}

	for i, v in ipairs(cardInfo.badgeIds) do
		table.insert(badgeIds, v.left)
	end

	PlayerAgent.instance:sendPM_ChangeBadgeReq(badgeIds, function()
		GlobalDispatcher:dispatch(BadgeController.CHANGEBADGE, cardInfo.badgeIds)
	end)
end

function BadgeController.canComposeBadge(badgeInfo)
	if not string.nilorempty(badgeInfo.piece) then
		local str = string.split(badgeInfo.piece, ":")
		local mo = MaterialMgr.getModel(tonumber(str[1]), tonumber(str[2]))

		return mo and mo.num >= tonumber(str[3])
	end

	return false
end

function BadgeController:handlePM_ComposeOrUpgradeBadgeRes(msg)
	BadgeModel.instance:saveComposeBadgeInfo(msg)
	self:checkBadgeRedPoind()

	local myCardInfo = RoleModel.instance:getCardInfoMo(RoleModel.CardBelong.My)

	if myCardInfo then
		myCardInfo.badgeNum = BadgeModel.instance:getBadgeNum()
	end

	GlobalDispatcher:dispatch(GlobalNotify.BadgeResRefesh)

	local cardInfo = RoleModel.instance:getCardInfoMo(RoleModel.CardBelong.My)

	for i, v in ipairs(cardInfo.badgeIds or {}) do
		v.right = BadgeModel.instance:getBadgeInfoById(v.left).level or 1
	end

	GlobalDispatcher:dispatch(BadgeController.CHANGEBADGE, cardInfo.badgeIds)
end

function BadgeController:sendPM_GetBadgeUpgradeLogsReq(badgeId)
	self._tempBadgeId = badgeId

	BadgeAgent.instance:sendPM_GetBadgeUpgradeLogsReq(badgeId)
end

function BadgeController:handlePM_GetBadgeUpgradeLogsRes(msg)
	BadgeModel.instance:saveLog(self._tempBadgeId, msg)

	self._tempBadgeId = nil

	GlobalDispatcher:dispatch(GlobalNotify.BadgeResRefesh)
end

function BadgeController:checkBadgeRedPoind()
	local isFind = false

	for i, v in ipairs(BadgeConfig.instance:getDefine()) do
		local info = BadgeModel.instance:getBadgeInfoById(v.id)

		if checknumber(v.levelPlanId) > 0 then
			if info then
				if not (info.level + 1) then
					local targetLevel = 1
					local levelCfg = BadgeConfig.instance:getLevelCfg(v.levelPlanId, targetLevel)

					if levelCfg and MaterialModel.instance:IsEnough(MatType.Item, v.pieceItemId, levelCfg.count) == true then
						isFind = true

						break
					end
				end
			end
		elseif not string.nilorempty(v.piece) and not info then
			local matType, matId, matNum = MaterialMgr.getMatParams(v.piece)

			if MaterialModel.instance:IsEnough(matType, matId, matNum) == true then
				isFind = true

				break
			end
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_BADGE_COMPOSE, isFind)
end

BadgeController.instance = BadgeController.New()

return BadgeController
