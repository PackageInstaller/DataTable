require("Framework.UI.UIManager")
local UIContextMgr = BaseClass("UIContextMgr", Singleton)
local M = UIContextMgr

function M:__init()
    self._contexts = {}
    self._allUIConfig = {}
end

function M:RegistContext(uiName, context)
    self._contexts[uiName] = context
end

function M:SetUIConfig(uiName, uiConfig)
    self._allUIConfig[uiName] = uiConfig
end

function M:GetUIConfig(uiName)
    return self._allUIConfig[uiName]
end

function M:Show(uiName, ...)
    if self._allUIConfig[uiName] == nil then
        return 
    end
    
    local arr = { ... }
    local uiconfig = self._allUIConfig[uiName]
    
    if uiconfig.isLua then
        if self._contexts[uiName] and self._contexts[uiName].Open then
            if self._contexts[uiName].Open == nil then
                Logger.LogError(uiName .. " context 中未写Open方法")
            end
            
            self._contexts[uiName]:Open(...)
        else
            UIManager:GetInstance():Show(uiName, ...)
        end
    else
        IUIContextMgr:Show(uiName, ...)
    end
    local obj = {}
    obj.uiName = uiName
    setmetatable(obj,{__newindex=UIEventNewIndex})
    return obj
end

--用于UI显示等事件
function UIEventNewIndex(table,key,value)
    if key == "onShow" then 
        local uiName = table.uiName
        if uiName and value and type(value) == "function" then 
            if UIManager:GetInstance():IsShow(uiName) then 
                value()
            else
                UIManager:GetInstance():SetVisibleCallback(uiName,value)
            end
        end
    end
end

function M:TopIt(uiName)
    local ctrl = self:GetCtrl(uiName)
    if ctrl then 
        ctrl.view.transform:SetAsLastSibling()
    end
end

function M:BottomIt(uiName)
    local ctrl = self:GetCtrl(uiName)
    if ctrl then 
        ctrl.view.transform:SetAsFirstSibling()
    end
end

function M:GetTopUIConfig(uiFormTyp)
    if IUIContextMgr == nil then 
        return 
    end
    return IUIContextMgr:GetTopUIConfig(uiFormTyp)
end

function M:Back()
    if IUIContextMgr == nil then 
        return 
    end
    IUIContextMgr:Back()
end

function M:Tips()
    if IUIContextMgr == nil then 
        return 
    end
    IUIContextMgr:Tips()
end

function M:GetContext(uiName)
    return self._contexts[uiName]
end

function M:Close(uiName)
    if IUIContextMgr == nil then 
        return 
    end
    IUIContextMgr:_Close(uiName)
    self:_Close(uiName)
end

function M:CloseUIByType(uiType)
    if IUIContextMgr == nil then 
        return 
    end
    IUIContextMgr:CloseUIByType(uiType)
end

function M:SwitchScene()
    for i, v in ipairs(self._contexts) do
        v:OnSceneChange()
    end
end

function M:IsShow(uiName)
    return UIManager:GetInstance():IsShow(uiName)
end

function M:isVisible(uiName)
    return UIManager:GetInstance():isVisible(uiName)
end

function M:Cleanup()
    --self._contexts = {}
end

function M:Dispose()
    UIManager:GetInstance():DestoryAll()
    
    for k, v in pairs(self._contexts) do
        if v.OnDispose ~= nil then
            v:OnDispose()
        end
    end
    
    self._contexts = {}
end

function M:GetCtrl(uiName)
    return UIManager:GetInstance():GetCtrl(uiName)
end

---------------------------------------------for c# call 
function M:_Close(uiName)
    if self._contexts[uiName] then
        self._contexts[uiName]:OnClose()
    else
        UIManager:GetInstance():Close(uiName)
    end
end

function M:_Destory(uiName)
    if self._contexts[uiName] then
        self._contexts[uiName]:_Destory(uiName)
    else
        UIManager:GetInstance():_Destory(uiName)
    end
end

---------------------------------------------end for c# call 

return UIContextMgr
