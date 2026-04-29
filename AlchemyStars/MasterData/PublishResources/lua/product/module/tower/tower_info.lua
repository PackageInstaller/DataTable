local TowerElementType = {
  TowerElementType_None = 0,
  TowerElementType_Blue = 1,
  TowerElementType_Red = 2,
  TowerElementType_Green = 3,
  TowerElementType_Yellow = 4,
  TowerElementType_Difficulty_Blue = 5,
  TowerElementType_Difficulty_Red = 6,
  TowerElementType_Difficulty_Green = 7,
  TowerElementType_Difficulty_Yellow = 8,
  TowerElementType_End = 9
}
_enum("TowerElementType", TowerElementType)
_class("each_tower_formation_info", Object)
each_tower_formation_info = each_tower_formation_info

function each_tower_formation_info:Constructor()
  self.id = 0
  self.name = ""
  self.pet_list = {}
end

each_tower_formation_info._proto = {
  [1] = {"id", "int"},
  [2] = {"name", "string"},
  [3] = {
    "pet_list",
    "list<int64>"
  }
}
_class("tower_formation_info", Object)
tower_formation_info = tower_formation_info

function tower_formation_info:Constructor()
  self.water_pet_list = {}
  self.fire_pet_list = {}
  self.wood_pet_list = {}
  self.thunder_pet_list = {}
  self.difficulty_water_pet_list = {}
  self.difficulty_fire_pet_list = {}
  self.difficulty_wood_pet_list = {}
  self.difficulty_thunder_pet_list = {}
end

tower_formation_info._proto = {
  [1] = {
    "water_pet_list",
    "list<int64>"
  },
  [2] = {
    "fire_pet_list",
    "list<int64>"
  },
  [3] = {
    "wood_pet_list",
    "list<int64>"
  },
  [4] = {
    "thunder_pet_list",
    "list<int64>"
  },
  [5] = {
    "difficulty_water_pet_list",
    "list<int64>"
  },
  [6] = {
    "difficulty_fire_pet_list",
    "list<int64>"
  },
  [7] = {
    "difficulty_wood_pet_list",
    "list<int64>"
  },
  [8] = {
    "difficulty_thunder_pet_list",
    "list<int64>"
  }
}
_class("mul_tower_formations", Object)
mul_tower_formations = mul_tower_formations

function mul_tower_formations:Constructor()
  self.mul_water_pet_lists = {}
  self.mul_fire_pet_lists = {}
  self.mul_wood_pet_lists = {}
  self.mul_thunder_pet_lists = {}
  self.difficulty_mul_water_pet_lists = {}
  self.difficulty_mul_fire_pet_lists = {}
  self.difficulty_mul_wood_pet_lists = {}
  self.difficulty_mul_thunder_pet_lists = {}
end

mul_tower_formations._proto = {
  [1] = {
    "mul_water_pet_lists",
    "list<each_tower_formation_info>"
  },
  [2] = {
    "mul_fire_pet_lists",
    "list<each_tower_formation_info>"
  },
  [3] = {
    "mul_wood_pet_lists",
    "list<each_tower_formation_info>"
  },
  [4] = {
    "mul_thunder_pet_lists",
    "list<each_tower_formation_info>"
  },
  [5] = {
    "difficulty_mul_water_pet_lists",
    "list<each_tower_formation_info>"
  },
  [6] = {
    "difficulty_mul_fire_pet_lists",
    "list<each_tower_formation_info>"
  },
  [7] = {
    "difficulty_mul_wood_pet_lists",
    "list<each_tower_formation_info>"
  },
  [8] = {
    "difficulty_mul_thunder_pet_lists",
    "list<each_tower_formation_info>"
  }
}
_class("player_tower_data", Object)
player_tower_data = player_tower_data

function player_tower_data:Constructor()
  self.tower_water = 0
  self.tower_fire = 0
  self.tower_wood = 0
  self.tower_thunder = 0
  self.formation_info = tower_formation_info:New()
  self.mul_formations = mul_tower_formations:New()
  self.difficulty_tower_water = 0
  self.difficulty_tower_fire = 0
  self.difficulty_tower_wood = 0
  self.difficulty_tower_thunder = 0
end

player_tower_data._proto = {
  [1] = {
    "tower_water",
    "int"
  },
  [2] = {"tower_fire", "int"},
  [3] = {"tower_wood", "int"},
  [4] = {
    "tower_thunder",
    "int"
  },
  [5] = {
    "formation_info",
    "tower_formation_info"
  },
  [6] = {
    "mul_formations",
    "mul_tower_formations"
  },
  [7] = {
    "difficulty_tower_water",
    "int"
  },
  [8] = {
    "difficulty_tower_fire",
    "int"
  },
  [9] = {
    "difficulty_tower_wood",
    "int"
  },
  [10] = {
    "difficulty_tower_thunder",
    "int"
  }
}
_class("tower_pass_pet_info", Object)
tower_pass_pet_info = tower_pass_pet_info

function tower_pass_pet_info:Constructor()
  self.template_id = 0
  self.level = 0
  self.grade = 0
  self.awakening = 0
  self.skin_id = 0
  self.equip_lv = 1
  self.equip_refine_lv = 0
  self.awake_lock = 0
end

tower_pass_pet_info._proto = {
  [1] = {
    "template_id",
    "int"
  },
  [2] = {"level", "int"},
  [3] = {"grade", "int"},
  [4] = {"awakening", "int"},
  [5] = {"skin_id", "int"},
  [6] = {"equip_lv", "int"},
  [7] = {
    "equip_refine_lv",
    "int"
  },
  [8] = {"awake_lock", "int"}
}
_class("tower_pass_info", Object)
tower_pass_info = tower_pass_info

function tower_pass_info:Constructor()
  self.type = 0
  self.level = 0
  self.nick = ""
  self.head = 0
  self.head_bg = 0
  self.pstid = 0
  self.formation_info = {}
  self.pass_time = 0
  self.frame_id = 0
end

tower_pass_info._proto = {
  [1] = {"type", "int"},
  [2] = {"level", "int"},
  [3] = {"nick", "string"},
  [4] = {"head", "int"},
  [5] = {"head_bg", "int"},
  [6] = {"pstid", "int64"},
  [7] = {
    "formation_info",
    "list<tower_pass_pet_info>"
  },
  [8] = {"pass_time", "time"},
  [9] = {"frame_id", "int"}
}
