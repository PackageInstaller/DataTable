-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/badge/model/BadgeModel.lua

module("logic.extensions.badge.model.BadgeModel", package.seeall)

local BadgeModel = class("BadgeModel", BaseListModel)

function BadgeModel:ctor()
	BadgeModel.super.ctor(self)
end

function BadgeModel:onInit()
	BadgeModel.super.onInit(self)

	self._badgeInfo = {}
	self._badgeIds = {}
	self._petBadgeFrameUrl = {
		"ui/icon/badge/hz_02.png",
		"ui/icon/badge/hz_03.png",
		"ui/icon/badge/hz_04.png",
		"ui/icon/badge/hz_05.png"
	}
end

function BadgeModel:onReset()
	BadgeModel.super.onReset(self)

	self._badgeInfo = {}
	self._badgeIds = {}
	self._log = {}
end

function BadgeModel:setBadgeInfo(infos)
	local badgeIds = {}

	self._badgeInfo = {}
	self._badgeIds = {}

	for i, v in ipairs(infos) do
		self._badgeInfo[v.badgeId] = v

		table.insert(badgeIds, v.badgeId)
	end

	self._badgeIds = badgeIds
	self._badgeNum = #infos
end

function BadgeModel:getBadgeInfoById(id)
	return self._badgeInfo[id]
end

function BadgeModel:getBadgeIds()
	return self._badgeIds
end

function BadgeModel:getBadgeNum()
	return self._badgeNum or 0
end

function BadgeModel:getPetBadgeFrameUrl(rare)
	return self._petBadgeFrameUrl[rare]
end

function BadgeModel:saveLog(id, msg)
	self._log = self._log or {}
	self._log[id] = GameUtil.pbToTable(msg)

	if self._log[id].upgradeTimeMillis then
		table.sort(self._log[id].upgradeTimeMillis, function(a, b)
			return a < b
		end)
	end
end

function BadgeModel:getLog(id)
	return self._log[id]
end

function BadgeModel:saveComposeBadgeInfo(msg)
	local isFind = false

	for i, v in ipairs(self._badgeIds) do
		if v == msg.info.badgeId then
			isFind = true

			break
		end
	end

	if not isFind then
		table.insert(self._badgeIds, msg.info.badgeId)
	end

	self._badgeInfo[msg.info.badgeId] = msg.info
	self._badgeNum = #self._badgeIds
	self._log[msg.info.badgeId] = self._log[msg.info.badgeId] or {}
	self._log[msg.info.badgeId].upgradeTimeMillis = self._log[msg.info.badgeId].upgradeTimeMillis or {}

	table.insert(self._log[msg.info.badgeId].upgradeTimeMillis, msg.info.latestUpgradeTimeMillis)
end

BadgeModel.instance = BadgeModel.New()

return BadgeModel
