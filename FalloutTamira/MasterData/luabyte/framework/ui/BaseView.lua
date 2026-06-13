BaseView = BaseClass("BaseView")
local M = BaseView

function M:__init(go)
    self._go = go
    self._binder = UIUtil.FindComponent(go.transform, typeof(CS.GameX.EditorUIView), nil)
    self._transform = go.transform
    self.transform = self._transform
    self.gameObject = self._transform.gameObject
    --用于查找对应组件
    self._container = UIBaseContainer.New(self, go)
    self._container:OnCreate()
    self._instanceId = go:GetInstanceID()
    GameObjectMgr:GetInstance():AddView(self)
end

function M:__delete()
    GameObjectMgr:GetInstance():Remove(self._instanceId)
end

function M:GetInstanceID()
    return self._instanceId
end

function M:AddComponent(componentType, gameObject)
    return self._container:AddComponent(componentType, gameObject)
end

function M:GetComponent(name, component_class)
    return self._container:GetComponent(name, component_class)
end

function M:OnComponentDestroy(destoryComponent)
    if self._container ~= nil and self._container == destoryComponent then
        self._container = nil
    end
end

function M:FindComponent(csType, path)
    return UIUtil.FindComponent(self._transform, csType, path)
end

function M:Instantiate()
    local view = self._class_type.New(self.gameObject:Instantiate())
    return view
end

function M:SetActive(v)
    self._go:SetActive(v)
end

function M:GetActive()
    return self._go.activeSelf
end

function M:GetName()
    return self._go.name
end

function M:SetParent(parent)
    self._transform:SetParent(parent)
end

--此处用小于，是想和C#中保持一致
function M:onClick(callback)
    self._onClickCallback = callback
    self._transform:onClick(Bind(self, self._OnClick))
end

function M:_OnClick(go)
    if self._onClickCallback then
        self._onClickCallback(go)
    end
end

--添加原生的LUA组件，如UIImage , UIRawImage , UIText等
function M:AddBaseCom(comClass, unity_comName)
    -- local comClass = require(comClassName)
    local unity_com = self._binder:GetValue(unity_comName)
    if IsNull(unity_com) then
        return nil
    end
    return self._container:AddComponent(comClass, unity_com.gameObject, unity_com)
end

-- comClassName 组件类全名 viewClassName 视图类全名 targetGoName 对象绑定名
function M:AddValue(comClassName, viewClassName, targetGoName)
    local targetGo = self._binder:GetGo(targetGoName)
    if targetGo == nil then
        Logger.LogError(viewClassName .. " " .. targetGoName .. " is NULL")
    end
    local viewClass = require(viewClassName)
    if type(viewClass) ~= "table" then
        Logger.LogError(viewClassName .. " " .. targetGoName .. " is Error")
    end
    local viewInstance = viewClass.New(targetGo)
    --无组件
    if comClassName == nil or comClassName == '' then
        return viewInstance
    end
    --有组件则初始化组件
    local comClass = require(comClassName)
    if type(comClass) ~= "table" then
        Logger.LogError(viewClassName .. " " .. targetGoName .. " is Error")
        return nil
    end
    local ctrlInstance = comClass.New(viewInstance)
    ctrlInstance.view = viewInstance
    if comClass.super and comClass.super.__cname == 'UIBaseComponent' then
        ctrlInstance = self._container:AddComponent(comClass, ctrlInstance)
    else
        self:AddChildComponent(ctrlInstance)
    end

    --调用其默认的激活与非激活
    if ctrlInstance.SetActive then
        ctrlInstance:SetActive(viewInstance:GetActive())
    end
    return ctrlInstance
end

function M:AddChildComponent(com)
    self._allChildern = self._allChildern or {}
    table.insert(self._allChildern, com)
end

function M:GetBaseValue(filedName)
    local type = self._binder:GetBaseFieldType(filedName)
    local content = self._binder:GetStrField(filedName)
    if type == 0 then -- 字符串
        return content
    elseif type == 1 then -- int
        return tonumber(content)
    elseif type == 2 then -- string[]
        -- body
        local strArrStr = content
        local arr = string.split(strArrStr, ",")
        return arr
    elseif type == 3 then -- int[]
        local strArrStr = content
        local arr = string.split(strArrStr, ",")
        local rtnArr = {}
        for i, v in ipairs(arr) do
            table.insert(rtnArr, tonumber(v))
        end
        return rtnArr
    end
    return nil
end

--主动销毁
function M:Destory()
    GameUtil.DestroyGo(self._go.gameObject)
    self:OnDispose()
end

function M:DestroyImmediate()
    GameUtil.DestroyImmediate(self._go.gameObject)
    self:OnDispose()
end

--被动销毁时调用
function M:OnDispose()
    if self._onClickCallback then
        self._onClickCallback = nil
        self._transform:onClick(nil)
    end
    if self._allChildern then
        for _, v in ipairs(self._allChildern) do
            if v and v.OnDispose then
                if v.OnDispose then
                    v:OnDispose()
                elseif v.OnDestroy then
                    v:OnDestroy()
                else
                    Logger.LogError(v._class_type.__cname .. "没有找到OnDispose方法，请添加")
                end
            end
        end
    end
    self._go = nil
    self._transform = nil
    self._allChildern = nil
    if self._container then
        self._container:OnDestroy()
    end
    self._container = nil
end

function M:SetPos(x, y, z)
    x = x or 0
    y = y or 0
    z = z or z
    self._transform:SetPos(x, y, z)
end

function M:SetLocalPos(x, y, z)
    x = x or 0
    y = y or 0
    z = z or z
    self._transform:SetLocalPos(x, y, z)
end

function M:SetDoLocalMove(endmove, sleep, ease)
    return self._transform:SetDoLocalMove(endmove.x, endmove.y, endmove.z, sleep, ease or 0)
end

function M:SetDoLocalMoveY(y, sleep, ease)
    return self._transform:SetDoLocalMoveY(y, sleep, ease or 0)
end

function M:DoTweenKill()
    return self._transform:DoTweenKill()
end

function M:DoTweenPause()
    return self._transform:DoTweenPause()
end

function M:DoTweenPlay()
    return self._transform:DoTweenPlay()
end

function M:InputMousePositionX()
    return self._transform:InputMousePositionX()
end

function M:Reset()
    self._transform:Reset()
end

return BaseView
