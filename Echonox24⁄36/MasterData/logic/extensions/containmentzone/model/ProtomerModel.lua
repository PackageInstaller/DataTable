-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/model/ProtomerModel.lua

module("logic.extensions.containmentzone.model.ProtomerModel", package.seeall)

local M = class("ProtomerModel", BaseModel)

function M:ctor()
	self._protomerGroup = {}
	self.tableForChangeView = nil
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._protomerGroup = {}
	self.tableForChangeView = nil
	self._curSelectProtomerId = nil
end

function M:gainProtomerPush(data, broadcast)
	if data then
		self:updateProtomer(data, broadcast)
	end
end

function M:updateProtomerDiffIntelligences(intelligences)
	if intelligences and #intelligences > 0 then
		for _, KeyValue in ipairs(intelligences) do
			local protomerId = KeyValue.key
			local intelligenceDiff = KeyValue.value
			local protomerInfoMo = self:getProtomerInfo(protomerId)

			if protomerInfoMo then
				protomerInfoMo:updateProtomerDiffIntelligence(intelligenceDiff)
			end
		end
	end
end

function M:updateProtomerLst(dataLst)
	if dataLst and #dataLst > 0 then
		for k, v in ipairs(dataLst) do
			self:updateProtomer(v, false)
		end
	else
		printWarn("隐秘原体数量为0")
	end

	GlobalDispatcher:dispatchEvent(EventType.HOUSE_PROTOMER_INFO_CHANGE)
end

function M:updateProtomer(data, broadcast)
	local protomerId = data.protomerId

	if not self._protomerGroup[protomerId] then
		self._protomerGroup[protomerId] = ProtomerMo.New()
	end

	local theMo = self._protomerGroup[protomerId]

	theMo:updateFromServer(data)

	if broadcast then
		GlobalDispatcher:dispatchEvent(EventType.HOUSE_PROTOMER_INFO_CHANGE)
	end
end

function M:updateProtomerFromClient(data, broadcast)
	local protomerId = data:getProtomerId()

	if not self._protomerGroup[protomerId] then
		self._protomerGroup[protomerId] = ProtomerMo.New()
	end

	local theMo = self._protomerGroup[protomerId]

	theMo:updateFromClient(data)

	if broadcast then
		GlobalDispatcher:dispatchEvent(EventType.HOUSE_PROTOMER_INFO_CHANGE)
	end
end

function M:getProtomerInfo(protomerId)
	return self._protomerGroup[protomerId]
end

function M:owenProtomer(protomerId)
	return self._protomerGroup[protomerId] ~= nil
end

function M:getProtomerRoomId(protomerId)
	if self:owenProtomer(protomerId) then
		return self._protomerGroup[protomerId]:getRoomId()
	else
		return 0
	end
end

function M:getProtomerInfoLstForChangeView()
	if self.tableForChangeView then
		return self.tableForChangeView
	end

	local pBackpackConfig = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.ProtomerItemType)
	local coLst = ContainmentConfig.instance:getProtomerCoLstByClassSort()

	self.tableForChangeView = coLst

	return self.tableForChangeView
end

function M:getProtomerLv(protomerId)
	local protomerInfoMo = self:getProtomerInfo(protomerId)

	return protomerInfoMo and protomerInfoMo:getLevel() or 0
end

function M:predictProtomerInfoChange(protomerId, addPoint, whithIntellUnlockInfo, intelligenceLst)
	local info = {
		lvOffset = 0,
		pointNow = 0,
		canUpgradeModule = false,
		pointMax = 0,
		protomerId = protomerId,
		addPoint = addPoint,
		unLockIntelligence = {}
	}
	local protomerInfoMo = self:getProtomerInfo(protomerId)

	if protomerInfoMo then
		local orgPoint = protomerInfoMo:getResearchPoint()
		local finalPoint = orgPoint + addPoint
		local cfgResearch = ContainmentConfig.instance:getHouseResearchCoByCode(protomerInfoMo:getProtomerCfgResearchCode())
		local orgLevel = protomerInfoMo:getLevel()
		local tryNextLv = orgLevel

		while cfgResearch and cfgResearch[tryNextLv] do
			local needPoint = cfgResearch[tryNextLv].point

			if needPoint == 0 then
				break
			end

			if needPoint > 0 then
				if finalPoint < cfgResearch[tryNextLv].point then
					if tryNextLv ~= orgLevel then
						tryNextLv = tryNextLv - 1 or tryNextLv
					end

					break
				end

				if cfgResearch[tryNextLv].point == finalPoint then
					break
				end
			end

			tryNextLv = tryNextLv + 1
		end

		print(string.format("原体研究点[%d]->[%d],等级[%d]->[%d]", orgPoint, finalPoint, orgLevel, tryNextLv))

		info.lvOffset = tryNextLv - orgLevel

		local nowP, needP = protomerInfoMo:getResearchProcessByData(tryNextLv, finalPoint)

		info.pointNow = nowP
		info.pointMax = needP

		local offsetModulePoint = 0

		if info.lvOffset > 0 then
			for i = orgLevel + 1, tryNextLv do
				offsetModulePoint = offsetModulePoint + cfgResearch[i].modulePoint
			end
		end

		local finalModulePoint = protomerInfoMo:getModulePoint() + offsetModulePoint
		local canUpgradeModuleIdLst = protomerInfoMo:hasModuleCanUpGrade(finalModulePoint)

		info.canUpgradeModule = #canUpgradeModuleIdLst > 0

		if whithIntellUnlockInfo then
			local _condition = ContainmentEnum.ProtomerInfoUnlockCondition
			local cfgUnlock = ContainmentConfig.instance:getProtomerInfoUnlockCoByCode(protomerInfoMo:getProtomerCfgUnlockCode())

			for _typ, _typLst in pairs(cfgUnlock or {}) do
				for _, value in pairs(_typLst) do
					if value.condition == _condition.ByPoint and orgPoint < value.param and finalPoint >= value.param then
						info.unLockIntelligence[value.item] = 1

						print(string.format("原体研究点达标[%d],解锁条目[%d]", value.param, value.item))
					end

					if value.condition == _condition.ByLevel and orgLevel < value.param and tryNextLv >= value.param then
						info.unLockIntelligence[value.item] = 1

						print(string.format("原体等级达标[%d],解锁条目[%d]", value.param, value.item))
					end
				end
			end

			if intelligenceLst and #intelligenceLst > 0 then
				for _, value in ipairs(intelligenceLst) do
					local binTable = ContainmentModel.instance:decimal2bin(value)

					for i = 1, 32 do
						if binTable[i] == 1 then
							local id = 32 - i + 1

							info.unLockIntelligence[id] = 1
						end
					end
				end
			end
		end
	end

	return info
end

function M:getProtomerInfoByShelterRoomTyp(shelterRoomType)
	local info
	local cfg = ContainmentConfig.instance:getProtomerCoByShelterRoomTyp(shelterRoomType)

	if cfg then
		info = self:getProtomerInfo(cfg.id)
	else
		printError(string.format("无法在house_hold_protomer中找到收容室资源[%d]的配置", shelterRoomType))
	end

	return info
end

function M:setCurSelectProtomerId(id)
	self._curSelectProtomerId = id
end

function M:getCurSelectProtomerId()
	return self._curSelectProtomerId
end

M.instance = M.New()

return M
