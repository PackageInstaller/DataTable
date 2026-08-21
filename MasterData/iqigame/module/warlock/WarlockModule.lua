-- chunkname: @IQIGame\\Module\\Warlock\\WarlockModule.lua

WarlockModule = {
	sortType = {
		EaseFavorLv = 3,
		Cost = 6,
		Easelv = 1,
		EaseQuality = 2,
		EaseElement = 4,
		EaseLifeUp = 5
	},
	EaseElement = {
		EaseFire = Constant.EaseElement.EaseFire,
		EaseWater = Constant.EaseElement.EaseWater,
		EaseWind = Constant.EaseElement.EaseWind,
		EaseMine = Constant.EaseElement.EaseMine,
		EaseIce = Constant.EaseElement.EaseIce
	},
	EaseProfession = {
		EaseConjuring = Constant.EaseProfession.EaseConjuring,
		EaseImplement = Constant.EaseProfession.EaseImplement,
		EaseSpeech = Constant.EaseProfession.EaseSpeech,
		EaseRune = Constant.EaseProfession.EaseRune,
		EaseCurtain = Constant.EaseProfession.EaseCurtain,
		EaseProvide = Constant.EaseProfession.EaseProvide
	},
	EaseInfluence = {
		EaseHidedoor = Constant.EaseInfluence.EaseInfluence_1,
		EaseLifeStudy = Constant.EaseInfluence.EaseInfluence_2,
		EaseYinyang = Constant.EaseInfluence.EaseInfluence_3
	},
	EaseInfluenceTable = {}
}

local this = WarlockModule

function WarlockModule.Initialize()
	WarlockModule.InitData()
	WarlockModule.AddEventListeners()
	WarlockModule.InitItemWarlockDataIdList()
	WarlockModule.InitInfluence()
end

function WarlockModule.InitData()
	WarlockModule.WarlockDataDic = {}
	WarlockModule.WarlockDataList = {}
	WarlockModule.curWarlockData = nil
	WarlockModule.isUpSort = true
	WarlockModule.PreloadAssetPath = {
		[1] = ""
	}
	WarlockModule.CurScreentable = {}
	WarlockModule.MyScreenWarlockList = {}
	WarlockModule.PersonalityDic = {}
	WarlockModule.CurPersonality = nil
	WarlockModule.ItemWarlockDataIdList = {}
	WarlockModule.RealCurPersonality = nil

	WarlockModule.__InitWarlockIDList()
end

function WarlockModule.__InitWarlockIDList()
	WarlockModule.__OpenHeroList = {}

	ForPairs(CfgHeroTable, function(_cid, _cfgData)
		if _cfgData.IsHide then
			return
		end

		table.insert(WarlockModule.__OpenHeroList, _cid)
	end)
end

function WarlockModule.Reload(WarlockPODList)
	WarlockModule.__InitLocalRecordNewHeroData()

	for i, v in pairs(WarlockPODList) do
		WarlockModule.CreateWarlockData(v)
	end
end

function WarlockModule.InitItemWarlockDataIdList()
	math.randomseed(tostring(os.time()):reverse():sub(1, 7))

	local StartIndex = math.random(100000000, 100000000000)

	table.insert(WarlockModule.ItemWarlockDataIdList, StartIndex)
end

function WarlockModule.GetRandomWarlockId()
	local Length = #WarlockModule.ItemWarlockDataIdList

	WarlockModule.ItemWarlockDataIdList[Length] = WarlockModule.ItemWarlockDataIdList[Length] + 1

	local newWarlockId = 0

	for i = 1, #WarlockModule.ItemWarlockDataIdList do
		newWarlockId = newWarlockId + WarlockModule.ItemWarlockDataIdList[i]
	end

	return newWarlockId
end

function WarlockModule.CreateWarlockData(HeroData)
	local WarlockData = WarlockData.New()

	WarlockData:Initialize(HeroData)

	WarlockModule.WarlockDataDic[HeroData.cid] = WarlockData
	WarlockModule.WarlockDataList[HeroData.cid] = HeroData.cid
end

