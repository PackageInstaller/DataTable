_class("StateN24ShopInit", StateN24ShopBase)
StateN24ShopInit = StateN24ShopInit

function StateN24ShopInit:OnEnter(TT, ...)
  self:Init()
  self._uiModule:LockAchievementFinishPanel(false)
end

function StateN24ShopInit:OnExit(TT)
end
