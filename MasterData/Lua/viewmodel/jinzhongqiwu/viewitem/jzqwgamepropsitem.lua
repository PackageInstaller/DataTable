













JZQWGamePropsItem = {}
JZQWGamePropsItem.__index = JZQWGamePropsItem

local objs = {
    button = {path = "Group", type = UITool.Button},
    emptyObj = {path = "Group/Empty", type = UITool.GameObject},
    itemObj = {path = "Group/Item", type = UITool.GameObject},
    icon = {path = "Group/Item/Icon", type = UITool.Image},
    normalObj = {path = "Group/Item/Normal", type = UITool.GameObject},
    selectObj = {path = "Group/Item/Select", type = UITool.GameObject},
    usingObj = {path = "Group/Item/Using", type = UITool.GameObject}
}

JZQWGamePropsItem.New = function()

    local self = {}
    setmetatable(self, JZQWGamePropsItem)
    return self
end

function JZQWGamePropsItem:Init()
    UITool.Parse(self.gameObject, self, objs)
    self.transform = self.gameObject.transform
    self.isSelected = false
    self.isUsing = false
    self.isDestroyed = false
    self.OnClickButton = function()
        local data = {}
        data.PropsData = self.data.PropsData
        LuaMgr.InvokeUIEventListeners(UIEventConst.JZQWClickProps, data)
        if self.data.OnClickCallback ~= nil then
            self.data.OnClickCallback(self)
        end
    end
    self.OnClickPropsEvent = function(param)
        self.isSelected = false
        self:Refresh()
        if param == nil or param.Length < 1 then
            return
        end
        if self.data.PropsData == nil then
            return
        end
        local data = param[0]
        if data ~= nil and data.PropsData ~= nil and data.PropsData.ID == self.data.PropsData.ID then
            self.isSelected = true
            self:Refresh()
        end
    end
    self.OnOperatePropsEvent = function(param)
        self:RefreshUseStatus(false)
        if param == nil or param.Length < 1 then
            return
        end
        if self.data.PropsData == nil then
            return
        end
        local data = param[0]
        if data ~= nil and data.PropsData ~= nil and data.PropsData.ID == self.data.PropsData.ID then
            self:RefreshUseStatus(data.IsUsing == true)
        end
    end
    LuaMgr.AddUIEventListener(UIEventConst.JZQWClickProps, self.OnClickPropsEvent)
    LuaMgr.AddUIEventListener(UIEventConst.JZQWOperateProps, self.OnOperatePropsEvent)
    LuaMgr.AddClick(self.button, self.OnClickButton)
end


function JZQWGamePropsItem:SetData(data)
    self.data = data.data
    self.operateType = JZQWConst.PropsOperateState.Default
    self.isSelected = false
    self.isUsing = false
    if self.data.PropsData == nil then
        self.operateType = JZQWConst.PropsOperateState.Default
    else
        self.operateType = JZQWConst.PropsOperateState.NoneOperate
    end
    self:Refresh()
end



function JZQWGamePropsItem:GetPropsData()
    return self.data.PropsData
end


function JZQWGamePropsItem:Refresh()
    SetActive(self.emptyObj, true)
    SetActive(self.itemObj, self.operateType ~= JZQWConst.PropsOperateState.Default)
    SetActive(self.normalObj, self.isSelected == false)
    SetActive(self.selectObj, self.isSelected == true)
    SetActive(self.usingObj, self.isUsing == true)
    if self.operateType ~= JZQWConst.PropsOperateState.Default then
        self.icon.sprite = LuaMgr.GetSprite(JZQWConst.GameAtlasName, self.data.PropsData.Config.Icon)
    end
end

function JZQWGamePropsItem:RefreshUseStatus(isUsing)
    self.isUsing = isUsing
    SetActive(self.usingObj, isUsing)
end

function JZQWGamePropsItem:ClearItems()
end

function JZQWGamePropsItem:Clear()
    self:ClearItems()
end

function JZQWGamePropsItem:Destroy()
    if self.isDestroyed == true then
        return
    end
    self.isDestroyed = true
    LuaMgr.RemoveClick(self.button, self.OnClickButton)
    LuaMgr.RemoveUIEventListener(UIEventConst.JZQWClickProps, self.OnClickPropsEvent)
    LuaMgr.RemoveUIEventListener(UIEventConst.JZQWOperateProps, self.OnOperatePropsEvent)
    self:Clear()
end