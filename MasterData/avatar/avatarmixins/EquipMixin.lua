-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\EquipMixin.lua

local Equip = require("Common/Object/Equip")
local Artifact = require("Common/Object/Artifact")
local Relic = require("Common/Object/Relic")
local ResEquipLevelTemplete = require("ClientData/ResEquipLevelTemplete")
local ResEquipReturn = require("ClientData/ResEquipReturn")
local ResArtifactXP = require("ClientData/ResArtifactXP")
local ResArtifactLevelUp = require("ClientData/ResArtifactLevelUp")
local ResEquipSuit = require("ClientData/ResEquipSuit")
local ResItem = require("ClientData/ResItem")
local ResGuideGet = require("ClientData/ResGuideGet")
local ResRelic = require("ClientData/ResRelic")
local ResRandClient = require("ClientData/ResRandClient")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResPlanWithPlayModeConfig = require("ClientData/ResPlanWithPlayModeConfig")
local ResPetRune = require("ClientData/ResPetRune")
local PropHelper = require("Common/FrameBattle/BattleObject/PropHelper")
local DragPlane = require("UI/Control/Com/DragPlane")
local ResEquipTowerCustomEquipEffect = require("ClientData/ResEquipTowerCustomEquipEffect")
local ResEquipRecycleExchange = require("ClientData/ResEquipRecycleExchange")
local ResEquipRecycleReturn = require("ClientData/ResEquipRecycleReturn")
local ResEquipRecycleAward = require("ClientData/ResEquipRecycleAward")
local UserData = require("Helper/UserData")
local EquipMixin = {}

Const.PLAYMODE_CONFIG = {
	{
		id = 1,
		type = BattleConst.BATTLE_TYPE_STAGE,
		name = Lang.get(29924)
	},
	{
		id = 2,
		type = BattleConst.BATTLE_TYPE_STEPTOWER,
		conditionLimitID = Const.CONDITION_LIMIT_STEP_TOWER,
		name = Lang.get(1460)
	},
	{
		id = 3,
		type = BattleConst.BATTLE_TYPE_EQUIPTOWER,
		conditionLimitID = Const.CONDITION_LIMIT_EQUIP_TOWER,
		name = Lang.get(30087)
	},
	{
		id = 4,
		type = BattleConst.BATTLE_TYPE_BOSSTOWER,
		conditionLimitID = Const.CONDITION_LIMIT_BOSS_TOWER,
		name = Lang.get(727)
	},
	{
		id = 5,
		type = BattleConst.BATTLE_TYPE_ASYNC_PVP,
		conditionLimitID = Const.CONDITION_LIMIT_PVP,
		name = Lang.get(29925)
	},
	{
		id = 6,
		type = BattleConst.BATTLE_TYPE_ONCETOWER,
		conditionLimitID = Const.CONDITION_LIMIT_ONCE_TOWER,
		name = Lang.get(1462)
	},
	[8] = {
		id = 8,
		type = BattleConst.BATTLE_TYPE_MAZE,
		conditionLimitID = Const.CONDITION_LIMIT_MAZE,
		name = Lang.get(1461)
	},
	[9] = {
		id = 9,
		type = BattleConst.BATTLE_TYPE_THREE_TEAM_PVP,
		conditionLimitID = Const.CONDITION_LIMIT_MULTIPVP,
		name = Lang.get(29926)
	},
	[10] = {
		id = 10,
		type = BattleConst.BATTLE_TYPE_WORLD_BOSS,
		conditionLimitID = Const.CONDITION_LIMIT_WORLD_BOSS,
		name = Lang.get(1447)
	},
	[13] = {
		id = 13,
		type = BattleConst.BATTLE_TYPE_SEASON_TOWER,
		name = Lang.get(1445)
	},
	[14] = {
		id = 14,
		type = BattleConst.BATTLE_TYPE_RENT,
		name = Lang.get(665)
	}
}

function EquipMixin:initEquipMixin(baseData, syncData)
	self.bagEquips = {}
	self.bagArtifacts = {}
	self.bagRelics = {}
	self.handBookArtifactDic = {}
	self.bagSeasonRelics = {}
	self.bindPlanAndPlayModeDic = {}
	self.lastBattleHeros = {}
	self.lastUsePlanID = syncData.equip_scheme.equip_scheme.sel_id or 0
	self.isSaveingPlan = false
	self.oldCurWearData = nil
	self.coverPlanID = nil

	for index, eInfo in ipairs(syncData.equip_scheme.equip_bag.equip) do
		local equip = Equip(eInfo)

		self.bagEquips[equip.gid] = equip
	end

	self.bagSize[Const.BAG_TYPE_EQUIP] = syncData.equip_scheme.equip_bag.equip_max
	self.equipEvolveOpen = syncData.equip_scheme.equip_bag.evolve or 0

	for index, aInfo in ipairs(syncData.bag.artifact_bag.artifact) do
		local artifact = Artifact(aInfo)

		self.handBookArtifactDic[artifact.id] = 1
		self.bagArtifacts[artifact.gid] = artifact
	end

	self.bagSize[Const.BAG_TYPE_ARTIFACT] = syncData.bag.artifact_bag.artifact_max

	for index, rInfo in ipairs(syncData.bag.relic_bag.relic) do
		local relic = Relic(rInfo)

		self.bagRelics[relic.id] = relic
	end

	for index, rInfo in ipairs(syncData.bag.season_relic_bag.relic) do
		local relic = Relic(rInfo)

		self.bagSeasonRelics[relic.id] = relic
	end

	self:initEquipAdditionalData()

	self.equipPlanDic = {}

	for id, plan in ipairs(syncData.equip_scheme.equip_scheme.state or {}) do
		self.equipPlanDic[plan.id] = {
			id = plan.id,
			name = plan.name
		}
	end

	self.equipPlanVersion = syncData.equip_scheme.equip_scheme.version
	self.commonEquipTipsFuncItem = UIControls.TipsConfig()

	self.commonEquipTipsFuncItem:addConfig(self, Lang.get(932), self.onLockEquip, self.onEquipLockCheck, self.onEquipLockCheck, 1)
	self.commonEquipTipsFuncItem:addConfig(self, Lang.get(1832), self.onDestroyEquip, nil, nil, 2)
	self.commonEquipTipsFuncItem:addConfig(self, Lang.get(1602), self.onTakeOffEquip, nil, self.onEquipTakeOffCheck, 3)
	self.commonEquipTipsFuncItem:addConfig(self, Lang.get(1189), self.onReplaceEquip, nil, self.onEquipReplaceCheck, 4)
	self.commonEquipTipsFuncItem:addConfig(self, Lang.get(920), self.onUpgradeEquip, nil, self.onUpgradeEquipCheck, 5)

	self.commonArtifactTipsFuncItem = UIControls.TipsConfig()

	self.commonArtifactTipsFuncItem:addConfig(self, Lang.get(932), self.onLockArtifact, self.onArtifactLockCheck, self.onArtifactLockCheck, 1)
	self.commonArtifactTipsFuncItem:addConfig(self, Lang.get(1832), self.onDestroyArtifact, self.onArtifactVisibleCheck, nil, 2)
	self.commonArtifactTipsFuncItem:addConfig(self, Lang.get(1602), self.onTakeOffArtifact, nil, self.onArtifactTakeOffCheck, 3)
	self.commonArtifactTipsFuncItem:addConfig(self, Lang.get(1189), self.onReplaceArtifact, nil, self.onArtifactReplaceCheck, 4)
	self.commonArtifactTipsFuncItem:addConfig(self, Lang.get(920), self.onUpgradeArtifact, self.onUpgradeArtifactCheck, nil, 5)
	self.commonArtifactTipsFuncItem:addConfig(self, Lang.get(1833), self.onUpgradeArtifact, self.onBreakArtifactCheck, nil, 5)
	self:checkCanEquipInTeamHeros(true)

	self.slotJumpToRecycleShop = Slot(self.jumpToRecycleShop, self)
end

function EquipMixin:jumpToRecycleShop()
	JumpGuideManager.jump(Const.JUMP_RECYCLE_SHOP)
end

function EquipMixin:initEquipAdditionalData()
	for _, hero in pairs(self.heroDic) do
		for _, equipGid in ipairs(hero.equipList) do
			if self.bagEquips[equipGid.gid] then
				self.bagEquips[equipGid.gid].inWearing = hero.gid
			end
		end

		if self.bagArtifacts[hero.artifactGid] then
			self.bagArtifacts[hero.artifactGid].inWearing = hero.gid
		end

		if self.bagRelics[hero.relicId] then
			self.bagRelics[hero.relicId].inWearing = hero.gid
		end
	end
end

function EquipMixin:getPlanDataByPlanSvrItem(svrItem, id)
	local planData = {}

	planData.equipInfoDic = {}

	for i, planInfo in ipairs(svrItem.hero) do
		if self.heroDic[planInfo.gid] then
			local equipInfo = {}

			equipInfo.equipGids = {}

			for _, equipSrc in ipairs(planInfo.equip) do
				local gid = equipSrc.gid

				if gid ~= "0" and self.bagEquips[gid] then
					table.insert(equipInfo.equipGids, gid)
				end
			end

			if self.bagArtifacts[planInfo.artifact] then
				equipInfo.artifactGid = planInfo.artifact
			else
				equipInfo.artifactGid = "0"
			end

			if self.bagRelics[planInfo.relic] then
				equipInfo.relicId = planInfo.relic
			else
				equipInfo.relicId = 0
			end

			if #equipInfo.equipGids ~= 0 or self.bagArtifacts[equipInfo.artifactGid] or not not self.bagRelics[equipInfo.relicId] then
				planData.equipInfoDic[planInfo.gid] = equipInfo
			end
		end
	end

	planData.petWearDic = {}

	if svrItem.pet then
		for _, petInfo in ipairs(svrItem.pet) do
			if self.petDic[petInfo.resid] then
				local info = {}

				info.amulet1 = petInfo.amulet1
				info.amulet2 = petInfo.amulet2
				info.gemList = {}

				for _, gem in ipairs(petInfo.gem) do
					table.insert(info.gemList, gem.gid)
				end

				planData.petWearDic[petInfo.resid] = info
			end
		end
	end

	planData.runeList = {}

	if svrItem.rune then
		for _, rune in ipairs(svrItem.rune) do
			local info = {}

			info.nodeId = rune.node_id
			info.heroGid = rune.hero_gid

			table.insert(planData.runeList, info)
		end
	end

	planData.id = id
	planData.name = svrItem.name

	return planData
end

function EquipMixin:getPlanItembyPlanData(planData)
	local planItem = {}

	planItem.name = planData.name
	planItem.hero = {}

	for heroGid, equipInfo in pairs(planData.equipInfoDic or {}) do
		if self.heroDic[heroGid] then
			local heroInfo = {}

			heroInfo.gid = heroGid
			heroInfo.equip = {}

			for part = 1, 6 do
				heroInfo.equip[part] = {}
				heroInfo.equip[part].gid = "0"
			end

			for _, equipGid in ipairs(equipInfo.equipGids) do
				if self.bagEquips[equipGid] then
					local part = self.bagEquips[equipGid].part

					heroInfo.equip[part].gid = equipGid
				end
			end

			if equipInfo.artifactGid and self.bagArtifacts[equipInfo.artifactGid] then
				heroInfo.artifact = equipInfo.artifactGid
			end

			if equipInfo.relicId and self.bagRelics[equipInfo.relicId] then
				heroInfo.relic = equipInfo.relicId
			end

			table.insert(planItem.hero, heroInfo)
		end
	end

	planItem.pet = {}

	for petId, petWear in pairs(planData.petWearDic or {}) do
		local petInfo = {}

		petInfo.resid = petId
		petInfo.amulet1 = petWear.amulet1
		petInfo.amulet2 = petWear.amulet2
		petInfo.gem = {}

		for _, gemGid in pairs(petWear.gemList) do
			if CurAvatar.petGemDic[gemGid] then
				table.insert(petInfo.gem, {
					gid = gemGid
				})
			end
		end

		table.insert(planItem.pet, petInfo)
	end

	planItem.rune = {}

	for _, rune in pairs(planData.runeList or {}) do
		local info = {}

		info.node_id = rune.nodeId
		info.hero_gid = rune.heroGid

		table.insert(planItem.rune, info)
	end

	return planItem
end

function EquipMixin:getEquipPlanData(planId)
	return self.equipPlanDic[planId]
end

function EquipMixin:onEquipSchemeItemNotify(item_id, item)
	local planData = self:getPlanDataByPlanSvrItem(item, item_id)

	if self.equipPlanDic[item_id] then
		planData.name = self.equipPlanDic[item_id].name
		self.equipPlanDic[item_id] = planData
	end
end

