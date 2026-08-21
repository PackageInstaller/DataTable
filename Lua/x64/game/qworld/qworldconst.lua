QWorldConst = {
	GOTO_BLACK_FADE_CENTER_TIME = 0,
	GOTO_BLACK_FADE_ENTER_TIME = 0.5,
	GOTO_BLACK_FADE_EXIT_TIME = 0.5,
	TagType = {
		Quest = 1,
		TagSystem = 2,
		HudTag = 3
	},
	QWorldHintType = {
		BLOOD_CARD_GET_CARD = 313431001
	}
}
QWORLD_GOTO_TYPE = {
	TELEPORT = 1,
	Activity = 4,
	JUMP = 2,
	Battle = 7,
	System = 6,
	OpenMiniMap = 5,
	StopStory = 3
}
NEED_CACHE_GOTO_TYPE = {
	[QWORLD_GOTO_TYPE.Activity] = true,
	[QWORLD_GOTO_TYPE.System] = true
}
QWorldCameraFlag = {
	Furniture = 4,
	Story = 3,
	Player = 1,
	FocusPlayer = 5,
	CustomCamera = 2
}
QWorldCameraLayer = {
	MiniGame = 3,
	PlayerOrStory = 40,
	Activity = 41,
	System = 42,
	ForcePlayer = 1,
	Illu = 4,
	FocusPlayer = 999
}
QWorldFunction = {
	[31364101] = "miniMapGo_",
	[31361101] = "sealBtn_",
	[31377101] = "bookBtn_"
}
QWorldSystemConst = {
	ENTRACE_400 = 2001,
	STAMP = 1002,
	ILL_310 = 1001,
	RED_ENVELOPE = 1004,
	Quest = 2,
	SEA_WARFARE = 2002,
	SHOP_310 = 1003
}
QWorldMainMenuConst = {
	[QWorldSystemConst.Quest] = "QWorldMainMenuQuest",
	[QWorldSystemConst.ILL_310] = "QWorldMainMenuBook",
	[QWorldSystemConst.STAMP] = "QWorldMainMenuSeal",
	[QWorldSystemConst.SHOP_310] = "QWorldMainMenuShop",
	[QWorldSystemConst.RED_ENVELOPE] = "QWorldMainMenuCollect",
	[QWorldSystemConst.ENTRACE_400] = "QWorldMainMenuEntrace"
}
QWorldAgentLayer = {
	NPC = bit.lshift(1, 1),
	Thing = bit.lshift(1, 2),
	Furniture = bit.lshift(1, 3)
}
QWorldCullMode = {
	Disable = 2,
	Normal = 1
}
QWorldInteractionMode = {
	ONLY_CONTROL_RUN = 2,
	ONLY_CONTROL_WALK = 3,
	FULL = 1
}
