












WJWYDungeonItem = {}
WJWYDungeonItem.__index = WJWYDungeonItem

local objs = {
    icon = { path = "Group/Icon", type = UITool.Image },
    btn = { path = "Group/Icon", type = UITool.Button },
    iconTrans = { path = "Group/Icon", type = UITool.Transform },
    iconCanvasGroup = { path = "Group/Icon", type = UITool.CanvasGroup },
    iconCanvas = { path = "Group/Icon", type = UITool.Canvas },
    nameText = { path = "Group/Icon/Name", type = UITool.Text },
    lockObj = { path = "Group/Icon/LockObj", type = UITool.GameObject },
    completeObj = { path = "Group/Icon/CompleteObj", type = UITool.GameObject },
    newObj = { path = "Group/Icon/NewObj", type = UITool.GameObject },
    newFlag = { path = "Group/Icon/NewObj/Flag", type = UITool.GameObject },
    redIconListener = { path = "Group/Icon/NewObj/RedParent", type = UITool.RedIconListener }
}

WJWYDungeonItem.Pos = {
    Up = Vector3(0, 10.6, 0),
    Down = Vector3(0, -92.7, 0)
}

WJWYDungeonItem.New = function()

    local self = {}
    setmetatable(self, WJWYDungeonItem)
    return self
end

function WJWYDungeonItem:Init()
    for i = 1, 2 do
        local name = "LightLineGroup" .. i
        local path = "Group/" .. name
        objs[name] = { path = path, type = UITool.GameObject }

        local leftLightName = "Light_Left" .. i
        local leftLightPath = string.format("Group/LightLineGroup%d/Left", i)
        objs[leftLightName] = { path = leftLightPath, type = UITool.GameObject }

        local rightLightName = "Light_Right" .. i
        local rightLightPath = string.format("Group/LightLineGroup%d/Right", i)
        objs[rightLightName] = { path = rightLightPath, type = UITool.GameObject }
    end

    for i = 1, 5 do
        local name = "ScoreFlag" .. i
        local path = "Group/Icon/CompleteObj/" .. name
        objs[name] = { path = path, type = UITool.GameObject }
    end
    for i = 1, 3 do
        local name = "DungeonTypeFlag" .. i
        local path = "Group/Icon/" .. name
        objs[name] = { path = path, type = UITool.GameObject }
    end
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickBtn = function()
        if self.data.Status == CommonRewardItem.Status.Lock then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, self.data.UnlockDesc)
            return
        end
        local enterDungeonParams = BattlePrepareMgr.GetDefaultEnterDungeonParams()
        enterDungeonParams.eventId = self.data.id
        enterDungeonParams.dungeonId = self.data.eventParam
        BattlePrepareMgr.BattlePrepare(enterDungeonParams)
        if self.data.DungeonType == WJWYConst.EventType.Hard then
            RedMgr.Singleton:UpdateClientRedData(self.redIconListener.RedId, 0)
            RedMgr.Singleton:FrushRedCondition(self.redIconListener.RedId)
        end
        SetActive(self.newFlag, false)
        if self.data.OnClickDungeon ~= nil then
            self.data.OnClickDungeon(self)
        end
    end
    LuaMgr.AddClick(self.btn, self.OnClickBtn)
end

