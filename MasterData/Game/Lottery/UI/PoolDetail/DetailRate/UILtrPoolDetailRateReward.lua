local UILtrPoolDetailRateReward = class("UILtrPoolDetailRateReward", UIBaseNode)
local base = UIBaseNode

function UILtrPoolDetailRateReward:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.img_star.gameObject:SetActive(false)
  self.starItemList = {}
end

function UILtrPoolDetailRateReward:InitLtrPoolDetailRateReward(rewardData)
  local star = 0
  if rewardData.rankCfg ~= nil then
    star = rewardData.rankCfg.star
  end
  self:__HideAllStar()
  self:__UpdateStar(star)
  if rewardData.isItem then
    self.ui.tex_Name.text = ConfigData:GetTipContent(304)
    self.ui.lock:SetActive(false)
  else
    self.ui.tex_Name.text = LanguageUtil.GetLocaleText(rewardData.heroCfg.name)
    local rewardCfg = rewardData.rewardCfg
    local lock = not CheckCondition.CheckLua(rewardCfg.pre_condition, rewardCfg.pre_para1, rewardCfg.pre_para2)
    self.ui.lock:SetActive(lock)
    if lock then
      local lockInfo = CheckCondition.GetUnlockInfoLua({
        rewardCfg.pre_condition[1]
      }, {
        rewardCfg.pre_para1[1]
      }, {
        rewardCfg.pre_para2[1]
      })
      self.ui.tex_Condition.text = lockInfo
    end
  end
  self.ui.tex_Rate:SetIndex(rewardData.upHero and 1 or 0, GetPreciseDecimalStr(rewardData.rate / 100, 2))
  self.ui.obj_IsUP:SetActive(rewardData.upHero)
end

function UILtrPoolDetailRateReward:__UpdateStar(starCount)
  local twoStarCount = starCount // 2
  local oneStarCount = starCount % 2
  for i = 1, twoStarCount do
    local starItem = self:__GetStar(i)
    starItem:SetIndex(0)
  end
  if oneStarCount ~= 0 then
    local starItem = self:__GetStar(twoStarCount + 1)
    starItem:SetIndex(1)
  end
end

function UILtrPoolDetailRateReward:__GetStar(index)
  local starItem = self.starItemList[index]
  if starItem == nil then
    starItem = self.ui.img_star:Instantiate()
    self.starItemList[index] = starItem
  end
  starItem.gameObject:SetActive(true)
  return starItem
end

function UILtrPoolDetailRateReward:__HideAllStar()
  for k, v in pairs(self.starItemList) do
    v.gameObject:SetActive(false)
  end
end

function UILtrPoolDetailRateReward:OnDelete()
  base.OnDelete(self)
end

return UILtrPoolDetailRateReward
