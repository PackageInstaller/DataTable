




HeroRedDataHelper = {
    archives_assess_BasicFileIDRedList = {},
    archives_assess_SpecialFileIDRedList = {},
    archives_assess_AvgFileIDRedList = {},
    archives_saying_redList = {},

    setting_avatarList = {},
    setting_avatarFrameList = {},
    setting_playerSkinsRedList = {},

    backPack_giftRedList = {},
    backpack_equipRedList = {},

    characterRedList = {},

    shopRedList = {
    },

    trafficPermit = {
    }

}


local cfgCharactorFiles = nil;
local cfgLinesUnlock = nil;
local dataCharacter = nil;
local dataDungeonRecords = nil;

local Archives_SayingUnlock = function(type)
    local unlockLines = dataCharacter.unlockedLines;
    local re = unlockLines[type];
    return re ~= nil;
end


local Archives_AssessUnlock = function(data)
    local unlock = false;
    local unlockText = "";
    if (tonumber(data.UnlockType) == 1) then
        if (dataCharacter.level >= tonumber(data.ElementID)) then
            unlock = true
        end
    elseif (tonumber(data.UnlockType) == 2) then
        if dataCharacter.prestigeLevel >= tonumber(data.ElementID) then
            unlock = true;
        end
    elseif (tonumber(data.UnlockType) == 3) then
        if dataDungeonRecords[data.ElementID] ~= nil then
            unlock = true;
        end
    elseif (tonumber(data.UnlockType) == 4) then
        local num = DataHelper.GetItemCountById(data.ElementID)
        if num > 0 then
            unlock = true;
        end
    else
        unlock = true;
    end
    return unlock, unlockText;
end



local Archives_AssessRedData = function(charaId)
    local red = 0;
    if cfgCharactorFiles == nil then
        return red;
    end
    if NumTool.GetLen(cfgCharactorFiles.basicFileID) > 0 then
        for i, v in ipairs(cfgCharactorFiles.basicFileID) do
            local unlock = Archives_AssessUnlock(cfgCharactorFiles.basicFileUnlock[i]);
            if unlock then
                local num = UnityEngine.PlayerPrefs.GetInt(DataMgr.Player.uid .. charaId .. v);
                HeroRedDataHelper.archives_assess_BasicFileIDRedList[v] = num;
                red = red + num;
            else
                UnityEngine.PlayerPrefs.SetInt(DataMgr.Player.uid .. charaId .. v, 1);
            end
        end
    end
    if NumTool.GetLen(cfgCharactorFiles.specialFileID) > 0 then
        for i, v in ipairs(cfgCharactorFiles.specialFileID) do
            local unlock = Archives_AssessUnlock(cfgCharactorFiles.specialFileUnlock[i]);
            if unlock then
                local num = UnityEngine.PlayerPrefs.GetInt(DataMgr.Player.uid .. charaId .. v);
                HeroRedDataHelper.archives_assess_SpecialFileIDRedList[v] = num;
                red = red + num;
            else
                UnityEngine.PlayerPrefs.SetInt(DataMgr.Player.uid .. charaId .. v, 1);
            end
        end
    end
    if NumTool.GetLen(cfgCharactorFiles.AVGFileID) > 0 then
        for i, v in ipairs(cfgCharactorFiles.AVGFileID) do
            local unlock = Archives_AssessUnlock(cfgCharactorFiles.AVGFileUnlock[i]);
            if unlock then
                local num = UnityEngine.PlayerPrefs.GetInt(DataMgr.Player.uid .. charaId .. v);
                HeroRedDataHelper.archives_assess_AvgFileIDRedList[v] = num;
                red = red + num;
            else
                UnityEngine.PlayerPrefs.SetInt(DataMgr.Player.uid .. charaId .. v, 1);
            end
        end
    end
    return red;
end


local Archives_SayintRedData = function(charaId)
    local red = 0;
    if cfgLinesUnlock == nil then
        return red;
    end
    for i, v in ipairs(cfgLinesUnlock) do
        local unlock = Archives_SayingUnlock(v.linesType)
        if unlock then
            local num = UnityEngine.PlayerPrefs.GetInt(DataMgr.Player.uid .. charaId .. v.linesType);
            HeroRedDataHelper.archives_saying_redList[v.linesType] = num;
            red = red + num;
        else
            UnityEngine.PlayerPrefs.SetInt(DataMgr.Player.uid .. charaId .. v.linesType, 1);
        end
    end
    return red;
end

HeroRedDataHelper.Archives_ClearAssessPlayerPrefsFile = function(charaId, index, v)
    local redNum = 0;
    local redNum1 = 0;
    local redNum2 = 0;
    local redNum3 = 0;
    if index == nil then
        for i, v in pairs(HeroRedDataHelper.archives_assess_BasicFileIDRedList) do
            if v > 0 and UnityEngine.PlayerPrefs.HasKey(DataMgr.Player.uid .. charaId .. i) then
                UnityEngine.PlayerPrefs.DeleteKey(DataMgr.Player.uid .. charaId .. i);
                RedMgr.Singleton:UpdateClientRedData("1124_" .. i, 0);
            end
        end
        for i, v in pairs(HeroRedDataHelper.archives_assess_SpecialFileIDRedList) do
            if v > 0 and UnityEngine.PlayerPrefs.HasKey(DataMgr.Player.uid .. charaId .. i) then
                UnityEngine.PlayerPrefs.DeleteKey(DataMgr.Player.uid .. charaId .. i);
                RedMgr.Singleton:UpdateClientRedData("1124_" .. i, 0);
            end
        end
        for i, v in pairs(HeroRedDataHelper.archives_assess_AvgFileIDRedList) do
            if v > 0 and UnityEngine.PlayerPrefs.HasKey(DataMgr.Player.uid .. charaId .. i) then
                UnityEngine.PlayerPrefs.DeleteKey(DataMgr.Player.uid .. charaId .. i);
                RedMgr.Singleton:UpdateClientRedData("1124_" .. i, 0);
            end
        end
    elseif UnityEngine.PlayerPrefs.HasKey(DataMgr.Player.uid .. charaId .. v) then
        UnityEngine.PlayerPrefs.DeleteKey(DataMgr.Player.uid .. charaId .. v);
        RedMgr.Singleton:UpdateClientRedData("1124_" .. v, 0);

        if index == 1 then
            HeroRedDataHelper.archives_assess_BasicFileIDRedList[v] = 0;
        elseif index == 2 then
            HeroRedDataHelper.archives_assess_SpecialFileIDRedList[v] = 0;
        elseif index == 3 then
            HeroRedDataHelper.archives_assess_AvgFileIDRedList[v] = 0;
        end



        for i, v in pairs(HeroRedDataHelper.archives_assess_BasicFileIDRedList) do
            if v > 0 then
                redNum1 = redNum1 + 1;
                break;
            end
        end
        redNum = redNum + redNum1;



        for i, v in pairs(HeroRedDataHelper.archives_assess_SpecialFileIDRedList) do
            if v > 0 then
                redNum2 = redNum2 + 1;
                break;
            end
        end
        redNum = redNum + redNum2;


        for i, v in pairs(HeroRedDataHelper.archives_assess_AvgFileIDRedList) do
            if v > 0 then
                redNum3 = redNum3 + 1;
                break;
            end
        end
        redNum = redNum + redNum3;
    else
        return
    end
    RedMgr.Singleton:UpdateClientRedData("1124_1", redNum1);
    RedMgr.Singleton:UpdateClientRedData("1124_2", redNum2);
    RedMgr.Singleton:UpdateClientRedData("1124_3", redNum3);


    RedMgr.Singleton:UpdateClientRedData("1125_2", redNum);
    RedMgr.Singleton:Refresh();
end


HeroRedDataHelper.Archives_ClearSayingPlayerPrefs = function(charaId, linesType)
    local num = 0;
    if linesType == nil then
        for i, v in pairs(HeroRedDataHelper.archives_saying_redList) do
            if v > 0 and UnityEngine.PlayerPrefs.HasKey(DataMgr.Player.uid .. charaId .. i) then
                UnityEngine.PlayerPrefs.DeleteKey(DataMgr.Player.uid .. charaId .. i)
                RedMgr.Singleton:UpdateClientRedData("1126_" .. i, 0);
            end
        end
    elseif UnityEngine.PlayerPrefs.HasKey(DataMgr.Player.uid .. charaId .. linesType) then
        UnityEngine.PlayerPrefs.DeleteKey(DataMgr.Player.uid .. charaId .. linesType);
        HeroRedDataHelper.archives_saying_redList[linesType] = 0;
        RedMgr.Singleton:UpdateClientRedData("1126_" .. linesType, 0);
        for i, v in pairs(HeroRedDataHelper.archives_saying_redList) do
            if v > 0 then
                num = 1;
                break;
            end
        end
    else
        return
    end
    local lanRed = PlayerCharacterMgr.ArchivesLanguageTipRed(charaId)
    RedMgr.Singleton:UpdateClientRedData("1312", lanRed);
    RedMgr.Singleton:UpdateClientRedData("1125_3", num + lanRed);
    RedMgr.Singleton:Refresh();
end

function HeroRedDataHelper.InitArchivesRedData(characterId)
    if DataMgr.Player.characters[characterId] == nil then
        RedMgr.Singleton:UpdateClientRedData("1121", 0);
        return
    end

    HeroRedDataHelper.archives_assess_BasicFileIDRedList = {};
    HeroRedDataHelper.archives_assess_SpecialFileIDRedList = {};
    HeroRedDataHelper.archives_assess_AvgFileIDRedList = {};
    HeroRedDataHelper.archives_saying_redList = {};

    cfgCharactorFiles = ConfigMgr.Config.characterFiles[characterId]
    cfgLinesUnlock = ConfigMgr.Config.linesUnlock;
    dataCharacter = DataMgr.Player.characters[characterId];
    dataDungeonRecords = DataMgr.Player.dungeonRecords;
    local redNum1 = Archives_AssessRedData(characterId);
    local redNum2 = Archives_SayintRedData(characterId);
    local redNum3 = PlayerCharacterMgr.ArchivesLanguageTipRed(characterId)
    RedMgr.Singleton:UpdateClientRedData("1121", redNum2 + redNum1 + redNum3);
end

function HeroRedDataHelper.InitAvatarFrame()
    local avatarList = {};
    local avatarFrameList = {};
    if nil ~= ConfigMgr.Config.avatarFrames then
        local len = #ConfigMgr.Config.avatarFrames;
        if (len > 0) then
            for i = 1, len do
                local data = ConfigMgr.Config.avatarFrames[i]

                if data.type == 1 then
                    if data.hide == 1 then
                        if nil ~= DataMgr.Player.avatarFrameMap[data.id] then
                            table.insert(avatarList, data)
                        end
                    else
                        table.insert(avatarList, data)
                    end
                elseif data.type == 2 then
                    table.insert(avatarFrameList, data)
                end
            end
        end
    end
    local redNum_0 = 0;
    for i, v in ipairs(avatarList) do
        local unlock = DataMgr.Player.avatarFrameMap[v.id] ~= nil;
        if unlock then
            local num = UnityEngine.PlayerPrefs.GetInt(DataMgr.Player.uid .. v.id);
            HeroRedDataHelper.setting_avatarList[v.id] = num;
            redNum_0 = redNum_0 + num;
        else
            UnityEngine.PlayerPrefs.SetInt(DataMgr.Player.uid .. v.id, 1);
        end
    end

    local redNum_1 = 0;
    for i, v in ipairs(avatarFrameList) do
        local unlock = DataMgr.Player.avatarFrameMap[v.id] ~= nil;
        if unlock then
            local num = UnityEngine.PlayerPrefs.GetInt(DataMgr.Player.uid .. v.id);
            HeroRedDataHelper.setting_avatarFrameList[v.id] = num;
            redNum_1 = redNum_1 + num;
        else
            UnityEngine.PlayerPrefs.SetInt(DataMgr.Player.uid .. v.id, 1);
        end
    end

    if PlayerPrefs.GetInt(DataMgr.Player.uid .. "head") == 0 then
        RedMgr.Singleton:UpdateClientRedData("1116", redNum_0);
        RedMgr.Singleton:UpdateClientRedData("1118", redNum_1);
        RedMgr.Singleton:UpdateClientRedData("1115", redNum_0 + redNum_1);
    end
end

function HeroRedDataHelper.ClearAvatarFrame(type, id)
    if RedMgr.Singleton:GetRedStateById("1115") > 0 then
        PlayerPrefs.SetInt(DataMgr.Player.uid .. "head", 1);
    end

    local redNum_0 = 0;
    local redNum_1 = 0;
    if type == nil then
        for i, v in pairs(HeroRedDataHelper.setting_avatarList) do
            if v > 0 and UnityEngine.PlayerPrefs.HasKey(DataMgr.Player.uid .. i) then
                UnityEngine.PlayerPrefs.DeleteKey(DataMgr.Player.uid .. i);
                RedMgr.Singleton:UpdateClientRedData("1117_" .. i, 0);
                HeroRedDataHelper.setting_avatarList[i] = 0;
            end
        end
        for i, v in pairs(HeroRedDataHelper.setting_avatarFrameList) do
            if v > 0 and UnityEngine.PlayerPrefs.HasKey(DataMgr.Player.uid .. i) then
                UnityEngine.PlayerPrefs.DeleteKey(DataMgr.Player.uid .. i);
                RedMgr.Singleton:UpdateClientRedData("1119_" .. i, 0);
                HeroRedDataHelper.setting_avatarFrameList[i] = 0;;
            end
        end
    elseif UnityEngine.PlayerPrefs.HasKey(DataMgr.Player.uid .. id) then
        UnityEngine.PlayerPrefs.DeleteKey(DataMgr.Player.uid .. id);
        if type == 0 then
            if HeroRedDataHelper.setting_avatarList[id] == 1 then
                HeroRedDataHelper.setting_avatarList[id] = 0;
            end
            RedMgr.Singleton:UpdateClientRedData("1117_" .. id, 0);
        else
            HeroRedDataHelper.setting_avatarFrameList[id] = 0;
            RedMgr.Singleton:UpdateClientRedData("1119_" .. id, 0);
        end

        for i, v in pairs(HeroRedDataHelper.setting_avatarList) do
            if v > 0 then
                redNum_0 = redNum_0 + 1;
                break;
            end
        end

        for i, v in pairs(HeroRedDataHelper.setting_avatarFrameList) do
            if v > 0 then
                redNum_1 = redNum_1 + 1;
                break;
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("1116", redNum_0);
    RedMgr.Singleton:UpdateClientRedData("1118", redNum_1);
    RedMgr.Singleton:UpdateClientRedData("1115", redNum_0 + redNum_1);

    RedMgr.Singleton:Refresh();
    HeroRedDataHelper.UpdateSettingRed();
    RedMgr.Singleton:RefreshOtherViewModel(UIName.SystemSettingViewModel);
end

function HeroRedDataHelper.InitPlayerSkin()
    local data_playerSkins = DataMgr.Player.playerSkins;
    local redNum = 0;
    if NumTool.GetLen(data_playerSkins) == 0 then
        return
    end
    ;
    for i, v in pairs(data_playerSkins) do
        if i == "SCJ101" or i == "SCJ102" then
            return
        end
        ;
        if not v then
            local num = UnityEngine.PlayerPrefs.GetInt(DataMgr.Player.uid .. "skin" .. i) == 0 and 1 or 0;
            HeroRedDataHelper.setting_playerSkinsRedList[i] = num;
            redNum = redNum + num;
        else
            UnityEngine.PlayerPrefs.SetInt(DataMgr.Player.uid .. "skin" .. i, 1);
        end
    end
    RedMgr.Singleton:UpdateClientRedData("1113", redNum);
end

function HeroRedDataHelper.ClearPlayerSkin(id)
    if id == nil then
        for i, v in pairs(HeroRedDataHelper.setting_playerSkinsRedList) do
            UnityEngine.PlayerPrefs.SetInt(DataMgr.Player.uid .. "skin" .. i, 1);
            HeroRedDataHelper.setting_playerSkinsRedList[i] = 0;
            RedMgr.Singleton:UpdateClientRedData("1114_" .. i, 0);
        end
        RedMgr.Singleton:UpdateClientRedData("1113", 0);
    elseif not UnityEngine.PlayerPrefs.HasKey(DataMgr.Player.uid .. "skin" .. id) then
        UnityEngine.PlayerPrefs.SetInt(DataMgr.Player.uid .. "skin" .. id, 1);
        HeroRedDataHelper.setting_playerSkinsRedList[id] = 0;
        RedMgr.Singleton:UpdateClientRedData("1114_" .. id, 0);
        local redNum = 0;
        for i, v in pairs(HeroRedDataHelper.setting_playerSkinsRedList) do
            if v > 0 then
                redNum = redNum + 1;
                break;
            end
        end
        RedMgr.Singleton:UpdateClientRedData("1113", redNum);
    end
    RedMgr.Singleton:Refresh();
    HeroRedDataHelper.UpdateSettingRed();
end

function HeroRedDataHelper.InitSettingRed()
    HeroRedDataHelper.InitAvatarFrame();
    HeroRedDataHelper.InitPlayerSkin();
    HeroRedDataHelper.UpdateSettingRed();
end

function HeroRedDataHelper.UpdateSettingRed(msgCount)
    local redNum_1111 = 0;
    if PlayerPrefs.GetInt(DataMgr.Player.uid .. "head") == 0 then
        for i, v in pairs(HeroRedDataHelper.setting_avatarList) do
            if v > 0 then
                redNum_1111 = redNum_1111 + 1;
                break;
            end
        end
        if redNum_1111 < 1 then
            for i, v in pairs(HeroRedDataHelper.setting_avatarFrameList) do
                if v > 0 then
                    redNum_1111 = redNum_1111 + 1;
                    break;
                end
            end
        end
    end
    if redNum_1111 < 1 then
        for i, v in pairs(HeroRedDataHelper.setting_playerSkinsRedList) do
            if v > 0 then
                redNum_1111 = redNum_1111 + 1;
                break;
            end
        end
    end
    if msgCount ~= nil then
        redNum_1111 = redNum_1111 + msgCount
    else

        local count = LuaMgr.GetMsgCount()
        redNum_1111 = redNum_1111 + count
    end
    local monthRed = 0;

    if not LuaMgr.IsGuide() and ActivityMgr.IsCheckInMonthCurDay() then
        monthRed = 1;
    end
    local assistRed = HeroRedDataHelper.SetSettingAssistRed();
    RedMgr.Singleton:UpdateClientRedData("1066", monthRed);
    RedMgr.Singleton:UpdateClientRedData("16009", redNum_1111 + monthRed);
    RedMgr.Singleton:UpdateClientRedData("1111", redNum_1111 + monthRed + assistRed);
end

HeroRedDataHelper.SetSettingAssistRed = function()
    if not PlayerAssistMgr.IsOpen() then return 0 end;

    local assistRed_16100 = RedMgr.Singleton:CheckRedCondition("16100") and 1 or 0;
    if assistRed_16100 == 0 then

        if not IsNull(DataMgr.Player.FriendHelp) and DataMgr.Player.FriendHelp.CanCount > 0 then
            assistRed_16100 = 1;
        end
    end
    RedMgr.Singleton:UpdateClientRedData("16100", assistRed_16100);
    return assistRed_16100;
end


HeroRedDataHelper.ClearBackPackGiftRed = function(id, type)
    if id == nil then
        for key, value in pairs(HeroRedDataHelper.backPack_giftRedList) do
            UnityEngine.PlayerPrefs.SetInt(key, value)
        end
        HeroRedDataHelper.backPack_giftRedList = {}
        RedMgr.Singleton:UpdateClientRedData("1094_1001",
            ConfigHelper.GetTableLength(HeroRedDataHelper.backPack_giftRedList))
        for key, value in pairs(HeroRedDataHelper.backpack_equipRedList) do
            UnityEngine.PlayerPrefs.SetString(key, value)
        end
        HeroRedDataHelper.backpack_equipRedList = {}
        RedMgr.Singleton:UpdateClientRedData("1094_1004",
            ConfigHelper.GetTableLength(HeroRedDataHelper.backpack_equipRedList))
    else
        if type then
            if HeroRedDataHelper.backPack_giftRedList[id] ~= nil then
                UnityEngine.PlayerPrefs.SetInt(id, HeroRedDataHelper.backPack_giftRedList[id])
                HeroRedDataHelper.backPack_giftRedList[id] = nil
            end
            RedMgr.Singleton:UpdateClientRedData("1094_1001",
                ConfigHelper.GetTableLength(HeroRedDataHelper.backPack_giftRedList))
        else
            if HeroRedDataHelper.backpack_equipRedList[id] ~= nil then
                UnityEngine.PlayerPrefs.SetString(id, HeroRedDataHelper.backpack_equipRedList[id])
                HeroRedDataHelper.backpack_equipRedList[id] = nil
            end
            RedMgr.Singleton:UpdateClientRedData("1094_1004",
                ConfigHelper.GetTableLength(HeroRedDataHelper.backpack_equipRedList))
        end
        RedMgr.Singleton:RefreshOtherViewModel(UIName.BackpackViewModel)
    end
end
HeroRedDataHelper.InitTimePropRed = function()
    if FeatureManager.IsLock("1019") then return 0 end
    local redCount = 0
    for key, value in pairs(DataMgr.Player.items) do
        if value.counts ~= nil and #value.counts > 0 then
            for i = 1, #value.counts do
                if value.counts[i][2] - LuaMgr.Timestamp() < ConfigMgr.Config.constants.staminaWarning then
                    redCount = 1
                    break
                end
            end
        end
    end
    return redCount
