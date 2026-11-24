












JYCSNovelItem = {}
JYCSNovelItem.__index = JYCSNovelItem

local objs = {
    rectTrans = {path = "", type = UITool.RectTransform},
    clickBtn = {path = "Group/ClickBtn", type = UITool.Button},
    normalObj = {path = "Group/NormalObj", type = UITool.GameObject},
    finishObj = {path = "Group/NormalObj/FinishObj1", type = UITool.GameObject},
    selectObj1 = {path = "Group/NormalObj/FinishObj2", type = UITool.GameObject},
    newObj = {path = "Group/NormalObj/NewObj1", type = UITool.GameObject},
    selectObj2 = {path = "Group/NormalObj/NewObj2", type = UITool.GameObject},
    lockObj = {path = "Group/LockObj", type = UITool.GameObject},
    name = {path = "Group/NormalObj/Name", type = UITool.Text},
    nameOutline = {path = "Group/NormalObj/Name", type = UITool.OutlineEx}
}

JYCSNovelItem.New = function(obj)

    local self = {}
    setmetatable(self, JYCSNovelItem)
    self.gameObject = obj
    self:Init()
    return self
end

function JYCSNovelItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickBtn = function()
        if self.data ~= nil and self.data.OnClickBtn ~= nil then
            self.data.OnClickBtn(self)
        end
    end
    LuaMgr.AddClick(self.clickBtn, self.OnClickBtn)
end

function JYCSNovelItem:SetData(data)
    self.data = data
    self:SetSelected(false)
    SetActive(self.normalObj, self.data.Status ~= CommonRewardItem.Status.Lock)
    SetActive(self.lockObj, self.data.Status == CommonRewardItem.Status.Lock)
    SetActive(self.finishObj, self.data.Status == CommonRewardItem.Status.Got)
    SetActive(self.newObj, self.data.Status == CommonRewardItem.Status.None)
    self.clickBtn.interactable = self.data.Status ~= CommonRewardItem.Status.Lock
    self.name.text = self.data.Name
    self:RefreshNameColor()
end

function JYCSNovelItem:SetSelected(selected)
    if self.data == nil then
        SetActive(self.selectObj1, false)
        SetActive(self.selectObj2, false)
        return
    end
    SetActive(self.selectObj1, selected and self.data.Status == CommonRewardItem.Status.Got)
    SetActive(self.selectObj2, selected and self.data.Status == CommonRewardItem.Status.None)
    self:RefreshNameColor(selected)
end

function JYCSNovelItem:RefreshNameColor(selected)
    if selected == true then
        self.name.color = HexToRGBA("#FCFCA3")
        self.nameOutline.effectColor = HexToRGBA("#8400FF")
    else
        self.name.color = HexToRGBA("#D0D7C6")
        self.nameOutline.effectColor = HexToRGBA("#39554C")
    end
end

function JYCSNovelItem:SetItemPos(pos)
    self.rectTrans.anchoredPosition = pos
end

function JYCSNovelItem:SetItemAngle(angle)
    self.rectTrans.localEulerAngles = angle
end

function JYCSNovelItem:ClearItems()
end

function JYCSNovelItem:Clear()
    self:SetSelected(false)
    self.data = nil
    self:ClearItems()
end

function JYCSNovelItem:Destroy()
    LuaMgr.RemoveClick(self.clickBtn, self.OnClickBtn)
    self.data = nil
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end