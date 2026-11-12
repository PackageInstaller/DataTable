local GachaInfoCtrl = class("GachaInfoCtrl", BaseCtrl)
AllEnum = require("GameCore.Common.AllEnum")
GachaInfoCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Recruit_info"
  },
  GridBig = {},
  GridOutfit = {},
  GridSmallOutfit = {},
  GridSmall = {},
  rtSSRList = {sComponentName = "Transform"},
  rtSRList = {sComponentName = "Transform"},
  rtAllSSRList = {sComponentName = "Transform"},
  rtAllSRList = {sComponentName = "Transform"},
  rtAllRList = {sComponentName = "Transform"},
  rtSSRContnet = {},
  rtSRContnet = {},
  rtUPContent = {},
  rtAllSSRContnet = {},
  rtAllSRContnet = {},
  rtAllRContnet = {},
  TMPPoolDes = {sComponentName = "TMP_Text"},
  TMPRandomInfo = {sComponentName = "TMP_Text"},
  TMPRepeatInfo = {sComponentName = "TMP_Text"},
  TMPUPTitle = {sComponentName = "TMP_Text"},
  TMPUPSSRTitle = {sComponentName = "TMP_Text"},
  TMPUPSRTitle = {sComponentName = "TMP_Text"},
  TMPAllTitle = {sComponentName = "TMP_Text"},
  TMPAllSSRTitle = {sComponentName = "TMP_Text"},
  TMPAllSRTitle = {sComponentName = "TMP_Text"},
  TMPAllRTitle = {sComponentName = "TMP_Text"},
  TMPPoolDesTitle = {sComponentName = "TMP_Text"},
  TMPRandomInfoTitle = {sComponentName = "TMP_Text"},
  TMPRepeatInfoTitle = {sComponentName = "TMP_Text"},
  btnCloseScreen = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  btnClose = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  rtPoolInfo = {sComponentName = "Animator"},
  btn_ProbDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_OpenProbInfo"
  },
  txt_Prob = {sComponentName = "TMP_Text", sLanguageId = "Gacha_Prob"},
  svInfo = {sComponentName = "ScrollRect"}
}
GachaInfoCtrl._mapEventConfig = {}

function GachaInfoCtrl:Awake()
end

function GachaInfoCtrl:FadeIn()
end

function GachaInfoCtrl:FadeOut()
end

function GachaInfoCtrl:OnEnable()
end

function GachaInfoCtrl:OnDisable()
end

function GachaInfoCtrl:OnDestroy()
end

function GachaInfoCtrl:OnRelease()
end

