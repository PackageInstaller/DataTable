-------------------------------------------------------------------------------
-- 和风战牌 - TCP连接弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-08-30 15:44:25
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')
local battleCardGameComp  = BattleCardGameUtils.GetComp()

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/LadderCompetion/LadderCompetionMatchDialog.prefab > name: ActivityJapanesePokerMatchDialog
---@class BattleCardGameConnectDialog
---@field Env                           	BattleCardGameConnectDialog             
---@field controller                    	Engine.UI.UILuaDialog                   
---@field Root                          	UnityEngine.RectTransform               	@ 0    
---@field TextMatchTime                 	UnityEngine.RectTransform               	@ 1    匹配时间文本
---@field BtnCancelMatch                	UnityEngine.RectTransform               	@ 2    取消匹配按钮
local BattleCardGameConnectDialog = Class('BattleCardGameConnectDialog')


function BattleCardGameConnectDialog:__init()
    ---@type integer @ 启动的时间点
    self.launchTime_ = 0

    ---@type fun():void @ 连接成功回调
    self.connectedCb_ = nil

    ---@type BattleCardGameSocketClient
    self.socketClient_ = battleCardGameComp:GetClient()
end


function BattleCardGameConnectDialog:__delete()
    self.launchTime_   = nil
    self.connectedCb_  = nil
    self.socketClient_ = nil
end


function BattleCardGameConnectDialog:Awake()
    SetButtonAction(self.BtnCancelMatch, Bind(self, self.OnClickCancelButtonHandler_))

    self.mainLoopAction_  = CfUtils.BehaviourActionAdd(self.controller, Bind(self, self.OnMainUpdateBehaviourHandler_))
    self.eventsDecorated_ = CfUtils.EventsDecorated({
        [BattleCardGameUtils.EventsName.SOCKET_CONNECT] = Bind(self, self.OnSocketConnectHandler_),
        [BattleCardGameUtils.EventsName.SOCKET_TIMEOUT] = Bind(self, self.OnSocketTimeoutHandler_),
        [BattleCardGameUtils.EventsName.SOCKET_STOPPED] = Bind(self, self.OnSocketStoppedHandler_),
    })
end


function BattleCardGameConnectDialog:OnInitialize()
    return CoWaitDo(function()
        -- init vars
        local initParams  = CfUtils.DialogSafeParameters(self.controller)
        self.connectedCb_ = initParams.connectedCb

        -- init views
        CfUtils.SetActive(self.BtnCancelMatch, false)
        self:UpdateLaunchTime_()
    end)
end


function BattleCardGameConnectDialog:OnFinalize()
    return CoWaitDo(function()
        CfUtils.BehaviourActionDel(self.mainLoopAction_)
        CfUtils.EventsUndecorated(self.eventsDecorated_)
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


function BattleCardGameConnectDialog:OnShow()
    return CoWaitDo(function()
        -- 连接行为需要放在 OnShow 里面去做，因为连通之后需要关闭自身。
        -- 如果放在 OnInit 中执行的画，极限情况下瞬间连通然后关闭自身，UIModule 会报错，因为自身还没有走完完整流程
        -- socket connect
        local socketHost = battleCardGameComp:GetHomeDojo().socketHost
        self.launchTime_ = os.time()
        self.socketClient_:SocketCreate()
        self.socketClient_:SocketConnect(socketHost)
    end)
end


-------------------------------------------------
-- public

function BattleCardGameConnectDialog:Close()
    CfUtils.DialogClose(self.controller)
end


-------------------------------------------------
-- private

function BattleCardGameConnectDialog:UpdateLaunchTime_()
    local nowTime = os.time()
    local oldTime = checkInt(self.launchTime_)
    CfUtils.FillText(self.TextMatchTime, nowTime - oldTime)
end


-------------------------------------------------
-- handler

function BattleCardGameConnectDialog:OnClickCancelButtonHandler_()
    self:Close()
end


function BattleCardGameConnectDialog:OnMainUpdateBehaviourHandler_()
    if self.launchTime_ > 0 then
        self:UpdateLaunchTime_()
    end
end


function BattleCardGameConnectDialog:OnSocketConnectHandler_()
    if self.connectedCb_ then
        self.connectedCb_()
    end
end


function BattleCardGameConnectDialog:OnSocketTimeoutHandler_()
    self.launchTime_ = 0

    GameUtils.SecondConfirm(localize('建立连接超时，是否要重新尝试？'), 
        function()
            self.launchTime_ = os.time()
            self.socketClient_:SocketReconnect()
            CfUtils.SetActive(self.BtnCancelMatch, false)
        end,
        function()
            self.socketClient_:SocketDestory()
            self:Close()
        end
    )
end


function BattleCardGameConnectDialog:OnSocketStoppedHandler_()
    self.launchTime_ = 0

    GameUtils.SecondConfirm(localize('无法建立连接'), 
        function()
            self.socketClient_:SocketDestory()
            self:Close()
        end,
        function()
            self.socketClient_:SocketDestory()
            self:Close()
        end
    )
end


return BattleCardGameConnectDialog
