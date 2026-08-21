-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\CueData\\10001.lua

local Data = {
	[100010001] = {
		TypeString = "Effect",
		CueID = 100010001,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/10001/H001_battle_attack_basic_01_behit.prefab",
			startPos = "",
			endPos = "",
			Source = "H001_battle_attack_basic_01_behit",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "0",
			oppositeDirection = false,
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
	[100010002] = {
		TypeString = "Effect",
		CueID = 100010002,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/10001/H001_battle_attack_basic_02_behit.prefab",
			startPos = "",
			endPos = "",
			Source = "H001_battle_attack_basic_02_behit",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "",
			oppositeDirection = false,
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
	[100010003] = {
		TypeString = "Effect",
		CueID = 100010003,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/10001/efx_10001_battle_attack_ultra_01_1.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_10001_battle_attack_ultra_01_1",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 2,
			curve = 0,
			mount = "",
			oppositeDirection = false,
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
	[100010004] = {
		TypeString = "Effect",
		CueID = 100010004,
		CueType = 0,
		EffectCue = {
			SourcePath = "",
			howToPlay = 1,
			startPos = "",
			endPos = "",
			height = 0,
			playLength = 0,
			curve = 0,
			speed = 0,
			mountType = 0,
			oppositeDirection = false,
			mount = "",
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
	[100015001] = {
		TypeString = "PostProcess",
		CueID = 100015001,
		CueType = 5,
		PostProcess = {
			fadeOut = 0.3,
			fadeIn = 0.3,
			length = 3.7,
			type = 6,
			cullingPlayer = 1,
			depthParam = {
				blurSize = 0,
				aperture = 5.6,
				focusDistance = 10,
				focalLength = 50
			}
		}
	},
	[100015002] = {
		TypeString = "PostProcess",
		CueID = 100015002,
		CueType = 5,
		PostProcess = {
			fadeOut = 0.5,
			fadeIn = 0.5,
			length = 1.5,
			type = 4,
			tintColorParam = {
				G = 1,
				A = 1,
				blendMode = false,
				R = 1,
				B = 1
			}
		}
	},
	[100010005] = {
		TypeString = "Effect",
		CueID = 100010005,
		CueType = 0,
		EffectCue = {
			SourcePath = "",
			howToPlay = 1,
			startPos = "",
			endPos = "",
			height = 0,
			playLength = 0,
			curve = 0,
			speed = 0,
			mountType = 0,
			oppositeDirection = false,
			mount = "Bone_Weapon_01/Bip001 Weapon",
			motionMode = 0,
			scale = 1,
			loopTimes = 1,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[100018001] = {
		TypeString = "SequenceFrame",
		CueID = 100018001,
		CueType = 8,
		SequenceFrame = {
			FrameCount = 31,
			SequenceName = "110001",
			SequenceType = 0
		}
	},
	[100015003] = {
		TypeString = "PostProcess",
		CueID = 100015003,
		CueType = 5,
		PostProcess = {
			cullingPlayer = 1,
			length = 3.9,
			type = 6,
			depthParam = {
				blurSize = 3,
				aperture = 0.1,
				focusDistance = 7,
				focalLength = 300
			}
		}
	},
	[100015004] = {
		TypeString = "PostProcess",
		CueID = 100015004,
		CueType = 5,
		PostProcess = {
			length = 7,
			type = 7,
			motionBlurParam = {
				blurSize = 1
			}
		}
	},
	[100013001] = {
		TypeString = "CueShake",
		CueID = 100013001,
		CueType = 3,
		CueShake = {
			Source = "ScreenShake"
		}
	},
	[100013002] = {
		TypeString = "CueShake",
		CueID = 100013002,
		CueType = 3,
		CueShake = {
			Source = "ScreenShake2"
		}
	},
	[100016001] = {
		TypeString = "ModelEffect",
		CueID = 100016001,
		CueType = 6,
		ModelEffect = {
			fadeIn = 0.2,
			howToPlay = 3,
			length = -1,
			type = 4,
			modelChangeAll = {
				animator = "Animators/Hero/Hero_11201_01.controller",
				commonModelId = 1120101
			}
		}
	},
	[100019001] = {
		TypeString = "TargetCamera",
		CueID = 100019001,
		CueType = 9,
		TargetCamera = {
			FadeOut = 0.2,
			SourcePath = "Camera/CameraCurvy/Heroes/11004/cam_11004_battle_ultra.anim",
			Length = 2,
			FadeIn = 0.2
		}
	},
	[100011001] = {
		TypeString = "Audio",
		CueID = 100011001,
		CueType = 1,
		AudioCue = {
			sourcePath = "Audios/SFX/Hero/hero_vocal_battle_11004_51_1.ogg",
			priority = 128,
			volume = 1,
			pitch = 1,
			source = "hero_vocal_battle_11004_51_1"
		}
	},
	[100011002] = {
		TypeString = "Audio",
		CueID = 100011002,
		CueType = 1,
		AudioCue = {
			sourcePath = "Audios/SFX/Hero/hero_vocal_battle_11004_51_2.ogg",
			priority = 128,
			volume = 1,
			pitch = 1,
			source = "hero_vocal_battle_11004_51_2"
		}
	},
	[100010006] = {
		TypeString = "Effect",
		CueID = 100010006,
		CueType = 0,
		EffectCue = {
			SourcePath = "",
			howToPlay = 0,
			startPos = "",
			endPos = "",
			height = 0,
			playLength = 0,
			curve = 0,
			speed = 0,
			mountType = 0,
			oppositeDirection = false,
			mount = "",
			motionMode = 0,
			scale = 0,
			loopTimes = 0,
			offset = {
				z = 0,
				x = 0,
				y = 0
			}
		}
	},
	[100011003] = {
		TypeString = "Audio",
		CueID = 100011003,
		CueType = 1,
		AudioCue = {
			sourcePath = "Audios/SFX/Hero/hero_vocal_battle_11004_21_1.ogg",
			priority = 128,
			volume = 1,
			pitch = 1,
			source = "hero_vocal_battle_11004_21_1"
		}
	},
	[100011004] = {
		TypeString = "Audio",
		CueID = 100011004,
		CueType = 1,
		AudioCue = {
			sourcePath = "Audios/SFX/Hero/hero_vocal_battle_11004_11_1.ogg",
			priority = 128,
			volume = 1,
			pitch = 1,
			source = "hero_vocal_battle_11004_11_1"
		}
	},
	[100011005] = {
		TypeString = "Audio",
		CueID = 100011005,
		CueType = 1,
		AudioCue = {
			sourcePath = "Audios/SFX/Hero/hero_vocal_battle_11004_11_2.ogg",
			priority = 128,
			volume = 1,
			pitch = 1,
			source = "hero_vocal_battle_11004_11_2"
		}
	},
	[100010007] = {
		TypeString = "Effect",
		CueID = 100010007,
		CueType = 0,
		EffectCue = {
			howToPlay = 1,
			SourcePath = "Effects/Heros/11004/efx_11004_battle_new_1.prefab",
			startPos = "",
			endPos = "",
			Source = "efx_11004_battle_new_1",
			playLength = 0,
			height = 0,
			speed = 0,
			mountType = 0,
			curve = 0,
			mount = "",
			oppositeDirection = false,
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
