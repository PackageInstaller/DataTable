-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataNewMaze.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResNewMaze = require("ClientData/ResNewMaze")
local ResNewMazeNode = require("ClientData/ResNewMazeNode")
local ResNewMazeLayerAward = require("ClientData/ResNewMazeLayerAward")
local ResNewMazeShop = require("ClientData/ResNewMazeShop")
local ResNewMazeRelic = require("ClientData/ResNewMazeRelic")
local ResNewMazeFeature = require("ClientData/ResNewMazeFeature")
local ResNewMazeHero = require("ClientData/ResNewMazeHero")
local ResNewMazeHalo = require("ClientData/ResNewMazeHalo")
local ResNewMazeDebuff = require("ClientData/ResNewMazeDebuff")
local ResNewMazeLevelMisc = require("ClientData/ResNewMazeLevelMisc")
local ResNewMazeAward = require("ClientData/ResNewMazeAward")
local ResNewMazeRandEvent = require("ClientData/ResNewMazeRandEvent")
local ResOpActivityAchieveDetail = require("ClientData/ResOpActivityAchieveDetail")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local ResNewMazeEnchanter = require("ClientData/ResNewMazeEnchanter")
local ResNewMazeTalent = require("ClientData/ResNewMazeTalent")
local ResNewMazeAchieve = require("ClientData/ResNewMazeAchieve")
local EventConst = require("EventConst")
local ActivityDataNewMaze = Class("ActivityDataNewMaze", ActivityDataBase)

function ActivityDataNewMaze:ctor()
	self.serverData = {}
	self.clientData = {}
end

function ActivityDataNewMaze:updateClientData(actId)
	self.actId = actId
	self.miscData = ResNewMaze[actId]
	self.nodeTableData = ResNewMazeNode[actId]
	self.layerAwardData = ResNewMazeLayerAward[actId]
	self.shopTableData = ResNewMazeShop[actId]
	self.levelMiscData = ResNewMazeLevelMisc[actId]
	self.awardTableData = ResNewMazeAward[actId]
	self.randEventTableData = ResNewMazeRandEvent[actId]
	self.relatedAchieveID = self.miscData.relate_achieve_id
	self.achieveData = ResOpActivityAchieveDetail[self.miscData.relate_achieve_id]
	self.heroId = self.miscData.init_hero
	self.auxHeroId = self.miscData.init_aux_hero
	self.assistHeroIds = self.miscData.assist_hero
end

function ActivityDataNewMaze:updateMgrData(opActivityMgrItem)
	self.mgrData = opActivityMgrItem
	self.startTime = self.mgrData.time.opentime
	self.endTime = self.mgrData.time.closetime
	self.freezeTime = self.mgrData.time.freezetime
	self.cycle = self.mgrData.specdata.new_maze.cycle
	self.status = self.mgrData.specdata.new_maze.status
	self.nextTick = self.mgrData.specdata.new_maze.next_cycle_tick
end

