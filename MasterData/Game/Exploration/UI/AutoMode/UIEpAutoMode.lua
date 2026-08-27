local UIEpAutoMode = class("UIEpAutoMode", UIBaseWindow)
local base = UIBaseWindow
local UINEpAutoOperator = require("Game.Exploration.UI.AutoMode.UINEpAutoOperator")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function UIEpAutoMode:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_AutoMask, self, self.OnBtnAutoMaskClicked)
  self.ui.autoOperator:SetActive(false)
  self.ui.tex_Auto:SetIndex(0)
end

function UIEpAutoMode:SetAutoTitleActive(active)
  self.ui.autoTitle:SetActive(active)
end

function UIEpAutoMode:SetAutoOperatorActive(active, bindParent)
  if active then
    self.autoOperatorNode = UINEpAutoOperator.New()
    local operatorObject = self.ui.autoOperator:Instantiate(bindParent)
    operatorObject:SetActive(true)
    self.autoOperatorNode:Init(operatorObject)
    self.autoOperatorNode.transform.localPosition = Vector3.zero
    self.autoOperatorNode:BindAutoParent(bindParent)
  else
    if self.autoOperatorNode ~= nil and not IsNull(self.autoOperatorNode.gameObject) then
      self.autoOperatorNode:Delete()
    end
    self.autoOperatorNode = nil
  end
end

function UIEpAutoMode:SetAutoOperatorText(second)
  if self.autoOperatorNode ~= nil then
    if not IsNull(self.autoOperatorNode.gameObject) then
      self.autoOperatorNode:UpdateAutoOperatorText(second)
    else
      self.autoOperatorNode = nil
    end
  end
end

function UIEpAutoMode:SetAutoTitleState(tileType, second)
  if tileType == ExplorationEnum.eAutoTitleType.Normal then
    self.ui.tex_Auto:SetIndex(ExplorationEnum.eAutoTitleType.Normal)
  else
    self.ui.tex_Auto:SetIndex(tileType, tostring(second or 0))
  end
end

function UIEpAutoMode:SetAutoMaskActive(active)
  self.ui.btn_AutoMask.gameObject:SetActive(active)
end

function UIEpAutoMode:SetAutoMaskClickFunc(func)
  self.__maskClickFunc = func
end

function UIEpAutoMode:OnBtnAutoMaskClicked()
  if self.__maskClickFunc == nil then
    return
  end
  self:SetAutoMaskActive(false)
  self:SetAutoTitleActive(false)
  self:SetAutoOperatorActive(false)
  self.__maskClickFunc()
end

function UIEpAutoMode:OnDelete()
  if self.autoOperatorNode ~= nil and not IsNull(self.autoOperatorNode.gameObject) then
    self.autoOperatorNode:Delete()
  end
  self.autoOperatorNode = nil
  base.OnDelete(self)
end

return UIEpAutoMode
