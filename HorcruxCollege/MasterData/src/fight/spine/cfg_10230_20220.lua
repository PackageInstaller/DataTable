local var_0_0 = {
	extra = {},
	xpeffect = {},
	attack = {
		totalframe = 20,
		animation = "attack",
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20220-attack",
					0.6
				}
			},
			{
				id = 29010001,
				frame = 11,
				effect = {
					{
						offsetX = 0,
						name = "20220_effect",
						offsetZ = 1,
						offsetY = 0.5,
						method = "target",
						ani = "attack"
					}
				}
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
	skill1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	skill1_1 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	skill1_2 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	skill1_3 = {
		{
			{
				method = "useSkill",
				param = "useskill1"
			}
		}
	},
	useskill1 = {
		totalframe = 30,
		animation = "skill",
		action_on_start = {
			{
				startframe = 4,
				action = {
					{
						method = "change_to_invincible"
					}
				}
			}
		},
		action_on_complete = {
			{
				method = "remove_invincible"
			},
			{
				method = "complete"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20220-skill",
					0.6
				}
			},
			{
				id = 29020001,
				frame = 5,
				effect = {
					{
						offsetX = 0,
						name = "20220_effect",
						offsetZ = 1,
						offsetY = 0.5,
						method = "target",
						ani = "skill"
					}
				}
			},
			{
				id = 29020001,
				frame = 14,
				effect = {
					{
						offsetX = 0,
						name = "20220_effect",
						offsetZ = 1,
						offsetY = 0.5,
						method = "target",
						ani = "skill"
					}
				}
			},
			{
				id = 29020001,
				frame = 24,
				effect = {
					{
						offsetX = 0,
						name = "20220_effect",
						offsetZ = 1,
						offsetY = 0.5,
						method = "target",
						ani = "skill"
					}
				}
			}
		}
	},
	useskill1_1 = {
		totalframe = 30,
		animation = "skill",
		action_on_start = {
			{
				startframe = 4,
				action = {
					{
						method = "change_to_invincible"
					}
				}
			}
		},
		action_on_complete = {
			{
				method = "remove_invincible"
			},
			{
				method = "complete"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20220-skill",
					0.6
				}
			},
			{
				id = 29020101,
				frame = 5,
				effect = {
					{
						offsetX = 0,
						name = "20220_effect",
						offsetZ = 1,
						offsetY = 0.5,
						method = "target",
						ani = "skill"
					}
				}
			},
			{
				id = 29020101,
				frame = 14,
				effect = {
					{
						offsetX = 0,
						name = "20220_effect",
						offsetZ = 1,
						offsetY = 0.5,
						method = "target",
						ani = "skill"
					}
				}
			},
			{
				id = 29020101,
				frame = 24,
				effect = {
					{
						offsetX = 0,
						name = "20220_effect",
						offsetZ = 1,
						offsetY = 0.5,
						method = "target",
						ani = "skill"
					}
				}
			}
		}
	},
	useskill1_2 = {
		totalframe = 30,
		animation = "skill",
		action_on_start = {
			{
				startframe = 4,
				action = {
					{
						method = "change_to_invincible"
					}
				}
			}
		},
		action_on_complete = {
			{
				method = "remove_invincible"
			},
			{
				method = "complete"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20220-skill",
					0.6
				}
			},
			{
				id = 29020201,
				frame = 5,
				effect = {
					{
						offsetX = 0,
						name = "20220_effect",
						offsetZ = 1,
						offsetY = 0.5,
						method = "target",
						ani = "skill"
					}
				}
			},
			{
				id = 29020201,
				frame = 14,
				effect = {
					{
						offsetX = 0,
						name = "20220_effect",
						offsetZ = 1,
						offsetY = 0.5,
						method = "target",
						ani = "skill"
					}
				}
			},
			{
				id = 29020201,
				frame = 24,
				effect = {
					{
						offsetX = 0,
						name = "20220_effect",
						offsetZ = 1,
						offsetY = 0.5,
						method = "target",
						ani = "skill"
					}
				}
			}
		}
	},
	useskill1_3 = {
		totalframe = 30,
		animation = "skill",
		action_on_start = {
			{
				startframe = 4,
				action = {
					{
						method = "change_to_invincible"
					}
				}
			}
		},
		action_on_complete = {
			{
				method = "remove_invincible"
			},
			{
				method = "complete"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20220-skill",
					0.6
				}
			},
			{
				id = 29020301,
				frame = 5,
				effect = {
					{
						offsetX = 0,
						name = "20220_effect",
						offsetZ = 1,
						offsetY = 0.5,
						method = "target",
						ani = "skill"
					}
				}
			},
			{
				id = 29020301,
				frame = 14,
				effect = {
					{
						offsetX = 0,
						name = "20220_effect",
						offsetZ = 1,
						offsetY = 0.5,
						method = "target",
						ani = "skill"
					}
				}
			},
			{
				id = 29020301,
				frame = 24,
				effect = {
					{
						offsetX = 0,
						name = "20220_effect",
						offsetZ = 1,
						offsetY = 0.5,
						method = "target",
						ani = "skill"
					}
				}
			}
		}
	},
	usexp = {
		turnbacklimit = false,
		xpeffect = "xp_effect",
		totalframe = 78,
		animation = "xp",
		action_on_start = {
			{
				method = "remove_invincible"
			},
			{
				method = "complete"
			}
		},
		exe_tbl = {
			{
				frame = 1,
				sound = {
					"20220-xp",
					0.6
				}
			},
			{
				behitted = "hitdown",
				id = 29030001,
				frame = 45,
				shake = {
					period = 2,
					time = 0.2,
					x = 6,
					y = 60
				},
				effect = {
					{
						offsetX = 0,
						name = "20220_effect",
						offsetZ = 1,
						offsetY = 0.5,
						method = "target",
						ani = "attack-xp"
					}
				}
			}
		}
	}
}

var_0_0.xpeffect.xp_effect = {
	bgfilescale = 0.8,
	totalframe = 78,
	bgfile = "20220_bg",
	bgfileflipX = true,
	locktarget = {
		locktargetpool = "oponent"
	},
	bgani = {
		{
			isloop = true,
			startframe = 0,
			ani = "BG"
		}
	},
	inserteffect = {
		{
			texture = "role/20220.png",
			ani = "xp",
			file = "xp2",
			startframe = 0,
			zorder = 200,
			sound = {
				"role_voice/10220_xp",
				1
			}
		}
	}
}

return var_0_0
