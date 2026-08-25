local Animator = CS.UnityEngine.Animator
local UIAnimationController = CS.Z1Client.UIAnimationController
local WorldStageBattleSettleTip, Super = System.NewClass("WorldStageBattleSettleTip", UIBasePanel)
WorldStageBattleSettleTip.uiResCls = UI_Battle_Popup_SettleResource

function WorldStageBattleSettleTip:ctor(battleFinishData, battleResult, moneyNum, callback, extraParam)
  Super.ctor(self)
  self.battleFinishData = battleFinishData
  self.battleResult = battleResult
  self.moneyNum = moneyNum
  self.callback = callback
  self.extraParam = extraParam or {}
  if bg.battleScene then
    AudioManager.Instance:PostSoundEvent(self.extraParam.soundEventName or "FIGHT_WIN_MUSIC")
  else
    AudioManager.Instance:PostSoundEvent("Play_SFX_POP_WIN_Fast")
  end
end

function WorldStageBattleSettleTip:OnBind(binder)
  local isWin = 1 == self.battleResult
  self.ui.Group_Defeat:SetActive(not isWin)
  self.ui.Group_Victory:SetActive(isWin)
  if isWin and self.battleFinishData then
    local moneyNum = self.moneyNum or 0
    if self.battleFinishData.battleTid then
      moneyNum = self:GetCoinRewardNum(self.battleFinishData.battleTid)
    end
    if moneyNum and moneyNum > 0 then
      binder:SetText(self.ui.Text_Coin_1, LT.Textf("UniversalSettlementPhiloStone", moneyNum))
      binder:BindToImage(self.ui.Image_Coin_1, function()
        return DT.GetOriginalConstant("PhiloStone")[2]
      end)
      binder:SetActive(self.ui.Image_Coin_1, true)
      self.ui.Text_Huode:SetActive(true)
      self.ui.Image_Coin_Bg:SetActive(true)
    else
      self.ui.Image_Coin_1:SetActive(false)
      self.ui.Text_Coin_1:SetActive(false)
      self.ui.Image_Coin_Bg:SetActive(false)
      self.ui.Text_Huode:SetActive(false)
    end
    if self.battleFinishData.itemList and #self.battleFinishData.itemList > 0 then
      local talentItem = self.battleFinishData.itemList[1]
      local talentCoinId = talentItem.tid
      binder:SetText(self.ui.Text_Coin_2, talentItem.num .. ItemDataUtils.GetName(talentCoinId))
      binder:BindToImage(self.ui.Image_Coin_2, function()
        do return ItemDataUtils.GetSmallIcon end
        return ItemDataUtils.GetSmallIcon, talentCoinId
      end)
      self.ui.Text_Huode:SetActive(true)
    else
      self.ui.Text_Coin_2:SetActive(false)
      self.ui.Image_Coin_2:SetActive(false)
    end
    binder:SetText(self.ui.Text_Huode, LT.Text("VictoryAward"))
  else
    self.ui.Text_Coin_1:SetActive(false)
    self.ui.Text_Coin_2:SetActive(false)
    self.ui.Image_Coin_1:SetActive(false)
    self.ui.Image_Coin_2:SetActive(false)
    self.ui.Text_Huode:SetActive(false)
    self.ui.Image_Coin_Bg:SetActive(false)
  end
  self.animator = self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.Animator))
  self.animator.enabled = true
  UIManager.Instance:CloseByUrl(Urls.CopiesAwakerInfoPanelNew)
  local uiAnimCtr = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  local str = isWin and "BattleVictory" or "BattleDefeat"
  if "BattleVictory" == str then
    uiAnimCtr:PlayState("UA_BattleClear_Victory", function()
      self:Close()
    end)
  else
    self:Close()
  end
end

function WorldStageBattleSettleTip:Close()
  local callback = self.callback
  self.callback = nil
  Super.Close(self)
  if callback then
    callback()
  end
end

function WorldStageBattleSettleTip:GetCoinRewardNum(battleTid)
  if bg.battleData and bg.battleData.blackCoin then
    return bg.battleData.blackCoin
  end
  do return CopyDataUtils.GetCoinRewardNum end
  return CopyDataUtils.GetCoinRewardNum, battleTid
end

return WorldStageBattleSettleTip
