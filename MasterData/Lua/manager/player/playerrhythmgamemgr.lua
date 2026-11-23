PlayerRhythmGameMgr = {}

local this = {
    musicConfig = nil,
    musicPos = 0,    
    historyScore = 0,
    EquipBuffsTb = {},
    saveEquipBuffsTb = {},
    IsDiscMask = false,
    GuideData = {},
    GuideDataTH = {},
    tabMapGroupList = { "Music01", "Music02", "Music03" }
};

PlayerRhythmGameMgr.Init = function()
    

end

PlayerRhythmGameMgr.Clear = function()
    this.thMusicConfig = nil;
    this.musicConfig = nil;
    this.musicAlbum = nil
    this.thMusicAlbum = nil
    this.selectItem = nil
    this.musicPos = nil
    this.historyScore = 0
    this.ShopTap = nil
    this.ChapterTab = nil
    this.ChapterArea = nil
    this.EquipBuffsTb = {}
    this.saveEquipBuffsTb = {}
    this.IsDiscMask = nil
    this.bInitShopNewDotData  = nil
    this.bInitEffectNewDotData = nil
    this.bInitMusicNewDotData = nil
    this.bInitChapterNewDotData = nil
    this.bInitBuffNewDotData = nil
end


PlayerRhythmGameMgr.SetMusicAlbum = function(musicAlbum)   
    this.musicAlbum = musicAlbum;
end


PlayerRhythmGameMgr.GetMusicAlbum = function()   
    return this.musicAlbum
end


PlayerRhythmGameMgr.SetTHMusicAlbum = function(musicAlbum)

    this.thMusicAlbum = musicAlbum;
end


PlayerRhythmGameMgr.GetTHMusicAlbum = function()
    return this.thMusicAlbum;
end


PlayerRhythmGameMgr.SetItemEffectItem = function(item)
    this.selectItem = item;
end


PlayerRhythmGameMgr.GetItemEffectItem = function()
    return this.selectItem;
end


PlayerRhythmGameMgr.ClearMusicConfig = function()
    this.musicConfig = nil
    this.thMusicConfig = nil
end


PlayerRhythmGameMgr.SetMusicConfig = function(config)
    PlayerRhythmGameMgr.ClearMusicConfig()
    this.musicConfig = config;
end


PlayerRhythmGameMgr.SetTHMusicConfig = function(config)
    PlayerRhythmGameMgr.ClearMusicConfig()
    this.thMusicConfig = config;
end


PlayerRhythmGameMgr.GetMusicConfig = function()
    local cache = this.musicConfig
    local typeStr = nil
    if(this.thMusicConfig ~= nil)then
        cache = this.thMusicConfig
        typeStr = "TH"
    end
    return cache,typeStr
end


PlayerRhythmGameMgr.SetMusicPos = function(pos)
    this.musicPos = pos;
end


PlayerRhythmGameMgr.GetMusicPos = function()
    return this.musicPos;
end


PlayerRhythmGameMgr.IsAlbumLock = function(id,type)
    if(type ~= nil)then
        if(type == "TH")then
            return DataMgr.Player.tHMusicAlbums[tostring(id)] == nil;
        end
    end
    return DataMgr.Player.musicAlbums[tostring(id)] == nil;
end


PlayerRhythmGameMgr.GetMusicSong = function(id,type)
    if(type ~= nil)then
        if(type == "TH")then            
            return DataMgr.Player.tHMusicSongs[id];
        end
    end
    return DataMgr.Player.musicSongs[id];
end


PlayerRhythmGameMgr.CompleteSong = function(data,type)

    local historyData = PlayerRhythmGameMgr.GetMusicSong(data.id,type);
    this.historyScore = historyData ~= nil and historyData.score or 0;
    if(type ~= nil)then
        if(type == "TH")then           
            ApiMgr.Request("thmusic/complete_song", data, true, this.CompleteTHSongResponse, nil, true, true);            
        end
    else
        ApiMgr.Request("music/complete_song", data, true, this.CompleteSongResponse, nil, true, true);
    end    
