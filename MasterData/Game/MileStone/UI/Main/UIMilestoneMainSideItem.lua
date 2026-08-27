local UIMilestoneMainSideItem = class("UIMilestoneMainSideItem", UIBaseNode)
local base = UIBaseNode
local MilestoneUtil = require("Game.MileStone.MilestoneUtil")

function UIMilestoneMainSideItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIMilestoneMainSideItem:InitMilestoneMainSideItem(profileCfg, msData)
  self.ui.tex_TitleName.text = LanguageUtil.GetLocaleText(profileCfg.text)
  local desFunc = MilestoneUtil.desFuncDic[profileCfg.id]
  if desFunc ~= nil then
    self.ui.tex_Progress.text = desFunc(msData)
  end
end

function UIMilestoneMainSideItem:OnDelete()
  base.OnDelete(self)
end

return UIMilestoneMainSideItem
