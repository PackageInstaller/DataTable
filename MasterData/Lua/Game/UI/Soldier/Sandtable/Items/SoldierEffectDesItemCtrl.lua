local SoldierEffectDesItemCtrl = class("SoldierEffectDesItemCtrl", BaseCtrl)
SoldierEffectDesItemCtrl._mapNodeConfig = {}
SoldierEffectDesItemCtrl._mapEventConfig = {}
SoldierEffectDesItemCtrl._mapRedDotConfig = {}

function SoldierEffectDesItemCtrl:OnRefresh(tbData, nCardId)
  if self._mapNode.TextName ~= nil then
    NovaAPI.SetTMPText(self._mapNode.TextName, tbData and tbData.sName or "")
  end
  if self._mapNode.TextDes ~= nil then
    NovaAPI.SetTMPText(self._mapNode.TextDes, tbData and tbData.sDes or "")
  end
end

return SoldierEffectDesItemCtrl
