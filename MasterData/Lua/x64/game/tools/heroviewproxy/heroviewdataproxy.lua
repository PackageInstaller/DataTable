local HeroViewDataProxy = class("HeroViewDataProxy")
local var_0_1 = {}

for iter_0_0, iter_0_1 in pairs((require("game/tools/HeroViewProxy/ProxyFuction/ProPertyProxyFunc"))) do
	var_0_1[iter_0_0] = iter_0_1
end

for iter_0_2, iter_0_3 in pairs((require("game/tools/HeroViewProxy/ProxyFuction/SkillProxyFunc"))) do
	var_0_1[iter_0_2] = iter_0_3
end

for iter_0_4, iter_0_5 in pairs((require("game/tools/HeroViewProxy/ProxyFuction/WeaponProxyFunc"))) do
	var_0_1[iter_0_4] = iter_0_5
end

for iter_0_6, iter_0_7 in pairs((require("game/tools/HeroViewProxy/ProxyFuction/ServantProxyFuc"))) do
	var_0_1[iter_0_6] = iter_0_7
end

for iter_0_8, iter_0_9 in pairs((require("game/tools/HeroViewProxy/ProxyFuction/EquiptProxyFunc"))) do
	var_0_1[iter_0_8] = iter_0_9
end

for iter_0_10, iter_0_11 in pairs((require("game/tools/HeroViewProxy/ProxyFuction/AstrolabeProxyFunc"))) do
	var_0_1[iter_0_10] = iter_0_11
end

for iter_0_12, iter_0_13 in pairs((require("game/tools/HeroViewProxy/ProxyFuction/TransitionProxyFunc"))) do
	var_0_1[iter_0_12] = iter_0_13
end

setmetatable(HeroViewDataProxy, {
	__index = var_0_1
})

function HeroViewDataProxy:Ctor(arg_1_1)
	self:SetViewDataType(arg_1_1)
end

function HeroViewDataProxy:GetDataClassInstanceByType(arg_2_1)
	if arg_2_1 == HeroConst.HERO_DATA_TYPE.FOREIGN then
		return ForeignInfoData
	elseif arg_2_1 == HeroConst.HERO_DATA_TYPE.TRIAL or arg_2_1 == HeroConst.HERO_DATA_TYPE.CUSTOM then
		return TempHeroData
	elseif arg_2_1 == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
		return PolyhedronData
	elseif arg_2_1 == HeroConst.HERO_DATA_TYPE.ADVANCETEST then
		return AdvanceTestData
	elseif arg_2_1 == HeroConst.HERO_DATA_TYPE.COOPERATION then
		return CooperationData
	elseif arg_2_1 == HeroConst.HERO_DATA_TYPE.SWIMSUITBATTLE then
		return SwimsuitBattleHeroData
	elseif arg_2_1 == HeroConst.HERO_DATA_TYPE.STRATEGYMATRIX then
		return StrategyMatrixData
	elseif arg_2_1 == HeroConst.HERO_DATA_TYPE.CHALLENGEROUGETEAM then
		return ChallengeRogueTeamData.dataList_[2]
	elseif arg_2_1 == HeroConst.HERO_DATA_TYPE.OSIRISPLAYGAME then
		return OsirisPlayGameTempHeroData
	elseif arg_2_1 == HeroConst.HERO_DATA_TYPE.HODURGAME then
		return HodurGameTempHeroData
	else
		return HeroData
	end
end

function HeroViewDataProxy:GetHeroList()
	return self.dataClass:GetHeroList(self.tempHeroList)
end

function HeroViewDataProxy:GetHeroData(arg_4_1)
	local var_4_0 = self.dataClass:GetHeroData(arg_4_1, self.tempHeroList)

	if self.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
		local var_4_1 = deepClone(var_4_0)

		var_4_1.star = HeroCfg[var_4_1.id].unlock_star

		return var_4_1
	end

	return var_4_0
end

