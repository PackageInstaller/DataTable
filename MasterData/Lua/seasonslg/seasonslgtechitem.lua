



















SeasonSLGTechItem = {}
SeasonSLGTechItem.__index = SeasonSLGTechItem



function SeasonSLGTechItem.GetLineStyleAndTurn(lineType)
    local style = math.floor((lineType % 1000) / 10)
    local turnType = lineType % 1000 % 10
    return style, turnType
end


local objs = {
    rectTrans = {path = "", type = UITool.RectTransform},
    button = {path = "Group", type = UITool.Button},
    unlockObj = {path = "Group/UnlockObj", type = UITool.GameObject},
    canUnlockObj = {path = "Group/CanUnlockObj", type = UITool.GameObject},
    lockObj = {path = "Group/Lock", type = UITool.GameObject},
    icon = {path = "Group/Icon", type = UITool.Image},
    line = {path = "Group/Line", type = UITool.Image},
    lineRect = {path = "Group/Line", type = UITool.RectTransform},
    selectedObj = {path = "Group/SelectedObj", type = UITool.GameObject},
    name = {path = "Group/Name", type = UITool.Text},
    levelGroup = {path = "Group/LevelGroup", type = UITool.GameObject},
    levelText = {path = "Group/LevelGroup/Text", type = UITool.Text},
    canUpgradeFlag = {path = "Group/LevelGroup/CanUpgrade", type = UITool.GameObject},
    fullLevelFlag = {path = "Group/LevelGroup/FullLevel", type = UITool.GameObject},
    upgradeEffect = {path = "Group/eff_levelup", type = UITool.GameObject}
}

SeasonSLGTechItem.New = function(prefab, parent)

    local self = {}
    setmetatable(self, SeasonSLGTechItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    self:Init()
    return self
end

function SeasonSLGTechItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickItem = function()
        if self.data.OnClickTechItem ~= nil then
            self.data.OnClickTechItem(self)
        end
    end
    SetActive(self.upgradeEffect, false)
    LuaMgr.AddClick(self.button, self.OnClickItem)
end




function SeasonSLGTechItem:SetData(data, upTechID)
    self.data = data
    self.gameObject.name = "TechItem_" .. self.data.ID
    SetActive(self.unlockObj, self.data.Status == SeasonSLGConst.TechStatus.Activate)
    SetActive(self.lockObj, self.data.Status == SeasonSLGConst.TechStatus.Default)
    if self.data.Status ~= SeasonSLGConst.TechStatus.Activate then
        SetActive(self.canUnlockObj, true)
        self.icon.sprite = LuaMgr.GetSprite(SeasonSLGConst.SeasonSLGAtlas, self.data.IconName .. "_1")
    else
        if self.data.Config.Tab == SeasonSLGConst.TechType.Person then
            self.icon.sprite = LuaMgr.GetSprite(SeasonSLGConst.SeasonSLGAtlas, self.data.IconName)
        elseif self.data.Config.Tab == SeasonSLGConst.TechType.Guild then
            self.icon.sprite = LuaMgr.GetSprite(SeasonSLGConst.SeasonSLGAtlas, self.data.IconName .. "_gh")
        else
            self.icon.sprite = LuaMgr.GetSprite(SeasonSLGConst.SeasonSLGAtlas, self.data.IconName)
        end
        SetActive(self.canUnlockObj, false)
    end
    self.name.text = SeasonSLGTechMgr.GetTechName(self.data.ID)
    SetActive(self.levelGroup, self.data.Status == SeasonSLGConst.TechStatus.Activate)
    SetActive(self.canUpgradeFlag, self.data.CanUpgrade == true)
    local isMaxLevel = SeasonSLGTechMgr.CheckTechIsMaxLevel(self.data.ID)
    SetActive(self.fullLevelFlag, isMaxLevel == true)
    self.levelText.text = string.format("Lv.%d", self.data.Level)
    self:SetItemPos()
    if upTechID == self.data.ID then
        self:SetUpgradeEffect()
    end
    if self.data.Config.LineType == 0 and type(self.data.Config.Unlock) == "table" and #self.data.Config.Unlock == 0 then
        self.gameObject.transform.localScale = Vector3.one * 0.8
    else
        self.gameObject.transform.localScale = Vector3.one
    end
end

function SeasonSLGTechItem:SetUpgradeEffect()
    local closeCallback = function()
        SetActive(self.upgradeEffect, false)
    end
    local func = function()
        SetActive(self.upgradeEffect, true)
        if self.effectTween ~= nil then
            self.effectTween:Kill(false)
        end
        self.effectTween = DOTWeen:Sequence()
        self.effectTween:AppendInterval(1):OnComplete(closeCallback)
    end
    if self.upgradeEffect.activeSelf == true then
        SetActive(self.upgradeEffect, false)
        LuaMgr.NextFrame(func)
    else
        func()
    end
end

function SeasonSLGTechItem:SetItemPos()
    self.rectTrans.anchoredPosition = Vector2(self.data.PosX, self.data.PosY)
end

function SeasonSLGTechItem:SetSelected(isSelected)
    SetActive(self.selectedObj, isSelected)
end

function SeasonSLGTechItem:RefreshLine(isShow, isLight)
    if isShow == false then
        SetActive(self.line.gameObject, false)
        return
    end
    local prefix = "dark"
    if isLight == true then
        prefix = "light"
    end
    local lineType = self.data.Config.LineType
    if lineType == 0 or lineType == nil then
        SetActive(self.line.gameObject, false)
        return
    end
    SetActive(self.line.gameObject, true)
    local style, turnType = SeasonSLGTechItem.GetLineStyleAndTurn(lineType)
    local resName = string.format("tech_line_%s%d", prefix, style)
    self.line.sprite = LuaMgr.GetSprite(SeasonSLGConst.SeasonSLGAtlas, resName)
    self.line:SetNativeSize()
    if type(self.data.Config.Size) == "table" and #self.data.Config.Size > 0 then
        local sizeX = self.data.Config.Size[1]
        local sizeY = self.data.Config.Size[2]
        self.lineRect.sizeDelta = Vector2(sizeX, sizeY)
    end
    if type(self.data.Config.LinePoint) == "table" and #self.data.Config.LinePoint > 0 then
        local pointX = self.data.Config.LinePoint[1]
        local pointY = self.data.Config.LinePoint[2]
        self.lineRect.anchoredPosition = Vector2(pointX, pointY)
    end
    if turnType == SeasonSLGConst.ItemLineType.Horizonal then
        self.lineRect.localScale = Vector3(-1, 1, 1)
    elseif turnType == SeasonSLGConst.ItemLineType.Vertical then
        self.lineRect.localScale = Vector3(1, -1, 1)
    elseif turnType == SeasonSLGConst.ItemLineType.HorizonalVertical then
        self.lineRect.localScale = Vector3(-1, -1, 1)
    else
        self.lineRect.localScale = Vector3.one
    end
end



function SeasonSLGTechItem:SetNextItems(itemDic)
    self.nextItems = itemDic
end

function SeasonSLGTechItem:ClearItems()
    self.nextItems = nil
end

function SeasonSLGTechItem:Clear()
    self:ClearItems()
end

function SeasonSLGTechItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
    self.nextItems = nil
end