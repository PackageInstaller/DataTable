_class("UISakuraItem", UICustomWidget)
UISakuraItem = UISakuraItem

function UISakuraItem:OnShow(uiParams)
  self:_InitBackGroundStateSprite()
  self:_GetComponents()
end

function UISakuraItem:_InitBackGroundStateSprite()
end

function UISakuraItem:_GetComponents()
  self._backGround = self:GetUIComponent("RawImageLoader", "BackGround")
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self._sakuraCost = self:GetGameObject("SakuraCost")
  self._richCost = self:GetUIComponent("UIRichText", "RichCost")
  self._redPoint = self:GetGameObject("RedPoint")
  self._redPointSpine = self:GetUIComponent("SpineLoader", "RedPoint")
  self._promptBg = self:GetGameObject("PromptBg")
  self._lockBg = self:GetUIComponent("RawImageLoader", "Lock")
  self._lock = self:GetGameObject("Lock")
end

function UISakuraItem:SetData(config, index, state, callBack)
  self._config = config
  self._index = index
  self._state = state
  self._callback = callBack
  self:_SetUIInfo()
end

function UISakuraItem:_SetUIInfo()
  self._title:SetText(StringTable.Get(self._config.title))
  self._sakuraCost:SetActive(self._state == SakuraStoryState.Lock)
  self._lock:SetActive(self._state == SakuraStoryState.Lock)
  if self._state == SakuraStoryState.Lock then
    if self._richCost then
      local fontSize = 32
      local costStr = self._config.unlockcount .. "<sprite=legend_zhangjie_icon4 size=100 />"
      local str = StringTable.Get("str_sakura_to_unlock_story", fontSize, costStr)
      self._richCost:SetText(str)
    end
    self._lockBg:LoadImage("legend_zhangjie_btn3")
  end
  self._redPoint:SetActive(self._state == SakuraStoryState.UnLockCanPlay)
  if self._state == SakuraStoryState.UnLockCanPlay and self._redPointSpine then
    self._redPointSpine:SetAnimation(0, "appear", false)
    GameGlobal.Timer():AddEvent(433, function()
      self._redPointSpine:SetAnimation(0, "idle", true)
    end)
  end
  self._promptBg:SetActive(self._state == SakuraStoryState.UnLockCantPlay)
end

function UISakuraItem:OnUpdate(alpha)
  if self._state == SakuraStoryState.UnLockCanPlay then
    self._redPointSpine.CurrentSkeleton.color = Color(1, 1, 1, alpha)
    self._redPointSpine.CurrentSkeleton.Skeleton.A = alpha
  end
end

function UISakuraItem:RefreshItemInfo(state)
  if self._state ~= state then
    self._state = state
    self:_SetUIInfo()
  end
end

function UISakuraItem:BtnOnClick(go)
  self._callback(self._index)
end
