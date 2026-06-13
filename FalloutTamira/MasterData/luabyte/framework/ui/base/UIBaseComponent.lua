--[[
-- UI组件基类：所有UI组件从这里继承
-- 说明：
-- 1、采用基于组件的设计方式，容器类负责管理和调度子组件，实现类似于Unity中挂载脚本的功能
-- 2、组件对应Unity原生的各种Component和Script，容器对应Unity原生的GameObject
-- 3、写逻辑时完全不需要关注脚本调度，在cs中脚本函数怎么调度的，这里就怎么调度，只是要注意接口变动，lua侧没有Get、Set访问器
-- 注意：
-- 1、Lua侧组件的名字并不总是和Unity侧组件名字同步，Lua侧组件名字会作为组件系统中组件的标识
-- 2、Lua侧组件名字会在组件创建时提取Unity侧组件名字，随后二者没有任何关联，Unity侧组件名字可以随便改
-- 3、虽然Unity侧组件名字随后可以随意改，但是不建议（有GC），此外Lua侧组件一旦创建，使用时全部以Lua侧名字为准
-- 4、虽然支持Update、LateUpdate、FixedUpdate更新，但是UI组件最好不要使用---不要定义这些函数即可
-- 5、需要定时刷新的界面，最好启用定时器、协程，界面需要刷新的频率一般较低，倒计时之类的只需要每秒钟更新一次即可
--]]
local UIBaseComponent = BaseClass("UIBaseComponent", Updatable)
local base = Updatable

-- 构造函数：除非特殊情况，所有子类不要再写这个函数，初始化工作放OnCreate
-- 多种重载方式：
-- 1、ComponentTypeClass.New(relative_path)
-- 2、ComponentTypeClass.New(child_index)
-- 3、ComponentTypeClass.New(unity_gameObject)
local function __init(self, holder, var_arg)
    assert(not IsNull(holder), "Err : holder nil!")
    assert(not IsNull(holder.transform), "Err : holder tansform nil!")
    -- assert(not IsNull(var_arg), "Err: var_arg nil!")
    -- 窗口view层脚本
    -- self.view = nil
    -- 持有者
    self.holder = holder
    self.view = holder
    self._view = self.view
    -- 脚本绑定的transform
    self.transform = nil
    -- transform对应的gameObject
    self.gameObject = nil
    -- trasnform对应的RectTransform
    self.rectTransform = nil
    -- 名字：Unity中获取Transform的名字是有GC的，而Lua侧组件大量使用了名字，所以这里缓存下
    self.__name = nil
    -- 绑定数据：在某些场景下可以提供诸多便利
    self.__bind_data = nil
    -- 可变类型参数，用于重载
    self.__var_arg = var_arg

    -- 初始化其它基本信息
    if type(self.__var_arg) == "string" then
        -- 与持有者的相对路径
        self.transform = UIUtil.FindTrans(self.holder.transform, self.__var_arg)
        self.gameObject = self.transform.gameObject
    elseif type(self.__var_arg) == "number" then
        -- 持有者第index个孩子
        self.transform = UIUtil.GetChild(self.holder.transform, self.__var_arg)
        self.gameObject = self.transform.gameObject
    elseif type(self.__var_arg) == "userdata" then
        -- Unity侧GameObject
        self.gameObject = self.__var_arg
        self.transform = self.gameObject.transform
    elseif self.__ver_arg == nil then
        self.transform = self.holder.transform
        self.gameObject = self.transform.gameObject
        --error("OnCreate : error params list! "..type(self.__var_arg).." "..tostring(self.__var_arg))
    end
    self.__name = self.gameObject.name .. "[" .. self.gameObject:GetInstanceID() .. "]"
    self.rectTransform = UIUtil.FindComponent(self.transform, typeof(CS.UnityEngine.RectTransform))
    self.__var_arg = nil
    self._unity_conponent = nil
    --保存类类型的虚表
    -- 这里一定要等资源异步加载完毕才启用Update
    self:EnableUpdate(false)
end

-- 析构函数：所有组件的子类不要再写这个函数，释放工作全部放到OnDestroy
local function __delete(self)
    self:OnDestroy()
end

-- 创建
local function OnCreate(self, unity_component)
    self._unity_conponent = unity_component
end

