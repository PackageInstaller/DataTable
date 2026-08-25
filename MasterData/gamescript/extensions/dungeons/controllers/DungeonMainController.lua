local DungeonMainController, Super = NewClass("DungeonMainController", BaseController)

function DungeonMainController:OpenDungeonMainView(targetPage)
  DungeonMainModel.Instance:SetCurDBGEntryPage(targetPage)
end

return DungeonMainController
