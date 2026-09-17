local this = class("CellAchieveGroup", G_UIModuleBase)
local _achievementGroupTpl = L_GameTpl:getAchievementGroupTpl()
local _achievementTpl = L_GameTpl:getAchievementTpl()

function this.bind()
  return {
    img_icon = "",
    txt_name = "",
    txt_reward = ""
  }
end

function this.methods()
  return {
    onClick = function(self)
      if self.bCanClick == false then
        return
      end
      self.bCanClick = false
      self:newOrResetTimer("forbidClick", function()
        self.bCanClick = true
      end, 2)
      self.bindComponents.aniRoot:Play("anim_achievementgroup_pageAchievementGroup_click_cell")
      self:newOrResetTimer("animCellTimer", function()
        self:emit("onClick", self.bind.index)
      end, 0.267)
    end
  }
end

function this:open()
  self.bCanClick = true
  self:refreshView()
end

function this:refreshView()
  local tpl = _achievementGroupTpl:getTplById(self.bind.id)
  self.bind.txt_name = _achievementGroupTpl:getAcheiNameIcon(tpl)
  self.bindComponents.name_txt:SetNativeSize()
  self.bind.img_icon = _achievementGroupTpl:getAcheiGroupIcon(tpl)
  self.bind.txt_reward = tostring(L_AchievementUtil.getStore():GetCurAllPointValueByBigGroup(self.bind.id))
end

return this
