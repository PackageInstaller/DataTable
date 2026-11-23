
local objs = {
    bookBtn = {path = "root/Middle/BookBtn", type = UITool.Button},
    makeBtn = {path = "root/Middle/MakeBtn", type = UITool.Button},
    formulaBtn = {path = "root/Middle/FormulaBtn", type = UITool.Button},
    eventObj = {path = "root/Middle/Event", type = UITool.GameObject},
    eventNovel = {path = "root/Middle/Event/EventNovel", type = UITool.GameObject},
    eventGame = {path = "root/Middle/Event/EventGame", type = UITool.GameObject},
    eventBattle = {path = "root/Middle/Event/EventBattle", type = UITool.GameObject},
    eventNewGlass = {path = "root/Middle/Event/EventNewGlass", type = UITool.GameObject},
    eventRepeatGlass = {path = "root/Middle/Event/EventRepeatGlass", type = UITool.GameObject},
    novelTitle = {path = "root/Middle/Event/EventNovel/Title", type = UITool.Text},
    battleTitle = {path = "root/Middle/Event/EventBattle/Title", type = UITool.Text},
    gameTitle = {path = "root/Middle/Event/EventGame/Title", type = UITool.Text},
    itemParent = {path = "root/Middle/Event/ItemParent", type = UITool.Transform},
    gotoEventBtn = {path = "root/Middle/Event/ItemParent/GotoBtn", type = UITool.Button},
    getRewardBtn = {path = "root/Middle/Event/ItemParent/GetRewardBtn", type = UITool.Button},
    goalIcon = {path = "root/Middle/GoalIcon", type = UITool.Image},
    combineSuccEffect = {path = "root/Middle/GoalIcon/vfx_on", type = UITool.GameObject}
}

local this = {
    eventItemParentPos1 = Vector3(-69.7, -10, 0),
    eventItemParentPos2 = Vector3(0, -16, 0)
}

this.BatchInitNode = function()
    for i = 1, 3 do
        local noneFillMatName = "noneFillMat" .. i
        local data = {}
        data.path = string.format("root/Middle/Material%d/NoneFillMat", i)
        data.type = UITool.GameObject
        objs[noneFillMatName] = data

        local fillMatName = "fillMat" .. i
        local data = {}
        data.path = string.format("root/Middle/Material%d/FillMat", i)
        data.type = UITool.GameObject
        objs[fillMatName] = data

        local fillMatIconName = "fillMatIcon" .. i
        local data = {}
        data.path = string.format("root/Middle/Material%d/FillMat/Icon", i)
        data.type = UITool.Image
        objs[fillMatIconName] = data

        local materialBtnName = "materialBtn" .. i
        local data = {}
        data.path = string.format("root/Middle/Material%d", i)
        data.type = UITool.Button
        objs[materialBtnName] = data
    end
end

this.before_awake = function()
    RedMgr.Singleton:RegisterViewModel(UIName.ZXLGlassCombinePanel)
    for i = 1, 3 do
        local materialBtnName = "materialBtn" .. i
        LuaMgr.AddClick(this[materialBtnName], this.OnClickMatAddFlag)
    end
end

this.before_active = function()
    ZXLData.CheckRed()
    SetActive(this.eventObj, false)
    SetActive(this.combineSuccEffect, false)
    RedMgr.Singleton:SetRedState(ZXLConst.RedPoint.AllPlay, ZXLData.CheckExistNoCompleteDelegate())
    this.RefreshUI()
end

this.RefreshUI = function()
    this.RefreshMaterial(true)
end

this.RefreshMaterial = function(isReset, choosedDatas)
    local chooseItemCount = type(choosedDatas) == "table" and NumTool.GetLen(choosedDatas) or 0
    for i = 1, 3 do
        local isShowFillMat = false
        if isReset == false and chooseItemCount >= i then
            isShowFillMat = true
        end
        local noneFillMatName = "noneFillMat" .. i
        SetActive(this[noneFillMatName], isShowFillMat == false)
        local fillMatName = "fillMat" .. i
        SetActive(this[fillMatName], isShowFillMat == true)
    end
    if isReset == false and choosedDatas ~= nil then
        local index = 1
        for key, value in pairs(choosedDatas) do
            local fillMatIconName = "fillMatIcon" .. index
            local fillMatIcon = this[fillMatIconName]
            local imageID = value.config.Icon
            fillMatIcon.sprite = LuaMgr.GetSprite(ZXLConst.AtlaName, imageID)
            index = index + 1
        end
    end
    this.choosedDatas = choosedDatas
    SetActive(this.goalIcon.gameObject, false)
    if chooseItemCount >= 3 then
        this.goalGlassData = ZXLData.GetGlassGoalByMat(choosedDatas)
    end
