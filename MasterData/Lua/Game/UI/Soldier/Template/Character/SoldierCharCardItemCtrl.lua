local SoldierCharCardItemCtrl = class("SoldierCharCardItemCtrl", BaseCtrl)
local iconPath2 = "Icon/SoldierOtherIcon/"
SoldierCharCardItemCtrl._mapNodeConfig = {
  btnItem = {
    sComponentName = "UIButton",
    callback = "OnBtnItemClick"
  },
  Star = {nCount = 5},
  FxStar = {nCount = 5},
  StarRoot = {sComponentName = "Transform"},
  goChar = {},
  imgEmpty = {},
  imgSelect = {},
  imgLock = {},
  imgPut = {},
  imageIcon = {sComponentName = "Image"},
  imageRarity = {sComponentName = "Image"},
  imgRecommend = {sComponentName = "Image"},
  img_Position = {sComponentName = "Image"},
  imgAttribute = {sComponentName = "Image"},
  animRoot = {sNodeName = "AnimRoot", sComponentName = "Animator"}
}
SoldierCharCardItemCtrl._mapEventConfig = {
  SoldierCharCardItemClicked = "OnEvent_SoldierCharCardItemClicked",
  SoldierRecommend_Update = "SetTrackAndRecommend",
  SoldierPartnerTrace = "SetTrackAndRecommend",
  SoldierExtraPartnerTagChange = "OnEvent_SoldierExtraPartnerTagChange"
}
SoldierCharCardItemCtrl._mapRedDotConfig = {}
SoldierCharCardItemCtrl.MAX_STAR = 5

function SoldierCharCardItemCtrl:Awake()
  self.bActive = false
end

function SoldierCharCardItemCtrl:OnEnable()
  self.bActive = true
end

function SoldierCharCardItemCtrl:OnDisable()
  self._objClickCallback = nil
  self._fnClickCallback = nil
  self.nCharId = nil
  self.bActive = false
end

function SoldierCharCardItemCtrl:OnDestroy()
  self.bActive = false
end

function SoldierCharCardItemCtrl:OnSelected()
end

function SoldierCharCardItemCtrl:OnRefresh(nCharId)
  self.nCharId = nCharId
  self:SetItemData(nCharId)
end

function SoldierCharCardItemCtrl:SetItemData(nCharId, bInSandland)
  bInSandland = bInSandland or false
  self._mapNode.imgSelect:SetActive(false)
  self._mapNode.imgPut:SetActive(false)
  if nCharId == nil then
    self._mapNode.goChar:SetActive(false)
    self._mapNode.imgEmpty:SetActive(true)
    return
  end
  self.nCharId = nCharId
  self._mapNode.imgEmpty:SetActive(false)
  self._mapNode.goChar:SetActive(true)
  local soldierCharConfig = ConfigTable.GetData("SoldierCharacter", nCharId)
  if soldierCharConfig == nil then
    return
  end
  self:SetRarity(soldierCharConfig.Rarity)
  self:SetStar(soldierCharConfig.Star, nCharId)
  self:SetChessPosition(soldierCharConfig.Type)
  self.bInSandland = bInSandland
  self:SetTrackAndRecommend()
  local skinConfig = ConfigTable.GetData("SoldierSkin", soldierCharConfig.Skin)
  if skinConfig then
    self:SetPngSprite(self._mapNode.imageIcon, skinConfig.Icon .. AllEnum.SoldierChessIconSurfix.M)
  end
end

function SoldierCharCardItemCtrl:SetRarity(nRarity)
  if nRarity == nil then
    return
  end
  self:SetPngSprite(self._mapNode.imageRarity, "Icon/SoldierOtherIcon/" .. AllEnum.SoldierChessRarityIcon[nRarity] .. AllEnum.SoldierChessIconSurfix.M)
end

function SoldierCharCardItemCtrl:SetAttribute(nIndex)
  if nIndex == nil or nIndex < 1 or 3 < nIndex then
    self._mapNode.imgAttribute.gameObject:SetActive(false)
    return
  end
  local nCfgId = PlayerData.SoldierData:GetSoldierPositionEffectDataId(nIndex)
  local cfg = ConfigTable.GetData("SoldierPositionEffect", nCfgId)
  if cfg then
    local bUnlock = true
    if cfg.TechNodeId > 0 then
      bUnlock = PlayerData.SoldierData:CheckTechNodeActiveById(cfg.TechNodeId)
    end
    self._mapNode.imgAttribute.gameObject:SetActive(bUnlock)
    self:SetPngSprite(self._mapNode.imgAttribute, iconPath2 .. cfg.Icon)
  end
