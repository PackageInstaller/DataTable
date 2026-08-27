local UINSectorActivityEntry = class("UINSectorActivityEntry", UIBaseNode)
local base = UIBaseNode
local CS_MessageCommon = CS.MessageCommon
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")

function UINSectorActivityEntry:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Activity, self, self.OnSectorActivityClick)
  UIUtil.AddButtonListener(self.ui.btn_Lock, self, self.OnClickActivityLock)
end

function UINSectorActivityEntry:RefreshSectorActivity(cfg, actFrameData, resloader, clickCallback)
  if self.__onActivityReddot ~= nil then
    RedDotController:RemoveListener(self.actNode.nodePath, self.__onActivityReddot)
    self.__onActivityReddot = nil
    self.actNode = nil
  end
  self._cfg = cfg
  self._dotObj = self._cfg.red_dot == 1 and self.ui.obj_redDot or self.ui.blueDot
  self._clickCallback = clickCallback
  local imageEntrance = ActivityFrameUtil.GetActivityRealImageEntrance(self._cfg)
  local imgPath = PathConsts:GetResImagePath("Activity/" .. imageEntrance .. ".png")
  local imgActivity = self.ui.img_Activity
  resloader:LoadABAssetAsync(imgPath, function(image)
    if not IsNull(imgActivity) and not IsNull(image) then
      imgActivity.texture = image
    end
  end)
  self.actNode = actFrameData:GetActivityReddotNode()
  self._actFrameData = actFrameData
  self:RefreshLockState()
  if self.actNode == nil then
    self.ui.obj_redDot:SetActive(false)
    self.ui.blueDot:SetActive(false)
    return
  end
  
  function self.__onActivityReddot(node)
    local activityBaseData = self._actFrameData:GetActivityData()
    if activityBaseData == nil then
      self._dotObj:SetActive(node:GetRedDotCount() > 0)
      return
    end
    local isBlue, num = activityBaseData:GetActivityReddotNum()
    self.ui.obj_redDot:SetActive(not isBlue and 0 < num)
    self.ui.blueDot:SetActive(isBlue and 0 < num)
  end
  
  RedDotController:AddListener(self.actNode.nodePath, self.__onActivityReddot)
  self.__onActivityReddot(self.actNode)
  self:__RefreshActTime()
end

function UINSectorActivityEntry:RefreshNoActivityBanner(cfg, resloader, clickCallback)
  self._cfg = cfg
  self._clickCallback = clickCallback
  local imageEntrance = ActivityFrameUtil.GetActivityRealImageEntrance(self._cfg)
  local imgPath = PathConsts:GetImagePath("Activity/" .. imageEntrance)
  local imgActivity = self.ui.img_Activity
  resloader:LoadABAssetAsync(imgPath, function(image)
    if not IsNull(imgActivity) and not IsNull(image) then
      imgActivity.texture = image
    end
  end)
  self.ui.obj_redDot:SetActive(false)
  self.ui.blueDot:SetActive(false)
end

function UINSectorActivityEntry:RefreshLockState()
  local isUnlock = self._actFrameData:GetIsActivityLocked()
  if not isUnlock then
    self.ui.btn_Lock.gameObject:SetActive(false)
    return
  end
  self.ui.btn_Lock.gameObject:SetActive(true)
  self.ui.tex_Lock.text = self._actFrameData:GetLockTip(true)
end

function UINSectorActivityEntry:GetEntryActFrameData()
  return self._actFrameData
end

function UINSectorActivityEntry:OnClickActivityLock()
  local tip = ConfigData:GetTipContent(31001)
  CS_MessageCommon.ShowMessageTips(tip)
end

function UINSectorActivityEntry:OnSectorActivityClick()
  if self._clickCallback ~= nil then
    self._clickCallback(self._cfg)
  end
end

function UINSectorActivityEntry:OnHide()
  if self.__onActivityReddot ~= nil then
    RedDotController:RemoveListener(self.actNode.nodePath, self.__onActivityReddot)
    self.__onActivityReddot = nil
  end
  base.OnHide(self)
end

function UINSectorActivityEntry:__RefreshActTime()
  local title, timeStr, expireTime = ActivityFrameUtil.GetShowEndTimeStr(self._actFrameData)
  local str = ActivityFrameUtil.CombineShowEndTimeStr(title, timeStr)
  self.ui.obj_actTimeImage:SetActive(true)
  self.ui.tex_acttext.text = str
end

function UINSectorActivityEntry:OnDelete()
  base.OnDelete(self)
end

return UINSectorActivityEntry
