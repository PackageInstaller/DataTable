local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 30,
		animation = "attack",
		exe_tbl = {
			{
				0.6,
				frame = 16,
				id = 60023021,
				sound = "20200_attack"
			}
		}
	},
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		totalframe = 50,
		animation = "skill",
		exe_tbl = {
			{
				1,
				frame = 1,
				sound = "20200_xp1"
			},
			{
				id = 60023031,
				frame = 21
			}
		}
	},
	skill2 = {
		{
			{
				method = "useSkill",
				param = "useskill2"
			}
		}
	},
	useskill2 = {
		totalframe = 50,
		animation = "skill2",
		exe_tbl = {
			{
				frame = 1,
				sound = "21620_xp1"
			},
			{
				frame = 20,
				bullet = "skill2"
			}
		}
	},
	xp = {
		{
			{
				method = "useSkill",
				param = "usexp"
			}
		}
	},
	usexp = {
		totalframe = 80,
		xpeffect = "xp_effect",
		animation = "xp",
		exe_tbl = {
			{
				frame = 1,
				sound = "22220_xp"
			},
			{
				id = 60023061,
				behitted = "hitdown",
				frame = 57
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	totalframe = 80,
	bgfile = "45080_bg",
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	}
}
var_0_0.extra.skill2 = {
	movingani = "run",
	maxdistance = 400,
	movingtype = "lockdirection",
	speed = 250,
	offsetZ = 1,
	filename = "600230_effect",
	initpos = {
		offsetY = 0.5,
		offsetX = 0.5,
		object = "self"
	},
	finalpos = {
		targettype = "oponent",
		crashtype = "cross",
		direction = 1
	},
	attack = {
		totalframe = 11,
		animation = "attack",
		exe_tbl = {
			{
				id = 60023041,
				frame = 20
			}
		}
	}
}

return var_0_0
