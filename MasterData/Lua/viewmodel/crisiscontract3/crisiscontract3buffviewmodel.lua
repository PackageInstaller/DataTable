require("ViewModel/CrisisContract3/CrisisContract3BuffItem")
require("ViewModel/CrisisContract3/CrisisContract3AdditionItem")

local this = {
    vm = nil,

    plotId = "",
    curPlotCfg = nil,

    isInitDungeonInfo = false,
    bossSpineItemList = {},
    bossSpineContentTr = nil,
    bossSpineTemplate = nil,

    isInitBuffList = false,
    buffList = {},
    buffScrollView = nil,
    buffItemTemplate = nil,
    curScore = 0,
    additionItems = {},
    additionItemTemplate = nil,
    additionItemContentTr = nil,

curShowType = 0,
    noBuffTipsToggleIsOn = false,
}

local data = {
    curScore = "",
    showInfoPage = false,
    showBuffPage = false,
    
    bossName = "",
    dungeonDesc = "",
    recommendChaList = {
        {
            id = "",
            icon = DefaultTexture,
            rare = DefaultSprite,
            job = DefaultSprite,
            desc = "",
            value = "",
        }
    },
    
    showWarningTips = false,
}

local command = {
    toggleInfoCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.curShowType == 1 then
                return
            end
            this.SetCurShowPage(1)
        end
    },
    toggleBuffCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.curShowType == 2 then
                return
            end
            this.SetCurShowPage(2)
        end
    },
    recommendChaCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local index = tonumber(param) + 1
            LuaMgr.ShowLuaPanel(UIName.CrisisContract3ChaAdditionPreviewPopup, this.vm.data.recommendChaList[index].id, this.curPlotCfg)
        end
    },
    diffAdditionCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            LuaMgr.ShowLuaPanel(UIName.CrisisContract3DiffAdditionPopup, this.curScore)
        end
    },
    NextCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if this.curShowType == 1 then
                this.SetCurShowPage(2)
                return
            end
            local chooseBuffIdList = {}
            for i, v in ipairs(this.buffList) do
                if v.Level > 0 and v.BuffInfo ~= nil then
                    table.insert(chooseBuffIdList, v.BuffInfo.BuffId)
                end
            end
            ActivityBattlePrepareMgr.SetMembers(ActivityKey.crisiscontract3, this.plotId)
            LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.crisiscontract3, this.plotId, chooseBuffIdList, this.GetCurSelectBuffTotalScore())
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        this.buffScrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/BuffPage/Group/ScrollView").gameObject)
        this.buffItemTemplate = vm.behaviour.transform:Find("template/BuffItem").gameObject
        this.bossSpineContentTr = vm.behaviour.transform:Find("root/Middle/InfoPage/Group/Boss/BossSpineContent"):GetComponent("RectTransform")
        this.bossSpineTemplate = vm.behaviour.transform:Find("template/BossSpine").gameObject
        this.additionItemTemplate = vm.behaviour.transform:Find("template/AdditionItem").gameObject
        this.additionItemContentTr = vm.behaviour.transform:Find("root/Middle/BuffPage/Group/DiffAddition/Content"):GetComponent("RectTransform")
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.plotId = vm.behaviour.Params[0];
        this.curPlotCfg = CrisisContract3Mgr.GetPlotConfig(this.plotId)
        if not this.vm.behaviour.IsPop or this.curShowType == 0 then
            this.curShowType = 1
        end
        this.InitBuffListData()
        this.SetCurShowPage(this.curShowType)
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        CrisisContract3Mgr.SaveChooseBuffList(this.plotId, this.buffList)
        for i, v in ipairs(this.additionItems) do
            v:Clear()
        end
        this.isInitDungeonInfo = false
        this.isInitBuffList = false
    end,
    before_destroy = function(vm)
        for i, v in ipairs(this.additionItems) do
            v:Destroy()
        end
        UIScrollView.ClearItem("CrisisContract3BuffItem")
        this = nil
    end,
}

