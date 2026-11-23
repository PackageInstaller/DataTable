require("ViewModel/SongShiYouXin/ViewItem/SSYXBuildSceneItem")
require("ViewModel/SongShiYouXin/ViewItem/SSYXSceneCharacter")
local objs = {
    characterTexObj = {path = "template/CharacterTex", type = UITool.GameObject},
    roleInfoObj = {path = "root/Left/RoleInfo", type = UITool.GameObject},
    middleTrans = {path = "root/Middle", type = UITool.Transform},
    avatar = {path = "root/Left/RoleInfo/Avatar", type = UITool.RawImage},
    avatarFrame = {path = "root/Left/RoleInfo/AvatarFrame", type = UITool.Image},
    dynamicAvatar = {path = "root/Left/RoleInfo/DynamicAvatar", type = UITool.PlayerDynamicAvatar},
    playerName = {path = "root/Left/RoleInfo/Name", type = UITool.Text},
    playerLevel = {path = "root/Left/RoleInfo/LevelText", type = UITool.Text},
    playerExpProgress = {path = "root/Left/RoleInfo/Progress", type = UITool.Image},
    buildListBtn = {path = "root/Left/BuildListBtn", type = UITool.Button},
    lastSceneBtn = {path = "root/Middle/ChangeScene/LastSceneBtn", type = UITool.Button},
    nextSceneBtn = {path = "root/Middle/ChangeScene/NextSceneBtn", type = UITool.Button},
    visitListBtn = {path = "root/Right/VisitListBtn", type = UITool.Button},
    lastDarkObj = {path = "root/Middle/ChangeScene/LastSceneBtn/Dark", type = UITool.GameObject},
    lastLightObj = {path = "root/Middle/ChangeScene/LastSceneBtn/Light", type = UITool.GameObject},
    nextDarkObj = {path = "root/Middle/ChangeScene/NextSceneBtn/Dark", type = UITool.GameObject},
    nextLightObj = {path = "root/Middle/ChangeScene/NextSceneBtn/Light", type = UITool.GameObject},
    sceneName = {path = "root/Middle/ChangeScene/SceneName", type = UITool.Text},
    treeIcon = {path = "root/Scene1/Viewport/Content/Tree/Icon", type = UITool.Image},
    treeRectTrans = {path = "root/Scene1/Viewport/Content/Tree", type = UITool.RectTransform},
    treeWaterObj = {path = "root/Scene1/Viewport/Content/Tree/WaterObj", type = UITool.GameObject},
    treeWaterRect = {path = "root/Scene1/Viewport/Content/Tree/WaterObj", type = UITool.RectTransform},
    treeRemainWaterCount = {path = "root/Scene1/Viewport/Content/Tree/WaterObj/RemainWaterCount", type = UITool.Text},
    treewaterEffect = {path = "root/Scene1/Viewport/Content/Tree/eff_jiaoshui", type = UITool.GameObject},
    treeWaterBtn = {path = "root/Scene1/Viewport/Content/Tree/ClickAreaBtn", type = UITool.Button},
    weatherGroup = {path = "root/Left/WeatherGroup", type = UITool.GameObject},
    weatherIcon = {path = "root/Left/WeatherGroup/Icon", type = UITool.Image},
    weatherDesc = {path = "root/Left/WeatherGroup/Addition", type = UITool.Text},
    fadeObj = {path = "root/FadeObj", type = UITool.Animator},
    tipParentLeft = {path = "root/Left/TipsParent", type = UITool.GameObject},
    tipParentRight = {path = "root/Right/TipsParent", type = UITool.GameObject},
    upgradeLeftTipsBtn = {path = "root/Left/TipsParent/UpgradeBtn", type = UITool.Button},
    cangetLeftTipsBtn = {path = "root/Left/TipsParent/CangetBtn", type = UITool.Button},
    newInfoLeftTipsBtn = {path = "root/Left/TipsParent/NewInfoBtn", type = UITool.Button},
    upgradeRightTipsBtn = {path = "root/Right/TipsParent/UpgradeBtn", type = UITool.Button},
    cangetRightTipsBtn = {path = "root/Right/TipsParent/CangetBtn", type = UITool.Button},
    newInfoRightTipsBtn = {path = "root/Right/TipsParent/NewInfoBtn", type = UITool.Button}
}

