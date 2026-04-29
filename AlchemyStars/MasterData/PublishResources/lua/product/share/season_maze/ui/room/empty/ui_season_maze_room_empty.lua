_class("UISeasonMazeRoomEmpty", UISeasonMazeRoomBase)
UISeasonMazeRoomEmpty = UISeasonMazeRoomEmpty

function UISeasonMazeRoomEmpty:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UISeasonMazeRoomEmpty:OnShowUI(uiParams)
  self:ShowDialog("UISeasonMazeRoomPopBox", SeasonMazeRoomType.SMRT_Empty, function()
    self:OnHideUI()
  end)
end
