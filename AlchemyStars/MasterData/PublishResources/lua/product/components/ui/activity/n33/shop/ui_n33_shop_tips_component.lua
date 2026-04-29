local LotteryShopState = {Lottery = 1, Idle = 2}
_enum("LotteryShopState", LotteryShopState)
local N33LotterySpineState = {ClawDown = 1, ClawUp = 2}
_enum("N33LotterySpineState", N33LotterySpineState)
local LotteryRewardState = {
  NotOpen = 1,
  HasBigReward = 2,
  NoBigReward = 3,
  NoReward = 4
}
_enum("LotteryRewardState", LotteryRewardState)
_class("UIN33ShopTipsComponent", Object)
UIN33ShopTipsComponent = UIN33ShopTipsComponent

function UIN33ShopTipsComponent:Constructor(objTipsBg, textTips, rawImageLoader)
  self._objTipsBg = objTipsBg
  self._textTips = textTips
  self._rawImageLoader = rawImageLoader
end

function UIN33ShopTipsComponent:FillUi(lotteryShopState, hundreds, tens, ones)
  local id = self:_GetConfigID(lotteryShopState, hundreds, tens, ones)
  local config = Cfg.cfg_n33_shop_tips[id]
  if not config then
    return
  end
  local maxIndex = #config.TipsText
  local index = math.random(1, maxIndex)
  self._textTips:SetText(StringTable.Get(config.TipsText[index]))
  self._rawImageLoader:LoadImage(config.FacePic[index])
end

function UIN33ShopTipsComponent:_GetConfigID(lotteryShopState, hundreds, tens, ones)
  if lotteryShopState ~= LotteryShopState.Lottery and lotteryShopState ~= LotteryShopState.Idle then
    return -1
  end
  if lotteryShopState == LotteryShopState.Lottery then
    hundreds = hundreds + 1
    if tens == N33LotterySpineState.ClawUp then
      ones = ones + 1
    end
  end
  return lotteryShopState * 1000 + hundreds * 100 + tens * 10 + ones
end
