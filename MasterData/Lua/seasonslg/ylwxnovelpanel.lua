require("SeasonSLG/YLWXNovelItem")
local objs = {
    itemPrefab = { path = "template/ItemGO", type = UITool.GameObject },
    scrollView = { path = "root/Middle/ScrollView", type = UITool.GameObject },
    scrollRect = { path = "root/Middle/ScrollView", type = UITool.RectTransform },
    scrollViewContent = { path = "root/Middle/ScrollView/Viewport/Content", type = UITool.RectTransform },
    itemListTra = { path = "root/Middle/ScrollView/Viewport/Content/ItemListTra", type = UITool.Transform },
    left = { path = "root/Left", type = UITool.GameObject },
    right = { path = "root/Right", type = UITool.GameObject }
}

local this = {
    scrollTweener = nil,
    scrollWidth = 0,
    scrollHeight = 0,
    contentPosX = 0,
    allNovelDatas = nil,
    newNovelData = nil,
    newNovelIndex = 0,
    lastNovelData = nil,
    novelItems = {}
}

this.CheckFinish = function(config)
    if config == nil or config.eventParam == nil then
        return false
    end
    if DataHelper ~= nil and DataHelper.CheckNovelComplete ~= nil then
        return DataHelper.CheckNovelComplete(config.eventParam)
    end
    return false
end

this.CheckUnlock = function(config)
    if config == nil then
        return false, ""
    end
    if config.unlockParam == nil or config.unlockParam == "" then
        return true, ""
    end
    local isUnlock = true
    if DataHelper ~= nil and DataHelper.CheckNovelComplete ~= nil then
        isUnlock = DataHelper.CheckNovelComplete(config.unlockParam)
    end
    local unlockDesc = ""
    if not isUnlock then
        unlockDesc = LuaMgr.GetLangText(config.tipsLan or config.tipslan)
    end
    return isUnlock, unlockDesc
end

