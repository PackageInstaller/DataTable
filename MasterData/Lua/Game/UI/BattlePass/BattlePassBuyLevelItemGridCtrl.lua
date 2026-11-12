local BattlePassBuyLevelItemGridCtrl = class("BattlePassBuyLevelItemGridCtrl", BaseCtrl)
BattlePassBuyLevelItemGridCtrl._mapNodeConfig = {
  rtItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btnGrid = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Grid"
  }
}
BattlePassBuyLevelItemGridCtrl._mapEventConfig = {}
BattlePassBuyLevelItemGridCtrl._mapRedDotConfig = {}

function BattlePassBuyLevelItemGridCtrl:Refresh(nTid, nCount)
  self.nTid = nTid
  self._mapNode.rtItem:SetItem(nTid, nil, nCount, nil, false, false, false, true, false)
end

function BattlePassBuyLevelItemGridCtrl:OnBtnClick_Grid(btn)
  UTILS.ClickItemGridWithTips(self.nTid, btn.gameObject.transform, true, true, false)
end

return BattlePassBuyLevelItemGridCtrl