end

this.RefreshGoalGlass = function()
    if this.goalGlassData ~= nil then
        SetActive(this.goalIcon.gameObject, true)
        this.goalIcon.sprite = LuaMgr.GetSprite(ZXLConst.AtlaName, this.goalGlassData.config.Icon .. "_light")
    else
        SetActive(this.goalIcon.gameObject, false)
    end
end

this.CombineSuccess = function()
    SetActive(this.combineSuccEffect, true)
    this.HideNewEventUI()
    local data = this.goalGlassData
    if data == nil then
        return
    end
    SetActive(this.eventObj, true)
    local seriesEventComplete = ZXLData.IsFirstCombine(data.ID)
    SetActive(this.itemParent.gameObject, seriesEventComplete == true)
    SetActive(this.eventRepeatGlass, seriesEventComplete == false)
    SetActive(this.gotoEventBtn.gameObject, true)
    SetActive(this.getRewardBtn.gameObject, false)
    this.itemParent.localPosition = this.eventItemParentPos1
    if data.eventType == ZXLConst.EventType.Novel then
        SetActive(this.eventNovel, seriesEventComplete == true)
        this.novelTitle.text = data.name
    elseif data.eventType == ZXLConst.EventType.Hard or data.eventType == ZXLConst.EventType.Main or data.eventType == ZXLConst.EventType.Repeat then
        SetActive(this.eventBattle, seriesEventComplete == true)
        this.battleTitle.text = data.name
    elseif data.eventType == ZXLConst.EventType.Play then
        SetActive(this.eventGame, seriesEventComplete == true)
        this.gameTitle.text = data.name
    elseif data.eventType == nil then
        SetActive(this.eventNewGlass, seriesEventComplete == true)
        SetActive(this.gotoEventBtn.gameObject, false)
        this.itemParent.localPosition = this.eventItemParentPos2
    end
    if data.reward then
        this.SetEventReward(data.reward)
    end

    this.RefreshMaterial(true)

    this.RefreshGoalGlass()
    this.DelayHideEventUI()

    local noCompleteDelegateRed = ZXLData.CheckExistNoCompleteDelegate()
    RedMgr.Singleton:SetRedState(ZXLConst.RedPoint.AllPlay, noCompleteDelegateRed)
end

this.DelayHideEventUI = function()
    local callback = function()
        SetActive(this.eventObj, false)
        this.OnClickGetRewardBtn()
    end
    this.eventHideTween = DOTWeen:Sequence()
    local intervalTime = ConfigMgr.Config.constants.ZxlAutoHide or 3
    this.eventHideTween:AppendInterval(intervalTime):OnComplete(callback)
end

this.ClearHideEventUITween = function(isComplete)
    if this.eventHideTween ~= nil then
        this.eventHideTween:Kill(isComplete or false)
        this.eventHideTween = nil
        SetActive(this.eventObj, false)
    end
end

this.SetEventReward = function(rewardDatas)
    if this.rewardItems == nil then

        this.rewardItems = {}
    end
    for key, value in pairs(this.rewardItems) do
        SetActive(value.object, false)
    end
    local scale = 0.5
    for i = 1, #rewardDatas do
        local item = this.rewardItems[i]
        if item ~= nil then
            SetActive(item.object, true)
        else
            item = GoodsDataItem.New(this.itemParent)
            table.insert(this.rewardItems, item)
        end
        local itemConfig = rewardDatas[i]
        item = this.rewardItems[i]
        local itemData = table.Copy(ConfigMgr.Config.itemMap[itemConfig.id])
        item:SetData(i, itemData, 1, false, Vector3(scale, scale, scale), false, itemConfig.count <= 0)
        item:SetCount(string.format("%d", itemConfig.count))
        item:SetIconBg(false)
    end
end

this.HideNewEventUI = function()
    SetActive(this.eventObj, true)
    SetActive(this.eventNovel, false)
    SetActive(this.eventGame, false)
    SetActive(this.eventBattle, false)
    SetActive(this.eventNewGlass, false)
    SetActive(this.eventRepeatGlass, false)
    SetActive(this.itemParent.gameObject, false)
end


