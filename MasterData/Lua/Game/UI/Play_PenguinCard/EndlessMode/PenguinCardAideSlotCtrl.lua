local PenguinCardAideSlotCtrl = class("PenguinCardAideSlotCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
PenguinCardAideSlotCtrl._mapNodeConfig = {
  AideItem = {
    nCount = 3,
    sNodeName = "PenguinCardAideSlot",
    sCtrlName = "Game.UI.Play_PenguinCard.EndlessMode.PenguinCardAideSlotItemCtrl"
  }
}
PenguinCardAideSlotCtrl._mapEventConfig = {
  PenguinCard_AddAide = "OnEvent_AddAide",
  PenguinCard_SelectAide = "OnEvent_SelectAide",
  PenguinCard_SaleAide = "OnEvent_SaleAide",
  PenguinCard_UpgradeAide = "OnEvent_UpgradeAide"
}

function PenguinCardAideSlotCtrl:Refresh()
  for i = 1, 3 do
    self._mapNode.AideItem[i]:Refresh(i)
  end
end

function PenguinCardAideSlotCtrl:PlayOutAni()
  for i = 1, 3 do
    self._mapNode.AideItem[i]:PlaySlotHideAni()
  end
end

function PenguinCardAideSlotCtrl:Awake()
end

function PenguinCardAideSlotCtrl:OnEnable()
end

function PenguinCardAideSlotCtrl:OnDisable()
end

function PenguinCardAideSlotCtrl:OnEvent_AddAide()
  local nSlot = self._panel.mapLevel.nAideLimit
  self._mapNode.AideItem[nSlot]:PlayUnlockAni()
end

function PenguinCardAideSlotCtrl:OnEvent_SelectAide(nSlot)
  self._mapNode.AideItem[nSlot]:Refresh(nSlot)
  self._mapNode.AideItem[nSlot]:PlaySelectAni()
end

function PenguinCardAideSlotCtrl:OnEvent_SaleAide(nSlot)
  local function callback()
    self._mapNode.AideItem[nSlot]:Refresh(nSlot)
  end
  
  self._mapNode.AideItem[nSlot]:PlaySaleAni(callback)
end

function PenguinCardAideSlotCtrl:OnEvent_UpgradeAide(nSlot, bUpgrade)
  if bUpgrade then
    local function callback()
      self._mapNode.AideItem[nSlot]:Refresh(nSlot)
    end
    
    self._mapNode.AideItem[nSlot]:PlayUpgradeAni(callback)
  else
    self._mapNode.AideItem[nSlot]:PlayGiftAni()
  end
end

return PenguinCardAideSlotCtrl