function GachaInfoCtrl:Refresh(nGachaId)
  NovaAPI.SetVerticalNormalizedPosition(self._mapNode.svInfo, 1)
  local mapGachaPoolCfgData = ConfigTable.GetData("Gacha", nGachaId)
  if mapGachaPoolCfgData == nil then
    printError("Gacha Missing:" .. nGachaId)
    return
  end
  local mapGachaCfgData = ConfigTable.GetData("GachaType", mapGachaPoolCfgData.GachaType)
  if mapGachaCfgData == nil then
    printError("GachaType Missing:" .. mapGachaPoolCfgData.GachaType)
    return
  end
  local tbSSRUpChar = {}
  local tbSSRUpOutfit = {}
  local tbSRUpChar = {}
  local tbSRUpOutfit = {}
  local tbSSRChar = {}
  local tbSSROutfit = {}
  local tbSRChar = {}
  local tbSROutfit = {}
  local tbROutfit = {}
  local tbUpItemList, tbItemList = PlayerData.Gacha:GetPoolProbDetail(nGachaId)
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
  delChildren(self._mapNode.rtAllRList)
  delChildren(self._mapNode.rtAllSRList)
  delChildren(self._mapNode.rtAllSSRList)
  delChildren(self._mapNode.rtSRList)
  delChildren(self._mapNode.rtSSRList)
  
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
    NovaAPI.SetTMPText(TMPName, mapCharCfgData.Title)
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
    NovaAPI.SetTMPText(TMPName, mapItemCfgData.Title)
    self:SetPngSprite(imgIcon, mapItemCfgData.Icon .. AllEnum.OutfitIconSurfix.Item)
    self:SetAtlasSprite(imgElement, "12_rare", AllEnum.Star_Element[mapDiscCfgData.EET].icon)
    self:SetSprite_FrameColor(imgRare, mapItemCfgData.Rarity, AllEnum.FrameType_New.Item)
    local btnGrid = goGrid:GetComponent("UIButton")
    if btnGrid ~= nil then
      local ui_func = ui_handler(self, self.OnBtnClick_ShowDiscInfo, goGrid, nTid)
      btnGrid.onClick:AddListener(ui_func)
    end
  end
  
  if #tbSSRUpChar + #tbSSRUpOutfit == 0 then
    self._mapNode.rtSSRContnet:SetActive(false)
  else
    self._mapNode.rtSSRContnet:SetActive(true)
    for _, nTid in ipairs(tbSSRUpChar) do
      local goGrid = instantiate(self._mapNode.GridBig, self._mapNode.rtSSRList)
      SetCharGrid(goGrid, nTid)
    end
    for _, nTid in ipairs(tbSSRUpOutfit) do
      local goGrid = instantiate(self._mapNode.GridOutfit, self._mapNode.rtSSRList)
      SetOutfitGrid(goGrid, nTid)
    end
  end
  if #tbSRUpOutfit + #tbSRUpChar == 0 then
    self._mapNode.rtSSRContnet:SetActive(false)
  else
    self._mapNode.rtSSRContnet:SetActive(true)
    self._mapNode.rtSSRContnet:SetActive(true)
    for _, nTid in ipairs(tbSRUpChar) do
      local goGrid = instantiate(self._mapNode.GridBig, self._mapNode.rtSRList)
      SetCharGrid(goGrid, nTid)
    end
    for _, nTid in ipairs(tbSRUpOutfit) do
      local goGrid = instantiate(self._mapNode.GridOutfit, self._mapNode.rtSRList)
      SetOutfitGrid(goGrid, nTid)
    end
  end
  if #tbSRUpOutfit + #tbSRUpChar + #tbSSRUpChar + #tbSSRUpOutfit == 0 then
    self._mapNode.rtUPContent:SetActive(false)
  else
    self._mapNode.rtUPContent:SetActive(true)
  end
  if #tbSSRChar + #tbSSROutfit == 0 then
    self._mapNode.rtAllSSRContnet:SetActive(false)
  else
    self._mapNode.rtAllSSRContnet:SetActive(true)
    for _, nTid in ipairs(tbSSRChar) do
      local goGrid = instantiate(self._mapNode.GridSmall, self._mapNode.rtAllSSRList)
      SetCharGrid(goGrid, nTid)
    end
    for _, nTid in ipairs(tbSSROutfit) do
      local goGrid = instantiate(self._mapNode.GridSmallOutfit, self._mapNode.rtAllSSRList)
      SetOutfitGrid(goGrid, nTid)
    end
  end
  if #tbSRChar + #tbSROutfit == 0 then
    self._mapNode.rtAllSRContnet:SetActive(false)
  else
    self._mapNode.rtAllSRContnet:SetActive(true)
    for _, nTid in ipairs(tbSRChar) do
      local goGrid = instantiate(self._mapNode.GridSmall, self._mapNode.rtAllSRList)
      SetCharGrid(goGrid, nTid)
    end
    for _, nTid in ipairs(tbSROutfit) do
      local goGrid = instantiate(self._mapNode.GridSmallOutfit, self._mapNode.rtAllSRList)
      SetOutfitGrid(goGrid, nTid)
    end
  end
  if tbROutfit == 0 then
    self._mapNode.rtAllSRContnet:SetActive(false)
  else
    self._mapNode.rtAllSRContnet:SetActive(true)
    for _, nTid in ipairs(tbROutfit) do
      local goGrid = instantiate(self._mapNode.GridSmallOutfit, self._mapNode.rtAllRList)
      SetOutfitGrid(goGrid, nTid)
    end
  end
  local tbContent = {}
  tbContent[1] = mapGachaPoolCfgData.Name
  local tbMainItem = {}
  local tbSubItem = {}
  local mapPkgData = ConfigTable.Get("GachaPkg")
  if mapPkgData ~= nil then
    ForEachTableLine(mapPkgData, function(mapData)
      if mapData.PkgId == mapGachaPoolCfgData.ATypeUpPkg then
        table.insert(tbMainItem, mapData.GoodsId)
      elseif mapData.PkgId == mapGachaPoolCfgData.BTypeUpPkg then
        table.insert(tbSubItem, mapData.GoodsId)
      end
    end)
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
  
  if tbMainItem[1] ~= nil then
    local nItemId = tbMainItem[1]
    tbContent[2] = GetContent(nItemId)
  end
  if tbSubItem[1] ~= nil then
    tbContent[3] = GetContent(tbSubItem[1])
  end
  if tbSubItem[2] ~= nil then
    tbContent[4] = GetContent(tbSubItem[2])
  end
  
  local function subContent(sContent)
    return (sContent:gsub("{(%d+)}", function(index)
      index = tonumber(index) + 1
      return tbContent[index] == nil and "" or tbContent[index]
    end))
  end
  
  NovaAPI.SetTMPText(self._mapNode.TMPUPTitle, mapGachaCfgData.Title4)
  NovaAPI.SetTMPText(self._mapNode.TMPUPSSRTitle, mapGachaCfgData.Desc4)
  NovaAPI.SetTMPText(self._mapNode.TMPUPSRTitle, mapGachaCfgData.Desc5)
  NovaAPI.SetTMPText(self._mapNode.TMPAllTitle, mapGachaCfgData.Title5)
  NovaAPI.SetTMPText(self._mapNode.TMPAllSSRTitle, mapGachaCfgData.Desc6)
  NovaAPI.SetTMPText(self._mapNode.TMPAllSRTitle, mapGachaCfgData.Desc7)
  NovaAPI.SetTMPText(self._mapNode.TMPAllRTitle, mapGachaCfgData.Desc8)
  NovaAPI.SetTMPText(self._mapNode.TMPPoolDes, subContent(mapGachaCfgData.Desc1))
  NovaAPI.SetTMPText(self._mapNode.TMPPoolDesTitle, mapGachaCfgData.Title1)
  NovaAPI.SetTMPText(self._mapNode.TMPRandomInfo, subContent(mapGachaCfgData.Desc2))
  NovaAPI.SetTMPText(self._mapNode.TMPRandomInfoTitle, mapGachaCfgData.Title2)
  NovaAPI.SetTMPText(self._mapNode.TMPRepeatInfo, mapGachaCfgData.Desc3)
  NovaAPI.SetTMPText(self._mapNode.TMPRepeatInfoTitle, mapGachaCfgData.Title3)
  self._mapNode.btn_ProbDetail.gameObject:SetActive(mapGachaPoolCfgData.StorageId ~= GameEnum.gachaStorageType.BeginnerCardPool)
end

function GachaInfoCtrl:OpenInfo()
  self.gameObject:SetActive(true)
  self._mapNode.rtPoolInfo:Play("t_window_04_t_in")
end

function GachaInfoCtrl:OnBtnClick_Close()
  local function Close()
    self.gameObject:SetActive(false)
  end
  
  self._mapNode.rtPoolInfo:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, Close, true, true, true)
end

function GachaInfoCtrl:OnBtnClick_ShowCharInfo(btn, nCharId)
  EventManager.Hit(EventId.OpenPanel, PanelId.CharBgTrialPanel, PanelId.CharInfoTrial, nCharId)
end

function GachaInfoCtrl:OnBtnClick_ShowDiscInfo(btn, nDiscId)
  EventManager.Hit(EventId.OpenPanel, PanelId.DiscSample, nDiscId)
end

function GachaInfoCtrl:OnBtnClick_OpenProbInfo()
  EventManager.Hit("GachaOpenProbInfo")
end

return GachaInfoCtrl