function ActivityDataNewMaze:updateRoleData(roleData)
	self.ratingLevel = roleData.new_maze.level
	self.layer = roleData.new_maze.layer
	self.curScore = tonumber(roleData.new_maze.score) or 0
	self.shop = roleData.new_maze.shop
	self.attr = roleData.new_maze.attr
	self.bag = roleData.new_maze.bag
	self.statistic = roleData.new_maze.statistic
	self.cache = roleData.new_maze.cache
	self.achieveSpecData = roleData.new_maze.achieve

	if self.ratingLevel and self.ratingLevel ~= 0 then
		self.randSubjectType = self.levelMiscData[self.ratingLevel].level_subject_type
	end

	self.curShopLv = self.shop.level
	self.curShopExp = self.shop.exp
	self.bagHeros = {}

	if self.bag.hero then
		for _, info in ipairs(self.bag.hero) do
			local heroData = {}

			heroData.id = info.id
			heroData.outside_relic_id = info.outside_relic_id
			heroData.fetter1_id = info.fetter1_id
			heroData.fetter2_id = info.fetter2_id
			heroData.fetter3_id = info.fetter3_id

			table.insert(self.bagHeros, heroData)
		end
	end

	self.bagRelics = {}

	if self.bag.relics then
		self.bagRelics = self.bag.relics
	end

	self.bagHalos = {}

	if self.bag.halo then
		self.bagHalos = self.bag.halo
	end

	self.resolveItemNum = 0
	self.bagSolder = {}

	for _, info in ipairs(self.bag.enchanter) do
		local itId = info.id
		local itCount = info.cache_count
		local buyNum = info.buy_count
		local eData = ResNewMazeEnchanter[itId]

		if eData.type == 2 then
			self.resolveItemNum = itCount
			self.resolveItemId = itId
		elseif eData.effect_id and itCount > 0 then
			self.bagSolder[eData.effect_id] = {
				id = eData.effect_id,
				num = itCount,
				item_id = itId,
				buy_count = info.buy_count
			}
		end
	end

	self.seasonCache = self.cache.season

	if self.seasonBestGradeLevel then
		self.oldSeasonBestGradeLevel = self.seasonBestGradeLevel
	end

	if self.seasonBestGradeLayer then
		self.oldSeasonBestGradeLayer = self.seasonBestGradeLayer
	end

	self.seasonBestGradeLevel = self.seasonCache.best_grade.level or 0
	self.seasonBestGradeLayer = self.seasonCache.best_grade.layer or 0
	self.seasonBestGradeScore = tonumber(self.seasonCache.best_grade.score) or 0
	self.lastPlayLevel = nil

	if self.seasonCache.last_cycle_grade and self.seasonCache.last_cycle_grade.level then
		self.lastPlayLevel = self.seasonCache.last_cycle_grade.level
	end

	self.hasGotFirstPassAward = ClientUtils.getBitsDictFromByteString(self.seasonCache.is_got_first_pass_award)
	self.firstPassChangeAward = ClientUtils.getBitsDictFromByteString(self.seasonCache.first_pass_award_change_flag)
	self.randHistory = self.seasonCache.rand_history
	self.randHistoryMultiAward = self.randHistory.multi_award
	self.randHistoryShop = self.randHistory.shop
	self.inheritHeroPool = {}
	self.inheritSelHeros = {}
	self.cycleCache = self.cache.cycle
	self.bestGradeLevel = self.cycleCache.best_grade.level or 0
	self.bestGradeLayer = self.cycleCache.best_grade.layer or 0
	self.layerCache = self.cache.layer
	self.lastRandEventList = nil

	if self.layerCache.last_rand_nodes_list and #self.layerCache.last_rand_nodes_list ~= 0 then
		self.lastRandEventList = self.layerCache.last_rand_nodes_list
	end

	self.lastEventData = self.layerCache.cur_node_data
	self.lastEventDataStatus = ClientUtils.getBitsDictFromByteString(self.lastEventData.status)
	self.randEventRemainTimes = nil
	self.subEventData = nil

	if self.lastEventData.node_type == Const.NEW_MAZE_NODE_EVENT_TYPE.RandEvent and self.lastEventData.spec_data.rand_event then
		if self.lastEventData.spec_data.rand_event.select_index and self.lastEventData.spec_data.rand_event.select_event.remainder_time > 0 then
			self.randEventRemainTimes = self.lastEventData.spec_data.rand_event.select_event.remainder_time
		end

		if self.lastEventData.spec_data.rand_event.select_event.sub_event then
			self.subEventData = self.lastEventData.spec_data.rand_event.select_event.sub_event
		end
	end

	self.monsterHpInfo = nil

	if (utils.tableIsContainsElement(Const.NEW_MAZE_BATTLE_EVENT, self.lastEventData.node_type) or self.lastEventData.node_type == Const.NEW_MAZE_NODE_EVENT_TYPE.RandEvent) and self.lastEventData.fight_monster then
		self.monsterHpInfo = self.lastEventData.fight_monster.record or {}
	end

	self.shopItems = nil

	if self.lastEventData.shop_item and #self.lastEventData.shop_item ~= 0 then
		self.shopItems = {}

		for i, shopItem in ipairs(self.lastEventData.shop_item) do
			table.insert(self.shopItems, shopItem.item)
		end
	end

	self.lastRandMultiAward = nil
	self.isFeatureMultiAward = nil

	if self.lastEventData.last_rand_multi_award and self.lastEventData.last_rand_multi_award[1] then
		self.lastRandMultiAward = {}

		local multiAward = self.lastEventData.last_rand_multi_award[1]

		if multiAward and multiAward.data and multiAward.data[1] then
			for i, data in ipairs(multiAward.data) do
				table.insert(self.lastRandMultiAward, data.item)
			end

			self.lastRandMultiAwardType = multiAward.type

			if multiAward.reason and multiAward.reason == Const.NEW_MAZE_MULTI_AWARD_NOTIFY_TYPE.Feature then
				self.isFeatureMultiAward = true
			end
		end
	end

	self.levelCache = self.cache.level
	self.isPassBoss = self.levelCache.is_pass_boss_fight
	self.assistHeroBaseStar = self.levelCache.aux_hero_star > 0 and self.levelCache.aux_hero_star or 1
	self.nextFightBuff = nil
	self.allFightBuffs = {}

	if Const.OPEN_NEW_MAZE_TALENT then
		for _, info in ipairs(self.levelCache.next_fight_buff) do
			local buffData = ResNewMazeDebuff[info.id]

			if buffData then
				info.canUseCount = buffData.max_use_count - info.use_count
			end

			if info.canUseCount and info.canUseCount > 0 then
				table.insert(self.allFightBuffs, info)
			end
		end
	else
		for _, info in ipairs(self.levelCache.next_fight_buff) do
			local buffData = ResNewMazeDebuff[info.id]

			if buffData then
				info.canUseCount = buffData.max_use_count - info.use_count
			end

			if info.canUseCount and info.canUseCount > 0 then
				self.nextFightBuff = info.id

				break
			end
		end
	end

	self.featureUseRecord = nil

	if self.levelCache.feature_record and #self.levelCache.feature_record ~= 0 then
		self.featureUseRecord = self.levelCache.feature_record
	end

	if Const.NEW_MAZE_ITERATION_OPEN then
		if self.seasonCache.inherit_pool then
			self.inheritHeroPool = self.seasonCache.inherit_pool.inherit_hero or {}
			self.inheritPoolFlags = ClientUtils.getBitsDictFromByteString(self.seasonCache.inherit_pool.settle_flag)
			self.inheritHeroPoolFlag = self.inheritPoolFlags[Const.NEW_MAZE_INHERIT_TYPE_HERO] or false
		end

		if self.seasonCache.inherit_select then
			self.inheritSelHeros = self.seasonCache.inherit_select.select_hero or {}
			self.inheritselFlags = ClientUtils.getBitsDictFromByteString(self.seasonCache.inherit_select.select_flag)
			self.inheritSelHerosFlag = self.inheritselFlags[Const.NEW_MAZE_INHERIT_TYPE_HERO] or false
		end

		self.curLayerNodeId = self.layerCache.cur_node_id or 0
		self.levelStatus = self.levelCache.status or 0
		self.previewBossData = self.levelCache.preview_boss or {}
	end

	self.heroInitSolder = self.seasonCache.init_hero_info

	self:initTalentData(self.seasonCache.talent_pool.talent)

	local oldTickets = self.tickets

	self.tickets = self.attr.tickets

	if oldTickets and oldTickets ~= self.tickets or oldTickets == nil then
		CurAvatar:onItemUpdateNotify("MoneyUpdate", {}, {
			{
				id = self.miscData.ticket_item_id,
				num = self.tickets
			}
		})
	end

	self.coin = self.attr.coin
	self.redheart = self.attr.redheart
	self.talentPoint = self.attr.talentpoint
	self.curCycle = self.seasonCache.cur_cycle
	self.battleCnt = self.statistic.battle_cnt
	self.usedHalo = {}
	self.maxUserHaloNum = self:getCurMaxHaloNumByShopLevel()

	self:initUserHaloData()

	self.allHeroDic = {}
	self.newMazeRelicHeroDic = {}
	self.newMazeHeroRelicDic = {}

	self:initBaseStar()

	self.allHeros = self:initAllHeros()

	self:initHeroCharacter()
	self:checkCanWearRelicNewMazeHero()
