_class("HomeLoading", Object)
HomeLoading = HomeLoading

function HomeLoading.Self()
  Log.debug("[HomelandProfile] (HomeLoading.Self) StartLoading")
  GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Homeland_Enter, "konggu02func")
end

function HomeLoading.Self_Art()
  GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Homeland_Enter, "konggu02")
end

function HomeLoading.Visit(friendID)
  GameGlobal.TaskManager():StartTask(HomeLoading._CheckFriend, {}, friendID, function()
    GameGlobal.LoadingManager():StartLoading("HomeVisitEnterLoadingHandler", "konggu02func", friendID)
  end)
end

function HomeLoading.VisitToSelf()
  GameGlobal.LoadingManager():StartLoading("HomeVisitToSelfLoading", "konggu02func")
end

function HomeLoading.SelfToVisit(friendID)
  GameGlobal.TaskManager():StartTask(HomeLoading._CheckFriend, {}, friendID, function()
    GameGlobal.LoadingManager():StartLoading("HomeSelfToVisitLoading", "konggu02func", friendID)
  end)
end

function HomeLoading.VisitToVisit(friendID)
  GameGlobal.TaskManager():StartTask(HomeLoading._CheckFriend, {}, friendID, function()
    GameGlobal.LoadingManager():StartLoading("HomeVisitToVisitLoading", "konggu02func", friendID)
  end)
end

function HomeLoading.Exit(...)
  GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Homeland_Exit, "UI", ...)
end

function HomeLoading._CheckFriend(_, TT, id, func)
  GameGlobal.UIStateManager():Lock("CheckFriendBeforeVisit")
  local res = GameGlobal.GetModule(SocialModule):HandleCEventBothwayFriend(TT, id)
  GameGlobal.UIStateManager():UnLock("CheckFriendBeforeVisit")
  if res:GetSucc() then
    func()
  else
    local m = ChatFriendManager:New()
    m:HandleErrorMsgCode(res:GetResult())
  end
end
