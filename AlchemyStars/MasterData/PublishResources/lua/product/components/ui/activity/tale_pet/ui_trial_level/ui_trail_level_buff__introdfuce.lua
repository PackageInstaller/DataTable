_class("UITrailLevelBuffIntroduce", UIController)
UITrailLevelBuffIntroduce = UITrailLevelBuffIntroduce

function UITrailLevelBuffIntroduce:OnShow(uiParams)
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._buffLevel = uiParams[1]
  local cfg = Cfg.cfg_trail_level_buff_level[self._buffLevel]
  if not cfg then
    return
  end
  self._icon:LoadImage(cfg.BuffIcon)
end

function UITrailLevelBuffIntroduce:MaskOnClick()
  self:Lock("UITrailLevelBuffIntroduce_MaskOnClick")
  GameGlobal.TaskManager():StartTask(self.Close, self)
end

function UITrailLevelBuffIntroduce:Close(TT)
  local anim = self:GetUIComponent("Animation", "Anim")
  anim:Play("uieff_yiTrailLevelBuffIntroduce_out")
  YIELD(TT, 500)
  self:CloseDialog()
  self:UnLock("UITrailLevelBuffIntroduce_MaskOnClick")
end
