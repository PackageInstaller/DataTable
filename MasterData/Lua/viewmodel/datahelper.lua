




DataHelper = {
    firstMainPage = false,
    isFirstLogin = false,
}



function DataHelper.GetItemCountById(id)
    return LuaMgr.GetItemCountById(id);
end


function DataHelper.ConditionCheck(id,count,func)
    if DataHelper.GetItemCountById(id) >= count then
        func()
    else
        local name = LuaMgr.GetLangText(ConfigMgr.Config.itemMap[id].nameLan)
        local callBack = function()

            LuaMgr.HidePanels();
            FeatureManager.GotoPanel("1210","charge")
        end
        if id == "1" then
            local exchangeConfig = ConfigItemMgr.GetItemExchangeConfig("2_1")
            local needPay = math.ceil((count - DataHelper.GetItemCountById(id)) / (exchangeConfig.GetNum / exchangeConfig.CostNum))
            if DataHelper.GetItemCountById("2") >= needPay then
                local tipStr = string.format(LuaMgr.GetLangText("DataHelper_0"),name,needPay,LuaMgr.GetLangText(ConfigMgr.Config.itemMap["2"].nameLan))
                local item1 = {ID = "2",Count = needPay}
                local item2 = {ID = "1",Count = needPay * (exchangeConfig.GetNum / exchangeConfig.CostNum)}
                local data = {[1] = item1,[2] = item2}
                LuaMgr.ShowGoodsConver(json.encode(data),tipStr,func)
            else
                if LuaMgr.IsPanelOpen(UIName.BaseShopViewModel) then
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,name..LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2184"].NameLan));
                    return;
                end
                local tipStr = name..LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2022"].NameLan)
                LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,tipStr,callBack,nil)
            end
        elseif id == "2" then
            local tipStr = name..LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2022"].NameLan)
            LuaMgr.ShowPanel(UIName.ConfirmSmallViewModel,tipStr,callBack,nil)
        elseif id == "3" then
            local tipStr = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["2100"].NameLan)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(tipStr,name));
        else
            local tipStr=LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["1601"].NameLan);
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel,string.format(tipStr,name));
        end
        
    end
end


function DataHelper.GetCharacterSkin(characterId)
    local characterData = DataMgr.Player.characters[characterId]
    if characterData ~= nil then
        return characterData.curSkin
    end
    return characterId.."001"
end



function DataHelper.GetShopRecordByGoodsId(goodsId)
    local count=DataMgr.Player.shop.records[goodsId];
    return count~=nil and count or 0;
end



DataHelper.TeamsContains = function(id)
    for key, value in pairs(DataMgr.Player.teams) do
            for memberkey, membervalue in pairs(value.members) do
                if id == membervalue then            
                    return true
                end
            end
        end
    return false
end



DataHelper.GetRechargeCount=function(chargeId)
    if DataMgr.Player.recharges==nil or DataMgr.Player.recharges[chargeId]==nil then
        return 0;
    else
        return DataMgr.Player.recharges[chargeId]
    end
    
end


DataHelper.GetNovelState = function(novelId)
    local pConfig = nil
    for i = 1, #ConfigMgr.Config.MainPlotMap do
        if ConfigMgr.Config.MainPlotMap[i].PlotId[1] == novelId then
            pConfig = ConfigMgr.Config.MainPlotMap[i]
            break
        end
    end
    if pConfig ~= nil then
        if pConfig.AreaDungeon ~= "" then
            if DataMgr.Player.completedAreaEvents[pConfig.AreaDungeon] ~= nil then
                return true
            end
        else
            for i = 1, #DataMgr.Player.completedChapters do
                if DataMgr.Player.completedChapters[i] == novelId then
                    return true
                end
            end
        end
    end
    return false
end

DataHelper.IsCompleteNovel=function(novelId)
    local completeNovels=DataMgr.Player.completedChapters;
    for i,v in ipairs(completeNovels) do
        if v==novelId then
            return true;
        end
    end
    return false;
end

DataHelper.IsCompleteDungeon=function(dungeonID)
    return DataMgr.Player.dungeonRecords[dungeonID]~=nil and DataMgr.Player.dungeonRecords[dungeonID].completeCount>0
