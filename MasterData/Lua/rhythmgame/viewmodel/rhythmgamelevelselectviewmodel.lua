
local this = {
    lvSelectBoxList = {},
    starBoxList = {},
    conditionItemList = {},
};

local objs = {
    rootPanel = { path = "root", type = "GameObject" },
    topBg = { path = "root/Panel/topBG", type = "Image" },
    imageBg = { path = "root/Panel/topBG/ImageBg", type = "Image" },
    imageBgGo = { path = "root/Panel/topBG/ImageBg", type = "GameObject" },
    exitBtn = { path = "root/Panel/topBG/BtnClose", type = "Button" },
    TextTitle = { path = "root/Panel/topBG/TextTitle", type = "Text" },
    TextGroup = { path = "root/Panel/topBG/TextGroup", type = "Text" },
    TextTotalPercent = { path = "root/Panel/topBG/TextPercent", type = "Text" },
    ButtonStar = { path = "root/Panel/bottomBG/ButtonStar", type = "Button" },
    ImageCollectBtn = { path = "root/Panel/Left/ImageCollectBtn", type = "Button" },
    starBox = { path = "root/Panel/Left/ImageCollectBtn/starBox", type = "Transform" },
    TextTotal = { path = "root/Panel/Left/Image1/TextTotal", type = "Text" },
    ImageLv = { path = "root/Panel/Left/Image2/ImageLv", type = "Image" },
    TextPercent = { path = "root/Panel/Left/Image3/TextPercent", type = "Text" },
    ImageLine1 = { path = "root/Panel/Left/Image1/ImageLine", type = "GameObject" },
    ImageLine2 = { path = "root/Panel/Left/Image2/ImageLine", type = "GameObject" },
    ImageLine3 = { path = "root/Panel/Left/Image3/ImageLine", type = "GameObject" },
    Right = { path = "root/Panel/Right", type = "Transform" },
    ConditionPanelBtn = { path = "root/Panel/ConditionPanel", type = "Button" },
    ConditionPanelBg = { path = "root/Panel/ConditionPanel/Bg", type = "RectTransform" },
    MaxLongText = { path = "root/Panel/ConditionPanel/Bg/MaxLongText", type = "Text" },
};

this.InitObjBox = function(...)
    for i = 1, this.Right.childCount do
        local child = this.Right:GetChild(i - 1)
        local cacheTable = this.InitEveryLvSelect(child, i)
        table.insert(this.lvSelectBoxList, cacheTable)
    end
    for i = 1, this.starBox.childCount do
        local child = this.starBox:GetChild(i - 1)
        local obj = child:Find("ImgStar").gameObject
        table.insert(this.starBoxList, obj)
    end
    for i = 2, this.ConditionPanelBg.childCount do
        local child = this.ConditionPanelBg:GetChild(i - 1)
        local cacheTable = this.InitConditionItem(child)
        table.insert(this.conditionItemList, cacheTable)
    end
end

this.InitEveryLvSelect = function(tras, index)
    local cacheTable = {}

    cacheTable.Btn = tras:GetComponent("Button")
    cacheTable.redIconListener = tras:GetComponent("RedIconListener")
    cacheTable.LockObj = tras:Find("LockImg").gameObject
    cacheTable.SelectedObj = tras:Find("Selected").gameObject
    cacheTable.TextNum = tras:Find("TextNum"):GetComponent("Text")
    cacheTable.OnBtnClick = function(...)
        this.CheckLevelLock(index)
    end
    LuaMgr.AddClick(cacheTable.Btn, cacheTable.OnBtnClick);
    return cacheTable
end

this.InitConditionItem = function(tras)
    local cacheTable = {}
    cacheTable.ImgStar = tras:Find("Image/ImgStarBg/ImgStar")
.gameObject
    cacheTable.TextContent = tras:Find("TextContent"):GetComponent("Text")
    cacheTable.MaxLongText = tras:Find("MaxLongText"):GetComponent("Text")
    return cacheTable
end


