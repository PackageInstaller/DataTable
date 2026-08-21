_class("AircrafBuildData", Object)
AircrafBuildData = AircrafBuildData

function AircrafBuildData:Constructor()
  self._id = 0
  self._roomType = 0
  self._lv = 0
  self._name = ""
  self._icon = ""
  self._des = nil
  self._petCount = 0
  self._moodSpeed = 0
  self._upLvID = 0
  self._downLvID = 0
  self._needBuildCondition = {}
  self._upLvCost = {}
  self._downLvReturn = {}
  self._needPower = 0
  self._upLvTime = 0
  self._nCount = 0
  self._uCount = 0
end

function AircrafBuildData:Init(id, roomType, lv, name, icon, des, petCount, moodSpeed, upLvID, downLvID, needBuildCondition, upLvCost, downLvReturn, needPower, upLvTime, nCount, uCount)
  self._id = id
  self._roomType = roomType
  self._lv = lv
  self._name = name
  self._icon = icon
  self._des = des
  self._petCount = petCount
  self._moodSpeed = moodSpeed
  self._upLvID = upLvID
  self._downLvID = downLvID
  self._needBuildCondition = needBuildCondition
  self._upLvCost = upLvCost
  self._downLvReturn = downLvReturn
  self._needPower = needPower
  self._upLvTime = upLvTime
  self._nCount = nCount
  self._uCount = uCount
end
