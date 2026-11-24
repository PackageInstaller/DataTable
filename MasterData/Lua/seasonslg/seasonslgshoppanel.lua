require("SeasonSLG/SeasonSLGShopItemGroup")
require("SeasonSLG/SeasonSLGShopItemGroup2")

local this = {
    msgList = {
        "LangGlobalLan_LangGlobal_name_34243",
        "LangGlobalLan_LangGlobal_name_34244",
        "LangGlobalLan_LangGlobal_name_34245",
        "LangGlobalLan_LangGlobal_name_34246",
        "LangGlobalLan_LangGlobal_name_34247",
    },
    msgList2 = {
        "LangGlobalLan_LangGlobal_name_35162",
        "LangGlobalLan_LangGlobal_name_35163",
        "LangGlobalLan_LangGlobal_name_35164",
        "LangGlobalLan_LangGlobal_name_35165",
        "LangGlobalLan_LangGlobal_name_35166",
    },
    msgIndices = { 0, 0 },
    curType = nil,
    scrollView = nil,
    scrollView2 = nil,
    questEvents = nil,
    questEvents2 = nil,
    shopItem = nil,
    shopItem2 = nil,
}

local objs = {
    shopItem = { path = "template/ShopItem", type = UITool.GameObject },
    shopItem2 = { path = "template/ShopItem2", type = UITool.GameObject },
    shopItemGroup = { path = "template/ShopItemGroup", type = UITool.GameObject },
    box1 = { path = "root/Middle/Box1", type = UITool.GameObject },
    box2 = { path = "root/Middle/Box2", type = UITool.GameObject },
    btnTypeBg = { path = "root/Middle/btnBg", type = UITool.GameObject },
    btnType1 = { path = "root/Middle/btnBg/btnType1", type = UITool.Button },
    btnType1UnSelected = { path = "root/Middle/btnBg/btnType1/ImgUnSelected", type = UITool.GameObject },
    btnType1Selected = { path = "root/Middle/btnBg/btnType1/ImgSelected", type = UITool.GameObject },
    btnType2 = { path = "root/Middle/btnBg/btnType2", type = UITool.Button },
    btnType2UnSelected = { path = "root/Middle/btnBg/btnType2/ImgUnSelected", type = UITool.GameObject },
    btnType2Selected = { path = "root/Middle/btnBg/btnType2/ImgSelected", type = UITool.GameObject },
    shopsGO = { path = "root/Middle/Box1/GroupGoods/Shops", type = UITool.GameObject },
    characterTF = { path = "root/Middle/Box1/GroupChacter/Character", type = UITool.RectTransform },
    characterDrawing = { path = "root/Middle/Box1/GroupChacter/Character/Body", type = UITool.DrawingAdjustTool },
    spineCharacter = { path = "root/Middle/Box1/GroupChacter/Character/Body", type = UITool.UISpineCharacter },
    characterBtn = { path = "root/Middle/Box1/GroupChacter/Character/Click", type = UITool.Button },
    msgContent = { path = "root/Middle/Box1/GroupChacter/Msg/ScrollView/Viewport/Content", type = UITool.Text },
    msgRect = { path = "root/Middle/Box1/GroupChacter/Msg", type = UITool.RectTransform },
    charaterGroupRect = { path = "root/Middle/Box1/GroupChacter", type = UITool.RectTransform },
    goosGroupRect = { path = "root/Middle/Box1/GroupGoods", type = UITool.RectTransform },
    shopsGO2 = { path = "root/Middle/Box2/GroupGoods/Shops", type = UITool.GameObject },
    characterTF2 = { path = "root/Middle/Box2/GroupChacter/Character", type = UITool.RectTransform },
    characterDrawing2 = { path = "root/Middle/Box2/GroupChacter/Character/Body", type = UITool.DrawingAdjustTool },
    spineCharacter2 = { path = "root/Middle/Box2/GroupChacter/Character/Body", type = UITool.UISpineCharacter },
    characterBtn2 = { path = "root/Middle/Box2/GroupChacter/Character/Click", type = UITool.Button },
    msgContent2 = { path = "root/Middle/Box2/GroupChacter/Msg/ScrollView/Viewport/Content", type = UITool.Text },
    msgRect2 = { path = "root/Middle/Box2/GroupChacter/Msg", type = UITool.RectTransform },
    charaterGroupRect2 = { path = "root/Middle/Box2/GroupChacter", type = UITool.RectTransform },
    goosGroupRect2 = { path = "root/Middle/Box2/GroupGoods", type = UITool.RectTransform }
}

