local module = class("cellRecentAchievement", G_UIModuleBase)
local _achievementTpl = L_GameTpl:getAchievementTpl()

function module.bind()
  return {
    go_sel = false,
    txt_name = "",
    txt_content = "",
    txt_point = "",
    txt_completetime = "",
    rewardList = L_Const.ModuleInfo.CellIconBag
  }
end

function module.methods()
  return {
    onClick = function(self)
      print("======================click 三级1111111111111")
      self:emit("onClick", self.bind.index)
    end
  }
end

function module:open()
end

function module:refresh()
  local tpl = _achievementTpl:getTplById(self.bind.id)
  self.bind.txt_name = _achievementTpl:getAchiName(tpl)
  self.bind.content = _achievementTpl:getAchiDesc(tpl)
  self.bind.txt_point = tostring(_achievementTpl:getAchiPoint(tpl))
  local reward = L_DataUtil.parseRangeRewardConfig(_achievementTpl:getReward(tpl))
  self.bind.rewardList:clear()
  self.bind.rewardList:insert_array(reward)
  self:setSelected(self.bind.index == self.bind.selThirdIndex)
  local finish = L_AchievementUtil.getStore():GetIsAchievementCompleted(self.bind.id)
  print("==============================finish", finish, self.bind.id)
end

function module:setSelected(sel)
  self.bind.go_sel = sel
end

return module
