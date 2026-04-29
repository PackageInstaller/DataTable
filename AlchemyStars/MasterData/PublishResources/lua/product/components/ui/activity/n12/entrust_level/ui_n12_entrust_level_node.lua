_class("UIN12EntrustLevelNode", UICustomWidget)
UIN12EntrustLevelNode = UIN12EntrustLevelNode
local EUIN12EntrustLevelNodeState = {Open = 1, Pass = 2}
_enum("EUIN12EntrustLevelNodeState", EUIN12EntrustLevelNodeState)

function UIN12EntrustLevelNode:OnShow(uiParams)
end

function UIN12EntrustLevelNode:PlayAnim(id, widgetName, animName, delayTime, time, callback)
  local anim = self:GetUIComponent("Animation", widgetName)
  local obj = self:GetGameObject(widgetName)
  local lockName = "UIN12EntrustLevelNode:PlayAnim()_" .. id .. "_" .. animName
  self:Lock(lockName)
  self:StartTask(function(TT)
    if delayTime and delayTime ~= 0 then
      obj:SetActive(false)
      YIELD(TT, delayTime)
      obj:SetActive(true)
    end
    anim:Play(animName)
    YIELD(TT, time)
    self:UnLock(lockName)
    if callback then
      callback()
    end
  end, self)
end

function UIN12EntrustLevelNode:SetData(component, levelId, nodeId, callback)
  self._component = component
  self._levelId = levelId
  self._nodeId = nodeId
  self._callback = callback
  self:_SetObjGroup()
  self:_SetState()
  self:_SetPos(nodeId)
  self:_SetType(nodeId)
  self:_SetAnim()
end

function UIN12EntrustLevelNode:_SetAnim()
  local anim1 = self:GetGameObject("anim1")
  local anim2 = self:GetGameObject("anim2")
  local anim1active = false
  local anim2active = false
  local type, subType = self._component:GetEventType(self._nodeId)
  if type == 3 then
    local pass = self._component:IsEventPass(self._levelId, self._nodeId)
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

function UIN12EntrustLevelNode:_SetPos(nodeId)
  local pos = self._component:GetEventPointPos(nodeId)
  local rect = self:GetGameObject():GetComponent("RectTransform")
  rect.anchorMax = Vector2(0, 0.5)
  rect.anchorMin = Vector2(0, 0.5)
  rect.sizeDelta = Vector2.zero
  rect.anchoredPosition = pos
end

function UIN12EntrustLevelNode:_SetType(nodeId)
  local type, subType = self._component:GetEventType(nodeId)
  local groupName = {"state_open", "state_pass"}
  local widgetName = {
    {"type1"},
    {"type2"},
    {"type3", "type3b"},
    {"type4"},
    {"type5"},
    {"type6"},
    {"type7"}
  }
  local trans = self:GetGameObject(groupName[self._state]).transform
  local name = widgetName[type][subType]
  for _, v in ipairs(widgetName) do
    for __, vv in ipairs(v) do
      local obj = trans:Find(vv)
      obj.gameObject:SetActive(name == vv)
    end
  end
end

function UIN12EntrustLevelNode:_SetState()
  self._state = self:_CheckState()
  UIWidgetHelper.SetObjGroupShow(self._stateObj, self._state)
end

function UIN12EntrustLevelNode:_CheckState()
  return self._component:IsEventPass(self._levelId, self._nodeId) and EUIN12EntrustLevelNodeState.Pass or EUIN12EntrustLevelNodeState.Open
end

function UIN12EntrustLevelNode:_SetObjGroup()
  local widgetNameGroup = {
    {"state_open"},
    {"state_pass"}
  }
  self._stateObj = UIWidgetHelper.GetObjGroupByWidgetName(self, widgetNameGroup)
end

function UIN12EntrustLevelNode:BtnOnClick()
  Log.info("UIN12EntrustLevelNode:BtnOnClick")
  if self._callback then
    self._callback(self._nodeId)
  end
  local lockName = "UIN12EntrustLevelNode:BtnOnClick"
  self:Lock(lockName)
  self:StartTask(function(TT)
    YIELD(TT, 400)
    self:UnLock(lockName)
    UIActivityN12Helper.N12_MapNode_Click(self._nodeId, self._levelId, self._component)
  end, self)
end

function UIN12EntrustLevelNode:SetDebugText(txt)
  self:GetGameObject("_debug"):SetActive(UIActivityHelper.CheckDebugOpen())
  local obj = self:GetUIComponent("UILocalizationText", "_debug")
  obj:SetText(txt)
end
