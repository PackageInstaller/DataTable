local this = {
    vm = nil,
    scrollRect = nil,
    scrollRectHeight = nil,
    scrollRectContent = nil,
    bgmTF = nil,
    cycleObj = nil,
    randomObj = nil,
    bgmListCountText = nil,
    progressDotTF = nil,
    progressDotDir = Vector2(0, 0),
    progressDotDistance = 0,
    bgmIconsPath = "Assets/_BundleResources/Images/BgmIcons/%s.png",
    pos1 = Vector3(-268, 6, 0),
    pos2 = Vector3(-88, 6, 0),
    pos3 = Vector3(90, 6, 0),
    pos4 = Vector3(270, 6, 0),
    musicList = {},
    nowId = "",
    selectId = "",
    selectIndex = 0,
    bgmAngle = Vector3(0, 0, 0),
    bgmAngle2 = Vector3(0, 0, 0),
    isPlay = false,
    playItemObj = {},
    playId = "",
    playTime = 0,
    bgmTime = 0,
    bgmPath = "",
    isPlayAni = false,
    music = nil,
    goods = nil,
    isTips = false,
    playType = 0,
    bgmMaxCount = 0,   
    bgmList = {},    
    PlayTypeEnum = {
        cycle = 0,
        random = 1,
        max = 2,
    }
}

local lockColor = UnityEngine.Color(1, 1, 1, 0.8);
local unlockColor = UnityEngine.Color(1, 1, 1, 1);

local data = {
    bgmList = { {
        num1 = "",
        num2 = "",
        num3 = "",
        num4 = "",
        isIcon1 = false,
        isIcon2 = false,
        isIcon3 = false,
        isIcon4 = false,
        icon1 = DefaultTexture,
        icon2 = DefaultTexture,
        icon3 = DefaultTexture,
        icon4 = DefaultTexture,
        icon1Color = unlockColor,
        icon2Color = unlockColor,
        icon3Color = unlockColor,
        icon4Color = unlockColor,
        now1 = false,
        now2 = false,
        now3 = false,
        now4 = false,
        InBgmList1 = false,
        InBgmList2 = false,
        InBgmList3 = false,
        InBgmList4 = false,
        localEulerAngles1 = Vector3.zero,
        localEulerAngles2 = Vector3.zero,
        localEulerAngles3 = Vector3.zero,
        localEulerAngles4 = Vector3.zero,
        nowAni1 = false,
        nowAni2 = false,
        nowAni3 = false,
        nowAni4 = false,
        light1 = false,
        light2 = false,
        light3 = false,
        light4 = false,
        name1 = "",
        name2 = "",
        name3 = "",
        name4 = "",
        lock1 = false,
        lock2 = false,
        lock3 = false,
        lock4 = false,
        buyLock1 = false,
        buyLock2 = false,
        buyLock3 = false,
        buyLock4 = false,
        buyLockText = "",
        bgSize = Vector2.zero,
        nameSize = Vector2.zero,
        pos1 = Vector3.zero,
        pos2 = Vector3.zero,
        pos3 = Vector3.zero,
        pos4 = Vector3.zero,
        isPlayAni = false
    } },
    bgmIcon = DefaultTexture,
    bgmName = "",
    progressValue = 0.0,
    isArrow = false,
    isPlayBtn = false,
    isPauseBtn = false,
    aniName = "",
    isChange = false,
    isBuyTips = false,
    isNormal = true,
    buyTips = "",
    buyTips2 = "",
    coin1Icon = DefaultTexture,
    coin1Num = "",
    coin2Icon = DefaultTexture,
    coin2Num = "",
}




