local MallActivityCtrl = class("MallActivityCtrl", BaseCtrl)
MallActivityCtrl._mapNodeConfig = {
  rtContent = {
    sNodeName = "--Content--",
    sComponentName = "RectTransform"
  }
}
MallActivityCtrl._mapEventConfig = {MallOrderClear = "Refresh"}
local sPrefabFormat = "UI_Activity/%s.prefab"
local sCtrlFormat = "Game.UI.Mall.MallActivity.%s"

local function GetActUICfg(actData)
  if actData:GetActType() == GameEnum.activityType.MallLogin then
    return actData:GetLoginRewardControlCfg()
  end
  return nil
end

function MallActivityCtrl:CreateActivityCtrl(actData)
  local mapActCfg = GetActUICfg(actData)
  if mapActCfg == nil then
    printError(string.format("商城活动 %s (类型 %s) 缺少界面配置", tostring(actData:GetActId()), tostring(actData:GetActType())))
    return nil
  end
  local sPrefabPath = string.format(sPrefabFormat, mapActCfg.UIAssets)
  local goObj = self:CreatePrefabInstance(sPrefabPath, self._mapNode.rtContent)
  if goObj == nil then
    return nil
  end
  self.sPrefabPath = sPrefabPath
  local actCtrl = self:BindCtrlByNode(goObj, string.format(sCtrlFormat, mapActCfg.CtrlName))
  if actCtrl == nil then
    self:DestroyPrefabInstance(sPrefabPath)
    self.sPrefabPath = nil
  end
  return actCtrl
end

function MallActivityCtrl:SetExpireTimer(actData)
  if self.expireTimer ~= nil then
    self.expireTimer:Cancel(false)
    self.expireTimer = nil
  end
  if actData == nil or actData:GetActCfgData().EndType == GameEnum.activityEndType.NoLimit then
    return
  end
  local nRemainTime = actData:GetActEndTime() - CS.ClientManager.Instance.serverTimeStamp
  if nRemainTime <= 0 then
    return
  end
  self.expireTimer = self:AddTimer(1, nRemainTime + 1, function()
    self.expireTimer = nil
    EventManager.Hit("MallActivityExpire")
  end, true, true, false)
end

function MallActivityCtrl:ClearActivity()
  local actCtrl = self.actCtrl
  if actCtrl ~= nil then
    if actCtrl.ClearActivity ~= nil then
      actCtrl:ClearActivity()
    end
    self:UnbindCtrlByNode(actCtrl)
    self.actCtrl = nil
  end
  if self.sPrefabPath ~= nil then
    self:DestroyPrefabInstance(self.sPrefabPath)
    self.sPrefabPath = nil
  end
  self.nActId = nil
end

function MallActivityCtrl:Refresh()
  if self._panel.nCurTog ~= AllEnum.MallToggle.Activity then
    return
  end
  if PlayerData.Activity:GetMallActivityData() == nil then
    self:ClearActivity()
    return
  end
  
  local function callback()
    self:RefreshActivity()
  end
  
  PlayerData.Mall:SendMallActivityListReq(callback)
end

function MallActivityCtrl:RefreshActivity()
  if self._panel.nCurTog ~= AllEnum.MallToggle.Activity then
    return
  end
  local actData = PlayerData.Activity:GetMallActivityData()
  if actData == nil then
    self:ClearActivity()
    return
  end
  if self.nActId ~= nil and self.nActId ~= actData:GetActId() then
    self:ClearActivity()
  end
  local actCtrl = self.actCtrl
  if actCtrl == nil then
    actCtrl = self:CreateActivityCtrl(actData)
    if actCtrl == nil then
      return
    end
    self.actCtrl = actCtrl
    self.nActId = actData:GetActId()
  end
  actCtrl.gameObject:SetActive(true)
  actCtrl:InitActData(actData)
end

function MallActivityCtrl:Awake()
  self.expireTimer = nil
end

function MallActivityCtrl:OnEnable()
end

function MallActivityCtrl:OnDisable()
  self:ClearActivity()
end

function MallActivityCtrl:OnDestroy()
end

return MallActivityCtrl
