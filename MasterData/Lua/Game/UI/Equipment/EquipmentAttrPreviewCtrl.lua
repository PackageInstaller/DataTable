local EquipmentAttrPreviewCtrl = class("EquipmentAttrPreviewCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
EquipmentAttrPreviewCtrl._mapNodeConfig = {
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  btnCloseBg = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  txtWindowTitle = {sComponentName = "TMP_Text"},
  window = {},
  aniWindow = {sNodeName = "window", sComponentName = "Animator"},
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnSwitch = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Switch"
  },
  txtBtnSwitch = {sComponentName = "TMP_Text"},
  sv = {},
  rtAll = {sComponentName = "Transform"},
  Content = {sComponentName = "Transform"},
  goAttr = {},
  goPropertyP = {},
  ActionBar = {
    sCtrlName = "Game.UI.ActionBar.ActionBarCtrl"
  },
  btnShortcutClose = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Close"
  }
}
EquipmentAttrPreviewCtrl._mapEventConfig = {}

function EquipmentAttrPreviewCtrl:Open()
  self.nPage = 1
  self._mapNode.blur:SetActive(true)
  self:PlayInAni()
  self:Refresh()
end

function EquipmentAttrPreviewCtrl:Refresh()
  self._mapNode.sv:SetActive(self.nPage == 1)
  self._mapNode.rtAll.gameObject:SetActive(self.nPage == 2)
  if self.nPage == 1 then
    self:RefreshByEquipment()
    NovaAPI.SetTMPText(self._mapNode.txtWindowTitle, ConfigTable.GetUIText("Equipment_Title_EquipmentPreview"))
    NovaAPI.SetTMPText(self._mapNode.txtBtnSwitch, ConfigTable.GetUIText("Equipment_Title_AttrPreview"))
  else
    self:RefreshByAll()
    NovaAPI.SetTMPText(self._mapNode.txtWindowTitle, ConfigTable.GetUIText("Equipment_Title_AttrPreview"))
    NovaAPI.SetTMPText(self._mapNode.txtBtnSwitch, ConfigTable.GetUIText("Equipment_Title_EquipmentPreview"))
  end
end

function EquipmentAttrPreviewCtrl:RefreshByEquipment()
  if self.bInitedByEquipment then
    return
  end
  local mapSlotData
  if self.tbEquipment == nil then
    self.tbEquipment, mapSlotData = PlayerData.Equipment:GetEquipedGem(self.nCharId)
  end
  for k, v in ipairs(self.tbEquipment) do
    local goItemObj = instantiate(self._mapNode.goAttr, self._mapNode.Content)
    goItemObj:SetActive(true)
    local txtName = goItemObj.transform:Find("t_common_04/imgBg/txtName"):GetComponent("TMP_Text")
    local sRoman = mapSlotData and ConfigTable.GetUIText("RomanNumeral_" .. mapSlotData[k].nGemIndex) or ""
    local sName = orderedFormat(ConfigTable.GetUIText("Equipment_AttrPreviewName_" .. k), v.sName, sRoman)
    NovaAPI.SetTMPText(txtName, sName)
    for i = 1, 4 do
      local goAttr = goItemObj.transform:Find("rtBg/goProperty" .. i).gameObject
      local ctrlAttr = self:BindCtrlByNode(goAttr, "Game.UI.TemplateEx.TemplateRandomPropertyCtrl")
      ctrlAttr:SetProperty(v.tbAffix[i], self.nCharId, false, v.tbUpgradeCount[i])
    end
  end
  self.bInitedByEquipment = true
end