--复制一个新的组件
local function Instantiate(self, parent)
    -- body
    if self._unity_conponent then
        local finalParent = self._unity_conponent.transform.parent
        if not IsNull(parent) then
            finalParent = parent
        end
        local go = CS.UnityEngine.GameObject.Instantiate(self._unity_conponent.gameObject, finalParent)
        go.transform.localEulerAngles = self.transform.localEulerAngles
        go.transform.localScale = self.transform.localScale
        local unityComponent = go:GetComponent(self._unity_conponent:GetType())
        local instance = nil
        --添加容器
        if self.holder and self.holder.AddComponent then
            instance = self.holder.AddComponent(self.holder, self._class_type, go, unityComponent)
        elseif self.holder and self.holder.AddChildComponen then
            -- body
            instance = self._class_type.New(self.holder, go)
            self.holder.AddChildComponent(self.holder, instance)
        end
        return instance
    elseif self._view then
        local newView = self._view:Instantiate()
        newView:SetParent(self._view._transform.parent)
        return self._class_type.New(newView)
    end
    return nil
end

local function SetParent(self,parent)
    self._view.transform:SetParent(parent)
end

--设置组件坐标
local function SetPos(self, x, y, z)
    -- body
    x = x or 0
    y = y or 0
    z = z or z
    self.transform:SetPos(x, y, z)
end

local function SetLocalPos(self, x, y, z)
    x = x or 0
    y = y or 0
    z = z or z
    self.transform:SetLocalPos(x, y, z)
end

-- 打开
local function OnEnable(self)
    -- 启用更新函数
    self:EnableUpdate(true)
end

-- 获取名字
local function GetName(self)
    return self.__name
end

-- 设置名字：toUnity指定是否同时设置Unity侧的名字---不建议，实在想不到什么情况下会用，但是调试模式强行设置，好调试
local function SetName(self, name, toUnity)
    if self.holder.OnComponentSetName ~= nil then
        self.holder:OnComponentSetName(self, name)
    end
    self.__name = name
end

-- 设置绑定数据
local function SetBindData(self, data)
    self.__bind_data = data
end

-- 获取绑定数据
local function GetBindData(self)
    return self.__bind_data
end

-- 激活、反激活
local function SetActive(self, active)
    if active then
        self.gameObject:SetActive(active)
        self:OnEnable()
    else
        self:OnDisable()
        self.gameObject:SetActive(active)
    end
end

local function SetEnable(self, active)
    if active then
        self._unity_conponent.enabled = active
        self:OnEnable()
    else
        self:OnDisable()
        self._unity_conponent.enabled = active
    end
end

-- 获取激活状态
local function GetActive(self)
    return self.gameObject.activeSelf
end

local function IsActiveInHierarchy(self)
    return self.gameObject.activeInHierarchy
end

local function IsEnabled(self)
    return self._unity_conponent.enabled
end

-- 等待资源准备完毕：用于协程
local function WaitForCreated(self)
    coroutine.waituntil(
        function()
            return not IsNull(self.gameObject)
        end
    )
end

local function onClick(self, ...)
    local arr = { ... }
    if #arr == 0 then
        self.gameObject:onClick(nil)
        return
    end
    self.__onclick = BindCallback(...)
    self.gameObject:onClick(self.__onclick)
end

local function SetClickUp(self)
    self.gameObject:SetClickUp()
end

-- 关闭
local function OnDisable(self)
    -- 禁用更新函数
    self:EnableUpdate(false)
end

-- 销毁
local function OnDestroy(self)
    if self.holder and self.holder.OnComponentDestroy ~= nil then
        self.holder:OnComponentDestroy(self)
    end
    if self.holder and self.holder.OnDispose then
        self.holder:OnDispose()
    end
    if not IsNull(self.gameObject) then
        self.gameObject:onClick(nil)
    end
    self.view = nil  -- == self.holder
    self._view = nil -- == self.holder
    self.holder = nil
    self.transform = nil
    self.gameObject = nil
    self.rectTransform = nil
    self.__name = nil
    self.__bind_data = nil
    self.__onclick = nil
end

local function SetDoLocalMoveX(self, endValue, duration, ease)
    ease = ease or 0
    return self.transform:SetDoLocalMoveX(endValue, duration, ease)
end

local function DOTweenTo(self, oldPos, newPos, duration)
    return self.transform:DOTweenTo(oldPos, newPos, duration)
end

local function onDrag(self, call)
    self.gameObject:onDrag(call)
end

local function onEndDrag(self, call)
    self.gameObject:onEndDrag(call)
end

local function GetSiblingIndex(self)
    return self.transform:GetSiblingIndex()
end

local function SetSiblingIndex(self, index)
    self.transform:SetSiblingIndex(index)
end

local function SetAsLastSibling(self)
    self.transform:SetAsLastSibling()
end

