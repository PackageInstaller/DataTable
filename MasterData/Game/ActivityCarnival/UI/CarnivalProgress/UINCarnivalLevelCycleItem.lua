local UINCarnivalLevelCycleItem = class("Game.ActivityCarnival.UI.CarnivalProgress.UINCarnivalLevelCycleItem", UIBaseNode)
local base = UIBaseNode

function UINCarnivalLevelCycleItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.image, self, self.OnClickReward)
end

function UINCarnivalLevelCycleItem:InitCarnivalLevelCycleItem(carnivalData, pickRewardFunc)
  self._pickRewardFunc = pickRewardFunc
  local mainCfg = carnivalData:GetCarnivalMainCfg()
  self.ui.tex_Des.text = ConfigData:GetTipContent(mainCfg.cir_reward_tip)
  local expCfgs = carnivalData:GetCarnivalExpCfg()
  local unit = expCfgs[#expCfgs].need_exp
  local curlevel, exp = carnivalData:GetCarnivalLevelExp()
  local maxLevel = carnivalData:GetCarnivalMaxLevel()
  if curlevel < maxLevel then
    self.ui.canvasGroup.alpha = 0.5
    self.ui.tex_Num.text = "0"
    self.ui.img_ExpProgress.fillAmount = 0
    self.ui.tex_ExpProgress:SetIndex(0, "0", tostring(unit))
    return
  end
  self.ui.canvasGroup.alpha = 1
  local rewardCount = exp // unit
  local remainExp = exp % unit
  self.ui.tex_Num.text = tostring(rewardCount)
  self.ui.img_ExpProgress.fillAmount = remainExp / unit
  self.ui.tex_ExpProgress:SetIndex(0, tostring(remainExp), tostring(unit))
end

function UINCarnivalLevelCycleItem:OnClickReward()
  if self._pickRewardFunc ~= nil then
    self._pickRewardFunc()
  end
end

return UINCarnivalLevelCycleItem
