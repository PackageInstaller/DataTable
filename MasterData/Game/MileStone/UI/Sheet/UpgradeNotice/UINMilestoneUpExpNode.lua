local base = UIBaseNode
local UINMilestoneUpExpNode = class("UINMilestoneUpExpNode", base)
local cs_Ease = CS.DG.Tweening.Ease
local MilestoneUtil = require("Game.MileStone.MilestoneUtil")
local UINMilestoneStar = require("Game.MileStone.UI.Common.UINMilestoneStar")

function UINMilestoneUpExpNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.starNode = UINMilestoneStar.New()
  self.starNode:Init(self.ui.uINSixPointStar)
  self.starNode:InitSixPointStar(nil, nil)
end

function UINMilestoneUpExpNode:InitMilestoneUpExpNode(msData, msModuleId)
  self.msData = msData
  self.msModuleId = msModuleId
  local stageDic, processDic = self.msData:GetDataForStar2Show()
  self.starNode:RefreshSPSMultPoint(stageDic, processDic, false)
  self.starNode.transform.rotation = Quaternion.Euler(0, 0, -30 + msModuleId * -60 + 360)
end

function UINMilestoneUpExpNode:PlayMilestoneUpgrage(stageId, oldProcess, newProcess, callback)
  local newPercent = math.floor(newProcess * 100)
  local oldPercent = math.floor(oldProcess * 100)
  self.ui.tex_Percent.text = tostring(oldPercent)
  self.ui.tex_Stage.text = MilestoneUtil.GetSPSStageId2EngChar(stageId)
  self.starNode:RefreshSPSSinglePoint(self.msModuleId, stageId, oldProcess, false)
  local newFillAmount = MilestoneUtil.GetMilstoneFillRateWithProcessId(newProcess)
  local oldFillAmount = MilestoneUtil.GetMilstoneFillRateWithProcessId(oldProcess)
  self.ui.progressFill.fillAmount = oldFillAmount
  TimerManager:StopTimer(self.__animTimer)
  if 1 <= newProcess then
    self.ui.Obj_GetTip:DOLocalMoveX(self.ui.Obj_GetTip.localPosition.x - 700, 0.3):From():SetDelay(1):SetLink(self.gameObject)
    self.ui.Obj_GetTip.gameObject:SetActive(true)
  else
    self.ui.Obj_GetTip.gameObject:SetActive(false)
  end
  self.__animTimer = TimerManager:StartTimer(0.65, function()
    self.ui.progressFill:DOKill()
    self.ui.tex_Percent:DOKill()
    local delayTime = math.abs(newFillAmount - oldFillAmount) * 4
    self.ui.tex_Percent:DOCounter(oldPercent, newPercent, delayTime):SetEase(cs_Ease.OutQuart):SetLink(self.gameObject)
    self.starNode:RefreshSPSSinglePoint(self.msModuleId, stageId, newProcess, true)
    self.ui.progressFill:DOFillAmount(newFillAmount, delayTime):SetEase(cs_Ease.OutQuart):SetLink(self.gameObject):OnComplete(function()
      if callback ~= nil then
        callback()
      end
    end)
  end, nil, true)
end

function UINMilestoneUpExpNode:OnDelete()
  TimerManager:StopTimer(self.__animTimer)
  base.OnDelete(self)
end

return UINMilestoneUpExpNode
