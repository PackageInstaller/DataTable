local SoldierCharSupportCardItemCtrl = class("SoldierCharSupportCardItemCtrl", BaseCtrl)
local SoldierAttrData = require("GameCore.Data.DataClass.Soldier.SoldierAttrData")
SoldierCharSupportCardItemCtrl._mapNodeConfig = {
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
  imgPut = {},
  ImgPutLight = {},
  imageIcon = {sComponentName = "Image"},
  imageRarity = {sComponentName = "Image"},
  img_Position = {sComponentName = "Image"},
  imgPosition = {},
  animRoot = {sNodeName = "AnimRoot", sComponentName = "Animator"},
  HeadRoot = {sComponentName = "Animator"},
  img_icon = {sComponentName = "Image"},
  img_iconBg = {sComponentName = "Image"},
  img_iconBg_Add = {sComponentName = "Image"},
  Fx_warrior = {}
}
SoldierCharSupportCardItemCtrl._mapEventConfig = {
  SoldierCharSupportCardItemClicked = "OnEvent_SoldierCharSupportCardItemClicked",
  SoldierExtraPartnerTagChange = "OnEvent_SoldierExtraPartnerTagChange"
}
SoldierCharSupportCardItemCtrl._mapRedDotConfig = {}
SoldierCharSupportCardItemCtrl.MAX_STAR = 5

function SoldierCharSupportCardItemCtrl:Awake()
end

function SoldierCharSupportCardItemCtrl:OnEnable()
end

function SoldierCharSupportCardItemCtrl:OnDisable()
  self:_StopPartnerActiveAnim()
end

function SoldierCharSupportCardItemCtrl:OnDestroy()
  self:_StopPartnerActiveAnim()
end

function SoldierCharSupportCardItemCtrl:OnSelected()
end

function SoldierCharSupportCardItemCtrl:OnRefresh(nCharId)
  if self.nCharId ~= nCharId then
    self:_StopPartnerActiveAnim()
  end
  self.nCharId = nCharId
  self:SetItemData(nCharId)
end

function SoldierCharSupportCardItemCtrl:SetItemData(nCharId, nUid)
  if self.nCharId ~= nCharId then
    self:_StopPartnerActiveAnim()
  end
  self._mapNode.imgPut:SetActive(false)
  self._mapNode.ImgPutLight:SetActive(false)
  self._mapNode.imgSelect:SetActive(false)
  if nCharId == nil then
    self.nCharId = nil
    self.nUid = nil
    self._mapNode.goChar:SetActive(false)
    self._mapNode.imgEmpty:SetActive(true)
    return
  end
  self.nCharId = nCharId
  self.nUid = nUid
  self._mapNode.imgEmpty:SetActive(false)
  self._mapNode.goChar:SetActive(true)
  local soldierCharConfig = ConfigTable.GetData("SoldierCharacter", nCharId)
  if soldierCharConfig == nil then
    return
  end
  self:SetRarity(soldierCharConfig.Rarity)
  self:SetStar(soldierCharConfig.Star, nCharId)
  local skinConfig = ConfigTable.GetData("SoldierSkin", soldierCharConfig.Skin)
  if skinConfig then
    self:SetPngSprite(self._mapNode.imageIcon, skinConfig.Icon .. AllEnum.SoldierChessIconSurfix.M)
  end
  self._mapNode.Fx_warrior.gameObject:SetActive(false)
  local curLevelData = PlayerData.SoldierData:GetCurLevelData()
  if curLevelData ~= nil and self.nUid ~= nil then
    local bWarrior = curLevelData:GetExtraPartnerTags(self.nUid)
    if bWarrior ~= nil then
      self._mapNode.Fx_warrior.gameObject:SetActive(true)
    end
  end
end

function SoldierCharSupportCardItemCtrl:SetRarity(nRarity)
  if nRarity == nil then
    return
  end
  self:SetPngSprite(self._mapNode.imageRarity, "Icon/SoldierOtherIcon/" .. AllEnum.SoldierChessRarityIcon[nRarity] .. AllEnum.SoldierChessIconSurfix.M)
end

