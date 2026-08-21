local var_0_0 = {
	RestaurantMode = {
		Start = "Start",
		RestaurantManual = "RestaurantManual",
		Close = "Close",
		RestaurantAuto = "RestaurantAuto"
	},
	CateenCharacterBubbleType = {
		onlyString = "onlyString",
		hasTimer = "hasTimer"
	},
	EntityType = {
		FoodItem = "FoodItem",
		Furniture = "Furniture",
		Character = "Character"
	},
	ControlType = {
		Player = "Player",
		AI = "AI"
	},
	CharacterType = {
		RestaurantSpecialCustomer = "RestaurantSpecialCustomer",
		RestaurantCashier = "RestaurantCashier",
		DormNormalHero = "DormNormalHero",
		RestaurantWaiter = "RestaurantWaiter",
		RestaurantNormalCustomer = "RestaurantNormalCustomer",
		RestaurantCook = "RestaurantCook"
	},
	ItemType = {
		Steamer = "Steamer",
		TrashCan = "TrashCan",
		Pan = "Pan",
		CashierTable = "CashierTable",
		DinningChair = "DinningChair",
		OrderFoodDummy = "OrderFoodDummy",
		Food = "Food",
		Pot = "Pot",
		DinningTable = "DinningTable",
		Oven = "Oven",
		PassTable = "PassTable"
	},
	FurnitureTypeNum = {
		Pot = 6,
		Oven = 5,
		Pan = 3,
		Steamer = 4
	},
	FurnitureMainType = {
		cook = 1,
		table = 2
	},
	BusinessStatus = {
		RestaurantClose = "关门中",
		RestaurantOpen = "营业中"
	},
	Namespace = {
		EntityOnTrigger = "entity.trigger",
		EntityCurrentAction = "entity.currentAction",
		HeroShowSpecialVfx = "hero.vfx.status",
		RestaurantBusiness = "restaurant.data",
		EntityType = "entity",
		EntityData = "entity.data"
	},
	Points = {
		RestaurantCustomerPay = "RestaurantCustomerPay",
		RestaurantFoodSpawn = "RestaurantFoodSpawn",
		RestaurantCashier = "RestaurantCashier",
		RestaurantExit = "RestaurantExit",
		RestaurantWaiter = "RestaurantWaiter",
		RestaurantNormalCustomer = "RestaurantNormalCustomer",
		RestaurantCook = "RestaurantCook"
	},
	FoodState = {
		HasCook = "HasCook",
		Canceled = "Canceled",
		TimeOut = "TimeOut",
		HasServer = "HasServer",
		Cooking = "Cooking",
		Wait = "Wait"
	},
	UniversalUIType = {
		FoodName = "FoodName",
		TasteName = "TasteName"
	},
	BubbleType = {
		CharacterEmotion = "CharacterEmotion",
		Complete = "Complete",
		WaitForFood = "WaitForFood",
		Working = "Working",
		Award = "Award"
	},
	FoodQuality = {
		high = 3,
		low = 1,
		normal = 2
	},
	MenuType = {
		foodMenu = "foodMenu",
		bag = "bag",
		levleAward = "levleAward"
	},
	CharacterScene = {
		PrivateDorm = "PrivateDorm",
		None = "None",
		PublicDorm = "PublicDorm",
		Canteen = "Canteen"
	},
	CharacterAIState = {
		Interact = "Interact",
		None = "None",
		Observe = "Observe",
		Move = "Move"
	},
	SpecialVfx = {
		Tired = "Tired",
		Hungry = "Hungry",
		Gift = "Gift"
	}
}

var_0_0.RestaurantKitchenWare = {
	[3] = var_0_0.ItemType.Pan,
	[4] = var_0_0.ItemType.Steamer,
	[5] = var_0_0.ItemType.Oven,
	[6] = var_0_0.ItemType.Pot
}
var_0_0.RestaurantJobToServerMap = {
	[var_0_0.CharacterType.RestaurantCook] = 1,
	[var_0_0.CharacterType.RestaurantWaiter] = 2,
	[var_0_0.CharacterType.RestaurantCashier] = 3
}
var_0_0.RestaurantJobToClientMap = {
	"RestaurantCook",
	"RestaurantWaiter",
	"RestaurantCashier"
}
var_0_0.DormRoomUseState = {
	Lock = "Lock",
	HadPlace = "HadPlace",
	Unlock = "Unlock"
}
var_0_0.DormHeroState = {
	InPublicDorm = "InPublicDorm",
	InIdolTraineeCamp = "InIdolTraineeCamp",
	InCanteenEntrust = "InCanteenEntrust",
	InPrivateDorm = "InPrivateDorm",
	OutDorm = "OutDorm",
	InCanteenJob = "InCanteenJob"
}
var_0_0.DormSystemType = {
	Illu = "Illu",
	Dormitory = "Dormitory",
	Main = "Main",
	CricketBattle = "CricketBattle",
	Canteen = "Canteen"
}
var_0_0.DormDeployType = {
	Occupy = "Occupy",
	Place = "Place",
	ReCall = "ReCall"
}
var_0_0.FurItemType = {
	StorageFurShow = "StorageFurShow",
	SuitEdit = "SuitEdit",
	TemplateShow = "TemplateShow",
	SuitFurShow = "SuitFurShow",
	Edit = "Edit",
	Illu = "Illu",
	Gift = "Gift"
}
var_0_0.FoodSellType = {
	SignFood = "SignFood",
	ForSale = "ForSale"
}
var_0_0.FoodType = {
	[0] = 210171,
	nil,
	nil,
	210201,
	210202,
	210203,
	210204
}

local var_0_1, var_0_2 = pcall(require, "bit")

if not var_0_1 then
	local var_0_3

	var_0_3, var_0_2 = pcall(require, "bit32")
end

var_0_0.BeginStoryFlag = {
	HideFurniture = 2,
	HideCharacter = 1,
	HideBoth = 3,
	None = 0
}

function var_0_0.HasFlag(arg_1_0, arg_1_1)
	local var_1_0 = var_0_2.tobit(arg_1_0)
	local var_1_1 = var_0_2.tobit(arg_1_1)

	return var_0_2.band(var_1_0, var_1_1) ~= 0
end

var_0_0.HighlightLayer = {
	Suit = 1,
	Available = 0
}

return var_0_0
