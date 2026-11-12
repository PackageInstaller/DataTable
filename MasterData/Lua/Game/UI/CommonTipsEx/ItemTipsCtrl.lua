local BaseCtrl = require("Game.UI.CommonTipsEx.CommonTipsBaseCtrl")
local ItemTipsCtrl = class("ItemTipsCtrl", BaseCtrl)
local JumpUtil = require("Game.Common.Utils.JumpUtil")
ItemTipsCtrl.minTipHeight = 87
ItemTipsCtrl.maxTipHeight = 557
local titleHeight = 240
local halfTitleNameHeight = 45
local MoveUpHeight = 45
local textTitleWidthWithDetail = 460
local textTitleWidth = 560
ItemTipsCtrl._mapNodeConfig = {
  btnCloseTips = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ClosePanel"
  },
  btnCloseWordTip = {
    sComponentName = "Button",
    callback = "OnBtnClick_CloseWord"
  },
  imgWordTipBg = {},
  TMPWordDesc = {sComponentName = "TMP_Text"},
  TMPWordTipsTitle = {sComponentName = "TMP_Text"},
  imgTipsBg = {
    sComponentName = "RectTransform"
  },
  rtContent = {
    sComponentName = "RectTransform"
  },
  TipsContent = {
    sComponentName = "RectTransform"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "RectTransform"
  },
  TMPItemTitle = {sComponentName = "TMP_Text"},
  TMPItemCount = {sComponentName = "TMP_Text"},
  imgRemainTime = {nCount = 3},
  TMPTimeLimit = {sComponentName = "TMP_Text"},
  TMPSubTitle = {sComponentName = "TMP_Text"},
  TMPItemDesc = {sComponentName = "TMP_Text"},
  rtJumptoContent = {
    sComponentName = "RectTransform"
  },
  goJumptoGrid = {},
  rtJumpTo = {
    sComponentName = "RectTransform"
  },
  TMPJumptoTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "ItemTips_GetWay"
  },
  srDesc = {
    sComponentName = "RectTransform"
  },
  rtDescContent = {
    sComponentName = "RectTransform"
  },
  btnShortcutClose = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_ClosePanel"
  },
  btnDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  txtBtnDetail = {sComponentName = "TMP_Text", sLanguageId = "MoreInfo"},
  exId = {sComponentName = "TMP_Text"},
  TMPFurnitureCollect = {sComponentName = "TMP_Text"},
  rtFurnitureChar = {},
  rtActiveRole = {
    sNodeName = "imgBg_Role_",
    nCount = 3
  },
  TMPFurnitureCharTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_FurnitureTips_ActionCharTitle"
  },
  imgActiveRoleIcon = {
    sComponentName = "Image",
    sNodeName = "imgRoleIcon_",
    nCount = 3
  }
}
ItemTipsCtrl._mapEventConfig = {}

function ItemTipsCtrl:Awake()
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.rtTarget = tbParam[1]
    self.mapData = tbParam[2]
  end
end

function ItemTipsCtrl:FadeIn()
end

function ItemTipsCtrl:FadeOut()
end