end

function SoldierCharCardItemCtrl:SetStar(nStar, nCharId)
  nStar = nStar or 0
  local bPlayCompoundAnim = false
  if self.nStar == nil then
    self.nStar = nStar
  elseif nStar > self.nStar and self.nCharId == nCharId then
    self.nStar = nStar
    bPlayCompoundAnim = true
  end
  for i = 1, self.MAX_STAR do
    local goFxStar = self._mapNode.FxStar[i]
    if goFxStar then
      goFxStar:SetActive(i <= nStar)
    end
  end
  if bPlayCompoundAnim == true then
    CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_chair_combine")
    local nAnimLength = NovaAPI.GetAnimClipLength(self._mapNode.animRoot, {
      "SoldierSupportCard_compound"
    })
    self:AddTimer(1, nAnimLength, function()
      for i = 1, self.MAX_STAR do
        local goStar = self._mapNode.Star[i]
        if goStar then
          goStar:SetActive(i <= nStar)
        end
      end
    end)
  else
    for i = 1, self.MAX_STAR do
      local goStar = self._mapNode.Star[i]
      if goStar then
        goStar:SetActive(nStar >= i)
      end
    end
  end
end

function SoldierCharCardItemCtrl:SetTrackAndRecommend()
  if self.bActive == false then
    return
  end
  if self.bInSandland == nil or self.bInSandland == false then
    self._mapNode.imgRecommend.gameObject:SetActive(false)
    return
  end
  if self.nCharId == nil then
    return
  end
  self._mapNode.imgRecommend.gameObject:SetActive(true)
  local levelData = PlayerData.SoldierData:GetCurLevelData()
  if levelData == nil then
    self._mapNode.imgRecommend.gameObject:SetActive(false)
    return
  end
  local bTrack = levelData:CheckChessTrace(self.nCharId)
  local bRecommend = PlayerData.SoldierData:CheckChessRecommendState(self.nCharId)
  local sIcon = ""
  if bRecommend and bTrack then
    sIcon = "Icon/SoldierOtherIcon/SoldierPartnerBuilds_03"
  elseif bTrack then
    sIcon = "Icon/SoldierOtherIcon/SoldierPartnerBuilds_02"
  elseif bRecommend then
    sIcon = "Icon/SoldierOtherIcon/SoldierPartnerBuilds_01"
  else
    self._mapNode.imgRecommend.gameObject:SetActive(false)
  end
  if sIcon ~= "" then
    self:SetPngSprite(self._mapNode.imgRecommend, sIcon)
  end
end

function SoldierCharCardItemCtrl:SetChessPosition(nType)
  if nType == nil then
    return
  end
  local tbChessTypeConfig = CacheTable.GetData("_SoldierChessType", nType)
  local sIcon = ""
  if tbChessTypeConfig ~= nil then
    sIcon = tbChessTypeConfig.Icon
  end
  local sPath = "Icon/SoldierOtherIcon/" .. sIcon
  self:SetPngSprite(self._mapNode.img_Position, sPath)
end

function SoldierCharCardItemCtrl:SetSelect(bSelect)
  self._mapNode.ImageSelect.gameObject:SetActive(bSelect)
end

function SoldierCharCardItemCtrl:SetLock(bLock)
  self._mapNode.imgLock.gameObject:SetActive(bLock)
end

function SoldierCharCardItemCtrl:SetClickCallback(obj, fn)
  self._objClickCallback = obj
  self._fnClickCallback = fn
end

function SoldierCharCardItemCtrl:GetAnimator()
  if self._mapNode.animRoot == nil then
    self._mapNode.animRoot = self.gameObejct.transform:GetChild(0):GetChild(0):GetComponent("Animator")
    if self._mapNode.animRoot == nil then
      return nil
    end
  end
  return self._mapNode.animRoot
end

function SoldierCharCardItemCtrl:OnBtnItemClick()
  if self._fnClickCallback ~= nil and self.nCharId ~= nil then
    self._fnClickCallback(self._objClickCallback, self.nCharId)
  end
end

function SoldierCharCardItemCtrl:OnEvent_SoldierCharCardItemClicked(nCharId)
  if nCharId == nil then
    self:SetSelect(false)
    return
  end
  self:SetSelect(nCharId == self.nCharId)
end

return SoldierCharCardItemCtrl
