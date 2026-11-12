local FilterPopupCtrl = class("FilterPopupCtrl", BaseCtrl)
local cellHeight = 88
local fixedColumnCount = 4
local gridPosY = -52.4
local gridLayoutSpaceY = 11
FilterPopupCtrl._mapNodeConfig = {
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  btnBlur = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  goRoot = {
    sNodeName = "---Detail---"
  },
  aniRoot = {
    sNodeName = "---Detail---",
    sComponentName = "Animator"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnReset = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reset"
  },
  labReset = {sComponentName = "TMP_Text", sLanguageId = "Reset"},
  btnConfirm = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  labConfirm = {sComponentName = "TMP_Text", sLanguageId = "Confirm"},
  sv = {
    sComponentName = "LoopScrollView"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharList_Filter_Title"
  }
}
FilterPopupCtrl._mapEventConfig = {}

function FilterPopupCtrl:Awake()
end

function FilterPopupCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  self.tbOption = tbParam[1]
  self.mapGridCtrl = {}
  self._mapNode.blur:SetActive(true)
  self:Open()
end

function FilterPopupCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.mapGridCtrl or {}) do
    self:UnbindCtrlByNode(objCtrl)
    self.mapGridCtrl[nInstanceId] = nil
  end
end

function FilterPopupCtrl:Open()
  self:PlayInAni()
  self:RefreshView()
end

function FilterPopupCtrl:RefreshView()
  self.tbGridHeight = {}
  local nCurCount = #self.tbOption
  if 0 < nCurCount then
    for k, optionType in ipairs(self.tbOption) do
      local items = AllEnum.ChooseOptionCfg[optionType].items
      local count = table.nums(items) + 1
      local height = math.abs(gridPosY) + math.ceil(count / fixedColumnCount) * (cellHeight + gridLayoutSpaceY) + 20
      self.tbGridHeight[k] = height
    end
    self._mapNode.sv:InitEx(self.tbGridHeight, self, self.OnGridRefresh, nil, true)
  else
    self._mapNode.sv.gameObject:SetActive(false)
  end
end

function FilterPopupCtrl:OnGridRefresh(goGrid, gridIndex)
  local index = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  local objCtrl = self.mapGridCtrl[nInstanceId]
  if objCtrl == nil then
    objCtrl = self:BindCtrlByNode(goGrid, "Game.UI.Filter.FilterItemCtrl")
    self.mapGridCtrl[nInstanceId] = objCtrl
  end
  objCtrl:Refresh(self.tbOption[index])
  objCtrl:ShowLine(index ~= 1)
end

function FilterPopupCtrl:PlayInAni()
  self._mapNode.goRoot:SetActive(true)
  self._mapNode.aniRoot:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function FilterPopupCtrl:PlayOutAni()
  self._mapNode.aniRoot:Play("t_window_04_t_out")
end

function FilterPopupCtrl:OnBtnClick_Reset()
  PlayerData.Filter:Reset(self.tbOption)
  self:RefreshView()
end

function FilterPopupCtrl:OnBtnClick_Confirm()
  PlayerData.Filter:SyncFilterByCache()
  EventManager.Hit(EventId.FilterConfirm)
  EventManager.Hit(EventId.ClosePanel, PanelId.FilterPopupPanel)
end

function FilterPopupCtrl:OnBtnClick_Close()
  PlayerData.Filter:SyncFilterByCache()
  EventManager.Hit(EventId.FilterConfirm)
  self:PlayOutAni()
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.2, function()
    self._mapNode.blur:SetActive(false)
    self._mapNode.goRoot:SetActive(false)
    EventManager.Hit(EventId.ClosePanel, PanelId.FilterPopupPanel)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
end

return FilterPopupCtrl
