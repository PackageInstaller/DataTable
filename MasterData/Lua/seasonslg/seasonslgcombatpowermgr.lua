require("SeasonSLG/SeasonSLGConst")
require("SeasonSLG/SeasonSLGMapMgr")
require("SeasonSLG/SeasonSLGTechMgr")
require("Manager/Config/ConfigCharacterMgr")
require("ViewModel/TeamWeapon/TeamWeaponMgr")








SeasonSLGCombatPowerMgr = {}

local this = {
    coeffMap = nil,
    originMap = nil,
    characterPowerMap = {},
    techPower = 0,
    coResearchPower = 0,
    fieldPower = 0,
}




local function BuildConfigIndex()
    this.coeffMap = {}
    this.originMap = {}
    local combatPowerMap = ConfigMgr.Config.SeasonalCombatPowerMap
    if combatPowerMap == nil then
        return
    end
    for id, cfg in pairs(combatPowerMap) do
        if cfg ~= nil then
            local combatType = cfg.CombatType
            local originId = cfg.OriginId
            local power = cfg.CombatPower or 0
            if originId == nil or originId == "" then

                this.coeffMap[combatType] = power
            else

                if this.originMap[combatType] == nil then
                    this.originMap[combatType] = {}
                end
                this.originMap[combatType][tostring(originId)] = power
            end
        end
    end
end


local function GetCoefficient(combatType)
    if this.coeffMap == nil then
        return 0
    end
    return this.coeffMap[combatType] or 0
end


local function GetOriginPower(combatType, originId)
    if this.originMap == nil then
        return 0
    end
    local map = this.originMap[combatType]
    if map == nil then
        return 0
    end
    return map[tostring(originId)] or 0
end




local function CalcCharacterLevelPower(character)
    local level = character and character.level or 0
    return level * GetCoefficient(1)
end


local function CalcTalentPower(character)
    local power = 0
    local talents = character and character.talents
    if talents == nil then
        return 0
    end
    for talentId, talentData in pairs(talents) do
        if talentData ~= nil and talentData.status == 2 then
            local talentCfg = ConfigMgr.Config.characterTalentMap[talentId]
            if talentCfg ~= nil then
                power = power + GetOriginPower(2, talentCfg.index)
            end
        end
    end
    return power
end


local function CalcStarPower(character)
    local star = character and character.star or 0
    return GetOriginPower(3, star)
end


local function CalcRarePower(characterId)
    local characterConfig = ConfigCharacterMgr.GetInfo(characterId)
    local rare = characterConfig and characterConfig.rare or 0
    return GetOriginPower(4, rare)
end


local function CalcEquipLevelPower(equipData)
    local level = equipData and equipData.level or 0
    return level * GetCoefficient(5)
end


local function CalcEquipStarPower(equipData)
    local star = equipData and equipData.star or 0
    return GetOriginPower(6, star)
end


local function CalcEquipRarePower(equipData)
    if equipData == nil then
        return 0
    end
    local equipConfig = ConfigMgr.Config.equipments[equipData.equipmentId]
    local rare = equipConfig and equipConfig.rare or 0
    return GetOriginPower(7, rare)
end


local function CalcSeasonLevelPower(characterId)
    local seasonHero = ConfigCharacterMgr.GetSeasonalHeroConfig(characterId)
    if seasonHero == nil then
        return 0
    end
    local seasonCharacters = DataMgr.Player.SeasonalCharacters
    local seasonCharacter = seasonCharacters and seasonCharacters[seasonHero.Id]
    local seasonLevel = seasonCharacter and seasonCharacter.Level or 0
    return seasonLevel * GetCoefficient(10)
end


local function GetWearEquipData(character)
    if character == nil or IsNullOrEmpty(character.wear) then
        return nil
    end
    local equipments = DataMgr.Player.equipments
    if equipments == nil then
        return nil
    end
    return equipments[character.wear]
end


local function CalcCharacterPower(characterId)
    local characters = DataMgr.Player.characters
    local character = characters and characters[characterId]
    if character == nil then
        return 0
    end
    local equipData = GetWearEquipData(character)
    local power = 0
    power = power + CalcCharacterLevelPower(character)
    power = power + CalcTalentPower(character)
    power = power + CalcStarPower(character)
    power = power + CalcRarePower(characterId)
    power = power + CalcEquipLevelPower(equipData)
    power = power + CalcEquipStarPower(equipData)
    power = power + CalcEquipRarePower(equipData)
    power = power + CalcSeasonLevelPower(characterId)
    return power
end


local function CalcTechPower()
    local power = 0
    local curSeasonal = SeasonSLGMapMgr.GetCurSeasonCfgData()
    if curSeasonal == nil then
        return 0
    end
    SeasonSLGTechMgr.InitData()
    local techDatas = SeasonSLGTechMgr.GetTechDatasBySeasonID(curSeasonal.Id)
    if techDatas == nil then
        return 0
    end
    for i, techData in pairs(techDatas) do
        if techData ~= nil and techData.Status == SeasonSLGConst.TechStatus.Activate then
            power = power + GetOriginPower(11, techData.ID)
        end
    end
    return power
end


