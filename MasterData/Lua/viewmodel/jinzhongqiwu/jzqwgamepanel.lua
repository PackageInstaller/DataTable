require("ViewModel/JinZhongQiWu/ViewItem/JZQWGamePropsItem")
require("ViewModel/JinZhongQiWu/ViewItem/JZQWGameTextItem")
require("ViewModel/JinZhongQiWu/ViewItem/JZQWGameActivateObjItem")
require("ViewModel/JinZhongQiWu/JZQWGameOpening")
require("ViewModel/JinZhongQiWu/JZQWGameRoleMove")
require("ViewModel/JinZhongQiWu/JZQWGameSceneInteract")
require("ViewModel/JinZhongQiWu/JZQWGameGuide")
require("ViewModel/JinZhongQiWu/JZQWGamePropsBag")
require("ViewModel/JinZhongQiWu/JZQWGameChapterFlow")

local objs = {
    propsItem = {path = "template/PropsItem", type = UITool.GameObject},
    textItem = {path = "template/TextItem", type = UITool.GameObject},
    activateItem = {path = "template/ActivateItem", type = UITool.GameObject},
    sceneBG = {path = "root/ScrollView/Viewport/Content/SceneBG", type = UITool.RawImage},
    decorateObj = {path = "root/ScrollView/Viewport/Content/SceneBG/Decorate", type = UITool.GameObject},
    sceneObjGroup = {path = "root/ScrollView/Viewport/Content/ActivateGroup", type = UITool.Transform},
    dragBehaviour = {path = "root/ScrollView", type = UITool.OnDragBehaviour},
    activateOperateTrans = {path = "root/Middle/ActivateObj", type = UITool.RectTransform},
    talkBubbleLeft = {path = "root/Middle/TalkBubbleLeft", type = UITool.RectTransform},
    talkBubbleLeftLayout = {path = "root/Middle/TalkBubbleLeft", type = UITool.HorizontalLayoutGroup},
    talkBubbleLeftContent = {path = "root/Middle/TalkBubbleLeft/Content", type = UITool.Text},
    talkBubbleRight = {path = "root/Middle/TalkBubbleRight", type = UITool.RectTransform},
    talkBubbleRightLayout = {path = "root/Middle/TalkBubbleRight", type = UITool.HorizontalLayoutGroup},
    talkBubbleRightContent = {path = "root/Middle/TalkBubbleRight/Content", type = UITool.Text},
    talkMask = {path = "root/TalkMask", type = UITool.Button},
    propsOperateGroup = {path = "root/Middle/PropsOperateGroup", type = UITool.RectTransform},
    propsScrollView = {path = "root/Middle/PropsScrollView", type = UITool.GameObject},
    introAnimObj = {path = "root/IntroAnim", type = UITool.GameObject},
    introAnimObj2 = {path = "root/IntroAnim2", type = UITool.GameObject},
    introAnimNameImage = {path = "root/IntroAnim/NameImage", type = UITool.Image},
    introAnimDesc = {path = "root/IntroAnim/Desc", type = UITool.Text},
    introAnimDesc2 = {path = "root/IntroAnim2/Desc", type = UITool.Text},
    introAnimButton = {path = "root/IntroAnim/Button", type = UITool.Button},
    introAnimButton2 = {path = "root/IntroAnim2/Button", type = UITool.Button},
    maleRole = {path = "root/ScrollView/Viewport/Content/MainRoleGroup/Male", type = UITool.Animator},
    femaleRole = {path = "root/ScrollView/Viewport/Content/MainRoleGroup/Female", type = UITool.Animator},
    maleRoleRectTrans = {path = "root/ScrollView/Viewport/Content/MainRoleGroup/Male", type = UITool.RectTransform},
    femaleRoleRectTrans = {path = "root/ScrollView/Viewport/Content/MainRoleGroup/Female", type = UITool.RectTransform},
    leftTipBtn = {path = "root/Left/TipBtn", type = UITool.Button},
    rightTipBtn = {path = "root/Right/TipBtn", type = UITool.Button},
    fadeObj = {path = "root/FadeObj", type = UITool.Animator},
    novelMask = {path = "root/Mask", type = UITool.GameObject},
    chapterJumpTimeBtn = {path = "root/Right/JumpBtn", type = UITool.Button},
    gmPanel = {path = "root/GM", type = UITool.GameObject},
    gmBtn1 = {path = "root/GM/Button1", type = UITool.Button},
    gmBtn2 = {path = "root/GM/Button2", type = UITool.Button}
}

