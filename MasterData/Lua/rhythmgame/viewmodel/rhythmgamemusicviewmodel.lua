
require("RhythmGame/ViewModel/RhythmGameMusicItem")
require("RhythmGame/ViewModel/RhythmGameMusicPosItem")
require("RhythmGame/ViewModel/RhythmGameMusicAlbumItem")
require("RhythmGame/ViewModel/RhythmGameMusicEffectItem")

local this = {
    effectList = nil,
    albumsList = nil,
    scrollView = nil,
    scrollWidth = 472,
    dragArea = nil,
    downPos = nil,
    musicLen = 0,
    moveTime = 0,
    musicSong = nil,
    bgMaskImage = { "Assets/_BundleResources/Images/RhythmGame/xg_qpzz_01.png", "Assets/_BundleResources/Images/RhythmGame/xg_qpzz_02.png", "Assets/_BundleResources/Images/RhythmGame/xg_qpzz_03.png" }
};

local objs = {
    aniRoot = { path = "root", type = "Animator" },
    bgMask = { path = "root/BgMask", type = "RawImage" },
    backBtn = { path = "root/Left/Back", type = "Button" },
    albumItem = { path = "template/AlbumItem", type = "GameObject" },
    albumsTF = { path = "root/Left/Albums", type = "Transform" },
    musicItem = { path = "template/MusicItem", type = "GameObject" },
    posItem = { path = "template/PosItem", type = "GameObject" },
    effectItem = { path = "template/EffectItem", type = "GameObject" },
    effectsTF = { path = "root/Left/Effects/List", type = "Transform" },
    effectsBtn = { path = "root/Left/Effects", type = "Button" },
    novelImg = { path = "root/Left/Novel", type = "Image" },
    novelName = { path = "root/Left/Novel/Name", type = "Text" },
    novelNameShadow = { path = "root/Left/Novel/Name", type = "Shadow" },
    novelText = { path = "root/Left/Novel/Text", type = "UIText" },
    novelPlayImg = { path = "root/Left/Novel/Play", type = "Image" },
    novelPlayBtn = { path = "root/Left/Novel/Play", type = "Button" },
    novelRedDot = { path = "root/Left/Novel/RedDot", type = "GameObject" },
    startBtn = { path = "root/Middle/Start", type = "Button" },
    startLock = { path = "root/Middle/Start/Lock", type = "GameObject" },
    scrollViewGO = { path = "root/Right/ScrollView", type = "GameObject" },
    ImageRightTitle = { path = "root/Right/ScrollView/ImageRightTitle", type = "Image" },
    TextTitle = { path = "root/Right/ScrollView/ImageRightTitle/TextNum", type = "Text" },
};


this.SetData = function()
    this.SetEffects();
    this.SetAlbums();

    this.SetMusics();
end


this.SetEffects = function()
    this.effectList:Clear();
    local listData;
    local listDatas = {};
    local equips = DataMgr.Player.musicEquips.Equip;

    local musicEquips = {}
    for k, v in pairs(equips) do
        local item = RhythmGameMgr.GetMusicEquip(tonumber(k))
        table.insert(musicEquips, item)
    end

    table.sort(musicEquips, function(a, b)
        return a.id < b.id
    end)

    local len = 3;
    for i = #musicEquips + 1, 3, 1 do
        table.insert(musicEquips, { id = -1 })
    end

    for i = 1, len do
        listData = UIListData.GetData(this.effectItem, "RhythmGameMusicEffectItem", musicEquips[i]);
        table.insert(listDatas, listData);
    end
    this.effectList:SetData(listDatas);
    PlayerRhythmGameMgr.CheckEffectEntranceNewDot()   
    RedMgr.Singleton:Refresh()
end


this.SetAlbums = function()
    this.albumsList:Clear();
    local listData;
    local listDatas = {};
    local musicAlbums = ConfigMgr.Config.MusicAlbums;
    local len = #musicAlbums;
    if (len <= 0) then return end
    local originAlbum = PlayerRhythmGameMgr.GetMusicAlbum();
    if (originAlbum == nil) then
        PlayerRhythmGameMgr.SetMusicAlbum(musicAlbums[1].group);
    end
    for i = 1, len do
        listData = UIListData.GetData(this.albumItem, "RhythmGameMusicAlbumItem", musicAlbums[i]);
        table.insert(listDatas, listData);
    end
    this.albumsList:SetData(listDatas);
end


this.OnAlbum = function(args)
    local musicAlbum = args[0];
    local originAlbum = PlayerRhythmGameMgr.GetMusicAlbum();
    if (originAlbum == musicAlbum.group) then return end
    local musicAlbums = ConfigMgr.Config.MusicAlbums;
    for i, v in ipairs(musicAlbums) do
        if (v == musicAlbum) then
            this.bgMask.texture = LuaMgr.GetTexture(this.bgMaskImage[i]);
        end
    end
    PlayerRhythmGameMgr.SetMusicAlbum(musicAlbum.group);
    this.albumsList:Refresh();

    this.SetMusics();
    this.aniRoot:Rebind();
    this.aniRoot:Play("ani_RhythmGameMusicPanel_root_002");
end


this.OnSelect = function(args)
    this.musicSong = args[0];
    local musicSongData = PlayerRhythmGameMgr.GetMusicSong(this.musicSong.id);
    SetActive(this.startLock, musicSongData == nil);
