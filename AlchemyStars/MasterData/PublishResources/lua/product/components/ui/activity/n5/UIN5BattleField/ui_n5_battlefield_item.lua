_class("UIN5BattleFieldItem", UICustomWidget)
UIN5BattleFieldItem = UIN5BattleFieldItem

function UIN5BattleFieldItem:Constructor()
  self._callback = nil
end

function UIN5BattleFieldItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIN5BattleFieldItem:_GetComponents()
  self._background = self:GetUIComponent("RawImageLoader", "Background")
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._tag = self:GetUIComponent("RawImageLoader", "Tag")
  self._name = self:GetUIComponent("RollingText", "Name")
  self._militaryExploit = self:GetUIComponent("UILocalizationText", "MilitaryExploit")
  self._militaryExploitMax = self:GetUIComponent("UILocalizationText", "MilitaryExploitMax")
  self._difficulty = self:GetUIComponent("UILocalizationText", "Difficulty")
  self._select = self:GetGameObject("Select")
  self._backgroundBtn = self:GetGameObject("Background")
  self:_AddUIEvent(self._backgroundBtn)
end

function UIN5BattleFieldItem:SetData(index, cfg, maxMilitaryExploit, challengemissioninfo, callback)
  self._index = index
  self._cfg = cfg
  self._maxMilitaryExploit = maxMilitaryExploit
  self._challengemissioninfo = challengemissioninfo
  self._callback = callback
  self:_SetUIInfo()
end

function UIN5BattleFieldItem:_SetUIInfo()
  self._background:LoadImage(BattleFieldDifficultyImg.MapCardImg[self._cfg.Index])
  self._icon:LoadImage(BattleFieldDifficultyImg.MapAvatarImg[self._cfg.Index])
  self._tag:LoadImage(BattleFieldDifficultyImg.MapTagImg[self._cfg.Index])
  self._name:RefreshText(StringTable.Get(self._cfg.MissionName))
  if self._challengemissioninfo.military_exploit >= self._maxMilitaryExploit and self._maxMilitaryExploit > 0 then
    self._militaryExploit:SetText("")
    self._militaryExploitMax:SetText(self._challengemissioninfo.military_exploit)
  else
    self._militaryExploit:SetText(self._challengemissioninfo.military_exploit)
    self._militaryExploitMax:SetText("")
  end
  self._difficulty:SetText(StringTable.Get(BattleFieldDifficultyText.DifficultyText[self._cfg.Index]))
end

function UIN5BattleFieldItem:RefreshMilitaryExploit(maxMilitaryExploit, militaryexploit)
  if maxMilitaryExploit <= militaryexploit then
    self._militaryExploit:SetText("")
    self._militaryExploitMax:SetText(militaryexploit)
  else
    self._militaryExploit:SetText(militaryexploit)
    self._militaryExploitMax:SetText("")
  end
  self._militaryExploit:SetText(militaryexploit)
end

function UIN5BattleFieldItem:BackgroundOnClick(go)
  if self._callback then
    self._callback(self._index)
  end
end

function UIN5BattleFieldItem:_AddUIEvent(btn)
  UIEventTriggerListener.Get(btn).onDown = function(go)
    self:_OnPress(go, true)
  end
  UIEventTriggerListener.Get(btn).onUp = function(go)
    self:_OnPress(go, false)
  end
end

function UIN5BattleFieldItem:_OnPress(go, show)
  self._select:SetActive(show)
end
