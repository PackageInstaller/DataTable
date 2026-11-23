require("ViewModel/HMWY/HMWYTalentItem")

local this =
{
    talentList = nil,
    showList = nil,
    selectedData = nil,
    lvUpId = nil,
};

local objs = {
    talentItem = { path = "template/talentItem", type = "GameObject" },
    bg1 = { path = "root/Bg1", type = "Button" },
    disselected = { path = "root/Bg1/Disselected", type = "Button" },
    imageList = { path = "root/Bg1/ImageList", type = "Transform" },
    imageBox = { path = "root/Middle/ImageBox", type = "RectTransform" },
    buttonCost = { path = "root/Middle/ImageBox/ButtonCost", type = "Button" },
    textCost = { path = "root/Middle/ImageBox/ButtonCost/TextCost", type = "Text" },
    imgCost = { path = "root/Middle/ImageBox/ButtonCost/TextCost/ImgCost", type = "RawImage" },
    imageMask = { path = "root/Middle/ImageBox/ButtonCost/ImageMask", type = "GameObject" },
    textTitle = { path = "root/Middle/ImageBox/TextTitle", type = "Text" },
    imageIcon = { path = "root/Middle/ImageBox/ImageIcon", type = "Image" },
    textContent = { path = "root/Middle/ImageBox/TextContent", type = "Text" },
    right = { path = "root/Right", type = "Transform" },
    left = { path = "root/Left", type = "Transform" },
};




this.SetData = function()
    this.activityKey = ActivityKey.HMWY

    this.SetTalentList()
end


this.OnBack = function()
    LuaMgr.Back()
end

this.OnClickLvUp = function()
    if this.CheckActivityRunning() and this.selectedData ~= nil then
        if (this.selectedData.isUnlock) then
            local cost = this.selectedData.config.UnConsump[1]
            local count = DataHelper.GetItemCountById(cost.id)
            if cost.count > count then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("10204"))
                return
            end
            local id = this.selectedData.config.Id
            ApiMgr.Request("HMWYGame/techTree", { Id = id }, true, function(result)
                HMWYMgr.SetShowAni(false)
                this.lvUpId = id
                this.SetTalentList()
                this.FinishTalent(id)
            end, nil, true, true);
        else
            local unlock = HMWYMgr.CheckTalentIsUnLock(this.selectedData.config)
            if (not unlock) then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("30259"))
            end
        end
    end
end

this.OnClickDisselected = function()
    SetActive(this.imageBox.gameObject, false)
    for k, v in pairs(this.talentList.itemList) do
        v.data.isSelected = false
        v:ShowSelected(v.data.isSelected)
    end
end

this.BuildTypeGroups = function()
    local typeGroups = {}
    for _, v in pairs(ConfigMgr.Config.HmwyTechTreeMap) do
        local typeId = v.Type
        if not typeGroups[typeId] then
            typeGroups[typeId] = { items = {}, hasInProgress = false, allFinish = true, anyUnlock = false }
        end
        local group  = typeGroups[typeId]
        local unlock = HMWYMgr.CheckTalentIsUnLock(v)
        local finish = HMWYMgr.CheckTalentIsComplete(v)
        table.insert(group.items, { config = v, unlock = unlock, finish = finish })
        if unlock and not finish then group.hasInProgress = true end
        if not finish then group.allFinish = false end
        if unlock then group.anyUnlock = true end
    end
    return typeGroups
end

this.GetGroupRepItem = function(group)
    local repItem = nil
    if group.hasInProgress then
        for _, item in ipairs(group.items) do
            if item.unlock and not item.finish then
                if repItem == nil or item.config.Index < repItem.config.Index then
                    repItem = item
                end
            end
        end
    elseif not group.anyUnlock then
        for _, item in ipairs(group.items) do
            if repItem == nil or item.config.Index < repItem.config.Index then
                repItem = item
            end
        end
    else
        for _, item in ipairs(group.items) do
            if repItem == nil or item.config.Index > repItem.config.Index then
                repItem = item
            end
        end
    end
    return repItem
end

this.BuildCacheMap = function(typeGroups)
    local cacheMap = {}
    for typeId, group in pairs(typeGroups) do
        local rep        = this.GetGroupRepItem(group)
        local cache      = {}
        cache.config     = rep.config
        cache.unlock     = rep.unlock
        cache.finish     = rep.finish
        cache.num        = #group.items
        cacheMap[typeId] = cache
    end
    return cacheMap
end

this.ResolvNestNum = function(typeGroups, lvUpType)
    local function findBestInProgressType()
        local best = nil
        for typeId, group in pairs(typeGroups) do
            if group.hasInProgress and (best == nil or typeId < best) then
                best = typeId
            end
        end
        return best or 0
    end

    if lvUpType == nil then
        return findBestInProgressType()
    end

    local lvUpGroup = typeGroups[lvUpType]
    if lvUpGroup and lvUpGroup.hasInProgress then
        return lvUpType
    end
    return findBestInProgressType()
