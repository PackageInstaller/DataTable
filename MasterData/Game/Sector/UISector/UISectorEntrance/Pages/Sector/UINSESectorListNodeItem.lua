local base = UIBaseNode
local UINSectorListNodeItem = class("UINSectorListNodeItem", base)
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")

function UINSectorListNodeItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Goto, self, self.OnClickGoto)
  self.RefreshUnlockStateCallback = BindCallback(self, self.RefreshUnlockState)
  MsgCenter:AddListener(eMsgEventId.SectorChapterUnlockSuccess, self.RefreshUnlockStateCallback)
end

function UINSectorListNodeItem:InitSectorListNodeItem(sctChaptData, jumpFunc)
  self._sctChaptData = sctChaptData
  self.jumpFunc = jumpFunc
  self.ui.tex_SectorNumber:SetIndex(0, sctChaptData:GetSctChaptSerialNum())
  self.ui.tex_SectorName.text = sctChaptData:GetSctChaptName()
  self:UpdSctChaptChallengeProgress()
end

function UINSectorListNodeItem:UpdSctChaptChallengeProgress()
  local allCount = 0
  local completeCount = 0
  local curChallengeTaskNum = 0
  local allChallengeTaskNum = 0
  allCount, completeCount, curChallengeTaskNum, allChallengeTaskNum = SectorStageDetailHelper.GetSectorStagePerformance(self._sctChaptData:GetSctChaptSectorId(), self._sctChaptData:IsSctChanllengeOpen())
  local progress = completeCount / allCount
  self.ui.sliderProgress.value = progress
  progress = math.floor(progress * 100)
  self.ui.tex_Progress:SetIndex(0, tostring(progress))
  if self._sctChaptData:IsSctChanllengeOpen() then
    self.ui.challenge:SetActive(true)
    self.ui.tex_TotalChall:SetIndex(0, tostring(curChallengeTaskNum), tostring(allChallengeTaskNum))
  else
    self.ui.challenge:SetActive(false)
  end
  self:RefreshUnlockState()
end

function UINSectorListNodeItem:RefreshUnlockState()
  local unlockCostOk = self._sctChaptData:IsSectorChapterUnlockCostOk()
  self.ui.img_Lock:SetActive(not unlockCostOk)
  self.ui.img_bottom:SetIndex(unlockCostOk and 0 or 1)
  self.ui.obj_Lock:SetActive(not unlockCostOk)
  self.ui.obj_gotoArrow:SetActive(unlockCostOk)
  self.ui.obj_gotoText:SetActive(unlockCostOk)
  self.ui.sliderProgress.gameObject:SetActive(unlockCostOk)
  if unlockCostOk then
    self.ui.texN_SectorNumber.color = self.ui.unlockColor
    self.ui.tex_SectorName.color = self.ui.unlockColor
  else
    self.ui.texN_SectorNumber.color = self.ui.lockColor
    self.ui.tex_SectorName.color = self.ui.lockColor
    self.ui.challenge:SetActive(false)
  end
end

function UINSectorListNodeItem:ShowSctChaptItemInEp(show)
  self.ui.inExplore:SetActive(show)
end

function UINSectorListNodeItem:OnClickGoto()
  if self.jumpFunc then
    self.jumpFunc(self._sctChaptData)
  end
end

function UINSectorListNodeItem:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.SectorChapterUnlockSuccess, self.RefreshUnlockStateCallback)
end

return UINSectorListNodeItem
