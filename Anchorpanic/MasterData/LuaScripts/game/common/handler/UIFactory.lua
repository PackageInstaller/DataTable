local BaseMask = require('game/common/logic_ui/BaseMask')
local AlertOK = require('game/common/logic_ui/AlertOK')
local AlertOKCancel = require('game/common/logic_ui/AlertOKCancel')

local AlertMessge = require('game/common/logic_ui/AlertMessgeView')
local AlertStoryMessge = require('game/common/logic_ui/AlertStoryMessgeView')

local Screensaver = require('game/common/logic_ui/Screensaver')
local ScreensaverOld = require('game/common/logic_ui/ScreensaverOld')
local LoadOnView = require('game/common/logic_ui/LoadOnView')
local AlertMessageWeakView = require('game/common/logic_ui/AlertMessageWeakView')
local NetReconnectView = require('game/common/logic_ui/NetReconnectView')
local NetRollView = require('game/common/logic_ui/NetRollView')

local UIFactory = Class.class('UIFactory')

-- function UIFactory:ctor()
-- end
--[[_s
@todo: 打开只有一个按钮类型警告框
@param: title 提示标题, 传nil会用默认值
@param: msg 提示内容
@param: call 回调函数，可以为nil
@return: alertUI
]]
function UIFactory:alertOK0(title, msg, call, tipCall)
    local alert = AlertOK.getInstance()
    alert:setInfo(title, msg, call, tipCall)
    alert:open()
    return alert
end

--[[_s
@todo: 打开只有两个按钮类型警告框
@param: title 提示标题, 传nil会用默认值
@param: msg 提示内容
@param: call 回调函数，可以为nil
@return: alertUI
]]
function UIFactory:alertOKCancel0(title, msg, call, tipCall)
    local alert = AlertOKCancel.getInstance()
    alert:setInfo(title, msg, call, tipCall)
    alert:open()
    return alert
end

--[[@todo: 打开背景遮罩
@param: layerTrans 打开所在层
]]
function UIFactory:bgMaskOpen(layerTrans, siblingIdx)
    local mask = BaseMask.getInstance()
    mask:open(layerTrans, siblingIdx)
end
--[[@todo: 关闭背景遮罩
]]
function UIFactory:bgMaskClose()
    local mask = BaseMask.getInstance()
    mask:close()
end

--[[
    低层级弹出提示框
    @msg 内容信息（为富文本，支持图文混排）
    @isShowConfirm 是否显示确认按钮
    @confirmCallBack 确定回调
    @confirmLabel 确定按钮文本内容
    @confirmParam 确定回调参数
    @isShowCancel 是否显示取消按钮
    @cancelCallBack 取消回调
    @cancelLabel 取消按钮文本内容
    @title 标题
    @isShowClose 是否显示关闭按钮
    @notRemindType 是否显示今日不再提示
    @tipsLitleDes  内容信息解释
    ------今日不提示的会直接执行到回调参数-------
]]
function UIFactory:alertMessge(msg, isShowConfirm, confirmCallBack, confirmLabel, confirmParam, isShowCancel, cancelCallBack, cancelLabel, title, isShowClose, notRemindType, tipsLitleDes, cancelTime)
    local isNotRemind = false
    if(notRemindType) then
        isNotRemind = remind.RemindManager:isTodayNotRemain(notRemindType)
    end
    if not isNotRemind then
        local destroyView = function()
            self.alertMessgeView:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
            self.alertMessgeView = nil
        end
        if self.alertMessgeView == nil then
            self.alertMessgeView = AlertMessge.new()
            self.alertMessgeView:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        end
        --初始化bool参数默认值 通用参数无需外部关注传参
        if isShowConfirm == nil then isShowConfirm = true end
        if isShowCancel == nil then isShowCancel = true end
        if isShowClose == nil then isShowClose = true end
        local data = {
            msg = msg,
            isShowConfirm = isShowConfirm,
            confirmCallBack = confirmCallBack or nil,
            confirmLabel = confirmLabel or _TT(1),
            confirmParam = confirmParam or nil,
            isShowCancel = isShowCancel,
            cancelCallBack = cancelCallBack or nil,
            cancelLabel = cancelLabel or _TT(2),
            title = title or _TT(5),
            isShowClose = isShowClose, --无用参数
            notRemindType = notRemindType or nil,
            tipsLitleDes = tipsLitleDes or nil,
            cancelTime = cancelTime or nil
            }
        self.alertMessgeView:open(data)
    else
        confirmCallBack(confirmParam)
    end

    return self.alertMessgeView
end

