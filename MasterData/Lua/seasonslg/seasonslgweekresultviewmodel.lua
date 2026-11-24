require("SeasonSLG/EventPopUp/BossBuffItem")

local this = {
    rewardItemList = nil,
    buffItemList = nil,
    buffUIList = nil,
    curHeatBuffGroup = nil,
    resultData = nil,
    showNovelType = nil,
    parsedData = nil,
}

local objs = {
    maskBtn = { path = "root/Mask", type = UITool.Button },
    buffItemObj = { path = "template/buffItem", type = UITool.GameObject },
    textWeekNum = { path = "root/Middle/Result/TextWeekNum", type = UITool.Text },
    textContent = { path = "root/Middle/Result/ScrollView/Viewport/Content/TextContent", type = UITool.Text },
    missionRatio = { path = "root/Middle/Result/missionRatio", type = UITool.GameObject },
    missionText = { path = "root/Middle/Result/missionRatio/missionText", type = UITool.Text },
    imageMissionSlider = { path = "root/Middle/Result/missionRatio/ImageMissionSlider", type = UITool.Image },
    imageMissionSliderTF = { path = "root/Middle/Result/missionRatio/ImageMissionSlider", type = UITool.Transform },
    textMissionRatio = { path = "root/Middle/Result/missionRatio/ImageMissionSlider/TextRatio", type = UITool.Text },
    bossRatio = { path = "root/Middle/Result/bossRatio", type = UITool.GameObject },
    bossText = { path = "root/Middle/Result/bossRatio/bossText", type = UITool.Text },
    imageBossSlider = { path = "root/Middle/Result/bossRatio/ImageBossSlider", type = UITool.Image },
    imageBossSliderTF = { path = "root/Middle/Result/bossRatio/ImageBossSlider", type = UITool.Transform },
    textBossRatio = { path = "root/Middle/Result/bossRatio/ImageBossSlider/TextRatio", type = UITool.Text },
    imageBuff = { path = "root/Middle/Result/ImageBuff", type = UITool.GameObject },
    buffLab = { path = "root/Middle/Result/ImageBuff/RewardLab", type = UITool.Text },
    buffsTF = { path = "root/Middle/Result/ImageBuff/ScrollView/Viewport/Rewards", type = UITool.Transform },
    imageReward = { path = "root/Middle/Result/ImageReward", type = UITool.GameObject },
    rewardLab = { path = "root/Middle/Result/ImageReward/RewardLab", type = UITool.Text },
    rewardsTF = { path = "root/Middle/Result/ImageReward/ScrollView/Viewport/Rewards", type = UITool.Transform },
}

local function SetProgressBar(imgComp, ratio)
    ratio = math.max(0, math.min(1, tonumber(ratio) or 0))
    if imgComp ~= nil then
        imgComp.fillAmount = ratio
    end
end

this.SetData = function(data)
    this.resultData = data or {}
    if this.textWeekNum ~= nil then
        local weekStr = tostring(this.resultData.weekNum or 1)
        this.textWeekNum.text = string.format(LuaMgr.GetLangText("SeasonSLGWeekResultViewModel_0"), weekStr)
    end
    if this.textContent ~= nil then
        this.textContent.text = this.resultData.content or ""
    end
    local mRatio = tonumber(this.resultData.missionRatio) or 0
    SetProgressBar(this.imageMissionSlider, mRatio)
    if this.missionText ~= nil and this.resultData.missionText ~= nil then
        this.missionText.text = this.resultData.missionText
    end
    if this.textMissionRatio ~= nil then
        this.textMissionRatio.text = this.resultData.missionRatioText or string.format("%d%%", math.floor(mRatio * 100))
    end








    this.SetBuffs(this.resultData.buffs)
    this.SetRewards(this.resultData.rewards)
end

