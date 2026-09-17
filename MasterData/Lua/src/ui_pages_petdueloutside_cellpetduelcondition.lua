local cls = class("cellPetDuelCondition", G_UIModuleBase)
local _commonConditionTpl = L_GameTpl:getCommonConditionTpl()
local _, colorWhite = C_ColorUtility.TryParseHtmlString(L_Const.colorHtml.white001)
local _, colorYellow = C_ColorUtility.TryParseHtmlString(L_Const.colorHtml.yellow002)

function cls.bind()
  return {
    toggle_Finish = false,
    img_reward = "",
    txt_rewardNum = "",
    txt_taskDes = "",
    color_txtReward = nil,
    color_txtDes = nil,
    alpha_bg = nil,
    go_bg2 = false
  }
end

function cls.methods()
  return {}
end

function cls:refresh()
  self.conditionId = self.bind.conditionId
  self.conditionParma = self.bind.conditionParma
  self.finished = self.bind.finished
  self.rewardIcon = self.bind.rewardIcon
  self.rewardNum = self.bind.rewardNum
  self:refreshView()
end

function cls:refreshView()
  if not self.finished then
    self.bind.toggle_Finish = false
    self.bind.color_txtReward = colorWhite
    self.bind.color_txtDes = C_Color(1, 1, 1, 0.8)
    self.bind.alpha_bg = 0.5
  else
    self.bind.toggle_Finish = true
    self.bind.color_txtReward = colorYellow
    self.bind.color_txtDes = colorWhite
    self.bind.alpha_bg = 0.8
    self.bind.go_bg2 = true
  end
  local tpl = _commonConditionTpl:getTplById(self.conditionId)
  local key = _commonConditionTpl:getDescShowKey(tpl)
  self.bind.txt_taskDes = L_Lang:get(key, {
    time = self.conditionParma
  })
  self.bind.img_reward = self.rewardIcon
  self.bind.txt_rewardNum = tostring(self.rewardNum)
end

return cls
