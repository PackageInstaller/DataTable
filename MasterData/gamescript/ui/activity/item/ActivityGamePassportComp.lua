local Aniversary2ndTaskActivityTid = DT.GetConstant("Aniversary2ndTaskActivityTid")
local ActivityGamePassportComp, Super = System.NewClass("ActivityGamePassportComp", ActivityBaseComp)
ActivityGamePassportComp.uiResCls = UI_Events_Panel_GamePassportResource
local UIAnimationController = CS.Z1Client.UIAnimationController

function ActivityGamePassportComp:ctor(_, activityTid)
  Super.ctor(self)
  self.activityTid = activityTid
  self.taskList = {}
  self.activityData = ActivityManager.Instance.model:GetActivityDataClient(activityTid)
  self.activityConfig = ActivityDataUtils.GetConfig(activityTid)
end

function ActivityGamePassportComp:Show()
  Super.Show(self)
  self.animController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.animController:StopPlayableGraph()
  self.animController:PlayState("UI_Events_Panel_GamePassport_Open")
  UIBasePanel.PlayTableViewFadeInAnim(self, self.ui.ScrollView)
end

function ActivityGamePassportComp:OnBind(binder)
  self.binder = binder
  self:CreateTaskTableView()
  self:RefreshGamePassPort()
  self:OnBindButtons(binder)
  self:BindButtonVisible()
  self:BindTip()
  self:_BindPortraitComp()
  self:SetBgImage()
  self:BindTexts()
  self:HideGameObjsInActivityPanel()
  self:_BindLetter()
  self:_BindWeapon()
  self:_BindActivityTimer()
  self:_BindLoadVXFx()
end

function ActivityGamePassportComp:_BindLetter()
  if not self.ui.Btn_Letter then
    return
  end
  self.binder:BindToVisible(self.ui.Btn_Letter, function()
    return Aniversary2ndTaskActivityTid == self.activityTid
  end)
  self.binder:BindButtonClick(self.ui.Btn_Letter, System.fn(self, self.OnClickLetter))
end

function ActivityGamePassportComp:OnClickLetter()
  UIManager.Instance:Reopen(Urls.Activity2ndAnniversaryInviteView)
end

function ActivityGamePassportComp:BindTexts()
  self.binder:SetText(self.ui.Text_Diary, self.activityConfig.ActivityName)
  self.binder:SetText(self.ui.Text_C_PassportUp, LT.Text("LevelUpGamePassport"))
  self.binder:SetText(self.ui.Text_C_Ordinary, LT.Text("NormalGamePassport"))
  self.binder:SetText(self.ui.Text_C_Senior, LT.Text("PlusGamePassport"))
  self.binder:SetText(self.ui.Text_C_OneKey, LT.Text("DispatchReceiveAll"))
end

function ActivityGamePassportComp:SetBgImage()
  if UIManager.Instance:GetWindow(Urls.ActivityMainPanel) then
    self.binder:SetActive(self.ui.Image_Map, true)
    self.binder:SetImageSync(self.ui.Image_Map, ActivityDataUtils.GetBgImage(self.activityTid))
  else
    self.binder:SetActive(self.ui.Image_Map, false)
  end
end

function ActivityGamePassportComp:_BindWeapon()
  local itemTid = self.activityConfig.ActivityItemShow and self.activityConfig.ActivityItemShow[1] or nil
  self.binder:SetActive(self.ui.WeaponCon, itemTid)
  if not itemTid then
    return
  end
  local itemCfg = DT.Item[itemTid]
  if itemCfg.Type ~= CommonDefine.ItemType.Weapon then
    return
  end
  if self._weaponPrefabComp then
    self._weaponPrefabComp.binder:teardown()
  end
  self._weaponPrefabComp = self.binder:BindComponent(AwakerWeaponPrefab(self.ui.Group_WeaponPrefab, itemCfg.SpIcon, 0.82))
  self.binder:BindButtonClick(self.ui.Group_WeaponPrefab, function()
    ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Group_WeaponPrefab, nil, itemTid)
  end)
end

function ActivityGamePassportComp:OnBindButtons(binder)
  binder:BindButtonClick(self.ui.Btn_Senior, System.fn(self, self.OnBuyPassport))
  binder:BindButtonClick(self.ui.Btn_PassportUp, System.fn(self, self.OnBuyPassport))
  binder:BindButtonClick(self.ui.Btn_OneKey, System.fn(self, self.OnBtnOneKey))
  binder:BindEvent(EventMgr.Instance.OnTryBuyPassport, System.fn(self, self.OnTryBuyPassport))
  binder:BindEvent(EventMgr.Instance.OnActivityDataSynced, System.fn(self, self.RefreshGamePassPort))
  binder:BindZ1Button(self.ui.UI_Common_Btn_Question, System.fn(self, self._OnClickIntro))
end

