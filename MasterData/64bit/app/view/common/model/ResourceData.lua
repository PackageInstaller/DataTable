local ResourceData = class("ResourceData")

function ResourceData:ctor()
	self:initData()
end

function ResourceData:initData()
	self._exp = 0
	self._vipExp = 0
	self._coin = 0
	self._vit = 0
	self._lastVit = 0
	self._recoverVitTime = 0
	self._biographie = 0
	self._guildWar = 0
	self._prestige = 0
	self._robNum = 0
	self._robNumTime = 0
	self._robScore = 0
	self._knightSoul = 0
	self._rebelCoin = 0
	self._rebelAttack = 0
	self._guildScore = 0
	self._guildTimes = 0
	self._mysteryShopFreeNum = 0
	self._mysteryShopFreeTime = 0
	self._artifactShopFreeTime = 0
	self._petShopFreeNum = 0
	self._petShopFreeTime = 0
	self._tired = 0
	self._stormScore = 0
	self._artifactShopFreeNum = 0
	self._grain = 0
	self._armyToken = 0
	self._furnitureShopFreeNum = 0
	self._furnitureShopFreeTime = 0
	self._voucherNum = 0
	self._resourceMap = {}
	self._chiefArenaScore = 0
	self._resourceData = {}
	self._resourceCfg = {}

	self:initCfg()
end

function ResourceData:updateData(arg_3_1)
	if not arg_3_1 then
		return
	end

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_EXP then
			self._exp = iter_3_1.num
		elseif iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_VIPEXP then
			self._vipExp = iter_3_1.num
		elseif iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_COIN then
			self._coin = iter_3_1.num
		elseif iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_STAMINA then
			if self._vit ~= iter_3_1.num then
				self._lastVit = self._vit
			end

			if iter_3_1.time then
				self._recoverVitTime = iter_3_1.time
			end

			self._vit = iter_3_1.num
		elseif iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_PRESTIGE then
			self._prestige = iter_3_1.num
		elseif iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_ROB_NUM then
			if iter_3_1.time then
				self._robNumTime = iter_3_1.time
			end

			self._robNum = iter_3_1.num
		elseif iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_ROB_SCORE then
			self._robScore = iter_3_1.num
		elseif iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_REBEL_COIN then
			self._rebelCoin = iter_3_1.num
		elseif iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_REBEL_ATTACK then
			self._rebelAttack = iter_3_1.num
		elseif iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_GUILD_SCORE then
			self._guildScore = iter_3_1.num
		elseif iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_GUILD_DUN_TIME then
			self._guildTimes = iter_3_1.num
		elseif iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_MYSTERY_SHOP_FREE_NUM then
			self._mysteryShopFreeNum = iter_3_1.num

			if iter_3_1.time then
				self._mysteryShopFreeTime = iter_3_1.time
			end
		elseif iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_KNIGHT_SOUL then
			self._knightSoul = iter_3_1.num
		elseif iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_TIRED then
			self._tired = iter_3_1.num
		elseif iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_STORM_SCORE then
			self._stormScore = iter_3_1.num
		elseif iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_ARTIFACT_SHOP_FREE_NUM then
			self._artifactShopFreeNum = iter_3_1.num

			if iter_3_1.time then
				self._artifactShopFreeTime = iter_3_1.time
			end
		elseif iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_BIOGRAPHIE then
			self._biographie = iter_3_1.num
		elseif iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_GRAIN then
			self._grain = iter_3_1.num
		elseif iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_ARMY_TOKEN then
			self._armyToken = iter_3_1.num
		elseif iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_GUILD_WAR then
			self._guildWar = iter_3_1.num
		elseif iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_PET_SHOP_FREE_NUM then
			self._petShopFreeNum = iter_3_1.num

			if iter_3_1.time then
				self._petShopFreeTime = iter_3_1.time
			end
		elseif iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_FURNITURE_SHOP_FREE_NUM then
			self._furnitureShopFreeNum = iter_3_1.num

			if iter_3_1.time then
				self._furnitureShopFreeTime = iter_3_1.time
			end
		elseif iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_VOUCHER_COIN_RESOURCE then
			self._voucherNum = iter_3_1.num
		elseif iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_CHIEF_ARENA_SKILL then
			self._chiefArenaScore = iter_3_1.num
		elseif iter_3_1.id == g.core.common.Goods.RESOURCE.TYPE_OUTPOST_POINT then
			g.core.model.User.outpostData:setTodayPoint(g.core.model.User.outpostData:getTodayPoint() + iter_3_1.num - (self._resourceMap[iter_3_1.id] or 0))
		end

		self._resourceMap[iter_3_1.id] = iter_3_1.num
		self._resourceData[iter_3_1.id] = iter_3_1

		if not iter_3_1.time and self._resourceData[iter_3_1.id] then
			iter_3_1.time = self._resourceData[iter_3_1.id].time
		end
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_RESOURCE_CHANGE)
end

