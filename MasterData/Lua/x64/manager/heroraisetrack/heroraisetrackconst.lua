local var_0_0 = {}

HERO_RAISE_ROTATE_TIME = 0.2
ASTROLABE_COLOR_TIME = 0.2
ASTROLABE_COLOR = {
	0.35294117647058826,
	0.39215686274509803,
	0.5098039215686274
}
var_0_0.HeroRaiseRotate = {
	[11] = Vector3(0, 130, 0),
	[60] = Vector3(0, 130, 0),
	[61] = Vector3(0, 130, 0)
}
var_0_0.ViewType = {
	null = "null",
	heroRaiseCommon = "heroRaiseCommon"
}
var_0_0.HeroRaiseType = {
	weapon = 3,
	astrolabe = 5,
	transition = 7,
	attr_promption = 11,
	chip_management = 61,
	equip = 4,
	chip = 6,
	adminsystem = 8,
	skill = 2,
	skill_details = 21,
	attr = 1
}
var_0_0.HeroServantType = {
	weapon = 1,
	servant = 2
}
var_0_0.HeroRaiseName = {
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	"VirtualCamera_Property",
	"VirtualCamera_Property_Transcend",
	"VirtualCamera_Property_Break",
	"VirtualCamera_Property_Files",
	"VirtualCamera_Property_Skin",
	nil,
	nil,
	nil,
	nil,
	nil,
	"VirtualCamera_Skill",
	"VirtualCamera_Skill_Details",
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	"VirtualCamera_Weapon",
	"VirtualCamera_Weapon_Break",
	"VirtualCamera_Weapon_WeaponServant",
	[40] = "VirtualCamera_Engraving",
	[61] = "VirtualCamera_Chip_Management",
	[81] = "VirtualCamera_Admin_Skin",
	[70] = "VirtualCamera_Transition",
	[80] = "VirtualCamera_AdminMain",
	[50] = "VirtualCamera_GodHood",
	[82] = "VirtualCamera_Admin_Chip",
	[83] = "VirtualCamera_AdminMain_Hide",
	[60] = "VirtualCamera_Chip",
	[41] = "VirtualCamera_Engraving_Details",
	[51] = "VirtualCamera_GodHood_Adjust",
	[71] = "VirtualCamera_Transition_Details"
}
var_0_0.HeroRaiseIdleAniName = "action1_1"
var_0_0.HeroAniName = {
	[21] = "Skill_Details",
	[61] = "Chip_Management",
	[80] = "Property_Transcend",
	[11] = "Property_Transcend",
	[12] = "Property_Break",
	[50] = "GodHood",
	[13] = "Property_Files",
	[82] = "Chip_Management",
	[10] = var_0_0.HeroRaiseIdleAniName,
	[14] = var_0_0.HeroRaiseIdleAniName,
	[20] = var_0_0.HeroRaiseIdleAniName,
	[40] = var_0_0.HeroRaiseIdleAniName,
	[60] = var_0_0.HeroRaiseIdleAniName,
	[70] = var_0_0.HeroRaiseIdleAniName,
	[81] = var_0_0.HeroRaiseIdleAniName,
	[83] = var_0_0.HeroRaiseIdleAniName
}
var_0_0.PageIndex = {
	VirtualCamera_Chip = 60,
	VirtualCamera_Engraving = 40,
	VirtualCamera_Property_Skin = 14,
	VirtualCamera_Weapon_WeaponServant = 32,
	VirtualCamera_Property_Transcend = 11,
	VirtualCamera_Property_Break = 12,
	VirtualCamera_Engraving_Details = 41,
	VirtualCamera_Skill = 20,
	VirtualCamera_GodHood = 50,
	VirtualCamera_Transition_Details = 71,
	VirtualCamera_Admin_Chip = 82,
	VirtualCamera_Weapon = 30,
	VirtualCamera_Property_Files = 13,
	VirtualCamera_Admin_Skin = 81,
	VirtualCamera_Chip_Management = 61,
	VirtualCamera_AdminMain_Hide = 83,
	VirtualCamera_AdminMain = 80,
	VirtualCamera_GodHood_Adjust = 51,
	VirtualCamera_Transition = 70,
	VirtualCamera_Weapon_Break = 31,
	VirtualCamera_Skill_Details = 21,
	VirtualCamera_Property = 10
}
var_0_0.ModelState = {
	weapon = 3,
	hero = 2,
	none = 1
}
var_0_0.CustomScene = {
	Cowboy_Prepare = 2,
	Cowboy = 1
}

return var_0_0