local this = {
    operateTypeNames = {"TypeObjUse", "TypeObjCombine", "TypeObjLook", "TypeObjCancel"},
    activateTypeNames = {"ActivateTalk", "ActivatePick", "ActivateCommit"},

    activateItems = {},

    activateItemCache = {},
    roleOrigenScale = {},
    curWaitTime = 0,
    curChapterJumpWaitTime = 0,
    isTalkTyping = false,
    isInTalkFlow = false,
    isTalkLineTyping = false,
    isChapterJumping = false
}

this.before_awake = function()
    this.roleOrigenScale = this.maleRoleRectTrans.localScale
    this.propsScrollViewUI = UIScrollView.New(this.propsScrollView)
    this.InitInputEvents()
end

this.BatchInitNode = function()
    for i = 1, #this.operateTypeNames do
        local data = {}
        local name = this.operateTypeNames[i]
        data.path = "root/Middle/PropsOperateGroup/" .. name
        data.type = UITool.Button
        objs[name] = data
    end

    for i = 1, #this.activateTypeNames do
        local data = {}
        local name = this.activateTypeNames[i]
        data.path = "root/Middle/ActivateObj/" .. name
        data.type = UITool.Button
        objs[name] = data
    end

    for i = 1, 3 do
        local data = {}
        local name = "Goal" .. i
        data.path = string.format("root/Right/GoalGroup/%s", name)
        data.type = UITool.GameObject
        objs[name] = data

        local data1 = {}
        local name1 = "GoalText" .. i
        data1.path = string.format("root/Right/GoalGroup/%s/GoalText", name)
        data1.type = UITool.Text
        objs[name1] = data1
    end
end

this.before_active = function()
    this.curWaitTime = 0
    this.curChapterJumpWaitTime = 0
    SetActive(this.chapterJumpTimeBtn.gameObject, false)
    SetActive(this.talkMask.gameObject, false)
    this.SetNovelAnimPanel()
    this.InitScene()
    this.RefreshProps(true)
    this.CheckPendingProgressRepair()
    this.RefreshTask()
    this.InitMainRole()
end

JZQWGameOpening.Bind(this)
JZQWGameRoleMove.Bind(this)
JZQWGameSceneInteract.Bind(this)
JZQWGameGuide.Bind(this)
JZQWGamePropsBag.Bind(this)
JZQWGameChapterFlow.Bind(this)


this.OnClickChapterJumpBtn = function()
    if this.isChapterJumping == true then
        return
    end
    local chapterData = JZQWGameData.GetChapterData()
    if this.CheckChapterJumpData(chapterData) == false then
        return
    end
    this.isChapterJumping = true

    local msgs = this.BuildChapterJumpMsgs(chapterData)
    local outputItems, consumeItems = this.BuildChapterJumpProps(chapterData)
    local failCallback = this.FailChapterJump
    local callback = function()
        this.ReportChapterJumpProps(outputItems, consumeItems, failCallback)
    end
    this.ReportActivateObjData(msgs, callback, failCallback)
end

this.CheckChapterJumpData = function(chapterData)
    if chapterData == nil or chapterData.Config == nil or chapterData.LastEvent == nil or chapterData.LastEvent.Config == nil then
        LuaDebug.error("this.OnClickChapterJumpBtn 章节数据异常")
        return false
    end
    return true
end

this.AddChapterJumpMsg = function(msgs, id, typ, state)
    if type(id) == "number" then
        id = tostring(id)
    end
    if type(id) ~= "string" or id == "" or id == "0" then
        return
    end
    local data = {}
    data.Id = id
    data.Typ = typ
    data.State = state
    table.insert(msgs, data)
end

this.BuildChapterJumpMsgs = function(chapterData)
    local msgs = {}
    this.AddChapterJumpMsg(msgs, chapterData.ID, JZQWConst.DataReportType.Chapter, JZQWConst.EventStatus.Finish)

    if type(chapterData.EventList) == "table" then
        for key, value in pairs(chapterData.EventList) do
            if value ~= nil then
                this.AddChapterJumpMsg(msgs, value.ID, JZQWConst.DataReportType.Event, JZQWConst.EventStatus.Finish)
            end
        end
    end

    if this.IsChapterJumpFinalChapter(chapterData) == true then
        return msgs
    end

    this.AddChapterJumpMsg(msgs, chapterData.Config.NextChapter, JZQWConst.DataReportType.Chapter, JZQWConst.EventStatus.Unlock)
    if type(chapterData.LastEvent.Config.NextEvent) == "table" then
        for i = 1, #chapterData.LastEvent.Config.NextEvent do
            this.AddChapterJumpMsg(msgs, chapterData.LastEvent.Config.NextEvent[i], JZQWConst.DataReportType.Event, JZQWConst.EventStatus.Unlock)
        end
    end
    return msgs
