local base = require("Game.Share.UI.UINShareCommonBtn")
local UINLobbyCommonShare = class("UINLobbyCommonShare", base)

function UINLobbyCommonShare:InitShareCommonBtn(shareFunc, shareId, showTipFunc)
  self._shareFunc = shareFunc
  self._shareId = shareId
  self:RefreshLobbyShareNode()
end

function UINLobbyCommonShare:RefreshLobbyShareNode()
  if self._shareId == nil or self._shareId == 0 then
    self:Hide()
    return
  end
  local shareCfg = ConfigData.share[self._shareId]
  if shareCfg == nil then
    self:Hide()
    error("Cant get shareCfg, id:" .. tostring(self._shareId))
    return
  end
  self:Show()
  if not ControllerManager:GetController(ControllerTypeId.Share, true):CanGetShareReward(self._shareId) then
    if not IsNull(self.ui.obj_TipNode) then
      self.ui.obj_TipNode:SetActive(false)
    end
    return
  end
  for itemId, itemNum in pairs(shareCfg.reward) do
    local itemCfg = ConfigData.item[itemId]
    self.ui.img_ItemIcon.sprite = CRH:GetSprite(itemCfg.icon)
    self.ui.tex_ItemNum.text = tostring(itemNum)
    if not IsNull(self.ui.obj_TipNode) then
      self.ui.obj_TipNode:SetActive(true)
    end
    break
  end
end

return UINLobbyCommonShare
