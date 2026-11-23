




ConfigHelper = {}

function ConfigHelper.GetItemById(id)
    return ConfigMgr.Config.itemMap[id];
end

function ConfigHelper.GetItemIconPath(id)
    if ConfigMgr.Config.itemMap[id] ~= nil and ConfigMgr.Config.itemMap[id].Icon ~= "" then
        return Path.item_PATH .. "itemicon_" .. ConfigMgr.Config.itemMap[id].Icon .. ".png";
    else
        return Path.item_PATH .. "itemicon_" .. tostring(id) .. ".png";
    end
end

function ConfigHelper.GetItemHomeIconPath(id)
    if ConfigMgr.Config.itemMap[id] ~= nil and ConfigMgr.Config.itemMap[id].Icon ~= "" then
        return Path.item_PATH .. "itemicon_home_" .. ConfigMgr.Config.itemMap[id].Icon .. ".png";
    else
        return Path.item_PATH .. "itemicon_home_" .. tostring(id) .. ".png";
    end
end


ConfigHelper.AttrDes = {}
function ConfigHelper.GetAttrDes(key)
    if not ConfigHelper.AttrDes or next(ConfigHelper.AttrDes) == nil then
        for key, value in pairs(ConfigMgr.Config.additionalAttrs) do
            ConfigHelper.AttrDes[value.addAttr] = value
        end
    end
    return ConfigHelper.AttrDes[key]
end



ConfigHelper.ExpDes = {}
function ConfigHelper.ExpGoodsDes()
    if not ConfigHelper.ExpDes or next(ConfigHelper.ExpDes) == null then
        local data = {}
        for i = 1, 5 do
            data["ID"] = "230" .. i
            data["value"] = ConfigMgr.Config.itemMap[data["ID"]].drop
            table.insert(ConfigHelper.ExpDes, 1, data)
            data = {}
        end
    end
end

function ConfigHelper.GoodsTime(expireTime)
    local residueTime = expireTime - LuaMgr.Timestamp()
    if residueTime >= 86400 then
        return math.floor(residueTime / 86400) .. LuaMgr.GetLangText("ConfigHelper_0")
    elseif residueTime < 86400 and residueTime >= 3600 then
        return math.floor(residueTime / 3600) .. LuaMgr.GetLangText("ConfigHelper_1")
    elseif residueTime < 3600 and residueTime >= 60 then
        return math.floor(residueTime / 60) .. LuaMgr.GetLangText("ConfigHelper_2")
    elseif residueTime < 60 then
        return "1"..LuaMgr.GetLangText("ConfigHelper_2")
    end
end

function ConfigHelper.GetChargeChannel(chargeGroup)
    local channel = "";
    local platform = LuaMgr.GetPlatform();
    if platform == "IOS" then
        channel = "apple";
    else
        channel = "1";
    end
    if LuaMgr.IsOneSDK() then
        channel = LuaMgr.GetChanel();
    end
    for i, v in pairs(ConfigMgr.Config.chargeChannel) do
        if v.ChannelType == channel and v.ChargeGroup == chargeGroup then
            return v;
        end
    end

    print("检查chargechannel表中是否存在 : " .. chargeGroup);
    return nil;
end

function ConfigHelper.GetAreaEventByDungoenId(dungoenId)
    local areaEventMap = ConfigMgr.Config.areaEvents
    for i, v in pairs(areaEventMap) do
        if v.eventParam == dungoenId then
            return v;
        end
    end
end


function ConfigHelper.GetTableLength(table)
    local length = 0
    if TableIsNull(table) then
        return length
    end
    for key, value in pairs(table) do
        length = length + 1
    end
    return length
end

function ConfigHelper.GetItemNamelan(id)
    local item = ConfigMgr.Config.itemMap[id];
    return item ~= nil and item.nameLan or "";
end


