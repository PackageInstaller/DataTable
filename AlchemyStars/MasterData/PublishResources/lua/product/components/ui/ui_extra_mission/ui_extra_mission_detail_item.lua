_class("UIExtraMissionDetailItem", UICustomWidget)
UIExtraMissionDetailItem = UIExtraMissionDetailItem

function UIExtraMissionDetailItem:OnShow(uiParams)
  self._stageList = {}
  self._pageCount = 4
  self._module = self:GetModule(ExtMissionModule)
end

function UIExtraMissionDetailItem:GetComponents()
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._nameEn2 = self:GetUIComponent("UILocalizationText", "nameEn2")
  self._nameIdx = self:GetUIComponent("UILocalizationText", "nameIdx")
  self._state = self:GetGameObject("state")
  self._desc = self:GetUIComponent("UILocalizationText", "desc")
  self._pagePool = self:GetUIComponent("Transform", "pagePool")
  self._pageTab = {}
  for i = 1, self._pagePool.childCount do
    local go = self._pagePool:GetChild(self._pageCount - i).gameObject
    table.insert(self._pageTab, go)
  end
end

function UIExtraMissionDetailItem:SetData(index, id, callback)
  self:GetComponents()
  self._index = index
  self._id = id
  self._callback = callback
  self:OnValue()
end

function UIExtraMissionDetailItem:OnValue()
  self._cfg_ext = Cfg.cfg_extra_mission[self._id]
  if self._cfg_ext == nil then
    Log.fatal("###cfg_ext is nil ! id --> ", self._id)
  end
  local nameEn = StringTable.Get(self._cfg_ext.ExtMissionNameEn)
  local name = StringTable.Get(self._cfg_ext.ExtMissionName)
  local desc = StringTable.Get(self._cfg_ext.ExtMissionDes)
  local idx = StringTable.Get(self._cfg_ext.ExtMissionIdx) .. " " .. name
  self._name:SetText(name)
  self._nameEn2:SetText(nameEn)
  self._nameIdx:SetText(idx)
  self._desc:SetText(desc)
  local state = self._module:UI_GetExtMissionState(self._id)
  if state == EnumExtMissionState.Down then
    self._state:SetActive(true)
  else
    self._state:SetActive(false)
  end
  local cfg_misison = Cfg.cfg_extra_mission({})
  local iconTab = {}
  for i, v in HelperProxy:GetInstance():pairsByKeys(cfg_misison) do
    table.insert(iconTab, v)
  end
  local ext_c = table.count(cfg_misison)
  for i = 1, self._pageCount do
    if i <= ext_c then
      self._pageTab[i]:SetActive(true)
      local idx = (i - 1 + self._index) % ext_c
      if idx == 0 then
        idx = ext_c
      end
      local icon = iconTab[idx].ExtMissionSmallImg
      self._pageTab[i]:GetComponent("RawImageLoader"):LoadImage(icon)
    else
      self._pageTab[i]:SetActive(false)
    end
  end
end

function UIExtraMissionDetailItem:bgOnClick()
  if self._callback then
    self._callback(self._index)
  end
end
