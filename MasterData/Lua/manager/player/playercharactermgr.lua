
PlayerCharacterMgr = {}


local upLevelHS = {}

local zzHS = {}

local talentHS = {}

local speciality = {}

local friendly = {}

local mainNovel = {}

local heroPackageRedList = {}

local brilliant = {}

local brilliantReward = {}




local CheckCharacterTeam = function(characterId)
    for k, team in pairs(DataMgr.Player.teams) do
if k ~= "teamsYX" then
            for key, item in pairs(team.members) do
                local helps=team.helps;
                if characterId == item and (IsNull(helps) or IsNullOrEmpty(helps[key]))then
                    return true
                end
            end
        end
    end
    return false
end


local CheckCharacterUpLevel = function(character, addExp) 
    PlayerCharacterMgr.GetFastLevelUpItem(character, false, true)
end


local CheckCharacterZZ = function(character)
    local characterConfig = ConfigMgr.Config.characterTable[character.id]
    if characterConfig == nil then
        return
    end

    local nextStar = character.star + 1
    if nextStar > ConfigMgr.Config.constants.maxStar then
        return
    end

    local rankUp = ConfigCharacterMgr.GetCharacterRankUp(nextStar, characterConfig.rare)
    if rankUp == nil then
        return
    end

    local coin = PlayerItemMgr.GetItemCountById("3")
    if coin < rankUp.coin then
        return
    end

    local itemCount = PlayerItemMgr.GetItemCountById(characterConfig.crystalItemId)
    if itemCount >= rankUp.count then
        zzHS[character.id] = true
        return
    end
    local selectTXK = SettingHelper.GetPrefasBool(ESetting.Msg_ZZTXKRed_Open);
    if (selectTXK and not IsNullOrEmpty(rankUp.matItem.id)) then
        itemCount = PlayerItemMgr.GetItemCountById(rankUp.matItem.id);
        if (itemCount >= rankUp.matItem.count) then
            zzHS[character.id] = true
        end
    end









    end


local CheckCharacterTalent = function(character)
    local rare = ConfigMgr.Config.characterTable[character.id].rare
    for key, item in pairs(character.talents) do
        if item.status == 1 then
            local talentConfig = ConfigMgr.Config.characterTalentMap[item.id]

            if talentConfig.talentType == 3 then
                goto continue
            end
            if talentConfig ~= nil and character.level >= talentConfig.requireLevel and character.star >= talentConfig.requireStar then
                if PlayerItemMgr.GetItemEnough(talentConfig.requireCoin) and PlayerItemMgr.GetItemEnough(talentConfig.requireItems) then
                    talentHS[character.id] = true
                    break
                end
            end
        end
        ::continue::
    end
end


local CheckSpeciality = function(character)
    local levelBool = character.level > ConfigMgr.Config.constants.ShenzaoUnlock
    local styleBool = type(character.style) == "function" or TableIsNull(character.style)
    local allPointCount = ConfigHelper.GetHeroSpecialityAllPoint(character.level)
    if styleBool and levelBool then
        speciality[character.id] = true
    elseif not styleBool then
        for i = 1, #character.style.points do
            allPointCount = allPointCount - character.style.points[i]
        end
        if allPointCount > 0 then
            speciality[character.id] = true
        end
    end







end


local CheckHeroFriendly = function(character)
    if character.prestigeLevel < 10 then
        local nextLevel = character.prestigeLevel + 1 > 10 and 10 or character.prestigeLevel + 1
        local nextLevelExp = ConfigMgr.Config.friendshipLevelUp[tostring(nextLevel)]
        if character.prestige >= nextLevelExp then
            friendly[character.id] = true
        end
    end
end


