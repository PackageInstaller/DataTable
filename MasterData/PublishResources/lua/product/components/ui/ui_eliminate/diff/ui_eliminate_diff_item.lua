_class("UIEliminateDiffItem", UICustomWidget)
UIEliminateDiffItem = UIEliminateDiffItem

function UIEliminateDiffItem:Constructor()
  self._isLock = true
end

function UIEliminateDiffItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIEliminateDiffItem:_GetComponents()
  self._diffTitle = self:GetUIComponent("UILocalizationText", "diffTitle")
  self._scoreNum = self:GetUIComponent("UILocalizationText", "scoreNum")
  self._lockTxt = self:GetUIComponent("UILocalizationText", "lockTxt")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._animObj = self:GetGameObject("anim")
  self._lockMaskObj = self:GetGameObject("lockMask")
end

function UIEliminateDiffItem:SetData(cfg, index, callback)
  self._cfg = cfg
  self._index = index
  self._callback = callback
  self:_InitComponents()
end

function UIEliminateDiffItem:_InitComponents()
  self._diffTitle:SetText(StringTable.Get("str_eliminate_difficulty", self._cfg.ID))
  self._scoreNum:SetText(self._cfg.RoundScore)
  local anipopModule = GameGlobal.GetModule(AnipopModule)
  local anipopInfo = anipopModule:GetAniPopInfo()
  if self._cfg.ID <= anipopInfo.cur_hard_id then
    self._isLock = false
  else
    self._lockTxt:SetText(StringTable.Get("str_eliminate_diff_locktip1"))
  end
  self._scoreNum.color = self._isLock and Color(1, 1, 1) or Color(0.8823529411764706, 0.7529411764705882, 0.4235294117647059)
  self._lockMaskObj:SetActive(self._isLock)
  self:StartTask(function(TT)
    local yieldTime = (self._index - 1) * 60
    YIELD(TT, yieldTime)
    if not tolua.isnull(self._animObj) then
      self._anim:Play("uieff_UIEliminateDiffItem_in")
    end
  end)
end

function UIEliminateDiffItem:BgOnClick()
  if self._isLock then
    return
  end
  if self._callback then
    self._callback(self._cfg.ID)
  end
end