local function SetLocalRotation(self, x, y, z)
    self.transform:SetLocalRotation(x, y, z)
end

local function SetLocalScale(self, scale)
    self.transform:SetLocalScale(scale, scale, scale)
end

local function SetDoScale(self, scale, duration, ease)
    if not ease then ease = 1 end
    return self.transform:SetDoScale(scale, duration, ease)
end

local function SetDoScaleX(self, endValue, duration, ease)
    if not ease then ease = 1 end
    return self.transform:SetDoScaleX(endValue, duration, ease)
end

local function SetDoLocalRotateX(self, angle, duration, ease)
    if not ease then ease = 1 end
    return self.transform:SetDoLocalRotateX(angle, duration, ease)
end

local function SetDoLocalRotateY(self, angle, duration, ease)
    if not ease then ease = 1 end
    return self.transform:SetDoLocalRotateY(angle, duration, ease)
end

local function SetDoLocalRotateZ(self, angle, duration, ease)
    if not ease then ease = 1 end
    return self.transform:SetDoLocalRotateZ(angle, duration, ease)
end

local function SetDoMoveX(self, endValue, duration, ease)
    ease = ease or 0
    return self.transform:SetDoMoveX(endValue, duration, ease)
end

local function SetDoShakePosition(self, duration, strength, vibrato)
    return self.transform:SetDoShakePosition(duration, strength, vibrato)
end

local function SetDoShakePositionX(self, duration, strength, vibrato)
    return self.transform:SetDoShakePositionX(duration, strength, vibrato)
end

local function SetDoShakePositionY(self, duration, strength, vibrato)
    return self.transform:SetDoShakePositionY(duration, strength, vibrato)
end

local function DoTweenKill(self, complete)
    if not complete then complete = false end
    return self.transform:DoTweenKill(complete)
end

local function OffsetMinAndMaxWithNotch(self)
    self.transform:OffsetMinAndMaxWithNotch()
end

UIBaseComponent.__init = __init
UIBaseComponent.__delete = __delete
UIBaseComponent.OnCreate = OnCreate
UIBaseComponent.OnEnable = OnEnable
UIBaseComponent.GetName = GetName
UIBaseComponent.SetName = SetName
UIBaseComponent.onClick = onClick
UIBaseComponent.SetClickUp = SetClickUp
UIBaseComponent.SetBindData = SetBindData
UIBaseComponent.GetBindData = GetBindData
UIBaseComponent.SetActive = SetActive
UIBaseComponent.GetActive = GetActive
UIBaseComponent.SetEnable = SetEnable
UIBaseComponent.IsEnabled = IsEnabled
UIBaseComponent.WaitForCreated = WaitForCreated
UIBaseComponent.OnDisable = OnDisable
UIBaseComponent.OnDestroy = OnDestroy
UIBaseComponent.Instantiate = Instantiate
UIBaseComponent.SetPos = SetPos
UIBaseComponent.SetLocalPos = SetLocalPos
UIBaseComponent.SetDoLocalMoveX = SetDoLocalMoveX
UIBaseComponent.DOTweenTo = DOTweenTo
UIBaseComponent.onDrag = onDrag
UIBaseComponent.onEndDrag = onEndDrag
UIBaseComponent.DoTweenKill = DoTweenKill
UIBaseComponent.GetSiblingIndex = GetSiblingIndex
UIBaseComponent.SetSiblingIndex = SetSiblingIndex
UIBaseComponent.SetAsLastSibling = SetAsLastSibling
UIBaseComponent.SetLocalRotation = SetLocalRotation
UIBaseComponent.SetLocalScale = SetLocalScale
UIBaseComponent.SetDoScale = SetDoScale
UIBaseComponent.SetDoMoveX = SetDoMoveX
UIBaseComponent.SetDoScaleX = SetDoScaleX
UIBaseComponent.SetDoLocalRotateX = SetDoLocalRotateX
UIBaseComponent.SetDoLocalRotateY = SetDoLocalRotateY
UIBaseComponent.SetDoLocalRotateZ = SetDoLocalRotateZ
UIBaseComponent.IsActiveInHierarchy = IsActiveInHierarchy
UIBaseComponent.SetDoShakePosition = SetDoShakePosition
UIBaseComponent.SetDoShakePositionX = SetDoShakePositionX
UIBaseComponent.SetDoShakePositionY = SetDoShakePositionY
UIBaseComponent.OffsetMinAndMaxWithNotch = OffsetMinAndMaxWithNotch
UIBaseComponent.SetParent = SetParent

return UIBaseComponent
