require("ViewModel/WJWY/ViewItem/WJWYShopItemGroup")

local this = {
    msgList = {
        "LangGlobalLan_LangGlobal_name_33213",
        "LangGlobalLan_LangGlobal_name_33214",
        "LangGlobalLan_LangGlobal_name_33215",
        "LangGlobalLan_LangGlobal_name_33216",
        "LangGlobalLan_LangGlobal_name_33217",
        "LangGlobalLan_LangGlobal_name_33218",
    },
    msgIndex = 0,
    scrollView = nil,
    questEvents = nil,
    shopItem = nil
}

local objs = {
    shopItem = { path = "template/ShopItem", type = UITool.GameObject },
    shopItemGroup = { path = "template/ShopItemGroup", type = UITool.GameObject },
    shopsGO = { path = "root/Middle/GroupGoods/Shops", type = UITool.GameObject },
    characterTF = { path = "root/Middle/GroupChacter/Character", type = UITool.RectTransform },
    characterDrawing = { path = "root/Middle/GroupChacter/Character/Body", type = UITool.DrawingAdjustTool },
    spineCharacter = { path = "root/Middle/GroupChacter/Character/Body", type = UITool.UISpineCharacter },
    characterBtn = { path = "root/Middle/GroupChacter/Character/Click", type = UITool.Button },
    msgContent = { path = "root/Middle/GroupChacter/Msg/ScrollView/Viewport/Content", type = UITool.Text },
    charaterGroupRect = { path = "root/Middle/GroupChacter", type = UITool.RectTransform },
    goosGroupRect = { path = "root/Middle/GroupGoods", type = UITool.RectTransform }
}

this.before_awake = function()

end

this.before_active = function()
    local screenWidth = LuaMgr.ScreenWidth()
    local screenHeight = LuaMgr.ScreenHeight()
    local fixRate = 21 / 9
    if screenWidth / screenHeight >= fixRate then
        this.goosGroupRect.anchoredPosition = Vector2(-50, 0)
        this.charaterGroupRect.anchoredPosition = Vector2(50, 0)
    else
        this.goosGroupRect.anchoredPosition = Vector2.zero
        this.charaterGroupRect.anchoredPosition = Vector2.zero
    end
end


this.SetData = function()
    this.questEvents = DataExHelper.Check_ConfigQuestEventByText(WJWYConst.ShopEventIDName)
    LuaMgr.AddTimer(TimerConst.SGYShopMsgTime, this.SetMsg, 10, -1, true)
end


this.SetCharacter = function()
    local characterId = WJWYConst.ShopCharacterID
    local path = HeroManager.SetCharacterDrawing(this.spineCharacter, characterId, characterId .. "001")
    if path ~= "" and this.characterDrawing ~= nil then
        this.characterDrawing.Sprite = path
    end
end


this.SetMsg = function()
    local len = #this.msgList
    local index = math.random(1, len)
    if (this.msgIndex ~= index) then
        this.msgIndex = index
    else
        if (index >= len) then
            this.msgIndex = index - 1
        else
            this.msgIndex = index + 1
        end
    end
    this.msgContent.text = LuaMgr.GetLangText(this.msgList[this.msgIndex])
end


this.SetShopList = function()
    this.scrollView:Clear(false)
    local itemLen
    local scrollDatas = {}
    local events = this.GetQuestEvents()
    local len = #events
    local index = 0
    while index < len do
        itemLen = index + 4 > len and len - index or 4
        local groupData = {}
        groupData.item = this.shopItem
        groupData.list = {}
        for i = 1, itemLen do
            if i + index <= len then
                table.insert(groupData.list, events[i + index])
                groupData.numIndex = i + index
            end
        end
        index = index + itemLen
        local scrollData = UIScrollData.GetData(this.shopItemGroup, "WJWYShopItemGroup", 815, 264, groupData)
        table.insert(scrollDatas, scrollData)
    end
    this.scrollView:SetParams(815, 575)
    this.scrollView:SetData(scrollDatas, false)
end


this.GetQuestEvents = function()
    local events = {}
    local sellouts = {}
    local quests = DataMgr.Player.quests
    if this.questEvents == nil then
        return events
    end
    local len = #this.questEvents
    for i = 1, len do
        local questConfig = this.questEvents[i]
        if questConfig.text == WJWYConst.ShopEventIDName then
            local questData = quests[questConfig.id]
            if questData ~= nil and questData.progress >= questConfig.progress then
                table.insert(sellouts, questConfig)
            else
                table.insert(events, questConfig)
            end
        end
    end
    len = #sellouts
    for i = 1, len do
        table.insert(events, sellouts[i])
    end
    return events
end


this.OnShopRefresh = function(args)
    local questConfig = args[0]
    local questData = DataMgr.Player.quests[questConfig.id]
    if (questData ~= nil and questData.progress >= questConfig.progress) then
        this.SetShopList()
    else
        this.scrollView:Refresh()
    end
end


this.OnClickCharacter = function()
    this.SetMsg()
    LuaMgr.RemoveTimer(TimerConst.SGYShopMsgTime)
    LuaMgr.AddTimer(TimerConst.SGYShopMsgTime, this.SetMsg, 10, -1, true)
end


this.OnBack = function()
    if DataExHelper.CommonActivityCheck(ActivityKey.WJWY) then
        LuaMgr.Back(ActivityKey.WJWY)
    else
        LuaMgr.Back()
    end
end

local data = { bodyPath = "" }

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.scrollView = UIScrollView.New(this.shopsGO)
        LuaMgr.AddClick(this.characterBtn, this.OnClickCharacter)
        this.before_awake()
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        if vm.behaviour.Params.Length > 0 then
            vm.behaviour:UpdateTopBar("", this.OnBack)
        end
        this.before_active()
        LuaMgr.AddUIEventListener(UIEventConst.SGYShopRefresh, this.OnShopRefresh)
        this.SetData()
        this.SetCharacter()
        this.SetShopList()
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.SGYShopMsgTime)
        LuaMgr.RemoveUIEventListener(UIEventConst.SGYShopRefresh, this.OnShopRefresh)
        this.scrollView:Clear(true)
        if (this.spineCharacter ~= nil) then
            this.spineCharacter:Clear()
        end
        this.questEvents = nil
    end,
    before_destroy = function()
        this.spineCharacter = nil
        LuaMgr.RemoveClick(this.characterBtn, this.OnClickCharacter)
        UIScrollView.ClearItem("WJWYShopItemGroup")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)