function ItemTipsCtrl:OnEnable()
  self:EnableGamepadUI(self._mapNode.btnShortcutClose)
  self.tbGoJumpto = {}
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
  self._mapNode.goJumptoGrid:SetActive(false)
  self._mapNode.rtFurnitureChar:SetActive(false)
  self._mapNode.TMPFurnitureCollect.gameObject:SetActive(false)
  self.sortingOrder = NovaAPI.GetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"))
  local btnComp = self.rtTarget:GetComponent("Button")
  if btnComp ~= nil then
    btnComp.interactable = false
  end
  NovaAPI.SetComponentEnableByName(self.rtTarget.gameObject, "TopGridCanvas", true)
  NovaAPI.SetTopGridCanvasSorting(self.rtTarget.gameObject, self.sortingOrder)
  local mapItemCfgData = ConfigTable.GetData_Item(self.mapData.nTid)
  if mapItemCfgData == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.TMPItemTitle, mapItemCfgData.Title)
  if mapItemCfgData.ExpireType == GameEnum.expireType.ExpireDate then
    local nExpire = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapItemCfgData.ExpireDate)
    local nCurTime = CS.ClientManager.Instance.serverTimeStamp
    local remainTime = nExpire - nCurTime
    local sTime = ""
    if 86400 <= remainTime then
      local day = math.floor(remainTime / 86400)
      local hour = math.floor((remainTime - day * 86400) / 3600)
      if hour == 0 then
        day = day - 1
        hour = 24
      end
      sTime = string.format("%s%s%s%s", day, ConfigTable.GetUIText("Depot_LeftTime_Day"), hour, ConfigTable.GetUIText("Depot_LeftTime_Hour"))
    elseif 3600 <= remainTime then
      local hour = math.floor(remainTime / 3600)
      local min = math.floor((remainTime - hour * 3600) / 60)
      if min == 0 then
        hour = hour - 1
        min = 60
      end
      sTime = string.format("%s%s%s%s", hour, ConfigTable.GetUIText("Depot_LeftTime_Hour"), min, ConfigTable.GetUIText("Depot_LeftTime_Min"))
    elseif 0 < remainTime then
      local min = math.floor(remainTime / 60)
      sTime = string.format("%s%s", min, ConfigTable.GetUIText("Depot_LeftTime_Min"))
    else
      sTime = ConfigTable.GetUIText("Depot_Item_Expire")
    end
    NovaAPI.SetTMPText(self._mapNode.TMPTimeLimit, sTime)
    self._mapNode.imgRemainTime[1].gameObject:SetActive(86400 <= remainTime)
    self._mapNode.imgRemainTime[2].gameObject:SetActive(remainTime < 86400 and 3600 <= remainTime)
    self._mapNode.imgRemainTime[3].gameObject:SetActive(remainTime < 3600)
  else
    self._mapNode.TMPTimeLimit.gameObject:SetActive(false)
  end
  if mapItemCfgData.Desc then
    if mapItemCfgData.Literary and mapItemCfgData.Literary ~= "" then
      NovaAPI.SetTMPText(self._mapNode.TMPItemDesc, mapItemCfgData.Desc .. [[

<color=#5E89B4>]] .. mapItemCfgData.Literary .. "</color>")
    else
      NovaAPI.SetTMPText(self._mapNode.TMPItemDesc, mapItemCfgData.Desc)
    end
  elseif mapItemCfgData.Literary and mapItemCfgData.Literary ~= "" then
    NovaAPI.SetTMPText(self._mapNode.TMPItemDesc, mapItemCfgData.Literary)
  else
    NovaAPI.SetTMPText(self._mapNode.TMPItemDesc, "")
  end
  self.tbDetailItem = {}
  
  local function sort(a, b)
    local mapItemCfgDataA = ConfigTable.GetData_Item(a.nId)
    local mapItemCfgDataB = ConfigTable.GetData_Item(b.nId)
    if mapItemCfgDataA and mapItemCfgDataB and mapItemCfgDataA.Rarity ~= mapItemCfgDataB.Rarity then
      return mapItemCfgDataA.Rarity < mapItemCfgDataB.Rarity
    end
    return a.nId < b.nId
  end
  
  if mapItemCfgData.Stype == GameEnum.itemStype.RandomPackage then
    local mapItemUseCfg = decodeJson(mapItemCfgData.UseArgs)
    for sTid, _ in pairs(mapItemUseCfg) do
      local nItemTid = tonumber(sTid)
      if nItemTid ~= nil then
        local tbDropShowData = PlayerData.Item:GetDropItemShow(nItemTid)
        if tbDropShowData ~= nil then
          for _, mapData in ipairs(tbDropShowData) do
            table.insert(self.tbDetailItem, {
              nId = mapData.ItemId,
              nCount = mapData.ItemQty
            })
          end
        end
      end
    end
    table.sort(self.tbDetailItem, sort)
    self.sDetailTitle = ConfigTable.GetUIText("ItemTip_RandomPackageTitle")
    self._mapNode.btnDetail.gameObject:SetActive(next(self.tbDetailItem) ~= nil)
    local titleTra = self._mapNode.TMPItemTitle:GetComponent("RectTransform")
    if next(self.tbDetailItem) ~= nil then
      titleTra.sizeDelta = Vector2(textTitleWidthWithDetail, titleTra.sizeDelta.y)
    else
      titleTra.sizeDelta = Vector2(textTitleWidth, titleTra.sizeDelta.y)
    end
  elseif mapItemCfgData.Stype == GameEnum.itemStype.ComCYO then
    local mapItemUseCfg = decodeJson(mapItemCfgData.UseArgs)
    for sTid, nCount in pairs(mapItemUseCfg) do
      local nItemTid = tonumber(sTid)
      if nItemTid ~= nil then
        table.insert(self.tbDetailItem, {nId = nItemTid, nCount = nCount})
      end
    end
    table.sort(self.tbDetailItem, sort)
    self.sDetailTitle = ConfigTable.GetUIText("ItemTip_ComCYOTitle")
    self._mapNode.btnDetail.gameObject:SetActive(next(self.tbDetailItem) ~= nil)
    local titleTra = self._mapNode.TMPItemTitle:GetComponent("RectTransform")
    if next(self.tbDetailItem) ~= nil then
      titleTra.sizeDelta = Vector2(textTitleWidthWithDetail, titleTra.sizeDelta.y)
    else
      titleTra.sizeDelta = Vector2(textTitleWidth, titleTra.sizeDelta.y)
    end
  elseif mapItemCfgData.Stype == GameEnum.itemStype.CharacterYO or mapItemCfgData.Stype == GameEnum.itemStype.OutfitCYO or mapItemCfgData.Stype == GameEnum.itemStype.Build then
    self.sDetailTitle = ConfigTable.GetUIText("ItemTip_ComCYOTitle")
    self._mapNode.btnDetail.gameObject:SetActive(true)
    local titleTra = self._mapNode.TMPItemTitle:GetComponent("RectTransform")
    titleTra.sizeDelta = Vector2(textTitleWidthWithDetail, titleTra.sizeDelta.y)
  elseif mapItemCfgData.Stype == GameEnum.itemStype.DormFurniture then
    self.sDetailTitle = "ItemStype_" .. mapItemCfgData.Stype
    local mapFurnitureConfig = ConfigTable.GetData("DormFurniture", self.mapData.nTid)
    if mapFurnitureConfig ~= nil then
      self._mapNode.TMPFurnitureCollect.gameObject:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.TMPFurnitureCollect, mapFurnitureConfig.CollectionValue)
      self._mapNode.rtFurnitureChar:SetActive(0 < mapFurnitureConfig.ActorSD_Id)
      if 0 < mapFurnitureConfig.ActorSD_Id then
        if mapFurnitureConfig.ActorSD_Id == 1 then
          local bIsMale = PlayerData.Base:GetPlayerSex() == true
          local nSkinId = bIsMale and PlayerData.PlayerDormData:GetDormCharSkin(9101) or PlayerData.PlayerDormData:GetDormCharSkin(9100)
          local mapCharSkin = ConfigTable.GetData("DormRoleSkin", nSkinId)
          if mapCharSkin ~= nil then
            self:SetPngSprite(self._mapNode.imgActiveRoleIcon[1], mapCharSkin.Icon .. AllEnum.CharHeadIconSurfix.S)
          end
        else
          local nCharSkinId = PlayerData.PlayerDormData:GetDormCharSkin(mapFurnitureConfig.ActorSD_Id)
          local mapCharSkin = ConfigTable.GetData("DormRoleSkin", nCharSkinId)
          if mapCharSkin ~= nil then
            self:SetPngSprite(self._mapNode.imgActiveRoleIcon[1], mapCharSkin.Icon .. AllEnum.CharHeadIconSurfix.S)
          end
        end
      end
    end
  else
    self._mapNode.btnDetail.gameObject:SetActive(false)
    local titleTra = self._mapNode.TMPItemTitle:GetComponent("RectTransform")
    titleTra.sizeDelta = Vector2(textTitleWidth, titleTra.sizeDelta.y)
  end
  if mapItemCfgData.Stype == GameEnum.itemStype.DormFurniture then
    self.mapData.bShowDepot = false
  end
  if self.mapData.bShowDepot and not mapItemCfgData.DisHaving then
    local nItemDepotCount = 0
    if self.mapData.nHasCount ~= nil then
      nItemDepotCount = self.mapData.nHasCount
    elseif self.mapData.nTid == AllEnum.CoinItemId.FREESTONE or self.mapData.nTid == AllEnum.CoinItemId.STONE then
      nItemDepotCount = PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.FREESTONE) + PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.STONE)
    else
      nItemDepotCount = PlayerData.Item:GetItemCountByID(self.mapData.nTid)
    end
    self._mapNode.TMPItemCount.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.TMPItemCount, orderedFormat(ConfigTable.GetUIText("ItemTip_DepotCount"), nItemDepotCount))
  else
    self._mapNode.TMPItemCount.gameObject:SetActive(false)
  end
  local sLanguage = "ItemStype_" .. mapItemCfgData.Stype
  NovaAPI.SetTMPText(self._mapNode.TMPSubTitle, ConfigTable.GetUIText(sLanguage) or "")
  local ModuleManager = require("GameCore.Module.ModuleManager")
  local sCurModule = ModuleManager.GetCurModuleName()
  if self.mapData.bShowJumpto and 0 < #mapItemCfgData.JumpTo then
    self._mapNode.rtJumpTo.gameObject:SetActive(true)
    self:RefreshJumpto(mapItemCfgData.JumpTo)
  else
    self._mapNode.rtJumpTo.gameObject:SetActive(false)
  end
  self._mapNode.exId.gameObject:SetActive(false)
  EventManager.Hit("TipsId", self._mapNode.exId, self.mapData.nTid)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    local nContentHeight = self._mapNode.rtDescContent.sizeDelta.y
    print(nContentHeight)
    if nContentHeight > self.maxTipHeight then
      nContentHeight = self.maxTipHeight
    end
    if nContentHeight < self.minTipHeight then
      nContentHeight = self.minTipHeight
    end
    self._mapNode.srDesc.sizeDelta = Vector2(self._mapNode.srDesc.sizeDelta.x, nContentHeight)
    local titleTra = self._mapNode.TMPItemTitle:GetComponent("RectTransform")
    local nTitleHeight = titleHeight
    local nDescOffset = 0
    if titleTra.sizeDelta.y < 75 then
      nTitleHeight = titleHeight
    else
      nTitleHeight = titleHeight * 1.25
      nDescOffset = MoveUpHeight
    end
    local itemCountTra = self._mapNode.TMPItemCount:GetComponent("RectTransform")
    itemCountTra.anchoredPosition = Vector2(itemCountTra.anchoredPosition.x, itemCountTra.anchoredPosition.y + MoveUpHeight - nDescOffset)
    local furnitrueCollectionTra = self._mapNode.TMPFurnitureCollect:GetComponent("RectTransform")
    furnitrueCollectionTra.anchoredPosition = Vector2(furnitrueCollectionTra.anchoredPosition.x, furnitrueCollectionTra.anchoredPosition.y + MoveUpHeight - nDescOffset)
    local exIdTra = self._mapNode.exId:GetComponent("RectTransform")
    exIdTra.anchoredPosition = Vector2(exIdTra.anchoredPosition.x, exIdTra.anchoredPosition.y + MoveUpHeight)
    if not (not self.mapData.bShowDepot or mapItemCfgData.DisHaving) or mapItemCfgData.Stype == GameEnum.itemStype.DormFurniture then
      self._mapNode.srDesc.anchoredPosition = Vector2(self._mapNode.srDesc.anchoredPosition.x, self._mapNode.srDesc.anchoredPosition.y + MoveUpHeight - nDescOffset)
      nTitleHeight = nTitleHeight - MoveUpHeight
    else
      self._mapNode.srDesc.anchoredPosition = Vector2(self._mapNode.srDesc.anchoredPosition.x, self._mapNode.srDesc.anchoredPosition.y + MoveUpHeight * 2 - nDescOffset)
      nTitleHeight = nTitleHeight - MoveUpHeight * 2
    end
    self._mapNode.imgTipsBg.sizeDelta = Vector2(self._mapNode.imgTipsBg.sizeDelta.x, nContentHeight + nTitleHeight)
    self:SetTipsPosition(self.rtTarget, self._mapNode.rtContent, self._mapNode.safeAreaRoot)
  end
  
  cs_coroutine.start(wait)
