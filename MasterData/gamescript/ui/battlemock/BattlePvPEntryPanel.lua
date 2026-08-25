local AWAKER_MAX_NUM = 4
local SKILL_MAX_NUM = 4
local POTENCY_MAX_NUM = 4
local AWAKER_TEXT_PRE_NAME = "Role_ID"
local SKILL_TEXT_PRE_NAME = "Skill_ID"
local POTENCY_TEXT_PRE_NAME = "Enlightenment_ID"
local BattlePvPEntryPanel, Super = System.NewClass("BattlePvPEntryPanel", UIBasePanel)
BattlePvPEntryPanel.uiResCls = Panel_Gm_PVPResource

function BattlePvPEntryPanel:ctor()
  Super.ctor(self)
end

function BattlePvPEntryPanel:OnBind(binder)
  binder:BindButtonClick(self.ui.Btn_Confirm, System.fn(self, self.OnClickConfirm))
  binder:BindButtonClick(self.ui.Btn_Cancel, System.fn(self, self.OnClickCancel))
  binder:BindToText(self.ui.Text_Title, function()
    return "PVP战斗模拟器"
  end)
  binder:BindToText(self.ui.Text_Role, function()
    return "选择唤醒体"
  end)
  binder:BindToText(self.ui.Text_Skill, function()
    return "选择主角技能"
  end)
  binder:BindToText(self.ui.Text_Enlightenment, function()
    return "选择启灵"
  end)
  binder:BindToText(self.ui.Text_Cancel, function()
    return "取消"
  end)
  binder:BindToText(self.ui.Text_Confirm, function()
    return "确认"
  end)
  for i = 1, AWAKER_MAX_NUM do
    local uiName = AWAKER_TEXT_PRE_NAME .. i
    binder:BindButtonClick(self.ui[uiName], System.bind(self.OnClickAwaker, self, i))
    binder:BindToText(self:GetTextObj(uiName).Text_Title, function()
      return "唤醒体" .. i .. ": "
    end)
  end
  for i = 1, SKILL_MAX_NUM do
    local uiName = SKILL_TEXT_PRE_NAME .. i
    binder:BindButtonClick(self.ui[uiName], System.bind(self.OnClickSkill, self, i))
    binder:BindToText(self:GetTextObj(uiName).Text_Title, function()
      return "主角技能" .. i .. ": "
    end)
  end
  for i = 1, POTENCY_MAX_NUM do
    local uiName = POTENCY_TEXT_PRE_NAME .. i
    binder:BindButtonClick(self.ui[uiName], System.bind(self.OnClickPotency, self, i))
    binder:BindToText(self:GetTextObj(uiName).Text_Title, function()
      return "启灵" .. i .. ": "
    end)
  end
  self:ReadLocalFile()
end

function BattlePvPEntryPanel:ReadLocalFile()
  for i = 1, AWAKER_MAX_NUM do
    self:ReadTextFromLoclFileByUiName(AWAKER_TEXT_PRE_NAME .. i)
  end
  for i = 1, SKILL_MAX_NUM do
    self:ReadTextFromLoclFileByUiName(SKILL_TEXT_PRE_NAME .. i)
  end
  for i = 1, POTENCY_MAX_NUM do
    self:ReadTextFromLoclFileByUiName(POTENCY_TEXT_PRE_NAME .. i)
  end
end

function BattlePvPEntryPanel:SaveLocalFile()
  for i = 1, AWAKER_MAX_NUM do
    self:SaveTextFromLoclFileByUiName(AWAKER_TEXT_PRE_NAME .. i)
  end
  for i = 1, SKILL_MAX_NUM do
    self:SaveTextFromLoclFileByUiName(SKILL_TEXT_PRE_NAME .. i)
  end
  for i = 1, POTENCY_MAX_NUM do
    self:SaveTextFromLoclFileByUiName(POTENCY_TEXT_PRE_NAME .. i)
  end
  MobileFileDataManager.Instance:OnSaveCommInfo()
end

function BattlePvPEntryPanel:GetTextObj(objName)
  do return Item_Gm_Battle_Art_Entry_InputFieldResource end
  return Item_Gm_Battle_Art_Entry_InputFieldResource, self.ui[objName]
end

function BattlePvPEntryPanel:ReadTextFromLoclFileByUiName(uiName)
  local key = "PvPMock_" .. uiName
  local saveValue = MobileFileDataManager.Instance:GetCommFileValue(key)
  if saveValue then
    self.binder:SetText(self:GetTextObj(uiName).Text_Input, saveValue)
  end
end

function BattlePvPEntryPanel:SaveTextFromLoclFileByUiName(uiName)
  local key = "PvPMock_" .. uiName
  local writeValue = self.binder:GetTextComp(self:GetTextObj(uiName).Text_Input).text or ""
  MobileFileDataManager.Instance:SetCommFileValue(key, writeValue)
end

function BattlePvPEntryPanel:OnClickAwaker(idx)
  local list = {}
  table.insert(list, {id = 0, text = "清除"})
  for _, info in pairs(DT.AwakerConfig) do
    local schoolName = LT.Text(DT.SchoolConfig[info.School].Name)
    local title = LT.Text(info.Title)
    local name = LT.Text(info.Name)
    table.insert(list, {
      id = info.ID,
      text = string.format("%s-%s-%s-%s-%s", info.ID, schoolName, title or "", name, info.CnID)
    })
  end
  self:OnOpenSimpleListPanel(list, self:GetTextObj(AWAKER_TEXT_PRE_NAME .. idx))
end

function BattlePvPEntryPanel:OnClickSkill(idx)
  local list = {}
  table.insert(list, {id = 0, text = "清除"})
  for _, info in pairs(DT.PVPSkill) do
    local name = LT.Text(info.Name)
    table.insert(list, {
      id = info.ID,
      text = string.format("%s-%s-%s", info.ID, name, info.CnID)
    })
  end
  self:OnOpenSimpleListPanel(list, self:GetTextObj(SKILL_TEXT_PRE_NAME .. idx))
end

function BattlePvPEntryPanel:OnClickPotency(idx)
  local list = {}
  table.insert(list, {id = 0, text = "清除"})
  for _, info in pairs(DT.Item) do
    if info.Type == "Weapon" then
      table.insert(list, {
        id = info.ID,
        text = string.format("%s-%s-%s", info.ID, info.Name, info.CnID)
      })
    end
  end
  self:OnOpenSimpleListPanel(list, self:GetTextObj(POTENCY_TEXT_PRE_NAME .. idx))
end

function BattlePvPEntryPanel:OnOpenSimpleListPanel(list, textObj)
  UIManager.Instance:Reopen(Urls.SimpleListView, list, function(data)
    UIManager.Instance:CloseByUrl(Urls.SimpleListView)
    if data.text ~= "清除" then
      self.binder:SetText(textObj.Text_Input, data.text)
    else
      self.binder:SetText(textObj.Text_Input, "")
    end
  end, true)
end

function BattlePvPEntryPanel:OnClickConfirm()
  self:OnClose()
end

function BattlePvPEntryPanel:OnClickCancel()
  self:OnClose()
end

function BattlePvPEntryPanel:OnClose()
  self:SaveLocalFile()
  self:Close()
end

return BattlePvPEntryPanel
