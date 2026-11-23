require("ViewModel/HMWY/HMWYConst")
require("ViewModel/HMWY/HMWYEmployeeItem")

local this =
{
    tapIndex = nil,
    tabBoxTab = {},
    searchItemDataList = {},
    searchItemCacheTab = {},
    selectedSearchItem = nil,
    rewardItems = {},
    clickTime = 0,
    startDelay = nil,
    startDelay2 = nil,
    medalActivityID = "30201",
    bShownBtnBox = true,
    filterJob = 0,
};

local objs = {
    searchItemObj = { path = "template/SearchItem", type = "GameObject" },
    rewardItemObj = { path = "template/RewardItem", type = "GameObject" },
    employeeItem = { path = "template/EmployeeItem", type = "GameObject" },
    root = { path = "root", type = "RectTransform" },
    searchItemsBox = { path = "root/SearchItemsBox", type = "RectTransform" },
    tipPaneCloseBtn = { path = "root/Middle/TipPaneCloseBtn", type = "Button" },
    dayText = { path = "root/Bg/Image/TextTime", type = "Text" },
    searchBtn = { path = "root/Middle/Left/SearchBtn", type = "Button" },
    icon1 = { path = "root/Middle/Left/SearchBtn/icon1", type = "GameObject" },
    icon2 = { path = "root/Middle/Left/SearchBtn/icon2", type = "GameObject" },
    gradBtn = { path = "root/Middle/Left/Image/GradBtn", type = "Button" },
    bottomBox = { path = "root/Middle/Left/BtnBox", type = "GameObject" },
    bottomBoxAnim = { path = "root/Middle/Left/BtnBox", type = "Animator" },
    textRatio = { path = "root/Middle/Left/Image/TextRatio", type = "Text" },
    imgRatio = { path = "root/Middle/Left/Image/ImgRatio", type = "Image" },
    signBtn = { path = "root/Middle/Right/SignBtn", type = "Button" },
    textWM = { path = "root/Middle/Right/SignBtn/Image/TextWM", type = "Text" },
    shopBtn = { path = "root/Middle/Right/ShopBtn", type = "Button" },
    talentBtn = { path = "root/Middle/Right/TalentBtn", type = "Button" },

    middle = { path = "root/Middle", type = "Transform" },
    tipPanelSmall = { path = "root/Middle/tipPanelSmall", type = "RectTransform" },
    tipPanelSmallTitle = { path = "root/Middle/tipPanelSmall/ImgType2/TextTitle", type = "Text" },
    tipPanelSmallTitleType1 = { path = "root/Middle/tipPanelSmall/ImgType1", type = "Image" },
    tipPanelSmallTitleType2 = { path = "root/Middle/tipPanelSmall/ImgType2", type = "Image" },
    tipPanelSmallRewardObj = { path = "root/Middle/tipPanelSmall/reward/tranLevelList/Viewport/Content/rectContent", type = "Transform" },
    smallBattleBtn = { path = "root/Middle/tipPanelSmall/BtnBattle", type = "Button" },
    gradPanel = { path = "root/Middle/gradPanel", type = "RectTransform" },
    textNum1 = { path = "root/Middle/gradPanel/box/Item1/TextNum", type = "Text" },
    textNum2 = { path = "root/Middle/gradPanel/box/Item2/TextNum", type = "Text" },
    textNum3 = { path = "root/Middle/gradPanel/box/Item3/TextNum", type = "Text" },
    textNum4 = { path = "root/Middle/gradPanel/box/Item4/TextNum", type = "Text" },
    textNum5 = { path = "root/Middle/gradPanel/box/Item5/TextNum", type = "Text" },
    employeeListCanvas = { path = "root/Middle/EmployeeList", type = "Canvas" },
    employeeList = { path = "root/Middle/EmployeeList/ScrollView", type = "GameObject" },
    filterBtn = { path = "root/Middle/EmployeeList/FilterBtn", type = "Button" },
};