local this = {
sceneBuildCount = {5, 8},

    buildSceneItems = {{}, {}},
buildSceneFirstPosX = {},
defaultScrollItemIndex = {2, 1},
normalizeMaxWidth = {},
    treeWaterObjPosY = {30, 155, -237},
    playerUID = nil,
    onDragBehaviourItems = {},
    scrollDragDelay = CS.UnityEngine.Application.targetFrameRate * 30 * 2,
    screenWidth = LuaMgr.GetScreenWidth(),

    spineCharacterItems = {},

    spineCharacterItemsCache = {}
}

this.before_awake = function()
    this.curSceneIndex = SSYXConst.MainSceneIndex
    RedMgr.Singleton:RegisterViewModel(UIName.SSYXGameHomePanel)
end

this.before_active = function()
    this.playerUID = DataMgr.Player.uid
    this.treeData = nil
    this.isWatering = false
    SetActive(this.treewaterEffect, false)
    this.ChangeScene(this.curSceneIndex, true)
    SSYXData.CheckGameRedPoint()
    local centerIndex = this.GetBuildCenterIndex()
    this.RefreshRedPoint(centerIndex)
end

this.BatchInitNode = function()
    for i = 1, SSYXConst.SceneCount do
        local sceneName = "Scene" .. i
        local path = "root/" .. sceneName
        objs[sceneName] = {path = path, type = UITool.ScrollRect}

        local dragBehaviour = "SceneDragBehaviour" .. i
        local path = "root/" .. sceneName
        objs[dragBehaviour] = {path = path, type = UITool.OnDragBehaviour}

        local flagLightName = "FlagLight" .. i
        local path = string.format("root/Middle/ChangeScene/FlagGroup/Item%d/Light", i)
        objs[flagLightName] = {path = path, type = UITool.GameObject}
    end
    for i = 1, 2 do
        for j = 1, this.sceneBuildCount[i] do
            local buildName = string.format("Build_%d_%dObj", i, j)
            local path = string.format("root/Scene%d/Viewport/Content/Build%d", i, j)
            objs[buildName] = {path = path, type = UITool.GameObject}
        end
    end
    UITool.Parse(this.vmBehaviour.gameObject, this, objs)
    for i = 1, 2 do
        local sceneBuildCount = this.sceneBuildCount[i]
        for j = 1, sceneBuildCount do
            local buildObjName = string.format("Build_%d_%dObj", i, j)
            local item = SSYXBuildSceneItem.New(this[buildObjName])
            table.insert(this.buildSceneItems[i], #this.buildSceneItems[i] + 1, item)
            if j == 1 then
                this.buildSceneFirstPosX[i] = item:GetPosX()
            end
        end
        local sceneItems = this.buildSceneItems[i]
        local firstItem = sceneItems[1]
        local lastItem = sceneItems[sceneBuildCount]
        this.normalizeMaxWidth[i] = lastItem:GetPosX() - firstItem:GetPosX()

        local dragBehaviourName = "SceneDragBehaviour" .. i
        local dragBehaviour = this[dragBehaviourName]
        this.onDragBehaviourItems[i] = dragBehaviour
    end
    this.leftTipButtons = {
        [SSYXConst.TipsType.BuildUpgrade] = this.upgradeLeftTipsBtn,
        [SSYXConst.TipsType.GetReward] = this.cangetLeftTipsBtn,
        [SSYXConst.TipsType.NewInfo] = this.newInfoLeftTipsBtn
    }
    this.rightTipButtons = {
        [SSYXConst.TipsType.BuildUpgrade] = this.upgradeRightTipsBtn,
        [SSYXConst.TipsType.GetReward] = this.cangetRightTipsBtn,
        [SSYXConst.TipsType.NewInfo] = this.newInfoRightTipsBtn
    }
    this.SetScrollDragEvent()
end

this.ChangeScene = function(index, isInit)
    this.curSceneIndex = index
    if this.changeSceneTween ~= nil then
        this.changeSceneTween:Kill(true)
        this.changeSceneTween = nil
    end
    if isInit == true then
        this.ChangeSceneDelay()
        return
    end
    this.fadeObj.enabled = true
    SetActive(this.fadeObj.gameObject, true)
    this.lastSceneBtn.interactable = false
    this.nextSceneBtn.interactable = false
    if this.tweenSquence ~= nil then
        this.tweenSquence:Kill()
    end
    this.CheckBuildState()
    this.tweenSquence = DOTWeen:Sequence()
    this.tweenSquence:AppendInterval(0.5):OnComplete(this.ChangeSceneDelay)
end

this.ChangeSceneDelay = function()
    this.fadeObj.enabled = false
    SetActive(this.fadeObj.gameObject, false)
    this.lastSceneBtn.interactable = true
    this.nextSceneBtn.interactable = true
    for i = 1, 2 do
        local name = "Scene" .. i
        local scroll = this[name]
        SetActive(scroll.gameObject, i == this.curSceneIndex)
    end
    this.RefreshSceneFlag()
    this.RefreshUI()
    local isSelf = this.playerUID == DataMgr.Player.uid
    if isSelf == true then
        this.MoveSceneScroll()
        local centerIndex = this.GetBuildCenterIndex()
        this.RefreshRedPoint(centerIndex)
    else
        for key, value in pairs(this.leftTipButtons) do
            SetActive(value.gameObject, false)
        end
        for key, value in pairs(this.rightTipButtons) do
            SetActive(value.gameObject, false)
        end
        this.MoveSceneScrollByPosX(this.treeRectTrans.anchoredPosition.x)
    end
    this.RecycleAllSpineCharacter()
    this.AddCharacterSpine()
end


this.AddCharacterSpine = function()
    local buildCount = this.sceneBuildCount[this.curSceneIndex]
    local needCharacterCount = buildCount
    local allEmployeeDatas = SSYXData.GetAllWordEmployeeDatas()
    ShuffleTable(allEmployeeDatas)
    for i = 1, needCharacterCount do
        local employeeData = allEmployeeDatas[i]
        local characterId = employeeData and employeeData.ID or nil
        if characterId ~= nil then
            local characterSpine = this.GetSpineCharacter()
            SetActive(characterSpine.gameObject, true)
            local data = {}
            data.CharacterId = characterId
            data.PathPosDatas = this.GetPathLine(i)
            data.PathLength = this.GetPathLineLength(data.PathPosDatas)
            characterSpine:SetData(data)
            table.insert(this.spineCharacterItems, characterSpine)
        end
    end
end

this.OnUpdate = function()
    for i = 1, #this.spineCharacterItems do
        local spineCharacterItem = this.spineCharacterItems[i]
        spineCharacterItem:OnUpdate()
    end
end

this.GetSpineCharacter = function()
    local tempSpineCharacter = table.remove(this.spineCharacterItemsCache)
    local name = "Scene" .. this.curSceneIndex
    local scrollRect = this[name]
    if tempSpineCharacter == nil then
        local tempObj = LuaMgr.InstantiateGO(this.characterTexObj, scrollRect.content, false)
        tempSpineCharacter = SSYXSceneCharacter.New(tempObj)
    end
    tempSpineCharacter:SetParent(scrollRect.content)
    return tempSpineCharacter
end

this.RecycleAllSpineCharacter = function()
    for i = 1, #this.spineCharacterItems do
        local spineCharacter = this.spineCharacterItems[i]
        spineCharacter:Clear()
        SetActive(spineCharacter.gameObject, false)
        table.insert(this.spineCharacterItemsCache, spineCharacter)
    end
end

this.GetPathLine = function(i)
    local linePaths = {}
    local curSceneItems = this.buildSceneItems[this.curSceneIndex]
    if curSceneItems == nil then
        return nil
    end
    local item = curSceneItems[i]
    local posStart = Vector3(item:GetPosX(), -570, 0)
    table.insert(linePaths, posStart)
    if i == 1 then
        local item = curSceneItems[#curSceneItems]
        local posEnd = Vector3(item:GetPosX(), -570, 0)
        table.insert(linePaths, posEnd)

        table.insert(linePaths, posStart)
    elseif i == #curSceneItems then
        local item = curSceneItems[1]
        local posEnd = Vector3(item:GetPosX(), -570, 0)
        table.insert(linePaths, posEnd)
        table.insert(linePaths, posStart)
    else
        local item = curSceneItems[#curSceneItems]
        local posEnd = Vector3(item:GetPosX(), -570, 0)
        table.insert(linePaths, posEnd)

        local item = curSceneItems[1]
        local posEnd = Vector3(item:GetPosX(), -570, 0)
        table.insert(linePaths, posEnd)
        math.randomseed(LuaMgr.Timestamp() * 100 + i)
        local random = math.random(1, 100)
        if random < 50 then
            linePaths[2], linePaths[3] = linePaths[3], linePaths[2]
        end

        table.insert(linePaths, posStart)
    end
    return linePaths
end

this.GetPathLineLength = function(linePaths)
    if linePaths == nil or #linePaths <= 1 then
        return 0
    end
    local length = 0
    for i = 1, #linePaths - 1 do
        local startPosX = linePaths[i].x
        local endPosX = linePaths[i + 1].x
        local deltaDistance = math.abs(startPosX - endPosX)
        length = length + deltaDistance
    end
    return length
end


this.RefreshSceneFlag = function()
    SetActive(this.lastDarkObj, this.curSceneIndex == 1)
    SetActive(this.lastLightObj, this.curSceneIndex ~= 1)
    SetActive(this.nextDarkObj, this.curSceneIndex == SSYXConst.SceneCount)
    SetActive(this.nextLightObj, this.curSceneIndex ~= SSYXConst.SceneCount)

    for i = 1, SSYXConst.SceneCount do
        local flagLightName = "FlagLight" .. i
        SetActive(this[flagLightName], i == this.curSceneIndex)
    end
end

this.RefreshUI = function()
    this.RefreshRoleInfo(this.playerUID)
    this.sceneName.text = LuaMgr.GetLangText(SSYXConst.LanText.LanText0[this.curSceneIndex])
    SetActive(this.buildListBtn.gameObject, this.playerUID == DataMgr.Player.uid)
    this.RefreshBuildData()
    this.RefreshTreeData()
end

this.RefreshBuildData = function()
    local allData = SSYXData.GetAllBuildData(this.curSceneIndex, this.playerUID)
    local allBuildItems = this.buildSceneItems[this.curSceneIndex]
    if #allBuildItems ~= #allData then
        LuaDebug.error(string.format("数据非法: %d_%d", #allBuildItems, #allData))
        return
    end
    for i = 1, #allBuildItems do
        local item = allBuildItems[i]
        local data = allData[i]
        data.IsSelf = this.playerUID == DataMgr.Player.uid
        data.OnClickBuild = this.OnClickBuildCallback
        item:SetData(data)
    end
end

this.CheckBuildState = function()
    if this.playerUID ~= DataMgr.Player.uid then
        return
    end
    local serverData = SSYXData.GetSelfBuildServerData()
    for key, value in pairs(serverData) do
        if value.State ~= 1 then
            local onSucc = function(result)
                local res = json.decode(result)
                if res.code ~= nil and res.code ~= 0 then
                    LuaDebug.error("OnClickCreateBtn 请求错误:" .. res.code)
                    return
                end
                SSYXData.RefreshBuildDataByID(key)
            end
            local data = {}
            data.BuildId = key
            ApiMgr.Request("operateBuild/makeFinish", data, true, onSucc, nil, true)
        end
    end
end

this.RefreshTreeData = function()
    local timeData = SSYXData.GetWhichDayData()
    if timeData.Config ~= nil then
        this.weatherIcon.sprite = LuaMgr.GetSprite(SSYXConst.ItemAtlaName, timeData.Config.Icon)
        this.weatherDesc.text = LuaMgr.GetLangText(timeData.Config.DescriptionLan)
    end
    if this.curSceneIndex ~= 1 then
        return
    end
    local isOtherPlayer = this.playerUID ~= DataMgr.Player.uid
    this.treeData = SSYXData.GetTreeData(this.playerUID)
    this.treeIcon.sprite = LuaMgr.GetSprite(SSYXConst.BuildAtlaName, "Tree_Light_" .. this.treeData.Level)
    local waterCountLan = LuaMgr.GetLangText(SSYXConst.LanText.LanText21)
    this.treeRemainWaterCount.text = string.format(waterCountLan, this.treeData.WaterCount, this.treeData.MaxWaterCount)
    this.treeWaterBtn.interactable = isOtherPlayer
    SetActive(this.treeWaterObj, isOtherPlayer)
    if isOtherPlayer == true then
        local posY = this.treeWaterObjPosY[this.treeData.Level] or 0
        this.treeWaterRect = Vector3(0, posY, 0)
    end
    if isOtherPlayer == false then
        local gotData = DataMgr.Player.OperateBuild.Tree.Rewards
        if type(gotData) ~= "table" then
            gotData = {}
        end
        for i = 1, this.treeData.Level do
            if i > 1 then
                local reward = gotData[tostring(i - 1)]
                if reward == nil then
                    local onSucc = function(result)
                        local res = json.decode(result)
                        if res.code ~= nil and res.code ~= 0 then
                            return
                        end
                        local data = json.encode(res.result)
                        LuaMgr.ShowItemRewared(data)
                    end
                    local data = {}
                    ApiMgr.Request("operateBuild/treeReward", data, true, onSucc, nil, true)
                    break
                end
            end
        end
    end
end

this.RefreshRoleInfo = function(uid)
    local roleData = SSYXData.GetRoleBaseData(uid)
    this.SetPlayerAvatar(roleData)
    this.playerName.text = roleData.Name
    this.playerLevel.text = string.format("LV.%d", roleData.Level)
    if roleData.IsMaxLevel == true then
        this.playerExpProgress.fillAmount = 1
    else
        if this.playerUID == DataMgr.Player.uid then
            this.playerExpProgress.fillAmount = roleData.Exp / roleData.MaxExp
        else
            this.playerExpProgress.fillAmount = this.beVisitorDataExp / roleData.MaxExp
        end
    end
end

this.MoveSceneScroll = function()
    local scrollItemIndex = this.defaultScrollItemIndex[this.curSceneIndex]
    local tempOpeBuildData = SSYXData.GetBuildTempData()
    if tempOpeBuildData ~= nil then
        scrollItemIndex = tempOpeBuildData.Config.Location
    end
    this.MoveSceneScrollByIndex(scrollItemIndex)
end

this.MoveSceneScrollByIndex = function(scrollItemIndex)
    if this.buildSceneItems[this.curSceneIndex][scrollItemIndex] == nil then
        return
    end
    local defaultBuildPosX = this.buildSceneItems[this.curSceneIndex][scrollItemIndex]:GetPosX()
    this.MoveSceneScrollByPosX(defaultBuildPosX)
end

this.MoveSceneScrollByPosX = function(defaultBuildPosX)
    local deltaSizeX = defaultBuildPosX - this.buildSceneFirstPosX[this.curSceneIndex]
    if deltaSizeX < 0 then
        return
    end
    local normalizPosX = deltaSizeX / this.normalizeMaxWidth[this.curSceneIndex]

    local scene = nil
    if this.curSceneIndex == 1 then
        scene = this.Scene1
    else
        scene = this.Scene2
    end
    scene.horizontalNormalizedPosition = normalizPosX
end

this.SetPlayerAvatar = function(data)
    if this.refreshHeadCoroutine ~= nil then
        coroutine_runner.stop(this.refreshHeadCoroutine)
        this.refreshHeadCoroutine = nil
    end
    if data.ImgType == 1 then
        this.avatar.texture = data.AvatarTexture
        SetActive(this.dynamicAvatar.gameObject, false)
    else
        this.SetDynamicAvatar(data)
    end
    SetActive(this.avatar.gameObject, data.ImgType == 1)
    PlayerAvatarFrameTool.SetAvatarFrame(this.avatarFrame, data.AvatarFrame)
end

this.SetDynamicAvatar = function(data)
    this.dynamicAvatar:AppointAvatar(data.Avatar)
    SetActive(this.dynamicAvatar.gameObject, false)
    local onDelay = function()
        coroutine_runner.wait(0.1)
        SetActive(this.dynamicAvatar.gameObject, true)
    end
    this.refreshHeadCoroutine = coroutine_runner.start(onDelay)
end



this.OnClickBuildCallback = function(item)
    if SSYXData.CheckActivityRunning() == false then
        return
    end
    local uiName = SSYXConst.BuildToUIMap[item.data.ID]
    if uiName == nil then
        uiName = UIName.SSYXBuildInfoPanel
    end
    LuaMgr.ShowLuaPanel(uiName, item.data)
    local tempData = SSYXData.GetBuildDataByID(item.data.ID)
    SSYXData.SetBuildTempData(tempData)
end

this.OnClickBuildListBtn = function()
    LuaMgr.ShowLuaPanel(UIName.SSYXBuildListPanel)
end

this.OnClickLastSceneBtn = function()
    local tempIndex = this.curSceneIndex - 1
    if tempIndex < 1 then
        return
    elseif tempIndex == 1 then
        SetActive(this.lastDarkObj, true)
        SetActive(this.lastLightObj, false)
    end
    SetActive(this.nextDarkObj, false)
    SetActive(this.nextLightObj, true)
    this.curSceneIndex = tempIndex
    this.ChangeScene(this.curSceneIndex)
end

this.OnClickNextSceneBtn = function()
    local tempIndex = this.curSceneIndex + 1
    if tempIndex > SSYXConst.SceneCount then
        return
    elseif tempIndex == SSYXConst.SceneCount then
        SetActive(this.nextDarkObj, true)
        SetActive(this.nextLightObj, false)
    end
    SetActive(this.lastDarkObj, false)
    SetActive(this.lastLightObj, true)
    this.curSceneIndex = tempIndex
    this.ChangeScene(this.curSceneIndex)
end

this.OnClickVisitListBtn = function()
    this.beVisitorData = nil
    local callback = function()
        LuaMgr.ShowLuaPanel(UIName.SSYXVisitListPopup, this.OnVisitPlayerCallback)
    end
    SSYXData.RefreshVisitRoleList(callback)
end

this.OnVisitPlayerCallback = function(uid, data)
    this.beVisitorData = data
    this.beVisitorDataExp = this.beVisitorData.Exp
    this.playerUID = uid
    SSYXData.SetVisitorBuildServerData(data.OpBuilds)
    this.ChangeScene(1)
    this.MoveSceneScrollByPosX(this.treeRectTrans.anchoredPosition.x)
end

this.OnClickTreeWaterBtn = function()
    if this.treeData == nil then
        return
    end
    local waterCount = DataMgr.Player.OperateBuild.Tree.DailyWatering[this.playerUID]
    if waterCount ~= nil and waterCount > 0 then
        local tipsContent = LuaMgr.GetLangText(SSYXConst.LanText.LanText53)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    if this.isWatering == true then
        return
    end
    if this.treeData.WaterCount >= this.treeData.MaxWaterCount then
        local tipsContent = LuaMgr.GetLangText(SSYXConst.LanText.LanText22)
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local onSucc = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            return
        end
        local reward = json.encode(res.result.Rewards)
        LuaMgr.ShowItemRewared(reward)
        this.RefreshUI()
    end
    local data = {}
    data.Uid = this.playerUID
    ApiMgr.Request("operateBuild/interact", data, true, onSucc, nil, true)
    this.PlayWaterEffect()
end

this.PlayWaterEffect = function()
    this.isWatering = true
    SetActive(this.treewaterEffect, true)
    this.waterTween = DOTWeen:Sequence()
    local callback = function()
        this.isWatering = false
        SetActive(this.treewaterEffect, false)
    end
    this.waterTween:AppendInterval(2):OnComplete(callback)
end

this.OnClickBackBtn = function()
    if this.playerUID ~= DataMgr.Player.uid then
        this.beVisitorData = nil
        SSYXData.SetVisitorBuildServerData(nil)
        this.playerUID = DataMgr.Player.uid
        this.ChangeScene(this.curSceneIndex)
        return
    end
    if LuaMgr.IsPanelOpen(UIName.SSYXBuildInfoPanel) then
        LuaMgr.HidePanel(UIName.SSYXBuildInfoPanel)
        return
    end
    LuaMgr.Back()
end

this.OnCreateBuildNotify = function(param)
    local centerIndex = this.GetBuildCenterIndex()
    if param == nil or param.Length == 0 then
        return
    end
    local buildData = param[0]
    if buildData.SceneIndex ~= this.curSceneIndex then
        SSYXData.SetBuildTempData(buildData)
        this.ChangeScene(buildData.SceneIndex)
    else
        this.RefreshBuildData()
        this.RefreshTreeData()
    end
    SSYXData.CheckGameRedPoint()
    this.RefreshRedPoint(centerIndex)
end


this.SetScrollDragEvent = function()
    for i = 1, #this.onDragBehaviourItems do
        local onDragBehaviourItem = this.onDragBehaviourItems[i]
        onDragBehaviourItem.onBeginDrag = this.OnBeginDrag
        onDragBehaviourItem.onDrag = this.OnDrag
        onDragBehaviourItem.onEndDrag = this.OnEndDrag

        local name = "Scene" .. i
        local scrollRect = this[name]
        scrollRect.onValueChanged:AddListener(this.OnScrollValueChanged)
    end
end

this.OnScrollValueChanged = function(value)
    if this.isScrolling ~= true then
        this.isScrolling = true
    end
    this.previousPosition = value
    if this.scrollCor ~= nil then
        coroutine_runner.stop(this.scrollCor)
    end
    this.scrollCor = coroutine_runner.start(this.CheckScrollEnd)
end

this.CheckScrollEnd = function()
    coroutine_runner.wait(0.1)
    local name = "Scene" .. this.curSceneIndex
    local scrollRect = this[name]
    if this.isScrolling and this.previousPosition == scrollRect.normalizedPosition then
        this.isScrolling = false
        local centerIndex = this.GetBuildCenterIndex()
        this.RefreshRedPoint(centerIndex)
    end
end

this.OnBeginDrag = function(eventData)
    this.lastPosX = 0
    this.lastScrollLength = 0
end

this.OnDrag = function(eventData)
    local curPosX = eventData.position.x
    this.lastPosX = curPosX
    this.lastScrollLength = this.lastScrollLength + curPosX - this.lastPosX
    this.lastScrollLength = 0
    local centerIndex = this.GetBuildCenterIndex()
    this.RefreshRedPoint(centerIndex)
end

this.OnEndDrag = function(eventData)
    local centerIndex = this.GetBuildCenterIndex()
    this.RefreshRedPoint(centerIndex)
end

this.RefreshRedPoint = function(centerIndex)
    local isSelf = this.playerUID == DataMgr.Player.uid
    for key, value in pairs(this.leftTipButtons) do
        SetActive(value.gameObject, false)
    end
    for key, value in pairs(this.rightTipButtons) do
        SetActive(value.gameObject, false)
    end
    if isSelf == false then
        return
    end
    local allItems = this.buildSceneItems[this.curSceneIndex]
    this.leftTipsDatas = {}
    this.rightTipsDatas = {}
    for i = centerIndex - 1, 1, -1 do
        local item = allItems[i]
        if item == nil then
            break
        end
        this.CheckTipsData(this.leftTipsDatas, item)
    end
    for i = centerIndex + 1, #allItems do
        local item = allItems[i]
        if item == nil then
            break
        end
        this.CheckTipsData(this.rightTipsDatas, item)
    end

    for key, value in pairs(this.leftTipButtons) do
        if this.leftTipsDatas[key] ~= nil then
            SetActive(value.gameObject, true)
        else
            SetActive(value.gameObject, false)
        end
    end
    for key, value in pairs(this.rightTipButtons) do
        if this.rightTipsDatas[key] ~= nil then
            SetActive(value.gameObject, true)
        else
            SetActive(value.gameObject, false)
        end
    end
end

this.CheckTipsData = function(tipsDatas, item)
    if tipsDatas[SSYXConst.TipsType.GetReward] == nil and item.redPointNum > 0 then
        tipsDatas[SSYXConst.TipsType.GetReward] = item
    end
    if tipsDatas[SSYXConst.TipsType.BuildUpgrade] == nil and item.data ~= nil and item.data.CanUpgrade == true then
        tipsDatas[SSYXConst.TipsType.BuildUpgrade] = item
    end
    if tipsDatas[SSYXConst.TipsType.NewInfo] == nil and item.redPointNum > 0 and item.isRewardTips == false then
        tipsDatas[SSYXConst.TipsType.NewInfo] = item
    end
end

this.GetBuildCenterIndex = function()
    local allItems = this.buildSceneItems[this.curSceneIndex]
    local centerX = this.screenWidth / 2
    local lastMinX = 1000000
    local lastMinIndex = 0
    for i = 1, #allItems do
        local item = allItems[i]
        local localPos = LuaMgr.World2Screen(item:GetWorldPos())
        if localPos.x > 0 and localPos.x < this.screenWidth then
            if math.abs(localPos.x - centerX) < math.abs(lastMinX - centerX) then
                lastMinX = localPos.x
                lastMinIndex = i
            end
        end
    end
    return lastMinIndex
end

this.OnClickLeftRedPointUpgrade = function()
    this.GotoBuildItem(this.leftTipsDatas[SSYXConst.TipsType.BuildUpgrade])
end

this.OnClickLeftRedPointCanget = function()
    this.GotoBuildItem(this.leftTipsDatas[SSYXConst.TipsType.GetReward])
end

this.OnClickLeftRedPointNewInfo = function()
    this.GotoBuildItem(this.leftTipsDatas[SSYXConst.TipsType.NewInfo])
end

this.OnClickRightRedPointUpgrade = function()
    this.GotoBuildItem(this.rightTipsDatas[SSYXConst.TipsType.BuildUpgrade])
end

this.OnClickRightRedPointCanget = function()
    this.GotoBuildItem(this.rightTipsDatas[SSYXConst.TipsType.GetReward])
end

this.OnClickRightRedPointNewInfo = function()
    this.GotoBuildItem(this.rightTipsDatas[SSYXConst.TipsType.NewInfo])
end

this.GotoBuildItem = function(item)
    if item == nil then
        return
    end
    this.MoveSceneScrollByIndex(item.data.Config.Location)
end



local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.vmBehaviour = vm.behaviour
        this.BatchInitNode()
        this.before_awake()
        LuaMgr.AddClick(this.buildListBtn, this.OnClickBuildListBtn)
        LuaMgr.AddClick(this.lastSceneBtn, this.OnClickLastSceneBtn)
        LuaMgr.AddClick(this.nextSceneBtn, this.OnClickNextSceneBtn)
        LuaMgr.AddClick(this.visitListBtn, this.OnClickVisitListBtn)
        LuaMgr.AddClick(this.treeWaterBtn, this.OnClickTreeWaterBtn)
        LuaMgr.AddClick(this.upgradeLeftTipsBtn, this.OnClickLeftRedPointUpgrade)
        LuaMgr.AddClick(this.cangetLeftTipsBtn, this.OnClickLeftRedPointCanget)
        LuaMgr.AddClick(this.newInfoLeftTipsBtn, this.OnClickLeftRedPointNewInfo)
        LuaMgr.AddClick(this.upgradeRightTipsBtn, this.OnClickRightRedPointUpgrade)
        LuaMgr.AddClick(this.cangetRightTipsBtn, this.OnClickRightRedPointCanget)
        LuaMgr.AddClick(this.newInfoRightTipsBtn, this.OnClickRightRedPointNewInfo)

        LuaMgr.AddUIEventListener(UIEventConst.SSYXCreateBuildNotify, this.OnCreateBuildNotify)
        LuaMgr.AddUIEventListener(UIEventConst.SSYXRefreshGameScene, this.OnCreateBuildNotify)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.vmBehaviour:UpdateTopBar("", this.OnClickBackBtn)
        this.before_active()
        LuaMgr.AddTimer(TimerConst.SSYXRefreshTreeTimer, this.RefreshUI, 60, -1, false)
        LuaMgr.AddUpdate(this.OnUpdate)
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUpdate(this.OnUpdate)
        LuaMgr.RemoveTimer(TimerConst.SSYXRefreshTreeTimer)
        this.RecycleAllSpineCharacter()
    end,
    before_destroy = function(vm)
        PlayerAvatarFrameTool.ClearImage(this.avatarFrame)
        LuaMgr.RemoveClick(this.buildListBtn, this.OnClickBuildListBtn)
        LuaMgr.RemoveClick(this.lastSceneBtn, this.OnClickLastSceneBtn)
        LuaMgr.RemoveClick(this.nextSceneBtn, this.OnClickNextSceneBtn)
        LuaMgr.RemoveClick(this.visitListBtn, this.OnClickVisitListBtn)
        LuaMgr.RemoveClick(this.treeWaterBtn, this.OnClickTreeWaterBtn)
        LuaMgr.RemoveClick(this.upgradeLeftTipsBtn, this.OnClickLeftRedPointUpgrade)
        LuaMgr.RemoveClick(this.cangetLeftTipsBtn, this.OnClickLeftRedPointCanget)
        LuaMgr.RemoveClick(this.newInfoLeftTipsBtn, this.OnClickLeftRedPointNewInfo)
        LuaMgr.RemoveClick(this.upgradeRightTipsBtn, this.OnClickRightRedPointUpgrade)
        LuaMgr.RemoveClick(this.cangetRightTipsBtn, this.OnClickRightRedPointCanget)
        LuaMgr.RemoveClick(this.newInfoRightTipsBtn, this.OnClickRightRedPointNewInfo)
        LuaMgr.RemoveUIEventListener(UIEventConst.SSYXCreateBuildNotify, this.OnCreateBuildNotify)
        LuaMgr.RemoveUIEventListener(UIEventConst.SSYXRefreshGameScene, this.OnCreateBuildNotify)
        for i = 1, #this.buildSceneItems do
            local sceneBuilds = this.buildSceneItems[i]
            for j = 1, #sceneBuilds do
                local buildItem = sceneBuilds[j]
                buildItem:Destroy()
            end
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