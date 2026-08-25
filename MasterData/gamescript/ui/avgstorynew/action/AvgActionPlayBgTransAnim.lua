local UIAnimationController = CS.Z1Client.UIAnimationController
local AvgActionPlayBgTransAnim, Super = System.NewClass("AvgActionPlayBgTransAnim", AvgActionBase)

function AvgActionPlayBgTransAnim:ctor(...)
  Super.ctor(self, ...)
  self.binder:BindEvent(EventMgr.Instance.CSSendEvent, System.fn(self, self.OnCSSendEvent))
end

function AvgActionPlayBgTransAnim:DoAction(_, bgAnim)
  self.ui.Image_Mask:SetActive(false)
  local animTb = {
    [CommonDefine.BgTrans.FastWhiteFlash] = {
      "UI_Story_Transition_1",
      0.05
    },
    [CommonDefine.BgTrans.SlowWhiteFlash] = {
      "UI_Story_Transition_2",
      0.05
    },
    [CommonDefine.BgTrans.FastBlackFlash] = {
      "UI_Story_Transition_3",
      0.033
    },
    [CommonDefine.BgTrans.SlowBlackFlash] = {
      "UI_Story_Transition_4",
      0.05
    },
    [CommonDefine.BgTrans.VerySlowBlack] = {
      "UI_jianbian_zl_vx_01_open3.5",
      0.05
    },
    [CommonDefine.BgTrans.GradualBlack] = {
      "UI_Story_Transition_5",
      1.45
    },
    [CommonDefine.BgTrans.QuickBlack] = {
      "UI_Story_Transition_6",
      1.45
    }
  }
  local animName, _ = table.unpack(animTb[bgAnim] or {})
  self.binder:BindTimer(6, 0, nil, function()
    self:ChangeAvgBg()
  end)
  if bgAnim == CommonDefine.BgTrans.SlowTimePass or bgAnim == CommonDefine.BgTrans.FastTimePass then
    self:StopVideo()
    local videoPath = CommonDefine.BgTransVideoPath
    local videoParams = videoPath[bgAnim]
    self.ui.TimelineVideoUIAdd:SetActive(true)
    local videoPath = CommonDefine.BgTransVideoPath
    local videoParams = videoPath[bgAnim]
    local uiRes = TimelineVideoUIAddResource(self.ui.TimelineVideoUIAdd)
    self.videoUIAddPlayer = AVProAlphaVideoPlayer(uiRes.color, uiRes.color_bak, uiRes.alpha, uiRes.alpha_bak)
    self.videoUIAddPlayer:OpenMedia(videoParams[1], videoParams[2])
    self.videoUIAddPlayer:SetLooping(videoParams[3] or false)
    self.videoUIAddPlayer:SetRawImage(uiRes.uiNode)
    
    function self.videoUIAddPlayer.finishedCallback()
      self:OnVideoEnd()
    end
    
    AddLuaCompOnce(uiRes.uiNode, AVProVideoLiftTimeControl):SetVideoPlayer(self.videoUIAddPlayer)
    local changeBgTime = videoParams[4]
    self.binder:BindTimer(changeBgTime, 0, nil, function()
      self:ChangeAvgBg()
    end)
    local overTime = 5
    self._overTimer = self.binder:BindTimer(overTime, 0, nil, function()
      self:OnVideoEnd()
    end)
    self.binder:onDestroy(function()
      self:StopVideo()
    end)
  elseif bgAnim == CommonDefine.BgTrans.FromRight then
    self.ui.UI_Black_animation:SetActive(true)
    local blackAniCtr = self.ui.UI_Black_animation:GetComponent(typeof(UIAnimationController))
    if blackAniCtr then
      blackAniCtr:PlayState("UI_Black_animation_a", function()
        self.ui.UI_Black_animation:SetActive(false)
      end)
    end
    self.binder:BindTimer(2, 0, nil, function()
      self.avgModel:SetLockInBgTrans(false)
      self:ChangeAvgBg()
    end)
  else
    self.avgPanel.uiAnimController:PlayState(animName, function()
      self.avgModel:SetLockInBgTrans(false)
      self:ChangeAvgBg()
    end)
  end
end

function AvgActionPlayBgTransAnim:OnVideoEnd()
  if self._overTimer then
    self.binder:StopTimer(self._overTimer)
  end
  self.ui.TimelineVideoUIAdd:SetActive(false)
  self.avgModel:SetLockInBgTrans(false)
  self:StopVideo()
end

function AvgActionPlayBgTransAnim:StopVideo()
  if self.videoUIAddPlayer then
    self.videoUIAddPlayer:Dispose()
    self.videoUIAddPlayer = nil
  end
end

function AvgActionPlayBgTransAnim:OnCSSendEvent(evenName, _)
  if "ChangeAvgBg" == evenName then
    self:ChangeAvgBg()
  end
end

function AvgActionPlayBgTransAnim:ChangeAvgBg()
  self.avgPanel.bgComp:SetBg()
  self:FinishAction()
end

return AvgActionPlayBgTransAnim