this.SetData = function(paramData)
    local data = paramData
    this.data = data

    local nameStr = "";
    local eventId = 0;
    if (data.Easy ~= nil) then
        nameStr = LuaMgr.GetLangText(data.Easy.nameLan);
        eventId = data.Easy.eventID
    elseif (data.Hard ~= nil) then
        nameStr = LuaMgr.GetLangText(data.Hard.nameLan);
        eventId = data.Hard.eventID
    elseif (data.Master ~= nil) then
        nameStr = LuaMgr.GetLangText(data.Master.nameLan);
        eventId = data.Master.eventID
    end

    local song = ConfigRhythmGameMgr.GetSongContent(eventId);
    local bNotNil = song.songBanner ~= nil and #song.songBanner > 0
    SetActive(this.imageBgGo, bNotNil)
    if (bNotNil) then
        local list = NumTool.split(song.songBanner, "/");
        this.imageBg.sprite = LuaMgr.GetSprite("RhythmGame", list[1]);
    end
    this.TextTitle.text = nameStr;
    local group = tostring(data.group);
    group = data.group < 10 and "0" .. group or group;
    this.TextGroup.text = group;
    local num, maxNum = ConfigRhythmGameMgr.GetTotalNum(data)
    if (num >= maxNum) then
        this.TextTotalPercent.text = string.format("<size=24><color=#bbf6d5>%s</color></size>/%s", num, maxNum)
    else
        this.TextTotalPercent.text = string.format("<size=24>%s</size>/%s", num, maxNum)
    end
    for i, v in ipairs(this.lvSelectBoxList) do        
        local config = this.GetDataByType(i)
        v.redIconListener.RedId ="12013_".. config.id
        local songContent = ConfigRhythmGameMgr.GetSongContent(config.eventID);
        if (songContent ~= nil) then
            v.TextNum.text = songContent.rank;
        end
        local musicSong = PlayerRhythmGameMgr.GetMusicSong(config.id);
        SetActive(v.LockObj, musicSong == nil);
    end
    PlayerRhythmGameMgr.CheckMusicNewDot()
    RedMgr.Singleton:Refresh()
    this.CheckLevelLock(1)
end

this.GetDataByType = function(type)
    local musicSong = nil
    if (type == 1) then
        musicSong = this.data.Easy
    elseif (type == 2) then
        musicSong = this.data.Hard
    else
        musicSong = this.data.Master
    end
    return musicSong
end

this.CheckLevelLock = function(type)
    local musicSong = this.GetDataByType(type)
    local musicSongData = PlayerRhythmGameMgr.GetMusicSong(musicSong.id);
    if (musicSongData == nil) then
        ConfigRhythmGameMgr.MusicUnlockTips(musicSong.unlock);



    else
        for i, v in ipairs(this.lvSelectBoxList) do
            SetActive(v.SelectedObj, i == type)
        end
        local refresh = PlayerRhythmGameMgr.UpdateMusicNewDotData(musicSong.id)
        if(refresh)then
            PlayerRhythmGameMgr.CheckMusicNewDot()
            RedMgr.Singleton:Refresh()
        end
        this.SelectLevel(musicSong);
    end
end

this.SelectLevel = function(musicSong)
    this.musicSongConfig = musicSong
    local songContent = ConfigRhythmGameMgr.GetSongContent(musicSong.eventID);
    local musicSongData = PlayerRhythmGameMgr.GetMusicSong(musicSong.id);

    if (musicSongData == nil or musicSongData.score == 0) then
        this.TextTotal.text = "";
        this.TextPercent.text = "";
        SetActive(this.ImageLv.gameObject, false);
        for i = 1, 3 do
            SetActive(this["ImageLine" .. i], true)
        end
        for i, v in ipairs(this.starBoxList) do
            SetActive(v, false)
        end
    else
        local judge = ConfigRhythmGameMgr.GetJudge(songContent, musicSongData.score, musicSongData.maxScore);
        this.ImageLv.sprite = LuaMgr.GetSprite("RhythmGame", "ui_hd_yy_xg_largebar_rate_0" .. judge);
        this.TextTotal.text = tostring(musicSongData.score);
        this.TextPercent.text = musicSongData.hit .. "B";
        SetActive(this.ImageLv.gameObject, true);
        for i = 1, 3 do
            SetActive(this["ImageLine" .. i], false)
        end
        for i, v in ipairs(this.starBoxList) do
            SetActive(v, musicSongData["condition" .. i] == 1);
        end
    end
