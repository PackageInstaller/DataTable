














JYCSDungeonItem = {}
JYCSDungeonItem.__index = JYCSDungeonItem

local objs = {
    icon = {path = "Group/Icon", type = UITool.Image},
    btn = {path = "Group/Icon", type = UITool.Button},
    iconTrans = {path = "Group/Icon", type = UITool.Transform},
    iconCanvasGroup = {path = "Group/Icon", type = UITool.CanvasGroup},
    iconCanvas = {path = "Group/Icon", type = UITool.Canvas},
    lockObj = {path = "Group/Icon/LockObj", type = UITool.GameObject},
    lockName = {path = "Group/Icon/LockObj/Name", type = UITool.Text},
    completeObj = {path = "Group/Icon/CompleteObj", type = UITool.GameObject},
    completeName = {path = "Group/Icon/CompleteObj/Name", type = UITool.Text},
    newObj = {path = "Group/Icon/NewObj", type = UITool.GameObject},
    newName = {path = "Group/Icon/NewObj/Name", type = UITool.Text},
    newFlag = {path = "Group/Icon/NewObj/Flag", type = UITool.GameObject},
    redIconListener = {path = "Group/Icon/NewObj/RedParent", type = UITool.RedIconListener}
}

JYCSDungeonItem.Pos = {
    Up = Vector3(0, 10.6, 0),
    Down = Vector3(0, -92.7, 0)
}

JYCSDungeonItem.New = function()

    local self = {}
    setmetatable(self, JYCSDungeonItem)
    return self
end

function JYCSDungeonItem:Init()
    for i = 1, 2 do
        local name = "LightLineGroup" .. i
        local path = "Group/" .. name
        objs[name] = {path = path, type = UITool.GameObject}

        local leftLightName = "Light_Left" .. i
        local leftLightPath = string.format("Group/LightLineGroup%d/Left", i)
        objs[leftLightName] = {path = leftLightPath, type = UITool.GameObject}

        local rightLightName = "Light_Right" .. i
        local rightLightPath = string.format("Group/LightLineGroup%d/Right", i)
        objs[rightLightName] = {path = rightLightPath, type = UITool.GameObject}
    end

    for i = 1, 5 do
        local name = "ScoreFlag" .. i
        local path = "Group/Icon/CompleteObj/" .. name
        objs[name] = {path = path, type = UITool.GameObject}
    end
    for i = 1, 3 do
        local name = "DungeonTypeFlag" .. i
        local path = "Group/Icon/" .. name
        objs[name] = {path = path, type = UITool.GameObject}
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
        if self.data.DungeonType == JYCSConst.EventType.Hard then
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

function JYCSDungeonItem:SetData(data)
    self.data = data.data
    if self.data.Index % 2 == 0 then
        self:SetLineVisibleByIndex(2)
    else
        self:SetLineVisibleByIndex(1)
    end
    if self.data.Index % 2 == 0 then
        self.icon.transform.localPosition = JYCSDungeonItem.Pos.Down
    else
        self.icon.transform.localPosition = JYCSDungeonItem.Pos.Up
    end
    self:SetIcon()
    SetActive(self.lockObj, false)
    SetActive(self.completeObj, false)
    SetActive(self.newObj, false)
    if self.data.Status == CommonRewardItem.Status.Lock then
        SetActive(self.lockObj, true)
        self.lockName.text = LuaMgr.GetLangText(self.data.namelan)
    elseif self.data.Status == CommonRewardItem.Status.Got then
        self.completeName.text = LuaMgr.GetLangText(self.data.namelan)
        SetActive(self.completeObj, true)
        local score = DataExHelper.GetDungeonDecordRating(self.data.eventParam)
        for i = 1, 3 do
            local name = "ScoreFlag" .. i
            SetActive(self[name], i == score)
        end
        local name1 = "ScoreFlag4"
        local name2 = "ScoreFlag5"
        SetActive(self[name1], self.data.DungeonType == JYCSConst.EventType.Repeat)
        SetActive(self[name2], self.data.DungeonType == JYCSConst.EventType.MainLine)
    else
        self.newName.text = LuaMgr.GetLangText(self.data.namelan)
        SetActive(self.newObj, true)
        if self.data.DungeonType == JYCSConst.EventType.Hard then
            self:RefrshRedPoint()
        end
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
        SetActive(self[name1], self.data.DungeonType == JYCSConst.EventType.Repeat)
        SetActive(self[name2], self.data.DungeonType == JYCSConst.EventType.Hard)
        SetActive(self[name3], self.data.DungeonType == JYCSConst.EventType.MainLine)
    end
    self.iconCanvas.sortingOrder = self.data.Index
end

function JYCSDungeonItem:SetIcon()
    local iconIndex = (self.data.Index - 1) % 2 + 1
    local spriteName = ""
    if self.data.DungeonType == JYCSConst.EventType.Repeat then
        spriteName = string.format("ui_hd_jycs_gq_img_fs_0%d", iconIndex)
    elseif self.data.DungeonType == JYCSConst.EventType.MainLine then
        spriteName = string.format("ui_hd_jycs_gq_img_zx")
    else
        spriteName = string.format("ui_hd_jycs_gq_img_kn")
    end
    self.icon.sprite = LuaMgr.GetSprite(JYCSConst.AtlasName, spriteName)
end

function JYCSDungeonItem:SetLineAllVisible(isLight, isLeft, visible)
    for i = 1, 2 do
        local namePart1 = "Light"
        local namePart2 = "Left"
        if isLeft == false then
            namePart2 = "Right"
        end
        local name = string.format("%s_%s%d", namePart1, namePart2, i)
        SetActive(self[name], visible)
    end
end

function JYCSDungeonItem:SetLineVisibleByIndex(index)
    for i = 1, 2 do
        local nameLight = "LightLineGroup" .. i
        SetActive(self[nameLight], i == index)
    end
end

function JYCSDungeonItem:RefrshRedPoint()
    local dungeonTypeIndex = JYCSConst.EventTypeMapIndex[self.data.DungeonType]
    local redID = string.format("%d_%d", JYCSConst.RedPoint.HardDungeon, dungeonTypeIndex * 100 + self.data.Index)
    self.redIconListener.RedId = redID
    if RedMgr.Singleton:CheckRedCondition(redID) then
        RedMgr.Singleton:UpdateClientRedData(redID, 1)
        RedMgr.Singleton:SetRedState(redID, 1)
        SetActive(self.newFlag, true)
    else
        SetActive(self.newFlag, false)
    end
end

function JYCSDungeonItem:ClearItems()
end

function JYCSDungeonItem:Clear()
    self:ClearItems()
end

function JYCSDungeonItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end