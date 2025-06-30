--[[ 
-----------------------------------------------------
@filename       : BaseReuseItem
@Description    : 可复用子项
@date           : 2021-01-19 17:04:07
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('lib.component.BaseReuseItem', Class.impl("lib.component.BaseContainer"))

--激活
function __active(self)
    super.__active(self)
    self:initViewText()
    self:addAllUIEvent()
end


--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

-- 为组件加入侦听点击事件
function addUIEvent(self, obj, callBack, soundPath, ...)
    self:addOnClick(obj, callBack, soundPath, ...)

    self.uiEventList = self.uiEventList or {}
    table.insert(self.uiEventList, obj)
end

-- 移除一个页面组件监听
function removeUIEvent(self, obj)
    self:removeOnClick(obj)
    table.removebyvalue(self.uiEventList, obj)
end

-- 移除所有页面组件点击侦听
function removeAllUIEvent(self)
    if self.uiEventList then
        for i = #self.uiEventList, 1, -1 do
            self:removeOnClick(self.uiEventList[i])
            table.remove(self.uiEventList, i)
        end
    end
end

-- 设置数据
function setData(self, cusParent, cusDupData)
    self:setParentTrans(cusParent)

end

-- 添加到父节点 cusSiblingIndex 添加显示层级
function addOnParent(self, cusSiblingIndex)
    if self.UIObject == nil then
        self.UIObject = gs.GOPoolMgr:Get(self.UIRes)
        if self.UIObject then
            self.UITrans = self.UIObject.transform
            self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.UIObject)
            self:configUI()
        end
    end
    super.addOnParent(self, cusSiblingIndex)
end

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end


function poolRecover(self)
    if self.UIObject then
        gs.GOPoolMgr:Recover(self.UIObject, self.UIRes)
    end
    self:removeAllUIEvent()

    self.UIObject = nil
    self.UITrans = nil
    self.m_childGos = nil
    self.m_childTrans = nil
    self:__deActive()

    LuaPoolMgr:poolRecover(self)
end

return _M