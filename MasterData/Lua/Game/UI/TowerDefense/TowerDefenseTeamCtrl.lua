local TowerDefenseTeamCtrl = class("TowerDefenseTeamCtrl", BaseCtrl)
TowerDefenseTeamCtrl._mapNodeConfig = {
  btnBack = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btn_go = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  txt_go = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Go"
  },
  txt_sv_char_title = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_TeamEditor_Char"
  },
  char_teamContent = {
    sComponentName = "RectTransform"
  },
  char_cell = {},
  txt_sv_item_title = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_TeamEditor_Item"
  },
  item_teamContent = {
    sComponentName = "RectTransform"
  },
  item_cell = {},
  txt_guide = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Guide"
  },
  btn_Guide = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Guide"
  },
  blur = {},
  guidPanel = {
    sNodeName = "TowerDefenseGuidePanel",
    sCtrlName = "Game.UI.TowerDefense.TowerDefenseGuideCtrl"
  }
}
TowerDefenseTeamCtrl._mapEventConfig = {
  CloseTowerDefenseGuidePanel = "OnEvent_CloseTowerDefenseGuidePanel"
}
TowerDefenseTeamCtrl._mapRedDotConfig = {}

function TowerDefenseTeamCtrl:Awake()
  self._mapNode.blur:SetActive(false)
  self._mapNode.guidPanel.gameObject:SetActive(false)
  self.tbGridCtrl = {}
end

function TowerDefenseTeamCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
  delChildren(self._mapNode.char_teamContent.transform)
  delChildren(self._mapNode.item_teamContent.transform)
end

function TowerDefenseTeamCtrl:SetData(nActId, nLevelId, tbChracter, nItemId)
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
  self.nActId = nActId
  self.tbSelectedCharGuideIds = tbChracter
  self.nSelectedItemId = nItemId
  self.nLevelId = nLevelId
  self.TowerDefenseData = PlayerData.Activity:GetActivityDataById(self.nActId)
  self.levelConfig = ConfigTable.GetData("TowerDefenseLevel", self.nLevelId)
  local floorConfig = ConfigTable.GetData("TowerDefenseFloor", self.levelConfig.FloorId)
  self.nTeamMaxCharacter = floorConfig.MemberNum
  self.tbCharGuideIds = {}
  self.tbItemIds = {}
  
  local function forEachFunction(config)
    if config.ActivityId == nActId and config.IsShow == true and self.TowerDefenseData:IsLevelUnlock(config.LevelId) and self.TowerDefenseData:IsPreLevelPass(config.LevelId) then
      if config.GuideType == GameEnum.TowerDefGuideType.Character then
        if #floorConfig.CharPoolGroup == 0 then
          table.insert(self.tbCharGuideIds, config.Id)
        elseif 0 < table.indexof(floorConfig.CharPoolGroup, config.ObjectId) then
          table.insert(self.tbCharGuideIds, config.Id)
        end
      elseif config.GuideType == GameEnum.TowerDefGuideType.Item then
        table.insert(self.tbItemIds, config.Id)
      end
    end
  end
  
  ForEachTableLine(DataTable.TowerDefenseGuide, forEachFunction)
  
  local function sortFunction(a, b)
    local config_a = ConfigTable.GetData("TowerDefenseGuide", a)
    local config_b = ConfigTable.GetData("TowerDefenseGuide", b)
    local bUnlock_a = self.TowerDefenseData:IsLevelUnlock(config_a.LevelId) and self.TowerDefenseData:IsPreLevelPass(config_a.LevelId)
    local bUnlock_b = self.TowerDefenseData:IsLevelUnlock(config_b.LevelId) and self.TowerDefenseData:IsPreLevelPass(config_b.LevelId)
    if bUnlock_a and not bUnlock_b then
      return true
    elseif bUnlock_b and not bUnlock_a then
      return false
    else
      return a < b
    end
  end
  
  table.sort(self.tbCharGuideIds, sortFunction)
  table.sort(self.tbItemIds, sortFunction)
  self:CreateChar()
  self:CreateItem()
end

function TowerDefenseTeamCtrl:CreateChar()
  delChildren(self._mapNode.char_teamContent.transform)
  for i = 1, #self.tbCharGuideIds do
    local go = instantiate(self._mapNode.char_cell, self._mapNode.char_teamContent.transform)
    local index = i
    local nInstanceId = go:GetInstanceID()
    if not self.tbGridCtrl[nInstanceId] then
      self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(go, "Game.UI.TowerDefense.TowerDefenseTeamCharCtrl")
    end
    local charIndex = table.indexof(self.tbSelectedCharGuideIds, self.tbCharGuideIds[index])
    self.tbGridCtrl[nInstanceId]:SetData(self.tbCharGuideIds[index], charIndex)
    local btn = go:GetComponent("UIButton")
    btn.onClick:AddListener(function()
      self:OnCharacterGridBtnClick(index)
    end)
    go:SetActive(true)
  end