end
HeroRedDataHelper.InitBackPackRed = function()
    if FeatureManager.IsLock("1019") then return 0 end
    local redCount = 0
    HeroRedDataHelper.backPack_giftRedList = {}
    HeroRedDataHelper.backpack_equipRedList = {}

    local config, lastNum = nil, 0
    for key, value in pairs(DataMgr.Player.items) do
        if ConfigMgr.Config.itemMap[key] ~= nil then
            config = ConfigMgr.Config.itemMap[key]
            if config.type == 1 or config.type == 8 then
                lastNum = UnityEngine.PlayerPrefs.GetInt(config.id)
                if value.count0 > lastNum then
                    HeroRedDataHelper.backPack_giftRedList[config.id] = value.count0
                    redCount = 1
                end
            end
        else
            print("itemMap表没有配置" .. key)
        end
    end
    RedMgr.Singleton:UpdateClientRedData("1094_1001", ConfigHelper.GetTableLength(HeroRedDataHelper.backPack_giftRedList))

    local lastStr = nil
    for key, value in pairs(DataMgr.Player.equipments) do
        if ConfigMgr.Config.equipments[value.equipmentId] ~= nil then
            config = ConfigMgr.Config.equipments[value.equipmentId]
            if config.rare == CharacterRare.UR then
                lastStr = UnityEngine.PlayerPrefs.GetString(key)
                if lastStr == nil or lastStr == "" then
                    HeroRedDataHelper.backpack_equipRedList[key] = key
                    redCount = 1
                end
            end
        else
            print("equipments表没有配置" .. key)
        end
    end
    RedMgr.Singleton:UpdateClientRedData("1094_1004",
        ConfigHelper.GetTableLength(HeroRedDataHelper.backpack_equipRedList))


    return redCount
end

HeroRedDataHelper.InitCharacterRed = function()
    local getValue = nil
    for key, value in pairs(DataMgr.Player.characters) do
        getValue = UnityEngine.PlayerPrefs.GetInt(key)
        if getValue == 0 then
            HeroRedDataHelper.characterRedList[key] = 1
        end
    end
end
HeroRedDataHelper.ClearCharacterRed = function(id)
    if id == nil then
        for key, value in pairs(HeroRedDataHelper.characterRedList) do
            UnityEngine.PlayerPrefs.SetInt(key, 1)
        end
        HeroRedDataHelper.characterRedList = {}
    else
        UnityEngine.PlayerPrefs.SetInt(id, 1)
        HeroRedDataHelper.characterRedList[id] = nil
    end
end

HeroRedDataHelper.InitCardPoolRed = function()
    local getValue = nil
    local nowTime = LuaMgr.Timestamp()
    for key, value in pairs(ConfigMgr.Config.cardPools) do
        if value.kind == "draw" and value.startTime < nowTime and value.endTime > nowTime
            and value.hidden == false and #value.characterShow >= 1 then
            getValue = UnityEngine.PlayerPrefs.GetString(value.id .. value.endTime)
            if getValue == "" then
                RedMgr.Singleton:UpdateClientRedData("1158", 1)
                return
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("1158", 0)
end

HeroRedDataHelper.InitEquipCountRed = function()
    local backpackCount = (ConfigMgr.Config.constants.InitVol + DataMgr.Player.bagExtraCap) * 0.1
    if ConfigHelper.GetTableLength(DataMgr.Player.equipments) > backpackCount then
        RedMgr.Singleton:UpdateClientRedData("1165", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("1165", 0)
    end
end

HeroRedDataHelper.FrushMainShopRed = function()
    if FeatureManager.IsLock("1200") then
        return;
    end

    local dataFundMissions = DataMgr.Player.fundMissions;
    local cfgFirstPay = {};
    local cfgFundPay = {}
    local cfgFund2Pay = {}
    local redFirst = 0;
    local newRedFirst = 0;
    local newRedFirst2 = 0;
    local newRedFirst3 = 0;
    local redFund = 0;
    local redFund2 = 0;
    local monthRed = 0;
    local drawRed = 0;
    local newPlayerLevelRed = 0;
    for _, v in pairs(ConfigMgr.Config.missionMap) do
        if v.type == ShopTaskType.firstPay then
            cfgFirstPay[v.id] = v;
        elseif v.type == ShopTaskType.freeFund or v.type == ShopTaskType.payFund then
            cfgFundPay[v.id] = v;
        elseif v.type == ShopTaskType.freeFund2 or v.type == ShopTaskType.payFund2 then
            cfgFund2Pay[v.id] = v;
        end
    end

    if not IsNull(DataMgr.Player.shop.record) and DataMgr.Player.shop.records["300100101"] and dataFundMissions ~= nil then
        for _, v in pairs(dataFundMissions) do
            local mission = cfgFirstPay[v.id];
            if mission ~= nil and not v.completed and v.current >= v.target then
                redFirst = 1;
                break;
            end
        end
    end











































    local monthId = "300100201";
    local vipCards = DataMgr.Player.vipCards;
    if not IsNull(vipCards) and vipCards ~= nil and vipCards[monthId] ~= nil then
        local curTime = LuaMgr.Timestamp();
        local monthInfo = vipCards[monthId];
        if curTime < monthInfo.Deadline then
            local date = os.date("*t", curTime);
            local checkTime = os.time({ year = date.year, month = date.month, day = date.day, hour = 4 })
            if monthInfo.LastDrawTime < checkTime and curTime > checkTime then
                monthRed = 1;
            end
        end
    end


    if dataFundMissions ~= nil then
        for i, v in pairs(dataFundMissions) do
            local mission = cfgFundPay[v.id];
            if mission ~= nil and not v.completed and v.current >= v.target then
                redFund = 1;
                break;
            end
        end
    end


    if dataFundMissions ~= nil then
        for i, v in pairs(dataFundMissions) do
            local mission = cfgFund2Pay[v.id];
            if mission ~= nil and not v.completed and v.current >= v.target then
                redFund2 = 1;
                break;
            end
        end
    end

    local cfgChargeMap = ConfigMgr.Config.charge;
    local cfgGiftShop = ConfigMgr.Config.shop[ShopType.Gift];
    local dataShopRecord = DataMgr.Player.shop.records;
    local chargeItem = nil;
    local giftRed = 0;
    for i, v in ipairs(cfgGiftShop.shelfs) do
        local redGiftItem = 0;
        if v.Type == 6 and v.Jump[1] == "LinearBagViewModel" then

            redGiftItem = HeroRedDataHelper.GetLinearBagRed()
        else
            for p, m in ipairs(v.goods) do
                chargeItem = cfgChargeMap[m.Id];
                if chargeItem ~= nil and not HeroRedDataHelper.IsOverdue(chargeItem) then
                    local isFree = chargeItem.UnlockLv <= DataMgr.Player.level and chargeItem.Cost.count == 0 and
                        chargeItem.ChargeGroup == ""
                    local isCanbuy = dataShopRecord[chargeItem.Id] == nil or
                        dataShopRecord[chargeItem.Id] < chargeItem.RefreshCount;
                    if isFree and isCanbuy then
                        redGiftItem = 1;
                        break
                    end
                end
            end
        end


        if v.Id == "4001007" and not HeroRedDataHelper.IsOverdue(v) and PlayerPrefs.GetInt(DataMgr.Player.uid .. "Shop_Shelf_4001007", 0) == 0 then
            redGiftItem = 1
        end
        RedMgr.Singleton:UpdateClientRedData("1146_" .. i, redGiftItem);
        giftRed = giftRed + redGiftItem
    end


    local shelf = nil
    local _cfgGiftShop = ConfigMgr.Config.shop[ShopType.Push]
    for i, v in ipairs(_cfgGiftShop.shelfs) do
        if v.Id == "3001081" then
            shelf = v;
            break;
        end
    end
    if shelf == nil then
        newPlayerLevelRed = 0
    else
        for i = 1, #shelf.goods do
            chargeItem = cfgChargeMap[shelf.goods[i].Id]
            if chargeItem ~= nil and chargeItem.ShowGroup == 0 and chargeItem.UnlockLv > 0 and DataMgr.Player.level >= chargeItem.UnlockLv then
                local isBuy = dataShopRecord[chargeItem.Id] ~= nil
                local tempSortType = UnityEngine.PlayerPrefs.GetInt(DataMgr.Player.uid .. "shop_gift" .. chargeItem.Id)
                if not isBuy and (tempSortType == nil or tempSortType == 0) then
                    newPlayerLevelRed = 1
                    break
                end
            end
        end
    end


    if not IsNull(DataMgr.Player.passesMultiple) and not IsNull(ConfigMgr.Config.PassesMap) then
        local cfgDrawPasses = nil;
        local dataDrawPasses = nil;
        for i, v in pairs(DataMgr.Player.passesMultiple) do
            if ConfigMgr.Config.PassesMap[v.id] ~= nil and ConfigMgr.Config.PassesMap[v.id].type == 3 then
                cfgDrawPasses = ConfigMgr.Config.PassesMap[v.id];
                dataDrawPasses = v;
                break;
            end
        end
        if cfgDrawPasses ~= nil and not IsNull(DataMgr.Player.passesRewardsMultiple) then
            drawRed = UnityEngine.PlayerPrefs.GetInt(DataMgr.Player.uid .. "_" .. cfgDrawPasses.Id) == 0 and 1 or 0;
            if drawRed == 0 then
                local count = DataHelper.GetItemCountById(cfgDrawPasses.Expitems);
                local drawLevel = math.floor(count / cfgDrawPasses.Exp);
                local isPay = dataDrawPasses.payRecord[cfgDrawPasses.Charge1[1]] ~= nil;
                local dataPassesRewardsMultiple = DataMgr.Player.passesRewardsMultiple[dataDrawPasses.id];
                if dataPassesRewardsMultiple ~= nil then
                    for i, v in pairs(dataPassesRewardsMultiple) do
                        if v.freeReceiveTime == 0 and drawLevel >= v.level then
                            drawRed = 1;
                            break;
                        end
                        if isPay and v.payReceiveTime == 0 and drawLevel >= v.level then
                            drawRed = 1;
                            break;
                        end
                    end
                end
            end
        end
    end


    local rechargeRed = 0
    local rechargeCfgMap = ConfigMgr.Config.AccumulatedRechargeMap
    local rechargeData = DataMgr.Player.accumulatedRecharge
    if rechargeCfgMap ~= nil then
        for k, v in pairs(rechargeCfgMap) do
            if not ((not IsNull(rechargeData.reward) and rechargeData.reward[k] ~= nil) or (not IsNull(rechargeData.order) and rechargeData.order[k] ~= nil))
                and not IsNull(rechargeData.finish) and rechargeData.finish[k] ~= nil then
                rechargeRed = rechargeRed + 1
            end
        end
    end


    local fristRed = RedMgr.Singleton:CheckRedCondition("1029") and 1 or 0;
    RedMgr.Singleton:UpdateClientRedData("1136_3001001", redFirst);
    RedMgr.Singleton:UpdateClientRedData("1136_3001003", redFund);
    RedMgr.Singleton:UpdateClientRedData("1136_3001004", redFund2);
    RedMgr.Singleton:UpdateClientRedData("1136_3001006", drawRed);
    RedMgr.Singleton:UpdateClientRedData("1136_3001002", monthRed);
    RedMgr.Singleton:UpdateClientRedData("1136_3001101", newRedFirst);
    RedMgr.Singleton:UpdateClientRedData("1136_3001102", newRedFirst2);
    RedMgr.Singleton:UpdateClientRedData("1136_3001103", newRedFirst3);
    RedMgr.Singleton:UpdateClientRedData("1136_3001081", newPlayerLevelRed);
    RedMgr.Singleton:UpdateClientRedData("1136_firstPay", redFirst + newRedFirst + newRedFirst2 + newRedFirst3);
    RedMgr.Singleton:UpdateClientRedData("1135_push",
        redFirst + redFund + newRedFirst + newRedFirst2 + newRedFirst3 + monthRed + redFund2 + drawRed +
        newPlayerLevelRed);
    RedMgr.Singleton:UpdateClientRedData("1135_gift", giftRed);
    RedMgr.Singleton:UpdateClientRedData("1135_totalRecharge", rechargeRed);
    RedMgr.Singleton:UpdateClientRedData("1029",
        redFirst + redFund + fristRed + giftRed + newRedFirst + newRedFirst2 + newRedFirst3 + monthRed + redFund2 +
        drawRed + newPlayerLevelRed + rechargeRed);
    RedMgr.Singleton:RefreshOtherViewModel(UIName.MainShopViewModel);
end

HeroRedDataHelper.GetRedPointByItemId_3301 = function()
    local serverItem = PlayerItemMgr.GetItemById("3301");
    local count = serverItem ~= nil and serverItem.count0 or 0
    return count > 0
end


HeroRedDataHelper.IsOverdue = function(charge)
    if charge == nil then
        return true;
    end

    local curTime = LuaMgr.Timestamp();
    if charge.StartTime ~= 0 and curTime < charge.StartTime then
        return true
    end
    if charge.EndTime ~= 0 and curTime >= charge.EndTime then
        return true;
    end
    return false;
end

HeroRedDataHelper.GetChargeById = function(goodsId)
    if goodsId == nil or goodsId == "" then
        return nil;
    end

    local shop = ConfigMgr.Config.shop[ShopType.Skin]
    if nil == shop then
        print('shop is nil')
        return nil;
    end

    if shop.shelfs ~= nil then
        local shelfNum = #shop.shelfs
        for k = 1, shelfNum do
            for i in pairs(shop.shelfs[k].goods) do
                local id = shop.shelfs[k].goods[i].Id;
                if id == goodsId then
                    local charge = ConfigMgr.Config.charge[id]
if charge.ClientGroup ~= 3 then
                        return charge;
                    end
                end
            end
        end
    end

    return nil;
end




HeroRedDataHelper.GetSkinByItemID = function(itemID)
    for k, v in pairs(ConfigMgr.Config.characterSkins) do
        local skins = v
        for i in pairs(skins) do
            if skins[i].mapItemsID == itemID then
                return skins[i];
            end
        end
    end

    return nil
end


HeroRedDataHelper.CheckSkinIDById = function(characterId, skinID)
    local skinsOfCharacter = DataMgr.Player.characterSkins[characterId]
    if skinsOfCharacter ~= nil then
        for i in pairs(skinsOfCharacter) do
            if skinsOfCharacter[i] == skinID then
                return true;
            end
        end
    end
    return false
end

HeroRedDataHelper.GetRemianTime = function(charge)
if charge.RefreshCycle ~= 5 then
        return ""
    end
    local remianTime = charge.EndTime - LuaMgr.Timestamp();
    if remianTime <= 0 then
        return "";
    end



local day, hour, minute = GetTimeDHM(remianTime)
    local timeStr = ""
    if IsNullOrEmpty(day) then
        timeStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10209"].NameLan), hour, minute)
    else
        timeStr = string.format(LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["10208"].NameLan), day, hour)
    end
    return timeStr
end


HeroRedDataHelper.FrushTrafficPermitNewRed = function()

    if IsNull(DataMgr.Player.passes) or IsNullOrEmpty(DataMgr.Player.passes.id) then
        return
    end

    local cfgThemePass = ConfigMgr.Config.PassesMap[DataMgr.Player.passes.id];

    if cfgThemePass == nil then
        return
    end

    local count = DataHelper.GetItemCountById("19");
    local level = math.floor(count / cfgThemePass.Exp);

    local rewardRed = 0;
    local dayRed = 0;
    local weekRed = 0;
    local archRed = 0;
    local fristRedNum = 0;

    if level < cfgThemePass.MaxLevel then
        if not IsNull(DataMgr.Player.passesMissions) then

            local weeklyMissions = DataMgr.Player.passesMissions.weekly;
            if not IsNull(weeklyMissions) then
                for i, v in pairs(weeklyMissions) do
                    if not v.completed and v.current == v.target then
                        weekRed = 1;
                        break
                    end
                end
            end

            local periodMissions = DataMgr.Player.passesMissions.period
            if not IsNull(periodMissions) then
                for i, v in pairs(periodMissions) do
                    if not v.completed and v.current == v.target then
                        archRed = 1;
                        break
                    end
                end
            end
        end


        if not IsNull(DataMgr.Player.passesRewards) then
            local isCharge = DataMgr.Player.passes.payRecord[cfgThemePass.Charge1[1]] ~= nil or
                DataMgr.Player.passes.payRecord[cfgThemePass.Charge2[1]] ~= nil;
            for i, v in pairs(DataMgr.Player.passesRewards) do
                if v.freeReceiveTime == 0 and level >= v.level then
                    rewardRed = 1;
                    break
                end
                if isCharge and v.payReceiveTime == 0 and level >= v.level then
                    rewardRed = 1;
                    break
                end
            end
        end
        fristRedNum = RedMgr.Singleton:CheckRedCondition("1131") and 1 or 0;
    end
    RedMgr.Singleton:UpdateClientRedData("1131", fristRedNum)
    RedMgr.Singleton:UpdateClientRedData("1132", rewardRed)
    RedMgr.Singleton:UpdateClientRedData("1134_1", dayRed)
    RedMgr.Singleton:UpdateClientRedData("1134_2", weekRed)
    RedMgr.Singleton:UpdateClientRedData("1134_3", archRed)
    RedMgr.Singleton:UpdateClientRedData("1133", dayRed + weekRed + archRed);
    RedMgr.Singleton:UpdateClientRedData("1129", dayRed + weekRed + archRed + rewardRed + fristRedNum);
    RedMgr.Singleton:Refresh();
end


HeroRedDataHelper.FrushTrafficPermitRed = function()

    if not DataExHelper.Check_TrafficPermintRuning() then
        return
    end

    if NumTool.GetLen(HeroRedDataHelper.trafficPermit) == 0 then
        HeroRedDataHelper.trafficPermit = {
            dayTask = {},
            weekTask = {},
            achievementTask = {},
            normalRewards = {},
            specialRewards = {},
        }
        local cfgQuestEvent = ConfigMgr.Config.questEvent;
        for i, v in pairs(cfgQuestEvent) do
            if v.groupId == 208 then
                if v.text == "PassTask1" then
                    table.insert(HeroRedDataHelper.trafficPermit.dayTask, v);
                elseif v.text == "PassTask2" then
                    table.insert(HeroRedDataHelper.trafficPermit.weekTask, v);
                elseif v.text == "PassTask3" then
                    table.insert(HeroRedDataHelper.trafficPermit.achievementTask, v);
                end
            end
            if v.groupId == 207 then
                if v.text == "Pass1" then
                    table.insert(HeroRedDataHelper.trafficPermit.normalRewards, v);
                elseif v.text == "Pass2" then
                    table.insert(HeroRedDataHelper.trafficPermit.specialRewards, v);
                end
            end
        end
    end

    local rewardRed = 0;
    local dayRed = 0;
    local weekRed = 0;
    local archRed = 0;

    local dataExQuests = DataMgr.Player.quests;

    for i, v in pairs(HeroRedDataHelper.trafficPermit.normalRewards) do
        if dataExQuests[v.id] ~= nil and dataExQuests[v.id].state == 2 then
            rewardRed = 1;
            break;
        end
    end
    if rewardRed == 0 then
        for i, v in pairs(HeroRedDataHelper.trafficPermit.specialRewards) do
            if dataExQuests[v.id] ~= nil and dataExQuests[v.id].state == 2 then
                rewardRed = 1;
                break;
            end
        end
    end
    local count = DataHelper.GetItemCountById("19");
    local level = math.floor(count / ConfigMgr.Config.constants.TrafficPermitExp[2]);
    if level < ConfigMgr.Config.constants.TrafficPermitExp[1] then








        for i, v in pairs(HeroRedDataHelper.trafficPermit.weekTask) do
            if dataExQuests[v.id] ~= nil and dataExQuests[v.id].state == 2 then
                weekRed = 1;
                break;
            end
        end

        for i, v in pairs(HeroRedDataHelper.trafficPermit.achievementTask) do
            if dataExQuests[v.id] ~= nil and dataExQuests[v.id].state == 2 then
                archRed = 1;
                break;
            end
        end
    end

    local fristRedNum = RedMgr.Singleton:CheckRedCondition("1131") and 1 or 0;
    RedMgr.Singleton:UpdateClientRedData("1131", fristRedNum)
    RedMgr.Singleton:UpdateClientRedData("1132", rewardRed)
    RedMgr.Singleton:UpdateClientRedData("1134_1", dayRed)
    RedMgr.Singleton:UpdateClientRedData("1134_2", weekRed)
    RedMgr.Singleton:UpdateClientRedData("1134_3", archRed)
    RedMgr.Singleton:UpdateClientRedData("1133", dayRed + weekRed + archRed);
    RedMgr.Singleton:UpdateClientRedData("1129", dayRed + weekRed + archRed + rewardRed + fristRedNum);
    RedMgr.Singleton:Refresh();
end