function ActivityGamePassportComp:BindButtonVisible()
  self.binder:BindToVisible(self.ui.Btn_PassportUp, function()
    return not self:IsBoughtPassport()
  end)
  self.binder:BindToVisible(self.ui.Btn_OneKey, System.fn(self, self.IsShowOneKey))
  self.binder:BindToVisible(self.ui.Image_Lock, function()
    return not self:IsBoughtPassport()
  end)
  self.binder:BindToVisible(self.ui.UI_Common_Btn_Question, System.fn(self, self._IsIntroVisible))
end

function ActivityGamePassportComp:HideGameObjsInActivityPanel()
  if not UIManager.Instance:GetWindow(Urls.ActivityMainPanel) then
    return
  end
  self.binder:BindTimer(0, -1, function()
    self.binder:SetActive(self.ui.Image_Description, false)
  end)
end

function ActivityGamePassportComp:BindTip()
  local ActivityPromotionalText1 = LT.Text(self.activityConfig.ActivityPromotionalText1) or ""
  local GamePassportTip = LT.Text("GamePassportTip")
  self.binder:BindToVisible(self.ui.Image_Tip, function()
    return not self:IsBoughtPassport() or not string.isempty(ActivityPromotionalText1)
  end)
  self.binder:BindToText(self.ui.Text_Tip, function()
    local tip = ""
    if string.isempty(ActivityPromotionalText1) then
      tip = GamePassportTip
      self.binder:SetActive(self.ui.Image_Tip, not self:IsBoughtPassport())
    else
      self.binder:SetActive(self.ui.Image_Tip, true)
      if self:IsBoughtPassport() then
        tip = ActivityPromotionalText1
      else
        tip = GamePassportTip .. "\n" .. ActivityPromotionalText1
      end
    end
    return tip
  end)
end

function ActivityGamePassportComp:IsBoughtPassport()
  return self.activityData and self.activityData.isUnlockExtraTask
end

function ActivityGamePassportComp:RefreshGamePassPort()
  self.taskList = self:GetTaskList(self.activityTid)
  self.taskTableView:ReloadData()
end

function ActivityGamePassportComp:GetTaskList(activityTid)
  do return ActivityDataUtils.GetGamePassportTaskList end
  return ActivityDataUtils.GetGamePassportTaskList, activityTid
end

function ActivityGamePassportComp:CreateTaskTableView()
  local gameObjLess4 = self.ui.UI_Events_Item_GamePassport
  local sizeDelta = gameObjLess4.transform.sizeDelta
  local itemWLess4, itemHLess4 = sizeDelta.x, sizeDelta.y
  local gameObjGT4 = self.ui.UI_Events_Item_GamePassport2
  sizeDelta = gameObjGT4.transform.sizeDelta
  local itemWGT4, itemHGT4 = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  self.taskTableView = self:CreateTableview(self.ui.ScrollView, function()
    return #self.taskList
  end, function(view, idx)
    local cell = view:DequeueCell()
    if not cell then
      if #self.taskList <= 4 then
        cell = view:AddChild(gameObjLess4)
      else
        cell = view:AddChild(gameObjGT4)
      end
    end
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local taskInfo = self.taskList[idx]
    local isBoughtPlus = self:IsBoughtPassport()
    local reqTaskRewards = System.fn(self, self.OnBtnOneKey)
    itemComps[gameObj] = self.binder:BindComponent(ActivityGamePassportItem(gameObj, self.activityTid, taskInfo, isBoughtPlus, reqTaskRewards, self.binder))
    return cell
  end, function(view, index)
    if #self.taskList <= 4 then
      return itemWLess4, itemHLess4
    else
      return itemWGT4, itemHGT4
    end
  end, function()
    itemComps = nil
  end)
  if self.taskTableView.isReady then
    self:_JumpToRewardIdx()
  else
    function self.taskTableView.reloadFinishCallback()
      self.taskTableView.reloadFinishCallback = nil
      
      self:_JumpToRewardIdx()
    end
  end
end

function ActivityGamePassportComp:OnBtnOneKey()
  ActivityDataUtils.ReqOnGainAllPrize(self.activityTid, function()
    self.binder:SetActive(self.ui.Btn_OneKey, false)
  end)
end

function ActivityGamePassportComp:_JumpToRewardIdx()
  local targetIdx = 1
  for idx, taskInfo in ipairs(self.taskList) do
    local normalTaskTid = taskInfo[1]
    local paidTaskTid = taskInfo[2]
    if TaskDataUtils.IsTaskCanReward(normalTaskTid) then
      targetIdx = idx
      break
    end
    if self:IsBoughtPassport() and TaskDataUtils.IsTaskCanReward(paidTaskTid) then
      targetIdx = idx
      break
    end
  end
  local offset = self.taskTableView:GetOffsetByIndex(targetIdx - 1)
  self.taskTableView:SetOffset(offset, false)
end

