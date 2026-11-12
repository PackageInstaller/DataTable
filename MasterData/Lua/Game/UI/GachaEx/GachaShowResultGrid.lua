local GachaShowResultGrid = class("GachaShowResultGrid", BaseCtrl)
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResType = GameResourceLoader.ResType
local GachaShowResRoot = "UI/GachaEx/Sprites_Show/"
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local typeof = _ENV.typeof
local mapCharAnimName = {
  [GameEnum.itemRarity.SSR] = "GachaShowResultItem_rtChar_SSR_in",
  [GameEnum.itemRarity.SR] = "GachaShowResultItem_rtChar_SR_in"
}
local mapOutfitAnimName = {
  [GameEnum.itemRarity.SSR] = "GachaShowResultItem_outfit_SSR_in",
  [GameEnum.itemRarity.SR] = "GachaShowResultItem_outfit_SR_in",
  [GameEnum.itemRarity.R] = "GachaShowResultItem_outfit_R_in",
  [GameEnum.itemRarity.M] = "GachaShowResultItem_outfit_N_in",
  [GameEnum.itemRarity.N] = "GachaShowResultItem_outfit_N_in"
}
GachaShowResultGrid._mapNodeConfig = {
  rtOutfit = {},
  imgOutfitBg = {sComponentName = "Image"},
  imgOutfit = {sComponentName = "Image"},
  imgOutfitIcon = {sComponentName = "Image"},
  rtChar = {},
  imgCharBg = {sComponentName = "Image"},
  imgChar = {sComponentName = "Image"},
  animChar = {sNodeName = "imgChar", sComponentName = "Animator"},
  animItem = {
    sNodeName = "resultItemRoot",
    sComponentName = "Animator"
  },
  imgItem = {sComponentName = "Image"},
  imgNewChar = {},
  imgNewOutfit = {},
  imgRare = {sComponentName = "Image"},
  imgPoint1 = {},
  imgPoint2 = {},
  resultItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 2
  },
  btnItem = {
    sComponentName = "UIButton",
    callback = "OnClickBtn_ShowDetail"
  }
}
GachaShowResultGrid._mapEventConfig = {}

function GachaShowResultGrid:OnEnable()
  self.animatorRoot = self.gameObject:GetComponent("Animator")
  self.canvasGroup = self.gameObject:GetComponent("CanvasGroup")
end

