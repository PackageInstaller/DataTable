local ActionBarCtrl = class("ActionBarCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
ActionBarCtrl._mapNodeConfig = {
  rtContent = {sComponentName = "Transform"},
  goAction = {}
}
ActionBarCtrl._mapEventConfig = {
  GamepadUIChange = "OnEvent_GamepadUIChange"
}

function ActionBarCtrl:InitActionBar(tbConfig)
  if self.tbConfig and #tbConfig == #self.tbConfig then
    local bAllSame = true
    for i, v in ipairs(tbConfig) do
      if v.sAction ~= self.tbConfig[i].sAction then
        bAllSame = false
        break
      end
    end
    if bAllSame then
      return
    end
  end
  self.tbActionObj = {}
  self.tbActionImg = {}
  self.tbConfig = tbConfig
  delChildren(self._mapNode.rtContent)
  for _, v in pairs(tbConfig) do
    local goAction = instantiate(self._mapNode.goAction, self._mapNode.rtContent)
    goAction:SetActive(true)
    local imgAction = goAction.transform:Find("imgAction"):GetComponent("Image")
    local imgAction2 = goAction.transform:Find("imgAction2"):GetComponent("Image")
    local txtAction = goAction.transform:Find("txtAction"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(txtAction, ConfigTable.GetUIText(v.sLang))
    self.tbActionObj[v.sAction] = goAction
    self.tbActionImg[v.sAction] = imgAction
    if v.sAction2 then
      imgAction2.gameObject:SetActive(true)
      self.tbActionObj[v.sAction2] = goAction
      self.tbActionImg[v.sAction2] = imgAction2
    end
  end
  self:RefreshActionImage()
end

function ActionBarCtrl:ClearActionBar()
  self.tbActionObj = {}
  self.tbActionImg = {}
  self.tbConfig = nil
  delChildren(self._mapNode.rtContent)
end

function ActionBarCtrl:RefreshActionImage()
  local nUIType = GamepadUIManager.GetCurUIType()
  if nUIType == AllEnum.GamepadUIType.Other then
    self.gameObject:SetActive(false)
    return
  end
  self.gameObject:SetActive(true)
  for sAction, imgAction in pairs(self.tbActionImg) do
    local sIcon
    if nUIType == AllEnum.GamepadUIType.PS then
      sIcon = ConfigTable.GetField("GamepadAction", sAction, "PlayStationIcon")
    elseif nUIType == AllEnum.GamepadUIType.Xbox then
      sIcon = ConfigTable.GetField("GamepadAction", sAction, "XboxIcon")
    elseif nUIType == AllEnum.GamepadUIType.Keyboard or nUIType == AllEnum.GamepadUIType.Mouse then
      sIcon = ConfigTable.GetField("GamepadAction", sAction, "KeyboardIcon")
    end
    if sIcon == nil or sIcon == "" then
      self.tbActionObj[sAction]:SetActive(false)
    else
      self.tbActionObj[sAction]:SetActive(true)
      self:SetPngSprite(imgAction, sIcon)
      NovaAPI.SetImageNativeSize(imgAction)
    end
  end
end

function ActionBarCtrl:OnEvent_GamepadUIChange(sName, nBeforeType, nAfterType)
  if not self.tbActionImg then
    return
  end
  self:RefreshActionImage()
end

return ActionBarCtrl
