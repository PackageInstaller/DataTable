local this = class("cellCommonTabItemBase", G_UIModuleBase)
local _achievementGroupTpl = L_GameTpl:getAchievementGroupTpl()
local _achievementTpl = L_GameTpl:getAchievementTpl()

function this.bind()
  return {txt_titleSel = "", txt_title = ""}
end

function this.methods()
  return {}
end

function this:open()
  self:refreshView()
end

function this:refreshView()
  self.bind.txt_titleSel = self.bind.txt
  self.bind.txt_title = self.bind.txt
end

return this
