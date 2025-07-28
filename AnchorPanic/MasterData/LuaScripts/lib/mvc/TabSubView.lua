module("lib.mvc.TabSubView", Class.impl("lib.component.BaseContainer"))

subName = "TabSubView"

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构函数
function dtor(self)
end

--初始化UI
function configUI(self)
end

-- 添加到父节点 cusSiblingIndex 添加显示层级
function addOnParent(self, cusSiblingIndex)
    local parentTrans = self:getParentTrans()
    if parentTrans then
        self.UITrans:SetParent(parentTrans, false)
        if cusSiblingIndex then
            self.UITrans:SetSiblingIndex(cusSiblingIndex)
        end
    end
end

function setUICache(self, isActive)
    if self.UITrans then
        if isActive then
            self.UITrans:SetParent(self:getParentTrans(), false)
        else
            self.UITrans:SetParent(GameView.UICache, false)
        end
    end
end

function getIsCache(self)
    return self.UITrans.parent == GameView.UICache
end

-- 内部激活，请勿使用
function __active(self, args, isReshow)
    self.isReshow = isReshow
    super.__active(self, args)
    -- self:active(args)
    self:initViewText()
    self:addAllUIEvent()
    -- self:regGuide()
end

-- -- 注册引导
-- function regGuide(self)
--     guide.GuideCondition:condition15(self.__cname)
-- end

-- 内部非激活，请勿使用
function __deActive(self)
    -- self:deActive()
    self:removeAllUIEvent()
    super.__deActive(self)
end

--激活
function active(self, args)
    
end
--非激活
function deActive(self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理
function addAllUIEvent(self)
end

-- 为组件加入侦听点击事件
function addUIEvent(self, obj, callBack, soundPath, ...)
    self:addOnClick(obj, callBack, soundPath, ...)

    self.uiEventList = self.uiEventList or {}
    table.insert(self.uiEventList, obj)
end
-- 移除所有页面组件点击侦听
function removeAllUIEvent(self)
    if self.uiEventList then
        for k, v in ipairs(self.uiEventList) do
            self:removeOnClick(v)
        end
    end
end

-- 玩家点击关闭
function onClickClose(self)
end

-- 玩家关闭所有窗口的c#回调
function onCloseAllCall(self)
end

return _M