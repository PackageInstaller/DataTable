local HuoChuiHudCtrl = class("HuoChuiHudCtrl", BaseCtrl)
local nRotateMax = 0
local nRotateMin = 45
local nAnimTime = 0.2
HuoChuiHudCtrl._mapNodeConfig = {
  imgFill1 = {},
  imgFill2 = {},
  imgBarLight = {},
  TMPValue = {sComponentName = "TMP_Text"},
  goRotationRoot = {
    sComponentName = "HpBarRotation"
  },
  goState33 = {},
  goState66 = {},
  goHotState = {},
  rtRoot = {sComponentName = "Animator"},
  AniTMPValue = {sNodeName = "TMPValue", sComponentName = "Animator"},
  imgFill3 = {
    sComponentName = "HpBarCanvasGroup"
  },
  imgFill3CG = {
    sNodeName = "imgFill3",
    sComponentName = "CanvasGroup"
  },
  imgBarLight1 = {
    sComponentName = "HpBarCanvasGroup"
  },
  imgBarLight1CG = {
    sNodeName = "imgBarLight1",
    sComponentName = "CanvasGroup"
  },
  imgHighlight = {}
}
HuoChuiHudCtrl._mapEventConfig = {}
HuoChuiHudCtrl._mapRedDotConfig = {}

function HuoChuiHudCtrl:Awake()
  self.nHotValue = 0
  self.nState = 1
  self.showState = 1
end

function HuoChuiHudCtrl:SetMonsterId(nId, nInitValue, nInitState)
  if self.nMonsterId ~= nil then
    printError("重复绑定：" .. nId)
    return
  end
  self.monsterId = nId
  self.nHotValue = nInitValue
  self.nState = nInitState
  self.gameObject:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.TMPValue, self.nHotValue)
  self._mapNode.goRotationRoot.transform.localEulerAngles = Vector3.zero
  local target = -45 * self.nHotValue / 100 + 45
  if target < 0 then
    target = 0
  end
  if 45 < target then
    target = 45
  end
  self._mapNode.goRotationRoot:SetTarget(target, 0, 0)
  self._mapNode.imgHighlight:SetActive(self.nHotValue ~= 0 and self.nHotValue ~= 100)
  self:OnEvent_StageChange(nInitValue)
  EventManager.AddEntityEvent("Dead", self.monsterId, self, self.OnEvent_Deaded)
  EventManager.AddEntityEvent("ClearSlef", self.monsterId, self, self.OnEvent_Deaded)
  EventManager.AddEntityEvent("HotValueChange", self.monsterId, self, self.OnEvent_ValueChange)
  EventManager.AddEntityEvent("HotStateChange", self.monsterId, self, self.OnEvent_StageChange)
end

function HuoChuiHudCtrl:Hide()
  self.monsterId = nil
  self.gameObject:SetActive(false)
  EventManager.RemoveEntityEvent("Dead", self.monsterId, self, self.OnEvent_Deaded)
  EventManager.RemoveEntityEvent("ClearSlef", self.monsterId, self, self.OnEvent_Deaded)
  EventManager.RemoveEntityEvent("ValueChange", self.monsterId, self, self.OnEvent_ValueChange)
  EventManager.RemoveEntityEvent("StateChange", self.monsterId, self, self.OnEvent_StageChange)
end

function HuoChuiHudCtrl:FadeIn()
end

function HuoChuiHudCtrl:FadeOut()
end

function HuoChuiHudCtrl:OnEnable()
end

function HuoChuiHudCtrl:OnDisable()
  EventManager.RemoveEntityEvent("Dead", self.monsterId, self, self.OnEvent_Deaded)
  EventManager.RemoveEntityEvent("ClearSlef", self.monsterId, self, self.OnEvent_Deaded)
  EventManager.RemoveEntityEvent("HotValueChange", self.monsterId, self, self.OnEvent_ValueChange)
  EventManager.RemoveEntityEvent("HotStateChange", self.monsterId, self, self.OnEvent_StageChange)
  self.monsterId = nil
end

function HuoChuiHudCtrl:ChangeState1()
  self._mapNode.goState33:SetActive(false)
  self._mapNode.goState66:SetActive(false)
  self._mapNode.goHotState:SetActive(false)
end

function HuoChuiHudCtrl:ChangeState2()
  self._mapNode.goState33:SetActive(true)
  self._mapNode.goState66:SetActive(false)
  self._mapNode.goHotState:SetActive(false)
