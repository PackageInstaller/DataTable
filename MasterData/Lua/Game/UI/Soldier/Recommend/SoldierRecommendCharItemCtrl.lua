local SoldierCharCardItemCtrl = require("Game.UI.Soldier.Template.Character.SoldierCharCardItemCtrl")
local SoldierRecommendCharItemCtrl = class("SoldierRecommendCharItemCtrl", SoldierCharCardItemCtrl)
SoldierRecommendCharItemCtrl._mapEventConfig = {}

function SoldierRecommendCharItemCtrl:Awake()
  SoldierCharCardItemCtrl.Awake(self)
  self._mapSpritePath = {}
  self._mapNode.animRoot.enabled = false
end

function SoldierRecommendCharItemCtrl:OnEnable()
  SoldierCharCardItemCtrl.OnEnable(self)
  self:SetAttribute(self._nRecommendPosition)
end

function SoldierRecommendCharItemCtrl:OnDisable()
  self.bActive = false
end

function SoldierRecommendCharItemCtrl:OnDestroy()
  SoldierCharCardItemCtrl.OnDestroy(self)
  self._mapSpritePath = nil
end

function SoldierRecommendCharItemCtrl:SetRecommendData(mapCharData, nPosition)
  self._nRecommendPosition = nPosition
  if mapCharData == nil or mapCharData.nId == nil or mapCharData.nId == 0 then
    self._nRecommendPosition = nil
    SoldierCharCardItemCtrl.SetItemData(self, nil)
    self.nCharId = nil
    self.bInSandland = false
    self._nRecommendStar = 0
    self:SetStar(0)
    self:SetAttribute(nil)
    self._mapNode.imgRecommend.gameObject:SetActive(false)
    self:SetLock(false)
    self:SetClickCallback(nil, nil)
    return
  end
  self._nRecommendStar = mapCharData.nStar or 0
  if self.nCharId ~= mapCharData.nId then
    SoldierCharCardItemCtrl.SetItemData(self, mapCharData.nId)
  else
    self:SetStar(self._nRecommendStar)
  end
  self:SetAttribute(nPosition)
end

function SoldierRecommendCharItemCtrl:SetStar(nStar)
  nStar = self._nRecommendStar or nStar or 0
  if self.nStar == nStar then
    return
  end
  self.nStar = nStar
  for nIndex = 1, self.MAX_STAR do
    local bActive = nIndex <= nStar
    local goStar = self._mapNode.Star[nIndex]
    local goFxStar = self._mapNode.FxStar[nIndex]
    if goStar ~= nil and goStar.activeSelf ~= bActive then
      goStar:SetActive(bActive)
    end
    if goFxStar ~= nil and goFxStar.activeSelf ~= bActive then
      goFxStar:SetActive(bActive)
    end
  end
end

function SoldierRecommendCharItemCtrl:SetAttribute(nPosition)
  local bUnlock = false
  local sIcon
  if nPosition ~= nil and 1 <= nPosition and nPosition <= 3 then
    local nConfigId = PlayerData.SoldierData:GetSoldierPositionEffectDataId(nPosition)
    local mapConfig = ConfigTable.GetData("SoldierPositionEffect", nConfigId)
    if mapConfig ~= nil then
      bUnlock = mapConfig.TechNodeId <= 0 or PlayerData.SoldierData:CheckTechNodeActiveById(mapConfig.TechNodeId)
      sIcon = "Icon/SoldierOtherIcon/" .. mapConfig.Icon
    end
  end
  local imgAttribute = self._mapNode.imgAttribute
  if imgAttribute.gameObject.activeSelf ~= bUnlock then
    imgAttribute.gameObject:SetActive(bUnlock)
  end
  if bUnlock then
    self:SetPngSprite(imgAttribute, sIcon)
  end
end

function SoldierRecommendCharItemCtrl:SetPngSprite(imgObj, sPath, sSurfix)
  if sSurfix ~= nil then
    return BaseCtrl.SetPngSprite(self, imgObj, sPath, sSurfix)
  end
  if sPath ~= nil and self._mapSpritePath[imgObj] == sPath then
    return true
  end
  local bSuccess = BaseCtrl.SetPngSprite(self, imgObj, sPath)
  if bSuccess then
    self._mapSpritePath[imgObj] = sPath
  end
  return bSuccess
end

return SoldierRecommendCharItemCtrl