HeroRedDataHelper.SetActivityRed = function()

    local focusOnRed = 0
    if DataExHelper.Check_CDKeyRuning() then
        focusOnRed = ActivityMgr.cdKeyState == 1 and 1 or 0;
        RedMgr.Singleton:UpdateClientRedData("1015", focusOnRed);
    end

    local tourismRed = 0;
    local sysVariables, type = DataExHelper.Check_TourismRuning();
    if sysVariables ~= nil then
        local re = UnityEngine.PlayerPrefs.GetInt(DataMgr.Player.uid .. "1068");
        tourismRed = re == 0 and 1 or 0
    end
    RedMgr.Singleton:UpdateClientRedData("1068", tourismRed);
    HeroRedDataHelper.SetTiXingBoHuaRed();
    HeroRedDataHelper.SetJinYuZhuRiRed();
    HeroRedDataHelper.SetCZFLRechargeRed();
    HeroRedDataHelper.SetQianLiJiangShanRed();
    HeroRedDataHelper.SetXueJingHanLinRed();
    HeroRedDataHelper.SetWalkMountRed();
    HeroRedDataHelper.ShowFlowerRed();
    HeroRedDataHelper.NewYearRed();
    PlayerRhythmGameMgr.CheckPanleEntranceRedDot()
    PlayerSlgMgr.CheckEntranceRedAndNewDot()
    HeroRedDataHelper.SetBranchAnecdoteRed()
    HeroRedDataHelper.SetCrisisContract()
    HeroRedDataHelper.CheckInOneYearRed();
    HeroRedDataHelper.CheckIn7DaysRed();
    HeroRedDataHelper.SetZNFLRechargeRed();
end



HeroRedDataHelper.SetQianLiJiangShanRed = function()
    local qljsRed = 0;
    if DataExHelper.CommonActivityCheck(ActivityKey.qianlijiangshan) then
        local checkInList = DataExHelper.Check_ConfigQuestEventByText("checkIn7qianlijiangshan")
        for i, v in ipairs(checkInList) do
            if DataMgr.Player.quests[v.id] ~= nil and DataMgr.Player.quests[v.id].state == 2 then
                qljsRed = 1;
                break;
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("2001", qljsRed);
end


HeroRedDataHelper.SetXueJingHanLinRed = function()
    local xjhyRed = 0;
    if DataExHelper.CommonActivityCheck(ActivityKey.xuejinghanlin) then
        local checkInList = DataExHelper.Check_ConfigQuestEventByText("checkIn7Thanlinxuejingtu")
        for i, v in ipairs(checkInList) do
            if DataMgr.Player.quests[v.id] ~= nil and DataMgr.Player.quests[v.id].state == 2 then
                xjhyRed = 1;
                break;
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("5001", xjhyRed);
end


HeroRedDataHelper.SetTiXingBoHuaRed = function()
    local txbh = 0;
    if DataExHelper.CommonActivityCheck(ActivityKey.tixingbohua) then
        local checkInList = DataExHelper.Check_ConfigQuestEventByText("checkIn7Txingbohua")
        for i, v in ipairs(checkInList) do
            if DataMgr.Player.quests[v.id] ~= nil and DataMgr.Player.quests[v.id].state == 2 then
                txbh = 1;
                break;
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("4001", txbh);
end


HeroRedDataHelper.SetJinYuZhuRiRed = function()
    local txbh = 0;
    if DataExHelper.CommonActivityCheck(ActivityKey.JYZR) then
        local checkInList = DataExHelper.Check_ConfigQuestEventByText("checkIn7JinSha")
        for i, v in ipairs(checkInList) do
            if DataMgr.Player.quests[v.id] ~= nil and DataMgr.Player.quests[v.id].state == 2 then
                txbh = 1;
                break;
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("17580", txbh);
end


HeroRedDataHelper.SetCZFLRechargeRed = function()
    local txbh = 0;
    if DataExHelper.CommonActivityCheck(ActivityKey.CZFL) then
        local checkInList = DataExHelper.Check_ConfigQuestEventByText("CZFLRecharge")
        for i, v in ipairs(checkInList) do
            if DataMgr.Player.quests[v.id] ~= nil and DataMgr.Player.quests[v.id].state == 2 then
                txbh = 1;
                break;
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("17501", txbh);
end

HeroRedDataHelper.SetZNFLRechargeRed = function()
    local txbh = 0;
    if DataExHelper.CommonActivityCheck(ActivityKey.ZNFL) then
        local checkInList = DataExHelper.Check_ConfigQuestEventByText("ZNFLRecharge")
        for i, v in ipairs(checkInList) do
            if DataMgr.Player.quests[v.id] ~= nil and DataMgr.Player.quests[v.id].state == 2 then
                txbh = 1;
                break;
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("17501", txbh);
end


HeroRedDataHelper.SetWalkMountRed = function()
    if not DataExHelper.Check_WalkMount() then return end;
    local dataLottery = DataMgr.Player.lottery

    local novelRed_1, novelRed_2, novelRed_3, novelRed_4 = 0, 0, 0, 0;
    local lottery_9000 = ConfigMgr.Config.LotteryActivityMap["9000"]
    if dataLottery[lottery_9000.ID] ~= nil and #dataLottery[lottery_9000.ID] == #lottery_9000.Content and RedMgr.Singleton:CheckRedCondition("3002_9000") then
        novelRed_1 = 1;
    end
    local lottery_9001 = ConfigMgr.Config.LotteryActivityMap["9001"]
    if dataLottery[lottery_9001.ID] ~= nil and #dataLottery[lottery_9001.ID] == #lottery_9001.Content and RedMgr.Singleton:CheckRedCondition("3002_9001") then
        novelRed_2 = 1;
    end
    local lottery_9002 = ConfigMgr.Config.LotteryActivityMap["9002"]
    if dataLottery[lottery_9002.ID] ~= nil and #dataLottery[lottery_9002.ID] == #lottery_9002.Content and RedMgr.Singleton:CheckRedCondition("3002_9002") then
        novelRed_3 = 1;
    end
    local lottery_9003 = ConfigMgr.Config.LotteryActivityMap["9003"]
    if dataLottery[lottery_9003.ID] ~= nil and #dataLottery[lottery_9003.ID] == #lottery_9003.Content and RedMgr.Singleton:CheckRedCondition("3002_9003") then
        novelRed_4 = 1;
    end


    local mountRed = 0;
    local isRewardAll = true;
    local mountIds = { "9000", "9001", "9002", "9003", "9004" }
    for i, v in ipairs(mountIds) do
        local lotteryActivity = ConfigMgr.Config.LotteryActivityMap[v]
        if dataLottery == nil or dataLottery[v] == nil then
            isRewardAll = false;
            break;
        end
        if #dataLottery[v] ~= #lotteryActivity.Content then
            isRewardAll = false;
            break;
        end
    end
    if not isRewardAll then
        local cfgDayTaskData = DataExHelper.Check_ConfigQuestEventByText("walkmountTask")
        local questData = DataMgr.Player.quests;
        local curTaskList = {};
        for i, v in ipairs(cfgDayTaskData) do
            if questData[v.id] ~= nil then
                table.insert(curTaskList, v);
            end
        end
        if #curTaskList > 0 then
            for i, v in ipairs(curTaskList) do
                if questData[v.id] ~= nil and questData[v.id].state == 2 then
                    mountRed = 1;
                    break
                end
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("3002_9000", novelRed_1);
    RedMgr.Singleton:UpdateClientRedData("3002_9001", novelRed_2);
    RedMgr.Singleton:UpdateClientRedData("3002_9002", novelRed_3);
    RedMgr.Singleton:UpdateClientRedData("3002_9003", novelRed_4);
    RedMgr.Singleton:UpdateClientRedData("3003", mountRed);
    RedMgr.Singleton:UpdateClientRedData("3001", mountRed + novelRed_1 + novelRed_2 + novelRed_3 + novelRed_4);
end


HeroRedDataHelper.SetQuestionnaireRed = function()
    local redNum = 0
    local isCanRed = nil
    for key, value in pairs(ConfigMgr.Config.QuestionnaireMap) do
        isCanRed = false
        if LuaMgr.Timestamp() >= value.startTime and LuaMgr.Timestamp() < value.endTime then
            for i = 1, #NoticeMgr.questionnaireData do
                if NoticeMgr.questionnaireData[i] == key then
                    isCanRed = true
                end
            end
            if not isCanRed then
                redNum = redNum + 1
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("1016", redNum)
end


HeroRedDataHelper.ShowFlowerRed = function()
    if not DataExHelper.Check_FlowerRuning() then return end
    local cfgTask = DataExHelper.Check_ConfigQuestEventByText("task")
    local cfgSkin = DataExHelper.Check_ConfigQuestEventByText("skin")
    local dataExQuests = DataMgr.Player.quests;
    local taskRed = 0;
    local skinRed = 0;


    for i, v in ipairs(cfgTask) do
        local re = dataExQuests[v.id]
        if re ~= nil then
            if re.state == 2 then
                taskRed = 1;
                break;
            end
        end
    end

    for i, v in ipairs(cfgSkin) do
        local re = dataExQuests[v.id]
        if re ~= nil then
            if v.eventType == 104 then
                if re.state == 2 then
                    skinRed = 1;
                    break;
                end
            else
                if re.state == 1 then
                    if v.cost ~= nil then
                        local myEnough = true;
                        for _i, _v in ipairs(v.cost) do
                            local myCount = DataHelper.GetItemCountById(_v.id)
                            if myCount < _v.count then
                                myEnough = false;
                                break;
                            end
                            if myEnough then
                                skinRed = 1;
                                break;
                            end
                        end
                    end
                end
            end
        end
    end

    RedMgr.Singleton:UpdateClientRedData("1071", skinRed);
    RedMgr.Singleton:UpdateClientRedData("1072", taskRed);
    local flowerRed = skinRed + taskRed;
    RedMgr.Singleton:UpdateClientRedData("1069", flowerRed);
end



HeroRedDataHelper.LuckyDrawRed = function()

    if DataExHelper.Check_LuckDrawRunning() then
        local red = 0;
        local cfgDrawActivityMap = {};
        local activityMap = ConfigMgr.Config.DrawActivityMap;
        for i, v in pairs(activityMap) do
            if v.Group == "1" then
                cfgDrawActivityMap[i] = v;
            end
        end
        local drawId = DataMgr.Player.drawRewardProgress["1"];
        local drawRewardRecords = DataMgr.Player.drawRewardRecords
        if drawId == nil then
            drawId = "1001";
        end
        local drawActivity = cfgDrawActivityMap[drawId];
        local myCount = DataHelper.GetItemCountById(drawActivity.Consume[1].id);
        local isSellOut = true;
        for i, v in ipairs(drawActivity.Content) do
            local key = drawId .. "_" .. v;
            if drawRewardRecords[key] == nil or (drawRewardRecords[key] ~= nil and drawRewardRecords[key] < ConfigMgr.Config.DrawMap[v].Time) then
                isSellOut = false;
            end
        end
        if not isSellOut and myCount >= drawActivity.Consume[1].count then
            red = 1;
        end
        RedMgr.Singleton:UpdateClientRedData("1086", red);
    end
end

