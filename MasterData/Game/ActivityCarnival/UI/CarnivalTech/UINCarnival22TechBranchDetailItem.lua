local UINCarnival22TechBranchDetailItem = class("UINCarnival22TechBranchDetailItem", UIBaseNode)
local base = UIBaseNode
local CommonLogicUtil = require("Game.Common.CommonLogicUtil.CommonLogicUtil")

function UINCarnival22TechBranchDetailItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._defalultDesColor = self.ui.tex_Des.color
end

function UINCarnival22TechBranchDetailItem:InitBranchEft(actTechData)
  self._actTechData = actTechData
  self.ui.tex_Name.text = self._actTechData:GetAWTechName()
  local logicArray, para1Array, para2Array, para3Array = self._actTechData:GetTechLogic(1)
  local intro = ""
  for index, logic in ipairs(logicArray) do
    local para1 = para1Array[index]
    local para2 = para2Array[index]
    local para3 = para3Array[index]
    local longDes, shortDes, valueDes = CommonLogicUtil.GetDesString(logic, para1, para2, para3)
    if string.IsNullOrEmpty(intro) then
      intro = longDes
    else
      intro = intro .. "\n" .. longDes
    end
  end
  self.ui.tex_Des.text = intro
  self:RefreshBranchEft()
end

function UINCarnival22TechBranchDetailItem:RefreshBranchEft()
  local isActive = self._actTechData:GetCurLevel() > 0
  self.ui.obj_IsActive:SetActive(isActive)
  self.ui.obj_Locked:SetActive(not isActive)
  if not isActive then
    local preConditionList = self._actTechData:GetAWTechUnlockInfo(1)
    self.ui.tex_locked.text = preConditionList[1].lockReason
    self.ui.tex_Name.color = self.ui.color_locked_text
    self.ui.tex_Des.color = self.ui.color_locked_text
  else
    self.ui.tex_Name.color = Color.white
    self.ui.tex_Des.color = self._defalultDesColor
  end
end

function UINCarnival22TechBranchDetailItem:RefreshBranchDetailItemReddot(flag)
  self.ui.redDot:SetActive(flag)
end

function UINCarnival22TechBranchDetailItem:GetBranchDetailItemId()
  return self._actTechData:GetTechId()
end

return UINCarnival22TechBranchDetailItem
