local cls = class("cellEntrustTaskStarReward", G_UIModuleBase)

function cls.bind()
  return {
    img_reward = "",
    txt_itemNum = "X0",
    color_itemNum = C_Color.white,
    go_bgRewardFinishImg = false,
    go_reward = false,
    go_star1 = nil,
    go_star2 = nil,
    go_star3 = nil,
    go_starLight1 = nil,
    go_starLight2 = nil,
    go_starLight3 = nil
  }
end

function cls:refresh()
  local b_finish = self.bind.starNum >= self.bind.index
  self.bind.go_star1 = self.bind.index > 0
  self.bind.go_star2 = self.bind.index > 1
  self.bind.go_star3 = self.bind.index > 2
  self.bind.go_starLight1 = b_finish
  self.bind.go_starLight2 = b_finish
  self.bind.go_starLight3 = b_finish
  self.bind.go_bgRewardFinishImg = b_finish
  if b_finish then
    local _, color = C_ColorUtility.TryParseHtmlString("#d87500")
    self.bind.color_itemNum = color
  else
    local _, color = C_ColorUtility.TryParseHtmlString("#5f5952")
    self.bind.color_itemNum = color
  end
end

return cls
