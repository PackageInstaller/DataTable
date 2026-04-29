_class("UISignInActBoxTipsController", UIController)
UISignInActBoxTipsController = UISignInActBoxTipsController

function UISignInActBoxTipsController:OnShow(uiParams)
  self._endTime = uiParams[1]
  self._svrModule = GameGlobal.GetModule(SvrTimeModule)
  self._timeTex = self:GetUIComponent("UILocalizationText", "timeTex")
  if self._endTime then
    self:ShowTime()
    self._event = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
      self:ShowTime()
    end)
  else
    self._timeTex:SetText("")
  end
  local itemInfo = self:GetUIComponent("UISelectObjectPath", "itemInfo")
  self._selectInfo = itemInfo:SpawnObject("UISelectInfo")
  self:ShowAwards()
end

function UISignInActBoxTipsController:ShowTime()
  local nowTime = math.ceil(self._svrModule:GetServerTime() * 0.001)
  local timeDown = self._endTime - nowTime
  if 0 < timeDown then
    local timeStr = HelperProxy:GetInstance():Time2Tex(timeDown)
    self._timeTex:SetText(StringTable.Get("str_sign_in_act_box_time", timeStr))
  else
    self:CloseDialog()
  end
end

function UISignInActBoxTipsController:ItemClick(id, pos)
  if self._selectInfo then
    self._selectInfo:SetData(id, pos)
  end
end

function UISignInActBoxTipsController:ShowAwards()
  local showAwards = Cfg.cfg_global.sign_activity_reward_id.TableValue.showAwards
  local awards = {}
  for i = 1, #showAwards do
    local id = showAwards[i]
    local count = 1
    local roleAsset = RoleAsset:New()
    roleAsset.assetid = id
    roleAsset.count = count
    table.insert(awards, roleAsset)
  end
  local pool = self:GetUIComponent("UISelectObjectPath", "layout")
  pool:SpawnObjects("UISignInActBoxItem", #awards)
  local list = pool:GetAllSpawnList()
  for i = 1, #list do
    local item = list[i]
    item:SetData(i, awards[i], function(id, pos)
      self:ItemClick(id, pos)
    end, false, true)
  end
end

function UISignInActBoxTipsController:OnHide()
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
end

function UISignInActBoxTipsController:BgOnClick()
  self:CloseDialog()
end