this.GetAllNovelDatas = function()
    if this.NovelConfigs == nil then
        local list = nil
        if DataExHelper ~= nil and DataExHelper.EX_GetEventListByArea ~= nil then
            list = DataExHelper.EX_GetEventListByArea("YLWX4")
            if list == nil or #list == 0 then
                list = DataExHelper.EX_GetEventListByArea("JYSH4")
            end
        end
        this.NovelConfigs = list or {}
    end

    local finishDatas = {}
    local allDatas = {}
    local firstUnlockData = nil

    if this.NovelConfigs ~= nil and #this.NovelConfigs > 0 then
        for i = 1, #this.NovelConfigs do
            local data = this.NovelConfigs[i]
            data.Index = i
            data.IsFirst = (i == 1)
            data.IsLast = (i == #this.NovelConfigs)
            data.Name = LuaMgr.GetLangText(data.nameLan or data.namelan)

            if this.CheckFinish(data) == true then
                data.Status = CommonRewardItem.Status.Got
            else
                local isUnlock, unlockDesc = this.CheckUnlock(data)
                if isUnlock == true then
                    data.Status = CommonRewardItem.Status.None
                else
                    data.Status = CommonRewardItem.Status.Lock
                    data.UnlockDesc = unlockDesc
                end
            end

            if data.Status == CommonRewardItem.Status.Got then
                table.insert(finishDatas, data)
            elseif data.Status == CommonRewardItem.Status.None and firstUnlockData == nil then
                firstUnlockData = data
            end
            table.insert(allDatas, data)
        end
    end

    return allDatas, firstUnlockData
end

this.SetNovelList = function()
    local addWidth = LuaMgr.GetScreenAddWidth()
    this.scrollWidth = 1280 + addWidth
    this.scrollHeight = 500
    this.scrollRect.sizeDelta = Vector2(this.scrollWidth, this.scrollHeight)
    this.allNovelDatas, this.newNovelData = this.GetAllNovelDatas()
    this.newNovelIndex = 0
    this.lastNovelData = nil
    this.contentPosX = math.huge

    if this.novelItems == nil then
        this.novelItems = {}
    end

    local len = this.allNovelDatas ~= nil and #this.allNovelDatas or 0
    for i = 1, len do
        local slot = this.itemListTra ~= nil and this.itemListTra:Find("Item" .. i)
        if slot ~= nil then
            local item = this.novelItems[i]
            if item == nil then
                local itemObj = LuaMgr.InstantiateGO(this.itemPrefab, slot, false)
                itemObj.transform.localPosition = Vector3.zero
                itemObj.transform.localScale = Vector3.one
                itemObj.transform.localRotation = Quaternion.identity
                item = YLWXNovelItem.New(itemObj)
                this.novelItems[i] = item
            end

            local data = this.allNovelDatas[i]
            if data ~= nil then
                data.OnClickBtn = this.OnClickNovelItem
                data.IsSelected = false
                if this.newNovelData ~= nil and data == this.newNovelData then
                    this.newNovelIndex = i
                end
                item:SetData(data)
                SetActive(slot.gameObject, true)
                SetActive(item.gameObject, true)
            else
                SetActive(slot.gameObject, false)
            end
        end
    end


    local defaultSelectIndex = 0
    if this.newNovelIndex > 0 and this.allNovelDatas[this.newNovelIndex] and this.allNovelDatas[this.newNovelIndex].Status ~= CommonRewardItem.Status.Lock then
        defaultSelectIndex = this.newNovelIndex
    elseif len > 0 and this.allNovelDatas[1] and this.allNovelDatas[1].Status ~= CommonRewardItem.Status.Lock then
        defaultSelectIndex = 1
    end

    if defaultSelectIndex > 0 then
        local selectData = this.allNovelDatas[defaultSelectIndex]
        selectData.IsSelected = true
        this.lastNovelData = selectData
        if this.novelItems[defaultSelectIndex] ~= nil then
            this.novelItems[defaultSelectIndex]:SetSelected(true)
        end
        this.RefreshBottomInfo(selectData)
    else
        this.RefreshBottomInfo(nil)
    end

    this.MoveToNewNovel()
    this.UpdateGotoNewBtn()
end

this.RefreshBottomInfo = function(data)
    if this.introBtn ~= nil and not IsObjectNull(this.introBtn) then
        if data == nil or data.Status == CommonRewardItem.Status.Lock then
            this.introBtn.interactable = false
        else
            this.introBtn.interactable = true
        end
    end
    if this.textTitle ~= nil and not IsObjectNull(this.textTitle) then
        this.textTitle.text = (data ~= nil and data.Name) or ""
    end
    if this.textType ~= nil and not IsObjectNull(this.textType) then
        if data == nil or data.Status == CommonRewardItem.Status.Lock then
            this.textType.text = ""
        else
            this.textType.text = data.Status == CommonRewardItem.Status.Got and LuaMgr.GetLangText("WJWYNovelPanel_0") or LuaMgr.GetLangText("WJWYNovelPanel_1")
        end
    end
end





this.OnClickNovelItem = function(item)
    if item == nil or item.data == nil then
        return
    end
    if item.data.Status == CommonRewardItem.Status.Lock then
        local desc = item.data.UnlockDesc
        if not IsNullOrEmpty(desc) then
            if PopUpMgr ~= nil and PopUpMgr.ShowTips ~= nil then
                PopUpMgr.ShowTips(desc)
            elseif LuaMgr ~= nil and LuaMgr.ShowPanel ~= nil and UIName ~= nil and UIName.MessageTipsViewModel ~= nil then
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, desc)
            end
        end
        return
    end

    if this.lastNovelData ~= nil then
        this.lastNovelData.IsSelected = false
    end
    this.lastNovelData = item.data
    this.lastNovelData.IsSelected = true

    if this.novelItems ~= nil then
        for _, novelItem in pairs(this.novelItems) do
            if novelItem ~= nil and novelItem.data ~= nil then
                novelItem:SetSelected(novelItem.data == this.lastNovelData)
            end
        end
    end

    this.RefreshBottomInfo(this.lastNovelData)
    this.PlayNovel(this.lastNovelData)
end

this.PlayNovel = function(data)
    if data == nil then
        return
    end
    local novelID = data.eventParam
    if novelID == nil or novelID == "" then
        return
    end
    local callback = function()
        LuaMgr.ShowLuaPanel(UIName.YLWXNovelPanel)
    end
    LuaMgr.PlayNovel(novelID, callback)
    if this.newNovelData ~= nil and this.newNovelData.eventParam == novelID then
        local redID = string.format("%s_%s", WJWYConst and WJWYConst.RedPoint and WJWYConst.RedPoint.Novel or "Novel", novelID)
        if RedMgr ~= nil and RedMgr.Singleton ~= nil and RedMgr.Singleton.FrushRedCondition ~= nil then
            RedMgr.Singleton:FrushRedCondition(redID)
        end
        if SeasonSLGMapMgr ~= nil and SeasonSLGMapMgr.CheckNovelRed ~= nil then
            SeasonSLGMapMgr.CheckNovelRed()
        end
    end
end

this.OnClickIntroBtn = function()
    if this.lastNovelData == nil or this.lastNovelData.Status == CommonRewardItem.Status.Lock then
        return
    end
    this.PlayNovel(this.lastNovelData)
end

this.OnClickGotoNewBtn = function()
    this.MoveToNewNovel()
end

this.MoveToNewNovel = function(animated)
    local targetIndex = 1
    if this.newNovelIndex ~= nil and this.newNovelIndex > 0 then
        targetIndex = this.newNovelIndex
    end
    if animated == nil then
        animated = true
    end
    this.MoveToIndex(targetIndex, animated)
    this.UpdateGotoNewBtn()
