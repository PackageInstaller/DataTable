








SSYXWordItem = {}
SSYXWordItem.__index = SSYXWordItem

local objs = {
    bg = {path = "BG", type = UITool.Image},
    name = {path = "Name", type = UITool.Text},
    mask = {path = "Mask", type = UITool.GameObject}
}

SSYXWordItem.New = function(obj, isInstantiate, parent)

    local self = {}
    setmetatable(self, SSYXWordItem)
    self.OnClickOtherToggle = function(params)
        self:OnRefreshItem(params)
    end
    if isInstantiate == true then
        self.gameObject = LuaMgr.Instantiate(obj, parent, false)
        SetActive(self.gameObject, true)
        LuaMgr.AddUIEventListener(UIEventConst.SSYXWordItemRefresh, self.OnClickOtherToggle)
    else
        self.gameObject = obj
    end
    self:Init()
    return self
end

function SSYXWordItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.toggle = self.gameObject:GetComponent(UITool.Toggle)
    local checkTrans = self.gameObject.transform:Find("CheckObj")
    self.checkObj = checkTrans ~= nil and checkTrans.gameObject or nil
    if self.toggle ~= nil then
        self.toggle.isOn = true
        self.OnClickToggle = function(value)
            local tempData = {}
            tempData.ID = self.data.ID
            tempData.IsSelected = value
            LuaMgr.InvokeUIEventListeners(UIEventConst.SSYXWordItemRefresh, tempData)
        end
        self.toggle.onValueChanged:AddListener(self.OnClickToggle)
    end
end

function SSYXWordItem:SetData(data)
    self.data = data.data
    if self.data == nil then
        self.data = data
    end
    self:SetWordColor()
    if self.data.Config ~= nil then
        local lanStr = LuaMgr.GetLangText(self.data.Config.NameLan)
        if self.data.IsSelected == true then
            self.name.text = string.format("<color=#BDA354>%s</color>", lanStr)
        else
            self.name.text = string.format("<color=#917547>%s</color>", lanStr)
        end
    end
    self:OnRefreshItem()
    if self.toggle ~= nil then
        self.toggle.isOn = self.data.IsSelected == true
    end
end

function SSYXWordItem:SetWordColor()
    if self.data.Config ~= nil then
        self.bg.color = HexToRGBA(self.data.Config.Color)
    end
    self.name.color = HexToRGBA("#917547")
    if self.data.IsAllWord ~= true then
        if self.data.IsSelected ~= true and self.data.IsEmployee ~= true then
            self.bg.color = HexToRGBA("#DAD5B1")
            self.name.color = HexToRGBA("#BDA354")
        end
    end
end

function SSYXWordItem:OnRefreshItem(params)
    SetActive(self.checkObj, self.data.IsSelected == true)
    self:SetWordColor()
end

function SSYXWordItem:ClearItems()
end

function SSYXWordItem:Clear()
    self:ClearItems()
end

function SSYXWordItem:Destroy()
    LuaMgr.DestroyImmediateGO(self.gameObject)
    LuaMgr.RemoveUIEventListener(UIEventConst.SSYXWordItemRefresh, self.OnClickOtherToggle)
    self.gameObject = nil
end