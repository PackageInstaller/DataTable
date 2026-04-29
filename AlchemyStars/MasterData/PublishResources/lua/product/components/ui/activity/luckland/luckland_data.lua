_class("LuckLandData", Singleton)
LuckLandData = LuckLandData

function LuckLandData:Init(missionID, threeDec, lucklandCmpt, lucklandInfoCmpt)
  self._curMissionID = missionID
  self._curCardDatas = UILuckLandCardDataLevel:New(missionID)
  self._curBuildingDatas = LuckLandBuildDataLevel:New(missionID)
  self._luckLandGameData = LuckLandGameData:New()
  self._lucklandThreeDec = threeDec
  self._lucklandCmpt = lucklandCmpt
  self._lucklandInfoCmpt = lucklandInfoCmpt
end

function LuckLandData:GetCurMissionID()
  return self._curMissionID
end

function LuckLandData:CurCardDatas()
  return self._curCardDatas
end

function LuckLandData:CurBuildingDatas()
  return self._curBuildingDatas
end

function LuckLandData:CurGameData()
  return self._luckLandGameData
end

function LuckLandData:CurThreeDecData()
  return self._lucklandThreeDec
end

function LuckLandData:CurLuckLandCmpt()
  return self._lucklandCmpt
end

function LuckLandData:CurLuckLandInfoCmpt()
  return self._lucklandInfoCmpt
end
