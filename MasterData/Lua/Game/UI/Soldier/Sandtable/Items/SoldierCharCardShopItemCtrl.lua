local SoldierAttrData = require("GameCore.Data.DataClass.Soldier.SoldierAttrData")
local SoldierCharCardShopItemCtrl = class("SoldierCharCardShopItemCtrl", BaseCtrl)
local SYNERGY_TEMPLATE_PATH = "Game.UI.Soldier.Sandtable.Items.SoldierCharCardShopPartnerItemCtrl"

local function _DestroyNode(node)
  if node == nil then
    return
  end
  if node.IsNull ~= nil and node:IsNull() == true then
    return
  end
  destroy(node.gameObject or node)
end

SoldierCharCardShopItemCtrl._mapNodeConfig = {
  imgUpgradeStar = {nCount = 5},
  imgUpgrade = {},
  btnItem = {
    sComponentName = "UIButton",
    callback = "OnBtnItemClick"
  },
  imgSelect = {},
  imageRarity = {sComponentName = "Image"},
  imgEmpty = {},
  Container = {},
  txtShopName = {sComponentName = "TMP_Text"},
  txtCharName = {sComponentName = "TMP_Text"},
  ImageIcon = {sComponentName = "Image"},
  imgPosition = {},
  img_Position = {sComponentName = "Image"},
  imgRecommend = {sComponentName = "Image"},
  imgUnavailable = {},
  imgInHand = {},
  txtCost = {sComponentName = "TMP_Text"},
  goSynergyRoot = {
    sComponentName = "RectTransform"
  },
  SynergyTemplate = {},
  animRoot = {sNodeName = "AnimRoot", sComponentName = "Animator"},
  FxCard_Random = {sComponentName = "Animator"},
  imgTrial = {},
  txtTrial = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Shop_Card_Trial"
  }
}
SoldierCharCardShopItemCtrl._mapEventConfig = {
  SoldierCharCardShopItemClicked = "OnEvent_SoldierCharCardShopItemClicked",
  SoldierRecommend_Update = "SetTrackAndRecommend",
  SoldierPartnerTrace = "SetTrackAndRecommend",
  SoldierShopRefresh = "OnShopRefresh"
}
SoldierCharCardShopItemCtrl._mapRedDotConfig = {}

function SoldierCharCardShopItemCtrl:Awake()
  self.nSlotIndex = 0
  self.fnClickHost = nil
  self.fnClickFunc = nil
  self._tbSynergyItemCtrl = {}
  self._tbSynergyItemGo = {}
  self._mapNode.FxCard_Random.gameObject:SetActive(false)
end

function SoldierCharCardShopItemCtrl:OnEnable()
end

function SoldierCharCardShopItemCtrl:OnDisable()
  self:SetEmpty()
end

function SoldierCharCardShopItemCtrl:OnDestroy()
  self._objClickCallback = nil
  self._fnClickCallback = nil
end

function SoldierCharCardShopItemCtrl:SetSlotIndex(nIndex)
  self.nSlotIndex = nIndex
end

function SoldierCharCardShopItemCtrl:SetClickCallback(host, func)
  self._objClickCallback = host
  self._fnClickCallback = func
end

function SoldierCharCardShopItemCtrl:SetData(nCharId, nCost, nStar, bDisablePurchase)
  self.nCharId = nCharId
  if nCharId == nil or nCharId <= 0 then
    self:SetEmpty()
    return
  end
  local mapChar = ConfigTable.GetData("SoldierCharacter", nCharId)
  if mapChar == nil then
    self:SetEmpty()
    return
  end
  self:SetNodeActive(self._mapNode.imgEmpty, false)
  self:SetNodeActive(self._mapNode.Container, true)
  self:RefreshBaseCard(mapChar)
  self:SetInHand(nStar)
  if nStar ~= nil then
    self:SetUpgradeHint(nStar or 0)
  end
  local mapShopData
  ForEachTableLine(DataTable.SoldierShopPool, function(mapData)
    if mapData.ChessCharacterId == nCharId then
      mapShopData = mapData
    end
  end)
  if mapShopData ~= nil then
    local nHasMoney = PlayerData.SoldierData:GetCurLevelData():GetItem(AllEnum.CoinItemId.SoldierCurrency)
    self:SetAvailable(nHasMoney >= (nCost or 0) and not bDisablePurchase)
    local sCost = tostring(nCost or 0)
    if nHasMoney < (nCost or 0) then
      sCost = "<color=#E15C73>" .. sCost .. "</color>"
    end
    self:SetCost(sCost)
  end
  self:RefreshSynergy()
  self:RefreshTrial(mapChar)