function EquipMixin:onEquipSchemeUpdateResp(sel_id, item, version, name, update)
	self.equipPlanVersion = version

	local planData = self:getPlanDataByPlanSvrItem(item, sel_id)

	planData.name = name

	if not self.equipPlanDic[sel_id] then
		self.equipPlanDic[sel_id] = planData
		self.lastUsePlanID = sel_id

		local mainBagDlg = UIManager.getUI("mainBagDlg", nil, false)

		if mainBagDlg and mainBagDlg.panelWear and mainBagDlg.panelWear:getVisible() then
			mainBagDlg.panelWear:addNewPlan(planData)
		end

		local battleBeforeWearDlg = UIManager.getUI("battleBeforeWearDlg", nil, false)

		if battleBeforeWearDlg and battleBeforeWearDlg.panelWear then
			battleBeforeWearDlg.panelWear:addNewPlan(planData)
		end

		MsgManager.clientNotice(369)
	else
		self.equipPlanDic[sel_id] = planData

		if update == 1 and self.coverPlanID and self.coverPlanID == sel_id then
			self.lastUsePlanID = sel_id
			self.coverPlanID = nil
		end

		local mainBagDlg = UIManager.getUI("mainBagDlg", nil, false)

		if mainBagDlg and mainBagDlg.panelWear and mainBagDlg.panelWear:getVisible() then
			mainBagDlg.panelWear:updatePlan(planData)
		end

		local battleBeforeWearDlg = UIManager.getUI("battleBeforeWearDlg", nil, false)

		if battleBeforeWearDlg and battleBeforeWearDlg.panelWear then
			battleBeforeWearDlg.panelWear:updatePlan(planData)
		end

		local bagPetWearDlg = UIManager.tryGetUI("bagPetWearDlg")

		if bagPetWearDlg then
			bagPetWearDlg:updatePlan(planData)
		end

		local petRuneMainDlg = UIManager.tryGetUI("petRuneMainDlg")

		if petRuneMainDlg then
			petRuneMainDlg:updatePlan(planData)
		end

		if self.isSaveingPlan then
			MsgManager.clientNotice(370)

			self.isSaveingPlan = false
		elseif update == 1 then
			MsgManager.notice(utils.format(ResClientNotice[615].notice, planData.name))
		else
			MsgManager.notice(utils.format(ResClientNotice[614].notice, planData.name))
		end
	end

	UIManager.tryHideUI("editProgramDlg")
end

function EquipMixin:onEquipSchemeApplyResp(sel_id, version)
	self.equipPlanVersion = version
	self.lastUsePlanID = sel_id

	self:changeHeroEquipedStatusByPlanId(sel_id)

	local mainBagDlg = UIManager.getUI("mainBagDlg", nil, false)

	if mainBagDlg and mainBagDlg.panelWear and mainBagDlg.panelWear:getVisible() then
		mainBagDlg.panelWear:revertToCurWear()
	end

	local battleBeforeWearDlg = UIManager.getUI("battleBeforeWearDlg", nil, false)

	if battleBeforeWearDlg and battleBeforeWearDlg.panelWear then
		battleBeforeWearDlg.panelWear:revertToCurWear()
	end

	local ui = ClientUtils.getNowDragDlg()

	if ui then
		ui:updateHeroBag()
		ui:refreshPetPart()
	end

	self:refreshHeroDetail()
	self:checkCanEquipInTeamHeros()
	MsgManager.notice(utils.format(ResClientNotice[613].notice, self.equipPlanDic[sel_id].name))
end

function EquipMixin:onEquipSchemeRenameResp(sel_id, name, version)
	self.equipPlanVersion = version
	self.equipPlanDic[sel_id].name = name

	local mainBagDlg = UIManager.getUI("mainBagDlg", nil, false)

	if mainBagDlg and mainBagDlg.panelWear and mainBagDlg.panelWear:getVisible() then
		mainBagDlg.panelWear:initPlanList()
		mainBagDlg.panelWear:refreshPlanName(name)
	end

	local battleBeforeWearDlg = UIManager.getUI("battleBeforeWearDlg", nil, false)

	if battleBeforeWearDlg and battleBeforeWearDlg.panelWear then
		battleBeforeWearDlg.panelWear:initPlanList()
		battleBeforeWearDlg.panelWear:refreshPlanName(name)
	end

	UIManager.tryHideUI("editProgramDlg")
	MsgManager.clientNotice(372)
end

function EquipMixin:onEquipSchemeDeleteResp(sel_id, version)
	self.equipPlanVersion = version
	self.equipPlanDic[sel_id] = nil

	if self.lastUsePlanID == sel_id then
		self.lastUsePlanID = nil
	end

	local mainBagDlg = UIManager.getUI("mainBagDlg", nil, false)

	if mainBagDlg and mainBagDlg.panelWear and mainBagDlg.panelWear:getVisible() then
		mainBagDlg.panelWear:initPlanList()
		mainBagDlg.panelWear:revertToCurWear()
	end

	local battleBeforeWearDlg = UIManager.getUI("battleBeforeWearDlg", nil, false)

	if battleBeforeWearDlg and battleBeforeWearDlg.panelWear then
		battleBeforeWearDlg.panelWear:initPlanList()
		battleBeforeWearDlg.panelWear:revertToCurWear()
	end

	MsgManager.clientNotice(379)
end

function EquipMixin:changeHeroEquipedStatusByPlanId(_planId)
	local planData = self:getEquipPlanData(_planId)

	self:changeHeroEquipedStatusByPlanData(planData)
end

function EquipMixin:changeHeroEquipedStatusByPlanData(planData)
	if planData then
		for _, hero in pairs(self.heroDic) do
			self:offAllEquip(hero)
		end

		for _, hero in pairs(self.heroDic) do
			if planData.equipInfoDic[hero.gid] then
				local equipInfo = planData.equipInfoDic[hero.gid]

				for _, equipGid in ipairs(equipInfo.equipGids) do
					if self.bagEquips[equipGid] then
						local gidStruct = {}

						gidStruct.gid = equipGid

						table.insert(hero.equipList, gidStruct)

						self.bagEquips[equipGid].inWearing = hero.gid
					end
				end

				if self.bagArtifacts[equipInfo.artifactGid] then
					hero.artifactGid = equipInfo.artifactGid
					self.bagArtifacts[equipInfo.artifactGid].inWearing = hero.gid
				elseif equipInfo.artifactGid ~= "0" and equipInfo.artifactGid ~= 0 then
					-- block empty
				end

				if self.bagRelics[equipInfo.relicId] then
					hero.relicId = equipInfo.relicId
					self.bagRelics[equipInfo.relicId].inWearing = hero.gid
				elseif equipInfo.relicId ~= 0 then
					-- block empty
				end
			end
		end

		for _, pet in pairs(self.petDic) do
			self:offAllPetEquip(pet)
		end

		for petId, petWear in pairs(planData.petWearDic) do
			if petWear.amulet1 and petWear.amulet1 > 0 then
				CurAvatar:wearAmulet(petId, petWear.amulet1, Const.PET_AMULET_POS_TYPE[1])
			end

			if petWear.amulet2 and petWear.amulet2 > 0 then
				CurAvatar:wearAmulet(petId, petWear.amulet2, Const.PET_AMULET_POS_TYPE[2])
			end

			for _, gemGid in ipairs(petWear.gemList) do
				CurAvatar:wearPetGem(petId, gemGid)
			end
		end

		local exclusiveRuneList = CurAvatar:getExclusiveRuneList()

		for id, data in pairs(CurAvatar.exclusiveRuneDic) do
			CurAvatar.exclusiveRuneDic[id] = {
				id = id
			}
		end

		for _, rune in pairs(planData.runeList) do
			local curRuneConfig

			for i, v in ipairs(exclusiveRuneList) do
				local runeConfig = ResPetRune[v.id]

				if runeConfig and runeConfig.node_id == rune.nodeId and (not curRuneConfig or runeConfig.level > curRuneConfig.level) then
					curRuneConfig = runeConfig
				end
			end

			if curRuneConfig then
				CurAvatar.exclusiveRuneDic[curRuneConfig.id] = {
					id = curRuneConfig.id,
					hero_gid = rune.heroGid
				}
			end
		end
	end
end

function EquipMixin:checkHeroCanWearBetterEquip()
	local bagEquipMaxRankDic, bagArtifactMaxRankDic, bagCustomMadeArtifactDic = self:getBagEquipMaxRank()

	if DragPlane.fieldObjs then
		for pos, obj in pairs(DragPlane.fieldObjs) do
			if pos > 0 and obj.hero and obj.hero:isMyHero() then
				local canEquip = self:checkHeroCanEquip(obj.hero, bagEquipMaxRankDic, bagArtifactMaxRankDic, bagCustomMadeArtifactDic)

				if canEquip then
					return true
				end
			end
		end
	end

	return false
end

function EquipMixin:addEquipMaxPlanCount()
	local maxPlanCount = Const.EQUIP_MAX_PLAN_COUNT

	for i, data in pairs(ResPlanWithPlayModeConfig) do
		if data.condition_id and data.plan_add_num then
			local isLocked = ConditionLimitManager.inLimitState(data.condition_id)

			if not isLocked then
				maxPlanCount = maxPlanCount + data.plan_add_num
			end
		end
	end

	return maxPlanCount
end

function EquipMixin:checkPlanCountNotOverMax()
	local maxPlanCount = self:addEquipMaxPlanCount()
	local planCount = utils.getTableElemCount(self.equipPlanDic)

	if planCount < maxPlanCount and planCount < Const.EQUIP_MAX_PLAN_COUNT_NEW then
		return true
	end

	return false
end

function EquipMixin:getHeroWearQualityScore(heroGid)
	local wearedHeroList = CurAvatar:getWearedOrInTeamHero()
	local groundColorScore = 0

	for i, hero in pairs(wearedHeroList or {}) do
		if hero.gid == heroGid then
			local equipNum = 0
			local allEquipQualityScore = 0

			for _, equip in pairs(hero.equipList or {}) do
				if equip.gid ~= "0" then
					equipNum = equipNum + 1

					local equipInfo = self.bagEquips[equip.gid]

					if equipInfo then
						allEquipQualityScore = allEquipQualityScore + equipInfo.quality
					end
				end
			end

			local interger, decimal = math.modf(allEquipQualityScore / equipNum)

			groundColorScore = decimal >= 0.5 and interger + 1 or interger
		end
	end

	return groundColorScore
end

function EquipMixin:getHeroWearEnhanceLevel(heroGid)
	local wearedHeroList = CurAvatar:getWearedOrInTeamHero()
	local allEnhanceLevel = 0

	for i, hero in pairs(wearedHeroList or {}) do
		if hero.gid == heroGid then
			for _, equip in pairs(hero.equipList or {}) do
				if equip.gid ~= "0" then
					local equipInfo = self.bagEquips[equip.gid]

					if equipInfo then
						allEnhanceLevel = allEnhanceLevel + equipInfo.enhanceLevel
					end
				end
			end
		end
	end

	return allEnhanceLevel
end

function EquipMixin:getNeedUpdateHeroInAllProgram(oldPlanData, planData)
	local oldPlanItem = self:getPlanItembyPlanData(oldPlanData)
	local planItem = self:getPlanItembyPlanData(planData)
	local needSyncList = {}

	for i, heroEquips in pairs(planItem.hero or {}) do
		local curHeroEquips, heroGid

		for j, oldHeroEquips in pairs(oldPlanItem.hero or {}) do
			if oldHeroEquips.gid == heroEquips.gid then
				heroGid = heroEquips.gid
				curHeroEquips = oldHeroEquips

				break
			end
		end

		if heroGid then
			if not needSyncList[heroGid] then
				needSyncList[heroGid] = {}
			end

			for part, equip in ipairs(heroEquips.equip or {}) do
				local canSync = false

				if curHeroEquips.equip[part].gid ~= "0" and equip.gid ~= "0" and curHeroEquips.equip[part].gid ~= equip.gid then
					local oldEquipObj = self.bagEquips[curHeroEquips.equip[part].gid]
					local newEquipObj = self.bagEquips[equip.gid]

					if oldEquipObj.haveSuit == 0 then
						canSync = true

						table.insert(needSyncList[heroGid], {
							part = part,
							oldGid = curHeroEquips.equip[part].gid,
							newGid = equip.gid
						})
					elseif newEquipObj.haveSuit == 1 and oldEquipObj.suitId == newEquipObj.suitId then
						canSync = true

						table.insert(needSyncList[heroGid], {
							part = part,
							oldGid = curHeroEquips.equip[part].gid,
							newGid = equip.gid
						})
					end
				end
			end
		end
	end

	local syncPlans = {}

	for _, program in pairs(self.equipPlanDic or {}) do
		if program.id ~= oldPlanData.id then
			local tempPlanData = utils.deepcopy(program)
			local needSync = false

			for heroGid, data in pairs(needSyncList or {}) do
				if tempPlanData.equipInfoDic and tempPlanData.equipInfoDic[heroGid] then
					for i, equip in pairs(tempPlanData.equipInfoDic[heroGid].equipGids or {}) do
						for _, info in pairs(data or {}) do
							if equip == info.oldGid then
								local hero, bagEquips, bagArtifacts, bagRelics = CurAvatar:getWearedOrInTeamHero(tempPlanData)

								if bagEquips[info.newGid] and bagEquips[info.newGid].inWearing == nil then
									tempPlanData.equipInfoDic[heroGid].equipGids[i] = info.newGid
									needSync = true
								end
							end
						end
					end
				end
			end

			if needSync then
				local planItem = self:getPlanItembyPlanData(tempPlanData)

				table.insert(syncPlans, {
					item_id = tempPlanData.id,
					item = planItem,
					name = planItem.name
				})
			end
		end
	end

	return syncPlans