this.SetBuffs = function(buffList)
    if this.imageBuff == nil then return end
    local buffIds = {}
    if buffList ~= nil and #buffList > 0 then
        for _, v in ipairs(buffList) do
            table.insert(buffIds, v)
        end
    end

    if #buffIds == 0 then
        SetActive(this.imageBuff, false)
        if this.buffUIList ~= nil then
            this.buffUIList:Clear()
        end
        this.curHeatBuffGroup = nil
        return
    end

    SetActive(this.imageBuff, true)
    if this.buffUIList == nil and this.buffsTF ~= nil then
        this.buffUIList = UIListView.New(this.buffsTF)
    end
    if this.buffUIList == nil then return end

    this.buffUIList:Clear()
    this.curHeatBuffGroup = buffIds

    local list = {}
    local buffItemObj = this.buffItemObj
    for i, v in ipairs(this.curHeatBuffGroup) do
        local seasonalBuff = ConfigMgr.Config.SeasonalBuffMap and
            (ConfigMgr.Config.SeasonalBuffMap[v] or ConfigMgr.Config.SeasonalBuffMap[tostring(v)])
        if seasonalBuff ~= nil then
            local buffItem = {
                icon = LuaMgr.GetSprite("BuffIcon", seasonalBuff.BuffIcon),
                name = LuaMgr.GetLangText(seasonalBuff.BuffNameLan),
                index = i,
                callBack = this.BuffClickCallBack,
            }
            local buffData = UIListData.GetData(buffItemObj, "BossBuffItem", buffItem)
            table.insert(list, buffData)
        end
    end

    this.buffUIList:SetData(list)
end

this.BuffClickCallBack = function(index)
    if this.curHeatBuffGroup == nil then
        return
    end
    local buffId = this.curHeatBuffGroup[index]
    if buffId ~= nil then
        LuaMgr.ShowLuaPanel(UIName.SeasonSlGEventBuffDesPopUpViewModel, buffId)
    end
end

this.DestroyBuffs = function()
    if this.buffUIList ~= nil then
        this.buffUIList:Clear()
        this.buffUIList:Destroy()
        this.buffUIList = nil
    end
    UIListView.ClearItem("BossBuffItem")
    this.curHeatBuffGroup = nil
    this.buffItemList = nil
end

this.SetRewards = function(rewardList)
    if this.imageReward == nil then return end
    if this.rewardItemList == nil then
        this.rewardItemList = {}
    end
    local items = rewardList
    local index = 0
    if items ~= nil and not IsNull(items) then
        SetActive(this.imageReward, true)
        for _, v in pairs(items) do
            index = index + 1
            local item = this.rewardItemList[index]
            if item == nil and this.rewardsTF ~= nil then
                item = GoodsDataItem.New(this.rewardsTF)
                this.rewardItemList[index] = item
            end
            if item ~= nil then
                if ConfigMgr.Config.itemMap and ConfigMgr.Config.itemMap[v.id] then
                    local itemData = table.Copy(ConfigMgr.Config.itemMap[v.id])
                    itemData.count0 = v.count or 1
                    item:SetData(1, itemData, 1, false, Vector3(0.6, 0.6, 1), false)
                    item:SetIconBg(false)
                end
                if item.gameObject ~= nil then
                    SetActive(item.gameObject, true)
                end
            end
        end
    else
        SetActive(this.imageReward, false)
    end
    local totalLen = #this.rewardItemList
    for i = index + 1, totalLen do
        if this.rewardItemList[i] ~= nil then
            if this.rewardItemList[i].Hide ~= nil then
                this.rewardItemList[i]:Hide()
            elseif this.rewardItemList[i].gameObject ~= nil then
                SetActive(this.rewardItemList[i].gameObject, false)
            end
        end
    end
end

this.DestroyRewards = function()
    if this.rewardItemList ~= nil then
        for _, item in pairs(this.rewardItemList) do
            if item ~= nil and item.Clear ~= nil then
                item:Clear()
            end
        end
        this.rewardItemList = nil
    end
end

this.OnClickClose = function()
    ApiMgr.Request("seasonal/report/read", { Id = this.parsedData.Id },
        true,
        function(result) end, nil, true, true);
    LuaMgr.HidePanel(UIName.SeasonSLGWeekResultViewModel)
    if (this.showNovelType ~= nil) then
        local novelId = this.parsedData.GridMap.NarrativeId[this.showNovelType]
        LuaMgr.PlayNovel(novelId, function()
            LuaMgr.Back()
        end)
    end
