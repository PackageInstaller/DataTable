require("ViewModel/JinZhongQiWu/ViewItem/JZQWHomePointItem")
local objs = {
    rootAnim = {path = "root", type = UITool.Animator},
    Viewport = {path = "root/BGScrollView/Viewport", type = UITool.RectTransform},
    Content = {path = "root/BGScrollView/Viewport/Content", type = UITool.RectTransform},
    bgNormal = {path = "root/BGScrollView/Viewport/Content/BgNormal", type = UITool.GameObject},
    pointNovel = {path = "root/BGScrollView/Viewport/Content/BgNormal/PointNovel", type = UITool.GameObject},
    pointDungeonRepeat = {path = "root/BGScrollView/Viewport/Content/BgNormal/PointDungeon1", type = UITool.GameObject},
    pointDungeonNormal = {path = "root/BGScrollView/Viewport/Content/BgNormal/PointDungeon3", type = UITool.GameObject},
    pointDungeonHard = {path = "root/BGScrollView/Viewport/Content/BgNormal/PointDungeon2", type = UITool.GameObject},
    smallPeopleNovel = {path = "root/BGScrollView/Viewport/Content/BgNormal/People1", type = UITool.GameObject},
    smallPeopleDungeon = {path = "root/BGScrollView/Viewport/Content/BgNormal/People3", type = UITool.GameObject},
    bgGame = {path = "root/BGScrollView/Viewport/Content/BgGame", type = UITool.GameObject},
    downTimeText = {path = "root/Middle/DownTime/DownTimeText", type = UITool.Text},
    collectText = {path = "root/Middle/CollectBtn/CollectText", type = UITool.Text},
    dungeonToggle = {path = "root/Middle/ToggleGroup/DungeonToggle", type = UITool.Toggle},
    novelToggle = {path = "root/Middle/ToggleGroup/NovelToggle", type = UITool.Toggle},
    gameToggle = {path = "root/Middle/ToggleGroup/GameToggle", type = UITool.Toggle},
    dungeonToggleEff = {path = "root/Middle/ToggleGroup/DungeonToggle/_Arrow/FX_select", type = UITool.GameObject},
    novelToggleEff = {path = "root/Middle/ToggleGroup/NovelToggle/_Arrow/FX_select", type = UITool.GameObject},
    gameToggleEff = {path = "root/Middle/ToggleGroup/GameToggle/_Arrow/FX_select", type = UITool.GameObject},
    dungeonToggleArrow = {path = "root/Middle/ToggleGroup/DungeonToggle/_Arrow", type = UITool.GameObject},
    novelToggleArrow = {path = "root/Middle/ToggleGroup/NovelToggle/_Arrow", type = UITool.GameObject},
    gameToggleArrow = {path = "root/Middle/ToggleGroup/GameToggle/_Arrow", type = UITool.GameObject},
    recollectionBtn = {path = "root/Right/RecollectionBtn", type = UITool.Button},
    gameTaskBtn = {path = "root/Right/GameTaskBtn", type = UITool.Button},
    recollectionTitleText = {path = "root/Right/RecollectionBtn/TitleText", type = UITool.Text},
    passBtn = {path = "root/Left/PassBtn", type = UITool.Button},
    shopBtn = {path = "root/Left/ShopBtn", type = UITool.Button},
    introAnimGroup = {path = "root/IntroAnimGroup", type = UITool.GameObject},
    bgScrollViewAnim = {path = "root/BGScrollView", type = UITool.Animator}
}

local this = {
    gamePointCount = 5,

    pointItemDic = {},

    toggleEffectDic = {},

    toggleParticle = {}
}

this.before_awake = function()
    this.InitPointItems()
    RedMgr.Singleton:RegisterViewModel(UIName.JZQWHomePanel)
end

this.before_active = function()
    local curPageType = JZQWData.GetHomeSelectPageType()
    if curPageType == nil then
        this.dungeonToggle.isOn = true
    end
    this.ChangePage(curPageType or JZQWConst.PageType.Dungeon)
    this.downTimeText.text = JZQWData.GetRemainTimeStr()
    this.OnUpdateMedalCollect()
    JZQWData.CheckRedPoint()
end

this.BatchInitNode = function()
    for i = 1, this.gamePointCount do
        local name = "PointGame" .. i
        local path = "root/BGScrollView/Viewport/Content/BgGame/PointGame/" .. name
        objs[name] = {path = path, type = UITool.GameObject}
    end
end

