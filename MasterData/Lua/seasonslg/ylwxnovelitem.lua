










YLWXNovelItem = {}
YLWXNovelItem.__index = YLWXNovelItem

local objs = {
    rectTrans = { path = "", type = UITool.RectTransform },
    clickBtn = { path = "Btn", type = UITool.Button },
    readImg = { path = "ReadImg", type = UITool.GameObject },
    lockImg = { path = "LockImg", type = UITool.GameObject },
    newImg = { path = "NewImg", type = UITool.GameObject },
    textName = { path = "TextName", type = UITool.Text },
    point = { path = "Point", type = UITool.GameObject }
}

YLWXNovelItem.New = function(obj)

    local self = {}
    setmetatable(self, YLWXNovelItem)
    self.gameObject = obj
    if obj ~= nil then
        self:Init()
    end
    return self
end

function YLWXNovelItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickBtn = function()
        if self.data ~= nil and self.data.OnClickBtn ~= nil then
            self.data.OnClickBtn(self)
        end
    end
    if self.clickBtn ~= nil and not IsObjectNull(self.clickBtn) then
        LuaMgr.AddClick(self.clickBtn, self.OnClickBtn)
    end
end

function YLWXNovelItem:SetData(data)
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

    if self.readImg ~= nil and not IsObjectNull(self.readImg) then
        SetActive(self.readImg, isGot)
    end
    if self.lockImg ~= nil and not IsObjectNull(self.lockImg) then
        SetActive(self.lockImg, isLock)
    end
    if self.newImg ~= nil and not IsObjectNull(self.newImg) then
        SetActive(self.newImg, isNone)
    end
    if self.point ~= nil and not IsObjectNull(self.point) then
        SetActive(self.point, isNone)
    end

    local txt = self.textName
    if txt ~= nil and not IsObjectNull(txt) then
        txt.text = self.data.Name or ""
    end
    self:RefreshNameColor(isSelected)
end

function YLWXNovelItem:SetSelected(selected)
    local isSelect = (selected == true)
    if self.data ~= nil then
        self.data.IsSelected = isSelect
    end
    self:RefreshNameColor(isSelect)
end

function YLWXNovelItem:RefreshNameColor(selected)
    local txt = self.textName
    if txt ~= nil and not IsObjectNull(txt) then
        if selected == true then
            txt.color = HexToRGBA("#d7e2f2")
        else
            txt.color = HexToRGBA("#e4ccb2")
        end
    end
end

function YLWXNovelItem:Clear()
    if self.readImg ~= nil and not IsObjectNull(self.readImg) then
        SetActive(self.readImg, false)
    end
    if self.lockImg ~= nil and not IsObjectNull(self.lockImg) then
        SetActive(self.lockImg, false)
    end
    if self.newImg ~= nil and not IsObjectNull(self.newImg) then
        SetActive(self.newImg, false)
    end
    if self.point ~= nil and not IsObjectNull(self.point) then
        SetActive(self.point, false)
    end
    self:RefreshNameColor(false)
    self.data = nil
end

function YLWXNovelItem:Destroy()
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