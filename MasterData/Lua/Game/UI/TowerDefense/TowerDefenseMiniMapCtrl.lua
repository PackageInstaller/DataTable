local TowerDefenseMiniMapCtrl = class("TowerDefenseMiniMapCtrl", BaseCtrl)
TowerDefenseMiniMapCtrl._mapNodeConfig = {
  btn_CloseMap = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  Img_map = {sComponentName = "Image"},
  txt_continue = {
    sComponentName = "TMP_Text",
    sLanguageId = "Tips_Continue"
  },
  AnimatorRoot = {sComponentName = "Animator"}
}

function TowerDefenseMiniMapCtrl:Open()
  self.gameObject:SetActive(true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function TowerDefenseMiniMapCtrl:SetData(nFloorId)
  self.nFloorId = nFloorId
  local floorConfig = ConfigTable.GetData("TowerDefenseFloor", nFloorId)
  if floorConfig == nil then
    return
  end
  if floorConfig.MiniMapName ~= "" then
    self:SetPngSprite(self._mapNode.Img_map, "UI/Play_TowerDefence/SpriteAtlas/MiniMap/" .. floorConfig.MiniMapName)
  end
end

function TowerDefenseMiniMapCtrl:Close()
  self.gameObject:SetActive(false)
end

function TowerDefenseMiniMapCtrl:OnBtnClick_Close()
  self._mapNode.AnimatorRoot:Play("TowerdefenseMiniMapPanel_out")
  self:AddTimer(1, 0.2, function()
    self:Close()
  end, true, true, true)
end

return TowerDefenseMiniMapCtrl
