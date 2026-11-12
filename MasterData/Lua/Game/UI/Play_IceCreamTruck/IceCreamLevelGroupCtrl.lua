local IceCreamLevelGroupCtrl = class("IceCreamLevelGroupCtrl", BaseCtrl)
local SpineManager = require("Game.Spine.SpineManager")
IceCreamLevelGroupCtrl._mapNodeConfig = {
  btn_LevelDetail = {
    sComponentName = "UIButton",
    callback = "OnBtn_OpenDetail"
  },
  txt_LevelTypeName = {sComponentName = "TMP_Text"},
  LockRoot = {},
  txt_Lock = {sComponentName = "TMP_Text"},
  iconCert = {},
  SpRoot_Island = {},
  redH = {}
}
IceCreamLevelGroupCtrl._mapEventConfig = {
  Event_CloseLevelDetail = "Event_CloseDetail",
  Event_ChangeNextDetail = "Event_ChangeNextDetail",
  Event_OpenLevelDetail = "Event_OpenLevelDetail"
}

function IceCreamLevelGroupCtrl:Awake()
end

function IceCreamLevelGroupCtrl:OnEnable()
end

function IceCreamLevelGroupCtrl:InitData(nActId, nIndex, tbLevels, parent)
  self.parent = parent
  self.nIndex = nIndex
  self.nActId = nActId
  self.IceCreamActData = PlayerData.Activity:GetActivityDataById(self.nActId)
  if self.IceCreamActData == nil then
    printError("没有冰淇淋活动数据")
    return
  end
  self.tbLevels = tbLevels
  if self.tbLevels == nil then
    printError("关卡组信息为空")
    return
  end
  self.CurrentMapData = self.IceCreamActData:GetLevelMapData(self.tbLevels[1])
  self:RefreshState()
  self:RegisterGroupSpines()
  self:RegisterNewRedNode(self.nActId, self.nIndex)
end

function IceCreamLevelGroupCtrl:RefreshState()
  self._mapNode.iconCert:SetActive(self:GetIsAllFinish())
  local nLevelId = self.tbLevels[1]
  local bLock, nRemain = self.IceCreamActData:CheckLevelIsLockByTime(nLevelId)
  if bLock then
    self.bLock = bLock
    self._mapNode.LockRoot:SetActive(self.bLock)
    self:RefreshLevelTime(nRemain)
    self:SetTypeName(bLock)
    return
  end
  bLock = self.IceCreamActData:CheckLevelLockByPrev(nLevelId)
  if bLock then
    self.bLock = bLock
    self._mapNode.LockRoot:SetActive(bLock)
    NovaAPI.SetTMPText(self._mapNode.txt_Lock, ConfigTable.GetUIText("IceCreamTruck_LevelLockPreTitle"))
    self:SetTypeName(bLock)
    return
  end
  self.bLock = bLock
  self._mapNode.LockRoot:SetActive(self.bLock)
  self:SetTypeName(bLock)
end

function IceCreamLevelGroupCtrl:GetIsAllFinish()
  for _, value in ipairs(self.tbLevels) do
    if not self.IceCreamActData:GetLevelData(value).bFirstComplete then
      return false
    end
  end
  return true
end

function IceCreamLevelGroupCtrl:SetTypeName(bLock)
  if bLock then
    NovaAPI.SetTMPText(self._mapNode.txt_LevelTypeName, ConfigTable.GetUIText("IceCreamTruck_LevelLockName"))
  elseif self.CurrentMapData then
    local LevelTypeName = self.CurrentMapData.IslandName
    NovaAPI.SetTMPText(self._mapNode.txt_LevelTypeName, LevelTypeName)
  end
end

function IceCreamLevelGroupCtrl:OnDisable()
  self:UnRegisterNewRedNode()
end

function IceCreamLevelGroupCtrl:OnDestroy()
end

