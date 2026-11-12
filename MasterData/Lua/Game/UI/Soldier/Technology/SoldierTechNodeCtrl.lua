local SoldierTechNodeCtrl = class("SoldierTechNodeCtrl", BaseCtrl)
local _, ActiveIconLineColor = ColorUtility.TryParseHtmlString("#93b1ba")
local _, ReadyIconLineColor = ColorUtility.TryParseHtmlString("#8ea9c0")
local _, LockIconLineColor = ColorUtility.TryParseHtmlString("#9199a4")
local _, ActiveIconSkillColor = ColorUtility.TryParseHtmlString("#4f5f7e")
local _, ReadyIconSkillColor = ColorUtility.TryParseHtmlString("#8ea9c0")
local _, LockIconSkillColor = ColorUtility.TryParseHtmlString("#9199a4")
SoldierTechNodeCtrl._mapNodeConfig = {
  goNodeSquare = {},
  rtLightSquare = {},
  imgLockSquare = {},
  imgNormalSquare = {},
  imgOnSquare = {},
  IconSkillSquare = {sComponentName = "Image"},
  IconBossMask = {},
  IconBoss = {sComponentName = "Image"},
  IconBossLock = {sComponentName = "Image"},
  IconLine = {sComponentName = "Image"},
  goNodeCircle = {},
  rtLightCircle = {},
  imgLockCircle = {},
  imgNormalCircle = {},
  imgOnCircle = {},
  IconSkillCircle = {sComponentName = "Image"},
  goSelect = {sNodeName = "Select"}
}
SoldierTechNodeCtrl._mapEventConfig = {}
SoldierTechNodeCtrl._mapRedDotConfig = {}

local function CheckResourceEnough(mapCfg)
  local nItemId = mapCfg.ItemId1
  local nItemQty = mapCfg.ItemQty1
  if nItemId and 0 < nItemId and nItemQty and 0 < nItemQty and nItemQty > PlayerData.Item:GetItemCountByID(nItemId) then
    return false
  end
  return true
end

function SoldierTechNodeCtrl:Refresh(nId, mapNodeData, bForceUnlocked)
  self.nId = nId
  self.mapNodeData = mapNodeData
  local mapCfg = ConfigTable.GetData("SoldierTechNode", nId)
  if not mapCfg then
    return
  end
  local nType = mapCfg.Type
  local bActive, bCanActive, bLock
  if bForceUnlocked then
    bActive = true
    bCanActive = false
    bLock = false
  else
    bActive = mapNodeData and mapNodeData.bActive
    local bReady = mapNodeData and mapNodeData.bReady
    bCanActive = not bActive and bReady and CheckResourceEnough(mapCfg)
    bLock = not bActive and not bCanActive
  end
  local bShowLight = bCanActive and not bForceUnlocked
  local bSquare = nType == GameEnum.SoldierTechNodeType.Core or nType == GameEnum.SoldierTechNodeType.BossAbility
  self._mapNode.goNodeSquare:SetActive(bSquare)
  self._mapNode.goNodeCircle:SetActive(not bSquare)
  if bSquare then
    self._mapNode.rtLightSquare:SetActive(bShowLight)
    self._mapNode.imgNormalSquare:SetActive(bCanActive)
    self._mapNode.imgLockSquare:SetActive(bLock)
    self._mapNode.imgOnSquare:SetActive(bActive)
    local lineColor = bActive and ActiveIconLineColor or bCanActive and ReadyIconLineColor or LockIconLineColor
    NovaAPI.SetImageColor(self._mapNode.IconLine, lineColor)
    if nType == GameEnum.SoldierTechNodeType.Core then
      self._mapNode.IconSkillSquare.gameObject:SetActive(true)
      self._mapNode.IconBossMask:SetActive(false)
      local iconColor = bActive and ActiveIconSkillColor or bCanActive and ReadyIconSkillColor or LockIconSkillColor
      NovaAPI.SetImageColor(self._mapNode.IconSkillSquare, iconColor)
      self:SetPngSprite(self._mapNode.IconSkillSquare, mapCfg.Icon)
    else
      self._mapNode.IconSkillSquare.gameObject:SetActive(false)
      self._mapNode.IconBossMask:SetActive(true)
      self._mapNode.IconBoss.gameObject:SetActive(bActive)
      self._mapNode.IconBossLock.gameObject:SetActive(not bActive)
      local nBossId = mapCfg.Param
      local mapBoss = ConfigTable.GetData("SoldierBossTemplate", nBossId)
      if mapBoss ~= nil then
        if bActive then
          self:SetPngSprite(self._mapNode.IconBoss, mapBoss.SoldierPlayerHead)
        else
          self:SetPngSprite(self._mapNode.IconBossLock, mapBoss.SoldierPlayerHead)
        end
      end
    end
  else
    self._mapNode.rtLightCircle:SetActive(bShowLight)
    self._mapNode.imgNormalCircle:SetActive(bCanActive)
    self._mapNode.imgLockCircle:SetActive(bLock)
    self._mapNode.imgOnCircle:SetActive(bActive)
    local iconColor = bActive and ActiveIconSkillColor or bCanActive and ReadyIconSkillColor or LockIconSkillColor
    NovaAPI.SetImageColor(self._mapNode.IconSkillCircle, iconColor)
    self:SetPngSprite(self._mapNode.IconSkillCircle, mapCfg.Icon)
  end
  self._mapNode.goSelect:SetActive(false)
end

function SoldierTechNodeCtrl:SetSelect(bSelect)
  self._mapNode.goSelect:SetActive(bSelect)
end

function SoldierTechNodeCtrl:Awake()
end

function SoldierTechNodeCtrl:OnEnable()
end

function SoldierTechNodeCtrl:OnDisable()
end

function SoldierTechNodeCtrl:OnDestroy()
end

return SoldierTechNodeCtrl
