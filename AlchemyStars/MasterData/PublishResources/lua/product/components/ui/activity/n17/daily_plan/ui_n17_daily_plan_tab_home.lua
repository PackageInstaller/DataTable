_class("UIN17DailyPlanTabHome", UICustomWidget)
UIN17DailyPlanTabHome = UIN17DailyPlanTabHome

function UIN17DailyPlanTabHome:OnShow(uiParams)
  self._isOpen = true
end

function UIN17DailyPlanTabHome:OnHide()
  self._isOpen = false
end

function UIN17DailyPlanTabHome:SetData(component, inHome, closeCallback)
  self._inHome = inHome
  self._closeCallback = closeCallback
  self:_SetCoinInfo(component)
  self:_SetList(component)
  self:_SetTip(component)
  self:_SetHint(component)
end

function UIN17DailyPlanTabHome:_SetCoinInfo(component)
  local obj = UIWidgetHelper.SpawnObject(self, "_coinPool", "UIN17DailyPlanCoin")
  obj:SetData(component)
end

function UIN17DailyPlanTabHome:_SetList(component)
  local info = component:GetConditionDesc()
  local url = component:GetKeyRewardIcon()
  local objs = UIWidgetHelper.SpawnObjects(self, "_list", "UIN17DailyPlanTabHomeListItem", #info)
  for i, v in ipairs(objs) do
    v:SetData(i, info[i].Desc, info[i].Reward, url)
  end
end

function UIN17DailyPlanTabHome:_SetTip(component)
  local limitDay, limitMax = component:GetLimitTipCount()
  local text = StringTable.Get("str_n17_daily_plan_home_limit_tip", limitDay, limitMax)
  UIWidgetHelper.SetLocalizationText(self, "_desc", text)
end

function UIN17DailyPlanTabHome:_SetHint(component)
  local cur, max = component:GetKeyRewardCount()
  local show = max <= cur
  self:GetGameObject("_hint"):SetActive(show)
end

function UIN17DailyPlanTabHome:BtnOnClick()
  if self._inHome then
    if self._closeCallback then
      self._closeCallback()
    end
  else
    local module = GameGlobal.GetModule(RoleModule)
    local isLock = not module:CheckModuleUnlock(GameModuleID.MD_HomeLand)
    if isLock then
      ToastManager.ShowToast(StringTable.Get("str_function_lock_unlock"))
    else
      GameGlobal.GetModule(HomelandModule):GetUIModule():LoadHomeland()
    end
  end
end
