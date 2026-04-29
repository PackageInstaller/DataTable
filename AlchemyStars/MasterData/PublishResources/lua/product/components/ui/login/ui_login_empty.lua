_class("UILoginEmpty", UIController)
UILoginEmpty = UILoginEmpty

function UILoginEmpty:OnShow(uiParams)
  if not _G.APPVER1220 then
    GameGlobal.UIStateManager():SetForceCloseBlackSideVisible(false)
  end
  if LoginLuaHelper.GetUIState() == LoginUIState.Close then
    LogoutGameNew()
  end
end

function UILoginEmpty:OnHide()
  if not _G.APPVER1220 then
    GameGlobal.UIStateManager():SetForceCloseBlackSideVisible(true)
  end
end