function GachaShowResultGrid:Refresh(nTid, bNew, nDelayTime)
  self.nTid = nTid
  self._mapNode.animItem:Play("empty")
  NovaAPI.SetCanvasGroupAlpha(self.canvasGroup, 0)
  self._mapNode.imgNewChar:SetActive(bNew)
  self._mapNode.imgNewOutfit:SetActive(bNew)
  local mapItemCfgData = ConfigTable.GetData_Item(nTid)
  if mapItemCfgData == nil then
    printError("ItemData missing:" .. nTid)
    self.gameObject:SetActive(false)
    return
  end
  
  local function delayCallback()
    NovaAPI.SetCanvasGroupAlpha(self.canvasGroup, 1)
    if self.sAnimName ~= nil and self.sAnimName ~= nil then
      self.animatorRoot:Play(self.sAnimName)
    end
    if mapItemCfgData.Rarity == GameEnum.itemRarity.SSR then
      WwiseAudioMgr:PlaySound("ui_recuit_gacha_result_SSR")
    elseif mapItemCfgData.Rarity == GameEnum.itemRarity.SR then
      WwiseAudioMgr:PlaySound("ui_recuit_gacha_result_SR")
    end
    self.delayTimer = nil
  end
  
  if mapItemCfgData.Type == GameEnum.itemType.Disc then
    self.nItemType = GameEnum.itemType.Disc
    local mapOutfitCfgData = ConfigTable.GetData("Disc", nTid)
    if mapOutfitCfgData == nil then
      printError("Outfit Data missing:" .. nTid)
      self.gameObject:SetActive(false)
      return
    end
    self._mapNode.rtOutfit:SetActive(true)
    self._mapNode.rtChar:SetActive(false)
    self:SetPngSprite(self._mapNode.imgOutfit, mapItemCfgData.Icon .. AllEnum.OutfitIconSurfix.Gacha)
    NovaAPI.SetImageSprite(self._mapNode.imgOutfitBg, Settings.AB_ROOT_PATH .. GachaShowResRoot .. "db_gacha_Outfit_" .. AllEnum.FrameColor_New[mapItemCfgData.Rarity] .. ".png")
    NovaAPI.SetImageSprite(self._mapNode.imgRare, Settings.AB_ROOT_PATH .. GachaShowResRoot .. "rare_character_gacha_" .. AllEnum.FrameColor_New[mapItemCfgData.Rarity] .. ".png")
    NovaAPI.SetImageNativeSize(self._mapNode.imgRare)
    self.sAnimName = mapOutfitAnimName[mapItemCfgData.Rarity]
    if bNew then
      self._mapNode.resultItem[1].gameObject:SetActive(false)
      self._mapNode.resultItem[2].gameObject:SetActive(false)
      self.bShowItem = false
    else
      self._mapNode.resultItem[1].gameObject:SetActive(false)
      self._mapNode.resultItem[2].gameObject:SetActive(false)
      self._mapNode.resultItem[1]:SetItem(mapOutfitCfgData.TransformItemId, nil, nil, nil, false, false, false, true, false)
      self.bShowItem = true
    end
  elseif mapItemCfgData.Type == GameEnum.itemType.Char then
    self.nItemType = GameEnum.itemType.Char
    local mapCharCfgData = ConfigTable.GetData_Character(nTid)
    if mapCharCfgData == nil then
      printError("Char Data missing:" .. nTid)
      self.gameObject:SetActive(false)
      return 0
    end
    self._mapNode.rtOutfit:SetActive(false)
    self._mapNode.rtChar:SetActive(true)
    local mapCfgDataCharSkin = ConfigTable.GetData_CharacterSkin(mapCharCfgData.DefaultSkinId)
    self:SetPngSprite(self._mapNode.imgChar, mapCfgDataCharSkin.Icon .. AllEnum.CharHeadIconSurfix.GC)
    NovaAPI.SetImageSprite(self._mapNode.imgCharBg, Settings.AB_ROOT_PATH .. GachaShowResRoot .. "db_gacha_character_" .. AllEnum.FrameColor_New[mapItemCfgData.Rarity] .. ".png")
    NovaAPI.SetImageSprite(self._mapNode.imgRare, Settings.AB_ROOT_PATH .. GachaShowResRoot .. "rare_character_gacha_" .. AllEnum.FrameColor_New[mapItemCfgData.Rarity] .. ".png")
    self._mapNode.imgPoint1:SetActive(mapItemCfgData.Rarity ~= 1)
    self._mapNode.imgPoint2:SetActive(mapItemCfgData.Rarity == 1)
    NovaAPI.SetImageNativeSize(self._mapNode.imgRare)
    if bNew then
      self._mapNode.resultItem[1].gameObject:SetActive(false)
      self._mapNode.resultItem[2].gameObject:SetActive(false)
      self.bShowItem = false
    else
      self._mapNode.resultItem[1].gameObject:SetActive(false)
      self._mapNode.resultItem[2].gameObject:SetActive(false)
      self._mapNode.resultItem[1]:SetItem(mapCharCfgData.FragmentsId, nil, mapCharCfgData.TransformQty, nil, false, false, false, true, false)
      self.bShowItem = true
    end
    self.sAnimName = mapCharAnimName[mapItemCfgData.Rarity]
  else
    printError("Item Type Error:" .. mapItemCfgData.Type)
    self.gameObject:SetActive(false)
    self.bShowItem = false
    return 0
  end
  if 0 < nDelayTime then
    self.delayTimer = self:AddTimer(1, nDelayTime, delayCallback, true, true, nil, nil)
  else
    delayCallback()
  end
  if mapItemCfgData.Rarity == GameEnum.itemRarity.SSR then
    return 0.35
  else
    return 0.1
  end
end

function GachaShowResultGrid:LoadPngGacha(sPath)
  return self:LoadAsset(sPath .. ".png", typeof(Sprite))
end

function GachaShowResultGrid:ShowAllCardEnd()
  if self.bShowItem == true then
    local mapItemCfgData = ConfigTable.GetData_Item(self.nTid)
    if mapItemCfgData.Type == GameEnum.itemType.Char then
      self._mapNode.animItem:Play("resultItemRoot_Char")
    else
      self._mapNode.animItem:Play("resultItemRoot_Outfit")
    end
    self._mapNode.resultItem[1].gameObject:SetActive(true)
    WwiseAudioMgr:PlaySound("ui_recuit_gacha_result_crystal")
  else
    self._mapNode.animItem:Play("empty")
  end
end

function GachaShowResultGrid:JumpDelay()
  if self.delayTimer ~= nil then
    self.delayTimer:Cancel(true)
  end
end

function GachaShowResultGrid:OnClickBtn_ShowDetail()
  if PlayerData.Guide:GetGuideState() then
    return
  end
  if self.nItemType == nil then
    return
  end
  if self.nItemType == GameEnum.itemType.Disc then
    EventManager.Hit(EventId.OpenPanel, PanelId.DiscSample, self.nTid)
  elseif self.nItemType == GameEnum.itemType.Char then
    EventManager.Hit(EventId.OpenPanel, PanelId.CharBgTrialPanel, PanelId.CharInfoTrial, self.nTid)
  end
end

return GachaShowResultGrid
