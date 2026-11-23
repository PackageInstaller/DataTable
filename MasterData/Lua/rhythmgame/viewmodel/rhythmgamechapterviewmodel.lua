
require("RhythmGame/ViewModel/RhythmGameChapterPosItem")
require("RhythmGame/ViewModel/RhythmGameChapterMusicItem")
require("RhythmGame/ViewModel/RhythmGameChapterItem")
require("RhythmGame/ViewModel/RhythmGameChapterBigItem")

local this = {
    scrollWidth = 1280,
    scrollViewPos = nil,
    tabMapGroupList = { "Music01", "Music02", "Music03" },
    activityMapByAre = {}
};

local objs = {
    musicItem = { path = "template/MusicItem", type = "GameObject" },
    posItem = { path = "template/PosItem", type = "GameObject" },
    chapterItem = { path = "template/ChapterItem", type = "GameObject" },
    bigChapterItem = { path = "template/BigChapterItem", type = "GameObject" },
    aniRoot = { path = "root", type = "Animator" },
    tab1Box = { path = "root/Tab1Box", type = "GameObject" },
    scrollViewLeftGo = { path = "root/Tab1Box/ScrollViewLeft", type = "GameObject" },
    scrollViewLeftTF = { path = "root/Tab1Box/ScrollViewLeft", type = "RectTransform" },
    contentGLG = { path = "root/Tab1Box/ScrollViewLeft/Viewport/Content", type = "GridLayoutGroup" },
    scrollViewRightGo = { path = "root/Tab1Box/ScrollViewRight", type = "GameObject" },
    scrollViewRightTF = { path = "root/Tab1Box/ScrollViewRight", type = "RectTransform" },
    btnBefore = { path = "root/Tab1Box/ScrollViewLeft/btnBefore", type = "Button" },
    btnNext = { path = "root/Tab1Box/ScrollViewLeft/btnNext", type = "Button" },
    rawImage = { path = "root/Tab1Box/RawImage", type = "RawImage" },

    tab2Box = { path = "root/Tab2Box", type = "GameObject" },
    scrollViewCenterGo = { path = "root/Tab2Box/ScrollViewCenter", type = "GameObject" },
    scrollViewCenterTF = { path = "root/Tab2Box/ScrollViewCenter", type = "RectTransform" },

    tab3Box = { path = "root/Tab3Box", type = "GameObject" },
    scrollViewCenter2Go = { path = "root/Tab3Box/ScrollViewCenter2", type = "GameObject" },
    scrollViewCenter2TF = { path = "root/Tab3Box/ScrollViewCenter2", type = "RectTransform" },

    buttonLeft = { path = "root/FixedBox/ImageBottom/ButtonLeft", type = "Button" },
    imageLightLeft = { path = "root/FixedBox/ImageBottom/ButtonLeft/ImageLight", type = "GameObject" },
    imageLeft = { path = "root/FixedBox/ImageBottom/ButtonLeft/Image", type = "GameObject" },
    imageLeftMask = { path = "root/FixedBox/ImageBottom/ButtonLeft/ImageMask", type = "GameObject" },
    imageLeftRed = { path = "root/FixedBox/ImageBottom/ButtonLeft/Image/RedBox", type = "GameObject" },
    effectLeft = { path = "root/FixedBox/ImageBottom/ButtonLeft/eff_Button_unlock", type = "GameObject" },

    buttonMiddle = { path = "root/FixedBox/ImageBottom/ButtonMiddle", type = "Button" },
    imageLightMiddle = { path = "root/FixedBox/ImageBottom/ButtonMiddle/ImageLight", type = "GameObject" },
    imageMiddle = { path = "root/FixedBox/ImageBottom/ButtonMiddle/Image", type = "GameObject" },
    imageMiddleMask = { path = "root/FixedBox/ImageBottom/ButtonMiddle/ImageMask", type = "GameObject" },
    imageMiddleRed = { path = "root/FixedBox/ImageBottom/ButtonMiddle/Image/RedBox", type = "GameObject" },
    effectMiddle = { path = "root/FixedBox/ImageBottom/ButtonMiddle/eff_Button_unlock", type = "GameObject" },

    buttonRight = { path = "root/FixedBox/ImageBottom/ButtonRight", type = "Button" },
    imageLightRight = { path = "root/FixedBox/ImageBottom/ButtonRight/ImageLight", type = "GameObject" },
    imageRight = { path = "root/FixedBox/ImageBottom/ButtonRight/Image", type = "GameObject" },
    imageRightMask = { path = "root/FixedBox/ImageBottom/ButtonRight/ImageMask", type = "GameObject" },
    imageRightRed = { path = "root/FixedBox/ImageBottom/ButtonRight/Image/RedBox", type = "GameObject" },
    effectRight = { path = "root/FixedBox/ImageBottom/ButtonRight/eff_Button_unlock", type = "GameObject" },

    btnMask = { path = "root/FixedBox/btnMask", type = "Button" },
    btnMaskBg = { path = "root/FixedBox/btnMask/ImageBg", type = "GameObject" },
    btnCheckmark = { path = "root/FixedBox/btnMask/Background/Checkmark", type = "GameObject" },
    btnMaskSelect = { path = "root/FixedBox/btnMask/ImageSelect", type = "GameObject" },
};



