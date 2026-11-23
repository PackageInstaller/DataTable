





EquipAttrItem = {}

EquipAttrItem.__index = EquipAttrItem

local objs = {
    normal_Text = {path = "Normal/Text",type = "Text"},
    choose = {path = "Choose",type = "GameObject"},
    choose_Text = {path = "Choose/Text",type = "Text"},
    clickBtn = {path = "Normal",type = "Button"},
}

function EquipAttrItem.New(prefab, parent)
    local self = {}
    setmetatable(self, EquipAttrItem)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    self.transform = self.gameObject:GetComponent("RectTransform")
    self.clickCommand = function()
        if self.callback ~= nil then
            self.callback(self.data.id)
        end
    end
    LuaMgr.AddClick(self.clickBtn,self.clickCommand)
    return self
end

function EquipAttrItem:SetData(data,callback,attrOptions)
    self.data = data
    self.callback = callback
    self.attrOptions = attrOptions
    local str = LuaMgr.GetLangText(self.data.NameLan)
    if self.data.addAttr == "Hp_PERCENT" or self.data.addAttr == "Atk_PERCENT" then
        str = str..ConfigMgr.LangGlobal("16108")
    end
    self.normal_Text.text = str
    self.choose_Text.text = str
    SetActive(self.choose,self.attrOptions[self.data.id] ~= nil)
    self.gameObject:SetActive(true)
end

function EquipAttrItem:Clear()
    self.data = nil
    self.callback = nil
    self.attrOptions = nil
    self.gameObject:SetActive(false)
end

function EquipAttrItem:Destroy()
    if (self.clickCommand ~= nil) then
        LuaMgr.RemoveClick(self.clickBtn, self.clickCommand)
        self.clickCommand = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end