local CheckBrilliant = function(character)
    if TableIsNull(character) then
        return
    end
    if character.level < 100 then
        return
    end
    local rare = HeroMgr.GetHeroNowRare(character.id)
    if rare > 4 then
        return
    end
    local brilliantKey = character.id..rare
    local brilliantConfig = ConfigMgr.Config.BrilliantMap[brilliantKey]
    if TableIsNull(brilliantConfig) then
        return
    end
    local curTime = LuaMgr.Timestamp()
    local unlockTime = brilliantConfig.UnlockDate
    if curTime < unlockTime then
        return
    end
    local hzKey = DataMgr.Player.uid.."huanzhang"..character.id
    if UnityEngine.PlayerPrefs.HasKey(hzKey) then
        local brilliantRed=1;

        local itemCost1=brilliantConfig.ItemCost1
        if not IsNull(itemCost1) and #itemCost1>0 then
            for i,v in ipairs(itemCost1) do
                if DataHelper.GetItemCountById(v.id)<v.count then
                    brilliantRed=0;
                    break;
                end
            end
        end

        local requireCoin =brilliantConfig.RequireCoin
        if brilliantRed>0 and not IsNull(requireCoin) and #requireCoin>0 then
            for i,v in ipairs(requireCoin) do
                if DataHelper.GetItemCountById(v.id)<v.count then
                    brilliantRed=0;
                    break;
                end
            end
        end
        if brilliantRed==0 then return end;
    end
    brilliant[character.id] = true
end


local CheckBrilliantReward = function(character)
    if TableIsNull(character) then
        return
    end

    local chaCfg = ConfigCharacterMgr.GetInfo(character.id)
    local brilliantKey = character.id .. chaCfg.rare
    local brilliantConfig = ConfigMgr.Config.BrilliantMap[brilliantKey]
    local curTime = LuaMgr.Timestamp()
    if TableIsNull(brilliantConfig) or IsNullOrEmpty(brilliantConfig.DungeonId) or curTime < brilliantConfig.UnlockDate then
        return
    end
    local hzKey = DataMgr.Player.uid.."huanzhangReward"..character.id
    brilliantReward[character.id] = not UnityEngine.PlayerPrefs.HasKey(hzKey)
end


local GetAddExp = function()
    local exp = 0
    local itemList = ConfigItemMgr.GetItemsByType(ItemType.CharacterExp)
    if itemList ~= nil then
        for k, item in pairs(itemList) do
            exp = exp + item.drop * PlayerItemMgr.GetItemCountById(item.id)
        end
    end
    return exp
end


PlayerCharacterMgr.CheckMail = function()
    for key, item in pairs(DataMgr.Player.mails) do
        if type(item.items) == "function" then
            item.items = {}
        end
        if item.expireTime >= LuaMgr.Timestamp() then
            if item.status == 0 then
                return 1
            end
            if item.status == 1 and next(item.items) ~= nil then
                return 1
            end
        end
    end
    return 0
end


PlayerCharacterMgr.CheckCGMap = function()
    if not FeatureManager.IsLock("1100") then
        local isBanned = false
        local collectCG = nil
        for i, v in ipairs(ConfigMgr.Config.collectCGs) do
            isBanned = FeatureManager.UnifyVerControls("collectCG",v.attributionType)
            if v.collectOFF == 0 and isBanned then
                collectCG = DataMgr.Player.collectCGMap[v.id]
                if collectCG.current == collectCG.target and not collectCG.unlock then
                    return 1
                end
            end
        end
    end
    return 0
end

PlayerCharacterMgr.CheckArchives = function()
    if not FeatureManager.IsLock("4004") then
        local isLock = true
        local isBanned = false
        for key,value in pairs(ConfigMgr.Config.FileMap) do

            isBanned = FeatureManager.UnifyVerControls("areamap",value.MainType)
            if isBanned then
                if value.Unlock[1] == "1" then
                    isLock = tonumber(value.Unlock[2]) > DataMgr.Player.level
                elseif value.Unlock[1] == "2" then
                    isLock = DataMgr.Player.completedAreaEvents[value.Unlock[2]] == nil
                elseif value.Unlock[1] == "3" then
                    isLock = PlayerCharacterMgr.GetState(value.Unlock[2])
                elseif value.Unlock[1] == "4" then
                    isLock = PlayerCharacterMgr.GetAreaEventState(value.Unlock[2])
                end
                if not isLock then
                    if type(DataMgr.Player.iceGorge.archivesReward) == "function" then return 1 end
                    if DataMgr.Player.iceGorge.archivesReward[value.ID] == nil then return 1 end
                end
            end
        end
    end
    return 0
end
PlayerCharacterMgr.GetState = function(condition)
    for i = 1, #DataMgr.Player.completedChapters do
        if DataMgr.Player.completedChapters[i] == condition then
            return false
        end
    end
    return true
end

