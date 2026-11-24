












WJWYNovelItem = {}
WJWYNovelItem.__index = WJWYNovelItem

local objs = {
    rectTrans = { path = "", type = UITool.RectTransform },
    clickBtn = { path = "Group/ClickBtn", type = UITool.Button },
    normalObj = { path = "Group/NormalObj", type = UITool.GameObject },
    finishObj = { path = "Group/NormalObj/FinishObj1", type = UITool.GameObject },
    selectObj1 = { path = "Group/NormalObj/FinishObj2", type = UITool.GameObject },
    newObj = { path = "Group/NormalObj/NewObj1", type = UITool.GameObject },
    selectObj2 = { path = "Group/NormalObj/NewObj2", type = UITool.GameObject },
    lockObj = { path = "Group/LockObj", type = UITool.GameObject },
    name = { path = "Group/NormalObj/Name", type = UITool.Text },
    nameOutline = { path = "Group/NormalObj/Name", type = UITool.OutlineEx }
}

WJWYNovelItem.New = function(obj)

    local self = {}
    setmetatable(self, WJWYNovelItem)
    self.gameObject = obj
    if obj ~= nil then
        self:Init()
    end
    return self
end

function WJWYNovelItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickBtn = function()
        if self.data ~= nil and self.data.OnClickBtn ~= nil then
            self.data.OnClickBtn(self)
        end
    end
    LuaMgr.AddClick(self.clickBtn, self.OnClickBtn)
end

function WJWYNovelItem:SetData(data)
    if data ~= nil and data.data ~= nil then
        self.data = data.data
    else
        self.data = data
    end
    if self.data == nil then
        return
    end
    local isLock = self.data.Status == CommonRewardItem.Status.Lock
    local isGot = self.data.Status == CommonRewardItem.Status.Got
    local isNone = self.data.Status == CommonRewardItem.Status.None
    local isSelected = (self.data.IsSelected == true)

    SetActive(self.normalObj, not isLock)
    SetActive(self.lockObj, isLock)
    SetActive(self.finishObj, isGot)
    SetActive(self.newObj, isNone)
    SetActive(self.selectObj1, isSelected and isGot)
    SetActive(self.selectObj2, isSelected and isNone)

    if self.clickBtn ~= nil and not IsObjectNull(self.clickBtn) then
        self.clickBtn.interactable = not isLock
    end
    if self.name ~= nil and not IsObjectNull(self.name) then
        self.name.text = self.data.Name or ""
    end
    self:RefreshNameColor(isSelected)
end

function WJWYNovelItem:SetSelected(selected)
    local isSelect = (selected == true)
    if self.data ~= nil then
        self.data.IsSelected = isSelect
        local isGot = self.data.Status == CommonRewardItem.Status.Got
        local isNone = self.data.Status == CommonRewardItem.Status.None
        SetActive(self.selectObj1, isSelect and isGot)
        SetActive(self.selectObj2, isSelect and isNone)
    else
        SetActive(self.selectObj1, false)
        SetActive(self.selectObj2, false)
    end
    self:RefreshNameColor(isSelect)
end

function WJWYNovelItem:RefreshNameColor(selected)
    if self.name ~= nil and not IsObjectNull(self.name) then
        if selected == true then
            self.name.color = HexToRGBA("#E34EC0")
        else
            self.name.color = HexToRGBA("#4E6EE3")
        end
    end
end

function WJWYNovelItem:Clear()
    SetActive(self.selectObj1, false)
    SetActive(self.selectObj2, false)
    self:RefreshNameColor(false)
    self.data = nil
end

function WJWYNovelItem:Destroy()
    if self.OnClickBtn ~= nil and self.clickBtn ~= nil and not IsObjectNull(self.clickBtn) then
        LuaMgr.RemoveClick(self.clickBtn, self.OnClickBtn)
    end
    self.OnClickBtn = nil
    self.data = nil
    if self.gameObject ~= nil and not IsObjectNull(self.gameObject) then
        LuaMgr.DestroyImmediateGO(self.gameObject)
    end
    self.gameObject = nil
end