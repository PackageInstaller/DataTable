
require("ViewModel/ZhiXiangLiu/ViewItem/ZXLGlassItemGroup")
local objs = {
    rewardPrefab = {path = "template/RewardParent", type = UITool.GameObject},
    glassItemGroup = {path = "template/ItemGroup", type = UITool.GameObject},
    glassItemPrefab = {path = "template/GlassItem", type = UITool.GameObject},
    progressText = {path = "root/Middle/CollectProgress/Progress", type = UITool.Text},
    glassScrollView = {path = "root/Middle/GlassList", type = UITool.GameObject},
    icon = {path = "root/Middle/RightGroup/Icon", type = UITool.Image},
    name = {path = "root/Middle/RightGroup/Name", type = UITool.Text},
    desc = {path = "root/Middle/RightGroup/DescGroup/Desc", type = UITool.Text},
    effectTxt = {path = "root/Middle/RightGroup/EffectGroup/Effect", type = UITool.Text},
    rewardGroup = {path = "root/Middle/RightGroup/RewardGroup", type = UITool.GameObject},
    unlockText = {path = "root/Middle/RightGroup/UnlockText", type = UITool.Text},
    gotoBtn = {path = "root/Middle/RightGroup/RewardGroup/GotoBtn", type = UITool.Button},
    againGotoBtn = {path = "root/Middle/RightGroup/RewardGroup/AgainGotoBtn", type = UITool.Button},
    replayBtn = {path = "root/Middle/RightGroup/RewardGroup/ReplayBtn", type = UITool.Button},
    getRewardBtn = {path = "root/Middle/RightGroup/RewardGroup/GetRewardBtn", type = UITool.Button},
    gotObj = {path = "root/Middle/RightGroup/RewardGroup/GotObj", type = UITool.GameObject},
    rewardScrollView = {path = "root/Middle/RightGroup/RewardGroup/RewardList", type = UITool.GameObject},
    glassDetailGroupAnim = {path = "root/Middle/RightGroup", type = UITool.Animator},
    descGroup = {path = "root/Middle/RightGroup/DescGroup", type = UITool.Transform},
    effectGroup = {path = "root/Middle/RightGroup/EffectGroup", type = UITool.GameObject},
    passLevelGroup = {path = "root/Middle/RightGroup/PassLevel", type = UITool.GameObject},
    gameLevelGroup = {path = "root/Middle/RightGroup/GameLevel", type = UITool.GameObject},
    unlockTextBG = {path = "root/Middle/RightGroup/UnlockTextBG", type = UITool.GameObject},
    lockName = {path = "root/Middle/RightGroup/LockName", type = UITool.GameObject}
}

local this = {

    lastSeletedItem = nil,
    detailDescPos1 = Vector3(5.62, -202.4),
    detailDescPos2 = Vector3(5.62, -248.4),
    allActivateBuff = {}
}

this.BatchInitNode = function()
    for i = 1, 3 do
        local name = "scorePassLevel" .. i
        local data = {}
        data.path = string.format("root/Middle/RightGroup/PassLevel/Level%d", i)
        data.type = UITool.GameObject
        objs[name] = data

        local name = "scoreGameLevel" .. i
        local data = {}
        data.path = string.format("root/Middle/RightGroup/GameLevel/Level%d", i)
        data.type = UITool.GameObject
        objs[name] = data
    end
end

this.before_awake = function()
    this.glassScrollViewUI = UIScrollView.New(this.glassScrollView)
    this.rewardScrollViewUI = UIScrollView.New(this.rewardScrollView)
end

this.before_active = function()
    RedMgr.Singleton:UpdateClientRedData(ZXLConst.RedPoint.AllPlay, 0)
    RedMgr.Singleton:UpdateClientRedData(ZXLConst.RedPoint.AllPlay, 0)
    this.RefreshGlassList()
end


this.OnClickGotoBtn = function()
    this.OnIntoChallenge()
end

this.OnClickReplayBtn = function()
    this.OnIntoChallenge()
end

this.OnClickGetRewardBtn = function()
    this.OnGetReward()
end

