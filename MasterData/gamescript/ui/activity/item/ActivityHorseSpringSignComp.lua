local MAX_SIGN_COUNT = 7
local UIAnimationController = CS.Z1Client.UIAnimationController
local ActivityHorseSpringSignComp, Super = System.NewClass("ActivityHorseSpringSignComp", ActivityBaseComp)

function ActivityHorseSpringSignComp:ctor(res, activityTid, model, params)
  Super.ctor(self, res, activityTid, model, params)
  self.ui = UI_Events_Panel_SpringSignResource(res)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
  self.activityConfig = ActivityDataUtils.GetConfig(activityTid)
  self.params = params or {}
end

function ActivityHorseSpringSignComp:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.awardList = self:GetAwardList()
  self:_RefreshSighItemList()
  self:_RefreshCountDown()
  binder:BindTimer(1, -1, System.fn(self, self._RefreshCountDown))
  if self.ui.Text_Title then
    self.binder:SetText(self.ui.Text_Title, self.params.title or LT.Text(self.activityConfig.ActivityName))
  end
  if self.ui.Text_Desc and self.params.desc then
    self.binder:SetText(self.ui.Text_Desc, self.params.desc)
  end
end

function ActivityHorseSpringSignComp:_RefreshSighItemList()
  for i = 1, MAX_SIGN_COUNT do
    local signItemUi = self.ui["Item_SignDay_" .. i]
    local viewData = {
      awardState = self.activityData.prize[i],
      awardList = self.awardList[i],
      idx = i,
      activityTid = self.activityData.activityTid,
      dontShowName = true
    }
    self.binder:BindComponent(ActivitySpringSevenDaySignItem(signItemUi, viewData))
  end
end

function ActivityHorseSpringSignComp:GetAwardList()
  if self.awardList then
    return self.awardList
  end
  local actCfg = DT.Activity[self.activityTid]
  local ret = {}
  for i = 1, MAX_SIGN_COUNT do
    local awards = {}
    if actCfg.ActivityPara1 then
      table.insert(awards, actCfg.ActivityPara1[i * 2 - 1])
      table.insert(awards, actCfg.ActivityPara1[i * 2])
    end
    if actCfg.ActivityPara4 then
      table.insert(awards, actCfg.ActivityPara4[i * 2 - 1])
      table.insert(awards, actCfg.ActivityPara4[i * 2])
    end
    table.insert(ret, awards)
  end
  return ret
end

function ActivityHorseSpringSignComp:_RefreshCountDown()
  ActivityUiUtils.RefreshActivityCountDown(self.binder, self.ui.Text_Time, self.activityData)
end

function ActivityHorseSpringSignComp:OnOpenAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Panel_SpringSign_Open", callback)
end

function ActivityHorseSpringSignComp:OnCloseAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Panel_SpringSign_Close", callback)
end

return ActivityHorseSpringSignComp
