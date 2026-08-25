local ANIM_DURATION_TIME = 3.91
local TutorialPopTip, Super = System.NewClass("TutorialPopTip", UIBasePanel)
TutorialPopTip.uiResCls = UI_Common_Tips_CourseBubbleResource

function TutorialPopTip:ctor(tidGroup)
  Super.ctor(self)
  self.tidGroup = tidGroup
end

function TutorialPopTip:OnBind(binder)
  self.binder = binder
  binder:BindZ1Button(self.ui.uiNode, function()
    self:Close()
    TutorialDataUtils.OpenTutorialMainPanel(self.tidGroup)
  end)
  binder:BindToText(self.ui.Text_Name, function()
    if self:IsMultiTutorialUnlock() then
      do return LT.Text end
      return LT.Text, "CoursePopMultiTipText", nil
    end
    local tid = self.tidGroup[1]
    local tutorialCfg = TutorialDataUtils.GetConfigByTid(tid)
    return tutorialCfg.Title
  end)
  binder:BindToImage(self.ui.Image_Icon, function()
    if self:IsMultiTutorialUnlock() then
      return CommonDefine.TutorialPopTipIcon.Multi
    end
    return CommonDefine.TutorialPopTipIcon.Single
  end)
  self:CloseCountDown()
end

function TutorialPopTip:IsMultiTutorialUnlock()
  return #self.tidGroup > 1
end

function TutorialPopTip:CloseCountDown()
  self.binder:BindTimer(ANIM_DURATION_TIME, 0, nil, function()
    self:Close()
  end)
end

function TutorialPopTip:OpenTutorialMainPanel()
  TutorialDataUtils.OpenTutorialMainPanel(self.tidGroup)
end

return TutorialPopTip
