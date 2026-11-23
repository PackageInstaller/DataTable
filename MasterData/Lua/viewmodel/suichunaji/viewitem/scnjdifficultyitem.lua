






SCNJDifficultyItem = {}
SCNJDifficultyItem.__index = SCNJDifficultyItem

local objs = {
    lineObj = {path = "Group/Line", type = UITool.GameObject},
    selectedObj = {path = "Group/Selected", type = UITool.GameObject},
    percentText = {path = "Group/Percent", type = UITool.Text},
    percentTextOutLine = {path = "Group/Percent", type = UITool.OutlineEx},
    lockObj = {path = "Group/Lock", type = UITool.GameObject},
    button = {path = "Group", type = UITool.Button}
}

SCNJDifficultyItem.New = function()

    local self = {}
    setmetatable(self, SCNJDifficultyItem)
    return self
end

function SCNJDifficultyItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickItem = function()
        local data = self.data.data
        if data.IsUnlock == false then
            local tipsLan = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29612")
            local needNumStr = string.format("%d %0.f%%", data.NeedHotLevel, data.NeedHotProgress / SCNJConst.HotExpPercentBase * 100)
            local tipsContent = string.format(tipsLan, needNumStr)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
            return
        end
        if self.data.clickCallback ~= nil then
            self.data.clickCallback(self)
        end
    end
    LuaMgr.AddClick(self.button, self.OnClickItem)
end

function SCNJDifficultyItem:SetData(data)
    self.data = data.data
    if self.data == nil then
        self.data = data
    end
    local selectedID = SCNJData.GetCurSelectedDifficultyDataID()
    if selectedID == nil or (selectedID == self.data.data.ID and self.data.isSelected == true and self.data.clickCallback ~= nil) then
        self.data.clickCallback(self)
    else
        self:OnSelected(false)
    end
    self:SetItem()
end

function SCNJDifficultyItem:SetItem()
    if self.data.isSelected then
        SetActive(self.selectedObj, true)
        self.percentTextOutLine.effectColor = UnityEngine.Color(62 / 255, 54 / 255, 41 / 255, 1)
    else
        SetActive(self.selectedObj, false)
        self.percentTextOutLine.effectColor = UnityEngine.Color(123 / 255, 46 / 255, 7 / 255, 1)
    end
    if self.data.isLast then
        SetActive(self.lineObj, false)
    else
        SetActive(self.lineObj, true)
    end
    self.percentText.text = self.data.data.Config.DiffDesc .. "%"
    SetActive(self.lockObj, self.data.data.IsUnlock == false)
end

function SCNJDifficultyItem:OnSelected(isSelected)
    self.data.isSelected = isSelected
    self:SetItem()
end

function SCNJDifficultyItem:ClearItems()
end

function SCNJDifficultyItem:Clear()
    self:ClearItems()
end

function SCNJDifficultyItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end