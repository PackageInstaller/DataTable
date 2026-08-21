local MazeRoomType = {
  MazeRoomType_Normal = 1,
  MazeRoomType_Elite = 2,
  MazeRoomType_Special = 3,
  MazeRoomType_XRoot = 4,
  MazeRoomType_Warehouse = 5,
  MazeRoomType_Battery = 6,
  MazeRoomType_Robber = 7
}
_enum("MazeRoomType", MazeRoomType)
local MazeRelicOutGameTriggerType = {
  MRTOGTT_None = 0,
  MRTOGTT_GetRelic = 1,
  MRTOGTT_GameOver = 2,
  MRTOGTT_RestRoom = 3
}
_enum("MazeRelicOutGameTriggerType", MazeRelicOutGameTriggerType)
local MazeRelicOutGameEffectType = {
  AddAttacker = 1,
  AddDefence = 2,
  AddMaxHP = 3,
  AddHP = 4,
  AddRestAddHP = 5,
  AddRestAddLight = 6,
  DropItem = 7,
  AddAfterDamage = 8,
  AddRestAddHPPetNum = 9
}
_enum("MazeRelicOutGameEffectType", MazeRelicOutGameEffectType)
_class("MazeLevelWaveInfo", Object)
MazeLevelWaveInfo = MazeLevelWaveInfo

function MazeLevelWaveInfo:Constructor()
  self.monster_refresh_param = 0
  self.trap_refresh_param = 0
end

MazeLevelWaveInfo._proto = {
  [1] = {
    "monster_refresh_param",
    "float"
  },
  [2] = {
    "trap_refresh_param",
    "float"
  }
}
_class("MazeLevelInfo", Object)
MazeLevelInfo = MazeLevelInfo

function MazeLevelInfo:Constructor()
  self.level_id = 0
  self.word_ids = {}
  self.wave_randoms = {}
  self.rand_seed = 0
  self.battle_archive = ""
  self.has_archive = false
end

MazeLevelInfo._proto = {
  [1] = {"level_id", "int"},
  [2] = {"word_ids", "list<int>"},
  [3] = {
    "wave_randoms",
    "list<float>"
  },
  [4] = {"rand_seed", "uint"},
  [5] = {
    "battle_archive",
    "string"
  },
  [6] = {
    "has_archive",
    "bool"
  }
}
_class("MazePetInfo", Object)
MazePetInfo = MazePetInfo

function MazePetInfo:Constructor()
  self.pet_pstid = 0
  self.power = 0
  self.blood = 1
  self.is_dead = false
  self.after_damage = 0
end

MazePetInfo._proto = {
  [1] = {"pet_pstid", "int64"},
  [2] = {"power", "int"},
  [3] = {"blood", "double"},
  [4] = {"is_dead", "bool"},
  [5] = {
    "after_damage",
    "double"
  }
}
_class("MazeRoomInfo", Object)
MazeRoomInfo = MazeRoomInfo

function MazeRoomInfo:Constructor()
  self.room_index = 0
  self.layer_step = 0
  self.step_index = 0
  self.room_id = 0
  self.x = 0
  self.z = 0
  self.next_rooms = {}
  self.level_info = MazeLevelInfo:New()
  self.relic_drop_id = 0
end

MazeRoomInfo._proto = {
  [1] = {"room_index", "int"},
  [2] = {"layer_step", "int"},
  [3] = {"step_index", "int"},
  [4] = {"room_id", "int"},
  [5] = {"x", "float"},
  [6] = {"z", "float"},
  [7] = {"next_rooms", "list<int>"},
  [8] = {
    "level_info",
    "MazeLevelInfo"
  },
  [9] = {
    "relic_drop_id",
    "int"
  }
}
_class("MazeRelicAddAttr", Object)
MazeRelicAddAttr = MazeRelicAddAttr

function MazeRelicAddAttr:Constructor()
  self.attack_mul = {}
  self.defense_mul = {}
  self.maxhp_mul = {}
end

MazeRelicAddAttr._proto = {
  [1] = {
    "attack_mul",
    "map<int,float>"
  },
  [2] = {
    "defense_mul",
    "map<int,float>"
  },
  [3] = {
    "maxhp_mul",
    "map<int,float>"
  }
}
_class("maze_formation_detail", Object)
maze_formation_detail = maze_formation_detail

function maze_formation_detail:Constructor()
  self.id = 0
  self.name = ""
  self.pet_list = {}
end

maze_formation_detail._proto = {
  [1] = {"id", "int"},
  [2] = {"name", "string"},
  [3] = {
    "pet_list",
    "list<int64>"
  }
}
_class("maze_formation_info", Object)
maze_formation_info = maze_formation_info

function maze_formation_info:Constructor()
  self.fromation_list = {}
end

maze_formation_info._proto = {
  [1] = {
    "fromation_list",
    "list<maze_formation_detail>"
  }
}
_class("maze_info", Object)
maze_info = maze_info

function maze_info:Constructor()
  self.owner_pstid = 0
  self.maze_version = 0
  self.layer = 0
  self.room_index = 0
  self.team_id = 0
  self.pet_info = {}
  self.relics = {}
  self.room_info = {}
  self.dangling_relics = {}
  self.relic_counters = {}
  self.layer_path = {}
  self.dropped_relics = {}
  self.relic_attrs = MazeRelicAddAttr:New()
  self.boss_room_ids = {}
  self.show_version_dialog = false
  self.show_layer_dialog = false
  self.formation_info = maze_formation_info:New()
  self.is_pass_all_maze = false
end

maze_info._proto = {
  [1] = {
    "owner_pstid",
    "int64"
  },
  [2] = {
    "maze_version",
    "int"
  },
  [3] = {"layer", "int"},
  [4] = {"room_index", "int"},
  [5] = {"team_id", "int"},
  [6] = {
    "pet_info",
    "map<int64,MazePetInfo>"
  },
  [7] = {"relics", "list<int>"},
  [8] = {
    "room_info",
    "list<MazeRoomInfo>"
  },
  [9] = {
    "dangling_relics",
    "list<CommonOutput>"
  },
  [10] = {
    "relic_counters",
    "map<int,int>"
  },
  [11] = {"layer_path", "list<int>"},
  [12] = {
    "dropped_relics",
    "list<int>"
  },
  [13] = {
    "relic_attrs",
    "MazeRelicAddAttr"
  },
  [14] = {
    "boss_room_ids",
    "list<int>"
  },
  [15] = {
    "show_version_dialog",
    "bool"
  },
  [16] = {
    "show_layer_dialog",
    "bool"
  },
  [17] = {
    "formation_info",
    "maze_formation_info"
  },
  [18] = {
    "is_pass_all_maze",
    "bool"
  }
}
