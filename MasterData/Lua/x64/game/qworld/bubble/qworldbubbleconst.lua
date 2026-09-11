local var_0_0 = {}

QWorldBubbleType = {
	NORMAL = 1
}
QWorldBubblePrefab = {
	[QWorldBubbleType.NORMAL] = "QWorld/UI/SubtitleBubble"
}
QWorldBubbleEntity = {
	[QWorldBubbleType.NORMAL] = QWorldNormalBubble
}
var_0_0.BUBBLE_PRE_DEFINED_TAG = {
	FURNITURE_INTERACT = -1,
	MINI_GAME_CELL = -1,
	BELOW_IS_PRE_DEFINED = 0,
	PHOTO_GAME = -1,
	SHOP_BUY = -1,
	NPC_INTERACT = -1
}

return var_0_0
