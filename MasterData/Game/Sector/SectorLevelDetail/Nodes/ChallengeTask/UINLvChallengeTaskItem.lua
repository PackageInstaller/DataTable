local UINLvChallengeTaskItem = class("UINLvChallengeTaskItem", UIBaseNode)
local base = UIBaseNode

function UINLvChallengeTaskItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINLvChallengeTaskItem:InitLvChallengeTaskItem(taskCfg, isComplete)
  self.ui.tex_Desc.text = LanguageUtil.GetLocaleText(taskCfg.name)
  self.ui.img_Complete:SetIndex(isComplete and 0 or 1)
  if self.ui.obj_IsComplete ~= nil then
    self.ui.obj_IsComplete:SetActive(isComplete)
  end
  if self.ui.obj_reward ~= nil then
    if not isComplete and 0 < #taskCfg.rewardIds then
      self.ui.obj_reward:SetActive(true)
    else
      self.ui.obj_reward:SetActive(false)
    end
  end
end

function UINLvChallengeTaskItem:OnDelete()
  base.OnDelete(self)
end

return UINLvChallengeTaskItem