end


this.CompleteSongResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        if(LuaMgr.IsPanelOpen(UIName.RhythmGamePauseViewModel))then
            LuaMgr.HidePanel(UIName.RhythmGamePauseViewModel);
        end
        LuaMgr.ShowLuaPanel(UIName.RhythmGameWinViewModel);
    end
end


this.CompleteTHSongResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        if(LuaMgr.IsPanelOpen(UIName.RhythmGamePauseViewModel))then
            LuaMgr.HidePanel(UIName.RhythmGamePauseViewModel);
        end
        LuaMgr.ShowLuaPanel(UIName.RhythmGameWinViewModel);
        if not IsNull(data.result.Items) then
            local items = {};
            local reward = data.result.Items
            for i, v in pairs(reward) do
                local item = { ID = v.id, Count = v.count }
                table.insert(items, item);
            end
            LuaMgr.ShowItemGetPanel(items);                       
        end
    end
end


PlayerRhythmGameMgr.GetHistoryScore = function()
    return this.historyScore;
end


PlayerRhythmGameMgr.EquipItemEffect = function(id, _type, cb)
    local data = { id = id, type = _type }
    ApiMgr.Request("music/equip", data, true,
        function(result)
            local re = json.decode(result)
            if re.code ~= 0 then
                return
            end
            cb(re)
        end, nil, true)
end


PlayerRhythmGameMgr.SetShopTap = function(_type)
    this.ShopTap = _type;
end


PlayerRhythmGameMgr.GetShopTap = function()
    return this.ShopTap;
end


PlayerRhythmGameMgr.SetChapterTab = function(_type)
    this.ChapterTab = _type;
end


PlayerRhythmGameMgr.GetChapterTab = function()
    return this.ChapterTab;
end


PlayerRhythmGameMgr.SetChapterArea = function(_type)
    this.ChapterArea = _type;
end


PlayerRhythmGameMgr.GetChapterArea = function()
    return this.ChapterArea;
end


PlayerRhythmGameMgr.SetEquipBuffs = function(_data)
    if (_data == nil) then       
        this.EquipBuffsTb = {}
    else
        table.insert(this.EquipBuffsTb, _data)
    end
end


PlayerRhythmGameMgr.GetEquipBuffs = function()
    return this.EquipBuffsTb;
end


PlayerRhythmGameMgr.SaveEquipBuffs = function()
    this.saveEquipBuffsTb = this.EquipBuffsTb;
end


PlayerRhythmGameMgr.GetSaveEquipBuffs = function()
    return this.saveEquipBuffsTb;
end


PlayerRhythmGameMgr.GetEquipBuffsID = function()
    if (this.saveEquipBuffsTb == this.EquipBuffsTb) then       
        local str = nil
        for i, v in ipairs(this.saveEquipBuffsTb) do
            if (str == nil) then
                str = v.buffID
            else
                str = str .. "," .. v.buffID
            end
        end
        return str 
    else
        return nil
    end
end


PlayerRhythmGameMgr.GetState = function(unlock)
    for i = 1, #DataMgr.Player.completedChapters do
        if DataMgr.Player.completedChapters[i] == unlock then
            return true
        end
    end
    return false
end


PlayerRhythmGameMgr.SetIsDiscMask = function(_bMask)
    this.IsDiscMask = _bMask;
end


PlayerRhythmGameMgr.GetIsDiscMask = function()
    if(this.IsDiscMask == nil)then
        this.IsDiscMask = false
    end
    return this.IsDiscMask;
end

PlayerRhythmGameMgr.GetGuideData = function(typestr)
    if not typestr then
        local musicConfig,typeT = PlayerRhythmGameMgr.GetMusicConfig()
        typestr = typeT
    end

    if(typestr ~= nil)then
        if(typestr == "TH")then
            return PlayerRhythmGameMgr.GetGuideDataTH()
        end
    end

    return PlayerRhythmGameMgr.GetGuideDataReal(this.GuideData, "RHYGuideData")
end

