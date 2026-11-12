local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local FilterItemCtrl = class("FilterItemCtrl", BaseCtrl)
local typeof = _ENV.typeof
FilterItemCtrl._mapNodeConfig = {
  img_line = {},
  lab_title = {sComponentName = "TMP_Text"},
  Grid = {
    sComponentName = "RectTransform"
  }
}
FilterItemCtrl._mapEventConfig = {}
local ResTypeAny = GameResourceLoader.ResType.Any
local sPrefabPath = "UI/Filter/FilterSubItem.prefab"

function FilterItemCtrl:Awake()
  self.tbCtrlObj = {}
  self.objList = {}
end

function FilterItemCtrl:OnEnable()
end

function FilterItemCtrl:OnDisable()
end

function FilterItemCtrl:OnDestroy()
  self:ResetView()
end

function FilterItemCtrl:ResetView()
  for nInstanceId, objCtrl in pairs(self.tbCtrlObj or {}) do
    self:UnbindCtrlByNode(objCtrl)
  end
  self.tbCtrlObj = {}
  for i, v in ipairs(self.objList or {}) do
    destroy(v)
  end
  self.objList = {}
end

function FilterItemCtrl:Refresh(optionType)
  self:ResetView()
  NovaAPI.SetTMPText(self._mapNode.lab_title, ConfigTable.GetUIText(AllEnum.ChooseOptionCfg[optionType].sLanguage))
  self.indexList = {}
  local items = AllEnum.ChooseOptionCfg[optionType].items
  local tbSortList = {}
  table.insert(tbSortList, {
    key = "All",
    value = {sLanguage = "Filter_All"}
  })
  for attrKey, v in pairs(items) do
    table.insert(tbSortList, {key = attrKey, value = v})
  end
  table.sort(tbSortList, function(a, b)
    if a.value.nSort == nil then
      a.value.nSort = 0
    end
    if b.value.nSort == nil then
      b.value.nSort = 0
    end
    return a.value.nSort < b.value.nSort
  end)
  for _, v in pairs(tbSortList) do
    table.insert(self.indexList, v.key)
  end
  for i, optionItemType in ipairs(self.indexList) do
    local goObj = self:CreatePrefabInstance(sPrefabPath, self._mapNode.Grid)
    table.insert(self.objList, goObj)
    local nInstanceId = goObj:GetInstanceID()
    local ctrl = self:BindCtrlByNode(goObj, "Game.UI.Filter.FilterSubItemCtrl")
    ctrl:Refresh(optionType, optionItemType, self)
    self.tbCtrlObj[nInstanceId] = ctrl
    if optionItemType == "All" then
      self.btnAllCtrl = ctrl
    end
  end
  self:CheckSelectionState()
end

function FilterItemCtrl:ShowLine(active)
  self._mapNode.img_line:SetActive(active)
end

function FilterItemCtrl:CheckSelectionState()
  local bAllSelected = true
  local firstValue
  for nInsId, ctrl in pairs(self.tbCtrlObj) do
    if ctrl.sKey ~= "All" then
      if firstValue == nil then
        firstValue = ctrl.choose
      elseif ctrl.choose ~= firstValue then
        bAllSelected = false
        break
      end
    end
  end
  if bAllSelected then
    for nInsId, ctrl in pairs(self.tbCtrlObj) do
      ctrl:SetBtnState(ctrl.sKey == "All")
    end
  else
    self.btnAllCtrl:SetBtnState(false)
  end
end

function FilterItemCtrl:OnBtnClick_All()
  if self.btnAllCtrl.choose then
    return
  end
  for nInsId, ctrl in pairs(self.tbCtrlObj) do
    ctrl:SetBtnState(ctrl.sKey == "All")
  end
end

return FilterItemCtrl
