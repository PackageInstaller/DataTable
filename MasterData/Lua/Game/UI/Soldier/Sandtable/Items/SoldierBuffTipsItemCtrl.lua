local SoldierBuffTipsItemCtrl = class("SoldierBuffTipsItemCtrl", BaseCtrl)
SoldierBuffTipsItemCtrl._mapEventConfig = {}
SoldierBuffTipsItemCtrl._mapRedDotConfig = {}

function SoldierBuffTipsItemCtrl:OnRefresh(mapCfg)
  if mapCfg == nil then
    return
  end
  self:SetPngSprite(self._mapNode.ImageIcon, mapCfg.Icon)
  NovaAPI.SetTMPText(self._mapNode.TextName, mapCfg.Name or "")
  local sDes = mapCfg.Desc or mapCfg.Des or ""
  NovaAPI.SetTMPText(self._mapNode.TextDes, sDes)
end

return SoldierBuffTipsItemCtrl
