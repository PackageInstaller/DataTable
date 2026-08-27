local base = require("Game.ActivityLobby.Entity.Interact.LbInteractEntityBase")
local LbIntrctNormalEntity = class("LbIntrctNormalEntity", base)

function LbIntrctNormalEntity:ctor()
end

function LbIntrctNormalEntity:HideLbEnttRenderer(hide)
  if not self._lbIntrctData:GetLbIntrctObjHide() then
    return
  end
  if self:GetRenderHide() then
    return
  end
  for i = 0, self.transform.childCount - 1 do
    local childTransform = self.transform:GetChild(i)
    if childTransform.name ~= "UIPoint" and childTransform.name ~= "InteractRange" then
      childTransform.gameObject:SetActive(not hide)
    end
  end
end

return LbIntrctNormalEntity
