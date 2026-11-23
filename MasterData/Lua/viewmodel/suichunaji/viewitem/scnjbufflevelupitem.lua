






SCNJBuffLevelUpItem = {}
SCNJBuffLevelUpItem.__index = SCNJBuffLevelUpItem

local objs = {
    icon = {path = "Group/Icon", type = UITool.Image},
    button = {path = "Group", type = UITool.Button}
}

SCNJBuffLevelUpItem.New = function()

    local self = {}
    setmetatable(self, SCNJBuffLevelUpItem)
    return self
end

function SCNJBuffLevelUpItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    local upBeforeLevelObj = self.gameObject.transform:Find("Group/LevelBG/UpBeforeLevel")
    local upAfterLevelObj = self.gameObject.transform:Find("Group/LevelBG/UpAfterLevel")
    local arrowObjObj = self.gameObject.transform:Find("Group/LevelBG/Arrow")
    local levelTextObj = self.gameObject.transform:Find("Group/LevelText")
    if upBeforeLevelObj ~= nil then
        self.upBeforeLevel = upBeforeLevelObj:GetComponent(UITool.Text)
    end
    if upAfterLevelObj ~= nil then
        self.upAfterLevel = upAfterLevelObj:GetComponent(UITool.Text)
    end
    if arrowObjObj ~= nil then
        self.arrowObj = arrowObjObj.gameObject
    end
    if levelTextObj ~= nil then
        self.levelText = levelTextObj:GetComponent(UITool.Text)
    end

    self.onclickButton = function()
        LuaMgr.ShowLuaPanel(UIName.SCNJBuffInfoPopup, self.data)
    end
    LuaMgr.AddClick(self.button, self.onclickButton)
end

function SCNJBuffLevelUpItem:SetData(data)
    self.data = data.data
    if self.data == nil then
        self.data = data
    end
    self:SetItem()
end

function SCNJBuffLevelUpItem:SetItem()
    self.icon.sprite = LuaMgr.GetSprite(SCNJConst.BuffIconAtlaName, self.data.BuffIcon)
    if self.upBeforeLevel ~= nil then
        self.upBeforeLevel.text = string.format("LV.%d", self.data.BeforeLevel)
    end
    if self.upAfterLevel ~= nil then
        SetActive(self.upAfterLevel.gameObject, self.data.AfterLevel ~= nil)
        SetActive(self.arrowObj, self.data.AfterLevel ~= nil)
        if self.data.AfterLevel ~= nil then
            self.upAfterLevel.text = string.format("LV.%d", self.data.AfterLevel)
        end
    end
    if self.levelText ~= nil then
        if type(self.data.Level) == "string" then
            self.levelText.text = string.format("LV.%s", self.data.Level)
        else
            self.levelText.text = string.format("LV.%d", self.data.Level)
        end
    end
end

function SCNJBuffLevelUpItem:ClearItems()
end

function SCNJBuffLevelUpItem:Clear()
    self:ClearItems()
end

function SCNJBuffLevelUpItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
    self.data = nil
end