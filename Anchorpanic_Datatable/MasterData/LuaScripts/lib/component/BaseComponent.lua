--[[
@todo: 可复用异步加载组件
@author: zzz
]]
module("BaseComponent", Class.impl("lib.component.BaseContainer"))

-- UI预制体名
UIRes = nil
-- 是否异步
IsAsyn = nil

function ctor(self)
    self:__initData()
end

function __getPrefabName(self)
    return self.UIRes
end

function __initData(self)
    self.m_sn = SnMgr:getSn()
    -------------------------------------------------- 数据相关 --------------------------------------------------
    -- 加载句柄
    self.m_loadSn = nil
    -- 是否资源加载完毕
    self.m_isLoadFinish = nil
    -- 资源加载完毕回调方法
    self.m_finishCall = nil
    -- 是否可点击
    self.m_clickEnable = nil
    self:setClickEnable(self.m_clickEnable)
    -- 点击的回调方法
    self.m_callFun = nil
    -- 点击的回调对象
    self.m_callObj = nil
    -- 点击的回调参数
    self.m_params = nil
    -- RectTransform
    self.m_rect = nil
    -- 坐标
    self.m_pos = nil
    -- 缩放系数
    self.m_scale = nil
    -- 数据源
    self.m_data = nil

    -------------------------------------------------- ui相关 --------------------------------------------------
    self.m_uiGo = nil
    self.m_childGos = nil
    self.m_childTrans = nil
    -- 父对象
    self.m_parentTrans = nil
end

function poolGet(self)
    guide.GuideUITransHandler:active(self.m_loadSn)
    return LuaPoolMgr:poolGet(self)
end

function poolRecover(self)
    guide.GuideUITransHandler:deActive(self.m_loadSn)
    self:__reset()
    LuaPoolMgr:poolRecover(self)
end

-- 通过外部传保存进来的需要重置的数据
function __reset(self)
    self.m_isLoadFinish = false
    if (self.m_sn ~= nil) then
        SnMgr:disposeSn(self.m_sn)
        self.m_sn = nil
    end
    if (self.m_loadSn ~= nil) then
        gs.GOPoolMgr:CancelAsyc(self.m_loadSn)
        self.m_loadSn = nil
    end
    if (self.m_uiGo and not gs.GoUtil.IsGoNull(self.m_uiGo)) then
        if self.m_uiGo:GetComponent(ty.Button) then
            self:removeOnClick(self.m_uiGo)
        end
        gs.GOPoolMgr:Recover(self.m_uiGo, self:__getPrefabName())
        self.m_uiGo = nil
    end

    self:__removeEventList()
    self:removeAllTimer()
    self:clearAllTimeout()
    self:__initData()
end

-- 创建
function create(self, parent, cusData, cusScale, cusIsAsyn, finishCall)
    local item = self:poolGet()
    item:setData(cusData, cusIsAsyn, finishCall)
    item:setParent(parent)
    item:setScale(cusScale)
    return item
end

-- 设置数据
function setData(self, cusData, cusIsAsyn, finishCall)
    self:__reset()
    if (cusData) then
        self.m_data = cusData
        self.m_finishCall = finishCall
        
        if (cusIsAsyn == nil) then
            cusIsAsyn = true
        end
        if (cusIsAsyn) then
            if (self.m_isLoadFinish) then
                self:__updateView()
                self:doFinishCall()
            else
                self:__preLoad(cusIsAsyn)
            end
        else
            self:__preLoad(cusIsAsyn)
        end
    end
end

