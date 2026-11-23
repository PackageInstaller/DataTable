require("Waterlily/WaterlilyConst")

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
    curAreaEventList = nil
};

local objs = {
    searchItemObj = { path = "template/SearchItem", type = "GameObject" },
    rewardItemObj = { path = "template/RewardItem", type = "GameObject" },
    root = { path = "root", type = "RectTransform" },
    bgRt = { path = "root/Bg", type = "RectTransform" },
    searchItemsBox = { path = "root/SearchItemsBox", type = "RectTransform" },
    tipPaneCloseBtn = { path = "root/Middle/TipPaneCloseBtn", type = "Button" },    
    bottomBox = { path = "root/Middle/BottomBox", type = "GameObject" },   
    middle = { path = "root/Middle", type = "Transform" },
    tipPanelBig = { path = "root/Middle/tipPanelBig", type = "RectTransform" },
    tipPanelBigTitle = { path = "root/Middle/tipPanelBig/Image/TextTitle", type = "Text" },
    tipPanelBigContent = { path = "root/Middle/tipPanelBig/TextContent", type = "Text" },
    tipPanelBigRewardObj = { path = "root/Middle/tipPanelBig/reward/tranLevelList/Viewport/Content/rectContent", type = "Transform" },
    bigBattleBtn = { path = "root/Middle/tipPanelBig/BtnBattle", type = "Button" },

    itemSelectedObj = { path = "root/Middle/SearchItemSelected", type = "GameObject" },
    itemSelIcon = { path = "root/Middle/SearchItemSelected/icon", type = "Transform" },
    itemSelTextName = { path = "root/Middle/SearchItemSelected/Image/TextName", type = "Text" },
    itemSelTextPos = { path = "root/Middle/SearchItemSelected/TextPos", type = "Text" },

    tipPanelSmall = { path = "root/Middle/tipPanelSmall", type = "RectTransform" },
    tipPanelSmallTitle = { path = "root/Middle/tipPanelSmall/Image/TextTitle", type = "Text" },
    tipPanelSmallTitleType1 = { path = "root/Middle/tipPanelSmall/Image/ImgType1", type = "GameObject" },
    tipPanelSmallTitleType2 = { path = "root/Middle/tipPanelSmall/Image/ImgType2", type = "GameObject" },
    tipPanelSmallRewardObj = { path = "root/Middle/tipPanelSmall/reward/tranLevelList/Viewport/Content/rectContent", type = "Transform" },
    smallBattleBtn = { path = "root/Middle/tipPanelSmall/BtnBattle", type = "Button" },    
};


this.tapBtnInit = function()
    for i = 0, this.bottomBox.transform.childCount - 1 do
        local child = this.bottomBox.transform:GetChild(i)
        local cache = {}
        cache.btn = child:GetComponent("Button")
        cache.selected = child.transform:Find("Selected").gameObject
        cache.btnFunc = function()
            local bPlay = PlayerWaterlilyMgr.GetPlayerAnimation()
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
    this.tapIndex = tonumber(index)
    PlayerWaterlilyMgr.SetCurTap(this.tapIndex)
    for i = 1, #this.tabBoxTab do
        SetActive(this.tabBoxTab[i].selected, false)
    end
    if this.tapIndex and this.tapIndex <= #this.tabBoxTab then
        SetActive(this.tabBoxTab[this.tapIndex].selected, true)
    end
    this.SetData()
end



this.OnClickTipPaneClose = function()
    SetActive(this.tipPanelBig.gameObject, false)
    SetActive(this.tipPanelSmall.gameObject, false)
    SetActive(this.tipPaneCloseBtn.gameObject, false)
    if (this.selectedSearchItem ~= nil) then
        this.selectedSearchItem.btn.enabled = true
        this.selectedSearchItem.go.transform:SetParent(this.searchItemsBox, false)
        SetActive(this.selectedSearchItem.go, true)
        SetActive(this.itemSelectedObj, false)
        this.selectedSearchItem = nil
        PlayerWaterlilyMgr.SetSelectedType(nil)
    end
end



this.OnBack = function()
    PlayerWaterlilyMgr.SetSelectedType(nil)
    PlayerWaterlilyMgr.SetCurTap(nil)
    LuaMgr.Back()
end



this.SetData = function()
    SetActive(this.bottomBox, this.tapIndex ~= nil)   
    if this.tapIndex == nil then
        this.RefreshList()
    else
        local cacheList = {}
        for i, v in ipairs(this.curAreaEventList) do
            if this.tapIndex == v.type then
                table.insert(cacheList, v)




            end
        end
        this.SetSearchItemData(cacheList, 2)
        this.SetSearchItem()
    end