end




this.MoveToIndex = function(index, animated)
    if index == nil or index <= 0 then
        return
    end
    if this.itemListTra == nil or this.scrollViewContent == nil then
        return
    end
    local slot = this.itemListTra:Find("Item" .. index)
    if slot == nil then
        return
    end


    local viewport = this.scrollViewContent.parent:GetComponent(typeof(CS.UnityEngine.RectTransform))
    local viewportWidth = (this.scrollWidth and this.scrollWidth > 0) and this.scrollWidth or (viewport and viewport.rect.width or 1280)
    local contentWidth = this.scrollViewContent.rect.width
    if contentWidth <= 0 then
        contentWidth = 2885
    end
    local contentPivotX = this.scrollViewContent.pivot.x


    local targetLocalPos = this.scrollViewContent:InverseTransformPoint(slot.position)
    local targetContentX = targetLocalPos.x


    local targetAnchoredX = viewportWidth * 0.5 - targetContentX


    if contentWidth <= viewportWidth then
        targetAnchoredX = (viewportWidth - contentWidth) * 0.5 + contentWidth * contentPivotX
    else
        local minX = viewportWidth - contentWidth * (1 - contentPivotX)
        local maxX = contentWidth * contentPivotX
        if targetAnchoredX < minX then
            targetAnchoredX = minX
        elseif targetAnchoredX > maxX then
            targetAnchoredX = maxX
        end
    end


    if this.scrollTweener ~= nil then
        this.scrollTweener:Kill(false)
        this.scrollTweener = nil
    end


    if animated ~= false and DOTWeen ~= nil then
        this.scrollTweener = DOTWeen.To(
            function()
                return this.scrollViewContent.anchoredPosition.x
            end,
            function(x)
                this.scrollViewContent.anchoredPosition = Vector2(x, this.scrollViewContent.anchoredPosition.y)
            end,
            targetAnchoredX,
            0.3
        ):SetEase(Ease.OutCubic):OnComplete(function()
            this.scrollTweener = nil
        end)
    else
        this.scrollViewContent.anchoredPosition = Vector2(targetAnchoredX, this.scrollViewContent.anchoredPosition.y)
    end
end

this.UpdateGotoNewBtn = function()
    if this.gotoNewBtn == nil or IsObjectNull(this.gotoNewBtn) then
        return
    end
    if this.newNovelData == nil or this.newNovelIndex == nil or this.newNovelIndex <= 0 then
        SetActive(this.gotoNewBtn.gameObject, false)
        return
    end
    SetActive(this.gotoNewBtn.gameObject, false)
end

this.OnUpdate = function()
    if this.scrollViewContent == nil or IsObjectNull(this.scrollViewContent) then
        return
    end
    local px = math.floor(this.scrollViewContent.anchoredPosition.x)
    if px == this.contentPosX then
        return
    end
    this.contentPosX = px
    this.UpdateGotoNewBtn()
end



local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        if this.itemPrefab == nil and this.itemGO ~= nil then
            this.itemPrefab = this.itemGO
        end
        if this.introBtn ~= nil and not IsObjectNull(this.introBtn) then
            LuaMgr.AddClick(this.introBtn, this.OnClickIntroBtn)
        end
        if this.gotoNewBtn ~= nil and not IsObjectNull(this.gotoNewBtn) then
            LuaMgr.AddClick(this.gotoNewBtn, this.OnClickGotoNewBtn)
        end
        if RedMgr ~= nil and RedMgr.Singleton ~= nil then
            RedMgr.Singleton:RegisterViewModel(UIName.YLWXNovelPanel)
        end
    end,
    before_active = function(vm)
        this.SetNovelList()
        this.OnUpdate()
    end,
    before_deactive = function(vm)
        if this.scrollTweener ~= nil then
            this.scrollTweener:Kill(false)
            this.scrollTweener = nil
        end
        this.lastNovelData = nil
    end,
    before_destroy = function()
        if this.scrollTweener ~= nil then
            this.scrollTweener:Kill(false)
            this.scrollTweener = nil
        end
        if this.introBtn ~= nil and not IsObjectNull(this.introBtn) then
            LuaMgr.RemoveClick(this.introBtn, this.OnClickIntroBtn)
        end
        if this.gotoNewBtn ~= nil and not IsObjectNull(this.gotoNewBtn) then
            LuaMgr.RemoveClick(this.gotoNewBtn, this.OnClickGotoNewBtn)
        end
        if this.novelItems ~= nil then
            for _, item in pairs(this.novelItems) do
                if item ~= nil and item.Destroy ~= nil then
                    item:Destroy()
                end
            end
            this.novelItems = nil
        end
        if RedMgr ~= nil and RedMgr.Singleton ~= nil then
            RedMgr.Singleton:RemoveViewModel(UIName.YLWXNovelPanel)
        end
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)