end

function SoldierCharCardShopItemCtrl:SetEmpty()
  self.nCharId = nil
  self:SetNodeActive(self._mapNode.imgEmpty or self._mapNode.EmptyContainer or self._mapNode.imgEmpty, true)
  self:SetNodeActive(self._mapNode.Container, false)
  self:ResetAllStates()
end

function SoldierCharCardShopItemCtrl:ResetAllStates()
  self:SetNodeActive(self._mapNode.imgRecommend, false)
  self:SetNodeActive(self._mapNode.imgUnavailable, false)
  self:SetNodeActive(self._mapNode.imgInHand, false)
  self:SetNodeActive(self._mapNode.imgPosition, false)
  self:SetUpgradeHint(0)
  self:_ClearSynergyItems()
end

function SoldierCharCardShopItemCtrl:RefreshBaseCard(mapChar)
  NovaAPI.SetTMPText(self._mapNode.txtShopName, mapChar.Name or "")
  NovaAPI.SetTMPText(self._mapNode.txtCharName, mapChar.Name or "")
  local mapSkin = ConfigTable.GetData("SoldierSkin", mapChar.Skin)
  if mapSkin ~= nil then
    self:SetPngSprite(self._mapNode.ImageIcon, mapSkin.Icon .. AllEnum.SoldierChessIconSurfix.L)
  end
  self:SetChessPosition(mapChar.Type)
  self:SetRarity(mapChar.Rarity)
  self:SetTrackAndRecommend()
end

function SoldierCharCardShopItemCtrl:SetRarity(nRarity)
  if nRarity == nil then
    return
  end
  self:SetPngSprite(self._mapNode.imageRarity, "Icon/SoldierOtherIcon/" .. AllEnum.SoldierChessRarityIcon[nRarity] .. AllEnum.SoldierChessIconSurfix.L)
end

function SoldierCharCardShopItemCtrl:SetChessPosition(nType)
  self._mapNode.imgPosition.gameObject:SetActive(true)
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

function SoldierCharCardShopItemCtrl:SetTrackAndRecommend()
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

function SoldierCharCardShopItemCtrl:SetInHand(nStar)
  if nStar ~= nil and 2 <= nStar then
    self:SetNodeActive(self._mapNode.imgInHand, true)
    return
  end
  local tbDeploy, tbWaiting, _ = PlayerData.SoldierData:GetCurLevelData():GetDeploy()
  local bInHand = false
  for k, v in pairs(tbDeploy) do
    if v.nId == self.nCharId then
      bInHand = true
      break
    end
  end
  if bInHand == false then
    for k, v in pairs(tbWaiting) do
      if v.nId == self.nCharId then
        bInHand = true
        break
      end
    end
  end
  self:SetNodeActive(self._mapNode.imgInHand, bInHand)
end

function SoldierCharCardShopItemCtrl:SetUpgradeHint(nStar)
  nStar = nStar or 0
  if nStar < 2 then
    nStar = 0
  end
  if nStar == 0 then
    self:SetNodeActive(self._mapNode.imgUpgrade, false)
    return
  else
    self:SetNodeActive(self._mapNode.imgUpgrade, true)
  end
  for i = 1, 5 do
    self:SetNodeActive(self._mapNode.imgUpgradeStar and self._mapNode.imgUpgradeStar[i], nStar >= i)
  end
end

function SoldierCharCardShopItemCtrl:SetAvailable(bAvailable)
  self:SetNodeActive(self._mapNode.imgUnavailable, not bAvailable)
end

function SoldierCharCardShopItemCtrl:SetCost(sCost)
  NovaAPI.SetTMPText(self._mapNode.txtCost, sCost)
end

function SoldierCharCardShopItemCtrl:SetSelect(bSelect)
  self:SetNodeActive(self._mapNode.imgSelect, bSelect)
end

function SoldierCharCardShopItemCtrl:GetAnimator()
  if self._mapNode.animRoot == nil then
    self._mapNode.animRoot = self.gameObejct.transform:GetChild(0):GetChild(0):GetComponent("Animator")
    if self._mapNode.animRoot == nil then
      return nil
    end
  end
  return self._mapNode.animRoot
end

