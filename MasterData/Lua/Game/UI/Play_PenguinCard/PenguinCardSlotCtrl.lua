local PenguinCardSlotCtrl = class("PenguinCardSlotCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
PenguinCardSlotCtrl._mapNodeConfig = {
  PenguinCardItem = {
    nCount = 6,
    sCtrlName = "Game.UI.Play_PenguinCard.PenguinCardItemCtrl"
  },
  goEmptySlot = {nCount = 6, sComponentName = "Transform"},
  aniSlot = {
    nCount = 6,
    sNodeName = "goEmptySlot",
    sComponentName = "Animator"
  }
}
PenguinCardSlotCtrl._mapEventConfig = {
  PenguinCard_AddSlot = "OnEvent_AddSlot",
  PenguinCard_SelectPenguinCard = "OnEvent_SelectPenguinCard",
  PenguinCard_SalePenguinCard = "OnEvent_SalePenguinCard",
  PenguinCard_ChangeCardLevel = "OnEvent_ChangeCardLevel",
  PenguinCard_AddInitialCard = "OnEvent_SelectPenguinCard"
}

function PenguinCardSlotCtrl:Refresh()
  for i = 1, 6 do
    self:RefreshSlot(i)
  end
end

function PenguinCardSlotCtrl:RefreshSlot(nIndex)
  local mapCard = self._panel.mapLevel.tbPenguinCard[nIndex]
  self._mapNode.PenguinCardItem[nIndex].gameObject:SetActive(mapCard ~= 0)
  self._mapNode.goEmptySlot[nIndex].gameObject:SetActive(mapCard == 0)
  if mapCard == 0 then
    local imgSlotLock = self._mapNode.goEmptySlot[nIndex]:Find("imgSlotLock").gameObject
    imgSlotLock:SetActive(nIndex > self._panel.mapLevel.nSlotCount)
  else
    self._mapNode.PenguinCardItem[nIndex]:Refresh_Slot(mapCard)
  end
end

function PenguinCardSlotCtrl:PlaySlotAni()
  for i = 1, 6 do
    local mapCard = self._panel.mapLevel.tbPenguinCard[i]
    if mapCard ~= 0 then
      self._mapNode.PenguinCardItem[i]:PlaySlotAni()
    end
  end
end

function PenguinCardSlotCtrl:PlayOutAni()
  for i = 1, 6 do
    local mapCard = self._panel.mapLevel.tbPenguinCard[i]
    if mapCard == 0 then
      self._mapNode.aniSlot[i]:Play("PengUinCard_Slot_Unlock_out")
    else
      self._mapNode.PenguinCardItem[i]:PlaySaleAni()
    end
  end
end

function PenguinCardSlotCtrl:Awake()
end

function PenguinCardSlotCtrl:OnEnable()
end

function PenguinCardSlotCtrl:OnDisable()
end

function PenguinCardSlotCtrl:OnEvent_AddSlot()
  local nIndex = self._panel.mapLevel.nSlotCount
  self._mapNode.aniSlot[nIndex]:Play("PengUinCard_Slot_Unlock_in")
  WwiseManger:PostEvent("Mode_Card_unlock")
  local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.aniSlot[nIndex], {
    "PengUinCard_Slot_Unlock_in"
  })
  self:AddTimer(1, nAnimTime, function()
    local imgSlotLock = self._mapNode.goEmptySlot[nIndex]:Find("imgSlotLock").gameObject
    imgSlotLock:SetActive(false)
  end, true, true, true)
end

function PenguinCardSlotCtrl:OnEvent_SelectPenguinCard(nSlot, bUpgrade)
  self._mapNode.PenguinCardItem[nSlot].gameObject:SetActive(true)
  if bUpgrade then
    local function callback()
      self._mapNode.PenguinCardItem[nSlot]:Refresh_Slot(self._panel.mapLevel.tbPenguinCard[nSlot])
    end
    
    self._mapNode.PenguinCardItem[nSlot]:PlayUpgradeAni(callback)
  else
    self._mapNode.PenguinCardItem[nSlot]:Refresh_Slot(self._panel.mapLevel.tbPenguinCard[nSlot])
    
    local function callback()
      self._mapNode.goEmptySlot[nSlot].gameObject:SetActive(false)
    end
    
    self._mapNode.PenguinCardItem[nSlot]:PlaySelectAni(callback)
  end
end

function PenguinCardSlotCtrl:OnEvent_SalePenguinCard(nSlot)
  self._mapNode.goEmptySlot[nSlot].gameObject:SetActive(true)
  local imgSlotLock = self._mapNode.goEmptySlot[nSlot]:Find("imgSlotLock").gameObject
  imgSlotLock:SetActive(nSlot > self._panel.mapLevel.nSlotCount)
  
  local function callback()
    self._mapNode.PenguinCardItem[nSlot].gameObject:SetActive(false)
  end
  
  self._mapNode.PenguinCardItem[nSlot]:PlaySaleAni(callback)
end

function PenguinCardSlotCtrl:OnEvent_ChangeCardLevel(nSlot, nChange, mapCard)
  local function callback()
    self._mapNode.PenguinCardItem[nSlot]:Refresh_Slot(mapCard)
  end
  
  self._mapNode.PenguinCardItem[nSlot]:PlayLevelAni(0 < nChange, callback)
end

return PenguinCardSlotCtrl