function HeroViewDataProxy:GetHeroIDList()
	return self.dataClass:GetHeroIDList(self.tempHeroList)
end

function HeroViewDataProxy:GetEquipInfoList(arg_6_1)
	return self.dataClass:GetEquipInfoList(arg_6_1, self.tempHeroList)
end

function HeroViewDataProxy:GetEquipDataList(arg_7_1, arg_7_2)
	local var_7_0 = {}

	if not table.isEmpty(arg_7_2) then
		for iter_7_0, iter_7_1 in ipairs(arg_7_2) do
			table.insert(var_7_0, EquipData:GetEquipData(iter_7_1.equip_id))
		end
	else
		var_7_0 = self.dataClass:GetEquipDataList(arg_7_1, self.tempHeroList)
	end

	return var_7_0
end

function HeroViewDataProxy:GetHeroServantInfo(arg_8_1)
	return self.dataClass:GetHeroServantInfo(arg_8_1, self.tempHeroList)
end

function HeroViewDataProxy:GetHeroSkillInfoList(arg_9_1)
	return self.dataClass:GetHeroSkillInfoList(arg_9_1, self.tempHeroList)
end

function HeroViewDataProxy:GetHeroTransitionInfoList(arg_10_1)
	return self.dataClass:GetHeroTransitionInfoList(arg_10_1, self.tempHeroList)
end

function HeroViewDataProxy:GetHeroUsingSkinInfo(arg_11_1)
	return self.dataClass:GetHeroUsingSkinInfo(arg_11_1, self.tempHeroList)
end

function HeroViewDataProxy:GetHeroBattleUsingSkinInfo(arg_12_1)
	return self.dataClass:GetHeroBattleUsingSkinInfo(arg_12_1, self.tempHeroList)
end

function HeroViewDataProxy:GetHeroName(arg_13_1)
	return self.dataClass:GetHeroName(arg_13_1, self.tempHeroList)
end

function HeroViewDataProxy:HasCustomNickName(arg_14_1)
	return self.dataClass:HasCustomNickName(arg_14_1, self.tempHeroList)
end

function HeroViewDataProxy:IsHeroOath(arg_15_1)
	return self.dataClass:IsHeroOath(arg_15_1, self.tempHeroList)
end

function HeroViewDataProxy:GetExFilterSorterFunc()
	return (self.dataClass:GetExFilterSorterFunc())
end

function HeroViewDataProxy:GetUIClassByType(arg_17_1)
	return _G[ViewHeroConst.CLASS[arg_17_1][self.viewDataType] or ViewHeroConst.CLASS[arg_17_1][HeroConst.HERO_DATA_TYPE.DEFAULT]]
end

function HeroViewDataProxy:GetUIPrefabByType(arg_18_1)
	return ViewHeroConst.PREFAB[arg_18_1][self.viewDataType] or ViewHeroConst.PREFAB[arg_18_1][HeroConst.HERO_DATA_TYPE.DEFAULT]
end

function HeroViewDataProxy:GetViewDataType()
	return self.viewDataType or HeroConst.HERO_DATA_TYPE.DEFAULT
end

function HeroViewDataProxy:SetViewDataType(arg_20_1)
	self.viewDataType = arg_20_1 or HeroConst.HERO_DATA_TYPE.DEFAULT
	self.dataClass = self:GetDataClassInstanceByType(self.viewDataType)

	self:SetViewPropertyByType(self.viewDataType)
end

