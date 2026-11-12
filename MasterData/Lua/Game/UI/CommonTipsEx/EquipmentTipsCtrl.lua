local BaseCtrl = require("Game.UI.CommonTipsEx.CommonTipsBaseCtrl")
local EquipmentTipsCtrl = class("EquipmentTipsCtrl", BaseCtrl)
EquipmentTipsCtrl._mapNodeConfig = {
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
  rtContentCanvasGroup = {
    sNodeName = "rtContent",
    sComponentName = "CanvasGroup"
  },
  TipsContent = {
    sComponentName = "RectTransform"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "RectTransform"
  },
  srDesc = {
    sComponentName = "RectTransform"
  },
  ScrollView = {sComponentName = "ScrollRect"},
  Content = {
    sComponentName = "RectTransform"
  },
  txtTipName = {sComponentName = "TMP_Text"},
  goStar = {
    sCtrlName = "Game.UI.TemplateEx.TemplateStarCtrl"
  },
  txtTipLevel = {sComponentName = "TMP_Text"},
  txtTipLevelCn = {sComponentName = "TMP_Text"},
  btnLock = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Lock"
  },
  imgLock = {},
  imgUnlock = {},
  imgEquipType = {sComponentName = "Image"},
  txtEquipmentType = {sComponentName = "TMP_Text"},
  txtEquipped = {sComponentName = "TMP_Text"},
  goBaseProperty = {},
  goRandomProperty = {nCount = 3},
  txtTipBaseAttr = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Base_Attr_Title"
  },
  rtBaseAttr = {
    sComponentName = "RectTransform"
  },
  txtTipRandomAttr = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Random_Attr_Title"
  },
  rtRandomAttr = {
    sComponentName = "RectTransform"
  },
  txtTipDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Desc_Title"
  },
  btnShortcutClose = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_ClosePanel"
  }
}
EquipmentTipsCtrl._mapEventConfig = {}
EquipmentTipsCtrl.minTipHeight = 87
EquipmentTipsCtrl.maxTipHeight = 587.6
local titleHeight = 285.87
local random_attr_normal = 1
local random_attr_match = 2
local random_attr_lock = 3

function EquipmentTipsCtrl:Refresh(nId, mapEquip, nCharId)
  local nChar, equipmentData
  if nId ~= nil and nId ~= 0 then
    self.nEquipmentId = nId
    equipmentData = PlayerData.Equipment:GetEquipmentById(nId)
    nChar = PlayerData.Char:GetCharByEquipment(nId)
  elseif mapEquip ~= nil then
    equipmentData = mapEquip
    self.nEquipmentId = 0
    nChar = nCharId
  end
  if nil ~= equipmentData then
    NovaAPI.SetTMPText(self._mapNode.txtTipName, equipmentData:GetName())
    self._mapNode.goStar:SetStar(equipmentData:GetStar(), equipmentData:GetStar())
    NovaAPI.SetTMPText(self._mapNode.txtTipLevel, equipmentData:GetLevel())
    self:ChangeLock(equipmentData:GetLock())
    self:SetPngSprite(self._mapNode.imgEquipType, equipmentData:GetTypeIcon())
    NovaAPI.SetTMPText(self._mapNode.txtEquipmentType, equipmentData:GetTypeDesc())
    self._mapNode.txtEquipped.gameObject:SetActive(nil ~= nChar and nChar ~= 0)
    if nil ~= nChar and nChar ~= 0 then
      local charCfg = ConfigTable.GetData_Character(nChar)
      NovaAPI.SetTMPText(self._mapNode.txtEquipped, charCfg.Name .. ConfigTable.GetUIText("Equipment_Equipped"))
    end
    self._mapNode.goBaseProperty.gameObject:SetActive(false)
    for _, v in ipairs(self._mapNode.goRandomProperty) do
      v.gameObject:SetActive(false)
    end
    delChildren(self._mapNode.rtBaseAttr.gameObject)
    local tbBaseAttr = equipmentData:GetBaseAttr()
    if next(tbBaseAttr) ~= nil then
      for _, mapAttachAttr in pairs(AllEnum.AttachAttr) do
        local mapAttr = tbBaseAttr[mapAttachAttr.sKey]
        if 0 < mapAttr.Value then
          local goItemObj = instantiate(self._mapNode.goBaseProperty, self._mapNode.rtBaseAttr)
          goItemObj:SetActive(true)
          local ctrlItem = self:BindCtrlByNode(goItemObj, "Game.UI.TemplateEx.TemplatePropertyCtrl")
          ctrlItem:SetItemProperty(mapAttr.Key, mapAttr.Value, nil, true)
        end
      end
    end
    delChildren(self._mapNode.rtRandomAttr.gameObject)
    local tbCharTag = {}
    if nChar ~= 0 then
      local mapCharDescCfg = ConfigTable.GetData("CharacterDes", nChar)
      for _, v in ipairs(mapCharDescCfg.Tag) do
        tbCharTag[v] = v
      end
    end
    local nMatchAddition = PlayerData.Equipment:GetEquipmentMatchAddition()
    local tbRandomAttr = equipmentData:GetRandomAttr()
    local tbTag = equipmentData:GetTag()
    local nLevel = equipmentData:GetLevel()
    for k, v in ipairs(tbRandomAttr) do
      local nIndex = 0
      if nLevel < v.UnlockLv then
        nIndex = random_attr_lock
      elseif tbCharTag[tbTag[k]] ~= nil then
        nIndex = random_attr_match
      else
        nIndex = random_attr_normal
      end
      local goItemObj = instantiate(self._mapNode.goRandomProperty[nIndex], self._mapNode.rtRandomAttr)
      goItemObj:SetActive(true)
      local ctrlItem = self:BindCtrlByNode(goItemObj, "Game.UI.TemplateEx.TemplateRandomPropertyCtrl")
      if nLevel < v.UnlockLv then
        ctrlItem:SetAttrLock(tbTag[k], v.UnlockLv)
      else
        local nValue = v.Value
        if nIndex == random_attr_match then
          nValue = nValue * (1 + nMatchAddition)
        end
        ctrlItem:SetProperty(tbTag[k], v.AttrId, nValue)
      end
    end
  end