this.InitPointItems = function()
    local novelPoint = JZQWHomePointItem.New(this.pointNovel)
    local dungeonPoint1 = JZQWHomePointItem.New(this.pointDungeonRepeat)
    local dungeonPoint2 = JZQWHomePointItem.New(this.pointDungeonNormal)
    local dungeonPoint3 = JZQWHomePointItem.New(this.pointDungeonHard)
    this.pointItemDic[JZQWConst.PageType.Novel] = {novelPoint}
    this.pointItemDic[JZQWConst.PageType.Dungeon] = {dungeonPoint1, dungeonPoint2, dungeonPoint3}
    this.pointItemDic[JZQWConst.PageType.Game] = {}
    for i = 1, this.gamePointCount do
        local name = "PointGame" .. i
        local obj = this[name]
        table.insert(this.pointItemDic[JZQWConst.PageType.Game], JZQWHomePointItem.New(obj))
    end
    this.toggleEffectDic[JZQWConst.PageType.Novel] = this.novelToggleArrow
    this.toggleEffectDic[JZQWConst.PageType.Dungeon] = this.dungeonToggleArrow
    this.toggleEffectDic[JZQWConst.PageType.Game] = this.gameToggleArrow

    this.toggleParticle[JZQWConst.PageType.Novel] = this.dungeonToggleEff
    this.toggleParticle[JZQWConst.PageType.Dungeon] = this.novelToggleEff
    this.toggleParticle[JZQWConst.PageType.Game] = this.gameToggleEff
end



this.ChangePage = function(type)
    local lastPageType = this.curPageType
    this.curPageType = type
    JZQWData.SetHomeSelectPageType(this.curPageType)
    SetActive(this.pointNovel, this.curPageType == JZQWConst.PageType.Novel)
    SetActive(this.pointDungeonRepeat, this.curPageType == JZQWConst.PageType.Dungeon)
    SetActive(this.pointDungeonNormal, this.curPageType == JZQWConst.PageType.Dungeon)
    SetActive(this.pointDungeonHard, this.curPageType == JZQWConst.PageType.Dungeon)
    SetActive(this.gameTaskBtn.gameObject, this.curPageType == JZQWConst.PageType.Game)
    SetActive(this.smallPeopleNovel, this.curPageType == JZQWConst.PageType.Novel)
    SetActive(this.smallPeopleDungeon, this.curPageType == JZQWConst.PageType.Dungeon)
    if this.curPageType == JZQWConst.PageType.Novel then
        this.RefreshNovelPage()
    elseif this.curPageType == JZQWConst.PageType.Dungeon then
        this.RefreshDungeonPage()
    else
        this.RefreshGamePage()
    end
    if lastPageType == JZQWConst.PageType.Game and type ~= JZQWConst.PageType.Game then
        this.bgScrollViewAnim:Play("ani_JZQWHomePanel_BGScrollView_BtoA")
    elseif lastPageType ~= JZQWConst.PageType.Game and type == JZQWConst.PageType.Game then
        this.bgScrollViewAnim:Play("ani_JZQWHomePanel_BGScrollView_AtoB")
    elseif lastPageType == type and type == JZQWConst.PageType.Game then
        this.bgScrollViewAnim:Play("ani_JZQWHomePanel_BGScrollView_AtoB")
    else
        this.bgScrollViewAnim:Play("ani_JZQWHomePanel_BGScrollView_BtoA")
    end
    for _, pointItems in pairs(this.pointItemDic) do
        for index = 1, #pointItems do
            local item = pointItems[index]
            SetActive(item.gameObject, false)
        end
    end
    if this.showPointTweens ~= nil then
        for i = 1, #this.showPointTweens do
            this.showPointTweens[i]:Kill()
        end
        this.showPointTweens = nil
    end
    this.showPointTweens = {}
    local showInterval = 0.3
    for i = 1, #this.pointItemDic[type] do
        local item = this.pointItemDic[type][i]
        if item.data ~= nil then
            local callBack = function()
                SetActive(item.gameObject, this.curPageType ~= JZQWConst.PageType.Game or item.data.Status == JZQWConst.SceneStatus.UnlockShow)
            end
            local tween = DOTWeen:Sequence()
            tween:AppendInterval((i - 1) * showInterval):OnComplete(callBack)
            table.insert(this.showPointTweens, tween)
        end
    end
end