end

this.IsChapterJumpFinalChapter = function(chapterData)
    local nextChapter = chapterData.Config.NextChapter
    return tonumber(chapterData.Config.FinalChapter) == 1 or type(nextChapter) ~= "string" or nextChapter == ""
end

this.BuildChapterJumpProps = function(chapterData)
    local outputItems = {}
    local keepItems = {}
    local ownerProps = DataMgr.Player.Adventure.Tools or {}
    this.AddChapterJumpFinalReward(chapterData, ownerProps, outputItems, keepItems)
    local consumeItems = this.BuildChapterJumpConsumeItems(chapterData, ownerProps, keepItems)
    return outputItems, consumeItems
end

this.AddChapterJumpKeepReward = function(item, ownerProps, outputItems, keepItems)
    if item == nil or type(item.id) ~= "string" or item.id == "" then
        return
    end
    keepItems[item.id] = true
    if ownerProps[item.id] == nil or ownerProps[item.id] <= 0 then
        outputItems[item.id] = item.count or 1
    end
end

this.IsChapterJumpFinalCompleteItem = function(chapterData, itemID)
    if type(chapterData.LastEvent.Config.CompleteItem) ~= "table" then
        return false
    end
    for i = 1, #chapterData.LastEvent.Config.CompleteItem do
        local item = chapterData.LastEvent.Config.CompleteItem[i]
        if item ~= nil and item.id == itemID then
            return true
        end
    end
    return false
end

this.AddChapterJumpFinalTalkReward = function(chapterData, ownerProps, outputItems, keepItems)
    if type(chapterData.Config.ObjList) ~= "table" then
        return
    end
    for i = 1, #chapterData.Config.ObjList do
        local objID = chapterData.Config.ObjList[i]
        local objConfig = ConfigMgr.Config.AdventureObjectsMap[objID]
        if objConfig ~= nil and type(objConfig.Param) == "table" then
            for j = 1, #objConfig.Param do
                local talkConfig = ConfigMgr.Config.AdventureNpcTalkMap[objConfig.Param[j]]
                if talkConfig ~= nil and type(talkConfig.Reward) == "table" then
                    local isFinalTalk = false
                    for k = 1, #talkConfig.Reward do
                        local reward = talkConfig.Reward[k]
                        if reward ~= nil and this.IsChapterJumpFinalCompleteItem(chapterData, reward.id) == true then
                            isFinalTalk = true
                            break
                        end
                    end
                    if isFinalTalk == true then
                        for k = 1, #talkConfig.Reward do
                            this.AddChapterJumpKeepReward(talkConfig.Reward[k], ownerProps, outputItems, keepItems)
                        end
                    end
                end
            end
        end
    end
end

this.AddChapterJumpFinalReward = function(chapterData, ownerProps, outputItems, keepItems)
    if chapterData.LastEvent.Status == JZQWConst.EventStatus.Finish or type(chapterData.LastEvent.Config.CompleteItem) ~= "table" then
        return
    end
    for i = 1, #chapterData.LastEvent.Config.CompleteItem do
        this.AddChapterJumpKeepReward(chapterData.LastEvent.Config.CompleteItem[i], ownerProps, outputItems, keepItems)
    end
    this.AddChapterJumpFinalTalkReward(chapterData, ownerProps, outputItems, keepItems)
end

this.BuildChapterJumpConsumeItems = function(chapterData, ownerProps, keepItems)
    local consumeItems = {}
    if type(chapterData.EventList) ~= "table" then
        return consumeItems
    end
    for key, value in pairs(chapterData.EventList) do
        if value ~= nil and value.Config ~= nil then
            this.AddChapterJumpConsumeItems(value.Config.TriggerItem, ownerProps, keepItems, consumeItems)
            this.AddChapterJumpConsumeItems(value.Config.CompleteItem, ownerProps, keepItems, consumeItems)
        end
    end
    return consumeItems
end