end

function ItemTipsCtrl:OnDisable()
  self:DisableGamepadUI()
  if self.tbGoJumpto == nil then
    return
  end
  for _, btnComp in pairs(self.tbGoJumpto) do
    btnComp.onClick:RemoveAllListeners()
  end
  self.tbGoJumpto = {}
end

function ItemTipsCtrl:OnDestroy()
end

function ItemTipsCtrl:OnRelease()
end

function ItemTipsCtrl:RefreshJumpto(tbJumpto)
  self.tbJumptoData = {}
  for _, nJumptoId in ipairs(tbJumpto) do
    local mapJumpTo = ConfigTable.GetData("JumpTo", nJumptoId)
    if mapJumpTo ~= nil then
      if mapJumpTo.Type == GameEnum.jumpType.ComCYO then
        local mapProduceCfg = ConfigTable.GetData("ProduceHelper", self.mapData.nTid)
        if mapProduceCfg ~= nil then
          local tbComCYO = mapProduceCfg.ComCYOIds
          for _, v in ipairs(tbComCYO) do
            local nCount = PlayerData.Item:GetItemCountByID(v)
            if 0 < nCount then
              local itemCfgData = ConfigTable.GetData_Item(v, true)
              if itemCfgData ~= nil then
                local mapAfter = clone(mapJumpTo)
                mapAfter.Desc = string.format(mapAfter.Desc, itemCfgData.Title)
                mapAfter.Param = {v}
                table.insert(self.tbJumptoData, mapAfter)
              end
            end
          end
        end
      else
        table.insert(self.tbJumptoData, mapJumpTo)
      end
    end
  end
  for i, mapJumpTo in ipairs(self.tbJumptoData) do
    local goJumpto = instantiate(self._mapNode.goJumptoGrid, self._mapNode.rtJumptoContent)
    goJumpto:SetActive(true)
    local btnComp = goJumpto.transform:Find("btnJump"):GetComponent("Button")
    table.insert(self.tbGoJumpto, btnComp)
    local func_Handler = ui_handler(self, self.OnBtnClick_JumpTo, btnComp, i)
    btnComp.onClick:AddListener(func_Handler)
    local imgIconJumpto = goJumpto.transform:Find("btnJump/AnimRoot/imgIcon"):GetComponent("Image")
    local txtDesc = goJumpto.transform:Find("btnJump/AnimRoot/txtDesc"):GetComponent("TMP_Text")
    local goArrow = goJumpto.transform:Find("btnJump/AnimRoot/imgArrow").gameObject
    if mapJumpTo.Icon == nil then
      mapJumpTo.Icon = ""
    end
    self:SetPngSprite(imgIconJumpto, mapJumpTo.Icon)
    NovaAPI.SetImageNativeSize(imgIconJumpto)
    NovaAPI.SetTMPText(txtDesc, mapJumpTo.Desc)
    if mapJumpTo.Type == GameEnum.jumpType.Text then
      btnComp.interactable = false
      goArrow:SetActive(false)
    else
      btnComp.interactable = true
      goArrow:SetActive(true)
    end
  end
