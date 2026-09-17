TALKEDITOR = {}
TALKEDITOR.CONSOLE_ITEM_TYPE = {
	XUANXIANG_BOX = 2,
	CHECK_BOX = 1
}
TALKEDITOR.CONSOLE_LIST = {
	{
		title = "场景效果",
		index = 1,
		keyList = {
			"splashScene",
			"shockScene",
			"colorScene",
			"nextScene",
			"blackScene",
			"moveScene",
			"zoomScene"
		},
		list = {
			"闪屏",
			"震屏",
			"变屏",
			"转屏",
			"黑屏",
			"移屏",
			"缩屏"
		},
		itemtype = TALKEDITOR.CONSOLE_ITEM_TYPE.XUANXIANG_BOX
	},
	{
		title = "立绘效果",
		index = 2,
		keyList = {
			"movePlayer",
			"zoomPlayer",
			"shockPlayer"
		},
		list = {
			"移动",
			"缩放",
			"震动"
		},
		itemtype = TALKEDITOR.CONSOLE_ITEM_TYPE.XUANXIANG_BOX
	},
	{
		title = "特殊效果",
		index = 3,
		keyList = {
			"attack",
			"zhiliao",
			"remeber",
			"hitted",
			"awake",
			"speedline"
		},
		list = {
			"攻击",
			"治疗",
			"回忆",
			"被击",
			"苏醒",
			"速度线"
		},
		itemtype = TALKEDITOR.CONSOLE_ITEM_TYPE.XUANXIANG_BOX
	},
	{
		title = "其他选项",
		index = 4,
		keyList = {
			"isSkip",
			"isStay"
		},
		list = {
			"是否跳过",
			"是否驻留"
		},
		itemtype = TALKEDITOR.CONSOLE_ITEM_TYPE.CHECK_BOX
	}
}
TALKEDITOR.OperateType = {
	Scale = 3,
	Position = 1,
	Rotation = 2,
	Opacity = 4
}
TALKEDITOR.OperateTypeNameList = {
	"Position",
	"Rotation",
	"Scale",
	"Opacity"
}
TALKEDITOR.OperateIndexNameList = {
	"Player",
	"Background",
	"Bubble"
}
TALKEDITOR.PropertyTypeList = {
	Expression = 3,
	Bubble = 1,
	Player = 4,
	Background = 5,
	TalkType = 2,
	Sound = 7,
	BGM = 6
}
TALKEDITOR.EDITOR_STATUS = {
	PREVIEW = 5,
	SETTING = 7,
	CONSOLE = 3,
	FREE = 1,
	SELECT = 6,
	NORMAL = 2,
	ADDXUANXIANG = 4
}