PlayerRhythmGameMgr.SetGuideData = function(data, typestr)
    if not typestr then
        local musicConfig,typeT = PlayerRhythmGameMgr.GetMusicConfig()
        typestr = typeT
    end

    if(typestr ~= nil)then
        if(typestr == "TH")then
            PlayerRhythmGameMgr.SetGuideDataTH(data)
            return 
        end
    end

    PlayerRhythmGameMgr.SetGuideDataReal(this.GuideData, "RHYGuideData", data)
end

PlayerRhythmGameMgr.SetGuideDataTH = function(data)
    PlayerRhythmGameMgr.SetGuideDataReal(this.GuideDataTH, "RHYGuideDataTH", data)
end

PlayerRhythmGameMgr.GetGuideDataTH = function()
    return PlayerRhythmGameMgr.GetGuideDataReal(this.GuideDataTH, "RHYGuideDataTH")
end

PlayerRhythmGameMgr.GetGuideDataReal = function(guideDataReal, fiter)
    if not guideDataReal[DataMgr.Player.uid] then       
        guideDataReal[DataMgr.Player.uid] = {Note={},Pic = {}} 
        local playerRHYGuideKey = DataMgr.Player.uid .. fiter
        local guideData = PlayerPrefs.GetString(playerRHYGuideKey, "")
        local data = nil
        if guideData ~= "" then      
            print(guideData)      
            data = json.decode(guideData)
        end
        if data then 
            guideDataReal[DataMgr.Player.uid] = data
        end
    end
    return guideDataReal[DataMgr.Player.uid]
end

PlayerRhythmGameMgr.SetGuideDataReal = function(guideData, fiter, data)
    guideData[DataMgr.Player.uid] = data
    local playerRHYGuideKey = DataMgr.Player.uid .. fiter
    print(json.encode(data))
    PlayerPrefs.SetString(playerRHYGuideKey, json.encode(data))
    PlayerPrefs.Save()
end


PlayerRhythmGameMgr.InitNewDotData = function ()    
    PlayerRhythmGameMgr.InitShopNewDotData()
    PlayerRhythmGameMgr.InitEffectNewDotData()
    PlayerRhythmGameMgr.InitMusicNewDotData()
    PlayerRhythmGameMgr.InitChapterNewDotData()
    PlayerRhythmGameMgr.InitBuffNewDotData()
end


PlayerRhythmGameMgr.CheckEntranceRedAndNewDot = function ()
    local bSign = PlayerRhythmGameMgr.CheckSignEntranceRedDot()
    local bTask = PlayerRhythmGameMgr.CheckTaskEntranceRedDot()   
    local bShop = PlayerRhythmGameMgr.CheckShopEntranceNewDot()    
    local bMusic = PlayerRhythmGameMgr.CheckMusicEntranceNewDot()
    local bChapter = PlayerRhythmGameMgr.CheckChapterEntranceNewDot()   

end

PlayerRhythmGameMgr.CheckPanleEntranceRedDot = function ()
    local bSign = PlayerRhythmGameMgr.CheckSignEntranceRedDot()
    local bTask = PlayerRhythmGameMgr.CheckTaskEntranceRedDot()    
    if(bSign or bTask)then
        RedMgr.Singleton:UpdateClientRedData("12001",1)
    else
        RedMgr.Singleton:UpdateClientRedData("12001",0)
    end    
    return bSign or bTask
end

PlayerRhythmGameMgr.CheckSignEntranceRedDot = function ()    
    if(this.configQuest231 == nil)then
        this.configQuest231 = DataExHelper.Check_ConfigQuestEventByGroupId(231);
    end    
    for k, v in pairs(this.configQuest231) do
        local data = DataMgr.Player.quests[v.id]
        if(data ~= nil and data.state == 2)then
            RedMgr.Singleton:UpdateClientRedData("12002",1)
            return true
        end
    end
    RedMgr.Singleton:UpdateClientRedData("12002",0)
    return false
end