end

function EquipMixin:compareCurWearAndLastUsePlan(planData)
	if planData == nil then
		return true
	end

	local curPlanData = CurAvatar:genNewPlanData("")
	local wearedHeroList = CurAvatar:getWearedOrInTeamHero()

	for i, hero in ipairs(wearedHeroList or {}) do
		if i <= Const.EQUIP_PLAN_MAX_HERO_COUNT then
			if planData.equipInfoDic and planData.equipInfoDic[hero.gid] then
				local planEquipInfo = planData.equipInfoDic[hero.gid]

				if utils.getTableElemCount(planEquipInfo.equipGids) == utils.getTableElemCount(hero.equipList) then
					for _, equip in pairs(hero.equipList or {}) do
						if self.bagEquips[equip.gid] and not utils.tableIsContainsElement(planEquipInfo.equipGids, equip.gid) then
							return false
						end
					end
				else
					return false
				end

				if tostring(hero.artifactGid) ~= tostring(planEquipInfo.artifactGid) then
					return false
				end

				if tostring(hero.relicId) ~= tostring(planEquipInfo.relicId) then
					return false
				end
			elseif utils.getTableElemCount(hero.equipList) > 0 then
				return false
			end
		end
	end

	local petWearDic = planData.petWearDic
	local curPetWearDic = curPlanData.petWearDic

	for id, pet in pairs(CurAvatar.petDic) do
		local petWear = petWearDic[pet.id]
		local curPetWear = curPetWearDic[pet.id]
		local checkWear = self:checkPetHaveWearInPlanPetWearDic(petWearDic, pet.id)
		local checkCurWear = self:checkPetHaveWearInPlanPetWearDic(curPetWearDic, pet.id)

		if checkWear ~= checkCurWear then
			return false
		end

		if checkWear then
			local amulet1 = petWear.amulet1 and CurAvatar.petAmuletDic[petWear.amulet1] and petWear.amulet1 ~= Const.PET_DEFAULT_AMULET and petWear.amulet1 or 0
			local curAmulet1 = curPetWear.amulet1 and CurAvatar.petAmuletDic[curPetWear.amulet1] and curPetWear.amulet1 ~= Const.PET_DEFAULT_AMULET and curPetWear.amulet1 or 0

			if amulet1 ~= curAmulet1 then
				return false
			end

			local amulet2 = petWear.amulet2 and CurAvatar.petAmuletDic[petWear.amulet2] and petWear.amulet2 or 0
			local curAmulet2 = curPetWear.amulet2 and CurAvatar.petAmuletDic[curPetWear.amulet2] and curPetWear.amulet2 or 0

			if amulet2 ~= curAmulet2 then
				return false
			end

			local gemList = petWear.gemList
			local curGemList = curPetWear.gemList

			for _, gemGid in ipairs(gemList) do
				if CurAvatar.petGemDic[gemGid] and utils.getIndexByValue(curGemList, gemGid) < 0 then
					return false
				end
			end

			for _, gemGid in ipairs(curGemList) do
				if CurAvatar.petGemDic[gemGid] and utils.getIndexByValue(gemList, gemGid) < 0 then
					return false
				end
			end
		end
	end

	local runeList = planData.runeList
	local curRuneList = curPlanData.runeList

	for _, info in pairs(runeList) do
		if CurAvatar.heroDic[info.heroGid] then
			local tmpHeroGid

			for _, tmpInfo in pairs(curRuneList) do
				if tmpInfo.nodeId == info.nodeId then
					tmpHeroGid = tmpInfo.heroGid

					break
				end
			end

			if info.heroGid ~= tmpHeroGid then
				return false
			end
		end
	end

	for _, info in pairs(curRuneList) do
		if CurAvatar.heroDic[info.heroGid] then
			local tmpHeroGid

			for _, tmpInfo in pairs(runeList) do
				if tmpInfo.nodeId == info.nodeId then
					tmpHeroGid = tmpInfo.heroGid

					break
				end
			end

			if info.heroGid ~= tmpHeroGid then
				return false
			end
		end
	end

	return true
end

function EquipMixin:checkPetHaveWearInPlanPetWearDic(petWearDic, petId)
	if not petId or not petWearDic then
		return false
	end

	local petWear = petWearDic[petId]

	if not petWear then
		return false
	end

	if petWear.amulet1 and petWear.amulet1 ~= Const.PET_DEFAULT_AMULET and CurAvatar.petAmuletDic[petWear.amulet1] then
		return true
	end

	if petWear.amulet2 and CurAvatar.petAmuletDic[petWear.amulet2] then
		return true
	end

	for _, gid in ipairs(petWear.gemList) do
		if CurAvatar.petGemDic[gid] then
			return true
		end
	end

	return false
end

function EquipMixin:initSuitFilterMapInfo()
	local suitFilterMap = {
		{}
	}

	suitFilterMap[1].title = Lang.get(50273)
	suitFilterMap[1].data = {}

	for i, suitInfo in ipairs(ResEquipSuit) do
		local info = {}

		if UIConst.EQUIP_SUIT_EMOJI[suitInfo.suit_id] then
			info[1] = UIConst.EQUIP_SUIT_EMOJI[suitInfo.suit_id] .. " " .. suitInfo.name
		else
			info[1] = suitInfo.name
		end

		info[2] = "suitId"
		info[3] = suitInfo.suit_id

		table.insert(suitFilterMap[1].data, info)
	end

	return suitFilterMap
end

function EquipMixin:getSuitInfoList(hero, suitCount, bagWearDic)
	local suitInfoList = {}
	local bagEquips = bagWearDic ~= nil and bagWearDic.equips or self.bagEquips
	local suitEquipPosCnt = {}
	local suitHaveDefineDic = {}
	local suitEquipPosDic = {}

	for gid, equip in pairs(bagEquips) do
		if (not equip.inWearing or equip.inWearing == hero.gid) and equip.haveSuit == 1 and equip.suitId and equip.suitId > 0 then
			if not suitEquipPosDic[equip.suitId] then
				suitEquipPosDic[equip.suitId] = {}
			end

			if not suitEquipPosDic[equip.suitId][equip.part] then
				suitEquipPosCnt[equip.suitId] = (suitEquipPosCnt[equip.suitId] or 0) + 1
				suitEquipPosDic[equip.suitId][equip.part] = true
			end

			if equip:getDefineHeroId() and hero.id == equip:getDefineHeroId() then
				suitHaveDefineDic[equip.suitId] = true
			end
		end
	end

	for i, resData in ipairs(ResEquipSuit) do
		if suitCount == resData.need_num then
			local suitInfo = {}

			suitInfo.resData = resData
			suitInfo.posCount = suitEquipPosCnt[resData.suit_id] or 0
			suitInfo.isHaveDefine = suitHaveDefineDic[resData.suit_id] ~= nil and hero.id or 0

			table.insert(suitInfoList, suitInfo)
		end
	end

	return suitInfoList
end

function EquipMixin:isOnBattleTeam(heroInfos, heroGid)
	if heroInfos and heroInfos[heroGid] then
		return true
	end

	return false
end

local function sortEquipChangeInfo(infoA, infoB)
	local heroA = infoA.oriHero
	local heroB = infoB.oriHero

	for _, pSortData in ipairs(UIConst.HERO_DEFAULT_SORT_MAP) do
		local pName = pSortData.name
		local vA = heroA[pName]
		local vB = heroB[pName]

		if vA and vB then
			if vA ~= vB then
				return vB < vA
			end
		elseif vA or vB then
			return vA ~= nil
		end
	end

	if heroA.id ~= heroB.id then
		return heroA.id > heroB.id
	else
		return heroA.gid > heroB.gid
	end
end

function EquipMixin:getEvoEquipChangeInfoList(planData, tempBagEquips)
	local evoEquipChangeInfoList = {}

	for _, oriEquip in pairs(self.bagEquips) do
		if oriEquip.evolve > 0 and oriEquip.inWearing ~= nil then
			local equipChangeInfo = {}

			equipChangeInfo.equip = oriEquip

			local tempEquip = tempBagEquips[oriEquip.gid]

			if tempEquip.inWearing and tempEquip.inWearing ~= oriEquip.inWearing then
				equipChangeInfo.oriHero = self.heroDic[oriEquip.inWearing]
				equipChangeInfo.tarHero = self.heroDic[tempEquip.inWearing]

				table.insert(evoEquipChangeInfoList, equipChangeInfo)
			elseif not tempEquip.inWearing then
				equipChangeInfo.oriHero = self.heroDic[oriEquip.inWearing]

				table.insert(evoEquipChangeInfoList, equipChangeInfo)
			end
		end
	end

	table.sort(evoEquipChangeInfoList, sortEquipChangeInfo)

	return evoEquipChangeInfoList
end

function EquipMixin:onEquipGetNotify(equipList)
	for _, eInfo in ipairs(equipList) do
		local equip = Equip(eInfo)

		self.bagEquips[equip.gid] = equip
	end

	self:refreshItemBag()
	self:checkCanEquipInTeamHeros()
end

function EquipMixin:onEquipDelNotify(delList)
	for _, gid in ipairs(delList) do
		self.bagEquips[gid] = nil
	end

	self:refreshItemBag()
	self:checkCanEquipInTeamHeros()
end

function EquipMixin:onArtifactGetNotify(artifactList)
	for _, aInfo in ipairs(artifactList) do
		local artifact = Artifact(aInfo)

		self.bagArtifacts[artifact.gid] = artifact
		self.handBookArtifactDic[artifact.id] = 1
	end

	self:refreshItemBag()
	self:checkCanEquipInTeamHeros()
end

function EquipMixin:onArtifactDelNotify(delList)
	for _, gid in ipairs(delList) do
		self.bagArtifacts[gid] = nil
	end

	self:refreshItemBag()
	self:checkCanEquipInTeamHeros()
end

local HERO_EQUIP_SHOW_ATTR = {
	"mhp",
	"atk",
	"p_def",
	"cri_rate",
	"cri_dmg",
	"assist_enhance",
	"effect_hit"
}

