require("state_avg_story_base")
_class("StateAVGStoryAuto", StateAVGStoryBase)
StateAVGStoryAuto = StateAVGStoryAuto

function StateAVGStoryAuto:OnEnter(TT, ...)
  self:Init()
  self.storyManager = self.data:StoryManager()
  self.storyManager:SetAuto(true)
  self:FlushButtonAuto(true)
  self:ShowHideButtonReview(false)
  self:ShowHideButtonShowHideUI(false)
  self:ShowHideButtonNext(false)
  self:ShowHideButtonGraph(false)
  self:ShowHideButtonExit(false)
end

function StateAVGStoryAuto:OnExit(TT)
  self.storyManager:SetAuto(false)
  self:FlushButtonAuto(false)
  self:ShowHideButtonReview(true)
  self:ShowHideButtonShowHideUI(true)
  self:ShowHideButtonNext(true)
  self:ShowHideButtonGraph(true)
  self:ShowHideButtonExit(true)
end

function StateAVGStoryAuto:OnUpdate(deltaTimeMS)
  self:UpdateDriveByState(deltaTimeMS)
end

function StateAVGStoryAuto:FlushButtonAuto(isAuto)
  if isAuto then
    self.ui.imgAuto.sprite = self.atlas:GetSprite("N20_avg_dh_icon05")
  else
    self.ui.imgAuto.sprite = self.atlas:GetSprite("N20_avg_dh_icon04")
  end
end
