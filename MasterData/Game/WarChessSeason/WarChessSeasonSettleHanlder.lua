local WarChessSeasonSettleHanlder = class("WarChessSeasonSettleHanlder")
local cs_MessageCommon = CS.MessageCommon

function WarChessSeasonSettleHanlder:EnterWarchessLevel(isWin, settleMsg, WCResultFunc)
  local nextWarChessLobby = settleMsg.nextWarChessLobby
  local nextRooms = settleMsg.RoomData
  local seasonSettleData = settleMsg.seasonData
  local totalScore = seasonSettleData.totalScore
  WarChessSeasonManager.__wcSeasonCtrl:WCSSetTotalScore(totalScore)
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  wcCtrl.palySquCtrl:SetWCSGetRewardWhenSettle(seasonSettleData)
  wcCtrl.palySquCtrl:SetWCSSelectLevel(nextWarChessLobby, nextRooms)
  local floor = WarChessSeasonManager.__wcSeasonCtrl.warChessSeasonFloor
  local addtionData = WarChessSeasonManager:GetSeasonAddtionData()
  if addtionData and addtionData:IsSetSeasonCompleteFloor() and addtionData:GetSeasonCompleteFloor() == floor then
    wcCtrl.palySquCtrl:SetCompleteFloorTipCallCoroutine(function()
      cs_MessageCommon.ShowMessageBox(addtionData:GetSeasonCompleteFloorTip(), function()
        wcCtrl.palySquCtrl:ResumeFloorTipCallCoroutine()
      end, function()
        WarChessManager:GiveUpWarchess()
      end)
    end, true)
  end
  wcCtrl.palySquCtrl:WhenWCSLevelSettle()
end

function WarChessSeasonSettleHanlder:EnterWarchessSeason(isWin, settleMsg, WCResultFunc)
  local addtionData = WarChessSeasonManager:GetSeasonAddtionData()
  local isFakeWin = false
  if not isWin and addtionData ~= nil and addtionData:IsSetSeasonCompleteFloor() then
    local floor = WarChessSeasonManager:GetWCSCtrl():WCSGetFloor()
    isFakeWin = floor > addtionData:GetSeasonCompleteFloor()
  end
  local seasonId = WarChessSeasonManager:GetWCSSeasonId()
  WarChessSeasonManager:RefreshWCSPassedTowerData(seasonId)
  UIManager:ShowWindowAsync(UIWindowTypeID.WCDebuffResult, function(window)
    if window ~= nil then
      local hightesScore = WarChessSeasonManager:GetWCHighesScore()
      window:InitWarchessSeasonResult(settleMsg.seasonData, hightesScore, isFakeWin, function()
        if WCResultFunc ~= nil then
          WCResultFunc(isFakeWin)
        end
      end)
    end
  end)
end

return WarChessSeasonSettleHanlder
