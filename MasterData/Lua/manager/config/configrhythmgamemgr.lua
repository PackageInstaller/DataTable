ConfigRhythmGameMgr = {}

local this = {
    musicSongMap = nil,
    thMusicSongMap = nil;    
    songContentMap = nil,
    thSongContentMap = nil,
    eventDriveMapByEventId = nil,
    guidePicMap = nil,
    guideControlsMap = nil
};

ConfigRhythmGameMgr.Init = function()
    this.InitMusicSong();
    this.InitSongContent();
    this.InitEventDriveContent();
    this.InitGuide()
end

ConfigRhythmGameMgr.Clear = function()
    this.musicSongMap = nil;
    this.thMusicSongMap = nil;
    this.songContentMap = nil;
    this.thSongContentMap = nil;
    this.eventDriveMapByEventId = nil
end


this.InitMusicSong = function()
    this.musicSongMap = {};
    this.thMusicSongMap = {};    
    local musicSongs = ConfigMgr.Config.MusicSongs;
    if (musicSongs ~= nil) then
        local len = #musicSongs;
        for i = 1, len do
            local musicSong = musicSongs[i];
            this.musicSongMap[musicSong.id] = musicSong;
        end
    end
    musicSongs = ConfigMgr.Config.THMusicSongs;
    if (musicSongs ~= nil) then
        local len = #musicSongs;
        for i = 1, len do
            local musicSong = musicSongs[i];
            this.thMusicSongMap[musicSong.id] = musicSong;
        end
    end
end

ConfigRhythmGameMgr.GetMusicConstants = function(type)
    if not type then
        local musicConfig,typeT = PlayerRhythmGameMgr.GetMusicConfig()
        type = typeT
    end

    if(type ~= nil)then
        if(type == "TH")then
            return ConfigMgr.Config.THMusicConstants;
        end
    end
    return ConfigMgr.Config.MusicConstants
end

ConfigRhythmGameMgr.GetBatSounds = function(type)
    if not type then
        local musicConfig,typeT = PlayerRhythmGameMgr.GetMusicConfig()
        type = typeT
    end

    if(type ~= nil)then
        if(type == "TH")then
            return ConfigMgr.Config.THBatSounds;
        end
    end
    return ConfigMgr.Config.BatSounds
end


ConfigRhythmGameMgr.GetMusicSongById = function(id,type)
    if(type ~= nil)then
        if(type == "TH")then
            return this.thMusicSongMap[id];
        end
    end
    return this.musicSongMap[id];
end


this.InitSongContent = function()
    this.songContentMap = {};
    this.thSongContentMap = {};   
    local songContents = ConfigMgr.Config.SongContents;
    if (songContents ~= nil) then
        local len = #songContents;
        for i = 1, len do
            local songContent = songContents[i];
            this.songContentMap[songContent.id] = songContent;
        end
    end
    songContents = ConfigMgr.Config.THSongContents;      
    if (songContents ~= nil) then
        local len = #songContents;
        for i = 1, len do
            local songContent = songContents[i];             
            this.thSongContentMap[songContent.id] = songContent;
        end
    end
end


ConfigRhythmGameMgr.GetSongContent = function(id,type)
    if(type ~= nil)then
        if(type == "TH")then
            return this.thSongContentMap[id];
        end
    end
    return this.songContentMap[id];
end


this.InitEventDriveContent = function()
    this.eventDriveMapByEventId = {};   
    local eventContents = ConfigMgr.Config.EventDriveMap;
    if (eventContents ~= nil) then
        for k, v in pairs(eventContents) do
            this.eventDriveMapByEventId[v.activityMapEventID] = v 
        end       
    end
end


ConfigRhythmGameMgr.GetEventDriveContent = function(eventId)
    return this.eventDriveMapByEventId[eventId];
end

ConfigRhythmGameMgr.GetBuffById = function(id)
    return ConfigMgr.Config.buffMap[id];
end

ConfigRhythmGameMgr.GetTotalNum = function(songData,type)
    local num = 0;
    local maxNum = 0;
    for k, v in pairs(songData) do
        if (k ~= "group") then
            local songContent = ConfigRhythmGameMgr.GetSongContent(v.eventID,type);
            local musicSong = PlayerRhythmGameMgr.GetMusicSong(v.id,type);                      
            for i = 1, 3 do
                if (songContent["Condition" .. i] ~= nil) then
                    maxNum = maxNum + 1
                end
                if (musicSong ~= nil) then
                    if (musicSong["condition" .. i] > 0) then
                        num = num + 1
                    end
                end
            end
        end
    end
    return num,maxNum