function ActivityGamePassportComp:MarkAllTaskRewardGot()
  local isBoughtPlus = self:IsBoughtPassport()
  for _, taskInfo in ipairs(self.taskList) do
    local task1, task2 = taskInfo[1], taskInfo[2]
    local taskData1 = TaskDataUtils.GetTaskData(task1)
    if taskData1 and taskData1.state == cd.TaskState.Receive then
      taskData1.state = cd.TaskState.Done
    end
    local taskData2 = TaskDataUtils.GetTaskData(task2)
    if taskData2 and taskData2.state == cd.TaskState.Receive and isBoughtPlus then
      taskData2.state = cd.TaskState.Done
    end
  end
end

function ActivityGamePassportComp:IsShowOneKey()
  if not self:IsBoughtPassport() then
    return
  end
  local oneKeyRewardCount = 1
  local rewardCount = 0
  for _, taskInfo in ipairs(self.taskList) do
    local task1, task2 = taskInfo[1], taskInfo[2]
    if TaskDataUtils.IsTaskCanReward(task1) then
      rewardCount = rewardCount + 1
    end
    if TaskDataUtils.IsTaskCanReward(task2) then
      rewardCount = rewardCount + 1
    end
    if oneKeyRewardCount <= rewardCount then
      return true
    end
  end
  return false
end

function ActivityGamePassportComp:OnTryBuyPassport(activityTid)
  if activityTid ~= self.activityTid then
    return
  end
  self:OnBuyPassport()
end

function ActivityGamePassportComp:OnBuyPassport()
  if self:IsBoughtPassport() then
    return
  end
  local shopItem, shopCfg = self:GetShopTidAndConfig()
  assert(shopItem and shopCfg, string.format("活动：%s 购买的通行证数据有误 ActivityPara4", self.activityConfig.ActivityName))
  local buyItem = shopCfg.Item[1]
  local buyItemCfg = ItemDataUtils.GetItemConfig(buyItem) or {}
  local buyInfo = {
    buyItem = shopItem,
    buyCallback = function()
      MainShopDataUtils.ReqOnShopBuyGoods(shopItem, shopCfg.ShopType, 1, function(data)
        if self.activityData then
          ActivityManager.Instance.model:SetActUnlockPassport(self.activityData, true)
          self.taskTableView:ReloadData()
        end
        UIManager.Instance:CloseByUrl(Urls.GamePassportBuyPanel)
      end)
    end,
    rewards = self:GetAllPlusRewards(),
    desc = buyItemCfg.Desc,
    actPromotional = self.activityConfig.ActivityPromotionalText1,
    costItem = shopCfg.Price[1],
    costNum = shopCfg.Price[2]
  }
  UIManager.Instance:Reopen(Urls.GamePassportBuyPanel, buyInfo)
end

function ActivityGamePassportComp:GetShopTidAndConfig()
  local actCfg = ActivityDataUtils.GetConfig(self.activityTid)
  if not actCfg then
    return
  end
  local _, shopItemTid = table.unpack(actCfg.ActivityPara4)
  if shopItemTid then
    local shopItemCfg = DT.Shop[shopItemTid]
    if not shopItemCfg then
      return
    end
    return shopItemTid, shopItemCfg
  end
end

function ActivityGamePassportComp:_OnClickIntro()
  local title = ActivityDataUtils.GetRuleTitle(self.activityTid)
  local content = ActivityDataUtils.GetRuleContent(self.activityTid)
  if content then
    UIManager.Instance:Reopen(Urls.CommonillustrateView, title, content)
  end
end

function ActivityGamePassportComp:_IsIntroVisible()
  if self.activityTid then
    local content = ActivityDataUtils.GetRuleContent(self.activityTid)
    return nil ~= content
  end
end

function ActivityGamePassportComp:GetAllPlusRewards()
  local rewardMap = {}
  for _, taskInfo in ipairs(self.taskList) do
    local plusTask = taskInfo[2]
    local taskCfg = TaskDataUtils.GetTaskConfigByTid(plusTask)
    local ExtraAward = taskCfg.ExtraAward or {}
    for rewardId, num in table.iteraDouble(ExtraAward) do
      rewardMap[rewardId] = (rewardMap[rewardId] or 0) + num
    end
  end
  local rewards = {}
  for itemTid, num in pairs(rewardMap) do
    table.insert(rewards, {
      tid = itemTid,
      num = num,
      itemCfg = ItemDataUtils.GetItemConfig(itemTid)
    })
  end
  table.sort(rewards, function(a, b)
    local cfg1 = a.itemCfg
    local cfg2 = b.itemCfg
    if not ItemDataUtils.IsSameQuality(cfg1, cfg2) then
      do return ItemDataUtils.IsSeniorQuality, cfg1 end
      return ItemDataUtils.IsSeniorQuality, cfg1, cfg2
    end
    return cfg1.BaseSortID < cfg2.BaseSortID
  end)
  return rewards
end

return ActivityGamePassportComp
