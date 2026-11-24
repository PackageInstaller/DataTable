







JZQWHomePointItem = {}
JZQWHomePointItem.__index = JZQWHomePointItem

local objs = {
    introBtn = {path = "BigIntroBtn", type = UITool.Button},
    rectTrans = {path = "", type = UITool.RectTransform},
    title = {path = "TitleBG/Title", type = UITool.Text},
    redPoint = {path = "_PointRedPoint", type = UITool.RedIconListener}
}

JZQWHomePointItem.New = function(obj)

    local self = {}
    setmetatable(self, JZQWHomePointItem)
    self.gameObject = obj
    self.transform = self.gameObject.transform
    self:Init()
    return self
end

function JZQWHomePointItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.OnClickIntroBtn = function()
        if self.data ~= nil and self.data.OnClickIntroBtn ~= nil then
            self.data.OnClickIntroBtn(self)
        elseif self.OnClickIntroBtnCallback ~= nil then
            self.OnClickIntroBtnCallback(self)
        end
    end
    LuaMgr.AddClick(self.introBtn, self.OnClickIntroBtn)
end

function JZQWHomePointItem:SetData(data)
    self.data = data
    self.OnClickIntroBtnCallback = self.data.OnClickIntroBtn
    if self.data == nil then
        self:Clear()
        return
    end
    if self.data.IsGamePoint ~= true then
        self.title.text = self.data.Name
    end
end

function JZQWHomePointItem:SetRedID(redID)
    self.redPoint.RedId = redID
end

function JZQWHomePointItem:RefreshPos()
    if self.data == nil or self.data.classId == nil then
        return
    end

    local list = NumTool.split(self.data.classId, ";")
    local posList = {}
    if list and #list >= 2 then
        posList = NumTool.split(list[2], ",")
    end

    local posX = tonumber(posList[1]) or 0
    local posY = tonumber(posList[2]) or 0
    self.rectTrans.anchoredPosition = Vector2(posX, posY)
end

function JZQWHomePointItem:ClearItems()
end

function JZQWHomePointItem:Clear()
    self.data = nil
    if self.title ~= nil then
        self.title.text = ""
    end
end

function JZQWHomePointItem:Destroy()
    LuaMgr.RemoveClick(self.introBtn, self.OnClickIntroBtn)
    self:Clear()
end