function EquipmentAttrPreviewCtrl:RefreshByAll()
  if self.bInitedByAll then
    return
  end
  if self.tbEquipment == nil then
    self.tbEquipment = PlayerData.Equipment:GetEquipedGem(self.nCharId)
  end
  local tbAllAffix = {}
  for _, v in ipairs(self.tbEquipment) do
    for k, nId in ipairs(v.tbAffix) do
      local nAddId = nId
      local mapCfg = ConfigTable.GetData("CharGemAttrValue", nId)
      if v.tbUpgradeCount[k] > 0 and mapCfg then
        nAddId = mapCfg.TypeId * 100 + v.tbUpgradeCount[k] + mapCfg.Level
      end
      table.insert(tbAllAffix, nAddId)
    end
  end
  local mapAttr_ATTR_FIX = {}
  local mapAttr_PLAYER_ATTR_FIX = {}
  local mapAttr_Skill = {}
  local mapAttr_Potential = {}
  for _, v in ipairs(tbAllAffix) do
    local mapCfg = ConfigTable.GetData("CharGemAttrValue", v)
    if mapCfg then
      local attrType = mapCfg.AttrType
      local attrSubType1 = mapCfg.AttrTypeFirstSubtype
      local attrSubType2 = mapCfg.AttrTypeSecondSubtype
      local nEffectDescId = self:GetEffectDescId(attrType, attrSubType1, attrSubType2)
      local mapAttributeDesc = ConfigTable.GetData("EffectDesc", nEffectDescId)
      if mapAttributeDesc then
        if attrType == GameEnum.CharGemEffectType.ATTR_FIX then
          if not mapAttr_ATTR_FIX[attrSubType1] then
            mapAttr_ATTR_FIX[attrSubType1] = {}
          end
          if not mapAttr_ATTR_FIX[attrSubType1][attrSubType2] then
            mapAttr_ATTR_FIX[attrSubType1][attrSubType2] = {
              mapAttributeDesc = mapAttributeDesc,
              nTag = mapCfg.Tag,
              nValue = 0
            }
          end
          mapAttr_ATTR_FIX[attrSubType1][attrSubType2].nValue = mapAttr_ATTR_FIX[attrSubType1][attrSubType2].nValue + tonumber(mapCfg.Value)
        elseif attrType == GameEnum.CharGemEffectType.PLAYER_ATTR_FIX then
          if not mapAttr_PLAYER_ATTR_FIX[attrSubType1] then
            mapAttr_PLAYER_ATTR_FIX[attrSubType1] = {}
          end
          if not mapAttr_PLAYER_ATTR_FIX[attrSubType1][attrSubType2] then
            mapAttr_PLAYER_ATTR_FIX[attrSubType1][attrSubType2] = {
              mapAttributeDesc = mapAttributeDesc,
              nTag = mapCfg.Tag,
              nValue = 0
            }
          end
          mapAttr_PLAYER_ATTR_FIX[attrSubType1][attrSubType2].nValue = mapAttr_PLAYER_ATTR_FIX[attrSubType1][attrSubType2].nValue + tonumber(mapCfg.Value)
        elseif attrType == GameEnum.CharGemEffectType.SkillLevel then
          if not mapAttr_Skill[attrSubType1] then
            mapAttr_Skill[attrSubType1] = {}
          end
          if not mapAttr_Skill[attrSubType1][attrSubType2] then
            mapAttr_Skill[attrSubType1][attrSubType2] = {
              mapAttributeDesc = mapAttributeDesc,
              nTag = mapCfg.Tag,
              nValue = 0
            }
          end
          mapAttr_Skill[attrSubType1][attrSubType2].nValue = mapAttr_Skill[attrSubType1][attrSubType2].nValue + tonumber(mapCfg.Value)
        elseif attrType == GameEnum.CharGemEffectType.Potential then
          if not mapAttr_Potential[attrSubType1] then
            mapAttr_Potential[attrSubType1] = {}
          end
          if not mapAttr_Potential[attrSubType1][attrSubType2] then
            mapAttr_Potential[attrSubType1][attrSubType2] = {
              mapAttributeDesc = mapAttributeDesc,
              nTag = mapCfg.Tag,
              nValue = 0
            }
          end
          mapAttr_Potential[attrSubType1][attrSubType2].nValue = mapAttr_Potential[attrSubType1][attrSubType2].nValue + tonumber(mapCfg.Value)
        end
      end
    end
  end
  
  local function create(mapAttributeDesc, nValue, nTag)
    local goItemObj = instantiate(self._mapNode.goPropertyP, self._mapNode.rtAll)
    goItemObj:SetActive(true)
    local txtTag = goItemObj.transform:Find("AnimRoot/txtTag"):GetComponent("TMP_Text")
    local txtProperty = goItemObj.transform:Find("AnimRoot/txtProperty"):GetComponent("TMP_Text")
    local txtPropertyValue = goItemObj.transform:Find("AnimRoot/txtPropertyValue"):GetComponent("TMP_Text")
    local link = goItemObj.transform:Find("AnimRoot/txtProperty"):GetComponent("TMPHyperLink")
    NovaAPI.SetTMPText(txtTag, ConfigTable.GetUIText("Equipment_AttrTag_" .. nTag))
    local sValue = ""
    sValue = self:_TransValueFormat(nValue, mapAttributeDesc.isPercent, mapAttributeDesc.Format, nTag ~= GameEnum.CharGemAttrTag.ATTR)
    NovaAPI.SetTMPText(txtProperty, UTILS.SubDesc(mapAttributeDesc.RandomAttrDesc, nil, nil, {
      nCharId = self.nCharId
    }))
    NovaAPI.SetTMPText(txtPropertyValue, sValue)
    local handler = ui_handler(self, function(_, goLink, sWordId)
      UTILS.ClickWordLink(goLink, sWordId, {
        nCharId = self.nCharId,
        nLevel = 1,
        nAddLv = tonumber(nValue)
      })
    end, link)
    link.onClick:AddListener(handler)
  end
  
  for _, v in ipairsSorted(mapAttr_ATTR_FIX) do
    for _, mapAttr in ipairsSorted(v) do
      create(mapAttr.mapAttributeDesc, mapAttr.nValue, mapAttr.nTag)
    end
  end
  for _, v in ipairsSorted(mapAttr_PLAYER_ATTR_FIX) do
    for _, mapAttr in ipairsSorted(v) do
      create(mapAttr.mapAttributeDesc, mapAttr.nValue, mapAttr.nTag)
    end
  end
  for _, v in ipairsSorted(mapAttr_Skill) do
    for _, mapAttr in ipairsSorted(v) do
      create(mapAttr.mapAttributeDesc, mapAttr.nValue, mapAttr.nTag)
    end
  end
  for _, v in ipairsSorted(mapAttr_Potential) do
    for _, mapAttr in ipairsSorted(v) do
      create(mapAttr.mapAttributeDesc, mapAttr.nValue, mapAttr.nTag)
    end
  end
  self.bInitedByAll = true
