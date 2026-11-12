local SoldierAttrData = require("GameCore.Data.DataClass.Soldier.SoldierAttrData")
local CommonTipsBaseCtrl = require("Game.UI.CommonTipsEx.CommonTipsBaseCtrl")
local SoldierPartnerTipsCtrl = class("SoldierPartnerTipsCtrl", CommonTipsBaseCtrl)
SoldierPartnerTipsCtrl._mapNodeConfig = {
  btnCloseTips = {
    sComponentName = "Button",
    callback = "OnBtnClick_ClosePanel"
  },
  rtContent = {
    sComponentName = "RectTransform"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "RectTransform"
  },
  TipsContent = {
    sComponentName = "RectTransform"
  },
  imgTipsBg = {
    sComponentName = "RectTransform"
  },
  ScrollView = {sComponentName = "ScrollRect"},
  rtDescContent = {
    sComponentName = "RectTransform"
  },
  srDesc = {
    sComponentName = "RectTransform"
  },
  goCharItem = {sComponentName = "Transform"},
  goEffectItem = {sComponentName = "Transform"},
  imgPartnerBg = {sComponentName = "Image"},
  imgPartnerIcon = {sComponentName = "Image"},
  txtPartnerName = {sComponentName = "TMP_Text"},
  btnTrace = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Trace"
  },
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Trace"
  },
  txtPartnerDesc = {sComponentName = "TMP_Text"},
  TMP_Link = {
    sNodeName = "txtPartnerDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnLinkClick_Word"
  },
  btnShortcutClose = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_ClosePanel"
  },
  btnCloseWordTip = {
    sComponentName = "Button",
    callback = "OnBtnClick_CloseWord"
  },
  imgWordTipBg = {},
  TMPWordDesc = {sComponentName = "TMP_Text"},
  TMPWordTipsTitle = {sComponentName = "TMP_Text"},
  partner_desc = {nCount = 5},
  go_Char = {
    sNodeName = "tc_char_small",
    sComponentName = "Transform"
  },
  goPartnerTitle = {
    sComponentName = "RectTransform"
  },
  charDetialRoot = {sComponentName = "Transform"},
  txtBtnTrace = {
    sComponentName = "TMP_Text",
    sLanguageId = "Solider_Trace"
  },
  txtBtnCancel = {sComponentName = "TMP_Text", sLanguageId = "BtnCancel"},
  imgBG = {sNodeName = "----BG----", sComponentName = "Image"}
}
SoldierPartnerTipsCtrl._mapEventConfig = {
  OnSetParnterTipsPosition = "OnEvent_SetParnterTipsPosition",
  SoldierCharTips_ShowBg = "OnEvent_ShowBg"
}
SoldierPartnerTipsCtrl._mapRedDotConfig = {}
local iconPartnerPath = "Icon/SoldierPartner/"
local RootPath = "Icon/SoldierOtherIcon/"
local contentHeight = 882
SoldierPartnerTipsCtrl.minTipHeight = 59.13
SoldierPartnerTipsCtrl.maxTipHeight = 896
local replace_Harvest = "==HARVEST=="

function SoldierPartnerTipsCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.rtTarget = tbParam[1]
    self.partnerType = tbParam[2]
    self.activityLevel = tbParam[3]
    self.bTrace = tbParam[4]
    self.tbChars = tbParam[5]
    self.bCanCheckCharTips = tbParam[6] or true
    self.bShowTrace = tbParam[7] or true
  end
  self._tbCharItemCtrl = {}
end

function SoldierPartnerTipsCtrl:OnEnable()
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
  self._mapNode.btnTrace.gameObject:SetActive(not self.bTrace and self.tbChars == nil and self.bShowTrace)
  self._mapNode.btnCancel.gameObject:SetActive(self.bTrace and self.tbChars == nil and self.bShowTrace)
  self:EnableGamepadUI(self._mapNode.btnShortcutClose, true)
  self:RefreshPanel()
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if self._mapNode == nil then
      return
    end
    local nContentHeight = self._mapNode.rtDescContent.sizeDelta.y
    if nContentHeight > self.maxTipHeight then
      nContentHeight = self.maxTipHeight
      NovaAPI.SetScrollRectVertical(self._mapNode.ScrollView, true)
    end
    if nContentHeight < self.minTipHeight then
      nContentHeight = self.minTipHeight
      NovaAPI.SetScrollRectVertical(self._mapNode.ScrollView, false)
    end
    self._mapNode.srDesc.sizeDelta = Vector2(self._mapNode.srDesc.sizeDelta.x, nContentHeight)
    nContentHeight = nContentHeight + self._mapNode.goPartnerTitle.sizeDelta.y + 20
    local nTipsBgHeight = nContentHeight + 10
    self._mapNode.imgTipsBg.sizeDelta = Vector2(self._mapNode.imgTipsBg.sizeDelta.x, nTipsBgHeight)
    if nTipsBgHeight < contentHeight then
      local nDiff = contentHeight - nTipsBgHeight
      local rtTargetRect = self.rtTarget:GetComponent("RectTransform")
      local anchoredPos = rtTargetRect.anchoredPosition
      self._tbTargetOriginPos = anchoredPos
      rtTargetRect.anchoredPosition = Vector2(anchoredPos.x, anchoredPos.y + nDiff)
    end
    self:SetTipsPosition(self.rtTarget, self._mapNode.rtContent, self._mapNode.safeAreaRoot)
    if self.bSetTipsPos ~= true then
      self._mapNode.charDetialRoot.position = self._mapNode.imgTipsBg.position
    end
  end
  
  cs_coroutine.start(wait)