this.InitBuffListData = function()
    this.buffList = CrisisContract3Mgr.GetAllBuffListByPlotId(this.plotId)
    local chooseBuffList = CrisisContract3Mgr.GetChooseBuffListByPlotId(this.plotId)
    local chooseBuffMap = {}
    for i, v in ipairs(chooseBuffList) do
        chooseBuffMap[v.Id] = {
            level = v.Level,
            buffInfo = v.BuffInfo
        }
    end
    for i, v in ipairs(this.buffList) do
        if chooseBuffMap[v.Id] ~= nil then
            v.Level = chooseBuffMap[v.Id].level
            v.BuffInfo = chooseBuffMap[v.Id].buffInfo
        end
    end
end

this.SetCurShowPage = function(type)
    this.curShowType = type
    if this.curShowType == 1 then
        this.SetDungeonInfo()
    elseif this.curShowType == 2 then
        this.RefreshBuffInfo()
    end
    this.vm.data.showInfoPage = this.curShowType == 1
    this.vm.data.showBuffPage = this.curShowType == 2
end

this.SetDungeonInfo = function()
    if this.isInitDungeonInfo then
        return
    end
    this.isInitDungeonInfo = true
    this.SetBossSpines()
    this.SetCharacters()
end

this.SetBossSpines = function()
    local bossPreviews = this.curPlotCfg.BossPreview
    local bossOffsets = this.curPlotCfg.Offset
    local index = 1
    for _ = 1, #bossPreviews do
        if index > #this.bossSpineItemList then
            local obj = LuaMgr.InstantiateGO(this.bossSpineTemplate, this.bossSpineContentTr, false)
            local item = {
                gameObject = obj,
                transform = obj.transform,
                uiSpineCharacter = obj.transform:Find("Body"):GetComponent("UISpineCharacter"),
                drawingAdjustTool = obj.transform:Find("Body"):GetComponent("DrawingAdjustTool")
            }
            table.insert(this.bossSpineItemList, item)
        end
        local bossSpineItem = this.bossSpineItemList[index]
        local realIndex = #bossPreviews - index + 1
        local bossId = bossPreviews[realIndex]
        local path = HeroManager.SetCharacterDrawing(bossSpineItem.uiSpineCharacter, bossId, bossId .. "01")
        if path ~= "" then
            bossSpineItem.drawingAdjustTool.Sprite = path
        end
        local x = tonumber(bossOffsets[3 * (realIndex - 1) + 1])
        local y = tonumber(bossOffsets[3 * (realIndex - 1) + 2])
        local scale = tonumber(bossOffsets[3 * (realIndex - 1) + 3])
        bossSpineItem.transform.localPosition = Vector3(x, y, 0.0)
        bossSpineItem.transform.localScale = Vector3(scale, scale, scale)
        bossSpineItem.gameObject:SetActive(true)
        index = index + 1
    end
    for i = index, #this.bossSpineItemList do
        this.bossSpineItemList[i].gameObject:SetActive(false)
    end
    
    this.vm.data.bossName = LuaMgr.GetLangText(this.curPlotCfg.BossNameLan)
    this.vm.data.dungeonDesc = LuaMgr.GetLangText(this.curPlotCfg.DescLan)
end

this.SetCharacters = function()
    local recommendChaList = this.curPlotCfg.Recommend
    local tempList = {}
    for i, v in ipairs(recommendChaList) do
        local attrDesCfg = ConfigMgr.Config.attrDesMap[v[2]]
        local characterId = v[1]
        local characterCfg = ConfigMgr.Config.characterTable[characterId]
        local data = {
            id = characterId,
            icon = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(characterId)),
            rare = LuaMgr.GetSprite("CommonRes", "ui_home_kbn_tx"..characterCfg.rare),
            job = LuaMgr.GetSprite("JobIcon", "job_" .. characterCfg.job),
            desc = LuaMgr.GetLangText(attrDesCfg.NameLan),
            value = "+" .. tostring(v[3]) .. attrDesCfg.attrDisplayType,
        }
        table.insert(tempList, data)
    end
    this.vm.data.recommendChaList = tempList
