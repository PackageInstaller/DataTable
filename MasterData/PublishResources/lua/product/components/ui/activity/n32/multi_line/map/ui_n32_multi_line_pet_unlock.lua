_class("UIN32MultiLinePetUnlock", UIController)
UIN32MultiLinePetUnlock = UIN32MultiLinePetUnlock

function UIN32MultiLinePetUnlock:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIN32MultiLinePetUnlock:OnShow(uiParams)
  self._petRewardId = uiParams[1]
  self._finishCallback = uiParams[2]
  self:InitWidget()
  self:OnValue()
end

function UIN32MultiLinePetUnlock:InitWidget()
  self.desc = self:GetUIComponent("UILocalizationText", "desc")
  self.content = self:GetUIComponent("UILocalizationText", "content")
  self.petImage = self:GetUIComponent("RawImageLoader", "petImage")
  self.animation = self:GetUIComponent("Animation", "animation")
end

function UIN32MultiLinePetUnlock:OnValue()
  local petfileCfg = Cfg.cfg_component_multiline_mission_petfiles[self._petRewardId]
  if not petfileCfg then
    Log.error("err: UIN32MultiLinePetUnlock cfg_component_multiline_mission_petfiles can't find  " .. self._petRewardId)
    return
  end
  self.content:SetText(StringTable.Get(petfileCfg.Title))
  self.desc:SetText(StringTable.Get(petfileCfg.Desc))
  local cfgs = Cfg.cfg_component_multiline_mission_pet({
    ComponentID = petfileCfg.ComponentID
  })
  if cfgs then
    for k, subCfg in pairs(cfgs) do
      for i, v in ipairs(subCfg.FilesID) do
        if v == self._petRewardId then
          self.petImage:LoadImage(subCfg.HeadImg)
        end
      end
    end
  end
end

function UIN32MultiLinePetUnlock:ClsoeBtnOnClick(go)
  self:StartTask(function(TT)
    local lockName = "UIN32MultiLinePetUnlock:ExitAni"
    self:Lock(lockName)
    self.animation:Play("uieff_UIN32MultiLinePetUnlock_out")
    YIELD(TT, 200)
    self:CloseDialog()
    self:UnLock(lockName)
    if self._finishCallback then
      self._finishCallback()
    end
  end)
end
