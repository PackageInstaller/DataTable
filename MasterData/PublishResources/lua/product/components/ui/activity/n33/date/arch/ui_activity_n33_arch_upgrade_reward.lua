_class("UIActivityN33ArchUpgradeReward", UIController)
UIActivityN33ArchUpgradeReward = UIActivityN33ArchUpgradeReward
local ARCH_LEVEL_MAX_CONST = 4

function UIActivityN33ArchUpgradeReward:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIActivityN33ArchUpgradeReward:OnShow(...)
  self:InitWidget()
  local data = table.unpack({
    ...
  })
  local archID = data[1]
  local currArchLv = data[2]
  local rewards = data[3]
  self.activityConst = data[4]
  self.rewards = rewards
  self:RefreshUI(archID, currArchLv, rewards)
  self:PlayAnim(true)
end

function UIActivityN33ArchUpgradeReward:InitWidget()
  self.rootNode = self:GetGameObject("RootNode")
  self.titleNode = self:GetGameObject("TitleNode")
  self.rewardNode = self:GetGameObject("RewardNode")
  self.closeBtn = self:GetUIComponent("Image", "CloseBtn")
  self.titleText = self:GetUIComponent("UILocalizationText", "TitleText")
  self.currDesText = self:GetUIComponent("UILocalizationText", "currDesText")
  self.rewardUnlockText = self:GetUIComponent("UILocalizationText", "RewardUnlockText")
  self.rewardItemText = self:GetUIComponent("UILocalizationText", "RewardItemText")
  self.rewardHeadList = self:GetUIComponent("UISelectObjectPath", "RewardHeadList")
  self.rewardItemList = self:GetGameObject("RewardItemList")
  self.rewardItemParent = self:GetGameObject("RewardItemParent")
  self.rewardItemGo = self:GetGameObject("RewardItem")
  self.rewardPetGo = self:GetGameObject("PetReward")
  self.rewardItem = self:GetUIComponent("UISelectObjectPath", "RewardItem")
  self.petReward = self:GetUIComponent("UISelectObjectPath", "PetReward")
  self.petRewardParent = self:GetGameObject("PetRewardParent")
  self.currStarNode_1 = self:GetUIComponent("Image", "currStarNode_1")
  self.currStarNode_2 = self:GetUIComponent("Image", "currStarNode_2")
  self.currStarNode_3 = self:GetUIComponent("Image", "currStarNode_3")
  self.currStarNode_4 = self:GetUIComponent("Image", "currStarNode_4")
  self.nextDesText = self:GetUIComponent("UILocalizationText", "nextDesText")
  self.nextStarNode_1 = self:GetUIComponent("Image", "nextStarNode_1")
  self.nextStarNode_2 = self:GetUIComponent("Image", "nextStarNode_2")
  self.nextStarNode_3 = self:GetUIComponent("Image", "nextStarNode_3")
  self.nextStarNode_4 = self:GetUIComponent("Image", "nextStarNode_4")
  self._anim = self:GetGameObject():GetComponent("Animation")
end

function UIActivityN33ArchUpgradeReward:RefreshUI(archID, currArchLv, rewards)
  if currArchLv >= ARCH_LEVEL_MAX_CONST then
    self.titleText:SetText(StringTable.Get("str_n33_date_upgrade_reward_key1"))
  else
    self.titleText:SetText(StringTable.Get("str_n33_date_upgrade_reward_key2"))
  end
  self.rewardUnlockText:SetText(StringTable.Get("str_n33_date_arch_info_key5"))
  self.rewardItemText:SetText(StringTable.Get("str_n33_date_arch_info_key6"))
  for i = 1, ARCH_LEVEL_MAX_CONST do
    self["currStarNode_" .. i].gameObject:SetActive(i == currArchLv - 1)
    self["nextStarNode_" .. i].gameObject:SetActive(i == currArchLv)
  end
  local currCfg = Cfg.cfg_component_simulation_operation({ArchitectureId = archID, Level = currArchLv})[1]
  local preCfg = Cfg.cfg_component_simulation_operation({
    ArchitectureId = archID,
    Level = currArchLv - 1
  })[1]
  self.currDesText:SetText(StringTable.Get(preCfg.Name))
  self.nextDesText:SetText(StringTable.Get(currCfg.Name))
  self:RefreshUI_RewardList(rewards)
  self:RefreshUI_RewardPetList(currCfg.StoryList)
  self.closeBtn.gameObject:SetActive(true)
end

function UIActivityN33ArchUpgradeReward:RefreshUI_RewardList(rewards)
  local rewardCount = table.count(rewards)
  for i = 1, rewardCount do
    local item = UnityEngine.GameObject.Instantiate(self.rewardItemGo, self.rewardItemParent.transform)
    item:SetActive(true)
    local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
    local itemWidget = rowPool:SpawnObject("UIActivityN33RewardItem")
    itemWidget:SetRewardData_Item(rewards[i], false, self.activityConst)
  end
end

function UIActivityN33ArchUpgradeReward:RefreshUI_RewardPetList(storyList)
  if not storyList then
    return
  end
  local rewardCount = table.count(storyList)
  for i = 1, rewardCount do
    local item = UnityEngine.GameObject.Instantiate(self.rewardPetGo, self.petRewardParent.transform)
    item:SetActive(true)
    local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
    local itemWidget = rowPool:SpawnObject("UIActivityN33RewardItem")
    itemWidget:SetRewardData_PetStory(storyList[i], false, self.activityConst)
  end
end

function UIActivityN33ArchUpgradeReward:CloseBtnOnClick(go)
  if self.activityConst:CheckSimulationOperationIsOver() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIActivityN33MainController)
    return
  end
  self:ShowDialog("UIGetItemController", self.rewards, function()
    self:PlayAnim(false, function()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN33UpgradeRewardOver)
      self:CloseDialog()
    end)
  end, true)
end

function UIActivityN33ArchUpgradeReward:PlayAnim(isIn, callback)
  if isIn then
    self:StartTask(function(TT)
      self:Lock("uieffanim_UIActivityN33ArchUpgradeReward_in")
      self._anim:Play("uieffanim_UIActivityN33ArchUpgradeReward_in")
      YIELD(TT, 2000)
      self:UnLock("uieffanim_UIActivityN33ArchUpgradeReward_in")
      self:_CheckGuide()
      if callback then
        callback()
      end
    end, self)
  else
    self:StartTask(function(TT)
      self:Lock("uieffanim_UIActivityN33ArchUpgradeReward_out")
      self._anim:Play("uieffanim_UIActivityN33ArchUpgradeReward_out")
      YIELD(TT, 250)
      self:UnLock("uieffanim_UIActivityN33ArchUpgradeReward_out")
      self:_CheckGuide()
      if callback then
        callback()
      end
    end, self)
  end
end

function UIActivityN33ArchUpgradeReward:_CheckGuide()
  local guideModule = GameGlobal.GetModule(GuideModule)
  if not guideModule:IsGuideDone(123004) then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN33ArchUpgradeReward)
  end
end
