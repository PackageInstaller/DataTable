_class("UIRugueLikeLastStageTipController", UIController)
UIRugueLikeLastStageTipController = UIRugueLikeLastStageTipController

function UIRugueLikeLastStageTipController:OnShow(uiParam)
end

function UIRugueLikeLastStageTipController:bgOnClick()
  self:ShowDialog("UIRugueLikeBattleResultController", true)
end
