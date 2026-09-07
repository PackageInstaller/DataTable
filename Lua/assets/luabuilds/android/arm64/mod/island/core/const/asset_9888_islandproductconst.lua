local IslandProductConst = class("IslandProductConst")

IslandProductConst.FarmlandPlaceId = 101
IslandProductConst.PasturePlaceId = 102
IslandProductConst.MilkTeaPlaceId = 601
IslandProductConst.MealPlaceId = 602
IslandProductConst.SimpeleMealPlaceId = 603
IslandProductConst.kebabPlaceId = 604
IslandProductConst.MinePlaceId = 401
IslandProductConst.FellingPlaceId = 402
IslandProductConst.TechnologyPlaceId = 702
IslandProductConst.CoffeePlaceId = 901
IslandProductConst.OrchardPlaceId = 501
IslandProductConst.GardenPlaceId = 502
IslandProductConst.FisheryPlaceId = 201
IslandProductConst.WoodProcessingPlaceId = 703
IslandProductConst.MachinePlaceId = 704
IslandProductConst.ElectronicPlaceId = 705
IslandProductConst.HandworkWorkbench = 706
IslandProductConst.FactorytPlaces = {
	IslandProductConst.WoodProcessingPlaceId,
	IslandProductConst.MachinePlaceId,
	IslandProductConst.ElectronicPlaceId,
	IslandProductConst.HandworkWorkbench
}
IslandProductConst.haveModelPlaces = {
	IslandProductConst.WoodProcessingPlaceId,
	IslandProductConst.MachinePlaceId,
	IslandProductConst.ElectronicPlaceId,
	IslandProductConst.HandworkWorkbench,
	IslandProductConst.MilkTeaPlaceId,
	IslandProductConst.MealPlaceId,
	IslandProductConst.SimpeleMealPlaceId,
	IslandProductConst.kebabPlaceId
}
IslandProductConst.havePerformPlace = {
	IslandProductConst.FisheryPlaceId
}
IslandProductConst.PlantPlaceIdLists = {
	IslandProductConst.FarmlandPlaceId,
	IslandProductConst.OrchardPlaceId,
	IslandProductConst.GardenPlaceId
}
IslandProductConst.ProductSlotType = {
	HandPlant = 1,
	RoleDelegation = 2
}

return IslandProductConst
