_class("StateAVGStoryBase", State)
StateAVGStoryBase = StateAVGStoryBase

function StateAVGStoryBase:Init()
  self.fsm = self:GetFsm()
  self.ui = self.fsm:GetData()
  self.data = self.ui.data
  self.atlas = self.ui:GetAsset("UIAVG.spriteatlas", LoadType.SpriteAtlas)
end

function StateAVGStoryBase:Destroy()
  StateAVGStoryBase.super.Destroy(self)
  self.ui = nil
end

function StateAVGStoryBase:NodeId(nodeId)
  return self.ui:NodeId(nodeId)
end

function StateAVGStoryBase:NextNodeId(nextNodeId)
  return self.ui:NextNodeId(nextNodeId)
end

function StateAVGStoryBase:PassSectionId(sectionSign)
  return self.ui:PassSectionId(sectionSign)
end

function StateAVGStoryBase:ClearPassSectionIds()
  self.ui:ClearPassSectionIds()
end

function StateAVGStoryBase:CalcCurData()
  return self.ui:CalcCurData()
end

function StateAVGStoryBase:InitStoryManager()
  return self.ui:InitStoryManager()
end

function StateAVGStoryBase:ShowHideOption(isShow)
  self.ui:ShowHideOption(isShow)
end

function StateAVGStoryBase:UpdateDriveByState(deltaTimeMS)
  if self.ui then
    self.ui:UpdateDriveByState(deltaTimeMS)
  end
end

function StateAVGStoryBase:ShowHideButtonAuto(isShow)
  self.ui.goAuto:SetActive(isShow)
end

function StateAVGStoryBase:ShowHideButtonReview(isShow)
  self.ui.btnReview:SetActive(isShow)
end

function StateAVGStoryBase:ShowHideButtonShowHideUI(isShow)
  self.ui.goShowHideUI:SetActive(isShow)
end

function StateAVGStoryBase:ShowHideButtonNext(isShow)
  self.ui.btnNext:SetActive(isShow)
end

function StateAVGStoryBase:ShowHideButtonGraph(isShow)
  self.ui.btnGraph:SetActive(isShow)
end

function StateAVGStoryBase:ShowHideButtonExit(isShow)
  self.ui.btnExit:SetActive(isShow)
end

function StateAVGStoryBase:HandleSetCurrentLocation(TT, nodeId, callback)
  local com = self.data:GetComponentAVG()
  local res = AsyncRequestRes:New()
  local ret = com:HandleSetCurrentLocation(TT, res, nodeId)
  if N20AVGData.CheckCode(res) and callback then
    callback()
  end
end