this.tapBtnInit = function()
    for i = 0, this.bottomBox.transform.childCount - 1 do
        local child = this.bottomBox.transform:GetChild(i)
        local cache = {}
        cache.btn = child:GetComponent("Button")
        cache.btnFunc = function()
            local bPlay = HMWYMgr.GetPlayerAnimation()
            if (bPlay) then
                return
            end
            this.OnClickTap(i + 1)
        end
        table.insert(this.tabBoxTab, cache)
        LuaMgr.AddClick(cache.btn, cache.btnFunc)
    end
end

this.OnClickTap = function(index)
    this.tapIndex = index
    HMWYMgr.SetCurTap(this.tapIndex)
    this.bottomBoxAnim:Rebind()
    this.bottomBoxAnim.enabled = not (this.tapIndex ~= nil)
    this.SetData()
end

this.OnClickSearch = function()
    this.bShownBtnBox = not this.bShownBtnBox
    if (not this.bShownBtnBox) then
        this.OnClickTap(nil)
    end
    SetActive(this.icon1, not this.bShownBtnBox)
    SetActive(this.icon2, this.bShownBtnBox)

    this.bottomBoxAnim:Rebind()
    this.bottomBoxAnim.enabled = not this.bShownBtnBox
end


this.OnClickSign = function()
    if this.CheckActivityRunning() then
        local data = {}
        data.medalActivityID = this.medalActivityID
        data.medalColor = "#3d6053"
        data.medalImgKey = "ui_hd_ty_dtyl_bt_hmwy"
        data.bgmPath = "Assets/_BundleResources/Audio/Bgm/HMWY.mp3"
        LuaMgr.ShowLuaPanel(UIName.PassesMain2ViewModel, data);
    end
end


this.OnClickShop = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.HMWYShopViewModel);
    end
end


this.OnClickTalent = function()
    if this.CheckActivityRunning() then
        LuaMgr.ShowLuaPanel(UIName.HMWYTalentViewModel);
    end
end


this.OnClickTipPaneClose = function()
    SetActive(this.tipPanelSmall.gameObject, false)
    SetActive(this.gradPanel.gameObject, false)
    SetActive(this.tipPaneCloseBtn.gameObject, false)
    if (this.selectedSearchItem ~= nil) then
        HMWYMgr.SetSelectedType(nil)
        this.selectedSearchItem = nil
    end
end


this.OnClickFilter = function()
    LuaMgr.ShowLuaPanel(UIName.HMWYFilterShortViewModel, function(job)
        this.filterJob = job
        this.RefefreshEmployeeList()
    end, this.filterJob);
end


this.OnBack = function()
    HMWYMgr.SetSelectedType(nil)
    HMWYMgr.SetCurTap(nil)
    LuaMgr.Back()
end

this.RefefreshEmployeeList = function(isRest)
local allDatas = HMWYDispatchMgr.GetDispatchHeroDataList({});
    this.allEmployeeDatas = allDatas
    this.employeeListUI:Clear()
    local scrollDatas = {}
    local itemWidth = 120
    for k, v in pairs(allDatas) do
        v.OnClickCallback = this.OnClickEmployeeItem
        local heroConfig = ConfigMgr.Config.characterTable[v.id]
        local scrollData = UIScrollData.GetData(this.employeeItem, "HMWYEmployeeItem", itemWidth, 100, v)
        if (this.filterJob ~= 0) then
            if (heroConfig.job == this.filterJob) then
                table.insert(scrollDatas, scrollData)
            end
        else
            table.insert(scrollDatas, scrollData)
        end
    end
    this.employeeListUI:SetParams(732, 100)
    if (isRest == nil) then
        this.employeeListUI:SetData(scrollDatas, true)
    else
        this.employeeListUI:SetData(scrollDatas, isRest)
    end
end

this.OnClickEmployeeItem = function(item)
    if LuaMgr.IsPanelOpen(UIName.HMWYDispatchHeroInfoViewModel) then
        LuaMgr.InvokeUIEventListeners(UIEventConst.HMWYDispatchId, item.data.id);
        return
    end
    this.employeeListCanvas.sortingOrder = 500
    LuaMgr.ShowLuaPanel(UIName.HMWYDispatchHeroInfoViewModel, item.data.id, function(type)
        if (type == 1) then
            this.RefefreshEmployeeList(false)
        end
        this.employeeListCanvas.sortingOrder = 1
    end);
