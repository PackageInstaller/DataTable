_class("UISMazeRoomLeaveBtn", UICustomWidget)
UISMazeRoomLeaveBtn = UISMazeRoomLeaveBtn

function UISMazeRoomLeaveBtn:Constructor()
end

function UISMazeRoomLeaveBtn:OnShow(uiParams)
end

function UISMazeRoomLeaveBtn:SetData(callback)
  self.callback = callback
end

function UISMazeRoomLeaveBtn:OnHide()
end

function UISMazeRoomLeaveBtn:ButtonBackOnClick(go)
  if self.callback then
    self.callback()
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundCancel)
end