this.SetData = function()
    this.UnLockTab();
    local curTab = PlayerRhythmGameMgr.GetChapterTab()
    if (curTab == nil) then
        PlayerRhythmGameMgr.SetChapterArea(1)
        this.SetTab(1);
    else
        local area = PlayerRhythmGameMgr.GetChapterArea()
        if (area == nil) then
            PlayerRhythmGameMgr.SetChapterArea(1)
        end
        this.SetTab(curTab);
    end
    local isMask = PlayerRhythmGameMgr.GetIsDiscMask()    
    PlayerRhythmGameMgr.SetIsDiscMask(isMask)
    SetActive(this.btnMaskBg, not isMask)
    SetActive(this.btnCheckmark, isMask)
    SetActive(this.btnMaskSelect, isMask)
end


this.ViewAdaptive = function()
    local addWidth = LuaMgr.GetScreenAddWidth();
    addWidth = addWidth > 0 and addWidth or 0;
    this.scrollWidth = 1280 + addWidth;
end

this.OnClickBtnMask = function()
    this.SetDiscMask()
end

this.SetDiscMask = function()
    local isMask = PlayerRhythmGameMgr.GetIsDiscMask()
    isMask = not isMask
    PlayerRhythmGameMgr.SetIsDiscMask(isMask)
    SetActive(this.btnMaskBg, not isMask)
    SetActive(this.btnCheckmark, isMask)
    SetActive(this.btnMaskSelect, isMask)
end



this.OnClickBtnLeft = function()
    this.SetTab(1);
end


this.OnClickBtnMiddle = function()
    this.SetTab(2);
end


this.OnClickBtnRight = function()
    this.SetTab(3);
end


this.SetTab = function(_tab)
    if (this.curTab == _tab) then return end
    if (DataMgr.Player.activityMaps[this.tabMapGroupList[_tab]] == nil) then
        if (_tab == 2 or _tab == 3) then
            local str = this.tabMapGroupList[_tab]
            local config = this.activityMapByAre[str]
            if (config ~= nil) then
                local unlockName = ConfigRhythmGameMgr.GetUnlockName(config.unlockParam)
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(ConfigMgr.LangGlobal("10754"), unlockName));
            end
        end
        return
    end
    SetActive(this.imageLightLeft, _tab == 1)
    SetActive(this.imageLightMiddle, _tab == 2)
    SetActive(this.imageLightRight, _tab == 3)
    SetActive(this.imageLeftRed, _tab ~= 1)
    SetActive(this.imageMiddleRed, _tab ~= 2)
    SetActive(this.imageRightRed, _tab ~= 3)
    this.curAreaList = DataExHelper.EX_GetGroupListByArea(this.tabMapGroupList[_tab])
    this.curAreaEventList = DataExHelper.EX_GetEventMapByArea(this.tabMapGroupList[_tab])
    this.curPlayerData = DataMgr.Player.activityMaps[this.tabMapGroupList[_tab]]
    for i = 1, 3 do
        SetActive(this["tab" .. i .. "Box"], i == _tab)
    end
    if (_tab == 1) then
        this.InitTab1Box()
    elseif (_tab == 2) then
        this.InitTab2Box()
    else
        this.InitTab3Box()
    end
    this.curTab = _tab
    PlayerRhythmGameMgr.SetChapterTab(_tab)
    PlayerRhythmGameMgr.CheckChapterNewDot()
    RedMgr.Singleton:Refresh()
end

this.UnLockTab = function()
    SetActive(this.imageLeft, false)
    SetActive(this.imageLeftMask, true)
    SetActive(this.imageLightLeft, false)
    SetActive(this.imageMiddle, false)
    SetActive(this.imageMiddleMask, true)
    SetActive(this.imageLightMiddle, false)
    SetActive(this.imageRight, false)
    SetActive(this.imageRightMask, true)
    SetActive(this.imageLightRight, false)
    SetActive(this.effectLeft, false)
    SetActive(this.effectMiddle, false)
    SetActive(this.effectRight, false)

    for k, v in pairs(this.tabMapGroupList) do
        if (DataMgr.Player.activityMaps[v] ~= nil) then
            if (k == 1) then
                if (this.UnLockTapEffetc(this.imageLeft, this.imageLeftMask, this.effectLeft, k)) then
                    SetActive(this.imageLeft, true)
                    SetActive(this.imageLeftMask, false)
                end
            elseif (k == 2) then




            else
                if (this.UnLockTapEffetc(this.imageRight, this.imageRightMask, this.effectRight, k)) then
                    SetActive(this.imageRight, true)
                    SetActive(this.imageRightMask, false)
                end
            end
        end
    end