this.AddChapterJumpConsumeItems = function(items, ownerProps, keepItems, consumeItems)
    if type(items) ~= "table" then
        return
    end
    for i = 1, #items do
        local item = items[i]
        if item ~= nil and type(item.id) == "string" and item.id ~= "" and keepItems[item.id] ~= true then
            local ownerCount = ownerProps[item.id]
            if ownerCount ~= nil and ownerCount > 0 then
                consumeItems[item.id] = item.count or 1
            end
        end
    end
end

this.ReportChapterJumpProps = function(outputItems, consumeItems, failCallback)
    if next(outputItems) ~= nil or next(consumeItems) ~= nil then
        local itemCallback = function()
            this.RefreshTask()
            this.FinishChapterJump()
        end
        this.ReportPropsData(outputItems, consumeItems, itemCallback, failCallback)
    else
        this.RefreshEventData()
        this.RefreshTask()
        this.FinishChapterJump()
    end
end

this.FinishChapterJump = function()
    this.isChapterJumping = false
    this.StopChapterGuideTimers()
    local chapterData = JZQWGameData.GetChapterData()
    this.PlayChapterEndFlow(chapterData)
end

this.FailChapterJump = function()
    this.isChapterJumping = false
end

this.OnShowChapterJump = function()
    if this.CheckStopChapterGuideTimers() == true then
        return
    end
    if this.chapterJumpTimeBtn == nil or this.chapterJumpTimeBtn.gameObject.activeSelf == true or this.isTalkTyping == true then
        return
    end
    this.curChapterJumpWaitTime = this.curChapterJumpWaitTime + 1
    if this.curChapterJumpWaitTime >= JZQWConst.ChapterJumpWaitTime then
        SetActive(this.chapterJumpTimeBtn.gameObject, true)
    end
end

this.OnTalkBegin = function()
    SetActive(this.chapterJumpTimeBtn.gameObject, false)
    SetActive(this.topBarComp, false)
end

this.OnTalkEnd = function()
    SetActive(this.topBarComp, true)
    if this.chapterJumpTimeBtn == nil then
        return
    end
    local chapterData = JZQWGameData.GetChapterData()
    if this.IsCurChapterFinish(chapterData) == true then
        this.StopChapterGuideTimers()
        return
    end
    if chapterData == nil or chapterData.LastEvent == nil or chapterData.LastEvent.Status == JZQWConst.EventStatus.Finish then
        SetActive(this.chapterJumpTimeBtn.gameObject, false)
        return
    end
    SetActive(this.chapterJumpTimeBtn.gameObject, this.curChapterJumpWaitTime >= JZQWConst.ChapterJumpWaitTime)
end

this.IsCurChapterFinish = function(chapterData)
    chapterData = chapterData or JZQWGameData.GetChapterData()
    return chapterData ~= nil and chapterData.Status == JZQWConst.ChapterStatus.Finish
end

this.HideChapterGuideButtons = function()
    if this.leftTipBtn ~= nil then
        SetActive(this.leftTipBtn.gameObject, false)
    end
    if this.rightTipBtn ~= nil then
        SetActive(this.rightTipBtn.gameObject, false)
    end
    if this.chapterJumpTimeBtn ~= nil then
        SetActive(this.chapterJumpTimeBtn.gameObject, false)
    end
end

this.StopChapterGuideTimers = function()
    LuaMgr.RemoveTimer(TimerConst.JZQWGameTipTimer)
    LuaMgr.RemoveTimer(TimerConst.JZQWShowChapterJump)
    this.HideChapterGuideButtons()
end

this.CheckStopChapterGuideTimers = function()
    if this.IsCurChapterFinish() == true then
        this.StopChapterGuideTimers()
        return true
    end
    return false
end




this.ReportPropsData = function(itemData1, itemData2, callback, failCallback)
    local data = {}
    data.Harvest = itemData1
    data.Consume = itemData2

    local onSucc = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            if failCallback ~= nil then
                failCallback()
            end
            return
        end
        this.RefreshProps(false)
        this.RefreshEventData()
        if callback ~= nil then
            callback()
        end
    end
    ApiMgr.Request("adventure/item", data, true, onSucc, failCallback, true)
end

