local UIAnimationController = CS.Z1Client.UIAnimationController
local T_UITableview = typeof(CS.UITableview)
local ActivityPassportTaskListComp, Super = System.NewClass("ActivityPassportTaskListComp", ActivityBaseComp)

function ActivityPassportTaskListComp:ctor(res, activityTid, model)
  Super.ctor(self)
  self.ui = UI_Events_Panel_ActivityPassportResource(res)
  self.activityTid = activityTid
  self.model = model
  self.taskList = {}
  self.actCfg = ActivityDataUtils.GetConfig(activityTid)
  self.activityData = self.model:GetActivityDataClient(activityTid)
end

function ActivityPassportTaskListComp:OnBind(binder)
  self.binder = binder
  self.taskList = self:GetTaskList(self.activityTid)
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.binder:SetImageSync(self.ui.Image_Map, self.actCfg.ActivityPicture)
  self.binder:SetText(self.ui.Text_Diary, self.actCfg.ActivityName)
  self.binder:BindButtonClick(self.ui.Btn_PassportUp, System.fn(self, self.OnBuyPassport))
  self.binder:BindButtonClick(self.ui.Btn_Senior, System.fn(self, self.OnBuyPassport))
  self.binder:BindButtonClick(self.ui.Btn_OneKey, System.fn(self, self.OnBtnOneKey))
  self:BindButtonVisible()
  self:BindTip()
  self:_UpdatePrice()
  self:CreateTaskTableView()
  self:_BindActivityTimer()
  self:_BindPortraitComp()
  self:_BindWeapon()
  self:_SetActivityIllustrate()
  self.taskTableView:SetOffset(0, false)
  self.taskTableView:ReloadData()
end

function ActivityPassportTaskListComp:_SetActivityIllustrate()
  self.binder:SetActive(self.ui.Image_Description, false)
end

function ActivityPassportTaskListComp:_GetBgImage()
  do return ActivityDataUtils.GetBgImage end
  return ActivityDataUtils.GetBgImage, self.activityTid
end

function ActivityPassportTaskListComp:_BindWeapon()
  local itemTid = self.actCfg.ActivityItemShow and self.actCfg.ActivityItemShow[1] or nil
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

