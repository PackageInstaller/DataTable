local this = class("CellAchieveFirstDir", G_UIModuleBase)
local _achievementGroupTpl = L_GameTpl:getAchievementGroupTpl()
local _achievementTpl = L_GameTpl:getAchievementTpl()

function this.bind()
  return {img_icon = "", txt_num = ""}
end

function this.methods()
  return {}
end

function this:open()
  self:refreshView()
end

function this:refreshView()
  self.bind.img_icon = self.bind.img_icon
  self.bind.txt_num = tostring(self.bind.num)
end

return this