function SoldierCharSupportCardItemCtrl:SetChessPosition(nDeployedPos)
  self._mapNode.imgPosition.gameObject:SetActive(false)
  if self.nCharId == nil then
    return
  end
  local mapChar = ConfigTable.GetData("SoldierCharacter", self.nCharId)
  if mapChar == nil then
    return
  end
  local nType = mapChar.Type or GameEnum.ChessType.Balance
  local tbChessTypeConfig = CacheTable.GetData("_SoldierChessType", nType)
  local sIcon = ""
  if tbChessTypeConfig ~= nil then
    sIcon = tbChessTypeConfig.Icon
  end
  self._mapNode.imgPosition.gameObject:SetActive(true)
  if nType ~= GameEnum.ChessType.Balance and nType ~= nDeployedPos then
    sIcon = sIcon .. "_00"
  end
  local sPath = "Icon/SoldierOtherIcon/" .. sIcon
  self:SetPngSprite(self._mapNode.img_Position, sPath)
end

function SoldierCharSupportCardItemCtrl:SetStar(nStar, nCharId)
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

function SoldierCharSupportCardItemCtrl:SetSelect(bSelect)
  self._mapNode.ImageSelect.gameObject:SetActive(bSelect)
end

function SoldierCharSupportCardItemCtrl:SetLock(bLock)
  self._mapNode.imgLock.gameObject:SetActive(bLock)
end

function SoldierCharSupportCardItemCtrl:_CancelPartnerActiveTimer()
  if self.timerCloseParterNode ~= nil then
    self.timerCloseParterNode:Cancel()
    self.timerCloseParterNode = nil
  end
end

function SoldierCharSupportCardItemCtrl:_StopPartnerActiveAnim()
  self:_CancelPartnerActiveTimer()
  self.tbPartnerActiveAnimQueue = nil
  self.mapPartnerActiveAnimPending = nil
  self.bPlayingPartnerActiveAnim = false
  if self._mapNode ~= nil and self._mapNode.HeadRoot ~= nil then
    self._mapNode.HeadRoot.gameObject:SetActive(false)
  end
end

function SoldierCharSupportCardItemCtrl:_GetPartnerActiveAnimKey(nPartnerType, nPartnerId)
  return tostring(nPartnerType or 0) .. "_" .. tostring(nPartnerId or 0)
end

function SoldierCharSupportCardItemCtrl:_TryInsertPartnerActiveAnim(tbQueue, nPartnerType, nPartnerId, nOrder)
  if nPartnerType == nil then
    return
  end
  local mapGroup = CacheTable.GetData("_SoldierPartnerGroup", nPartnerType)
  if mapGroup == nil then
    return
  end
  table.insert(tbQueue, {
    nType = nPartnerType,
    nId = nPartnerId,
    nOrder = nOrder
  })
end

function SoldierCharSupportCardItemCtrl:_GetMyActivePartnerQueue(tbActivePartner)
  if self.nCharId == nil or self.nCharId == 0 then
    return
  end
  local tbPartnerTypes = SoldierAttrData.GetPartnerGroupsByChessId(self.nCharId)
  if tbPartnerTypes == nil or #tbPartnerTypes == 0 then
    return nil
  end
  local tbQueue = {}
  for nOrder, nPartnerType in ipairs(tbPartnerTypes) do
    local mapActivePartner = tbActivePartner ~= nil and tbActivePartner[nPartnerType] or nil
    if mapActivePartner ~= nil then
      local nPartnerId = type(mapActivePartner) == "table" and mapActivePartner.nId or mapActivePartner
      self:_TryInsertPartnerActiveAnim(tbQueue, nPartnerType, nPartnerId, nOrder)
    end
  end
  if #tbQueue == 0 then
    return nil
  end
  table.sort(tbQueue, function(a, b)
    if a.nOrder == b.nOrder then
      return a.nType < b.nType
    end
    return a.nOrder < b.nOrder
  end)
  return tbQueue
end

function SoldierCharSupportCardItemCtrl:_TryAppendPartnerActiveAnimQueue(mapItem)
  if mapItem == nil then
    return
  end
  local sKey = self:_GetPartnerActiveAnimKey(mapItem.nType, mapItem.nId)
  self.mapPartnerActiveAnimPending = self.mapPartnerActiveAnimPending or {}
  if self.mapPartnerActiveAnimPending[sKey] == true then
    return
  end
  self.mapPartnerActiveAnimPending[sKey] = true
  self.tbPartnerActiveAnimQueue = self.tbPartnerActiveAnimQueue or {}
  table.insert(self.tbPartnerActiveAnimQueue, mapItem)
end

function SoldierCharSupportCardItemCtrl:_FinishPartnerActiveAnimItem(mapItem)
  if mapItem == nil or self.mapPartnerActiveAnimPending == nil then
    return
  end
  local sKey = self:_GetPartnerActiveAnimKey(mapItem.nType, mapItem.nId)
  self.mapPartnerActiveAnimPending[sKey] = nil
