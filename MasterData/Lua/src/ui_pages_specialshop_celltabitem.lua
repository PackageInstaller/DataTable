local this = class("CellAchieveFirstDir", G_UIModuleBase)
local _achievementGroupTpl = L_GameTpl:getAchievementGroupTpl()
local _achievementTpl = L_GameTpl:getAchievementTpl()

function this.bind()
  return {
    txt_titleSel = "",
    txt_title = "",
    txt_eng = "",
    txt_eng_sel = ""
  }
end

function this.methods()
  return {}
end

function this:open()
  self:refreshView()
end

function this:refreshView()
  self.bind.txt_titleSel = self.bind.txt_cn
  self.bind.txt_title = self.bind.txt_cn
  self.bind.txt_eng = self.bind.txt_eng
  self.bind.txt_eng_sel = self.bind.txt_eng
end

return this
