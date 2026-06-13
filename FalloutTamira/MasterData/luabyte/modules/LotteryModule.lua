local LotteryModule = BaseClass("LotteryModule" , require("Framework.Module.BaseGameModule"))
local M = LotteryModule
local tInsert = table.insert

function M:__init()
    self._curPlayer = nil 
end

function M:OnEnter(page)
    self.page = page
    M.super.OnEnter(self)
    local request = {}
    NetPack:SendMessage(Proto.MessageId.RequestLoadLottoRec, request)
    self._requestLottoCallbackHandler = NetPack:RegistResponse(Proto.MessageId.ResponseLoadLottoRec, Bind(self,self._OnResponseGameLotto))
end

function M:_OnResponseGameLotto(msgId,result,msg)
    NetPack:UnRegistResponse(Proto.MessageId.ResponseLoadLottoRec, self._requestLottoCallbackHandler)
    if result ~= 0 then 
        self.hasError = true
        return
    end
    self._msg = msg 
    if self:GetCurSceneName() ~= "Display02" then
        self:LoadScene("Display02", Bind(self, self._LoadSceneComplete))
    else
        self:_LoadSceneComplete(self:GetViewAndCtrl("Display02"))
    end
    self._startPlayTimeHandler =  EventMgr:AddListener(UIMessageNames.LOTTERY_TIMELINE_PLAY_START,Bind(self,self._StartPlayTime))
    self._startLuckDrawPlayTimeHandler =  EventMgr:AddListener(UIMessageNames.LOTTERY_LUCKDRAW_TIMELINE_PLAY_START,Bind(self,self._LuckDrawEnd))
    local num = UIContextMgr:GetInstance():GetContext("Lottery"):ResetcurIdx()
end

function M:_LoadSceneComplete(_,ctrl)
    --local view = self:GetViewAndCtrl("Display02")
    ctrl:ChangeDisplay("Lottery")
    self._ctrl = ctrl
    -- view.mainsceneObjs:SetActive(false)
    -- view.shopObjs:SetActive(false)
    -- view.CameraNode:SetActive(false)
    -- view.developObjs:SetActive(false)
    -- view.lotteryObjs:SetActive(false)
    -- view.otakuObjs:SetActive(false)
    -- view.luckdrawObjs:SetActive(false)
    self._lotteryView = ctrl:GetHolder("Lottery")
    --self._lotteryView = view.lotteryHolder
    self._lockDrawView = ctrl:GetHolder("LuckDraw")
    --self._lockDrawView = view.luckdrawHolder

    if self._lotteryView.cameraBrain then 
        self._lotteryView.cameraBrain:SetActive(false)
    end
    local cls = require ("UI.Ctrl.Lottery.LotteryTimelinePlayer")
    self._timelinePlayer = { cls.New(self._lotteryView.ChouKa_1) , cls.New(self._lotteryView.ChouKa_10) }
    for i,player in ipairs(self._timelinePlayer) do
        player:SetActive(false)
    end
    UIContextMgr:GetInstance():Show("Lottery",self.page,self._msg).onShow = Bind(self,self._WaitForReady)
    --coroutine.start(Bind(self,self._WaitForReady))
end

function M:_WaitForReady()
    --coroutine.waitforseconds(0.1)

    -- local view = self:GetViewAndCtrl("Display02")
    -- view.mainsceneObjs:SetActive(false)
    -- view.shopObjs:SetActive(false)
    -- view.CameraNode:SetActive(false)
    -- view.developObjs:SetActive(false)
    -- view.lotteryObjs:SetActive(true)
    -- view.otakuObjs:SetActive(false)
    -- view.luckdrawObjs:SetActive(false)
    self:Ready()
end

function M:ChangeLotteryState(type)
    if type == 1 then 
        self._ctrl:ChangeDisplay("Lottery")
    else
        self._ctrl:ChangeDisplay("LuckDraw")
    end
end

