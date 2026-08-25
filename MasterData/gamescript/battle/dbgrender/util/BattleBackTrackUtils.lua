local BattleBackTrackUtils = {}

function BattleBackTrackUtils.IsOpen()
  do return end
  return BattlePassDataUtils.IsCore, nil
end

function BattleBackTrackUtils.GetCorePrivilegeLockTipText()
  do return PlayerDataUtils.GetFeatureLogicUnlockTips, CommonDefine.FeatureId.BattlePass, PlayerDataUtils.GetFeatureMainTypeKey() end
  return PlayerDataUtils.GetFeatureLogicUnlockTips, CommonDefine.FeatureId.BattlePass, PlayerDataUtils.GetFeatureMainTypeKey()
end

function BattleBackTrackUtils.TryShowCorePrivilegeLockedTip()
  local tipText = BattleBackTrackUtils.GetCorePrivilegeLockTipText()
  if tipText and "" ~= tipText then
    Alert.ShowStr(tipText)
    return true
  end
  return false
end

function BattleBackTrackUtils.BackToRound(round, forBattleRestart)
  if not forBattleRestart and not BattleBackTrackUtils.IsOpen() then
    return
  end
  Logger.Info("[BattleBackTrack] BackToRound round=%s forBattleRestart=%s", round, tostring(forBattleRestart))
  EventMgr.Instance.ChooseRewindToBout:Dispatch(round, forBattleRestart)
  TimerManager.Instance:CreateTimer(0.1, 0, nil, function()
    if bg.battleScene then
      bg.battleScene:RestartBattle(nil, true)
    end
  end)
end

function BattleBackTrackUtils.RestartBattle()
  BattleBackTrackUtils.BackToRound(1, true)
end

function BattleBackTrackUtils.ShowFailTips(cancelCallback, confirmCallback, effectUid, reason)
  if not bg.battleRender then
    return
  end
  if bg.battleRender._showedFailTips then
    if cancelCallback then
      cancelCallback()
    end
    return
  end
  bg.battleRender._showedFailTips = true
  local loseTipId = reason == bc.ConfirmReason.BoutLimit and "PVEExceedMaxRoundsTips" or 20068
  Alert.Show(loseTipId, function()
    Logger.Info("[BattleBackTrack] ShowFailTips 离开/放弃 effectUid=%s", tostring(effectUid))
    if cancelCallback then
      cancelCallback()
    end
  end, function()
    Logger.Info("[BattleBackTrack] ShowFailTips 重新开始 effectUid=%s", tostring(effectUid))
    if confirmCallback then
      confirmCallback()
    elseif effectUid then
      bg.battleRender:OnReqRespawn(effectUid, false, true)
    else
      BattleBackTrackUtils.RestartBattle()
    end
  end)
end

function BattleBackTrackUtils.CheckShowBackTrackTutorial()
  if BattleBackTrackUtils.IsOpen() and ClientDataUtils.GetClientSubData(cd.ClientSubKey.BattleTrackBackTutorial) == nil then
    ClientDataUtils.SetClientSubData(cd.ClientSubKey.BattleTrackBackTutorial, 1)
    UIManager.Instance:Reopen(Urls.TutorialSimpleView, 120371)
  end
end

function BattleBackTrackUtils.ShouldShowNewTag()
  return BattleBackTrackUtils.IsOpen() and ClientDataUtils.GetClientSubData(cd.ClientSubKey.BattleTrackBackNewTag) == nil
end

function BattleBackTrackUtils.MarkNewTagClicked()
  if BattleBackTrackUtils.ShouldShowNewTag() then
    ClientDataUtils.SetClientSubData(cd.ClientSubKey.BattleTrackBackNewTag, 1)
  end
end

function BattleBackTrackUtils.OpenRebirthChargeView(viewData)
  viewData = viewData or {}
  if not MainShopDataUtils.IsInitData() then
    ProtoManager.Instance:ReqServer("GameRequest", "OnOpenShop", function(data)
      MainShopData.shopData = MainShopDataUtils.SortAllGoods(data)
      MainShopData.isInit = true
      RedPointDataUtils.UpdateShopRed()
      BattleBackTrackUtils.OpenRebirthChargeView(viewData)
    end, function(_)
      Logger.Error("[BattleBackTrackUtils] OpenRebirthChargeView req shop data failed")
      if viewData.cancelFunc then
        viewData.cancelFunc()
      end
    end)
    return
  end
  viewData.costItemTid = viewData.costItemTid or CommonDefine.CurrencyType.SummonGiftMoney
  viewData.rebirthItemId = DT.GetConstant("RevivalItemId")
  viewData.shopCfg = ShopCfgUtils.GetExchangeShopCfg(viewData.rebirthItemId) or {}
  local singlePrice = viewData.shopCfg.Price and viewData.shopCfg.Price[2] or 0
  viewData.needBuyCount = viewData.needBuyCount or 1
  viewData.costNum = singlePrice * viewData.needBuyCount
  viewData.shopItemData = MainShopDataUtils.GetShopDataByTid(viewData.shopCfg.ID)
  viewData.remainNum = MainShopDataUtils.GetGoodRemaining(viewData.shopItemData) or 0
  if viewData.remainNum < viewData.needBuyCount then
    if viewData.cancelFunc then
      viewData.cancelFunc()
    end
    return
  end
  local stageData = WorldStageManager.Instance:GetCurStageData()
  viewData.isAbyssChallenge = AbyssDataUtils.IsAbyssStageTid(stageData and stageData.stageId)
  UIManager.Instance:Reopen(Urls.RebirthChargeView, viewData)
end

return BattleBackTrackUtils