HeroRedDataHelper.SnackOnLineRed = function()

    local snackRed = 0
    if DataExHelper.Check_SnacksOnLineRunning() then
        local cfgOnLineReward = ConfigMgr.Config.onlineReward;
        if (#cfgOnLineReward == 0) then
            return
        end
        local dataOnlineReward = DataMgr.Player.onlineReward;
        if (dataOnlineReward.RewardID == 0) then
            return;
        end
        local curTimeReward;
        local dayReards = cfgOnLineReward[dataOnlineReward.Days];
        local len = #dayReards;
        for i = 1, len do
            local reward = dayReards[i];
            if (reward.ID == dataOnlineReward.RewardID) then
                curTimeReward = reward;
                break;
            end
        end
        if (curTimeReward == nil) then
            return;
        end

        local snacksTimer = dataOnlineReward.EndTime - LuaMgr.Timestamp();
        if snacksTimer <= 0 then
            snackRed = 1;
        end
    end
    RedMgr.Singleton:UpdateClientRedData("1190", snackRed);
end



HeroRedDataHelper.NewYearRed = function()
    local groupId = ActivityMgr.groupKeyList[ActivityKey.newYear]
    local dataGroup_flower = DataMgr.Player.variables[groupId]
    if dataGroup_flower == nil then
        return
    end
    local cfgCheckInQuest = DataExHelper.Check_ConfigQuestEventByText("NewYear")
    table.sort(cfgCheckInQuest, function(a, b) return tonumber(a.id) < tonumber(b.id) end)

    local dataQuests = DataMgr.Player.quests
    local Netdata = {}
    for key, value in ipairs(cfgCheckInQuest) do
        table.insert(Netdata, dataQuests[value.id])
    end
    if #Netdata == 0 then
        return
    end
    local startTime = dataGroup_flower.startTime
    local NowTime = LuaMgr.Timestamp()
    local currentDayInex = math.floor((NowTime - startTime) / 86400) + 1
    if Netdata[currentDayInex] ~= nil and Netdata[currentDayInex].state == 3 then
        RedMgr.Singleton:UpdateClientRedData("1088", 0);
    else
        RedMgr.Singleton:UpdateClientRedData("1088", 1);
    end
end

local IsCompleteNovel = function(novelId)
    local completeNovels = DataMgr.Player.completedChapters;
    for i, v in ipairs(completeNovels) do
        if v == novelId then
            return true;
        end
    end
    return false;
end



HeroRedDataHelper.FrushTravelRed = function(isMain)
    if not DataExHelper.Check_TravelRunning() then
        return 0;
    end
    local novelRed = 0;
    local taskRed = 0;
    local letterRed = 0;
    local levelRed = 0;
    local shopRed = 0;
    local bossRed = 0;
    local actTravel = nil;
    local actMap = ConfigMgr.Config.activityMapList
    local isLetterComming = false;
    for i, v in ipairs(actMap) do
        if v.area == "Travel" then
            actTravel = v;
        end
    end
    local curTime = LuaMgr.Timestamp();
    local endTime = actTravel.closeDate;
    if endTime - curTime > 0 then
        local dataQuests = DataMgr.Player.quests;

        local cfgNovel = {};
        local mapEventList = ConfigMgr.Config.activityMapEventList
        for i, v in ipairs(mapEventList) do
            if v.area == "Travel" and v.type == 1 then
                table.insert(cfgNovel, v);
            end
        end
        table.sort(cfgNovel, function(a, b) return a.id < b.id end)
        local myCount = NumTool.GetLen(DataMgr.Player.postcards)
        for i, v in ipairs(cfgNovel) do
            local unlockValue = v.unlockParam == "" and 0 or tonumber(v.unlockParam);
            if not IsCompleteNovel(v.eventParam) and myCount >= unlockValue then
                novelRed = 1;
                break
            end
        end


        local cfgTask = DataExHelper.Check_ConfigQuestEventByText("Traveltask");
        for i, v in ipairs(cfgTask) do
            if dataQuests[v.id] ~= nil and dataQuests[v.id].state == 2 then
                taskRed = 1;
                break;
            end
        end

        local dataTravel = DataMgr.Player.travel;
        if IsNull(dataTravel.PendingRewards) or dataTravel.PendingRewards == nil then
            letterRed = 0;
        else
            for i, v in ipairs(dataTravel.PendingRewards) do
                if v.FinishTime <= curTime then
                    letterRed = 1;
                    isLetterComming = true;
                    break;
                end
            end
            local curTravelCount = DataMgr.Player.dailyCount.TravelTimes;
            curTravelCount = curTravelCount == nil and 0 or curTravelCount;
            local maxTravelCount = ConfigMgr.Config.TravelConstants.TravelTimes;
            if dataTravel.FinishTime <= curTime and curTravelCount < maxTravelCount then
                letterRed = 1;
            end
            if letterRed == 1 then

                local cfgBento = {};
                local myBentoCount = 0;

                for i, v in pairs(ConfigMgr.Config.itemMap) do
                    if v.type == 22 then
                        table.insert(cfgBento, v.id);
                    end
                end
                for i, v in pairs(cfgBento) do
                    myBentoCount = myBentoCount + DataHelper.GetItemCountById(v);
                end
                letterRed = myBentoCount > 0 and 1 or 0;
            end
        end

        local cfgShop = DataExHelper.Check_ConfigQuestEventByText("Travelshop");
        for i, v in ipairs(cfgShop) do
            if dataQuests[v.id] ~= nil and v.cost[1].count == 0 and dataQuests[v.id].state ~= 3 then
                shopRed = 1;
                break;
            end
        end

        if DataMgr.Player.travel.BattleBossCount > 0 and RedMgr.Singleton:CheckRedCondition("6001") then
            bossRed = 1;
        end


        levelRed = DataMgr.Player.travel.TotalCount > 0 and 1 or 0;

        local tipType = nil;
        local travelTimes = DataMgr.Player.dailyCount.TravelTimes == nil and 0 or DataMgr.Player.dailyCount.TravelTimes
        if not IsNullOrEmpty(dataTravel.DungeonIdMeet) and dataTravel.DungeonIdMeetTime <= curTime then
            tipType = "22"
        elseif isLetterComming then
            tipType = "24";
        elseif travelTimes < ConfigMgr.Config.TravelConstants.TravelTimes then
            tipType = "23"
            math.randomseed(curTime)
            local index = math.random(100);
            if index > ConfigMgr.Config.TravelConstants.TipsShowOdds then
                tipType = nil;
            end
        end
        if isMain and tipType ~= nil then
            if LuaMgr.IsPanelOpen("MainPageViewModel") then
                LuaMgr.ShowLuaPanel(UIName.TravelTipViewModel, tipType);
            end
        end
    end

    RedMgr.Singleton:UpdateClientRedData("1142", taskRed);
    RedMgr.Singleton:UpdateClientRedData("1143", novelRed);
    RedMgr.Singleton:UpdateClientRedData("1144", letterRed + levelRed);
    RedMgr.Singleton:UpdateClientRedData("1145", levelRed);
    RedMgr.Singleton:UpdateClientRedData("1153", shopRed);
    RedMgr.Singleton:UpdateClientRedData("6001", bossRed);
    RedMgr.Singleton:UpdateClientRedData("1141", taskRed + letterRed + novelRed + shopRed + levelRed + bossRed);
    return taskRed + letterRed + novelRed;
end


HeroRedDataHelper.FrushDailyFBRed = function()
























end


HeroRedDataHelper.MoreModCheckPassTeaching = function()
    local cfgTeachingList = {}
    for i, v in pairs(ConfigMgr.Config.moreModMap) do
        if v.Group == "JX" then
            table.insert(cfgTeachingList, v);
        end
    end
    table.sort(cfgTeachingList, function(a, b) return a.Id < b.Id end)

    local unlockId = cfgTeachingList[#cfgTeachingList].DungeonIDs[1];
    local dataDungeonRecords = DataMgr.Player.dungeonRecords;
    local isPass = unlockId == "" or
        (dataDungeonRecords[unlockId] ~= nil and dataDungeonRecords[unlockId].completeCount > 0);
    return isPass, unlockId
end

HeroRedDataHelper.FrushMoreModRed = function()

    local isPass, id = HeroRedDataHelper.MoreModCheckPassTeaching();
    local redCount = HeroRedDataHelper.FrushMoreModTimeRed()
    if FeatureManager.IsLock("1080") or not isPass then
        RedMgr.Singleton:UpdateClientRedData("1147", 0);
        if FeatureManager.IsLock("1080") == false then
            RedMgr.Singleton:UpdateClientRedData("1147_1", redCount)
        else
            RedMgr.Singleton:UpdateClientRedData("1147_1", 0)
        end
        HeroRedDataHelper.UpdateClientMoreRed(redCount)
        return redCount
    end

    local taskRed = 0;
    local dataMission = DataMgr.Player.missions["weekly"]["106"];
    local cfgTask = {};
    for i, v in pairs(ConfigMgr.Config.missionMap) do
        if v.tab == "weekly" and v.type == "106" then
            table.insert(cfgTask, v);
        end
    end
    if #cfgTask > 0 then
        local taskItem = nil;
        for i, v in ipairs(cfgTask) do
            taskItem = dataMission[v.id];
            if taskItem ~= nil then
                if not taskItem.completed and taskItem.current >= taskItem.target then
                    taskRed = 1;
                end
            end
        end
    end
    local timeRedCount = 0
    if FeatureManager.IsLock("1080") == false then
        timeRedCount = HeroRedDataHelper.FrushMoreModTimeRed()
    end
    RedMgr.Singleton:UpdateClientRedData("1147", taskRed);
    RedMgr.Singleton:UpdateClientRedData("1147_1", timeRedCount)
    HeroRedDataHelper.UpdateClientMoreRed(redCount)
    return taskRed + timeRedCount;
end


HeroRedDataHelper.UpdateClientMoreRed = function(redCount)
    if HeroRedDataHelper.MoreModCheckPassTeaching() == true then
        RedMgr.Singleton:UpdateClientRedData("15111", 0);
        RedMgr.Singleton:UpdateClientRedData("15111_1", redCount);
    else
        RedMgr.Singleton:UpdateClientRedData("15111", redCount);
        RedMgr.Singleton:UpdateClientRedData("15111_1", 0);
    end
end

HeroRedDataHelper.FrushMoreModTimeRed = function()
    if FeatureManager.IsLock("1080") then
        return 0
    end
    local dataTable = DataMgr.Player.missions["weekly"]["106"]
    local startTime = 0
    local endTime = 0
    local curTime = LuaMgr.Timestamp()
    for key, value in pairs(dataTable) do
        if curTime >= value.createTime and curTime < value.expiredTime then
            startTime = value.createTime
            endTime = value.expiredTime
            break
        end
    end
    if startTime == 0 or endTime == 0 then
        return 0
    end
    local deltaTimeStart = GetTimeDay(curTime - startTime)
    local deltaTimeEnd = GetTimeDay(endTime - curTime)
    local redID = "15111"
    if HeroRedDataHelper.MoreModCheckPassTeaching() == true then
        redID = "15111_1"
    end
    if deltaTimeStart == 1 and RedMgr.Singleton:CheckRedCondition(redID) == true then
        return 1
    elseif (deltaTimeEnd == 1 or deltaTimeEnd == 3) and RedMgr.Singleton:CheckRedCondition(redID) == true then
        return 1
    end
    return 0
end

HeroRedDataHelper.GetTrainingRewardRed = function()
    local cfgTrainingSeries = ConfigMgr.Config.TrainingSeriesMap

    local curTimestamp = LuaMgr.Timestamp();
    local totalDungeonRedCount = 0
    local totalStarRedCount = 0
    for k, v in pairs(cfgTrainingSeries) do
        local endTimeStatus = v.EndTime > curTimestamp
        if v.EndTime == 0 then
            endTimeStatus = true
        end
        if v.OpenTime < curTimestamp and endTimeStatus then
            totalDungeonRedCount = totalDungeonRedCount + HeroRedDataHelper.GetTrainingDungeonRewardRed(k)
            totalStarRedCount = totalStarRedCount + HeroRedDataHelper.GetTrainingStarRewardRed(k)
        end
    end

    return totalDungeonRedCount, totalStarRedCount
end

HeroRedDataHelper.GetTrainingDungeonRewardRed = function(seriesID)
    local trainingAwardCfgs = ConfigMgr.Config.TrainingAwardMap
    local trainingRecords = DataMgr.Player.TrainingRecords
    local trainingRewards = DataMgr.Player.TrainingRewards

    local redCount = 0
    for k, v in pairs(trainingAwardCfgs) do
        if v.SeriesId == seriesID and trainingRewards[k] == nil and trainingRecords[tostring(v.Parameter)] then
            redCount = redCount + 1
        end
    end
    return redCount
end

HeroRedDataHelper.GetTrainingStarRewardRed = function(seriesID)
    local trainingAwardCfgs = ConfigMgr.Config.TrainingAwardMap
    local cfgTrainingDungeonGroups = ConfigMgr.Config.TrainingCpointMap
    local trainingRecords = DataMgr.Player.TrainingRecords
    local trainingRewards = DataMgr.Player.TrainingRewards

    local totalGetStarCount = 0
    for k, v in pairs(trainingRecords) do
        local dungeonGroupCfg = cfgTrainingDungeonGroups[k]
        if dungeonGroupCfg.SeriesId == seriesID then
            totalGetStarCount = totalGetStarCount + v.StarCount
        end
    end

    local redCount = 0
    for k, v in pairs(trainingAwardCfgs) do
        if v.SeriesId == seriesID and trainingRewards[k] == nil and totalGetStarCount >= v.Parameter then
            redCount = redCount + 1
        end
    end
    return redCount
end

HeroRedDataHelper.CheckTrainingSeries1Red = function()
    local activityGroupTable = nil
    for _, v in pairs(ConfigMgr.Config.activityGroup) do
        if v.key == ActivityKey.TrainingSeries1 then
            activityGroupTable = v
            break
        end
    end

    if activityGroupTable == nil then
        return 0
    end

    if not ActivityMgr.ActivityCanFinish(ActivityKey.TrainingSeries1) then
        RedMgr.Singleton:UpdateClientRedData(activityGroupTable.RedId, 0)
        return 0
    end

    local seriesID = "20003"
    local redNum = 0
    if HeroRedDataHelper.GetTrainingDungeonRewardRed(seriesID) > 0
        or HeroRedDataHelper.GetTrainingStarRewardRed(seriesID) > 0 then
        redNum = 1
    end

    RedMgr.Singleton:UpdateClientRedData(activityGroupTable.RedId, redNum)
    return redNum
end

HeroRedDataHelper.SetCheDanJiRed = function()
    local redPointMap = ConfigMgr.Config.redPointMap;
    local redNum = 0;

    if redPointMap["1157"] ~= nil and redPointMap["1157"].Chick == 1 then
        redNum = 0;
        local dataTravel = DataMgr.Player.travel;
        local rewardsList = {}
        if not IsNull(dataTravel.PendingRewards) and dataTravel.PendingRewards ~= nil and #dataTravel.PendingRewards > 0 then
            local curTimestamp = LuaMgr.Timestamp();
            for i, v in ipairs(dataTravel.PendingRewards) do
                if v.FinishTime <= curTimestamp then
                    table.insert(rewardsList, v.Rewards);
                end
            end
        end
        redNum = #rewardsList >= 3 and 1 or 0;
        RedMgr.Singleton:UpdateClientRedData("1157", redNum);
    end

    if redPointMap["1166"] ~= nil and redPointMap["1166"].Chick == 1 then
        redNum = DataHelper.GetItemCountById("4101") > 500 and 1 or 0;
        if redNum == 1 and not HeroRedDataHelper.CheckAreaShopRed() then
            redNum = 0
        end
        RedMgr.Singleton:UpdateClientRedData("1166", redNum);
    end

    if redPointMap["1167"] ~= nil and redPointMap["1167"].Chick == 1 then
        redNum = DataHelper.GetItemCountById("16") > 500 and 1 or 0;
        RedMgr.Singleton:UpdateClientRedData("1167", redNum);
    end

    if redPointMap["1168"] ~= nil and redPointMap["1168"].Chick == 1 then
        redNum = DataHelper.GetItemCountById("11") > 500 and 1 or 0;
        RedMgr.Singleton:UpdateClientRedData("1168", redNum);
    end

    if redPointMap["1170"] ~= nil and redPointMap["1170"].Chick == 1 then
        redNum = 0;
        local dungeonRecords = DataMgr.Player.dungeonRecords;
        if dungeonRecords["M100012"] ~= nil and dungeonRecords["M100012"].completeCount > 0 then
            if dungeonRecords["J100001"] == nil then
                redNum = 1;
            end
        end
        RedMgr.Singleton:UpdateClientRedData("1170", redNum);
    end

    if redPointMap["1171"] ~= nil and redPointMap["1171"].Chick == 1 then
        redNum = 0;
        local dungeonRecords = DataMgr.Player.dungeonRecords;
        if dungeonRecords["M300003"] ~= nil and dungeonRecords["M300003"].completeCount > 0 then
            if PlayerPrefs.GetInt("zhedanji_1171") == 0 then
                local modDungeous = DataMgr.Player.moreModData.Dungeons;
                if modDungeous ~= nil and NumTool.GetLen(modDungeous) > 0 then
                    local re = true;
                    for i, v in pairs(modDungeous) do
                        if dungeonRecords[v.Dungeon] ~= nil then
                            PlayerPrefs.SetInt("zhedanji_1171", 1);
                            re = false;
                            break;
                        end
                    end
                    redNum = re and 1 or 0;
                else
                    redNum = 1
                end
            end
        end
        RedMgr.Singleton:UpdateClientRedData("1171", redNum);
    end
end

local function GetActivityMission(key, tabID)
    local missions = DataMgr.Player.activityMissions[key];
    if (missions ~= nil) then
        local len = #missions;
        if (len > 0) then
            local mission;
            for i = 1, len do
                mission = missions[i];
                if (mission.tabId == tabID) then
                    return mission;
                end
            end
        end
    end
    return nil;
end

HeroRedDataHelper.SetJoinJobRed = function()
    if not DataExHelper.Check_JobInRunning() then
        return
    end
    ;

    local taskEightRed = 0;
    if DataMgr.Player.missions["8dayPhase"] == nil then
        return 0
    end
    local map = DataMgr.Player.missions["8dayPhase"]["502"];
    for _, v in pairs(map) do
        if (not v.completed and v.current == v.target) then
            taskEightRed = 1;
            break
        end
    end
    local task8Missions = DataMgr.Player.activityMissions["8day"];
    if (task8Missions ~= nil) then
        local missions = DataMgr.Player.missions;
        local cfgTaskValues = ConfigMgr.Config.taskOpen;
        for _, v in pairs(cfgTaskValues) do
            local mission = GetActivityMission("8day", v.tabID);
            if (mission ~= nil and mission.unlock) then
                map = missions[v.tabID]["501"];
                if (map ~= nil) then
                    for _, v in pairs(map) do
                        if (not v.completed and v.current == v.target) then
                            taskEightRed = 1;
                            break
                        end
                    end
                end
            end
        end
    end

    local checkInRed = 0;
    if (ActivityMgr.IsPopSignIn()) then
        checkInRed = 1;
    end

local JC_red = 0;
local JJ_red = 0;
local SZ_red = 0;
    local cfgUnlockCondition = ConfigMgr.Config.constants.UnlockTeach;
    local Job1Events, Job2Events = {}, {}
    for i, v in pairs(ConfigMgr.Config.areaEvents) do
        if v.category == 8 then
            table.insert(Job1Events, v);
        elseif v.category == 9 then
            table.insert(Job2Events, v);
        end
    end
    if RedMgr.Singleton:CheckRedCondition("1174_1") then
        if cfgUnlockCondition[1] == "0" or DataMgr.Player.dungeonRecords[cfgUnlockCondition[1]] ~= nil
            and DataMgr.Player.dungeonRecords[cfgUnlockCondition[1]].completeCount > 0 then
            for i, v in ipairs(Job1Events) do
                if DataMgr.Player.dungeonRecords[v.id] == nil or DataMgr.Player.dungeonRecords[v.id].completeCount == 0 then
                    JC_red = 1
                    break
                end
            end
        end
    end











    if RedMgr.Singleton:CheckRedCondition("1174_3") then
        if cfgUnlockCondition[3] == "0" or DataMgr.Player.dungeonRecords[cfgUnlockCondition[3]] ~= nil
            and DataMgr.Player.dungeonRecords[cfgUnlockCondition[3]].completeCount > 0 then
            local dungeonRecords = DataMgr.Player.dungeonRecords
            for i, v in pairs(ConfigMgr.Config.dungeonMap) do
                if v.type == 3 and (dungeonRecords[v.id] == nil or dungeonRecords[v.id].completeCount == 0) then
                    SZ_red = 1
                    break
                end
            end
        end
    end

    local novelBarList = DataExHelper.EX_GetGroupListByArea("entry");
    local novelDataMap = DataExHelper.EX_GetEventMapByArea("entry")
    local novelRed = 0
    if DataMgr.Player.activityMaps["entry"] ~= nil then
        local dataEntryEvents = DataMgr.Player.activityMaps["entry"].activityEvents;
        for i, v in ipairs(novelBarList) do
            local redId = 0;
            if v.unlockParam == "" or DataMgr.Player.dungeonRecords[v.unlockParam] ~= nil and DataMgr.Player.dungeonRecords[v.unlockParam].completeCount > 0 then
                local novelList = novelDataMap[v.id]
                for p, m in ipairs(novelList) do
                    local unLock = m.unlockParam == "" or
                        dataEntryEvents[m.unlockParam] ~= nil and dataEntryEvents[m.unlockParam].complete
                    local isCan = unLock and
                        DataHelper.GetItemCountById(m.itemExpend[1].id) >= tonumber(m.itemExpend[1].count)
                    local isFirst = isCan and (dataEntryEvents[m.id] == nil or not dataEntryEvents[m.id].complete)
                    if isFirst then
                        redId = 1;
                    end
                end
            end
            RedMgr.Singleton:UpdateClientRedData("1172_" .. i, redId);
            novelRed = novelRed + redId
        end
    end
    RedMgr.Singleton:UpdateClientRedData("1174_1", JC_red);

    RedMgr.Singleton:UpdateClientRedData("1174_3", SZ_red);
    RedMgr.Singleton:UpdateClientRedData("1174", JC_red + JJ_red + SZ_red);

    RedMgr.Singleton:UpdateClientRedData("1172", novelRed);
    RedMgr.Singleton:UpdateClientRedData("1017", checkInRed);
    RedMgr.Singleton:UpdateClientRedData("1176", taskEightRed + checkInRed + novelRed + JC_red + SZ_red);
end


HeroRedDataHelper.SetAreaTeachingRed = function()

local JC_red = 0;
local JJ_red = 0;
local JY_red = 0;
    local cfgUnlockCondition = ConfigMgr.Config.constants.UnlockTeach;
    local Job1Events, Job2Events, Job3Events = {}, {}, {}
    for i, v in pairs(ConfigMgr.Config.areaEvents) do
        if v.category == 8 then
            table.insert(Job1Events, v);
        elseif v.category == 9 then
            table.insert(Job2Events, v);
        elseif v.category == 10 then
            table.insert(Job3Events, v);
        end
    end
    if RedMgr.Singleton:CheckRedCondition("1174_1") then
        if cfgUnlockCondition[1] == "0" or DataMgr.Player.dungeonRecords[cfgUnlockCondition[1]] ~= nil
            and DataMgr.Player.dungeonRecords[cfgUnlockCondition[1]].completeCount > 0 then
            for i, v in ipairs(Job1Events) do
                if DataMgr.Player.dungeonRecords[v.id] == nil or DataMgr.Player.dungeonRecords[v.id].completeCount == 0 then
                    JC_red = 1
                    break
                end
            end
        end
    end






















    RedMgr.Singleton:UpdateClientRedData("1174_1", JC_red);


    RedMgr.Singleton:UpdateClientRedData("1401", JC_red + JJ_red + JY_red);
end


HeroRedDataHelper.GetSawPuzzleUnlock = function(unlockList)
    local completeCount = 0;
    local dataQuests = DataMgr.Player.quests;
    for i, v in ipairs(unlockList) do
        if v == "0" then
            completeCount = completeCount + 1;
        else
            if dataQuests[v] ~= nil and dataQuests[v].state == 3 then
                completeCount = completeCount + 1;
            end
        end
    end
    return completeCount >= #unlockList;
end



HeroRedDataHelper.SetSawPuzzleRed = function()
    local red = 0;
    if DataExHelper.CommonActivityCheck(ActivityKey.sawpuzzle) then
        local isShow = RedMgr.Singleton:CheckRedCondition("7001")
        if isShow then
            for i, v in pairs(ConfigMgr.Config.ActivityPuzzleMap) do
                local unlock = HeroRedDataHelper.GetSawPuzzleUnlock(v.unlock)
                if unlock and DataMgr.Player.puzzleActStatus[v.id] == nil then
                    red = 1;
                    break;
                end
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("7001", red);
end


HeroRedDataHelper.SetChanganRed = function()
    if not DataExHelper.Check_ChanganRunning() then return end;
    local dataQuests = DataMgr.Player.quests;
    ChanganMgr.InitData();
    local levelGroup1 = ChanganMgr.changanMapEventList[1]
    local dgRcds = DataMgr.Player.dungeonRecords;

    local taskRed = 0;
    local taskList = DataExHelper.Check_ConfigQuestEventByText("CAtask")
    for i, v in ipairs(taskList) do
        if dataQuests[v.id] ~= nil and dataQuests[v.id].state == 2 then
            taskRed = 1
            break
        end
    end



    local apprasialRed = 0;
    if dgRcds[levelGroup1[1].eventParam] ~= nil and dgRcds[levelGroup1[1].eventParam].completeCount > 0 then
        local appraisalList = DataExHelper.Check_ConfigQuestEventByText("CAappraisal")
        local costItem = appraisalList[1].cost[1];
        local myCount = DataHelper.GetItemCountById(costItem.id);
        for i, v in ipairs(appraisalList) do
            if dataQuests[v.id] ~= nil and dataQuests[v.id].state ~= 3 then
                apprasialRed = 1
                break
            end
        end
        if apprasialRed == 1 and myCount < costItem.count then
            apprasialRed = 0
        end
    end


    local rouleRed = 0
    if dgRcds[levelGroup1[2].eventParam] ~= nil and dgRcds[levelGroup1[2].eventParam].completeCount > 0 then
        local drawId = "2001"
        local groupId = "2"
        local cfgDrawMap = ConfigMgr.Config.DrawMap;
        local dataDrawProgress = DataMgr.Player.drawRewardProgress;
        local dataDrawRecords = DataMgr.Player.drawRewardRecords;
        if dataDrawProgress[groupId] ~= nil then
            drawId = dataDrawProgress[groupId]
        end
        local curDrawActivity = nil;
        local activityMap = ConfigMgr.Config.DrawActivityMap;
        for i, v in pairs(activityMap) do
            if v.Group == groupId and v.ID == drawId then
                curDrawActivity = v;
            end
        end
        if curDrawActivity ~= nil then
            for i, v in ipairs(curDrawActivity.Content) do
                local count = cfgDrawMap[v].Time;
                local hasBuyCount = 0
                if not IsNullOrEmpty(dataDrawRecords) and dataDrawRecords ~= nil then
                    local key = string.format("%s_%s", drawId, v);
                    hasBuyCount = dataDrawRecords[key];
                end
                if hasBuyCount == nil or hasBuyCount < count then

                    rouleRed = 1
                    break
                end
            end
            myCount = DataHelper.GetItemCountById(curDrawActivity.Consume[1].id)

            if rouleRed == 1 and myCount < curDrawActivity.Consume[1].count then
                rouleRed = 0
            end
        end
    end


    local dayShopRed = 0
    local curTime = LuaMgr.Timestamp();
    local date = os.date("*t", curTime);
    local startTime = os.time({ year = date.year, month = date.month, day = date.day, hour = 8, min = 0, sec = 00 });
    local endTime = os.time({ year = date.year, month = date.month, day = date.day, hour = 22, min = 0, sec = 00 });
    if curTime >= startTime and curTime < endTime then
        dayShopRed = RedMgr.Singleton:CheckRedCondition("1181") and 1 or 0
    end

    RedMgr.Singleton:UpdateClientRedData("1178", taskRed);
    RedMgr.Singleton:UpdateClientRedData("1179", apprasialRed);
    RedMgr.Singleton:UpdateClientRedData("1180", rouleRed);
    RedMgr.Singleton:UpdateClientRedData("1181", dayShopRed);
    RedMgr.Singleton:UpdateClientRedData("1177", dayShopRed + rouleRed + apprasialRed + taskRed);
end


function HeroRedDataHelper.InitCanFinishRedData()
    for key, value in pairs(ConfigMgr.Config.activityGroup) do
if ActivityCheckCanFinishKey[value.key] ~= nil then
if ActivityMgr.ActivityCanFinish(value.key) then
                RedMgr.Singleton:UpdateClientRedData(value.RedId, 1)
            else
                RedMgr.Singleton:UpdateClientRedData(value.RedId, 0)
            end
        end
    end
end

HeroRedDataHelper.SetHeroBranchRed = function()
    local redCount = 0
    if not DataExHelper.Check_HeroBranchActivity() then
        redCount = 0
    else
        local groupId = ActivityMgr.groupKeyList["Story1"]
        local typeId = tonumber(string.sub(groupId, 7))
        local questEvents = DataExHelper.Check_ConfigQuestEventByGroupId(typeId)
        local tempData = nil
        for i = 1, #questEvents do
            tempData = DataMgr.Player.quests[questEvents[i].id]
            if not TableIsNull(tempData) then
                if tempData.state == 2 and questEvents[i].progress == tempData.progress then
                    redCount = 1
                    break
                end
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("1191", redCount)
    return redCount
end

HeroRedDataHelper.SetAnniversaryRed = function()
    local isShow = DataExHelper.CommonActivityCheck(ActivityKey.Anniversary)
    if not isShow then
        return
    end
    isShow = RedMgr.Singleton:CheckRedCondition("16080")
    if isShow then
        RedMgr.Singleton:UpdateClientRedData("16080", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("16080", 0)
    end
end

HeroRedDataHelper.SetAnniversaryEntityFeedRed = function(frush)
    local isShow = DataExHelper.CommonActivityCheck(ActivityKey.YearGift1)
    if not isShow then
        return
    end
    local redPointID = "16120"
    isShow = RedMgr.Singleton:CheckRedCondition(redPointID)
    if isShow then
        RedMgr.Singleton:UpdateClientRedData(redPointID, 1)
    else
        RedMgr.Singleton:UpdateClientRedData(redPointID, 0)
    end
    if frush == true then
        RedMgr.Singleton:FrushRedCondition(redPointID)
    end
end

HeroRedDataHelper.SetAnnualReportRed = function()
    local isShow = DataExHelper.CommonActivityCheck(ActivityKey.AnnualReport)
    if not isShow then
        return
    end
    isShow = RedMgr.Singleton:CheckRedCondition("17652")
    if isShow then
        RedMgr.Singleton:UpdateClientRedData("17652", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("17652", 0)
    end
end

HeroRedDataHelper.SetYaoQingBackRed = function()
    local isShow = DataExHelper.CommonActivityCheck(ActivityKey.YaoQingBack)
    if not isShow then
        return
    end
    isShow = RedMgr.Singleton:CheckRedCondition("16891")
    if isShow then
        RedMgr.Singleton:UpdateClientRedData("16891", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("16891", 0)
    end
end

HeroRedDataHelper.GetTurnOverMissionRed = function()
    local isShow = DataExHelper.CommonActivityCheck(ActivityKey.NewCelebration)
    if not isShow then
        return 0
    end
    local questEvent = DataExHelper.Check_ConfigQuestEventByText("CelebrationTask")
    if TableIsNull(questEvent) then
        return 0
    end
    local tempData = nil
    for i = 1, #questEvent do
        tempData = DataMgr.Player.quests[questEvent[i].id]
        if not TableIsNull(tempData) then
            if tempData.state == 2 and tempData.progress >= questEvent[i].progress then
                return 1
            end
        end
    end
    return 0
end


HeroRedDataHelper.SetComeBackRed = function()
    local redCount = 0
    if redCount == 0 then
        redCount = HeroRedDataHelper.ComeBackLetterRed()
    end
    if redCount == 0 then
        redCount = HeroRedDataHelper.ComeBackSignInRed()
    end
    if redCount == 0 then
        redCount = HeroRedDataHelper.ComeBackMissionRed()
    end
    if redCount == 0 then
        redCount = HeroRedDataHelper.ComeBackPhaseRed()
    end
    if redCount == 0 then
        redCount = HeroRedDataHelper.ComeBackPermitRed()
    end
    return redCount
end

HeroRedDataHelper.ComeBackLetterRed = function()
    if DataExHelper.Check_ComeBackActivity() then
        if not TableIsNull(DataMgr.Player.backPlayer.tabUnlock) then
            if DataMgr.Player.backPlayer.tabUnlock.backLetter then
                local targetCount = 0
                for key, value in pairs(DataMgr.Player.backPlayerMissions["backLetter"]) do
                    targetCount = MissionHelper.GetTargetCount(key)
                    if not value.completed then
                        return 1
                    end
                end
            end
        end
    end
    return 0
end

HeroRedDataHelper.ComeBackSignInRed = function()
    if DataExHelper.Check_ComeBackActivity() then
        if not TableIsNull(DataMgr.Player.backPlayer.tabUnlock) then
            if DataMgr.Player.backPlayer.tabUnlock.backPlayer then
                local targetCount = 0
                for key, value in pairs(DataMgr.Player.backPlayerMissions["backPlayer"]) do
                    targetCount = MissionHelper.GetTargetCount(key)
                    if not value.completed and value.current >= targetCount then
                        return 1
                    end
                end
            end
        end
    end
    return 0
end

HeroRedDataHelper.ComeBackMissionRed = function()
    if DataExHelper.Check_ComeBackActivity() then
        if not TableIsNull(DataMgr.Player.backPlayer.tabUnlock) then
            local dayKey = ""
            local targetCount = 0
            for i = 1, 5 do
                dayKey = "back0" .. i
                if DataMgr.Player.backPlayer.tabUnlock[dayKey] then
                    for key, value in pairs(DataMgr.Player.backPlayerMissions[dayKey]) do
                        targetCount = MissionHelper.GetTargetCount(key)
                        if not value.completed and value.current >= targetCount then
                            return 1
                        end
                    end
                end
            end
        end
    end
    return 0
end

HeroRedDataHelper.ComeBackPhaseRed = function()
    if DataExHelper.Check_ComeBackActivity() then
        if not TableIsNull(DataMgr.Player.backPlayer.tabUnlock) then
            if DataMgr.Player.backPlayer.tabUnlock.backPhase then
                local targetCount = 0
                for key, value in pairs(DataMgr.Player.backPlayerMissions["backPhase"]) do
                    targetCount = MissionHelper.GetTargetCount(key)
                    if not value.completed and value.current >= targetCount then
                        return 1
                    end
                end
            end
        end
    end
    return 0
end

HeroRedDataHelper.ComeBackPermitRed = function()
    if DataExHelper.Check_ComeBackActivity() then
        local permitPassesId = "11001"
        local passesData = DataMgr.Player.passesMultiple[permitPassesId]
        if TableIsNull(passesData) then
            return 0
        end
        local passesRewards = DataMgr.Player.passesRewardsMultiple[permitPassesId]
        if TableIsNull(passesRewards) then
            return 0
        end
        local passesMissions = DataMgr.Player.passesMissionsMultiple[permitPassesId]
        if TableIsNull(passesMissions) then
            return 0
        end
        local tempConfig = nil
        local tempMission = nil
        for key, value in pairs(passesRewards) do
            tempConfig = ConfigMgr.Config.PassesRewardMap[key]
            if not TableIsNull(tempConfig) then
                tempMission = passesMissions.period[tempConfig.TaskId]
                if not TableIsNull(tempMission) then
                    if tempMission.completed and tempMission.current >= tempMission.target and value.freeReceiveTime == 0 then
                        return 1
                    end
                    if passesData.pay and tempMission.completed and tempMission.current >= tempMission.target and value.payReceiveTime == 0 then
                        return 1
                    end
                end
            end
        end
    end
    return 0
end

local LockId = {

}
local buildConfig = {};
HeroRedDataHelper.RefreshMiniGameRed = function()
    local config = ConfigMgr.Config.constants["GamePoint"]
    if TableIsNull(buildConfig) then
        for index, value in ipairs(ConfigMgr.Config.interactionMap) do
            if value.Group == "401" then
                buildConfig[value.Id] = value.Level;
            end
        end
    end
    local nowLevel = 1;
    for key, value in pairs(DataMgr.Player.interactions) do
        if buildConfig[key] ~= nil then
            nowLevel = buildConfig[key];
        end
    end
    local unlockFourLv = ConfigMgr.Config.constants.FourInLineUnlock;
    local unlockTurnLv = ConfigMgr.Config.constants.GameBoardUnlock;
    local unlock2048Lv = ConfigMgr.Config.constants.NumberMergeUnlock;
    local unlockPuzzleLv = ConfigMgr.Config.constants.PuzzleUnlock;
    local checkList = { nowLevel >= unlock2048Lv, nowLevel >= unlockTurnLv, nowLevel >= unlockFourLv, nowLevel >=
    unlockPuzzleLv }
    for index, value in ipairs(config) do
        RedMgr.Singleton:UpdateClientRedData("1100_" .. value[1], 0);
        if value[2] == "nil" or (not checkList[index]) then
            goto continue;
        end
        if not PlayerPrefs.HasKey(DataMgr.Player.uid .. "#" .. value[1] .. "#" .. value[2]) then
            RedMgr.Singleton:UpdateClientRedData("1100_" .. value[1], 1);
        end
        ::continue::
    end

    local firstData = DataMgr.Player.fourInLine.first;

    if firstData ~= nil then
        for i, v in pairs(firstData) do
if i == tostring(1) then
                if not v then
                    RedMgr.Singleton:UpdateClientRedData("1100_4", 1);
                end
            end
        end
    end
    RedMgr.Singleton:Refresh();
end




HeroRedDataHelper.RefreshCollectorPracticeStoryRed = function()


















CollectorPracticeMgr.RefushStoryData("MapA");
local setOutRed = false;
    RedMgr.Singleton:UpdateClientRedData("1216", 1);
    for key, value in pairs(CollectorPracticeMgr.StoryData) do
for _, data in pairs(value) do
            local setDataRed = false;
for _, quest in pairs(data.questList) do
if (not quest.complete) and DataMgr.Player.storyQuest[quest.questID] == false then
                    RedMgr.Singleton:UpdateClientRedData("1215_" .. tostring(key) .. "#" .. tostring(data.questType), 1);
                    RedMgr.Singleton:UpdateClientRedData("1217_" .. tostring(key) .. "#" .. tostring(data.questType), 1);
                    setDataRed = true;
                    setOutRed = true;
                    break;
                end
            end
if not setDataRed then
                RedMgr.Singleton:UpdateClientRedData("1215_" .. tostring(key) .. "#" .. tostring(data.questType), 0);
                RedMgr.Singleton:UpdateClientRedData("1217_" .. tostring(key) .. "#" .. tostring(data.questType), 0);
            end
        end
        if setOutRed then
            RedMgr.Singleton:UpdateClientRedData("1214", 1);
            break;
        end
    end
    if not setOutRed then
        RedMgr.Singleton:UpdateClientRedData("1214", 0);
    end
    RedMgr.Singleton:Refresh();
end

HeroRedDataHelper.RefreshCollectorPracticeTrammelsRed = function()
    CollectorPracticeMgr.InitGalleryData();
    local tempData = {};
    for key, value in pairs(CollectorPracticeMgr.HomeGrlleryData) do
        if tempData[value.OriginsID] == nil then
            tempData[value.OriginsID] = {}
            table.insert(tempData[value.OriginsID], value)
        else
            table.insert(tempData[value.OriginsID], value)
        end
    end
    for key, value in pairs(tempData) do
        local ChildTab = tempData[key]
        local completeNum = 0;

        for _Index, _value in ipairs(ChildTab) do
            if _value.Achieve then
                completeNum = completeNum + 1
            end
        end
        if completeNum == #tempData[key] then
            if DataMgr.Player.originsTalent[key] == nil then
                RedMgr.Singleton:UpdateClientRedData("1219_" .. tostring(key), 1);
            else
                RedMgr.Singleton:UpdateClientRedData("1219_" .. tostring(key), 0);
            end
        else
            RedMgr.Singleton:UpdateClientRedData("1219_" .. tostring(key), 0);
        end
    end

    local originsTalentConfig = ConfigMgr.Config.OriginsTalentMap;
    local originsTalentDataMap = {};
for key, value in pairs(originsTalentConfig) do
        if originsTalentDataMap[value.Map] == nil then
            originsTalentDataMap[value.Map] = {};
        end
        table.insert(originsTalentDataMap[value.Map], key);
    end
    for key, value in pairs(originsTalentDataMap) do
        RedMgr.Singleton:UpdateClientRedData("1218_" .. tostring(key), 0);
        for key2, value2 in pairs(value) do
            if RedMgr.Singleton:GetRedStateById("1219_" .. tostring(value2)) > 0 then
                RedMgr.Singleton:UpdateClientRedData("1218_" .. tostring(key), 1);
                break;
            end
        end
    end
    RedMgr.Singleton:Refresh();
end

HeroRedDataHelper.RefreshCollectorPracticeWeeklyRed = function()
    local dataTable = DataMgr.Player.missions["weekly"]["604"];
    local result = false;
    for key, value in pairs(dataTable) do
        if value.current >= value.target and not value.completed then
            result = true;
            break;
        end
    end
    RedMgr.Singleton:UpdateClientRedData("1309", result and 1 or 0);
    RedMgr.Singleton:Refresh();
end


HeroRedDataHelper.RefreshCollectorPracticeOnMainScene = function()
    if FeatureManager.IsLock("1400") then
        RedMgr.Singleton:UpdateClientRedData("1308", 0);
        return;
    end
    local data = ConfigMgr.Config.PracticePeriodMaps;
    local result = false;
    for key, value in pairs(data) do
        local nowTime = LuaMgr.Timestamp();
    end

    RedMgr.Singleton:Refresh();
end


HeroRedDataHelper.RefreshCollectorAchievementVersion2Red = function()
RedMgr.Singleton:UpdateClientRedData("1314", 1);
    RedMgr.Singleton:UpdateClientRedData("1313_All", 0);
    RedMgr.Singleton:UpdateClientRedData("1313_Label", 0);
    RedMgr.Singleton:UpdateClientRedData("1314_Label", 0);
for i = 1, 7, 1 do
        RedMgr.Singleton:UpdateClientRedData("1313_SelectType" .. tostring(i), 0);
        RedMgr.Singleton:UpdateClientRedData("1313_Type" .. tostring(i), 0);
    end

    local buffData = DataMgr.Player.missions["YX2BUFF"]["701"]
    for key, value in pairs(buffData) do
        local typeData = ConfigMgr.Config.missionMap[key].condition1[1].ElementID;
if RedMgr.Singleton:GetRedStateById("1313_SelectType" .. typeData) > 0 then
            goto continue;
        end
        if value.current >= value.target and (not value.completed) then
            RedMgr.Singleton:UpdateClientRedData("1313_SelectType" .. typeData, 1);
            RedMgr.Singleton:UpdateClientRedData("1313_Type" .. typeData, 1);
        end
        ::continue::
    end
for i = 1, 7, 1 do
        if RedMgr.Singleton:GetRedStateById("1313_SelectType" .. tostring(i)) > 0 then
            RedMgr.Singleton:UpdateClientRedData("1313_Label", 1);
            break;
        end
    end

    local buffData2 = DataMgr.Player.missions["YX2Event"]["701"]
    for key, value in pairs(buffData2) do
        RedMgr.Singleton:UpdateClientRedData("1314_" .. key, 0);
        if value.current >= value.target and (not value.completed) then
            RedMgr.Singleton:UpdateClientRedData("1314_" .. key, 1);
            RedMgr.Singleton:UpdateClientRedData("1314_Label", 1);
        end
        ::continue::
    end

    if RedMgr.Singleton:GetRedStateById("1313_Label") > 0 or RedMgr.Singleton:GetRedStateById("1314_Label") > 0 then
        RedMgr.Singleton:UpdateClientRedData("1313_All", 1);
    end
    RedMgr.Singleton:Refresh();
end


HeroRedDataHelper.ConstRedToMapType = {
    ["MapA"] = {
        "1218_MapA",
        "1214"
    },
    ["MapB"] = {
        "1218_MapB",
        "1313_All",
    },
}


HeroRedDataHelper.UpdateRedLevelSelectMap = function()
    local data = ConfigMgr.Config.PracticePeriodMaps;
    for key, value in pairs(data) do
        local nowTime = LuaMgr.Timestamp();
        local result = false;
if value.openTime <= nowTime and value.closeTime >= nowTime then
if not PlayerPrefs.HasKey(DataMgr.Player.uid .. "#" .. value.mapType) then
                result = true;
else
if HeroRedDataHelper.ConstRedToMapType[value.mapType] ~= nil then
                    for index2, value2 in ipairs(HeroRedDataHelper.ConstRedToMapType[value.mapType]) do
if RedMgr.Singleton:GetRedStateById(value2) > 0 then
                            result = true;
break;
                        end
                    end
                end
            end
        end

        RedMgr.Singleton:UpdateClientRedData("1221" .. "_" .. value.mapType, result and 1 or 0);
    end
    RedMgr.Singleton:Refresh();
end

HeroRedDataHelper.UpdateRedLevelMainPage = function()
    RedMgr.Singleton:UpdateClientRedData("1308", 0);
    if FeatureManager.IsLock("1400") then
        return;
    end
    local data = ConfigMgr.Config.PracticePeriodMaps;
    local result = false;
    for key, value in pairs(data) do
        if RedMgr.Singleton:GetRedStateById("1221" .. "_" .. value.mapType) > 0 then
            result = true;
            break;
        end
    end
    if RedMgr.Singleton:GetRedStateById("1309") > 0 then
        result = true;
    end
    local timeRedCount = HeroRedDataHelper.GetLevelTimeRedCount()
    if result == true or timeRedCount > 0 then
        RedMgr.Singleton:UpdateClientRedData("1308", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("1308", 0)
    end
    RedMgr.Singleton:Refresh();
end


HeroRedDataHelper.GetLevelTimeRedCount = function()
    if FeatureManager.IsLock("1400") then
        return 0
    end
    local dataTable = DataMgr.Player.missions["weekly"]["604"];
    local startTime = 0
    local endTime = 0
    local curTime = LuaMgr.Timestamp()
    for key, value in pairs(dataTable) do
        if curTime >= value.createTime and curTime < value.expiredTime then
            startTime = value.createTime
            endTime = value.expiredTime
            break
        end
    end
    if startTime == 0 or endTime == 0 then
        return 0
    end
    local deltaTimeStart = GetTimeDay(curTime - startTime)
    local deltaTimeEnd = GetTimeDay(endTime - curTime)
    local redID = "15112"
    if deltaTimeStart == 1 and RedMgr.Singleton:CheckRedCondition(redID) == true then
        return 1
    elseif (deltaTimeEnd == 1 or deltaTimeEnd == 3) and RedMgr.Singleton:CheckRedCondition(redID) == true then
        return 1
    end
    return 0
end


HeroRedDataHelper.RefreshCollectorPractice = function()
    HeroRedDataHelper.RefreshCollectorPracticeTrammelsRed();
    HeroRedDataHelper.RefreshCollectorPracticeStoryRed();
    HeroRedDataHelper.RefreshCollectorPracticeWeeklyRed();
    HeroRedDataHelper.RefreshCollectorAchievementVersion2Red();
    HeroRedDataHelper.UpdateRedLevelSelectMap();
    HeroRedDataHelper.UpdateRedLevelMainPage();
end





HeroRedDataHelper.RefreshNianBeastRed = function()
    if not DataExHelper.Check_NianBeast() then
        return;
    end
    local dataQuests = DataMgr.Player.quests;
    local nianBeast = DataMgr.Player.nianBeast;

    local taskRed = 0;
    local cfgDailyTask = DataExHelper.Check_ConfigQuestEventByText("newYearDaily")
    table.sort(cfgDailyTask, function(a, b) return tonumber(a.id) < tonumber(b.id) end)
    local dailyCount = #cfgDailyTask
    for i, v in ipairs(cfgDailyTask) do
        local questData = dataQuests[v.id]
        if questData ~= nil then
            if questData.state == 2 then
                taskRed = 1;
                break
            end
            if questData.state == 3 then
                dailyCount = dailyCount - 1
            end
        end
    end
    if (dailyCount > 0 and RedMgr.Singleton:CheckRedCondition("1301")) then
        taskRed = 1
    end

    local productRed = 0;
    if nianBeast.Lv > 0 then
        local cfgScenesLevel = ConfigMgr.Config.scenesLevelMap;
        local curSceneLevel = cfgScenesLevel[tostring(nianBeast.Lv)]
        local passMin = (LuaMgr.Timestamp() - nianBeast.ActiveTime)
        local rewardTime = ConfigMgr.Config.constants.NianBeastRewardTime;
        local passRewardCount = passMin / (rewardTime * 60);
        passRewardCount = math.floor(passRewardCount);
        local canRewardCount = passRewardCount * curSceneLevel.reward[1].count;
        productRed = canRewardCount >= curSceneLevel.rewardLimit and 1 or 0;
    end
    local hurtRed = 0;

    local cfgTotalDamage = DataExHelper.Check_ConfigQuestEventByText("newYearDamageTotal")
    for i, v in pairs(cfgTotalDamage) do
        if dataQuests[v.id] ~= nil and dataQuests[v.id].state == 2 then
            hurtRed = 1;
            break;
        end
    end

    local cfgRewardList = {}
    table.insert(cfgRewardList, DataExHelper.Check_ConfigQuestEventByText("newYearMonsterDamage1"))
    table.insert(cfgRewardList, DataExHelper.Check_ConfigQuestEventByText("newYearMonsterDamage2"))
    table.insert(cfgRewardList, DataExHelper.Check_ConfigQuestEventByText("newYearMonsterDamage3"))
    table.insert(cfgRewardList, DataExHelper.Check_ConfigQuestEventByText("newYearMonsterDamage4"))
    for i, v in ipairs(cfgRewardList) do
        for p, m in ipairs(v) do
            if dataQuests[m.id] ~= nil and dataQuests[m.id].state == 2 then
                hurtRed = 1;
                break
            end
        end
    end

    local storyRed = 0
    for k, v in ipairs(ConfigMgr.Config.activityMapEventList) do
        if (v.area == "NianBeast01") then
            local eventData = nil
            local cacheData = DataMgr.Player.activityMaps[v.area];
            if (cacheData ~= nil) then
                eventData = cacheData.activityEvents[v.id];
            end
            if (eventData ~= nil) then
                storyRed = 1
                if (eventData.complete) then
                    storyRed = 0
                end
            end
        end
    end

    local rewardRed, passTaskRed = HeroRedDataHelper.GetPassesRed();
    local showRewardRedNum = HeroRedDataHelper.ShowRewardNum()

    RedMgr.Singleton:UpdateClientRedData("1301", taskRed);
    RedMgr.Singleton:UpdateClientRedData("1302", productRed);
    RedMgr.Singleton:UpdateClientRedData("1303", hurtRed);
    RedMgr.Singleton:UpdateClientRedData("1300",
        taskRed + productRed + hurtRed + rewardRed + passTaskRed + storyRed + showRewardRedNum);
    RedMgr.Singleton:UpdateClientRedData("15050", storyRed);
    RedMgr.Singleton:UpdateClientRedData("15051", rewardRed + passTaskRed);
end

HeroRedDataHelper.ShowRewardNum = function()
    local redGroupIds = { 11, 13, 14, 15 }
    local totalNum = 0
    local showRewardRedNum = 0
    local minConsume = 0
    local playerTotalCount = DataHelper.GetItemCountById("5006");
    for k, v in pairs(redGroupIds) do
        local num, consume = HeroRedDataHelper.GetRewardNum(v)
        if (minConsume == 0) then
            minConsume = consume
        else
            if (minConsume < consume) then
                minConsume = consume
            end
        end
        totalNum = totalNum + num
    end
    if (totalNum > 0 and playerTotalCount > minConsume) then
        showRewardRedNum = 1
    end
    RedMgr.Singleton:UpdateClientRedData("15052", showRewardRedNum);
    return showRewardRedNum
end

HeroRedDataHelper.GetRewardNum = function(group)
    local minConsume = 0
    local groupId = group;
    local curDrawActivity = nil;
    local dataDrawRewardProgress = DataMgr.Player.drawRewardProgress
    local drawRewardRecords = DataMgr.Player.drawRewardRecords
    local cfgDrawMap = ConfigMgr.Config.DrawMap;
    local drawActList = {}
    for i, v in pairs(ConfigMgr.Config.DrawActivityMap) do
        if v.Group == tostring(groupId) then
            table.insert(drawActList, v);
            if (IsNull(dataDrawRewardProgress) ~= nil) then
                if dataDrawRewardProgress[tostring(groupId)] ~= nil then
                    curDrawActivity = v;
                end
            end
        end
    end
    local totalNum = 0
    if curDrawActivity == nil then
        curDrawActivity = drawActList[1];
    end
    if curDrawActivity ~= nil then
        for i, v in ipairs(curDrawActivity.Content) do
            local drawItem = cfgDrawMap[v];
            if IsNull(drawRewardRecords) ~= nil then
                local key = string.format("%s_%s", curDrawActivity.ID, drawItem.ID);
                local hasBuyCount = drawRewardRecords[key];
                if hasBuyCount == nil then
                    hasBuyCount = 0
                end
                totalNum = totalNum + (drawItem.Time - hasBuyCount)
            end
        end
        minConsume = curDrawActivity.Consume[1].count
    end
    return totalNum, minConsume
end


HeroRedDataHelper.CheckAreaShopRed = function()
    local unlockParam = ""
    local dungeonRecord = nil
    local goodConfig = nil
    for i = 1, #ConfigMgr.Config.shop.area.shelfs do
        unlockParam = ConfigMgr.Config.shop.area.shelfs[i].UnlockCond[1].ElementID
        if not IsNullOrEmpty(unlockParam) then
            dungeonRecord = DataMgr.Player.dungeonRecords[unlockParam]
            if dungeonRecord ~= nil and not IsNullOrEmpty(dungeonRecord.historyRating) then
                for k = 1, #ConfigMgr.Config.shop.area.shelfs[i].goods do
                    goodConfig = ConfigMgr.Config.shop.area.shelfs[i].goods[k]
                    if DataHelper.GetShopRecordByGoodsId(goodConfig.Id) ~= goodConfig.RefreshCount then
                        return true
                    end
                end
            end
        end
    end
    return false
end

HeroRedDataHelper.SetSIMRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.SIM) then
        return
    end
    local cfgSIMconstants = ConfigMgr.Config.SIMconstants;
    local dataSimulationCultivation = DataMgr.Player.simulationCultivation;
    local learnRed_8002 = 0;

    local unlockPlotCount = NumTool.GetLen(dataSimulationCultivation.unlockPlot);
    local allPlotCount = NumTool.GetLen(ConfigMgr.Config.SIMplotMap);
    if dataSimulationCultivation.finishDay ~= cfgSIMconstants.TimeAllocation
        and DataHelper.GetItemCountById("5039") > 0
        and RedMgr.Singleton:CheckRedCondition("8002") then
        learnRed_8002 = 1;
    elseif dataSimulationCultivation.finishDay == cfgSIMconstants.TimeAllocation and unlockPlotCount < allPlotCount then
        learnRed_8002 = 1;
    end

    local novelRed_8003 = 0;
    local dataCompleteNovel = {}
    for i, v in ipairs(DataMgr.Player.completedChapters) do
        if dataCompleteNovel[v] == nil then
            dataCompleteNovel[v] = v;
        end
    end
    for i, v in pairs(ConfigMgr.Config.SIMplotMap) do
        if v.PlotType ~= 3 and dataSimulationCultivation.unlockPlot[v.ID] ~= nil and dataCompleteNovel[v.NarrativeID[2]] == nil then
            novelRed_8003 = 1;
            break;
        end
    end

    local novelTaskRed_8004 = 0;
    local cfgNovelTaskList = DataExHelper.Check_ConfigQuestEventByText("niaoyinshanshuitask");
    for i, v in ipairs(cfgNovelTaskList) do
        if DataMgr.Player.quests[v.id] ~= nil and DataMgr.Player.quests[v.id].state == 2 then
            novelTaskRed_8004 = 1;
            break;
        end
    end

    local taskRed_8005 = 0;
    for i, v in pairs(DataMgr.Player.simulationCultivation.task) do
        if v.target == v.current then
            taskRed_8005 = 1;
            break
        end
    end
    RedMgr.Singleton:UpdateClientRedData("8002", learnRed_8002);
    RedMgr.Singleton:UpdateClientRedData("8003", novelRed_8003 + novelTaskRed_8004);
    RedMgr.Singleton:UpdateClientRedData("8004", novelTaskRed_8004);
    RedMgr.Singleton:UpdateClientRedData("8005", taskRed_8005);
    RedMgr.Singleton:UpdateClientRedData("8001", learnRed_8002 + novelRed_8003 + novelTaskRed_8004 + taskRed_8005);
end


HeroRedDataHelper.SetZhongQiuJieRed = function()

    local drawRed = 0;
    local drawId = "3001";
    local groupId = "3";
    local drawMap = ConfigMgr.Config.DrawMap;
    local drawRewardProgress = DataMgr.Player.drawRewardProgress;
    if (drawRewardProgress[groupId] ~= nil) then
        drawId = drawRewardProgress[groupId];
    end
    local drawActivity = nil;
    local drawActivityMap = ConfigMgr.Config.DrawActivityMap;
    for _, v in pairs(drawActivityMap) do
        if (v.Group == groupId and v.ID == drawId) then
            drawActivity = v;
        end
    end
    if (drawActivity ~= nil) then
        local drawRewardRecords = DataMgr.Player.drawRewardRecords;
        for _, v in ipairs(drawActivity.Content) do
            local count = drawMap[v].Time;
            local hasBuyCount = 0;
            if (IsNull(drawRewardRecords) ~= nil) then
                local key = string.format("%s_%s", drawId, v);
                hasBuyCount = drawRewardRecords[key];
            end
            if (hasBuyCount == nil or hasBuyCount < count) then
                drawRed = 1;
                break;
            end
        end
        local consumeItem = drawActivity.Consume[1];
        local itemCount = PlayerItemMgr.GetItemCountById(consumeItem.id);
        if (drawRed == 1 and itemCount < consumeItem.count) then
            drawRed = 0;
        end
    end

    local taskData;
    local taskRed = 0;
    local configs = DataExHelper.Check_ConfigQuestEventByText("zhongqiujieTask");
    local quests = DataMgr.Player.quests;
    local taskList = {};
    for _, v in ipairs(configs) do
        taskData = quests[v.id];
        if (taskData ~= nil) then
            table.insert(taskList, taskData);
        end
    end
    local len = #taskList;
    if (len > 0) then
        for i = 1, len do
            if (taskList[i].state == 2) then
                taskRed = 1;
                break;
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("1182", drawRed + taskRed);
end


HeroRedDataHelper.SetGuoBaoRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.GuoBao) then return end;





































    local rewardRed, taskRed = HeroRedDataHelper.GetPassesRed();
    RedMgr.Singleton:UpdateClientRedData("15041", rewardRed + taskRed);
    RedMgr.Singleton:UpdateClientRedData("15040", rewardRed + taskRed);

end


HeroRedDataHelper.SetSGYRed = function()

    local novel = 0;
    local furnitureActives = ConfigMgr.Config.FurnitureActives;
    if (furnitureActives ~= nil) then
        for _, v in pairs(furnitureActives) do
            if (v.Type == 1 and PlayerSGYMgr.IsDungeonRecord(v.Id)) then
                for _, n in pairs(v.NarrativesId) do
                    if (not PlayerSGYMgr.GetNovelRecord(n)) then
                        novel = 1;
                        break;
                    end
                end
            end
            if (novel == 1) then
                break;
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("15060", novel);
    local rewardRed, taskRed = HeroRedDataHelper.GetPassesRed();
    RedMgr.Singleton:UpdateClientRedData("15056", rewardRed + taskRed);
    RedMgr.Singleton:UpdateClientRedData("15055", rewardRed + taskRed + novel);
end


HeroRedDataHelper.GetDungeon66TotalStar = function(seriesId)
    local trainingCamp = DataMgr.Player.trainingCamp;
    if (IsNull(trainingCamp)) then return 0 end

    local items = DataMgr.Player.trainingCamp.items;
    if (IsNull(items)) then return 0 end

    local item = items[seriesId];
    if (IsNull(item)) then return 0 end

    local star = 0;
    local campPlotMap = ConfigMgr.Config.CampPlotMap;
    for k, _ in pairs(item.records) do
        local campPlot = campPlotMap[k];
        if (campPlot ~= nil) then
            star = star + TrainingCampMgr.GetStar(campPlot.DungeonId[1]) + TrainingCampMgr.GetStar(campPlot.DungeonId[2]);
        end
    end
    return star;
end


HeroRedDataHelper.GetDungeon66Star = function(dungeonId)
    local challenges = ConfigMgr.Config.levelChallenges[dungeonId];
    if (challenges == nil) then return 0 end

    local count = 0;
    local len = #challenges;
    for i = 1, len do
        if (DataMgr.Player.completedTags[challenges[i]] ~= nil) then
            count = count + 1;
        end
    end
    return count;
end


HeroRedDataHelper.SetDungeon66Red = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.SummerCamp) then
        return false
    end
    local red = 0;
    local campRewardMap = ConfigMgr.Config.CampRewardMap;
    local trainingCamp = DataMgr.Player.trainingCamp;
    if (not IsNull(campRewardMap) and not IsNull(trainingCamp)) then
        local seriesId = TrainingCampMgr.GetCurWheelSeriesID();
        if seriesId ~= nil then
            local rewards = DataMgr.Player.trainingCamp.rewards;
            local totalStar = HeroRedDataHelper.GetDungeon66TotalStar(seriesId);
            for _, v in pairs(campRewardMap) do
                if (v.SeriesId == seriesId) then
                    if (IsNull(rewards) or IsNull(rewards[v.ID])) then
                        if (totalStar >= v.Parameter) then
                            red = 1;
                            break;
                        end
                    end
                end
            end
        end
    end
    local techRed = TrainingCampMgr.CheckIsCanUnlockTech() and 1 or 0
    RedMgr.Singleton:UpdateClientRedData("16104", red + techRed);
    RedMgr.Singleton:UpdateClientRedData("16105", red);
    RedMgr.Singleton:UpdateClientRedData("16452", techRed);
end


HeroRedDataHelper.SetSpringCampRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.SpringCamp) then
        return false
    end
    local red = 0;
    local campRewardMap = ConfigMgr.Config.CampRewardMap;
    local trainingCamp = DataMgr.Player.trainingCamp;
    if (not IsNull(campRewardMap) and not IsNull(trainingCamp)) then
        local seriesId = TrainingCampMgr.GetCurWheelSeriesID();
        if seriesId ~= nil then
            local rewards = DataMgr.Player.trainingCamp.rewards;
            local totalStar = HeroRedDataHelper.GetDungeon66TotalStar(seriesId);
            for _, v in pairs(campRewardMap) do
                if (v.SeriesId == seriesId) then
                    if (IsNull(rewards) or IsNull(rewards[v.ID])) then
                        if (totalStar >= v.Parameter) then
                            red = 1;
                            break;
                        end
                    end
                end
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("17810", red);
    RedMgr.Singleton:UpdateClientRedData("17811", red);
end


HeroRedDataHelper.GetParkourRed = function()
    local parkourLevelMap = ConfigMgr.Config.DHParkourLevelMap;
    for _, v in pairs(parkourLevelMap) do
        local flag = false;
        if (v.UnlockType == 1) then
            if (IsNullOrEmpty(v.Unlock_1)) then
                flag = true;
            else
                local levelConfig = ConfigMgr.Config.DHParkourLevelMap[v.Unlock_1];
                if (levelConfig ~= nil) then
                    local score = DataMgr.Player.DunHuang.ParkourMap[levelConfig.LevelID];
                    if (score ~= nil and score >= levelConfig.Score) then
                        flag = true;
                    end
                end
            end
        elseif (v.UnlockType == 2) then
            flag = LuaMgr.Timestamp() > v.Unlock_2;
        end
        if (flag) then
            local score = DataMgr.Player.DunHuang.ParkourMap[v.LevelID];
            if (score == nil or score < v.Score) then
                return 1;
            end
        end
    end
    return 0;
end


HeroRedDataHelper.SetDHRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.DunHuang) then
        return false;
    end
    local rewardRed, taskRed = HeroRedDataHelper.GetPassesRed();
    local otherRed = PlayerDHMgr.CheckEntranceRedDot()
    local parkourRed = HeroRedDataHelper.GetParkourRed();
RedMgr.Singleton:UpdateClientRedData("16051", rewardRed + taskRed);
RedMgr.Singleton:UpdateClientRedData("16050", rewardRed + taskRed + otherRed + parkourRed);
RedMgr.Singleton:UpdateClientRedData("16056", parkourRed);
end


HeroRedDataHelper.GetActivityRoomRed = function()
    local questEvents = DataExHelper.Check_ConfigQuestEventByText("RSReward");
    local len = #questEvents;
    for i = 1, len do
        local questData = DataMgr.Player.quests[questEvents[i].id];
        if (questData ~= nil and questData.state == 2) then
            return 1;
        end
    end
    local fristActivityRoom = PlayerPrefs.GetInt("FristActivityRoom_" .. DataMgr.Player.uid, 1);
    return fristActivityRoom;
end


HeroRedDataHelper.SetDH2Red = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.RoomShare) then
        return false;
    end
    local rewardRed, taskRed = HeroRedDataHelper.GetPassesRed();
    local otherRed = PlayerDH2Mgr.CheckEntranceRedDot()
    local activityRoomRed = HeroRedDataHelper.GetActivityRoomRed();
