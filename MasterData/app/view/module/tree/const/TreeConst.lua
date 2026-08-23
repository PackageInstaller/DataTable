local var_0_0 = {
	DIR = {
		RIGHT = 4,
		UP = 1,
		LEFT = 3,
		DOWN = 2
	},
	NODE_TYPE = {
		BIG = 2,
		SMALL = 1,
		CENTER = 3
	},
	MAP = {
		GRID_X = 20,
		GRID_WIDTH = 200,
		GRID_Y = 20,
		GRID_HEIGHT = 200
	},
	EVENT = {
		NODE_GOTO = "TREE_NODE_GOTO",
		NODE_CLICK = "TREE_TALENT_CLICK",
		NODE_TOUCH_BEGIN = "TREE_NODE_TOUCH_BEGIN"
	}
}

var_0_0.CENTER_LENGTH = 3
var_0_0.CENTER_ID = {
	[201001] = 202000,
	[401001] = 402000,
	[101001] = 102000,
	[301001] = 302000
}
var_0_0.QUALITY_NAME = {
	[0] = "",
	"B",
	"B+",
	"A",
	"A+",
	"S",
	"S+",
	"SS",
	"SSS"
}

return var_0_0
