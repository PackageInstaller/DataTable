require("state")
_class("N28StateAVGStoryBase", State)
N28StateAVGStoryBase = N28StateAVGStoryBase

function N28StateAVGStoryBase:Init()
  self.fsm = self:GetFsm()
  self.ui = self.fsm:GetData()
  self.data = self.ui.data
  self.atlas = self.ui:GetAsset("UIN28AVG.spriteatlas", LoadType.SpriteAtlas)
end

function N28StateAVGStoryBase:Destroy()
  N28StateAVGStoryBase.super.Destroy(self)
  self.ui = nil
end

function N28StateAVGStoryBase:NodeId(nodeId)
  return self.ui:NodeId(nodeId)
end

function N28StateAVGStoryBase:NextNodeId(nextNodeId)
  return self.ui:NextNodeId(nextNodeId)
end

function N28StateAVGStoryBase:PassSectionId(sectionSign)
  return self.ui:PassSectionId(sectionSign)
end

function N28StateAVGStoryBase:ClearPassSectionIds()
  self.ui:ClearPassSectionIds()
end

function N28StateAVGStoryBase:InitEvidenceBookShowStatus()
  self.ui:InitEvidenceBookShowStatus()
end

function N28StateAVGStoryBase:ShowJumpAnim(callback)
  self.ui:ShowJumpAnim(callback)
end

function N28StateAVGStoryBase:SetShowEvienceCount(manualID)
  self.ui:SetShowEvienceCount(manualID)
end

function N28StateAVGStoryBase:GetShowEvienceCount(manualID)
  return self.ui:GetShowEvienceCount(manualID)
end

function N28StateAVGStoryBase:ClearShowEvienceCount()
  return self.ui:ClearShowEvienceCount()
end

function N28StateAVGStoryBase:CopyEvidenceDataInCache()
  self.ui:CopyEvidenceDataInCache()
end

function N28StateAVGStoryBase:GetEvidenceDataInCache()
  return self.ui:GetEvidenceDataInCache()
end

function N28StateAVGStoryBase:ChangeEvidenceDataInCache(eid, isAdd)
  self.ui:ChangeEvidenceDataInCache(eid, isAdd)
end

function N28StateAVGStoryBase:CalcCurData()
  return self.ui:CalcCurData()
end

function N28StateAVGStoryBase:InitStoryManager()
  return self.ui:InitStoryManager()
end

function N28StateAVGStoryBase:ShowHideOption(isShow)
  self.ui:ShowHideOption(isShow)
end

function N28StateAVGStoryBase:ShowHideGainEvidence(isShow)
  self.ui:ShowHideGainEvidence(isShow)
end

function N28StateAVGStoryBase:ShowHideShowEvidence(isShow)
  self.ui:ShowHideShowEvidence(isShow)
end

function N28StateAVGStoryBase:ShowHideShowEvidenceEff(isShow)
  self.ui:ShowHideShowEvidenceEff(isShow)
end

function N28StateAVGStoryBase:ShowHideJumpBtn(isShow)
  if self.ui then
    self.ui:ShowHideJumpBtn(isShow)
  end
end

function N28StateAVGStoryBase:UpdateDriveByState(deltaTimeMS)
  if self.ui then
    self.ui:UpdateDriveByState(deltaTimeMS)
  end
end

function N28StateAVGStoryBase:ShowHideButtonAuto(isShow)
  self.ui.goAuto:SetActive(isShow)
end

function N28StateAVGStoryBase:ShowHideButtonReview(isShow)
  self.ui.btnReview:SetActive(isShow)
end

function N28StateAVGStoryBase:ShowHideButtonShowHideUI(isShow)
  self.ui.goShowHideUI:SetActive(isShow)
end

function N28StateAVGStoryBase:ShowHideButtonNext(isShow)
  self.ui.btnNext:SetActive(isShow)
end

function N28StateAVGStoryBase:ShowHideButtonGraph(isShow)
  self.ui.btnGraph:SetActive(isShow)
end

function N28StateAVGStoryBase:ShowHideButtonExit(isShow)
  self.ui.btnExit:SetActive(isShow)
end

function N28StateAVGStoryBase:ShowHideButtonEvidenceBook(isShow)
  self.ui:SetBtnEvidenceBookActive(isShow)
end

function N28StateAVGStoryBase:HandleSetCurrentLocation(TT, nodeId, callback, errCallback)
  local com = self.data:GetComponentAVG()
  local res = AsyncRequestRes:New()
  local ret = com:HandleSetCurrentLocation(TT, res, nodeId)
  if N28AVGData.CheckCode(res) then
    if callback then
      callback()
    end
  elseif errCallback then
    errCallback()
  end
end
