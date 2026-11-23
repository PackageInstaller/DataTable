





YXTwoBuffItemViewModel = {}

YXTwoBuffItemViewModel.__index = YXTwoBuffItemViewModel

local objs = {
    type_1 = {path = "Type1", type = "GameObject"},
    type_1_Button = {path = "Type1", type = "Button"},

    type_2 = {path = "Type2", type = "GameObject"},
    type_2_Button = {path = "Type2", type = "Button"},
    
    icon = {path = "Icon",type = "Image"},
    lock = {path = "Lock", type = "GameObject"},
    name = {path = "Name", type = "Text"},
    choose = {path = "Choose", type = "GameObject"},
}

function YXTwoBuffItemViewModel.New(prefab, parent)
    local self = {}
    setmetatable(self, YXTwoBuffItemViewModel)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    self.command = function()
        self.fun(self.groupIndex,self.index)
    end
    LuaMgr.AddClick(self.type_1_Button,self.command)
    LuaMgr.AddClick(self.type_2_Button,self.command)
    return self
end

function YXTwoBuffItemViewModel:SetData(data,groupIndex,index,fun)
    self.data = data
    self.groupIndex = groupIndex
    self.index = index
    self.fun = fun
    self.icon.sprite = LuaMgr.GetSprite("BuffIcon",self.data.BuffIcon)
    self.name.text = self.data.lock and ConfigMgr.LangGlobal("7207") or LuaMgr.GetLangText(self.data.BuffNameLan)
    SetActive(self.choose,self.data.choose)
    SetActive(self.lock,self.data.lock)
    SetActive(self.type_1,self.data.Type[1] == 1)
    SetActive(self.type_2,self.data.Type[1] == 2)
    self.gameObject:SetActive(true)
end

function YXTwoBuffItemViewModel:Clear()
    self.data = nil
    self.groupIndex = nil
    self.index = nil
    self.fun = nil
    self.gameObject:SetActive(false)
end

function YXTwoBuffItemViewModel:Destroy()
    if (self.command ~= nil) then
        LuaMgr.RemoveClick(self.type_1_Button, self.command)
        LuaMgr.RemoveClick(self.type_2_Button, self.command)
        self.command = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end