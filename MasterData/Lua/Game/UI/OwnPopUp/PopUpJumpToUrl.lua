local PopUpJumpToUrl = class("PopUpJumpToUrl", BaseCtrl)
PopUpJumpToUrl._mapNodeConfig = {
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnCloseBg = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  }
}
PopUpJumpToUrl._mapEventConfig = {}
PopUpJumpToUrl._mapRedDotConfig = {}

function PopUpJumpToUrl:ShowPopUp(id, callback, index)
  self.popUpIndex = index
  self.nCurId = id
  self.callback = callback
  self.mapCfg = ConfigTable.GetData("PopUp", self.nCurId)
  self.nOpenTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(self.mapCfg.StartTime)
  if self.mapCfg.EndType == GameEnum.PopUpEndType.Date then
    self.nEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(self.mapCfg.EndTime)
  elseif self.mapCfg.EndType == GameEnum.activityEndType.TimeLimit then
    self.nEndTime = self.nOpenTime + self.mapCfg.EndDuration * 86400
  end
  self.anim = self.gameObject:GetComponent("Animator")
  self:PlayOpenAnim()
end

function PopUpJumpToUrl:PlayOpenAnim()
  if self.anim then
    self.anim:Play("open", 0, 0)
  end
end

function PopUpJumpToUrl:ClosePopUp(callback)
  if self.anim ~= nil then
    self.anim:Play("close", 0, 0)
    self:AddTimer(1, 0.1, function()
      if callback ~= nil then
        callback()
      end
    end, true, true, true)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.1)
  elseif callback ~= nil then
    callback()
  end
end

function PopUpJumpToUrl:OnBtnClick_Close()
  self:ClosePopUp(self.callback)
end

function PopUpJumpToUrl:Awake()
end

function PopUpJumpToUrl:FadeIn()
end

function PopUpJumpToUrl:FadeOut()
end

function PopUpJumpToUrl:OnEnable()
end

function PopUpJumpToUrl:OnDisable()
end

function PopUpJumpToUrl:OnDestroy()
end

function PopUpJumpToUrl:OnRelease()
end

function PopUpJumpToUrl:OnBtnClick_AAA()
end

function PopUpJumpToUrl:OnEvent_AAA()
end

return PopUpJumpToUrl
