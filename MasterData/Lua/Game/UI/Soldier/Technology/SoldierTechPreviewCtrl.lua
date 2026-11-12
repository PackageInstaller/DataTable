local SoldierAttrData = require("GameCore.Data.DataClass.Soldier.SoldierAttrData")
local SoldierTechPreviewCtrl = class("SoldierTechPreviewCtrl", BaseCtrl)
SoldierTechPreviewCtrl._mapNodeConfig = {
  goTechPreview = {},
  goBlur = {},
  aniWindow = {
    sNodeName = "goTechPreview",
    sComponentName = "Animator"
  },
  btnCloseBig = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtTechPreviewWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Tech_Preview_Title"
  },
  goEffectScroll = {},
  txtEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Tech_Preview_Empty"
  },
  goPropertyItem = {},
  goPropertyList = {},
  goTechDescItem = {},
  goTechDescList = {}
}
SoldierTechPreviewCtrl._mapEventConfig = {}
SoldierTechPreviewCtrl._mapRedDotConfig = {}

local function _FormatValue(nValue, bPercent)
  if bPercent then
    return tostring(clearFloat(nValue * 100)) .. "%"
  end
  return tostring(clearFloat(nValue))
end

local _tbAttrEffectMeta = {
  [GameEnum.SoldierClientEffect.AmendAttr] = {nOrder = 1, bForcePercent = false},
  [GameEnum.SoldierClientEffect.BaseAmendAttr] = {nOrder = 2, bForcePercent = false},
  [GameEnum.SoldierClientEffect.PercentAmendAttr] = {nOrder = 3, bForcePercent = true},
  [GameEnum.SoldierClientEffect.BasePercentAmendAttr] = {nOrder = 4, bForcePercent = true}
}

local function _DescOfAttr(sKey)
  local d = CacheTable.GetData("_AttributeDesc", sKey)
  if d == nil then
    return nil
  end
  return d.Icon, d.Desc, d.isPercent
end

local function _DescOfBattle(eType)
  local d = AllEnum.SoldierTechBattleEffect[eType]
  if d == nil then
    return nil
  end
  return d.sIcon, d.sLanguageId and ConfigTable.GetUIText(d.sLanguageId) or "", false
end

local function _CollectAttrItems(tbAttr)
  local tbList = {}
  if tbAttr == nil then
    return tbList
  end
  local tbShowAttrKey = SoldierAttrData.GetShowAttrKey()
  for eType, tbSub in pairs(tbAttr) do
    local meta = _tbAttrEffectMeta[eType]
    if meta ~= nil then
      for sKey, nValue in pairs(tbSub) do
        local nShowIndex = tbShowAttrKey[sKey]
        if nShowIndex ~= nil then
          local sIcon, sName, bDescPercent = _DescOfAttr(sKey)
          if sIcon ~= nil then
            if eType == GameEnum.SoldierClientEffect.PercentAmendAttr or eType == GameEnum.SoldierClientEffect.BasePercentAmendAttr then
              nValue = nValue / 100
            end
            table.insert(tbList, {
              sIcon = sIcon,
              sName = sName,
              sValue = _FormatValue(nValue, meta.bForcePercent or bDescPercent),
              nShowIndex = nShowIndex,
              nOrder = meta.nOrder
            })
          end
        end
      end
    end
  end
  table.sort(tbList, function(a, b)
    if a.nShowIndex ~= b.nShowIndex then
      return a.nShowIndex < b.nShowIndex
    end
    return a.nOrder < b.nOrder
  end)
  return tbList
end

local function _CollectBattleItems(tbBattleAttr)
  local tbList = {}
  if tbBattleAttr == nil then
    return tbList
  end
  for eType, nValue in pairs(tbBattleAttr) do
    local sIcon, sName = _DescOfBattle(eType)
    if sIcon ~= nil then
      table.insert(tbList, {
        sIcon = sIcon,
        sName = sName,
        sValue = _FormatValue(nValue, true),
        eType = eType
      })
    end
  end
  table.sort(tbList, function(a, b)
    return a.eType < b.eType
  end)
  return tbList
end

local function _BuildPropertyList(tbPreview)
  local tbList = {}
  if tbPreview == nil then
    return tbList
  end
  for _, v in ipairs(_CollectAttrItems(tbPreview.tbAttr)) do
    table.insert(tbList, v)
  end
  for _, v in ipairs(_CollectBattleItems(tbPreview.tbBattleAttr)) do
    table.insert(tbList, v)
  end
  return tbList
end

function SoldierTechPreviewCtrl:_ClearPropertyList()
  self._tbPropertyList = self._tbPropertyList or {}
  self._tbHidePropertyList = self._tbHidePropertyList or {}
  for _, ctrl in ipairs(self._tbPropertyList) do
    ctrl.gameObject:SetActive(false)
    table.insert(self._tbHidePropertyList, ctrl)
  end
  self._tbPropertyList = {}
end

