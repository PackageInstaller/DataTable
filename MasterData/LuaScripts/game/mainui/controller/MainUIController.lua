--[[****************************************************************************
Brief  :主UI控制器
Author :lizhenghui
****************************************************************************
]]
module('mainui.MainUIController', Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
    self:__init()
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    self:__init()
    super.reLogin(self)
end

function __init(self)
    if self.m_mainUI then
        self.m_mainUI:destroy()
        self.m_mainUI = nil
    end
end

--游戏开始的回调
function gameStartCallBack(self)
    -- self:onShowMainUIHandler()
end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.SHOW_MAIN_UI, self.onShowMainUIHandler, self)
    GameDispatcher:addEventListener(EventName.HIDE_MAIN_UI, self.onHideMainHandler, self)
    GameDispatcher:addEventListener(EventName.UI_SHOW_CHANGE, self.onUIShowChangeHandler, self)
    GameDispatcher:addEventListener(EventName.HERO_LIST_INIT, self.onInitHeroListHandler, self)
    GameDispatcher:addEventListener(EventName.SHOW_MAINUI_WALLPAPER, self.onShowWallpaperHandler, self)
    GameDispatcher:addEventListener(EventName.CLOSE_MAINUI_WALLPAPER, self.onCloseWallpaperHandler, self)

    GameDispatcher:addEventListener(EventName.OPEN_RECOVERY_PANEL, self.onClickRecoveryHandler, self)
    -- GameDispatcher:addEventListener(EventName.MAP_TYPE_CHANGE, self.onMapTypeChangeHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {}
end

--显示主UI
function onShowMainUIHandler(self, args)
    if self.m_mainUI == nil then
        self.m_mainUI = mainui.MainUI.new()
    end
    self.m_mainUI:open(args)
end

-- 关闭主UI
function onHideMainHandler(self)
    if self.m_mainUI ~= nil then
        self.m_mainUI:close()
    end
end

function onUIShowChangeHandler(self)
    if mainui.MainUIManager:getUIIsShow(UI_TYPE.MAIN) then
        self:onShowMainUIHandler()
    else
        self:onHideMainHandler()
    end
end

-- 战员初始化完成
function onInitHeroListHandler(self)
    if bigHostel.BigHostelManager:getMainUIShow() then
        return
    end

    mainui.MainUIManager:setHeroInit()
    mainui.MainUIManager:playFirstCV()
end

-- 地图类型改变
function onMapTypeChangeHandler(self)
    mainui.MainUIManager:setUIShow()
    self:_checkFlag()
end

-- 检测红点
function _checkFlag(self)
end

-- 展示壁纸
function onShowWallpaperHandler(self, args)
    if self.mMainUIWallpaper == nil then
        self.mMainUIWallpaper = mainui.MainUIWallpaper.new()
        self.mMainUIWallpaper:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainUIWallpaper, self)
    end
    self.mMainUIWallpaper:open(args)
end

function onDestroyMainUIWallpaper(self)
    self.mMainUIWallpaper:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyMainUIWallpaper, self)
    self.mMainUIWallpaper = nil
end

-- 关闭壁纸
function onCloseWallpaperHandler(self)
    if self.mMainUIWallpaper and self.mMainUIWallpaper.isPop == 1 then
        self.mMainUIWallpaper:close()
    end
    self:onShowMainUIHandler()
end

-- 桌面是否处于壁纸状态
function checkWallpaperIsShow(self)
    if self.mMainUIWallpaper and self.mMainUIWallpaper.isPop == 1 then
        return true
    end
end


function onClickRecoveryHandler(self,args)
    if self.mRecoveryPanel==nil then
        self.mRecoveryPanel = mainui.RecoveryPanel.new()
        self.mRecoveryPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRecoveryPanel, self)
    end
    self.mRecoveryPanel:open(args)
end

function onDestroyRecoveryPanel(self)
    self.mRecoveryPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyRecoveryPanel, self)
    self.mRecoveryPanel = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]