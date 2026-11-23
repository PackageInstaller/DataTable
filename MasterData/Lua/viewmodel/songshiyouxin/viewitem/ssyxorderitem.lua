
















SSYXOrderItem = {}
SSYXOrderItem.__index = SSYXOrderItem
SSYXOrderItem.TalkLan = {
    "LangGlobalLan_LangGlobal_name_29879",
    "LangGlobalLan_LangGlobal_name_29880",
    "LangGlobalLan_LangGlobal_name_29881",
    "LangGlobalLan_LangGlobal_name_29882",
    "LangGlobalLan_LangGlobal_name_29883"
}

local objs = {
    orderObj = {path = "OrderObj", type = UITool.GameObject},
    remainTimeObj = {path = "RemainTimeObj", type = UITool.GameObject},
    lockObj = {path = "LockObj", type = UITool.GameObject},
    talkContent = {path = "OrderObj/Talk/Content", type = UITool.Text},
    tradeBtn = {path = "OrderObj/TradeBtn", type = UITool.Button},
    noTradeObj = {path = "OrderObj/TradeBtn/NoTradeObj", type = UITool.GameObject},
    canTradeObj = {path = "OrderObj/TradeBtn/CanTradeObj", type = UITool.GameObject},
    refreshBtn = {path = "OrderObj/RefreshBtn", type = UITool.Button},
    characterParent = {path = "OrderObj/CharacterParent", type = UITool.Transform},
    leftDownTime = {path = "RemainTimeObj/DownTime", type = UITool.Text},
    remainRefreshProgress = {path = "RemainTimeObj/Progress", type = UITool.Image},
    fastComplateBtn = {path = "RemainTimeObj/FastComplateBtn", type = UITool.Button},
    unlockDesc = {path = "LockObj/UnlockDesc", type = UITool.Text},
    spineCharacter = {path = "OrderObj/CharacterParent/CharacterTex", type = UITool.UISpineCharacter}
}

SSYXOrderItem.New = function(obj)

    local self = {}
    setmetatable(self, SSYXOrderItem)
    self.gameObject = obj
    self:Init()
    return self
end

function SSYXOrderItem:Init()
    for i = 1, 2 do
        local needMatObjName = "MatItemObj" .. i
        local path = string.format("OrderObj/NeedMat/%s", needMatObjName)
        objs[needMatObjName] = {path = path, type = UITool.GameObject}
    end
    for i = 1, 4 do
        local rewardObjName = "RewardItemObj" .. i
        local path = string.format("OrderObj/Reward/%s", rewardObjName)
        objs[rewardObjName] = {path = path, type = UITool.GameObject}
    end
    UITool.Parse(self.gameObject, self, objs)

    self.needMatItems = {}

    self.rewardItems = {}
    for i = 1, 2 do
        local needMatObjName = "MatItemObj" .. i
        local needMatItem = SSYXMakeMatItem.New(self[needMatObjName])
        self.needMatItems[i] = needMatItem
        SetActive(needMatItem.gameObject, false)
    end
    for i = 1, 4 do
        local rewardObjName = "RewardItemObj" .. i
        local rewardItem = SSYXMakeMatItem.New(self[rewardObjName])
        self.rewardItems[i] = rewardItem
        SetActive(rewardItem.gameObject, false)
    end
    self.OnClickTradeBtn = function()
        if self.data.CanTrade == false then
            return
        end
        local curCount, maxCount = SSYXData.GetOrderNum()
        if curCount >= ConfigMgr.Config.OperateConstants.DailyMaximumOrderSubmission then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_30031"))
            return
        end
        local onSucc = function(result)
            local res = json.decode(result)
            if res.code ~= nil and res.code ~= 0 then
                return
            end
            local tempData = SSYXData.RefreshSingleOrderData(self.data.Index)
            self:SetData(tempData)
            LuaMgr.InvokeUIEventListeners(UIEventConst.SSYXOrderRefresh, self.data)
        end
        local data = {}
        data.Ids = {}
        table.insert(data.Ids, self.data.ID)
        
        ApiMgr.Request("operateOrder/order_finish", data, true, onSucc, nil, true)
    end

    self.OnClickRefreshBtn = function()
        local onSucc = function(result)
            local res = json.decode(result)
            if res.code ~= nil and res.code ~= 0 then
                return
            end
            local tempData = SSYXData.RefreshSingleOrderData(self.data.Index)
            self:SetData(tempData)
        end
        local data = {}
        data.Id = self.data.ID
        ApiMgr.Request("operateOrder/order_refresh", data, true, onSucc, nil, true)
    end

    self.OnClickFastComplateBtn = function()
        if self.data.OnFastComplateBtn ~= nil then
            self.data.OnFastComplateBtn(self)
        end
    end
    LuaMgr.AddClick(self.tradeBtn, self.OnClickTradeBtn)
    LuaMgr.AddClick(self.refreshBtn, self.OnClickRefreshBtn)
    LuaMgr.AddClick(self.fastComplateBtn, self.OnClickFastComplateBtn)
