








ZXLChooseItem = {}
ZXLChooseItem.__index = ZXLChooseItem

local objs = {
    button = {path = "Group", type = UITool.Button},
    normalObj = {path = "Group/NormalObj", type = UITool.GameObject},
    choosedObj = {path = "Group/ChoosedObj", type = UITool.GameObject},
    lockObj = {path = "Group/LockObj", type = UITool.GameObject},
    name = {path = "Group/Name", type = UITool.Text},
    icon = {path = "Group/Icon", type = UITool.Image}
}

function ZXLChooseItem.New(prefab, parent)

    local self = {}
    setmetatable(self, ZXLChooseItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    SetActive(self.choosedObj, false)
    SetActive(self.lockObj, false)
    local func = function()
        if self.data ~= nil and self.data.clickCallback then
            self.data.clickCallback(self)
        end
    end
    LuaMgr.AddClick(self.button, func)
    return self
end

function ZXLChooseItem:SetData(data)
    self.data = data
    SetActive(self.gameObject, true)
    self:SetItem()
end

function ZXLChooseItem:SetItem()
    SetActive(self.lockObj, self.data.unlock == false)
    if self.data.unlock == true then
        local nameLan = LuaMgr.GetLangText(self.data.config.NameLan)
        self.name.text = string.format("<color=#4A5E94>%s</color>", nameLan)
    elseif self.data.unlockTime > 0 then
        local nameLan = os.date(LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29404"), self.data.unlockTime)
        self.name.text = string.format("<color=#C1C1C1>%s</color>", nameLan)
    end
    self.icon.sprite = LuaMgr.GetSprite(ZXLConst.AtlaName, self.data.config.Icon)
    self:RefreshChooseStatus()
end

function ZXLChooseItem:SetChoosed(isChoose)
    self.data.isChoosed = isChoose
    self:RefreshChooseStatus()
end

function ZXLChooseItem:RefreshChooseStatus()
    SetActive(self.choosedObj, self.data.isChoosed == true)
end

function ZXLChooseItem:Clear()
    self.data = nil
    SetActive(self.gameObject, false)
end

function ZXLChooseItem:Destroy()
    if self.item ~= nil then
        self.item:Clear()
        self.item = nil
    end
    if self.OnClickItem ~= nil then
        LuaMgr.RemoveClick(self.button, self.OnClickItem)
        self.OnClickItem = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end