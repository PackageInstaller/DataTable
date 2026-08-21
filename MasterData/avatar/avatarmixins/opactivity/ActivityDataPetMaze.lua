-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataPetMaze.lua

local ResPetMazeMisc = require("ClientData/ResPetMazeMisc")
local ResPetMazeCondition = require("ClientData/ResPetMazeCondition")
local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResPetMazeBPLevel = require("ClientData/ResPetMazeBPLevel")
local ResPetMazeLayer = require("ClientData/ResPetMazeLayer")
local ResPetMazeHpGrade = require("ClientData/ResPetMazeHpGrade")
local ResPetMazeHeroOpactMapping = require("ClientData/ResPetMazeHeroOpactMapping")
local RechargeManager = require("System/Recharge/RechargeManager")
local ShopItem = require("UI/MainState/Trade/ShopItem")
local Hero = require("Common/Object/Hero")
local PlayerPrefs = UnityEngine.PlayerPrefs

UIConst.PET_MAZE_BOSS_STATE_LOCK = 1
UIConst.PET_MAZE_BOSS_STATE_READY = 2
UIConst.PET_MAZE_BOSS_STATE_BATTLEING = 3
UIConst.PET_MAZE_BOSS_STATE_PASS = 4
UIConst.PET_MAZE_BOSS_STATE_CLEAN = 5

local ActivityDataPetMaze = Class("ActivityDataPetMaze", ActivityDataBase)

function ActivityDataPetMaze:updateClientData(actId)
	ActivityDataPetMaze.super.updateClientData(self, actId)

	self.battleHeroNum = 5
	self.assistHeroNum = 5
	self.miscConfig = ResPetMazeMisc[actId]
	self.needFinishNormalAreaCount = self.miscConfig.stage_num
	self.totalAwardTimes = self.miscConfig.award_num

	local bpData = ResPetMazeBPLevel[2]

	self.repeatedIndex = #bpData
	self.repeatedProgress = bpData[self.repeatedIndex][1].star_need - bpData[self.repeatedIndex - 1][1].star_need
	self.historyInfo = {}
	self.historyScore = 0
	self.supportMarkPath = "Atlas/MazzPetAtlas/MazzPetAtlas3"
	self.supportHero_QualityDic = {}
	self.heroJumpIdDic = {}

	for k, v in pairs(ResPetMazeHeroOpactMapping) do
		self.heroJumpIdDic[v.hero_id] = v.jump_id
	end
end

function ActivityDataPetMaze:updateRoleData(roleData)
	ActivityDataPetMaze.super.updateRoleData(self, roleData)

	local mazeData = roleData.pet_maze

	self.season = mazeData.season
	self.seasonStar = mazeData.season_star
	self.layer = mazeData.level
	self.specialHeroId = mazeData.spec_hero
	self.leftAwardTimes = mazeData.award_cnt
	self.selectHeroList = {}

	if mazeData.formation_hero then
		for i = 1, #mazeData.formation_hero do
			table.insert(self.selectHeroList, mazeData.formation_hero[i].gid)
		end
	end

	self.normalAreaDataList = {}
	self.normalAreaDataDic = {}
	self.supportHero_QualityDic = {}

	local normalAreaList = mazeData.stage

	if normalAreaList then
		for i = 1, #normalAreaList do
			local area = normalAreaList[i]
			local areaData = {
				id = area.id,
				specialHeroId = area.spec_support,
				quality = area.quality,
				star = area.star or 0,
				is_pass = area.is_pass and area.is_pass > 0 or false,
				condition = area.condition or {}
			}

			self.supportHero_QualityDic[area.spec_support] = area.quality
			areaData.selectHeroList = {}

			if area.support then
				for j = 1, #area.support do
					local hero = utils.getSamepleHero(area.support[j])

					if hero then
						if hero.id == area.spec_support then
							table.insert(areaData.selectHeroList, 1, hero)
						else
							table.insert(areaData.selectHeroList, hero)
						end
					end
				end
			end

			table.insert(self.normalAreaDataList, areaData)

			self.normalAreaDataDic[area.id] = areaData
		end
	end

	local bossData = mazeData.boss

	self.bossAreaData = {
		id = bossData.type,
		is_pass = bossData.is_pass and bossData.is_pass > 0 or false,
		score = bossData.score
	}

	local buffList = {}

	if bossData.buff then
		for i = 1, #bossData.buff do
			table.insert(buffList, bossData.buff[i].buff)
		end
	end

	self.bossAreaData.buffList = buffList
	self.checkMysteryShopTrigger = mazeData.mystery_shop_triggered and mazeData.mystery_shop_triggered > 0 or false
	self.mysteryData = mazeData.mysteryshop and mazeData.mysteryshop.cur_goods_item

	self:initPlayerPetMazeData()

	self.checkClean = mazeData.sweep_level and mazeData.sweep_level > 0

	self:refreshBossRedDot()
	self:refreshNewSeasonRedDot()