end



DataHelper.SetAvatar = function(rawImageHero)
    local avatarFrames = ConfigMgr.Config.avatarFrames;
    local avatar = DataMgr.Player.Avatar;
    local avatarData;
    local len = #avatarFrames;
    for i = 1, len do
        avatarData = avatarFrames[i];
        if (avatarData.id == avatar) then
            break;
        else
            avatarData = nil;
        end
    end

    if (avatarData ~= nil) then
        rawImageHero.texture = LuaMgr.GetTexture( ConfigHelper.GetHeadIconPath(avatarData.img, avatarData.imgId));
    end
end


DataHelper.IsContainsSkin = function(characterId, skinId)
    if skinId == characterId.."001" then 
        return true 
    end
    
    if DataMgr.Player.characterSkins[characterId] == nil then 
        return false
    end
    
    for i = 1, #DataMgr.Player.characterSkins[characterId] do
        if DataMgr.Player.characterSkins[characterId][i] == skinId then
            return true
        end
    end
    
    return false
end

DataHelper.SettingSkinLogo = function(resLOGO,logoStr)
    local _bool = false
    for i = 1, #resLOGO do
        if resLOGO[i] == logoStr then
            _bool = true
            break
        end
    end
    return _bool
end


DataHelper.CheckIsBirthDay=function()
    if DataMgr.Player.birthday==nil or DataMgr.Player.birthday=="" then
        return false;
    end
    local birArray=NumTool.split(DataMgr.Player.birthday,"/");
    local nowDate=os.date("*t",LuaMgr.Timestamp())
    if tonumber(birArray[2])==nowDate.month and tonumber(birArray[3])==nowDate.day then
        return true;
    else
        return false;
    end
end


DataHelper.GetChargeByShelf = function(payId)
    local chargeMap = ConfigMgr.Config.charge;
    for _, v in pairs(chargeMap) do
        if (v.Shelf == payId) then
            return v;
        end
    end
    return nil;
end


DataHelper.CheckFristPay = function(payId)
    local charge = DataHelper.GetChargeByShelf(payId);
    if (charge == nil) then return false end

    local missions=DataMgr.Player.fundMissions;
    local fristMission={};
    local len = #charge.Task;
    for i = 1, len do
        local missionId = charge.Task[i];
        if missions[missionId]~=nil then
            table.insert(fristMission,missions[missionId]);
        end
    end
    if #fristMission==0 then return true end;
    for _,v in ipairs(fristMission) do
        if not v.completed then
            return true;
        end
    end
    return false;
end


