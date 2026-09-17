local this = class("cellCommonRewardsItem", G_UIModuleBase)

function this.bind()
  return {
    go_reward_number = false,
    reward_icon = "",
    go_curLevel = false,
    go_reward_star = false,
    txt_reward_star = "",
    cell_list = {
      moduleName = "pages/entrustTask/cellEntrustReward"
    },
    txt_content = "",
    go_reward_content = false,
    reward_content = ""
  }
end

function this.methods()
  return {}
end

function this:open(options)
end

function this:refresh()
  self:showStarOrNumber(self.bind.isStar)
  self:refreshNumber(self.bind.isStar, self.bind.number)
  self:refreshList(self.bind.rewardList)
  self:refreshIcon(self.bind.reward_icon)
  self:refreshSelect(self.bind.isSelect)
  self:refreshRewardContent(self.bind.reward_tips)
end

function this:showStarOrNumber(isStar)
  if isStar == nil then
    return
  end
  self.bind.go_reward_star = isStar
  self.bind.go_reward_number = not isStar
end

function this:refreshNumber(isStar, number)
  if isStar == nil or number == nil then
    return
  end
  if isStar then
    self.bind.txt_reward_star = tostring(number)
  else
  end
end

function this:refreshList(list)
  self.bind.cell_list:clear()
  self.bind.cell_list:insert_array(list)
end

function this:refreshIcon(icon)
  if icon == nil then
    return
  end
  self.bind.reward_icon = icon
end

function this:refreshSelect(isSelect)
  if isSelect == nil then
    return
  end
  self.bind.go_curLevel = isSelect
end

function this:refreshRewardContent(content)
  if string.isEmpty(content) then
    self.bind.go_reward_content = false
    return
  end
  self.bind.go_reward_content = true
  self.bind.reward_content = content
end

return this
