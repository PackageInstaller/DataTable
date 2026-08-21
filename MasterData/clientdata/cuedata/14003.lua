-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\CueData\\14003.lua

local Data = {
	[140030001] = {
		TypeString = "Effect",
		CueID = 140030001,
		CueType = 0,
		EffectCue = {
			howToPlay = 2,
			SourcePath = "Effects/Heros/14003/efx_14003_battle_attack_basic_01.prefab",
			startPos = "Bone016",
			endPos = "Bip001 Behit",
			Source = "efx_14003_battle_attack_basic_01",
			playLength = -1,
			height = 3,
			speed = 0,
			mountType = 0,
			curve = 5,
			oppositeDirection = false,
			motionMode = 1,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[140030002] = {
		TypeString = "Effect",
		CueID = 140030002,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/14003/efx_14003_battle_attack_basic_01_behit.prefab",
			height = 0,
			curve = 0,
			Source = "efx_14003_battle_attack_basic_01_behit",
			playLength = 0,
			oppositeDirection = false,
			speed = 0,
			mountType = 0,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[140038001] = {
		TypeString = "SequenceFrame",
		CueID = 140038001,
		CueType = 8,
		SequenceFrame = {
			FrameCount = 0,
			SequenceName = "HeroUltra/14003/video_14003_ultra.mp4",
			SequenceType = 2
		}
	},
	[140030003] = {
		TypeString = "Effect",
		CueID = 140030003,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/14003/efx_14003_battle_attack_ultra_behit.prefab",
			height = 0,
			curve = 0,
			Source = "efx_14003_battle_attack_ultra_behit",
			playLength = 0,
			oppositeDirection = false,
			speed = 0,
			mountType = 0,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[140030004] = {
		TypeString = "Effect",
		CueID = 140030004,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/14003/efx_14003_battle_attack_ultra_01.prefab",
			height = 0,
			curve = 0,
			Source = "efx_14003_battle_attack_ultra_01",
			playLength = 0,
			oppositeDirection = false,
			speed = 0,
			mountType = 0,
			mount = "Bip001 Spine",
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[140030005] = {
		TypeString = "Effect",
		CueID = 140030005,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/14003/efx_14003_battle_attack_passive_21_behit.prefab",
			height = 0,
			curve = 0,
			Source = "efx_14003_battle_attack_passive_21_behit",
			playLength = 0,
			oppositeDirection = false,
			speed = 0,
			mountType = 0,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[140035001] = {
		TypeString = "PostProcess",
		CueID = 140035001,
		CueType = 5,
		PostProcess = {
			fadeOut = 0.2,
			cullingPlayer = 1,
			length = 2,
			type = 4,
			tintColorParam = {
				G = 0,
				A = 1,
				blendMode = true,
				R = 0,
				B = 0
			}
		}
	},
	[140036001] = {
		TypeString = "ModelEffect",
		CueID = 140036001,
		CueType = 6,
		ModelEffect = {
			length = -1,
			howToPlay = 3,
			type = 4,
			modelChangeAll = {
				animator = "Animators/Hero/Hero_14003.controller",
				commonModelId = 14003010
			}
		}
	},
	[140036002] = {
		TypeString = "ModelEffect",
		CueID = 140036002,
		CueType = 6,
		ModelEffect = {
			length = -1,
			howToPlay = 3,
			type = 4,
			modelChangeAll = {
				animator = "Animators/Hero/Hero_14003.controller",
				commonModelId = 14003020
			}
		}
	},
	[140038002] = {
		TypeString = "SequenceFrame",
		CueID = 140038002,
		CueType = 8,
		SequenceFrame = {
			FrameCount = 0,
			SequenceName = "HeroUltra/14003/video_14003_ultra_short.mp4",
			SequenceType = 2
		}
	},
	[140031001] = {
		TypeString = "Audio",
		CueID = 140031001,
		CueType = 1,
		AudioCue = {
			sourcePath = "Audios/SFX/Hero/hero_vocal_battle_14003_51_1.ogg",
			priority = 128,
			volume = 1,
			pitch = 1,
			source = "hero_vocal_battle_14003_51_1"
		}
	},
	[140031002] = {
		TypeString = "Audio",
		CueID = 140031002,
		CueType = 1,
		AudioCue = {
			sourcePath = "Audios/SFX/Hero/hero_vocal_battle_14003_51_2.ogg",
			priority = 128,
			volume = 1,
			pitch = 1,
			source = "hero_vocal_battle_14003_51_2"
		}
	},
	[140031003] = {
		TypeString = "Audio",
		CueID = 140031003,
		CueType = 1,
		AudioCue = {
			sourcePath = "Audios/SFX/Hero/hero_vocal_battle_14003_51_3.ogg",
			priority = 128,
			volume = 1,
			pitch = 1,
			source = "hero_vocal_battle_14003_51_3"
		}
	},
	[140031004] = {
		TypeString = "Audio",
		CueID = 140031004,
		CueType = 1,
		AudioCue = {
			sourcePath = "Audios/SFX/Hero/hero_vocal_battle_14003_51_4.ogg",
			priority = 128,
			volume = 1,
			pitch = 1,
			source = "hero_vocal_battle_14003_51_4"
		}
	},
	[140031005] = {
		TypeString = "Audio",
		CueID = 140031005,
		CueType = 1,
		AudioCue = {
			sourcePath = "Audios/SFX/Hero/hero_vocal_battle_14003_11_2.ogg",
			priority = 128,
			volume = 1,
			pitch = 1,
			source = "hero_vocal_battle_14003_11_2"
		}
	},
	[140031006] = {
		TypeString = "Audio",
		CueID = 140031006,
		CueType = 1,
		AudioCue = {
			sourcePath = "Audios/SFX/Hero/hero_vocal_battle_14003_21_1_standby.ogg",
			priority = 128,
			volume = 1,
			pitch = 1,
			source = "hero_vocal_battle_14003_21_1_standby"
		}
	},
	[140031007] = {
		TypeString = "Audio",
		CueID = 140031007,
		CueType = 1,
		AudioCue = {
			sourcePath = "Audios/SFX/Hero/hero_vocal_battle_14003_61_1.ogg",
			priority = 128,
			volume = 1,
			pitch = 1,
			source = "hero_vocal_battle_14003_61_1"
		}
	},
	[140030006] = {
		TypeString = "Effect",
		CueID = 140030006,
		CueType = 0,
		EffectCue = {
			howToPlay = 0,
			SourcePath = "Effects/Heros/14003/efx_14003_battle_attack_ultra_61_1_HUD.prefab",
			height = 0,
			curve = 0,
			Source = "efx_14003_battle_attack_ultra_61_1_HUD",
			playLength = 3,
			oppositeDirection = false,
			speed = 0,
			mountType = 0,
			motionMode = 3,
			scale = 0,
			loopTimes = 0,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[140030007] = {
		TypeString = "Effect",
		CueID = 140030007,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/14003/efx_14003_battle_attack_ultra_01_new.prefab",
			height = 0,
			curve = 0,
			Source = "efx_14003_battle_attack_ultra_01_new",
			playLength = 0,
			oppositeDirection = false,
			speed = 0,
			mountType = 3,
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[140033001] = {
		TypeString = "CueShake",
		CueID = 140033001,
		CueType = 3,
		CueShake = {
			Source = "FistScreenShake07"
		}
	},
	[140030008] = {
		TypeString = "Effect",
		CueID = 140030008,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/14003/efx_14003_battle_attack_ultra_behit_1.prefab",
			height = 0,
			curve = 0,
			Source = "efx_14003_battle_attack_ultra_behit_1",
			playLength = 0,
			oppositeDirection = false,
			speed = 0,
			mountType = 0,
			mount = "Bip001 behit",
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[140030009] = {
		TypeString = "Effect",
		CueID = 140030009,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/14003/efx_14003_battle_attack_ultra_behit_2.prefab",
			height = 0,
			curve = 0,
			Source = "efx_14003_battle_attack_ultra_behit_2",
			playLength = 0,
			oppositeDirection = false,
			speed = 0,
			mountType = 0,
			mount = "Bip001 Behit",
			motionMode = 0,
			scale = 0,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	}
}

return Data
