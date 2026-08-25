local Readonly = System.readonly
local M = {}
M.AlchemyType = {
  Compose = "Compose",
  Decompose = "Decompose",
  Recast = "Recast",
  Exchange = "Exchange",
  TrinketDecompose = "TrinketDecompose",
  ItemDecompose = "ItemDecompose"
}
M.AlchemyPage = {
  CompositePanel = 1,
  DecompositePanel = 2,
  RecastPanel = 3,
  CompositeTip = 4,
  DecompositeTip = 5,
  RecastTip = 6,
  RecastTrinkBag = 7,
  ExchangePanel = 8,
  ExchangeTip = 9,
  ExchangeItemBag = 10,
  TrinketDecompositePanel = 11,
  ItemDecompositePanel = 12,
  Quit = 100
}
M.AlchemyImagesPath = {
  MainPanelBg = "UIResources/UIBigImages/UI_Large/UI_Common_Image_Bg7.png",
  Line04 = "UIResources/UIBigImages/UI_Alchemy/UI_Alchemy_Image_TabBg.png",
  Icon03 = "UIResources/AtlasSource/UI_Alchemy_Image/UI_Alchemy_Icon03.png"
}
M.AlchemyPageLevel = {
  Quit = 3,
  Panel = 2,
  Tips = 1
}
M.AlchemySliderLimit = 999
M.AlchemyItemType = {
  Formula = 1,
  CompositeCostItem = 2,
  SecondConfirmItem = 3,
  DecompositeConvertItem = 4,
  RecastTrinketItem = 5,
  DecomposeItem = 6
}
M = Readonly(M, "AlchemyDefine")
return M
