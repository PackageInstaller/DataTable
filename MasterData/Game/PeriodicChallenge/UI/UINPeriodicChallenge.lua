local UINPeriodicChallenge = class("UINPeriodicChallenge", UIBaseNode)
local base = UIBaseNode
local UINPeriodicInfoItem = require("Game.PeriodicChallenge.UI.UINPeriodicInfoItem")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")

function UINPeriodicChallenge:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_node, self, self.OnClickDetail)
end

function UINPeriodicChallenge:InitPeriodicItem(id, eChallenge, parentNode)
  self.detailType = SectorLevelDetailEnum.eDetailType.PeriodicChallenge
  self.dungeonId = id
  self.eChallenge = eChallenge
  self.parentNode = parentNode
  self.isSelected = false
end

function UINPeriodicChallenge:InitWeeklyItem(id, parentNode)
  self.detailType = SectorLevelDetailEnum.eDetailType.WeeklyChallenge
  self.dungeonId = id
  self.parentNode = parentNode
  self.isSelected = false
end

function UINPeriodicChallenge:OnClickDetail()
  if not SectorStageDetailHelper.IsWeeklyChallengeNoCollide(true) then
    return
  end
  local has, dungeonId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
  if has and self.dungeonId ~= dungeonId then
    if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    end
    SectorStageDetailHelper.TryToShowCurrentLevelTips(SectorStageDetailHelper.PlayMoudleType.Ep)
    return
  end
  if self.parentNode.selectedItem == self then
    return
  end
  self.parentNode:OnClickItemCallback(self, true)
end

function UINPeriodicChallenge:SetSelectState(flag)
  self.ui.img_Select:SetActive(flag)
  self.isSelected = flag
  if flag then
    self.ui.wave:DOPlayForward()
    AudioManager:PlayAudioById(1107)
  else
    self.ui.wave:DOPlayBackwards()
    AudioManager:PlayAudioById(1108)
  end
end

return UINPeriodicChallenge