PlayerCharacterMgr.GetAreaEventState = function(eventId)
    if ConfigMgr.Config.areaExplores[eventId] == nil then return true end
    local areaName = ConfigMgr.Config.areaExplores[eventId].tab
    if areaName == nil then return true end
    if DataMgr.Player.areaExplores[areaName]==nil then
        return true
    end
    if DataMgr.Player.areaExplores[areaName].completedExplores[eventId] == nil then
        return true
    else
        return false
    end
end

PlayerCharacterMgr.CheckJournal = function()
    if not FeatureManager.IsLock("4003") then
        local isLock = true
        for key,value in pairs(ConfigMgr.Config.MagazineMap) do
            if value.Unlock[1] == "1" then
                isLock = tonumber(value.Unlock[2]) > DataMgr.Player.level
            elseif value.Unlock[1] == "2" then
                isLock = DataMgr.Player.completedAreaEvents[value.Unlock[2]] == nil
            elseif value.Unlock[1] == "3" then
                isLock = PlayerCharacterMgr.GetState(value.Unlock[2])
            end
            if not isLock then
                if type(DataMgr.Player.iceGorge.journalReward) == "function" then return 1 end
                if DataMgr.Player.iceGorge.journalReward[value.ID] == nil then return 1 end
            end
        end
    end
    return 0
end

PlayerCharacterMgr.CheckEventPlayback = function()
    if not FeatureManager.IsLock("4002") then
        if next(mainNovel) == nil then
            local type = nil
            for i = 1, #ConfigMgr.Config.MainPlotMap do
                type = ConfigMgr.Config.MainPlotMap[i].MainType
                if mainNovel[type] == nil then mainNovel[type] = {} end
                table.insert(mainNovel[type],ConfigMgr.Config.MainPlotMap[i])
            end
        end
        local rewardIsShow = true
        local isBanned = false
        for key,value in pairs(mainNovel) do

            isBanned = FeatureManager.UnifyVerControls("areamap",key)
            if isBanned then
                rewardIsShow = true
if PlayerAreaMgr.CheckAreaUnlock(key)  then
                    if type(DataMgr.Player.iceGorge.storyReward) == "function" or
                            DataMgr.Player.iceGorge.storyReward[key] == nil then
                        for i = 1, #value do
                            if not DataHelper.GetNovelState(value[i].PlotId[1]) then
                                rewardIsShow = false
                            end
                        end
                        if rewardIsShow then return 1 end
                    end
                end
            end
        end
    end
    return 0
end

PlayerCharacterMgr.CheckGroupPhotoRed = function()
    if not FeatureManager.IsLock("4005") then
        for key,value in pairs(DataMgr.Player.missions["groupPhoto"]["901"]) do
            if not value.completed and value.current >= value.target then
                return 1
            end
        end
    end
    return 0
end

PlayerCharacterMgr.CheckAddAttrActiveRed = function()
    local nowTime = LuaMgr.Timestamp()
    if nowTime >= ConfigMgr.Config.constants.BestiarySupplyTime then
        if not FeatureManager.IsLock("4006") then
            local character = nil
            local typeKey = nil
            for key,value in pairs(ConfigMgr.Config.BestiarySupplyMap) do
                character = DataMgr.Player.characters[key]
                if not TableIsNull(character) and value.Switch == 1 then

                    typeKey = key.."_level_"..value.Level
                    if DataMgr.Player.jobExtraAttr[typeKey] == nil then
                        if character.level >= value.Level then
                            return 1
                        end
                    else

                        for i = 2, #value.Provide do
                            if i <= 7 then
                                if value.Provide[i] ~= "" and i - 1 <= character.star then
                                    typeKey = key.."_star_"..i - 1
                                    if DataMgr.Player.jobExtraAttr[typeKey] == nil then
                                        return 1
                                    end
                                end
                            end
                        end

                        typeKey = key.."_brilliant_1"
                        local curRare = HeroMgr.GetHeroNowRare(key)
                        if DataMgr.Player.jobExtraAttr[typeKey] == nil and curRare >= 5 then
                            return 1
                        end
                    end
                end
            end
        end
    end
    return 0
end