end

function SoldierCharSupportCardItemCtrl:_PlayNextPartnerActiveAnim()
  self:_CancelPartnerActiveTimer()
  if self.tbPartnerActiveAnimQueue == nil or #self.tbPartnerActiveAnimQueue == 0 then
    self.bPlayingPartnerActiveAnim = false
    self._mapNode.HeadRoot.gameObject:SetActive(false)
    return
  end
  local mapItem = table.remove(self.tbPartnerActiveAnimQueue, 1)
  local mapGroup = CacheTable.GetData("_SoldierPartnerGroup", mapItem.nType)
  local mapPartner = ConfigTable.GetData("SoldierPartner", mapItem.nId)
  if mapGroup ~= nil and mapPartner ~= nil then
    self.bPlayingPartnerActiveAnim = true
    self:SetPngSprite(self._mapNode.img_icon, "Icon/SoldierPartner/" .. mapGroup.Icon .. AllEnum.SoldierChessIconSurfix.M)
    self:SetPngSprite(self._mapNode.img_iconBg, "Icon/SoldierOtherIcon/PartnerLevelQuality_0" .. mapPartner.PartnerLevelQuality)
    self:SetPngSprite(self._mapNode.img_iconBg_Add, "Icon/SoldierOtherIcon/PartnerLevelQuality_0" .. mapPartner.PartnerLevelQuality)
    self._mapNode.HeadRoot.gameObject:SetActive(true)
    self._mapNode.HeadRoot:Play("HeadActive", 0, 0)
    local nAnimLength = NovaAPI.GetAnimClipLength(self._mapNode.HeadRoot, {"HeadActive"})
    if type(nAnimLength) ~= "number" or nAnimLength <= 0 then
      nAnimLength = 1
    end
    self.timerCloseParterNode = self:AddTimer(1, nAnimLength, function()
      self._mapNode.HeadRoot.gameObject:SetActive(false)
      self:_FinishPartnerActiveAnimItem(mapItem)
      self:_PlayNextPartnerActiveAnim()
    end, true, true)
  else
    self:_FinishPartnerActiveAnimItem(mapItem)
    self:_PlayNextPartnerActiveAnim()
  end
end

function SoldierCharSupportCardItemCtrl:OnEvent_SoldierPartnerNewActive(tbActivePartner)
  local tbQueue = self:_GetMyActivePartnerQueue(tbActivePartner)
  if tbQueue == nil then
    return
  end
  for _, mapItem in ipairs(tbQueue) do
    self:_TryAppendPartnerActiveAnimQueue(mapItem)
  end
  if self.bPlayingPartnerActiveAnim ~= true then
    self:_PlayNextPartnerActiveAnim()
  end
end

function SoldierCharSupportCardItemCtrl:OnEvent_SoldierExtraPartnerTagChange()
  if self.nUid == nil then
    self._mapNode.Fx_warrior.gameObject:SetActive(false)
    return
  end
  local bWarrior = PlayerData.SoldierData:GetCurLevelData():GetExtraPartnerTags(self.nUid)
  if bWarrior ~= nil then
    self._mapNode.Fx_warrior.gameObject:SetActive(true)
  else
    self._mapNode.Fx_warrior.gameObject:SetActive(false)
  end
end

function SoldierCharSupportCardItemCtrl:GetAnimator()
  if self._mapNode.animRoot == nil then
    self._mapNode.animRoot = self.gameObejct.transform:GetChild(0):GetChild(0):GetComponent("Animator")
    if self._mapNode.animRoot == nil then
      return nil
    end
  end
  return self._mapNode.animRoot
end

function SoldierCharSupportCardItemCtrl:OnBtnItemClick()
  if self._fnClickCallback ~= nil and self.nCharId ~= nil then
    self._fnClickCallback(self._objClickCallback, self.nCharId)
  end
end

function SoldierCharSupportCardItemCtrl:SetClickCallback(obj, fn)
  self._objClickCallback = obj
  self._fnClickCallback = fn
end

function SoldierCharSupportCardItemCtrl:OnEvent_SoldierCharSupportCardItemClicked(nCharId)
  if nCharId == nil then
    self:SetSelect(false)
    return
  end
  if self._fnClickCallback ~= nil and self.nCharId ~= nil then
    self:SetSelect(nCharId == self.nCharId)
    self._fnClickCallback(self._objClickCallback, self.nCharId)
  end
end

return SoldierCharSupportCardItemCtrl