function EquipMixin:onEquipWearResp(hero, datas, equip_id, off_equip_id)
	local realHero = self.heroDic[hero]
	local nakedHeroAttr = self:getRealHeroAttr(realHero)
	local cacheNewEquipGids = {}
	local oldSuits = realHero:getSuits()
	local oldSuitsDic = {}

	for _, suitId in ipairs(oldSuits) do
		if not oldSuitsDic[suitId] then
			oldSuitsDic[suitId] = 0
		end

		oldSuitsDic[suitId] = oldSuitsDic[suitId] + 1
	end

	for _, data in ipairs(datas) do
		self:offEquip(hero, data.off_equip_id)

		self.bagEquips[data.equip_id].inWearing = hero

		local gidStruct = {}

		gidStruct.gid = data.equip_id

		table.insert(cacheNewEquipGids, data.equip_id)
		table.insert(self.heroDic[hero].equipList, gidStruct)
	end

	local realHeroAttr = self:getRealHeroAttr(realHero)

	self:calAndShowNumAttr(realHeroAttr, nakedHeroAttr)

	local effectPartList = {}
	local suitEffPartList = {}
	local suits = realHero:getSuits()
	local newSuitIds = {}

	for _, suitId in ipairs(suits) do
		if not oldSuitsDic[suitId] or oldSuitsDic[suitId] == 0 then
			table.insert(newSuitIds, suitId)
		else
			oldSuitsDic[suitId] = oldSuitsDic[suitId] - 1
		end
	end

	local equips = realHero:getEquips()
	local suitEffPartDic = {}

	for _, _suitId in ipairs(newSuitIds) do
		local suitEquipNum = 0

		for _, gid in ipairs(cacheNewEquipGids) do
			if suitEquipNum == ResEquipSuit[_suitId].need_num then
				break
			end

			local part = self.bagEquips[gid].part
			local suitId = self.bagEquips[gid].suitId

			if equips[part] and suitId == _suitId and not suitEffPartDic[part] then
				suitEquipNum = suitEquipNum + 1

				table.insert(suitEffPartList, part)

				suitEffPartDic[part] = true
			end
		end

		for part = 1, 6 do
			if suitEquipNum == ResEquipSuit[_suitId].need_num then
				break
			end

			if equips[part] and equips[part].suitId == _suitId and not suitEffPartDic[part] then
				suitEquipNum = suitEquipNum + 1

				table.insert(suitEffPartList, part)

				suitEffPartDic[part] = true
			end
		end
	end

	local playAnimParts = {}

	for _, gid in ipairs(cacheNewEquipGids) do
		local part = self.bagEquips[gid].part

		table.insert(playAnimParts, part)

		if not suitEffPartDic[part] then
			table.insert(effectPartList, part)
		end
	end

	local heroMainDlg = UIManager.getUI("heroMainDlg", nil, false)
	local mainBagDlg = UIManager.getUI("mainBagDlg", nil, false)
	local battleBeforeWearDlg = UIManager.getUI("battleBeforeWearDlg", nil, false)

	if heroMainDlg then
		local equipPanel = heroMainDlg.heroContentPanel.panelList[Const.HERO_CONTENT_PANEL.HERO_EQUIP]

		if equipPanel and equipPanel:getVisible() then
			equipPanel:playEquipPartEfx(effectPartList, suitEffPartList)
		end
	end

	if mainBagDlg then
		local wearPanel = mainBagDlg.panelWear

		if wearPanel and wearPanel:getVisible() then
			wearPanel:playEquipPartEfx(realHero.gid, nil, suitEffPartList)
		end
	end

	if battleBeforeWearDlg then
		local wearPanel = battleBeforeWearDlg.panelWear

		if wearPanel and wearPanel:getVisible() then
			wearPanel:playEquipPartEfx(realHero.gid, nil, suitEffPartList)
		end
	end

	self:refreshHeroDetail(hero)
	self:closeWearDlg()

	if heroMainDlg and not heroMainDlg:isInShow() then
		local equipPanel = heroMainDlg.heroContentPanel.panelList[Const.HERO_CONTENT_PANEL.HERO_EQUIP]

		if equipPanel and equipPanel:getVisible() then
			equipPanel:clearEfx()
		end
	end

	if mainBagDlg and not mainBagDlg:isInShow() then
		local wearPanel = mainBagDlg.panelWear

		if wearPanel and wearPanel:getVisible() then
			wearPanel:clearEfx()
		end
	end

	if battleBeforeWearDlg and not battleBeforeWearDlg:isInShow() then
		local wearPanel = battleBeforeWearDlg.panelWear

		if wearPanel and wearPanel:getVisible() then
			wearPanel:clearEfx()
		end
	end

	self:refreshItemBag()
	self:checkCanEquipInTeamHeros()

	if mainBagDlg then
		local wearPanel = mainBagDlg.panelWear

		if wearPanel and wearPanel:getVisible() then
			wearPanel:playEquipPartWearAnim(realHero.gid, playAnimParts, Const.WEAR_EQUIP_ANIM)
		end
	end

	if battleBeforeWearDlg then
		local wearPanel = battleBeforeWearDlg.panelWear

		if wearPanel and wearPanel:getVisible() then
			wearPanel:playEquipPartWearAnim(realHero.gid, playAnimParts, Const.WEAR_EQUIP_ANIM)
		end
	end

	for _, gid in ipairs(cacheNewEquipGids) do
		local obj = self.bagEquips[gid]

		if obj and obj.part and obj.part == 1 then
			local heroMainDlg = UIManager.getUI("heroMainDlg", nil, false)

			if heroMainDlg then
				local equipPanel = heroMainDlg.heroContentPanel.panelList[Const.HERO_CONTENT_PANEL.HERO_EQUIP]

				if heroMainDlg:isInShow() and equipPanel and equipPanel:getVisible() then
					BeginnerManager.CheckHeroHatEnhance(gid)
				end
			end
		end
	end
end

function EquipMixin:closeWearDlg()
	local heroEquipWearDlg = UIManager.getUI("heroEquipWearDlg", nil, false)

	if heroEquipWearDlg then
		heroEquipWearDlg:setVisible(false)
	end

	local relicWearDlg = UIManager.getUI("relicWearDlg", nil, false)

	if relicWearDlg then
		relicWearDlg:setVisible(false)
	end
end

function EquipMixin:onEquipOffResp(hero, off_equip_id)
	local realHero = self.heroDic[hero]
	local nakedHeroAttr = self:getRealHeroAttr(realHero)
	local playAnimParts = {}

	for _, equip_id in ipairs(off_equip_id) do
		self:offEquip(hero, equip_id)

		if self.bagEquips[equip_id] then
			table.insert(playAnimParts, self.bagEquips[equip_id].part)
		end
	end

	local mainBagDlg = UIManager.getUI("mainBagDlg", nil, false)
	local battleBeforeWearDlg = UIManager.getUI("battleBeforeWearDlg", nil, false)

	if mainBagDlg then
		local wearPanel = mainBagDlg.panelWear

		if wearPanel and wearPanel:getVisible() then
			wearPanel:playEquipPartWearAnim(realHero.gid, playAnimParts, Const.OFF_EQUIP_ANIM)
		end
	end

	if battleBeforeWearDlg then
		local wearPanel = battleBeforeWearDlg.panelWear

		if wearPanel and wearPanel:getVisible() then
			wearPanel:playEquipPartWearAnim(realHero.gid, playAnimParts, Const.OFF_EQUIP_ANIM)
		end
	end

	local realHeroAttr = self:getRealHeroAttr(realHero)

	self:calAndShowNumAttr(realHeroAttr, nakedHeroAttr)
	self:refreshHeroDetail(hero)
	self:closeWearDlg()
	self:refreshItemBag()
	self:checkCanEquipInTeamHeros()
end

function EquipMixin:onHeroOffWearsResp(off_evo, hero_gid)
	for _, gid in ipairs(hero_gid) do
		local hero = self.heroDic[gid]

		if hero and off_evo == Const.HREO_OFF_ALL_EQUIPS_TYPE_ALL then
			self:offAllEquip(self.heroDic[gid])
		elseif hero then
			local equips = hero:getEquips()

			for part, equip in pairs(equips) do
				if equip.evolve < 1 then
					self:offEquip(hero.gid, equip.gid)
				end
			end

			local artifact = hero:getArtifact()

			if artifact then
				self:offArtifact(hero.gid, artifact.gid)
			end

			local relic = hero:getRelic()

			if relic then
				self:offRelic(hero.gid, relic.id)
			end
		end
	end

	local heroMainDlg = UIManager.getUI("heroMainDlg", nil, false)

	if heroMainDlg then
		local selectExist = heroMainDlg.selectedHero and self.heroDic[heroMainDlg.selectedHero.gid]

		if selectExist then
			heroMainDlg:regularUpdateHeroCardList(heroMainDlg.selectedHero.gid)
		else
			heroMainDlg:regularUpdateHeroCardList(nil, 1)
		end
	end

	self:refreshItemBag()
	MsgManager.clientNotice(296)
	self:checkCanEquipInTeamHeros()
end

function EquipMixin:getRealHeroAttr(realHero)
	return PropHelper.getHeroPanelAttrContainer({}, realHero.id, realHero:getPropLevel(), realHero.battleStep, realHero.star, realHero:getEquips(), realHero:getArtifact(), realHero, realHero:getSkinData(), realHero:getBaseData(), realHero:getRelic(), realHero:getPaintData(), realHero:getRelationPointData())
end

function EquipMixin:calAndShowNumAttr(realHeroAttr, nakedHeroAttr)
	local equipAttrDiff = {}

	for _, attrName in pairs(HERO_EQUIP_SHOW_ATTR) do
		local realValue = realHeroAttr[attrName] or 0
		local nakedValue = nakedHeroAttr[attrName] or 0
		local diffValue = realValue - nakedValue

		if diffValue ~= 0 then
			local diffZhName, diffValueStr = ClientUtils.getRolePropZhName(attrName, diffValue, true)

			if diffValue > 0 then
				diffValueStr = "+" .. diffValueStr
			end

			table.insert(equipAttrDiff, {
				attrName,
				diffZhName,
				diffValueStr
			})
		end
	end

	local heroMainDlg = UIManager.getUI("heroMainDlg", nil, false)

	if heroMainDlg then
		local equipPanel = heroMainDlg.heroContentPanel.panelList[Const.HERO_CONTENT_PANEL.HERO_EQUIP]

		if equipPanel and equipPanel:getVisible() then
			equipPanel:playEquipAttrNum(equipAttrDiff)
		end
	end
end

function EquipMixin:offAllEquip(hero, ignoreArtifact, ignoreRelic)
	local equips = hero:getEquips()

	if not ignoreArtifact then
		local artifact = hero:getArtifact()

		if artifact then
			equips[Const.PART_OF_ARTIFACT] = artifact
		end
	end

	if not ignoreRelic then
		local relic = hero:getRelic()

		if relic then
			equips[Const.PART_OF_RELIC] = relic
		end
	end

	for _, equipItem in pairs(equips) do
		equipItem.inWearing = nil
	end

	hero:offAllEquips(ignoreArtifact, ignoreRelic)
end

function EquipMixin:offAllEquipByGids(heroGids, ignoreArtifact, ignoreRelic)
	for _, heroGid in ipairs(heroGids) do
		if self.heroDic[heroGid] then
			self:offAllEquip(self.heroDic[heroGid], ignoreArtifact, ignoreRelic)
		end
	end
end

function EquipMixin:isHaveCanWearRelic(hero)
	local haveCanWear = false

	for _, relic in pairs(self.bagRelics) do
		if not relic.inWearing and relic:isCanBeWear(hero) or relic.inWearing and relic.inWearing == hero.gid then
			haveCanWear = true

			break
		end
	end

	return haveCanWear
end

function EquipMixin:offEquip(hero_gid, off_equip_id)
	if self.bagEquips[off_equip_id] then
		self.bagEquips[off_equip_id].inWearing = nil
	end

	for i, v in pairs(self.heroDic[hero_gid].equipList) do
		if v.gid == off_equip_id then
			table.remove(self.heroDic[hero_gid].equipList, i)
		end
	end
end

function EquipMixin:onEquipSwapResp(equipInfos)
	for _, info in ipairs(equipInfos) do
		self:offAllEquip(self.heroDic[info.gid], true, true)
	end

	for _, info in ipairs(equipInfos) do
		for _, data in ipairs(info.equips) do
			self.bagEquips[data.gid].inWearing = info.gid

			local gidStruct = {}

			gidStruct.gid = data.gid

			table.insert(self.heroDic[info.gid].equipList, gidStruct)
		end

		self:refreshHeroDetail(info.gid)
	end

	self:refreshItemBag()
	self:checkCanEquipInTeamHeros()
	MsgManager.clientNotice(239)
end

function EquipMixin:onArtifactWearResp(hero, artifact_id, off_artifact_id)
	local realHero = self.heroDic[hero]
	local nakedHeroAttr = self:getRealHeroAttr(realHero)

	self:offArtifact(hero, off_artifact_id)

	self.heroDic[hero].artifactGid = artifact_id
	self.bagArtifacts[artifact_id].inWearing = hero

	local realHeroAttr = self:getRealHeroAttr(realHero)

	self:calAndShowNumAttr(realHeroAttr, nakedHeroAttr)

	local heroMainDlg = UIManager.getUI("heroMainDlg", nil, false)

	if heroMainDlg then
		local equipPanel = heroMainDlg.heroContentPanel.panelList[Const.HERO_CONTENT_PANEL.HERO_EQUIP]

		if equipPanel and equipPanel:getVisible() then
			equipPanel:playArtifactEfx()
		end
	end

	self:refreshHeroDetail(hero)
	self:closeWearDlg()

	if heroMainDlg and not heroMainDlg:isInShow() then
		local equipPanel = heroMainDlg.heroContentPanel.panelList[Const.HERO_CONTENT_PANEL.HERO_EQUIP]

		if equipPanel and equipPanel:getVisible() then
			equipPanel:clearEfx()
		end
	end

	self:refreshItemBag()
	self:checkCanEquipInTeamHeros()
end

function EquipMixin:onArtifactOffResp(hero, off_artifact_id)
	local realHero = self.heroDic[hero]
	local nakedHeroAttr = self:getRealHeroAttr(realHero)

	self:offArtifact(hero, off_artifact_id)

	local realHeroAttr = self:getRealHeroAttr(realHero)

	self:calAndShowNumAttr(realHeroAttr, nakedHeroAttr)
	self:refreshHeroDetail(hero)
	self:closeWearDlg()
	self:refreshItemBag()

	local heroEquipUpGradeDlg = UIManager.getUI("heroEquipUpGradeDlg", nil, false)

	if heroEquipUpGradeDlg then
		heroEquipUpGradeDlg:refreshMaterialList()
		heroEquipUpGradeDlg:updateMaterial()
	end

	self:checkCanEquipInTeamHeros()
end

function EquipMixin:onEquipUpdateNotify(equip)
	local newEquip = Equip(equip)
	local heroEquipUpGradeDlg = UIManager.getUI("heroEquipUpGradeDlg", nil, false)

	if heroEquipUpGradeDlg then
		heroEquipUpGradeDlg:playUpgradeEfx(newEquip.enhanceLevel > self.bagEquips[equip.gid].enhanceLevel)
	end

	newEquip.inWearing = self.bagEquips[equip.gid].inWearing
	self.bagEquips[equip.gid] = newEquip

	self:checkCanEquipInTeamHeros()
end

