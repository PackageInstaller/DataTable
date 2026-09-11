LianLianKan = {}
LianLianKan.AI = {
	[DormEnum.CharacterType.RestaurantWaiter] = import(".AI.WaiterAI"),
	[DormEnum.CharacterType.RestaurantCook] = import(".AI.CookAI"),
	[DormEnum.CharacterType.RestaurantCashier] = import(".AI.CashierAI"),
	[DormEnum.CharacterType.RestaurantNormalCustomer] = import(".AI.CustomerAI")
}
LianLianKanBridge = import(".LianLianKanBridge")
GridMap = import(".GridMap")
LianLianKanUtil = import(".LianLianKanUtil")
LianLianKanItemGen = import(".LianLianKanItemGen")
LianLianKanGameManager = import(".LianLianKanGameManager")