RedMgr.Singleton:UpdateClientRedData("16051", rewardRed + taskRed);
RedMgr.Singleton:UpdateClientRedData("16130", rewardRed + taskRed + otherRed + activityRoomRed);
    RedMgr.Singleton:UpdateClientRedData("16135", activityRoomRed);
end


HeroRedDataHelper.SetZGCXRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.LightEvent) then
        return false;
    end
    local rewardRed, taskRed = HeroRedDataHelper.GetPassesRed();
    local otherRed = PlayerZGCXMgr.CheckEntranceRedDot()
RedMgr.Singleton:UpdateClientRedData("16402", rewardRed + taskRed);
RedMgr.Singleton:UpdateClientRedData("16401", rewardRed + taskRed + otherRed);
end


HeroRedDataHelper.SetMainLine1Red = function()
    local rewardRed, taskRed = HeroRedDataHelper.GetPassesRed();
    local mianLine1Reward = HeroRedDataHelper.ShowMainLine1RewardNum()
    local abyssCanFight = PlayerAreaMapMgr.CheckAreaCanFight("abyss")
    local mainLine1Collect = AreaMapSceneMgr.CheckCourseRed()
    local areaAbyss = 0
    local curType = ConfigMainLineMgr.CheckCanSwitch() and 1 or 2;
    if (RedMgr.Singleton:CheckRedCondition("16802") and abyssCanFight ~= nil and curType == 2) then
        areaAbyss = 1
    end
    local mainLine1 = 0
    if (RedMgr.Singleton:CheckRedCondition("16803")) then
        mainLine1 = 1
    end
    local jumpGame = 0
    if (RedMgr.Singleton:CheckRedCondition("16807") and curType == 2) then
        jumpGame = 1
    end