function ConfigHelper.GetMonsterAvatarPath(monsterId)
    local monsterInfo = ConfigMgr.Config.monsterMap[monsterId];
    if monsterInfo == nil then return "" end
    ;
    local avatarPath = Path.Monster_PATH .. monsterInfo.monsterModel .. "/Avatar/" .. monsterInfo.monsterSkin .. ".png";
    return avatarPath;
end


function ConfigHelper.GetMonsterRoundPath(monsterId)
    local monsterInfo = ConfigMgr.Config.monsterMap[monsterId];
    if monsterInfo == nil then return "" end
    ;
    local avatarPath = Path.Monster_PATH .. monsterInfo.monsterModel .. "/Avatar_Round/" ..
    monsterInfo.monsterSkin .. ".png";
    return avatarPath;
end


function ConfigHelper.GetCharacterAvatarPath(characterId, skinId)
    local characterPath;
    if skinId ~= nil then
        characterPath = Path.Character_PATH .. characterId .. "/Avatar/" .. skinId .. ".png";
    else
        characterPath = Path.Character_PATH .. characterId .. "/Avatar/" .. characterId .. "001.png";
    end
    return characterPath;
end


function ConfigHelper.GetCharacterRoundPath(characterId, skinId)
    local characterPath;
    if skinId ~= nil then
        characterPath = Path.Character_PATH .. characterId .. "/Avatar_Round/" .. skinId .. ".png";
    else
        characterPath = Path.Character_PATH .. characterId .. "/Avatar_Round/" .. characterId .. "001.png";
    end
    return characterPath;
end


function ConfigHelper.GetHeadIconPath(characterId, skinId)
    local headIcon;
    if skinId == nil or skinId == "" then
        headIcon = Path.HeadIcon_PATH .. characterId .. ".png";
    else
        if not string.match(skinId, characterId) then
            skinId = characterId .. skinId
        end
        headIcon = string.format("%s%s/Avatar/%s.png", Path.Character_PATH, characterId,
            skinId);
        if not LuaMgr.HasAsset(headIcon) then
            headIcon = string.format("%s%s/Avatar/%s%s.png", Path.Character_PATH, characterId, characterId,
                "001");
        end
    end
    return headIcon;
end

function ConfigHelper.GetHeroDrawingTexture(characterId, skinId)
    local path = string.format("%s%s/Drawing/%s.png", Path.Character_PATH, characterId, skinId)
    return LuaMgr.GetTexture(path);
end


function ConfigHelper.GetHeroCard(characterId, skinId)
    local path = string.format("%s%s/Cards/%s.png", Path.Character_PATH, characterId, skinId)
    return LuaMgr.GetTexture(path);
end


function ConfigHelper.GetHeroSkinConfig(skinId)
    if IsNullOrEmpty(skinId) then return nil end;
    local characterId = string.sub(skinId, 1, string.len(skinId) - 3)
    local skinConfig = nil
    if ConfigMgr.Config.characterSkins==nil then
        return nil;
    end
    local skinTable = ConfigMgr.Config.characterSkins[characterId]
    if skinTable==nil then return nil end;
    if not TableIsNull(skinTable) then
        for i = 1, #skinTable do
            if skinTable[i].skinID == skinId then
                skinConfig = skinTable[i]
                break
            end
        end
    end
    return skinConfig
end




function ConfigHelper.GetRareSprite(rare)
    return LuaMgr.GetSprite("ItemRare", "itemRare" .. rare)
end




function ConfigHelper.GetItemTexture(id)
    local cfgItem = ConfigMgr.Config.itemMap[id]
    if cfgItem.Icon ~= nil and cfgItem.Icon ~= "" then
        return LuaMgr.GetTexture("Images/ItemIcons/itemicon_" .. cfgItem.Icon .. ".png");
    end
    return LuaMgr.GetTexture("Images/ItemIcons/itemicon_" .. id .. ".png");
end

function ConfigHelper.GetItemTexture_large(id)
    local textrue = LuaMgr.GetTexture("Images/ItemIcons/itemicon_home_" .. id .. "_large.png");
    if textrue ~= nil then
        return textrue;
    end

    return ConfigHelper.GetItemTexture(id)