this.before_awake = function()

end

this.before_active = function()
    local screenWidth = LuaMgr.ScreenWidth()
    local screenHeight = LuaMgr.ScreenHeight()
    local isWide = (screenWidth / screenHeight >= 21 / 9)
    local goodsOffset = isWide and Vector2(-50, 0) or Vector2.zero
    local charOffset = isWide and Vector2(50, 0) or Vector2(-50, 0)
    local msgOffset = isWide and Vector2(452, -264) or Vector2(502, -264)

    local rectPairs = {
        { this.goosGroupRect,  this.charaterGroupRect,  this.msgRect },
        { this.goosGroupRect2, this.charaterGroupRect2, this.msgRect2 }
    }
    for _, pair in ipairs(rectPairs) do
        if pair[1] ~= nil then pair[1].anchoredPosition = goodsOffset end
        if pair[2] ~= nil then pair[2].anchoredPosition = charOffset end
        if pair[3] ~= nil then pair[3].anchoredPosition = msgOffset end
    end
end


this.SetData = function()
    this.questEvents = DataExHelper.Check_ConfigQuestEventByText("JYSHShop")
    this.questEvents2 = DataExHelper.Check_ConfigQuestEventByText("YLWXShop")
    if this.questEvents2 == nil or #this.questEvents2 == 0 then
        this.questEvents2 = this.questEvents
    end
    LuaMgr.AddTimer(TimerConst.SGYShopMsgTime, this.OnTimerMsg, 10, -1, true)
end


this.SetCharacter = function(tabIndex)
    tabIndex = tabIndex or 1
    local spine = (tabIndex == 1) and this.spineCharacter or this.spineCharacter2
    local drawing = (tabIndex == 1) and this.characterDrawing or this.characterDrawing2
    if spine == nil then return end

    local characterId = (tabIndex == 1) and "A0184" or "W0185"
    local path = HeroManager.SetCharacterDrawing(spine, characterId, characterId .. "001")
    if path ~= "" and drawing ~= nil then
        drawing.Sprite = path
    end
end


this.SetMsg = function(tabIndex)
    tabIndex = tabIndex or this.curType or 1
    local msgContent = (tabIndex == 1) and this.msgContent or this.msgContent2
    if msgContent == nil then return end

    local msgList = (tabIndex == 1) and this.msgList or this.msgList2
    local len = #msgList
    local lastIndex = this.msgIndices[tabIndex] or 0
    local index = math.random(1, len)
    if (lastIndex == index) then
        index = (index >= len) and (index - 1) or (index + 1)
    end
    this.msgIndices[tabIndex] = index
    msgContent.text = LuaMgr.GetLangText(msgList[index])
end


this.OnTimerMsg = function()
    this.SetMsg(this.curType)
end


this.GetQuestEvents = function(tabIndex)
    tabIndex = tabIndex or 1
    local sourceEvents = (tabIndex == 1) and this.questEvents or (this.questEvents2 or this.questEvents)
    if sourceEvents == nil then return {} end

    local targetText = (tabIndex == 1) and "JYSHShop" or "YLWXShop"
    local events = {}
    local sellouts = {}
    local quests = DataMgr.Player.quests

    for i = 1, #sourceEvents do
        local questConfig = sourceEvents[i]
        if questConfig.text == targetText or questConfig.text == "YLWXShop" then
            local questData = quests[questConfig.id]
            if questData ~= nil and questData.progress >= questConfig.progress then
                table.insert(sellouts, questConfig)
            else
                table.insert(events, questConfig)
            end
        end
    end
    for i = 1, #sellouts do
        table.insert(events, sellouts[i])
    end
    return events