function WarlockModule.GetSortedSoulDataList(sort_type, dataDic, Positive)
	local ret = {}

	for i, v in pairs(dataDic) do
		ret[#ret + 1] = v
	end

	local sortFunction = WarlockModule.DefaultSort

	if sort_type == WarlockModule.sortType.Easelv then
		sortFunction = WarlockModule.DefaultSort
	elseif sort_type == WarlockModule.sortType.EaseQuality then
		sortFunction = WarlockModule.QualitySort
	elseif sort_type == WarlockModule.sortType.EaseFavorLv then
		sortFunction = WarlockModule.FavorLvSort
	elseif sort_type == WarlockModule.sortType.EaseElement then
		sortFunction = WarlockModule.ElementLvSort
	elseif sort_type == WarlockModule.sortType.EaseLifeUp then
		sortFunction = WarlockModule.LifeUpSort
	elseif sort_type == WarlockModule.sortType.Cost then
		sortFunction = WarlockModule.CostSort
	end

	table.sort(ret, sortFunction)

	if WarlockModule.isUpSort == false or Positive == false then
		local _retTable = {}
		local retLength = #ret

		for i, v in ipairs(ret) do
			local index = i - 1

			_retTable[i] = ret[retLength - index]
		end

		return _retTable
	else
		return ret
	end
end

function WarlockModule.DefaultSort(tb1, tb2)
	return WarlockModule.LvSort(tb1, tb2)
end

function WarlockModule.SortItem(tb1, tb2)
	if tb1.BaseData.Profession > tb2.BaseData.Profession then
		return true
	elseif tb1.BaseData.Profession == tb2.BaseData.Profession then
		if tb1.BaseData.Elements > tb2.BaseData.Elements then
			return true
		elseif tb1.BaseData.Elements == tb2.BaseData.Elements and tb1.BaseData.Id > tb2.BaseData.Id then
			return true
		end
	end

	return false
end

function WarlockModule.LvSort(tb1, tb2)
	if tb1.lv > tb2.lv then
		return true
	elseif tb1.lv == tb2.lv then
		if tb1.BaseData.Quality > tb2.BaseData.Quality then
			return true
		elseif tb1.BaseData.Quality == tb2.BaseData.Quality then
			if tb1.breakLv > tb2.breakLv then
				return true
			elseif tb1.breakLv == tb2.breakLv then
				return WarlockModule.SortItem(tb1, tb2)
			end

			return tb1.BaseData.Id < tb1.BaseData.Id
		end

		return tb1.breakLv > tb2.breakLv
	else
		return false
	end
end

function WarlockModule.QualitySort(tb1, tb2)
	if tb1.BaseData.Quality > tb2.BaseData.Quality then
		return true
	elseif tb1.BaseData.Quality == tb2.BaseData.Quality then
		if tb1.lv > tb2.lv then
			return true
		elseif tb1.lv == tb2.lv then
			if tb1.breakLv > tb2.breakLv then
				return true
			elseif tb1.breakLv == tb2.breakLv then
				return WarlockModule.SortItem(tb1, tb2)
			end

			return tb1.BaseData.Id < tb1.BaseData.Id
		end

		return false
	else
		return false
	end
end

function WarlockModule.FavorLvSort(tb1, tb2)
	if tb1.favorLv > tb2.favorLv then
		return true
	elseif tb1.favorLv == tb2.favorLv then
		return WarlockModule.LvSort(tb1, tb2)
	else
		return false
	end
end

function WarlockModule.ElementLvSort(tb1, tb2)
	if tb1.elementMaster > tb2.elementMaster then
		return true
	elseif tb1.elementMaster == tb2.elementMaster then
		return WarlockModule.LvSort(tb1, tb2)
	else
		return false
	end
end

function WarlockModule.LifeUpSort(tb1, tb2)
	if tb1.lifeCount > tb2.lifeCount then
		return true
	elseif tb1.lifeCount == tb2.lifeCount then
		return WarlockModule.LvSort(tb1, tb2)
	else
		return false
	end
end

function WarlockModule.CostSort(tb1, tb2)
	if tb1.BaseData.Cost > tb2.BaseData.Cost then
		return true
	elseif tb1.BaseData.Cost == tb2.BaseData.Cost then
		return WarlockModule.LvSort(tb1, tb2)
	else
		return false
	end
end

function WarlockModule.ResetScreen()
	WarlockModule.CurScreentable = {}
end

function WarlockModule.ToggleScreenhero(v, curElement, curProfession, curInfluence)
	local add

	if curElement == nil then
		add = true
	elseif v.BaseData.Elements == curElement then
		add = true
	else
		add = false

		return add
	end

	if curProfession ~= nil then
		if v.BaseData.Profession == curProfession then
			add = true
		else
			add = false

			return add
		end
	end

	if curInfluence ~= nil then
		if v.BaseData.Forces == curInfluence then
			add = true
		else
			add = false

			return add
		end
	end

	return add
end

function WarlockModule.SetPreloadAssetPath(index, Path)
	WarlockModule.PreloadAssetPath[index] = Path
end

function WarlockModule.GetCurPersonalityIndex(warlockData)
	local data

	if warlockData ~= nil then
		data = warlockData
	else
		data = WarlockModule.curWarlockData
	end

	if data == nil then
		return nil, 0
	end

	local index = 1

	for i = 1, #data.PersonalityDataList do
		local itemdata = data.PersonalityDataList[i]

		if itemdata.isOpen then
			index = i
		end
	end

	return data.PersonalityDataList, index
end

function WarlockModule.GetPersonalityIndex()
	WarlockModule.CurPersonality = WarlockModule.curWarlockData.PersonalityDataList[1]
	WarlockModule.RealCurPersonality = nil

	for i = 1, #WarlockModule.curWarlockData.PersonalityDataList do
		local itemdata = WarlockModule.curWarlockData.PersonalityDataList[i]

		if itemdata.isOpen then
			WarlockModule.RealCurPersonality = itemdata

			if i == #WarlockModule.curWarlockData.PersonalityDataList then
				WarlockModule.CurPersonality = itemdata
			else
				WarlockModule.CurPersonality = WarlockModule.curWarlockData.PersonalityDataList[i + 1]
			end
		end
	end

	return WarlockModule.CurPersonality
end

function WarlockModule.CreatRoleDetailsData(cid)
	local config = CfgHeroTable[cid]
	local AttriListData = {}
	local SkillData = {}
	local HeroPod = {}
	local AttribuateArr = UIUtil.GetConfigArrToNumber(config.Attribute, 3)

	for i = 1, #AttribuateArr do
		local ItemArr = AttribuateArr[i]
		local v = ItemArr[1]

		AttriListData[v] = ItemArr[2]
	end

	AttriListData[6] = 0

	for i = 1, 3 do
		local ItemSkillData = {}

		ItemSkillData.id = i
		ItemSkillData.itemCid = UIUtil.GetConfigArr(config.Skill)[i][2]
		ItemSkillData.skillCid = CfgItemTable[ItemSkillData.itemCid].LikeId
		ItemSkillData.exp = 0
		ItemSkillData.heroCid = cid
		ItemSkillData.heroPos = i
		ItemSkillData.lv = 1
		ItemSkillData.strengLv = 0

		table.insert(SkillData, ItemSkillData)
	end

	HeroPod.attr = AttriListData
	HeroPod.skill = SkillData
	HeroPod.cid = cid
	HeroPod.exp = 0
	HeroPod.lv = 1
	HeroPod.baseAttr = {}

	local WarlockData = WarlockData.New()

	WarlockData:Initialize(HeroPod, true)

	return WarlockData
end

function WarlockModule.Shutdown()
	WarlockModule.RemoveEventListeners()
end

function WarlockModule.AddEventListeners()
	EventDispatcher.AddEventListener(EventID.RoleUpdateData, WarlockModule.UpdateRoleData)
end

function WarlockModule.RemoveEventListeners()
	EventDispatcher.RemoveEventListener(EventID.RoleUpdateData, WarlockModule.UpdateRoleData)
end

function WarlockModule.UpdateRoleData(heros)
	for i, v in pairs(heros) do
		if WarlockModule.WarlockDataDic[v.cid] ~= nil then
			WarlockModule.WarlockDataDic[v.cid]:Initialize(v)
		else
			WarlockModule.CreateWarlockData(v)
		end

		PlayerModule.PlayerInfo.heros[i] = v
	end

	EventDispatcher.Dispatch(EventID.RoleAttrChange)
end

function WarlockModule.InitInfluence()
	local InitInfluenceConfig = CfgDiscreteDataTable[41].Data

	WarlockModule.EaseInfluenceTable = {}

	local ArrData = UIUtil.GetConfigArr(InitInfluenceConfig)

	for i = 1, #ArrData do
		local config = ArrData[i]

		WarlockModule.EaseInfluenceTable[i] = {}
		WarlockModule.EaseInfluenceTable[i].TypeId = config[1]
		WarlockModule.EaseInfluenceTable[i].DesId = config[2]
	end
end

function WarlockModule.GetAllUnLockPersonalityDataWithHeroID(heroData)
	return heroData:GetAllUnLockData()
end

function WarlockModule.GetHeroData(heroCid)
	for _, v in pairs(this.WarlockDataDic) do
		if v.cid == heroCid then
			return v
		end
	end
end

function WarlockModule.GetWarlockList()
	local result = {}

	for _, v in pairs(this.WarlockDataDic) do
		table.insert(result, v)
	end

	return result
end

function WarlockModule.GetWarlockListByScreenData(screenData)
	local heros = {}

	ForPairs(this.WarlockDataDic, function(k, _heroData)
		if screenData ~= nil and not CommonScreenModule.ScreenCheck(_heroData, screenData) then
			return
		end

		table.insert(heros, _heroData)
	end)

	return heros
end

function WarlockModule.FilterHeroCid(sourceDic, heroCidList)
	local tempHeroDic = Clone(sourceDic)

	for _, v in pairs(heroCidList) do
		if tempHeroDic[v] ~= nil then
			tempHeroDic[v] = nil
		end
	end

	return tempHeroDic
end

function WarlockModule.UnlockPersonality(heroCid, personalityId)
	net_hero.unlockPersonality(heroCid, personalityId)
end

function WarlockModule.UnlockPersonalitySucceed(personalityId)
	UIModule.Open(Constant.UIControllerName.PersonalityTipsUI, Constant.UILayer.UI, {
		personalityId = personalityId
	})
	EventDispatcher.Dispatch(EventID.UnlockPersonalityRefresh)
end

function WarlockModule.GetHeroMaxEnergyByHeroPOD(heroData)
	local maxEnergy = 0

	ForPairs(heroData.skill, function(_pos, _skillPOD)
		local skillConfig = CfgSkillTable[_skillPOD.skillCid]

		if skillConfig.SkillType ~= Constant.SkillType.TYPE_ULTIMATE then
			return
		end

		local skillDetailData = CfgSkillDetailTable[skillConfig.SkillDetail]

		maxEnergy = skillDetailData.NeedAp

		return true
	end)

	return maxEnergy
end

function WarlockModule.GetHeroHPValueByHeroPOD(heroData)
	return heroData.attr[1]
end

function WarlockModule.GetHeroEnergyValueByHeroPOD(heroData)
	return heroData.attr[7]
end

function WarlockModule.CheckHeroIsDieByHeroPOD(heroData)
	local hp = WarlockModule.GetHeroHPValueByHeroPOD(heroData)

	return hp <= 0
end

function WarlockModule.SortRoleListByType(roleList, sortType, isUp)
	if isUp == nil then
		isUp = true
	end

	if sortType == Constant.WarlockSortType.Level then
		return WarlockModule.CommonSortByLevel(roleList, isUp)
	elseif sortType == Constant.WarlockSortType.Quality then
		return WarlockModule.CommonSortByQuality(roleList, isUp)
	elseif sortType == Constant.WarlockSortType.Favor then
		return WarlockModule.CommonSortByFavor(roleList, isUp)
	elseif sortType == Constant.WarlockSortType.Element then
		return WarlockModule.CommonSortByElement(roleList, isUp)
	else
		return WarlockModule.CommonSortByQuality(roleList, isUp)
	end
end

function WarlockModule.CommonSortByLevel(roleList, isUp)
	table.sort(roleList, function(_source, _target)
		local success, result = _source:CompareWithLevel(_target, isUp)

		if success then
			return result
		end

		success, result = _source:CompareWithQuality(_target, isUp)

		if success then
			return result
		end

		success, result = _source:CompareWithCid(_target, isUp)

		if success then
			return result
		end

		return false
	end)

	return roleList
end

function WarlockModule.CommonSortByQuality(roleList, isUp)
	table.sort(roleList, function(_source, _target)
		local success, result = _source:CompareWithQuality(_target, isUp)

		if success then
			return result
		end

		success, result = _source:CompareWithLevel(_target, isUp)

		if success then
			return result
		end

		success, result = _source:CompareWithCid(_target, isUp)

		if success then
			return result
		end

		return false
	end)

	return roleList
end

function WarlockModule.CommonSortByFavor(roleList, isUp)
	table.sort(roleList, function(_source, _target)
		local success, result = _source:CompWithFavorLv(_target, isUp)

		if success then
			return result
		end

		success, result = _source:CompareWithLevel(_target, isUp)

		if success then
			return result
		end

		local success, result = _source:CompareWithQuality(_target, isUp)

		if success then
			return result
		end

		success, result = _source:CompareWithCid(_target, isUp)

		if success then
			return result
		end

		return false
	end)

	return roleList
end

function WarlockModule.CommonSortByElement(roleList, isUp)
	table.sort(roleList, function(_source, _target)
		local success, result = _source:CompWithElement(_target, isUp)

		if success then
			return result
		end

		success, result = _source:CompareWithLevel(_target, isUp)

		if success then
			return result
		end

		local success, result = _source:CompareWithQuality(_target, isUp)

		if success then
			return result
		end

		success, result = _source:CompareWithCid(_target, isUp)

		if success then
			return result
		end

		return false
	end)

	return roleList
end

function WarlockModule.__InitLocalRecordNewHeroData()
	WarlockModule.heroNewTagRecordData = {}

	local recordStr = SettingModule.GetHeroNewTagRecordData()

	if LuaUtility.StrIsNullOrEmpty(recordStr) then
		return
	end

	local cidList = string.split(recordStr, "|")

	ForArray(cidList, function(_, _cidStr)
		local cid = tonumber(_cidStr)

		WarlockModule.heroNewTagRecordData[cid] = true
	end)
end

function WarlockModule.UpdateLocalRecordNewHeroData(heroCid)
	if WarlockModule.heroNewTagRecordData[heroCid] then
		return
	end

	WarlockModule.heroNewTagRecordData[heroCid] = true

	local recordStr = ""

	ForPairs(WarlockModule.heroNewTagRecordData, function(_cid, _)
		if LuaUtility.StrIsNullOrEmpty(recordStr) then
			recordStr = tostring(_cid)
		else
			recordStr = recordStr .. "|" .. tostring(_cid)
		end
	end)
	SettingModule.SaveHeroNewTagRecordData(recordStr)
	RedDotModule.CheckRedDot_Warlock()
	EventDispatcher.Dispatch(EventID.roleRedDotEvent)
end

function WarlockModule.NeedShowNewHeroTag(heroCid)
	if WarlockModule.heroNewTagRecordData[heroCid] then
		return false
	end

	return true
end

function WarlockModule.NotifyHeroFavor(heroCid, groupId, entryId)
	local warlockData = WarlockModule.WarlockDataDic[heroCid]

	if not warlockData then
		logError("【好感】属性角色好感数据失败，没有角色数据 id = %s", heroCid)

		return
	end

	warlockData:RefreshFavorData(groupId, entryId)
end

function WarlockModule.GetHeroFavorArray()
	local data = {}

	for _, v in pairs(WarlockModule.WarlockDataDic) do
		table.insert(data, v)
	end

	return data
end

function WarlockModule.GetHeroTotalCount()
	return table.len(WarlockModule.WarlockDataDic)
end

function WarlockModule.ForArrayOpenHeroList(func)
	ForArray(WarlockModule.__OpenHeroList, function(_, _heroCid)
		func(_heroCid)
	end)
end

function WarlockModule.GetOpenHeroList()
	return Clone(WarlockModule.__OpenHeroList)
end

function WarlockModule.GetLockedHeroCombinationData(heroCid)
	if heroCid == 0 then
		return 0, 0, 0
	end

	local heroCfg = CfgHeroTable[heroCid]
	local cfg = CfgCombinationTable[heroCfg.LinkItem]
	local needItemCid = GetArrayValue(cfg.Combination, 1, -1)
	local needItemNum = GetArrayValue(cfg.Combination, 2, -1)

	if needItemCid < 0 or needItemNum < 0 then
		return heroCfg.LinkItem, 0, 0
	end

	local ownerCnt = WarehouseModule.GetItemNumByCfgID(needItemCid)

	return heroCfg.LinkItem, needItemNum, ownerCnt
end
