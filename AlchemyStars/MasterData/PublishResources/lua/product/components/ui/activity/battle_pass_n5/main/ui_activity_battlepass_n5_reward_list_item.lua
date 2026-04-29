_class("UIActivityBattlePassN5RewardListItem", UICustomWidget)
UIActivityBattlePassN5RewardListItem = UIActivityBattlePassN5RewardListItem

function UIActivityBattlePassN5RewardListItem:SetData_Fixed(component)
  self._component = component
  self._info = component:ComponentInfo()
  self:_SetLevel()
  self:_SetCell({
    adv = false,
    fix = true,
    sp = false
  })
  self:_SetCell({
    adv = true,
    fix = true,
    sp = false
  })
end

function UIActivityBattlePassN5RewardListItem:SetData(index, component, clickCallback, tipCallback)
  self._index = index
  self._component = component
  self._info = component:ComponentInfo()
  self._clickCallback = clickCallback
  self._tipCallback = tipCallback
  self:_SetState()
  self:_SetLevel(self._index)
  self:_SetCell({adv = false, fix = false})
  self:_SetCell({adv = true, fix = false})
end

function UIActivityBattlePassN5RewardListItem:OnShow(uiParams)
end

function UIActivityBattlePassN5RewardListItem:OnHide()
end

function UIActivityBattlePassN5RewardListItem:_SetState()
  local lvUnlock = self._index <= self._info.m_current_level and 1 or 2
  local tb_lv = {
    {
      self:GetGameObject("state_LvUnlock")
    },
    {
      self:GetGameObject("state_LvLock")
    }
  }
  UIWidgetHelper.SetObjGroupShow(tb_lv, lvUnlock)
  local goldReward = self._component:IsPreviewLvFromConfig(self._index) and 1 or 2
  local tb_reward = {
    {
      self:GetGameObject("state_GoldReward"),
      self:GetGameObject("state_GoldReward2")
    },
    {
      self:GetGameObject("state_NormalReward"),
      self:GetGameObject("state_NormalReward2")
    }
  }
  UIWidgetHelper.SetObjGroupShow(tb_reward, goldReward)
end

function UIActivityBattlePassN5RewardListItem:_SetLevel(lv)
  if lv and lv < 10 then
    lv = "0" .. lv
  elseif string.isnullorempty(lv) then
    lv = ""
  end
  local tb = {
    self:GetUIComponent("UILocalizationText", "txt_Unlock_Gold"),
    self:GetUIComponent("UILocalizationText", "txt_Unlock_Normal"),
    self:GetUIComponent("UILocalizationText", "txt_Lock_Gold"),
    self:GetUIComponent("UILocalizationText", "txt_Lock_Normal")
  }
  for _, v in pairs(tb) do
    v:SetText(tostring(lv))
  end
end

function UIActivityBattlePassN5RewardListItem:_SetCell(args)
  local id = args.adv and "deluxePool" or "standardPool"
  local sop = self:GetUIComponent("UISelectObjectPath", id)
  local obj = sop:SpawnObject("UIActivityBattlePassN5ItemIconReward")
  if not args.fix then
    obj:SetData(self._index, args.adv, self._component, self._clickCallback, self._tipCallback)
  else
    obj:SetData_Fixed(args.adv, self._component)
  end
end