end


this.SetShopList = function(tabIndex)
    tabIndex = tabIndex or 1
    local scrollView = (tabIndex == 1) and this.scrollView or this.scrollView2
    if scrollView == nil then return end

    local targetItem = (tabIndex == 2) and this.shopItem2 or this.shopItem
    local targetLua = (tabIndex == 2) and "SeasonSLGShopItemGroup2" or "SeasonSLGShopItemGroup"
    local events = this.GetQuestEvents(tabIndex)
    local len = #events
    local index = 0
    local scrollDatas = {}

    scrollView:Clear(false)
    while index < len do
        local itemLen = (index + 4 > len) and (len - index) or 4
        local groupData = { item = targetItem, list = {} }
        for i = 1, itemLen do
            if i + index <= len then
                table.insert(groupData.list, events[i + index])
                groupData.numIndex = i + index
            end
        end
        index = index + itemLen
        local scrollData = UIScrollData.GetData(this.shopItemGroup, targetLua, 815, 264, groupData)
        table.insert(scrollDatas, scrollData)
    end
    scrollView:SetParams(815, 575)
    scrollView:SetData(scrollDatas, false)
end


this.RefreshAllShopList = function()
    this.SetShopList(1)
    this.SetShopList(2)
end


this.OnShopRefresh = function(args)
    local questConfig = args[0]
    local questData = DataMgr.Player.quests[questConfig.id]
    if (questData ~= nil and questData.progress >= questConfig.progress) then
        this.RefreshAllShopList()
    else
        if this.scrollView ~= nil then this.scrollView:Refresh() end
        if this.scrollView2 ~= nil then this.scrollView2:Refresh() end
    end
end


this.OnClickCharacterFunc = function(tabIndex)
    this.SetMsg(tabIndex)
    LuaMgr.RemoveTimer(TimerConst.SGYShopMsgTime)
    LuaMgr.AddTimer(TimerConst.SGYShopMsgTime, this.OnTimerMsg, 10, -1, true)
end

this.OnClickCharacter1 = function() this.OnClickCharacterFunc(1) end
this.OnClickCharacter2 = function() this.OnClickCharacterFunc(2) end
this.OnClickCharacter = this.OnClickCharacter1


this.OnClickType1 = function() this.SwitchType(1) end
this.OnClickType2 = function() this.SwitchType(2) end


this.SwitchType = function(curType)
    if (curType == this.curType) then return end
    this.curType = curType
    local isType1 = (curType == 1)
    if this.box1 ~= nil then SetActive(this.box1, isType1) end
    if this.box2 ~= nil then SetActive(this.box2, not isType1) end
    if this.btnType1UnSelected ~= nil then SetActive(this.btnType1UnSelected, isType1) end
    if this.btnType1Selected ~= nil then SetActive(this.btnType1Selected, not isType1) end
    if this.btnType2UnSelected ~= nil then SetActive(this.btnType2UnSelected, not isType1) end
    if this.btnType2Selected ~= nil then SetActive(this.btnType2Selected, isType1) end


    this.SetMsg(curType)
    local topbarText = LuaMgr.GetLangText(this.GetTopbarTextKey(curType))
    this.topBarComp.BackName:Set(topbarText)
end


this.OnBack = function()
    if DataExHelper.CommonActivityCheck(ActivityKey.SeasonSLG) then
        LuaMgr.Back(ActivityKey.SeasonSLG)
    else
        LuaMgr.Back()
    end
end

this.RefreshPageTypeKey = function()
    this.topbarTextKey = this.GetTopbarTextKey(this.curType)
    local func = function()
        if this.topBarComp and this.topbarTextKey ~= nil then
            local text = LuaMgr.GetLangText(this.topbarTextKey)
            this.topBarComp.BackName:Set(text)
        end
    end
    if this.tween ~= nil then
        this.tween:Kill()
        this.tween = nil
    end
    this.tween = DOTWeen:Sequence()
    this.tween:AppendInterval(0.2):OnComplete(func)