end


function ConfigHelper.GetFriendlyLevelText(level)
    return LuaMgr.GetLangText(ConfigMgr.Config.friendshipDescription[tostring(level)].iconDescriptionLan)
end


function ConfigHelper.GetFriendlyLevelAllText(level)
    return LuaMgr.GetLangText(ConfigMgr.Config.friendshipDescription[tostring(level)].descriptionLan)
end



function ConfigHelper.CreateGoodsItem(items_id, items_count, scale, isCount, isClick)
    local item = ConfigMgr.Config.itemMap[tostring(items_id)];
    if item == nil then return nil end
    ;
    local rewardItem = {
        id = tostring(items_id),
        count = LuaMgr.NumFormat(items_count),
        isCount = isCount,
        rare = ConfigHelper.GetRareSprite(item.rare),
        icon = ConfigHelper.GetItemTexture(items_id),
        scale = Vector3(1 * scale, 1 * scale, 1),
        sizeDelta = Vector2(128 * scale, 128 * scale),
        isClick = isClick
    }
    return rewardItem;
end


function ConfigHelper.CreateEquipItem(equip_id, scale, isClick)
    local cfgEquip = ConfigMgr.Config.equipments[equip_id];
    local equip = {
        itemId = tostring(equip_id),
        contentLocalPos = Vector3(0, 0, 0),
        rareIcon = ConfigHelper.GetRareSprite(cfgEquip.rare),
        icon = ConfigHelper.GetItemTexture(tostring(equip_id)),
        scale = Vector3(1 * scale, 1 * scale, 1 * scale),
        level = string.format("lv.1"),
        star1 = true,
        weaponBtnBool = false,
        isClick = isClick
    };
    return equip;
end


function ConfigHelper.GetAttrNameStr(attrId)
    if attrId == nil or attrId == "" then return end
    local attrName,attrValue,attrType = "","",""
    local talentBank = ConfigMgr.Config.talentBankMap[attrId]
    if talentBank == nil then return end

    local attrDesLength = NumTool.GetStringLength(talentBank.talentParam1)
    local attrDes = NumTool.split(LuaMgr.SubstringLen(talentBank.talentParam1,1,attrDesLength - 2),',')
    if attrDes[1] == "EnergyRecoveryCycle_FIX" then

        attrValue = LuaMgr.Division(tonumber(attrDes[2]), 100)
    else
        attrValue = attrDes[2]
    end
    local result = ConfigMgr.Config.attrDesMap[attrDes[1]];
    if (result ~= nil) then
        attrName = LuaMgr.GetLangText(result.NameLan);
        attrType = result.attrDisplayType;
    end
    return attrName,attrValue,attrType,attrDes[1];
end


ConfigHelper.GetShareStatus = function(type)
    local channelId = LuaMgr.GetChanel();
    local shareChannel = ConfigMgr.Config.ShareChannel;
    for _, v in pairs(shareChannel) do
        if (v.ChannelId == channelId) then
            return not v[type];
        end
    end
    return false;
end

ConfigHelper.ItemName=function(id)
    if ConfigMgr.Config.itemMap[tostring(id)]==nil then return "" end;
    return LuaMgr.GetLangText(ConfigMgr.Config.itemMap[id].nameLan);
end

ConfigHelper.GetHomeBgTexture=function()

    if not TableIsNull(ConfigMgr.Config.BGSwitchMap) then
        local currentBgImage = DataMgr.Player.currentBgImage;
        local bgConfig = ConfigMgr.Config.BGSwitchMap[currentBgImage];
        if (bgConfig ~= nil) then
            return bgConfig.Image;
        end
    end
    return "ui_home_bj_di";













end

ConfigHelper.GetCurCardPoolsData=function()
    local curCards={}
    local curTime=LuaMgr.Timestamp();
    for i,v in pairs(ConfigMgr.Config.cardPools) do
        if not v.hidden and v.SWdungeons>0 and (v.type=="time" or v.type=="limited") and v.kind=="draw" and curTime>=v.startTime and curTime<v.endTime then
            table.insert(curCards,v);
        end
    end
    table.sort(curCards,function(a, b) return a.kindNum<b.kindNum  end)
    return curCards;