this.InitBgms = function()   
    this.bgmList = DataMgr.Player.FoundationMusicData.List;  
    this.bgmMaxCount = ConfigMgr.Config.constants.MusicNum
    this.playType = DataMgr.Player.FoundationMusicData.Type
    if (this.bgmList == nil or #this.bgmList <= 0) then
        local music = ConfigFoundationMgr.GetDefualtMusic();
        if (music ~= nil) then
            this.nowId = music.Id;
        end
    else
        this.nowId = this.GetIdByPath(AudioMgr.Singleton.CurrentBgmAudio)
    end
    this.musicList = {};
    local time = LuaMgr.Timestamp();
    local foundationMusicMap = ConfigMgr.Config.FoundationMusicMap;
    for _, v in pairs(foundationMusicMap) do
        if (time >= v.StartTime and time <= v.EndTime) then
            table.insert(this.musicList, v);
        end
    end
    table.sort(this.musicList, this.BgmSort);

    this.bgmListCountText.text = string.format(LuaMgr.GetLangText("FoundationBgmViewModel_0"), #this.bgmList, this.bgmMaxCount)

    this.scrollRect.vertical = #this.musicList > 8;
    this.vm.data.isArrow = false;
end


this.SetBgms = function()
    local list = {};
    local item;
    local index = 1;
    local len = #this.musicList;
    while (index <= len) do
        item = this.SetBgmData(index,
            this.musicList[index],
            this.musicList[index + 1],
            this.musicList[index + 2],
            this.musicList[index + 3]);
        table.insert(list, item);
        index = index + 4;
    end
    this.vm.data.bgmList = list;
end


this.BgmSort = function(a, b)
    return a.Id < b.Id;
end


this.SetBgmData = function(index, bgm1, bgm2, bgm3, bgm4)
    local item = {
        nowAni1 = false,
        nowAni2 = false,
        nowAni3 = false,
        nowAni4 = false,
        pos1 = this.pos1,
        pos2 = this.pos2,
        pos3 = this.pos3,
        pos4 = this.pos4,
        light1 = false,
        light2 = false,
        light3 = false,
        light4 = false,
        localEulerAngles1 = Vector3.zero,
        localEulerAngles2 = Vector3.zero,
        localEulerAngles3 = Vector3.zero,
        localEulerAngles4 = Vector3.zero
    };
    item.bgSize = Vector2(index == 1 and 768 or 800, 288);
    item.nameSize = Vector2(index == 1 and 724 or 756, 60);
    item.isPlayAni = this.isPlayAni;
    if (bgm1 ~= nil) then
        item.id1 = bgm1.Id;
        item.num1 = this.GetBgmNum(index);
        item.isIcon1 = true;
        item.icon1 = LuaMgr.GetTexture(string.format(this.bgmIconsPath, bgm1.Icon));

        item.InBgmList1 = this.GetIndex(this.bgmList, bgm1.Id) ~= -1
        item.name1 = LuaMgr.GetLangText(bgm1.NameLan);
        item.lock1 = false;
        if (this.IsBgmBuyLock(bgm1)) then
            item.icon1Color = lockColor;
            item.buyLock1 = true;
        else
            item.icon1Color = unlockColor;
            item.buyLock1 = false;
        end
    else
        item.num1 = "";
        item.isIcon1 = false;
        item.icon1 = nil;
        item.now1 = false;
        item.name1 = "";
        item.lock1 = true;
        item.buyLock1 = false;
    end
    if (bgm2 ~= nil) then
        item.id2 = bgm2.Id;
        item.num2 = this.GetBgmNum(index + 1);
        item.isIcon2 = true;
        item.icon2 = LuaMgr.GetTexture(string.format(this.bgmIconsPath, bgm2.Icon));

        item.InBgmList2 = this.GetIndex(this.bgmList, bgm2.Id) ~= -1
        item.name2 = LuaMgr.GetLangText(bgm2.NameLan);
        item.lock2 = false;
        if (this.IsBgmBuyLock(bgm2)) then
            item.icon2Color = lockColor;
            item.buyLock2 = true;
        else
            item.icon2Color = unlockColor;
            item.buyLock2 = false;
        end
    else
        item.num2 = "";
        item.isIcon2 = false;
        item.icon2 = nil;
        item.now2 = false;
        item.name2 = "";
        item.lock2 = true;
        item.buyLock2 = false;
    end
    if (bgm3 ~= nil) then
        item.id3 = bgm3.Id;
        item.num3 = this.GetBgmNum(index + 2);
        item.isIcon3 = true;
        item.icon3 = LuaMgr.GetTexture(string.format(this.bgmIconsPath, bgm3.Icon));

        item.InBgmList3 = this.GetIndex(this.bgmList, bgm3.Id) ~= -1
        item.name3 = LuaMgr.GetLangText(bgm3.NameLan);
        item.lock3 = false;
        if (this.IsBgmBuyLock(bgm3)) then
            item.icon3Color = lockColor;
            item.buyLock3 = true;
        else
            item.icon3Color = unlockColor;
            item.buyLock3 = false;
        end
    else
        item.num3 = "";
        item.isIcon3 = false;
        item.icon3 = nil;
        item.now3 = false;
        item.name3 = "";
        item.lock3 = true;
        item.buyLock3 = false;
    end
    if (bgm4 ~= nil) then
        item.id4 = bgm4.Id;
        item.num4 = this.GetBgmNum(index + 3);
        item.isIcon4 = true;
        item.icon4 = LuaMgr.GetTexture(string.format(this.bgmIconsPath, bgm4.Icon));

        item.InBgmList4 = this.GetIndex(this.bgmList, bgm4.Id) ~= -1
        item.name4 = LuaMgr.GetLangText(bgm4.NameLan);
        item.lock4 = false;
        if (this.IsBgmBuyLock(bgm4)) then
            item.icon4Color = lockColor;
            item.buyLock4 = true;
        else
            item.icon4Color = unlockColor;
            item.buyLock4 = false;
        end
    else
        item.num4 = "";
        item.isIcon4 = false;
        item.icon4 = nil;
        item.now4 = false;
        item.name4 = "";
        item.lock4 = true;
        item.buyLock4 = false;
    end
    return item;
end


this.IsBgmBuyLock = function(bgm)
    if (bgm.UnlockType == 0) then
        return false
    end

    return DataMgr.Player.foundationUnlockMusic[bgm.Id] == nil;
end


this.GetBgmNum = function(num)
    if (num < 10) then
        return "0" .. num;
    end
    return tostring(num);
end


this.SelectBgm = function(id)
    if (this.selectId == id) then
        return
    end

    this.selectId = id;
    local music = ConfigMgr.Config.FoundationMusicMap[id];
    if (music ~= nil) then
        this.SetIconStatus(this.selectIndex, false, true);
        this.selectIndex = this.FindBgmIndex(id);
        this.vm.data.bgmIcon = LuaMgr.GetTexture(string.format(this.bgmIconsPath, music.Icon));
        this.vm.data.bgmName = LuaMgr.GetLangText("FoundationBgmViewModel_1") .. LuaMgr.GetLangText(music.NameLan);
        this.vm.data.progressValue = 0.0;
        this.SetIconStatus(this.selectIndex, true, true);
        this.SetNowAni(this.selectIndex);
        this.bgmAngle.z = 0;
        this.bgmTF.localRotation = UnityEngine.Quaternion.Euler(this.bgmAngle);
        this.progressDotTF.anchoredPosition = Vector2(-5, -3);
        if (this.playId == this.selectId) then
            this.isPlay = true;
            this.vm.data.isPlayBtn = false;
            this.vm.data.isPauseBtn = true;
        else
            this.isPlay = false;
            this.vm.data.isPlayBtn = true;
            this.vm.data.isPauseBtn = false;
        end
        this.goods = nil;
        this.isTips = false;
        this.vm.data.buyTips = "";
        this.vm.data.buyTips2 = ""
        if (this.IsBgmBuyLock(music)) then
            this.vm.data.isChange = false;
            this.vm.data.isBuyTips = false;
            this.vm.data.isNormal = false;
            this.vm.data.isArrow = false;
            this.SetBuyTips(music);
        else
            this.vm.data.isChange = true;
            this.vm.data.isBuyTips = false;
            this.vm.data.isNormal = true;
        end
    end
end


this.SetBgmCD = function(id)
    local music = ConfigMgr.Config.FoundationMusicMap[id];
    if (music ~= nil) then
        this.selectIndex = this.FindBgmIndex(id);
        this.vm.data.bgmIcon = LuaMgr.GetTexture(string.format(this.bgmIconsPath, music.Icon));
        this.vm.data.bgmName = LuaMgr.GetLangText("FoundationBgmViewModel_1") .. LuaMgr.GetLangText(music.NameLan);
        this.vm.data.progressValue = 0.0;
        this.SetIconStatus(this.selectIndex, true, false);
        this.bgmAngle.z = 0;
        this.bgmTF.localRotation = UnityEngine.Quaternion.Euler(this.bgmAngle);
        this.progressDotTF.anchoredPosition = Vector2(-5, -3);
        this.isPlay = false;
        this.vm.data.isPlayBtn = true;
        this.vm.data.isPauseBtn = false;
        this.vm.data.isChange = false;
        this.vm.data.isBuyTips = false;
        this.vm.data.isNormal = true;
    end
end


this.GotoPos = function()
    local itemIndex = math.ceil(this.selectIndex / 4);
    if (itemIndex >= 3) then
        local py = (itemIndex - 1) * (280 - 43) + 20;
        local height = this.scrollRectContent.sizeDelta.y - this.scrollRectHeight;
        if (py > height) then
            py = height;
        end
        this.scrollRectContent.anchoredPosition = Vector2(0, py);
    else
        this.scrollRectContent.anchoredPosition = Vector2(0, 0);
    end
end


this.SetIconStatus = function(index, status, nowStatus)
    local itemIndex = math.ceil(index / 4);
    local itemData = this.vm.data.bgmList[itemIndex];
    if (itemData ~= nil) then
        local py = 6;
        if (status) then
            py = py + 20;
        end
        local itemNum = index % 4;
        if (itemNum == 1) then
            itemData.pos1 = Vector3(-268, py, 0);
            itemData.light1 = status;

        elseif (itemNum == 2) then
            itemData.pos2 = Vector3(-88, py, 0);
            itemData.light2 = status;

        elseif (itemNum == 3) then
            itemData.pos3 = Vector3(90, py, 0);
            itemData.light3 = status;

        elseif (itemNum == 0) then
            itemData.pos4 = Vector3(270, py, 0);
            itemData.light4 = status;

        end
    end
end


this.SetNowAni = function(index)
    local itemIndex = math.ceil(index / 4);
    local itemData = this.vm.data.bgmList[itemIndex];
    if (itemData ~= nil) then
        local itemNum = index % 4;
        if (itemNum == 1) then
            itemData.nowAni1 = true;
        elseif (itemNum == 2) then
            itemData.nowAni2 = true;
        elseif (itemNum == 3) then
            itemData.nowAni3 = true;
        elseif (itemNum == 0) then
            itemData.nowAni4 = true;
        end
    end
end


this.FindBgmIndex = function(id)
    local len = #this.musicList;
    if (len > 0) then
        for i = 1, len do
            if (this.musicList[i].Id == id) then
                return i;
            end
        end
    end
    return 1;
end


this.OnUpdate = function()
    this.CheckPlay();
    this.CheckArrow();
end


this.CheckPlay = function()
    if (this.isPlay) then
        this.bgmAngle.z = this.bgmAngle.z - 1;
        this.bgmTF.localRotation = UnityEngine.Quaternion.Euler(this.bgmAngle);
        local time = os.time() - this.playTime;
        local progress = time / this.bgmTime;
        if (progress > 1) then
            progress = 0.0;
            this.playTime = os.time();
        end
        this.vm.data.progressValue = progress;
        local distance = this.progressDotDistance * progress;
        local p = this.progressDotDir * distance;
        p.x = p.x - 5;
        p.y = p.y - 3;
        this.progressDotTF.anchoredPosition = p;
    end
    local playIndex = this.FindBgmIndex(this.playId)
    this.bgmAngle2.z = this.bgmAngle2.z - 1;
    local itemIndex = math.ceil(playIndex / 4);
    local itemData = this.vm.data.bgmList[itemIndex];
    if (itemData ~= nil) then
        local itemNum = playIndex % 4;
        if (itemNum == 1) then
            itemData.localEulerAngles1 = this.bgmAngle2
        elseif (itemNum == 2) then
            itemData.localEulerAngles2 = this.bgmAngle2
        elseif (itemNum == 3) then
            itemData.localEulerAngles3 = this.bgmAngle2
        elseif (itemNum == 0) then
            itemData.localEulerAngles4 = this.bgmAngle2
        end
    end
end


this.CheckArrow = function()
    if (#this.musicList > 8 and this.goods == nil and not this.isTips) then
        local py = this.scrollRectContent.anchoredPosition.y;
        local height = this.scrollRectContent.sizeDelta.y;
        if (py + this.scrollRectHeight + 50 < height) then
            this.vm.data.isArrow = true;
        else
            this.vm.data.isArrow = false;
        end
    end
end


this.PlayBgm = function(id)
    local prePlayIndex = this.FindBgmIndex(this.playId)
    local itemIndex = math.ceil(prePlayIndex / 4);
    local itemData = this.vm.data.bgmList[itemIndex];
    this.bgmAngle2 = Vector3.zero
    if (itemData ~= nil) then
        local itemNum = prePlayIndex % 4;
        if (itemNum == 1) then
            itemData.pos1 = Vector3.zero;
        elseif (itemNum == 2) then
            itemData.localEulerAngles2 = Vector3.zero;
        elseif (itemNum == 3) then
            itemData.localEulerAngles3 = Vector3.zero;
        elseif (itemNum == 0) then
            itemData.localEulerAngles4 = Vector3.zero;
        end
    end

    local config = ConfigMgr.Config.FoundationMusicMap[id];
    if (config ~= nil) then
        this.bgmPath = string.format("%sBgm/%s.mp3", Path.audio_PATH, config.Resources);
        this.bgmTime = AudioMgr.Singleton:GetClipTime(this.bgmPath);
        AudioMgr.Singleton:StopBgm(false);
        AudioMgr.Singleton:PlayBgm(this.bgmPath, false);
        this.isPlay = true;
        this.playId = id;
        this.playTime = os.time();
        this.vm.data.isPlayBtn = false;
        this.vm.data.isPauseBtn = true;
        this.SetBgms()
    end
end


this.SelectMusicResponse = function()
    this.nowId = this.selectId;
    this.selectId = "";
    this.SetBgms();
    this.SelectBgm(this.nowId);
    if (not this.isPlay) then
        this.PlayBgm(this.nowId);
    end
end


this.ChangeBGMListResponse = function()
    this.bgmList = DataMgr.Player.FoundationMusicData.List;
    this.bgmListCountText.text = string.format(LuaMgr.GetLangText("FoundationBgmViewModel_2"), #this.bgmList, this.bgmMaxCount)
    this.SetBgms();
end


this.ChangePlayType = function()
    SetActive(this.cycleObj.gameObject, this.playType == this.PlayTypeEnum.cycle)
    SetActive(this.randomObj.gameObject, this.playType == this.PlayTypeEnum.random)
end


this.OnAniPlayFinish = function()
    LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAniPlayFinish);
    this.isPlayAni = false;
    local len = #this.vm.data.bgmList;
    for i = 1, len do
        this.vm.data.bgmList[i].isPlayAni = this.isPlayAni;
    end
    this.SelectBgm(this.nowId);
    this.GotoPos();
    this.PlayBgm(this.nowId);
    LuaMgr.AddUpdate(this.OnUpdate);
end


this.SetBuyTips = function(music)
    local musicShop = ConfigMgr.Config.shop.MusicShop;
    if (musicShop == nil) then
        return
    end

    local shelf = musicShop.shelfs[1];
    if (shelf == nil) then
        return
    end

    this.music = music;
    local goods;
    local len = #shelf.goods;
    for i = 1, len do
        goods = shelf.goods[i];
        if (goods.Id == music.GoodsId) then
            this.goods = goods;
            break;
        end
    end
    if (this.goods == nil) then
        this.isTips = true;
        this.vm.data.buyTips2 = LuaMgr.GetLangText(music.SourceTipLan);
        return;
    end
    this.vm.data.buyTips2 = ""
    this.vm.data.isBuyTips = true;
    this.vm.data.isNormal = false;
    this.vm.data.buyTips = ConfigMgr.LangGlobal("6966");
    this.vm.data.coin1Icon = GetItemHomeIcon(this.goods.Currency);
    local itemCount = PlayerItemMgr.GetItemCountById(this.goods.Currency);
    if (itemCount >= this.goods.Price) then
        this.vm.data.coin1Num = LuaMgr.NumFormat(this.goods.Price);
    else
        this.vm.data.coin1Num = string.format("<color=#d73030>%s</color>", LuaMgr.NumFormat(this.goods.Price));
    end
    this.vm.data.coin2Icon = GetItemHomeIcon(this.goods.Price2[1]);
    itemCount = PlayerItemMgr.GetItemCountById(this.goods.Price2[1]);
    local needCount = tonumber(this.goods.Price2[2]);
    if (itemCount >= needCount) then
        this.vm.data.coin2Num = LuaMgr.NumFormat(needCount);
    else
        this.vm.data.coin2Num = string.format("<color=#d73030>%s</color>", LuaMgr.NumFormat(needCount));
    end
end


this.BuyGoodsResponse = function(result)
    if (this.music ~= nil) then
        local msg = string.format(ConfigMgr.LangGlobal("6967"), LuaMgr.GetLangText(this.music.NameLan));
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, msg);
    end
    local id = this.selectId;
    this.selectId = "";
    this.SetBgms();
    this.SelectBgm(id);
end

this.GetIndex = function(list, value)
    for i, v in ipairs(list) do
        if v == value then
            return i
        end
    end
    return -1
end

this.GetIdByPath = function(path)
    for i, v in pairs(ConfigMgr.Config.FoundationMusicMap) do
        local bMatch = string.match(path, v.Resources)
        if bMatch then
            return i
        end
    end
    return nil
end

local command = {
    OnClickBack = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)            
            ConfigFoundationMgr.PlayBgmMusic();
            LuaMgr.HidePanel(UIName.FoundationBgmViewModel);
        end
    },
    OnClickPrev = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = this.selectIndex - 1;
            if (index <= 0) then
                index = #this.musicList;
            end
            this.SelectBgm(this.musicList[index].Id);
            this.GotoPos();
        end
    },
    OnClickPlay = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if (not this.isPlay) then
                this.PlayBgm(this.selectId);
                local probs = json.encode({ act_type = 0, after_music = this.selectId });
                PlayerFoundationMgr.LogBiliEvent({ Event = "foundation_office_music", Probs = probs });
            end
        end
    },
    OnClickNext = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = this.selectIndex + 1;
            if (index > #this.musicList) then
                index = 1;
            end
            this.SelectBgm(this.musicList[index].Id);
            this.GotoPos();
        end
    },
    OnClickIcon1 = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param);
            local bgmData = this.vm.data.bgmList[index + 1];
            if (bgmData ~= nil) then
                this.SelectBgm(bgmData.id1);
            end
        end
    },
    OnClickIcon2 = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param);
            local bgmData = this.vm.data.bgmList[index + 1];
            if (bgmData ~= nil) then
                this.SelectBgm(bgmData.id2);
            end
        end
    },
    OnClickIcon3 = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param);
            local bgmData = this.vm.data.bgmList[index + 1];
            if (bgmData ~= nil) then
                this.SelectBgm(bgmData.id3);
            end
        end
    },
    OnClickIcon4 = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param);
            local bgmData = this.vm.data.bgmList[index + 1];
            if (bgmData ~= nil) then
                this.SelectBgm(bgmData.id4);
            end
        end
    },
    OnClickAdd = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if #this.bgmList >= this.bgmMaxCount then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ErrCodeLan_ErrCode_messagelan_156"));
            end
            if this.GetIndex(this.bgmList, this.selectId) ~= -1 then
                return
            end
            local addList = { this.selectId }
            PlayerFoundationMgr.SelectBGMList(addList, this.ChangeBGMListResponse);
        end
    },
    OnClickReMove = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local bgmIndex = this.GetIndex(this.bgmList, this.selectId)
            if bgmIndex == -1 then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_26519"));
                return
            end
            if #this.bgmList <= 1 then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("ErrCodeLan_ErrCode_messagelan_157"));
                return
            end
            if bgmIndex ~= -1 then
                local removeList = { this.selectId }
                PlayerFoundationMgr.RemoveBGMList(removeList, this.ChangeBGMListResponse);
            end
        end
    },
    OnClickBuyCoin1 = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if (this.goods ~= nil) then
                PlayerFoundationMgr.BuyGoods(this.goods.Id, this.goods.RefreshCount, this.goods.Currency,
                    this.BuyGoodsResponse);
            end
        end
    },
    OnClickBuyCoin2 = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if (this.goods ~= nil) then
                PlayerFoundationMgr.BuyGoods(this.goods.Id, this.goods.RefreshCount, this.goods.Price2[1],
                    this.BuyGoodsResponse);
            end
        end
    },
    OnClickChangePlayType = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.playType = (this.playType + 1) % this.PlayTypeEnum.max
            PlayerFoundationMgr.ChangePlayerType(this.playType, this.ChangePlayType);
        end
    }

}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        local bgmList = vm.behaviour.transform:Find("root/Middle/BgmList");
        this.scrollRectHeight = bgmList.sizeDelta.y;
        this.scrollRect = bgmList:GetComponent("ScrollRect");
        this.scrollRectContent = vm.behaviour.transform:Find("root/Middle/BgmList/Viewport/Content"):GetComponent(
            "RectTransform");
        this.bgmTF = vm.behaviour.transform:Find("root/Left/Bgm");
        this.progressDotTF = vm.behaviour.transform:Find("root/Left/Progress/Dot");
        this.cycleObj = vm.behaviour.transform:Find("root/Middle/bgmList/cycle")
        this.randomObj = vm.behaviour.transform:Find("root/Middle/bgmList/random")
        this.bgmListCountText = vm.behaviour.transform:Find("root/Middle/bgmList/Text"):GetComponent("Text")
        local dotBegin = vm.behaviour.transform:Find("root/Left/Progress/Begin");
        local dotEnd = vm.behaviour.transform:Find("root/Left/Progress/End");
        local p = dotEnd.localPosition - dotBegin.localPosition;
        this.progressDotDistance = p.magnitude;
        local dir = p.normalized;
        this.progressDotDir.x = dir.x;
        this.progressDotDir.y = dir.y;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end

        this.isPlayAni = true;
        this.InitBgms();
        this.SetBgms();
        this.SetBgmCD(this.nowId);
        LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAniPlayFinish);
        vm.data.aniName = "UIFoundationBgmPanel";
        PlayerPrefs.SetInt(DataMgr.Player.uid .. "FoundationBgm", 0);
        this.ChangePlayType()
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUpdate(this.OnUpdate);
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAniPlayFinish);
        this.musicList = nil;
        this.bgmList = nil;
        this.selectId = "";
        this.isPlay = false;
        this.playId = "";
        this.music = nil;
        this.goods = nil;
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})