function EquipMixin:onArtifactUpdateNotify(artifact)
	for k, v in pairs(artifact) do
		-- block empty
	end

	local newArtifact = Artifact(artifact)
	local heroEquipUpGradeDlg = UIManager.getUI("heroEquipUpGradeDlg", nil, false)

	if heroEquipUpGradeDlg then
		heroEquipUpGradeDlg:playUpgradeEfx(newArtifact.enhanceLevel > self.bagArtifacts[artifact.gid].enhanceLevel)
	end

	newArtifact.inWearing = self.bagArtifacts[artifact.gid].inWearing
	self.bagArtifacts[artifact.gid] = newArtifact

	self:checkCanEquipInTeamHeros()
end

function EquipMixin:onEquipLevelUpResp(gid, cost_gid, item_id, item_num, prop, total_xp)
	local heroEquipUpGradeDlg = UIManager.getUI("heroEquipUpGradeDlg", nil, false)

	if heroEquipUpGradeDlg then
		heroEquipUpGradeDlg:clearMaterial(prop, total_xp)
	end

	self:refreshItemBag()
	self:refreshHeroDetail()
	self:refreshHeroEquipWear()
	self:checkCanEquipInTeamHeros()
end

function EquipMixin:onEquipEvolveResp(gid, evolve)
	local evoServerData = utils.deepcopy(self.bagEquips[gid]._serverData)

	evoServerData.evolve = evoServerData.evolve + 1

	local evoEquip = Equip(evoServerData)

	evoEquip.inWearing = self.bagEquips[gid].inWearing
	evoEquip.isLock = self.bagEquips[gid].isLock
	self.bagEquips[gid] = evoEquip

	local heroEquipEvolutionDlg = UIManager.getUI("heroEquipEvolutionDlg", nil, false)

	if heroEquipEvolutionDlg then
		heroEquipEvolutionDlg:playSuccessEfxAndAni(self.bagEquips[gid])
	end

	self:refreshItemBag()
	self:refreshHeroDetail()
	self:refreshHeroEquipWear()
	self:checkCanEquipInTeamHeros()
end

function EquipMixin:onArtifactLevelUpResp(gid, cost_gid, item_id, item_num, total_xp)
	local heroEquipUpGradeDlg = UIManager.getUI("heroEquipUpGradeDlg", nil, false)

	if heroEquipUpGradeDlg then
		heroEquipUpGradeDlg:clearMaterial({}, total_xp)
	end

	self:refreshItemBag()
	self:refreshHeroDetail()
	self:refreshHeroEquipWear()
	self:checkCanEquipInTeamHeros()
end

function EquipMixin:offArtifact(hero_gid, off_artifact_id)
	if self.bagArtifacts[off_artifact_id] then
		self.bagArtifacts[off_artifact_id].inWearing = nil
	end

	self.heroDic[hero_gid].artifactGid = 0
end

function EquipMixin:offRelic(hero_gid, off_relic_id)
	if self.bagRelics[off_relic_id] then
		self.bagRelics[off_relic_id].inWearing = nil
	end

	self.heroDic[hero_gid].relicId = 0
end

function EquipMixin:refreshHeroEquipWear()
	local heroEquipWearDlg = UIManager.getUI("heroEquipWearDlg", nil, false)

	if heroEquipWearDlg then
		local dataList = {}

		if self.wearType == Const.WEAR_TYPE_EQUIP then
			dataList = self:getAllEquips(self.filterAttr)
		elseif self.wearType == Const.WEAR_TYPE_ARTIFACT then
			dataList = self:getAllArtifacts(self.filterAttr, nil, nil, nil, heroEquipWearDlg.hero.id)
		end

		heroEquipWearDlg:refreshData(dataList)
	end
end

function EquipMixin:getAllEquips(filter, includeWearing, except, bagWearDic, exceptLock, includeRecycling)
	local bagEquips = bagWearDic or self.bagEquips
	local equips = {}

	for gid, equip in pairs(bagEquips) do
		if (not equip.inWearing or includeWearing) and (not except or equip.gid ~= except) and (not exceptLock or not equip.isLock or equip.isLock ~= Const.EQUIP_STATE_LOCK) and (equip.inRecycling ~= Const.EQUIP_STATE_RECYCLE or includeRecycling) and (filter == nil or filter == 0 or equip.subType == filter) then
			table.insert(equips, equip)
		end
	end

	return equips
end

local function _sortEquipReformList(a, b)
	if a.sortQuality ~= b.sortQuality then
		return a.sortQuality > b.sortQuality
	elseif a.sortDefineId ~= b.sortDefineId then
		return a.sortDefineId > b.sortDefineId
	elseif a.enhanceLevel ~= b.enhanceLevel then
		return a.enhanceLevel > b.enhanceLevel
	else
		return a.id < b.id
	end
end

function EquipMixin:getCanReformEquips(filter)
	local equips = {}

	for gid, equip in pairs(self.bagEquips) do
		if equip.enhanceLevel >= Const.EQUIP_REFORM_MIN_ENHANCE_LEVEL and equip.evolve >= Const.EQUIP_REFORM_MIN_EVOLVE_LEVEL and equip:isDefineHeroEquip() and (filter == nil or filter == 0 or equip.subType == filter) then
			table.insert(equips, equip)
		end
	end

	table.sort(equips, _sortEquipReformList)

	return equips
end

local function _sortDefineEquips(a, b)
	if a.sameDefineSuitId ~= b.sameDefineSuitId then
		return a.sameDefineSuitId > b.sameDefineSuitId
	elseif a.enhanceLevel ~= b.enhanceLevel then
		return a.enhanceLevel > b.enhanceLevel
	else
		return a.id < b.id
	end
end

function EquipMixin:getAllDefineEquipList(defineEffectId, suitId)
	local equips = {}

	for gid, equip in pairs(self.bagEquips) do
		local fakeEquipedItem = BaseObject.CopyObject(equip)

		fakeEquipedItem.inWearing = nil

		if defineEffectId == fakeEquipedItem.defineEffectId then
			fakeEquipedItem.sameDefineSuitId = suitId == fakeEquipedItem.suitId and 1 or 0

			if not equips[fakeEquipedItem.part] then
				equips[fakeEquipedItem.part] = {}
			end

			table.insert(equips[fakeEquipedItem.part], fakeEquipedItem)
		end
	end

	for _, equipList in pairs(equips) do
		table.sort(equipList, _sortDefineEquips)
	end

	return equips
end

function EquipMixin:getAllArtifacts(career, includeWearing, except, bagWearDic, heroId, exceptLock)
	local bagArtifacts = bagWearDic or self.bagArtifacts
	local artifacts = {}

	for gid, artifact in pairs(bagArtifacts) do
		if (not artifact.inWearing or includeWearing) and (not except or artifact.gid ~= except) and (not exceptLock or not artifact.isLock or artifact.isLock ~= Const.EQUIP_STATE_LOCK) and (career == nil or career == Const.CAREER_TYPE.ALL or artifact.career == career or artifact.career == Const.CAREER_TYPE.ALL) and (heroId == nil or artifact.heroId == nil or artifact.heroId == heroId) then
			table.insert(artifacts, artifact)
		end
	end

	return artifacts
end

function EquipMixin:getArtifactNumById(id)
	if not id then
		return 0
	end

	local bagArtifacts = self.bagArtifacts
	local cnt = 0

	for gid, artifact in pairs(bagArtifacts) do
		if artifact.id == id then
			local extraNum = artifact.breakLevel

			cnt = cnt + 1 + extraNum
		end
	end

	return cnt
end

function EquipMixin:getAllRelics(filter, includeWearing, except, bagWearDic)
	local bagRelics = bagWearDic or self.bagRelics
	local relics = {}

	for gid, relic in pairs(bagRelics) do
		if (not relic.inWearing or includeWearing) and (not except or relic.gid ~= except) and (filter == nil or filter == 0 or relic.subType == filter) then
			table.insert(relics, relic)
		end
	end

	return relics
end

function EquipMixin:isRelicsUpToLevel(id, enhanceLv)
	if not id or not enhanceLv then
		return false
	end

	local bagRelics = self.bagRelics
	local relic = bagRelics[id]

	if not relic then
		return false
	end

	if enhanceLv <= relic.enhanceLevel then
		return true
	end

	local curNum = CurAvatar:getItemNumById(relic.lvUpMaterialId)
	local needNum = 0

	for lv = relic.enhanceLevel + 1, enhanceLv do
		needNum = needNum + relic.levelUpInfo[lv].material_cost
	end

	return needNum <= curNum
end

function EquipMixin:getCanWearRelics(hero, includeWearing, bagWearDic)
	local bagRelics = bagWearDic or self.bagRelics
	local relics = {}

	for gid, relic in pairs(bagRelics) do
		if (not relic.inWearing or includeWearing) and relic:isCanBeWear(hero) then
			table.insert(relics, relic)
		end
	end

	return relics
end

function EquipMixin:getCanWearRelicsInAll(hero, includeWearing)
	local relics = {}

	for id, _ in pairs(ResRelic) do
		local relic = self.bagRelics[id]

		if not relic then
			local rInfo = {}

			rInfo.id = id
			rInfo.level = 0
			relic = Relic(rInfo)
		end

		if (not relic.inWearing or includeWearing) and relic:isCanBeWear(hero) then
			table.insert(relics, relic)
		end
	end

	return relics
end

function EquipMixin:relicCanLvUp(relic)
	local lvUpMaterialInfo = relic:getLvUpNeed()

	if lvUpMaterialInfo then
		for materialId, needNum in pairs(lvUpMaterialInfo) do
			if needNum > CurAvatar:getItemNumById(materialId) then
				return false
			end
		end
	else
		return false
	end

	return true
end

function EquipMixin:getBagEquipMaxRank(hero, bagWearDic, defineHeroId, ignoreWearing)
	local bagEquipMaxRankDic = {}
	local reSuitData = hero and hero:getRecSuit() or {}
	local bagEquips = bagWearDic ~= nil and bagWearDic.equips or self.bagEquips
	local equips = {}

	for gid, equip in pairs(bagEquips) do
		if not equips[equip.part] then
			equips[equip.part] = {}
		end

		if defineHeroId then
			equip:initRankScore(defineHeroId)
		else
			equip:initRankScore()
		end

		if hero then
			table.insert(equips[equip.part], equip)
		elseif ignoreWearing or not equip.inWearing then
			table.insert(equips[equip.part], equip)
		end
	end

	for banType, banInfo in pairs(Const.HERO_PROP_INVALID_BAN) do
		local maxEquipDic = {}

		bagEquipMaxRankDic[banType] = maxEquipDic

		for i = 1, 6 do
			local equipList = equips[i] or {}
			local maxEquip
			local maxRank = 0
			local maxSuitRank = {}
			local maxSuitEquip = {}

			for idx, equip in ipairs(equipList) do
				if equip.inRecycling ~= Const.EQUIP_STATE_RECYCLE and (not hero or ignoreWearing or not equip.inWearing or equip.inWearing == hero.gid) then
					local rank = equip:getRankScore(banType)

					if maxSuitRank[equip.suitId] == nil or rank > maxSuitRank[equip.suitId] then
						maxSuitRank[equip.suitId] = rank
						maxSuitEquip[equip.suitId] = equip
					end

					if maxRank < rank then
						maxRank = rank
						maxEquip = equip
					elseif hero and rank == maxRank then
						if equip.inWearing == hero.gid then
							maxRank = rank
							maxEquip = equip
						elseif reSuitData.suit_id == equip.suitId then
							maxRank = rank
							maxEquip = equip
						end
					end
				end
			end

			for suitId, _ in ipairs(ResEquipSuit) do
				if not maxEquipDic[suitId] then
					maxEquipDic[suitId] = {}
				end

				if maxSuitEquip[suitId] then
					maxEquipDic[suitId][i] = maxSuitEquip[suitId]
				end
			end

			if not maxEquipDic[0] then
				maxEquipDic[0] = {}
			end

			maxEquipDic[0][i] = maxEquip
		end
	end

	local bagArtifactMaxRankDic = {}
	local bagCustomMadeArtifactDic = {}
	local bagArtifacts = bagWearDic ~= nil and bagWearDic.artifacts or self.bagArtifacts

	for _, artifact in pairs(bagArtifacts) do
		if ignoreWearing or not artifact.inWearing then
			if artifact.heroId then
				if not bagCustomMadeArtifactDic[artifact.heroId] then
					bagCustomMadeArtifactDic[artifact.heroId] = {
						rank = artifact.rankScore,
						obj = artifact
					}
				end

				if artifact.rankScore > bagCustomMadeArtifactDic[artifact.heroId].rank then
					bagCustomMadeArtifactDic[artifact.heroId] = {
						rank = artifact.rankScore,
						obj = artifact
					}
				end
			else
				if not bagArtifactMaxRankDic[artifact.career] then
					bagArtifactMaxRankDic[artifact.career] = {}
				end

				if not bagArtifactMaxRankDic[artifact.career][artifact.mechanismType] then
					bagArtifactMaxRankDic[artifact.career][artifact.mechanismType] = {
						rank = artifact.rankScore,
						obj = artifact
					}
				end

				if artifact.rankScore > bagArtifactMaxRankDic[artifact.career][artifact.mechanismType].rank then
					bagArtifactMaxRankDic[artifact.career][artifact.mechanismType] = {
						rank = artifact.rankScore,
						obj = artifact
					}
				end
			end
		end
	end

	if bagArtifactMaxRankDic[Const.CAREER_TYPE.ALL] then
		for _, career in pairs(Const.CAREER_TYPE) do
			if career ~= Const.CAREER_TYPE.ALL then
				if not bagArtifactMaxRankDic[career] then
					bagArtifactMaxRankDic[career] = {}
				end

				for mechanismType, maxInfo in pairs(bagArtifactMaxRankDic[Const.CAREER_TYPE.ALL]) do
					if not bagArtifactMaxRankDic[career][mechanismType] then
						bagArtifactMaxRankDic[career][mechanismType] = maxInfo
					elseif maxInfo.rank > bagArtifactMaxRankDic[career][mechanismType].rank then
						bagArtifactMaxRankDic[career][mechanismType] = maxInfo
					end
				end
			end
		end
	end

	return bagEquipMaxRankDic, bagArtifactMaxRankDic, bagCustomMadeArtifactDic
