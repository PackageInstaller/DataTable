local var_0_0 = {
	sliderNum = 0.8333333333333334,
	StoryType = {
		Level1BossNoPass = 4,
		Level1BossPass = 3,
		FirstEnter = 1,
		Level2BossPass = 5,
		Condition = 2
	},
	NodeName = {
		elite = 300202,
		normal = 300201
	},
	StageType = {
		Second = 2,
		First = 1
	},
	CameraPosition = Vector3.New(0, 0, -10),
	CameraEulerAngles = Vector3.New(0, 0, 0)
}

var_0_0.NodeType = {
	var_0_0.NodeName.normal,
	var_0_0.NodeName.elite
}
var_0_0.StoryPriorty = {
	var_0_0.StoryType.FirstEnter,
	var_0_0.StoryType.Condition,
	var_0_0.StoryType.Level1BossPass,
	var_0_0.StoryType.Level1BossNoPass,
	var_0_0.StoryType.Level2BossPass
}

return var_0_0