RedMgr.Singleton:UpdateClientRedData("16805", rewardRed + taskRed);
RedMgr.Singleton:UpdateClientRedData("16801", mainLine1Collect)
RedMgr.Singleton:UpdateClientRedData("16802", areaAbyss)
RedMgr.Singleton:UpdateClientRedData("16803", mainLine1)
RedMgr.Singleton:UpdateClientRedData("16807", jumpGame)
    RedMgr.Singleton:UpdateClientRedData("16806",
rewardRed + taskRed + mianLine1Reward + mainLine1Collect + areaAbyss + mainLine1 + jumpGame);
end

HeroRedDataHelper.SetMiniBattle2Red = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.MiniBattlenew) then
        return false;
    end

    local isFinish = true
    local taskRed = 0;
    local taskList = DataExHelper.Check_DataExByGroupId(MiniBattle2Mgr.activityGroupId)
    for i, v in ipairs(taskList) do
        if v.state ~= 3 then
            isFinish = false
        end
        if v.state == 2 then
            taskRed = 1
            break
        end
    end

    local dungeonRewardRed = MiniBattle2Mgr.CheckAllDungeonRewardRed()

    local playRed = 0
    if (RedMgr.Singleton:CheckRedCondition("16430") and not isFinish) then
        playRed = 1
    end

RedMgr.Singleton:UpdateClientRedData("16432", taskRed);
RedMgr.Singleton:UpdateClientRedData("16431", dungeonRewardRed);
RedMgr.Singleton:UpdateClientRedData("16430", taskRed + dungeonRewardRed + playRed);
end

HeroRedDataHelper.SetMiniBattle5Red = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.MiniBattle5) then
        return false;
    end

    local isFinish = true
    local taskRed = 0;
    local taskList = DataExHelper.Check_DataExByGroupId(MiniBattle5Mgr.activityGroupId)
    for i, v in ipairs(taskList) do
        if v.state ~= 3 then
            isFinish = false
        end
        if v.state == 2 then
            taskRed = 1
            break
        end
    end

    local dungeonRewardRed = MiniBattle5Mgr.CheckAllDungeonRewardRed()

    local playRed = 0
    if (RedMgr.Singleton:CheckRedCondition("17630") and not isFinish) then
        playRed = 1
    end

RedMgr.Singleton:UpdateClientRedData("17632", taskRed);
RedMgr.Singleton:UpdateClientRedData("17631", dungeonRewardRed);
RedMgr.Singleton:UpdateClientRedData("17630", taskRed + dungeonRewardRed + playRed);
end

HeroRedDataHelper.SetMiniBattle3Red = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.DualBattle) then
        return false;
    end

    local taskRed = 0;
    local taskList = DataExHelper.Check_DataExByGroupId(MiniBattle3Mgr.activityGroupId)
    for i, v in ipairs(taskList) do
        if v.state == 2 then
            taskRed = 1
            break
        end
    end

    local dungeonRewardRed = MiniBattle3Mgr.CheckAllDungeonRewardRed()
    local collectRed = MiniBattle3Mgr.CheckCollectRed()

    local playRed = 0
    if (RedMgr.Singleton:CheckRedCondition("16871")) then
        playRed = 1
    end

RedMgr.Singleton:UpdateClientRedData("16872", taskRed);
RedMgr.Singleton:UpdateClientRedData("16873", collectRed);
RedMgr.Singleton:UpdateClientRedData("16871", taskRed + dungeonRewardRed + collectRed + playRed);
end

HeroRedDataHelper.ShowMainLine1RewardNum = function()
    local type1 = { 41, 42, 43, 44, 45 }
    local type2 = { 51, 52, 53, 54, 55 }
    local redGroupIds = ConfigMainLineMgr.CheckCanSwitch() and type1 or type2;
    local totalNum = 0
    local showRewardRedNum = 0
    local minConsume = 0
    local playerTotalCount = DataHelper.GetItemCountById("5107");
    for k, v in pairs(redGroupIds) do
        local num, consume = HeroRedDataHelper.GetRewardNum(v)
        if (minConsume == 0) then
            minConsume = consume
        else
            if (minConsume < consume) then
                minConsume = consume
            end
        end
        totalNum = totalNum + num
    end
    if (totalNum > 0 and playerTotalCount > minConsume) then
        showRewardRedNum = 1
    end
    RedMgr.Singleton:UpdateClientRedData("16804", showRewardRedNum);
    return showRewardRedNum
end

HeroRedDataHelper.SetCrisisContract2Red = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.crisiscontract2) then
        return false;
    end
    local taskRed = 0;
    local taskList = DataExHelper.Check_DataExByGroupId(4005)
    for i, v in ipairs(taskList) do
        if v.state == 2 then
            taskRed = 1
            break
        end
    end

    local dungeonRewardRed = CrisisContract2Mgr.CheckDungeonRewardRed()

RedMgr.Singleton:UpdateClientRedData("16832", taskRed);
RedMgr.Singleton:UpdateClientRedData("16831", dungeonRewardRed);
RedMgr.Singleton:UpdateClientRedData("16830", taskRed + dungeonRewardRed);
end

HeroRedDataHelper.SetCrisisContract3Red = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.crisiscontract3) then
        return false;
    end
    local taskRed = 0;
    local taskList = DataExHelper.Check_DataExByGroupId(4006)
    for i, v in ipairs(taskList) do
        if v.state == 2 then
            taskRed = 1
            break
        end
    end

    local dungeonRewardRed = CrisisContract3Mgr.CheckDungeonRewardRed()

RedMgr.Singleton:UpdateClientRedData("17013", taskRed);
RedMgr.Singleton:UpdateClientRedData("17012", dungeonRewardRed);
RedMgr.Singleton:UpdateClientRedData("17011", taskRed + dungeonRewardRed);
end

HeroRedDataHelper.SetCrisisContract4Red = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.TeamRelay3) then
        return false;
    end
    local taskRed = 0;
    local taskList = DataExHelper.Check_DataExByGroupId(4202)
    for i, v in ipairs(taskList) do
        if v.state == 2 then
            taskRed = 1
            break
        end
    end

    local dungeonRewardRed = CrisisContract4Mgr.CheckAllDungeonRewardRed() and 1 or 0

RedMgr.Singleton:UpdateClientRedData("17521", taskRed);
RedMgr.Singleton:UpdateClientRedData("17520", taskRed + dungeonRewardRed);
end

HeroRedDataHelper.SetWaterlilyRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.Waterlily) then
        return false;
    end
    local rewardRed, taskRed = HeroRedDataHelper.GetPassesRed();
    local otherRed = PlayerWaterlilyMgr.CheckEntranceRedDot()
RedMgr.Singleton:UpdateClientRedData("16864", rewardRed + taskRed);
RedMgr.Singleton:UpdateClientRedData("16861", rewardRed + taskRed + otherRed);
end

HeroRedDataHelper.SetXingHaiXuYuRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.NewCelebration) then
        return false;
    end
    local redNum = XingHaiData.CheckRed()
    RedMgr.Singleton:UpdateClientRedData("16886", redNum)
end

HeroRedDataHelper.SetLouYiZhuoMingRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.LYZM) then
        return false;
    end
    local redNum = ManagementData.CheckRed()
    RedMgr.Singleton:UpdateClientRedData("16910", redNum)
end

HeroRedDataHelper.SetZhiXiangLiuRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.ZXL) then
        return false;
    end
    local redNum = ZXLData.CheckRed()
    RedMgr.Singleton:UpdateClientRedData(ZXLConst.RedPoint.Home, redNum)
end

HeroRedDataHelper.SetSuiChuNaJiRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.TeamRelay) then
        return false;
    end
    local redNum = SCNJData.CheckRed()
    RedMgr.Singleton:UpdateClientRedData(SCNJConst.RedPoint.Home, redNum)
end

