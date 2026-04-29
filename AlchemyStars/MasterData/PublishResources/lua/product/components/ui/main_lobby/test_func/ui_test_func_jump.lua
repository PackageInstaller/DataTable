_class("UITestFuncJump", UICustomWidget)
UITestFuncJump = UITestFuncJump

function UITestFuncJump:OnShow(uiParams)
  self._root = self:GetGameObject("_root")
  self._jumpIdText = self:GetUIComponent("UILocalizationText", "_jumpIdText")
  self._jumpParam1Text = self:GetUIComponent("UILocalizationText", "_jumpParam1Text")
  self._jumpParam2Text = self:GetUIComponent("UILocalizationText", "_jumpParam2Text")
end

function UITestFuncJump:OnHide()
end

function UITestFuncJump:ExitBtnOnClick()
  self._root:SetActive(false)
end

function UITestFuncJump:CheckBtnOnClick()
  local idText = self._jumpIdText.text
  local id = idText and tonumber(idText)
  local p1Text = self._jumpParam1Text.text
  local p2Text = self._jumpParam2Text.text
  local param1 = p1Text and tonumber(p1Text)
  local param2 = p2Text and tonumber(p2Text)
  local params = {param1, param2}
  if not id then
    ToastManager.ShowToast("Jump ID is nil")
    return
  end
  local questModule = GameGlobal.GetModule(QuestModule)
  local jumpModule = questModule.uiModule
  if jumpModule == nil then
    Log.fatal("[quest] error --> uiModule is nil ! --> jumpModule")
    return
  end
  local fromParam = {}
  table.insert(fromParam, QuestType.QT_Daily)
  jumpModule:SetFromUIData(FromUIType.NormalUI, "UIQuestController", UIStateType.UIMain, fromParam)
  local jumpType = id
  local jumpParams = params
  jumpModule:SetJumpUIData(jumpType, jumpParams)
  jumpModule:Jump()
end
