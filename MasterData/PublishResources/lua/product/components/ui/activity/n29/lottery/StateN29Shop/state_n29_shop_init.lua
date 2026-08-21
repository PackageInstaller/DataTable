_class("StateN29ShopInit", StateN29ShopBase)
StateN29ShopInit = StateN29ShopInit

function StateN29ShopInit:OnEnter(TT, ...)
  self:Init()
  self._uiModule:LockAchievementFinishPanel(false)
end

function StateN29ShopInit:OnExit(TT)
end