end

function ActivityDataPetMaze:initPlayerPetMazeData()
	local playerMazeData = CurAvatar.petMazeData or {}

	self.historyScore = playerMazeData.star or 0
	self.historyInfo = {}
	self.endHistorySeason = 1

	local firstPhase

	for _, itemInfo in ipairs(playerMazeData.bp or {}) do
		local newInfo = {}

		newInfo.hasBuy = itemInfo.is_super == 1
		newInfo.freeGet = utils.getBitsDictFromByteString(itemInfo.normal_awarded.bits)
		newInfo.giftGet = utils.getBitsDictFromByteString(itemInfo.super_awarded.bits)
		newInfo.phase = math.max(1, itemInfo.season)
		self.historyInfo[newInfo.phase] = newInfo

		if firstPhase == nil then
			firstPhase = newInfo.phase
		end

		if newInfo.phase + 1 > self.endHistorySeason then
			self.endHistorySeason = newInfo.phase + 1
		end
	end

	self.startHistorySeason = firstPhase or 1

	local petMazeAchiDlg = UIManager.tryGetUI("petMazeAchiDlg")

	if petMazeAchiDlg then
		petMazeAchiDlg:updateActivityData()
	end

	local checkAchiRedDot = self:checkHistoryNew()

	RedDotManager.setKeyState(UIConst.RD_HINT_PET_MAZE_ACHI, checkAchiRedDot)
end

function ActivityDataPetMaze:updateMgrData(opActivityMgrItem)
	ActivityDataPetMaze.super.updateMgrData(self, opActivityMgrItem)

	local mgrData = opActivityMgrItem.specdata.pet_maze

	if mgrData then
		self.seasonEndTime = mgrData.next_season_tick
		self.checkRankOpen = mgrData.rank_is_open and mgrData.rank_is_open > 0
	end
end

function ActivityDataPetMaze:setMysteryData(goodsItems)
	self.mysteryData = goodsItems

	local petMazeMainDlg = UIManager.tryGetUI("petMazeMainDlg")

	if petMazeMainDlg then
		petMazeMainDlg:refreshBtnStore()
	end
end

function ActivityDataPetMaze:checkMysterySoldOut()
	local checkSoldOut = true

	if self.mysteryData then
		for i = 1, #self.mysteryData do
			local data = self.mysteryData[i]

			if data.goods_type == Const.MYSTERY_SHOP_TYPE_ITEM then
				local shopItem = ShopItem(0, data.goods_id, data.special.buy_count.count, CurAvatar:getTimeCounter(Const.TimeTICounterTypeShop, data.goods_id))

				if not shopItem:isSoldOut() then
					checkSoldOut = false

					break
				end
			else
				local rechargeId = data.goods_id
				local realShowRechargeId = rechargeId

				if CurAvatar.rechargeReplaced and CurAvatar.rechargeReplaced[rechargeId] then
					local newRechargeInfo = CurAvatar.rechargeReplaced[rechargeId]

					if newRechargeInfo then
						local newRechargeId = newRechargeInfo[1]
						local actObj = newRechargeInfo[2]
						local newProduct = RechargeManager.getProductByRechargeId(newRechargeId)

						if newProduct and actObj and actObj:isValid() then
							realShowRechargeId = newRechargeId
						end
					end
				end

				realShowRechargeId = RechargeManager.getNestedId(realShowRechargeId)

				local product = RechargeManager.getProductByRechargeId(realShowRechargeId)

				if not product then
					-- block empty
				elseif product.buyTimesLeft > 0 then
					checkSoldOut = false

					break
				end
			end
		end
	end

	return checkSoldOut