end

function EquipmentTipsCtrl:ChangeLock(bLock)
  self.bLock = bLock
  self._mapNode.imgLock.gameObject:SetActive(bLock)
  self._mapNode.imgUnlock.gameObject:SetActive(not bLock)
end

function EquipmentTipsCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.rtTarget = tbParam[1]
    self.mapData = tbParam[2]
  end
end

function EquipmentTipsCtrl:OnEnable()
  self:EnableGamepadUI(self._mapNode.btnShortcutClose)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.rtContentCanvasGroup, 0)
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
  self.sortingOrder = NovaAPI.GetCanvasSortingOrder(self.gameObject:GetComponent("Canvas"))
  local btnComp = self.rtTarget:GetComponent("Button")
  if btnComp ~= nil then
    btnComp.interactable = false
  end
  NovaAPI.SetComponentEnableByName(self.rtTarget.gameObject, "TopGridCanvas", true)
  NovaAPI.SetTopGridCanvasSorting(self.rtTarget.gameObject, self.sortingOrder)
  local bHideLock = self.mapData.bHideLock
  self._mapNode.btnLock.gameObject:SetActive(not bHideLock)
  self:Refresh(self.mapData.nId, self.mapData.equipmentData, self.mapData.nCharId)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    local nContentHeight = self._mapNode.Content.sizeDelta.y
    print(nContentHeight)
    if nContentHeight > self.maxTipHeight then
      nContentHeight = self.maxTipHeight
      NovaAPI.SetScrollRectVertical(self._mapNode.ScrollView, true)
    end
    if nContentHeight < self.minTipHeight then
      nContentHeight = self.minTipHeight
      NovaAPI.SetScrollRectVertical(self._mapNode.ScrollView, false)
    end
    self._mapNode.srDesc.sizeDelta = Vector2(self._mapNode.srDesc.sizeDelta.x, nContentHeight)
    self._mapNode.imgTipsBg.sizeDelta = Vector2(self._mapNode.imgTipsBg.sizeDelta.x, nContentHeight + titleHeight)
    self:SetTipsPosition(self.rtTarget, self._mapNode.rtContent, self._mapNode.safeAreaRoot)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.rtContentCanvasGroup, 1)
  end
  
  cs_coroutine.start(wait)
end

function EquipmentTipsCtrl:OnDisable()
  self:DisableGamepadUI()
end

function EquipmentTipsCtrl:OnBtnClick_Close()
end

function EquipmentTipsCtrl:OnBtnClick_Lock()
  local function callback(bLock)
    EventManager.Hit(EventId.EquipmentChangeLockState, self.nEquipmentId)
    
    local equipmentData = PlayerData.Equipment:GetEquipmentById(self.nEquipmentId)
    if bLock then
      EventManager.Hit(EventId.OpenMessageBox, {
        nType = AllEnum.MessageBox.Tips,
        bPositive = true,
        sContent = orderedFormat(ConfigTable.GetUIText("Equipment_Lock_Suc"), equipmentData:GetName())
      })
    else
      EventManager.Hit(EventId.OpenMessageBox, {
        nType = AllEnum.MessageBox.Tips,
        bPositive = true,
        sContent = orderedFormat(ConfigTable.GetUIText("Equipment_Unlock_Suc"), equipmentData.sName)
      })
    end
    self:ChangeLock(bLock)
  end
  
  PlayerData.Equipment:SendEquipmentLockUnlockReq(self.nEquipmentId, not self.bLock, callback)
end

function EquipmentTipsCtrl:OnBtnClick_CloseWordTips()
  self._mapNode.btn_CloseWordTips.gameObject:SetActive(false)
  self._mapNode.go_WordTip:SetActive(false)
  if self.funcCloseTips ~= nil and self.mapParent ~= nil then
    self.funcCloseTips(self.mapParent)
  end
end

function EquipmentTipsCtrl:OnLinkClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

function EquipmentTipsCtrl:OnBtnClick_ClosePanel(btn)
  if self.rtTarget and not self.rtTarget:IsNull() then
    local btnComp = self.rtTarget:GetComponent("Button")
    if btnComp ~= nil then
      btnComp.interactable = true
    end
    NovaAPI.SetComponentEnableByName(self.rtTarget.gameObject, "TopGridCanvas", false)
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.EquipmentTips)
end

function EquipmentTipsCtrl:OnBtnClick_CloseWord(btn)
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
end

return EquipmentTipsCtrl