DataHelper.CheckBuyFristPay = function(payId)
    local charge = DataHelper.GetChargeByShelf(payId);
    if (charge == nil) then return false end

    local missions=DataMgr.Player.fundMissions;
    local fristMission={};
    local len = #charge.Task;
    for i = 1, len do
        local missionId = charge.Task[i];
        if missions[missionId]~=nil then
            table.insert(fristMission,missions[missionId]);
        end
    end
    if (#fristMission == 0) then return false end
    
    for _,v in ipairs(fristMission) do
        if (v.completed or v.current >= v.target) then
            return true;
        end
    end
    return false;
end


DataHelper.CheckNovelComplete=function(novelId)
    for i = 1, #DataMgr.Player.completedChapters do
        if DataMgr.Player.completedChapters[i] == novelId then
            return true
        end
    end
    return false;
end


DataHelper.CheckNovelComplete_NovelModel=function(novelId)
    if IsNull(DataMgr.Player.storyModeCompletedChapters) then
        return false 
    end;
    for i = 1, #DataMgr.Player.storyModeCompletedChapters do
        if DataMgr.Player.storyModeCompletedChapters[i] == novelId then
            return true
        end
    end
    return false;
end

DataHelper.CheckDungeonComplete_NovelModel=function(dungeonID)
    if IsNull(DataMgr.Player.storyModeDungeonRecords) then 
        return false 
    end;
    local dungeon=DataMgr.Player.storyModeDungeonRecords[dungeonID];
    if dungeon==nil then
        return false;
    end
    return dungeon.completeCount>0;
end



DataHelper.CheckDungeonComplete=function(dungeonID)
    if IsNull(DataMgr.Player.dungeonRecords) then
        return false
    end;
    local dungeon=DataMgr.Player.dungeonRecords[dungeonID];
    if dungeon==nil then
        return false;
    end
    return dungeon.completeCount>0;
end


DataHelper.GetNextChallengeName = function(pLastMainEvent, completedAreaEvents)
    local isComplete=false;
    local challengeNameLan=nil;

    for k, v in pairs(ConfigMgr.Config.areaEvents) do
        if v.category == 0 and v.unlockParam == pLastMainEvent and string.sub(v.id, 1, 1) == "M" then
            if v.type==2 and ConfigMgr.Config.dungeonMap[v.id]~=nil then
                challengeNameLan=ConfigMgr.Config.dungeonMap[v.id].NameLan;
                if not IsNull(completedAreaEvents) and  completedAreaEvents[v.id]~=nil then
                    isComplete=true;
                end
                break
            elseif v.type==1 and ConfigMgr.Config.narrativeMap[v.id]~=nil then
                if not IsNull(completedAreaEvents) and completedAreaEvents[v.id]~=nil then

                    challengeNameLan, isComplete = DataHelper.GetNextChallengeName(v.id, completedAreaEvents)
                else
                    challengeNameLan=ConfigMgr.Config.narrativeMap[v.id].nameLan;
                end
                break;
            end
        end
    end

    if challengeNameLan == nil then
        local areaEvent = ConfigMgr.Config.areaEvents[pLastMainEvent]
        if areaEvent.type==2 and ConfigMgr.Config.dungeonMap[pLastMainEvent]~=nil then
            challengeNameLan=ConfigMgr.Config.dungeonMap[pLastMainEvent].NameLan;
            isComplete = not IsNull(completedAreaEvents) and completedAreaEvents[pLastMainEvent]~=nil
        elseif areaEvent.type==1 and ConfigMgr.Config.narrativeMap[pLastMainEvent]~=nil then
            challengeNameLan=ConfigMgr.Config.narrativeMap[pLastMainEvent].nameLan;
            isComplete = not IsNull(completedAreaEvents) and completedAreaEvents[pLastMainEvent]~=nil
        end
    end
    return challengeNameLan, isComplete
end




DataHelper.GetCycleBagBatchIDByChargeId=function(chargeId)
    for batch,array in pairs(ConfigMgr.Config.CycleBagMap) do
        for i,v in ipairs(array.ChargeId) do
            if v==chargeId then
                return array.Batch,i;
            end
        end
    end
    return nil,nil;
end


DataHelper.GetCycleBagRemainDays=function(chargeId)
    if IsNull(DataMgr.Player.CycleTimeGift) or IsNull(DataMgr.Player.CycleTimeGift.items) then
        return -1;
    end
    local batchId,arrayIndex=DataHelper.GetCycleBagBatchIDByChargeId(chargeId);
    local itemData=DataMgr.Player.CycleTimeGift.items[tostring(batchId)]
    if itemData==nil then
        return -1,arrayIndex, batchId;
    end

    if itemData.day==0 then
        local date=os.date("*t",LuaMgr.Timestamp());


        local timeStamp_4=os.time({year=date.year,month=date.month,day=date.day,hour=4,min=0,sec=00});
        if LuaMgr.Timestamp()-itemData.send>=86400 then
            return -1,arrayIndex, batchId;
        end
        if itemData.send<timeStamp_4 and LuaMgr.Timestamp()>timeStamp_4 then
            return -1,arrayIndex, batchId;
        end

        local cycleBags=ConfigMgr.Config.CycleBagMap[tostring(batchId)]
        if cycleBags~=nil and DataMgr.Player.shop.records[cycleBags.ChargeId[1]]~=nil and DataMgr.Player.shop.records[cycleBags.ChargeId[1]]>0 then
            return -1,arrayIndex, batchId;
        end
        return itemData.day,arrayIndex, batchId;
    end
    return itemData.day,arrayIndex, batchId;
end


DataHelper.GetDrawCardSkin = function()
    return DataMgr.Player.GachaSkin
end

return DataHelper;