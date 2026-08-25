local PopupRewardComp = System.NewClass("PopupRewardComp", PopupBaseComp)

function PopupRewardComp:ctor()
  self.rewardsList = {}
end

function PopupRewardComp:OnBind(binder)
  self.binder = binder
  binder:BindEvent(EventMgr.Instance.CheckShowRewardEvent, System.fn(self, self.OnCheckShowReward))
  self:BindRewards()
end

function PopupRewardComp:Clear()
  table.clear(self.rewardsList)
end

function PopupRewardComp:CheckPopup()
  if self:IsDelayShowReward() then
    if #self.rewardsList > 0 then
      PopupQueManager.Instance:AddToTempPriorityComp(self)
    end
    return
  end
  self:PopupReward()
end

function PopupRewardComp:PopupReward()
  if #self.rewardsList > 0 then
    local popTipsMgr = PopTipsManager.Instance
    local datas = self.rewardsList[1]
    local ok, skinRewards = xpcall(self.TakeOutSkinItem, function(err)
      Logger.Warn("PopupRewardComp:TakeOutSkinItem error:", err, debug.traceback())
    end, self, datas)
    if not ok then
      Logger.Warn("PopupRewardComp:PopupReward batch dropped (TakeOutSkinItem crashed), pending:", #self.rewardsList)
      table.remove(self.rewardsList, 1)
      return
    end
    if skinRewards then
      local shown = popTipsMgr:ShowSkinReward(skinRewards)
      if not shown then
        Logger.Warn("PopupRewardComp:PopupReward skin not shown, drain remainder. pending:", #self.rewardsList)
        self:PopupReward()
      end
    else
      table.remove(self.rewardsList, 1)
      local isUseItem = false
      local weaponOrAwaker = false
      local chooseItemData, removeIdx
      for idx, itemData in ipairs(datas) do
        local reason = itemData.reason
        local itemType = ItemDataUtils.GetItemType(itemData.tid)
        if (reason == cd.ItemReason.UseItem or reason == cd.ItemReason.UseChooseItem) and (itemData.changedNum or 0) < 0 then
          isUseItem = true
        end
        if itemType == cd.ItemType.AwakerItem or itemType == cd.ItemType.Weapon then
          weaponOrAwaker = true
          chooseItemData = itemData
        end
        if reason == cd.ItemReason.WeaponAutoRefine and (popTipsMgr.weaponLock[itemData.tid] or DataCenter.itemData.IsRewardRandom) then
          removeIdx = idx
        end
      end
      if removeIdx and not isUseItem then
        table.remove(datas, removeIdx)
      end
      local isRandomOrChoose = isUseItem and weaponOrAwaker
      if isRandomOrChoose and chooseItemData then
        popTipsMgr:UpdateWeaponLock(chooseItemData.tid, true)
        popTipsMgr:ShowChooseReward(chooseItemData)
      else
        popTipsMgr:TakeOutKeeperSkill(datas)
        popTipsMgr:ShowNewAwakerWeaponReward(datas)
        popTipsMgr:ShowCommonReward(datas)
      end
      CopyController.Instance:CheckShowOverflowTipsBySync(datas)
    end
  end
end

function PopupRewardComp:IsDelayShowReward()
  if PopTipsManager.Instance:IsTutorialLockActive() then
    return true
  end
  if self.forbidShowRewardTime and self.forbidShowRewardTime > TimeUtils.GetServerTime() then
    return true
  end
  local topFullScreen = UIManager.Instance:GetTopFullScreenPanel()
  if topFullScreen == Urls.SummonResultPanel or topFullScreen == Urls.SummonSkinResultPanel or topFullScreen == Urls.SummonSkinResultNextPanel or topFullScreen == Urls.SummonedAwakerPanel then
    return true
  end
  if AvgStoryManager.Instance:IsPlaying() then
    return true
  end
  if UIManager.Instance:GetWindow(Urls.ShowRewardPanel) then
    return
  end
  if UIManager.Instance:GetWindow(Urls.ShowRewardSharePanel) then
    return
  end
end

function PopupRewardComp:BindRewards()
  self.binder:BindEvent(EventMgr.Instance.UpdateBagEvent, function(datas)
    local topFullScreen = UIManager.Instance:GetTopFullScreenPanel()
    if topFullScreen == Urls.SummonResultPanel or topFullScreen == Urls.SummonedAwakerPanel or topFullScreen == Urls.SummonPanel then
      self:TakeOutAutoRefineAndAutoDecompose(datas)
    end
    if topFullScreen == Urls.SummonSkinResultPanel or topFullScreen == Urls.SummonSkinResultNextPanel then
      datas = table.deepclone(datas)
      self:TakeOutSkinItem(datas)
    end
    local rewardDatas = datas
    if UIManager.Instance:GetWindow(Urls.TutorialMainView) then
      rewardDatas = self:FilterOutTutorialRead(datas)
      if 0 == #rewardDatas then
        return
      end
    end
    table.insert(self.rewardsList, rewardDatas)
    if PopupQueManager.Instance:GetIsDealRewardsInQue() then
      return
    end
    self:CheckPopup()
  end)
end

function PopupRewardComp:OnCheckShowReward()
  self:PopupReward()
end

function PopupRewardComp:TakeOutAutoRefineAndAutoDecompose(datas)
  if not datas then
    return
  end
  for i = #datas, 1, -1 do
    local reward = datas[i]
    if reward.reason == cd.ItemReason.WeaponAutoRefine or reward.reason == cd.ItemReason.AutoDecompose then
      table.remove(datas, i)
    end
  end
end

function PopupRewardComp:FilterOutTutorialRead(datas)
  local filtered = {}
  if not datas then
    return filtered
  end
  for _, reward in pairs(datas) do
    if type(reward) == "table" and reward.reason ~= "TutorialRead" then
      table.insert(filtered, reward)
    end
  end
  return filtered
end

function PopupRewardComp:TakeOutSkinItem(datas)
  for i = #datas, 1, -1 do
    local reward = datas[i]
    local itemCfg = ItemDataUtils.GetItemConfig(reward.tid)
    if itemCfg.Type == cd.ItemType.SkinItem then
      table.remove(datas, i)
      return {reward}
    end
  end
end

function PopupRewardComp:SetForbidShowRewardTime(time)
  self.forbidShowRewardTime = TimeUtils.GetServerTime() + time
end

function PopupRewardComp:HasPendingRewards()
  return #self.rewardsList > 0
end

return PopupRewardComp