end

function SoldierPartnerTipsCtrl:OnDisable()
  self:DisableGamepadUI()
  if self._tbTargetOriginPos ~= nil and self.rtTarget ~= nil then
    local rtTargetRect = self.rtTarget:GetComponent("RectTransform")
    rtTargetRect.anchoredPosition = self._tbTargetOriginPos
    self._tbTargetOriginPos = nil
  end
end

function SoldierPartnerTipsCtrl:RefreshPanel()
  self:RefreshTitle()
  self:RefreshLevelItems()
  self:RefreshCharItems()
end

function SoldierPartnerTipsCtrl:RefreshTitle()
  local partnerGroupCfg = CacheTable.GetData("_SoldierPartnerGroup", self.partnerType)
  self:SetPngSprite(self._mapNode.imgPartnerIcon, iconPartnerPath .. partnerGroupCfg.Icon .. "_M")
  local tbAttrData = SoldierAttrData.GetPartnerLevelsByType(self.partnerType)
  local level = math.max(1, self.activityLevel)
  local mapCfg = ConfigTable.GetData("SoldierPartner", tbAttrData[level].nConfigId)
  if mapCfg == nil then
    return
  end
  local sPath = self.activityLevel > 0 and RootPath .. AllEnum.SoldierPartnerLevelIcon[mapCfg.PartnerLevelQuality].bg or RootPath .. AllEnum.SoldierPartnerLevelIcon[GameEnum.PartnerLevelQuality.None].bg
  self:SetPngSprite(self._mapNode.imgPartnerBg, sPath)
  NovaAPI.SetTMPText(self._mapNode.txtPartnerName, partnerGroupCfg.Name)
  local nHarvest = 0
  if PlayerData.SoldierData:GetCurLevelData() ~= nil then
    nHarvest = PlayerData.SoldierData:GetCurLevelData():GetClientHarvestCount()
  end
  local sDesc = UTILS.ParseDesc(partnerGroupCfg)
  sDesc = string.gsub(sDesc, replace_Harvest, nHarvest)
  NovaAPI.SetTMPText(self._mapNode.txtPartnerDesc, sDesc)
end

function SoldierPartnerTipsCtrl:RefreshLevelItems()
  local tbAttrData = SoldierAttrData.GetPartnerLevelsByType(self.partnerType)
  for i = 1, 5 do
    self._mapNode.partner_desc[i].gameObject:SetActive(tbAttrData[i] ~= nil)
    if tbAttrData[i] ~= nil then
      local canvasGroup = self._mapNode.partner_desc[i]:GetComponent("CanvasGroup")
      local imgEffectLv = self._mapNode.partner_desc[i].transform:Find("imgEffectLv"):GetComponent("Image")
      local txtEffectDesc = self._mapNode.partner_desc[i].transform:Find("txtEffectDesc"):GetComponent("TMP_Text")
      local txt_level = self._mapNode.partner_desc[i].transform:Find("imgEffectLv/txt_level"):GetComponent("TMP_Text")
      local mapCfg = ConfigTable.GetData("SoldierPartner", tbAttrData[i].nConfigId)
      if mapCfg == nil then
        return
      end
      self:SetPngSprite(imgEffectLv, RootPath .. AllEnum.SoldierPartnerLevelIcon[mapCfg.PartnerLevelQuality].levelIcon)
      NovaAPI.SetTMPText(txtEffectDesc, mapCfg.Desc)
      NovaAPI.SetTMPText(txt_level, mapCfg.Num)
      NovaAPI.SetCanvasGroupAlpha(canvasGroup, i == self.activityLevel and 1 or 0.5)
    end
  end
end

