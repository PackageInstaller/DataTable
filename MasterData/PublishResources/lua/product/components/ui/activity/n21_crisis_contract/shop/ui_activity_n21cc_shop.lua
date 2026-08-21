_class("UIActivityN21CCShop", UIController)
UIActivityN21CCShop = UIActivityN21CCShop

function UIActivityN21CCShop:LoadDataOnEnter(TT, res, uiParams)
  self._activityConst = UIActivityN21CCConst:New()
  self._activityConst:LoadData(TT, res)
  self._rewardDatas = self._activityConst:GetShopDatas()
end

function UIActivityN21CCShop:OnShow(uiParams)
  self:AttachEvent(GameEventType.N21CCGetScoreReward, self.RefreshRewardList)
  self:AttachEvent(GameEventType.N21CCShopRewardItemClick, self.ShowItemInfo)
  self._topBtn = self:GetGameObject("TopBtn")
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  local backBtn = btns:SpawnObject("UICommonTopButton")
  backBtn:SetData(function()
    self:StartTask(function(TT)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.N21CCPlayMainFocusAnim)
      self._anim:Play("UIActivityN21CCShop_out")
      YIELD(TT, 333)
      self:CloseDialog()
    end)
  end, nil, nil, true)
  self._bossListLoader = self:GetUIComponent("UISelectObjectPath", "BossList")
  self._itemsLoader = self:GetUIComponent("UISelectObjectPath", "Items")
  self._bossIconLoader = self:GetUIComponent("RawImageLoader", "BossIcon")
  self._scoreLabel = self:GetUIComponent("UILocalizationText", "Score")
  self._scoreShadowLabel = self:GetUIComponent("UILocalizationText", "ScoreShadow")
  self._anim = self:GetUIComponent("Animation", "Anim")
  local s = self:GetUIComponent("UISelectObjectPath", "ItemInfo")
  self._tips = s:SpawnObject("UISelectInfo")
  self._currentBossItem = nil
  local missionId = uiParams[1]
  local index = 1
  if missionId then
    for i = 1, #self._rewardDatas do
      local bossData = self._rewardDatas[i]
      if bossData:IsMission(missionId) then
        index = i
        break
      end
    end
  end
  self:Init(index)
  self:PlayEnterAnim()
end

function UIActivityN21CCShop:OnHide()
  self:DetachEvent(GameEventType.N21CCGetScoreReward, self.RefreshRewardList)
  self:DetachEvent(GameEventType.N21CCShopRewardItemClick, self.ShowItemInfo)
end

