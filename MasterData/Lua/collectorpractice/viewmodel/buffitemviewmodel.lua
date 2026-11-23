




BuffItemViewModel = {}

BuffItemViewModel.__index = BuffItemViewModel

local objs = {
    addObj = {path = "Add", type = "GameObject"},
    add_Choose = {path = "Add/Choose", type = "GameObject"},
    add_Lock = {path = "Add/Lock", type = "GameObject"},
    add_Button = {path = "Add", type = "Button"},
    add_ButRaycast = {path = "Add", type = "Image"},
    
    subtractObj = {path = "Subtract", type = "GameObject"},
    subtract_Choose = {path = "Subtract/Choose", type = "GameObject"},
    subtract_Lock = {path = "Subtract/Lock", type = "GameObject"},
    subtract_Button = {path = "Subtract", type = "Button"},
    subtract_ButRaycast = {path = "Subtract", type = "Image"},

    buffIcon = {path = "BuffIcon", type = "Image"},
    buffName = {path = "BuffName", type = "Text"},
    buffIntro = {path = "BuffIntro", type = "Text"},
}

function BuffItemViewModel.New(prefab, parent)
    local self = {}
    setmetatable(self, BuffItemViewModel)
    self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
    UITool.Parse(self.gameObject, self, objs)
    self.transform = self.gameObject:GetComponent("RectTransform")
    
    self.add_Command = function()
        if self.add_Lock.activeSelf then
            self:OpenTip()
            return
        end
        if self.call ~= nil then
            self.call(self.data.Type,self.indexRow,self.index)
        end
    end
    LuaMgr.AddClick(self.add_Button,self.add_Command)
    self.subtract_Command = function()
        if self.subtract_Lock.activeSelf then
            self:OpenTip()
            return
        end
        if self.call ~= nil then
            self.call(self.data.Type,self.indexRow,self.index)
        end
    end
    LuaMgr.AddClick(self.subtract_Button,self.subtract_Command)
    return self
end

function BuffItemViewModel:SetData(data,call,indexRow,index,isPreview)
    self.data = data
    self.call = call
    self.auto = nil
    self.index = index
    self.indexRow = indexRow
    self.add_ButRaycast.raycastTarget = isPreview ~= nil and not isPreview
    self.subtract_ButRaycast.raycastTarget = isPreview ~= nil and not isPreview
    local buffConfig = json.decode(LuaMgr.GetBuffDes(self.data.Buffid))
    if buffConfig ~= nil and buffConfig ~= "" then
        self.buffIcon.sprite = LuaMgr.GetSprite("BuffIcon",buffConfig.BuffIcon)
        self.buffIntro.text = LuaMgr.GetLangText(buffConfig.DescriptionLan)
    end
    if self.data.Type == 1 then
        self.buffName.text = "<color=#566823>"..LuaMgr.GetLangText(self.data.BuffNameLan).."</color>"
    elseif self.data.Type == 2 then
        self.buffName.text = "<color=#711d1e>"..LuaMgr.GetLangText(self.data.BuffNameLan).."</color>"
    end
    SetActive(self.add_Lock,self.data.Type == 1 and self.data.lock)
    SetActive(self.subtract_Lock,self.data.Type == 2 and self.data.lock)
    SetActive(self.addObj,self.data.Type == 1)
    SetActive(self.subtractObj,self.data.Type == 2)
    self:CloseChoose()
    self.gameObject:SetActive(true)
end

function BuffItemViewModel:OpenChoose()
    SetActive(self.add_Choose,self.data.Type == 1)
    SetActive(self.subtract_Choose,self.data.Type == 2)
end
function BuffItemViewModel:CloseChoose()
    SetActive(self.add_Choose,false)
    SetActive(self.subtract_Choose,false)
end

function BuffItemViewModel:OpenLock()
    SetActive(self.add_Lock,self.data.Type == 1)
    SetActive(self.subtract_Lock,self.data.Type == 2)
end
function BuffItemViewModel:CloseLock()
    SetActive(self.add_Lock,false)
    SetActive(self.subtract_Lock,false)
end

function BuffItemViewModel:OpenTip()
    local str = LuaMgr.GetLangText(ConfigMgr.Config.langGlobal["7137"].NameLan)
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel,str)
end

function BuffItemViewModel:Clear()
    self.data = nil
    self.auto = nil
    self.call = nil
    self.index = index
    self.indexRow = indexRow
    self.gameObject:SetActive(false)
end

function BuffItemViewModel:Destroy()
    if (self.add_Command ~= nil) then
        LuaMgr.RemoveClick(self.add_Button, self.add_Command)
        self.add_Command = nil
    end
    if (self.subtract_Command ~= nil) then
        LuaMgr.RemoveClick(self.subtract_Button, self.subtract_Command)
        self.subtract_Command = nil
    end
    LuaMgr.DestroyImmediateGO(self.gameObject)
    self.gameObject = nil
end