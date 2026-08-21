_class("StateAVGStoryBECheck", StateAVGStoryBase)
StateAVGStoryBECheck = StateAVGStoryBECheck

function StateAVGStoryBECheck:OnEnter(TT, ...)
  self:Init()
  local auto = table.unpack({
    ...
  })
  self.storyManager = self.data:StoryManager()
  local storyId = self.storyManager:GetCurStoryID()
  local paragraphId = self.storyManager:GetCurParagraphID()
  local sectionIdx = self.storyManager:GetCurSectionIndex()
  self:FlushChangeValue(storyId, paragraphId, sectionIdx)
  local dialog = self:GetDialog(storyId, paragraphId, sectionIdx)
  if dialog and dialog:IsSatisfyBE() then
    GameGlobal.UIStateManager():ShowDialog("UIN20AVGEnding", dialog.beId)
  end
  if self.storyManager:IsEnd() then
    self:ChangeState(StateAVGStory.Over)
  elseif auto then
    self:ChangeState(StateAVGStory.Auto)
  else
    self:ChangeState(StateAVGStory.Play)
  end
end

function StateAVGStoryBECheck:OnExit(TT)
end

function StateAVGStoryBECheck:GetDialog(storyId, paragraphId, sectionIdx)
  local node = self.data:GetNodeByStoryId(storyId)
  local paragraph = node:GetParagraphByParagraphId(paragraphId)
  local dialog = paragraph:GetDialogBySectionIdx(sectionIdx)
  return dialog
end

function StateAVGStoryBECheck:FlushChangeValue(storyId, paragraphId, sectionIdx)
  local dialog = self:GetDialog(storyId, paragraphId, sectionIdx)
  if dialog and dialog:HasValueChange() then
    local sign = N20AVGData.Sign({
      storyId,
      paragraphId,
      sectionIdx
    })
    self.ui:SetPassSectionId(sign, true)
    self.ui:FlushData()
    local vc = dialog:ValueChange()
    if vc then
      local hpDelta = vc[1] or 0
      self.ui:PlayAnimHP(hpDelta)
    end
  end
  self:FlushDebugText()
end

function StateAVGStoryBECheck:FlushDebugText()
  if IsUnityEditor() then
    local storyId = self.storyManager:GetCurStoryID()
    local paragraphId = self.storyManager:GetCurParagraphID()
    local sectionIdx = self.storyManager:GetCurSectionIndex()
    local curTime = self.storyManager:GetCurrentTime()
    local line1 = string.format("[storyId=%d] [ParagraphId=%d] [sectionIdx=%d] [curTime=%f]", storyId, paragraphId, sectionIdx, curTime)
    local line2 = "passSectionIds="
    local passSectionIds = self:PassSectionId()
    for key, passSectionId in pairs(passSectionIds) do
      line2 = line2 .. key .. ";"
    end
    local log = line1 .. "\n" .. line2
    self.ui.txtDebug:SetText(log)
  end
end