function WJWYDungeonItem:SetData(data)
    self.data = data.data
    self:SetLineVisible()
    if self.data.Index % 2 == 0 then
        self.icon.transform.localPosition = WJWYDungeonItem.Pos.Down
    else
        self.icon.transform.localPosition = WJWYDungeonItem.Pos.Up
    end
    self:SetIcon()
    SetActive(self.lockObj, false)
    SetActive(self.completeObj, false)
    SetActive(self.newObj, false)
    if self.data.Status == CommonRewardItem.Status.Lock then
        SetActive(self.lockObj, true)
        self.nameText.text = LuaMgr.GetLangText(self.data.namelan)
        self.nameText.color = HexToRGBA("#617274")
    elseif self.data.Status == CommonRewardItem.Status.Got then
        self.nameText.text = LuaMgr.GetLangText(self.data.namelan)
        self.nameText.color = HexToRGBA("#E34EC0")
        SetActive(self.completeObj, true)
        local score = DataExHelper.GetDungeonDecordRating(self.data.eventParam)
        for i = 1, 3 do
            local name = "ScoreFlag" .. i
            SetActive(self[name], i == score)
        end
        local name1 = "ScoreFlag4"
        local name2 = "ScoreFlag5"
        SetActive(self[name1], self.data.DungeonType == WJWYConst.EventType.Repeat)
        SetActive(self[name2], self.data.DungeonType == WJWYConst.EventType.MainLine)
    else
        self.nameText.text = LuaMgr.GetLangText(self.data.namelan)
        self.nameText.color = HexToRGBA("#E34EC0")

        SetActive(self.newObj, true)



    end
    if self.data.Status == CommonRewardItem.Status.Lock then
        for i = 1, 3 do
            local name = "DungeonTypeFlag" .. i
            SetActive(self[name], false)
        end
    else
        local name1 = "DungeonTypeFlag1"
        local name2 = "DungeonTypeFlag2"
        local name3 = "DungeonTypeFlag3"
        SetActive(self[name1], self.data.DungeonType == WJWYConst.EventType.Repeat)
        SetActive(self[name2], self.data.DungeonType == WJWYConst.EventType.Hard)
        SetActive(self[name3], self.data.DungeonType == WJWYConst.EventType.MainLine)
    end
    self.iconCanvas.sortingOrder = self.data.Index
end

function WJWYDungeonItem:SetIcon()
    local iconIndex = (self.data.Index - 1) % 2 + 1
    local spriteName = ""
    if self.data.DungeonType == WJWYConst.EventType.Repeat then
        spriteName = string.format("ui_hd_wjwy_gq0%d", iconIndex)
    elseif self.data.DungeonType == WJWYConst.EventType.MainLine then
        spriteName = string.format("ui_hd_wjwy_gq04")
    else
        spriteName = string.format("ui_hd_wjwy_gq05")
    end
    self.icon.sprite = LuaMgr.GetSprite(WJWYConst.AtlasName, spriteName)
end

function WJWYDungeonItem:SetLineVisible()
    if self.data.Index % 2 == 0 then
        SetActive(self.LightLineGroup1, false)
        SetActive(self.LightLineGroup2, false)
        SetActive(self.Light_Left1, false)
        SetActive(self.Light_Left2, false)
        SetActive(self.Light_Right1, false)
        SetActive(self.Light_Right2, false)
        return
    end

    local isUnlock = self.data.Status ~= CommonRewardItem.Status.Lock
    SetActive(self.LightLineGroup1, true)
    SetActive(self.LightLineGroup2, true)

    local preData = self.data.PreData
    local nextData = self.data.NextData
    if preData == nil or nextData == nil then
        local eventList = WJWYData.GetActiveEventsByArea(self.data.DungeonType)
        if eventList ~= nil then
            if preData == nil and self.data.Index > 1 then
                preData = eventList[self.data.Index - 1]
            end
            if nextData == nil and self.data.Index < #eventList then
                nextData = eventList[self.data.Index + 1]
            end
        end
    end

    if preData ~= nil and not self.data.IsFirst then
        local isPreUnlock = preData.Status ~= CommonRewardItem.Status.Lock
        SetActive(self.Light_Left1, isPreUnlock)
        SetActive(self.Light_Left2, not isPreUnlock)
    else
        SetActive(self.Light_Left1, false)
        SetActive(self.Light_Left2, false)
    end

    if nextData ~= nil and not self.data.IsLast then
        SetActive(self.Light_Right1, isUnlock)
        SetActive(self.Light_Right2, not isUnlock)
    else
        SetActive(self.Light_Right1, false)
        SetActive(self.Light_Right2, false)
    end
end

function WJWYDungeonItem:RefrshRedPoint()
    local dungeonTypeIndex = WJWYConst.EventTypeMapIndex[self.data.DungeonType]
    local redID = string.format("%d_%d", WJWYConst.RedPoint.HardDungeon, dungeonTypeIndex * 100 + self.data.Index)
    self.redIconListener.RedId = redID
    if RedMgr.Singleton:CheckRedCondition(redID) then
        RedMgr.Singleton:UpdateClientRedData(redID, 0)
        RedMgr.Singleton:SetRedState(redID, 0)
        SetActive(self.newFlag, true)
    else
        SetActive(self.newFlag, false)
    end
end

function WJWYDungeonItem:ClearItems()
end

function WJWYDungeonItem:Clear()
    self:ClearItems()
end

function WJWYDungeonItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end