this.ApplyAdventureFinishMsgs = function(msgs)
    if type(msgs) ~= "table" then
        return
    end
    local adventureData = DataMgr.Player.Adventure
    if adventureData == nil then
        return
    end
    adventureData.Chapters = adventureData.Chapters or {}
    adventureData.EventIds = adventureData.EventIds or {}
    adventureData.NpcIds = adventureData.NpcIds or {}
    adventureData.StoryIds = adventureData.StoryIds or {}

    local nextChapterID = nil
    local refreshChapterIDs = {}
    for i = 1, #msgs do
        local msg = msgs[i]
        if msg ~= nil and type(msg.Id) == "string" and msg.Id ~= "" then
            if msg.Typ == JZQWConst.DataReportType.Chapter then
                adventureData.Chapters[msg.Id] = msg.State
                table.insert(refreshChapterIDs, msg.Id)
                if msg.State == JZQWConst.EventStatus.Unlock then
                    nextChapterID = msg.Id
                end
            elseif msg.Typ == JZQWConst.DataReportType.Event then
                adventureData.EventIds[msg.Id] = msg.State
            elseif msg.Typ == JZQWConst.DataReportType.Npc or msg.Typ == JZQWConst.DataReportType.Scene then
                adventureData.NpcIds[msg.Id] = msg.State
            elseif msg.Typ == JZQWConst.DataReportType.Novel then
                adventureData.StoryIds[msg.Id] = msg.State
            end
        end
    end
    for i = 1, #refreshChapterIDs do
        JZQWGameData.RefreshChapterData(refreshChapterIDs[i])
    end
    if nextChapterID ~= nil then
        adventureData.ChapterId = nextChapterID
    end
end

this.ReportActivateObjData = function(msgs, callback, failCallback)

    local onSucc = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            if failCallback ~= nil then
                failCallback()
            end
            return
        end
        this.ApplyAdventureFinishMsgs(msgs)
        this.RefreshEventData()
        if callback ~= nil then
            callback()
        end
    end
    local data = {}
    data.Msgs = msgs
    ApiMgr.Request("adventure/finish", data, true, onSucc, failCallback, true)
end



this.OnClickGMBtn1 = function()
    this.OnClickChapterJumpBtn()
end

this.OnClickGMBtn2 = function()
    local chapterData = JZQWGameData.GetChapterData()
    local msgs = {}
    local outputItems = {}
    for key, value in pairs(chapterData.EventList) do
        local data = {}
        if value.ID ~= chapterData.LastEvent.ID then
            data.Id = value.ID
            data.Typ = JZQWConst.DataReportType.Event
            data.State = JZQWConst.EventStatus.Finish
            table.insert(msgs, data)
        else

            data.Id = value.ID
            data.Typ = JZQWConst.DataReportType.Event
            data.State = JZQWConst.EventStatus.Unlock
            table.insert(msgs, data)

            for i = 1, #chapterData.LastEvent.Config.TriggerItem do
                local item = chapterData.LastEvent.Config.TriggerItem[i]
                outputItems[item.id] = 1
            end
        end

    end
    this.ReportActivateObjData(msgs)
    this.ReportPropsData(outputItems)
end