end

this.RefreshBuffInfo = function()
    if not this.isInitBuffList then
        this.isInitBuffList = true
        local scrollData, scrollDatas = {}, {}
        local groupData = nil
        local len = #this.buffList
        for i = 1, #this.buffList do
            groupData = this.buffList[i]
            groupData.index = i
            groupData.onClickAdd = this.AddBuffLevel
            groupData.onClickDel = this.DelBuffLevel
            scrollData = UIScrollData.GetData(this.buffItemTemplate, "CrisisContract3BuffItem", 1180, 85, groupData)
            table.insert(scrollDatas, scrollData)
        end

        this.buffScrollView:Clear(false)
        this.buffScrollView:SetPadding(0, 0, 0, 0)
        this.buffScrollView:SetParams(1223, 332)
        this.buffScrollView:SetData(scrollDatas, true)
    else
        this.buffScrollView:Refresh()
    end
    this.curScore = this.GetCurSelectBuffTotalScore()
    this.vm.data.curScore = this.curScore
    this.vm.data.showWarningTips = this.curScore > this.curPlotCfg.Credit[#this.curPlotCfg.Credit]
    this.SetDiffAdditionList()
end

this.GetCurSelectBuffTotalScore = function()
local initialCredit = this.curPlotCfg.InitialCredit
    local totalScore = initialCredit
    for i, v in ipairs(this.buffList) do
        totalScore = totalScore + v.BuffInfo.Score
    end
    return totalScore
end

this.SetDiffAdditionList = function()
    local curReinf = CrisisContract3Mgr.GetCurScoreDiffAddition(this.curScore)
    local index = 1
    if curReinf ~= nil then
        for _, v in ipairs(curReinf.Buff) do
            if index > #this.additionItems then
                local obj = LuaMgr.InstantiateGO(this.additionItemTemplate, this.additionItemContentTr, false).transform
                local item = CrisisContract3AdditionItem.New()
                item.gameObject = obj.gameObject
                item.transform = obj
                item:Init()
                table.insert(this.additionItems, item)
            end
            local item = this.additionItems[index]
            local buffDesc = CrisisContract3Mgr.GetBuffDescCfg(v)
            if buffDesc ~= nil then
                item:SetData(LuaMgr.GetLangText(buffDesc.BuffDesLan))
            end
            index = index + 1
        end
    end

    local len = #this.additionItems;
    for i = index, len do
        this.additionItems[i]:Hide();
    end

    LuaMgr.NextFrame(function()
        RectTransformTool.RebuildLayoutImmediate(this.additionItemContentTr)
    end)
end

this.AddBuffLevel = function(index)
    local selfBuffInfo = this.buffList[index]
    local curLevel = selfBuffInfo.Level
    if curLevel == selfBuffInfo.MaxLevel then
        return
    end
    selfBuffInfo.Level = curLevel + 1
    selfBuffInfo.BuffInfo = CrisisContract3Mgr.GetBuffInfoByLevel(selfBuffInfo.Id, selfBuffInfo.Level)
    this.RefreshBuffInfo()
end

this.DelBuffLevel = function(index)
    local selfBuffInfo = this.buffList[index]
    local curLevel = selfBuffInfo.Level
    if curLevel == 0 then
        return
    end
    selfBuffInfo.Level = curLevel - 1
    selfBuffInfo.BuffInfo = CrisisContract3Mgr.GetBuffInfoByLevel(selfBuffInfo.Id, selfBuffInfo.Level)
    this.RefreshBuffInfo()
end

return vm({
    data = data,
    command = command,
    hook = hook
})