function SoldierTechPreviewCtrl:_ClearTechDescList()
  self._tbTechDescList = self._tbTechDescList or {}
  self._tbHideTechDescList = self._tbHideTechDescList or {}
  for _, ctrl in ipairs(self._tbTechDescList) do
    ctrl.gameObject:SetActive(false)
    table.insert(self._tbHideTechDescList, ctrl)
  end
  self._tbTechDescList = {}
end

function SoldierTechPreviewCtrl:_AcquirePropertyItem()
  local nHide = #self._tbHidePropertyList
  if 0 < nHide then
    local ctrl = self._tbHidePropertyList[nHide]
    table.remove(self._tbHidePropertyList, nHide)
    ctrl.gameObject:SetActive(true)
    return ctrl
  end
  local goObj = instantiate(self._mapNode.goPropertyItem, self._mapNode.goPropertyList.transform)
  goObj:SetActive(true)
  return self:BindCtrlByNode(goObj, "Game.UI.Soldier.Technology.SoldierTechPreviewPropertyItemCtrl")
end

function SoldierTechPreviewCtrl:_AcquireTechDescItem()
  local nHide = #self._tbHideTechDescList
  if 0 < nHide then
    local ctrl = self._tbHideTechDescList[nHide]
    table.remove(self._tbHideTechDescList, nHide)
    ctrl.gameObject:SetActive(true)
    return ctrl
  end
  local goObj = instantiate(self._mapNode.goTechDescItem, self._mapNode.goTechDescList.transform)
  goObj:SetActive(true)
  return self:BindCtrlByNode(goObj, "Game.UI.Soldier.Technology.SoldierTechPreviewTechDescItemCtrl")
end

function SoldierTechPreviewCtrl:Refresh()
  local tbPreview = PlayerData.SoldierData:GetActiveNodePreview()
  local tbProperty = _BuildPropertyList(tbPreview)
  local tbCore = tbPreview and tbPreview.tbCore or {}
  self:_ClearPropertyList()
  self:_ClearTechDescList()
  for _, mapData in ipairs(tbProperty) do
    local ctrl = self:_AcquirePropertyItem()
    ctrl:Refresh(mapData.sIcon, mapData.sName, mapData.sValue)
    table.insert(self._tbPropertyList, ctrl)
  end
  for _, nId in ipairs(tbCore) do
    local ctrl = self:_AcquireTechDescItem()
    ctrl:Refresh(nId)
    table.insert(self._tbTechDescList, ctrl)
  end
  local bHasContent = 0 < #tbProperty or 0 < #tbCore
  self._mapNode.goEffectScroll:SetActive(bHasContent)
  self._mapNode.txtEmpty.gameObject:SetActive(not bHasContent)
end

function SoldierTechPreviewCtrl:PlayInAni()
  if self._mapNode.aniWindow ~= nil then
    self._mapNode.aniWindow:Play("t_window_04_t_in")
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function SoldierTechPreviewCtrl:PlayOutAni(callback)
  if self._mapNode.aniWindow ~= nil then
    self._mapNode.aniWindow:Play("t_window_04_t_out")
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, callback, true, true, true)
end

function SoldierTechPreviewCtrl:Close()
  local function callback()
    EventManager.Hit(EventId.ClosePanel, PanelId.SoldierTechPreviewPanel)
  end
  
  self:PlayOutAni(callback)
end

function SoldierTechPreviewCtrl:ClearCtrl()
  if self._tbPropertyList then
    for k, v in pairs(self._tbPropertyList) do
      self:UnbindCtrlByNode(v)
      self._tbPropertyList[k] = nil
    end
  end
  if self._tbHidePropertyList then
    for k, v in pairs(self._tbHidePropertyList) do
      self:UnbindCtrlByNode(v)
      self._tbHidePropertyList[k] = nil
    end
  end
  if self._tbTechDescList then
    for k, v in pairs(self._tbTechDescList) do
      self:UnbindCtrlByNode(v)
      self._tbTechDescList[k] = nil
    end
  end
  if self._tbHideTechDescList then
    for k, v in pairs(self._tbHideTechDescList) do
      self:UnbindCtrlByNode(v)
      self._tbHideTechDescList[k] = nil
    end
  end
  delChildren(self._mapNode.goPropertyList.transform)
  delChildren(self._mapNode.goTechDescList.transform)
end

function SoldierTechPreviewCtrl:Awake()
  self._tbPropertyList = {}
  self._tbHidePropertyList = {}
  self._tbTechDescList = {}
  self._tbHideTechDescList = {}
end

function SoldierTechPreviewCtrl:OnEnable()
  self._mapNode.goBlur:SetActive(false)
  self._mapNode.goTechPreview:SetActive(false)
  self._mapNode.goPropertyItem:SetActive(false)
  self._mapNode.goTechDescItem:SetActive(false)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goBlur:SetActive(true)
    self._mapNode.goTechPreview:SetActive(true)
    self:Refresh()
    self:PlayInAni()
  end
  
  cs_coroutine.start(wait)
end

function SoldierTechPreviewCtrl:OnDisable()
  self:ClearCtrl()
end

function SoldierTechPreviewCtrl:OnDestroy()
end

function SoldierTechPreviewCtrl:OnBtnClick_Close()
  self:Close()
end

return SoldierTechPreviewCtrl
