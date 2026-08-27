local UINChristmas22TechTitle = class("UINChristmas22TechTitle", UIBaseNode)
local base = UIBaseNode

function UINChristmas22TechTitle:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Check, self, self.OnClickTitle)
end

function UINChristmas22TechTitle:InitChristmas22TechTitle(actTechTree, branchId, callback)
  self._data = actTechTree
  self._branchId = branchId
  self._callback = callback
  local techType = self._data:GetTreeId()
  local branchCfg = ConfigData.activity_tech_branch[techType][self._branchId]
  self.ui.tex_TitleCN.text = LanguageUtil.GetLocaleText(branchCfg.branch_name)
  self:RefreshChristmas22TechTitle()
end

function UINChristmas22TechTitle:RefreshChristmas22TechTitle()
  local techTypeDic = self._data:GetTechDataDic()
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

function UINChristmas22TechTitle:OnClickTitle()
  if self._callback ~= nil then
    self._callback(self._branchId)
  end
end

return UINChristmas22TechTitle
