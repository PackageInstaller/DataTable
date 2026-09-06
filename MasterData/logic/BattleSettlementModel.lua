-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/model/BattleSettlementModel.lua

module("logic.extensions.battlesettlement.model.BattleSettlementModel", package.seeall)

local BattleSettlementModel = class("BattleSettlementModel")

BattleSettlementModel.Enum = {
	Fengbaobao = 23,
	DivineDiShiTianClg = 59,
	DragonAwaken = 70,
	ShenJiChallenge = 52,
	HolyChall = 20,
	NeverLandDefendChallenge = 46,
	TunTianChallenge = 44,
	PeakTournamentFight = 40,
	BountyPKCompete = 38,
	Endless = 18,
	QieCuo = 21,
	TeachingDungeon = 17,
	WarriorTower = 9,
	EliteCopy = 16,
	KunLunChallengeNormal = 51,
	KingWay = 3,
	FamilyHoudingClg = 55,
	SummonTower = 27,
	NightFeastBoss = 57,
	Task = 8,
	GodDiShiTian = 33,
	FanRuiChallenge = 49,
	TongBattle = 24,
	LingShenChallenge = 61,
	NianNianChall = 25,
	HolyStripeCopy = 32,
	HalloweenBoss = 26,
	SixArtdaoguanNumbers = 71,
	Scenariocopy = 19,
	GodMonster = 10,
	KingArena = 69,
	AngelPower = 63,
	NuoYaSisterClgExtreme = 68,
	SimplyDesc = 54,
	YoungChampionKingQualifier = 65,
	DivineGasiri = 60,
	PetTrial = 12,
	Legend = 2,
	KingCiYuanChallenge = 41,
	ResCopy = 15,
	LailisiChanllenge = 34,
	HonourTowerChallenge = 43,
	Default = 1,
	DoDragonBossChallenge = 42,
	KingDragonChallenge = 36,
	CORBossChallenge = 37,
	FamilyWar = 29,
	PlotCopy = 14,
	NeverLandAttackChallenge = 45,
	DivineDakinosClg = 66,
	GodStatuesWar = 56,
	Chuangezhengli = 67,
	FamilyTeamplay = 22,
	VillaintrialPet = 31,
	GodARuiShi = 35,
	EternalChallenge = 48,
	DragonXiuerBossChallenge = 53,
	Expedition = 7,
	DragonKingARuiShiClg = 58,
	Eternalholydragon = 47,
	Roguelike = 64,
	ViretaActivity = 30,
	Arena = 13,
	LongZunChallenge = 39,
	HeartofJieshen = 62,
	WroldBoss = 28,
	NaiLongEvolve = 72,
	DivineCiYuanNationChallenge = 50
}

function BattleSettlementModel:onInit()
	self:onReset()
end

function BattleSettlementModel:onReset()
	self._txtTitle = ""
	self._battleResultEnum = self.Enum.Default

	table.clear(self._params)

	self._rewardChangeSetId = nil
	self._isDouble = false
	self._doubleNum = nil
	self._extraItems = nil
	self._fakeMatList = nil

	self:setBattleTopExtView(nil)
end

function BattleSettlementModel:getRewardList()
	local changeSetId = self:_getChangeSetId()

	if changeSetId then
		local var_3_0 = MaterialFacade.instance:getItemsByChangeSetId(changeSetId)

		if not var_3_0 then
			var_3_0 = MaterialController.instance:getTempItemsByChangeSetId(changeSetId)

			local items = var_3_0
			local rewardChangeSetId = self:_getRewardChangeSetId()

			if rewardChangeSetId then
				::label_3_0::

				local rewardItems = MaterialFacade.instance:getItemsByChangeSetId(rewardChangeSetId)
				local resultList = {}

				if rewardItems then
					local isDouble = self._isDouble

					for i, v in ipairs(rewardItems) do
						table.insert(resultList, {
							isDouble = isDouble,
							item = v,
							doubleNum = checknumber(self._doubleNum)
						})
					end
				end

				if items then
					for i, v in ipairs(items) do
						table.insert(resultList, {
							isDouble = false,
							item = v
						})
					end
				end

				local extraItems = self:_getExtraItems()

				if extraItems and type(extraItems) == "table" then
					for i, v in ipairs(extraItems) do
						table.insert(resultList, {
							isDouble = false,
							item = v
						})
					end
				end

				return resultList
			end
		end
	end
end

