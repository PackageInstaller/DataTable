local UINCarnival22TechTitle = class("UINCarnival22TechTitle", UIBaseNode)
local base = UIBaseNode

function UINCarnival22TechTitle:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Check, self, self.OnClickBranch)
end

function UINCarnival22TechTitle:InitCarnivalTechTitle(carnivalData, branchId, callback)
  self._carnivalData = carnivalData
  self._branchId = branchId
  self._callback = callback
  local techType = self._carnivalData:GetCarnivalTechType()
  local branchCfg = ConfigData.activity_tech_branch[techType][self._branchId]
  self.ui.tex_TitleCN.text = LanguageUtil.GetLocaleText(branchCfg.branch_name)
  self.ui.tex_TitleEN.text = branchCfg.branch_name_en
  self:RefreshCarnivalTechTitle()
end

function UINCarnival22TechTitle:RefreshCarnivalTechTitle()
  local techTypeDic = self._carnivalData:GetCarnivalTech()
  local techDic = techTypeDic[self._branchId]
  local curLevel = 0
  local totalLevel = 0
  for _, techData in pairs(techDic) do
    if not techData:IsActTechAutoUnlock() then
      curLevel = curLevel + techData:GetCurLevel()
      totalLevel = totalLevel + techData:GetMaxLevel()
    end
  end
  self.ui.tex_Count:SetIndex(0, tostring(curLevel), tostring(totalLevel))
end

function UINCarnival22TechTitle:SetCarnivalBranchReddot(flag)
  self.ui.redDot:SetActive(flag)
end

function UINCarnival22TechTitle:GetCarnivalBranchId()
  return self._branchId
end

function UINCarnival22TechTitle:OnClickBranch()
  if self._callback ~= nil then
    self._callback(self._branchId)
  end
end

return UINCarnival22TechTitle
