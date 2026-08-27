local eSortKindType = {
  Star = 0,
  KindType = 1,
  Interact = 2,
  Binding = 3
}
local eSortKindTypeMax = {
  [eSortKindType.Star] = 3,
  [eSortKindType.KindType] = 3,
  [eSortKindType.Interact] = 2,
  [eSortKindType.Binding] = 2
}
local M = {eSortKindType, eSortKindTypeMax}
return M