PlayerCharacterMgr.CheckMission = function()

    local missionDic = DataMgr.Player.missions
    for k, active in pairs(missionDic["daily"]["102"]) do
        if not active.completed then
            for key, mission in pairs(missionDic["daily"]["101"]) do
                if not mission.completed and mission.current >= mission.target then
                    return 1
                end
            end
            break
        end
    end

    for k, active in pairs(missionDic["weekly"]["104"]) do
        if not active.completed then
            for key, mission in pairs(missionDic["weekly"]["103"]) do
                if not mission.completed and mission.current >= mission.target then
                    return 1
                end
            end
            break
        end
    end

    local isLock = FeatureManager.IsLock("1018")
    if not isLock then
        for k, achievement in pairs(missionDic["achievement"]["201"]) do
            if not achievement.completed and achievement.current >= achievement.target then
                return 1
            end
        end
    end
    return 0
end


PlayerCharacterMgr.CheckCharacter = function()
    upLevelHS = {}
    zzHS = {}
    talentHS = {}
    speciality = {}
    heroPackageRedList = {}
    friendly = {}
    brilliant = {}
    brilliantReward = {}
    local addExp = GetAddExp()
    local isUpLevel = not FeatureManager.IsLock("1005")
    local isZZ = not FeatureManager.IsLock("1007")
    local isTalent = not FeatureManager.IsLock("1006")
    local isLP = not FeatureManager.IsLock("1110")
    local isFriendly = not FeatureManager.IsLock("1010")
    local isHZ = not FeatureManager.IsLock("8050")
    local SetUpLevel = SettingHelper.GetPrefasBool(ESetting.Msg_LevelUpRed_CommonlyHero)
    local SetAllUpLevel = SettingHelper.GetPrefasBool(ESetting.Msg_LevelUpRed_AllHero)
    local SetHeroZZ = SettingHelper.GetPrefasBool(ESetting.Msg_ZZRed_CommonlyHero)
    local SetAllHeroZZ = SettingHelper.GetPrefasBool(ESetting.Msg_ZZRed_AllHero)
    local SetTalent = SettingHelper.GetPrefasBool(ESetting.Msg_TalentRed_CommonlyHero)
    local SetAllTalent = SettingHelper.GetPrefasBool(ESetting.Msg_TalentRed_AllHero)
    local SetSpeciality = SettingHelper.GetPrefasBool(ESetting.Msg_LPRed_CommonlyHero)
    local SetAllSpeciality = SettingHelper.GetPrefasBool(ESetting.Msg_LPRed_AllHero)
    local SetHZ = SettingHelper.GetPrefasBool(ESetting.Msg_HZRed_CommonlyHero)
    local SetAllHZ = SettingHelper.GetPrefasBool(ESetting.Msg_HZRed_AllHero)

    for k, item in pairs(DataMgr.Player.characters) do
        local isTeam = CheckCharacterTeam(item.id)
        if isUpLevel then
            if SetUpLevel or SetAllUpLevel then
                if (SetUpLevel and isTeam) or not SetUpLevel then
                    CheckCharacterUpLevel(item, addExp)
                end
            end
        end

        if isZZ then
            if SetHeroZZ or SetAllHeroZZ then
                if (SetHeroZZ and isTeam) or not SetHeroZZ then
                    CheckCharacterZZ(item)
                end
            end
        end

        if isTalent then
            if SetTalent or SetAllTalent then
                if (SetTalent and isTeam) or not SetTalent then
                    CheckCharacterTalent(item)
                end
            end
        end

        if isLP then
            if SetSpeciality or SetAllSpeciality then
                if (SetSpeciality and isTeam) or not SetSpeciality then
                    CheckSpeciality(item)
                end
            end
        end

        if isFriendly then
            CheckHeroFriendly(item)
        end
        
        if isHZ then
            if SetHZ or SetAllHZ then
                if (SetHZ and isTeam) or not SetHZ then
                    CheckBrilliant(item)
                end
            end
        end
        

        CheckBrilliantReward(item)
        
        local redCount = PlayerCharacterMgr.RedUpLevel(item.id) and 1 or 0
        redCount = redCount + (PlayerCharacterMgr.RedZZ(item.id) and 1 or 0)
        redCount = redCount + (PlayerCharacterMgr.RedTalent(item.id) and 1 or 0)
        redCount = redCount + (PlayerCharacterMgr.RedSpeciality(item.id) and 1 or 0)

        RedMgr.Singleton:UpdateClientRedData("1022_" .. item.id, redCount)
    end
    
    local count = PlayerCharacterMgr.RedUpLevel()
    count = count + PlayerCharacterMgr.RedZZ()
    count = count + PlayerCharacterMgr.RedTalent()
    count = count + PlayerCharacterMgr.RedSpeciality()
    count=count+PlayerCharacterMgr.ArchivesLanguageTipRed();
    count = count + ConfigHelper.GetTableLength(friendly)
    PlayerCharacterMgr.CalculateHeroRedCount()
    count = count + PlayerCharacterMgr.RedHuanZhang()
    count = count + PlayerCharacterMgr.RedHuanZhangReward()
    RedMgr.Singleton:UpdateClientRedData("1021", count)
    RedMgr.Singleton:Refresh();