end

function EquipmentAttrPreviewCtrl:GetEffectDescId(attrType, attrSubType1, attrSubType2)
  return attrType * 10000 + attrSubType1 * 10 + attrSubType2
end

function EquipmentAttrPreviewCtrl:_TransValueFormat(nValue, bPercent, nFormat, bAdd)
  local sValue = ""
  if bAdd then
    sValue = orderedFormat(ConfigTable.GetUIText("Equipment_AttrDesc_PlusLevel"), nValue)
  else
    sValue = FormatEffectValue(nValue, bPercent, nFormat)
  end
  return sValue
end

function EquipmentAttrPreviewCtrl:PlayInAni()
  self._mapNode.window:SetActive(true)
  self._mapNode.aniWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function EquipmentAttrPreviewCtrl:PlayOutAni()
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.2, "Close", true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

function EquipmentAttrPreviewCtrl:Close()
  self._mapNode.window:SetActive(false)
  EventManager.Hit(EventId.ClosePanel, PanelId.EquipmentAttrPreview)
end

function EquipmentAttrPreviewCtrl:Awake()
  self._mapNode.window:SetActive(false)
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nCharId = tbParam[1]
    self.tbEquipment = tbParam[2]
  end
  self._mapNode.btnShortcutClose.gameObject:SetActive(GamepadUIManager.GetInputState())
  if GamepadUIManager.GetInputState() then
    local tbConfig = {
      {
        sAction = "Back",
        sLang = "ActionBar_Back"
      }
    }
    self._mapNode.ActionBar:InitActionBar(tbConfig)
  end
end

function EquipmentAttrPreviewCtrl:OnEnable()
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.EnableGamepadUI("EquipmentAttrPreviewCtrl", self:GetGamepadUINode(), nil, true)
  end
  self:Open()
end

function EquipmentAttrPreviewCtrl:OnDisable()
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.DisableGamepadUI("EquipmentAttrPreviewCtrl")
  end
end

function EquipmentAttrPreviewCtrl:OnDestroy()
end

function EquipmentAttrPreviewCtrl:OnBtnClick_Close()
  self:PlayOutAni()
end

function EquipmentAttrPreviewCtrl:OnBtnClick_Switch()
  self.nPage = 3 - self.nPage
  self:Refresh()
end

return EquipmentAttrPreviewCtrl