this.OnIntoChallenge = function()
    local data = this.lastSeletedData
    if data.eventType == ZXLConst.EventType.Novel then
        local playNovelCallback = function()
            LuaMgr.ShowLuaPanel(UIName.ZXLGlassBookPanel)
        end
        LuaMgr.PlayNovel(data.eventConfig.eventParam, playNovelCallback)
    elseif data.eventType == ZXLConst.EventType.Play then
        local tempData = {}
        tempData.passID = data.eventConfig.eventParam
        tempData.name = data.name
        LuaMgr.ShowLuaPanel(UIName.ZXLGamePanel, tempData)
    else
        local glassBuffs = this.allActivateBuff
        local buffIDStr = nil
        if glassBuffs ~= nil then
            buffIDStr = table.concat(glassBuffs, ";")
        end
        local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
        enterDungeonParams.eventId = data.eventConfig.id
        enterDungeonParams.dungeonId = data.eventConfig.eventParam
        if buffIDStr ~= nil then
            enterDungeonParams.extraParams = {"glassmerge", buffIDStr}
        end
        BattlePrepareMgr.BattlePrepare(enterDungeonParams)
    end
end

this.OnGetReward = function()
    local data = this.lastSeletedData
    if data.eventType == nil then
    end
end


this.RefreshGlassList = function()
    this.glassScrollViewUI:Clear(false)
    local itemLen
    local scrollDatas = {}
    local allDatas, allActivateBuff = ZXLData.GetAllGlassDatas()
    this.allActivateBuff = allActivateBuff
    table.sort(allDatas, ZXLData.SortGlassData)
    local len = #allDatas
    local index = 0
    local rowIndex = 0
    local goalRowIndex = 0
    local allCompleteCount = 0
    while index < len do
        itemLen = index + 4 > len and len - index or 4
        rowIndex = rowIndex + 1
        local groupData = {}
        groupData.item = this.glassItemPrefab
        groupData.list = {}
        for i = 1, itemLen do
            if i + index <= len then
                local tempData = {}
                tempData.data = allDatas[i + index]
                tempData.data.isSelected = false
                tempData.clickCallback = this.OnSeletedCallback
                local lastSelectID = ZXLData.GetBookLastSelected()
                local tempDataIndex = tempData.data.Index
                if lastSelectID == nil or lastSelectID == tempDataIndex then
                    tempData.data.isSelected = true
                    ZXLData.SetBookLastSelected(tempDataIndex)
                    goalRowIndex = rowIndex
                end
                if tempData.data.isUnlock == true then
                    allCompleteCount = allCompleteCount + 1
                end
                table.insert(groupData.list, tempData)
                groupData.numIndex = i + index
            end
        end
        index = index + itemLen
        local scrollData = UIScrollData.GetData(this.glassItemGroup, "ZXLGlassItemGroup", 680, 148.3, groupData)
        table.insert(scrollDatas, scrollData)
    end
    this.glassScrollViewUI:SetParams(680, 592)
    this.glassScrollViewUI:SetData(scrollDatas, true)
    this.glassScrollViewUI:MoveToIndex(goalRowIndex)
    this.progressText.text = string.format("<size=30>%d</size>/%d", allCompleteCount, #allDatas)
end



this.OnSeletedCallback = function(glassItem, isRefreshData)
    if isRefreshData == true then
        glassItem:SetSelected(glassItem.data.isSelected)
        if glassItem.data.isSelected == true then
            this.lastSeletedItem = glassItem
            this.lastSeletedData = glassItem.data
            ZXLData.SetBookLastSelected(glassItem.data.Index)
        end
    else
        if this.lastSeletedItem ~= nil then
            this.lastSeletedItem:SetSelected(false)
        end
        if this.lastSeletedData ~= nil then
            this.lastSeletedData.isSelected = false
        end
        this.lastSeletedItem = glassItem
        this.lastSeletedData = glassItem.data
        this.lastSeletedData.isSelected = true
        this.lastSeletedItem:SetSelected(true)
        ZXLData.SetBookLastSelected(glassItem.data.Index)
    end
    local isShowLastSelectData = this.lastSeletedData and this.lastSeletedData.isUnlock == true
    SetActive(this.rewardGroup, isShowLastSelectData)
    SetActive(this.passLevelGroup, isShowLastSelectData)
    SetActive(this.gameLevelGroup, isShowLastSelectData)
    if this.lastSeletedData == nil or this.lastSeletedData.isUnlock == false then
        SetActive(this.unlockText.gameObject, false)
        SetActive(this.unlockTextBG, false)
        SetActive(this.icon.gameObject, false)
        SetActive(this.lockName, true)
        this.RefreshGlassLockInfo()
    else
        SetActive(this.unlockTextBG, true)
        SetActive(this.icon.gameObject, true)
        SetActive(this.lockName, false)
        this.RefreshGlassInfo()
    end
    this.glassDetailGroupAnim:Play("ani_ZXLGlassBookPanel_RightGroup", 0, 0)
end

this.RefreshGlassLockInfo = function()
    SetActive(this.effectGroup, true)
    SetActive(this.gotObj.gameObject, false)
    this.descGroup.localPosition = this.detailDescPos1
    this.name.text = LuaMgr.GetLangText("ZXLGlassBookPanel_0")
    this.desc.text = LuaMgr.GetLangText("ZXLGlassBookPanel_1")
    this.effectTxt.text = LuaMgr.GetLangText("ZXLGlassBookPanel_2")
end

this.RefreshGlassInfo = function()
    local data = this.lastSeletedData
    this.icon.sprite = LuaMgr.GetSprite(ZXLConst.AtlaName, data.config.Icon)
    this.name.text = data.name
    this.desc.text = data.desc
    if data.existEffect == true then
        SetActive(this.effectGroup, true)
        this.descGroup.localPosition = this.detailDescPos1
        this.effectTxt.text = data.effectTxt
    else
        SetActive(this.effectGroup, false)
        this.descGroup.localPosition = this.detailDescPos2
    end
    SetActive(this.passLevelGroup, false)
    SetActive(this.gameLevelGroup, false)
    SetActive(this.gotoBtn.gameObject, false)
    SetActive(this.replayBtn.gameObject, false)
    SetActive(this.getRewardBtn.gameObject, false)
    SetActive(this.gotObj.gameObject, false)
    SetActive(this.unlockText.gameObject, data.canJoin ~= true)
    SetActive(this.rewardGroup, data.canJoin == true)
    if data.canJoin == true then
        if data.eventType == ZXLConst.EventType.Novel then
            SetActive(this.gotoBtn.gameObject, data.status == CommonRewardItem.Status.None)
            SetActive(this.replayBtn.gameObject, data.status == CommonRewardItem.Status.Got)
        elseif data.eventType == ZXLConst.EventType.Play then
            SetActive(this.gameLevelGroup, true)
            SetActive(this.gotoBtn.gameObject, data.status == CommonRewardItem.Status.None)
            SetActive(this.replayBtn.gameObject, data.status == CommonRewardItem.Status.Got)
            for i = 1, 3 do
                local starName = "scoreGameLevel" .. i
                SetActive(this[starName], data.scoreLevel > i)
            end
        elseif data.eventType ~= nil then
            for i = 1, 3 do
                local raringName = "scorePassLevel" .. i
                SetActive(this[raringName], data.scoreLevel == i)
            end
            SetActive(this.passLevelGroup, true)
            SetActive(this.gotoBtn.gameObject, data.status == CommonRewardItem.Status.None)
            SetActive(this.replayBtn.gameObject, data.status == CommonRewardItem.Status.Got)
        else
            SetActive(this.gotObj.gameObject, data.isUnlock == true)
        end
        this.RefreshReward()
    else
        this.unlockText.text = data.unlockText
    end
end

this.RefreshReward = function()
    this.rewardScrollViewUI:Clear()
    local scrollDatas = {}
    local allDatas = this.lastSeletedData.reward
    local len = NumTool.GetLen(allDatas)
    for i = 1, len do
        local data = allDatas[i]
        if this.lastSeletedData.config.Area == ZXLConst.EventType.Repeat then
            data.status = CommonRewardItem.Status.None
        end
        local scrollData = UIScrollData.GetData(this.rewardPrefab, "CommonRewardItem", 80, 80, data)
        table.insert(scrollDatas, scrollData)
    end
    this.rewardScrollViewUI:SetParams(230, 85)
    this.rewardScrollViewUI:SetData(scrollDatas)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        this.BatchInitNode()
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.gotoBtn, this.OnClickGotoBtn)
        LuaMgr.AddClick(this.againGotoBtn, this.OnClickGotoBtn)
        LuaMgr.AddClick(this.replayBtn, this.OnClickReplayBtn)
        LuaMgr.AddClick(this.getRewardBtn, this.OnClickGetRewardBtn)
        this.before_awake()
    end,
    before_active = function(vm)
        if ZXLData.CheckIsSwitchUser() then
            ZXLData.SetBookLastSelected()
        end
        ZXLData.SetLastUserID()
        if vm.behaviour.Params == nil then
            return
        end
        this.before_active()
    end,
    before_deactive = function(vm)
        UIScrollView.ClearItem("ZXLGlassItemGroup")
    end,
    before_destroy = function(vm)
        UIScrollView.ClearItem("ZXLGlassItemGroup")
        UIScrollView.ClearItem("CommonRewardItem")
        LuaMgr.RemoveClick(this.gotoBtn, this.OnClickGotoBtn)
        LuaMgr.RemoveClick(this.againGotoBtn, this.OnClickGotoBtn)
        LuaMgr.RemoveClick(this.replayBtn, this.OnClickReplayBtn)
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