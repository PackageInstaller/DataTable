local base = UIBaseNode
local UINSEActPageActItem = class("UINSEActPageActItem", UIBaseNode)
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local CS_MessageCommon = CS.MessageCommon

function UINSEActPageActItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_actNode, self, self.__OnClick)
  UIUtil.AddButtonListener(self.ui.btn_Lock, self, self.OnClickActivityLock)
end

function UINSEActPageActItem:RefreshActNode(actInfo, onClickAct, resloader)
  self.actInfo = actInfo
  self.onClickAct = onClickAct
  self.resloader = resloader
  local actName = actInfo.activityFrameInfo:GetActivityFrameName()
  self.ui.tex_ActName.text = actName
  self:__LoadRes(actInfo.entranceCfg)
  self:__RefreshLimitTime(actInfo.activityFrameInfo)
  self:__AddRefrshReddot()
  self:__RefreshLockState()
end

function UINSEActPageActItem:__LoadRes(entranceCfg)
  self.ui.img_Act.gameObject:SetActive(false)
  if not string.IsNullOrEmpty(entranceCfg.entrance_banner_small) then
    self.resloader:LoadABAssetAsync(PathConsts:GetHandbookItemPic(entranceCfg.entrance_banner_small), function(texture)
      if IsNull(texture) or IsNull(self.transform) then
        return
      end
      self.ui.img_Act.gameObject:SetActive(true)
      self.ui.img_Act.texture = texture
    end)
  else
    warn("活动入口" .. tostring(entranceCfg.id) .. "没有配置小图")
  end
  local isHaveTag = not string.IsNullOrEmpty(entranceCfg.type_icon)
  self.ui.img_Tpye:SetActive(isHaveTag)
  if isHaveTag then
    self.resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorEntrance"), function(spriteAtlas)
      if spriteAtlas == nil then
        return
      end
      self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, entranceCfg.type_icon)
    end)
  end
end

function UINSEActPageActItem:__RefreshLimitTime(actFrameData)
  local title, timeStr, expireTime = ActivityFrameUtil.GetShowEndTimeStr(actFrameData)
  self.ui.tex_Time.text = ActivityFrameUtil.CombineShowEndTimeStr(title, timeStr)
  local playLeftTime = actFrameData:GetActivityEndTime() - PlayerDataCenter.timestamp
  local isLessThenNDay = 0 < playLeftTime and playLeftTime <= 259200
  self.ui.img_Tag:SetActive(isLessThenNDay)
  if isLessThenNDay then
    self.ui.tex_TagTime:SetIndex(0, tostring(math.ceil(playLeftTime / 86400)))
  end
end

function UINSEActPageActItem:__AddRefrshReddot()
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

function UINSEActPageActItem:__RefreshLockState()
  local isUnlock = self.actInfo.activityFrameInfo:GetIsActivityLocked()
  if not isUnlock then
    self.ui.btn_Lock.gameObject:SetActive(false)
    return
  end
  self.ui.btn_Lock.gameObject:SetActive(true)
  self.ui.tex_Lock.text = self.actInfo.activityFrameInfo:GetLockTip(true)
end

function UINSEActPageActItem:OnClickActivityLock()
  local tip = ConfigData:GetTipContent(31001)
  CS_MessageCommon.ShowMessageTips(tip)
end

function UINSEActPageActItem:__OnClick()
  if self.onClickAct ~= nil then
    self.onClickAct(self.actInfo)
  end
end

function UINSEActPageActItem:OnDelete()
  if self.removeReddotFunc ~= nil then
    self.removeReddotFunc()
    self.removeReddotFunc = nil
  end
  base.OnDelete(self)
end

return UINSEActPageActItem