--[[
    低层级弹出提示框 剧情专用
    @msg 内容信息（为富文本，支持图文混排）
    @isShowConfirm 是否显示确认按钮
    @confirmCallBack 确定回调
    @confirmLabel 确定按钮文本内容
    @confirmParam 确定回调参数
    @isShowCancel 是否显示取消按钮
    @cancelCallBack 取消回调
    @cancelLabel 取消按钮文本内容
    @title 标题
    @isShowClose 是否显示关闭按钮
    @notRemindType 是否显示今日不再提示
    @tipsLitleDes  内容信息解释
    ------今日不提示的会直接执行到回调参数-------
]]
function UIFactory:alertStoryMessge(msg,storyTitle,storyDes, isShowConfirm, confirmCallBack, confirmLabel, confirmParam, isShowCancel, cancelCallBack, cancelLabel, title, isShowClose, notRemindType, tipsLitleDes, cancelTime)
    local isNotRemind = false
    if(notRemindType) then
        isNotRemind = remind.RemindManager:isTodayNotRemain(notRemindType)
    end
    if not isNotRemind then
        local destroyView = function()
            self.alertStoryMessgeView:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
            self.alertStoryMessgeView = nil
        end
        if self.alertStoryMessgeView == nil then
            self.alertStoryMessgeView = AlertStoryMessge.new()
            self.alertStoryMessgeView:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        end
        --初始化bool参数默认值 通用参数无需外部关注传参
        if isShowConfirm == nil then isShowConfirm = true end
        if isShowCancel == nil then isShowCancel = true end
        if isShowClose == nil then isShowClose = true end
        local data = {
            msg = msg,
            storyTitle = storyTitle,
            storyDes = storyDes,
            isShowConfirm = isShowConfirm,
            confirmCallBack = confirmCallBack or nil,
            confirmLabel = confirmLabel or _TT(1),
            confirmParam = confirmParam or nil,
            isShowCancel = isShowCancel,
            cancelCallBack = cancelCallBack or nil,
            cancelLabel = cancelLabel or _TT(2),
            title = title or _TT(5),
            isShowClose = isShowClose, --无用参数
            notRemindType = notRemindType or nil,
            tipsLitleDes = tipsLitleDes or nil,
            cancelTime = cancelTime or nil
            }
        self.alertStoryMessgeView:open(data)
    else
        confirmCallBack(confirmParam)
    end

    return self.alertStoryMessgeView
end

--[[
    打开页面的黑色过渡界面（闪一下黑屏，同时打开加载界面）
]]
function UIFactory:openScreenSaver(time, noLoad)
    if self.loadOnView and self.loadOnView.isOpen == 1 then return end
    if not self.screensaverMask then
        self.screensaverMask = Screensaver.new()
    end
    self.screensaverMask:show(time, noLoad)
end

--[[
    关闭页面的黑色过渡界面（关闭加载界面，如果不存在黑色过渡动画再次调用褐色过渡动画）
]]
function UIFactory:closeScreenSaver(time)
    if not self.screensaverMask then
        self.screensaverMask = Screensaver.new()
    end
    self.screensaverMask:start(time)
end

--[[
    打开页面的黑色过渡界面（闪一下黑屏，同时打开加载界面）
]]
function UIFactory:openScreenSaverOld(time, noLoad)
    if self.loadOnView and self.loadOnView.isOpen == 1 then return end
    if not self.screensaverOldMask then
        self.screensaverOldMask = ScreensaverOld.new()
    end
    self.screensaverOldMask:show(time, noLoad)
end

--[[
    打开加载过度界面
]]
function UIFactory:openLoadOnView(load_id)
    if not self.loadOnView then
        self.loadOnView = LoadOnView.new()
    end
    if(self.loadOnView.isOpen ~= 1)then
        self.loadOnView:open(load_id)
    end
end

--[[
    关闭加载过度界面
]]
function UIFactory:closeLoadOnView()
    if self.loadOnView then
        self.loadOnView:close()
    end
end

--[[
    打开加载界面（强制显示，不被其他关闭，必须和closeForcibly成对出现）
]]
function UIFactory:startForcibly(load_id)
    if not self.screensaverMask then
        self.screensaverMask = Screensaver.new()
    end
    self.screensaverMask:startForcibly(load_id)
end

--[[
    取消强制显示
]]
function UIFactory:closeForcibly()
    if not self.screensaverMask then
        self.screensaverMask = Screensaver.new()
    end
    self.screensaverMask:closeForcibly()
end

--[[@todo: 打开弱提示
]]
function UIFactory:openAlertWeakView(content)
    if not self.alertWeakView then
        self.alertWeakView = AlertMessageWeakView.new()
    end
    if(self.alertWeakView.isOpen == 1)then
        self.alertWeakView:close()
    end
    self.alertWeakView:open()
    self.alertWeakView:setContent(content)
end

--[[@todo: 关闭弱提示
]]
function UIFactory:closeAlertWeakView()
    if self.alertWeakView then
        self.alertWeakView:close()
    end
end

-- 展示掉线重连提示
function UIFactory:showReconnect()
    local destroyView = function()
        self.netReconnectView:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        self.netReconnectView = nil
    end
    if self.netReconnectView == nil then
        self.netReconnectView = NetReconnectView.new()
        self.netReconnectView:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end
    self.netReconnectView:open()

    return self.netReconnectView
end

-- 打开网络转圈圈界面
function UIFactory:showNetRollView()
    local destroyView = function()
        self.netRollView:removeEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
        self.netRollView = nil
    end
    if self.netRollView == nil then
        self.netRollView = NetRollView.new()
        self.netRollView:addEventListener(View.EVENT_VIEW_DESTROY, destroyView, self)
    end
    self.netRollView:open()
end

-- 关闭网络转圈圈界面
function UIFactory:closeNetRollView()
    if self.netRollView then
        self.netRollView:close()
    end
end

return UIFactory

--[[ 替换语言包自动生成，请勿修改！
]]