function ResourceData:getResourceDataByType(arg_4_1)
	return self._resourceData[arg_4_1]
end

function ResourceData:initCfg()
	for iter_5_0 = 1, g.core.config.basic_figure_info.getLength() do
		local var_5_0 = g.core.config.basic_figure_info.indexOf(iter_5_0)

		self._resourceCfg[var_5_0.value] = var_5_0
	end
end

function ResourceData:getRecoverCfg(arg_6_1)
	return self._resourceCfg[arg_6_1]
end

function ResourceData:setVit(arg_7_1)
	self._vit = math.max(0, arg_7_1)
end

function ResourceData:setRobNum(arg_8_1)
	self._robNum = arg_8_1
end

function ResourceData:setRebelAttack(arg_9_1)
	self._rebelAttack = arg_9_1
end

function ResourceData:setTired(arg_10_1)
	self._tired = arg_10_1
end

function ResourceData:setBioGraphie(arg_11_1)
	self._biographie = arg_11_1
end

function ResourceData:getBioGraphie()
	return self._biographie
end

function ResourceData:getExp()
	return self._exp
end

function ResourceData:getVipExp()
	return self._vipExp
end

function ResourceData:getCoin()
	return self._coin
end

function ResourceData:getVit()
	return self._vit
end

function ResourceData:getLastVit()
	return self._lastVit
end

function ResourceData:getRecoverMaxVitTime()
	return self._recoverVitTime
end

function ResourceData:getPrestige()
	return self._prestige
end

function ResourceData:getRobNum()
	return self._robNum
end

function ResourceData:getRobScore()
	return self._robScore
end

function ResourceData:getRebelCoin()
	return self._rebelCoin
end

function ResourceData:getRebelAttack()
	return self._rebelAttack
end

function ResourceData:getGuildDungeonScore()
	return self._guildScore
end

function ResourceData:getGuildDungeonTimes()
	return self._guildTimes
end

function ResourceData:getMysteryShopFreeNum()
	return self._mysteryShopFreeNum
end

function ResourceData:getMysteryShopFreeTime()
	return self._mysteryShopFreeTime
end

function ResourceData:getArtifactShopFreeTime()
	return self._artifactShopFreeTime
end

function ResourceData:getKnightSoul()
	return self._knightSoul
end

function ResourceData:getRobNumTime()
	return self._robNumTime
end

function ResourceData:getTired()
	return self._tired
end

function ResourceData:getStormScore()
	return self._stormScore
end

function ResourceData:getArtifactShopFreeNum()
	return self._artifactShopFreeNum
end

function ResourceData:getPetShopFreeNum()
	return self._petShopFreeNum
end

function ResourceData:getPetShopFreeTime()
	return self._petShopFreeTime
end

function ResourceData:getFurnitureShopFreeNum()
	return self._furnitureShopFreeNum
end

function ResourceData:getFurnitureShopFreeTime()
	return self._furnitureShopFreeTime
end

function ResourceData:getGuildWar()
	return self._guildWar
end

function ResourceData:getChiefArenaScore()
	return self._chiefArenaScore
end

function ResourceData:getResourceById(arg_40_1)
	return self._resourceMap[arg_40_1] or 0
end

function ResourceData:setResource(arg_41_1)
	local var_41_0 = {}

	table.insert(var_41_0, arg_41_1)
	self:updateData(var_41_0)
end

function ResourceData:updateResourceByRefresh(arg_42_1)
	if not arg_42_1.resources then
		return
	end

	self:setResource({
		id = arg_42_1.resources.id,
		num = arg_42_1.resources.num
	})
end

return ResourceData