end

function ActivityDataPetMaze:getMysteryAutoOpen()
	local key = CurAvatar.uid .. "_" .. self.actObject.opId .. "MysteryAutoOpen"
	local check = PlayerPrefs.GetInt(key) or 0

	return check > 0
end

function ActivityDataPetMaze:setMysteryAutoOpen()
	local key = CurAvatar.uid .. "_" .. self.actObject.opId .. "MysteryAutoOpen"

	PlayerPrefs.SetInt(key, 1)
end

function ActivityDataPetMaze:getNormalAreaData(stageId)
	return self.normalAreaDataDic and self.normalAreaDataDic[stageId] or nil
end

function ActivityDataPetMaze:getCurFinishNormalAreaCount()
	local num = 0

	for i = 1, #self.normalAreaDataList do
		local areaData = self.normalAreaDataList[i]

		if areaData and areaData.is_pass then
			num = num + 1
		end
	end

	return num
end

function ActivityDataPetMaze:getBossStatus()
	if self.checkClean then
		return UIConst.PET_MAZE_BOSS_STATE_CLEAN
	end

	if not self.bossAreaData then
		return UIConst.PET_MAZE_BOSS_STATE_LOCK
	end

	if self.bossAreaData.is_pass then
		return UIConst.PET_MAZE_BOSS_STATE_PASS
	end

	local curNum = self:getCurFinishNormalAreaCount()

	if curNum < self.needFinishNormalAreaCount then
		return UIConst.PET_MAZE_BOSS_STATE_LOCK
	end

	if self.bossAreaData.score == 0 then
		return UIConst.PET_MAZE_BOSS_STATE_READY
	end

	if self.bossAreaData.score and self.bossAreaData.score > 0 then
		return UIConst.PET_MAZE_BOSS_STATE_BATTLEING
	end
end

function ActivityDataPetMaze:checkPass()
	local bossStatus = self:getBossStatus()
	local isPass = bossStatus == UIConst.PET_MAZE_BOSS_STATE_PASS or bossStatus == UIConst.PET_MAZE_BOSS_STATE_CLEAN

	return isPass
end

function ActivityDataPetMaze:getBossMaxScore(layer, bossId)
	local layerConfig = ResPetMazeLayer[layer]
	local maxScore = 0

	if layerConfig.hp_score_rate then
		maxScore = layerConfig.hp_score_rate * 1000
	else
		local configDic = ResPetMazeHpGrade[bossId]

		for k, v in pairs(configDic) do
			if v.score and maxScore < v.score then
				maxScore = v.score
			end
		end
	end

	return maxScore
end

function ActivityDataPetMaze:getBattleExcludeHeroIdDic()
	local dic = {}

	for i = 1, #self.normalAreaDataList do
		local areaData = self.normalAreaDataList[i]

		if areaData and areaData.is_pass then
			for j = 1, #areaData.selectHeroList do
				local hero = areaData.selectHeroList[j]

				if hero then
					dic[hero.id] = true
				end
			end
		end
	end

	return dic
end

function ActivityDataPetMaze:getSupportExcludeHeroIdDic(stageId)
	local dic = {}

	if #self.selectHeroList > 0 then
		for i = 1, #self.selectHeroList do
			local gid = self.selectHeroList[i]
			local hero = CurAvatar.heroDic[gid]

			if hero then
				dic[hero.id] = true
			end
		end
	end

	for i = 1, #self.normalAreaDataList do
		local areaData = self.normalAreaDataList[i]

		if areaData and areaData.is_pass and areaData.id ~= stageId and areaData.selectHeroList and #areaData.selectHeroList > 0 then
			for j = 1, #areaData.selectHeroList do
				local hero = areaData.selectHeroList[j]

				if hero then
					dic[hero.id] = true
				end
			end
		end
	end

	return dic
end