PlayerRhythmGameMgr.CheckTaskRedDot = function ()   
    if(this.configQuest233 == nil)then
        this.configQuest233 = DataExHelper.Check_ConfigQuestEventByGroupId(233);
    end  
    local checkA = false
    local checkB = false
    for k, v in pairs( this.configQuest233) do
        local state =  DataExHelper.Check_RewardState(v.id);        
        if (v.text == "missionA" and state ~= nil and state == 2 and not checkA) then
            checkA = true
            RedMgr.Singleton:UpdateClientRedData("12008_1",1)
        end
        if (v.text == "missionB" and state ~= nil and state == 2 and not checkB) then
            checkB = true
            RedMgr.Singleton:UpdateClientRedData("12008_2",1)
        end
        if(checkA and checkB)then
            break
        end
    end
    if(not checkA)then
        RedMgr.Singleton:UpdateClientRedData("12008_1",0)
    end
    if(not checkB)then
        RedMgr.Singleton:UpdateClientRedData("12008_2",0)
    end   
    return checkA or checkB
end

PlayerRhythmGameMgr.CheckTaskEntranceRedDot = function ()   
   local bShow = PlayerRhythmGameMgr.CheckTaskRedDot()
   if(bShow)then
        RedMgr.Singleton:UpdateClientRedData("12003",1)
   else
        RedMgr.Singleton:UpdateClientRedData("12003",0)
   end
   return bShow
end