end

function ActivityDataNewMaze:initTalentData(talentState)
	self.talentState = talentState
	self.shopRefreshCost = self.miscData.shop_refresh_cost
	self.battleGoldAdd = 0
	self.battleExpAdd = 0

	for _, info in ipairs(self.talentState) do
		local groupData = ResNewMazeTalent[info.group]

		groupData = groupData[info.grade]

		if groupData then
			if groupData.type == 2 then
				self.shopRefreshCost = self.shopRefreshCost - groupData.param1
			elseif groupData.type == 1 then
				self.battleGoldAdd = self.battleGoldAdd + groupData.param1
			elseif groupData.type == 4 then
				self.battleExpAdd = self.battleExpAdd + groupData.param1
			end
		end
	end
end

function ActivityDataNewMaze:initAllHeros(checkBattleFormation)
	local allHeros = {}

	for i, heroData in pairs(self.bagHeros or {}) do
		local hero

		if Const.NEW_MAZE_ITERATION_OPEN then
			hero = self:getPerfectHero(heroData.id, heroData.outside_relic_id, checkBattleFormation)
			hero.gid = tostring(hero.id)

			if heroData.outside_relic_id then
				self.newMazeRelicHeroDic[heroData.outside_relic_id] = hero.gid
				self.newMazeHeroRelicDic[hero.gid] = heroData.outside_relic_id
			end
		else
			hero = self:getPerfectHero(heroData.id, nil, checkBattleFormation)
			hero.gid = tostring(hero.id)
		end

		local mazeSolder = {}

		if heroData.fetter1_id and heroData.fetter1_id > 0 then
			table.insert(mazeSolder, heroData.fetter1_id)
		end

		if heroData.fetter2_id and heroData.fetter2_id > 0 then
			table.insert(mazeSolder, heroData.fetter2_id)
		end

		if heroData.fetter3_id and heroData.fetter3_id > 0 then
			table.insert(mazeSolder, heroData.fetter3_id)
		end

		hero:setMazeSolder(mazeSolder)

		self.allHeroDic[hero.gid] = hero

		table.insert(allHeros, hero)
	end

	local assistNum = #self.assistHeroIds - #self.inheritSelHeros

	for i = 1, assistNum do
		local assistHeroId = self.assistHeroIds[i]
		local hero = self:getPrefectAssistHero(assistHeroId)

		hero.gid = tostring(assistHeroId)
		self.allHeroDic[hero.gid] = hero

		table.insert(allHeros, hero)
	end

	return allHeros
end

function ActivityDataNewMaze:getInheritPoolHeros()
	local heros = {}

	for i, v in ipairs(self.inheritHeroPool or {}) do
		table.insert(heros, v)
	end

	return heros
end

function ActivityDataNewMaze:getInheritSelHeros()
	local heros = {}

	for i, v in ipairs(self.inheritSelHeros or {}) do
		table.insert(heros, v)
	end

	return heros
end

function ActivityDataNewMaze:getAllCanInheritHeros()
	local heros = {}

	for i, hero in pairs(self.allHeroDic or {}) do
		if self:isCanInheritPool(hero.id) then
			table.insert(heros, hero)
		end
	end

	return heros
end

function ActivityDataNewMaze:isCanInheritPool(heroId)
	if heroId == self.heroId or heroId == self.auxHeroId then
		return false
	end

	for i, assistHeroId in ipairs(self.assistHeroIds) do
		if assistHeroId == heroId then
			return false
		end
	end

	for i, hero in pairs(self.inheritHeroPool or {}) do
		if hero.hero_id == heroId then
			return false
		end
	end

	return true
end

function ActivityDataNewMaze:isInheriting(heroId)
	for i, hero in pairs(self.inheritSelHeros or {}) do
		if hero.hero_id == heroId then
			return true
		end
	end

	return false
end

function ActivityDataNewMaze:getAllInheritPoolHeros()
	local heros = {}

	for i, hero in pairs(self.inheritHeroPool or {}) do
		if self.allHeroDic[tostring(hero.hero_id)] then
			table.insert(heros, self.allHeroDic[tostring(hero.hero_id)])
		end
	end

	return heros
end

