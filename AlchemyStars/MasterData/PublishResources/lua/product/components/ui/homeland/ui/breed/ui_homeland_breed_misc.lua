local HomelandBreedUIType = {
  Mutation = 1,
  Clone = 2,
  StateChg = 3,
  Manual = 4
}
_enum("HomelandBreedUIType", HomelandBreedUIType)
local HomelandBreedUIWidget = {
  [HomelandBreedUIType.Mutation] = "UIHomelandBreedMutation",
  [HomelandBreedUIType.Clone] = "UIHomelandBreedClone",
  [HomelandBreedUIType.StateChg] = "UIHomelandBreedStateChg",
  [HomelandBreedUIType.Manual] = "UIHomelandBreedManual"
}
_enum("HomelandBreedUIWidget", HomelandBreedUIWidget)
local HomelandBreedState = {
  None = 0,
  Mutationing = 1,
  Cloning = 2,
  MutationReap = 4,
  CloneReap = 5,
  StateChgReap = 6
}
_enum("HomelandBreedState", HomelandBreedState)
local HomelandBreedTypeStr = {
  [HomelandBreedState.Mutationing] = "str_homeland_breed_mutation",
  [HomelandBreedState.Cloning] = "str_homeland_breed_clone",
  [HomelandBreedState.MutationReap] = "str_homeland_breed_mutation",
  [HomelandBreedState.CloneReap] = "str_homeland_breed_clone",
  [HomelandBreedState.StateChgReap] = "str_homeland_breed_statechg"
}
_enum("HomelandBreedTypeStr", HomelandBreedTypeStr)
local HomelandBreedSpeciesType = {Tree = 1}
_enum("HomelandBreedSpeciesType", HomelandBreedSpeciesType)
local HomelandBreedSpeciesStr = {
  [HomelandBreedSpeciesType.Tree] = "str_homeland_breed_tree"
}
_enum("HomelandBreedSpeciesStr", HomelandBreedSpeciesStr)
local HomelandBreedPedigree = {Jia = 1, Yi = 2}
_enum("HomelandBreedPedigree", HomelandBreedPedigree)
local HomelandBreedPedigreeStr = {
  [HomelandBreedPedigree.Jia] = "str_homeland_breed_pedigree_j",
  [HomelandBreedPedigree.Yi] = "str_homeland_breed_pedigree_y"
}
_enum("HomelandBreedPedigreeStr", HomelandBreedPedigreeStr)
local HomelandBreedRarityStr = {
  [RarityType.C] = "C",
  [RarityType.B] = "B",
  [RarityType.A] = "A",
  [RarityType.S] = "S"
}
_enum("HomelandBreedRarityStr", HomelandBreedRarityStr)
local HomelandBreedTool = {
  GetTimeStr = function(time)
    if time <= 0 then
      return "00:00:00"
    end
    local h = math.floor(time / 3600)
    time = time - h * 3600
    local m = math.floor(time / 60)
    local s = math.floor(time - m * 60)
    if h < 10 then
      h = "0" .. h
    end
    if m < 10 then
      m = "0" .. m
    end
    if s < 10 then
      s = "0" .. s
    end
    return h .. ":" .. m .. ":" .. s
  end,
  GetRemainTime = function(time)
    local day, hour, minute
    day = math.floor(time / 86400)
    hour = math.floor(time / 3600) % 24
    minute = math.floor(time / 60) % 60
    local timestring = ""
    if 0 < day then
      timestring = day .. StringTable.Get("str_activity_common_day")
      if 0 < hour then
        timestring = timestring .. hour .. StringTable.Get("str_activity_common_hour")
      end
    elseif 0 < hour then
      timestring = hour .. StringTable.Get("str_activity_common_hour")
      if 0 < minute then
        timestring = timestring .. minute .. StringTable.Get("str_activity_common_minute")
      end
    elseif 0 < minute then
      timestring = minute .. StringTable.Get("str_activity_common_minute")
    else
      timestring = StringTable.Get("str_activity_common_less_minute")
    end
    return timestring
  end
}
_enum("HomelandBreedTool", HomelandBreedTool)
