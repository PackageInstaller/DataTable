_class("UIActivityN4CCLevelDetailTab", UICustomWidget)
UIActivityN4CCLevelDetailTab = UIActivityN4CCLevelDetailTab

function UIActivityN4CCLevelDetailTab:OnShow(uiParams)
  self:InitWidget()
  self._atlas = self:GetAsset("UIN4CC.spriteatlas", LoadType.SpriteAtlas)
end

function UIActivityN4CCLevelDetailTab:InitWidget()
  self.txtDiffculty = self:GetUIComponent("UILocalizationText", "txtDiffculty")
  self.bg = self:GetUIComponent("Image", "bg")
  self.pass = self:GetGameObject("pass")
end

function UIActivityN4CCLevelDetailTab:SetData(cfg, context, clickCb)
  self._cfg = cfg
  self._context = context
  self._clickCb = clickCb
  self:RefreshState()
end

function UIActivityN4CCLevelDetailTab:RefreshState()
  local state = self._context:GetMissionState(self._cfg)
  self._isLock = state == UIActivityN4CCHelper.DiffultyState.Lock
  self.pass:SetActive(state == UIActivityN4CCHelper.DiffultyState.Pass)
  if self._isLock then
    self.bg.sprite = self._atlas:GetSprite("activity_wjyz_gk_btn06")
  end
  if self._isLock then
    self.txtDiffculty:SetText("<color=#000000>" .. self:GetDiffcultyName(self._cfg.HardID) .. "</color>")
  else
    self.txtDiffculty:SetText(self:GetDiffcultyName(self._cfg.HardID))
  end
end

function UIActivityN4CCLevelDetailTab:SetSelect(bSelect)
  if bSelect then
    self.bg.sprite = self._atlas:GetSprite("activity_wjyz_gk_btn05")
  else
    self.bg.sprite = self._atlas:GetSprite("activity_wjyz_gk_btn04")
  end
end

function UIActivityN4CCLevelDetailTab:BtnOnClick(go)
  if self._isLock then
    ToastManager.ShowToast(StringTable.Get("str_crisis_contract_lock_diffculty"))
    return
  end
  if self._clickCb then
    self._clickCb(self)
  end
end

function UIActivityN4CCLevelDetailTab:GetCfg()
  return self._cfg
end

function UIActivityN4CCLevelDetailTab:IsLock()
  return self._isLock
end

function UIActivityN4CCLevelDetailTab:GetDiffcultyName(diff)
  return StringTable.Get("str_crisis_contract_hard_title" .. diff)
end