function HeroViewDataProxy:SetViewPropertyByType(arg_21_1)
	self.unlockToggle = false
	self.showRedPoint = false
	self.showHeroHeadRedPoint = false
	self.showCurrencyWindowBar = false
	self.showInfoWindowBar = false
	self.disableSort = false
	self.showDetailBtn = false
	self.showfavorBtn = false
	self.hideChipToggle = false
	self.hideTransitionToggle = false
	self.hideModule = false
	self.hideCultureGrvureBtn = false
	self.hideServant = false
	self.hideFilterBtn = false
	self.isSelf = false
	self.isTemp = false
	self.notGotoAstrolabeAdjust = true
	self.isHideAstrolabeReset = false

	if arg_21_1 == HeroConst.HERO_DATA_TYPE.FOREIGN then
		self.unlockToggle = true
		self.hideCultureGrvureBtn = true
		self.hideFilterBtn = true
		self.notGotoAstrolabeAdjust = false
		self.isHideAstrolabeReset = true
	elseif arg_21_1 == HeroConst.HERO_DATA_TYPE.TRIAL then
		self.unlockToggle = true
		self.disableSort = true
		self.showDetailBtn = true
		self.hideChipToggle = true
		self.hideCultureGrvureBtn = true
		self.notGotoAstrolabeAdjust = false
		self.isTemp = true
	elseif arg_21_1 == HeroConst.HERO_DATA_TYPE.CUSTOM then
		self.unlockToggle = true
		self.disableSort = true
		self.showDetailBtn = true
		self.hideCultureGrvureBtn = true
		self.isTemp = true
	elseif arg_21_1 == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
		self.showHeroHeadRedPoint = true
		self.unlockToggle = true
		self.showDetailBtn = true
		self.hideCultureGrvureBtn = true
		self.hideChipToggle = true
		self.hideTransitionToggle = true
		self.hideModule = true
		self.isTemp = true
		self.showRedPoint = false
	elseif arg_21_1 == HeroConst.HERO_DATA_TYPE.ADVANCETEST then
		self.unlockToggle = true
		self.showDetailBtn = true
		self.hideCultureGrvureBtn = true
		self.isHideAstrolabeReset = true
	elseif arg_21_1 == HeroConst.HERO_DATA_TYPE.COOPERATION then
		self.unlockToggle = true
	elseif arg_21_1 == HeroConst.HERO_DATA_TYPE.PREVIEW then
		self.hideServant = true
		self.isHideAstrolabeReset = true
	elseif arg_21_1 == HeroConst.HERO_DATA_TYPE.DEFAULT then
		self.showRedPoint = true
		self.showHeroHeadRedPoint = true
		self.showCurrencyWindowBar = false
		self.showInfoWindowBar = true
		self.showDetailBtn = true
		self.showfavorBtn = true
		self.isSelf = true
	elseif arg_21_1 == HeroConst.HERO_DATA_TYPE.STRATEGYMATRIX then
		self.showHeroHeadRedPoint = true
		self.unlockToggle = true
		self.showDetailBtn = true
		self.hideCultureGrvureBtn = true
		self.hideChipToggle = true
		self.hideTransitionToggle = true
		self.hideModule = true
		self.isTemp = true
		self.showRedPoint = false
		self.notGotoAstrolabeAdjust = false
	elseif arg_21_1 == HeroConst.HERO_DATA_TYPE.CHALLENGEROUGETEAM then
		self.unlockToggle = true
		self.hideCultureGrvureBtn = true
		self.showHeroHeadRedPoint = true
		self.isTemp = true
		self.hideCultureGrvureBtn = true
		self.notGotoAstrolabeAdjust = false
	elseif arg_21_1 == HeroConst.HERO_DATA_TYPE.OSIRISPLAYGAME then
		self.unlockToggle = true
		self.hideCultureGrvureBtn = true
		self.showHeroHeadRedPoint = true
		self.notGotoAstrolabeAdjust = false
		self.hideChipToggle = true
		self.hideModule = true
	elseif arg_21_1 == HeroConst.HERO_DATA_TYPE.HODURGAME then
		self.unlockToggle = true
		self.hideCultureGrvureBtn = true
		self.showHeroHeadRedPoint = true
		self.notGotoAstrolabeAdjust = false
		self.hideChipToggle = true
		self.hideModule = true
	end
end

function HeroViewDataProxy:SetTempHeroList(arg_22_1)
	self.tempHeroList = arg_22_1
end

return HeroViewDataProxy