this.OnClickBookBtn = function()
    RedMgr.Singleton:FrushRedCondition(ZXLConst.RedPoint.AllPlay)
    RedMgr.Singleton:SetRedState(ZXLConst.RedPoint.AllPlay, 0, UIName.ZXLHomePanel)
    RedMgr.Singleton:SetRedState(ZXLConst.RedPoint.AllPlay, 0, UIName.ZXLGlassCombinePanel)
    LuaMgr.ShowLuaPanel(UIName.ZXLGlassBookPanel)
end

this.OnClickMakeBtn = function()
    SetActive(this.eventObj, false)
    SetActive(this.combineSuccEffect, false)
    local choosedDatas = this.choosedDatas
    local chooseItemCount = type(choosedDatas) == "table" and NumTool.GetLen(choosedDatas) or 0
    if this.goalGlassData == nil or chooseItemCount == 0 then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29408")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local data = {}
    data.Id = this.goalGlassData.ID
    local callback = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            LuaDebug.error("开始游戏请求失败，错误码：" .. tostring(res.code))
            return
        end
        local resultData = res.result
        this.rewardItemDatas = {}
        if type(resultData) == "table" and type(resultData.Reward) == "table" and type(resultData.Reward.Items) == "table" then
            for i, v in pairs(resultData.Reward.Items) do
                local item = {ID = v.id, Count = v.count}
                table.insert(this.rewardItemDatas, item)
            end
            this.OnClickGetRewardBtn()
        end
        ZXLData.GetAllGlassDatas()
        this.CombineSuccess()
    end
    ApiMgr.Request("glassmerge/merge", data, true, callback, nil, true)
end

this.OnClickFormulaBtn = function()
    LuaMgr.ShowLuaPanel(UIName.ZXLGlassFormulaPopup)
end

this.OnClickGotoEventBtn = function()
    local data = this.goalGlassData
    if data == nil then
        return
    end
    if data.eventType == ZXLConst.EventType.Novel then
        local playNovelCallback = function()
            LuaMgr.Back()
        end
        LuaMgr.PlayNovel(data.eventConfig.eventParam, playNovelCallback)
    elseif data.eventType == ZXLConst.EventType.Hard or data.eventType == ZXLConst.EventType.Main or data.eventType == ZXLConst.EventType.Repeat then
        local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
        enterDungeonParams.eventId = data.eventConfig.id
        enterDungeonParams.dungeonId = data.eventConfig.eventParam
        BattlePrepareMgr.BattlePrepare(enterDungeonParams)
    elseif data.eventType == ZXLConst.EventType.Play then
        local tempData = {}
        tempData.passID = data.eventConfig.eventParam
        tempData.name = data.name
        LuaMgr.ShowLuaPanel(UIName.ZXLGamePanel, tempData)
    end
end

this.OnClickGetRewardBtn = function()
    if #this.rewardItemDatas > 0 then
        LuaMgr.ShowItemGetPanel(this.rewardItemDatas)
        this.rewardItemDatas = {}
        this.ClearHideEventUITween(false)
    end
end

this.OnClickMatAddFlag = function()
    this.ClearHideEventUITween()
    local data = {}
    data.chooseCallback = this.OnChooseMaterialRes
    LuaMgr.ShowLuaPanel(UIName.ZXLGlassChooseMatPopup, data)
end


this.OnChooseMaterialRes = function(choosedDatas)
    this.RefreshMaterial(false, choosedDatas)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.BatchInitNode()
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.bookBtn, this.OnClickBookBtn)
        LuaMgr.AddClick(this.makeBtn, this.OnClickMakeBtn)
        LuaMgr.AddClick(this.formulaBtn, this.OnClickFormulaBtn)
        LuaMgr.AddClick(this.gotoEventBtn, this.OnClickGotoEventBtn)
        LuaMgr.AddClick(this.getRewardBtn, this.OnClickGetRewardBtn)
        this.before_awake()
    end,
    before_active = function(vm)
        this.before_active()
    end,
    before_deactive = function(vm)
        this.ClearHideEventUITween(true)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.bookBtn, this.OnClickBookBtn)
        LuaMgr.RemoveClick(this.makeBtn, this.OnClickMakeBtn)
        LuaMgr.RemoveClick(this.formulaBtn, this.OnClickFormulaBtn)
        LuaMgr.RemoveClick(this.gotoEventBtn, this.OnClickGotoEventBtn)
        LuaMgr.RemoveClick(this.getRewardBtn, this.OnClickGetRewardBtn)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)