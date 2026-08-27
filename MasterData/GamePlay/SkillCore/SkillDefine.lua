eSkillTriggerType = {
  AfterBattleStart = 1,
  SetHurt = 2,
  SetDeadHurt = 3,
  AfterHurt = 4,
  SetHeal = 5,
  AfterHeal = 6,
  BeforeAddBuff = 7,
  AfterAddBuff = 8,
  BeforeBuffDispel = 9,
  BuffDie = 10,
  AfterBuffRemove = 11,
  AfterBuffAddHitMaxTier = 12,
  RoleDie = 13,
  BeforePlaySkill = 14,
  AfterPlaySkill = 15,
  BeforeTargetSelect = 16,
  HurtResultStart = 17,
  HurtResultEnd = 18,
  HealResultStart = 19,
  HealResultEnd = 20,
  OnBreakSkill = 21,
  BeforeBattleEnd = 22,
  OnBattleEnd = 23,
  OnBreakShield = 24,
  OnAfterShieldHurt = 25,
  OnPlayerMpCostToTargetValue = 26,
  AfterSelfUltEffectEnd = 27,
  AfterSelfUltInTimeLineEnd = 28,
  AfterSelfUltOutTimeLineEnd = 29,
  AfterSelfUltSpecTimeLineEnd = 30,
  AfterSelfUltMovieEnd = 31,
  OnSelfUltMovieFadeOut = 32,
  StartSelfUltRoleAction = 33,
  OnSelfAttrChanged = 34,
  OnSelfAfterMove = 35,
  OnSelfStartMove = 42,
  OnGridCreatedInBattle = 36,
  OnCallNextWaveTowerMonster = 37,
  OnAfterDeployTower = 38,
  OnAfterLoadOffTower = 39,
  OnAfterResurrectionCharacter = 40,
  OnBtRoleBreakStateEnter = 41,
  BeforeJudgeAndAddBuff = 42
}
eTriggerSkillType = {
  None = 0,
  GridSkill = 1,
  RoleSkill = 2
}
eSkillLuaTrigger = {
  OnDoodad = 1,
  OnChipSuitInvoke = 2,
  OnRoleSplash = 3,
  OnWaveCollision = 4,
  CallWave = 5,
  OnRealSummonerCaster = 6,
  OnTDTakeGrid = 7,
  OnCommonAttackTrigger = 8,
  OnSummonerDieForDemiurge = 9,
  OnNascitaAttack = 10,
  OnUltSkillPlayed = 11,
  PuzzleSummonerTimerAcc = 12,
  OnSixAttack = 13,
  OnStateWake = 14,
  OnStateSleep = 15,
  OnCrypterAttack = 16,
  OnMonsterStageCreat = 17,
  OnDamageEnd = 18,
  OnOdetteHalfHp = 20,
  FernSkill = 21,
  FernDragonHurt = 22,
  DupinAttack = 23,
  OnTuringSkill = 24,
  OnJiangyuSkill = 25,
  OnPlayYelenaSkill = 26,
  OnHorizonCauseBacklash = 27,
  OnLindHurt = 28,
  OnFortitudeSkill = 29,
  OnAnnaStun = 30,
  OnErikaAttackEx = 31,
  OnChelseaStun = 32,
  OnCallBuff = 33,
  OnSkillInit = 34,
  CallHurtPool = 35,
  Callthrows = 36,
  PickUpCoins = 37,
  OnAddShield = 38,
  OnPlaylunaExSkill = 39,
  OnBrotatoMonsterDie = 40,
  OnPlayArmorChange = 41,
  OnAddMoneyInBattle = 42,
  OnSacrifice = 43,
  OnAddEfcGrid = 44,
  OnRolePhaseMoveStart = 45,
  DupinExDam = 46,
  OnRevengeCall = 47,
  OnRebattleStart = 48,
  OnPlayChang = 49,
  OnRecoverHeal = 50,
  OnMayuriUlt = 51,
  OnKurisuSummonerSkill = 52,
  OnKurisuSummonerHurt = 53,
  OncentaureissispHit = 55,
  OnDetonatorCastSkill = 56,
  OnPuzzleNewSummoner = 57,
  OnShaleBuffAdd = 58,
  OnQiuCollected = 59,
  OnSangomaSummonerDead = 60,
  OnBelladonnaAddBuff = 61,
  OnBeforeAddShield = 62,
  OnBeforeCallSummoner = 63,
  OnXinghuanAddZhuRan = 64,
  OnEosPassive01 = 65,
  OnCreatGiantHitGrid = 66,
  OnDestoryGiantHitGrid = 67,
  StoryEvent = 54
}
eBattleEffectEvent = {
  Create = 0,
  Trigger = 1,
  Arrive = 2,
  Die = 3
}
eBuffFeatureType = {
  NotMove = 1,
  Invinciable = 2,
  Silent = 3,
  Bewitch = 4,
  NotBeSelected = 5,
  NoDeath = 6,
  Stun = 7,
  Taunt = 8,
  CustomRepeated = 9,
  StopSkillCD = 10,
  StopCommonAttackCD = 11,
  KnockOff = 12,
  BeatBack = 13,
  Bleed = 14,
  CtrlImmunity = 15,
  Exiled = 16,
  AbadonDebuff = 17,
  HealRepeated = 18,
  AttackRealDmg = 19,
  DoubleAttack = 20,
  SplitShoot = 21,
  NotBeSelectedExceptSameBlong = 22,
  FocusOnFiring = 23,
  Rotate = 24,
  AbandonMove = 25,
  AbandonUltSkill = 26,
  DisActiveCollider = 27,
  NotBeSelectedExceptRemote = 28,
  NotBeSelectedSameBlong = 29,
  ChiYan = 30,
  DisableAction = 31,
  Blind = 32
}
eBattleRoleBelong = {
  neutral = 0,
  player = 1,
  enemy = 2
}
eMonsterCamp = {ePurger = 1, eEntropy = 2}
eBattleRoleType = {
  character = 1,
  skillCaster = 2,
  hideSummoner = 3,
  realSummoner = 4,
  DungeonRole = 5
}
eBuffRemoveType = {
  Timeout = 1,
  Dispel = 2,
  Conflict = 3
}
eBuffLifeEvent = {
  NewAdd = 1,
  OverlayAdd = 2,
  Overlay = 3,
  Remove = 4
}
eBuffType = {Beneficial = 1, Debeneficial = 2}
eHeroAttrType = {
  Origin = 1,
  Base = 2,
  Ratio = 3,
  Extra = 4
}
eHeroAttr = {
  hp = 1,
  maxHp = 2,
  pow = 3,
  def = 4,
  speed = 5,
  hit = 6,
  dodge = 7,
  moveSpeed = 8,
  crit = 9,
  critDamage = 10,
  lucky = 11,
  sunder = 12,
  true_damage = 13,
  resistance = 14,
  battleEnd_hp_regen = 15,
  attackRange = 16,
  life_steal = 17,
  spell_life_steal = 18,
  damage_increase = 19,
  injury_reduce = 20,
  heal = 21,
  treatment = 22,
  cd_reduce = 23,
  return_damage = 24,
  hp_regen = 25,
  skill_intensity = 26,
  magic_res = 27,
  magic_pen = 28,
  max_property_count = 28
}
eRawAttr = {RawAttributionIDNone = 0, RawAttributionIdEnergyReturn = 1}
eHeroAttrPercent = 1000
eColliderInfluenceType = {
  None = 0,
  Enemy = 2,
  Player = 4,
  Neutral = 8,
  Skill = 16,
  All = 32
}
eBelongReletionType = {
  None = 0,
  Enemy = 2,
  Player = 4,
  Neutral = 8
}
eBelongReletionSetting = {
  [eBattleRoleBelong.neutral] = {
    [0] = eBelongReletionType.Player,
    [1] = eBelongReletionType.Neutral,
    [2] = eBelongReletionType.Neutral
  },
  [eBattleRoleBelong.player] = {
    [0] = eBelongReletionType.Neutral,
    [1] = eBelongReletionType.Player,
    [2] = eBelongReletionType.Enemy
  },
  [eBattleRoleBelong.enemy] = {
    [0] = eBelongReletionType.Neutral,
    [1] = eBelongReletionType.Enemy,
    [2] = eBelongReletionType.Player
  }
}
eBelongNumRelation = {
  [eBattleRoleBelong.neutral] = {
    [eBattleRoleBelong.enemy] = eBattleRoleBelong.enemy,
    [eBattleRoleBelong.player] = eBattleRoleBelong.neutral
  },
  [eBattleRoleBelong.player] = {
    [eBattleRoleBelong.enemy] = eBattleRoleBelong.enemy,
    [eBattleRoleBelong.player] = eBattleRoleBelong.player
  },
  [eBattleRoleBelong.enemy] = {
    [eBattleRoleBelong.enemy] = eBattleRoleBelong.player,
    [eBattleRoleBelong.player] = eBattleRoleBelong.enemy
  }
}
eCamShakeLevel = {
  None = 0,
  Light = 1,
  Strong = 2
}
generalHurtConfig = {
  hit_formula = 9991,
  def_formula = 9996,
  basehurt_formula = 9993,
  minhurt_formula = 9994,
  crit_formula = 9992,
  crithur_ratio = 9995,
  correct_formula = 9989,
  lifesteal_formula = 1001,
  spell_lifesteal_formula = 1002,
  returndamage_formula = 1000,
  hurt_type = -1
}
metaGeneralHurtConfig = {
  __index = generalHurtConfig
}
generalHealConfig = {
  baseheal_formula = 0,
  heal_number = 0,
  crit_formula = 0,
  crithur_ratio = 0,
  correct_formula = 9990
}
realDamageConfig = {
  hit_formula = 0,
  def_formula = 0,
  basehurt_formula = 9993,
  minhurt_formula = 9994,
  crit_formula = 0,
  crithur_ratio = 0,
  correct_formula = 9989,
  lifesteal_formula = 1001,
  spell_lifesteal_formula = 1002,
  returndamage_formula = 1000,
  hurt_type = 2
}
metaRealDamageConfig = {
  __index = realDamageConfig
}
eSkillCv = {UltSkill = 107}
eShieldType = {
  Normal = 0,
  LongRange = 1,
  NoRange = 2,
  Beelneith = 3,
  MaxShieldCount = 4
}
eHitAuRecordHint = "hit_target_type"
eHitAuRoleType = {
  None = 0,
  Body = 1,
  Heavy = 2,
  Shield = 3
}
eEffectGridType = {
  None = 0,
  positive = 1,
  negative = 2
}
eSkillTag = {
  commonAttack = 0,
  normalSkill = 1,
  passiveSkill = 2,
  ultSkill = 3
}
eHurtType = {
  None = -1,
  PhysicsDmg = 0,
  MagicDmg = 1,
  RealDmg = 2
}
eHurtTag = {
  chiyan = 1,
  kurisu_benti = 2,
  kurisu_fenshe = 3
}
eBattleSkillLogicType = {
  Original = 0,
  Chip = 1,
  BattleBuff = 2,
  TempChip = 3,
  AthSuit = 4,
  ChipConsume = 5,
  ExtraAdd = 6,
  Lable = 7,
  Fiary = 8
}
eBattleSkillLogicFreshRemove = {
  [eBattleSkillLogicType.AthSuit] = true,
  [eBattleSkillLogicType.ExtraAdd] = true
}
eSkillResultShapeType = {
  Target = 0,
  AllRole = 1,
  Block = 2,
  CellDist = 3
}
eWaveType = {normalWave = 0, entropyWave = 1}
HexagonNeighbor = {
  [0] = {
    {x = 1, y = 0},
    {x = 0, y = -1},
    {x = -1, y = -1},
    {x = -1, y = 0},
    {x = -1, y = 1},
    {x = 0, y = 1}
  },
  [1] = {
    {x = 1, y = 0},
    {x = 1, y = -1},
    {x = 0, y = -1},
    {x = -1, y = 0},
    {x = 0, y = 1},
    {x = 1, y = 1}
  }
}
CoordNeighbor = {
  [0] = {
    [131073] = 0,
    [65536] = 1,
    [0] = 2,
    [1] = 3,
    [2] = 4,
    [65538] = 5
  },
  [1] = {
    [131073] = 0,
    [131072] = 1,
    [65536] = 2,
    [1] = 3,
    [65538] = 4,
    [131074] = 5
  }
}
SelectRolesType = {
  SingleRole = 1,
  CsBattleRoleList = 2,
  CsBattleTargetList = 3,
  LuaRoleArray = 4
}
eBuffDurationType = {
  None = 0,
  LogicTime = 1,
  WholeBattle = 2
}
eScoreType = {cacheGoldNum = 3, notPickupGoldNum = 4}
