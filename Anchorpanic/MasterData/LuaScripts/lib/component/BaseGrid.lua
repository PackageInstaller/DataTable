--[[
-----------------------------------------------------
@filename       : BaseGrid
@Description    : 道具格子基础
@date           : 2022-08-09 15:51:27
@Author         : Jacob
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("BaseGrid", Class.impl(BaseReuseItem))

--构造函数
function ctor(self)
    super.ctor(self)
end

function poolRecover(self)
    super.poolRecover(self)
    self:initData()
end

function initData(self)

    self.mCallFun = nil
    self.mCallObj = nil

    -- 是否显示动效
    self.mIsTween = nil
    -- 缩放比例
    self.mScale = nil
    -- 是否可点击
    self.mClickEnable = nil
end

function configUI(self)

end

function active(self)
    super.active(self)
    guide.GuideUITransHandler:active(self.m_loadSn)

    gs.TransQuick:UIPos(self.UITrans, 0, 0, 0)
    gs.TransQuick:Anchor(self.UITrans, 0.5, 0.5, 0.5, 0.5)
    gs.TransQuick:Pivot(self.UITrans, 0.5, 0.5)
    gs.TransQuick:Scale(self.UITrans, 1, 1, 1)

end

function deActive(self)
    super.deActive(self)
    guide.GuideUITransHandler:deActive(self.m_loadSn)

    if (self.mEndTimeloopSn) then
        self:removeTimerByIndex(self.mEndTimeloopSn)
        self.mEndTimeloopSn = nil
    end
end

--[[
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.UIObject, self.onClickHandler)
end

-- 设置数据
function setData(self, cusData, cusParent)

end

-- 更新数据
function updateData(self)
    self:updateTween()
    self:updateScale()
    self:updateClickEnable()
end

function setParent(self, cusParentTrans)
    self:setParentTrans(cusParentTrans)
end

-- 设置回调
function setCallBack(self, cusCallObj, cusCallFun, ...)
    if select("#", ...) > 0 then
        self.mParams = {...}
    end
    self.mCallFun = cusCallFun
    self.mCallObj = cusCallObj
end

-- 点击触发
function onClickHandler(self)
    if (self.mCallFun and self.mCallObj) then
        -- 调用外部处理
        if self.mParams then
            self.mCallFun(self.mCallObj, self.mPropsVo, unpack(self.mParams))
        else
            self.mCallFun(self.mCallObj, self.mPropsVo)
        end
    else
        -- 内部默认处理
        self:onDefaultClickHandler()
    end
end

-- 点击默认触发
function onDefaultClickHandler(self)
    local propsVo = self.mPropsVo
    local rect = self.mImgIcon.transform
    local id = propsVo.id or 0
    logInfo("道具id：" .. id .. ", tid: " .. propsVo.tid)
    if (propsVo.type == PropsType.EQUIP) then
        TipsFactory:equipTips(propsVo, nil, {rectTransform = rect})
    elseif propsVo.type == PropsType.HERO then
        if not fight.FightManager:getIsFighting() then
            GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DETAILSINFOPANEL, {heroTid = propsVo.tid})
        else
            logInfo("=============战斗场景的弹窗不打开")
        end
        --local heroId = hero.HeroManager:getHeroIdByTid(propsVo.tid)
        --GameDispatcher:dispatchEvent(EventName.OPEN_HERO_DETAILS_PANEL, { heroId = heroId, heroTid = propsVo.tid, isShowFashion = false })
    elseif (propsVo.type ~= PropsType.EQUIP) then
        TipsFactory:propsTips({propsVo = propsVo, isShowUseBtn = self.mIsShowUseInTip}, {rectTransform = rect})
    end
end

-- 取图标矩
function getIconRect(self)
    return self.mImgIcon.transform
end

function getIsShowUseInTip(self)
    return self.mIsShowUseInTip
end
------------------------------------------------------------------------

-- 设置动效状态
function setTween(self, isTween)
    self.mIsTween = isTween
    self:updateTween()
end

-- 设置缩放
function setScale(self, scale)
    self.mScale = scale
    self:updateScale()
    self:updateCountTextSize()
end

-- 设置是否可点击
function setClickEnable(self, cusClickEnable)
    self.mClickEnable = cusClickEnable
    self:updateClickEnable()
end

----------------------------------------------------------------------

-- 更新可点击状态
function updateClickEnable(self)
    if (self.mClickEnable == nil or self.mClickEnable == true) then
        self:addUIEvent(self.UIObject, self.onClickHandler)
    else
        self:removeUIEvent(self.UIObject)
    end
end

-- 更新缩放
function updateScale(self)
    if (self.mScale ~= nil) then
        gs.TransQuick:Scale(self.UITrans, self.mScale, self.mScale, self.mScale)
    end
end

-- 展示动效
function updateTween(self)
    if self.UIObject and not gs.GoUtil.IsGoNull(self.UIObject) then
        if (self.mIsTween == true and not gs.GoUtil.IsCompNull(self.UIObject:GetComponent(ty.Animator))) then
            self.UIObject:GetComponent(ty.Animator):SetTrigger("show")
        end
    end
end

-- 更新字号
function updateCountTextSize(self)

end

-- 获取道具格子根节点
function getTrans(self)
    return self.UITrans
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