end


ConfigRhythmGameMgr.GetMusics = function(musicAlbum,type)
    local musicSong;
    local musicData;
    local musics = {};
    local musicSongs = ConfigMgr.Config.MusicSongs;
    if(type ~= nil)then
        if(type == "TH")then
            musicSongs = ConfigMgr.Config.THMusicSongs;
        end
    end
    local len = #musicSongs;
    for i = 1, len do
        musicSong = musicSongs[i];
        if (musicSong.album == musicAlbum) then
            if (musicData == nil or musicData.group ~= musicSong.typeGroup) then
                musicData = { group = musicSong.typeGroup };
                table.insert(musics, musicData);
            end
            musicData[musicSong.type] = musicSong;
        end
    end
    return musics;
end


ConfigRhythmGameMgr.GetMusicSongByEventId = function(eventId,type)
    local musicSong;
    local musicSongs = ConfigMgr.Config.MusicSongs;
    if(type ~= nil)then
        if(type == "TH")then
            musicSongs = ConfigMgr.Config.THMusicSongs;
        end
    end
    local len = #musicSongs;
    for i = 1, len do
        musicSong = musicSongs[i];
        if (musicSong.eventID == eventId) then
            return musicSong;
        end
    end
    return nil;
end


ConfigRhythmGameMgr.GetAlbumConfig = function(album,type)   
    local musicAlbums = ConfigMgr.Config.MusicAlbums;
    if(type ~= nil)then
        if(type == "TH")then
            musicAlbums = ConfigMgr.Config.THMusicAlbums;
        end
    end
    local len = #musicAlbums;
    for i = 1, len do
        local musicAlbum = musicAlbums[i];
        if (musicAlbum.group == album) then
            return musicAlbum;
        end
    end
    return nil;
end


ConfigRhythmGameMgr.GetConditionText = function(type, num)
    local str = nil;
    if (type == "101") then
        str = ConfigMgr.LangGlobal("10740");
    elseif (type == "102") then
        str = ConfigMgr.LangGlobal("10741");
    elseif (type == "103") then
        str = ConfigMgr.LangGlobal("10742");
    elseif (type == "104") then
        str = ConfigMgr.LangGlobal("10743");
    end
    if (str ~= nil) then
        return string.format(str, num);
    end
    return "";
end


this.GetMusicSongLevelText = function(type)
    if (type == "Easy") then
        return ConfigMgr.LangGlobal("10718");
    elseif (type == "Hard") then
        return ConfigMgr.LangGlobal("10719");
    elseif (type == "Master") then
        return ConfigMgr.LangGlobal("10720");
    end
    return "";
end


ConfigRhythmGameMgr.MusicUnlockTips = function(unlock,type)
    local msg = ConfigRhythmGameMgr.GetMusicUnlockTips(unlock,type)
    if not msg then
        return
    end
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, msg);
end


ConfigRhythmGameMgr.ShowMusicPanel = function(type)
    
    if(type ~= nil)then
        if(type == "TH")then
            LuaMgr.ShowLuaPanel(UIName.RhythmGameMusicShortViewModel);
        end
    else
        LuaMgr.ShowLuaPanel(UIName.RhythmGameMusicViewModel);
    end   
end


ConfigRhythmGameMgr.GetMusicUnlockTips = function(unlock,typeStr)
    local type = unlock[1];
if (type == "1") then
        local config = ConfigRhythmGameMgr.GetMusicSongById(unlock[2],typeStr);
        if (config ~= nil) then
            local level = this.GetMusicSongLevelText(config.type);
            local msg = string.format(ConfigMgr.LangGlobal("10730"), LuaMgr.GetLangText(config.nameLan), level, unlock[3]);
            return msg
        end
elseif (type == "2") then
        local config = ConfigRhythmGameMgr.GetMusicSongById(unlock[2],typeStr);
        if (config ~= nil) then
            local level = this.GetMusicSongLevelText(config.type);
            local msg = string.format(ConfigMgr.LangGlobal("10731"), LuaMgr.GetLangText(config.nameLan), level, unlock[3]);
            return msg
        end
elseif (type == "3") then
        local msg = string.format(ConfigMgr.LangGlobal("10732"), unlock[2]);
        return msg