end

function EquipMixin:getEquipCount()
	local count = 0

	for k, v in pairs(self.bagEquips) do
		count = count + 1
	end

	return count
end

function EquipMixin:getArtifactCount()
	local count = 0

	for k, v in pairs(self.bagArtifacts) do
		count = count + 1
	end

	return count
end

function EquipMixin:getSameIdArtifacts(id, includeWearing, except, exceptLock)
	local artifacts = {}

	for gid, artifact in pairs(self.bagArtifacts) do
		if (not artifact.inWearing or includeWearing) and (not except or artifact.gid ~= except) and (not exceptLock or not artifact.isLock or artifact.isLock ~= Const.EQUIP_STATE_LOCK) and artifact.id == id then
			table.insert(artifacts, artifact)
		end
	end

	return artifacts
end

function EquipMixin:getAllEquipUpgradeMaterial(part)
	local allUpgradeMaterial = self:getItemsByStype({
		[Const.ITEM_STYPE_EQUIP_UPGRADE_MATERIAL] = true
	})
	local materialList = {}

	for _, item in ipairs(allUpgradeMaterial) do
		if (item.resData.extend_args1 == part or item.resData.extend_args1 == 0) and item.num > 0 then
			item.upgradePart = part

			table.insert(materialList, item)
		end
	end

	return materialList
end

function EquipMixin:getAllArtifactUpgradeMaterial(targetItem, isBreak)
	local allUpgradeMaterial = {}

	if isBreak then
		self:addBreakMaterial(targetItem, allUpgradeMaterial)
	else
		allUpgradeMaterial = self:getItemsByStype({
			[Const.ITEM_STYPE_ARTIFACT_UPGRADE_MATERIAL] = true
		})

		self:addBreakMaterial(targetItem, allUpgradeMaterial)
	end

	local materialList = {}

	for _, item in ipairs(allUpgradeMaterial) do
		if item.num > 0 then
			item.upgradePart = 0

			table.insert(materialList, item)
		end
	end

	return materialList
end

function EquipMixin:getAllCanBuildEquip()
	local allBuildEquips = {}

	for i, equip in pairs(self.bagEquips or {}) do
		if equip.level == Const.EQUIP_QUALITY_PINK then
			if equip:isDefineHeroEquip() then
				if equip.buildQuality and equip.buildQuality < Const.EQUIP_BUILD_MAX then
					table.insert(allBuildEquips, equip)
				end
			else
				table.insert(allBuildEquips, equip)
			end
		end
	end

	return allBuildEquips
end

function EquipMixin:getBuildEquipByStone(effectId)
	local allBuildEquips = self:getAllCanBuildEquip()
	local buildEquipsList = {}

	for i, equip in pairs(allBuildEquips or {}) do
		if equip:isDefineHeroEquip() then
			if equip.defineEffectId and effectId and equip.defineEffectId == effectId then
				table.insert(buildEquipsList, equip)
			end
		else
			table.insert(buildEquipsList, equip)
		end
	end

	return buildEquipsList
end

function EquipMixin:getAllBuildStone()
	local allUpgradeMaterial = self:getItemsByStype({
		[Const.ITEM_STYPE_BUILD_STONE] = true
	})
	local materialList = {}

	for _, item in ipairs(allUpgradeMaterial) do
		if item.num > 0 then
			table.insert(materialList, item)
		end
	end

	return materialList
end

function EquipMixin:getBuildStoneBySpeEquip(effectId)
	local allStoneList = self:getAllBuildStone()
	local materialList = {}

	for i, stone in pairs(allStoneList or {}) do
		if effectId and stone.resData.extend_args1 == effectId then
			table.insert(materialList, stone)
		end
	end

	return materialList
end

function EquipMixin:onEquipBuildResp(gid, build_exp, effect_id)
	local newEquip

	for i, equip in pairs(self.bagEquips) do
		if equip.gid == gid then
			newEquip = equip

			break
		end
	end

	local heroEquipBuildDlg = UIManager.getUI("heroEquipBuildDlg", nil, false)

	if heroEquipBuildDlg then
		heroEquipBuildDlg:onEquipBuild(newEquip)
	end

	self:refreshItemBag()
	self:refreshHeroDetail()
	self:refreshHeroEquipWear()
	self:checkCanEquipInTeamHeros()
end

function EquipMixin:onEquipBuildLevelUpResp(gid, build_exp)
	local newEquip

	for i, equip in pairs(self.bagEquips) do
		if equip.gid == gid then
			newEquip = equip

			break
		end
	end

	local heroEquipBuildDlg = UIManager.getUI("heroEquipBuildDlg", nil, false)

	if heroEquipBuildDlg then
		heroEquipBuildDlg:onEquipBuild(newEquip)
	end

	self:refreshItemBag()
	self:refreshHeroDetail()
	self:refreshHeroEquipWear()
	self:checkCanEquipInTeamHeros()
end

function EquipMixin:onEquipLockResp(gid, lock)
	local msg = lock == Const.EQUIP_STATE_LOCK and Lang.get(96465) or Lang.get(96466)

	MsgManager.notice(msg)

	if self.bagEquips[gid] then
		self.bagEquips[gid].isLock = lock
		self.bagEquips[gid]._serverData.lock = lock
	end

	local equipTips = UIManager.tryGetUI("equipTips")

	if equipTips then
		equipTips:refreshLockInfo()
	end

	self:refreshItemBag()
	self:refreshHeroDetail()
end

function EquipMixin:onArtifactLockResp(gid, lock)
	local msg = lock == Const.EQUIP_STATE_LOCK and Lang.get(96467) or Lang.get(96468)

	MsgManager.notice(msg)

	if self.bagArtifacts[gid] then
		self.bagArtifacts[gid].isLock = lock
	end

	local artifactTips = UIManager.tryGetUI("artifactTips")

	if artifactTips then
		artifactTips:refreshLockInfo()
	end

	self:refreshItemBag()
	self:refreshHeroDetail()
end

function EquipMixin:addBreakMaterial(targetItem, allUpgradeMaterial)
	if targetItem.breakLevel >= targetItem:getMaxBreakLv() then
		return
	end

	local breakMaterial = self:getItemsByStype({
		[Const.ITEM_STYPE_ARTIFACT_BREAK_MATERIAL] = true
	})

	for _, item in ipairs(breakMaterial) do
		if item.resData.extend_args1 == 0 or item.resData.extend_args1 == targetItem.career then
			for _, quality in ipairs(item.resData.extend_args3) do
				if quality == targetItem.quality then
					table.insert(allUpgradeMaterial, item)

					break
				end
			end
		end
	end
end

function EquipMixin:getBreakLvByEnhanceLv(artifact)
	local breakLv = 0

	for i = 0, Const.ARTIFACT_MAX_BREAK_LEVEL do
		if artifact.enhanceLevel > ResArtifactLevelUp[i].limit_level then
			breakLv = i + 1
		end
	end

	return breakLv
end

function EquipMixin:getHaveExpByEquip(equip)
	local equipXp = equip.resData.xp

	return equipXp + math.floor(equip.enhanceExp * (equip.resData.discount_rate / 10000))
end

function EquipMixin:getHaveExpByItem(item)
	local itemXp = item.resData.extend_args2

	return itemXp
end

