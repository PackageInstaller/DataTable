local this = class("CellAchieveFirstDir", G_UIModuleBase)
local _achievementGroupTpl = L_GameTpl:getAchievementGroupTpl()
local _achievementTpl = L_GameTpl:getAchievementTpl()

function this.bind()
  return {
    txt_titleSel = "",
    txt_title = "",
    txt_e_titleSel = "",
    txt_e_title = "",
    img_sel = "",
    img = "",
    canvas_alpha = 1
  }
end

function this.methods()
  return {}
end

function this:open()
  if self.bind.firstInit then
    self.bind.canvas_alpha = 0
    L_TimerManager:newOrResetTimer(self, "firstDirAnim", function()
      self.bindComponents.aniRoot:Play("anim_achievementgroup_cellAchieveFirstDir_in")
    end, (self.bind.index - 1) * 0.06 + 0.1)
  end
  self:refreshView()
end

function this:refreshView()
  local tpl = _achievementGroupTpl:getTplById(self.bind.id)
  self.bind.txt_titleSel = _achievementGroupTpl:getAchiName(tpl)
  self.bind.txt_title = _achievementGroupTpl:getAchiName(tpl)
  self.bind.txt_e_titleSel = _achievementGroupTpl:getAchiEnglishName(tpl)
  self.bind.txt_e_title = _achievementGroupTpl:getAchiEnglishName(tpl)
  self.bind.img = self.bind.icon
  self.bind.img_sel = self.bind.icon
end

function this:close()
  L_TimerManager:stopTimer(self, "firstDirAnim")
end

return this
