local this = L_BevTree:registClass("guide.mainCityUIRevertAction", L_BevTree.action)

function this:param()
end

function this:parse()
end

function this:onEnter()
  if CS.Lens.Gameplay.Managers.GuideManager.CheckInRealTimePetCatchState() then
    CS.Lens.Gameplay.Managers.GuideManager.ExitRealTimePetCatchState()
  end
  if CS.Lens.Gameplay.Managers.GuideManager.CheckInShowQuickItemBarState() then
    CS.Lens.Gameplay.Managers.GuideManager.ExitShowQuickItemBarState()
  end
end

function this:execute()
  return L_BevTree.taskResult.Success
end

return this
