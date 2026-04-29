_class("AircrafEnterSortData", Object)
AircrafEnterSortData = AircrafEnterSortData

function AircrafEnterSortData:Constructor()
  self._sortType = 0
  self._sortOrder = 0
  self._chooseType = {}
end

function AircrafEnterSortData:Init(sortType, sortOrder, chooseType)
  self._sortType = sortType
  self._sortOrder = sortOrder
  self:ChangeChooseType(chooseType, true)
end

function AircrafEnterSortData:ChangeChooseType(chooseType)
  if table.icontains(self._chooseType, chooseType) then
    table.removev(self._chooseType, chooseType)
    if table.count(self._chooseType) == 0 then
      table.insert(self._chooseType, AircraftEnterChooseType.None)
    end
  else
    if table.icontains(self._chooseType, AircraftEnterChooseType.None) then
      table.removev(self._chooseType, AircraftEnterChooseType.None)
    end
    table.insert(self._chooseType, chooseType)
  end
end