function ActivityPassportTaskListComp:CreateTaskTableView()
  local baseGameObj = self.ui.UI_Events_Item_GamePassport
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  local sizeVec = CS.UnityEngine.Vector2()
  local tableview = self.ui.ScrollView:GetComponent(T_UITableview)
  local scrollRect = self.ui.ScrollView:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
  if scrollRect then
    scrollRect.scrollSensitivity = cd.ScrollSensitivity
  end
  
  function tableview.numberCellsInTableview()
    return #self.taskList
  end
  
  function tableview.tableCellAtIndex(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local taskInfo = self.taskList[idx + 1]
    local isBoughtPlus = self:IsBuyPassport()
    itemComps[gameObj] = self.binder:BindComponent(ActivityGamePassportItem(gameObj, self.activityTid, taskInfo, isBoughtPlus, nil, self.binder))
    return cell
  end
  
  function tableview.tableCellSizeForIndex(view, index)
    sizeVec.x = itemW
    sizeVec.y = itemH
    return sizeVec
  end
  
  self.taskTableView = tableview
  if self.taskTableView.isReady then
    self:_JumpToRewardIdx()
  else
    function self.taskTableView.reloadFinishCallback()
      self.taskTableView.reloadFinishCallback = nil
      
      self:_JumpToRewardIdx()
    end
  end
end

function ActivityPassportTaskListComp:_JumpToRewardIdx()
  local targetIdx = 1
  for idx, taskInfo in ipairs(self.taskList) do
    local normalTaskTid = taskInfo[1]
    local paidTaskTid = taskInfo[2]
    if TaskDataUtils.IsTaskCanReward(normalTaskTid) then
      targetIdx = idx
      break
    end
    if self:IsBuyPassport() and TaskDataUtils.IsTaskCanReward(paidTaskTid) then
      targetIdx = idx
      break
    end
  end
  local offset = self.taskTableView:GetOffsetByIndex(targetIdx - 1)
  self.taskTableView:SetOffset(offset, false)
end

function ActivityPassportTaskListComp:GetTaskList(activityTid)
  do return ActivityDataUtils.GetGamePassportTaskList end
  return ActivityDataUtils.GetGamePassportTaskList, activityTid
end

function ActivityPassportTaskListComp:GetAllPlusRewards()
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

function ActivityPassportTaskListComp:IsBuyPassport()
  return self.activityData and self.activityData.isUnlockExtraTask
end

function ActivityPassportTaskListComp:GetChargeTid()
  local actCfg = ActivityDataUtils.GetConfig(self.activityTid)
  if not actCfg then
    return
  end
  local buyItemTid, _, chargeGroup = table.unpack(actCfg.ActivityPara4)
  local chargeId = ShopDataUtils.GetChargeIdByChargeGroup(chargeGroup, true)
  return chargeId, buyItemTid
end

function ActivityPassportTaskListComp:OnBuyPassport()
  if self:IsBuyPassport() then
    return
  end
  local chargeTid, buyItemTid = self:GetChargeTid()
  local buyItemCfg = ItemDataUtils.GetItemConfig(buyItemTid)
  local buyInfo = {
    buyItem = buyItemTid,
    buyCallback = function()
      local chargeCfg = ShopDataUtils.GetChargeCfgById(chargeTid)
      if chargeCfg then
        local function onPlayFinished(payCode, id, isSucceess)
          if payCode == chargeCfg.PayCode and id == chargeCfg.ID and isSucceess then
            if self.activityData then
              ActivityManager.Instance.model:SetActUnlockPassport(self.activityData, true)
              
              self.taskTableView:ReloadData()
            end
            UIManager.Instance:CloseByUrl(Urls.GamePassportBuyPanel)
          end
        end
        
        SdkMgr.Instance:Pay(chargeCfg.PayCode, chargeCfg.ID, onPlayFinished, true)
        return
      end
    end,
    rewards = self:GetAllPlusRewards(),
    desc = buyItemCfg.Desc,
    actPromotional = self.actCfg.ActivityPromotionalText1,
    costItem = chargeTid
  }
  UIManager.Instance:Reopen(Urls.GamePassportBuyPanel, buyInfo)
end

function ActivityPassportTaskListComp:_ReqOnGainAllPrize()
  ActivityDataUtils.ReqOnGainAllPrize(self.activityTid, function()
    self.binder:SetActive(self.ui.Btn_OneKey, false)
    self:MarkAllTaskRewardGot()
  end)
end

function ActivityPassportTaskListComp:OnBtnOneKey()
  if ActivityDataUtils.CheckPassportPassportTaskListEnergyIsOverMax(self.activityTid, self:IsBuyPassport()) then
    GetEnergyCheckUtils.TipsShow(function()
      self:_ReqOnGainAllPrize()
    end)
    return
  end
  self:_ReqOnGainAllPrize()
end

function ActivityPassportTaskListComp:MarkAllTaskRewardGot()
  for _, taskInfo in ipairs(self.taskList) do
    local task1, task2 = taskInfo[1], taskInfo[2]
    local taskData1 = TaskDataUtils.GetTaskData(task1)
    if taskData1 and taskData1.state == cd.TaskState.Receive then
      taskData1.state = cd.TaskState.Done
    end
    local taskData2 = TaskDataUtils.GetTaskData(task2)
    if taskData2 and taskData2.state == cd.TaskState.Receive then
      taskData2.state = cd.TaskState.Done
    end
  end
end

function ActivityPassportTaskListComp:OnOpenAnim(callback)
  Binder.PlayTableViewFadeInAnim(self.binder, self.ui.ScrollView)
  self.uiAnimController:PlayState("UI_Events_Panel_GamePassport_Open", callback)
end

function ActivityPassportTaskListComp:OnCloseAnim(callback)
  if callback then
    callback()
  end
end

function ActivityPassportTaskListComp:_UpdatePrice()
  local chargeTid = self:GetChargeTid()
  local chargeCfg = chargeTid and ShopDataUtils.GetChargeCfgById(chargeTid)
  if chargeCfg then
    self.binder:SetText(self.ui.Text_C_PassportUp, ShopDataUtils.GetChargePriceStr(chargeTid))
  end
end

function ActivityPassportTaskListComp:BindButtonVisible()
  self.binder:BindToVisible(self.ui.Btn_PassportUp, function()
    return not self:IsBuyPassport()
  end)
  self.binder:BindToVisible(self.ui.Btn_OneKey, System.fn(self, self.IsShowOneKey))
  self.binder:BindToVisible(self.ui.Image_Lock, function()
    return not self:IsBuyPassport()
  end)
end

function ActivityPassportTaskListComp:BindTip()
  local ActivityPromotionalText1 = LT.Text(self.actCfg.ActivityPromotionalText1) or ""
  local GamePassportTip = LT.Text("GamePassportTip")
  self.binder:BindToVisible(self.ui.Image_Tip, function()
    return not self:IsBuyPassport() or not string.isempty(ActivityPromotionalText1)
  end)
  self.binder:BindToText(self.ui.Text_Tip, function()
    local tip = ""
    if string.isempty(ActivityPromotionalText1) then
      tip = GamePassportTip
      self.binder:SetActive(self.ui.Image_Tip, not self:IsBuyPassport())
    else
      self.binder:SetActive(self.ui.Image_Tip, true)
      if self:IsBuyPassport() then
        tip = ActivityPromotionalText1
      else
        tip = GamePassportTip .. "\n" .. ActivityPromotionalText1
      end
    end
    return tip
  end)
end

function ActivityPassportTaskListComp:IsShowOneKey()
  if not self:IsBuyPassport() then
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
end

return ActivityPassportTaskListComp
