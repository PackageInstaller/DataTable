local this = class("cellActivityMainTaskReward", G_UIModuleBase)

function this.bind()
  return {
    txt_desc1 = "",
    txt_desc2 = "",
    img_reward = "",
    txt_rewardNum = ""
  }
end

function this.methods()
  return {
    onClick_reward = function(self)
    end
  }
end

function this:open()
end

function this:refresh()
  local itemId = self.bind.rewardId
end

return this