end


function PlayerCharacterMgr.ArchivesLanguageTipRed(chId)
    local characterId="A0100"
    if chId~=nil and characterId~=chId then
        return 0
    end
    if DataMgr.Player.characters[characterId]==nil then return 0 end
    if RedMgr.Singleton:CheckRedCondition("1312") then
        return 1
    end
    return 0;
end



function PlayerCharacterMgr.RedUpLevel(characterId)
    if characterId == nil then
        local count = 0
        for k, v in pairs(upLevelHS) do
            count = count + 1
        end
        return count
    else
        return upLevelHS[characterId] == true
    end
end


function PlayerCharacterMgr.RedZZ(characterId)
    if characterId == nil then
        local count = 0
        for k, v in pairs(zzHS) do
            count = count + 1
        end
        return count
    else
        return zzHS[characterId] == true;
    end
end


function PlayerCharacterMgr.RedFriendly(characterId)
    if DataMgr.Player.characters[characterId]==nil then

        return 0
    end
    local count = 0
    local isFriendly = not FeatureManager.IsLock("1010")
    if isFriendly then
        local character = DataMgr.Player.characters[characterId]
        if character.prestigeLevel == 10 then
            count = 0
        else
            local nextLevel = character.prestigeLevel + 1 > 10 and 10 or character.prestigeLevel + 1
            local nextLevelExp = ConfigMgr.Config.friendshipLevelUp[tostring(nextLevel)]
            if character.prestige >= nextLevelExp then
                count = 1
            end
        end
    end
    return count
end


function PlayerCharacterMgr.RedTalent(characterId)
    if characterId == nil then
        local count = 0
        for k, v in pairs(talentHS) do
            count = count + 1
        end
        return count
    else
        return talentHS[characterId] == true
    end
end


function PlayerCharacterMgr.RedSpeciality(characterId)
    if characterId == nil then
        local count = 0
        for k, v in pairs(speciality) do
            count = count + 1
        end
        return count
    else
        return speciality[characterId] == true
    end
end


function PlayerCharacterMgr.RedHuanZhang(characterId)
    if characterId == nil then
        local count = 0
        for k, v in pairs(brilliant) do
            count = count + 1
        end
        return count
    else
        return brilliant[characterId] == true
    end
end


function PlayerCharacterMgr.UpdateRedHuanZhang(character)
    brilliant[character.id] = false
    local isTeam = CheckCharacterTeam(character.id)
    if isTeam then
        CheckBrilliant(character)
    end
end


function PlayerCharacterMgr.RedHuanZhangReward(characterId)
    if characterId == nil then
        local count = 0
        for k, v in pairs(brilliantReward) do
            if v then
                count = count + 1
            end
        end
        return count
    else
        return brilliantReward[characterId] == true
    end
end


function PlayerCharacterMgr.UpdateRedHuanZhangReward(character)
    brilliantReward[character.id] = false
    CheckBrilliantReward(character)
    PlayerCharacterMgr.CalculateHeroRedCount()
end


function PlayerCharacterMgr.TalentRedState(talentId,characterId)
    local characterData = DataMgr.Player.characters[characterId]

    if TableIsNull(characterData) or IsNullOrEmpty(characterId) then
        return false
    end
    local talent = ConfigMgr.Config.characterTalentMap[talentId]
    if TableIsNull(talent) or IsNullOrEmpty(talentId) then
        return false
    end
if talent.requireLevel ~= 0 then
        if talent.requireLevel > characterData.level then return false end
    end