function ActivityDataPetMaze:checkConditionOK(condId, heros)
	local condConfig = ResPetMazeCondition[condId]

	if not condConfig then
		return false
	end

	local OKNum = 0

	for _, hero in ipairs(heros or {}) do
		if condConfig.check_type == 1 then
			for _, camp in ipairs(condConfig.param or {}) do
				if hero.camp == camp then
					OKNum = OKNum + 1

					break
				end
			end
		elseif condConfig.check_type == 2 then
			for _, career in ipairs(condConfig.param or {}) do
				if hero.career == career then
					OKNum = OKNum + 1

					break
				end
			end
		elseif condConfig.check_type == 3 then
			for _, team in ipairs(condConfig.param or {}) do
				if hero.team == team then
					OKNum = OKNum + 1

					break
				end
			end
		elseif condConfig.check_type == 4 then
			local needStar = condConfig.param[1]

			if needStar <= hero.star then
				OKNum = OKNum + 1
			end
		elseif condConfig.check_type == 5 then
			OKNum = OKNum + hero.step
		elseif condConfig.check_type == 6 then
			OKNum = OKNum + hero.star
		elseif condConfig.check_type == 7 then
			OKNum = OKNum + hero.star

			local paintData = hero:getPaintData()

			if paintData and paintData.resData then
				OKNum = OKNum + paintData.resData.card_show_id + 1
			end
		end
	end

	return OKNum >= condConfig.need_value, OKNum
end

function ActivityDataPetMaze:checkHaveBattleFormation(isTip)
	local num = 0

	for i = 1, #self.selectHeroList do
		local gid = self.selectHeroList[i]
		local hero = CurAvatar.heroDic[gid]

		if hero then
			num = num + 1
		end
	end

	if num == 0 and isTip then
		MsgManager.notice(Lang.get(78057))
	end

	return num > 0, num
end

function ActivityDataPetMaze:startBattle(boss_id, stage_id, pveId, conditionOkList)
	local check, heroNum = self:checkHaveBattleFormation(true)

	if not check then
		return
	end

	if heroNum < self.battleHeroNum then
		local content = ClientUtils.getClientNotice(109)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", content, Functor(self.realStartBattle, self, boss_id, stage_id, pveId, conditionOkList))
	else
		self:realStartBattle(boss_id, stage_id, pveId, conditionOkList)
	end
end

function ActivityDataPetMaze:realStartBattle(boss_id, stage_id, pveId, conditionOkList)
	local formation = CurAvatar:getNowFormation(Const.FORMATION_PET_MAZE) or {}
	local battleData = {}

	battleData.petMazeData = {
		conditionOkList = conditionOkList,
		act_id = self.actObject.opId,
		season = self.season,
		level = self.layer,
		boss_id = boss_id or 0,
		stage_id = stage_id or 0,
		buffs = boss_id and boss_id > 0 and self.bossAreaData.buffList
	}
	battleData.fixedHeros = {}

	local heroIdList = {}

	if boss_id and boss_id > 0 then
		local heroDic = CurAvatar.heroDic
		local excludeHeroIdDic = self:getBattleExcludeHeroIdDic()

		for gid, hero in pairs(heroDic) do
			if not excludeHeroIdDic or not excludeHeroIdDic[hero.id] then
				table.insert(heroIdList, gid)
			end
		end

		battleData.heroPutFilter = {
			[self.specialHeroId] = true
		}
	else
		for i = 1, #self.selectHeroList do
			table.insert(heroIdList, self.selectHeroList[i])
		end
	end

	if #heroIdList > 0 then
		for i = 1, #heroIdList do
			local gid = heroIdList[i]
			local pos = formation[gid] or 0
			local hero = CurAvatar.heroDic[gid]

			if hero then
				if hero.id == self.specialHeroId then
					local layerConfig = ResPetMazeLayer[self.layer]
					local minStar = layerConfig.guarantee_star

					if minStar > hero.star then
						local newHero = utils.getDeepCopyHero(hero)

						newHero.star = minStar
						hero = newHero
					end
				end

				table.insert(battleData.fixedHeros, {
					pos,
					hero
				})
			end
		end
	end

	battleData.formationIdx = Const.FORMATION_PET_MAZE

	CurAvatar:enterFormation(pveId, BattleConst.BATTLE_TYPE_MAZE_PET, battleData)
end

function ActivityDataPetMaze:getSeasonLeftTime()
	return self.seasonEndTime and self.seasonEndTime - ClientUtils.getServerTime() or 0
end

function ActivityDataPetMaze:thisTimeOver()
	return false
end

