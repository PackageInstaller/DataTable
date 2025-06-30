--[[        -----------------------------------------------------
@filename       : SurveyWebView
@Description    : 调查问卷外部网页
@date           : 2021-03-31 13:53:34
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
        -----------------------------------------------------
        ]]
module("game.webView.view.SurveyWebView", Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("webView/SurveyWebView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
end

function getAdaptaTrans(self)
    return self:getChildTrans("mGroupTop")
end

--析构
function dtor(self)
end

function initData(self)
    self.webUrl = ""
end

-- 初始化
function configUI(self)
    self.mBtnClose = self:getChildGO("mBtnClose")
end

--激活
function active(self, args)
    super.active(self, args)
    self.bulletinId = args.bulletinId
    self.webUrl = args.webUrl
    self:__updateView()
    -- 修改为点开就发奖励
    -- self:addTimerSendComplete()
    self:onTimerSendComplete()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:closeWebView()
    -- self:removeTimerSendComplete()
end

function setMoneyBar(self)
end

function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickClose)
end

function closeWebView(self)
    if (self.mWebId) then
        sdk.SdkManager:closeWebView(self.mWebId)
    end
    self.mWebId = nil
end

function openWebView(self, url, posX, posY, width, height)
    self:closeWebView()
    if (url and url ~= "") then
        self.mWebId = self._NAME
        sdk.SdkManager:openWebView(self.mWebId, url, GameView.UINode["SUB_POP"], posX, posY, width, height)
    end
end

-- function addTimerSendComplete(self)
--     if(not self.mTimerSn)then
--         self.mTimerSn = LoopManager:addTimer(1, 0, self, self.onTimerSendComplete)
--     end
-- end

-- function removeTimerSendComplete(self)
--     if(self.mTimerSn)then
--         LoopManager:removeTimerByIndex(self.mTimerSn)
--     end
-- end

function onTimerSendComplete(self)
    GameDispatcher:dispatchEvent(EventName.SEND_SURVER_COMPLETE, self.bulletinId)
    -- logInfo("=====打开页面10s，请求领取奖励=====")
end

function __updateView(self)
    self.webUrl = self.webUrl .. "?sojumpparm=g=12;pf=" .. web.WebManager.pf_id .. ";ch=" .. web.WebManager.channel_id .. ";srv=" .. web.WebManager.server_id .. ";player=" .. role.RoleManager:getRoleVo().playerId
    -- self.webUrl = "https://www.wjx.cn/vj/ws1yYSw.aspx?sojumpparm=g=12;pf=3;ch=998;srv=399809999;player=1717170870318792705"

    if (not self.mIsInit) then
        self.mIsInit = true
        local posWeb1 = self.UITrans:InverseTransformPoint(self:getChildTrans("PointWeb1").position)
        local posWeb2 = self.UITrans:InverseTransformPoint(self:getChildTrans("PointWeb2").position)
        local posMax1 = self.UITrans:InverseTransformPoint(self:getChildTrans("PointMax1").position)
        local posMax2 = self.UITrans:InverseTransformPoint(self:getChildTrans("PointMax2").position)
        local screenWidth = math.ceil(math.abs(posMax1.x) + math.abs(posMax2.x))
        local screenHeight = math.ceil(math.abs(posMax1.y) + math.abs(posMax2.y))
        self.mWebWidth = math.ceil(math.abs(posWeb1.x) + math.abs(posWeb2.x))
        self.mWebHeight = math.ceil(math.abs(posWeb1.y) + math.abs(posWeb2.y))

        self.mWebPosX = math.ceil(math.abs(posMax1.x) - math.abs(posWeb1.x))
        self.mWebPosY = math.ceil(math.abs(posMax1.y) - math.abs(posWeb1.y))

        self.mRatioX = 1
        self.mRatioY = 1
        local sdkInfo = sdk.SdkManager:getSdkInfo()
        if(sdkInfo)then
            self.mRatioX = (sdkInfo and sdkInfo.screenWidth and sdkInfo.screenHeight) and math.max(sdkInfo.screenWidth, sdkInfo.screenHeight) / screenWidth or self.mRatioX
            self.mRatioY = (sdkInfo and sdkInfo.screenWidth and sdkInfo.screenHeight) and math.min(sdkInfo.screenWidth, sdkInfo.screenHeight) / screenHeight or self.mRatioY
            print(string.format("SdkWidth = %s, SdkHeight = %s", sdkInfo.screenWidth, sdkInfo.screenHeight))
        end
        print(string.format("ScreenWidth = %s, ScreenHeight = %s", screenWidth, screenHeight))
        print(string.format("WebWidth = %s, WebHeight = %s", self.mWebWidth, self.mWebHeight))
        print(string.format("WebPosX = %s, WebPosY = %s", self.mWebPosX, self.mWebPosY))
        print(string.format("RatioX = %s, RatioY = %s", self.mRatioX, self.mRatioY))
        print(string.format("Params：x = %s, y = %s, width = %s, height = %s", self.mWebPosX * self.mRatioX, self.mWebPosY * self.mRatioY, self.mWebWidth * self.mRatioX, self.mWebHeight * self.mRatioY))
        print(self.webUrl, self.mWebPosX * self.mRatioX, self.mWebPosY * self.mRatioY, self.mWebWidth * self.mRatioX, self.mWebHeight * self.mRatioY)
    end

    self:openWebView(self.webUrl, self.mWebPosX * self.mRatioX, self.mWebPosY * self.mRatioY, self.mWebWidth * self.mRatioX, self.mWebHeight * self.mRatioY)
end

function __playOpenAction(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]