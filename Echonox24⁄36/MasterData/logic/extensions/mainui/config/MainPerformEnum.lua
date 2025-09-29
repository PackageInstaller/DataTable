-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/config/MainPerformEnum.lua

module("logic.extensions.mainui.config.MainPerformEnum", package.seeall)

local MainPerformEnum = {}

MainPerformEnum.DragControlAngle = true
MainPerformEnum.DefaultFov = 30
MainPerformEnum.AnimFPS = 30
MainPerformEnum.AnimDefaultMixDuration = 0.4
MainPerformEnum.AnimPrefix = {
	HeartAnchor = "xinmao",
	CanXiang = "canxiang",
	XiangQing = "xiangqing",
	ChouKa = "chouka",
	QinHeDu = "xiangqing",
	JiaoShiQi = "jiaoshiqi",
	Shafa = "shafa",
	Skin = "skin",
	Thinking = "xiangqing"
}
MainPerformEnum.AnimFullName = {
	ChangeShow = "xiangqing_change",
	XiangQingIdle = "xiangqing_loop",
	ShafaTouch = "shafa_touch",
	ShafaIdle = "shafa_loop",
	ChoukaIdle = "chouka_loop"
}
MainPerformEnum.AnimFullNameFallBack = {
	[MainPerformEnum.AnimFullName.ShafaIdle] = "shafa_idle"
}
MainPerformEnum.AnimPrefixLayer = {
	[MainPerformEnum.AnimPrefix.Shafa] = 0,
	[MainPerformEnum.AnimPrefix.XiangQing] = 1,
	[MainPerformEnum.AnimPrefix.QinHeDu] = 1,
	[MainPerformEnum.AnimPrefix.CanXiang] = 1,
	[MainPerformEnum.AnimPrefix.JiaoShiQi] = 1,
	[MainPerformEnum.AnimPrefix.Thinking] = 1,
	[MainPerformEnum.AnimPrefix.HeartAnchor] = 1,
	[MainPerformEnum.AnimPrefix.Skin] = 2,
	[MainPerformEnum.AnimPrefix.ChouKa] = 0
}
MainPerformEnum.AnimPrefixLayerFallBack = {}
MainPerformEnum.AnimEventName = {
	End = "animation_end"
}
MainPerformEnum.AnimLookAtIKData = {}
MainPerformEnum.LightDirtyMark = {
	EnterShow = 1
}
MainPerformEnum.ResTyp = {
	ShafaTouchTimeline = 6,
	Model = 1,
	Item = 3,
	Timeline = 2,
	ActivationItem = 4,
	ChangeTimeline = 5
}
MainPerformEnum.GyrosEventTyp = {
	Echo = 3,
	MainCam = 2,
	None = 1
}
MainPerformEnum.GyrosEventName = {
	[MainPerformEnum.GyrosEventTyp.None] = "无",
	[MainPerformEnum.GyrosEventTyp.MainCam] = "主场景相机",
	[MainPerformEnum.GyrosEventTyp.Echo] = "残响效果"
}
MainPerformEnum.ElementPointAdjutant = 0
MainPerformEnum.ElementPointSP = -1
MainPerformEnum.ElementIdAirtightClock = 30001
MainPerformEnum.ElementIdTelevision = 30002
MainPerformEnum.EditEventTyp = {
	AniCam = 2,
	HeroPos = 1
}
MainPerformEnum.CamCodeMain = 0
MainPerformEnum.CamCodeClock = 10
MainPerformEnum.DefaultCamTweenDuration = 1.3
MainPerformEnum.DefaultCamTweenDurationPredict = MainPerformEnum.DefaultCamTweenDuration * 0.68
MainPerformEnum.SkinTabIndex = {
	SkinPreview = 2,
	SkinMainView = 1
}
MainPerformEnum.CharSysCamGroupItemTyp = {
	Thinking = 6,
	Equip = 4,
	Authority = 3,
	SkillPreview = 10,
	Profile = 7,
	Echo = 5,
	SkinPreview = 9,
	Depot = 1,
	Skin = 8,
	Detail = 2
}
MainPerformEnum.CharSysCamGroupItemName = {
	[MainPerformEnum.CharSysCamGroupItemTyp.Depot] = "仓库",
	[MainPerformEnum.CharSysCamGroupItemTyp.Detail] = "信息",
	[MainPerformEnum.CharSysCamGroupItemTyp.Authority] = "亲和度",
	[MainPerformEnum.CharSysCamGroupItemTyp.Equip] = "校时器",
	[MainPerformEnum.CharSysCamGroupItemTyp.Echo] = "残响",
	[MainPerformEnum.CharSysCamGroupItemTyp.Thinking] = "思维",
	[MainPerformEnum.CharSysCamGroupItemTyp.Profile] = "角色资料页",
	[MainPerformEnum.CharSysCamGroupItemTyp.Skin] = "装束主界面",
	[MainPerformEnum.CharSysCamGroupItemTyp.SkinPreview] = "装束预览",
	[MainPerformEnum.CharSysCamGroupItemTyp.SkillPreview] = "技能预览"
}
MainPerformEnum.Cfg2Template = {
	main_perform_landlady_r = {
		sortKey = 1,
		title = {
			"id",
			"posData",
			"anim",
			"animItem",
			"activationItem",
			"animItemShowData",
			"animItemHideData",
			"charSysCamGroup",
			"hideNode",
			"collider",
			"airtightShowNode",
			"noEnterMatEffNode"
		},
		format = {
			"number",
			"array",
			"string",
			"string",
			"string",
			"array",
			"array",
			"number",
			"arrayStr",
			"array",
			"arrayStr",
			"arrayStr"
		},
		titleName = {
			"模型id",
			"位置旋转缩放",
			"随机动画",
			"伴随动画",
			"激活物品",
			"伴随物件显示坐标",
			"伴随物件隐藏坐标",
			"角色系统相机组",
			"隐藏节点",
			"碰撞",
			"密室显示节点",
			"进场不扫光节点"
		}
	},
	main_interact_element_r = {
		sortKey = 1,
		title = {
			[1] = "id",
			[2] = "charSysCamGroup"
		},
		format = {
			[1] = "number",
			[2] = "number"
		}
	},
	main_perform_hero_r = {
		sortKey = 1,
		title = {
			"id",
			"posData",
			"anim",
			"animItem",
			"activationItem",
			"animItemShowData",
			"animItemHideData",
			"hideNode",
			"airtightShowNode"
		},
		format = {
			"number",
			"array",
			"string",
			"string",
			"string",
			"array",
			"array",
			"arrayStr",
			"arrayStr"
		}
	},
	main_perform_camera_r = {
		sortKey = 1,
		title = {
			"id",
			"posData",
			"name"
		},
		format = {
			"number",
			"array",
			"string"
		}
	},
	main_perform_animix_r = {
		sortKey = 1,
		title = {
			"id",
			"default",
			"sp"
		},
		format = {
			"number",
			"number",
			"string"
		}
	},
	main_perform_cam_group_chasys_r = {
		sortKey = 1,
		title = {
			"id",
			"camIds",
			"name"
		},
		format = {
			"number",
			"array",
			"string"
		}
	},
	hero_preview_cam_info = {
		sortKey = 1,
		title = {
			"id",
			"pos",
			"rot",
			"fov",
			"name"
		},
		format = {
			"number",
			"vector3",
			"vector3",
			"number",
			"string"
		}
	},
	hero_preview_pos_info = {
		sortKey = 1,
		title = {
			"id",
			"pos",
			"rot",
			"name"
		},
		format = {
			"number",
			"vector3",
			"vector3",
			"string"
		}
	},
	hero_preview_info = {
		sortKey = 1,
		title = {
			"id",
			"camId",
			"posId",
			"name"
		},
		format = {
			"number",
			"number",
			"number",
			"string"
		}
	},
	battle_perform_hero_pos = {
		sortKey = 1,
		title = {
			"id",
			"posData",
			"animation"
		},
		format = {
			"number",
			"array",
			"string"
		}
	},
	main_perform_face_anim_r = {
		sortKey = 1,
		title = {
			[1] = "id",
			[2] = "state"
		},
		format = {
			[1] = "number",
			[2] = "arrayStr"
		}
	}
}

return MainPerformEnum