function BattleSettlementModel:checkHasRewardList()
	local changeSetId = self._changeSetId
	local items

	if changeSetId then
		items = MaterialController.instance:___getItemsByChangeSetIdOnlyRead(changeSetId)

		if not items or #items <= 0 then
			items = MaterialController.instance:___getTempItemsByChangeSetIdOnlyRead(changeSetId)
		end
	end

	local rewardChangeSetId = self._rewardChangeSetId

	if rewardChangeSetId then
		::label_4_0::

		local rewardItems = MaterialController.instance:___getItemsByChangeSetIdOnlyRead(rewardChangeSetId)
		local extraItems = self._extraItems

		return items and #items > 0 or rewardItems and #rewardItems > 0 or extraItems and #extraItems > 0
	end
end

function BattleSettlementModel:setFakeMatStrList(matStr)
	if matStr then
		local arr = string.split(matStr, "#")

		self._fakeMatList = self._fakeMatList or {}

		for i, matStr in ipairs(arr) do
			local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

			if matType == MatType.Item_Fake then
				table.insert(self._fakeMatList, matStr)
			end
		end
	end
end

function BattleSettlementModel:getFakeMatStrList()
	return self._fakeMatList
end

function BattleSettlementModel:clearFakeMatStrList()
	self._fakeMatList = nil
end

function BattleSettlementModel:setChangeSetId(changeSetId)
	self._changeSetId = changeSetId
end

function BattleSettlementModel:_getChangeSetId()
	local changeSetId = self._changeSetId

	self:clearChangeSetId()

	return changeSetId
end

function BattleSettlementModel:clearChangeSetId()
	self._changeSetId = nil
end

function BattleSettlementModel:setRewardChangeSetId(rewardChangeSetId, isDouble, multiple)
	self._rewardChangeSetId = rewardChangeSetId
	self._isDouble = isDouble and isDouble or false
	self._doubleNum = 100

	if self._isDouble and checknumber(multiple) > 0 then
		self._doubleNum = self._doubleNum * multiple
	end
end

function BattleSettlementModel:_getRewardChangeSetId()
	self._rewardChangeSetId = nil

	return self._rewardChangeSetId
end

function BattleSettlementModel:setExtraItems(items)
	self._extraItems = items
end

function BattleSettlementModel:_getExtraItems()
	local extraItems = self._extraItems

	self:clearExtraItems()

	return extraItems
end

function BattleSettlementModel:clearExtraItems()
	self._extraItems = nil
end

function BattleSettlementModel:setType(typeEnum, params)
	self._battleResultEnum = typeEnum
	self._params = params
end

function BattleSettlementModel:getType()
	return self._battleResultEnum
end

function BattleSettlementModel:getParams()
	return self._params
end

function BattleSettlementModel:setTxtTitle(txt)
	self._txtTitle = txt

	BattleModel.instance:setBattleName(self._txtTitle)
	printInfo("设置战斗名称", txt)
end

function BattleSettlementModel:getPerfectPassConditionPetNum(chapterId, stageId)
	local cfg = CopyConfig.instance:getStageById(chapterId, stageId)
	local splitsStr = string.split(cfg.perfectPassCondition, "$")

	return (checknumber(splitsStr[2]))
end

function BattleSettlementModel:getPlotCopyPerfectText(chapterId, stageId, isHidePerfect)
	local petNum = self:getPerfectPassConditionPetNum(chapterId, stageId)
	local perfectTxt = "完美通关："

	if isHidePerfect then
		perfectTxt = ""
	end

	if petNum == 0 then
		return perfectTxt .. "阵上精灵全部存活"
	else
		return string.format("%s我方阵亡精灵数量不超过%d只", perfectTxt, petNum)
	end
end

function BattleSettlementModel:isGiveBackTili(enumType)
	return enumType == self.Enum.PlotCopy or enumType == self.Enum.Legend or enumType == self.Enum.Scenariocopy
end

function BattleSettlementModel:isPerfectWin()
	if self:_isPlotCopyHaveChancePerfectPass() then
		return self:_isPlotCopyPerfectPass()
	else
		local conditionType = BattleModel.instance:getPerfectWinType()

		if not string.nilorempty(conditionType) then
			return (BattleModel.instance:isPerfectWin())
		end
	end
end

function BattleSettlementModel:_isPlotCopyHaveChancePerfectPass()
	local enumType = self:getType()

	return enumType == self.Enum.PlotCopy
end

function BattleSettlementModel:_isPlotCopyPerfectPass()
	local enumType = self:getType()

	return PlotCopyModel.instance:isPerfectPass(enumType)
end

function BattleSettlementModel:setBattleTopExtView(viewName)
	self._battleExtTopView = viewName
end

function BattleSettlementModel:getBattleTopExtView()
	return self._battleExtTopView
end

function BattleSettlementModel:getDescByWinOpId(winnerOpId)
	return
end

BattleSettlementModel.instance = BattleSettlementModel.New()

return BattleSettlementModel