end

this.SetConditionItem = function()
    local musicSongConfig = ConfigRhythmGameMgr.GetSongContent(this.musicSongConfig.eventID);
    local musicSongData = PlayerRhythmGameMgr.GetMusicSong(this.musicSongConfig.id);
    local num = 0
    local maxLongText = ""
    for i, v in ipairs(this.conditionItemList) do
        local config = musicSongConfig["Condition" .. i]
        local data = musicSongData["condition" .. i]
        local content = ConfigRhythmGameMgr.GetConditionText(config[1], config[2])
        v.TextContent.text = content
        SetActive(v.ImgStar, data == 1)
        if (#content > num) then
            num = #content
            maxLongText = content
        end
    end
    for i, v in ipairs(this.conditionItemList) do
        v.MaxLongText.text = maxLongText
    end
    this.MaxLongText.text = maxLongText
end



this.OnClickBack = function()
    LuaMgr.HidePanel(UIName.RhythmGameLevelSelectViewModel);
end

this.OnButtonStar = function()
    if (this.musicSongConfig == nil) then return end

    local musicSongData = PlayerRhythmGameMgr.GetMusicSong(this.musicSongConfig.id);
    if (musicSongData == nil) then
        ConfigRhythmGameMgr.MusicUnlockTips(this.musicSongConfig.unlock);
        return;
    end
    if this.startDelay ~= nil then
        coroutine_runner.stop(this.startDelay)
    end
    this.startDelay = coroutine_runner.start(function()
        LuaMgr.ShowLuaPanel(UIName.RhythmGameLoadViewModel);
        coroutine_runner.wait(1.5)        
        local songContent = ConfigRhythmGameMgr.GetSongContent(this.musicSongConfig.eventID);
        PlayerRhythmGameMgr.SetMusicConfig(songContent);
        LuaMgr.ShowLuaPanel(UIName.RhythmGameViewModel);  
        SetActive(this.rootPanel,false)      

        coroutine_runner.wait(0.75)             
        LuaMgr.HidePanel(UIName.RhythmGameLoadViewModel)
        LuaMgr.HidePanel(UIName.RhythmGameLevelSelectViewModel);          
    end)   
end

this.OnImageCollectBtn = function()
    this.SetConditionItem()
    SetActive(this.ConditionPanelBtn.gameObject, true)
end

this.OnConditionPanelBtn = function()
    SetActive(this.ConditionPanelBtn.gameObject, false)
end

local command = {}
local data = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.exitBtn, this.OnClickBack);
        LuaMgr.AddClick(this.ButtonStar, this.OnButtonStar);
        LuaMgr.AddClick(this.ImageCollectBtn, this.OnImageCollectBtn);
        LuaMgr.AddClick(this.ConditionPanelBtn, this.OnConditionPanelBtn);
        RedMgr.Singleton:RegisterViewModel(UIName.RhythmGameLevelSelectViewModel);
        
        this.InitObjBox()
    end,
    before_active = function(vm)
        SetActive(this.rootPanel,true)
        if (vm.behaviour.Params == nil) then return end
        this.paramData = vm.behaviour.Params[0];
        this.SetData(this.paramData);


    end,
    before_deactive = function(vm)
        SetActive(this.rootPanel,true)
        if (not coroutine_runner.checkIsDestory()) and this.startDelay~=nil then
            coroutine_runner.stop(this.startDelay);
            this.startDelay=nil;
         end



    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.exitBtn, this.OnClickBack);
        LuaMgr.RemoveClick(this.ButtonStar, this.OnButtonStar);
        LuaMgr.RemoveClick(this.ImageCollectBtn, this.OnImageCollectBtn);
        LuaMgr.RemoveClick(this.ConditionPanelBtn, this.OnConditionPanelBtn);
        RedMgr.Singleton:RemoveViewModel(UIName.RhythmGameLevelSelectViewModel);
        for i, v in ipairs(this.lvSelectBoxList) do
            LuaMgr.RemoveClick(v.Btn, v.OnBtnClick);
        end
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})