function ActivityDataNewMaze:getCanWearRelicsInNewMaze(hero)
	local outsideRelics = {}

	if Const.NEW_MAZE_ITERATION_OPEN then
		for gid, relic in pairs(CurAvatar.bagRelics) do
			if (not self.newMazeRelicHeroDic[relic.id] or self.newMazeRelicHeroDic[relic.id] == hero.gid) and relic:isCanBeWear(hero) and relic.heroIdLimit then
				local outsideRelic = BaseObject.CopyObject(relic)

				table.insert(outsideRelics, outsideRelic)
			end
		end
	end

	return outsideRelics
end

function ActivityDataNewMaze:checkCanWearRelicNewMazeHero()
	local canWearRelicNewMazeHeroDic = {}
	local canWearRelicNewMazeHeroList = {}

	if Const.NEW_MAZE_ITERATION_OPEN then
		for gid, hero in pairs(self.allHeroDic) do
			if hero and not hero:getRelic() then
				for gid, relic in pairs(CurAvatar.bagRelics) do
					if not self.newMazeRelicHeroDic[relic.id] and relic:isCanBeWear(hero) and relic.heroIdLimit then
						canWearRelicNewMazeHeroDic[hero.gid] = true

						table.insert(canWearRelicNewMazeHeroList, hero.gid)
					end
				end
			end
		end

		RedDotManager.setKeyState(UIConst.RD_HINT_NEW_MAZE_HERO_PREVIEW, #canWearRelicNewMazeHeroList > 0)
	end

	return canWearRelicNewMazeHeroDic
end

function ActivityDataNewMaze:initBaseStar()
	if self.levelMiscData[self.ratingLevel] then
		self.baseStar = self.levelMiscData[self.ratingLevel].guarantee_star
	end
end

function ActivityDataNewMaze:initHeroCharacter()
	self.upHeroCharacterData = {}

	if self.miscData.new_hero_feature1 and ResNewMazeFeature[self.miscData.new_hero_feature1] then
		table.insert(self.upHeroCharacterData, ResNewMazeFeature[self.miscData.new_hero_feature1])
	end

	if self.miscData.new_hero_feature2 and ResNewMazeFeature[self.miscData.new_hero_feature2] then
		table.insert(self.upHeroCharacterData, ResNewMazeFeature[self.miscData.new_hero_feature2])
	end
end

function ActivityDataNewMaze:initUserHaloData()
	for i, halo in pairs(self.bagHalos or {}) do
		if halo.is_equip and halo.is_equip == 1 then
			table.insert(self.usedHalo, halo.id)
		end
	end
end

function ActivityDataNewMaze:getRemainOpenTime()
	return self.endTime - ClientUtils.getServerTime()
end

function ActivityDataNewMaze:getResetTime()
	return self.nextTick - ClientUtils.getServerTime()
end

function ActivityDataNewMaze:getLeftTimeToFreeze(...)
	if self.actObject.curState == Const.OPACT_STATE_CLOSE or self.actObject.curState == Const.OPACT_STATE_FREEZE then
		return -1
	end

	if self.freezeTime then
		return self.freezeTime - ClientUtils.getServerTime()
	end

	return -1
end

function ActivityDataNewMaze:onStateChange(opActState)
	if self.actObject:inFreeze() then
		local mainDlg = UIManager.tryGetUI("newMazeMainDlg")

		if mainDlg then
			local freezeDisableDlgs = {
				"newMazeStoreDlg",
				"newMazeChooseThreeDlg",
				"newMazeRandomDetailDlg",
				"newMazeChangeHeroDlg"
			}

			for _, name in pairs(freezeDisableDlgs) do
				local subUI = UIManager.tryGetUI(name)

				if subUI then
					subUI:setVisible(false)
				end
			end
		end
	elseif self.actObject.curState == Const.OPACT_STATE_CLOSE then
		local mainDlg = UIManager.tryGetUI("newMazeMainDlg")

		if mainDlg then
			mainDlg:setVisible(false)

			local closeDisableDlgs = {
				"newMazeChooseDlg",
				"newMazeStoreDlg",
				"newMazeStoreLvDlg",
				"newMazeChooseThreeDlg",
				"newMazeRandomDetailDlg",
				"newMazeChangeHeroDlg",
				"newMazeBoxDetailDlg",
				"newMazeEventDetailDlg"
			}

			for _, name in pairs(closeDisableDlgs) do
				local subUI = UIManager.tryGetUI(name)

				if subUI then
					subUI:setVisible(false)
				end
			end
		end
	end
end

function ActivityDataNewMaze:getCoin()
	return self.coin
end

function ActivityDataNewMaze:getAllTableHeroCount()
	local count = 0

	for i, hero in pairs(ResNewMazeHero) do
		if ClientUtils.isHeroValidById(hero.id) and hero.quality >= 2 then
			count = count + 1
		end
	end

	return count
end

function ActivityDataNewMaze:getThreeLabelHeroList()
	local heroList = {}

	for i, hero in pairs(self.bagHeros or {}) do
		if hero.id ~= self.heroId and hero.fetter1_id > 0 and hero.fetter2_id > 0 and hero.fetter3_id > 0 then
			table.insert(heroList, {
				id = hero.id
			})
		end
	end

	return heroList
end

function ActivityDataNewMaze:getSaleHeroListExceptUp()
	local heroList = {}

	for i, hero in pairs(self.bagHeros or {}) do
		if hero.id ~= self.heroId then
			local labelNum = 0

			if ResNewMazeHero[hero.id].team_label then
				labelNum = labelNum + 1
			end

			if ResNewMazeHero[hero.id].feature_label1 then
				labelNum = labelNum + 1
			end

			if ResNewMazeHero[hero.id].feature_label2 then
				labelNum = labelNum + 1
			end

			table.insert(heroList, {
				id = hero.id,
				type = Const.NEW_MAZE_SHOP_ITEM_TYPE.Hero,
				labelNum = labelNum
			})
		end
	end

	table.sort(heroList, function(a, b)
		return a.labelNum < b.labelNum
	end)

	return heroList
end

function ActivityDataNewMaze:getSaleRelicsListExceptUp()
	local relicList = {}

	for i, relic in pairs(self.bagRelics or {}) do
		if ResNewMazeRelic[relic.id].hero_exclusive_id and ResNewMazeRelic[relic.id].hero_exclusive_id == self.heroId then
			-- block empty
		else
			table.insert(relicList, {
				id = relic.id,
				type = Const.NEW_MAZE_SHOP_ITEM_TYPE.Relic
			})
		end
	end

	table.sort(relicList, function(a, b)
		return ResNewMazeRelic[a.id].rarity < ResNewMazeRelic[b.id].rarity
	end)

	return relicList
end

function ActivityDataNewMaze:getAllHaloList()
	local haloList = {}

	for i, halo in pairs(self.bagHalos or {}) do
		table.insert(haloList, {
			id = halo.id,
			type = Const.NEW_MAZE_SHOP_ITEM_TYPE.Halo
		})
	end

	return haloList
end

local function addOneHeroToFetter(fetterType, hero, inBattleFormation, allFettersList)
	if not fetterType then
		return
	end

	local heroId = hero.id
	local curFettersData

	for _, fettersData in ipairs(allFettersList) do
		if fetterType == fettersData.type then
			if fetterType == Const.SPECIAL_FETTERS_TYPE then
				if not utils.tableIsContainsElement(fettersData.heros, hero.career) then
					table.insert(fettersData.heros, hero.career)

					fettersData.num = fettersData.num + 1
				end
			else
				fettersData.num = fettersData.num + 1

				table.insert(fettersData.heros, heroId)
			end

			curFettersData = fettersData

			break
		end
	end

	if not curFettersData then
		curFettersData = {
			num = 1,
			formationNum = 0,
			type = fetterType,
			heros = {
				heroId
			},
			formationHeros = {},
			halo = {},
			notUseHalo = {}
		}

		table.insert(allFettersList, curFettersData)
	end

	if inBattleFormation then
		if fetterType == Const.SPECIAL_FETTERS_TYPE then
			if not utils.tableIsContainsElement(curFettersData.formationHeros, hero.career) then
				curFettersData.formationNum = curFettersData.formationNum + 1
			end

			table.insert(curFettersData.formationHeros, hero.career)
		else
			curFettersData.formationNum = curFettersData.formationNum + 1

			table.insert(curFettersData.formationHeros, heroId)
		end
	end
end

function ActivityDataNewMaze:getAllFetters(dragFormation)
	local formation = CurAvatar:getNowFormation(Const.FORMATION_NEW_MAZE)

	if dragFormation then
		formation = dragFormation
	end

	local allFettersList = {}

	table.insert(allFettersList, {
		num = 0,
		formationNum = 0,
		type = Const.SPECIAL_FETTERS_TYPE,
		heros = {},
		formationHeros = {},
		halo = {},
		notUseHalo = {}
	})

	for i, heroData in ipairs(self.bagHeros or {}) do
		local heroId = heroData.id
		local hero = BaseObject.GetObject(heroId)

		if ResNewMazeHero[heroId] then
			local inBattleFormation = formation[tostring(heroId)] ~= nil

			if heroData.fetter1_id > 0 then
				addOneHeroToFetter(heroData.fetter1_id, hero, inBattleFormation, allFettersList)
			end

			if heroData.fetter2_id > 0 then
				addOneHeroToFetter(heroData.fetter2_id, hero, inBattleFormation, allFettersList)
			end

			if heroData.fetter3_id > 0 then
				addOneHeroToFetter(heroData.fetter3_id, hero, inBattleFormation, allFettersList)
			end

			addOneHeroToFetter(Const.SPECIAL_FETTERS_TYPE, hero, inBattleFormation, allFettersList)
		end
	end

	for _, halo in ipairs(self.bagHalos or {}) do
		local fetterType = ResNewMazeHalo[halo.id].label
		local isHave = false

		for _, fettersData in pairs(allFettersList or {}) do
			if fettersData.type == fetterType then
				if utils.tableIsContainsElement(self.usedHalo, halo.id) then
					table.insert(fettersData.halo, halo.id)
				else
					if fettersData.notUseHalo == nil then
						fettersData.notUseHalo = {}
					end

					table.insert(fettersData.notUseHalo, halo.id)
				end

				isHave = true

				break
			end
		end

		if not isHave then
			if utils.tableIsContainsElement(self.usedHalo, halo.id) then
				table.insert(allFettersList, {
					num = 0,
					formationNum = 0,
					type = fetterType,
					heros = {},
					formationHeros = {},
					halo = {
						halo.id
					},
					notUseHalo = {}
				})
			else
				table.insert(allFettersList, {
					num = 0,
					formationNum = 0,
					type = fetterType,
					heros = {},
					formationHeros = {},
					halo = {},
					notUseHalo = {
						halo.id
					}
				})
			end
		end
	end

	table.sort(allFettersList, function(a, b)
		if a.type ~= Const.SPECIAL_FETTERS_TYPE == (b.type ~= Const.SPECIAL_FETTERS_TYPE) then
			local activeNumA = a.formationNum + utils.getTableElemCount(a.halo)
			local activeNumb = b.formationNum + utils.getTableElemCount(b.halo)

			if activeNumA ~= activeNumb then
				return activeNumb < activeNumA
			else
				local haveNumA = a.num + utils.getTableElemCount(a.halo)
				local haveNumB = b.num + utils.getTableElemCount(b.halo)

				if haveNumA ~= haveNumB then
					return haveNumB < haveNumA
				else
					return a.type < b.type
				end
			end
		else
			return a.type ~= Const.SPECIAL_FETTERS_TYPE
		end
	end)

	return allFettersList
end

function ActivityDataNewMaze:getOneFetters(fetterType, dragFormation)
	local fetters = self:getAllFetters(dragFormation)

	for _, info in ipairs(fetters) do
		if info.type == fetterType then
			return info
		end
	end

	return {
		num = 0,
		formationNum = 0,
		type = fetterType,
		heros = {},
		formationHeros = {},
		halo = {},
		notUseHalo = {}
	}
end

function ActivityDataNewMaze:getCurMaxHaloNumByShopLevel()
	local levelNum = 0

	for i, data in pairs(self.shopTableData) do
		if data.shop_level == self.shop.level then
			levelNum = data.allow_equip_halo_num

			break
		end
	end

	levelNum = levelNum + self.attr.potion

	return levelNum
end

function ActivityDataNewMaze:checkHaloPreviewRed()
	local maxUserHaloNum = self:getCurMaxHaloNumByShopLevel()

	if maxUserHaloNum < #self.bagHalos then
		RedDotManager.setKeyState(UIConst.RD_HINT_NEW_MAZE_HALO_PREVIEW, true)
	end
end

function ActivityDataNewMaze:getPerfectHero(heroId, outsideRelicId, checkBattleFormation)
	local hero = BaseObject.GetObject(heroId)

	hero.isNotCircleHero = true

	local wearedRelic

	if Const.NEW_MAZE_ITERATION_OPEN and outsideRelicId and CurAvatar.bagRelics[outsideRelicId] then
		wearedRelic = BaseObject.CopyObject(CurAvatar.bagRelics[outsideRelicId])
	end

	hero = utils.getCircleBattleHero(hero, wearedRelic)

	if hero then
		local maxStarHero

		for i, h in pairs(CurAvatar.heroDic) do
			if h.id == hero.id and (maxStarHero and maxStarHero.star < h.star or maxStarHero == nil) then
				maxStarHero = h
			end
		end

		hero.star = self.baseStar

		if maxStarHero then
			hero:setPaintData(maxStarHero:getPaintData())
			hero:setPaintPlusData(maxStarHero:getPaintPlusData())

			if not Const.NEW_MAZE_ITERATION_OPEN and maxStarHero.relicId then
				hero.relicId = maxStarHero.relicId
				hero.relic = maxStarHero:getRelic()
			end

			if maxStarHero.star > self.baseStar then
				hero.star = maxStarHero.star
			end
		end

		if checkBattleFormation then
			local formation = CurAvatar:getNowFormation(Const.FORMATION_NEW_MAZE)

			if formation[tostring(heroId)] then
				hero.inBattleFormation = true
			end
		end

		local heroData = self:getBagHeroData(heroId)

		if heroData then
			local mazeSolder = {}

			if heroData.fetter1_id and heroData.fetter1_id > 0 then
				table.insert(mazeSolder, heroData.fetter1_id)
			end

			if heroData.fetter2_id and heroData.fetter2_id > 0 then
				table.insert(mazeSolder, heroData.fetter2_id)
			end

			if heroData.fetter3_id and heroData.fetter3_id > 0 then
				table.insert(mazeSolder, heroData.fetter3_id)
			end

			hero:setMazeSolder(mazeSolder)
		end

		return hero
	end

	return BaseObject.GetObject(heroId)
end

function ActivityDataNewMaze:getPrefectAssistHero(heroId)
	local hero = BaseObject.GetObject(heroId)

	hero.isNotCircleHero = true
	hero = utils.getCircleBattleHero(hero)

	if hero then
		hero.star = self.assistHeroBaseStar

		return hero
	end

	return BaseObject.GetObject(heroId)
end

function ActivityDataNewMaze:getLayerAwardData()
	local data = {}

	for i, award in pairs(self.awardTableData) do
		table.insert(data, award)
	end

	table.sort(data, function(a, b)
		return a.id < b.id
	end)

	return data
end

function ActivityDataNewMaze:getAchiAwardData()
	local data = {}

	if self.ratingLevel > 1 then
		for achieveType, achieveData in pairs(self.achieveData) do
			if achieveType == Const.NEW_MAZE_ADVANCE_ACTIVE_ACHIEVE_TYPE then
				for i, v in ipairs(achieveData) do
					table.insert(data, v)
				end
			end
		end
	end

	return data
end

function ActivityDataNewMaze:getActiveAwardData()
	local data = {}

	if self.ratingLevel > 1 then
		for achieveType, achieveData in pairs(self.achieveData) do
			if achieveType == Const.NEW_MAZE_NORMAL_ACTIVE_ACHIEVE_TYPE then
				table.insert(data, achieveData[1])
			end
		end
	end

	return data
end

function ActivityDataNewMaze:getSkillAwardData()
	local data = {}

	if self.ratingLevel > 1 then
		for achieveType, achieveData in pairs(ResNewMazeAchieve) do
			for i, v in ipairs(achieveData) do
				table.insert(data, v)
			end
		end
	end

	return data
end

function ActivityDataNewMaze:getNewMazeAchieveProgress(newMazeAchieveType)
	for i, data in pairs(self.achieveSpecData or {}) do
		if newMazeAchieveType == data.type then
			return data.progress
		end
	end

	return 0
end

function ActivityDataNewMaze:canShowOnRank(nowScore)
	local limitScore = self.miscData.rank_score

	if Const.OPEN_NEW_MAZE_TALENT then
		nowScore = math.floor(nowScore / Const.RANK_NEW_MAZE_SCORE_RATE)

		return limitScore <= nowScore
	else
		return limitScore <= nowScore
	end
end

function ActivityDataNewMaze:onMultiAwardSave(items)
	self.exitBattleMultiAward = items
end

function ActivityDataNewMaze:onNewMazeOpenResp(level)
	self.ratingLevel = level
end

function ActivityDataNewMaze:onNodeSelectResp(data)
	self.lastEventData = data
end

function ActivityDataNewMaze:onNewMazeShopItemUpdateNotify(items, cur_coin_num)
	self.shopItems = items

	local newMazeStoreDlg = UIManager.tryGetUI("newMazeStoreDlg")

	if newMazeStoreDlg then
		if self.coin == cur_coin_num then
			MsgManager.notice(ResNewMazeDisplay[13060068].desc)
		end
	else
		newMazeStoreDlg = UIManager.getUI("newMazeStoreDlg", true)
	end

	self.coin = cur_coin_num

	local isRefresh = true

	newMazeStoreDlg:setData(self.shopItems, isRefresh)
end

function ActivityDataNewMaze:onNewMazeShopPurchase(item, cur_coin_num)
	local newMazeStoreDlg = UIManager.tryGetUI("newMazeStoreDlg")

	if newMazeStoreDlg then
		newMazeStoreDlg:refreshBuyItem(self.shopItems)
		newMazeStoreDlg:refreshCoinNum()
		newMazeStoreDlg:refreshFettersUI()
		newMazeStoreDlg:flyImageToUI()
	end

	MsgManager.notice(Lang.get(1714))
end

function ActivityDataNewMaze:onNewMazeShopSell(item, cur_coin_num)
	self.coin = cur_coin_num

	if item.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Hero then
		for i, hero in pairs(self.bagHeros) do
			if hero.id == item.id then
				table.remove(self.bagHeros, i)

				break
			end
		end

		self.allHeros = self:initAllHeros()

		local newMazeStoreDlg = UIManager.tryGetUI("newMazeStoreDlg")

		if newMazeStoreDlg then
			newMazeStoreDlg:refreshSaleHeroItem()
			newMazeStoreDlg:refreshCoinNum()
			newMazeStoreDlg:refreshFettersUI()
		end
	elseif item.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Relic then
		for i, relic in pairs(self.bagRelics) do
			if relic.id == item.id then
				table.remove(self.bagRelics, i)

				break
			end
		end

		local newMazeStoreDlg = UIManager.tryGetUI("newMazeStoreDlg")

		if newMazeStoreDlg then
			newMazeStoreDlg:refreshSaleRelicsItem()
			newMazeStoreDlg:refreshCoinNum()
			newMazeStoreDlg:refreshFettersUI()
		end
	elseif item.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Halo then
		for i, halo in pairs(self.bagHalos) do
			if halo.id == item.id then
				table.remove(self.bagHalos, i)

				break
			end
		end

		local newMazeStoreDlg = UIManager.tryGetUI("newMazeStoreDlg")

		if newMazeStoreDlg then
			newMazeStoreDlg:refreshSaleHaloItem()
			newMazeStoreDlg:refreshCoinNum()
			newMazeStoreDlg:refreshFettersUI()
		end
	end

	MsgManager.notice(Lang.get(3377))
end

function ActivityDataNewMaze:onNewMazeItemChangeNotify(items)
	if items[1] and items[1].type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Halo then
		self:checkHaloPreviewRed()
	end
end

function ActivityDataNewMaze:onNewMazeHaloEquip(id)
	table.insert(self.usedHalo, id)

	for i, halo in pairs(self.bagHalos) do
		if halo.id == id then
			halo.is_equip = 1
		end
	end
end

function ActivityDataNewMaze:onNewMazeHaloUnEquip(id)
	for i, haloId in pairs(self.usedHalo) do
		if haloId == id then
			table.remove(self.usedHalo, i)

			break
		end
	end

	for i, halo in pairs(self.bagHalos) do
		if halo.id == id then
			halo.is_equip = 0
		end
	end
end

function ActivityDataNewMaze:onFeatureUseResp(id, layer)
	if not self.featureUseRecord then
		self.featureUseRecord = {}
	end

	local isHave = false

	for i, record in pairs(self.featureUseRecord) do
		if record.id == id then
			record.last_use_layer = layer
			isHave = true
		end
	end

	if not isHave then
		table.insert(self.featureUseRecord, {
			id = id,
			last_use_layer = layer
		})
	end
end

function ActivityDataNewMaze:onNewMazeShopLevelUpNotify()
	local haloNum = self:getCurMaxHaloNumByShopLevel()

	MsgManager.notice(string.format(ResNewMazeDisplay[13060060].desc, self.curShopLv, haloNum))
end

function ActivityDataNewMaze:onNewMazeSetOutsideRelicResp(hero_id, relic_id)
	if relic_id ~= 0 then
		if self.newMazeHeroRelicDic[hero_id] then
			self.newMazeRelicHeroDic[self.newMazeHeroRelicDic[hero_id]] = nil
			self.newMazeHeroRelicDic[hero_id] = nil
		end

		self.newMazeHeroRelicDic[hero_id] = relic_id
		self.newMazeRelicHeroDic[relic_id] = hero_id
	elseif self.newMazeHeroRelicDic[hero_id] then
		self.newMazeRelicHeroDic[self.newMazeHeroRelicDic[hero_id]] = nil
		self.newMazeHeroRelicDic[hero_id] = nil

		MsgManager.notice(Lang.get(1838))
	end

	self:checkCanWearRelicNewMazeHero()

	local newMazeChangeSolderDlg = UIManager.tryGetUI("newMazeChangeSolderDlg")

	if newMazeChangeSolderDlg then
		newMazeChangeSolderDlg:refreshHeroDetailIconNew()
	end
end

function ActivityDataNewMaze:onNewMazeLevelExitResp(op_type, inherit_flag)
	if inherit_flag == 1 then
		local newMazeInheritDlg = UIManager.getUI("newMazeInheritDlg", true)

		newMazeInheritDlg:setData(Const.PUT_IN_INHERIT_POOL, op_type, true)
	else
		self:realSettlementFunc(op_type)
	end
end

function ActivityDataNewMaze:realSettlementFunc(settleType)
	if settleType == Const.NEW_MAZE_SETTLEMENT_TYPE.Next then
		if self.ratingLevel == 1 then
			RPC.opActivityData("kOpActivitySyncMgrData", 0, self.actObject.opId)
			RPC.newMazeOpen(self.actObject.opId)
		else
			if self.tickets < 1 then
				MsgManager.notice(ResNewMazeDisplay[13060005].desc)
			end

			self:openChooseDlg(true)
		end
	elseif settleType == Const.NEW_MAZE_SETTLEMENT_TYPE.Over then
		local bossLayer = 30

		for i, data in pairs(self.nodeTableData[self.ratingLevel]) do
			if data.node_type == Const.NEW_MAZE_BOSS_NODE_TYPE then
				bossLayer = data.layer

				break
			end
		end

		if self.ratingLevel < #self.levelMiscData and bossLayer < self.layer then
			self:openChooseDlg(true)
		else
			self:openChooseDlg()
		end
	elseif settleType == Const.NEW_MAZE_SETTLEMENT_TYPE.Reset then
		RPC.newMazeLevelEnter(self.actObject.opId, Const.NEW_MAZE_LEVEL_ENTER_TYPE.Reset)
	end
end

function ActivityDataNewMaze:openChooseDlg(needPlayAni)
	local mainDlg = UIManager.tryGetUI("newMazeMainDlg")

	if mainDlg then
		mainDlg:setVisible(false)
	end

	local chooseDlg = UIManager.tryGetUI("newMazeChooseDlg")

	if chooseDlg then
		chooseDlg:_setData(needPlayAni)
	else
		chooseDlg = UIManager.getUI("newMazeChooseDlg", true)

		chooseDlg:_setData(needPlayAni)
	end
end

function ActivityDataNewMaze:onNewMazeSelectInheritResp(type)
	self.inheritSelHerosFlag = false
end

function ActivityDataNewMaze:getSolderResolveItemNum()
	return self.resolveItemNum
end

function ActivityDataNewMaze:getSolderItemList()
	local items = {}

	for id, itInfo in pairs(self.bagSolder) do
		table.insert(items, itInfo)
	end

	return items
end

function ActivityDataNewMaze:getBagHeroData(heroId)
	for i, heroData in pairs(self.bagHeros or {}) do
		if heroData.id == heroId then
			return heroData
		end
	end
end

function ActivityDataNewMaze:checkTalentEnable(groupId)
	if not self:isTalentUnlock() then
		return false
	end

	if groupId then
		local groupData = ResNewMazeTalent[groupId]
		local curLevel = 0

		for _, info in ipairs(self.talentState) do
			if info.group == groupId then
				curLevel = info.grade

				break
			end
		end

		groupData = groupData[curLevel + 1]

		if not groupData then
			return false
		end

		local curData = groupData[curLevel] or {}

		if self.talentPoint >= groupData.need_point - (curData.need_point or 0) then
			return true
		else
			return false
		end
	else
		for _, gId in pairs(self.miscData.open_talent_group or {}) do
			if self:checkTalentEnable(gId) then
				return true
			end
		end

		return false
	end
end

function ActivityDataNewMaze:getAllTalentPoint()
	local totalPoint = self.talentPoint

	for _, info in ipairs(self.talentState) do
		local groupData = ResNewMazeTalent[info.group]

		groupData = groupData[info.grade]

		if groupData then
			totalPoint = totalPoint + groupData.need_point
		end
	end

	return totalPoint
end

function ActivityDataNewMaze:isTalentUnlock()
	return Const.OPEN_NEW_MAZE_TALENT and self.curCycle > 0
end

function ActivityDataNewMaze:getHandBookAllFetters()
	local allFettersList = {}

	for heroId, heroData in pairs(ResNewMazeHero) do
		local hero = BaseObject.GetObject(heroId)
		local inBattleFormation = false

		if heroData.team_label then
			addOneHeroToFetter(heroData.team_label, hero, inBattleFormation, allFettersList)
		end

		if heroData.feature_label1 then
			addOneHeroToFetter(heroData.feature_label1, hero, inBattleFormation, allFettersList)
		end

		if heroData.feature_label2 then
			addOneHeroToFetter(heroData.feature_label2, hero, inBattleFormation, allFettersList)
		end
	end

	table.sort(allFettersList, function(a, b)
		return a.type < b.type
	end)

	return allFettersList
end

return ActivityDataNewMaze