end

ConfigHelper.GetCurLimitCardPoolsData=function()
    local curCards={}
    local curTime=LuaMgr.Timestamp();
    for i,v in pairs(ConfigMgr.Config.cardPools) do
        if not v.hidden and (v.type=="limited") and v.kind=="draw" and curTime>=v.startTime and curTime<v.endTime then
            table.insert(curCards,v);
        end
    end
    table.sort(curCards,function(a, b) return a.kindNum<b.kindNum  end)
    return curCards;
end

ConfigHelper.MsgReplacePlayerByName=function(msg)
    if string.match(msg,"player") then
        msg=LuaMgr.Replace(msg,"player",DataMgr.Player.name)
    end
    if string.match(msg,"Player") then
        msg=LuaMgr.Replace(msg,"Player",DataMgr.Player.name)
    end
    if string.match(msg,"<Player>") then
        msg=LuaMgr.Replace(msg,"<Player>",DataMgr.Player.name)
    end
    if string.match(msg,"<player>") then
        msg=LuaMgr.Replace(msg,"<player>",DataMgr.Player.name)
    end
    return msg;
end

function ConfigHelper.GetAvatarFrame(id)
    local avatarFrame;
    local avatarFrames = ConfigMgr.Config.avatarFrames;
    local len = #avatarFrames;
    for i = 1, len do
        avatarFrame = avatarFrames[i];
        if (avatarFrame.id == id) then
            return avatarFrame;
        end
    end
    return nil;
end

function ConfigHelper.GetActivityGroupIdByKey(key)
    local activityGroupId = 0
    for i,v in pairs(ConfigMgr.Config.activityGroup) do
        if v.key == key then
            activityGroupId = v.id
            break
        end
    end
    return activityGroupId
end

function ConfigHelper.GetGoodsPriceStr(goodsId)
    local charge = ConfigMgr.Config.charge[goodsId]
    local RMBPrice = ""
    if charge.ChargeGroup~=nil and charge.ChargeGroup~="" then
        local chargeChanel=ConfigHelper.GetChargeChannel(charge.ChargeGroup)
        RMBPrice=chargeChanel.CurrencySymbol..chargeChanel.PriceShow
    end
    return RMBPrice
end

function ConfigHelper.InitAvatarDatas()
    if ConfigHelper.Avatar2ItemDatas == nil or ConfigHelper.Item2AvatarDatas == nil then
        ConfigHelper.Avatar2ItemDatas = {}
        ConfigHelper.Item2AvatarDatas = {}
        for key, value in pairs(ConfigMgr.Config.avatarFrames) do
            ConfigHelper.Avatar2ItemDatas[value.id] = value
            if value.unlockType == 2 and value.unlock ~= "0" then

                ConfigHelper.Item2AvatarDatas[value.unlock] = value
            end
        end
    end
end

function ConfigHelper.IsAlreadyHadAvatarByItemID(itemID)
    ConfigHelper.InitAvatarDatas()
    local avatarConfig = ConfigHelper.Item2AvatarDatas[tostring(itemID)]
    if avatarConfig == nil then
        LuaDebug.error("头像配置有误 itemID:" .. itemID)
        return false
    end
    return DataMgr.Player.avatarFrameMap[avatarConfig.id] ~= nil
end

function ConfigHelper.GetNovelRewardByEventID(eventID)
    local config = ConfigMgr.Config.narrativeMap[eventID]
    if type(config) == "nil" then
        return {}
    end
    return ConfigHelper.GetRewardListByDrop(config.fixedDrop) or {}
end

function ConfigHelper.GetRewardListByDrop(drop)
    if IsNull(drop) then return nil end;
    local list={}
    for i,v in ipairs(drop) do
        local dropInfo=ConfigMgr.Config.dropMap[v.id];
        if dropInfo~=nil then
            for p,m in pairs(dropInfo.items) do
                table.insert(list,{id=m.id,count=m.count*v.count,weight=v.weight})
            end
        end
    end
    return list;