end


this.RefreshList = function()   
    this.SetSearchItemData(this.curAreaEventList, 1)
    this.SetSearchItem()
end



this.SetSearchItemData = function(_configList, _posType)
    LuaDebug.error("_posType:" .. tostring(_posType))
    this.searchItemDataList = {}
    if (_configList ~= nil and #_configList > 0) then
        for i, v in ipairs(_configList) do
            local cache = {}
            cache.id = v.id
            cache.icon = v.type
            local list = NumTool.split(v.classId, ";");
            local posList = nil
            if (_posType == 1) then
                if list and #list >= 2 then
                    posList = NumTool.split(list[2], ",");
                end
                local config = ConfigZGCXMgr.GetActivityMapConfigByArea(v.area)
                if (config ~= nil) then
                    cache.name = LuaMgr.GetLangText(config.namelan);
                else
                    cache.name = ""
                end
            else
                if list and #list >= 3 then
                    posList = NumTool.split(list[3], ",");
                end
                cache.name = LuaMgr.GetLangText(v.namelan);
                local isFinish = PlayerWaterlilyMgr.CheckFinish(v)
                if (not isFinish) then
                    cache.icon = 6
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
    SetActive(this.itemSelectedObj, false)
    if (#this.searchItemDataList > 0) then
        for i, v in ipairs(this.searchItemDataList) do
            if (this.searchItemCacheTab[i] == nil or this.searchItemCacheTab[i].Obj == nil) then
                this.searchItemCacheTab[i] = {}
                local go = LuaMgr.InstantiateGO(this.searchItemObj, this.searchItemsBox, false)
                local cache = {}
                cache.go = go
                cache.btn = go.transform:GetComponent("Button")
                cache.ani = go.transform:GetComponent("Animator")
                cache.icon = go.transform:Find("icon")
                cache.textName = go.transform:Find("Image/TextName"):GetComponent("Text");
                cache.textPos = go.transform:Find("TextPos"):GetComponent("Text");
                this.searchItemCacheTab[i].Obj = cache
            end
            local obj = this.searchItemCacheTab[i].Obj
            obj.go.transform.localPosition = Vector3(tonumber(v.pos[1]), tonumber(v.pos[2]), 0)
            local bPlay = PlayerWaterlilyMgr.GetPlayerAnimation()
            SetActive(obj.go, not bPlay)
            obj.ani.enabled = false

            for j = 0, obj.icon.childCount - 1 do
                SetActive(obj.icon:GetChild(j).gameObject, (j + 1) == tonumber(v.icon))
            end
            obj.textName.text = v.name;
            obj.textPos.text = string.format("(%s,%s)", v.pos[1], v.pos[2])
            local onclick = function()
                if (v.icon == 6) then
                    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,
                        LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_22801"));
                    return;
                end
                this.selectedSearchItem = obj
                this.selectedSearchItem.ani.enabled = false
                this.selectedSearchItem.btn.enabled = false
                this.selectedSearchItem.go.transform:SetParent(this.middle, false)
                SetActive(this.selectedSearchItem.go, false)
                this.selectedSearchItem.config = v.config
                this.itemSelectedObj.transform.localPosition = obj.go.transform.localPosition
                for j = 0, this.itemSelIcon.childCount - 1 do
                    SetActive(this.itemSelIcon:GetChild(j).gameObject, (j + 1) == tonumber(v.icon))
                end
                this.itemSelTextName.text = v.name;
                this.itemSelTextPos.text = string.format("(%s,%s)", v.pos[1], v.pos[2])
                SetActive(this.itemSelectedObj, true)
                PlayerWaterlilyMgr.SetSelectedType(v.config.type)
                if (v.config.type == WaterlilyLevelNumType.Story) then
                    this.ShowTipPanelBig(obj, v)
                else
                    this.ShowTipPanelSmall(obj, v)
                end
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
    local bPlay = PlayerWaterlilyMgr.GetPlayerAnimation()
    if (bPlay) then
        if this.startDelay2 ~= nil then
            coroutine_runner.stop(this.startDelay2)
        end
        this.startDelay2 = coroutine_runner.start(function()
            for i, v in ipairs(this.searchItemDataList) do
                coroutine_runner.wait(0.1)
                local obj = this.searchItemCacheTab[i].Obj
                obj.ani.enabled = true
                SetActive(obj.go, true)
            end
            PlayerWaterlilyMgr.SetPlayerAnimation(false)
        end)
    end
end



this.ShowTipPanelBig = function(_obj, _config)
    local pos = _obj.go.transform.position
    local size = { 574, 314 }
    local aPos = this.CalculatePopupPosition(pos, size)
    SetActive(this.tipPanelBig.gameObject, true)
    this.tipPanelBig.anchoredPosition = aPos
    SetActive(this.tipPaneCloseBtn.gameObject, true)
    this.tipPanelBigTitle.text = LuaMgr.GetLangText(_config.config.namelan)
    this.tipPanelBigContent.text = LuaMgr.GetLangText(_config.config.descriptionlan)
    this.SetRewardItems(_config.config, this.tipPanelBigRewardObj)
end



this.ShowTipPanelSmall = function(_obj, _config)
    local pos = _obj.go.transform.position
    local size = { 571, 248 }
    local aPos = this.CalculatePopupPosition(pos, size)
    SetActive(this.tipPanelSmall.gameObject, true)
    this.tipPanelSmall.anchoredPosition = aPos
    SetActive(this.tipPaneCloseBtn.gameObject, true)
    this.tipPanelSmallTitle.text = LuaMgr.GetLangText(_config.config.namelan)
    local area = _config.config.type
    SetActive(this.tipPanelSmallTitleType1, area == WaterlilyLevelNumType.Play)
    SetActive(this.tipPanelSmallTitleType2, area ~= WaterlilyLevelNumType.Play)
    this.SetRewardItems(_config.config, this.tipPanelSmallRewardObj)
end




this.CalculatePopupPosition = function(_pos, _size)
    local UnityEngine_Screen_width = CS.UnityEngine.Screen.width
    local UnityEngine_Screen_height = CS.UnityEngine.Screen.height
    local inputWorldPos = _pos
    local popupSize = _size
    local offsetX = 40 * UnityEngine_Screen_width / 1280
    local offsetY = 40 * UnityEngine_Screen_height / 720
    local screenPointVec3 = LuaMgr.World2Screen(inputWorldPos)
    local screenPoint = { x = screenPointVec3.x, y = screenPointVec3.y }

    local screenWidth = UnityEngine_Screen_width
    local screenHeight = UnityEngine_Screen_height

    local inputQuadrant

    if screenPointVec3.z < 0 then
        inputQuadrant = 4
    elseif screenPoint.x >= screenWidth / 2 and screenPoint.y >= screenHeight / 2 then
        inputQuadrant = 1
    elseif screenPoint.x < screenWidth / 2 and screenPoint.y >= screenHeight / 2 then
        inputQuadrant = 2
    elseif screenPoint.x < screenWidth / 2 and screenPoint.y < screenHeight / 2 then
        inputQuadrant = 3
    else
        inputQuadrant = 4
    end

    local popupWorldX = screenPointVec3.x
    local popupWorldY = screenPointVec3.y

    local halfPopupWidth = popupSize[1] / 2 * UnityEngine_Screen_width / 1280
    local halfPopupHeight = popupSize[2] / 2 * UnityEngine_Screen_height / 720

    if inputQuadrant == 1 then
        popupWorldX = screenPointVec3.x - offsetX - halfPopupWidth
popupWorldY = screenPointVec3.y - offsetY - halfPopupHeight
    elseif inputQuadrant == 2 then
        popupWorldX = screenPointVec3.x + offsetX + halfPopupWidth
popupWorldY = screenPointVec3.y - offsetY - halfPopupHeight
    elseif inputQuadrant == 3 then
        popupWorldX = screenPointVec3.x + offsetX + halfPopupWidth
        popupWorldY = screenPointVec3.y + offsetY + halfPopupHeight
    else
        popupWorldX = screenPointVec3.x - offsetX - halfPopupWidth
        popupWorldY = screenPointVec3.y + offsetY + halfPopupHeight
    end
    local localPos = LuaMgr.Screen2Local(Vector2(popupWorldX, popupWorldY), this.root)
    return localPos
end


this.OnClickBigBattleBtn = function()
    if (this.selectedSearchItem == nil) then
        return
    end
    local config = this.selectedSearchItem.config
    local area = config.type
    if (area == WaterlilyLevelNumType.Story) then
        LuaMgr.PlayNovel(config.eventParam, function()
            if (this.tapIndex == nil) then
                LuaMgr.ShowLuaPanel(UIName.WaterlilyPlayViewModel);
            else
                LuaMgr.ShowLuaPanel(UIName.WaterlilyPlayViewModel, this.tapIndex);
            end
        end);
    end
end


this.OnClickSmallBattleBtn = function()
    if (this.selectedSearchItem == nil) then
        return
    end
    local config = this.selectedSearchItem.config
    local area = config.type
    if (area == WaterlilyLevelNumType.Repeat or area == WaterlilyLevelNumType.Main or area == WaterlilyLevelNumType.Difficult) then
        local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams();
        enterDungeonParams.eventId = config.id;
        enterDungeonParams.dungeonId = config.eventParam;
        BattlePrepareMgr.BattlePrepare(enterDungeonParams);
    elseif (area == WaterlilyLevelNumType.Play) then
        LuaMgr.ShowLuaPanel(UIName.WaterlilyGuessPanel, config);       
    end
end



this.SetRewardItems = function(_config, _container)
    local area = _config.type
    local rewardConfigList = {}
    local itemDataLis = {}
    local isFirst = false
    local isFinish = false
    if (area == WaterlilyLevelNumType.Repeat or area == WaterlilyLevelNumType.Main or area == WaterlilyLevelNumType.Difficult) then
        local dropShow = nil
        local record = DataMgr.Player.dungeonRecords[_config.eventParam];
        local dungeonConfig = ConfigMgr.Config.dungeonMap[_config.eventParam]
        if (record == nil or record.completeCount == 0) then
            isFirst = true
            dropShow = dungeonConfig.firstDropShow;
        elseif (record.completeCount ~= 0 and area ~= WaterlilyLevelNumType.Repeat) then
            isFinish = true
            dropShow = dungeonConfig.firstDropShow;
        else
            dropShow = dungeonConfig.fixedDropShow;
        end
        itemDataLis = NumTool.split(dropShow, ';')
    elseif (area == WaterlilyLevelNumType.Story) then
        local narrativeConfig = ConfigMgr.Config.narrativeMap[_config.eventParam];
        itemDataLis = NumTool.split(narrativeConfig.fixedDropShow, ';')
        isFinish = DataHelper.CheckNovelComplete(_config.id);
    else
        local rewardData = PlayerWaterlilyMgr.GetGameRewardsData();
        if (rewardData ~= nil and rewardData[_config.eventParam] ~= nil) then
            isFinish = true
        end
        local rewardConf = ConfigMgr.Config.ColorQuestionMap[_config.eventParam]
        for k, v in pairs(rewardConf.Reward) do
            table.insert(itemDataLis, v.id)
        end
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
        LuaMgr.AddClick(this.tipPaneCloseBtn, this.OnClickTipPaneClose);
        LuaMgr.AddClick(this.bigBattleBtn, this.OnClickBigBattleBtn);
        LuaMgr.AddClick(this.smallBattleBtn, this.OnClickSmallBattleBtn);
        RedMgr.Singleton:RegisterViewModel(UIName.WaterlilyPlayViewModel);
    end,

    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end        
        PlayerWaterlilyMgr.SetPlayerAnimation(true)
        this.curAreaEventList = DataExHelper.EX_GetEventListByArea("Waterlily1")
        if vm.behaviour.Params.Length > 0 then
            this.tapIndex = PlayerWaterlilyMgr.GetCurTap()
            if (this.tapIndex == nil) then
                this.tapIndex = vm.behaviour.Params[0]
            end
            this.OnClickTap(this.tapIndex)
        else
            this.tapIndex = nil
            this.SetData();
        end          
        PlayerWaterlilyMgr.CheckEntranceRedDot()       
        RedMgr.Singleton:Refresh()
        if (RedMgr.Singleton:CheckRedCondition("16405")) then
            RedMgr.Singleton:FrushRedCondition("16405")
        end
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
        LuaMgr.RemoveClick(this.tipPaneCloseBtn, this.OnClickTipPaneClose);
        LuaMgr.RemoveClick(this.bigBattleBtn, this.OnClickBigBattleBtn);
        LuaMgr.RemoveClick(this.smallBattleBtn, this.OnClickSmallBattleBtn);
        if (this.tabBoxTab ~= nil and #this.tabBoxTab > 0) then
            for i = 1, #this.tabBoxTab do
                LuaMgr.RemoveClick(this.tabBoxTab[i].btn, this.tabBoxTab[i].btnFunc)
            end
        end
        RedMgr.Singleton:RemoveViewModel(UIName.WaterlilyPlayViewModel);
        if (this.spineGO ~= nil) then
            LuaMgr.Destroy(this.spineGO);
            this.spineGO = nil;
        end
    end
}



this.CheckActivityRunning = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.Waterlily) then
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