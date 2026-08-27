local UINSupportHeroSkill = class("UINSupportHeroSkill", UIBaseNode)
local base = UIBaseNode
local UINBaseSkillItem = require("Game.CommonUI.Item.UINBaseSkillItem")
local cs_Edge = CS.UnityEngine.RectTransform.Edge

function UINSupportHeroSkill:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.skillItem = UINBaseSkillItem.New()
  self.skillItem:Init(self.ui.uINSkillItem)
  self.ui.btn_ShowIntro.gameObject:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_ShowIntro, self, self.OnShowIntroClick)
end

function UINSupportHeroSkill:InitSupportHeroSkill(skillData, resloader)
  self.skillData = skillData
  if skillData == nil then
    error("skillData is NIL")
    return
  end
  self.skillItem:InitBaseSkillItem(skillData, resloader)
  self.ui.tex_Type:SetIndex(skillData:GetSkillTag() - 1)
  local skillCD = skillData:GetCurrentSkillCDTime()
  if skillCD == 0 then
    self.ui.tex_CD.transform.parent.gameObject:SetActive(false)
  else
    self.ui.tex_CD.text = GetPreciseDecimalStr(skillCD, 1) .. "s"
  end
  self.ui.tex_Name.text = skillData:GetName()
  self.ui.tex_Descr.text = skillData:GetCurLevelDescribe()
  local isFullLevel = skillData:IsFullLevel()
  if isFullLevel then
    self.ui.tex_Lv:SetIndex(1)
  else
    self.ui.tex_Lv:SetIndex(0, tostring(skillData.level))
  end
  self.ui.lock:SetActive(not skillData:GetIsUnlock())
  self:RefreshBtnShowIntro()
end

function UINSupportHeroSkill:RefreshBtnShowIntro()
  if self.skillData == nil then
    self.ui.btn_ShowIntro.gameObject:SetActive(false)
    return
  end
  local active = self.skillData:HaveSkillLabeId()
  self.ui.btn_ShowIntro.gameObject:SetActive(active)
end

function UINSupportHeroSkill:UpdateLevelDescribe()
  if self.skillData ~= nil then
    self.ui.tex_Descr.text = self.skillData:GetCurLevelDescribe()
  end
end

function UINSupportHeroSkill:OnShowIntroClick()
  UIManager:ShowWindowAsync(UIWindowTypeID.RichIntro, function(win)
    if win ~= nil then
      win:ShowIntroBySkillData(self.ui.richIntroHolder, self.skillData)
      win:SetIntroListPosition(cs_Edge.Left, cs_Edge.Top)
    end
  end)
end

return UINSupportHeroSkill
