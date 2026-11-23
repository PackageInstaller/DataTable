













SSYXDungeonItem = {}
SSYXDungeonItem.__index = SSYXDungeonItem

local objs = {
    icon = {path = "Group/Icon", type = UITool.Image},
    btn = {path = "Group/Icon", type = UITool.Button},
    iconTrans = {path = "Group/Icon", type = UITool.Transform},
    iconCanvas = {path = "Group/Icon", type = UITool.CanvasGroup},
    lockObj = {path = "Group/Icon/LockObj", type = UITool.GameObject},
    lockName = {path = "Group/Icon/LockObj/Name", type = UITool.Text},
    completeObj = {path = "Group/Icon/CompleteObj", type = UITool.GameObject},
    completeName = {path = "Group/Icon/CompleteObj/Name", type = UITool.Text},
    newObj = {path = "Group/Icon/NewObj", type = UITool.GameObject},
    newName = {path = "Group/Icon/NewObj/Name", type = UITool.Text},
    newFlag = {path = "Group/Icon/NewObj/Flag", type = UITool.GameObject},
    redIconListener = {path = "Group/Icon/NewObj/RedParent", type = UITool.RedIconListener}
}

SSYXDungeonItem.Pos = {
    Up = Vector3(-71, 162.7, 0),
    Down = Vector3(-71, -20, 0)
}

SSYXDungeonItem.New = function()

    local self = {}
    setmetatable(self, SSYXDungeonItem)
    return self
end

function SSYXDungeonItem:Init()
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

        local name1 = "DarkLineGroup" .. i
        local path = "Group/" .. name1
        objs[name1] = {path = path, type = UITool.GameObject}

        local leftDarkName = "Dark_Left" .. i
        local leftDarkPath = string.format("Group/DarkLineGroup%d/Left", i)
        objs[leftDarkName] = {path = leftDarkPath, type = UITool.GameObject}

        local rightDarkName = "Dark_Right" .. i
        local rightDarkPath = string.format("Group/DarkLineGroup%d/Right", i)
        objs[rightDarkName] = {path = rightDarkPath, type = UITool.GameObject}
    end

    for i = 1, 3 do
        local name = "ScoreFlag" .. i
        local path = "Group/Icon/CompleteObj/" .. name
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
        if self.data.DungeonType == SSYXConst.EventType.Hard then
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

function SSYXDungeonItem:SetData(data)
    self.data = data.data
    if self.data.Index % 2 == 0 then
        self:SetLineVisibleByIndex(1)
    else
        self:SetLineVisibleByIndex(2)
    end
    if self.data.Index % 2 == 0 then
        self.icon.transform.localPosition = SSYXDungeonItem.Pos.Up
    else
        self.icon.transform.localPosition = SSYXDungeonItem.Pos.Down
    end
    self:SetIcon()
    SetActive(self.lockObj, false)
    SetActive(self.completeObj, false)
    SetActive(self.newObj, false)
    if self.data.Status == CommonRewardItem.Status.Lock then
        self.iconCanvas.alpha = 0.6
        SetActive(self.lockObj, true)
        self.lockName.text = LuaMgr.GetLangText(self.data.namelan)
    elseif self.data.Status == CommonRewardItem.Status.Got then
        self.iconCanvas.alpha = 1
        self.completeName.text = LuaMgr.GetLangText(self.data.namelan)
        SetActive(self.completeObj, true)
        local score = DataExHelper.GetDungeonDecordRating(self.data.eventParam)
        for i = 1, 3 do
            local name = "ScoreFlag" .. i
            SetActive(self[name], i == score)
        end
    else
        self.newName.text = LuaMgr.GetLangText(self.data.namelan)
        SetActive(self.newObj, true)
        if self.data.DungeonType == SSYXConst.EventType.Hard then
            self:RefrshRedPoint()
        end
    end
end

function SSYXDungeonItem:SetIcon()
    local iconIndex = (self.data.Index - 1) % 3 + 1
    local spriteName = ""
    if self.data.DungeonType == SSYXConst.EventType.Repeat then
        spriteName = string.format("ui_hd_trj_gk_sec_pic_fs%d", iconIndex)
    elseif self.data.DungeonType == SSYXConst.EventType.MainLine then
        spriteName = string.format("ui_hd_trj_gk_sec_pic_gn%d", iconIndex)
    else
        spriteName = string.format("ui_hd_trj_gk_sec_pic_zx%d", iconIndex)
    end
    self.icon.sprite = LuaMgr.GetSprite(SSYXConst.DungeonAtlaName, spriteName)
end

function SSYXDungeonItem:SetLineAllVisible(isLight, isLeft, visible)
    for i = 1, 2 do
        local namePart1 = "Light"
        local namePart2 = "Left"
        if isLight == false then
            namePart1 = "Dark"
        end
        if isLeft == false then
            namePart2 = "Right"
        end
        local name = string.format("%s_%s%d", namePart1, namePart2, i)
        SetActive(self[name], visible)
    end
end

function SSYXDungeonItem:SetLineVisibleByIndex(index)
    local isLock = self.data.Status == CommonRewardItem.Status.Lock
    for i = 1, 2 do
        local nameLight = "LightLineGroup" .. i
        local nameDark = "DarkLineGroup" .. i
        if self.data.IsLast == true then
            SetActive(self[nameLight], false)
            SetActive(self[nameDark], false)
        else
            if isLock == true then
                SetActive(self[nameDark], i == index)
                SetActive(self[nameLight], false)
            else
                SetActive(self[nameDark], false)
                SetActive(self[nameLight], i == index)
            end
        end
    end
end

function SSYXDungeonItem:RefrshRedPoint()
    local dungeonTypeIndex = SSYXConst.EventTypeMapIndex[self.data.DungeonType]
    local redID = string.format("%d_%d", SSYXConst.RedPoint.HardDungeon, dungeonTypeIndex * 100 + self.data.Index)
    self.redIconListener.RedId = redID
    if RedMgr.Singleton:CheckRedCondition(redID) then
        RedMgr.Singleton:UpdateClientRedData(redID, 1)
        RedMgr.Singleton:SetRedState(redID, 1)
        SetActive(self.newFlag, true)
    else
        SetActive(self.newFlag, false)
    end
end

function SSYXDungeonItem:ClearItems()
end

function SSYXDungeonItem:Clear()
    self:ClearItems()
end

function SSYXDungeonItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end