if talent.requireStar ~= 0 then
        if talent.requireStar > characterData.star then return false end
    end
for i = 1, #talent.requireTalent do
        local id = talent.requireTalent[i]
        if characterData.talents[id].status ~= 2 then return false end
    end

    if type(talent.requireItems) ~= "function" then
        local length = ConfigHelper.GetTableLength(talent.requireItems)
        for i = 1, length do
            if DataHelper.GetItemCountById(talent.requireItems[i].id) < talent.requireItems[i].count then
                return false
            end
        end
    end

    local id,count = nil,nil
    if type(talent.requireCoin) ~= "function" and #talent.requireCoin > 0 then
        id,count = talent.requireCoin[1].id,talent.requireCoin[1].count
        if DataHelper.GetItemCountById(id) < count then
            return false
        end
    end
    return true
end


function PlayerCharacterMgr.EquipmentWearState(characterId)
    local isFriendly = not FeatureManager.IsLock("1025")
    local isTeam = CheckCharacterTeam(characterId)
    if isFriendly and isTeam then
        local wearId = DataMgr.Player.characters[characterId].wear
        local characterJob = ConfigMgr.Config.characterTable[characterId].job
        if wearId == nil or wearId == "" then
            for i, v in pairs(DataMgr.Player.equipments) do
                local equipJob = ConfigMgr.Config.equipments[v.equipmentId].job
                if equipJob == characterJob and v.characterId == "" then
                    return true
                end
            end
        else
            local equipConfig = ConfigMgr.Config.equipments[DataMgr.Player.equipments[wearId].equipmentId]
            local equipRare = 0
            if equipConfig ~= nil then
                equipRare = equipConfig.rare
            end
            local tempEquip = nil
            local equipJob = 0
            if equipRare < CharacterRare.SSR then
                for i, v in pairs(DataMgr.Player.equipments) do
                    tempEquip = ConfigMgr.Config.equipments[v.equipmentId]
                    equipJob = tempEquip == nil and 0 or tempEquip.job
                    if equipJob == characterJob and equipRare < ConfigMgr.Config.equipments[v.equipmentId].rare and v.characterId == "" then
                        return true
                    end
                end
            end
        end
    end
    return false
end

function PlayerCharacterMgr.GetCharacter(id)
    return DataMgr.Player.characters[id]
end







local GetLevelUpItem
GetLevelUpItem = function(expItemList, itemIndex, needExp, costCoin, rareUpCoin, neexExpItemList)
    if neexExpItemList == nil then
        neexExpItemList = {}
    end
    if needExp <= 0 then return true end
    if itemIndex <= 0 then return false end
    
    local expItem = expItemList[itemIndex]
    local serverItem = PlayerItemMgr.GetItemById(expItem.id)
    local count = serverItem ~= nil and serverItem.count0 or 0
    local needItemCount = 0
    local coin = PlayerItemMgr.GetItemCountById("3")
    if expItem ~= nil and count > 0 then
        needItemCount = math.min( math.floor(needExp / expItem.drop), count)
        while coin < needItemCount * expItem.drop * rareUpCoin + costCoin do
            needItemCount = needItemCount - 1
        end
    end
    local isOk = GetLevelUpItem(expItemList, itemIndex - 1, needExp - needItemCount * expItem.drop, needItemCount * expItem.drop * rareUpCoin + costCoin, rareUpCoin, neexExpItemList)

    if not isOk then

        if needItemCount + 1 > count then
            return false, false
        end
        needItemCount = needItemCount + 1
        if needItemCount <= 0 or coin < needItemCount * expItem.drop * rareUpCoin + costCoin then
            return false, true
        end
    end
    neexExpItemList[expItem.id] = needItemCount
    
    return true, true
end