elseif (type == "4") then
        local msg = ConfigMgr.LangGlobal("10800")
        return msg
    end
end


ConfigRhythmGameMgr.GetJudge = function(songContent, score, maxScore)
    local rate = (score / maxScore) * 100;
    if (rate >= songContent.scoreSSS) then
        return 5;
    elseif (rate >= songContent.scoreSS) then
        return 4;
    elseif (rate >= songContent.scoreS) then
        return 3;
    elseif (rate >= songContent.scoreA) then
        return 2;
    elseif (rate >= songContent.scoreB) then
        return 1;
    end
    return 1;
end


ConfigRhythmGameMgr.GetJudgeImg = function(type) 
    if (type == "S") then
        return "ui_hd_yy_gk_xy_zdy"
    elseif (type == "A") then
        return "ui_hd_yy_gk_xy_zdl"
    elseif (type == "B") then
        return "ui_hd_yy_gk_xy_zdz"
    else
        return "ui_hd_yy_gk_xy_zdoc"
    end    
end


ConfigRhythmGameMgr.GetHasLookImg = function(hasLook)       
    if(hasLook)then
        return "ui_hd_yy_gk_xy_khg"
    else
        return "ui_hd_yy_gk_xy_hgoc"
    end   
end


ConfigRhythmGameMgr.GetEquipBuffIndexImg = function(bLight,index)   
    if(bLight)then
        return "ui_hd_yy_gk_cp_num1_"..index  
    else
        return "ui_hd_yy_gk_cp_num0_"..index  
    end   
end


ConfigRhythmGameMgr.GetUnlockName = function(unlockParam)   
    local config = nil
    for i, v in ipairs(ConfigMgr.Config.activityMapEventList) do
        if v.id == unlockParam then
            config = v
            break
        end
    end
    local unlockName = LuaMgr.GetLangText(config.namelan)
    return unlockName
end


ConfigRhythmGameMgr.GetUnlockChapter = function(unlockParam)   
    local config = nil
    local list = ConfigMgr.Config.activityMapEventList
    for i, v in ipairs(list) do
        if v.id == unlockParam and list[i + 1] ~= nil then
            config = list[i + 1]
            break
        end
    end    
    return config
end



this.InitGuide = function()
    this.guidePicMap = {}
    this.guideControlsMap = {}
    if ConfigMgr.Config.TeachPictures then        
        for i,v in ipairs(ConfigMgr.Config.TeachPictures) do
            local st = this.guidePicMap[v.SongId] or {}
            table.insert(st, v)
            this.guidePicMap[v.SongId] = st
        end
    end

    for k, v in pairs(this.guidePicMap) do
        table.sort(v, function(a,b)
            return a.Id > b.Id
        end) 
    end

    if ConfigMgr.Config.TeachControls then        
        for i,v in ipairs(ConfigMgr.Config.TeachControls) do
            this.guideControlsMap[v.Type]=v;
        end
    end

    this.InitGuideTH()
end

this.InitGuideTH = function()
    this.guidePicMapTH = {}
    this.guideControlsMapTH = {}
    if ConfigMgr.Config.THTeachPictures then        
        for i,v in ipairs(ConfigMgr.Config.THTeachPictures) do
            local st = this.guidePicMapTH[v.SongId] or {}
            table.insert(st, v)
            this.guidePicMapTH[v.SongId] = st
        end
    end

    for k, v in pairs(this.guidePicMapTH) do
        table.sort(v, function(a,b)
            return a.Id > b.Id
        end) 
    end

    if ConfigMgr.Config.THTeachControls then        
        for i,v in ipairs(ConfigMgr.Config.THTeachControls) do
            this.guideControlsMapTH[v.Type]=v;
        end
    end
end


ConfigRhythmGameMgr.GetGuidePic = function(id, typestr)
    if not typestr then
        local musicConfig,typeT = PlayerRhythmGameMgr.GetMusicConfig()
        typestr = typeT
    end

    if(typestr ~= nil)then
        if(typestr == "TH")then
            return this.guidePicMapTH[id];
        end
    end
    return this.guidePicMap[id];
end

ConfigRhythmGameMgr.GetGuideControl = function(id, typestr)
    if not typestr then
        local musicConfig,typeT = PlayerRhythmGameMgr.GetMusicConfig()
        typestr = typeT
    end

    if(typestr ~= nil)then
        if(typestr == "TH")then
            return this.guideControlsMapTH[id];
        end
    end
    return this.guideControlsMap[id];
end