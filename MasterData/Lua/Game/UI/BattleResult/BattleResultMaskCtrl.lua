local BattleResultMaskCtrl = class("BattleResultMaskCtrl", BaseCtrl)
BattleResultMaskCtrl._mapNodeConfig = {
  animRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  }
}
BattleResultMaskCtrl._mapEventConfig = {
  SettlementPerformLoadFinish = "OnEvent_LoadFinish"
}

function BattleResultMaskCtrl:Awake()
end

function BattleResultMaskCtrl:OnEnable()
end

function BattleResultMaskCtrl:OnDisable()
end

function BattleResultMaskCtrl:OnDestroy()
end

function BattleResultMaskCtrl:OnEvent_LoadFinish()
  self._mapNode.animRoot:Play("BattleResultMaskPanel_victory_out")
  local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.animRoot, {
    "BattleResultMaskPanel_victory_out"
  })
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(nAnimTime))
    EventManager.Hit(EventId.ClosePanel, PanelId.BattleResultMask)
    EventManager.Hit("OpenBattleResultPanel")
  end
  
  cs_coroutine.start(wait)
end

return BattleResultMaskCtrl
