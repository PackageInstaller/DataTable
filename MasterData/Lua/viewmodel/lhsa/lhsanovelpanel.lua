require("ViewModel/LHSA/LHSANovelItem")
local objs = {
    novelPointRight = {path = "root/Middle/NovelPointRight", type = UITool.GameObject},
    novelPointDown = {path = "root/Middle/NovelPointDown", type = UITool.GameObject},
    novelPointUp = {path = "root/Middle/NovelPointUp", type = UITool.GameObject},
    introBtn = {path = "root/Middle/IntroBtn", type = UITool.Button},
    introSelectObj = {path = "root/Middle/IntroBtn/SelectObj", type = UITool.GameObject},
    pointParent = {path = "root/Middle", type = UITool.Transform}
}

local this = {

    novelItems = nil,

    novelItemsCacheEven = {},

    novelItemsCacheOdd = {},

    novelItemRight = nil,

    novelItemDown = nil,

    novelItemUp = nil
}

this.before_awake = function()
    this.novelItemRight = LHSANovelItem.New(this.novelPointRight)
    this.novelItemDown = LHSANovelItem.New(this.novelPointDown)
    this.novelItemUp = LHSANovelItem.New(this.novelPointUp)
end

this.before_active = function()
    if this.novelItems == nil then
        this.novelItems = {}
    end
    local allData = LHSAMgr.GetNovelDatas()
    local instantiateCount = 0
    for i = 1, #allData do
        local data = allData[i]
        data.OnClickButton = this.OnClickNovelItem
        if data.Type == 1 then
            this.novelItemRight:SetData(data)
        elseif data.Type == 2 then
            this.novelItemDown:SetData(data)
        elseif data.Type == 3 and instantiateCount == 0 then
            this.novelItemUp:SetData(data)
            instantiateCount = instantiateCount + 1
        elseif data.Type == 3 and instantiateCount > 0 then
            local isEven = instantiateCount % 2 == 0
            local item = this.GetNovelItem(isEven)
            table.insert(this.novelItems, item)
            item:SetData(data)
            item:SetIsEven(isEven)
            local posX = this.novelItemUp.rectTrans.anchoredPosition.x + 155 * instantiateCount
            local posY = isEven and this.novelItemUp.rectTrans.anchoredPosition.y or -92
            item:SetPosition(Vector2(posX, posY))
            instantiateCount = instantiateCount + 1
        end
    end
    this.RefreshIntroBtnStatus()
end



this.OnClickNovelItem = function(item)
    if this.curSelectItem ~= nil then
        this.curSelectItem:SetSelectStatus(false)
    end
    this.curSelectItem = item
    this.curSelectItem:SetSelectStatus(true)
    this.RefreshIntroBtnStatus()
end

this.OnClickIntroBtn = function()
    if this.curSelectItem == nil then
        return
    end
    if this.curSelectItem.data.Status == CommonRewardItem.Status.Lock then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, this.curSelectItem.data.UnlockDesc)
        return
    end
    local playNovelCallback = function()
        LuaMgr.ShowLuaPanel(UIName.LHSANovelPanel)
    end
    LuaMgr.PlayNovel(this.curSelectItem.data.eventParam, playNovelCallback)
    local redId = string.format("%s_%s", 18503, this.curSelectItem.data.eventParam)
    RedMgr.Singleton:FrushRedCondition(redId)
end

this.RefreshIntroBtnStatus = function()
    SetActive(this.introSelectObj, this.curSelectItem ~= nil)
end

this.GetNovelItem = function(isEven)
    local novelItemsCache = isEven == true and this.novelItemsCacheEven or this.novelItemsCacheOdd
    local item = table.remove(novelItemsCache)
    if item == nil then
        if isEven == true then
            item = LHSANovelItem.New(this.novelPointUp, true, this.pointParent)
        else
            item = LHSANovelItem.New(this.novelPointDown, true, this.pointParent)
        end
    end
    return item
end

this.Recycle = function()
    if this.novelItems == nil then
        return
    end
    for key, value in pairs(this.novelItems) do
        if value.isEven == true then
            table.insert(this.novelItemsCacheEven, value)
        else
            table.insert(this.novelItemsCacheOdd, value)
        end
    end
    this.novelItems = nil
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.introBtn, this.OnClickIntroBtn)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.before_active()
    end,
    before_deactive = function(vm)
        this.Recycle()
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.introBtn, this.OnClickIntroBtn)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)