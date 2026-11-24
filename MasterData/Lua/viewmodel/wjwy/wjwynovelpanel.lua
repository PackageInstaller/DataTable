require("ViewModel/WJWY/ViewItem/WJWYNovelItem")
local objs = {
    itemPrefab = { path = "template/ItemPrefab", type = UITool.GameObject },
    scrollView = { path = "root/Middle/ScrollView", type = UITool.GameObject },
    scrollViewContent = { path = "root/Middle/ScrollView/Viewport/Content", type = UITool.RectTransform },
    introBtn = { path = "root/Middle/IntroBtn", type = UITool.Button },
    gotoNewBtn = { path = "root/Right/GotoNewBtn", type = UITool.Button },
    textType = { path = "root/Middle/bg/textType", type = UITool.Text },
    textTitle = { path = "root/Middle/bg/textTitle", type = UITool.Text }
}

local this = {
    levelSV = nil,
    scrollWidth = 0,
    scrollHeight = 0,
    contentPosX = 0,
    allNovelDatas = nil,
    newNovelData = nil,
    newNovelIndex = 0,
    lastNovelData = nil
}

this.SetNovelList = function()
    local addWidth = LuaMgr.GetScreenAddWidth()
    this.scrollWidth = 1280 + addWidth
    this.scrollHeight = 240

    if this.levelSV ~= nil then
        this.levelSV:Clear(false)
    end
    this.allNovelDatas, this.newNovelData = WJWYData.GetAllNovelDatas()
    this.newNovelIndex = 0
    this.lastNovelData = nil
    this.contentPosX = math.huge

    local scrollDatas = {}
    local len = this.allNovelDatas ~= nil and #this.allNovelDatas or 0
    for i = 1, len do
        local data = this.allNovelDatas[i]
        data.OnClickBtn = this.OnClickNovelItem
        data.IsSelected = false
        if this.newNovelData ~= nil and data == this.newNovelData then
            this.newNovelIndex = i
        end
        local scrollData = UIScrollData.GetData(this.itemPrefab, "WJWYNovelItem", 170, 148, data)
        table.insert(scrollDatas, scrollData)
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
        this.RefreshBottomInfo(selectData)
    else
        this.RefreshBottomInfo(nil)
    end

    if this.levelSV ~= nil then
        this.levelSV:SetParams(this.scrollWidth, this.scrollHeight)
        this.levelSV:SetPadding(50, 50, 0, 0)
        this.levelSV:SetData(scrollDatas, true)
    end

    this.MoveToNewNovel()
    this.UpdateGotoNewBtn()
end

this.RefreshBottomInfo = function(data)
    if this.introBtn == nil or IsObjectNull(this.introBtn) then
        return
    end
    if data == nil or data.Status == CommonRewardItem.Status.Lock then
        this.introBtn.interactable = false
        if this.textTitle ~= nil and not IsObjectNull(this.textTitle) then
            this.textTitle.text = ""
        end
        if this.textType ~= nil and not IsObjectNull(this.textType) then
            this.textType.text = ""
        end
    else
        this.introBtn.interactable = true
        if this.textTitle ~= nil and not IsObjectNull(this.textTitle) then
            this.textTitle.text = data.Name or ""
        end
        if this.textType ~= nil and not IsObjectNull(this.textType) then
            this.textType.text = data.Status == CommonRewardItem.Status.Got and LuaMgr.GetLangText("WJWYNovelPanel_0") or LuaMgr.GetLangText("WJWYNovelPanel_1")
        end
    end
end





this.OnClickNovelItem = function(item)
    if item == nil or item.data == nil then
        return
    end
    if item.data.Status == CommonRewardItem.Status.Lock then
        return
    end
    if this.lastNovelData == item.data then
        return
    end
    if this.lastNovelData ~= nil then
        this.lastNovelData.IsSelected = false
    end
    this.lastNovelData = item.data
    this.lastNovelData.IsSelected = true

    if this.levelSV ~= nil then
        this.levelSV:Refresh()
    end

    this.RefreshBottomInfo(this.lastNovelData)
end

this.OnClickIntroBtn = function()
    if this.lastNovelData == nil or this.lastNovelData.Status == CommonRewardItem.Status.Lock then
        return
    end
    local novelID = this.lastNovelData.eventParam
    if novelID == nil then
        return
    end
    local callback = function()
        LuaMgr.ShowLuaPanel(UIName.WJWYNovelPanel)
    end
    LuaMgr.PlayNovel(novelID, callback)
    if this.newNovelData ~= nil and this.newNovelData.eventParam == novelID then
        local redID = string.format("%s_%s", WJWYConst.RedPoint.Novel, novelID)
        RedMgr.Singleton:FrushRedCondition(redID)
    end
end

this.OnClickGotoNewBtn = function()
    this.MoveToNewNovel()
end

this.MoveToNewNovel = function()
    if this.levelSV == nil then
        return
    end
    local targetIndex = 1
    if this.newNovelIndex ~= nil and this.newNovelIndex > 0 then
        targetIndex = this.newNovelIndex
    end
    this.levelSV:MoveToIndex(targetIndex, true)
    this.UpdateGotoNewBtn()
end

this.UpdateGotoNewBtn = function()
    if this.gotoNewBtn == nil or IsObjectNull(this.gotoNewBtn) then
        return
    end
    if this.levelSV == nil or this.newNovelData == nil or this.newNovelIndex == nil or this.newNovelIndex <= 0 then
        SetActive(this.gotoNewBtn.gameObject, false)
        return
    end
    local inScreen = this.levelSV:InScreen(this.newNovelIndex)
    SetActive(this.gotoNewBtn.gameObject, not inScreen)
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
        this.levelSV = UIScrollView.New(this.scrollView)
        if this.levelSV ~= nil then
            this.levelSV.scrollCallBack = this.UpdateGotoNewBtn
        end
        LuaMgr.AddClick(this.introBtn, this.OnClickIntroBtn)
        LuaMgr.AddClick(this.gotoNewBtn, this.OnClickGotoNewBtn)
        RedMgr.Singleton:RegisterViewModel(UIName.WJWYNovelPanel)
    end,
    before_active = function(vm)
        this.SetNovelList()
        LuaMgr.AddUpdate(this.OnUpdate)
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUpdate(this.OnUpdate)
        if this.levelSV ~= nil then
            this.levelSV:Clear(true)
        end
        this.lastNovelData = nil
    end,
    before_destroy = function()
        LuaMgr.RemoveUpdate(this.OnUpdate)
        if this.introBtn ~= nil and not IsObjectNull(this.introBtn) then
            LuaMgr.RemoveClick(this.introBtn, this.OnClickIntroBtn)
        end
        if this.gotoNewBtn ~= nil and not IsObjectNull(this.gotoNewBtn) then
            LuaMgr.RemoveClick(this.gotoNewBtn, this.OnClickGotoNewBtn)
        end
        if this.levelSV ~= nil then
            this.levelSV.scrollCallBack = nil
            this.levelSV:Clear(true)
            this.levelSV:Destroy()
            this.levelSV = nil
        end
        UIScrollView.ClearItem("WJWYNovelItem")
        RedMgr.Singleton:RemoveViewModel(UIName.WJWYNovelPanel)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)