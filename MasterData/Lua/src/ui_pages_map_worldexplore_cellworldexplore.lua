local this = class("cellWorldExplore", G_UIModuleBase)

function this.bind()
  return {
    txt_explore = "",
    goConfirmActive = nil,
    goNotActive = nil,
    goYlqActive = nil,
    goRawardsActive = nil,
    scrollList_reward = L_Const.ModuleInfo.CellIcon
  }
end

function this.methods()
  return {
    onClick = function(self)
      self:emit("onClick", self.bind)
    end
  }
end

function this:refresh()
  self.bind.goConfirmActive = self.bind.status == L_Const.commonRewardStatus.complete
  self.bind.goYlqActive = self.bind.status == L_Const.commonRewardStatus.got
  self.bind.goNotActive = self.bind.status == L_Const.commonRewardStatus.notComp
  if self.bind.status == L_Const.commonRewardStatus.got then
    self.bind.goRawardsActive = false
  else
    self.bind.goRawardsActive = true
    self.bind.scrollList_reward:clear()
    self.bind.scrollList_reward:insert_array(self.bind.rewardList)
  end
end

return this