end

local data = {}
local command = {}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        if this.maskBtn ~= nil then
            LuaMgr.AddClick(this.maskBtn, this.OnClickClose)
        end
        if this.buffsTF ~= nil then
            this.buffUIList = UIListView.New(this.buffsTF)
        end
    end,
    before_active = function(vm)
        this.parsedData = nil
        if (vm.behaviour.Params == nil) then return end
        if vm.behaviour.Params.Length > 0 then
            this.parsedData = vm.behaviour.Params[0]
        end
        local data = {}
        if this.parsedData ~= nil then
            data.weekNum = this.parsedData.Id
            data.content = this.ParseParams(this.parsedData)
            local taskData = nil
            local taskConfig = nil
            for i, v in ipairs(this.parsedData.GridMap.TaskGroupId) do
                local cache = DataMgr.Player.SeasonalTasks[v]
                if (cache ~= nil and cache.current >= cache.target) then
                    taskData = cache
                    taskConfig = ConfigMgr.Config.SeasonalTaskMap[v]
                end
            end
            local current = tonumber(taskData and taskData.current) or 0
            local target = tonumber(taskData and taskData.target) or 1
            data.missionRatio = current / target
            data.missionRatioText = math.floor((current / target) * 100) .. "%"





            data.Report = this.parsedData.Report
            data.GridMap = this.parsedData.GridMap
            if this.parsedData.GridMap ~= nil then
                data.bossId = this.parsedData.GridMap.BossID
            end
            if (taskConfig == nil) then
                LuaDebug.error("ConfigMgr.Config.SeasonalTaskMap配置读取失败")
            else
                if taskConfig.BuffReward ~= nil then
                    data.buffs = taskConfig.BuffReward
                end
                if taskConfig.Reward ~= nil then
                    data.rewards = taskConfig.Reward
                end
            end
        end



        this.SetData(data)
    end,
    before_deactive = function(vm)
        this.resultData = nil
        if this.buffUIList ~= nil then
            this.buffUIList:Clear()
        end
        this.curHeatBuffGroup = nil
    end,
    before_destroy = function(vm)
        if this.maskBtn ~= nil then
            LuaMgr.RemoveClick(this.maskBtn, this.OnClickClose)
        end
        this.DestroyBuffs()
        this.DestroyRewards()
    end,
}

this.ParseParams = function(params)
    local data = ""
    local configTypeDesList = {}
    for i, v in ipairs(params.GridMap.StatisticsType) do
        local cache = {}
        local land = params.GridMap.LangId[i]
        cache.type = v
        cache.land = land
        table.insert(configTypeDesList, cache)
    end
    table.sort(configTypeDesList, function(a, b) return a.type < b.type end)
    local num = 0
    for k, v in ipairs(configTypeDesList) do
        local cache = params.Report[tostring(v.type)]
        if (cache ~= nil) then
            num = num + 1
            if (v.type == 1 or v.type == 2) then
                this.showNovelType = v.type
                local taskConfig = ConfigMgr.Config.SeasonalTaskMap[cache]
                local taskName = LuaMgr.GetLangText(taskConfig.NameLan)
                local str = string.format(ConfigMgr.LangGlobal(v.land), taskName)
                data = data .. str .. "\n\n"
            elseif (v.type == 5) then
                local bossConfig = ConfigMgr.Config.SeasonalGridBOSSMap[params.GridMap.BossID]
                local name = LuaMgr.GetLangText(bossConfig.NameLan)
                local str = string.format(ConfigMgr.LangGlobal(v.land), cache, name)
                data = data .. str .. "\n\n"
            else
                local str = string.format(ConfigMgr.LangGlobal(v.land), cache)
                data = data .. str .. "\n\n"
            end
        end
    end
    if data ~= "" then
        data = data .. "\n"
    end
    return data
end

return vm({
    data = data,
    command = command,
    hook = hook
})