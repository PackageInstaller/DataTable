local TemplateBattleAssetBarCtrl = class("TemplateBattleAssetBarCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
TemplateBattleAssetBarCtrl._mapNodeConfig = {
  imgCoinIcon = {sComponentName = "Image"},
  txtCoinCount = {sComponentName = "TMP_Text"}
}

function TemplateBattleAssetBarCtrl:Awake()
  self.rtObj = self.gameObject:GetComponent("RectTransform")
end

function TemplateBattleAssetBarCtrl:RefreshBar(assetId, assetCount)
  self:SetSprite_Coin(self._mapNode.imgCoinIcon, assetId)
  NovaAPI.SetTMPText(self._mapNode.txtCoinCount, assetCount)
  if nil ~= self.rtObj then
    LayoutRebuilder.ForceRebuildLayoutImmediate(self.rtObj)
  end
end

return TemplateBattleAssetBarCtrl
