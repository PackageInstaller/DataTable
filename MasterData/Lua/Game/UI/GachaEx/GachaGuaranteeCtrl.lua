local GachaGuaranteeCtrl = class("GachaGuaranteeCtrl", BaseCtrl)
GachaGuaranteeCtrl._mapNodeConfig = {
  GridSmallOutfit = {},
  GridSmall = {},
  TMPGuaranteeTitle = {sComponentName = "TMP_Text"},
  TMPGuarantee = {sComponentName = "TMP_Text"},
  TMPPoolDesc = {sComponentName = "TMP_Text"},
  rtGuaranteeItems = {sComponentName = "Transform"},
  Content = {}
}
GachaGuaranteeCtrl._mapEventConfig = {}
GachaGuaranteeCtrl._mapRedDotConfig = {}

function GachaGuaranteeCtrl:Awake()
end

function GachaGuaranteeCtrl:FadeIn()
end

function GachaGuaranteeCtrl:FadeOut()
end

function GachaGuaranteeCtrl:OnEnable()
end

function GachaGuaranteeCtrl:OnDisable()
  delChildren(self._mapNode.rtGuaranteeItems)
end

function GachaGuaranteeCtrl:OnDestroy()
end

function GachaGuaranteeCtrl:OnRelease()
end

function GachaGuaranteeCtrl:Refresh(nPoolId)
  local mapPoolCfgData = ConfigTable.GetData("Gacha", nPoolId)
  if mapPoolCfgData == nil then
    self._mapNode.Content:SetActive(false)
    return
  end
  local nStrogeId = mapPoolCfgData.StorageId
  local mapStorageTypeCfgData = ConfigTable.GetData("GachaType", mapPoolCfgData.GachaType)
  local mapStorageCfgData = ConfigTable.GetData("GachaStorage", nStrogeId)
  if mapStorageTypeCfgData == nil or mapStorageCfgData == nil then
    self._mapNode.Content:SetActive(false)
    return
  end
  
  local function GetContent(nItmeId)
    local ret = ""
    local mapCfgData = ConfigTable.GetData_Item(nItmeId)
    if mapCfgData ~= nil then
      if mapCfgData.Type == GameEnum.itemType.Char then
        local mapCharCfg = ConfigTable.GetData_Character(nItmeId)
        if mapCharCfg ~= nil then
          ret = string.format("%s·%s", ConfigTable.GetUIText("T_Element_Attr_" .. mapCharCfg.EET), mapCharCfg.Name)
        end
      elseif mapCfgData.Type == GameEnum.itemType.Disc then
        local mapDiscCfg = ConfigTable.GetData("Disc", nItmeId)
        if mapDiscCfg ~= nil then
          ret = string.format("%s·%s", ConfigTable.GetUIText("T_Element_Attr_" .. mapDiscCfg.EET), mapCfgData.Title)
        end
      end
    end
    return ret
  end
  
  self._mapNode.Content:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.TMPGuaranteeTitle, orderedFormat(mapStorageTypeCfgData.Desc9, mapPoolCfgData.Name))
  local tbSSRUpChar = {}
  local tbSSRUpOutfit = {}
  local tbSRUpChar = {}
  local tbSRUpOutfit = {}
  local tbSSRChar = {}
  local tbSSROutfit = {}
  local tbSRChar = {}
  local tbSROutfit = {}
  local tbROutfit = {}
  local tbUpItemList, tbItemList = PlayerData.Gacha:GetPoolProbDetail(nPoolId)
  for _, v in pairs(tbUpItemList) do
    local itemConfig = ConfigTable.GetData_Item(v.nGoodsId)
    if itemConfig.Type == GameEnum.itemType.Char then
      if itemConfig.Rarity == GameEnum.itemRarity.SSR then
        table.insert(tbSSRUpChar, v.nGoodsId)
        table.insert(tbSSRChar, v.nGoodsId)
      else
        table.insert(tbSRUpChar, v.nGoodsId)
        table.insert(tbSRChar, v.nGoodsId)
      end
    elseif itemConfig.Rarity == GameEnum.itemRarity.SSR then
      table.insert(tbSSRUpOutfit, v.nGoodsId)
      table.insert(tbSSROutfit, v.nGoodsId)
    else
      table.insert(tbSRUpOutfit, v.nGoodsId)
      table.insert(tbSROutfit, v.nGoodsId)
    end
  end
  for _, v in pairs(tbItemList) do
    local itemConfig = ConfigTable.GetData_Item(v.nGoodsId)
    if itemConfig.Type == GameEnum.itemType.Char then
      if itemConfig.Rarity == GameEnum.itemRarity.SSR then
        table.insert(tbSSRChar, v.nGoodsId)
      else
        table.insert(tbSRChar, v.nGoodsId)
      end
    elseif itemConfig.Rarity == GameEnum.itemRarity.SSR then
      table.insert(tbSSROutfit, v.nGoodsId)
    elseif itemConfig.Rarity == GameEnum.itemRarity.SR then
      table.insert(tbSROutfit, v.nGoodsId)
    else
      table.insert(tbROutfit, v.nGoodsId)
    end
  end
  local nCount = 0
  local upItemName = ""
  if nStrogeId == GameEnum.gachaStorageType.DiscCardPool or nStrogeId == GameEnum.gachaStorageType.CharacterCardPool or nStrogeId == GameEnum.gachaStorageType.CharacterCardRewardPool then
    local nAupMissing = PlayerData.Gacha:GetAMissTimesById(nPoolId)
    local nMaxMissing = mapPoolCfgData.ATypeGuaranteeTimes
    local nSum = nMaxMissing - nAupMissing
    nCount = nSum
  else
    local nAupMissing = PlayerData.Gacha:GetAupMissTimesById(nPoolId)
    local nMaxMissing = mapStorageCfgData.AUpGuaranteeTimes
    local nSum = nMaxMissing - nAupMissing
    nCount = nSum
    if 0 < #tbSSRUpChar then
      upItemName = GetContent(tbSSRUpChar[1])
    elseif 0 < #tbSSRUpOutfit then
      upItemName = GetContent(tbSSROutfit[1])
    end
  end
  NovaAPI.SetTMPText(self._mapNode.TMPGuarantee, orderedFormat(mapStorageTypeCfgData.Desc10, nCount))
  NovaAPI.SetTMPText(self._mapNode.TMPPoolDesc, orderedFormat(mapStorageTypeCfgData.Desc11, mapPoolCfgData.Name, upItemName))
  
  local function SetCharGrid(goGrid, nTid)
    goGrid:SetActive(true)
    local mapCharCfgData = ConfigTable.GetData_Item(nTid)
    local mapCharCfg = ConfigTable.GetData_Character(nTid)
    local mapCharSkin = ConfigTable.GetData_CharacterSkin(mapCharCfg.DefaultSkinId)
    local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[mapCharCfg.Grade]
    local imgIcon = goGrid.transform:Find("AnimRoot/rtScaleRoot/tc_char_03/imgIconBg/imgItemIcon"):GetComponent("Image")
    local imgRare = goGrid.transform:Find("AnimRoot/rtScaleRoot/tc_char_03/imgItemRare"):GetComponent("Image")
    local imgElement = goGrid.transform:Find("AnimRoot/rtScaleRoot/tc_char_03/imgElement"):GetComponent("Image")
    local TMPName = goGrid.transform:Find("AnimRoot/TMPName"):GetComponent("TMP_Text")
    local TMPName1 = goGrid.transform:Find("AnimRoot/TMPName1"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(TMPName, mapCharCfgData.Title)
    NovaAPI.SetTMPText(TMPName1, mapCharCfgData.Title)
    TMPName.gameObject:SetActive(nStrogeId == GameEnum.gachaStorageType.CharacterUpCardPool or nStrogeId == GameEnum.gachaStorageType.DiscUpCardPool)
    TMPName1.gameObject:SetActive(nStrogeId == GameEnum.gachaStorageType.CharacterCardRewardPool or nStrogeId == GameEnum.gachaStorageType.DiscCardPool or nStrogeId == GameEnum.gachaStorageType.CharacterCardPool)
    self:SetPngSprite(imgIcon, mapCharSkin.Icon .. AllEnum.CharHeadIconSurfix.XXL)
    self:SetAtlasSprite(imgElement, "12_rare", AllEnum.Star_Element[mapCharCfg.EET].icon)
    self:SetAtlasSprite(imgRare, "12_rare", sFrame)
    local btnGrid = goGrid:GetComponent("UIButton")
    if btnGrid ~= nil then
      local ui_func = ui_handler(self, self.OnBtnClick_ShowCharInfo, goGrid, nTid)
      btnGrid.onClick:AddListener(ui_func)
    end
  end
  
  local function SetOutfitGrid(goGrid, nTid)
    goGrid:SetActive(true)
    local mapItemCfgData = ConfigTable.GetData_Item(nTid)
    local imgIcon = goGrid.transform:Find("AnimRoot/rtScaleRoot/imgIcon"):GetComponent("Image")
    local imgRare = goGrid.transform:Find("AnimRoot/rtScaleRoot/imgRare"):GetComponent("Image")
    local imgElement = goGrid.transform:Find("AnimRoot/rtScaleRoot/imgElement"):GetComponent("Image")
    local mapDiscCfgData = ConfigTable.GetData("Disc", nTid)
    local TMPName = goGrid.transform:Find("AnimRoot/TMPName"):GetComponent("TMP_Text")
    local TMPName1 = goGrid.transform:Find("AnimRoot/TMPName1"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(TMPName, mapItemCfgData.Title)
    NovaAPI.SetTMPText(TMPName1, mapItemCfgData.Title)
    TMPName.gameObject:SetActive(nStrogeId == GameEnum.gachaStorageType.CharacterUpCardPool or nStrogeId == GameEnum.gachaStorageType.DiscUpCardPool)
    TMPName1.gameObject:SetActive(nStrogeId == GameEnum.gachaStorageType.DiscCardPool or nStrogeId == GameEnum.gachaStorageType.CharacterCardPool)
    self:SetPngSprite(imgIcon, mapItemCfgData.Icon .. AllEnum.OutfitIconSurfix.Item)
    self:SetAtlasSprite(imgElement, "12_rare", AllEnum.Star_Element[mapDiscCfgData.EET].icon)
    self:SetSprite_FrameColor(imgRare, mapItemCfgData.Rarity, AllEnum.FrameType_New.Item)
    local btnGrid = goGrid:GetComponent("UIButton")
    if btnGrid ~= nil then
      local ui_func = ui_handler(self, self.OnBtnClick_ShowDiscInfo, goGrid, nTid)
      btnGrid.onClick:AddListener(ui_func)
    end
  end
  
  delChildren(self._mapNode.rtGuaranteeItems)
  if nStrogeId == GameEnum.gachaStorageType.DiscCardPool or nStrogeId == GameEnum.gachaStorageType.CharacterCardPool or nStrogeId == GameEnum.gachaStorageType.CharacterCardRewardPool then
    for _, nTid in ipairs(tbSSRChar) do
      local goGrid = instantiate(self._mapNode.GridSmall, self._mapNode.rtGuaranteeItems)
      SetCharGrid(goGrid, nTid)
    end
    for _, nTid in ipairs(tbSSROutfit) do
      local goGrid = instantiate(self._mapNode.GridSmallOutfit, self._mapNode.rtGuaranteeItems)
      SetOutfitGrid(goGrid, nTid)
    end
  else
    for _, nTid in ipairs(tbSSRUpChar) do
      local goGrid = instantiate(self._mapNode.GridSmall, self._mapNode.rtGuaranteeItems)
      SetCharGrid(goGrid, nTid)
    end
    for _, nTid in ipairs(tbSSRUpOutfit) do
      local goGrid = instantiate(self._mapNode.GridSmallOutfit, self._mapNode.rtGuaranteeItems)
      SetOutfitGrid(goGrid, nTid)
    end
  end
end

function GachaGuaranteeCtrl:OnBtnClick_ShowCharInfo(btn, nCharId)
  EventManager.Hit(EventId.OpenPanel, PanelId.CharBgTrialPanel, PanelId.CharInfoTrial, nCharId)
end

function GachaGuaranteeCtrl:OnBtnClick_ShowDiscInfo(btn, nDiscId)
  EventManager.Hit(EventId.OpenPanel, PanelId.DiscSample, nDiscId)
end

return GachaGuaranteeCtrl
