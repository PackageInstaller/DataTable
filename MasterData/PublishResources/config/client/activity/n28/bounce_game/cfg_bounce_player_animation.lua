local key = {
  ID = 1,
  Name = 2,
  Eff = 3,
  Duration = 4,
  BaseRect = 5,
  WeaponRect = 6
}
local common = {
  "walk",
  "attack",
  "jump",
  "down",
  "jumpAttack",
  "downAttack",
  "dead",
  "select"
}
local config = {
  {
    1,
    common[1],
    "eff_walk",
    500,
    common[1]
  },
  {
    2,
    common[2],
    "eff_attack",
    500,
    common[2],
    "attackWeapon"
  },
  {
    3,
    common[3],
    "eff_jump",
    1000,
    common[3]
  },
  {
    4,
    common[4],
    "eff_down",
    1000,
    common[4]
  },
  {
    5,
    common[5],
    "eff_jumpAttack",
    500,
    common[5],
    "jumpAttackWeapon"
  },
  {
    6,
    common[6],
    "eff_downAttack",
    1000,
    common[6],
    "downAttackWeapon"
  },
  {
    7,
    common[7],
    "eff_dead",
    1000,
    common[7]
  },
  {
    8,
    common[8],
    nil,
    1000,
    common[8]
  }
}
return config, "ID", key
