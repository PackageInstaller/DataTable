local UISettingDescribe = class("UISettingDescribe", UIBaseWindow)
local base = UIBaseWindow
local UINSettingDescribeTogItem = require("Game.Setting.UI.UINSettingDescribeTogItem")

function UISettingDescribe:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnConfirmClicked)
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Setting, true)
  self.isOn = false
  self.onToggleValueCallback = BindCallback(self, self.OnToggleValueCallback)
end

function UISettingDescribe:InitSettingDescribe(onConfirmCallback)
  self.onConfirmCallback = onConfirmCallback
  local skillID = 100503
  local showDetailDescList = {false, true}
  self:InitSkillToggleItem(skillID, showDetailDescList)
end

function UISettingDescribe:InitSkillToggleItem(skillID, showDetailDescList)
  local isInit = true
  for index, go in ipairs(self.ui.togGoList) do
    local item = UINSettingDescribeTogItem.New()
    item:Init(go)
    item:InitSettingDescribeItem(index, skillID, showDetailDescList[index], self.onToggleValueCallback)
    if isInit then
      item:SetIsON()
      isInit = false
    end
  end
end

function UISettingDescribe:OnToggleValueCallback(index, value)
  if self.selIndex == index then
    return
  end
  self.selIndex = index
  if index == 2 and value then
    self.isOn = true
  end
  if index == 1 and value then
    self.isOn = false
  end
end

function UISettingDescribe:OnConfirmClicked()
  self:SetDetailDescribe()
  self:Delete()
  if self.onConfirmCallback ~= nil then
    self.onConfirmCallback()
  end
end

function UISettingDescribe:SetDetailDescribe()
  for i, id in ipairs(ConfigData.game_set_group[eGameSetType.detail].order) do
    self.ctrl:SetShowDetailDescribe(id, self.isOn)
  end
end

function UISettingDescribe:OnDelete()
  PersistentManager:SaveModelData(PersistentConfig.ePackage.SystemData)
  self.ctrl:TryReqSaveGameSettingData()
  self.ctrl = nil
  base.OnDelete(self)
end

return UISettingDescribe
