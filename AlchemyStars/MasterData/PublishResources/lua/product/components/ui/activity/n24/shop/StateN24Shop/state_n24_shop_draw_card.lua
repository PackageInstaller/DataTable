_class("StateN24ShopDrawCard", StateN24ShopBase)
StateN24ShopDrawCard = StateN24ShopDrawCard

function StateN24ShopDrawCard:OnEnter(TT, ...)
  self:Init()
  self._uiModule:LockAchievementFinishPanel(true)
  self.lockKey = "UIN24ShopDoDraw"
  GameGlobal.UIStateManager():Lock(self.lockKey)
  local lotteryType = table.unpack({
    ...
  })
  self:DoDraw(TT, lotteryType)
end

function StateN24ShopDrawCard:OnExit(TT)
  GameGlobal.UIStateManager():UnLock(self.lockKey)
end

function StateN24ShopDrawCard:DoDraw(TT, lotteryType)
  local res = AsyncRequestRes:New()
  local getRewards, isOpenNew = self:_SendDrawReq(TT, res, self:CurPageIndex(), lotteryType)
  if N24Data.CheckCode(res) then
    self.ui:_RecordRewardsInfo(getRewards, lotteryType, nil, isOpenNew, nil)
    self:ChangeState(StateN24Shop.SpineAnim, lotteryType)
  else
    self:ChangeState(StateN24Shop.Init)
  end
end

function StateN24ShopDrawCard:_SendDrawReq(TT, res, boxIndex, lotteryType)
  local cLottery = self.data:GetComponentShop()
  if cLottery then
    return cLottery:HandleLottery(TT, res, boxIndex, lotteryType)
  end
  res:SetSucc(false)
  return nil
end
