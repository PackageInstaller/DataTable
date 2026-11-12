local IceCreamUtils = {}
IceCreamUtils.EnumConeType = {Cone = 1, Cup = 2}
IceCreamUtils.EnumFlavor = {
  Vanilla = 3,
  Strawberry = 4,
  Melon = 5,
  Chocolate = 6
}
IceCreamUtils.EnumTopping = {
  Cherry = 8,
  Rainbow = 9,
  Cookie = 10,
  Cream = 11
}
IceCreamUtils.EnumSlotType = {
  SLOT_CONE = 1,
  SLOT_SCOOP1 = 2,
  SLOT_SCOOP2 = 3,
  SLOT_SCOOP3 = 4,
  SLOT_SCOOP4 = 5,
  SLOT_TOPPING = 6
}
IceCreamUtils.Cone_IconPath = {
  [IceCreamUtils.EnumConeType.Cone] = "",
  [IceCreamUtils.EnumConeType.Cup] = ""
}
IceCreamUtils.Flavor_IconPath = {
  [IceCreamUtils.EnumFlavor.Vanilla] = "",
  [IceCreamUtils.EnumFlavor.Strawberry] = "",
  [IceCreamUtils.EnumFlavor.Chocolate] = "",
  [IceCreamUtils.EnumFlavor.Melon] = ""
}
IceCreamUtils.Topping_IconPath = {
  [IceCreamUtils.EnumTopping.Cream] = "",
  [IceCreamUtils.EnumTopping.Cookie] = "",
  [IceCreamUtils.EnumTopping.Rainbow] = "",
  [IceCreamUtils.EnumTopping.Cherry] = ""
}
IceCreamUtils.EnumQueueType = {InQueue = 1, InMake = 2}
IceCreamUtils.EnumCustomerState = {
  idle = "idle",
  walk = "walk",
  happy_walk = "walk_happy",
  happy = "happy",
  sad = "sad",
  angry_walk = "walk_angry",
  angry = "angry"
}
IceCreamUtils.EnumOrderState = {
  Null = 0,
  Normal = 1,
  Perfect = 2,
  Lose = 3
}

function IceCreamUtils.InitIconPath()
  local function forEachLine_IceCreamCreate(mapLineData)
    if mapLineData.OptionType == GameEnum.iceOption.Cone then
      IceCreamUtils.Cone_IconPath[mapLineData.LocalParm] = mapLineData.Path
    elseif mapLineData.OptionType == GameEnum.iceOption.IceBall then
      IceCreamUtils.Flavor_IconPath[mapLineData.LocalParm] = mapLineData.Path
    elseif mapLineData.OptionType == GameEnum.iceOption.Topping then
      IceCreamUtils.Topping_IconPath[mapLineData.LocalParm] = mapLineData.Path
    end
  end
  
  ForEachTableLine(DataTable.IceCreamCreate, forEachLine_IceCreamCreate)
end

function IceCreamUtils.SetCondimentIcon(step, v)
  local IconPath = ""
  if step < IceCreamUtils.EnumSlotType.SLOT_CONE or step > IceCreamUtils.EnumSlotType.SLOT_TOPPING then
    return IconPath
  end
  if step == IceCreamUtils.EnumSlotType.SLOT_CONE then
    IconPath = IceCreamUtils.Cone_IconPath[v]
  elseif step == IceCreamUtils.EnumSlotType.SLOT_TOPPING then
    IconPath = IceCreamUtils.Topping_IconPath[v]
  else
    IconPath = IceCreamUtils.Flavor_IconPath[v]
  end
  return IconPath
end

return IceCreamUtils
