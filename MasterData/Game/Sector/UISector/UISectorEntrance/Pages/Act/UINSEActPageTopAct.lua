local base = UIBaseNode
local UINSEActPageTopAct = class("UINSEActPageTopAct", UIBaseNode)
local CS_MessageCommon = CS.MessageCommon
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")

function UINSEActPageTopAct:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_top, self, self.__OnClick)
  UIUtil.AddButtonListener(self.ui.btn_Lock, self, self.OnClickActivityLock)
end

function UINSEActPageTopAct:RefreshTopActNode(actInfo, onClickAct, resloader)
  self.actInfo = actInfo
  self.onClickAct = onClickAct
  self.resloader = resloader
  local actName = actInfo.activityFrameInfo:GetActivityFrameName()
  self.ui.tex_actName:SetIndex(0, actName)
  self:__LoadRes(actInfo.entranceCfg)
  self:__RefreshLimitTime(actInfo.activityFrameInfo)
  self:__AddRefrshReddot()
  self:__RefreshLockState()
end

function UINSEActPageTopAct:__LoadRes(entranceCfg)
  self.ui.img_actBg.gameObject:SetActive(false)
  self.ui.img_Logo.gameObject:SetActive(false)
  self.ui.img_actNoLogoImg:SetActive(false)
  self.resloader:LoadABAssetAsync(PathConsts:GetSectorEntrancTex(entranceCfg.entrance_banner), function(texture)
    if IsNull(texture) or IsNull(self.transform) then
      return
    end
    self.ui.img_actBg.gameObject:SetActive(true)
    self.ui.img_actBg.texture = texture
  end)
  local entranceLogoData = ActivityFrameUtil.GetActivityRealEntranceLogoData(entranceCfg)
  if string.IsNullOrEmpty(entranceLogoData.entranceLogo) then
    self.ui.img_actNoLogoImg:SetActive(true)
    self.ui.tex_actNoLogoName.text = self.actInfo.activityFrameInfo:GetActivityFrameName()
    return
  end
  self.resloader:LoadABAssetAsync(PathConsts:GetResImagePath(entranceLogoData.entranceLogo), function(texture)
    if IsNull(texture) or IsNull(self.transform) then
      return
    end
    self.ui.img_Logo.gameObject:SetActive(true)
    self.ui.img_Logo.texture = texture
    local logoPos = Vector3.New(entranceLogoData.logoPosition[1], entranceLogoData.logoPosition[2], entranceLogoData.logoPosition[3])
    local size = Vector2.New(entranceLogoData.logoSize[1], entranceLogoData.logoSize[2])
    local transform = self.ui.img_Logo.gameObject.transform
    transform.localPosition = logoPos
    transform.sizeDelta = size
  end)
end

function UINSEActPageTopAct:__RefreshLimitTime(actFrameData)
  local title, timeStr, expireTime = ActivityFrameUtil.GetShowEndTimeStr(actFrameData)
  self.ui.tex_timeLimit.text = ActivityFrameUtil.CombineShowEndTimeStr(title, timeStr)
end

function UINSEActPageTopAct:__AddRefrshReddot()
  if self.removeReddotFunc ~= nil then
    self.removeReddotFunc()
    self.removeReddotFunc = nil
  end
  local actNode = self.actInfo.activityFrameInfo:GetActivityReddotNode()
  
  local function RefrshActivityReddot(node)
    local actData = self.actInfo.activityFrameInfo:GetActivityData()
    if actData == nil then
      self.ui.redDot:SetActive(node:GetRedDotCount() > 0)
      return
    end
    local isBlue, num = actData:GetActivityReddotNum()
    self.ui.redDot:SetActive(not isBlue and 0 < num)
    self.ui.blueDot:SetActive(isBlue and 0 < num)
  end
  
  function self.removeReddotFunc()
    RedDotController:RemoveListener(actNode.nodePath, RefrshActivityReddot)
  end
  
  RedDotController:AddListener(actNode.nodePath, RefrshActivityReddot)
  RefrshActivityReddot(actNode)
end

function UINSEActPageTopAct:__RefreshLockState()
  local isUnlock = self.actInfo.activityFrameInfo:GetIsActivityLocked()
  if not isUnlock then
    self.ui.btn_Lock.gameObject:SetActive(false)
    return
  end
  self.ui.btn_Lock.gameObject:SetActive(true)
  self.ui.tex_Lock.text = self.actInfo.activityFrameInfo:GetLockTip()
end

function UINSEActPageTopAct:OnClickActivityLock()
  local tip = ConfigData:GetTipContent(31001)
  CS_MessageCommon.ShowMessageTips(tip)
end

function UINSEActPageTopAct:__OnClick()
  if self.onClickAct ~= nil then
    self.onClickAct(self.actInfo)
  end
end

function UINSEActPageTopAct:OnDelete()
  if self.removeReddotFunc ~= nil then
    self.removeReddotFunc()
    self.removeReddotFunc = nil
  end
  base.OnDelete(self)
end

return UINSEActPageTopAct