function SoldierCharCardShopItemCtrl:PlayRandomRefreshOneShot()
  if self.timerRandomRefresh ~= nil then
    self.timerRandomRefresh:Cancel()
    self.timerRandomRefresh = nil
    self._mapNode.FxCard_Random.gameObject:SetActive(false)
  end
  self._mapNode.FxCard_Random.gameObject:SetActive(true)
  local nAnimLength = NovaAPI.GetAnimClipLength(self._mapNode.FxCard_Random, {
    "ShopCardItem_random"
  })
  self.timerRandomRefresh = self:AddTimer(1, nAnimLength, function()
    self._mapNode.FxCard_Random.gameObject:SetActive(false)
  end, true, true, true)
end

function SoldierCharCardShopItemCtrl:RefreshSynergy()
  self:_ClearSynergyItems()
  self:SetNodeActive(self._mapNode.SynergyTemplate, false)
  local tbPartnerTypes = SoldierAttrData.GetPartnerGroupsByChessId(self.nCharId)
  if tbPartnerTypes == nil or #tbPartnerTypes == 0 then
    self:SetNodeActive(self._mapNode.goSynergyRoot, false)
    return
  end
  local goTemplate = self._mapNode.SynergyTemplate
  local goRoot = self._mapNode.goSynergyRoot
  if goTemplate == nil or goRoot == nil then
    return
  end
  self:SetNodeActive(goRoot, true)
  local trParent = goRoot.transform or goRoot
  local nItemCount = 0
  for _, nPartnerType in ipairs(tbPartnerTypes) do
    local mapGroup = CacheTable.GetData("_SoldierPartnerGroup", nPartnerType)
    if mapGroup ~= nil then
      local goItem = instantiate(goTemplate, trParent)
      self:SetNodeActive(goItem, true)
      local ctrl = self:BindCtrlByNode(goItem, SYNERGY_TEMPLATE_PATH)
      if ctrl ~= nil then
        ctrl:OnRefresh(mapGroup)
        nItemCount = nItemCount + 1
        self._tbSynergyItemCtrl = self._tbSynergyItemCtrl or {}
        self._tbSynergyItemGo = self._tbSynergyItemGo or {}
        table.insert(self._tbSynergyItemCtrl, ctrl)
        table.insert(self._tbSynergyItemGo, goItem)
      else
        _DestroyNode(goItem)
      end
    end
  end
  self:SetNodeActive(goRoot, 0 < nItemCount)
end

function SoldierCharCardShopItemCtrl:_ClearSynergyItems()
  local tbSynergyItemCtrl = self._tbSynergyItemCtrl or {}
  for _, ctrl in ipairs(tbSynergyItemCtrl) do
    self:UnbindCtrlByNode(ctrl)
  end
  local tbSynergyItemGo = self._tbSynergyItemGo or {}
  for _, goItem in ipairs(tbSynergyItemGo) do
    _DestroyNode(goItem)
  end
  self._tbSynergyItemCtrl = {}
  self._tbSynergyItemGo = {}
end

function SoldierCharCardShopItemCtrl:RefreshTrial(mapCfg)
  local bShow = false
  if mapCfg.CharacterType == GameEnum.SoldierCharacterType.Actor and mapCfg.CharacterId ~= 0 then
    local mapChar = PlayerData.Char:GetCharDataByTid(mapCfg.CharacterId)
    bShow = mapChar == nil
  end
  self._mapNode.imgTrial.gameObject:SetActive(bShow)
end

function SoldierCharCardShopItemCtrl:SetNodeActive(node, bActive)
  if node == nil then
    return
  end
  if node.gameObject ~= nil then
    node.gameObject:SetActive(bActive)
  else
    node:SetActive(bActive)
  end
end

function SoldierCharCardShopItemCtrl:OnBtnItemClick()
  if self._fnClickCallback ~= nil and self.nCharId ~= nil then
    self._fnClickCallback(self._objClickCallback, self.nCharId)
  end
end

function SoldierCharCardShopItemCtrl:OnEvent_SoldierCharCardShopItemClicked(nCharId)
  if nCharId == nil then
    self:SetSelect(false)
    return
  end
  self:SetSelect(nCharId == self.nCharId)
end

function SoldierCharCardShopItemCtrl:OnShopRefresh(bRandomRefresh)
  if bRandomRefresh then
    self:PlayRandomRefreshOneShot()
  else
    self:GetAnimator():Play("ShopCardItem_refresh")
  end
end

return SoldierCharCardShopItemCtrl
