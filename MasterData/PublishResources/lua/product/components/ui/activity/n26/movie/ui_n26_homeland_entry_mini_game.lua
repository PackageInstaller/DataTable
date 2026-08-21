_class("UIN26HomelandEntryMiniGame", Object)
UIN26HomelandEntryMiniGame = UIN26HomelandEntryMiniGame

function UIN26HomelandEntryMiniGame:Constructor(campaign)
  self._campaign = campaign
end

function UIN26HomelandEntryMiniGame:GetNew()
  self._movieDataHelper = MovieDataHelper:New()
  local type = self._movieDataHelper:ShowOrNot()
  return type
end

function UIN26HomelandEntryMiniGame:GetRedCount()
  return 0
end

function UIN26HomelandEntryMiniGame:OpenUI()
  GameGlobal.UIStateManager():ShowDialog("UIN26Movie", true)
end