this.OnClickBack = function()
    if this.topBarComp.activeSelf == false then
        return
    end
    JZQWData.SetIsChildPanel(true)
    LuaMgr.ShowLuaPanel(UIName.JZQWHomePanel)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.BatchInitNode()
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.operateBtnCallbacks = this.operateBtnCallbacks or {}
        for i = 1, #this.operateTypeNames do
            local index = i
            local name = this.operateTypeNames[i]
            local btn = this[name]
            local callBack = function()
                this.OnClickPropsOperateBtn(index)
            end
            this.operateBtnCallbacks[name] = callBack
            LuaMgr.AddClick(btn, callBack)
        end

        this.activateBtnCallbacks = this.activateBtnCallbacks or {}
        for i = 1, #this.activateTypeNames do
            local index = i
            local name = this.activateTypeNames[i]
            local btn = this[name]
            local callBack = function()
                this.OnClickActivateOperate(index)
            end
            this.activateBtnCallbacks[name] = callBack
            LuaMgr.AddClick(btn, callBack)
        end

        this.IsDebug = LuaMgr.IsDebug()
        SetActive(this.gmPanel, this.IsDebug == true)
        if this.IsDebug == true then
            LuaMgr.AddClick(this.gmBtn1, this.OnClickGMBtn1)
            LuaMgr.AddClick(this.gmBtn2, this.OnClickGMBtn2)
        end

        LuaMgr.AddClick(this.leftTipBtn, this.OnClickLeftTipBtn)
        LuaMgr.AddClick(this.rightTipBtn, this.OnClickRightTipBtn)
        LuaMgr.AddClick(this.introAnimButton, this.OnClickIntroBtn)
        LuaMgr.AddClick(this.introAnimButton2, this.OnClickIntroBtn)
        LuaMgr.AddClick(this.chapterJumpTimeBtn, this.OnClickChapterJumpBtn)
        LuaMgr.AddClick(this.talkMask, this.OnClickTalkMask)
        LuaMgr.AddUIEventListener(UIEventConst.JZQWClickActivateObj, this.OnClickActivateObj)
        LuaMgr.AddUIEventListener(UIEventConst.JZQWTalkBegin, this.OnTalkBegin)
        LuaMgr.AddUIEventListener(UIEventConst.JZQWTalkEnd, this.OnTalkEnd)
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil or vm.behaviour.Params.Length < 1 then
            return
        end
        if this.topBarComp == nil then
            local topBarObj = UnityEngine.GameObject.Find("UIRoot(Clone)/Fixed")
            this.topBarComp = topBarObj
        end
        LuaMgr.AddTimer(TimerConst.JZQWGameTipTimer, this.OnTipTimer, 1, -1, true)
        LuaMgr.AddTimer(TimerConst.JZQWShowChapterJump, this.OnShowChapterJump, 1, -1, true)
        local paramsData = vm.behaviour.Params[0]
        this.sceneID = paramsData.SceneID
        vm.behaviour:UpdateTopBar("", this.OnClickBack)
        this.before_active()
        this.CheckStopChapterGuideTimers()
    end,
    before_deactive = function(vm)
        if this.talkBubbleTextSeq ~= nil then
            this.talkBubbleTextSeq:Kill(false)
            this.talkBubbleTextSeq = nil
        end
        this.isTalkTyping = false
        this.isInTalkFlow = false
        this.isTalkLineTyping = false
        SetActive(this.talkMask.gameObject, false)
        this.RecycleAllActivateObj()
        this.ClearPropsScrollItems()
        LuaMgr.RemoveTimer(TimerConst.JZQWGameTipTimer)
        LuaMgr.RemoveTimer(TimerConst.JZQWShowChapterJump)
        UIScrollView.ClearItem("JZQWGamePropsItem")
        UIListView.ClearItem("JZQWGameTextItem")
    end,
    before_destroy = function()
        if this.talkBubbleTextSeq ~= nil then
            this.talkBubbleTextSeq:Kill(false)
            this.talkBubbleTextSeq = nil
        end
        this.isTalkTyping = false
        this.isInTalkFlow = false
        this.isTalkLineTyping = false
        SetActive(this.talkMask.gameObject, false)
        this.ClearPropsScrollItems()
        LuaMgr.RemoveClick(this.leftTipBtn, this.OnClickLeftTipBtn)
        LuaMgr.RemoveClick(this.rightTipBtn, this.OnClickRightTipBtn)
        LuaMgr.RemoveClick(this.introAnimButton, this.OnClickIntroBtn)
        LuaMgr.RemoveClick(this.introAnimButton2, this.OnClickIntroBtn)
        LuaMgr.RemoveClick(this.chapterJumpTimeBtn, this.OnClickChapterJumpBtn)
        LuaMgr.RemoveClick(this.talkMask, this.OnClickTalkMask)
        for i = 1, #this.operateTypeNames do
            local name = this.operateTypeNames[i]
            local btn = this[name]
            local callBack = this.operateBtnCallbacks and this.operateBtnCallbacks[name]
            if btn ~= nil and callBack ~= nil then
                LuaMgr.RemoveClick(btn, callBack)
            end
        end

        for i = 1, #this.activateTypeNames do
            local name = this.activateTypeNames[i]
            local btn = this[name]
            local callBack = this.activateBtnCallbacks and this.activateBtnCallbacks[name]
            if btn ~= nil and callBack ~= nil then
                LuaMgr.RemoveClick(btn, callBack)
            end
        end

        if this.IsDebug == true then
            LuaMgr.RemoveClick(this.gmBtn1, this.OnClickGMBtn1)
            LuaMgr.RemoveClick(this.gmBtn2, this.OnClickGMBtn2)
        end
        this.operateBtnCallbacks = nil
        this.activateBtnCallbacks = nil
        LuaMgr.RemoveUIEventListener(UIEventConst.JZQWClickActivateObj, this.OnClickActivateObj)
        LuaMgr.RemoveUIEventListener(UIEventConst.JZQWTalkBegin, this.OnTalkBegin)
        LuaMgr.RemoveUIEventListener(UIEventConst.JZQWTalkEnd, this.OnTalkEnd)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)