function PlayerCharacterMgr.GetFastLevelUpItem(character, isUpLevelPanel, isUpdateRedDot)
    local isItemEnough = false
    local expItemList = ConfigItemMgr.GetItemsByType(ItemType.CharacterExp)
    local characterConfig = ConfigMgr.Config.characterTable[character.id]
    
    if characterConfig == nil then return false end
    
    if character.level >= character.limitedLevel then return false end
    
    if character.level >= ConfigMgr.Config.constants.maxCharacterLevel then return false end

    local canLevelUpMaxLevel = character.level
    local needExp = ConfigMgr.Config.characterLevelUp[tostring(character.level + 1)] - character.exp
    local rareUpCoin = ConfigCharacterMgr.GetLevelUpCoinByRare(characterConfig.rare) / 100
    local coin = PlayerItemMgr.GetItemCountById("3")    
    local needExpItemList = {}
    local isOk = false

    if isUpLevelPanel then
        local limitedLevel = math.min(character.limitedLevel, ConfigMgr.Config.constants.maxCharacterLevel)
        local maxExpByCoin = math.floor(coin / rareUpCoin)
        local maxExpByItem = 0
        for i = 1, #expItemList do
            local expItem = expItemList[i]
            local needItemCount = 0
            local serverItem = PlayerItemMgr.GetItemById(expItem.id)
            local count = serverItem ~= nil and serverItem.count0 or 0
            maxExpByItem = maxExpByItem + expItem.drop * count
        end
        local maxExp = math.min(maxExpByCoin, maxExpByItem)
        isItemEnough = maxExpByItem >= maxExpByCoin
        local allExp = maxExp + character.exp
        while canLevelUpMaxLevel <= limitedLevel do
            if allExp < ConfigMgr.Config.characterLevelUp[tostring(canLevelUpMaxLevel)] then
                canLevelUpMaxLevel = canLevelUpMaxLevel - 1
                break
            end
            canLevelUpMaxLevel = canLevelUpMaxLevel + 1
        end
        canLevelUpMaxLevel = math.min(limitedLevel, canLevelUpMaxLevel)

        
        while canLevelUpMaxLevel > character.level do
            needExp = ConfigMgr.Config.characterLevelUp[tostring(canLevelUpMaxLevel)] - character.exp
            isOk, isItemEnough = GetLevelUpItem(expItemList, #expItemList, needExp, 0, rareUpCoin, needExpItemList)
            if isOk then
                break
            end
            canLevelUpMaxLevel = canLevelUpMaxLevel - 1
        end
    else
        isOk, isItemEnough = GetLevelUpItem(expItemList, #expItemList, needExp, 0, rareUpCoin, needExpItemList)
    end

    if isUpdateRedDot and isOk then
        upLevelHS[character.id] = true
    end
    return isOk, needExpItemList, isItemEnough
end

function PlayerCharacterMgr.GetReveiwActivityRed()
    if FeatureManager.IsLock("4007") then
        return 0;
    end

    if PlayerPrefs.GetInt(DataMgr.Player.uid.."ActivityReview")==0 then
        return 1;
    end
    local red=0;
    for i,v in pairs(ConfigMgr.Config.ActivityThemeMap) do
        red=PlayerCharacterMgr.GetActivityThemeReviewRed(v.ID);
        if red>0 then
            break;
        end
    end
    return red;
end

function PlayerCharacterMgr.GetDispatchStoryRed()
    if FeatureManager.IsLock("30097") then
        return 0;
    end
    return DispatchData.GetStoryRewardRed();
end


function PlayerCharacterMgr.GetActivityThemeReviewRed(id)
    local activity=ConfigMgr.Config.ActivityThemeMap[id];
    if activity==nil then 
        return 0;
    end;
    if activity.StartTime>LuaMgr.Timestamp() then
        return 0;
    end

    if IsNull(DataMgr.Player.activityReview) or IsNull(DataMgr.Player.activityReview.unlock) or DataMgr.Player.activityReview.unlock[id]==nil then

        if not IsNull(activity.Unlock) and #activity.Unlock>0 and activity.Unlock[1]=="3" then

            local myCount=DataHelper.GetItemCountById(activity.Unlock[2]);
            return myCount>=tonumber(activity.Unlock[3]) and 1 or 0;
        end
        return 0;
    end
    

    if  not IsNull(DataMgr.Player.activityReview.reward) then
        if DataMgr.Player.activityReview.reward[id]~=nil then
            return 0;
        end
    end
    
    local red=0;
    local key=activity.Key;
    if key=="entry" then
        if DataMgr.Player.variables[activity.GroupID] ~= nil and DataMgr.Player.variables[activity.GroupID].clientFished then
            red=1;
        end
    elseif key=="walkmount" then

        red=0;
    else
        local activeTheme=ConfigMgr.Config.ActivityThemeMap[id];
        if activeTheme==nil or  IsNull(activeTheme.Rewards) or #activeTheme.Rewards==0 then
            return 0
        end
        red=1;
        local novelList={}
        local dungeonList={}
        for i,v in ipairs(ConfigMgr.Config.activityMapEventList) do
            if string.starts(v.area,key) then
                if v.type==1 then
                    table.insert(novelList,v);
                elseif v.type==2 then
                    if key=="Travel"  then
                        if not IsNullOrEmpty(v.groupId) then
                            table.insert(dungeonList,v);
                        end
                    elseif key == "Music" then
                        if v.area ~= "Music02" then
                            table.insert(dungeonList,v);
                        end
                    else
                        table.insert(dungeonList,v);
                    end
                end
            end
        end
        if #novelList>0 then
            for i,v in ipairs(novelList) do
                if not DataHelper.CheckNovelComplete(v.eventParam) then
                    red=0;
                    break;
                end
            end
        end
        if red==1 then
            for i,v in ipairs(dungeonList) do
                if DataMgr.Player.dungeonRecords[v.eventParam]==nil or DataMgr.Player.dungeonRecords[v.eventParam].completeCount==0 then
                    red=0;
                end
            end
        end
        if red==1 and key=="Travel" then
            local cfgTravelCard={}
            for p,m in pairs(ConfigMgr.Config.TravelPostcardMap) do
                if m.RewardType==1 then
                    table.insert(cfgTravelCard,m);
                end
            end
            if IsNull(DataMgr.Player.postcards) or #cfgTravelCard==0 or NumTool.GetLen(DataMgr.Player.postcards)<#cfgTravelCard then
                red=0;
            end
        end
    end
    return red;
end

function PlayerCharacterMgr.CalculateHeroRedCount()
    heroPackageRedList = {}
    for k, v in pairs(upLevelHS) do
        if v then
            heroPackageRedList[k] = 1
        end
    end
    for k, v in pairs(zzHS) do
        if v then
            heroPackageRedList[k] = 1
        end
    end
    for k, v in pairs(talentHS) do
        if v then
            heroPackageRedList[k] = 1
        end
    end
    for k, v in pairs(speciality) do
        if v then
            heroPackageRedList[k] = 1
        end
    end
    for k, v in pairs(friendly) do
        if v then
            heroPackageRedList[k] = 1
        end
    end
    for k,v in pairs(brilliant) do
        if v then
            heroPackageRedList[k] = 1
        end
    end
    for k,v in pairs(brilliantReward) do
        if v then
            heroPackageRedList[k] = 1
        end
    end
    if PlayerCharacterMgr.ArchivesLanguageTipRed() > 0 then
        heroPackageRedList["A0100"] = 1
    end
end

function PlayerCharacterMgr.GetHeroPackageRedNum()
    return ConfigHelper.GetTableLength(heroPackageRedList)
end

function PlayerCharacterMgr.HeroPackageRedContain(heroId)
    local isTrue = heroPackageRedList[heroId] ~= nil and heroPackageRedList[heroId] == 1
    return isTrue
end

function PlayerCharacterMgr.GetCharacterSkillLevel(characterId,skillId,isAssisHero)
    local character=nil;
    if isAssisHero then
        character=PlayerAssistMgr.GetCurAssist_CharacterData();
    else
        character=DataMgr.Player.characters[characterId];
    end
    if character==nil then
        return 0
    end;
    local  exSkillId = skillId.."ex";
    for i,v in pairs(character.skills) do
        if v.groupId==skillId or v.groupId==exSkillId then
            return v.level
        end
    end
    return 0;
end

function PlayerCharacterMgr.CheckLoginBackGroundUnLock(loginBackItem)
    if LuaMgr.Timestamp()>loginBackItem.StartTime and LuaMgr.Timestamp()<loginBackItem.EndTime then
        return true;
    end
    if not IsNullOrEmpty(loginBackItem.UnLockSkin)  then
        return DataHelper.GetItemCountById(loginBackItem.UnLockSkin)>0
    end
    return false;
    
end 

function PlayerCharacterMgr.UpdateLoginKV(kvName,callBack)
    local askData={Id=kvName}
    ApiMgr.Request("selectLoginKV",askData,true,function()
        if callBack~=nil then
            callBack();
        end
    end,nil,true);
end 