function IceCreamLevelGroupCtrl:RefreshLevelTime(remainTime)
  local sTime = self:GetTimeText(remainTime)
  NovaAPI.SetTMPText(self._mapNode.txt_Lock, orderedFormat(ConfigTable.GetUIText("IceCreamTruck_TimeTips") or "", sTime))
end

function IceCreamLevelGroupCtrl:GetTimeText(remainTime)
  local sTimeStr = ""
  if remainTime <= 60 then
    local sec = math.floor(remainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Sec") or "", sec)
  elseif 60 < remainTime and remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    local sec = math.floor(remainTime - min * 60)
    if sec == 0 then
      min = min - 1
      sec = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Min") or "", min, sec)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    if min == 0 then
      hour = hour - 1
      min = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Hour") or "", hour, min)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    if hour == 0 then
      day = day - 1
      hour = 24
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Day") or "", day, hour)
  end
  return sTimeStr
end

function IceCreamLevelGroupCtrl:OnBtn_OpenDetail()
  if self.bLock then
    return
  end
  self.parent._mapNode.LevelDetailsPanel:Open(self.nActId, self.nIndex)
  self.parent:OpenLevelDetail_Animator(self.nIndex)
  self:ClickIn_Spine()
end

function IceCreamLevelGroupCtrl:Event_CloseDetail(nIndex)
  if self.nIndex == nIndex then
    self:ClickOut_Spine()
    self.parent:CloseLevelDetail_AnimatorOut(nIndex)
  end
end

function IceCreamLevelGroupCtrl:Event_ChangeNextDetail(nIndex, nNextIndex)
  if self.nIndex == nIndex then
    self:ClickOut_Spine()
    self.parent:OpenNextLevelDetail(nIndex, nNextIndex)
  end
end

function IceCreamLevelGroupCtrl:Event_OpenLevelDetail(nNextIndex)
  if self.nIndex == nNextIndex then
    self.parent._mapNode.LevelDetailsPanel:Open(self.nActId, nNextIndex)
    self.parent:OpenLevelDetail_Animator(nNextIndex)
    self:ClickIn_Spine()
  end
end

function IceCreamLevelGroupCtrl:RegisterGroupSpines()
  local objSpine = self._mapNode.SpRoot_Island
  if objSpine ~= nil then
    if self.bLock then
      SpineManager.PlayAnim(objSpine, "lock", true)
    else
      SpineManager.PlayAnim(objSpine, "idle", true)
    end
  end
end

function IceCreamLevelGroupCtrl:ClickIn_Spine()
  local objSpine = self._mapNode.SpRoot_Island
  if objSpine ~= nil then
    self:SetStatusSwitch(objSpine, "in", false, "idle2")
  end
end

function IceCreamLevelGroupCtrl:ClickOut_Spine()
  local objSpine = self._mapNode.SpRoot_Island
  if objSpine ~= nil then
    self:SetStatusSwitch(objSpine, "out", false, "idle")
  end
end

function IceCreamLevelGroupCtrl:SetStatusSwitch(objSpine, sState, bLoop, sNextLoop)
  if not objSpine then
    return
  end
  if bLoop == nil then
    bLoop = true
  end
  SpineManager.PlayAnim(objSpine, sState, bLoop)
  if not bLoop and sNextLoop then
    SpineManager.AddAnim(objSpine, sNextLoop, true, 0)
  end
end

function IceCreamLevelGroupCtrl:RegisterNewRedNode(nActId, nIndex)
  RedDotManager.RegisterNode(RedDotDefine.Activity_IceCreamTruck_NewType, {nActId, nIndex}, self._mapNode.redH)
end

function IceCreamLevelGroupCtrl:UnRegisterNewRedNode()
  RedDotManager.UnRegisterNode(RedDotDefine.Activity_IceCreamTruck_NewType, {
    nActId,
    nIndex
  }, self._mapNode.redH)
end

return IceCreamLevelGroupCtrl