function EquipMixin:getEquipExpNeed(equip, enhanceLevel)
	enhanceLevel = math.min(enhanceLevel, #ResEquipLevelTemplete[equip.resData.templete_id])

	if enhanceLevel < 1 then
		return 0
	else
		return math.floor(ResEquipLevelTemplete[equip.resData.templete_id][enhanceLevel].need_xp * equip.resData.xp_rate)
	end
end

function EquipMixin:getEquipLevelByExp(equip, exp)
	local levelTemplete = ResEquipLevelTemplete[equip.resData.templete_id]
	local getLevel = 0

	for level, levelData in ipairs(levelTemplete) do
		if exp >= levelData.need_xp * equip.resData.xp_rate then
			getLevel = level
		else
			break
		end
	end

	return getLevel
end

function EquipMixin:isOpenCustomEquip(heroId)
	for _, effectData in pairs(ResEquipTowerCustomEquipEffect) do
		if effectData[1].hero_id == heroId then
			return true
		end
	end

	return false
end

function EquipMixin:getHaveExpByArtifact(artifact)
	local artifactXp = artifact.resData.xp

	return artifactXp + math.floor(artifact.enhanceExp * (artifact.resData.discount_rate / 10000))
end

function EquipMixin:getArtifactExpNeed(artifact, enhanceLevel)
	enhanceLevel = math.min(enhanceLevel, #ResArtifactXP[artifact.resData.templete_id])

	if enhanceLevel < 1 then
		return 0
	else
		return math.floor(ResArtifactXP[artifact.resData.templete_id][enhanceLevel].xp * artifact.resData.xp_rate)
	end
end

function EquipMixin:getArtifactLevelByExp(artifact, exp)
	local levelTemplete = ResArtifactXP[artifact.resData.templete_id]
	local getLevel = 0

	for level, levelData in ipairs(levelTemplete) do
		if exp >= levelData.xp * artifact.resData.xp_rate then
			getLevel = level
		else
			break
		end
	end

	return getLevel
end

function EquipMixin:getSuitPath(suitId)
	if suitId then
		return {
			UIConst.COMMON_ICON_PATH .. ResEquipSuit[suitId].iconPath,
			ResEquipSuit[suitId].icon
		}
	end
end

function EquipMixin:openWearDlg(wearType, hero, filterAttr, isFromEditPlan, bagWearDic, isFromBattle)
	local dataList = {}
	local noticeStrId = 0

	if wearType == Const.WEAR_TYPE_EQUIP then
		dataList = self:getAllEquips(filterAttr, nil, nil, bagWearDic)
		noticeStrId = 130
	elseif wearType == Const.WEAR_TYPE_ARTIFACT then
		dataList = self:getAllArtifacts(filterAttr, nil, nil, bagWearDic, hero.id)
		noticeStrId = 131
	elseif wearType == Const.WEAR_TYPE_RELIC then
		dataList = self:getCanWearRelics(hero, nil, bagWearDic)
		noticeStrId = 281

		local wearRelic = hero:getRelic()

		if wearRelic then
			table.insert(dataList, wearRelic)
		end
	end

	if #dataList > 0 then
		if wearType == Const.WEAR_TYPE_RELIC then
			local relicWearDlg = UIManager.getUI("relicWearDlg", true)

			relicWearDlg:setHero(hero, dataList, isFromEditPlan, nil, isFromBattle)
		else
			local heroEquipWearDlg = UIManager.getUI("heroEquipWearDlg", true)

			heroEquipWearDlg:setData(wearType, hero, filterAttr, isFromEditPlan, dataList, isFromBattle)
		end
	else
		MsgManager.clientNotice(noticeStrId)
	end
end

function EquipMixin:changeWearPartPlanData(hero, equipGids, artifactGid, relicId, refreshUI)
	local mainBagDlg = UIManager.getUI("mainBagDlg", nil, false)

	if mainBagDlg and mainBagDlg.panelWear then
		mainBagDlg.panelWear:changePlanData(hero, equipGids, artifactGid, relicId, refreshUI)
	end

	local battleBeforeWearDlg = UIManager.getUI("battleBeforeWearDlg", nil, false)

	if battleBeforeWearDlg and battleBeforeWearDlg.panelWear then
		battleBeforeWearDlg.panelWear:changePlanData(hero, equipGids, artifactGid, relicId, refreshUI)
	end
end

function EquipMixin:openUpgradeEquipDlg(upgradeType, targetItem, isFromBattle)
	if self:getEquipOrArtifactLvMax(upgradeType, targetItem) then
		if upgradeType == Const.UPGRADE_TYPE_ARTIFACT then
			MsgManager.clientNotice(247)
		else
			MsgManager.clientNotice(248)
		end

		return
	end

	local materialList = self:getUpgradeEquipMaterial(upgradeType, targetItem)

	if #materialList > 0 then
		local heroEquipUpGradeDlg = UIManager.getUI("heroEquipUpGradeDlg", true)

		heroEquipUpGradeDlg:setData(upgradeType, targetItem, materialList, isFromBattle)
	else
		MsgManager.clientNotice(132)
	end
end

function EquipMixin:getEquipOrArtifactLvMax(upgradeType, targetItem)
	if upgradeType == Const.UPGRADE_TYPE_EQUIP then
		return targetItem.enhanceLevel >= targetItem:getMaxLevel()
	elseif upgradeType == Const.UPGRADE_TYPE_ARTIFACT then
		return targetItem.enhanceLevel >= targetItem:getMaxEnhanceLv()
	end
end

function EquipMixin:getIsHaveArtifactById(artifactId)
	for _, artifact in pairs(self.bagArtifacts) do
		if artifact.id == artifactId then
			return true
		end
	end

	return self:isItemInMailbox(artifactId)
end

function EquipMixin:getArtifactById(artifactId, artifactDic)
	artifactDic = artifactDic or self.bagArtifacts

	local nowLevel = -1
	local nowArtifact

	for _, artifact in pairs(artifactDic) do
		if artifact.id == artifactId and nowLevel < artifact.enhanceLevel then
			nowArtifact = artifact
			nowLevel = artifact.enhanceLevel
		end
	end

	return nowArtifact
end

function EquipMixin:getUpgradeEquipMaterial(upgradeType, targetItem)
	local materialList = {}
	local equipList = {}

	if upgradeType == Const.UPGRADE_TYPE_EQUIP then
		materialList = self:getAllEquipUpgradeMaterial(targetItem.part)
		equipList = self:getAllEquips(targetItem.part, false, targetItem.gid, nil, true)
	elseif upgradeType == Const.UPGRADE_TYPE_ARTIFACT then
		local curLevel = targetItem.enhanceLevel
		local curExp = targetItem.enhanceExp
		local limitLevel = ResArtifactLevelUp[targetItem.breakLevel].limit_level

		if curLevel < limitLevel then
			materialList = self:getAllArtifactUpgradeMaterial(targetItem)
			equipList = self:getAllArtifacts(nil, false, targetItem.gid, nil, nil, true)
		else
			materialList = self:getAllArtifactUpgradeMaterial(targetItem, true)
			equipList = self:getSameIdArtifacts(targetItem.id, true, targetItem.gid, true)
		end
	end

	for _, data in ipairs(equipList) do
		if data.itemType ~= Const.ITEM_TYPE_ARTIFACT or data.quality <= targetItem.quality then
			local isReform = false

			if data.itemType == Const.ITEM_TYPE_EQUIP then
				local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_EQUIP_REFINE)

				if actObj and actObj:isValid() and actObj.actData:isEquipReform(data.gid) then
					isReform = true
				end
			end

			if not isReform and data.inRecycling ~= Const.EQUIP_STATE_RECYCLE then
				table.insert(materialList, data)
			end
		end
	end

	if #materialList == 0 and upgradeType == Const.UPGRADE_TYPE_ARTIFACT then
		local curLevel = targetItem.enhanceLevel
		local curExp = targetItem.enhanceExp
		local limitLevel = ResArtifactLevelUp[targetItem.breakLevel].limit_level

		if limitLevel <= curLevel then
			for _, resData in pairs(ResItem) do
				if resData.subtype == Const.ITEM_STYPE_ARTIFACT_BREAK_MATERIAL then
					local item = BaseObject.GetObject(resData.id)

					if item.resData.extend_args1 == 0 or item.resData.extend_args1 == targetItem.career then
						for _, quality in ipairs(item.resData.extend_args3) do
							if quality == targetItem.quality then
								item.upgradePart = item.resData.extend_args1

								table.insert(materialList, item)

								break
							end
						end
					end
				end
			end

			table.insert(materialList, BaseObject.GetObject(targetItem.id))
		end
	end

	if upgradeType == Const.UPGRADE_TYPE_ARTIFACT then
		for _, item in ipairs(materialList) do
			if item.itemType == Const.ITEM_TYPE_ARTIFACT and item.id == targetItem.id and item.breakLevel == 0 then
				item.isSameIdNoBreakArtifact = 1
			else
				item.isSameIdNoBreakArtifact = 0
			end
		end
	end

	return materialList
end

function EquipMixin:getMaterialEquipTowerCanSweep(materialId)
	if ResItem[materialId].get_ids then
		for _, getId in ipairs(ResItem[materialId].get_ids) do
			local args = ResGuideGet[getId].condition_args
			local conditionOutput = self:getEquipTowerCondition(args)

			if self:getIsConditionAllPass(conditionOutput) then
				return true
			end
		end

		return false
	else
		return false
	end
end

function EquipMixin:getEquipCanEvolve(equip)
	return true
end

function EquipMixin:getCanEvoEquipPart(hero)
	local canEquipPartList = {}
	local equips = hero:getEquips()

	for part = 1, 6 do
		local equip = equips[part]

		if equip and equip:getCanEvo() then
			table.insert(canEquipPartList, part)
		end
	end

	return canEquipPartList
end

function EquipMixin:onEquipTakeOffCheck(grid)
	local obj = grid.object

	if obj.inWearing then
		return true
	else
		return false
	end
end

function EquipMixin:onEquipReplaceCheck(grid)
	local obj = grid.object

	if obj.inWearing then
		return true
	else
		return false
	end
end

function EquipMixin:onUpgradeEquipCheck(grid)
	local obj = grid.object

	if obj.canEnhance and obj.canEnhance == 1 then
		return true
	else
		return false
	end
end

function EquipMixin:onEquipLockCheck(grid)
	return true
end

function EquipMixin:onEquipDestroyCheck(grid)
	local obj = grid.object

	if obj.inWearing then
		return false
	else
		return true
	end
end

local function confirmOffEquip(obj)
	RPC.equipOff(obj.inWearing, {
		obj.subType - 1
	})
end

function EquipMixin:onTakeOffEquip(grid)
	local obj = grid.object

	if obj.inWearing then
		if grid.uiConfig and grid.uiConfig.fromEditPlan then
			local willReplaceGid = obj.gid
			local gidList = grid.uiConfig.wearHero:getEquipGidList()

			for i, gid in ipairs(gidList) do
				if gid == willReplaceGid then
					table.remove(gidList, i)
				end
			end

			self:changeWearPartPlanData(grid.uiConfig.wearHero, gidList, nil, nil, true)
		else
			RPC.equipOff(obj.inWearing, {
				obj.subType - 1
			})
		end
	end
end

function EquipMixin:onUpgradeEquip(grid)
	if grid.uiConfig and grid.uiConfig.fromEditPlan then
		MsgManager.clientNotice(376)

		return
	end

	local isFromBattle

	if grid.uiConfig and grid.uiConfig.fromBattle then
		isFromBattle = true
	end

	local obj = grid.object

	if obj then
		self:openUpgradeEquipDlg(Const.UPGRADE_TYPE_EQUIP, obj, isFromBattle)
	end
end

function EquipMixin:onReplaceEquip(grid)
	local obj = grid.object

	if obj and obj.inWearing then
		local isFromBattle

		if grid.uiConfig and grid.uiConfig.fromBattle then
			isFromBattle = true
		end

		if grid.uiConfig and grid.uiConfig.fromEditPlan then
			self:openWearDlg(Const.WEAR_TYPE_EQUIP, grid.uiConfig.wearHero, obj.subType, true, grid.uiConfig.bagEquips, isFromBattle)
		else
			self:openWearDlg(Const.WEAR_TYPE_EQUIP, self.heroDic[obj.inWearing], obj.subType, nil, nil, isFromBattle)
		end
	end
end

function EquipMixin:onLockEquip(grid)
	local obj = grid.object

	if obj then
		if obj.isLock and obj.isLock == Const.EQUIP_STATE_LOCK then
			RPC.equipLock(obj.gid, 0)
		else
			RPC.equipLock(obj.gid, 1)
		end
	end

	return true
end

function EquipMixin:onDestroyEquip(grid)
	local obj = grid.object

	if obj then
		if obj.inWearing then
			MsgManager.clientNotice(285)

			return true
		elseif obj.isLock and obj.isLock == Const.EQUIP_STATE_LOCK then
			MsgManager.notice(Lang.get(96469))

			return true
		else
			local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_EQUIP_REFINE)

			if actObj and actObj:isValid() and actObj.actData:isEquipReform(obj.gid) then
				MsgManager.notice(Lang.get(91262))

				return true
			end

			local function yesFunc()
				RPC.equipSell({
					obj.gid
				})
			end

			local msgContent = string.format(ClientUtils.getClientNotice(432), obj:getSellPriceStr())

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, yesFunc, nil, -1)
		end
	end
end

function EquipMixin:onArtifactTakeOffCheck(grid)
	local obj = grid.object

	if obj.inWearing then
		return true
	else
		return false
	end
end

function EquipMixin:onArtifactReplaceCheck(grid)
	local obj = grid.object

	if obj.inWearing then
		return true
	else
		return false
	end
end

function EquipMixin:onArtifactLockCheck(grid)
	return true
end

function EquipMixin:onArtifactVisibleCheck(grid)
	return false
end

function EquipMixin:onArtifactDestroyCheck(grid)
	local obj = grid.object

	if obj.inWearing then
		return false
	else
		return true
	end
end

function EquipMixin:onTakeOffArtifact(grid)
	local obj = grid.object

	if obj and obj.inWearing then
		if grid.uiConfig and grid.uiConfig.fromEditPlan then
			self:changeWearPartPlanData(grid.uiConfig.wearHero, nil, 0, nil, true)
		else
			RPC.artifactOff(obj.inWearing, obj.gid)
		end
	end
end

function EquipMixin:onUpgradeArtifact(grid)
	if grid.uiConfig and grid.uiConfig.fromEditPlan then
		MsgManager.clientNotice(376)

		return
	end

	local isFromBattle

	if grid.uiConfig and grid.uiConfig.fromBattle then
		isFromBattle = true
	end

	local obj = grid.object

	if obj then
		self:openUpgradeEquipDlg(Const.UPGRADE_TYPE_ARTIFACT, obj, isFromBattle)
	end
end

function EquipMixin:onUpgradeArtifactCheck(grid)
	local obj = grid.object

	if obj then
		local limitLevel = ResArtifactLevelUp[obj.breakLevel].limit_level

		return limitLevel > obj.enhanceLevel
	end
end

function EquipMixin:onBreakArtifactCheck(grid)
	local obj = grid.object

	if obj then
		local limitLevel = ResArtifactLevelUp[obj.breakLevel].limit_level

		return limitLevel == obj.enhanceLevel
	end
end

function EquipMixin:onReplaceArtifact(grid)
	local obj = grid.object

	if obj and obj.inWearing then
		local isFromBattle

		if grid.uiConfig and grid.uiConfig.fromBattle then
			isFromBattle = true
		end

		if grid.uiConfig and grid.uiConfig.fromEditPlan then
			self:openWearDlg(Const.WEAR_TYPE_ARTIFACT, grid.uiConfig.wearHero, self.heroDic[obj.inWearing].career, true, grid.uiConfig.bagArtifacts, isFromBattle)
		else
			self:openWearDlg(Const.WEAR_TYPE_ARTIFACT, self.heroDic[obj.inWearing], self.heroDic[obj.inWearing].career, nil, nil, isFromBattle)
		end
	end
end

function EquipMixin:onLockArtifact(grid)
	local obj = grid.object

	if obj then
		if obj.isLock and obj.isLock == Const.EQUIP_STATE_LOCK then
			RPC.artifactLock(obj.gid, 0)
		else
			RPC.artifactLock(obj.gid, 1)
		end
	end

	return true
end

function EquipMixin:onDestroyArtifact(grid)
	local obj = grid.object

	if obj then
		if obj.inWearing then
			MsgManager.clientNotice(286)

			return true
		elseif obj.isLock and obj.isLock == Const.EQUIP_STATE_LOCK then
			MsgManager.clientNotice(Lang.get(96467))

			return true
		else
			RPC.artifactSell({
				obj.gid
			})
		end
	end
end

function EquipMixin:onRelicGetNotify(relicList)
	for _, rInfo in ipairs(relicList) do
		local relic = Relic(rInfo)

		self.bagRelics[relic.id] = relic

		self:onCollectAchieveProgressNotify(Const.CRYSTAL_TYPE_RELIC, relic.id, 0, ClientUtils.getBitsDictFromByteString(rInfo.collect_award))
	end

	self:refreshItemBag()
	self:checkCanEquipInTeamHeros()
	self:checkRelicUpgradeHint()
end