HeroRedDataHelper.SetSongShiYouXinRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.SSYX) then
        return false;
    end
    local redNum = SSYXData.CheckRed()
    RedMgr.Singleton:UpdateClientRedData(SSYXConst.RedPoint.Home, redNum)
end

HeroRedDataHelper.SetKZRYRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.KZRY) then
        return false;
    end
    local rewardRed, taskRed = HeroRedDataHelper.GetPassesRed();
    local missionRed = 0;
    local taskList = DataExHelper.Check_DataExByGroupId(4009)
    local isFinish = true
    for i, v in ipairs(taskList) do
        if (v.event == 807) then
            if (v.state ~= 3) then
                isFinish = false
            end
            if v.state == 2 then
                missionRed = 1
                break
            end
        end
    end
    local playRed = 0
    if (RedMgr.Singleton:CheckRedCondition("16838") and not isFinish) then
        playRed = 1
    end
RedMgr.Singleton:UpdateClientRedData("16839", rewardRed + taskRed);
RedMgr.Singleton:UpdateClientRedData("16837", missionRed);
RedMgr.Singleton:UpdateClientRedData("16836", missionRed + rewardRed + taskRed + playRed);
RedMgr.Singleton:UpdateClientRedData("16838", missionRed + playRed);
end

HeroRedDataHelper.SetRogueRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.RogueLike) then
        return false;
    end


    local rewardRed, taskRed = HeroRedDataHelper.GetPassesRed();
    local passRed = rewardRed + taskRed


    local missionRed = 0
    local missionRed_1 = 0
    local missionRed_2 = 0
    local missionRed_3 = 0
    local isFinish = true
    local activityData = DataExHelper.Check_ConfigQuestEventByGroupId(RogueMgr.GroupId_1)
    for index, value in ipairs(activityData) do
        local tempData = DataMgr.Player.quests[value.id]
        if tempData.state ~= 3 then
            isFinish = false
        end
        if tempData.state == 2 then
            if value.text == "XHYT1" then
                missionRed_1 = 1
            elseif value.text == "XHYT2" then
                missionRed_2 = 1
            elseif value.text == "XHYT3" then
                missionRed_3 = 1
            end
        end
    end
    missionRed = missionRed_1 + missionRed_2 + missionRed_3


    local eventRed = 0
    local eventHandbookCfgs = ConfigMgr.Config.RogueEventHandBooks
    local handEventRecords = DataMgr.Player.RogueHandbookRecords
    local eventRecords = DataMgr.Player.RogueEventRecords
    for i, v in ipairs(eventHandbookCfgs) do
        if not IsNull(eventRecords) and (IsNull(handEventRecords) or handEventRecords[tostring(v.Id)] == nil) then
            for j, n in ipairs(v.EventId) do
                if eventRecords[n] ~= nil then
                    eventRed = 1
                    break
                end
            end
        end
    end


    local techRed = RogueMgr.GetTechTreeRed()

    local rogueMain2Red = eventRed + techRed + missionRed

    local playRed = 0
    if not RogueMgr.CheckRogueLike2IsOpen() then

        if (RedMgr.Singleton:CheckRedCondition("16857") and not isFinish) then
            playRed = 1
        end
RedMgr.Singleton:UpdateClientRedData("16858", passRed);
RedMgr.Singleton:UpdateClientRedData("16902", 0);
RedMgr.Singleton:UpdateClientRedData("16857", passRed + playRed + rogueMain2Red);
RedMgr.Singleton:UpdateClientRedData("16903", 0);
    else

        if (RedMgr.Singleton:CheckRedCondition("16901") and not isFinish) then
            playRed = 1
        end
RedMgr.Singleton:UpdateClientRedData("16902", passRed);
RedMgr.Singleton:UpdateClientRedData("16858", 0);
RedMgr.Singleton:UpdateClientRedData("16901", passRed + playRed + rogueMain2Red);
RedMgr.Singleton:UpdateClientRedData("16903", passRed + playRed);
    end

RedMgr.Singleton:UpdateClientRedData("16856", rogueMain2Red);
RedMgr.Singleton:UpdateClientRedData("16865", eventRed);
RedMgr.Singleton:UpdateClientRedData("16859", techRed);
RedMgr.Singleton:UpdateClientRedData("16855", missionRed);
RedMgr.Singleton:UpdateClientRedData("16855_1", missionRed_1);
RedMgr.Singleton:UpdateClientRedData("16855_2", missionRed_2);
RedMgr.Singleton:UpdateClientRedData("16855_3", missionRed_3);
end



HeroRedDataHelper.SetAnalectRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.analect) then return end;
    local dataAnalects = DataMgr.Player.analects;
    local red_13002 = 0;
    local red_13003 = 0;
    local red_13004 = 0;
    for i, v in pairs(ConfigMgr.Config.AnalectsCpointMap) do
        if dataAnalects[v.ID] ~= nil then
            local key1 = DataMgr.Player.uid .. "_13002_" .. v.ID;
            local key2 = DataMgr.Player.uid .. "_13004_" .. v.ID;
            if PlayerPrefs.GetInt(key1) == 0 then
                RedMgr.Singleton:UpdateClientRedData("13002_" .. v.ID, 1);
                red_13002 = 1;
            elseif NumTool.GetLen(dataAnalects[v.ID].finishedDungeon) > 0 and PlayerPrefs.GetInt(key2) == 0 then
                RedMgr.Singleton:UpdateClientRedData("13002_" .. v.ID, 1);
                RedMgr.Singleton:UpdateClientRedData("13004_" .. v.ID, 1);
                red_13004 = 1;
            else
                RedMgr.Singleton:UpdateClientRedData("13004_" .. v.ID, 0);
                RedMgr.Singleton:UpdateClientRedData("13002_" .. v.ID, 0);
            end

            if dataAnalects[v.ID].received > 0 and not DataHelper.CheckNovelComplete(ConfigMgr.Config.AnalectsAtlasMap[v.ID].NovelId) then
                RedMgr.Singleton:UpdateClientRedData("13003_" .. v.ID, 1);
                red_13003 = 1;
            else
                RedMgr.Singleton:UpdateClientRedData("13003_" .. v.ID, 0);
            end
        else
            RedMgr.Singleton:UpdateClientRedData("13002_" .. v.ID, 0);
            RedMgr.Singleton:UpdateClientRedData("13003_" .. v.ID, 0);
            RedMgr.Singleton:UpdateClientRedData("13004_" .. v.ID, 0);
        end
    end
    RedMgr.Singleton:UpdateClientRedData("13003", red_13003);
    RedMgr.Singleton:UpdateClientRedData("13004", red_13004);
    RedMgr.Singleton:UpdateClientRedData("13001", red_13002 + red_13003 + red_13004);
end


HeroRedDataHelper.SetQinTourRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.QinTour) then return end;
    local dataQuests = DataMgr.Player.quests;

    local passes_rewardRed, passes_taskRed = HeroRedDataHelper.GetPassesRed();
    local shopRed = 0;
    local shopList = DataExHelper.Check_ConfigQuestEventByText("Qin2shop");

    for i, v in ipairs(shopList) do
        if not IsNull(v.cost) and v.cost[1].count == 0 then
            if dataQuests[v.id] ~= nil and dataQuests[v.id].progress < v.progress then
                shopRed = 1;
                break;
            end
        end
    end

    local lineRed = 0;
    for i, v in pairs(ConfigMgr.Config.TourMapMap) do
        local red = HeroRedDataHelper.GetQinLineRed(v.ScenicSpot)
        if red > 0 and not RedMgr.Singleton:CheckRedCondition("15003_" .. v.Id) then
            red = 0;
        end
        if red > 0 then
            lineRed = 1;
        end
        RedMgr.Singleton:UpdateClientRedData("15003_" .. v.Id, red);
    end

    RedMgr.Singleton:UpdateClientRedData("15002", passes_rewardRed + passes_taskRed);
    RedMgr.Singleton:UpdateClientRedData("15001", shopRed);
    RedMgr.Singleton:UpdateClientRedData("15000", passes_rewardRed + passes_taskRed + shopRed + lineRed);
end


HeroRedDataHelper.SetBranchAnecdoteRed = function()
    if DataExHelper.CommonActivityCheck(ActivityKey.BranchStory) then
        local playerData = DataMgr.Player.branch.children["Reg2001"]
        if not TableIsNull(playerData) and playerData.unlocked then
            for key_1, value_1 in pairs(playerData.children) do
                if value_1.unlocked then
                    for key_2, value_2 in pairs(value_1.children) do
                        if value_2.completed and not value_2.received then
                            RedMgr.Singleton:UpdateClientRedData("14051", 1)
                            return
                        end
                    end
                end
            end
        end
        RedMgr.Singleton:UpdateClientRedData("14051", 0)
    end
end


HeroRedDataHelper.SetCrisisContract = function()
    local redCount = 0
    if DataExHelper.CommonActivityCheck(ActivityKey.crisiscontract) then
        local mission = DataExHelper.Check_DataExByGroupId(2000)
        if not TableIsNull(mission) then
            for i = 1, #mission do
                if mission[i].state == 2 then
                    redCount = 1
                    break
                end
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("15013", redCount)
    return redCount
end

HeroRedDataHelper.GetQinLineRed = function(ScenicSpot)
    local dataFinishEvent = DataMgr.Player.tour.finishEvent
    if IsNull(dataFinishEvent) then
        return 0
    end;
    for i, v in ipairs(ScenicSpot) do
        if HeroRedDataHelper.CheckLineItemUnlock(v) then
            for j, p in ipairs(ConfigMgr.Config.TourSpotMap[v].TourEvent) do
                if dataFinishEvent[p] == nil then
                    return 1;
                end
            end
        end
    end
    return 0;
end

HeroRedDataHelper.CheckLineItemUnlock = function(id)
    local Unlock = ConfigMgr.Config.TourSpotMap[id].Unlock
    if IsNull(Unlock) then return true end;
    if Unlock[1] == "1" then

        return DataMgr.Player.level >= tonumber(Unlock[1]);
    elseif Unlock[1] == "2" then

        if not IsNull(DataMgr.Player.tour.finishEvent) and DataMgr.Player.tour.finishEvent[Unlock[3]] ~= nil then
            return true;
        end
        return false;
    end
end

HeroRedDataHelper.SetBossChallengeRed = function()
    local red_point_15011_result_map = {}
    local current_timestamp = LuaMgr.Timestamp()
    local challenge_bosses = DataMgr.Player.ChallengeBosses
    for _, config_boss in ipairs(ConfigMgr.Config.ChallengeBosses) do
        RedMgr.Singleton:UpdateClientRedData("15011_" .. config_boss.Id, 0)
        if challenge_bosses[config_boss.Id] ~= nil then
            local challenge_boss_data = challenge_bosses[config_boss.Id]
            if current_timestamp < challenge_boss_data.ChallengeTime then

                local record_time = UnityEngine.PlayerPrefs.GetInt(DataMgr.Player.uid ..
                    "BossChallenge_15011_" .. config_boss.Id)
                if record_time <= 0 then

                    red_point_15011_result_map[config_boss.Id] = 1
                else
                    if record_time < challenge_boss_data.ChallengeTime then
                        red_point_15011_result_map[config_boss.Id] = 1
                    else
                        red_point_15011_result_map[config_boss.Id] = 0
                    end
                end
            else

                red_point_15011_result_map[config_boss.Id] = 0
            end
        else

            red_point_15011_result_map[config_boss.Id] = 0
        end
    end

    local rewards = DataMgr.Player.ChallengeBossRankRewards
    if rewards ~= nil and #rewards > 0 then
        for i, v in ipairs(rewards) do
            if v.Status == 0 and red_point_15011_result_map[v.BossId] ~= nil then
                red_point_15011_result_map[v.BossId] = red_point_15011_result_map[v.BossId] + 1
            end
        end
    end

    local has_15010_red_point = 0
    for k, v in pairs(red_point_15011_result_map) do
        if v > 0 then
            RedMgr.Singleton:UpdateClientRedData("15011_" .. k, 1)
            has_15010_red_point = 1
        end
    end

    RedMgr.Singleton:UpdateClientRedData("15010", has_15010_red_point)
end

HeroRedDataHelper.GetLinearBagRed = function()
    local linearBagCfgs = ConfigMgr.Config.LinearBagMap
    local _cfgChargeMap = ConfigMgr.Config.charge
    for k, v in pairs(linearBagCfgs) do
        if v.Type == 0 then
            local chargeCfg = _cfgChargeMap[v.ChargeId];
            if not HeroRedDataHelper.IsOverdue(chargeCfg) then
                local isBought = chargeCfg.RefreshCount - DataHelper.GetShopRecordByGoodsId(v.ChargeId) <= 0
                if not isBought then
                    if IsNullOrEmpty(v.Unlock) or v.Unlock == 0 then
                        return 1
                    else
                        local preLinearBagCfg = linearBagCfgs[tostring(v.Unlock)]
                        local preChargeCfg = _cfgChargeMap[preLinearBagCfg.ChargeId];
                        local isUnlock = preChargeCfg.RefreshCount -
                            DataHelper.GetShopRecordByGoodsId(preLinearBagCfg.ChargeId) <= 0
                        if isUnlock then
                            return 1
                        end
                    end
                end
            end
        end
    end
    return 0
end

HeroRedDataHelper.CheckCurCardGiftCharacterRed = function()
    local redCount = 0
    local cardPools = ConfigHelper.GetCurCardPoolsData()
    for i, v in ipairs(cardPools) do
        if ActivityMgr.GetGiftCharacterRedCount(v.id) > 0 then
            redCount = 1
            break
        end
    end
    return redCount
end

HeroRedDataHelper.SetGiftCharacterRed = function()
    local showRed = DataExHelper.CommonCanFinishActivityCheck(ActivityKey.GiftCharacterOne);
    RedMgr.Singleton:UpdateClientRedData("16840", showRed and 1 or 0)

    showRed = DataExHelper.CommonCanFinishActivityCheck(ActivityKey.GiftCharacterTwo);
    RedMgr.Singleton:UpdateClientRedData("16841", showRed and 1 or 0)
end


HeroRedDataHelper.SetPackUpRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.PackUp) then
        return false;
    end
    local rewardRed, taskRed = HeroRedDataHelper.GetPassesRed();
    local otherRed = PackUpMgr.CheckEntranceRedDot()
RedMgr.Singleton:UpdateClientRedData("17002", rewardRed + taskRed);
RedMgr.Singleton:UpdateClientRedData("17001", rewardRed + taskRed + otherRed);
    RedMgr.Singleton:Refresh();
end


HeroRedDataHelper.SetYPSRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.YPS) then
        return false;
    end
    local rewardRed, taskRed = HeroRedDataHelper.GetPassesRed();
    local otherRed = YPSMgr.CheckEntranceRedDot()
RedMgr.Singleton:UpdateClientRedData("17204", rewardRed + taskRed);
RedMgr.Singleton:UpdateClientRedData("17201", rewardRed + taskRed + otherRed);
    RedMgr.Singleton:Refresh();
end


HeroRedDataHelper.SetXCHDRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.XCHD) then
        return false;
    end
    local rewardRed, taskRed = HeroRedDataHelper.GetPassesRed();
    local simulateRed = XCHDMgr.CheckSimulateRedDot();
    local otherRed = XCHDMgr.CheckEntranceRedDot()
RedMgr.Singleton:UpdateClientRedData("17212", rewardRed + taskRed);
RedMgr.Singleton:UpdateClientRedData("17211", rewardRed + taskRed + otherRed + simulateRed);
    RedMgr.Singleton:Refresh();
end


HeroRedDataHelper.SetWMFCRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.WMFC) then
        return false;
    end
    local rewardRed, taskRed = HeroRedDataHelper.GetPassesRed();
    local otherRed = WMFCMgr.CheckEntranceRedDot()
RedMgr.Singleton:UpdateClientRedData("17304", rewardRed + taskRed);
RedMgr.Singleton:UpdateClientRedData("17301", rewardRed + taskRed + otherRed);
    RedMgr.Singleton:Refresh();
end


HeroRedDataHelper.SetJSYZRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.JSYZ) then
        return false;
    end
    local rewardRed, taskRed = HeroRedDataHelper.GetPassesRed();
    local otherRed = JSYZMgr.CheckEntranceRedDot()
RedMgr.Singleton:UpdateClientRedData("17604", rewardRed + taskRed);
RedMgr.Singleton:UpdateClientRedData("17601", rewardRed + taskRed + otherRed);
    RedMgr.Singleton:Refresh();
end


HeroRedDataHelper.SetHMWYRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.HMWY) then
        return false;
    end
    local rewardRed, taskRed = HeroRedDataHelper.GetPassesRed();
    local otherRed = HMWYMgr.CheckEntranceRedDot()
RedMgr.Singleton:UpdateClientRedData("17824", rewardRed + taskRed);
RedMgr.Singleton:UpdateClientRedData("17820", rewardRed + taskRed + otherRed);
    RedMgr.Singleton:Refresh();
end


HeroRedDataHelper.SetRSDXRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.RSDX) then
        return false;
    end
    local rewardRed, taskRed = HeroRedDataHelper.GetPassesRed();
    RSDXMgr.Init();
    local otherRed = RSDXMgr.SetEventRed();
RedMgr.Singleton:UpdateClientRedData("17901", rewardRed + taskRed);
RedMgr.Singleton:UpdateClientRedData("17900", rewardRed + taskRed + otherRed);
    RedMgr.Singleton:Refresh();
end


HeroRedDataHelper.SetFSMYRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.FSMY) then
        return false;
    end
    local rewardRed, taskRed = HeroRedDataHelper.GetPassesRed();
    local otherRed = FSMYMgr.CheckEntranceRedDot()
RedMgr.Singleton:UpdateClientRedData("18101", rewardRed + taskRed);
RedMgr.Singleton:UpdateClientRedData("18100", rewardRed + taskRed + otherRed);
    RedMgr.Singleton:Refresh();
end


HeroRedDataHelper.SetBossDummy4Red = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.BossDummy4) then
        return false;
    end

    local missionRed, isFinish = BossDummy4Mgr.CheckMissionRed()
    local levelRewardRed = BossDummy4Mgr.CheckPlotLevelRed() and 1 or 0
    local playerRed = 0
    if (RedMgr.Singleton:CheckRedCondition("17022") and not isFinish) then
        playerRed = 1
    end

    RedMgr.Singleton:UpdateClientRedData("17021", missionRed + levelRewardRed + playerRed);
    RedMgr.Singleton:UpdateClientRedData("17023", missionRed);
    RedMgr.Singleton:Refresh();
end

HeroRedDataHelper.SetBossDummy5Red = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.BossDummy5) then
        return false;
    end

    local levelRewardRed = BossDummy5Mgr.CheckMissionRed()
    local playerRed = 0
    if (RedMgr.Singleton:CheckRedCondition("17860")) then
        playerRed = 1
    end

    RedMgr.Singleton:UpdateClientRedData("17860", levelRewardRed + playerRed);
    RedMgr.Singleton:UpdateClientRedData("17861", levelRewardRed);
    RedMgr.Singleton:Refresh();
end

HeroRedDataHelper.Clear = function()
    HeroRedDataHelper.archives_assess_BasicFileIDRedList = {};
    HeroRedDataHelper.archives_assess_SpecialFileIDRedList = {};
    HeroRedDataHelper.archives_assess_AvgFileIDRedList = {};
    HeroRedDataHelper.archives_saying_redList = {};

    HeroRedDataHelper.setting_avatarList = {};
    HeroRedDataHelper.setting_avatarFrameList = {};
    HeroRedDataHelper.setting_playerSkinsRedList = {};

    HeroRedDataHelper.backPack_giftRedList = {};
    HeroRedDataHelper.backpack_equipRedList = {}
    HeroRedDataHelper.shopRedList = {};
    HeroRedDataHelper.trafficPermit = {};

    LuaMgr.RemoveDataEventListener(HeroRedDataHelper.OnChangeData);
end



HeroRedDataHelper.GetPassesRed = function()
    local rewardRed = 0;
    local taskWeekRed = 0;
    local taskPeriodRed = 0;
    local cfgThemePass = nil;
    local dataPasses = nil;
    if IsNull(ConfigMgr.Config.PassesMap) then
        return 0, 0
    end
    for i, v in pairs(DataMgr.Player.passesMultiple) do
        if ConfigMgr.Config.PassesMap[v.id] ~= nil and ConfigMgr.Config.PassesMap[v.id].type == 2 then
            cfgThemePass = ConfigMgr.Config.PassesMap[v.id];
            dataPasses = v;
            break;
        end
    end

    if cfgThemePass == nil or dataPasses == nil then
        return 0, 0;
    end


    local isCharage = false;
    if not IsNull(dataPasses) and not IsNull(cfgThemePass.Charge1) and #cfgThemePass.Charge1 > 0 and dataPasses.payRecord[cfgThemePass.Charge1[1]] ~= nil then
        isCharage = true;
    end
    local count = DataHelper.GetItemCountById(cfgThemePass.Expitems);
    local passesLevel = math.floor(count / cfgThemePass.Exp);
    local dataPassesRewardsMultiple = DataMgr.Player.passesRewardsMultiple[cfgThemePass.Id];
    if not IsNull(dataPassesRewardsMultiple) then
        for i, v in pairs(dataPassesRewardsMultiple) do
            if passesLevel >= v.level and v.freeReceiveTime == 0 then

                rewardRed = 1;
                break;
            elseif passesLevel >= v.level and isCharage and v.payReceiveTime == 0 then

                rewardRed = 1;
                break;
            end
        end
    end

    if passesLevel < cfgThemePass.MaxLevel then
        local dataPassesTaskMultiple = DataMgr.Player.passesMissionsMultiple[cfgThemePass.Id];
        if not IsNull(dataPassesTaskMultiple) then

            for i, v in pairs(dataPassesTaskMultiple.weekly) do
                if not v.completed and v.current >= v.target then
                    taskWeekRed = 1;
                    break
                end
            end

            for i, v in pairs(dataPassesTaskMultiple.period) do
                if not v.completed and v.current >= v.target then
                    taskPeriodRed = 1;
                    break
                end
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("15005", taskWeekRed);
    RedMgr.Singleton:UpdateClientRedData("15006", taskPeriodRed);
    RedMgr.Singleton:UpdateClientRedData("15004", taskWeekRed + taskPeriodRed);
    RedMgr.Singleton:Refresh();
    return rewardRed, taskWeekRed + taskPeriodRed;