end

function HuoChuiHudCtrl:ChangeState3()
  self._mapNode.goState33:SetActive(false)
  self._mapNode.goState66:SetActive(true)
  self._mapNode.goHotState:SetActive(false)
end

function HuoChuiHudCtrl:ChangeStateHot()
  self._mapNode.goState33:SetActive(false)
  self._mapNode.goState66:SetActive(false)
  self._mapNode.goHotState:SetActive(true)
end

function HuoChuiHudCtrl:OnDestroy()
  EventManager.RemoveEntityEvent("Dead", self.monsterId, self, self.OnEvent_Deaded)
  EventManager.RemoveEntityEvent("ClearSlef", self.monsterId, self, self.OnEvent_Deaded)
  EventManager.RemoveEntityEvent("HotValueChange", self.monsterId, self, self.OnEvent_ValueChange)
  EventManager.RemoveEntityEvent("HotStateChange", self.monsterId, self, self.OnEvent_StageChange)
  self.monsterId = nil
end

function HuoChuiHudCtrl:OnRelease()
end

function HuoChuiHudCtrl:SetState(nBeforeValue, nCurValue)
  if nBeforeValue < 33 and 33 <= nCurValue or nBeforeValue < 66 and 66 <= nCurValue then
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.imgFill3CG, 1)
    self._mapNode.imgFill3:SetTarget(0, 0.8, 0)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.imgBarLight1CG, 1)
    self._mapNode.imgBarLight1:SetTarget(0, 0.8, 0)
  end
  if self.nState ~= 3 then
    if nCurValue < 33 and self.showState ~= 1 then
      self.showState = 1
      self:ChangeState1()
    elseif nCurValue < 66 and self.showState ~= 2 then
      self.showState = 2
      self:ChangeState2()
    elseif 66 <= nCurValue and self.showState ~= 3 then
      self.showState = 3
      self:ChangeState3()
    end
  end
end

function HuoChuiHudCtrl:OnEvent_Deaded()
  self.gameObject:SetActive(false)
  EventManager.RemoveEntityEvent("Dead", self.monsterId, self, self.OnEvent_Deaded)
  EventManager.RemoveEntityEvent("ClearSlef", self.monsterId, self, self.OnEvent_Deaded)
  EventManager.RemoveEntityEvent("HotValueChange", self.monsterId, self, self.OnEvent_ValueChange)
  EventManager.RemoveEntityEvent("HotStateChange", self.monsterId, self, self.OnEvent_StageChange)
  self.monsterId = nil
end

function HuoChuiHudCtrl:OnEvent_ValueChange(nValue)
  local nBeforValue = self.nHotValue
  local nCurAngle = -45 * self.nHotValue / 100 + 45
  local nCurValue = nValue
  self._mapNode.goRotationRoot.transform.localEulerAngles = Vector3(0, 0, nCurAngle)
  self.nHotValue = nValue
  local nTarget = -45 * self.nHotValue / 100 + 45
  if nTarget < 0 then
    nTarget = 0
  end
  if 45 < nTarget then
    nTarget = 45
  end
  self._mapNode.goRotationRoot:SetTarget(nTarget, nCurAngle, nAnimTime, 0)
  NovaAPI.SetTMPText(self._mapNode.TMPValue, self.nHotValue)
  if nBeforValue ~= 100 and self.nHotValue == 100 then
    self._mapNode.AniTMPValue:Play("HudHuoChuiBoss_TMPValue")
  end
  self:SetState(nBeforValue, nCurValue)
  self._mapNode.imgHighlight:SetActive(self.nHotValue ~= 0 and self.nHotValue ~= 100)
end

function HuoChuiHudCtrl:OnEvent_StageChange(nState)
  self.nState = nState
  if self.nState == 3 then
    self._mapNode.imgFill1:SetActive(false)
    self._mapNode.imgFill2:SetActive(true)
    self._mapNode.imgBarLight:SetActive(true)
    self:ChangeStateHot()
  else
    if self.nState == 2 then
      self._mapNode.rtRoot:Play("HudHuoChuiBoss_die")
    end
    self._mapNode.imgFill1:SetActive(true)
    self._mapNode.imgFill2:SetActive(false)
    self._mapNode.imgBarLight:SetActive(false)
    self.showState = 0
    self:SetState(0, self.nHotValue)
  end
end

return HuoChuiHudCtrl
