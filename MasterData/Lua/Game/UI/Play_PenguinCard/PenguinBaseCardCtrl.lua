local PenguinBaseCardCtrl = class("PenguinBaseCardCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
PenguinBaseCardCtrl._mapNodeConfig = {
  imgBg = {},
  imgIcon = {sComponentName = "Image"}
}
PenguinBaseCardCtrl._mapEventConfig = {}

function PenguinBaseCardCtrl:Refresh(nId, bOpen)
  self:RefreshIcon(bOpen)
  local mapCfg = ConfigTable.GetData("PenguinBaseCard", nId)
  if not mapCfg then
    return
  end
  self:SetSprite(self._mapNode.imgIcon, "UI/Play_PenguinCard/SpriteAtlas/Sprite/" .. mapCfg.Icon)
  self.tbSuit = {}
  for i = 1, 3 do
    if mapCfg["Suit" .. i] > 0 and 0 < mapCfg["SuitCount" .. i] then
      table.insert(self.tbSuit, mapCfg["Suit" .. i])
    end
  end
end

function PenguinBaseCardCtrl:RefreshIcon(bOpen)
  self._mapNode.imgBg:SetActive(not bOpen)
  self._mapNode.imgIcon.gameObject:SetActive(bOpen)
end

function PenguinBaseCardCtrl:PlayInAni()
  self.animator:Play("PengUinCard_Base")
end

function PenguinBaseCardCtrl:PlayFlipAni()
  if self._mapNode.imgBg.activeSelf == false then
    return
  end
  self._mapNode.imgIcon.gameObject:SetActive(true)
  self.animator:Play("PengUinCard_Base_Turn", 0, 0)
  WwiseManger:PostEvent("Mode_Card_trunover")
  self.animator.speed = self._panel.mapLevel.nSpeed
  local nAnimTime = NovaAPI.GetAnimClipLength(self.animator, {
    "PengUinCard_Base_Turn"
  })
  nAnimTime = nAnimTime / self._panel.mapLevel.nSpeed
  self:AddTimer(1, nAnimTime, function()
    self._mapNode.imgBg:SetActive(false)
  end, true, true, true)
end

function PenguinBaseCardCtrl:PlayFlipBackAni()
  if self._mapNode.imgIcon.gameObject.activeSelf == false then
    return
  end
  self._mapNode.imgBg.gameObject:SetActive(true)
  self.animator:Play("PengUinCard_Base_TurnBack", 0, 0)
  WwiseManger:PostEvent("Mode_Card_trunover")
  self.animator.speed = self._panel.mapLevel.nSpeed
  local nAnimTime = NovaAPI.GetAnimClipLength(self.animator, {
    "PengUinCard_Base_Turn"
  })
  nAnimTime = nAnimTime / self._panel.mapLevel.nSpeed
  self:AddTimer(1, nAnimTime, function()
    self._mapNode.imgIcon.gameObject:SetActive(false)
  end, true, true, true)
end

function PenguinBaseCardCtrl:PlayReplaceAni(bStone)
  if bStone then
    self.animator:Play("PengUinCard_Base_Stone", 0, 0)
    WwiseManger:PostEvent("Mode_Card_stone")
  else
    self.animator:Play("PengUinCard_Base_Double", 0, 0)
    WwiseManger:PostEvent("Mode_Card_cast")
  end
  self.animator.speed = self._panel.mapLevel.nSpeed
end

function PenguinBaseCardCtrl:PlayTriggerAni(pos)
  local bTrigger = false
  if not self.tbSuit or #self.tbSuit == 0 then
    return
  end
  for _, nSuit in ipairs(self.tbSuit) do
    if 0 < table.indexof(self._panel.mapLevel.tbHandRank, nSuit) then
      bTrigger = true
    end
  end
  if not bTrigger then
    return
  end
  self.animator:Play("PengUinCard_Base_Open", 0, 0)
  WwiseManger:PostEvent("Mode_Card_cast")
  self.animator.speed = self._panel.mapLevel.nSpeed
end

function PenguinBaseCardCtrl:PlayHideAni()
  self.animator:Play("PengUinCard_Base_Out", 0, 0)
  self.animator.speed = self._panel.mapLevel.nSpeed
end

function PenguinBaseCardCtrl:Awake()
  self.animator = self.gameObject:GetComponent("Animator")
end

function PenguinBaseCardCtrl:OnEnable()
end

function PenguinBaseCardCtrl:OnDisable()
end

return PenguinBaseCardCtrl