function UIActivityN21CCShop:Init(index)
  if #self._rewardDatas <= 0 then
    return
  end
  self._bossListLoader:SpawnObjects("UIActivityN21CCShopBossItem", #self._rewardDatas)
  local items = self._bossListLoader:GetAllSpawnList()
  for i = 1, #items do
    local bossData = self._rewardDatas[i]
    local item = items[i]
    item:Refresh(bossData, function(bossItem)
      self:PlaySelectBossAnim(bossItem)
      self:SelectBoss(bossItem)
    end)
  end
  if items and items[index] then
    self:SelectBoss(items[index])
  end
end

function UIActivityN21CCShop:PlayEnterAnim()
  self:StartTask(self.PlayEnterAnimCoro, self)
end

function UIActivityN21CCShop:PlayEnterAnimCoro(TT)
  self:Lock("UIActivityN21CCShop_PlayEnterAnimCoro")
  self._anim:Play("UIActivityN21CCShop_in")
  local items = self._itemsLoader:GetAllSpawnList()
  for i = 1, #items do
    local item = items[i]
    item:PlayAnim()
    YIELD(TT, 100)
  end
  self:UnLock("UIActivityN21CCShop_PlayEnterAnimCoro")
end

function UIActivityN21CCShop:PlaySelectBossAnim(bossItem)
  if not bossItem then
    return
  end
  if self._currentBossItem == bossItem then
    return
  end
  self._anim:Play("UIActivityN21CCShop_zhuanhuan")
  self._playAnim = true
  local bossData = bossItem:GetBossData()
  self._scoreLabel:SetText(0)
  self._scoreShadowLabel:SetText(0)
  self._length = 500
  self._targetValue = bossData:GetTotalScore()
  self._speed = self._targetValue / self._length
  self._currentVaue = 0
end

function UIActivityN21CCShop:OnUpdate(deltaTimeMS)
  if not self._playAnim then
    return
  end
  self._currentVaue = self._currentVaue + deltaTimeMS * self._speed
  self._currentVaue = math.floor(self._currentVaue)
  if self._currentVaue >= self._targetValue then
    self._playAnim = false
    self._currentVaue = self._targetValue
  end
  self._scoreLabel:SetText(self._currentVaue)
  self._scoreShadowLabel:SetText(self._currentVaue)
end

function UIActivityN21CCShop:ShowItemInfo(matid, pos)
  self._tips:SetData(matid, pos)
end

function UIActivityN21CCShop:SelectBoss(bossItem)
  if not bossItem then
    return
  end
  if self._currentBossItem == bossItem then
    return
  end
  if self._currentBossItem then
    self._currentBossItem:SetSelectStatus(false)
  end
  self._currentBossItem = bossItem
  bossItem:SetSelectStatus(true)
  self:RefreshRewardList()
  local bossData = bossItem:GetBossData()
  self._bossIconLoader:LoadImage(bossData:GetBossBigIcon())
  self._scoreLabel:SetText(bossData:GetTotalScore())
  self._scoreShadowLabel:SetText(bossData:GetTotalScore())
end

function UIActivityN21CCShop:RefreshRewardList()
  if not self._currentBossItem then
    return
  end
  local bossData = self._currentBossItem:GetBossData()
  bossData:Refresh()
  local datas = bossData:GetRewardDatas()
  self._itemsLoader:SpawnObjects("UIActivityN21CCShopItem", #datas)
  local items = self._itemsLoader:GetAllSpawnList()
  for i = 1, #items do
    local data = datas[i]
    local item = items[i]
    item:Refresh(data, function(data)
      if self._activityConst:IsActivityEnd() then
        ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
        self:SwitchState(UIStateType.UIMain)
        return
      end
      self:StartTask(self.GetSingleReward, self, data)
    end)
  end
end

function UIActivityN21CCShop:GetSingleReward(TT, data)
  self:Lock("UIActivityN21CCShop_GetSingleReward")
  local personProgress1Component = data:GetProgressComponent()
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  personProgress1Component:HandleReceiveReward(TT, res, data:GetProgress())
  if res:GetSucc() then
    data:SetStatus(UIActivityN21CCShopRewardStatus.HasGet)
    UIActivityN21CCConst.ShowRewards(data:GetRewards(), function()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.N21CCGetScoreReward)
    end)
  else
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CheckErrorCode(res.m_result)
  end
  self:UnLock("UIActivityN21CCShop_GetSingleReward")
end

function UIActivityN21CCShop:BtnGetOnClick()
  if self._activityConst:IsActivityEnd() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  local bossData = self._currentBossItem:GetBossData()
  if bossData == nil or bossData:HasCanGetReward() == false then
    ToastManager.ShowToast(StringTable.Get("str_n20_crisis_contract_cannot_getrewards_tips"))
    return
  end
  self:StartTask(self.GetReward, self)
end

function UIActivityN21CCShop:GetReward(TT)
  self:Lock("UIActivityN21CCShop_GetRewarda")
  local bossData = self._currentBossItem:GetBossData()
  local personProgress1Component = bossData:GetProgressComponent()
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  local rewards = personProgress1Component:HandleOneKeyReceiveRewards(TT, res)
  if res:GetSucc() then
    bossData:GetAllRewards()
    UIActivityN21CCConst.ShowRewards(rewards, function()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.N21CCGetScoreReward)
    end)
  else
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CheckErrorCode(res.m_result)
  end
  self:UnLock("UIActivityN21CCShop_GetRewarda")
end
