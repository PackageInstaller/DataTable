JSYZConst = {}




JSYZGame = {
gridSizeX = 18,
gridSizeY = 9,
cellSize = 88,
bombTimer = ConfigMgr.Config.BoomConstants.BombTimer,
explosionDuration = ConfigMgr.Config.BoomConstants.ExplosionDuration / 10,
pathRecalcInterval = 0.5,
maxPathfindingIterations = 200
}





JSYZCellType = {
EMPTY = 0,
WALL = 1,
BRICK = 2,
PLAYER = 3,
ENEMY = 4,
BOMB = 5,
EXPLOSION = 6,
EXIT = 7,
POWERUP_RANGE = 8,
POWERUP_SPEED = 9,
POWERUP_INVINCIBLE = 10,
POWERUP_BOMB = 11,
POWERUP_HP = 12,
POWERUP_INVINCIBLE_HURT = 13,
}





JSYZMap = {
borderWall = false,


    fixedWallPattern = {
enabled = false,
rowInterval = 2,
colInterval = 2
    },
}





JSYZPowerups = {
    [1] = {
        id = 11,
        name = LuaMgr.GetLangText("JSYZGameConst_2"),
        prefab = "Powerup_Bomb",
maxValue = 5,
        scoreBonus = 50,
    },
    [2] = {
        id = 12,
        name = LuaMgr.GetLangText("JSYZGameConst_3"),
        prefab = "HP",
maxValue = 5,
        scoreBonus = 50,
    },
    [3] = {
        id = 9,
        name = LuaMgr.GetLangText("JSYZGameConst_0"),
        prefab = "Powerup_Speed",
        scoreBonus = 50,
    },
    [4] = {
id = 8,
name = "范围增加",
        prefab = "Powerup_Range",
maxValue = 5,
scoreBonus = 50,
    },
    [5] = {
id = 7,
name = "出口",
        prefab = "Powerup_Range",
    },
    [6] = {
        id = 10,
        name = LuaMgr.GetLangText("JSYZGameConst_1"),
        prefab = "Powerup_Invincible",
duration = 5,
        scoreBonus = 50,
    },
    [7] = {
        id = 13,
        name = LuaMgr.GetLangText("JSYZGameConst_4"),
        prefab = "Powerup_Invincible",
duration = 2,
    },
}





JSYZEnemies = {

    [1] = {
id = 1,
name = "普通怪物",
prefab = "MD01101,MD02001",
moveSpeed = 1.2,
scoreValue = 1,
ai = "smart_chase",
chaseRange = 0,
dangerAvoidance = false,
riskThreshold = 0
    },


    [2] = {
        id = 2,
        name = LuaMgr.GetLangText("JSYZGameConst_5"),
        prefab = "EV10201,EV11601",
moveSpeed = 1,
scoreValue = 1,
ai = "aggressive",
        chaseRange = 1,
dangerAvoidance = false,
riskThreshold = 0
    },


    [3] = {
        id = 3,
        name = LuaMgr.GetLangText("JSYZGameConst_6"),
        prefab = "CD03501,CD00901",
moveSpeed = 0.9,
scoreValue = 1,
ai = "patrol_only",
chaseRange = 2,
dangerAvoidance = true,
riskThreshold = 1.5
    }
}





JSYZVisuals = {

    cells = {
        [0] = {
prefab = "Cell_Empty",
        },
        [1] = {
prefab = "Cell_Wall",
        },
        [2] = {
prefab = "Cell_Brick",
        },
        [7] = {
prefab = "Cell_Exit",
            sprite = "km"
        },

        [8] = {
prefab = "Powerup_Range",
            sprite = "ql"
        },
        [9] = {
prefab = "Powerup_Speed",
            sprite = "jx"
        },
        [10] = {
prefab = "Powerup_Invincible",
            sprite = "js"
        },
        [11] = {
prefab = "Powerup_Bomb",
            sprite = "cy"
        },
        [12] = {
prefab = "Powerup_Hp",
            sprite = "fs"
        }
    },


    characters = {
        player = {
prefab = "Player_Robot",
normalMaterial = "Mat_Player_Normal",
invincibleMaterial = "Mat_Player_Invincible",
            animations = {
idle = "Anim_Player_Idle",
walk = "Anim_Player_Walk"
            }
        }
    },


    bomb = {
prefab = "Bomb",
material = "Mat_Bomb",
tickSound = "SFX_Bomb_Tick"
    },


    explosion = {
prefab = "Explosion_Effect",
sound = "SFX_Explosion",
duration = 0.5
    }
}





JSYZSounds = {
Explosion = "SFX_Explosion",
BombTick = "SFX_Bomb_Tick",
Powerup = "SFX_Powerup",
Death = "SFX_Death",
Win = "SFX_Win",
Move = "SFX_Move"
}