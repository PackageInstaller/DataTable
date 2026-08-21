require("n28_state_avg_story_base")
_class("N28StateAVGStoryAuto", N28StateAVGStoryBase)
N28StateAVGStoryAuto = N28StateAVGStoryAuto

function N28StateAVGStoryAuto:OnEnter(TT, ...)
  self:Init()
  self.storyManager = self.data:StoryManager()
  self.storyManager:SetAuto(true, 1)
  self:FlushButtonAuto(true)
  self:ShowHideButtonReview(false)
  self:ShowHideButtonShowHideUI(false)
  self:ShowHideButtonNext(false)
  self:ShowHideButtonGraph(false)
  self:ShowHideButtonExit(false)
  self:ShowHideButtonEvidenceBook(false)
end

function N28StateAVGStoryAuto:OnExit(TT)
  self.storyManager:SetAuto(false, 1)
  self:FlushButtonAuto(false)
  self:ShowHideButtonReview(true)
  self:ShowHideButtonShowHideUI(true)
  self:ShowHideButtonNext(true)
  self:ShowHideButtonGraph(true)
  self:ShowHideButtonExit(true)
  self:ShowHideButtonEvidenceBook(true)
end

function N28StateAVGStoryAuto:OnUpdate(deltaTimeMS)
  self:UpdateDriveByState(deltaTimeMS)
end

function N28StateAVGStoryAuto:FlushButtonAuto(isAuto)
  if isAuto then
    self.ui.imgAuto.sprite = self.atlas:GetSprite("N28_avg_jq_icon05")
  else
    self.ui.imgAuto.sprite = self.atlas:GetSprite("N28_avg_jq_icon04")
  end
end
