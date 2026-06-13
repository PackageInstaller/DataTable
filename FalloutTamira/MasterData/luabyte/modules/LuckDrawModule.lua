local LuckDrawModule = BaseClass("LuckDrawModule" , require("Framework.Module.BaseGameModule"))
local M = LuckDrawModule

function M:OnEnter()
    M.super.OnEnter(self)
    self:LoadScene("Gift01",Bind(self,self._LoadSceneComplete))
end

function M:_LoadSceneComplete(view)
    self._view = view
    UIContextMgr:GetInstance():Show("LuckDraw",Bind(self,self._LuckDrawEnd))
    self._view.luckDrawCtrl:SetActive(true)
    self._view.luckDrawCtrl:MReset()
    self:ChangeCameraTimeLine(1)
    self:Ready()
end

--抽卡协议完成后 timeline表演
function M:_LuckDrawEnd(itemids,itemNumbers)
    GameHelper.DoPlayerAction(PlayerAction.LuckDrawAct)
    self:ChangeCameraTimeLine(2)
    -- self._view.luckDrawCtrl.transform:GetComponent(typeof(CS.LuckDrawShowCtrl)):Init(itemids,itemNumbers)
    self.showGuide = true
    GameHelper.PlayTimelineObjByCallBack(self._view.luckDrawTimeLine.gameObject)
    self._view.luckDrawCtrl.gameObject:SetActive(true)
    self._view.luckDrawCtrl:Init(itemids,itemNumbers,
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
            UIContextMgr:GetInstance():Show("LuckDraw",Bind(self,self._LuckDrawEnd))
            --ICameraMgr:ActiveCamera(1,true)
            --UIContextMgr:GetInstance():Close("LotteryGuideUI2")
            --self._view.luckDrawCtrl.gameObject:SetActive(false)
            self._view.luckDrawCtrl:MReset()
            local uiCamera = ICameraMgr:GetCamera(1)
            local uiLayer = PhysicsMgr.NamesToLayer(PhysicsMgr.g_uiLayerName)
            uiCamera.cullingMask = uiLayer.value

        end
    ,
        function(go)
            self:ChangeCameraTimeLine(1)
        end
    )
    UIContextMgr:GetInstance():Close("LuckDraw")
    -- UIContextMgr:GetInstance():Show("LotteryGuideUI2")
    --ICameraMgr:ActiveCamera(1,false)
    coroutine.start(Bind(self,self._WaitForShowGuide))

end

function M:_WaitForShowGuide()
    coroutine.waitforseconds(1.2)
    if self.showGuide then
        UIContextMgr:GetInstance():Show("LotteryGuideUI2")
    end
end


function M:OnExit()
    M.super.OnExit(self)
end

--index:1-开始到UI  2-点击UI后到开始抽 3-抽完回UI
function M:ChangeCameraTimeLine(index)
    self._view.luckDrawTimeLine:SetActive(index ==2)
    self._view.GiftBox_end:SetActive(index == 1)
    self._view.GiftBox_return:SetActive(index ==3)
end

return LuckDrawModule