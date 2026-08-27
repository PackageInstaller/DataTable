local UINLuckyRaffleMainInfo = class("UINLuckyRaffleMainInfo", UIBaseNode)
local base = UIBaseNode
local UINLuckyRaffleRewardPartInfoItem = require("Game.ActivityLuckyRaffle.UI.UINLuckyRaffleRewardPartInfoItem")

function UINLuckyRaffleMainInfo:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.rewardOne = UINLuckyRaffleRewardPartInfoItem.New()
  self.rewardOne:Init(self.ui.obj_reward_1)
  self.rewardTwo = UINLuckyRaffleRewardPartInfoItem.New()
  self.rewardTwo:Init(self.ui.obj_reward_2)
  self.rewardThree = UINLuckyRaffleRewardPartInfoItem.New()
  self.rewardThree:Init(self.ui.obj_reward_3)
end

function UINLuckyRaffleMainInfo:InitNLuckyRaffleMainInfo(luckyRaffleCfg, luckyRaffleData, resloader)
  self.luckyRaffleCfg = luckyRaffleCfg
  self.luckyRaffleData = luckyRaffleData
  self.resloader = resloader
  self:RefreshRafflePageNormalInfo()
end

function UINLuckyRaffleMainInfo:RefreshRafflePageNormalInfo()
  local rewardPartData = {}
  rewardPartData.bgImage = self.luckyRaffleCfg.super_raffle_image
  rewardPartData.level = self.luckyRaffleCfg.super_raffle_text
  rewardPartData.title = self.luckyRaffleCfg.super_raffle_name
  rewardPartData.des = self.luckyRaffleCfg.super_raffle_info
  rewardPartData.num = self.luckyRaffleCfg.super_raffle_num
  self.rewardOne:InitLuckyRaffleRewardPartInfoItem(rewardPartData, self.resloader)
  rewardPartData.bgImage = self.luckyRaffleCfg.normal_raffle_image1
  rewardPartData.level = self.luckyRaffleCfg.normal_raffle_text1
  rewardPartData.title = self.luckyRaffleCfg.normal_raffle_name1
  rewardPartData.des = self.luckyRaffleCfg.normal_raffle_info1
  rewardPartData.num = self.luckyRaffleCfg.normal_raffle_num1
  self.rewardTwo:InitLuckyRaffleRewardPartInfoItem(rewardPartData, self.resloader)
  rewardPartData.bgImage = self.luckyRaffleCfg.normal_raffle_image2
  rewardPartData.level = self.luckyRaffleCfg.normal_raffle_text2
  rewardPartData.title = self.luckyRaffleCfg.normal_raffle_name2
  rewardPartData.des = self.luckyRaffleCfg.normal_raffle_info2
  rewardPartData.num = self.luckyRaffleCfg.normal_raffle_num2
  self.rewardThree:InitLuckyRaffleRewardPartInfoItem(rewardPartData, self.resloader)
  self.ui.tex_bigReward_up.text = LanguageUtil.GetLocaleText(self.luckyRaffleCfg.raffle_text)
  self:RefreshVoteNum()
end

function UINLuckyRaffleMainInfo:RefreshVoteNum()
  self.ui.tex_already_num.text = tostring(self.luckyRaffleData:GetLuckyRaffleVoteNumByPoolId(self.luckyRaffleCfg.raffle_id))
end

function UINLuckyRaffleMainInfo:OnClickRafflePageItem()
end

return UINLuckyRaffleMainInfo