end

function ItemTipsCtrl:OnBtnClick_JumpTo(_, nIndex)
  self:OnBtnClick_ClosePanel()
  JumpUtil.JumpTo(self.tbJumptoData[nIndex].Id, self.tbJumptoData[nIndex].Param, self.mapData.nTid, self.mapData.nNeedCount)
end

function ItemTipsCtrl:OnBtnClick_Word(sWordId)
  local nWordId = tonumber(sWordId)
  local mapWordData = ConfigTable.GetData_World(nWordId)
  if mapWordData == nil then
    printError("wordId error:" .. sWordId)
    return
  end
  self._mapNode.btnCloseWordTip.gameObject:SetActive(true)
  self._mapNode.imgWordTipBg:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.TMPWordDesc, mapWordData.Desc)
  NovaAPI.SetTMPSourceText(self._mapNode.TMPWordTipsTitle, mapWordData.Title)
  self:SetWordTipsSize()
end

function ItemTipsCtrl:OnBtnClick_CloseWord(btn)
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
end

function ItemTipsCtrl:OnBtnClick_ClosePanel(btn)
  if self.rtTarget and not self.rtTarget:IsNull() then
    local btnComp = self.rtTarget:GetComponent("Button")
    if btnComp ~= nil then
      btnComp.interactable = true
    end
    NovaAPI.SetComponentEnableByName(self.rtTarget.gameObject, "TopGridCanvas", false)
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.ItemTips)
end

