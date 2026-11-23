
require("RhythmGame/ViewModel/RhythmGameMusicTHItem")
require("RhythmGame/ViewModel/RhythmGameMusicAlbumTHItem")


local this = {   
    albumsList = nil,
    scrollView = nil,
    scrollWidth = 1270,   
    musicLen = 0,   
    musicSong = nil,
    typeStr = "TH",
};

local objs = {
    aniRoot = { path = "root", type = "Animator" },   
    backBtn = { path = "root/Left/Back", type = "Button" },
    albumItem = { path = "template/AlbumItem", type = "GameObject" },
    albumsTF = { path = "root/Middle/Albums", type = "Transform" },
    musicItem = { path = "template/MusicItem", type = "GameObject" }, 
    
    scrollViewGO = { path = "root/Middle/ScrollView", type = "GameObject" },
    ImageRightTitle = { path = "root/Middle/ImageRightTitle", type = "Image" },
    TextTitle = { path = "root/Middle/ImageRightTitle/TextNum", type = "Text" },
};


this.SetData = function()    
    this.SetAlbums();    
    this.SetMusics();
end



this.SetAlbums = function()
    this.albumsList:Clear();
    local listData;
    local listDatas = {};
    local musicAlbums = ConfigMgr.Config.THMusicAlbums;
    local len = #musicAlbums;
    if (len <= 0) then return end
    local originAlbum = PlayerRhythmGameMgr.GetTHMusicAlbum();
    if (originAlbum == nil) then
        PlayerRhythmGameMgr.SetTHMusicAlbum(musicAlbums[1].group);
    end
    for i = 1, len do
        listData = UIListData.GetData(this.albumItem, "RhythmGameMusicAlbumTHItem", musicAlbums[i]);
        table.insert(listDatas, listData);
    end
    this.albumsList:SetData(listDatas);
end


this.OnAlbum = function(args)
    local musicAlbum = args[0];
    local originAlbum = PlayerRhythmGameMgr.GetTHMusicAlbum();
    if (originAlbum == musicAlbum.group) then return end    
    PlayerRhythmGameMgr.SetTHMusicAlbum(musicAlbum.group);
    this.albumsList:Refresh();    
    this.SetMusics();
    this.aniRoot:Rebind();
    this.aniRoot:Play("ani_RhythmGameMusicPanel_root_002");
end



this.SetMusics = function()
    local scrollData;
    this.scrollView:Clear(false);
    local musicAlbum = PlayerRhythmGameMgr.GetTHMusicAlbum();
    local musicDatas = ConfigRhythmGameMgr.GetMusics(musicAlbum,this.typeStr);
    local musicLen = #musicDatas;
    local scrollDatas = {};
    local totalNum = 0
    local totalMaxNum = 0
    for i = 1, musicLen do
        local data = {}
        data.index = i
        data.data = musicDatas[i];
        scrollData = UIScrollData.GetData(this.musicItem, "RhythmGameMusicTHItem", 280, 420, data);
        table.insert(scrollDatas, scrollData);
        local num, maxNum = ConfigRhythmGameMgr.GetTotalNum(data.data,this.typeStr)
        totalNum = totalNum + num
        totalMaxNum = totalMaxNum + maxNum
    end
    this.scrollView:SetParams(this.scrollWidth, 420);
    this.scrollView:SetData(scrollDatas, true);
    this.TextTitle.text = string.format("<size=26><color=#6cedee>%s</color></size>/%s", totalNum, totalMaxNum)
    PlayerRhythmGameMgr.CheckMusicNewDot(this.typeStr)
    RedMgr.Singleton:Refresh()
end


this.OnClickBack = function()
    LuaMgr.Back();
end


this.OnClickStart = function()
    if (this.musicSong == nil) then return end

    local musicSongData = PlayerRhythmGameMgr.GetMusicSong(this.musicSong.id,this.typeStr);
    if (musicSongData == nil) then
        ConfigRhythmGameMgr.MusicUnlockTips(this.musicSong.unlock,this.typeStr);
        return;
    end
    local songContent = ConfigRhythmGameMgr.GetSongContent(this.musicSong.eventID,this.typeStr);
    PlayerRhythmGameMgr.SetTHMusicConfig(songContent);
    LuaMgr.ShowLuaPanel(UIName.RhythmGameViewModel);
end


this.ViewAdaptive = function()
    local addWidth = LuaMgr.GetScreenAddWidth();
    addWidth = addWidth > 0 and addWidth or 0;
    this.scrollWidth = 1270 + addWidth;
end

local command = {}
local data = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);   
        this.ViewAdaptive()   
        this.albumsList = UIListView.New(this.albumsTF);
        this.scrollView = UIScrollView.New(this.scrollViewGO);
        LuaMgr.AddClick(this.backBtn, this.OnClickBack);
        
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        RedMgr.Singleton:RegisterViewModel(UIName.RhythmGameMusicShortViewModel);
        LuaMgr.AddUIEventListener(UIEventConst.RhythmGameMusicAlbum, this.OnAlbum);       
             
        this.SetData();
        this.aniRoot:Play("ani_RhythmGameMusicPanel_root_001");
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.RhythmGameMusicAlbum, this.OnAlbum);        
       
        
        this.albumsList:Clear();
        this.scrollView:Clear(true);       
        this.musicSong = nil;
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.backBtn, this.OnClickBack);  
    
        UIListView.ClearItem("RhythmGameMusicAlbumTHItem");
        UIScrollView.ClearItem("RhythmGameMusicTHItem");
        RedMgr.Singleton:RemoveViewModel(UIName.RhythmGameMusicShortViewModel);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})