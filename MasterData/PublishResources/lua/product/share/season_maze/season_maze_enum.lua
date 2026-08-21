local SeasonMazeBeadUIMode = {Equip = 1, Synthesis = 2}
_enum("SeasonMazeBeadUIMode", SeasonMazeBeadUIMode)
local SeasonMazeBeadSortType = {Type = 1, Quality = 2}
_enum("SeasonMazeBeadSortType", SeasonMazeBeadSortType)
local SeasonMazeBeadSortOrder = {Descending = 1, Ascending = 2}
_enum("SeasonMazeBeadSortOrder", SeasonMazeBeadSortOrder)
local SeasonMazeBeadItemType = {
  Normal = 1,
  EquipSlot = 2,
  SynthesisSlot = 3,
  Template = 4,
  SynthesisList = 5,
  Reward = 6
}
_enum("SeasonMazeBeadItemType", SeasonMazeBeadItemType)
local SeasonMazeBeadTipsBtnType = {
  None = 0,
  Demount = 1,
  Equiped = 2,
  RemoveSynthesis = 3,
  AddSynthesis = 4
}
_enum("SeasonMazeBeadTipsBtnType", SeasonMazeBeadTipsBtnType)
local SeasonMazeBeadTipsColorType = {
  Red = 1,
  Green = 2,
  Black = 3
}
_enum("SeasonMazeBeadTipsColorType", SeasonMazeBeadTipsColorType)
local SeasonMazeBeadAttType = {
  Crit = ESeasonMazeAutoBeadAttr.ESeasonMazeAutoBeadAttr_Crit,
  Hit = ESeasonMazeAutoBeadAttr.ESeasonMazeAutoBeadAttr_Hit,
  Combo = ESeasonMazeAutoBeadAttr.ESeasonMazeAutoBeadAttr_Combo,
  HurtFload = ESeasonMazeAutoBeadAttr.ESeasonMazeAutoBeadAttr_HurtFload,
  Energy = ESeasonMazeAutoBeadAttr.ESeasonMazeAutoBeadAttr_Energy,
  Hurt = ESeasonMazeAutoBeadAttr.ESeasonMazeAutoBeadAttr_Hurt,
  CritHurt = ESeasonMazeAutoBeadAttr.ESeasonMazeAutoBeadAttr_CritHurt,
  EnergyRevise = 7
}
_enum("SeasonMazeBeadAttType", SeasonMazeBeadAttType)
local SeasonMazeCardPlayType = {
  None = 0,
  Button = 1,
  Drag = 2
}
_enum("SeasonMazeCardPlayType", SeasonMazeCardPlayType)
