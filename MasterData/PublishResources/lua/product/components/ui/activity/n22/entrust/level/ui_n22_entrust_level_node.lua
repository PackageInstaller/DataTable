_class("UIN22EntrustLevelNode", UICustomWidget)
UIN22EntrustLevelNode = UIN22EntrustLevelNode
local EUIN22EntrustLevelNodeState = {Open = 1, Pass = 2}
_enum("EUIN22EntrustLevelNodeState", EUIN22EntrustLevelNodeState)

function UIN22EntrustLevelNode:OnShow(uiParams)
end

function UIN22EntrustLevelNode:PlayAnim(id, animName, delay, duration, callback)
  local widgetName = "_anim"
  local hideWidget = "_anim"
  UIWidgetHelper.PlayAnimationInSequence(self, widgetName, hideWidget, animName, delay, duration, callback)
end

function UIN22EntrustLevelNode:SetData(campaign, component, levelId, nodeId, setPlayerCallback, eventCloseCallback)
  self._campaign = campaign
  self._component = component
  self._levelId = levelId
  self._eventId = nodeId
  self._setPlayerCallback = setPlayerCallback
  self._eventCloseCallback = eventCloseCallback
  self:_SetObjGroup()
  self:_SetState()
  self:_SetPos(nodeId)
  self:_SetType(nodeId)
  self:_SetAnim()
  self:SetDebugText(self._eventId)
end

function UIN22EntrustLevelNode:_SetAnim()
  local anim1 = self:GetGameObject("anim1")
  local anim2 = self:GetGameObject("anim2")
  local anim1active = false
  local anim2active = false
  local type, subType = self._component:GetEventType(self._eventId)
  if type == 3 then
    local pass = self._component:IsEventPass(self._levelId, self._eventId)
    if not pass then
      if subType == 1 then
        anim1active = true
      elseif subType == 2 then
        anim2active = true
      end
    end
  end
  anim1:SetActive(anim1active)
  anim2:SetActive(anim2active)
end

function UIN22EntrustLevelNode:_SetPos(nodeId)
  local pos = self._component:GetEventPointPos(nodeId)
  local rect = self:GetGameObject():GetComponent("RectTransform")
  rect.anchorMax = Vector2(0, 0.5)
  rect.anchorMin = Vector2(0, 0.5)
  rect.sizeDelta = Vector2.zero
  rect.anchoredPosition = pos
end

function UIN22EntrustLevelNode:_SetType(nodeId)
  local groupName = {"state_open", "state_pass"}
  local trans = self:GetGameObject(groupName[self._state]).transform
  local widgetName = {
    [EntrustEventType.EntrustEventType_Start] = {"type1"},
    [EntrustEventType.EntrustEventType_End] = {"type2"},
    [EntrustEventType.EntrustEventType_Fight] = {"type3", "type3b"},
    [EntrustEventType.EntrustEventType_Story] = {"type4"},
    [EntrustEventType.EntrustEventType_MissionOccupy] = {"type5"},
    [EntrustEventType.EntrustEventType_MissionSubmit] = {"type6"},
    [EntrustEventType.EntrustEventType_Box] = {"type7"},
    [EntrustEventType.EntrustEventType_Transfer] = {"type8"}
  }
  local type, subType = self._component:GetEventType(nodeId)
  local name = widgetName[type][subType]
  for _, v in ipairs(widgetName) do
    for __, vv in ipairs(v) do
      local obj = trans:Find(vv)
      obj.gameObject:SetActive(name == vv)
    end
  end
end

function UIN22EntrustLevelNode:_SetState()
  self._state = self:_CheckState()
  UIWidgetHelper.SetObjGroupShow(self._stateObj, self._state)
end

function UIN22EntrustLevelNode:_CheckState()
  return self._component:IsEventPass(self._levelId, self._eventId) and EUIN22EntrustLevelNodeState.Pass or EUIN22EntrustLevelNodeState.Open
end

function UIN22EntrustLevelNode:_SetObjGroup()
  local widgetNameGroup = {
    {"state_open"},
    {"state_pass"}
  }
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, widgetNameGroup)
end

function UIN22EntrustLevelNode:BtnOnClick()
  Log.info("UIN22EntrustLevelNode:BtnOnClick")
  local player = self._component:GetPlayerPos()
  local path = self._component:GetPath_BFS(self._levelId, player, self._eventId)
  if table.count(path) == 0 then
    return
  end
  if self._setPlayerCallback then
    self._setPlayerCallback(self._eventId)
  end
  local lockName = "UIN22EntrustLevelNode:BtnOnClick"
  self:Lock(lockName)
  self:StartTask(function(TT)
    YIELD(TT, 400)
    self:UnLock(lockName)
    self:ShowDialog("UIN22EntrustEventController", self._campaign, self._component, self._levelId, self._eventId, self._eventCloseCallback, self._setPlayerCallback)
  end, self)
end

function UIN22EntrustLevelNode:SetDebugText(txt)
  self:GetGameObject("_debug"):SetActive(UIActivityHelper.CheckDebugOpen())
  local obj = self:GetUIComponent("UILocalizationText", "_debug")
  obj:SetText(txt)
end
