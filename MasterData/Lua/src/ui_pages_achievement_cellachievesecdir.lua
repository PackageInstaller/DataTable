local this = class("CellAchieveSecDir", G_UIModuleBase)
local _achievementGroupTpl = L_GameTpl:getAchievementGroupTpl()
local _achievementTpl = L_GameTpl:getAchievementTpl()

function this.bind()
  return {
    go_sel = false,
    go_normal = false,
    txt_title_sel = "",
    txt_progress_sel = "",
    txt_title = "",
    txt_progress = "",
    canvas_alpha = 1
  }
end

function this.methods()
  return {
    onClick = function(self)
      print("=======================click")
      self:emit("onClick", self.bind.index)
    end
  }
end

function this:open()
end

function this:refresh()
  local tpl = _achievementGroupTpl:getTplById(self.bind.id)
  self.bind.txt_title_sel = _achievementGroupTpl:getAchiName(tpl)
  self.bind.txt_title = _achievementGroupTpl:getAchiName(tpl)
  local finishCount = L_AchievementUtil.getStore():GetFinishCountOfGroup(self.bind.id)
  local tplList = _achievementTpl:getTplListByGroupId(self.bind.id)
  local finish_rate = finishCount .. "/" .. #tplList
  self.bind.txt_progress = finish_rate
  self.bind.txt_progress_sel = finish_rate
  self:setSelected(self.bind.index == self.parent.selSecIndex)
end

function this:setSelected(sel)
  self.bind.go_sel = sel
  self.bind.go_normal = not sel
end

function this:close()
  L_TimerManager:stopTimer(self, "secDirAnim")
end

return this
