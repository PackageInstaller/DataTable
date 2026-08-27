local UINActivityDivergentAllTaskCompleteNode = class("UINActivityDivergentAllTaskCompleteNode", UIBaseNode)
local base = UIBaseNode

function UINActivityDivergentAllTaskCompleteNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINActivityDivergentAllTaskCompleteNode:InitDivergentAllTaskCompleteNode(divergentData)
  self._data = divergentData
end

function UINActivityDivergentAllTaskCompleteNode:RefreshDivergentAllTaskCompleteNode(divergentHeroId, ani_center)
  if self._data:GetDivergentCurrentHeroId() ~= divergentHeroId then
    self:Hide()
    return
  end
  if self._data:GetDivergentHeroFragAllGet(divergentHeroId) then
    self:Show()
    local heroCfg = ConfigData.hero_data[divergentHeroId]
    self.ui.tex_AllComplete:SetIndex(1, LanguageUtil.GetLocaleText(heroCfg.name))
    self.ui.obj_Tip:SetActive(false)
    return
  else
    self.ui.tex_AllComplete:SetIndex(0)
    self.ui.obj_Tip:SetActive(true)
  end
  local divergentTaskProgress = self._data:GetDivergentTaskProgress()
  local mainCfg = self._data:GetDivergentMainCfg()
  if divergentTaskProgress.completedNum < mainCfg.task_complete_num then
    self:Hide()
    return
  end
  self:Show()
  self.ui.tex_TaskCount:SetIndex(0, tostring(divergentTaskProgress.completedNum), tostring(mainCfg.task_complete_num))
  ani_center:Play("UI_AnotherHero_FinishStateIntro")
end

return UINActivityDivergentAllTaskCompleteNode