local function CalcCoResearchPower()
    local count = 0
    local bestiarySupplyMap = ConfigMgr.Config.BestiarySupplyMap
    if bestiarySupplyMap == nil then
        return 0
    end
    local characters = DataMgr.Player.characters
    local jobExtraAttr = DataMgr.Player.jobExtraAttr
    for key, value in pairs(bestiarySupplyMap) do
        if value ~= nil and value.Switch == 1 then
            local character = characters and characters[key]
            if character ~= nil then

                local activated = false
                if jobExtraAttr ~= nil then

                    if jobExtraAttr[key .. "_level_" .. value.Level] ~= nil then
                        activated = true
                    end

                    if not activated then
                        for star = 1, 6 do
                            if jobExtraAttr[key .. "_star_" .. star] ~= nil then
                                activated = true
                                break
                            end
                        end
                    end

                    if not activated and jobExtraAttr[key .. "_brilliant_1"] ~= nil then
                        activated = true
                    end
                end
                if activated then
                    count = count + 1
                end
            end
        end
    end
    return count * GetCoefficient(8)
end


local function CalcFieldPower()
    local totalLevel = TeamWeaponMgr.GetWeaponTotalLevel()
    return totalLevel * GetCoefficient(9)
end


local function GetAllSeasonalHeroIds()
    local heroIds = {}
    local characterTable = ConfigMgr.Config.characterTable
    if characterTable == nil then
        return heroIds
    end
    for i, characterConfig in pairs(characterTable) do
        if characterConfig ~= nil and characterConfig.id ~= nil and ConfigCharacterMgr.GetSeasonalHeroConfig(characterConfig.id) ~= nil then
            table.insert(heroIds, characterConfig.id)
        end
    end
    return heroIds
end




SeasonSLGCombatPowerMgr.Init = function()
    if SeasonSLGMapMgr.CheckExistValidConfig() == false then
        return
    end
    if SeasonSLGCombatPowerMgr.isInit then
        return
    end

    if ConfigMgr.Config.SeasonalCombatPowerMap == nil then
        return
    end

    local curSeasonal = SeasonSLGMapMgr.GetCurSeasonCfgData()
    if curSeasonal == nil then
        return
    end

    BuildConfigIndex()

    LuaMgr.RemoveDataEventListener(SeasonSLGCombatPowerMgr.OnDataChange)
    LuaMgr.AddDataEventListener(SeasonSLGCombatPowerMgr.OnDataChange)

    SeasonSLGCombatPowerMgr.RebuildAll()
    SeasonSLGCombatPowerMgr.isInit = true
end


SeasonSLGCombatPowerMgr.Clear = function()
    SeasonSLGCombatPowerMgr.isInit = false
    LuaMgr.RemoveDataEventListener(SeasonSLGCombatPowerMgr.OnDataChange)
    this.characterPowerMap = {}
    this.techPower = 0
    this.coResearchPower = 0
    this.fieldPower = 0
    this.coeffMap = nil
    this.originMap = nil
end


SeasonSLGCombatPowerMgr.RebuildAll = function()
    SeasonSLGCombatPowerMgr.RefreshAllCharacterPower()
    SeasonSLGCombatPowerMgr.RefreshTechPower()
    SeasonSLGCombatPowerMgr.RefreshCoResearchPower()
    SeasonSLGCombatPowerMgr.RefreshFieldPower()
end


SeasonSLGCombatPowerMgr.RefreshAllCharacterPower = function()
    this.characterPowerMap = {}
    local heroIds = GetAllSeasonalHeroIds()
    for i, characterId in ipairs(heroIds) do
        this.characterPowerMap[characterId] = CalcCharacterPower(characterId)
    end
end


SeasonSLGCombatPowerMgr.RefreshTechPower = function()
    this.techPower = CalcTechPower()
end


SeasonSLGCombatPowerMgr.RefreshCoResearchPower = function()
    this.coResearchPower = CalcCoResearchPower()
end


SeasonSLGCombatPowerMgr.RefreshFieldPower = function()
    this.fieldPower = CalcFieldPower()
end


SeasonSLGCombatPowerMgr.OnDataChange = function(param)
    local key = tostring(param[0])
    if key == "characters" then

        SeasonSLGCombatPowerMgr.RefreshAllCharacterPower()
        SeasonSLGCombatPowerMgr.RefreshCoResearchPower()
    elseif key == "SeasonalCharacters" then

        SeasonSLGCombatPowerMgr.RefreshAllCharacterPower()
    elseif key == "equipments" then

        SeasonSLGCombatPowerMgr.RefreshAllCharacterPower()
    elseif key == "SeasonalTech" then

        SeasonSLGCombatPowerMgr.RefreshTechPower()
    elseif key == "jobExtraAttr" then

        SeasonSLGCombatPowerMgr.RefreshCoResearchPower()
    elseif key == "TeamWeapons" then

        SeasonSLGCombatPowerMgr.RefreshFieldPower()
    end
end


SeasonSLGCombatPowerMgr.GetCharacterPower = function(characterId)
    return this.characterPowerMap[characterId] or 0
end


SeasonSLGCombatPowerMgr.GetTechPower = function()
    return this.techPower or 0
end


SeasonSLGCombatPowerMgr.GetCoResearchPower = function()
    return this.coResearchPower or 0
end


SeasonSLGCombatPowerMgr.GetFieldPower = function()
    return this.fieldPower or 0
end


SeasonSLGCombatPowerMgr.GetTotalPower = function(characterId)
    return SeasonSLGCombatPowerMgr.GetCharacterPower(characterId)
        + SeasonSLGCombatPowerMgr.GetTechPower()
        + SeasonSLGCombatPowerMgr.GetCoResearchPower()
        + SeasonSLGCombatPowerMgr.GetFieldPower()
end