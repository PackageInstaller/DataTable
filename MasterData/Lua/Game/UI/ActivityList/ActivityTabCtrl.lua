local ActivityTabCtrl = class("ActivityTabCtrl", BaseCtrl)
ActivityTabCtrl._mapNodeConfig = {
  imgActivity = {sComponentName = "Image"},
  imgChoose = {},
  imgActTime = {},
  redDotActTab = {},
  redDotActNew = {}
}
ActivityTabCtrl._mapEventConfig = {}

function ActivityTabCtrl:Init(actData)
  self._mapNode.imgChoose.gameObject:SetActive(false)
  self.actData = actData.actData
  self.nType = actData.nType
  if actData.nType == AllEnum.ActivityMainType.Activity then
    self.nActId = self.actData:GetActId()
  elseif actData.nType == AllEnum.ActivityMainType.ActivityGroup then
    self.nActId = self.actData:GetActGroupId()
  end
  local actCfg = actData.nType == AllEnum.ActivityMainType.Activity and self.actData:GetActCfgData() or self.actData:GetActGroupCfgData()
  self:SetPngSprite(self._mapNode.imgActivity, actCfg.TabBgRes)
  NovaAPI.SetImageNativeSize(self._mapNode.imgActivity)
  local endTime = actData.nType == AllEnum.ActivityMainType.Activity and self.actData:GetActEndTime() or self.actData:GetActGroupEndTime()
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local remainTime = endTime - curTime
  self._mapNode.imgActTime.gameObject:SetActive(0 < endTime and remainTime <= 259200)
  self:RegisterRedDotNode()
end

function ActivityTabCtrl:SetSelect(bSelect)
  self._mapNode.imgChoose.gameObject:SetActive(bSelect)
end

function ActivityTabCtrl:RegisterRedDotNode()
  if self.nType == AllEnum.ActivityMainType.Activity then
    RedDotManager.RegisterNode(RedDotDefine.Activity_Tab, self.nActId, self._mapNode.redDotActTab)
    RedDotManager.RegisterNode(RedDotDefine.Activity_New_Tab, self.nActId, self._mapNode.redDotActNew)
  elseif self.nType == AllEnum.ActivityMainType.ActivityGroup then
    if not self.actData:IsUnlock() then
      self._mapNode.redDotActTab:SetActive(false)
      self._mapNode.redDotActNew:SetActive(false)
    else
      local HasRedDot = RedDotManager.GetValid(RedDotDefine.Activity_Group, {
        self.nActId
      })
      local HasNew = RedDotManager.GetValid(RedDotDefine.Activity_New_Tab, {
        self.nActId
      })
      RedDotManager.SetValid(RedDotDefine.Activity_New_Tab, self.nActId, HasNew and not HasRedDot)
      self._mapNode.redDotActTab.gameObject:SetActive(HasRedDot)
      RedDotManager.RegisterNode(RedDotDefine.Activity_New_Tab, self.nActId, self._mapNode.redDotActNew)
    end
  end
end

function ActivityTabCtrl:OnDisable()
end

return ActivityTabCtrl
