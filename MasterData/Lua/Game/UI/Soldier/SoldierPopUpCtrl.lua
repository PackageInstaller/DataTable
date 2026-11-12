local SoldierPopUpCtrl = class("SoldierPopUpCtrl", BaseCtrl)
local JumpUtil = require("Game.Common.Utils.JumpUtil")
local ClientManager = CS.ClientManager.Instance
SoldierPopUpCtrl._mapNodeConfig = {
  btnCloseFullscreen = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  txtBtnGo = {sComponentName = "TMP_Text", sLanguageId = "Soldier_Go"},
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  }
}
SoldierPopUpCtrl._mapEventConfig = {}
SoldierPopUpCtrl._mapRedDotConfig = {}

function SoldierPopUpCtrl:ShowPopUp(id, callback, index)
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

function SoldierPopUpCtrl:ClosePopUp(callback)
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

function SoldierPopUpCtrl:PlayOpenAnim()
  if self.anim then
    self.anim:Play("open", 0, 0)
  end
end

function SoldierPopUpCtrl:Awake()
end

function SoldierPopUpCtrl:OnEnable()
end

function SoldierPopUpCtrl:OnDisable()
end

function SoldierPopUpCtrl:OnDestroy()
end

function SoldierPopUpCtrl:OnBtnClick_Go()
  local function callback()
    if nil ~= self.nCurId then
      PopUpManager.InterruptPopUp(self.popUpIndex)
      
      EventManager.Hit(EventId.ClosePanel, PanelId.ActivityPopUp)
      JumpUtil.JumpTo(self.mapCfg.JumpToParams)
    end
  end
  
  self:ClosePopUp(callback)
end

function SoldierPopUpCtrl:OnBtnClick_Close()
  self:ClosePopUp(self.callback)
end

return SoldierPopUpCtrl
