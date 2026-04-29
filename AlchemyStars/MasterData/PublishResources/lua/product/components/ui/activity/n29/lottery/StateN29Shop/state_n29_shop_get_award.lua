_class("StateN29ShopGetAward", StateN29ShopBase)
StateN29ShopGetAward = StateN29ShopGetAward

function StateN29ShopGetAward:OnEnter(TT, ...)
  self:Init()
  local rewardRecord = self:GetRewardRecord()
  self:_ShowGetReward(rewardRecord)
end

function StateN29ShopGetAward:OnExit(TT)
  self._uiModule:LockAchievementFinishPanel(false)
end

function StateN29ShopGetAward:_ShowGetReward(record)
  local rewards = record.m_getRewards
  local isOpenNew = record.m_isOpenNew
  self:Sort(rewards)
  local tempPets, assetAwards, hasBig = self:GetPetAssetBig(rewards)
  
  local function cbFunc()
    if isOpenNew then
      local curPageIndex = self:CurPageIndex()
      PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, StringTable.Get("str_n29_shop_new_box_unlock_title"), StringTable.Get("str_n29_shop_open_next_text", curPageIndex, curPageIndex + 1), function()
        self:ForceRefresh(true)
      end, nil)
    elseif hasBig and self.data:GotAllBigAward() then
      PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get("str_n29_shop_loop_box_reset_tips"), function()
        self:ForceRefresh(true)
      end, nil)
    else
      self:ForceRefresh(false)
    end
  end
  
  local getItemCtrl = "UIGetItemController"
  if 0 < #tempPets then
    GameGlobal.UIStateManager():ShowDialog("UIPetObtain", tempPets, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
      GameGlobal.UIStateManager():ShowDialog(getItemCtrl, assetAwards, cbFunc, true)
    end)
  else
    GameGlobal.UIStateManager():ShowDialog(getItemCtrl, assetAwards, cbFunc, true)
  end
end

function StateN29ShopGetAward:Sort(rewards)
  table.sort(rewards, function(a, b)
    local isBigA = a.m_is_big_reward and 1 or 0
    local isBigB = b.m_is_big_reward and 1 or 0
    return isBigA > isBigB
  end)
end

function StateN29ShopGetAward:GetPetAssetBig(rewards)
  local tempPets = {}
  local assetAwards = {}
  local hasBig = false
  if 0 < #rewards then
    for i = 1, #rewards do
      local roleAsset = RoleAsset:New()
      roleAsset.assetid = rewards[i].m_item_id
      roleAsset.count = rewards[i].m_count
      local ispet = self.mPet:IsPetID(roleAsset.assetid)
      if ispet then
        table.insert(tempPets, roleAsset)
      end
      table.insert(assetAwards, roleAsset)
      if rewards[i].m_is_big_reward then
        hasBig = true
      end
    end
  end
  return tempPets, assetAwards, hasBig
end

function StateN29ShopGetAward:ForceRefresh(b)
  local dontPlaySpine
  if not b then
    dontPlaySpine = true
  end
  self:_ForceRefresh(b, dontPlaySpine)
  self:ChangeState(StateN29Shop.Init)
end