PlayerRhythmGameMgr.InitShopNewDotData = function ()
    if(this.bInitShopNewDotData == nil)then
        this.bInitShopNewDotData = true
    else
        return
    end
    if(this.configQuest235 == nil)then
        this.configQuest235 = DataExHelper.Check_ConfigQuestEventByGroupId(235);
    end  
    this.shopUnlockDataMap = {}
    this.shopUnlockDataMapShown = {}
    local num = 0
    for i, v in ipairs( this.configQuest235) do
        if (v.text == "shopLock") then           
            num = num + 1  
            local data = DataMgr.Player.quests[v.id]         
            local isLock = data ~= nil and data.state == 1 and num ~= 1           
            if(not isLock)then
                this.shopUnlockDataMap[v.id] = true
                this.shopUnlockDataMapShown[v.id] = true                 
            end          
        end
    end
 end

 PlayerRhythmGameMgr.CheckShopTapNewDotDataById = function (id)  
    local bNew = false
    local data = DataMgr.Player.quests[id]         
    local isLock = data~= nil and data.state == 1    
    if(not isLock and this.shopUnlockDataMap[id] == nil)then               
        bNew = true          
    end      
    return bNew
 end

 PlayerRhythmGameMgr.CheckShopTapEffectShownById = function (id)  
    local bNew = false     
    if(PlayerRhythmGameMgr.CheckShopTapNewDotDataById(id) and this.shopUnlockDataMapShown[id] == nil)then  
        this.shopUnlockDataMapShown[id] = true             
        bNew = true          
    end      
    return bNew
 end

 PlayerRhythmGameMgr.CheckShopTapNewDot = function ()     
    local num = 0
    local bNew = false
    for i, v in ipairs( this.configQuest235) do
        if (v.text == "shopLock") then           
            num = num + 1                     
            if(PlayerRhythmGameMgr.CheckShopTapNewDotDataById(v.id))then
                RedMgr.Singleton:UpdateClientRedData("12010_"..num,1)
                bNew = true
            else
                RedMgr.Singleton:UpdateClientRedData("12010_"..num,0)
            end          
        end
    end
    return bNew
 end

 PlayerRhythmGameMgr.CheckShopEntranceNewDot = function ()      
    local bNew = PlayerRhythmGameMgr.CheckShopTapNewDot() 
    if(bNew)then
        RedMgr.Singleton:UpdateClientRedData("12004",1)
    else
        RedMgr.Singleton:UpdateClientRedData("12004",0)
    end   
    return bNew
 end

 PlayerRhythmGameMgr.UpdateShopNewDotData = function (id)  
    local refresh = false
    if(this.shopUnlockDataMap == nil)then
        this.shopUnlockDataMap = {}
    end
    if(this.shopUnlockDataMap[id] == nil)then
        this.shopUnlockDataMap[id] = true  
        refresh = true     
    end 
    return refresh  
 end

 PlayerRhythmGameMgr.InitEffectNewDotData = function ()
    if(this.bInitEffectNewDotData == nil)then
        this.bInitEffectNewDotData = true
    else
        return
    end    
    this.effectUnlockDataMap = {}
    this.effectUnlockDataMapShown = {}
    local unlocks = DataMgr.Player.musicEquips.Unlock;  
    for k, v in pairs(unlocks) do
        this.effectUnlockDataMap[k] = true
        this.effectUnlockDataMapShown[k] = true
    end   
 end

 PlayerRhythmGameMgr.CheckEffectNewDotDataById = function (id)     
    local bNew = false    
    local unlocks = DataMgr.Player.musicEquips.Unlock; 
    if unlocks[tostring(id)] and this.effectUnlockDataMap[tostring(id)] == nil then
        bNew = true      
    end
    return bNew
 end

 PlayerRhythmGameMgr.CheckEffectEffectShownById = function (id)     
    local bNew = false     
    if(PlayerRhythmGameMgr.CheckEffectNewDotDataById(id) and this.effectUnlockDataMapShown[id] == nil)then  
        this.effectUnlockDataMapShown[id] = true             
        bNew = true          
    end      
    return bNew
 end

 PlayerRhythmGameMgr.CheckEffectNewDot = function ()     
    local bNew = false
    local musicEquips = ConfigMgr.Config.MusicEquips     
    for k, v in pairs(musicEquips) do
        if PlayerRhythmGameMgr.CheckEffectNewDotDataById(v.id) then
            bNew = true
            RedMgr.Singleton:UpdateClientRedData("12015_"..v.id,1)
        else
            RedMgr.Singleton:UpdateClientRedData("12015_"..v.id,0)
        end
    end
    return bNew
 end

 PlayerRhythmGameMgr.CheckEffectEntranceNewDot = function ()      
    local bNew = PlayerRhythmGameMgr.CheckEffectNewDot() 
    if(bNew)then
        RedMgr.Singleton:UpdateClientRedData("12014",1)
    else
        RedMgr.Singleton:UpdateClientRedData("12014",0)
    end   
    return bNew
 end

 PlayerRhythmGameMgr.UpdateEffectNewDotData = function (id)  
    local refresh = false
    if(this.effectUnlockDataMap == nil)then
        this.effectUnlockDataMap = {}
    end
    if(this.effectUnlockDataMap[tostring(id)] == nil)then
        this.effectUnlockDataMap[tostring(id)] = true  
        refresh = true     
    end 
    return refresh  
 end

 PlayerRhythmGameMgr.InitMusicNewDotData = function ()
    if(this.bInitMusicNewDotData == nil)then
        this.bInitMusicNewDotData = true
    else
        return
    end    
    this.musicUnlockDataMap = {}
    this.musicUnlockDataMapShown = {}
    this.musicAlbumUnlockDataMapShown = {}
    this.musicThUnlockDataMap = {}
    this.musicThUnlockDataMapShown = {}
    this.musicThAlbumUnlockDataMapShown = {}
    local dataMap = DataMgr.Player.musicSongs;   
    for k, v in pairs(dataMap) do
        this.musicUnlockDataMap[k] = true 
        this.musicUnlockDataMapShown[k] = true
    end 
    for k, v in pairs(DataMgr.Player.musicAlbums) do
        this.musicAlbumUnlockDataMapShown[k] = true
    end 
    dataMap = DataMgr.Player.tHMusicSongs;   
    for k, v in pairs(dataMap) do
        this.musicThUnlockDataMap[k] = true 
        this.musicThUnlockDataMapShown[k] = true
    end  
    for k, v in pairs(DataMgr.Player.tHMusicAlbums) do
        this.musicThAlbumUnlockDataMapShown[k] = true
    end  
 end

 PlayerRhythmGameMgr.CheckMusicNewDotDataById = function (id,type)      
    local bNew = false
    local idStr = tostring(id) 
    local unlocks = DataMgr.Player.musicSongs;    
    if(type ~= nil)then
        if(type == "TH")then    
            unlocks = DataMgr.Player.tHMusicSongs;        
            local bUnlock = unlocks[idStr] and this.musicThUnlockDataMap[idStr] == nil
            if(bUnlock)then
                bNew = true
            end             
        end
    else
        local bUnlock = unlocks[idStr] and this.musicUnlockDataMap[idStr] == nil
        if(bUnlock)then
            bNew = true
        end  
    end  
    return bNew    
 end

 PlayerRhythmGameMgr.CheckMusicShownById = function (id,type)     
    local bNew = false   
    if(type ~= nil)then
        if(type == "TH")then 
            if(PlayerRhythmGameMgr.CheckMusicNewDotDataById(id,type) and this.musicThUnlockDataMapShown[id] == nil)then         
                this.musicThUnlockDataMapShown[id] = true             
                bNew = true          
            end     
        end
    else
        if(PlayerRhythmGameMgr.CheckMusicNewDotDataById(id) and this.musicUnlockDataMapShown[id] == nil)then         
            this.musicUnlockDataMapShown[id] = true             
            bNew = true          
        end     
    end    
    return bNew
 end

 PlayerRhythmGameMgr.CheckMusicAlbumShownById = function (id,type)     
    local bNew = false  
    if(type ~= nil)then
        if(type == "TH")then
            if(not PlayerRhythmGameMgr.IsAlbumLock(id,type) and this.musicThAlbumUnlockDataMapShown[tostring(id)] == nil)then  
                this.musicThAlbumUnlockDataMapShown[tostring(id)] = true             
                bNew = true          
            end    
        end
    else
        if(not PlayerRhythmGameMgr.IsAlbumLock(id) and this.musicAlbumUnlockDataMapShown[tostring(id)] == nil)then  
            this.musicAlbumUnlockDataMapShown[tostring(id)] = true             
            bNew = true          
        end    
    end   
    return bNew
 end

 PlayerRhythmGameMgr.CheckMusicNewDot = function (type)      
    local bNew = false
    local musicAlbums = ConfigMgr.Config.MusicAlbums;  
    local strCache = ""
    if(type ~= nil)then
        if(type == "TH")then
            musicAlbums = ConfigMgr.Config.THMusicAlbums;
            strCache = "TH"
        end
    end 
    for k, v in ipairs(musicAlbums) do
        local bNewAlbum = false
        local musicDatas = ConfigRhythmGameMgr.GetMusics(v.group,type);
        for key, value in pairs(musicDatas) do           
            local bUnlockE = PlayerRhythmGameMgr.CheckMusicNewDotDataById(value.Easy.id,type)
            local bUnlockH = PlayerRhythmGameMgr.CheckMusicNewDotDataById(value.Hard.id,type)
            local bUnlockM = PlayerRhythmGameMgr.CheckMusicNewDotDataById(value.Master.id,type)
            if(bUnlockE or bUnlockH or bUnlockM)then
                bNew = true
                bNewAlbum = true
                RedMgr.Singleton:UpdateClientRedData("12012_"..value.Easy.id..strCache,1)                
            else
                RedMgr.Singleton:UpdateClientRedData("12012_"..value.Easy.id..strCache,0)
            end
            if(bUnlockE)then               
                RedMgr.Singleton:UpdateClientRedData("12013_"..value.Easy.id..strCache,1)
            else
                RedMgr.Singleton:UpdateClientRedData("12013_"..value.Easy.id..strCache,0)
            end
            if(bUnlockH)then               
                RedMgr.Singleton:UpdateClientRedData("12013_"..value.Hard.id..strCache,1)
            else
                RedMgr.Singleton:UpdateClientRedData("12013_"..value.Hard.id..strCache,0)
            end
            if(bUnlockM)then                
                RedMgr.Singleton:UpdateClientRedData("12013_"..value.Master.id..strCache,1)
            else
                RedMgr.Singleton:UpdateClientRedData("12013_"..value.Master.id..strCache,0)
            end  
        end       
        if(bNewAlbum)then
            RedMgr.Singleton:UpdateClientRedData("12011_"..v.group..strCache,1)         
        else
            RedMgr.Singleton:UpdateClientRedData("12011_"..v.group..strCache,0)       
        end     
    end
    return bNew
 end

 PlayerRhythmGameMgr.CheckMusicEntranceNewDot = function ()      
    local bNew = PlayerRhythmGameMgr.CheckMusicNewDot() 
    if(bNew)then
        RedMgr.Singleton:UpdateClientRedData("12005",1)
    else
        RedMgr.Singleton:UpdateClientRedData("12005",0)
    end   
    return bNew
 end

 PlayerRhythmGameMgr.UpdateMusicNewDotData = function (id,type)  
    local refresh = false
    if(type ~= nil)then
        if(type == "TH")then
            if(this.musicThUnlockDataMap == nil)then
                this.musicThUnlockDataMap = {}
            end
            if(this.musicThUnlockDataMap[tostring(id)] == nil)then
                this.musicThUnlockDataMap[tostring(id)] = true  
                refresh = true     
            end  
        end
    else
        if(this.musicUnlockDataMap == nil)then
            this.musicUnlockDataMap = {}
        end
        if(this.musicUnlockDataMap[tostring(id)] == nil)then
            this.musicUnlockDataMap[tostring(id)] = true  
            refresh = true     
        end  
    end  
    return refresh 
 end

 PlayerRhythmGameMgr.InitChapterNewDotData = function ()
    if(this.bInitChapterNewDotData == nil)then
        this.bInitChapterNewDotData = true
    else
        return
    end    
    this.chapterUnlockDataMap = {}
    this.chapterUnlockDataMapShown = {}
    for i,v in ipairs(this.tabMapGroupList) do
        local curPlayerData = DataMgr.Player.activityMaps[v]
        if(curPlayerData ~= nil)then
            for key, value in pairs(curPlayerData.activityEvents) do
                this.chapterUnlockDataMap[key] = true 
                this.chapterUnlockDataMapShown[key] = true 
            end 
        end
    end
 end

 PlayerRhythmGameMgr.UpdateChapterNewDotData = function (id)  
    local refresh = false
    if(this.chapterUnlockDataMap == nil)then
        this.chapterUnlockDataMap = {}
    end
    if(this.chapterUnlockDataMap[id] == nil)then
        this.chapterUnlockDataMap[id] = true 
        refresh = true     
    end  
    return refresh 
 end

 PlayerRhythmGameMgr.CheckChapterNewDotDataById = function (id)  
    local bNew = false   
    for i,v in ipairs(this.tabMapGroupList) do       
        local cache = DataMgr.Player.activityMaps[v]
        if(cache ~= nil)then
            local curPlayerData = cache.activityEvents
            if curPlayerData[tostring(id)] and this.chapterUnlockDataMap[id] == nil then
               return true          
            end        
        end 
    end    
    return bNew
 end

 PlayerRhythmGameMgr.CheckChapterShownById = function (id)     
    local bNew = false   
    local configNext = ConfigRhythmGameMgr.GetUnlockChapter(id)   
    if(configNext ~= nil and PlayerRhythmGameMgr.CheckChapterNewDotDataById(configNext.id) and this.chapterUnlockDataMapShown[configNext.id] == nil)then
        if this.startDelay ~= nil then
            coroutine_runner.stop(this.startDelay)
        end
        this.startDelay = coroutine_runner.start(function()       
            coroutine_runner.wait(1)
            this.chapterUnlockDataMapShown[configNext.id] = true          
        end) 
        bNew = true          
    end    
    return bNew
 end

 PlayerRhythmGameMgr.CheckChapterNewDot = function ()  
    local bNew = false
    local groupBox = {}     
    for i,v in ipairs(this.tabMapGroupList) do        
        local bTab = false        
        local curAreaEventList = DataExHelper.EX_GetEventMapByArea(v)
        local curAreaList = DataExHelper.EX_GetGroupListByArea(v)
        local cache = DataMgr.Player.activityMaps[v]
        if(cache == nil)then
           return false
        end                 
        local curPlayerData = cache.activityEvents 
        for key, value in pairs(curAreaEventList) do           
            for key1, value1 in pairs(value) do 
                if curPlayerData[tostring(value1.id)] and this.chapterUnlockDataMap[value1.id] == nil then
                    bNew = true 
                    bTab = true      
                    if(i == 1 and groupBox[key] == nil)then
                        groupBox[key] = true
                    end                      
                    RedMgr.Singleton:UpdateClientRedData("12018_"..value1.id,1)
                else                                     
                    RedMgr.Singleton:UpdateClientRedData("12018_"..value1.id,0)
                end
            end            
        end 
        if(bTab)then           
            RedMgr.Singleton:UpdateClientRedData("12016_"..i,1)
        else            
            RedMgr.Singleton:UpdateClientRedData("12016_"..i,0)
        end
        for key, value in pairs(curAreaList) do
            if(groupBox[value.id])then                
                RedMgr.Singleton:UpdateClientRedData("12017_"..key,1)
            else                
                RedMgr.Singleton:UpdateClientRedData("12017_"..key,0)
            end
        end
    end     
    return bNew
 end

 PlayerRhythmGameMgr.CheckChapterEntranceNewDot = function ()      
    local bNew = PlayerRhythmGameMgr.CheckChapterNewDot() 
    if(bNew)then
        RedMgr.Singleton:UpdateClientRedData("12006",1)
    else
        RedMgr.Singleton:UpdateClientRedData("12006",0)
    end   
    return bNew
 end

 PlayerRhythmGameMgr.InitBuffNewDotData = function ()
    if(this.bInitBuffNewDotData == nil)then
        this.bInitBuffNewDotData = true
    else
        return
    end    
    this.buffUnlockDataMap = {}
    this.buffUnlockDataMapShown = {}
    local unlocks = DataMgr.Player.msBtDrives;
    for k, v in pairs(unlocks) do
        this.buffUnlockDataMap[k] = true
        this.buffUnlockDataMapShown[k] = true
    end  
 end

 PlayerRhythmGameMgr.UpdateBuffNewDotData = function (id)  
    local refresh = false
    if(this.buffUnlockDataMap == nil)then
        this.buffUnlockDataMap = {}
    end
    if(this.buffUnlockDataMap[id] == nil)then
        this.buffUnlockDataMap[id] = true  
        refresh = true     
    end  
    return refresh 
 end

 PlayerRhythmGameMgr.CheckBuffNewDotDataById = function (id)  
    local bNew = false   
    if(DataMgr.Player.msBtDrives[id] and this.buffUnlockDataMap[id] == nil)then
        bNew = true  
    end     
    return bNew
 end

 PlayerRhythmGameMgr.CheckBuffShownById = function (id)     
    local bNew = false     
    if(PlayerRhythmGameMgr.CheckBuffNewDotDataById(id) and this.buffUnlockDataMapShown[id] == nil)then  
        this.buffUnlockDataMapShown[id] = true             
        bNew = true          
    end      
    return bNew
 end


 PlayerRhythmGameMgr.CheckBuffNewDot = function (eventMap)      
    local bNew = false
    local list = NumTool.split(eventMap.archiveBUFF, ";");   
    for i, v in ipairs(list) do
        local value = ConfigMgr.Config.MsBtDriveMap[v] 
        if(value == nil)then 
            LuaDebug.error(v) 
            LuaDebug.error("没有在ConfigMgr.Config.MsBtDriveMap配置中读取到内容") 
            return 
        end      
        if(PlayerRhythmGameMgr.CheckBuffNewDotDataById(value.id))then
            bNew = true            
            RedMgr.Singleton:UpdateClientRedData("12021_"..value.id,1)
        else
            RedMgr.Singleton:UpdateClientRedData("12021_"..value.id,0)
        end       
    end
    return bNew
 end