end

function SSYXOrderItem:SetData(data)
    self.data = data
    SetActive(self.lockObj, self.data.IsUnlock == false)
    local curTime = LuaMgr.Timestamp()
    local leftTime = self.data.EndTime - curTime
    SetActive(self.orderObj, self.data.IsUnlock == true and leftTime < 0)
    SetActive(self.remainTimeObj, self.data.IsUnlock == true and leftTime >= 0)
    self.TimerID = TimerConst.SSYXOrderRefreshTimer * 1000 + self.data.Index
    if self.data.IsUnlock == false then
        self.unlockDesc.text = LuaMgr.GetLangText(self.data.UnlockDesc)
    else
        if leftTime >= 0 then
            self.OnRefrshTime = function()
                self:RefreshTime()
            end
            LuaMgr.AddTimer(self.TimerID, self.OnRefrshTime, 1, -1, true)
        end
        local randomIndex = math.random(1, #SSYXOrderItem.TalkLan)
        if randomIndex == 3 then
            local lanStr = LuaMgr.GetLangText(SSYXOrderItem.TalkLan[randomIndex])
            self.talkContent.text = string.format(lanStr, DataMgr.Player.name)
        else
            self.talkContent.text = LuaMgr.GetLangText(SSYXOrderItem.TalkLan[randomIndex])
        end
        SetActive(self.noTradeObj, self.data.CanTrade == false)
        SetActive(self.canTradeObj, self.data.CanTrade == true)
        for i = 1, 2 do
            local itemConfig = self.data.TaskConfig.RequiredMaterials[i]
            if itemConfig ~= nil then
                local data = {}
                data.ID = itemConfig.id
                data.IsInBag = false
                local ownerCount = SSYXData.GetItemCountByID(itemConfig.id)
                if ownerCount >= itemConfig.count then
                    data.NumText = string.format("%d/%d", ownerCount, itemConfig.count)
                    data.ConsumeIsEnough = true
                else
                    data.NumText = string.format("<color=#C33D20>%d</color>/%d", ownerCount, itemConfig.count)
                    data.ConsumeIsEnough = false
                end
                self.needMatItems[i]:SetData(data)
                SetActive(self.needMatItems[i].gameObject, true)
            else
                SetActive(self.needMatItems[i].gameObject, false)
            end
        end
        for i = 1, 4 do
            local rewardData = self.data.RewardDatas[i]
            if rewardData ~= nil and rewardData.ID ~= SSYXConst.GamePropsID1 and rewardData.ID ~= SSYXConst.GamePropsID2 then
                rewardData.NumText = tostring(rewardData.Count)
                self.rewardItems[i]:SetData(rewardData)
                SetActive(self.rewardItems[i].gameObject, true)
            else
                SetActive(self.rewardItems[i].gameObject, false)
            end
        end
    end
    local characterId = self.data.CharacterID or "V0076"
    local characterCfg = ConfigMgr.Config.characterTable[characterId]
    self.spineCharacter:SetBattle(characterId, characterId .. "001", "-1", characterCfg.job)
    self.spineCharacter:Play("house_idle", true, nil)
end

function SSYXOrderItem:RefreshTime()
    local curTime = LuaMgr.Timestamp()
    local leftTime = self.data.EndTime - curTime
    if leftTime >= 0 then
        self.remainRefreshProgress.fillAmount = (self.data.RefreshSecond - leftTime) / self.data.RefreshSecond
        local h, m, s = GetTimeHMS(leftTime)
        self.leftDownTime.text = string.format("%02d:%02d:%02d", h, m, s)
    else
        LuaMgr.RemoveTimer(self.TimerID)
        self:SetData(SSYXData.RefreshSingleOrderData(self.data.Index))
    end
end

function SSYXOrderItem:ClearItems()
    for i = 1, 2 do
        self.needMatItems[i]:Clear()
        SetActive(self.needMatItems[i].gameObject, false)
    end
    for i = 1, 4 do
        self.rewardItems[i]:Clear()
        SetActive(self.rewardItems[i].gameObject, false)
    end
    LuaMgr.RemoveTimer(self.TimerID)
end

function SSYXOrderItem:Clear()
    self:ClearItems()
end

function SSYXOrderItem:Destroy()
    self.spineCharacter:Clear()
    self.gameObject = nil
end