class = var_0_10000

local var_0_0 = var_0_10000("IslandProductConst")

var_0_0.FarmlandPlaceId = 101
var_0_0.PasturePlaceId = 102
var_0_0.MilkTeaPlaceId = 601
var_0_0.MealPlaceId = 602
var_0_0.SimpeleMealPlaceId = 603
var_0_0.kebabPlaceId = 604
var_0_0.MinePlaceId = 401
var_0_0.FellingPlaceId = 402
var_0_0.TechnologyPlaceId = 702
var_0_0.CoffeePlaceId = 901
var_0_0.OrchardPlaceId = 501
var_0_0.GardenPlaceId = 502
var_0_0.FisheryPlaceId = 201
var_0_0.WoodProcessingPlaceId = 703
var_0_0.MachinePlaceId = 704
var_0_0.ElectronicPlaceId = 705
var_0_0.HandworkWorkbench = 706
var_0_0.FactorytPlaces = {
	var_0_0.WoodProcessingPlaceId,
	var_0_0.MachinePlaceId,
	var_0_0.ElectronicPlaceId,
	var_0_0.HandworkWorkbench
}
var_0_0.haveModelPlaces = {
	var_0_0.WoodProcessingPlaceId,
	var_0_0.MachinePlaceId,
	var_0_0.ElectronicPlaceId,
	var_0_0.HandworkWorkbench,
	var_0_0.MilkTeaPlaceId,
	var_0_0.MealPlaceId,
	var_0_0.SimpeleMealPlaceId,
	var_0_0.kebabPlaceId
}
var_0_0.havePerformPlace = {
	var_0_0.FisheryPlaceId
}
var_0_0.PlantPlaceIdLists = {
	var_0_0.FarmlandPlaceId,
	var_0_0.OrchardPlaceId,
	var_0_0.GardenPlaceId
}
var_0_0.ProductSlotType = {
	HandPlant = 1,
	RoleDelegation = 2
}

return var_0_0