end

this.UnLockTapEffetc = function(lightObj, maskObj, effectObj, key)
    local str = this.tabMapGroupList[key]
    local config = this.activityMapByAre[str]
    if (config ~= nil) then
        if (this.startDelayMap == nil) then
            this.startDelayMap = {}
        end
       
        if (PlayerRhythmGameMgr.CheckChapterShownById(config.unlockParam)) then
            if this.startDelayMap[key] ~= nil then
                coroutine_runner.stop(this.startDelayMap[key])
            end
            this.startDelayMap[key] = coroutine_runner.start(function()
                SetActive(lightObj, false)
                SetActive(maskObj, true)
                coroutine_runner.wait(0.9)
                SetActive(effectObj, true)
                coroutine_runner.wait(0.6)
                SetActive(lightObj, true)
                SetActive(maskObj, false)
                coroutine_runner.wait(0.4)
                SetActive(effectObj, false)
            end)
            return false
        end
    end
    return true
end


this.InitTab1Box = function()
    local curTab = PlayerRhythmGameMgr.GetChapterArea()
    this.btnBefore.interactable = curTab ~= 1
    this.btnNext.interactable = curTab ~= #this.curAreaList
    local config = this.curAreaList[curTab]
    local itemTexture = LuaMgr.GetTexture(string.format("Assets/_BundleResources/Images/RhythmGame/%s.png",
        config.statusIcon))
    if (itemTexture ~= nil) then
        this.rawImage.texture = itemTexture
    else
        LuaDebug.error(json.encode(config))
        LuaDebug.error(config.statusIcon)

    end
    this.SetScrollViewLeft()
    this.SetScrollViewRight()
    this.aniRoot:Rebind();
    this.aniRoot:Play("ani_ui_RhythmGameChapterPanel_root_Tab1Box");
end

this.SetScrollViewLeft = function()
    this.scrollViewLeft:Clear(false);
    local scrollDatasLeft = {}

    for i = 1, #this.curAreaList do
        local data = {}
        data.index = i
        data.config = this.curAreaList[i]
        data.isLock = this.curPlayerData.mapGroups[data.config.id] == nil
        local scrollData = UIScrollData.GetData(this.posItem, "RhythmGameChapterPosItem", 84, 59, data);
        table.insert(scrollDatasLeft, scrollData);
    end
    this.scrollViewLeft:SetParams(479, 59);

    this.scrollViewLeft:SetData(scrollDatasLeft, true);

end

this.SetScrollViewRight = function()
    this.scrollViewRight:Clear(false);
    local tab = PlayerRhythmGameMgr.GetChapterArea()
    local list = this.curAreaEventList[this.curAreaList[tab].id]
    local scrollDatas = {}
    local moveIndex = 1
    for i = 1, #list do
        local data = {}
        data.config = list[i]
        data.playerData = this.curPlayerData.activityEvents[data.config.id]
        if (data.playerData ~= nil and moveIndex < i) then
            moveIndex = i - 1
        end
        local scrollData = UIScrollData.GetData(this.musicItem, "RhythmGameChapterMusicItem", 441, 115, data);
        table.insert(scrollDatas, scrollData);
    end
    this.scrollViewRight:SetParams(473, 525);

    this.scrollViewRight:SetData(scrollDatas, true);

    this.scrollViewRight:MoveToIndex(moveIndex);
end


this.OnClickBtnBefore = function()
    local curTab = PlayerRhythmGameMgr.GetChapterArea()
    curTab = curTab - 1
    if (curTab <= 0) then
        return
    end
    PlayerRhythmGameMgr.SetChapterArea(curTab)
    this.InitTab1Box()
end

this.OnClickBtnNext = function()
    local totalNum = #this.curAreaList
    local curTab = PlayerRhythmGameMgr.GetChapterArea()
    curTab = curTab + 1
    if (curTab > totalNum) then
        return
    end
    local config = this.curAreaList[curTab]
    if (this.curPlayerData.mapGroups[config.id] == nil) then
        local unlockName = ConfigRhythmGameMgr.GetUnlockName(config.unlockParam)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, string.format(ConfigMgr.LangGlobal("10754"), unlockName));
        return
    end
    PlayerRhythmGameMgr.SetChapterArea(curTab)
    this.InitTab1Box()
end