end


this.SetData = function()

    local lv = DataMgr.Player.HMWYGame.Level .. ""
    this.textRatio.text = LuaMgr.GetLangText("HMWYMainViewModel_0") .. lv
    local config = ConfigMgr.Config.HmwyProsperityLvMap[lv]
    this.imgRatio.fillAmount = DataMgr.Player.HMWYGame.Exp / config.Exp
    if this.tapIndex == nil then
        this.RefreshList()
    else
        local cacheList = {}
        for i, v in ipairs(ConfigMgr.Config.activityMapEventList) do
            if HMWYLevelStrType[v.area] == HMWYLevelNumType[this.tapIndex] then
                if (v.type == 3) then
                    local config = ConfigMgr.Config.HmwyDispatchEventCheckMap[v.eventParam];
                    if (config and config.EventType == 2) then
                        table.insert(cacheList, v)
                    end
                else
                    table.insert(cacheList, v)
                end




            end
        end
        this.SetSearchItemData(cacheList, 2)
        this.SetSearchItem()
    end
end

this.RefreshList = function()
    local randomData = HMWYMgr.GetCombineData();
    this.SetSearchItemData(randomData, 1)
    this.SetSearchItem()
end

this.SetSearchItemData = function(_configList, _posType)
    this.searchItemDataList = {}
    if (_configList ~= nil and #_configList > 0) then
        for i, v in ipairs(_configList) do
            local cache = {}
            cache.id = v.id
            cache.icon = v.type;
            cache.isfinish = true
            cache.name = LuaMgr.GetLangText(v.namelan);
            local list = NumTool.split(v.classId, ";");
            local posList = nil
            if (_posType == 1) then
                if list and #list >= 2 then
                    posList = NumTool.split(list[2], ",");
                end
            else
                if list and #list >= 3 then
                    posList = NumTool.split(list[3], ",");
                end
                if (v.type == 3) then
                    cache.isfinish = HMWYMgr.CheckEggEventId(v.id)
                else
                    cache.isfinish = HMWYMgr.CheckEventIsComplete(v)
                end
            end
            if (posList ~= nil and #posList >= 2) then
                cache.pos = { posList[1], posList[2] }
            end
            cache.config = v
            table.insert(this.searchItemDataList, cache)
        end
    end
end

this.SetSearchItem = function()
    if (#this.searchItemDataList > 0) then
        for i, v in ipairs(this.searchItemDataList) do
            if (this.searchItemCacheTab[i] == nil or this.searchItemCacheTab[i].Obj == nil) then
                this.searchItemCacheTab[i] = {}
                local go = LuaMgr.InstantiateGO(this.searchItemObj, this.searchItemsBox, false)
                local cache = {}
                cache.go = go
                cache.btn = go.transform:GetComponent("Button")
                cache.icon = go.transform:Find("icon"):GetComponent("Image");
                cache.effect = go.transform:Find("effect");
                cache.imageBg = go.transform:Find("ImageBg"):GetComponent("Image");
                cache.textName = go.transform:Find("ImageBg/TextName"):GetComponent("Text");
                cache.imageRed = go.transform:Find("ImageBg/ImageRed");
                this.searchItemCacheTab[i].Obj = cache
            end
            local obj = this.searchItemCacheTab[i].Obj
            obj.go.transform.localPosition = Vector3(tonumber(v.pos[1]), tonumber(v.pos[2]), 0)
            local bPlay = HMWYMgr.GetPlayerAnimation()
            SetActive(obj.go, not bPlay)
            local isTypeOnly = this.tapIndex ~= nil
            SetActive(obj.effect.gameObject, not isTypeOnly)
            for i = 0, 4 do
                local item = obj.effect:GetChild(i)
                SetActive(item.gameObject, v.icon == i + 1)
            end
            local finishShowNum = v.isfinish and this.CheckShowPlayIcon(v) or "wjs"
            obj.icon.sprite = LuaMgr.GetSprite("HMWY", "ui_hd_hmwy_zjm_jq02_" .. finishShowNum);
            finishShowNum = not isTypeOnly and ("0" .. v.icon) or "re"
            obj.imageBg.sprite = LuaMgr.GetSprite("HMWY", "ui_hd_hmwy_zjm_zjbt_" .. finishShowNum);
            obj.textName.text = v.name;
            SetActive(obj.imageRed.gameObject, v.config.type == 1 and not isTypeOnly)
            local onclick = function()
                if (not v.isfinish) then
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,
                        LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_7108"));
                    return;
                end
                if (v.config.type == 3) then
                    if (isTypeOnly) then
                        local result = {}
                        result.eggId = v.id
                        result.showEggOnly = true
                        LuaMgr.ShowLuaPanel(UIName.HMWYDispatchRibbonViewModel, result);
                    else
                        HMWYDispatchMgr.ShowEventPopup(v.config.eventParam, function()
                            this.SetData()
                            this.RefefreshEmployeeList()
                        end)
                    end
                    return
                end
                this.selectedSearchItem = obj
                this.selectedSearchItem.config = v.config
                HMWYMgr.SetSelectedType(v.config.area)
                this.ShowTipPanelSmall(obj, v)
            end
            obj.btn.onClick:RemoveAllListeners()
            LuaMgr.AddClick(obj.btn, onclick)
        end
    end
    local num1 = #this.searchItemCacheTab
    local num2 = #this.searchItemDataList
    if (num2 < num1) then
        for i = num2 + 1, num1 do
            if this.searchItemCacheTab[i] and this.searchItemCacheTab[i].Obj then
                SetActive(this.searchItemCacheTab[i].Obj.go, false)
            end
        end
    end
    this.PlaySearchItem()
end

this.PlaySearchItem = function()
    local bPlay = HMWYMgr.GetPlayerAnimation()
    if (bPlay) then
        if this.startDelay2 ~= nil then
            coroutine_runner.stop(this.startDelay2)
        end
        this.startDelay2 = coroutine_runner.start(function()
            for i, v in ipairs(this.searchItemDataList) do
                coroutine_runner.wait(0.1)
                local obj = this.searchItemCacheTab[i].Obj
                SetActive(obj.go, true)
            end
            HMWYMgr.SetPlayerAnimation(false)
        end)
    end
end

this.ShowTipPanelSmall = function(_obj, _config)
    SetActive(this.tipPanelSmall.gameObject, true)
    SetActive(this.tipPaneCloseBtn.gameObject, true)
    local str = this.CheckShowPlayIcon(_config)
    this.tipPanelSmallTitleType1.sprite = LuaMgr.GetSprite("HMWY", "ui_hd_hmwy_zjm_jq02_" .. str);
    this.tipPanelSmallTitleType2.sprite = LuaMgr.GetSprite("HMWY", "ui_hd_hmwy_zjm_zjbt_0" .. _config.icon);
    this.tipPanelSmallTitle.text = LuaMgr.GetLangText(_config.config.namelan)
    this.SetRewardItems(_config.config, this.tipPanelSmallRewardObj)
end

this.CheckShowPlayIcon = function(_config)
    local str = "0" .. _config.icon
    if (_config.icon == 3) then
        local state = HMWYMgr.CheckGameState(_config.id)
        if (state == 2) then
            str = "0" .. _config.icon .. "_2"
        elseif (state == 1) then
            str = "0" .. _config.icon .. "_1"
        else
            str = "0" .. _config.icon
        end
    end
    return str
end

this.OnClickSmallBattleBtn = function()
    if (this.selectedSearchItem == nil) then
        return
    end
    local config = this.selectedSearchItem.config
    local area = config.area
    if (area == HMWYLevelType.Repeat or area == HMWYLevelType.Main or area == HMWYLevelType.Difficult) then
        local hmwyBuffs = HMWYMgr.GetUnlockTalentBuffList()
        local buffIDStr = nil
        if hmwyBuffs ~= nil then
            buffIDStr = table.concat(hmwyBuffs, ";")
        end
        local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
        enterDungeonParams.eventId = config.id
        enterDungeonParams.dungeonId = config.eventParam
        if buffIDStr ~= nil and #buffIDStr > 0 then
            enterDungeonParams.extraParams = { "hmwyBuffs", buffIDStr }
        end
        BattlePrepareMgr.BattlePrepare(enterDungeonParams)
    elseif (area == HMWYLevelType.Play) then
        HMWYDispatchMgr.ShowEventPopup(config.eventParam, function()
            this.SetData()
            this.RefefreshEmployeeList()
        end)
    elseif (area == HMWYLevelType.Story) then
        LuaMgr.PlayNovel(config.eventParam, function()
            if (this.tapIndex == nil) then
                LuaMgr.ShowLuaPanel(UIName.HMWYMainViewModel);
            else
                LuaMgr.ShowLuaPanel(UIName.HMWYMainViewModel, this.tapIndex);
            end
        end);
    end
end

this.OnClickGradBtn = function()
    SetActive(this.gradPanel.gameObject, true)
    SetActive(this.tipPaneCloseBtn.gameObject, true)
    for i = 0, 4 do
        local num = DataMgr.Player.HMWYGame.Grade[i .. ""]
        if (num == nil) then
            num = 0
        end
        this["textNum" .. (i + 1)].text = num
    end
end

this.SetRewardItems = function(_config, _container)
    local area = _config.area
    local rewardConfigList = {}
    local itemDataLis = {}
    local isFirst = false
    local isFinish = false
    if (area == HMWYLevelType.Repeat or area == HMWYLevelType.Main or area == HMWYLevelType.Difficult) then
        local dropShow = nil
        local record = DataMgr.Player.dungeonRecords[_config.eventParam];
        local dungeonConfig = ConfigMgr.Config.dungeonMap[_config.eventParam]
        if (record == nil or record.completeCount == 0) then
            isFirst = true
            dropShow = dungeonConfig.firstDropShow;
        elseif (record.completeCount ~= 0 and area ~= HMWYLevelType.Repeat) then
            isFinish = true
            dropShow = dungeonConfig.firstDropShow;
        else
            dropShow = dungeonConfig.fixedDropShow;
        end
        itemDataLis = NumTool.split(dropShow, ';')
    elseif (area == HMWYLevelType.Story) then
        local narrativeConfig = ConfigMgr.Config.narrativeMap[_config.eventParam];
        itemDataLis = NumTool.split(narrativeConfig.fixedDropShow, ';')
        isFinish = DataHelper.CheckNovelComplete(_config.id);
    end
    for i = 1, #itemDataLis do
        local itemData = table.Copy(ConfigMgr.Config.itemMap[itemDataLis[i]]);
        table.insert(rewardConfigList, itemData)
    end
    if (this.rewardItems ~= nil) then
        for k, v in pairs(this.rewardItems) do
            v.rewardObj:Hide();
            SetActive(v.go, false)
        end
    end
    if (#rewardConfigList > 0) then
        for i, v in ipairs(rewardConfigList) do
            if (this.rewardItems == nil) then
                this.rewardItems = {}
            end
            if (this.rewardItems[i] == nil) then
                local go = GameObject.Instantiate(this.rewardItemObj)
                local cache = {}
                cache.go = go
                cache.box = go.transform:Find("reward"):GetComponent("Transform");
                cache.get = go.transform:Find("get").gameObject;
                cache.first = go.transform:Find("first").gameObject;
                cache.rewardObj = GoodsDataItem.New(cache.box);
                this.rewardItems[i] = cache
            end
            local obj = this.rewardItems[i]
            obj.go.transform:SetParent(_container, false);
            obj.rewardObj:SetData(1, v, 1, false, Vector3(0.6, 0.6, 0.6), false, true);

            SetActive(obj.get, isFinish)
            SetActive(obj.first, isFirst)
            SetActive(obj.go, true)
        end
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.tapBtnInit()
        LuaMgr.AddClick(this.searchBtn, this.OnClickSearch);
        LuaMgr.AddClick(this.shopBtn, this.OnClickShop);
        LuaMgr.AddClick(this.talentBtn, this.OnClickTalent);
        LuaMgr.AddClick(this.filterBtn, this.OnClickFilter);
        LuaMgr.AddClick(this.signBtn, this.OnClickSign);
        LuaMgr.AddClick(this.tipPaneCloseBtn, this.OnClickTipPaneClose);
        LuaMgr.AddClick(this.smallBattleBtn, this.OnClickSmallBattleBtn);
        LuaMgr.AddClick(this.gradBtn, this.OnClickGradBtn);
        RedMgr.Singleton:RegisterViewModel(UIName.HMWYMainViewModel);
        this.employeeListUI = UIScrollView.New(this.employeeList)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        HMWYMgr.SetPlayerAnimation(true)
        this.filterJob = 0
        if vm.behaviour.Params.Length > 0 then
            this.tapIndex = HMWYMgr.GetCurTap()
            if (this.tapIndex == nil) then
                this.tapIndex = vm.behaviour.Params[0]
            end
            this.OnClickTap(this.tapIndex)
        else
            this.tapIndex = nil
            this.SetData();
        end
        this.bShownBtnBox = true
        SetActive(this.icon1, not this.bShownBtnBox)
        SetActive(this.icon2, this.bShownBtnBox)

        this.bottomBoxAnim:Rebind()
        this.bottomBoxAnim.enabled = false
        this.dayText.text = HMWYMgr.GetTimeStr()
        local finishMedalCount1 = DataExHelper.GetMedalFinishCount(this.medalActivityID)
        local medalList1 = DataExHelper.GetMedalList(this.medalActivityID)
        this.medalList = {}
        for key, value in pairs(medalList1) do
            table.insert(this.medalList, value)
        end
        this.textWM.text = string.format(LuaMgr.GetLangText("CrisisContract2MainViewModel_0"), finishMedalCount1,
            #this.medalList)
        this.RefefreshEmployeeList()
        if (RedMgr.Singleton:CheckRedCondition("17821")) then
            RedMgr.Singleton:FrushRedCondition("17821")
        end
        HeroRedDataHelper.SetHMWYRed()
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack);
    end,
    before_deactive = function(vm)
        this.OnClickTipPaneClose()
        if this.startDelay ~= nil then
            coroutine_runner.stop(this.startDelay)
        end
        if this.startDelay2 ~= nil then
            coroutine_runner.stop(this.startDelay2)
        end
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.searchBtn, this.OnClickSearch);
        LuaMgr.RemoveClick(this.shopBtn, this.OnClickShop);
        LuaMgr.RemoveClick(this.talentBtn, this.OnClickTalent);
        LuaMgr.RemoveClick(this.filterBtn, this.OnClickFilter);
        LuaMgr.RemoveClick(this.signBtn, this.OnClickSign);
        LuaMgr.RemoveClick(this.tipPaneCloseBtn, this.OnClickTipPaneClose);
        LuaMgr.RemoveClick(this.smallBattleBtn, this.OnClickSmallBattleBtn);
        LuaMgr.RemoveClick(this.gradBtn, this.OnClickGradBtn);
        if (this.tabBoxTab ~= nil and #this.tabBoxTab > 0) then
            for i = 1, #this.tabBoxTab do
                LuaMgr.RemoveClick(this.tabBoxTab[i].btn, this.tabBoxTab[i].btnFunc)
            end
        end
        RedMgr.Singleton:RemoveViewModel(UIName.HMWYMainViewModel);
        if (this.spineGO ~= nil) then
            LuaMgr.Destroy(this.spineGO);
            this.spineGO = nil;
        end
        UIScrollView.ClearItem("HMWYEmployeeItem")
    end
}


this.CheckActivityRunning = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.HMWY) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        return false;
    end
    return true;
end

return vm({
    data = data,
    command = command,
    hook = hook
})