function ActivityDataPetMaze:getBattlePassData(seasonType)
	if seasonType then
		return ResPetMazeBPLevel[1][1]
	else
		local startPhase = self.startHistorySeason or 1
		local firstPhase
		local endPhase = self.endHistorySeason or 1
		local allData = ResPetMazeBPLevel[2]
		local repeatedData = allData[self.repeatedIndex]
		local outData = {}
		local hasNewPhase = {}

		for phase = startPhase, endPhase do
			local oriData = allData[phase]
			local stateData = self.historyInfo[phase] or {}
			local hasBuy = stateData.hasBuy
			local freeGet = stateData.freeGet or {}
			local giftGet = stateData.giftGet or {}

			if phase > self.repeatedIndex then
				oriData = utils.deepcopy(repeatedData)

				for id, info in ipairs(oriData) do
					info.phase = phase
					info.star_need = info.star_need + (phase - self.repeatedIndex) * self.repeatedProgress
				end
			end

			local lastProgress = oriData[#oriData].star_need

			oriData[1].preProgress = lastProgress - self.repeatedProgress
			hasNewPhase[phase] = false

			for id, info in ipairs(oriData) do
				if self.historyScore >= info.star_need then
					if not freeGet[id] or hasBuy and not giftGet[id] then
						hasNewPhase[phase] = true

						if not firstPhase then
							firstPhase = phase - startPhase + 1

							break
						end
					end
				elseif not firstPhase then
					firstPhase = phase - startPhase + 1

					break
				end
			end

			table.insert(outData, oriData)

			local maxNeed = oriData[#oriData].star_need

			if maxNeed > self.historyScore then
				break
			end
		end

		return outData, firstPhase or #outData, hasNewPhase
	end
end

function ActivityDataPetMaze:getHistoryData(phase)
	return self.historyInfo[phase] or {}
end

function ActivityDataPetMaze:getCurSeasonStar()
	return self.seasonStar
end

function ActivityDataPetMaze:getCurHistoryStar()
	return self.historyScore
end

function ActivityDataPetMaze:checkNew()
	if self:checkHistoryNew() then
		return true
	end
end

function ActivityDataPetMaze:checkHistoryNew()
	local startPhase = self.startHistorySeason or 1
	local endPhase = self.endHistorySeason or 1
	local allData = ResPetMazeBPLevel[2]
	local repeatedData = allData[self.repeatedIndex]

	for phase = startPhase, endPhase do
		local oriData = allData[phase]
		local stateData = self.historyInfo[phase] or {}
		local hasBuy = stateData.hasBuy
		local freeGet = stateData.freeGet or {}
		local giftGet = stateData.giftGet or {}

		if phase > self.repeatedIndex then
			oriData = utils.deepcopy(repeatedData)

			for id, info in ipairs(oriData) do
				info.star_need = info.star_need + (phase - self.repeatedIndex) * self.repeatedProgress
			end
		end

		for id, info in ipairs(oriData) do
			if self.historyScore >= info.star_need and (not freeGet[id] or hasBuy and not giftGet[id]) then
				return true
			end
		end
	end
end

function ActivityDataPetMaze:refreshBossRedDot()
	local status = self:getBossStatus()
	local check = status == UIConst.PET_MAZE_BOSS_STATE_READY

	RedDotManager.setKeyState(UIConst.RD_HINT_PET_MAZE_BOSS, check)
end

function ActivityDataPetMaze:refreshNewSeasonRedDot()
	local season = self:getClientSeason()
	local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_PET_MAZE)
	local checkPetMaze = actObj ~= nil and actObj:isValid()

	RedDotManager.setKeyState(UIConst.RD_HINT_PET_MAZE_NEW_SEASON, checkPetMaze and season ~= self.season)
end

function ActivityDataPetMaze:getClientSeason()
	local key = CurAvatar.uid .. "_" .. self.actObject.opId .. "Season"
	local value = PlayerPrefs.GetInt(key) or 0

	return value
end

function ActivityDataPetMaze:setClientSeason()
	local key = CurAvatar.uid .. "_" .. self.actObject.opId .. "Season"

	PlayerPrefs.SetInt(key, self.season)
	self:refreshNewSeasonRedDot()
end

function ActivityDataPetMaze:onPetMazeSweepResp(layer)
	local ui = UIManager.getUI("petMazeCleanAwardDlg", true)

	if ui then
		ui:setData(self.actObject, layer)
	end
end

return ActivityDataPetMaze
