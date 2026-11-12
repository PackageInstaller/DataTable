local OptionMultiSelect = class("OptionMultiSelect", BaseCtrl)
OptionMultiSelect._mapNodeConfig = {
  txtOptionTitle = {sComponentName = "TMP_Text"},
  svList = {
    sComponentName = "RectTransform"
  },
  btnReset = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reset"
  },
  ListItem = {}
}
OptionMultiSelect._mapEventConfig = {}

function OptionMultiSelect:Init(tbTextList, sTitle, callback)
  NovaAPI.SetTMPText(self._mapNode.txtOptionTitle, sTitle)
  self.callback = callback
  self.tbCurSelect = {}
  self.nItemCount = #tbTextList
  self:ClearGrids()
  for k, v in pairs(self.tbGo) do
    if k > self.nItemCount then
      v:SetActive(false)
    end
  end
  for i = 1, self.nItemCount do
    local item = self.tbGo[i]
    if item == nil then
      item = instantiate(self._mapNode.ListItem, self._mapNode.svList)
    end
    self.tbGo[i] = item
    item:SetActive(true)
    local ctrl = self:BindCtrlByNode(item, "Game.UI.Settings.OptionMultiSelectGrid")
    if ctrl ~= nil then
      ctrl:Init(tbTextList[i])
      local btn = item:GetComponent("UIButton")
      btn.onClick:RemoveAllListeners()
      btn.onClick:AddListener(function()
        self:OnGridClick(i)
      end)
      table.insert(self.tbItem, ctrl)
    end
  end
end

function OptionMultiSelect:OnGridClick(nBtnIndex)
  local nIndexOfThis = table.indexof(self.tbCurSelect, nBtnIndex)
  if 0 < nIndexOfThis then
    table.remove(self.tbCurSelect, nIndexOfThis)
    self.tbItem[nBtnIndex]:SetSelect(false, 0)
    for k, v in pairs(self.tbCurSelect) do
      self.tbItem[v]:SetSelect(true, k)
    end
  else
    table.insert(self.tbCurSelect, nBtnIndex)
    self.tbItem[nBtnIndex]:SetSelect(true, #self.tbCurSelect)
  end
  if self.callback ~= nil then
    self.callback(self.tbCurSelect)
  end
end

function OptionMultiSelect:SetSelect(tbSelect)
  self:Reset()
  self.tbCurSelect = tbSelect
  if self.tbItem ~= nil then
    for k, v in pairs(self.tbCurSelect) do
      self.tbItem[v]:SetSelect(true, k)
    end
  else
    self:Reset()
  end
end

function OptionMultiSelect:Reset()
  for i = 1, self.nItemCount do
    self.tbItem[i]:SetSelect(false, 0)
  end
  self.tbCurSelect = {}
end

function OptionMultiSelect:ClearGrids()
  if self.tbItem ~= nil then
    for i = #self.tbItem, 1, -1 do
      local item = self.tbItem[i].gameObject
      local btn = item:GetComponent("UIButton")
      btn.onClick:RemoveAllListeners()
      self:UnbindCtrlByNode(self.tbItem[i])
      table.remove(self.tbItem, i)
    end
  end
  self.tbItem = {}
end

function OptionMultiSelect:Awake()
  self.tbGo = {}
end

function OptionMultiSelect:OnEnable()
  self._mapNode.ListItem:SetActive(false)
end

function OptionMultiSelect:OnDisable()
  self:ClearGrids()
end

function OptionMultiSelect:OnDestroy()
  for k, v in pairs(self.tbGo) do
    destroy(v)
  end
  self.tbGo = {}
end

function OptionMultiSelect:OnBtnClick_Reset()
  self:Reset()
  if self.callback ~= nil then
    self.callback(self.tbCurSelect)
  end
end

return OptionMultiSelect