this.RefreshNovelPage = function()
    local finishDatas, allDatas = JZQWData.GetAllNovelDatas()
    local maxCount = JZQWData.GetRecollectionCount(this.curPageType)
    local textLan = LuaMgr.GetLangText(JZQWConst.TextLan.TextLan2)
    this.recollectionTitleText.text = string.format(textLan, #finishDatas, maxCount)

    local pointItem = this.pointItemDic[JZQWConst.PageType.Novel][1]
    this.RefreshPointItem(allDatas, pointItem)
end

this.RefreshDungeonPage = function()
    local repeatDatas, allRepeatDatas = JZQWData.GetDungeonDatas(JZQWConst.EventType.Repeat)
    local mainLineDatas, allMainLineDatas = JZQWData.GetDungeonDatas(JZQWConst.EventType.MainLine)
    local hardDatas, allHardDatas = JZQWData.GetDungeonDatas(JZQWConst.EventType.Hard)

    local finishCount = #repeatDatas + #mainLineDatas + #hardDatas
    local maxCount = JZQWData.GetRecollectionCount(this.curPageType)
    local textLan = LuaMgr.GetLangText(JZQWConst.TextLan.TextLan1)
    this.recollectionTitleText.text = string.format(textLan, finishCount, maxCount)
    this.RefreshPointItem(allRepeatDatas, this.pointItemDic[JZQWConst.PageType.Dungeon][1])
    this.RefreshPointItem(allMainLineDatas, this.pointItemDic[JZQWConst.PageType.Dungeon][2])
    this.RefreshPointItem(allHardDatas, this.pointItemDic[JZQWConst.PageType.Dungeon][3])
end

this.RefreshGamePage = function()
    local allDatas, maxCount = JZQWData.GetOwnerNpcDatas()
    local textLan = LuaMgr.GetLangText(JZQWConst.TextLan.TextLan3)
    local count = 0
    for k, v in pairs(allDatas) do
        for k1, v1 in pairs(v.DescList) do
            count = count + 1
        end
    end
    this.recollectionTitleText.text = string.format(textLan, count, maxCount)
    local pointItems = this.pointItemDic[this.curPageType]
    local allSceneData = JZQWGameData.GetAllSceneDatas()
    local redNum = 0
    for i = 1, #pointItems do
        local item = pointItems[i]
        local sceneData = allSceneData[i]
        SetActive(item.gameObject, sceneData ~= nil)
        if sceneData ~= nil then
            local redId = string.format("%s_%s", JZQWConst.RedPoint.Game, sceneData.Config.Id)
            local data = sceneData
            data.OnClickIntroBtn = this.OnClickIntroBtn
            data.Name = LuaMgr.GetLangText(sceneData.Config.NameLan)
            data.IsGamePoint = true
            item:SetRedID(redId)
            item:SetData(data)
            SetActive(item.gameObject, data.Status == JZQWConst.SceneStatus.UnlockShow)
            if data.Status == JZQWConst.SceneStatus.UnlockShow then
                if data.CanIntro == true and RedMgr.Singleton:CheckRedCondition(redId) then
                    redNum = 1
                end
                RedMgr.Singleton:UpdateClientRedData(redId, redNum)
                RedMgr.Singleton:SetRedState(redId, redNum)
                this.SetMapPos(item)
            else
                RedMgr.Singleton:UpdateClientRedData(redId, 0)
                RedMgr.Singleton:SetRedState(redId, 0)
            end
        end
    end
end

this.GetMapTargetTransform = function(target)
    if target == nil then
        return nil
    end

    if type(target) == "number" then
        local pointItems = this.pointItemDic[this.curPageType]
        local item = pointItems ~= nil and pointItems[target] or nil
        return item ~= nil and item.transform or nil
    end

    if target.transform ~= nil then
        return target.transform
    end
    if target.gameObject ~= nil and target.gameObject.transform ~= nil then
        return target.gameObject.transform
    end

    return target
end

this.GetClampedMapAnchoredX = function(tar)
    local viewportWidth = this.Viewport.rect.width
    local contentWidth = this.Content.rect.width
    local contentPivotX = this.Content.pivot.x

    local targetLocalPos = this.Content:InverseTransformPoint(tar.position)
    local targetContentX = targetLocalPos.x

    local targetAnchoredX = viewportWidth * 0.5 - targetContentX

    if contentWidth <= viewportWidth then
        return (viewportWidth - contentWidth) * 0.5 + contentWidth * contentPivotX
    end

    local minX = viewportWidth - contentWidth * (1 - contentPivotX)
    local maxX = contentWidth * contentPivotX

    if targetAnchoredX < minX then
        targetAnchoredX = minX
    elseif targetAnchoredX > maxX then
        targetAnchoredX = maxX
    end

    return targetAnchoredX
end

this.SetMapPos = function(target, bAnim)
    local tar = this.GetMapTargetTransform(target)
    if tar == nil or this.Viewport == nil or this.Content == nil then
        return
    end

    local targetX = this.GetClampedMapAnchoredX(tar)
    local targetPos = Vector2(targetX, this.Content.anchoredPosition.y)

    if bAnim then
        if this.tweener2 ~= nil then
            this.tweener2:Kill()
            this.tweener2 = nil
        end
        this.tweener2 = DOTWeen.To(function() return this.Content.anchoredPosition end, function(value)
            this.Content.anchoredPosition = value
        end, targetPos, 0.5):SetEase(Ease.Linear)
    else
        this.Content.anchoredPosition = targetPos
    end
end



this.RefreshPointItem = function(allDatas, pointItem)
    local lastUnlockData = nil
    local index = 0
    for i = 1, #allDatas do
        local data = allDatas[i]
        if data.Status == CommonRewardItem.Status.None then
            lastUnlockData = data
            index = i
            break
        end
    end
    if lastUnlockData ~= nil then
        local data = lastUnlockData
        data.OnClickIntroBtn = this.OnClickIntroBtn
        pointItem:SetData(data)
        pointItem:RefreshPos()
        this.SetMapPos(pointItem)
    else
        pointItem:Clear()
    end
end


this.DestroyPointItems = function()
    for _, pointItems in pairs(this.pointItemDic) do
        for i = 1, #pointItems do
            pointItems[i]:Destroy()
        end
    end
    this.pointItemDic = {}
end

this.OnClickDungeonToggle = function(value)
    if value == true then
        this.ChangePage(JZQWConst.PageType.Dungeon)
    end
    SetActive(this.toggleEffectDic[JZQWConst.PageType.Dungeon], value == true)
end

this.OnClickNovelToggle = function(value)
    if value == true then
        this.ChangePage(JZQWConst.PageType.Novel)
    end
    SetActive(this.toggleEffectDic[JZQWConst.PageType.Novel], value == true)
end

this.OnClickGameToggle = function(value)
    if value == true then
        this.ChangePage(JZQWConst.PageType.Game)
    end
    SetActive(this.toggleEffectDic[JZQWConst.PageType.Game], value == true)
end

this.OnClickRecollectionBtn = function()
    local data = {}
    data.CurPageType = this.curPageType
    LuaMgr.ShowLuaPanel(UIName.JZQWRecollectionPopup, data)
end

this.OnClickGameTaskBtn = function()
    if JZQWData.CheckActivityRunning() == false then
        return
    end
    LuaMgr.ShowLuaPanel(UIName.JZQWGameTaskPopup)
end

this.OnClickPassBtn = function()
    if JZQWData.CheckActivityRunning() == false then
        return
    end
    JZQWData.SetIsChildPanel(true)
    local data = {}
    data.medalActivityID = JZQWConst.MedalActivityID
    data.medalColor = "#3d6053"
    data.medalImgKey = "ui_hd_ty_dtyl_bt_jzqw"
    data.bgmPath = "Assets/_BundleResources/Audio/Bgm/jinzhongqiwu.mp3"
    LuaMgr.ShowLuaPanel(UIName.PassesMain2ViewModel, data)
end

this.OnClickShopBtn = function()
    if JZQWData.CheckActivityRunning() == false then
        return
    end
    JZQWData.SetIsChildPanel(true)
    LuaMgr.ShowLuaPanel(UIName.JZQWShopPanel)
end


this.OnClickIntroBtn = function(item)
    if JZQWData.CheckActivityRunning() == false then
        return
    end
    JZQWData.SetIsChildPanel(true)
    if this.curPageType == JZQWConst.PageType.Game then
        if item.data.IsUnlock == false then
            local tipsContent = LuaMgr.GetLangText(JZQWConst.TextLan.TextLan4)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
            return
        elseif item.data.CanIntro == false then
            local tipsContent = string.format(LuaMgr.GetLangText(item.data.UnlockTipsLan), Get_Beijing_TimeStr(item.data.UnlockTime))
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
            return
        end
        local data = {}
        data.SceneID = item.data.Config.Id
        LuaMgr.ShowLuaPanel(UIName.JZQWGamePanel, data)

        local redId = string.format("%s_%s", JZQWConst.RedPoint.Game, item.data.Config.Id)
        RedMgr.Singleton:FrushRedCondition(redId)
    elseif this.curPageType == JZQWConst.PageType.Novel then
        local playNovelCallback = function()
            LuaMgr.ShowLuaPanel(UIName.JZQWHomePanel)
        end
        LuaMgr.PlayNovel(item.data.eventParam, playNovelCallback)

        local redId = string.format("%s_%s", JZQWConst.RedPoint.Novel, item.data.eventParam)
        RedMgr.Singleton:FrushRedCondition(redId)
    else
        local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
        enterDungeonParams.eventId = item.data.id
        enterDungeonParams.dungeonId = item.data.eventParam
        BattlePrepareMgr.BattlePrepare(enterDungeonParams)

        local redId = ""
        if item.data.EventType == JZQWConst.EventType.Repeat then
            redId = string.format("%s_%s", JZQWConst.RedPoint.Repeat, item.data.eventParam)
        elseif item.data.EventType == JZQWConst.EventType.MainLine then
            redId = string.format("%s_%s", JZQWConst.RedPoint.MainLineDungeon, item.data.eventParam)
        elseif item.data.EventType == JZQWConst.EventType.Hard then
            redId = string.format("%s_%s", JZQWConst.RedPoint.HardDungeon, item.data.eventParam)
        end
        RedMgr.Singleton:FrushRedCondition(redId)
    end
end




this.OnUpdateMedalCollect = function()
    local medalActivityID = JZQWConst.MedalActivityID
    local finishMedalCount = DataExHelper.GetMedalFinishCount(medalActivityID)
    local medalList = DataExHelper.GetMedalList(medalActivityID)

    local totalFinishMedalCount = finishMedalCount
    this.medalList = {}
    this.AddMedalList(medalList)
    this.collectText.text = string.format(LuaMgr.GetLangText("CrisisContract2MainViewModel_0"), totalFinishMedalCount, #this.medalList)
    PlayerMedalMgr.CheckMedalPopup(medalActivityID)
end

this.AddMedalList = function(list)
    for key, value in pairs(list) do
        table.insert(this.medalList, value)
    end
end




this.SetIntroAnim = function()
    SetActive(this.introAnimGroup, false)
    if JZQWData.GetIsChildPanel() == true then
        JZQWData.SetIsChildPanel(false)
        return
    end
    for key, value in pairs(this.toggleParticle) do
        SetActive(value, false)
    end
    SetActive(this.introAnimGroup, true)
    SetActive(this.topBarComp, false)
    if this.introAnimTween ~= nil then
        this.introAnimTween:Kill(true)
    end
    this.introAnimTween = DOTWeen:Sequence()
    local callBack = function()
        SetActive(this.introAnimGroup, false)
        SetActive(this.topBarComp, true)
        this.rootAnim:Play("ani_JZQWHomePanel_root_01", 0, 0)
        for key, value in pairs(this.toggleParticle) do
            SetActive(value, true)
        end
    end
    this.introAnimTween:AppendInterval(JZQWConst.IntroAnimTime):OnComplete(callBack)
end



local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.BatchInitNode()
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        this.dungeonToggle.onValueChanged:AddListener(this.OnClickDungeonToggle)
        this.novelToggle.onValueChanged:AddListener(this.OnClickNovelToggle)
        this.gameToggle.onValueChanged:AddListener(this.OnClickGameToggle)
        LuaMgr.AddClick(this.recollectionBtn, this.OnClickRecollectionBtn)
        LuaMgr.AddClick(this.gameTaskBtn, this.OnClickGameTaskBtn)
        LuaMgr.AddClick(this.passBtn, this.OnClickPassBtn)
        LuaMgr.AddClick(this.shopBtn, this.OnClickShopBtn)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        if this.topBarComp == nil then
            local topBarObj = UnityEngine.GameObject.Find("UIRoot(Clone)/Fixed")
            this.topBarComp = topBarObj
        end
        this.SetIntroAnim()
        this.before_active()
    end,
    before_deactive = function(vm)
        SetActive(this.topBarComp, true)
        if this.showPointTweens ~= nil then
            for i = 1, #this.showPointTweens do
                this.showPointTweens[i]:Kill()
            end
            this.showPointTweens = nil
        end
        if this.introAnimTween ~= nil then
            this.introAnimTween:Kill(true)
            this.introAnimTween = nil
        end
        if this.tweener2 ~= nil then
            this.tweener2:Kill()
        end
    end,
    before_destroy = function()
        this.dungeonToggle.onValueChanged:RemoveListener(this.OnClickDungeonToggle)
        this.novelToggle.onValueChanged:RemoveListener(this.OnClickNovelToggle)
        this.gameToggle.onValueChanged:RemoveListener(this.OnClickGameToggle)

        LuaMgr.RemoveClick(this.recollectionBtn, this.OnClickRecollectionBtn)
        LuaMgr.RemoveClick(this.gameTaskBtn, this.OnClickGameTaskBtn)
        LuaMgr.RemoveClick(this.passBtn, this.OnClickPassBtn)
        LuaMgr.RemoveClick(this.shopBtn, this.OnClickShopBtn)
        this.DestroyPointItems()
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)