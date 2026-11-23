













TechnologyItem = {}
TechnologyItem.__index = TechnologyItem

local objs = {
    clickBtn = {path = "Group", type = UITool.Button},
    lightLineObj = {path = "Group/LightLine", type = UITool.GameObject},
    darkLineObj = {path = "Group/DarkLine", type = UITool.GameObject},
    unlockObj = {path = "Group/UnlockObj", type = UITool.GameObject},
    lockObj = {path = "Group/LockObj", type = UITool.GameObject},
    selectObj = {path = "Group/SelectedObj", type = UITool.GameObject},
    unlockIcon = {path = "Group/UnlockObj/Icon", type = UITool.Image},
    unlockDesc = {path = "Group/UnlockObj/Desc", type = UITool.Text},
    unlockLevel = {path = "Group/UnlockObj/Level", type = UITool.Text},
    lockIcon = {path = "Group/LockObj/Icon", type = UITool.Image},
    lockDesc = {path = "Group/LockObj/Desc", type = UITool.Text}
}

TechnologyItem.New = function(obj)

    local self = {}
    setmetatable(self, TechnologyItem)
    self.gameObject = obj
    self:Init()
    return self
end

function TechnologyItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickItem = function()
        if self.data.IsUnlock == false and self.data.CanShow == false then
            local tipsContent = LuaMgr.GetLangText(SSYXConst.LanText.LanText5)
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
            return
        end
        if self.data.OnSelectTechnology ~= nil then
            self.data.OnSelectTechnology(self)
        end
    end
    LuaMgr.AddClick(self.clickBtn, self.OnClickItem)
end

function TechnologyItem:SetData(data)
    self.data = data
    SetActive(self.lightLineObj, self.data.IsUnlock == true)
    SetActive(self.darkLineObj, self.data.IsUnlock == false)
    SetActive(self.unlockObj, self.data.IsUnlock == true)
    SetActive(self.lockObj, self.data.IsUnlock == false)
    if self.data.IsUnlock == true then
        self.unlockIcon.sprite = LuaMgr.GetSprite(SSYXConst.TechAtlaName, self.data.Config.Icon)
        self.unlockDesc.text = LuaMgr.GetLangText(self.data.Config.NameLan)
        self.unlockLevel.text = string.format("Lv.%d", self.data.Level)
    else
        self.lockIcon.sprite = LuaMgr.GetSprite(SSYXConst.TechAtlaName, self.data.Config.Icon .. "b")
        self.lockDesc.text = LuaMgr.GetLangText(self.data.Config.NameLan)
    end
end

function TechnologyItem:SetSelected(isSelect)
    SetActive(self.selectObj, isSelect)
end

function TechnologyItem:ClearItems()
    LuaMgr.RemoveClick(self.clickBtn, self.OnClickItem)
end

function TechnologyItem:Clear()
    self:ClearItems()
end

function TechnologyItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end