function EquipMixin:onRelicWearResp(hero_gid, relic_id, off_relic_id)
	local realHero = self.heroDic[hero_gid]
	local nakedHeroAttr = self:getRealHeroAttr(realHero)

	self:offRelic(hero_gid, off_relic_id)

	self.heroDic[hero_gid].relicId = relic_id

	self.heroDic[hero_gid]:refreshSkillInfo()

	self.bagRelics[relic_id].inWearing = hero_gid

	local realHeroAttr = self:getRealHeroAttr(realHero)

	self:calAndShowNumAttr(realHeroAttr, nakedHeroAttr)

	local heroMainDlg = UIManager.getUI("heroMainDlg", nil, false)

	if heroMainDlg then
		local equipPanel = heroMainDlg.heroContentPanel.panelList[Const.HERO_CONTENT_PANEL.HERO_EQUIP]

		if equipPanel and equipPanel:getVisible() then
			equipPanel:playRelicEfx()
		end
	end

	self:refreshHeroDetail(hero_gid)
	self:closeWearDlg()

	if heroMainDlg and not heroMainDlg:isInShow() then
		local equipPanel = heroMainDlg.heroContentPanel.panelList[Const.HERO_CONTENT_PANEL.HERO_EQUIP]

		if equipPanel and equipPanel:getVisible() then
			equipPanel:clearEfx()
		end
	end

	self:refreshItemBag()
	self:checkCanEquipInTeamHeros()
end

function EquipMixin:onRelicOffResp(hero_gid, off_relic_id)
	local realHero = self.heroDic[hero_gid]
	local nakedHeroAttr = self:getRealHeroAttr(realHero)

	self:offRelic(hero_gid, off_relic_id)

	local heroMainDlg = UIManager.getUI("heroMainDlg", nil, false)

	if heroMainDlg then
		local bgmId = self.bagRelics[off_relic_id]:getBgmIdByType(Const.RELIC_BGM_TYPE_HERO_DLG)

		if bgmId then
			heroMainDlg:stopLogicBGM()
		end
	end

	local realHeroAttr = self:getRealHeroAttr(realHero)

	self:calAndShowNumAttr(realHeroAttr, nakedHeroAttr)
	self:refreshHeroDetail(hero_gid)
	self:refreshItemBag()
	self:closeWearDlg()
	self:checkCanEquipInTeamHeros(true)
end

function EquipMixin:onRelicLevelUpResp(relic_id, cur_level)
	local upServerData = utils.deepcopy(self.bagRelics[relic_id]._serverData)

	upServerData.level = upServerData.level + 1

	local upRelic = Relic(upServerData)

	upRelic.inWearing = self.bagRelics[relic_id].inWearing
	self.bagRelics[relic_id] = upRelic

	self:refreshItemBag()
	self:refreshHeroDetail()
	self:checkCanEquipInTeamHeros()
	self:checkRelicUpgradeHint()

	local relicWearDlg = UIManager.getUI("relicWearDlg", nil, false)

	if relicWearDlg then
		local relicUpgradeResultDlg = UIManager.getUI("relicUpgradeResultDlg", true)

		relicUpgradeResultDlg:setRelic(upRelic)
		relicWearDlg:refreshForNewSelectedRelic(self.bagRelics[relic_id])
	else
		local relicUpgradeResultDlg = UIManager.getUI("relicUpgradeResultDlg", true)

		relicUpgradeResultDlg:setRelic(upRelic)
	end

	self:onCollectAchieveProgressNotify(Const.CRYSTAL_TYPE_RELIC, relic_id, cur_level, ClientUtils.getBitsDictFromByteString(self.bagRelics[relic_id]._serverData.collect_award))
end

function EquipMixin:onSeasonRelicOpResp(relic_id, type, cur_level)
	local upServerData

	if self.bagSeasonRelics[relic_id] then
		upServerData = utils.deepcopy(self.bagSeasonRelics[relic_id]._serverData)
		upServerData.level = cur_level
	else
		upServerData = {
			id = relic_id
		}
		upServerData.level = cur_level
	end

	local upRelic = Relic(upServerData)

	self.bagSeasonRelics[relic_id] = upRelic

	local heroMainDlg = UIManager.getUI("heroMainDlg", nil, false)

	if heroMainDlg then
		local equipPanel = heroMainDlg.heroContentPanel.panelList[Const.HERO_CONTENT_PANEL.HERO_EQUIP]

		if equipPanel and equipPanel:getVisible() then
			equipPanel:playSeasonRelicEfx()
		end
	end

	self:checkCanLvUpSeasonRelicHeros()
	self:checkCanUnLockSeasonRelicHeros()
end

function EquipMixin:checkRelicUpgradeHint()
	for _, relic in pairs(self.bagRelics) do
		if self:relicCanLvUp(relic) then
			RedDotManager.setKeyState(UIConst.RD_HINT_BAG_RELIC, true)

			return
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_BAG_RELIC, false)
end

function EquipMixin:isRelicBagCanUse(relicBag)
	if relicBag.resData.extend_args3 and ResRandClient[relicBag.resData.extend_args3[1]] and ResRandClient[relicBag.resData.extend_args3[1]].show_ids then
		local relicIds = ResRandClient[relicBag.resData.extend_args3[1]].show_ids

		for _, relicId in ipairs(relicIds) do
			local relic = self.bagRelics[relicId]

			if not relic or self:relicIsCanGetMaterial(relic) then
				return true
			end
		end
	end

	return false
end

function EquipMixin:relicIsCanGetMaterial(relic)
	if relic:isEnhanceLvMax() then
		return false
	else
		local needMaterialCount = 0

		for level = relic.enhanceLevel + 1, relic.maxLevel do
			local resLvInfo = relic.levelUpInfo[level]

			if resLvInfo and resLvInfo.material_cost then
				needMaterialCount = needMaterialCount + resLvInfo.material_cost
			end
		end

		return needMaterialCount > self:getItemNumById(relic.lvUpMaterialId)
	end
end

function EquipMixin:getRelicByMaterial(material)
	if self.bagRelics then
		local relicId = 0

		for _, relic in pairs(self.bagRelics) do
			if relic.lvUpMaterialId and relic.lvUpMaterialId == material.id then
				relicId = relic.id
			end
		end

		if relicId ~= 0 then
			local relic = self.bagRelics[relicId]

			if relic then
				return relic
			end
		end
	end
end

function EquipMixin:getAllCanRecycleEquipList()
	local list = {}

	for i, equip in pairs(self.bagEquips) do
		if equip.isExclusive and equip.isLock ~= Const.EQUIP_STATE_LOCK and not equip.inWearing then
			table.insert(list, equip)
		end
	end

	return list
end

function EquipMixin:refreshBraceletExchange(...)
	local ui = UIManager.tryGetUI("activityBraceletExchangeDlg")

	if ui and ui:getVisible() then
		ui:setData()
	end
end

function EquipMixin:onOpActEquipRecycleChooseResp(actId, type, gid)
	if type == "kEquipRecycleOpTypeDelete" then
		if gid and self.bagEquips and self.bagEquips[gid] then
			self.bagEquips[gid].inRecycling = Const.EQUIP_STATE_UNRECYCLE
		end
	elseif type == "kEquipRecycleOpTypeAdd" and gid and self.bagEquips and self.bagEquips[gid] then
		self.bagEquips[gid].inRecycling = Const.EQUIP_STATE_RECYCLE
	end

	local ui = UIManager.tryGetUI("mainBagDlg")

	if ui then
		ui:refreshMode()
	end
end

function EquipMixin:onOpActEquipRecycleNotify(equips)
	for _, equip in ipairs(equips or {}) do
		if equip.equip_gid and self.bagEquips and self.bagEquips[equip.equip_gid] then
			self.bagEquips[equip.equip_gid].inRecycling = equip.recycle
		end
	end

	local ui = UIManager.tryGetUI("mainBagDlg")

	if ui and ui:getVisible() then
		ui:refreshMode()
	end
end

function EquipMixin:onOpActEquipRecycleUnlockWorkShopResp(...)
	local ui = UIManager.tryGetUI("activityEquipRecycleDlg")

	if ui then
		ui.panelEquipRecycle:onUnlockTime()
	end
end

function EquipMixin:getEquipRecycleExchangeHeroData()
	local ResTimeValidConfig = require("ClientData/ResTimeValidConfig")
	local nowHeroData

	for id, data in pairs(ResEquipRecycleExchange) do
		local beginTimeId = data.begin_time
		local endTimeId = data.end_time

		if beginTimeId and endTimeId and ResTimeValidConfig[beginTimeId] and ResTimeValidConfig[endTimeId] then
			local beginTime = ClientUtils.getServerTimeByTimeStr(ResTimeValidConfig[beginTimeId].valid_tick)
			local endTime = ClientUtils.getServerTimeByTimeStr(ResTimeValidConfig[endTimeId].valid_tick)

			if beginTime <= ClientUtils.getServerTime() and endTime >= ClientUtils.getServerTime() then
				nowHeroData = data

				break
			end
		end
	end

	local nextHeroData

	if nowHeroData then
		for id, data in pairs(ResEquipRecycleExchange) do
			if data.begin_time == nowHeroData.end_time then
				local beginTime = ClientUtils.getServerTimeByTimeStr(ResTimeValidConfig[data.begin_time].valid_tick)

				data.beginTime = beginTime
				nextHeroData = data
			end
		end
	end

	return nowHeroData, nextHeroData
end

function EquipMixin:getEquipRecycleReturn(equip, recycleType)
	local itemIds = {}
	local itemNums = {}
	local visMap = {}

	if equip then
		if recycleType and recycleType ~= 0 and ResEquipRecycleAward[recycleType] and equip.buildQuality and equip.buildQuality ~= 0 then
			local randId

			if ResEquipRecycleAward[recycleType] and ResEquipRecycleAward[recycleType][equip.buildQuality] then
				randId = ResEquipRecycleAward[recycleType][equip.buildQuality].award
			end

			if randId and ResRandClient[randId] then
				local nums = ResRandClient[randId].show_nums

				for index, id in ipairs(ResRandClient[randId].show_ids) do
					if visMap[id] then
						itemNums[visMap[id]] = itemNums[visMap[id]] + nums[index]
					else
						table.insert(itemIds, id)
						table.insert(itemNums, nums[index])

						visMap[id] = #itemIds
					end
				end
			end
		end

		if equip.enhanceLevel and equip.enhanceLevel ~= 0 and ResEquipRecycleReturn[equip.enhanceLevel] then
			local returnData = ResEquipRecycleReturn[equip.enhanceLevel]

			if visMap[returnData.item_id] then
				itemNums[visMap[returnData.item_id]] = itemNums[visMap[returnData.item_id]] + returnData.item_num
			else
				table.insert(itemIds, returnData.item_id)
				table.insert(itemNums, returnData.item_num)

				visMap[returnData.item_id] = #itemIds
			end
		end

		if equip.evolve and equip.evolve ~= 0 and ResEquipReturn[equip.evolve] and ResEquipReturn[equip.evolve][equip.part] then
			local evoReturnData = ResEquipReturn[equip.evolve][equip.part]

			for index, data in ipairs(evoReturnData.ret_item) do
				if visMap[data.id] then
					itemNums[visMap[data.id]] = itemNums[visMap[data.id]] + data.num
				else
					table.insert(itemIds, data.id)
					table.insert(itemNums, data.num)

					visMap[data.id] = #itemIds
				end
			end
		end
	end

	return itemIds, itemNums
end

function EquipMixin:onEquipTeamWearResp(wearList)
	if not wearList then
		return
	end

	for _, wear in pairs(wearList) do
		local hero = wear.hero_gid
		local equipList = wear.equip_id
		local artifact = wear.artifact_id
		local relic = wear.relic_id

		if artifact and self.bagArtifacts and self.bagArtifacts[artifact] then
			local oldHero = self.bagArtifacts[artifact].inWearing

			if oldHero ~= hero then
				local oldArtifact = self.heroDic[hero].artifactGid

				if oldHero then
					self:offArtifact(oldHero, artifact)
				end

				if oldArtifact then
					self:offArtifact(hero, oldArtifact)
				end

				self.heroDic[hero].artifactGid = artifact
				self.bagArtifacts[artifact].inWearing = hero
			end
		end

		if relic and self.bagRelics and self.bagRelics[relic] then
			local oldHero = self.bagRelics[relic].inWearing

			if oldHero ~= hero then
				local oldRelic = self.heroDic[hero].relicId

				if oldHero then
					self:offRelic(oldHero, relic)
				end

				if oldRelic then
					self:offRelic(hero, oldRelic)
				end

				self.heroDic[hero].relicId = relic
				self.bagRelics[relic].inWearing = hero
			end
		end

		if equipList and self.bagEquips then
			for _, equip in ipairs(equipList) do
				local oldHero = self.bagEquips[equip].inWearing

				if oldHero ~= hero then
					local oldEquipInfo = self.heroDic[hero]:getEquipBySubType(self.bagEquips[equip].subType)

					if oldHero then
						self:offEquip(oldHero, equip)
					end

					if oldEquipInfo then
						self:offEquip(hero, oldEquipInfo.gid)
					end

					self.bagEquips[equip].inWearing = hero

					local gidStruct = {}

					gidStruct.gid = equip

					table.insert(self.heroDic[hero].equipList, gidStruct)
				end
			end
		end
	end
end

return EquipMixin
