local UINSkinActDrawLottery = class("UINSkinActDrawLottery", UIBaseNode)
local base = UIBaseNode
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local JumpManager = require("Game.Jump.JumpManager")
local cs_MessageCommon = CS.MessageCommon

function UINSkinActDrawLottery:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_SkinAct, self, self.OnClickDrawLotteryJump)
end

function UINSkinActDrawLottery:InitSkinActDrawLottery(lotteryType, poolId)
  self.drawLotteryCtrl = ControllerManager:GetController(ControllerTypeId.EventDrawLottery)
  if self.drawLotteryCtrl == nil then
    self:Hide()
    return
  end
  self.drawLotteryData = self.drawLotteryCtrl:GetEventDrawLotteryData()
  if self.drawLotteryData == nil or not self.drawLotteryData:IsActivityRunning() then
    self:Hide()
    return
  end
  if self.drawLotteryData:CheckPooIdIsExclude(poolId) then
    self:Hide()
    return
  end
  local taskCompleteData = self.drawLotteryData:GetDrawLotteryHaveTaskComplete(lotteryType)
  if taskCompleteData.destroy then
    self:Hide()
    return
  end
  local canGet = taskCompleteData.canPick or self.drawLotteryData:GetDrawLotteryBpCanPick()
  self.ui.obj_get:SetActive(canGet)
  self.ui.tex_num.gameObject:SetActive(not canGet)
  if not canGet then
    self.ui.tex_num.text = tostring(taskCompleteData.schedule) .. "/" .. tostring(taskCompleteData.aim)
  end
  self:Show()
end

function UINSkinActDrawLottery:OnClickDrawLotteryJump()
  if self.drawLotteryData == nil or not self.drawLotteryData:IsActivityRunning() then
    local err = ConfigData:GetTipContent(6033)
    cs_MessageCommon.ShowMessageTips(err)
    return
  end
  JumpManager:Jump(JumpManager.eJumpTarget.DynActivity, nil, nil, {
    self.drawLotteryData:GetActFrameId()
  })
end

function UINSkinActDrawLottery:OnDelete()
end

return UINSkinActDrawLottery
