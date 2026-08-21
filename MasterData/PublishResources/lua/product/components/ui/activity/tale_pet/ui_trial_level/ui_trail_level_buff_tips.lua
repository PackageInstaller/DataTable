_class("UITrailLevelBuffTips", UIController)
UITrailLevelBuffTips = UITrailLevelBuffTips

function UITrailLevelBuffTips:LoadDataOnEnter(TT, res, uiParams)
  self._talePetModule = GameGlobal.GetModule(TalePetModule)
  self._talePetModule:ApplyBuffInfo(TT)
  local maxLevel = 1
  self._buffLevel, maxLevel = self._talePetModule:GetBuffLevel()
  self._talePetModule:ShowBuffTips(TT)
end

function UITrailLevelBuffTips:OnShow(uiParams)
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._buffLevelLabel = self:GetUIComponent("UILocalizationText", "Level")
  local cfg = Cfg.cfg_trail_level_buff_level[self._buffLevel]
  if not cfg then
    return
  end
  self._buffId = cfg.BuffId
  self._name:SetText(StringTable.Get(cfg.BuffName))
  self._icon:LoadImage(cfg.BuffIcon)
  self._buffLevelLabel:SetText(StringTable.Get("str_tale_pet_trail_level_buff_level", self._buffLevel))
  self._callback = uiParams[1]
end

function UITrailLevelBuffTips:MaskOnClick()
  self:Lock("UITrailLevelBuffTips_MaskOnClick")
  GameGlobal.TaskManager():StartTask(self.Close, self)
end

function UITrailLevelBuffTips:Close(TT)
  local anim = self:GetUIComponent("Animation", "Anim")
  anim:Play("uieff_uiTrailLevelBuffTips_out")
  YIELD(TT, 500)
  if self._callback then
    self._callback()
  end
  self:CloseDialog()
  self:UnLock("UITrailLevelBuffTips_MaskOnClick")
end
