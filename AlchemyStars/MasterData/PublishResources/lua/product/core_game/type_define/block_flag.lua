local BlockFlag = {
  None = 0,
  LinkLine = 2,
  MonsterLand = 4,
  MonsterFly = 8,
  DropItem = 16,
  SkillSkip = 32,
  Skill = 64,
  HitBack = 128,
  SummonTrap = 256,
  ChangeElement = 1024,
  Transport = 2048,
  FallGrid = 4096,
  MoveBoard = 8192,
  HitBackFly = 16384
}
_enum("BlockFlag", BlockFlag)

function GetBlockFlagByValue(value)
  if not value or value == 0 then
    return BlockFlag.None
  end
  return 1 << value
end
