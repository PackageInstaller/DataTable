local this = {}

function this:checkPagePlayerExp()
  local curPageName = L_UI:currentPage(L_UI.groupKeys.stack)
  if curPageName ~= "pageMainCity" then
    return false
  end
  return true
end

function this:checkPageAttendance()
  local curPageName = L_UI:currentPage(L_UI.groupKeys.stack)
  if curPageName ~= "pageMainCity" then
    return false
  end
  local eId = L_GameEventStore:getIdByType(L_Const.ActivityType.AT_SIGN)
  if not eId then
    return
  end
  local eventData = L_GameEventStore:getGameEventData(eId)
  if not eventData:isValid() then
    return false
  end
  if not L_UI:checkPageShown("pageAttendance", true) then
    return true
  end
  if L_UI:checkPageShown("pageMainCity", true) then
    return true
  end
  return false
end

function this:checkFlyMsgHomeScienceExpTip()
  local status = L_UI:getPageStatus("pageReward")
  if status == "shown" or status == "opening" then
    return false
  end
  return true
end

function this:checkIsMainPage()
  local curPageName = L_UI:currentPage(L_UI.groupKeys.stack)
  if curPageName ~= "pageMainCity" then
    return false
  end
  if L_UI:checkPageShown("pageMainCity", true) then
    return true
  end
  return false
end

function this:checkIsInReading()
  local curPageName = L_UI:currentPage(L_UI.groupKeys.stack)
  if curPageName == "pageLibraryBookBrowse" or curPageName == "pageLibraryBookNews" then
    return false
  end
  return true
end

return this