function ItemTipsCtrl:OnBtnClick_Detail()
  local mapItemCfgData = ConfigTable.GetData_Item(self.mapData.nTid)
  if mapItemCfgData == nil then
    return
  end
  self:OnBtnClick_ClosePanel()
  EventManager.Hit(EventId.CloseMessageBox)
  EventManager.Hit(EventId.BlockInput, true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    EventManager.Hit(EventId.BlockInput, false)
    if mapItemCfgData.Stype == GameEnum.itemStype.CharacterYO then
      EventManager.Hit(EventId.OpenPanel, PanelId.CharConsumablePanel, self.mapData.nTid, true)
    elseif mapItemCfgData.Stype == GameEnum.itemStype.OutfitCYO then
      EventManager.Hit(EventId.OpenPanel, PanelId.DiscPreview, self.mapData.nTid, true)
    elseif mapItemCfgData.Stype == GameEnum.itemStype.Build then
      local nBuildId = decodeJson(mapItemCfgData.UseArgs)["1"]
      local mapBuildCfgData = PlayerData.Build:GetTrialBuild(tonumber(nBuildId))
      if mapBuildCfgData == nil then
        return
      end
      EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerBuildDetailPreview, mapBuildCfgData)
    else
      local msg = {
        nType = AllEnum.MessageBox.ItemList,
        tbItem = self.tbDetailItem,
        sTitle = self.sDetailTitle
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
    end
  end
  
  cs_coroutine.start(wait)
end

return ItemTipsCtrl