end

this.GetTopbarTextKey = function(curType)
    if curType == 1 then
        return "LangGlobalLan_LangGlobal_name_34251"
    elseif curType == 2 then
        return "LangGlobalLan_LangGlobal_name_35167"
    end
    return ""
end

local data = { bodyPath = "" }

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.scrollView = UIScrollView.New(this.shopsGO)
        if this.shopsGO2 ~= nil then
            this.scrollView2 = UIScrollView.New(this.shopsGO2)
        end
        LuaMgr.AddClick(this.characterBtn, this.OnClickCharacter1)
        if this.characterBtn2 ~= nil then
            LuaMgr.AddClick(this.characterBtn2, this.OnClickCharacter2)
        end
        if this.btnType1 ~= nil then
            LuaMgr.AddClick(this.btnType1, this.OnClickType1)
        end
        if this.btnType2 ~= nil then
            LuaMgr.AddClick(this.btnType2, this.OnClickType2)
        end
        this.before_awake()
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        if vm.behaviour.Params.Length > 0 then
            vm.behaviour:UpdateTopBar("", this.OnBack)
        end
        if this.topBarComp == nil then
            local topBarObj = UnityEngine.GameObject.Find("UIRoot(Clone)/Fixed/TopBarPanel(Clone)")
            if (topBarObj ~= nil) then
                this.topBarComp = topBarObj:GetComponent("TopBarViewModel")
            end
        end
        this.before_active()
        LuaMgr.AddUIEventListener(UIEventConst.SGYShopRefresh, this.OnShopRefresh)
        this.SetData()
        if DataExHelper.GetDataExByTag(ActivityKey.YLWX) ~= nil and DataExHelper.CommonActivityCheck(ActivityKey.YLWX) then
            SetActive(this.btnTypeBg, true)
        else
            SetActive(this.btnTypeBg, false)
        end
        this.SetCharacter(1)
        this.SetCharacter(2)
        this.RefreshAllShopList()
        if vm.behaviour.Params.Length > 0 then
            local param = tonumber(vm.behaviour.Params[0]) or 1
            this.SwitchType(param)
        else
            if (this.btnTypeBg.activeSelf) then



                this.SwitchType(2)
            else
                this.SwitchType(1)
            end
        end
        this.RefreshPageTypeKey()
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.SGYShopMsgTime)
        LuaMgr.RemoveUIEventListener(UIEventConst.SGYShopRefresh, this.OnShopRefresh)
        if this.scrollView ~= nil then
            this.scrollView:Clear(true)
        end
        if this.scrollView2 ~= nil then
            this.scrollView2:Clear(true)
        end
        if (this.spineCharacter ~= nil) then
            this.spineCharacter:Clear()
        end
        if (this.spineCharacter2 ~= nil) then
            this.spineCharacter2:Clear()
        end
        this.questEvents = nil
        this.questEvents2 = nil
        if this.tween ~= nil then
            this.tween:Kill()
            this.tween = nil
        end
    end,
    before_destroy = function()
        this.spineCharacter = nil
        this.spineCharacter2 = nil
        LuaMgr.RemoveClick(this.characterBtn, this.OnClickCharacter1)
        if this.characterBtn2 ~= nil then
            LuaMgr.RemoveClick(this.characterBtn2, this.OnClickCharacter2)
        end
        if this.btnType1 ~= nil then
            LuaMgr.RemoveClick(this.btnType1, this.OnClickType1)
        end
        if this.btnType2 ~= nil then
            LuaMgr.RemoveClick(this.btnType2, this.OnClickType2)
        end
        UIScrollView.ClearItem("SeasonSLGShopItemGroup")
        UIScrollView.ClearItem("SeasonSLGShopItemGroup2")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)