function __preLoad(self, cusIsAsyn)
    if (self.m_isLoadFinish) then
        return
    end

    if(self.IsAsyn ~= nil)then
        cusIsAsyn = self.IsAsyn
    end

    if (cusIsAsyn) then
        local loadFinish = function(go, args)
            if(not web.WebManager:isReleaseApp())then
                local list = string.split(self:__getPrefabName(), "/")
                local prefabName = string.split(list[#list], ".")[1]
                if(go.name ~= prefabName .. "(Clone)")then
                    gs.GameObject.Destroy(go)
                    Debug:log_error(string.format("异步加载出来的资源%s和%s不一致", go.name, self:__getPrefabName()))
                    return
                end
            end

            self.m_loadSn = nil
            self.m_uiGo = go
            self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.m_uiGo)
            self.m_isLoadFinish = true
            self:__updateView()
            self:doFinishCall()
        end
        if (self.m_loadSn ~= nil) then
            gs.GOPoolMgr:CancelAsyc(self.m_loadSn)
        end
        self.m_loadSn = gs.GOPoolMgr:GetAsyc(self:__getPrefabName(), loadFinish, nil)
    else
        local go = gs.GOPoolMgr:Get(self:__getPrefabName())
        if(not web.WebManager:isReleaseApp())then
            local list = string.split(self:__getPrefabName(), "/")
            local prefabName = string.split(list[#list], ".")[1]
            if(go.name ~= prefabName .. "(Clone)")then
                gs.GameObject.Destroy(go)
                Debug:log_error(string.format("同步加载出来的资源%s和%s不一致", go.name, self:__getPrefabName()))
                return
            end
        end

        self.m_uiGo = go
        self.m_childGos, self.m_childTrans = GoUtil.GetChildHash(self.m_uiGo)
        self.m_isLoadFinish = true
        self:__updateView()
        self:doFinishCall()
    end
end

function getTrans(self)
    if (self.m_uiGo and not gs.GoUtil.IsGoNull(self.m_uiGo)) then
        return self.m_uiGo.transform
    else
        return nil
    end
end

function getData(self)
    return self.m_data
end

function __updateView(self)
    if (not self:getData()) then
        return
    end
    self:__initGo()
    self:__removeEventList()
    self:__addEventList()
    self:__updateBaseView()
    self:__updateCustomView()
end

function __removeEventList(self)
end

function __addEventList(self)
end

-- 更新基础的信息显示
function __updateBaseView(self)
    self:__updateParent()
    self:__updateClickEnable()
    self:__updatePosition()
    self:__updateScale()
end

-- 更新其他的信息显示
function __updateCustomView(self)
end

function setParent(self, cusParentTrans)
    self.m_parentTrans = cusParentTrans
    self:__updateParent()
end

function __updateParent(self)
    if (self.m_isLoadFinish) then
        if (self.m_parentTrans ~= nil) then
            self.m_uiGo.transform:SetParent(self.m_parentTrans, false)
        end
    end
end

function __initGo(self)
    local rect = self.m_uiGo:GetComponent(ty.RectTransform)
    gs.TransQuick:UIPos(rect, 0, 0)
    gs.TransQuick:Anchor(rect, 0.5, 0.5, 0.5, 0.5)
    gs.TransQuick:Scale(rect, 1, 1, 1)
    -- gs.TransQuick:Pivot(groupRect, 0, 1)
end

function doFinishCall(self)
    -- 如果是已经加载好了的，延迟一帧回调，避免外部逻辑还没拿到本对象
    LoopManager:addFrame(1, 1, self, function()
        if(self.m_finishCall)then
            self.m_finishCall()
        end
    end)
end

function setCallBack(self, cusCallObj, cusCallFun, ...)
    if select("#", ...) > 0 then
        self.m_params = {...}
    end
    self.m_callFun = cusCallFun
    self.m_callObj = cusCallObj
end

-- 设置是否可点击
function setClickEnable(self, cusClickEnable)
    self.m_clickEnable = cusClickEnable
    self:__updateClickEnable()
end

function __updateClickEnable(self)
    if (self.m_isLoadFinish) then
        if (self.m_clickEnable == nil or self.m_clickEnable == true) then
            if not self.m_uiGo:GetComponent(ty.Button) then
                -- logWarn(self.__cname, self:__getPrefabName().."没有对应Button组件")
            else
                self:addOnClick(self.m_uiGo, self.__onClickHandler)
            end
        else
            if self.m_uiGo:GetComponent(ty.Button) then
                self:removeOnClick(self.m_uiGo)
            end
        end
    end
end

-- 点击触发
function __onClickHandler(self)
    if (self.m_callFun and self.m_callObj) then
        -- 调用外部处理
        if self.m_params then
            self.m_callFun(self.m_callObj, self:getData(), unpack(self.m_params))
        else
            self.m_callFun(self.m_callObj, self:getData())
        end
    else
        -- 内部默认处理
        self:__onDefaultClickHandler()
    end
end

-- 点击触发默认处理
function __onDefaultClickHandler(self)
    -- override
end

function setPosition(self, cusPos)
    self.m_pos = cusPos
    self:__updatePosition()
end

function __updatePosition(self)
    if (self.m_isLoadFinish) then
        if (self.m_pos ~= nil) then
            if (self.m_rect == nil) then
                self.m_rect = self.m_uiGo:GetComponent(ty.RectTransform)
            end
            gs.TransQuick:LPos(self.m_rect, self.m_pos.x, self.m_pos.y, self.m_pos.z)
        end
    end
end

function setScale(self, scale)
    self.m_scale = scale
    self:__updateScale()
end

function __updateScale(self)
    if (self.m_isLoadFinish) then
        if (self.m_scale ~= nil) then
            if (self.m_rect == nil) then
                self.m_rect = self.m_uiGo:GetComponent(ty.RectTransform)
            end
            gs.TransQuick:Scale(self.m_rect, self.m_scale, self.m_scale, self.m_scale)
        end
    end
end

function setGuideTrans(self, ctrlname, ctrlTrans)
    guide.GuideUITransHandler:addTrans(self.m_sn, ctrlname, ctrlTrans)
end

function clearGuideTrans(self)
    guide.GuideUITransHandler:clearTrans(self.m_sn)
end

return _M
