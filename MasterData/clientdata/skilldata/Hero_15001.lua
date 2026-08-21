-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_15001.lua

local Data = {
	cueFile = "15001",
	[1500101] = {
		bhEvent = "skill.1500101",
		atkEvents = {
			{
				unitDelay = 0.15,
				boxId = 1500109,
				flyCueId = 150010006,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						150010001
					}
				}
			},
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						150010005
					}
				}
			},
			{
				targetChoose = 14,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 1500110,
						hitCue = {
							cueList = {
								150010009
							}
						}
					},
					[3] = {
						boxId = 1500110,
						hitCue = {
							cueList = {
								150010009
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				targetChoose = 4,
				subEventId = 1002,
				subEventSkill = 1500101,
				targetArea = 3,
				state = {}
			},
			[1002] = {
				targetArea = 1,
				boxId = 1500111,
				targetChoose = 14,
				state = {},
				hitCue = {
					cueList = {
						150010009
					}
				}
			}
		}
	},
	[1500121] = {
		actTime = 30,
		skillTarget = 1,
		bhEvent = "skill.1500121",
		atkEvents = {
			{
				targetChoose = 12,
				targetArea = 3,
				state = {
					duration = 15,
					stateId = 1500102
				},
				hitCue = {
					cueList = {
						150010004,
						150011004
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 20,
							stateId = 1500102
						}
					},
					[3] = {
						state = {
							duration = 20,
							stateId = 1500102
						}
					},
					[4] = {
						state = {
							duration = 20,
							stateId = 1500102
						}
					},
					[5] = {
						state = {
							duration = 20,
							stateId = 1500102
						}
					},
					[6] = {}
				}
			},
			{
				targetChoose = 12,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 10,
							stateId = 1500103
						}
					},
					[4] = {
						state = {
							duration = 10,
							stateId = 1500103
						}
					},
					[5] = {
						state = {
							duration = 10,
							stateId = 1500103
						}
					},
					[6] = {}
				}
			},
			[100] = {
				targetChoose = 3,
				recordSkillTargets = 1,
				targetArea = 3,
				excludeTarget = 1,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						targetChoose = 7
					},
					[4] = {
						targetChoose = 4
					},
					[5] = {
						targetChoose = 4
					},
					[6] = {
						targetChoose = 4
					}
				}
			},
			[1001] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 82150011
				}
			}
		}
	},
	[1500151] = {
		hideTime = 10,
		hideEvent = 3,
		videoActTime = 35,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 115,
		bhEvent = "skill.1500151",
		atkEvents = {
			[2] = {
				targetChoose = 12,
				state = {},
				hitCue = {
					cueList = {
						150010002,
						150011002,
						10006003
					}
				}
			},
			{
				hitedAnim = "Hit",
				boxId = 1500159,
				targetChoose = 12,
				eventType = 1,
				state = {
					duration = 8,
					stateId = 1000004
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 10,
							stateId = 1000004
						}
					},
					[3] = {
						state = {
							duration = 10,
							stateId = 1000004
						}
					},
					[4] = {
						state = {
							duration = 12,
							stateId = 1000004
						}
					},
					[5] = {
						state = {
							duration = 10,
							stateId = 1000004
						}
					},
					[6] = {
						state = {
							duration = 10,
							stateId = 1000004
						}
					}
				}
			},
			[3] = {
				randomTargetNumber = 2,
				recordSkillTargets = 1,
				randomRule = 2,
				targetChoose = 7,
				hitedAnim = "Hit",
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						randomTargetNumber = 3
					},
					[4] = {
						randomTargetNumber = 3
					},
					[5] = {
						randomTargetNumber = 3
					},
					[6] = {
						randomTargetNumber = 3
					}
				}
			},
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						150010010
					}
				}
			},
			[11] = {
				state = {},
				hitCue = {
					cueList = {
						150010003
					}
				}
			},
			[13] = {
				hitedAnim = "end",
				targetChoose = 12,
				state = {}
			},
			[4] = {
				targetChoose = 12,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 12,
							stateId = 1500104
						}
					},
					[3] = {
						state = {
							duration = 12,
							stateId = 1500104
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[12] = {
				state = {},
				atkCue = {
					cueList = {
						150010007,
						150015001
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				150011005,
				150018002
			}
		}
	},
	[1500152] = {
		hideTime = 10,
		hideEvent = 3,
		videoActTime = 35,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 115,
		bhEvent = "skill.1500152",
		atkEvents = {
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						150010010
					}
				}
			},
			{
				boxId = 1500160,
				targetChoose = 7,
				hitedAnim = "Hit",
				state = {
					duration = 15,
					stateId = 1000004
				}
			},
			[12] = {
				state = {},
				atkCue = {
					cueList = {
						150010007,
						150015001
					}
				}
			},
			{
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						150010002,
						150011002,
						10006003
					}
				}
			},
			[4] = {
				state = {}
			},
			[13] = {
				hitedAnim = "end",
				targetChoose = 7,
				state = {}
			},
			{
				targetChoose = 10,
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				150011005,
				150018002
			}
		}
	}
}
local skillDefault = {}
local atkEventsDefault = {
	randomTargetNumber = 0,
	boxType = 0,
	flyCueId = 0,
	eventType = 0,
	delay = 0,
	stateCondition = 0,
	boxId = 0,
	eventProbId = 0
}

for k, skillData in pairs(Data) do
	if k ~= "cueFile" then
		setmetatable(skillData, {
			__index = skillDefault
		})

		for skillKey, skillInfo in pairs(skillData) do
			if skillKey == "atkEvents" then
				for eventsKey, event in pairs(skillInfo) do
					setmetatable(event, {
						__index = atkEventsDefault
					})
				end
			end
		end
	end
end

return Data