end


this.SetNovel = function()
    local album = PlayerRhythmGameMgr.GetMusicAlbum();
    local albumConfig = ConfigRhythmGameMgr.GetAlbumConfig(album);
    this.novelImg.sprite = LuaMgr.GetSprite("RhythmGame", "ui_hd_yy_xg_intro_di_01");
    this.novelPlayImg.sprite = LuaMgr.GetSprite("RhythmGame", "ui_hd_yy_xg_intro_jq_01");
    this.novelName.text = ConfigMgr.LangGlobal(albumConfig.NameLan);
    this.novelNameShadow.effectColor = UnityEngine.Color(224 / 255, 127 / 255, 154 / 255, 1);
    this.novelText.text = albumConfig.text;
    SetActive(this.novelRedDot, false);
end


this.SetMusics = function()
    local scrollData;
    this.scrollView:Clear(false);
    local musicAlbum = PlayerRhythmGameMgr.GetMusicAlbum();
    local musicDatas = ConfigRhythmGameMgr.GetMusics(musicAlbum);
    local musicLen = #musicDatas;
    local scrollDatas = {};
    local totalNum = 0
    local totalMaxNum = 0
    for i = 1, musicLen do
        local data = {}
        data.index = i
        data.data = musicDatas[i];
        scrollData = UIScrollData.GetData(this.musicItem, "RhythmGameMusicItem", this.scrollWidth, 86, data);
        table.insert(scrollDatas, scrollData);
        local num, maxNum = ConfigRhythmGameMgr.GetTotalNum(data.data)
        totalNum = totalNum + num
        totalMaxNum = totalMaxNum + maxNum
    end
    this.scrollView:SetParams(this.scrollWidth, 670);
    this.scrollView:SetData(scrollDatas, true);
    this.TextTitle.text = string.format("<size=24>%s</size>/%s", totalNum, totalMaxNum)
    local albumConfig = ConfigRhythmGameMgr.GetAlbumConfig(musicAlbum);
    if (albumConfig ~= nil) then
        this.ImageRightTitle.sprite = LuaMgr.GetSprite("RhythmGame", albumConfig.otherIcon[2][1]);
    end
    PlayerRhythmGameMgr.CheckMusicNewDot()
    RedMgr.Singleton:Refresh()
end


this.OnClickBack = function()
    LuaMgr.Back();
end


this.OnClickEffects = function()
    LuaMgr.ShowLuaPanel(UIName.RhythmGameItemEffectSelectViewModel);
end


this.OnClickNovelPlay = function()

end


this.OnClickStart = function()
    if (this.musicSong == nil) then return end

    local musicSongData = PlayerRhythmGameMgr.GetMusicSong(this.musicSong.id);
    if (musicSongData == nil) then
        ConfigRhythmGameMgr.MusicUnlockTips(this.musicSong.unlock);
        return;
    end
    local songContent = ConfigRhythmGameMgr.GetSongContent(this.musicSong.eventID);
    PlayerRhythmGameMgr.SetMusicConfig(songContent);
    LuaMgr.ShowLuaPanel(UIName.RhythmGameViewModel);
end

this.OnItemEffectChange = function()
    this.SetEffects()
end

local command = {}
local data = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.effectList = UIListView.New(this.effectsTF);
        this.albumsList = UIListView.New(this.albumsTF);
        this.scrollView = UIScrollView.New(this.scrollViewGO);
        LuaMgr.AddClick(this.backBtn, this.OnClickBack);
        LuaMgr.AddClick(this.effectsBtn, this.OnClickEffects);
        LuaMgr.AddClick(this.novelPlayBtn, this.OnClickNovelPlay);

    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        RedMgr.Singleton:RegisterViewModel(UIName.RhythmGameMusicViewModel);
        LuaMgr.AddUIEventListener(UIEventConst.RhythmGameMusicAlbum, this.OnAlbum);
        LuaMgr.AddUIEventListener(UIEventConst.RhythmGameMusicSelect, this.OnSelect);
        LuaMgr.AddUIEventListener(UIEventConst.RhythmGameItemEffectChange, this.OnItemEffectChange);        
        this.SetData();
        this.aniRoot:Play("ani_RhythmGameMusicPanel_root_001");
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.RhythmGameMusicAlbum, this.OnAlbum);
        LuaMgr.RemoveUIEventListener(UIEventConst.RhythmGameMusicSelect, this.OnSelect);
        LuaMgr.RemoveUIEventListener(UIEventConst.RhythmGameItemEffectChange, this.OnItemEffectChange);
        this.effectList:Clear();
        this.albumsList:Clear();
        this.scrollView:Clear(true);
        this.downPos = nil;
        this.musicSong = nil;
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.backBtn, this.OnClickBack);
        LuaMgr.RemoveClick(this.effectsBtn, this.OnClickEffects);
        LuaMgr.RemoveClick(this.novelPlayBtn, this.OnClickNovelPlay);

        UIListView.ClearItem("RhythmGameMusicPosItem");
        UIListView.ClearItem("RhythmGameMusicEffectItem");
        UIListView.ClearItem("RhythmGameMusicAlbumItem");
        UIScrollView.ClearItem("RhythmGameMusicItem");
        RedMgr.Singleton:RemoveViewModel(UIName.RhythmGameMusicViewModel);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})