end


function ConfigHelper.CheckCharacterHighSkin(characterId,skinId)
    local cfgSkin=ConfigHelper.GetHeroSkinConfig(skinId);
    if cfgSkin~=nil and cfgSkin.highskin~=nil and cfgSkin.highskin==1 and not IsNull(ConfigMgr.Config.constants.HighSkinLineWeight) then

        local skinLineWeight=ConfigMgr.Config.constants.HighSkinLineWeight;
        if #skinLineWeight>0 then
            local maxWeight=skinLineWeight[#skinLineWeight];
            math.randomseed(LuaMgr.Timestamp());
            local randomWeight=math.random(1,maxWeight);
            local index=1;
            for i,v in ipairs(skinLineWeight) do
                if randomWeight>v then
                    index=index+1;
                end
            end
            if index>1 then
                return skinId;
            else
                return characterId.."001";
            end
        end
        return characterId.."001";
    end
    return skinId;
end

function ConfigHelper.CheckGiftListByTime(giftList)
    if TableIsNull(giftList) then
        return {}
    end
    local _cfgChargeMap= ConfigMgr.Config.charge
    local curTime = LuaMgr.Timestamp()
    local newGiftList = {}
    for i, v in ipairs(giftList) do
        local chargecfg =_cfgChargeMap[v.Id];
        if chargecfg.StartTime <= curTime and chargecfg.EndTime >= curTime then
            table.insert(newGiftList, v)
        end
    end
    return newGiftList
end


function ConfigHelper.ShowItemTips(itemId,isHave)
    local time=nil;
    local type=nil;
    local dataItem=DataMgr.Player.items[itemId];
    if ConfigMgr.Config.itemMap[itemId]~=nil then
        type=ConfigMgr.Config.itemMap[itemId].type;
    end
    if dataItem~=nil then
        if not IsNull(dataItem.counts) and #dataItem.counts>0 and #dataItem.counts[1]>1 then
            time=dataItem.counts[1][2];
        end
    end 
    if time ~= nil then
        LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,itemId,true,true,true,time)
    elseif time == nil and type== 11 then
        LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,itemId,false,false,false,0)
    else
        if isHave ~= nil then
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,itemId,true,true,true)
        else
            LuaMgr.ShowPanel(UIName.GoodsTipsViewModel,itemId,false,false,false)
        end
    end
end


function ConfigHelper.GetHeroSpecialityAllPoint(level)
    if level == nil then
        return 0
    end
    if level < ConfigMgr.Config.constants.ShenzaoUnlock then
        return 0
    end
    if ConfigMgr.Config.constants["JobStyleSkillPointNew"] == nil then
        return 0
    end
    if TableIsNull(ConfigMgr.Config.constants.JobStyleSkillPointNew) then
        return 0
    end
    local length = #ConfigMgr.Config.constants.JobStyleSkillPointNew
    if level == ConfigMgr.Config.constants.maxCharacterLevel then
        return length
    end
    for i = 1, length do
        if ConfigMgr.Config.constants.JobStyleSkillPointNew[i] > level then
            return i - 1
        end
    end
end


function ConfigHelper.IsLimitCount(dungeonId)
    if TableIsNull(ConfigMgr.Config.constants.DungeonLimit) then
        return false
    end
    for i = 1, #ConfigMgr.Config.constants.DungeonLimit do
        if ConfigMgr.Config.constants.DungeonLimit[i] == dungeonId then
            return true,i
        end
    end
    return false
end


function ConfigHelper.GetTitleConfig(id)
    local tempId,titleConfig = nil,nil
    if not IsNullOrEmpty(id) then
        tempId = id
    else
        tempId = ConfigMgr.Config.constants.DefaultTitle
    end
    titleConfig = ConfigHelper.GetAvatarFrame(tempId)
    return titleConfig
end

return ConfigHelper;