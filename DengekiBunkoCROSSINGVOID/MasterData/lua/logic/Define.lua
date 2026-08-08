local PB = require("Common/PbHelper")
local FightDefine = {
  ACTOR_NUM = 6,
  HALF_ACTOR_NUM = 3,
  TEAM1 = 1,
  TEAM2 = 2,
  FIX_HP = 1,
  CARD_NUM_MAIN = 2,
  CARD_NUM_ASSIST = 1,
  SPEED_RANDOM = 1,
  BuffFightType = {
    [PB.enum.BuffFightType.SpecialAttrChange] = {
      "inDuration",
      "autoDisappear",
      "shieldBroked"
    },
    [PB.enum.BuffFightType.AttrTransAbHurt] = {
      "attack",
      "target",
      [999] = "CurrentHpDef"
    }
  },
  WeaponUseCountLimit = 2,
  UseCountSprite = {
    "Impression/spot_1",
    "Impression/spot_2"
  },
  AllInOne = {
    {
      1,
      4,
      7
    },
    {
      2,
      5,
      8
    },
    {
      3,
      6,
      9
    }
  },
  WeaponTalentFlagThreshold = 999,
  TalentFlagDEF = {
    Common = 1,
    IgnoreShowId = 9,
    Weapon = 11,
    Actor = 12,
    Link = 13
  },
  CardFlag = {
    Normal = 0,
    S = 1,
    Link = 2,
    Weapon = 4
  },
  infiniteSkill = 0,
  maxSp = 20,
  maxMp = 10,
  initSp = 0,
  initMp = 0,
  time = 30,
  changeRate = 1,
  addSp = 0,
  addMp = 1,
  roundSp = 0,
  roundMp = 0,
  PreDefinedCommand = {
    SkipCommand = 999,
    WeaponCommandBase = 5000,
    WeaponCommandLimit = 5210
  },
  HUDTemplates = {
    [PB.enum.HudTextType.PhysicsHPDamage] = "HUDPhysicsHPDamage",
    [PB.enum.HudTextType.MagicHPDamage] = "HUDMagicHPDamage",
    [PB.enum.HudTextType.HPRecover] = "HUDHPRecover",
    [PB.enum.HudTextType.Energy] = "HUDEnergy"
  },
  HEXColor = {
    [PB.enum.BuffFightType.SpToMp] = 1559034367,
    [PB.enum.BuffFightType.MpOnceChange] = 1559034367,
    [PB.enum.BuffFightType.SpOnceChange] = 4294926591
  }
}

function FightDefine.WeaponCommand(isCommandNum, ...)
  local params = {
    ...
  }
  if isCommandNum then
    local commandNum = params[1]
    if commandNum and commandNum >= FightDefine.PreDefinedCommand.WeaponCommandBase and commandNum < FightDefine.PreDefinedCommand.WeaponCommandLimit then
      local uniqueId = commandNum - FightDefine.PreDefinedCommand.WeaponCommandBase
      return uniqueId
    else
      error("WeaponCommand", "parameters is not valid!")
      return 0
    end
  else
    local team = params[1]
    local seat = params[2]
    local uniqueId = FightDefine.GenRoundActorInfoUniqueId(team, seat)
    return FightDefine.PreDefinedCommand.WeaponCommandBase + uniqueId
  end
end

function FightDefine.IsWeapon(roundActorInfo)
  return roundActorInfo and roundActorInfo.baseSeat > FightDefine.ACTOR_NUM and roundActorInfo.baseSeat <= FightDefine.ACTOR_NUM + 3
end

function FightDefine.GenRoundCardInfoIndex(team, seat, flag, indexOfAllCards)
  return team * 10000 + seat * 1000 + flag * 100 + indexOfAllCards
end

function FightDefine.RoundCardInfoIndex(index)
  local indexOfAllCards = index % 100
  local flag = index // 100 % 10
  local seat = index // 1000 % 10
  local team = index // 10000
  return team, seat, flag, indexOfAllCards
end

function FightDefine.GenRoundActorInfoUniqueId(team, seat)
  return team * 100 + seat
end

function FightDefine.RoundActorInfoUniqueId(uniqueId)
  local seat = uniqueId % 100
  local team = uniqueId // 100
  return team, seat
end

function FightDefine.GenWeaponTalentFlag(weaponId, position, phase)
  return phase * 100000 + position * 10000 + weaponId
end

function FightDefine.WeaponTalentFlag(talentFlag)
  local weaponId = talentFlag % 10000
  local phase = talentFlag // 100000
  local position = talentFlag % 100000 // 10000
  return weaponId, position, phase
end

function FightDefine.GetDefineParams(dungeonId)
  local result = {}
  table.copy(FightDefine, result)
  local dungeonMonster = PB.get("DungeonMonster", dungeonId)
  if dungeonMonster ~= nil then
    local index = dungeonMonster.modeIndex
    local dungeonModeIndex = PB.get("DungeonModeIndex", fif(index == 0, 1, index))
    if dungeonModeIndex ~= nil then
      table.merge(result, dungeonModeIndex)
    end
  end
  return result
end

return FightDefine