end


HeroRedDataHelper.CheckInOneYearRed = function()
    local red = 0;
    if DataExHelper.CommonActivityCheck(ActivityKey.checkInOneYear) then
        local checkInList = DataExHelper.Check_ConfigQuestEventByText("checkInOneYear")
        if not IsNull(checkInList) or #checkInList > 0 then

            local questData = DataMgr.Player.quests;
            local key = DataMgr.Player.uid .. "CheckInOnYear_Day30";
            local str = PlayerPrefs.GetString(key)
            if not IsNullOrEmpty(str) then
                local record = json.decode(str);
                for i, v in ipairs(checkInList) do
                    if questData[v.id] ~= nil and (record == nil or record[v.id] == nil) then
                        red = 1;
                    end
                end
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("16001", red);
end



HeroRedDataHelper.CheckIn7DaysRed = function()
    local red = 0;
    if DataExHelper.CommonActivityCheck(ActivityKey.checkIn7Days) then
        local checkInList = DataExHelper.Check_ConfigQuestEventByText("checkIn7DaysText")
        if not IsNull(checkInList) and #checkInList > 0 then
            local questData = DataMgr.Player.quests;
            for i, v in ipairs(checkInList) do
                if questData[v.id] ~= nil and questData[v.id].state == 2 then
                    red = 1;
                    break;
                end
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("16090", red);
end


HeroRedDataHelper.SetBrilliantGiftRed = function()
    local red = 0;
    if not DataExHelper.CommonActivityCheck(ActivityKey.BrilliantGift) then
        RedMgr.Singleton:UpdateClientRedData("16200", red);
        return;
    end

    local checkInRed = DataExHelper.Check_BrilliantGift() and 1 or 0;

    local taskRed = 0;
    local task1List = DataExHelper.Check_ConfigQuestEventByText("BrilliantGiftDay")
    local task2List = DataExHelper.Check_ConfigQuestEventByText("BrilliantGiftTotal")

    if #task1List > 0 then
        local taskListByDay = {}
        local dayCount = 0;
        for i, v in ipairs(task1List) do
            if taskListByDay[v.parameter] == nil then
                taskListByDay[tostring(v.parameter)] = {}
                dayCount = dayCount + 1;
            end
            table.insert(taskListByDay[tostring(v.parameter)], v);
        end
        for i = 1, dayCount, 1 do
            local tempRed = 0;
            for p, v in ipairs(taskListByDay[tostring(i)]) do
                if DataMgr.Player.quests[v.id] ~= nil and DataMgr.Player.quests[v.id].state == 2 then
                    tempRed = 1;
                    taskRed = 1;
                    break
                end
            end
            RedMgr.Singleton:UpdateClientRedData("16201_" .. i, tempRed);
        end
    end
    if taskRed == 0 and #task2List > 0 then
        for i, v in ipairs(task2List) do
            if DataMgr.Player.quests[v.id] ~= nil and DataMgr.Player.quests[v.id].state == 2 then
                taskRed = 1;
                break;
            end
        end
    end
    RedMgr.Singleton:UpdateClientRedData("16201", taskRed);
    RedMgr.Singleton:UpdateClientRedData("16202", checkInRed);
    RedMgr.Singleton:UpdateClientRedData("16200", taskRed + checkInRed);
end


HeroRedDataHelper.SetBrilliantTrialPlayRed = function()
    local red = 0
    local cardPool = ConfigHelper.GetCurCardPoolsData()
    if TableIsNull(cardPool) then
        return red
    end
    local length = #cardPool
    local character = nil
    local brilliantKey = nil
    for i = 1, length do
        character = ConfigCharacterMgr.GetInfo(cardPool[i].characterShow[1])
        if not TableIsNull(character) then
            brilliantKey = character.id .. character.rare
            if ConfigMgr.Config.BrilliantMap[brilliantKey] ~= nil then
                if PlayerCharacterMgr.RedHuanZhangReward(character.id) then
                    red = red + 1
                end
            end
        end
    end
    return red

end

HeroRedDataHelper.SetBossDummyRed = function()
    local red = 0;
    if not DataExHelper.CommonActivityCheck(ActivityKey.EventBoss) then
        RedMgr.Singleton:UpdateClientRedData("16301", red);
        return;
    end

    local is_16301_red = false

    for _, config in ipairs(ConfigMgr.Config.EventBosses) do
        local red = 0
        if DataMgr.Player.EventBosses[tostring(config.Id)] == nil then
            RedMgr.Singleton:UpdateClientRedData("16301" .. config.Id, 0)
        else
            local reward_group_configs = {}
            for _, v in ipairs(ConfigMgr.Config.EventBossRewards) do
                if v.Group == config.RewardGroup then
                    table.insert(reward_group_configs, v)
                end
            end
            local data = DataMgr.Player.EventBosses[tostring(config.Id)]
            local current_score = data.Damage

            local isRed = 0
            for _, v in ipairs(reward_group_configs) do
                if current_score >= v.Credit and DataMgr.Player.EventBosses[tostring(config.Id)].RewardRecords[tostring(v.Id)] == nil then
                    isRed = 1
                    break
                end
            end
            RedMgr.Singleton:UpdateClientRedData("16301_" .. config.Id, isRed)
            if isRed > 0 then
                is_16301_red = true
            end
        end
    end


    local score = ActivityMgr.GetEventBossesTotalScore()
    local isRed = 0
    for i, v in ipairs(ConfigMgr.Config.EventBossCreditRewards) do
        if score >= v.Credit and DataMgr.Player.EventBossTotalRewards[tostring(v.Id)] == nil then
            isRed = 1
            is_16301_red = true
            break
        end
    end

    RedMgr.Singleton:UpdateClientRedData("16301_1", isRed)


    is_16301_red = is_16301_red or RedMgr.Singleton:CheckRedCondition("15113")

    if is_16301_red then
        RedMgr.Singleton:UpdateClientRedData("16301", 1)
    else
        RedMgr.Singleton:UpdateClientRedData("16301", 0)
    end
end

HeroRedDataHelper.SetMiniBattle4Red = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.DualBattle2) then
        return false;
    end

    local isFinish = true
    local taskRed = 0;
    local taskList = DataExHelper.Check_DataExByGroupId(MiniBattle4Mgr.activityGroupId)
    for i, v in ipairs(taskList) do
        if v.state ~= 3 then
            isFinish = false
        end
        if v.state == 2 then
            taskRed = 1
            break
        end
    end

    local playRed = 0
    if (RedMgr.Singleton:CheckRedCondition("17220") and not isFinish) then
        playRed = 1
    end

    local plotRed = 0
    local seriesList = MiniBattle4Mgr.GetSeriesList()
    for i, seriesId in ipairs(seriesList) do
        local seriesRed = 0
        local plotList = MiniBattle4Mgr.GetPlotCfgList(seriesId)
        for j, cfg in ipairs(plotList) do
            local plotRed = 0
            local plotCfg = MiniBattle4Mgr.GetPlotCfg(cfg.ID)
            local len = #plotCfg.EnemyOption
            for n = len, 1, -1 do
                local status = MiniBattle4Mgr.GetPlotLevelStatus(plotCfg.EnemyOption[n])
                if status == 0 then
                    plotRed = 1
                    break
                end
            end

            RedMgr.Singleton:UpdateClientRedData("17222_" .. cfg.ID, plotRed);
            seriesRed = seriesRed + plotRed
        end
        RedMgr.Singleton:UpdateClientRedData("17222_" .. seriesId, seriesRed);
        plotRed = plotRed + seriesRed
    end

RedMgr.Singleton:UpdateClientRedData("17221", taskRed);
RedMgr.Singleton:UpdateClientRedData("17220", taskRed + plotRed + playRed);
end

HeroRedDataHelper.SetTeamWeaponRed = function()
    if FeatureManager.IsLock("33001") then
        return false;
    end
    local cultivateRed = TeamWeaponMgr.CheckAllTeamWeaponCultivateRed()
    local totalLevelRed = TeamWeaponMgr.CheckTotalLevelRed()

RedMgr.Singleton:UpdateClientRedData("17401", cultivateRed + totalLevelRed)
RedMgr.Singleton:UpdateClientRedData("17402", totalLevelRed);
end

HeroRedDataHelper.SetTeamRelay2Red = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.TeamRelay2) then
        return false;
    end

    local isFinish = true
    local taskRed = 0;
    local taskList = DataExHelper.Check_DataExByGroupId(TeamRelay2Mgr.activityGroupId)
    for i, v in ipairs(taskList) do
        if v.state ~= 3 then
            isFinish = false
        end
        if v.state == 2 then
            taskRed = 1
            break
        end
    end

    local playRed = 0
    if (RedMgr.Singleton:CheckRedCondition("17510") and not isFinish) then
        playRed = 1
    end

    local levelRed = 0
    local plotIds = TeamRelay2Mgr.GetPlotIds()
    for _, plotId in ipairs(plotIds) do
        local plotCfg = TeamRelay2Mgr.GetPlotCfg(plotId)
        for _, levelId in ipairs(plotCfg.Group) do
            local status = TeamRelay2Mgr.GetLevelStatus(levelId)
            if status == TeamRelay2Mgr.LevelStatus.CanClaim then
                levelRed = 1
                break
            end
        end
        if levelRed > 0 then
            break
        end
    end

RedMgr.Singleton:UpdateClientRedData("17511", taskRed);
RedMgr.Singleton:UpdateClientRedData("17512", levelRed);
RedMgr.Singleton:UpdateClientRedData("17510", taskRed + levelRed + playRed);
end


HeroRedDataHelper.MainPageCheckRed = function()
    HeroRedDataHelper.SetActivityRed();
    HeroRedDataHelper.ShowFlowerRed();
    HeroRedDataHelper.LuckyDrawRed();
    HeroRedDataHelper.SnackOnLineRed()
    HeroRedDataHelper.InitSettingRed();
    HeroRedDataHelper.InitCardPoolRed();
    HeroRedDataHelper.InitEquipCountRed();
    HeroRedDataHelper.InitCharacterRed();
    HeroRedDataHelper.FrushMainShopRed();

    HeroRedDataHelper.FrushTrafficPermitNewRed();
    HeroRedDataHelper.FrushTravelRed(true)
    HeroRedDataHelper.SetCheDanJiRed();
    HeroRedDataHelper.SetJoinJobRed();
    HeroRedDataHelper.SetChanganRed();
    HeroRedDataHelper.RefreshNianBeastRed();
    HeroRedDataHelper.SetHeroBranchRed()
    HeroRedDataHelper.SetSawPuzzleRed();
    HeroRedDataHelper.SetSIMRed();
    HeroRedDataHelper.SetZhongQiuJieRed();
    HeroRedDataHelper.SetAnalectRed();
    HeroRedDataHelper.SetQinTourRed();
    HeroRedDataHelper.SetBossChallengeRed();
    HeroRedDataHelper.SetGuoBaoRed();
    HeroRedDataHelper.SetSGYRed();
    HeroRedDataHelper.SetDungeon66Red();
    HeroRedDataHelper.SetSpringCampRed();
    HeroRedDataHelper.SetDHRed();
    HeroRedDataHelper.SetDH2Red();
    BalatroDataMgr.CheckRedDot()
    KingDeerData.CheckRedDot()
    HeroRedDataHelper.SetAnniversaryRed()
    HeroRedDataHelper.SetAnniversaryEntityFeedRed()
    HeroRedDataHelper.SetAnnualReportRed()
    HeroRedDataHelper.SetBrilliantGiftRed();
    HeroRedDataHelper.SetBossDummyRed()
    HeroRedDataHelper.SetZGCXRed()
    HeroRedDataHelper.SetMainLine1Red()
    HeroRedDataHelper.SetCrisisContract2Red()
    HeroRedDataHelper.SetCrisisContract3Red()
    HeroRedDataHelper.SetCrisisContract4Red()
    HeroRedDataHelper.SetMiniBattle2Red()
    HeroRedDataHelper.SetMiniBattle5Red()
    HeroRedDataHelper.SetKZRYRed()
    HeroRedDataHelper.SetWaterlilyRed()
    HeroRedDataHelper.SetRogueRed()
    HeroRedDataHelper.SetXingHaiXuYuRed()
    HeroRedDataHelper.SetLouYiZhuoMingRed()
    HeroRedDataHelper.SetZhiXiangLiuRed()
    HeroRedDataHelper.SetSuiChuNaJiRed()
    HeroRedDataHelper.SetSongShiYouXinRed()
    HeroRedDataHelper.SetYaoQingBackRed()
    HeroRedDataHelper.SetPackUpRed()
    HeroRedDataHelper.SetBossDummy4Red()
    HeroRedDataHelper.SetBossDummy5Red()
    HeroRedDataHelper.SetYPSRed()
    HeroRedDataHelper.SetMiniBattle4Red()
    HeroRedDataHelper.SetMiniBattle5Red()
    HeroRedDataHelper.SetXCHDRed()
    HeroRedDataHelper.SetWMFCRed()
    HeroRedDataHelper.SetJSYZRed()
    HeroRedDataHelper.SetHMWYRed()
    HeroRedDataHelper.SetRSDXRed()
    HeroRedDataHelper.SetFSMYRed()
    HeroRedDataHelper.SetTeamWeaponRed()
    HeroRedDataHelper.SetTeamRelay2Red()
    HeroRedDataHelper.CheckSignIn14ThreeRed();
    HeroRedDataHelper.CheckTeamTowerRed()
    HeroRedDataHelper.CheckTRJRed();
    HeroRedDataHelper.CheckRotateFLZPRed();
    HeroRedDataHelper.CheckTrainingSeries1Red();
end

HeroRedDataHelper.Init = function()
    LuaMgr.RemoveDataEventListener(HeroRedDataHelper.OnChangeData);
    LuaMgr.AddDataEventListener(HeroRedDataHelper.OnChangeData);
end


HeroRedDataHelper.OnChangeData = function(param)
    local strType = tostring(param[0])
    if strType == "items" then
        HeroRedDataHelper.InitTimePropRed()
        HeroRedDataHelper.InitBackPackRed();
    end
end

HeroRedDataHelper.GetEquipExchangeRed = function()
    if not ActivityMgr.ActivityRuning(ActivityKey.ExchangeItem) then
        return 0
    end
    if type(ConfigMgr.Config.constants.ExchangeEquipTasks) ~= "table" then
        return 0
    end
    local exchangeTimes = 0
    local totalCostCount = 0
    if DataMgr.Player.EquipExchange ~= nil then
        exchangeTimes = DataMgr.Player.EquipExchange.exchangeTotal
        totalCostCount = DataMgr.Player.EquipExchange.total
    end
    local totalPhaseCount = #ConfigMgr.Config.constants.ExchangeEquipTasks

    local exchangedCount = 0
    local curPhase = 0
    HeroRedDataHelper.recordListDatas = {}
    if HeroRedDataHelper.rewardItemCfg == nil then
        HeroRedDataHelper.rewardItemCfg = ConfigMgr.Config.constants.ExchangeEquipTaskReward[1]
    end
    for i = 1, exchangeTimes do
        local singleGoalCount = ConfigMgr.Config.constants.ExchangeEquipTasks[i]
        if i > totalPhaseCount then
            singleGoalCount = ConfigMgr.Config.constants.ExchangeEquipTasks[totalPhaseCount]
        end
        exchangedCount = exchangedCount + singleGoalCount
        curPhase = i + 1
        local data = HeroRedDataHelper.rewardItemCfg
        table.insert(HeroRedDataHelper.recordListDatas, #HeroRedDataHelper.recordListDatas + 1, data)
    end

    curPhase = math.min(curPhase, totalPhaseCount)
    curPhase = math.max(curPhase, 1)
    local goalCount = ConfigMgr.Config.constants.ExchangeEquipTasks[curPhase]
    local costCount = totalCostCount - exchangedCount
    if costCount >= goalCount then
        return 1
    end
    return 0
end

HeroRedDataHelper.CheckSignIn14ThreeRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.SignIn14Three) then
        RedMgr.Singleton:UpdateClientRedData("1316", 0)
        return;
    end
    local re = ActivityMgr.ActivityCanFinish(ActivityKey.SignIn14Three);
    local redNum = re and 1 or 0
    RedMgr.Singleton:UpdateClientRedData("1316", redNum)
end

HeroRedDataHelper.CheckTeamTowerRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.TeamTower) then
        RedMgr.Singleton:UpdateClientRedData("17620", 0)
        return 0;
    end
    local rewardRed = 0
    local levelRed = 0
    local data = TeamTowerMgr.GetTeamTowerData()
    for i, v in pairs(data.Reward) do
        if v == 0 then
            rewardRed = 1
            break
        end
    end
    local levelConfig = ConfigMgr.Config.TeamTowerFloorMap[TeamTowerMgr.GetCurChallengeTowerId()]
    if RedMgr.Singleton:CheckRedCondition("17622") and levelConfig.GroupID == "1" then
        levelRed = 1;
    end
    RedMgr.Singleton:UpdateClientRedData("17621", rewardRed)
    RedMgr.Singleton:UpdateClientRedData("17622", levelRed)
    RedMgr.Singleton:UpdateClientRedData("17620", levelRed + rewardRed)
    return levelRed + rewardRed
end


HeroRedDataHelper.CheckTRJRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.ZNHD) then
        return;
    end
    local checkRed = 0;
    local passesCfg = ConfigMgr.Config.PassesMap["10002"];
    local passesMultiple = DataMgr.Player.passesMultiple["10002"];
    if passesCfg ~= nil and passesMultiple ~= nil and passesMultiple.endTime - LuaMgr.Timestamp() > 0 then
        local isPay = not IsNull(passesMultiple) and not IsNull(passesMultiple.payRecord) and
            passesMultiple.payRecord[passesCfg.Charge1[1]] ~= nil;


        local dataPassesRewardsMultiple = DataMgr.Player.passesRewardsMultiple[passesCfg.Id];
        local dataMissions = DataMgr.Player.passesMissionsMultiple[passesCfg.Id].period;
        if not IsNull(dataPassesRewardsMultiple) then
            for i, v in pairs(dataPassesRewardsMultiple) do
                local rewardsCfg = ConfigMgr.Config.PassesRewardMap[v.id]
                local isCan = dataMissions[rewardsCfg.TaskId].completed;
                if isCan and v.freeReceiveTime == 0 then

                    checkRed = 1;
                    break;
                elseif isCan and isPay and v.payReceiveTime == 0 then

                    checkRed = 1;
                    break;
                end
            end
        end
    end
    local rotateRed = 0;


    local cfgDrawActive = ConfigMgr.Config.DrawActivityMap["60001"]
    if cfgDrawActive ~= nil then
        local drawCount = 1;
        if not IsNull(DataMgr.Player.drawRewardRecords) then
            for i, v in ipairs(cfgDrawActive.Content) do
                local key = string.format("%s_%s", "60001", v);
                if DataMgr.Player.drawRewardRecords[key] ~= nil then
                    drawCount = drawCount + DataMgr.Player.drawRewardRecords[key];
                end
            end
        end
        if drawCount > #cfgDrawActive.Consume then
            drawCount = #cfgDrawActive.Consume;
        end
        local cost = cfgDrawActive.Consume[drawCount];
        if cost.count == 0 then
            rotateRed = 1;
        end
    end

    local freeRed = 0;
    local questCelebrationFree = DataExHelper.Check_ConfigQuestEventByText("ZNFLFree")
    if not IsNull(questCelebrationFree) then
        local questConfig = questCelebrationFree[1]
        local questData = DataMgr.Player.quests[questConfig.id]
        if questData ~= nil and questData.state == 2 then
            freeRed = 1;
        end
    end
    RedMgr.Singleton:UpdateClientRedData("17642", rotateRed)
    RedMgr.Singleton:UpdateClientRedData("17641", checkRed)
    RedMgr.Singleton:UpdateClientRedData("17643", freeRed)
    RedMgr.Singleton:UpdateClientRedData("17640", checkRed + rotateRed + freeRed)
end



HeroRedDataHelper.CheckRotateFLZPRed = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.FLZP) then
        return;
    end
    local rotateRed = 0;

    local cfgDrawActive = ConfigMgr.Config.DrawActivityMap["60001"]
    if cfgDrawActive ~= nil then
        local drawCount = 1;
        if not IsNull(DataMgr.Player.drawRewardRecords) then
            for i, v in ipairs(cfgDrawActive.Content) do
                local key = string.format("%s_%s", "60001", v);
                if DataMgr.Player.drawRewardRecords[key] ~= nil then
                    drawCount = drawCount + DataMgr.Player.drawRewardRecords[key];
                end
            end
        end
        if drawCount > #cfgDrawActive.Consume then
            drawCount = #cfgDrawActive.Consume;
        end
        local cost = cfgDrawActive.Consume[drawCount];
        if cost.count == 0 then
            rotateRed = 1;
        end
    end
    RedMgr.Singleton:UpdateClientRedData("17642", rotateRed)
end



return HeroRedDataHelper