end

function TowerDefenseTeamCtrl:CreateItem()
  delChildren(self._mapNode.item_teamContent.transform)
  for i = 1, #self.tbItemIds do
    local go = instantiate(self._mapNode.item_cell, self._mapNode.item_teamContent.transform)
    local nIndex = i
    local icon = go.transform:Find("AnimRoot/img_icon")
    local guideConfig = ConfigTable.GetData("TowerDefenseGuide", self.tbItemIds[nIndex])
    if guideConfig == nil then
      return
    end
    local itemConfig = ConfigTable.GetData("TowerDefenseItem", guideConfig.ObjectId)
    if itemConfig == nil then
      return
    end
    if itemConfig.CardIcon ~= "" then
      self:SetPngSprite(icon.gameObject:GetComponent("Image"), itemConfig.CardIcon)
    end
    local selected = go.transform:Find("AnimRoot/go_select")
    selected.gameObject:SetActive(self.nItemId == self.tbItemIds[nIndex])
    local go_selectMask = go.transform:Find("AnimRoot/go_selectMask")
    go_selectMask.gameObject:SetActive(self.nItemId == self.tbItemIds[nIndex])
    local selected_tips = go.transform:Find("AnimRoot/selected_tips")
    selected_tips.gameObject:SetActive(self.nItemId == self.tbItemIds[nIndex])
    local txt_selected = go.transform:Find("AnimRoot/selected_tips/txt_selected")
    NovaAPI:SetTMPText(txt_selected:GetComponent("TMP_Text"), ConfigTable.GetUIText("TowerDef_TeamEditor_Selected"))
    local btn = go:GetComponent("UIButton")
    btn.onClick:AddListener(function()
      self:OnItemGridBtnClick(go, nIndex)
    end)
    go:SetActive(true)
  end
end

function TowerDefenseTeamCtrl:UpdateSelectedChar(tbCharGuideIds)
  self.tbSelectedCharGuideIds = tbCharGuideIds
  EventManager.Hit("TowerDefense_CharUpdate", self.tbSelectedCharGuideIds)
end

function TowerDefenseTeamCtrl:OnCharacterGridBtnClick(nIndex)
  local charIndex = table.indexof(self.tbSelectedCharGuideIds, self.tbCharGuideIds[nIndex])
  if 0 < charIndex then
    table.remove(self.tbSelectedCharGuideIds, charIndex)
    EventManager.Hit("TowerDefense_CharUpdate", self.tbSelectedCharGuideIds)
  elseif #self.tbSelectedCharGuideIds >= self.nTeamMaxCharacter then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("TowerDef_TeamEditor_CharTip"))
  else
    table.insert(self.tbSelectedCharGuideIds, self.tbCharGuideIds[nIndex])
    EventManager.Hit("TowerDefense_CharUpdate", self.tbSelectedCharGuideIds)
  end
end

function TowerDefenseTeamCtrl:OnItemGridBtnClick(goGrid, nIndex)
  local selectItemId = self.tbItemIds[nIndex]
  if self.nSelectedItemId == selectItemId then
    local selected = goGrid.transform:Find("btn_grid/AnimRoot/selected")
    selected.gameObject:SetActive(false)
    local go_selectMask = goGrid.transform:Find("btn_grid/AnimRoot/go_selectMask")
    go_selectMask.gameObject:SetActive(false)
    self.nSelectedItemId = 0
    EventManager.Hit("TowerDefense_ItemUpdate", self.nSelectedItemId)
  elseif self.nSelectedItemId ~= nil and self.nSelectedItemId ~= 0 then
    local selected = goGrid.transform:Find("btn_grid/AnimRoot/go_select")
    selected.gameObject:SetActive(true)
    local go_selectMask = goGrid.transform:Find("btn_grid/AnimRoot/go_selectMask")
    go_selectMask.gameObject:SetActive(true)
    self.nSelectedItemId = self.tbItemIds[nIndex]
    EventManager.Hit("TowerDefense_ItemUpdate", self.nSelectedItemId)
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("TowerDef_TeamEditor_ItemTip"))
  end
end

function TowerDefenseTeamCtrl:OnBtnClick_Close()
  EventManager.Hit("TowerDefenseTeamPanelClose")
end

function TowerDefenseTeamCtrl:OnBtnClick_Go()
  EventManager.Hit("TowerDefenseTeamPanelConfirm")
end

function TowerDefenseTeamCtrl:OnBtnClick_Guide()
  self._mapNode.blur.gameObject:SetActive(true)
  self._mapNode.guidPanel.gameObject:SetActive(true)
  self._mapNode.guidPanel:SetData(self.nActId, self.tbSelectedCharGuideIds)
end

function TowerDefenseTeamCtrl:OnEvent_CloseTowerDefenseGuidePanel()
  self._mapNode.guidPanel.gameObject:SetActive(false)
  self._mapNode.blur.gameObject:SetActive(false)
end

return TowerDefenseTeamCtrl
