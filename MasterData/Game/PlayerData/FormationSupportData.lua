local FormationSupportData = class("FormationSupportData")
FormationSupportData.eSupportType = {
  nono = 0,
  friend = 1,
  official = 2
}

function FormationSupportData:ctor()
  self.__supportType = FormationSupportData.eSupportType.nono
  self.__formIdx = nil
  self.__heroId = nil
  self.__uid = nil
  self.__officialCfgId = nil
end

function FormationSupportData:ExchangeLocation()
end

return FormationSupportData