this.InitTab2Box = function()
    this.scrollViewCenter:Clear(false);

    local list = this.curAreaEventList[this.curAreaList[1].id]
    local scrollDatas = {}
    local moveIndex = 1
    for i = 1, #list do
        local data = {}
        data.index = i
        data.isLast = i == #list
        data.config = list[i]
        data.playerData = this.curPlayerData.activityEvents[data.config.id]
        if (data.playerData ~= nil and moveIndex < i) then
            moveIndex = i - 1
        end
        local scrollData = UIScrollData.GetData(this.chapterItem, "RhythmGameChapterItem", 320, 489, data);
        table.insert(scrollDatas, scrollData);
    end
    this.scrollViewCenter:SetParams(this.scrollWidth, 489);

    this.scrollViewCenter:SetData(scrollDatas, true);

    this.scrollViewCenter:MoveToIndex(moveIndex);
    this.aniRoot:Rebind();
    this.aniRoot:Play("ani_ui_RhythmGameChapterPanel_root_Tab2Box");
end




this.InitTab3Box = function()
    this.scrollViewCenter2:Clear(false);

    local list = this.curAreaEventList[this.curAreaList[1].id]
    local scrollDatas = {}
    for i = 1, #list do
        local data = {}
        data.index = i
        data.config = list[i]
        data.playerData = this.curPlayerData.activityEvents[data.config.id]
        local scrollData = UIScrollData.GetData(this.bigChapterItem, "RhythmGameChapterBigItem", 540, 430, data);
        table.insert(scrollDatas, scrollData);
    end
    this.scrollViewCenter2:SetParams(940, 500);

    this.scrollViewCenter2:SetData(scrollDatas, true);

    this.aniRoot:Rebind();
    this.aniRoot:Play("ani_ui_RhythmGameChapterPanel_root_Tab3Box");
end





local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.btnBefore, this.OnClickBtnBefore)
        LuaMgr.AddClick(this.btnNext, this.OnClickBtnNext)
        LuaMgr.AddClick(this.buttonLeft, this.OnClickBtnLeft);

        LuaMgr.AddClick(this.buttonRight, this.OnClickBtnRight);
        LuaMgr.AddClick(this.btnMask, this.OnClickBtnMask)
        this.scrollViewLeft = UIScrollView.New(this.scrollViewLeftGo);
        this.scrollViewRight = UIScrollView.New(this.scrollViewRightGo);
        this.scrollViewCenter = UIScrollView.New(this.scrollViewCenterGo);
        this.scrollViewCenter2 = UIScrollView.New(this.scrollViewCenter2Go);
        RedMgr.Singleton:RegisterViewModel(UIName.RhythmGameChapterViewModel);
        LuaMgr.AddUIEventListener(UIEventConst.RhythmGameChapterArea, this.InitTab1Box);
        this.scrollViewPos = this.scrollViewRightTF.anchoredPosition;
        local actMap = ConfigMgr.Config.activityMapList
        for i, v in ipairs(actMap) do
            for key, value in pairs(this.tabMapGroupList) do
                if v.area == value then
                    this.activityMapByAre[value] = v
                    break
                end
            end
        end
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.curTab = nil
        this.ViewAdaptive();
        this.SetData();
    end,
    before_deactive = function(vm)
        this.scrollViewLeft:Clear(true);
        this.scrollViewRight:Clear(true);
        this.scrollViewCenter:Clear(true);
        this.scrollViewCenter2:Clear(true);
        if (this.startDelayMap ~= nil) then
            for k, v in pairs(this.startDelayMap) do
                if (not coroutine_runner.checkIsDestory()) then
                    coroutine_runner.stop(v);
                end
            end
            this.startDelayMap = nil
        end
        this.type = 0;
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.btnBefore, this.OnClickBtnBefore)
        LuaMgr.RemoveClick(this.btnNext, this.OnClickBtnNext)
        LuaMgr.RemoveClick(this.buttonLeft, this.OnClickBtnLeft);
        LuaMgr.RemoveClick(this.buttonMiddle, this.OnClickBtnMiddle);
        LuaMgr.RemoveClick(this.buttonRight, this.OnClickBtnRight);
        LuaMgr.RemoveClick(this.btnMask, this.OnClickBtnMask)
        UIScrollView.ClearItem("RhythmGameChapterPosItem");
        UIScrollView.ClearItem("RhythmGameChapterMusicItem");
        UIScrollView.ClearItem("RhythmGameChapterItem");
        UIScrollView.ClearItem("RhythmGameChapterBigItem");
        RedMgr.Singleton:RemoveViewModel(UIName.RhythmGameChapterViewModel);
        LuaMgr.RemoveUIEventListener(UIEventConst.RhythmGameChapterArea, this.InitTab1Box);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})