end

this.SetTalentList = function()
    this.talentList:Clear()
    local lvUpType = nil
    if this.lvUpId ~= nil then
        local lvUpConfig = ConfigMgr.Config.HmwyTechTreeMap[this.lvUpId]
        if lvUpConfig then lvUpType = lvUpConfig.Type end
        this.lvUpId = nil
    end

    local typeGroups = this.BuildTypeGroups()
    local cacheMap   = this.BuildCacheMap(typeGroups)
    local nestNum    = lvUpType
    if (lvUpType == nil) then
        nestNum = this.ResolvNestNum(typeGroups, nil)
    end
    local scrollDatas = {}
    local len         = #cacheMap
    for i = 1, len do
        local data = cacheMap[i]
        local scrollData = UIListData.GetData(this.talentItem, "HMWYTalentItem", {
            config     = data.config,
            num        = data.num,
            numIndex   = i,
            isSelected = nestNum == i,
            isUnlock   = data.unlock,
            isFinish   = data.finish,
            callback   = this.ItemClickCallBack
        })
        table.insert(scrollDatas, scrollData)
    end

    this.talentList:SetData(scrollDatas)
    this.showIndex = 1
    this.showList  = this.talentList.itemList

    local showAni  = HMWYMgr.CheckShowAni()
    for _, v in pairs(this.showList) do
        SetActive(v.gameObject, not showAni)
    end
    if showAni then
        LuaMgr.AddTimer(TimerConst.SGYNovelListDelay, this.OnTalentList, 0.05, -1, true)
    end

    this.ItemClickCallBack(nestNum > 0 and nestNum or 1)
end


this.OnTalentList = function()
    if (this.showIndex > #this.showList) then
        LuaMgr.RemoveTimer(TimerConst.SGYNovelListDelay);
        this.showList = nil;
        return;
    end
    local item = this.showList[this.showIndex];
    SetActive(item.gameObject, true);
    this.showIndex = this.showIndex + 1;
end

this.ItemClickCallBack = function(index)
    local item = this.talentList.itemList[index];
    local data = item.data.config;
    this.selectedData = item.data

    this.textTitle.text = LuaMgr.GetLangText(data.NameLan);
    this.textContent.text = LuaMgr.GetLangText(data.DescriptionLan);
    this.textCost.text = data.UnConsump[1].count
    local iconPath = ConfigHelper.GetItemHomeIconPath(data.UnConsump[1].id)
    local iconTexture = LuaMgr.GetTexture(iconPath)
    this.imgCost.texture = iconTexture
    local isUnlock = item.data.isUnlock
    local isFinish = item.data.isFinish
    local isFinishStr = item.data.isFinish == true and "b" or "a"
    this.imageIcon.sprite = LuaMgr.GetSprite("HMWY", data.Icon .. isFinishStr)
    SetActive(this.imageMask, not isUnlock);
    SetActive(this.buttonCost.gameObject, not isUnlock or not isFinish)
    for k, v in pairs(this.talentList.itemList) do
        v.data.isSelected = false
        if (index == v.data.numIndex) then
            v.data.isSelected = true
        end
        v:ShowSelected(v.data.isSelected)
    end
    SetActive(this.imageBox.gameObject, true)
    this.SetImageBoxPos(data)

end

this.SetImageBoxPos = function(config)
    if (config.Pos[1] < 0) then
        this.imageBox.anchoredPosition = Vector2(460, 0);
    else
        this.imageBox.anchoredPosition = Vector2(-460, 0);
    end
end

this.FinishTalent = function(id)
    for k, v in pairs(this.talentList.itemList) do
        local data = v.data.config;
        if (data.Id == id) then
            v:ShowOnce(true)
        else
            v:ShowOnce(false)
        end
    end
end



local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.buttonCost, this.OnClickLvUp);
        LuaMgr.AddClick(this.disselected, this.OnClickDisselected)
        RedMgr.Singleton:RegisterViewModel(UIName.HMWYTalentViewModel);
        this.talentList = UIListView.New(this.imageList);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        HeroRedDataHelper.SetHMWYRed()
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.SGYNovelListDelay);
        this.showList = nil;
        this.talentList:Clear();
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.buttonCost, this.OnClickLvUp);
        LuaMgr.RemoveClick(this.disselected, this.OnClickDisselected)
        RedMgr.Singleton:RemoveViewModel(UIName.HMWYTalentViewModel);
        UIListView.ClearItem("HMWYTalentItem");
    end
}


this.CheckActivityRunning = function()
    if not DataExHelper.CommonActivityCheck(this.activityKey) then
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