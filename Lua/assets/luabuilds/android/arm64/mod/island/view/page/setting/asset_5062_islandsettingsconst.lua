local IslandSettingsConst = class("IslandSettingsConst")

IslandSettingsConst.ISLAND_JOY_STICK_DEFAULT_PREFERENCE = {
	scale = 1,
	x = 248,
	y = 213
}
IslandSettingsConst.op_btn = 1
IslandSettingsConst.jump = 2
IslandSettingsConst.scope = 3
IslandSettingsConst.seed = 4
IslandSettingsConst.settingRectSize = {
	x = 1349,
	y = 762
}
IslandSettingsConst.OPERATION_DEFAULT_PREFERENCE = {}
IslandSettingsConst.OPERATION_DEFAULT_PREFERENCE[IslandSettingsConst.op_btn] = {
	scale = 1,
	x = -300,
	y = 250
}
IslandSettingsConst.OPERATION_DEFAULT_PREFERENCE[IslandSettingsConst.jump] = {
	scale = 1,
	x = -120,
	y = 120
}
IslandSettingsConst.OPERATION_DEFAULT_PREFERENCE[IslandSettingsConst.scope] = {
	scale = 1,
	x = -120,
	y = 335
}
IslandSettingsConst.OPERATION_DEFAULT_PREFERENCE[IslandSettingsConst.seed] = {
	scale = 1,
	x = -465,
	y = 110
}
IslandSettingsConst.ISLAND_KEY_JOYSTICK_ANCHORX = "island_joystick_anchorX"
IslandSettingsConst.ISLAND_KEY_JOYSTICK_ANCHORY = "island_joystick_anchorY"
IslandSettingsConst.ISLAND_KEY_OPERATION_ANCHORX = {}
IslandSettingsConst.ISLAND_KEY_OPERATION_ANCHORX[1] = "island_op1_anchorX"
IslandSettingsConst.ISLAND_KEY_OPERATION_ANCHORX[2] = "island_op2_anchorX"
IslandSettingsConst.ISLAND_KEY_OPERATION_ANCHORX[3] = "island_op3_anchorX"
IslandSettingsConst.ISLAND_KEY_OPERATION_ANCHORX[4] = "island_op4_anchorX"
IslandSettingsConst.ISLAND_KEY_OPERATION_ANCHORX[5] = "island_op5_anchorX"
IslandSettingsConst.ISLAND_KEY_OPERATION_ANCHORY = {}
IslandSettingsConst.ISLAND_KEY_OPERATION_ANCHORY[1] = "island_op1_anchorY"
IslandSettingsConst.ISLAND_KEY_OPERATION_ANCHORY[2] = "island_op2_anchorY"
IslandSettingsConst.ISLAND_KEY_OPERATION_ANCHORY[3] = "island_op3_anchorY"
IslandSettingsConst.ISLAND_KEY_OPERATION_ANCHORY[4] = "island_op4_anchorY"
IslandSettingsConst.ISLAND_KEY_OPERATION_ANCHORY[5] = "island_op5_anchorY"

return IslandSettingsConst