function SoldierPartnerTipsCtrl:RefreshCharItems()
  self._mapNode.go_Char.gameObject:SetActive(false)
  local partnerGroupCfg = CacheTable.GetData("_SoldierPartnerGroup", self.partnerType)
  if partnerGroupCfg == nil then
    return
  end
  local tbChars = {}
  for k, v in ipairs(partnerGroupCfg.ChessCharacterIds) do
    table.insert(tbChars, v)
  end
  table.sort(tbChars, function(a, b)
    local charCfgA = ConfigTable.GetData("SoldierCharacter", a)
    local charCfgB = ConfigTable.GetData("SoldierCharacter", b)
    if charCfgA.Rarity ~= charCfgB.Rarity then
      return charCfgA.Rarity > charCfgB.Rarity
    end
    return a < b
  end)
  for i = 1, #tbChars do
    if self._tbCharItemCtrl[i] ~= nil then
      self:RefreshCharInfo(self._tbCharItemCtrl[i].itemCtrl, tbChars[i], self._tbCharItemCtrl[i].goItem)
      self._tbCharItemCtrl[i].goItem.gameObject:SetActive(true)
    else
      local charItem = instantiate(self._mapNode.go_Char, self._mapNode.goCharItem)
      local charItemCtrl = self:BindCtrlByNode(charItem, "Game.UI.Soldier.Template.Character.SoldierCharItemCtrl")
      self:RefreshCharInfo(charItemCtrl, tbChars[i], charItem)
      charItem.gameObject:SetActive(true)
      table.insert(self._tbCharItemCtrl, {itemCtrl = charItemCtrl, goItem = charItem})
    end
  end
  for i = #tbChars + 1, #self._tbCharItemCtrl do
    if self._tbCharItemCtrl[i] ~= nil then
      self._tbCharItemCtrl[i].goItem.gameObject:SetActive(false)
    end
  end
end

function SoldierPartnerTipsCtrl:RefreshCharInfo(itemCtrl, charId, goChar)
  local tbDeployChess = {}
  local tbWaitingChess = {}
  if self.tbChars == nil or #self.tbChars <= 0 then
    local curLevelData = PlayerData.SoldierData:GetCurLevelData()
    if curLevelData ~= nil then
      tbDeployChess, tbWaitingChess = curLevelData:GetDeploy()
    end
  else
    tbDeployChess = self.tbChars
  end
  local bInBattle = false
  local bInWaiting = false
  local nStar = 0
  itemCtrl:SetItemData(charId)
  for _, char in ipairs(tbDeployChess) do
    if char.nId == charId then
      bInBattle = true
      nStar = math.max(nStar, char.nStar)
      break
    end
  end
  for _, char in ipairs(tbWaitingChess) do
    if char.nId == charId then
      bInWaiting = true
      nStar = math.max(nStar, char.nStar)
      break
    end
  end
  itemCtrl:SetItemState(bInBattle, not bInWaiting and not bInBattle)
  itemCtrl:SetCharLevel(nStar)
  if self.bCanCheckCharTips then
    itemCtrl:SetCharItemBtnFunc(function()
      local chessData = {
        nPositionType = self.partnerType,
        nId = charId,
        nStar = math.max(nStar, 1)
      }
      EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCharCardTips, self._mapNode.charDetialRoot, chessData)
      EventManager.Hit("OnSetTipsPosition", self.skillTipsPos, self.potentialTipsPos, self.partnerTipsPos)
    end)
  end
end

function SoldierPartnerTipsCtrl:OnBtnClick_ClosePanel()
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierPartnerTips)
end

function SoldierPartnerTipsCtrl:OnBtnClick_Trace()
  local function callback()
    self.bTrace = not self.bTrace
    
    self._mapNode.btnTrace.gameObject:SetActive(not self.bTrace)
    self._mapNode.btnCancel.gameObject:SetActive(self.bTrace)
  end
  
  local curLevelData = PlayerData.SoldierData:GetCurLevelData()
  if curLevelData ~= nil then
    curLevelData:SetPartnerTrace(self.partnerType, not self.bTrace, callback)
  end
end

function SoldierPartnerTipsCtrl:OnBtnClick_CloseWord(btn)
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
end

function SoldierPartnerTipsCtrl:OnLinkClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

function SoldierPartnerTipsCtrl:OnEvent_ShowBg()
  self._mapNode.imgBG.enabled = true
end

function SoldierPartnerTipsCtrl:OnEvent_SetParnterTipsPosition(charTipsPos, skillTipsPos, pontentialTipsPos, partnerTipsPos)
  self.bSetTipsPos = true
  if charTipsPos ~= nil and self._mapNode.charDetialRoot ~= nil then
    self._mapNode.charDetialRoot.position = charTipsPos
  end
  if skillTipsPos ~= nil then
    self.skillTipsPos = skillTipsPos
  end
  if pontentialTipsPos ~= nil then
    self.potentialTipsPos = pontentialTipsPos
  end
  if partnerTipsPos ~= nil then
    self.partnerTipsPos = partnerTipsPos
  end
end

return SoldierPartnerTipsCtrl