function M:_StartPlayTime( lotteryId, heros,startFrame)
    if self._lotteryView.cameraBrain then 
        self._lotteryView.cameraBrain:SetActive(true)
    end
    --关闭主UI 
    UIContextMgr:GetInstance():Close("Lottery")
    local player = nil 
    local idx = 1 
    if #heros == 1 then 
        idx = 1 
    else
        idx = 2 
    end
    if startFrame == nil then 
        startFrame = 0 
    end
    if self._curPlayer then 
        self._curPlayer:SetActive(false)
    end
    for i,player in ipairs(self._timelinePlayer) do
        player:SetActive(i==idx)
        if idx == i then 
            player:Play1ResultTimeline(heros,startFrame,3,
            --暂停时显示提示UI 
            function()
                UIContextMgr:GetInstance():Show("LotteryGuideUI")
            end,
            --播放完成
            function(heros,finish)
                player:SetActive(false)
                if finish then
                    EventMgr:Broadcast(UIMessageNames.LOTTERY_TIMELINE_PLAY_OVER,lotteryId,heros)
                else
                    ---跳过timeline 仅展示ssr
                    local ssrHeros = {}
                    for _, value in pairs(heros) do
                        local itemcfg = ConfigHelper.GetCfg("item",value.ObjId)
                        if itemcfg.quality >= 4 then
                        tInsert(ssrHeros,value)
                        end
                    end
                    --跳过timeline也跳过立绘展示
                    EventMgr:Broadcast(UIMessageNames.LOTTERY_TIMELINE_SKIP,lotteryId,heros,ssrHeros)
                end
        end,
            --拖动完成后关闭提示UI 
            function()
                UIContextMgr:GetInstance():Close("LotteryGuideUI")
            end )
            self._curPlayer = player 
        end
    end
end

--原始道具，实际到手的道具ID，实际到手的道具数量
function M:_LuckDrawEnd(oitems,itemids,itemNumbers)
    --local view = self:GetViewAndCtrl("Display02")
    --view.luckdrawObjs:SetActive(true)
    --self._lotteryView:SetActive(true)
    GameHelper.DoPlayerAction(PlayerAction.LuckDrawAct)
    self:ChangeCameraTimeLine(2)
    self.showGuide = true
    if self._lotteryView.cameraBrain then 
        self._lotteryView.cameraBrain:SetActive(true)
    end
    GameHelper.PlayTimelineObjByCallBack(self._lockDrawView.luckDrawTimeLine.gameObject)
    self._lockDrawView.luckDrawCtrl.gameObject:SetActive(true)

    local oitemIds = {}
    local oitemNums = {}
    for key, value in pairs(oitems) do
        tInsert(oitemIds,key)
        tInsert(oitemNums,value)
    end

    self._lockDrawView.luckDrawCtrl:Init(oitemIds,itemids,itemNumbers,
        function()
            self.showGuide = false
            UIContextMgr:GetInstance():Close("LotteryGuideUI2")
        end
    ,
        function(go)
        self:ChangeCameraTimeLine(3)
        end
    ,
        function(go)
            --UIContextMgr:GetInstance():Show("Lottery")
            self._lockDrawView.luckDrawCtrl:MReset()
            local uiCamera = ICameraMgr:GetCamera(1)
            local uiLayer = PhysicsMgr.NamesToLayer(PhysicsMgr.g_uiLayerName)
            uiCamera.cullingMask = uiLayer.value

        end
    ,
        function(go)
            self:ChangeCameraTimeLine(1)
            UIContextMgr:GetInstance():Close("LotteryGuideUI2") --有时候会关不掉 再关一次
            UIContextMgr:GetInstance():GetContext("Lottery"):Open()
            --self._lockDrawView.camera.gameObject:SetActive(false)
            --view.luckdrawObjs:SetActive(false)
            self._lotteryView:SetActive(false)
        end
    )
    UIContextMgr:GetInstance():Close("Lottery")
    coroutine.start(Bind(self,self._WaitForShowGuide))
end



function M:_WaitForShowGuide()
    coroutine.waitforseconds(1.2)
    if self.showGuide then
        UIContextMgr:GetInstance():Show("LotteryGuideUI2")
    end
end


--index:1-开始到UI  2-点击UI后到开始抽 3-抽完回UI
function M:ChangeCameraTimeLine(index)
    self._lockDrawView.luckDrawTimeLine:SetActive(index ==2)
    self._lockDrawView.GiftBox_end:SetActive(index == 1)
    self._lockDrawView.GiftBox_return:SetActive(index ==3)
end


function M:OnExit()
    UIContextMgr:GetInstance():GetContext("Lottery"):ResetcurIdx()
    if self._timelinePlayer then 
        for i,player in ipairs(self._timelinePlayer) do
            player:Dispose()
        end
    end
    
    self._curPlayer = nil 
    UIContextMgr:GetInstance():Close("Lottery")
    EventMgr:RemoveListener(UIMessageNames.LOTTERY_TIMELINE_PLAY_START,self._startPlayTimeHandler)
    EventMgr:RemoveListener(UIMessageNames.LOTTERY_LUCKDRAW_TIMELINE_PLAY_START,self._startLuckDrawPlayTimeHandler)
    
    M.super.OnExit(self)
end

return LotteryModule