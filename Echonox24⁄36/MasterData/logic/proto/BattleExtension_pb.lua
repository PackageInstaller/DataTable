-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/BattleExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

dependencies.AchievementExtension = require("logic.proto.AchievementExtension_pb")

module("logic.proto.BattleExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.GameType = protobuf.EnumDescriptor()
enum_item_descriptors.GameType_DEFAULT = protobuf.EnumValueDescriptor()
enum_item_descriptors.GameType_FOOTBALLPVP = protobuf.EnumValueDescriptor()
type_descriptors.Relation = protobuf.EnumDescriptor()
enum_item_descriptors.Relation_ENEMY = protobuf.EnumValueDescriptor()
enum_item_descriptors.Relation_FRIEND = protobuf.EnumValueDescriptor()
enum_item_descriptors.Relation_NEUTRAL = protobuf.EnumValueDescriptor()
type_descriptors.Attribute = protobuf.EnumDescriptor()
enum_item_descriptors.Attribute_MOVE = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_MAX_HP = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_ATK_PHY = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_DEF_PHY = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_ATK_MAG = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_DEF_MAG = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_INSPIRATION = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_DAMAGE_ENHANCE = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_DAMAGE_REDUCE = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_CRIT_ENHANCE = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_CRIT_REDUCE = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_RESTRAIN_ENHANCE = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_RESTRAIN_REDUCE = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_CURE = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_BE_CURED = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_SUCK = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_SAN_GROW = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_SAN_BACK = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_IGNORE_PHY = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_IGNORE_MAG = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_CURRENT_HP = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_CURRENT_SAN = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_CURRENT_HP_RATE = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_LOST_HP_RATE = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_FIGHTING_CAPACITY = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_WEAK_POINT_DAMAGE = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_SKILL_CD_OFFSET = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_EXTRA = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_MOONRING = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_CHASE = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_BOMB = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_BORESPINE = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_ARCLIGHT = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_BLADE_EDGE_MIN_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_BLADE_EDGE_MAX_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_AGILE_MIN_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_AGILE_MAX_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_DEFENSE_MIN_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_DEFENSE_MAX_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_DECLINE_MIN_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_DECLINE_MAX_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_WEAK_MIN_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_WEAK_MAX_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_EROSION_MIN_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_EROSION_MAX_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_ROAR_MIN_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_ROAR_MAX_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_MAD_MIN_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_MAD_MAX_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_PENETRATE_MIN_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_PENETRATE_MAX_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_SNIPE = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_PIERCED_TIMES = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_NORMAL_SKILL_CD_OFFSET = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_SPECIAL_SKILL_CD_OFFSET = protobuf.EnumValueDescriptor()
enum_item_descriptors.Attribute_TRUMP_SKILL_CD_OFFSET = protobuf.EnumValueDescriptor()
type_descriptors.AttributePart = protobuf.EnumDescriptor()
enum_item_descriptors.AttributePart_PART_CURRENT_SAN = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_MOVE = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_CURRENT_HP = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_INSPIRATION = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_DAMAGE_REDUCE = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_CRIT_ENHANCE = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_CRIT_REDUCE = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_RESTRAIN_ENHANCE = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_RESTRAIN_REDUCE = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_CURE = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_BE_CURED = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_SUCK = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_SAN_GROW = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_SAN_BACK = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_IGNORE_PHY = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_IGNORE_MAG = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_MAX_HP_BASE = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_MAX_HP_MULTIPLICATION = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_MAX_HP_ADDITION = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_ATK_PHY_BASE = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_ATK_PHY_MULTIPLICATION = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_ATK_PHY_ADDITION = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_DEF_PHY_BASE = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_DEF_PHY_MULTIPLICATION = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_DEF_PHY_ADDITION = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_ATK_MAG_BASE = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_ATK_MAG_MULTIPLICATION = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_ATK_MAG_ADDITION = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_DEF_MAG_BASE = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_DEF_MAG_MULTIPLICATION = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_DEF_MAG_ADDITION = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_WEAK_POINT_DAMAGE = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_SKILL_CD_OFFSET = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_EXTRA = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_MOONRING = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_CHASE = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_BOMB = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_BORESPINE = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_ARCLIGHT = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_BLADE_EDGE_MIN_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_BLADE_EDGE_MAX_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_AGILE_MIN_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_AGILE_MAX_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_DEFENSE_MIN_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_DEFENSE_MAX_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_DECLINE_MIN_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_DECLINE_MAX_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_WEAK_MIN_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_WEAK_MAX_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_EROSION_MIN_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_EROSION_MAX_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_ROAR_MIN_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_ROAR_MAX_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_MAD_MIN_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_MAD_MAX_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_PENETRATE_MIN_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_PENETRATE_MAX_LAYER = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_SNIPE = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_PIERCED_TIMES = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_NORMAL_SKILL_CD_OFFSET = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_SPECIAL_SKILL_CD_OFFSET = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttributePart_PART_TRUMP_SKILL_CD_OFFSET = protobuf.EnumValueDescriptor()
type_descriptors.DeadReason = protobuf.EnumDescriptor()
enum_item_descriptors.DeadReason_HP_0_BY_ATTACK = protobuf.EnumValueDescriptor()
enum_item_descriptors.DeadReason_HP_0_BY_BUFF = protobuf.EnumValueDescriptor()
enum_item_descriptors.DeadReason_SANITY_LOW = protobuf.EnumValueDescriptor()
enum_item_descriptors.DeadReason_HP_0_BY_SKILL = protobuf.EnumValueDescriptor()
type_descriptors.State = protobuf.EnumDescriptor()
enum_item_descriptors.State_CANNOT_NORMAL_ATTACK = protobuf.EnumValueDescriptor()
enum_item_descriptors.State_CANNOT_MOVE = protobuf.EnumValueDescriptor()
enum_item_descriptors.State_IGNORE_DISTANCE_WHEN_COUNTER = protobuf.EnumValueDescriptor()
enum_item_descriptors.State_COUNTER_BEFORE_ATTACK = protobuf.EnumValueDescriptor()
enum_item_descriptors.State_CHASE = protobuf.EnumValueDescriptor()
enum_item_descriptors.State_DEFENDER_CANNOT_COUNTER = protobuf.EnumValueDescriptor()
enum_item_descriptors.State_IGNORE_NEAR = protobuf.EnumValueDescriptor()
enum_item_descriptors.State_NEXT_SKILL_ENHANCED = protobuf.EnumValueDescriptor()
enum_item_descriptors.State_STEPPABLE_AGAIN = protobuf.EnumValueDescriptor()
enum_item_descriptors.State_SNIPING = protobuf.EnumValueDescriptor()
enum_item_descriptors.State_ALWAYS_CRITICAL = protobuf.EnumValueDescriptor()
enum_item_descriptors.State_DOUBLE_ATTACK = protobuf.EnumValueDescriptor()
enum_item_descriptors.State_SILENT = protobuf.EnumValueDescriptor()
enum_item_descriptors.State_DAMAGING_ONE_HP = protobuf.EnumValueDescriptor()
enum_item_descriptors.State_CANNOT_INCR_HP = protobuf.EnumValueDescriptor()
enum_item_descriptors.State_INVINCIBLE = protobuf.EnumValueDescriptor()
enum_item_descriptors.State_PHYSICAL_DAMAGING_ONE_HP = protobuf.EnumValueDescriptor()
enum_item_descriptors.State_MAGICAL_DAMAGING_ONE_HP = protobuf.EnumValueDescriptor()
enum_item_descriptors.State_CANNOT_COUNTER = protobuf.EnumValueDescriptor()
enum_item_descriptors.State_CANNOT_CHANGE_POSITION = protobuf.EnumValueDescriptor()
enum_item_descriptors.State_PIERCEABLE = protobuf.EnumValueDescriptor()
enum_item_descriptors.State_CHANGE_CAMP_WHEN_OVERDRAWN = protobuf.EnumValueDescriptor()
enum_item_descriptors.State_IGNORE_BARRIER = protobuf.EnumValueDescriptor()
type_descriptors.MonsterType = protobuf.EnumDescriptor()
enum_item_descriptors.MonsterType_MONSTER_TYPE_NORMAL = protobuf.EnumValueDescriptor()
enum_item_descriptors.MonsterType_MONSTER_TYPE_ELITE = protobuf.EnumValueDescriptor()
enum_item_descriptors.MonsterType_MONSTER_TYPE_BOSS = protobuf.EnumValueDescriptor()
type_descriptors.SkillType = protobuf.EnumDescriptor()
enum_item_descriptors.SkillType_SKILL_TYPE_NORMAL = protobuf.EnumValueDescriptor()
enum_item_descriptors.SkillType_SKILL_TYPE_SPECIAL = protobuf.EnumValueDescriptor()
enum_item_descriptors.SkillType_SKILL_TYPE_TRUMP = protobuf.EnumValueDescriptor()
enum_item_descriptors.SkillType_SKILL_TYPE_TALENT = protobuf.EnumValueDescriptor()
enum_item_descriptors.SkillType_SKILL_TYPE_ECHO = protobuf.EnumValueDescriptor()
enum_item_descriptors.SkillType_SKILL_TYPE_DEPUTY = protobuf.EnumValueDescriptor()
enum_item_descriptors.SkillType_SKILL_TYPE_EQUIPMENT = protobuf.EnumValueDescriptor()
enum_item_descriptors.SkillType_SKILL_TYPE_EXTRA = protobuf.EnumValueDescriptor()
enum_item_descriptors.SkillType_SKILL_TYPE_GLOBAL = protobuf.EnumValueDescriptor()
enum_item_descriptors.SkillType_SKILL_TYPE_PASSIVE = protobuf.EnumValueDescriptor()
type_descriptors.AttackingDirection = protobuf.EnumDescriptor()
enum_item_descriptors.AttackingDirection_ATTACKING_DIRECTION_ATTACK = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttackingDirection_ATTACKING_DIRECTION_COUNTER = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttackingDirection_ATTACKING_DIRECTION_CHASE = protobuf.EnumValueDescriptor()
enum_item_descriptors.AttackingDirection_ATTACKING_DIRECTION_DOUBLE = protobuf.EnumValueDescriptor()
type_descriptors.PositionChangingMethod = protobuf.EnumDescriptor()
enum_item_descriptors.PositionChangingMethod_POSITION_CHANGING_METHOD_SUDDEN = protobuf.EnumValueDescriptor()
enum_item_descriptors.PositionChangingMethod_POSITION_CHANGING_METHOD_SMOOTH = protobuf.EnumValueDescriptor()
type_descriptors.SkillSourceType = protobuf.EnumDescriptor()
enum_item_descriptors.SkillSourceType_ADDITIONAL_TERRAIN = protobuf.EnumValueDescriptor()
enum_item_descriptors.SkillSourceType_ENTITY = protobuf.EnumValueDescriptor()
enum_item_descriptors.SkillSourceType_BUFF = protobuf.EnumValueDescriptor()
enum_item_descriptors.SkillSourceType_OTHER = protobuf.EnumValueDescriptor()
type_descriptors.EndType = protobuf.EnumDescriptor()
enum_item_descriptors.EndType_VICTORY = protobuf.EnumValueDescriptor()
enum_item_descriptors.EndType_DEFEAT = protobuf.EnumValueDescriptor()
enum_item_descriptors.EndType_RESTART = protobuf.EnumValueDescriptor()
enum_item_descriptors.EndType_SURRENDER = protobuf.EnumValueDescriptor()
type_descriptors.EntityType = protobuf.EnumDescriptor()
enum_item_descriptors.EntityType_ENTITY_HERO = protobuf.EnumValueDescriptor()
enum_item_descriptors.EntityType_ENTITY_MONSTER = protobuf.EnumValueDescriptor()
enum_item_descriptors.EntityType_ENTITY_HALO_TERRAIN = protobuf.EnumValueDescriptor()
enum_item_descriptors.EntityType_ENTITY_SYSTEM_NPC = protobuf.EnumValueDescriptor()
enum_item_descriptors.EntityType_ENTITY_INTANGIBLE = protobuf.EnumValueDescriptor()
enum_item_descriptors.EntityType_ENTITY_SUMMON = protobuf.EnumValueDescriptor()
type_descriptors.RemoveReason = protobuf.EnumDescriptor()
enum_item_descriptors.RemoveReason_REASON_RETREAT = protobuf.EnumValueDescriptor()
enum_item_descriptors.RemoveReason_REASON_OTHER = protobuf.EnumValueDescriptor()
type_descriptors.TagEnhanceCmd = protobuf.EnumDescriptor()
enum_item_descriptors.TagEnhanceCmd_REPLACE = protobuf.EnumValueDescriptor()
enum_item_descriptors.TagEnhanceCmd_ADD = protobuf.EnumValueDescriptor()
enum_item_descriptors.TagEnhanceCmd_MUL = protobuf.EnumValueDescriptor()
type_descriptors.BattleType = protobuf.EnumDescriptor()
enum_item_descriptors.BattleType_DUNGEON = protobuf.EnumValueDescriptor()
enum_item_descriptors.BattleType_GM_CUSTOMIZE = protobuf.EnumValueDescriptor()
enum_item_descriptors.BattleType_GM_LEVEL = protobuf.EnumValueDescriptor()
enum_item_descriptors.BattleType_RODEO_AIR = protobuf.EnumValueDescriptor()
enum_item_descriptors.BattleType_TEST_AIR = protobuf.EnumValueDescriptor()
enum_item_descriptors.BattleType_PVP = protobuf.EnumValueDescriptor()
enum_item_descriptors.BattleType_FREE_AIR = protobuf.EnumValueDescriptor()
enum_item_descriptors.BattleType_ENDLESS_AIR = protobuf.EnumValueDescriptor()
type_descriptors.PlayerChangeReason = protobuf.EnumDescriptor()
enum_item_descriptors.PlayerChangeReason_OVERDRAWN_SANITY = protobuf.EnumValueDescriptor()
enum_item_descriptors.PlayerChangeReason_PLOT = protobuf.EnumValueDescriptor()
type_descriptors.AiMode = protobuf.EnumDescriptor()
enum_item_descriptors.AiMode_NONE = protobuf.EnumValueDescriptor()
enum_item_descriptors.AiMode_BEHAVIOR_TREE = protobuf.EnumValueDescriptor()
enum_item_descriptors.AiMode_USER_RECORD = protobuf.EnumValueDescriptor()
type_descriptors.Gameplay = protobuf.EnumDescriptor()
enum_item_descriptors.Gameplay_GAME_NORMAL = protobuf.EnumValueDescriptor()
enum_item_descriptors.Gameplay_GAME_RECORD = protobuf.EnumValueDescriptor()
enum_item_descriptors.Gameplay_GAME_CONSECUTIVE = protobuf.EnumValueDescriptor()
type_descriptors.BattleEndedEventNO = protobuf.Descriptor()
field_descriptors.BattleEndedEventNO_winner = protobuf.FieldDescriptor()
field_descriptors.BattleEndedEventNO_loser = protobuf.FieldDescriptor()
field_descriptors.BattleEndedEventNO_realEnd = protobuf.FieldDescriptor()
type_descriptors.StageNO = protobuf.Descriptor()
field_descriptors.StageNO_players = protobuf.FieldDescriptor()
type_descriptors.AnimationPostedPush = protobuf.Descriptor()
type_descriptors.MultiRoundAoeUpdateNO = protobuf.Descriptor()
field_descriptors.MultiRoundAoeUpdateNO_aoe = protobuf.FieldDescriptor()
type_descriptors.ForecastReply = protobuf.Descriptor()
type_descriptors.EffectNO = protobuf.Descriptor()
field_descriptors.EffectNO_timelineRes = protobuf.FieldDescriptor()
field_descriptors.EffectNO_events = protobuf.FieldDescriptor()
type_descriptors.PlotTriggered3D = protobuf.Descriptor()
field_descriptors.PlotTriggered3D_plot = protobuf.FieldDescriptor()
field_descriptors.PlotTriggered3D_events = protobuf.FieldDescriptor()
type_descriptors.AiModeChangeNO = protobuf.Descriptor()
field_descriptors.AiModeChangeNO_aiMode = protobuf.FieldDescriptor()
type_descriptors.ConnectRequest = protobuf.Descriptor()
type_descriptors.ShapeTagNO = protobuf.Descriptor()
field_descriptors.ShapeTagNO_shape = protobuf.FieldDescriptor()
type_descriptors.WholeBattleBoardNO = protobuf.Descriptor()
type_descriptors.LogBattleLogPush = protobuf.Descriptor()
field_descriptors.LogBattleLogPush_log = protobuf.FieldDescriptor()
type_descriptors.ConnectStateChangePush = protobuf.Descriptor()
field_descriptors.ConnectStateChangePush_state = protobuf.FieldDescriptor()
type_descriptors.MessageCompositeNO = protobuf.Descriptor()
field_descriptors.MessageCompositeNO_textPart = protobuf.FieldDescriptor()
field_descriptors.MessageCompositeNO_voice = protobuf.FieldDescriptor()
field_descriptors.MessageCompositeNO_emoji = protobuf.FieldDescriptor()
type_descriptors.MessagePartNO = protobuf.Descriptor()
field_descriptors.MessagePartNO_type = protobuf.FieldDescriptor()
field_descriptors.MessagePartNO_id = protobuf.FieldDescriptor()
type_descriptors.WinConditionNO = protobuf.Descriptor()
field_descriptors.WinConditionNO_id = protobuf.FieldDescriptor()
field_descriptors.WinConditionNO_params = protobuf.FieldDescriptor()
type_descriptors.ForecastTagNO = protobuf.Descriptor()
field_descriptors.ForecastTagNO_entity = protobuf.FieldDescriptor()
field_descriptors.ForecastTagNO_tag = protobuf.FieldDescriptor()
field_descriptors.ForecastTagNO_count = protobuf.FieldDescriptor()
type_descriptors.ModelChangedNO = protobuf.Descriptor()
field_descriptors.ModelChangedNO_entity = protobuf.FieldDescriptor()
field_descriptors.ModelChangedNO_modelId = protobuf.FieldDescriptor()
field_descriptors.ModelChangedNO_action = protobuf.FieldDescriptor()
type_descriptors.UnfinishedBattleExpiredPush = protobuf.Descriptor()
type_descriptors.ForecastAiNO = protobuf.Descriptor()
field_descriptors.ForecastAiNO_entity = protobuf.FieldDescriptor()
field_descriptors.ForecastAiNO_target = protobuf.FieldDescriptor()
type_descriptors.BuffTriggeredEventNO = protobuf.Descriptor()
field_descriptors.BuffTriggeredEventNO_entity = protobuf.FieldDescriptor()
field_descriptors.BuffTriggeredEventNO_code = protobuf.FieldDescriptor()
field_descriptors.BuffTriggeredEventNO_effects = protobuf.FieldDescriptor()
type_descriptors.EntityHoldNO = protobuf.Descriptor()
field_descriptors.EntityHoldNO_entity = protobuf.FieldDescriptor()
field_descriptors.EntityHoldNO_effectTimeline = protobuf.FieldDescriptor()
type_descriptors.MultiEntityHoldNO = protobuf.Descriptor()
field_descriptors.MultiEntityHoldNO_entities = protobuf.FieldDescriptor()
type_descriptors.PlotChainTriggeredEventNO = protobuf.Descriptor()
field_descriptors.PlotChainTriggeredEventNO_groupCode = protobuf.FieldDescriptor()
field_descriptors.PlotChainTriggeredEventNO_chainCode = protobuf.FieldDescriptor()
field_descriptors.PlotChainTriggeredEventNO_events = protobuf.FieldDescriptor()
type_descriptors.WeakPointAddedEventNO = protobuf.Descriptor()
field_descriptors.WeakPointAddedEventNO_entity = protobuf.FieldDescriptor()
field_descriptors.WeakPointAddedEventNO_hp = protobuf.FieldDescriptor()
field_descriptors.WeakPointAddedEventNO_type = protobuf.FieldDescriptor()
type_descriptors.HaloRefreshedEventNO = protobuf.Descriptor()
field_descriptors.HaloRefreshedEventNO_linked = protobuf.FieldDescriptor()
field_descriptors.HaloRefreshedEventNO_unlinked = protobuf.FieldDescriptor()
type_descriptors.EntityDeadEventNO = protobuf.Descriptor()
field_descriptors.EntityDeadEventNO_entity = protobuf.FieldDescriptor()
field_descriptors.EntityDeadEventNO_reason = protobuf.FieldDescriptor()
type_descriptors.BackToReply = protobuf.Descriptor()
type_descriptors.ConnectCompleteReply = protobuf.Descriptor()
type_descriptors.PostEventAnimationRequest = protobuf.Descriptor()
type_descriptors.CenterShapeNO = protobuf.Descriptor()
field_descriptors.CenterShapeNO_center = protobuf.FieldDescriptor()
field_descriptors.CenterShapeNO_shape = protobuf.FieldDescriptor()
type_descriptors.TriggeringNO = protobuf.Descriptor()
field_descriptors.TriggeringNO_events = protobuf.FieldDescriptor()
type_descriptors.PostEventAnimationReply = protobuf.Descriptor()
type_descriptors.SkillSourceNO = protobuf.Descriptor()
field_descriptors.SkillSourceNO_type = protobuf.FieldDescriptor()
field_descriptors.SkillSourceNO_id = protobuf.FieldDescriptor()
type_descriptors.CircleNO = protobuf.Descriptor()
field_descriptors.CircleNO_radius = protobuf.FieldDescriptor()
type_descriptors.BattlefieldNO = protobuf.Descriptor()
field_descriptors.BattlefieldNO_id = protobuf.FieldDescriptor()
field_descriptors.BattlefieldNO_map = protobuf.FieldDescriptor()
field_descriptors.BattlefieldNO_myPlayerId = protobuf.FieldDescriptor()
field_descriptors.BattlefieldNO_entities = protobuf.FieldDescriptor()
field_descriptors.BattlefieldNO_stages = protobuf.FieldDescriptor()
field_descriptors.BattlefieldNO_cells = protobuf.FieldDescriptor()
field_descriptors.BattlefieldNO_haloLinks = protobuf.FieldDescriptor()
field_descriptors.BattlefieldNO_systemPlayer = protobuf.FieldDescriptor()
field_descriptors.BattlefieldNO_multiRoundAoes = protobuf.FieldDescriptor()
field_descriptors.BattlefieldNO_round = protobuf.FieldDescriptor()
field_descriptors.BattlefieldNO_battleExtra = protobuf.FieldDescriptor()
field_descriptors.BattlefieldNO_stepPlayer = protobuf.FieldDescriptor()
field_descriptors.BattlefieldNO_stepHistory = protobuf.FieldDescriptor()
field_descriptors.BattlefieldNO_leftBackCount = protobuf.FieldDescriptor()
field_descriptors.BattlefieldNO_aiMode = protobuf.FieldDescriptor()
field_descriptors.BattlefieldNO_heros = protobuf.FieldDescriptor()
type_descriptors.TagEnhanceAddNO = protobuf.Descriptor()
field_descriptors.TagEnhanceAddNO_entity = protobuf.FieldDescriptor()
field_descriptors.TagEnhanceAddNO_contexts = protobuf.FieldDescriptor()
type_descriptors.ShapeWithRootNO = protobuf.Descriptor()
field_descriptors.ShapeWithRootNO_root = protobuf.FieldDescriptor()
field_descriptors.ShapeWithRootNO_entity = protobuf.FieldDescriptor()
field_descriptors.ShapeWithRootNO_shape = protobuf.FieldDescriptor()
type_descriptors.HaloLinkedNO = protobuf.Descriptor()
field_descriptors.HaloLinkedNO_fromEntity = protobuf.FieldDescriptor()
field_descriptors.HaloLinkedNO_fromSkill = protobuf.FieldDescriptor()
field_descriptors.HaloLinkedNO_toEntity = protobuf.FieldDescriptor()
field_descriptors.HaloLinkedNO_effects = protobuf.FieldDescriptor()
type_descriptors.AttributeModifiedEventNO = protobuf.Descriptor()
field_descriptors.AttributeModifiedEventNO_entity = protobuf.FieldDescriptor()
field_descriptors.AttributeModifiedEventNO_attr = protobuf.FieldDescriptor()
field_descriptors.AttributeModifiedEventNO_value = protobuf.FieldDescriptor()
field_descriptors.AttributeModifiedEventNO_initial = protobuf.FieldDescriptor()
type_descriptors.ForecastAiRequest = protobuf.Descriptor()
type_descriptors.CellsBlockedEventNO = protobuf.Descriptor()
field_descriptors.CellsBlockedEventNO_cells = protobuf.FieldDescriptor()
field_descriptors.CellsBlockedEventNO_entity = protobuf.FieldDescriptor()
field_descriptors.CellsBlockedEventNO_skill = protobuf.FieldDescriptor()
type_descriptors.SetAiControlledReply = protobuf.Descriptor()
type_descriptors.PlotTriggered = protobuf.Descriptor()
field_descriptors.PlotTriggered_type = protobuf.FieldDescriptor()
field_descriptors.PlotTriggered_id = protobuf.FieldDescriptor()
type_descriptors.DeleteUnfinishedBattleRequest = protobuf.Descriptor()
type_descriptors.WeakPointRemovedEventNO = protobuf.Descriptor()
field_descriptors.WeakPointRemovedEventNO_entity = protobuf.FieldDescriptor()
type_descriptors.AdditionalTerrainNO = protobuf.Descriptor()
field_descriptors.AdditionalTerrainNO_code = protobuf.FieldDescriptor()
field_descriptors.AdditionalTerrainNO_round = protobuf.FieldDescriptor()
field_descriptors.AdditionalTerrainNO_triggered = protobuf.FieldDescriptor()
type_descriptors.NoteCellNO = protobuf.Descriptor()
field_descriptors.NoteCellNO_scale = protobuf.FieldDescriptor()
field_descriptors.NoteCellNO_specialEffectPath = protobuf.FieldDescriptor()
field_descriptors.NoteCellNO_cells = protobuf.FieldDescriptor()
type_descriptors.PlayerStatisticNO = protobuf.Descriptor()
field_descriptors.PlayerStatisticNO_totalDamageToEnemy = protobuf.FieldDescriptor()
field_descriptors.PlayerStatisticNO_totalEnemyKilled = protobuf.FieldDescriptor()
field_descriptors.PlayerStatisticNO_deadHeroes = protobuf.FieldDescriptor()
field_descriptors.PlayerStatisticNO_deadEnemies = protobuf.FieldDescriptor()
field_descriptors.PlayerStatisticNO_weakBroken = protobuf.FieldDescriptor()
field_descriptors.PlayerStatisticNO_exitHeroes = protobuf.FieldDescriptor()
field_descriptors.PlayerStatisticNO_exitEnemies = protobuf.FieldDescriptor()
type_descriptors.MovedEventNO = protobuf.Descriptor()
field_descriptors.MovedEventNO_entity = protobuf.FieldDescriptor()
field_descriptors.MovedEventNO_before = protobuf.FieldDescriptor()
field_descriptors.MovedEventNO_movement = protobuf.FieldDescriptor()
field_descriptors.MovedEventNO_after = protobuf.FieldDescriptor()
type_descriptors.RemoveEntityRequest = protobuf.Descriptor()
field_descriptors.RemoveEntityRequest_entity = protobuf.FieldDescriptor()
type_descriptors.PlayerNO = protobuf.Descriptor()
field_descriptors.PlayerNO_id = protobuf.FieldDescriptor()
field_descriptors.PlayerNO_playerStatistic = protobuf.FieldDescriptor()
type_descriptors.AttributePartNO = protobuf.Descriptor()
field_descriptors.AttributePartNO_attr = protobuf.FieldDescriptor()
field_descriptors.AttributePartNO_value = protobuf.FieldDescriptor()
type_descriptors.BackEventNO = protobuf.Descriptor()
field_descriptors.BackEventNO_info = protobuf.FieldDescriptor()
type_descriptors.PlaceEntityReply = protobuf.Descriptor()
type_descriptors.EntitySteppedEventNO = protobuf.Descriptor()
field_descriptors.EntitySteppedEventNO_entity = protobuf.FieldDescriptor()
field_descriptors.EntitySteppedEventNO_moved = protobuf.FieldDescriptor()
field_descriptors.EntitySteppedEventNO_releasingSkill = protobuf.FieldDescriptor()
field_descriptors.EntitySteppedEventNO_target = protobuf.FieldDescriptor()
field_descriptors.EntitySteppedEventNO_beforeMain = protobuf.FieldDescriptor()
field_descriptors.EntitySteppedEventNO_main = protobuf.FieldDescriptor()
field_descriptors.EntitySteppedEventNO_afterMain = protobuf.FieldDescriptor()
field_descriptors.EntitySteppedEventNO_round = protobuf.FieldDescriptor()
field_descriptors.EntitySteppedEventNO_skillCd = protobuf.FieldDescriptor()
field_descriptors.EntitySteppedEventNO_strengthening = protobuf.FieldDescriptor()
field_descriptors.EntitySteppedEventNO_turn = protobuf.FieldDescriptor()
type_descriptors.ConnectReply = protobuf.Descriptor()
field_descriptors.ConnectReply_info = protobuf.FieldDescriptor()
type_descriptors.PointNO = protobuf.Descriptor()
type_descriptors.MultiRoundAoeNO = protobuf.Descriptor()
field_descriptors.MultiRoundAoeNO_shape = protobuf.FieldDescriptor()
field_descriptors.MultiRoundAoeNO_entity = protobuf.FieldDescriptor()
field_descriptors.MultiRoundAoeNO_skill = protobuf.FieldDescriptor()
field_descriptors.MultiRoundAoeNO_id = protobuf.FieldDescriptor()
field_descriptors.MultiRoundAoeNO_targetEntity = protobuf.FieldDescriptor()
field_descriptors.MultiRoundAoeNO_targetCell = protobuf.FieldDescriptor()
field_descriptors.MultiRoundAoeNO_strengthening = protobuf.FieldDescriptor()
field_descriptors.MultiRoundAoeNO_MultiEntityHold = protobuf.FieldDescriptor()
type_descriptors.StepHistoryNO = protobuf.Descriptor()
field_descriptors.StepHistoryNO_round = protobuf.FieldDescriptor()
field_descriptors.StepHistoryNO_entityId = protobuf.FieldDescriptor()
field_descriptors.StepHistoryNO_entityCode = protobuf.FieldDescriptor()
field_descriptors.StepHistoryNO_entityType = protobuf.FieldDescriptor()
field_descriptors.StepHistoryNO_movement = protobuf.FieldDescriptor()
field_descriptors.StepHistoryNO_releasingSkill = protobuf.FieldDescriptor()
type_descriptors.TagEnhanceNO = protobuf.Descriptor()
field_descriptors.TagEnhanceNO_tag = protobuf.FieldDescriptor()
field_descriptors.TagEnhanceNO_field = protobuf.FieldDescriptor()
field_descriptors.TagEnhanceNO_contexts = protobuf.FieldDescriptor()
type_descriptors.EndStageReply = protobuf.Descriptor()
type_descriptors.PlaceEntityNO = protobuf.Descriptor()
field_descriptors.PlaceEntityNO_entity = protobuf.FieldDescriptor()
field_descriptors.PlaceEntityNO_cell = protobuf.FieldDescriptor()
type_descriptors.AirMapInfoNO = protobuf.Descriptor()
field_descriptors.AirMapInfoNO_sceneId = protobuf.FieldDescriptor()
field_descriptors.AirMapInfoNO_building = protobuf.FieldDescriptor()
field_descriptors.AirMapInfoNO_extraWinCondition = protobuf.FieldDescriptor()
field_descriptors.AirMapInfoNO_ambushUnit = protobuf.FieldDescriptor()
field_descriptors.AirMapInfoNO_normalUnit = protobuf.FieldDescriptor()
field_descriptors.AirMapInfoNO_initTags = protobuf.FieldDescriptor()
field_descriptors.AirMapInfoNO_bornCell = protobuf.FieldDescriptor()
type_descriptors.ShootNO = protobuf.Descriptor()
field_descriptors.ShootNO_eId = protobuf.FieldDescriptor()
field_descriptors.ShootNO_events = protobuf.FieldDescriptor()
field_descriptors.ShootNO_chain = protobuf.FieldDescriptor()
type_descriptors.SurrenderRequest = protobuf.Descriptor()
field_descriptors.SurrenderRequest_type = protobuf.FieldDescriptor()
type_descriptors.FractionPointNO = protobuf.Descriptor()
field_descriptors.FractionPointNO_x = protobuf.FieldDescriptor()
field_descriptors.FractionPointNO_z = protobuf.FieldDescriptor()
type_descriptors.WeakPointHpChangedEventNO = protobuf.Descriptor()
field_descriptors.WeakPointHpChangedEventNO_entity = protobuf.FieldDescriptor()
field_descriptors.WeakPointHpChangedEventNO_hp = protobuf.FieldDescriptor()
type_descriptors.ModelRectangleNO = protobuf.Descriptor()
field_descriptors.ModelRectangleNO_modelId = protobuf.FieldDescriptor()
type_descriptors.TagNO = protobuf.Descriptor()
field_descriptors.TagNO_base = protobuf.FieldDescriptor()
field_descriptors.TagNO_events = protobuf.FieldDescriptor()
type_descriptors.BuffAddedEventNO = protobuf.Descriptor()
field_descriptors.BuffAddedEventNO_entity = protobuf.FieldDescriptor()
field_descriptors.BuffAddedEventNO_code = protobuf.FieldDescriptor()
field_descriptors.BuffAddedEventNO_round = protobuf.FieldDescriptor()
field_descriptors.BuffAddedEventNO_id = protobuf.FieldDescriptor()
field_descriptors.BuffAddedEventNO_layer = protobuf.FieldDescriptor()
type_descriptors.WonConditionsChangedEventNO = protobuf.Descriptor()
field_descriptors.WonConditionsChangedEventNO_added = protobuf.FieldDescriptor()
field_descriptors.WonConditionsChangedEventNO_removed = protobuf.FieldDescriptor()
type_descriptors.ParallelRectangleNO = protobuf.Descriptor()
field_descriptors.ParallelRectangleNO_width = protobuf.FieldDescriptor()
field_descriptors.ParallelRectangleNO_height = protobuf.FieldDescriptor()
field_descriptors.ParallelRectangleNO_offset = protobuf.FieldDescriptor()
type_descriptors.ResultForecastAiPush = protobuf.Descriptor()
field_descriptors.ResultForecastAiPush_fromForecast = protobuf.FieldDescriptor()
field_descriptors.ResultForecastAiPush_forecastAis = protobuf.FieldDescriptor()
type_descriptors.StepRequest = protobuf.Descriptor()
field_descriptors.StepRequest_entity = protobuf.FieldDescriptor()
field_descriptors.StepRequest_movement = protobuf.FieldDescriptor()
field_descriptors.StepRequest_releasingSkill = protobuf.FieldDescriptor()
field_descriptors.StepRequest_target = protobuf.FieldDescriptor()
field_descriptors.StepRequest_position = protobuf.FieldDescriptor()
field_descriptors.StepRequest_strengthening = protobuf.FieldDescriptor()
field_descriptors.StepRequest_lookAt = protobuf.FieldDescriptor()
type_descriptors.LineNO = protobuf.Descriptor()
field_descriptors.LineNO_start = protobuf.FieldDescriptor()
field_descriptors.LineNO_end = protobuf.FieldDescriptor()
type_descriptors.EntityPlayerChangedEventNO = protobuf.Descriptor()
field_descriptors.EntityPlayerChangedEventNO_entity = protobuf.FieldDescriptor()
field_descriptors.EntityPlayerChangedEventNO_player = protobuf.FieldDescriptor()
field_descriptors.EntityPlayerChangedEventNO_battleCamp = protobuf.FieldDescriptor()
field_descriptors.EntityPlayerChangedEventNO_reason = protobuf.FieldDescriptor()
type_descriptors.ImmuneBuffAddNO = protobuf.Descriptor()
field_descriptors.ImmuneBuffAddNO_entity = protobuf.FieldDescriptor()
field_descriptors.ImmuneBuffAddNO_buffs = protobuf.FieldDescriptor()
type_descriptors.StepReply = protobuf.Descriptor()
type_descriptors.DisconnectRequest = protobuf.Descriptor()
type_descriptors.EndReadyRequest = protobuf.Descriptor()
type_descriptors.SkillNO = protobuf.Descriptor()
field_descriptors.SkillNO_code = protobuf.FieldDescriptor()
field_descriptors.SkillNO_enhanced = protobuf.FieldDescriptor()
field_descriptors.SkillNO_source = protobuf.FieldDescriptor()
field_descriptors.SkillNO_cd = protobuf.FieldDescriptor()
type_descriptors.BattleInfoNO = protobuf.Descriptor()
field_descriptors.BattleInfoNO_type = protobuf.FieldDescriptor()
field_descriptors.BattleInfoNO_battlefield = protobuf.FieldDescriptor()
field_descriptors.BattleInfoNO_passId = protobuf.FieldDescriptor()
field_descriptors.BattleInfoNO_levelId = protobuf.FieldDescriptor()
field_descriptors.BattleInfoNO_map = protobuf.FieldDescriptor()
field_descriptors.BattleInfoNO_mapId = protobuf.FieldDescriptor()
field_descriptors.BattleInfoNO_pvpType = protobuf.FieldDescriptor()
field_descriptors.BattleInfoNO_players = protobuf.FieldDescriptor()
field_descriptors.BattleInfoNO_startTime = protobuf.FieldDescriptor()
field_descriptors.BattleInfoNO_multiplied = protobuf.FieldDescriptor()
field_descriptors.BattleInfoNO_gameplay = protobuf.FieldDescriptor()
type_descriptors.OnEventTriggeredPush = protobuf.Descriptor()
field_descriptors.OnEventTriggeredPush_endReason = protobuf.FieldDescriptor()
field_descriptors.OnEventTriggeredPush_events = protobuf.FieldDescriptor()
type_descriptors.MoonRingTagNO = protobuf.Descriptor()
field_descriptors.MoonRingTagNO_shape = protobuf.FieldDescriptor()
type_descriptors.AssistTagNO = protobuf.Descriptor()
field_descriptors.AssistTagNO_shape = protobuf.FieldDescriptor()
type_descriptors.SheetMusicNO = protobuf.Descriptor()
field_descriptors.SheetMusicNO_sheetMusicCode = protobuf.FieldDescriptor()
field_descriptors.SheetMusicNO_entity = protobuf.FieldDescriptor()
field_descriptors.SheetMusicNO_skill = protobuf.FieldDescriptor()
field_descriptors.SheetMusicNO_notes = protobuf.FieldDescriptor()
type_descriptors.EntityConfigChangedEventNO = protobuf.Descriptor()
field_descriptors.EntityConfigChangedEventNO_id = protobuf.FieldDescriptor()
field_descriptors.EntityConfigChangedEventNO_career = protobuf.FieldDescriptor()
field_descriptors.EntityConfigChangedEventNO_color = protobuf.FieldDescriptor()
field_descriptors.EntityConfigChangedEventNO_camp = protobuf.FieldDescriptor()
field_descriptors.EntityConfigChangedEventNO_monsterType = protobuf.FieldDescriptor()
type_descriptors.BornCellNO = protobuf.Descriptor()
field_descriptors.BornCellNO_cell = protobuf.FieldDescriptor()
field_descriptors.BornCellNO_direction = protobuf.FieldDescriptor()
type_descriptors.EntityNO = protobuf.Descriptor()
field_descriptors.EntityNO_id = protobuf.FieldDescriptor()
field_descriptors.EntityNO_code = protobuf.FieldDescriptor()
field_descriptors.EntityNO_player = protobuf.FieldDescriptor()
field_descriptors.EntityNO_attributes = protobuf.FieldDescriptor()
field_descriptors.EntityNO_cell = protobuf.FieldDescriptor()
field_descriptors.EntityNO_level = protobuf.FieldDescriptor()
field_descriptors.EntityNO_tags = protobuf.FieldDescriptor()
field_descriptors.EntityNO_skills = protobuf.FieldDescriptor()
field_descriptors.EntityNO_buffs = protobuf.FieldDescriptor()
field_descriptors.EntityNO_state = protobuf.FieldDescriptor()
field_descriptors.EntityNO_viewCode = protobuf.FieldDescriptor()
field_descriptors.EntityNO_extra = protobuf.FieldDescriptor()
field_descriptors.EntityNO_weakPointType = protobuf.FieldDescriptor()
field_descriptors.EntityNO_maxWeakPointHp = protobuf.FieldDescriptor()
field_descriptors.EntityNO_weakPointHp = protobuf.FieldDescriptor()
field_descriptors.EntityNO_type = protobuf.FieldDescriptor()
field_descriptors.EntityNO_battleCamp = protobuf.FieldDescriptor()
field_descriptors.EntityNO_tagEnhances = protobuf.FieldDescriptor()
field_descriptors.EntityNO_steppable = protobuf.FieldDescriptor()
field_descriptors.EntityNO_modelId = protobuf.FieldDescriptor()
field_descriptors.EntityNO_immuneBuffs = protobuf.FieldDescriptor()
type_descriptors.ImmuneBuffRemoveNO = protobuf.Descriptor()
field_descriptors.ImmuneBuffRemoveNO_entity = protobuf.FieldDescriptor()
field_descriptors.ImmuneBuffRemoveNO_buffs = protobuf.FieldDescriptor()
type_descriptors.CrossLineNO = protobuf.Descriptor()
field_descriptors.CrossLineNO_width = protobuf.FieldDescriptor()
field_descriptors.CrossLineNO_height = protobuf.FieldDescriptor()
type_descriptors.CancelReadyReply = protobuf.Descriptor()
type_descriptors.BuffRoundDecredEventNO = protobuf.Descriptor()
field_descriptors.BuffRoundDecredEventNO_entity = protobuf.FieldDescriptor()
field_descriptors.BuffRoundDecredEventNO_ids = protobuf.FieldDescriptor()
field_descriptors.BuffRoundDecredEventNO_decrement = protobuf.FieldDescriptor()
type_descriptors.BackToRequest = protobuf.Descriptor()
field_descriptors.BackToRequest_round = protobuf.FieldDescriptor()
field_descriptors.BackToRequest_step = protobuf.FieldDescriptor()
type_descriptors.UnfinishedBattlePush = protobuf.Descriptor()
field_descriptors.UnfinishedBattlePush_battleInfo = protobuf.FieldDescriptor()
field_descriptors.UnfinishedBattlePush_canReconnect = protobuf.FieldDescriptor()
type_descriptors.EventNO = protobuf.Descriptor()
field_descriptors.EventNO_stageStarted = protobuf.FieldDescriptor()
field_descriptors.EventNO_stageEnded = protobuf.FieldDescriptor()
field_descriptors.EventNO_battleEnded = protobuf.FieldDescriptor()
field_descriptors.EventNO_skillTriggered = protobuf.FieldDescriptor()
field_descriptors.EventNO_buffTriggered = protobuf.FieldDescriptor()
field_descriptors.EventNO_attributeModified = protobuf.FieldDescriptor()
field_descriptors.EventNO_buffAdded = protobuf.FieldDescriptor()
field_descriptors.EventNO_buffRemoved = protobuf.FieldDescriptor()
field_descriptors.EventNO_buffRoundDecred = protobuf.FieldDescriptor()
field_descriptors.EventNO_cured = protobuf.FieldDescriptor()
field_descriptors.EventNO_entityDead = protobuf.FieldDescriptor()
field_descriptors.EventNO_entityStepped = protobuf.FieldDescriptor()
field_descriptors.EventNO_weakPointHpChanged = protobuf.FieldDescriptor()
field_descriptors.EventNO_positionChanged = protobuf.FieldDescriptor()
field_descriptors.EventNO_entitiesAdded = protobuf.FieldDescriptor()
field_descriptors.EventNO_entityRemoved = protobuf.FieldDescriptor()
field_descriptors.EventNO_entitiesSwapped = protobuf.FieldDescriptor()
field_descriptors.EventNO_roundStarted = protobuf.FieldDescriptor()
field_descriptors.EventNO_plotChainTriggered = protobuf.FieldDescriptor()
field_descriptors.EventNO_plotTriggered = protobuf.FieldDescriptor()
field_descriptors.EventNO_damaged = protobuf.FieldDescriptor()
field_descriptors.EventNO_stateAdded = protobuf.FieldDescriptor()
field_descriptors.EventNO_stateRemoved = protobuf.FieldDescriptor()
field_descriptors.EventNO_cellsBlocked = protobuf.FieldDescriptor()
field_descriptors.EventNO_cellsUnblocked = protobuf.FieldDescriptor()
field_descriptors.EventNO_cup = protobuf.FieldDescriptor()
field_descriptors.EventNO_playerStarted = protobuf.FieldDescriptor()
field_descriptors.EventNO_playerEnded = protobuf.FieldDescriptor()
field_descriptors.EventNO_haloRefreshed = protobuf.FieldDescriptor()
field_descriptors.EventNO_entityConfigChanged = protobuf.FieldDescriptor()
field_descriptors.EventNO_taskTrigger = protobuf.FieldDescriptor()
field_descriptors.EventNO_userReady = protobuf.FieldDescriptor()
field_descriptors.EventNO_cancelReady = protobuf.FieldDescriptor()
field_descriptors.EventNO_tacitTaskProgress = protobuf.FieldDescriptor()
field_descriptors.EventNO_terrainChange = protobuf.FieldDescriptor()
field_descriptors.EventNO_skillAdded = protobuf.FieldDescriptor()
field_descriptors.EventNO_skillRemoved = protobuf.FieldDescriptor()
field_descriptors.EventNO_entityPlayerChanged = protobuf.FieldDescriptor()
field_descriptors.EventNO_wonConditionsChanged = protobuf.FieldDescriptor()
field_descriptors.EventNO_terrainUpdated = protobuf.FieldDescriptor()
field_descriptors.EventNO_skillCdUpdate = protobuf.FieldDescriptor()
field_descriptors.EventNO_weakPointStatusChanged = protobuf.FieldDescriptor()
field_descriptors.EventNO_weakPointAdded = protobuf.FieldDescriptor()
field_descriptors.EventNO_groupEvent = protobuf.FieldDescriptor()
field_descriptors.EventNO_plotTriggered3D = protobuf.FieldDescriptor()
field_descriptors.EventNO_doomForecast = protobuf.FieldDescriptor()
field_descriptors.EventNO_tag = protobuf.FieldDescriptor()
field_descriptors.EventNO_tagWithBase = protobuf.FieldDescriptor()
field_descriptors.EventNO_lightColumn = protobuf.FieldDescriptor()
field_descriptors.EventNO_shoot = protobuf.FieldDescriptor()
field_descriptors.EventNO_sheetMusic = protobuf.FieldDescriptor()
field_descriptors.EventNO_pianoPlaying = protobuf.FieldDescriptor()
field_descriptors.EventNO_tagEnhanceAdds = protobuf.FieldDescriptor()
field_descriptors.EventNO_tagEnhanceRemoves = protobuf.FieldDescriptor()
field_descriptors.EventNO_multiRoundAoeAdd = protobuf.FieldDescriptor()
field_descriptors.EventNO_multiRoundAoeUpdate = protobuf.FieldDescriptor()
field_descriptors.EventNO_multiRoundAoeRemove = protobuf.FieldDescriptor()
field_descriptors.EventNO_attributeRemoved = protobuf.FieldDescriptor()
field_descriptors.EventNO_steppableChange = protobuf.FieldDescriptor()
field_descriptors.EventNO_weakPointRemoved = protobuf.FieldDescriptor()
field_descriptors.EventNO_back = protobuf.FieldDescriptor()
field_descriptors.EventNO_modelChanged = protobuf.FieldDescriptor()
field_descriptors.EventNO_multiEntityHold = protobuf.FieldDescriptor()
field_descriptors.EventNO_ImmuneBuffAdd = protobuf.FieldDescriptor()
field_descriptors.EventNO_ImmuneBuffRemove = protobuf.FieldDescriptor()
field_descriptors.EventNO_aiModeChangeNO = protobuf.FieldDescriptor()
field_descriptors.EventNO_triggering = protobuf.FieldDescriptor()
field_descriptors.EventNO_airMessage = protobuf.FieldDescriptor()
type_descriptors.GroupEventNO = protobuf.Descriptor()
field_descriptors.GroupEventNO_events = protobuf.FieldDescriptor()
field_descriptors.GroupEventNO_center = protobuf.FieldDescriptor()
field_descriptors.GroupEventNO_direction = protobuf.FieldDescriptor()
type_descriptors.ResultForecastPush = protobuf.Descriptor()
field_descriptors.ResultForecastPush_endReason = protobuf.FieldDescriptor()
field_descriptors.ResultForecastPush_myEntity = protobuf.FieldDescriptor()
field_descriptors.ResultForecastPush_targetEntity = protobuf.FieldDescriptor()
field_descriptors.ResultForecastPush_critical = protobuf.FieldDescriptor()
field_descriptors.ResultForecastPush_immunized = protobuf.FieldDescriptor()
field_descriptors.ResultForecastPush_near = protobuf.FieldDescriptor()
field_descriptors.ResultForecastPush_countered = protobuf.FieldDescriptor()
field_descriptors.ResultForecastPush_haloLinked = protobuf.FieldDescriptor()
field_descriptors.ResultForecastPush_haloUnlinked = protobuf.FieldDescriptor()
field_descriptors.ResultForecastPush_cellsBlocked = protobuf.FieldDescriptor()
field_descriptors.ResultForecastPush_cellsUnblocked = protobuf.FieldDescriptor()
field_descriptors.ResultForecastPush_myDamagedValue = protobuf.FieldDescriptor()
field_descriptors.ResultForecastPush_targetDamagedValue = protobuf.FieldDescriptor()
field_descriptors.ResultForecastPush_secondaryTargetEntities = protobuf.FieldDescriptor()
field_descriptors.ResultForecastPush_counteredCritically = protobuf.FieldDescriptor()
field_descriptors.ResultForecastPush_counteredImmunizedly = protobuf.FieldDescriptor()
field_descriptors.ResultForecastPush_counteredNear = protobuf.FieldDescriptor()
field_descriptors.ResultForecastPush_tags = protobuf.FieldDescriptor()
field_descriptors.ResultForecastPush_counterBeforeAttack = protobuf.FieldDescriptor()
type_descriptors.ReconnectBattleReply = protobuf.Descriptor()
field_descriptors.ReconnectBattleReply_battleInfo = protobuf.FieldDescriptor()
type_descriptors.SectorNO = protobuf.Descriptor()
field_descriptors.SectorNO_radius = protobuf.FieldDescriptor()
field_descriptors.SectorNO_direction = protobuf.FieldDescriptor()
type_descriptors.MultiRoundAoeRemoveNO = protobuf.Descriptor()
field_descriptors.MultiRoundAoeRemoveNO_aoe = protobuf.FieldDescriptor()
type_descriptors.RemoveEntityReply = protobuf.Descriptor()
type_descriptors.SkillChangedEventNO = protobuf.Descriptor()
field_descriptors.SkillChangedEventNO_entity = protobuf.FieldDescriptor()
field_descriptors.SkillChangedEventNO_skill = protobuf.FieldDescriptor()
type_descriptors.EndStageRequest = protobuf.Descriptor()
type_descriptors.MoveEntityReply = protobuf.Descriptor()
type_descriptors.CancelReadyRequest = protobuf.Descriptor()
type_descriptors.ShapeNO = protobuf.Descriptor()
field_descriptors.ShapeNO_circle = protobuf.FieldDescriptor()
field_descriptors.ShapeNO_rhombus = protobuf.FieldDescriptor()
field_descriptors.ShapeNO_rectangle = protobuf.FieldDescriptor()
field_descriptors.ShapeNO_point = protobuf.FieldDescriptor()
field_descriptors.ShapeNO_wholeBattleBoard = protobuf.FieldDescriptor()
field_descriptors.ShapeNO_sector = protobuf.FieldDescriptor()
field_descriptors.ShapeNO_multipleShape = protobuf.FieldDescriptor()
field_descriptors.ShapeNO_cells = protobuf.FieldDescriptor()
field_descriptors.ShapeNO_crossLine = protobuf.FieldDescriptor()
field_descriptors.ShapeNO_parallelRectangle = protobuf.FieldDescriptor()
field_descriptors.ShapeNO_modelRectangle = protobuf.FieldDescriptor()
field_descriptors.ShapeNO_line = protobuf.FieldDescriptor()
field_descriptors.ShapeNO_linkLine = protobuf.FieldDescriptor()
type_descriptors.SkillCdNO = protobuf.Descriptor()
field_descriptors.SkillCdNO_skill = protobuf.FieldDescriptor()
field_descriptors.SkillCdNO_cd = protobuf.FieldDescriptor()
type_descriptors.PvpPlayerNO = protobuf.Descriptor()
field_descriptors.PvpPlayerNO_playerId = protobuf.FieldDescriptor()
field_descriptors.PvpPlayerNO_teamId = protobuf.FieldDescriptor()
field_descriptors.PvpPlayerNO_userId = protobuf.FieldDescriptor()
type_descriptors.TagEventWithBaseNO = protobuf.Descriptor()
field_descriptors.TagEventWithBaseNO_base = protobuf.FieldDescriptor()
field_descriptors.TagEventWithBaseNO_events = protobuf.FieldDescriptor()
type_descriptors.WeakPointStatusChangedEventNO = protobuf.Descriptor()
field_descriptors.WeakPointStatusChangedEventNO_entity = protobuf.FieldDescriptor()
field_descriptors.WeakPointStatusChangedEventNO_type = protobuf.FieldDescriptor()
field_descriptors.WeakPointStatusChangedEventNO_effects = protobuf.FieldDescriptor()
type_descriptors.SkillCdUpdateEventNO = protobuf.Descriptor()
field_descriptors.SkillCdUpdateEventNO_entity = protobuf.FieldDescriptor()
field_descriptors.SkillCdUpdateEventNO_skills = protobuf.FieldDescriptor()
type_descriptors.StateChangedEventNO = protobuf.Descriptor()
field_descriptors.StateChangedEventNO_entity = protobuf.FieldDescriptor()
field_descriptors.StateChangedEventNO_state = protobuf.FieldDescriptor()
type_descriptors.FractionNO = protobuf.Descriptor()
field_descriptors.FractionNO_numerator = protobuf.FieldDescriptor()
field_descriptors.FractionNO_denominator = protobuf.FieldDescriptor()
type_descriptors.ConnectCompleteRequest = protobuf.Descriptor()
type_descriptors.ReconnectBattleRequest = protobuf.Descriptor()
type_descriptors.PositionChangedEventNO = protobuf.Descriptor()
field_descriptors.PositionChangedEventNO_method = protobuf.FieldDescriptor()
field_descriptors.PositionChangedEventNO_entities = protobuf.FieldDescriptor()
field_descriptors.PositionChangedEventNO_refCell = protobuf.FieldDescriptor()
type_descriptors.EntityRemovedNO = protobuf.Descriptor()
field_descriptors.EntityRemovedNO_id = protobuf.FieldDescriptor()
field_descriptors.EntityRemovedNO_reason = protobuf.FieldDescriptor()
type_descriptors.PlaceEntityRequest = protobuf.Descriptor()
field_descriptors.PlaceEntityRequest_placeEntities = protobuf.FieldDescriptor()
type_descriptors.MultipleShapeNO = protobuf.Descriptor()
field_descriptors.MultipleShapeNO_offSetShapes = protobuf.FieldDescriptor()
field_descriptors.MultipleShapeNO_centerShapes = protobuf.FieldDescriptor()
type_descriptors.GetBackInfoReply = protobuf.Descriptor()
field_descriptors.GetBackInfoReply_info = protobuf.FieldDescriptor()
type_descriptors.SteppableChangeNO = protobuf.Descriptor()
field_descriptors.SteppableChangeNO_entity = protobuf.FieldDescriptor()
field_descriptors.SteppableChangeNO_steppable = protobuf.FieldDescriptor()
type_descriptors.TacitTaskProgressEventNO = protobuf.Descriptor()
field_descriptors.TacitTaskProgressEventNO_taskId = protobuf.FieldDescriptor()
field_descriptors.TacitTaskProgressEventNO_progress = protobuf.FieldDescriptor()
type_descriptors.CuredEventNO = protobuf.Descriptor()
field_descriptors.CuredEventNO_releaser = protobuf.FieldDescriptor()
field_descriptors.CuredEventNO_entity = protobuf.FieldDescriptor()
field_descriptors.CuredEventNO_value = protobuf.FieldDescriptor()
field_descriptors.CuredEventNO_skill = protobuf.FieldDescriptor()
field_descriptors.CuredEventNO_buff = protobuf.FieldDescriptor()
field_descriptors.CuredEventNO_hpIncrement = protobuf.FieldDescriptor()
type_descriptors.BuildingNO = protobuf.Descriptor()
field_descriptors.BuildingNO_id = protobuf.FieldDescriptor()
field_descriptors.BuildingNO_cell = protobuf.FieldDescriptor()
field_descriptors.BuildingNO_msg = protobuf.FieldDescriptor()
type_descriptors.AirMessageNO = protobuf.Descriptor()
field_descriptors.AirMessageNO_type = protobuf.FieldDescriptor()
field_descriptors.AirMessageNO_msg = protobuf.FieldDescriptor()
field_descriptors.AirMessageNO_pos = protobuf.FieldDescriptor()
type_descriptors.SetAiControlledRequest = protobuf.Descriptor()
field_descriptors.SetAiControlledRequest_aiControlled = protobuf.FieldDescriptor()
type_descriptors.ReadyStartPush = protobuf.Descriptor()
type_descriptors.GetBackInfoRequest = protobuf.Descriptor()
field_descriptors.GetBackInfoRequest_round = protobuf.FieldDescriptor()
field_descriptors.GetBackInfoRequest_step = protobuf.FieldDescriptor()
type_descriptors.SkillTriggeredEventNO = protobuf.Descriptor()
field_descriptors.SkillTriggeredEventNO_entity = protobuf.FieldDescriptor()
field_descriptors.SkillTriggeredEventNO_code = protobuf.FieldDescriptor()
field_descriptors.SkillTriggeredEventNO_effects = protobuf.FieldDescriptor()
field_descriptors.SkillTriggeredEventNO_attackingDirection = protobuf.FieldDescriptor()
field_descriptors.SkillTriggeredEventNO_strengthen = protobuf.FieldDescriptor()
type_descriptors.AttributeNO = protobuf.Descriptor()
field_descriptors.AttributeNO_attr = protobuf.FieldDescriptor()
field_descriptors.AttributeNO_value = protobuf.FieldDescriptor()
field_descriptors.AttributeNO_initial = protobuf.FieldDescriptor()
type_descriptors.EndReadyReply = protobuf.Descriptor()
type_descriptors.CellNO = protobuf.Descriptor()
field_descriptors.CellNO_x = protobuf.FieldDescriptor()
field_descriptors.CellNO_z = protobuf.FieldDescriptor()
field_descriptors.CellNO_additionalTerrains = protobuf.FieldDescriptor()
field_descriptors.CellNO_blocked = protobuf.FieldDescriptor()
type_descriptors.TaskTriggerNO = protobuf.Descriptor()
field_descriptors.TaskTriggerNO_name = protobuf.FieldDescriptor()
field_descriptors.TaskTriggerNO_params = protobuf.FieldDescriptor()
type_descriptors.BattleStartPush = protobuf.Descriptor()
type_descriptors.RhombusNO = protobuf.Descriptor()
field_descriptors.RhombusNO_radius = protobuf.FieldDescriptor()
type_descriptors.RectangleNO = protobuf.Descriptor()
field_descriptors.RectangleNO_width = protobuf.FieldDescriptor()
field_descriptors.RectangleNO_height = protobuf.FieldDescriptor()
type_descriptors.ExtraNO = protobuf.Descriptor()
field_descriptors.ExtraNO_direction = protobuf.FieldDescriptor()
field_descriptors.ExtraNO_lookAt = protobuf.FieldDescriptor()
field_descriptors.ExtraNO_bodyEffect = protobuf.FieldDescriptor()
type_descriptors.PianoPlayingEventNO = protobuf.Descriptor()
field_descriptors.PianoPlayingEventNO_scale = protobuf.FieldDescriptor()
field_descriptors.PianoPlayingEventNO_events = protobuf.FieldDescriptor()
type_descriptors.MultiRoundAoeAddNO = protobuf.Descriptor()
field_descriptors.MultiRoundAoeAddNO_aoe = protobuf.FieldDescriptor()
type_descriptors.DoomForecastNO = protobuf.Descriptor()
field_descriptors.DoomForecastNO_effectIndex = protobuf.FieldDescriptor()
field_descriptors.DoomForecastNO_actionIndex = protobuf.FieldDescriptor()
field_descriptors.DoomForecastNO_collectorIndex = protobuf.FieldDescriptor()
field_descriptors.DoomForecastNO_randomActionIndex = protobuf.FieldDescriptor()
field_descriptors.DoomForecastNO_targets = protobuf.FieldDescriptor()
type_descriptors.DeleteUnfinishedBattleReply = protobuf.Descriptor()
type_descriptors.ForecastRequest = protobuf.Descriptor()
field_descriptors.ForecastRequest_step = protobuf.FieldDescriptor()
type_descriptors.BuffRemovedEventNO = protobuf.Descriptor()
field_descriptors.BuffRemovedEventNO_entity = protobuf.FieldDescriptor()
field_descriptors.BuffRemovedEventNO_ids = protobuf.FieldDescriptor()
type_descriptors.AmbushNO = protobuf.Descriptor()
field_descriptors.AmbushNO_hero = protobuf.FieldDescriptor()
field_descriptors.AmbushNO_condition = protobuf.FieldDescriptor()
field_descriptors.AmbushNO_params = protobuf.FieldDescriptor()
type_descriptors.SurrenderReply = protobuf.Descriptor()
type_descriptors.TagEnhanceRemoveNO = protobuf.Descriptor()
field_descriptors.TagEnhanceRemoveNO_entity = protobuf.FieldDescriptor()
field_descriptors.TagEnhanceRemoveNO_contexts = protobuf.FieldDescriptor()
type_descriptors.TurnNO = protobuf.Descriptor()
field_descriptors.TurnNO_entity = protobuf.FieldDescriptor()
field_descriptors.TurnNO_lookAt = protobuf.FieldDescriptor()
type_descriptors.MoveEntityRequest = protobuf.Descriptor()
field_descriptors.MoveEntityRequest_entity = protobuf.FieldDescriptor()
field_descriptors.MoveEntityRequest_cell = protobuf.FieldDescriptor()
type_descriptors.LinkLineNO = protobuf.Descriptor()
field_descriptors.LinkLineNO_start = protobuf.FieldDescriptor()
field_descriptors.LinkLineNO_end = protobuf.FieldDescriptor()
type_descriptors.OffsetShapeNO = protobuf.Descriptor()
field_descriptors.OffsetShapeNO_offset = protobuf.FieldDescriptor()
field_descriptors.OffsetShapeNO_shape = protobuf.FieldDescriptor()
type_descriptors.TagEnhanceContextNO = protobuf.Descriptor()
field_descriptors.TagEnhanceContextNO_id = protobuf.FieldDescriptor()
field_descriptors.TagEnhanceContextNO_cmd = protobuf.FieldDescriptor()
field_descriptors.TagEnhanceContextNO_pType = protobuf.FieldDescriptor()
field_descriptors.TagEnhanceContextNO_param = protobuf.FieldDescriptor()
type_descriptors.DamagedEventNO = protobuf.Descriptor()
field_descriptors.DamagedEventNO_entity = protobuf.FieldDescriptor()
field_descriptors.DamagedEventNO_damageValue = protobuf.FieldDescriptor()
field_descriptors.DamagedEventNO_damageType = protobuf.FieldDescriptor()
field_descriptors.DamagedEventNO_skill = protobuf.FieldDescriptor()
field_descriptors.DamagedEventNO_buff = protobuf.FieldDescriptor()
field_descriptors.DamagedEventNO_skillEntity = protobuf.FieldDescriptor()
field_descriptors.DamagedEventNO_fromEntity = protobuf.FieldDescriptor()
field_descriptors.DamagedEventNO_critical = protobuf.FieldDescriptor()
field_descriptors.DamagedEventNO_immunized = protobuf.FieldDescriptor()
field_descriptors.DamagedEventNO_weakPointDamage = protobuf.FieldDescriptor()
field_descriptors.DamagedEventNO_hpDecrement = protobuf.FieldDescriptor()
field_descriptors.DamagedEventNO_hpDecrementOverflow = protobuf.FieldDescriptor()
type_descriptors.TerrainChangeNO = protobuf.Descriptor()
field_descriptors.TerrainChangeNO_removed = protobuf.FieldDescriptor()
field_descriptors.TerrainChangeNO_added = protobuf.FieldDescriptor()
type_descriptors.TagBaseNO = protobuf.Descriptor()
field_descriptors.TagBaseNO_tagId = protobuf.FieldDescriptor()
field_descriptors.TagBaseNO_variant = protobuf.FieldDescriptor()
field_descriptors.TagBaseNO_moonRing = protobuf.FieldDescriptor()
field_descriptors.TagBaseNO_assist = protobuf.FieldDescriptor()
field_descriptors.TagBaseNO_shapeTag = protobuf.FieldDescriptor()
type_descriptors.BattleExtraNO = protobuf.Descriptor()
field_descriptors.BattleExtraNO_doomForecast = protobuf.FieldDescriptor()
field_descriptors.BattleExtraNO_lightColumn = protobuf.FieldDescriptor()
field_descriptors.BattleExtraNO_sheetMusic = protobuf.FieldDescriptor()
type_descriptors.MapMessageNO = protobuf.Descriptor()
field_descriptors.MapMessageNO_msg = protobuf.FieldDescriptor()
field_descriptors.MapMessageNO_time = protobuf.FieldDescriptor()
field_descriptors.MapMessageNO_params = protobuf.FieldDescriptor()
type_descriptors.HeroNO = protobuf.Descriptor()
field_descriptors.HeroNO_heroId = protobuf.FieldDescriptor()
field_descriptors.HeroNO_cell = protobuf.FieldDescriptor()
field_descriptors.HeroNO_msg = protobuf.FieldDescriptor()
type_descriptors.ConnectStateNO = protobuf.Descriptor()
field_descriptors.ConnectStateNO_userId = protobuf.FieldDescriptor()
field_descriptors.ConnectStateNO_online = protobuf.FieldDescriptor()
type_descriptors.LightColumnNO = protobuf.Descriptor()
field_descriptors.LightColumnNO_column = protobuf.FieldDescriptor()
field_descriptors.LightColumnNO_lightRes = protobuf.FieldDescriptor()
type_descriptors.DisconnectReply = protobuf.Descriptor()
type_descriptors.ForecastAiReply = protobuf.Descriptor()
enum_item_descriptors.GameType_DEFAULT.name = "DEFAULT"
enum_item_descriptors.GameType_DEFAULT.index = 0
enum_item_descriptors.GameType_DEFAULT.number = 1
enum_item_descriptors.GameType_FOOTBALLPVP.name = "FOOTBALLPVP"
enum_item_descriptors.GameType_FOOTBALLPVP.index = 1
enum_item_descriptors.GameType_FOOTBALLPVP.number = 2
type_descriptors.GameType.name = "GameType"
type_descriptors.GameType.full_name = ".GameType"
type_descriptors.GameType.values = {
	enum_item_descriptors.GameType_DEFAULT,
	enum_item_descriptors.GameType_FOOTBALLPVP
}
enum_item_descriptors.Relation_ENEMY.name = "ENEMY"
enum_item_descriptors.Relation_ENEMY.index = 0
enum_item_descriptors.Relation_ENEMY.number = 1
enum_item_descriptors.Relation_FRIEND.name = "FRIEND"
enum_item_descriptors.Relation_FRIEND.index = 1
enum_item_descriptors.Relation_FRIEND.number = 2
enum_item_descriptors.Relation_NEUTRAL.name = "NEUTRAL"
enum_item_descriptors.Relation_NEUTRAL.index = 2
enum_item_descriptors.Relation_NEUTRAL.number = 3
type_descriptors.Relation.name = "Relation"
type_descriptors.Relation.full_name = ".Relation"
type_descriptors.Relation.values = {
	enum_item_descriptors.Relation_ENEMY,
	enum_item_descriptors.Relation_FRIEND,
	enum_item_descriptors.Relation_NEUTRAL
}
enum_item_descriptors.Attribute_MOVE.name = "MOVE"
enum_item_descriptors.Attribute_MOVE.index = 0
enum_item_descriptors.Attribute_MOVE.number = 2
enum_item_descriptors.Attribute_MAX_HP.name = "MAX_HP"
enum_item_descriptors.Attribute_MAX_HP.index = 1
enum_item_descriptors.Attribute_MAX_HP.number = 3
enum_item_descriptors.Attribute_ATK_PHY.name = "ATK_PHY"
enum_item_descriptors.Attribute_ATK_PHY.index = 2
enum_item_descriptors.Attribute_ATK_PHY.number = 4
enum_item_descriptors.Attribute_DEF_PHY.name = "DEF_PHY"
enum_item_descriptors.Attribute_DEF_PHY.index = 3
enum_item_descriptors.Attribute_DEF_PHY.number = 5
enum_item_descriptors.Attribute_ATK_MAG.name = "ATK_MAG"
enum_item_descriptors.Attribute_ATK_MAG.index = 4
enum_item_descriptors.Attribute_ATK_MAG.number = 6
enum_item_descriptors.Attribute_DEF_MAG.name = "DEF_MAG"
enum_item_descriptors.Attribute_DEF_MAG.index = 5
enum_item_descriptors.Attribute_DEF_MAG.number = 7
enum_item_descriptors.Attribute_INSPIRATION.name = "INSPIRATION"
enum_item_descriptors.Attribute_INSPIRATION.index = 6
enum_item_descriptors.Attribute_INSPIRATION.number = 8
enum_item_descriptors.Attribute_DAMAGE_ENHANCE.name = "DAMAGE_ENHANCE"
enum_item_descriptors.Attribute_DAMAGE_ENHANCE.index = 7
enum_item_descriptors.Attribute_DAMAGE_ENHANCE.number = 9
enum_item_descriptors.Attribute_DAMAGE_REDUCE.name = "DAMAGE_REDUCE"
enum_item_descriptors.Attribute_DAMAGE_REDUCE.index = 8
enum_item_descriptors.Attribute_DAMAGE_REDUCE.number = 10
enum_item_descriptors.Attribute_CRIT_ENHANCE.name = "CRIT_ENHANCE"
enum_item_descriptors.Attribute_CRIT_ENHANCE.index = 9
enum_item_descriptors.Attribute_CRIT_ENHANCE.number = 11
enum_item_descriptors.Attribute_CRIT_REDUCE.name = "CRIT_REDUCE"
enum_item_descriptors.Attribute_CRIT_REDUCE.index = 10
enum_item_descriptors.Attribute_CRIT_REDUCE.number = 12
enum_item_descriptors.Attribute_RESTRAIN_ENHANCE.name = "RESTRAIN_ENHANCE"
enum_item_descriptors.Attribute_RESTRAIN_ENHANCE.index = 11
enum_item_descriptors.Attribute_RESTRAIN_ENHANCE.number = 13
enum_item_descriptors.Attribute_RESTRAIN_REDUCE.name = "RESTRAIN_REDUCE"
enum_item_descriptors.Attribute_RESTRAIN_REDUCE.index = 12
enum_item_descriptors.Attribute_RESTRAIN_REDUCE.number = 14
enum_item_descriptors.Attribute_CURE.name = "CURE"
enum_item_descriptors.Attribute_CURE.index = 13
enum_item_descriptors.Attribute_CURE.number = 15
enum_item_descriptors.Attribute_BE_CURED.name = "BE_CURED"
enum_item_descriptors.Attribute_BE_CURED.index = 14
enum_item_descriptors.Attribute_BE_CURED.number = 16
enum_item_descriptors.Attribute_SUCK.name = "SUCK"
enum_item_descriptors.Attribute_SUCK.index = 15
enum_item_descriptors.Attribute_SUCK.number = 17
enum_item_descriptors.Attribute_SAN_GROW.name = "SAN_GROW"
enum_item_descriptors.Attribute_SAN_GROW.index = 16
enum_item_descriptors.Attribute_SAN_GROW.number = 18
enum_item_descriptors.Attribute_SAN_BACK.name = "SAN_BACK"
enum_item_descriptors.Attribute_SAN_BACK.index = 17
enum_item_descriptors.Attribute_SAN_BACK.number = 19
enum_item_descriptors.Attribute_IGNORE_PHY.name = "IGNORE_PHY"
enum_item_descriptors.Attribute_IGNORE_PHY.index = 18
enum_item_descriptors.Attribute_IGNORE_PHY.number = 20
enum_item_descriptors.Attribute_IGNORE_MAG.name = "IGNORE_MAG"
enum_item_descriptors.Attribute_IGNORE_MAG.index = 19
enum_item_descriptors.Attribute_IGNORE_MAG.number = 21
enum_item_descriptors.Attribute_CURRENT_HP.name = "CURRENT_HP"
enum_item_descriptors.Attribute_CURRENT_HP.index = 20
enum_item_descriptors.Attribute_CURRENT_HP.number = 22
enum_item_descriptors.Attribute_CURRENT_SAN.name = "CURRENT_SAN"
enum_item_descriptors.Attribute_CURRENT_SAN.index = 21
enum_item_descriptors.Attribute_CURRENT_SAN.number = 23
enum_item_descriptors.Attribute_CURRENT_HP_RATE.name = "CURRENT_HP_RATE"
enum_item_descriptors.Attribute_CURRENT_HP_RATE.index = 22
enum_item_descriptors.Attribute_CURRENT_HP_RATE.number = 24
enum_item_descriptors.Attribute_LOST_HP_RATE.name = "LOST_HP_RATE"
enum_item_descriptors.Attribute_LOST_HP_RATE.index = 23
enum_item_descriptors.Attribute_LOST_HP_RATE.number = 25
enum_item_descriptors.Attribute_FIGHTING_CAPACITY.name = "FIGHTING_CAPACITY"
enum_item_descriptors.Attribute_FIGHTING_CAPACITY.index = 24
enum_item_descriptors.Attribute_FIGHTING_CAPACITY.number = 27
enum_item_descriptors.Attribute_WEAK_POINT_DAMAGE.name = "WEAK_POINT_DAMAGE"
enum_item_descriptors.Attribute_WEAK_POINT_DAMAGE.index = 25
enum_item_descriptors.Attribute_WEAK_POINT_DAMAGE.number = 28
enum_item_descriptors.Attribute_SKILL_CD_OFFSET.name = "SKILL_CD_OFFSET"
enum_item_descriptors.Attribute_SKILL_CD_OFFSET.index = 26
enum_item_descriptors.Attribute_SKILL_CD_OFFSET.number = 29
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_EXTRA.name = "DAMAGE_ENHANCE_EXTRA"
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_EXTRA.index = 27
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_EXTRA.number = 30
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_MOONRING.name = "DAMAGE_ENHANCE_MOONRING"
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_MOONRING.index = 28
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_MOONRING.number = 31
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_CHASE.name = "DAMAGE_ENHANCE_CHASE"
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_CHASE.index = 29
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_CHASE.number = 32
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_BOMB.name = "DAMAGE_ENHANCE_BOMB"
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_BOMB.index = 30
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_BOMB.number = 33
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_BORESPINE.name = "DAMAGE_ENHANCE_BORESPINE"
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_BORESPINE.index = 31
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_BORESPINE.number = 34
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_ARCLIGHT.name = "DAMAGE_ENHANCE_ARCLIGHT"
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_ARCLIGHT.index = 32
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_ARCLIGHT.number = 35
enum_item_descriptors.Attribute_BLADE_EDGE_MIN_LAYER.name = "BLADE_EDGE_MIN_LAYER"
enum_item_descriptors.Attribute_BLADE_EDGE_MIN_LAYER.index = 33
enum_item_descriptors.Attribute_BLADE_EDGE_MIN_LAYER.number = 36
enum_item_descriptors.Attribute_BLADE_EDGE_MAX_LAYER.name = "BLADE_EDGE_MAX_LAYER"
enum_item_descriptors.Attribute_BLADE_EDGE_MAX_LAYER.index = 34
enum_item_descriptors.Attribute_BLADE_EDGE_MAX_LAYER.number = 37
enum_item_descriptors.Attribute_AGILE_MIN_LAYER.name = "AGILE_MIN_LAYER"
enum_item_descriptors.Attribute_AGILE_MIN_LAYER.index = 35
enum_item_descriptors.Attribute_AGILE_MIN_LAYER.number = 38
enum_item_descriptors.Attribute_AGILE_MAX_LAYER.name = "AGILE_MAX_LAYER"
enum_item_descriptors.Attribute_AGILE_MAX_LAYER.index = 36
enum_item_descriptors.Attribute_AGILE_MAX_LAYER.number = 39
enum_item_descriptors.Attribute_DEFENSE_MIN_LAYER.name = "DEFENSE_MIN_LAYER"
enum_item_descriptors.Attribute_DEFENSE_MIN_LAYER.index = 37
enum_item_descriptors.Attribute_DEFENSE_MIN_LAYER.number = 40
enum_item_descriptors.Attribute_DEFENSE_MAX_LAYER.name = "DEFENSE_MAX_LAYER"
enum_item_descriptors.Attribute_DEFENSE_MAX_LAYER.index = 38
enum_item_descriptors.Attribute_DEFENSE_MAX_LAYER.number = 41
enum_item_descriptors.Attribute_DECLINE_MIN_LAYER.name = "DECLINE_MIN_LAYER"
enum_item_descriptors.Attribute_DECLINE_MIN_LAYER.index = 39
enum_item_descriptors.Attribute_DECLINE_MIN_LAYER.number = 42
enum_item_descriptors.Attribute_DECLINE_MAX_LAYER.name = "DECLINE_MAX_LAYER"
enum_item_descriptors.Attribute_DECLINE_MAX_LAYER.index = 40
enum_item_descriptors.Attribute_DECLINE_MAX_LAYER.number = 43
enum_item_descriptors.Attribute_WEAK_MIN_LAYER.name = "WEAK_MIN_LAYER"
enum_item_descriptors.Attribute_WEAK_MIN_LAYER.index = 41
enum_item_descriptors.Attribute_WEAK_MIN_LAYER.number = 44
enum_item_descriptors.Attribute_WEAK_MAX_LAYER.name = "WEAK_MAX_LAYER"
enum_item_descriptors.Attribute_WEAK_MAX_LAYER.index = 42
enum_item_descriptors.Attribute_WEAK_MAX_LAYER.number = 45
enum_item_descriptors.Attribute_EROSION_MIN_LAYER.name = "EROSION_MIN_LAYER"
enum_item_descriptors.Attribute_EROSION_MIN_LAYER.index = 43
enum_item_descriptors.Attribute_EROSION_MIN_LAYER.number = 46
enum_item_descriptors.Attribute_EROSION_MAX_LAYER.name = "EROSION_MAX_LAYER"
enum_item_descriptors.Attribute_EROSION_MAX_LAYER.index = 44
enum_item_descriptors.Attribute_EROSION_MAX_LAYER.number = 47
enum_item_descriptors.Attribute_ROAR_MIN_LAYER.name = "ROAR_MIN_LAYER"
enum_item_descriptors.Attribute_ROAR_MIN_LAYER.index = 45
enum_item_descriptors.Attribute_ROAR_MIN_LAYER.number = 48
enum_item_descriptors.Attribute_ROAR_MAX_LAYER.name = "ROAR_MAX_LAYER"
enum_item_descriptors.Attribute_ROAR_MAX_LAYER.index = 46
enum_item_descriptors.Attribute_ROAR_MAX_LAYER.number = 49
enum_item_descriptors.Attribute_MAD_MIN_LAYER.name = "MAD_MIN_LAYER"
enum_item_descriptors.Attribute_MAD_MIN_LAYER.index = 47
enum_item_descriptors.Attribute_MAD_MIN_LAYER.number = 50
enum_item_descriptors.Attribute_MAD_MAX_LAYER.name = "MAD_MAX_LAYER"
enum_item_descriptors.Attribute_MAD_MAX_LAYER.index = 48
enum_item_descriptors.Attribute_MAD_MAX_LAYER.number = 51
enum_item_descriptors.Attribute_PENETRATE_MIN_LAYER.name = "PENETRATE_MIN_LAYER"
enum_item_descriptors.Attribute_PENETRATE_MIN_LAYER.index = 49
enum_item_descriptors.Attribute_PENETRATE_MIN_LAYER.number = 52
enum_item_descriptors.Attribute_PENETRATE_MAX_LAYER.name = "PENETRATE_MAX_LAYER"
enum_item_descriptors.Attribute_PENETRATE_MAX_LAYER.index = 50
enum_item_descriptors.Attribute_PENETRATE_MAX_LAYER.number = 53
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_SNIPE.name = "DAMAGE_ENHANCE_SNIPE"
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_SNIPE.index = 51
enum_item_descriptors.Attribute_DAMAGE_ENHANCE_SNIPE.number = 54
enum_item_descriptors.Attribute_PIERCED_TIMES.name = "PIERCED_TIMES"
enum_item_descriptors.Attribute_PIERCED_TIMES.index = 52
enum_item_descriptors.Attribute_PIERCED_TIMES.number = 55
enum_item_descriptors.Attribute_NORMAL_SKILL_CD_OFFSET.name = "NORMAL_SKILL_CD_OFFSET"
enum_item_descriptors.Attribute_NORMAL_SKILL_CD_OFFSET.index = 53
enum_item_descriptors.Attribute_NORMAL_SKILL_CD_OFFSET.number = 56
enum_item_descriptors.Attribute_SPECIAL_SKILL_CD_OFFSET.name = "SPECIAL_SKILL_CD_OFFSET"
enum_item_descriptors.Attribute_SPECIAL_SKILL_CD_OFFSET.index = 54
enum_item_descriptors.Attribute_SPECIAL_SKILL_CD_OFFSET.number = 57
enum_item_descriptors.Attribute_TRUMP_SKILL_CD_OFFSET.name = "TRUMP_SKILL_CD_OFFSET"
enum_item_descriptors.Attribute_TRUMP_SKILL_CD_OFFSET.index = 55
enum_item_descriptors.Attribute_TRUMP_SKILL_CD_OFFSET.number = 58
type_descriptors.Attribute.name = "Attribute"
type_descriptors.Attribute.full_name = ".Attribute"
type_descriptors.Attribute.values = {
	enum_item_descriptors.Attribute_MOVE,
	enum_item_descriptors.Attribute_MAX_HP,
	enum_item_descriptors.Attribute_ATK_PHY,
	enum_item_descriptors.Attribute_DEF_PHY,
	enum_item_descriptors.Attribute_ATK_MAG,
	enum_item_descriptors.Attribute_DEF_MAG,
	enum_item_descriptors.Attribute_INSPIRATION,
	enum_item_descriptors.Attribute_DAMAGE_ENHANCE,
	enum_item_descriptors.Attribute_DAMAGE_REDUCE,
	enum_item_descriptors.Attribute_CRIT_ENHANCE,
	enum_item_descriptors.Attribute_CRIT_REDUCE,
	enum_item_descriptors.Attribute_RESTRAIN_ENHANCE,
	enum_item_descriptors.Attribute_RESTRAIN_REDUCE,
	enum_item_descriptors.Attribute_CURE,
	enum_item_descriptors.Attribute_BE_CURED,
	enum_item_descriptors.Attribute_SUCK,
	enum_item_descriptors.Attribute_SAN_GROW,
	enum_item_descriptors.Attribute_SAN_BACK,
	enum_item_descriptors.Attribute_IGNORE_PHY,
	enum_item_descriptors.Attribute_IGNORE_MAG,
	enum_item_descriptors.Attribute_CURRENT_HP,
	enum_item_descriptors.Attribute_CURRENT_SAN,
	enum_item_descriptors.Attribute_CURRENT_HP_RATE,
	enum_item_descriptors.Attribute_LOST_HP_RATE,
	enum_item_descriptors.Attribute_FIGHTING_CAPACITY,
	enum_item_descriptors.Attribute_WEAK_POINT_DAMAGE,
	enum_item_descriptors.Attribute_SKILL_CD_OFFSET,
	enum_item_descriptors.Attribute_DAMAGE_ENHANCE_EXTRA,
	enum_item_descriptors.Attribute_DAMAGE_ENHANCE_MOONRING,
	enum_item_descriptors.Attribute_DAMAGE_ENHANCE_CHASE,
	enum_item_descriptors.Attribute_DAMAGE_ENHANCE_BOMB,
	enum_item_descriptors.Attribute_DAMAGE_ENHANCE_BORESPINE,
	enum_item_descriptors.Attribute_DAMAGE_ENHANCE_ARCLIGHT,
	enum_item_descriptors.Attribute_BLADE_EDGE_MIN_LAYER,
	enum_item_descriptors.Attribute_BLADE_EDGE_MAX_LAYER,
	enum_item_descriptors.Attribute_AGILE_MIN_LAYER,
	enum_item_descriptors.Attribute_AGILE_MAX_LAYER,
	enum_item_descriptors.Attribute_DEFENSE_MIN_LAYER,
	enum_item_descriptors.Attribute_DEFENSE_MAX_LAYER,
	enum_item_descriptors.Attribute_DECLINE_MIN_LAYER,
	enum_item_descriptors.Attribute_DECLINE_MAX_LAYER,
	enum_item_descriptors.Attribute_WEAK_MIN_LAYER,
	enum_item_descriptors.Attribute_WEAK_MAX_LAYER,
	enum_item_descriptors.Attribute_EROSION_MIN_LAYER,
	enum_item_descriptors.Attribute_EROSION_MAX_LAYER,
	enum_item_descriptors.Attribute_ROAR_MIN_LAYER,
	enum_item_descriptors.Attribute_ROAR_MAX_LAYER,
	enum_item_descriptors.Attribute_MAD_MIN_LAYER,
	enum_item_descriptors.Attribute_MAD_MAX_LAYER,
	enum_item_descriptors.Attribute_PENETRATE_MIN_LAYER,
	enum_item_descriptors.Attribute_PENETRATE_MAX_LAYER,
	enum_item_descriptors.Attribute_DAMAGE_ENHANCE_SNIPE,
	enum_item_descriptors.Attribute_PIERCED_TIMES,
	enum_item_descriptors.Attribute_NORMAL_SKILL_CD_OFFSET,
	enum_item_descriptors.Attribute_SPECIAL_SKILL_CD_OFFSET,
	enum_item_descriptors.Attribute_TRUMP_SKILL_CD_OFFSET
}
enum_item_descriptors.AttributePart_PART_CURRENT_SAN.name = "PART_CURRENT_SAN"
enum_item_descriptors.AttributePart_PART_CURRENT_SAN.index = 0
enum_item_descriptors.AttributePart_PART_CURRENT_SAN.number = 1
enum_item_descriptors.AttributePart_PART_MOVE.name = "PART_MOVE"
enum_item_descriptors.AttributePart_PART_MOVE.index = 1
enum_item_descriptors.AttributePart_PART_MOVE.number = 3
enum_item_descriptors.AttributePart_PART_CURRENT_HP.name = "PART_CURRENT_HP"
enum_item_descriptors.AttributePart_PART_CURRENT_HP.index = 2
enum_item_descriptors.AttributePart_PART_CURRENT_HP.number = 4
enum_item_descriptors.AttributePart_PART_INSPIRATION.name = "PART_INSPIRATION"
enum_item_descriptors.AttributePart_PART_INSPIRATION.index = 3
enum_item_descriptors.AttributePart_PART_INSPIRATION.number = 5
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE.name = "PART_DAMAGE_ENHANCE"
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE.index = 4
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE.number = 6
enum_item_descriptors.AttributePart_PART_DAMAGE_REDUCE.name = "PART_DAMAGE_REDUCE"
enum_item_descriptors.AttributePart_PART_DAMAGE_REDUCE.index = 5
enum_item_descriptors.AttributePart_PART_DAMAGE_REDUCE.number = 7
enum_item_descriptors.AttributePart_PART_CRIT_ENHANCE.name = "PART_CRIT_ENHANCE"
enum_item_descriptors.AttributePart_PART_CRIT_ENHANCE.index = 6
enum_item_descriptors.AttributePart_PART_CRIT_ENHANCE.number = 8
enum_item_descriptors.AttributePart_PART_CRIT_REDUCE.name = "PART_CRIT_REDUCE"
enum_item_descriptors.AttributePart_PART_CRIT_REDUCE.index = 7
enum_item_descriptors.AttributePart_PART_CRIT_REDUCE.number = 9
enum_item_descriptors.AttributePart_PART_RESTRAIN_ENHANCE.name = "PART_RESTRAIN_ENHANCE"
enum_item_descriptors.AttributePart_PART_RESTRAIN_ENHANCE.index = 8
enum_item_descriptors.AttributePart_PART_RESTRAIN_ENHANCE.number = 10
enum_item_descriptors.AttributePart_PART_RESTRAIN_REDUCE.name = "PART_RESTRAIN_REDUCE"
enum_item_descriptors.AttributePart_PART_RESTRAIN_REDUCE.index = 9
enum_item_descriptors.AttributePart_PART_RESTRAIN_REDUCE.number = 11
enum_item_descriptors.AttributePart_PART_CURE.name = "PART_CURE"
enum_item_descriptors.AttributePart_PART_CURE.index = 10
enum_item_descriptors.AttributePart_PART_CURE.number = 12
enum_item_descriptors.AttributePart_PART_BE_CURED.name = "PART_BE_CURED"
enum_item_descriptors.AttributePart_PART_BE_CURED.index = 11
enum_item_descriptors.AttributePart_PART_BE_CURED.number = 13
enum_item_descriptors.AttributePart_PART_SUCK.name = "PART_SUCK"
enum_item_descriptors.AttributePart_PART_SUCK.index = 12
enum_item_descriptors.AttributePart_PART_SUCK.number = 14
enum_item_descriptors.AttributePart_PART_SAN_GROW.name = "PART_SAN_GROW"
enum_item_descriptors.AttributePart_PART_SAN_GROW.index = 13
enum_item_descriptors.AttributePart_PART_SAN_GROW.number = 15
enum_item_descriptors.AttributePart_PART_SAN_BACK.name = "PART_SAN_BACK"
enum_item_descriptors.AttributePart_PART_SAN_BACK.index = 14
enum_item_descriptors.AttributePart_PART_SAN_BACK.number = 16
enum_item_descriptors.AttributePart_PART_IGNORE_PHY.name = "PART_IGNORE_PHY"
enum_item_descriptors.AttributePart_PART_IGNORE_PHY.index = 15
enum_item_descriptors.AttributePart_PART_IGNORE_PHY.number = 17
enum_item_descriptors.AttributePart_PART_IGNORE_MAG.name = "PART_IGNORE_MAG"
enum_item_descriptors.AttributePart_PART_IGNORE_MAG.index = 16
enum_item_descriptors.AttributePart_PART_IGNORE_MAG.number = 18
enum_item_descriptors.AttributePart_PART_MAX_HP_BASE.name = "PART_MAX_HP_BASE"
enum_item_descriptors.AttributePart_PART_MAX_HP_BASE.index = 17
enum_item_descriptors.AttributePart_PART_MAX_HP_BASE.number = 19
enum_item_descriptors.AttributePart_PART_MAX_HP_MULTIPLICATION.name = "PART_MAX_HP_MULTIPLICATION"
enum_item_descriptors.AttributePart_PART_MAX_HP_MULTIPLICATION.index = 18
enum_item_descriptors.AttributePart_PART_MAX_HP_MULTIPLICATION.number = 20
enum_item_descriptors.AttributePart_PART_MAX_HP_ADDITION.name = "PART_MAX_HP_ADDITION"
enum_item_descriptors.AttributePart_PART_MAX_HP_ADDITION.index = 19
enum_item_descriptors.AttributePart_PART_MAX_HP_ADDITION.number = 21
enum_item_descriptors.AttributePart_PART_ATK_PHY_BASE.name = "PART_ATK_PHY_BASE"
enum_item_descriptors.AttributePart_PART_ATK_PHY_BASE.index = 20
enum_item_descriptors.AttributePart_PART_ATK_PHY_BASE.number = 22
enum_item_descriptors.AttributePart_PART_ATK_PHY_MULTIPLICATION.name = "PART_ATK_PHY_MULTIPLICATION"
enum_item_descriptors.AttributePart_PART_ATK_PHY_MULTIPLICATION.index = 21
enum_item_descriptors.AttributePart_PART_ATK_PHY_MULTIPLICATION.number = 23
enum_item_descriptors.AttributePart_PART_ATK_PHY_ADDITION.name = "PART_ATK_PHY_ADDITION"
enum_item_descriptors.AttributePart_PART_ATK_PHY_ADDITION.index = 22
enum_item_descriptors.AttributePart_PART_ATK_PHY_ADDITION.number = 24
enum_item_descriptors.AttributePart_PART_DEF_PHY_BASE.name = "PART_DEF_PHY_BASE"
enum_item_descriptors.AttributePart_PART_DEF_PHY_BASE.index = 23
enum_item_descriptors.AttributePart_PART_DEF_PHY_BASE.number = 25
enum_item_descriptors.AttributePart_PART_DEF_PHY_MULTIPLICATION.name = "PART_DEF_PHY_MULTIPLICATION"
enum_item_descriptors.AttributePart_PART_DEF_PHY_MULTIPLICATION.index = 24
enum_item_descriptors.AttributePart_PART_DEF_PHY_MULTIPLICATION.number = 26
enum_item_descriptors.AttributePart_PART_DEF_PHY_ADDITION.name = "PART_DEF_PHY_ADDITION"
enum_item_descriptors.AttributePart_PART_DEF_PHY_ADDITION.index = 25
enum_item_descriptors.AttributePart_PART_DEF_PHY_ADDITION.number = 27
enum_item_descriptors.AttributePart_PART_ATK_MAG_BASE.name = "PART_ATK_MAG_BASE"
enum_item_descriptors.AttributePart_PART_ATK_MAG_BASE.index = 26
enum_item_descriptors.AttributePart_PART_ATK_MAG_BASE.number = 28
enum_item_descriptors.AttributePart_PART_ATK_MAG_MULTIPLICATION.name = "PART_ATK_MAG_MULTIPLICATION"
enum_item_descriptors.AttributePart_PART_ATK_MAG_MULTIPLICATION.index = 27
enum_item_descriptors.AttributePart_PART_ATK_MAG_MULTIPLICATION.number = 29
enum_item_descriptors.AttributePart_PART_ATK_MAG_ADDITION.name = "PART_ATK_MAG_ADDITION"
enum_item_descriptors.AttributePart_PART_ATK_MAG_ADDITION.index = 28
enum_item_descriptors.AttributePart_PART_ATK_MAG_ADDITION.number = 30
enum_item_descriptors.AttributePart_PART_DEF_MAG_BASE.name = "PART_DEF_MAG_BASE"
enum_item_descriptors.AttributePart_PART_DEF_MAG_BASE.index = 29
enum_item_descriptors.AttributePart_PART_DEF_MAG_BASE.number = 31
enum_item_descriptors.AttributePart_PART_DEF_MAG_MULTIPLICATION.name = "PART_DEF_MAG_MULTIPLICATION"
enum_item_descriptors.AttributePart_PART_DEF_MAG_MULTIPLICATION.index = 30
enum_item_descriptors.AttributePart_PART_DEF_MAG_MULTIPLICATION.number = 32
enum_item_descriptors.AttributePart_PART_DEF_MAG_ADDITION.name = "PART_DEF_MAG_ADDITION"
enum_item_descriptors.AttributePart_PART_DEF_MAG_ADDITION.index = 31
enum_item_descriptors.AttributePart_PART_DEF_MAG_ADDITION.number = 33
enum_item_descriptors.AttributePart_PART_WEAK_POINT_DAMAGE.name = "PART_WEAK_POINT_DAMAGE"
enum_item_descriptors.AttributePart_PART_WEAK_POINT_DAMAGE.index = 32
enum_item_descriptors.AttributePart_PART_WEAK_POINT_DAMAGE.number = 34
enum_item_descriptors.AttributePart_PART_SKILL_CD_OFFSET.name = "PART_SKILL_CD_OFFSET"
enum_item_descriptors.AttributePart_PART_SKILL_CD_OFFSET.index = 33
enum_item_descriptors.AttributePart_PART_SKILL_CD_OFFSET.number = 35
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_EXTRA.name = "PART_DAMAGE_ENHANCE_EXTRA"
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_EXTRA.index = 34
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_EXTRA.number = 36
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_MOONRING.name = "PART_DAMAGE_ENHANCE_MOONRING"
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_MOONRING.index = 35
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_MOONRING.number = 37
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_CHASE.name = "PART_DAMAGE_ENHANCE_CHASE"
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_CHASE.index = 36
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_CHASE.number = 38
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_BOMB.name = "PART_DAMAGE_ENHANCE_BOMB"
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_BOMB.index = 37
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_BOMB.number = 39
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_BORESPINE.name = "PART_DAMAGE_ENHANCE_BORESPINE"
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_BORESPINE.index = 38
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_BORESPINE.number = 40
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_ARCLIGHT.name = "PART_DAMAGE_ENHANCE_ARCLIGHT"
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_ARCLIGHT.index = 39
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_ARCLIGHT.number = 41
enum_item_descriptors.AttributePart_PART_BLADE_EDGE_MIN_LAYER.name = "PART_BLADE_EDGE_MIN_LAYER"
enum_item_descriptors.AttributePart_PART_BLADE_EDGE_MIN_LAYER.index = 40
enum_item_descriptors.AttributePart_PART_BLADE_EDGE_MIN_LAYER.number = 42
enum_item_descriptors.AttributePart_PART_BLADE_EDGE_MAX_LAYER.name = "PART_BLADE_EDGE_MAX_LAYER"
enum_item_descriptors.AttributePart_PART_BLADE_EDGE_MAX_LAYER.index = 41
enum_item_descriptors.AttributePart_PART_BLADE_EDGE_MAX_LAYER.number = 43
enum_item_descriptors.AttributePart_PART_AGILE_MIN_LAYER.name = "PART_AGILE_MIN_LAYER"
enum_item_descriptors.AttributePart_PART_AGILE_MIN_LAYER.index = 42
enum_item_descriptors.AttributePart_PART_AGILE_MIN_LAYER.number = 44
enum_item_descriptors.AttributePart_PART_AGILE_MAX_LAYER.name = "PART_AGILE_MAX_LAYER"
enum_item_descriptors.AttributePart_PART_AGILE_MAX_LAYER.index = 43
enum_item_descriptors.AttributePart_PART_AGILE_MAX_LAYER.number = 45
enum_item_descriptors.AttributePart_PART_DEFENSE_MIN_LAYER.name = "PART_DEFENSE_MIN_LAYER"
enum_item_descriptors.AttributePart_PART_DEFENSE_MIN_LAYER.index = 44
enum_item_descriptors.AttributePart_PART_DEFENSE_MIN_LAYER.number = 46
enum_item_descriptors.AttributePart_PART_DEFENSE_MAX_LAYER.name = "PART_DEFENSE_MAX_LAYER"
enum_item_descriptors.AttributePart_PART_DEFENSE_MAX_LAYER.index = 45
enum_item_descriptors.AttributePart_PART_DEFENSE_MAX_LAYER.number = 47
enum_item_descriptors.AttributePart_PART_DECLINE_MIN_LAYER.name = "PART_DECLINE_MIN_LAYER"
enum_item_descriptors.AttributePart_PART_DECLINE_MIN_LAYER.index = 46
enum_item_descriptors.AttributePart_PART_DECLINE_MIN_LAYER.number = 48
enum_item_descriptors.AttributePart_PART_DECLINE_MAX_LAYER.name = "PART_DECLINE_MAX_LAYER"
enum_item_descriptors.AttributePart_PART_DECLINE_MAX_LAYER.index = 47
enum_item_descriptors.AttributePart_PART_DECLINE_MAX_LAYER.number = 49
enum_item_descriptors.AttributePart_PART_WEAK_MIN_LAYER.name = "PART_WEAK_MIN_LAYER"
enum_item_descriptors.AttributePart_PART_WEAK_MIN_LAYER.index = 48
enum_item_descriptors.AttributePart_PART_WEAK_MIN_LAYER.number = 50
enum_item_descriptors.AttributePart_PART_WEAK_MAX_LAYER.name = "PART_WEAK_MAX_LAYER"
enum_item_descriptors.AttributePart_PART_WEAK_MAX_LAYER.index = 49
enum_item_descriptors.AttributePart_PART_WEAK_MAX_LAYER.number = 51
enum_item_descriptors.AttributePart_PART_EROSION_MIN_LAYER.name = "PART_EROSION_MIN_LAYER"
enum_item_descriptors.AttributePart_PART_EROSION_MIN_LAYER.index = 50
enum_item_descriptors.AttributePart_PART_EROSION_MIN_LAYER.number = 52
enum_item_descriptors.AttributePart_PART_EROSION_MAX_LAYER.name = "PART_EROSION_MAX_LAYER"
enum_item_descriptors.AttributePart_PART_EROSION_MAX_LAYER.index = 51
enum_item_descriptors.AttributePart_PART_EROSION_MAX_LAYER.number = 53
enum_item_descriptors.AttributePart_PART_ROAR_MIN_LAYER.name = "PART_ROAR_MIN_LAYER"
enum_item_descriptors.AttributePart_PART_ROAR_MIN_LAYER.index = 52
enum_item_descriptors.AttributePart_PART_ROAR_MIN_LAYER.number = 54
enum_item_descriptors.AttributePart_PART_ROAR_MAX_LAYER.name = "PART_ROAR_MAX_LAYER"
enum_item_descriptors.AttributePart_PART_ROAR_MAX_LAYER.index = 53
enum_item_descriptors.AttributePart_PART_ROAR_MAX_LAYER.number = 55
enum_item_descriptors.AttributePart_PART_MAD_MIN_LAYER.name = "PART_MAD_MIN_LAYER"
enum_item_descriptors.AttributePart_PART_MAD_MIN_LAYER.index = 54
enum_item_descriptors.AttributePart_PART_MAD_MIN_LAYER.number = 56
enum_item_descriptors.AttributePart_PART_MAD_MAX_LAYER.name = "PART_MAD_MAX_LAYER"
enum_item_descriptors.AttributePart_PART_MAD_MAX_LAYER.index = 55
enum_item_descriptors.AttributePart_PART_MAD_MAX_LAYER.number = 57
enum_item_descriptors.AttributePart_PART_PENETRATE_MIN_LAYER.name = "PART_PENETRATE_MIN_LAYER"
enum_item_descriptors.AttributePart_PART_PENETRATE_MIN_LAYER.index = 56
enum_item_descriptors.AttributePart_PART_PENETRATE_MIN_LAYER.number = 58
enum_item_descriptors.AttributePart_PART_PENETRATE_MAX_LAYER.name = "PART_PENETRATE_MAX_LAYER"
enum_item_descriptors.AttributePart_PART_PENETRATE_MAX_LAYER.index = 57
enum_item_descriptors.AttributePart_PART_PENETRATE_MAX_LAYER.number = 59
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_SNIPE.name = "PART_DAMAGE_ENHANCE_SNIPE"
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_SNIPE.index = 58
enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_SNIPE.number = 60
enum_item_descriptors.AttributePart_PART_PIERCED_TIMES.name = "PART_PIERCED_TIMES"
enum_item_descriptors.AttributePart_PART_PIERCED_TIMES.index = 59
enum_item_descriptors.AttributePart_PART_PIERCED_TIMES.number = 61
enum_item_descriptors.AttributePart_PART_NORMAL_SKILL_CD_OFFSET.name = "PART_NORMAL_SKILL_CD_OFFSET"
enum_item_descriptors.AttributePart_PART_NORMAL_SKILL_CD_OFFSET.index = 60
enum_item_descriptors.AttributePart_PART_NORMAL_SKILL_CD_OFFSET.number = 62
enum_item_descriptors.AttributePart_PART_SPECIAL_SKILL_CD_OFFSET.name = "PART_SPECIAL_SKILL_CD_OFFSET"
enum_item_descriptors.AttributePart_PART_SPECIAL_SKILL_CD_OFFSET.index = 61
enum_item_descriptors.AttributePart_PART_SPECIAL_SKILL_CD_OFFSET.number = 63
enum_item_descriptors.AttributePart_PART_TRUMP_SKILL_CD_OFFSET.name = "PART_TRUMP_SKILL_CD_OFFSET"
enum_item_descriptors.AttributePart_PART_TRUMP_SKILL_CD_OFFSET.index = 62
enum_item_descriptors.AttributePart_PART_TRUMP_SKILL_CD_OFFSET.number = 64
type_descriptors.AttributePart.name = "AttributePart"
type_descriptors.AttributePart.full_name = ".AttributePart"
type_descriptors.AttributePart.values = {
	enum_item_descriptors.AttributePart_PART_CURRENT_SAN,
	enum_item_descriptors.AttributePart_PART_MOVE,
	enum_item_descriptors.AttributePart_PART_CURRENT_HP,
	enum_item_descriptors.AttributePart_PART_INSPIRATION,
	enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE,
	enum_item_descriptors.AttributePart_PART_DAMAGE_REDUCE,
	enum_item_descriptors.AttributePart_PART_CRIT_ENHANCE,
	enum_item_descriptors.AttributePart_PART_CRIT_REDUCE,
	enum_item_descriptors.AttributePart_PART_RESTRAIN_ENHANCE,
	enum_item_descriptors.AttributePart_PART_RESTRAIN_REDUCE,
	enum_item_descriptors.AttributePart_PART_CURE,
	enum_item_descriptors.AttributePart_PART_BE_CURED,
	enum_item_descriptors.AttributePart_PART_SUCK,
	enum_item_descriptors.AttributePart_PART_SAN_GROW,
	enum_item_descriptors.AttributePart_PART_SAN_BACK,
	enum_item_descriptors.AttributePart_PART_IGNORE_PHY,
	enum_item_descriptors.AttributePart_PART_IGNORE_MAG,
	enum_item_descriptors.AttributePart_PART_MAX_HP_BASE,
	enum_item_descriptors.AttributePart_PART_MAX_HP_MULTIPLICATION,
	enum_item_descriptors.AttributePart_PART_MAX_HP_ADDITION,
	enum_item_descriptors.AttributePart_PART_ATK_PHY_BASE,
	enum_item_descriptors.AttributePart_PART_ATK_PHY_MULTIPLICATION,
	enum_item_descriptors.AttributePart_PART_ATK_PHY_ADDITION,
	enum_item_descriptors.AttributePart_PART_DEF_PHY_BASE,
	enum_item_descriptors.AttributePart_PART_DEF_PHY_MULTIPLICATION,
	enum_item_descriptors.AttributePart_PART_DEF_PHY_ADDITION,
	enum_item_descriptors.AttributePart_PART_ATK_MAG_BASE,
	enum_item_descriptors.AttributePart_PART_ATK_MAG_MULTIPLICATION,
	enum_item_descriptors.AttributePart_PART_ATK_MAG_ADDITION,
	enum_item_descriptors.AttributePart_PART_DEF_MAG_BASE,
	enum_item_descriptors.AttributePart_PART_DEF_MAG_MULTIPLICATION,
	enum_item_descriptors.AttributePart_PART_DEF_MAG_ADDITION,
	enum_item_descriptors.AttributePart_PART_WEAK_POINT_DAMAGE,
	enum_item_descriptors.AttributePart_PART_SKILL_CD_OFFSET,
	enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_EXTRA,
	enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_MOONRING,
	enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_CHASE,
	enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_BOMB,
	enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_BORESPINE,
	enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_ARCLIGHT,
	enum_item_descriptors.AttributePart_PART_BLADE_EDGE_MIN_LAYER,
	enum_item_descriptors.AttributePart_PART_BLADE_EDGE_MAX_LAYER,
	enum_item_descriptors.AttributePart_PART_AGILE_MIN_LAYER,
	enum_item_descriptors.AttributePart_PART_AGILE_MAX_LAYER,
	enum_item_descriptors.AttributePart_PART_DEFENSE_MIN_LAYER,
	enum_item_descriptors.AttributePart_PART_DEFENSE_MAX_LAYER,
	enum_item_descriptors.AttributePart_PART_DECLINE_MIN_LAYER,
	enum_item_descriptors.AttributePart_PART_DECLINE_MAX_LAYER,
	enum_item_descriptors.AttributePart_PART_WEAK_MIN_LAYER,
	enum_item_descriptors.AttributePart_PART_WEAK_MAX_LAYER,
	enum_item_descriptors.AttributePart_PART_EROSION_MIN_LAYER,
	enum_item_descriptors.AttributePart_PART_EROSION_MAX_LAYER,
	enum_item_descriptors.AttributePart_PART_ROAR_MIN_LAYER,
	enum_item_descriptors.AttributePart_PART_ROAR_MAX_LAYER,
	enum_item_descriptors.AttributePart_PART_MAD_MIN_LAYER,
	enum_item_descriptors.AttributePart_PART_MAD_MAX_LAYER,
	enum_item_descriptors.AttributePart_PART_PENETRATE_MIN_LAYER,
	enum_item_descriptors.AttributePart_PART_PENETRATE_MAX_LAYER,
	enum_item_descriptors.AttributePart_PART_DAMAGE_ENHANCE_SNIPE,
	enum_item_descriptors.AttributePart_PART_PIERCED_TIMES,
	enum_item_descriptors.AttributePart_PART_NORMAL_SKILL_CD_OFFSET,
	enum_item_descriptors.AttributePart_PART_SPECIAL_SKILL_CD_OFFSET,
	enum_item_descriptors.AttributePart_PART_TRUMP_SKILL_CD_OFFSET
}
enum_item_descriptors.DeadReason_HP_0_BY_ATTACK.name = "HP_0_BY_ATTACK"
enum_item_descriptors.DeadReason_HP_0_BY_ATTACK.index = 0
enum_item_descriptors.DeadReason_HP_0_BY_ATTACK.number = 1
enum_item_descriptors.DeadReason_HP_0_BY_BUFF.name = "HP_0_BY_BUFF"
enum_item_descriptors.DeadReason_HP_0_BY_BUFF.index = 1
enum_item_descriptors.DeadReason_HP_0_BY_BUFF.number = 2
enum_item_descriptors.DeadReason_SANITY_LOW.name = "SANITY_LOW"
enum_item_descriptors.DeadReason_SANITY_LOW.index = 2
enum_item_descriptors.DeadReason_SANITY_LOW.number = 3
enum_item_descriptors.DeadReason_HP_0_BY_SKILL.name = "HP_0_BY_SKILL"
enum_item_descriptors.DeadReason_HP_0_BY_SKILL.index = 3
enum_item_descriptors.DeadReason_HP_0_BY_SKILL.number = 4
type_descriptors.DeadReason.name = "DeadReason"
type_descriptors.DeadReason.full_name = ".DeadReason"
type_descriptors.DeadReason.values = {
	enum_item_descriptors.DeadReason_HP_0_BY_ATTACK,
	enum_item_descriptors.DeadReason_HP_0_BY_BUFF,
	enum_item_descriptors.DeadReason_SANITY_LOW,
	enum_item_descriptors.DeadReason_HP_0_BY_SKILL
}
enum_item_descriptors.State_CANNOT_NORMAL_ATTACK.name = "CANNOT_NORMAL_ATTACK"
enum_item_descriptors.State_CANNOT_NORMAL_ATTACK.index = 0
enum_item_descriptors.State_CANNOT_NORMAL_ATTACK.number = 1
enum_item_descriptors.State_CANNOT_MOVE.name = "CANNOT_MOVE"
enum_item_descriptors.State_CANNOT_MOVE.index = 1
enum_item_descriptors.State_CANNOT_MOVE.number = 2
enum_item_descriptors.State_IGNORE_DISTANCE_WHEN_COUNTER.name = "IGNORE_DISTANCE_WHEN_COUNTER"
enum_item_descriptors.State_IGNORE_DISTANCE_WHEN_COUNTER.index = 2
enum_item_descriptors.State_IGNORE_DISTANCE_WHEN_COUNTER.number = 3
enum_item_descriptors.State_COUNTER_BEFORE_ATTACK.name = "COUNTER_BEFORE_ATTACK"
enum_item_descriptors.State_COUNTER_BEFORE_ATTACK.index = 3
enum_item_descriptors.State_COUNTER_BEFORE_ATTACK.number = 4
enum_item_descriptors.State_CHASE.name = "CHASE"
enum_item_descriptors.State_CHASE.index = 4
enum_item_descriptors.State_CHASE.number = 5
enum_item_descriptors.State_DEFENDER_CANNOT_COUNTER.name = "DEFENDER_CANNOT_COUNTER"
enum_item_descriptors.State_DEFENDER_CANNOT_COUNTER.index = 5
enum_item_descriptors.State_DEFENDER_CANNOT_COUNTER.number = 6
enum_item_descriptors.State_IGNORE_NEAR.name = "IGNORE_NEAR"
enum_item_descriptors.State_IGNORE_NEAR.index = 6
enum_item_descriptors.State_IGNORE_NEAR.number = 7
enum_item_descriptors.State_NEXT_SKILL_ENHANCED.name = "NEXT_SKILL_ENHANCED"
enum_item_descriptors.State_NEXT_SKILL_ENHANCED.index = 7
enum_item_descriptors.State_NEXT_SKILL_ENHANCED.number = 8
enum_item_descriptors.State_STEPPABLE_AGAIN.name = "STEPPABLE_AGAIN"
enum_item_descriptors.State_STEPPABLE_AGAIN.index = 8
enum_item_descriptors.State_STEPPABLE_AGAIN.number = 9
enum_item_descriptors.State_SNIPING.name = "SNIPING"
enum_item_descriptors.State_SNIPING.index = 9
enum_item_descriptors.State_SNIPING.number = 10
enum_item_descriptors.State_ALWAYS_CRITICAL.name = "ALWAYS_CRITICAL"
enum_item_descriptors.State_ALWAYS_CRITICAL.index = 10
enum_item_descriptors.State_ALWAYS_CRITICAL.number = 11
enum_item_descriptors.State_DOUBLE_ATTACK.name = "DOUBLE_ATTACK"
enum_item_descriptors.State_DOUBLE_ATTACK.index = 11
enum_item_descriptors.State_DOUBLE_ATTACK.number = 12
enum_item_descriptors.State_SILENT.name = "SILENT"
enum_item_descriptors.State_SILENT.index = 12
enum_item_descriptors.State_SILENT.number = 13
enum_item_descriptors.State_DAMAGING_ONE_HP.name = "DAMAGING_ONE_HP"
enum_item_descriptors.State_DAMAGING_ONE_HP.index = 13
enum_item_descriptors.State_DAMAGING_ONE_HP.number = 14
enum_item_descriptors.State_CANNOT_INCR_HP.name = "CANNOT_INCR_HP"
enum_item_descriptors.State_CANNOT_INCR_HP.index = 14
enum_item_descriptors.State_CANNOT_INCR_HP.number = 15
enum_item_descriptors.State_INVINCIBLE.name = "INVINCIBLE"
enum_item_descriptors.State_INVINCIBLE.index = 15
enum_item_descriptors.State_INVINCIBLE.number = 16
enum_item_descriptors.State_PHYSICAL_DAMAGING_ONE_HP.name = "PHYSICAL_DAMAGING_ONE_HP"
enum_item_descriptors.State_PHYSICAL_DAMAGING_ONE_HP.index = 16
enum_item_descriptors.State_PHYSICAL_DAMAGING_ONE_HP.number = 17
enum_item_descriptors.State_MAGICAL_DAMAGING_ONE_HP.name = "MAGICAL_DAMAGING_ONE_HP"
enum_item_descriptors.State_MAGICAL_DAMAGING_ONE_HP.index = 17
enum_item_descriptors.State_MAGICAL_DAMAGING_ONE_HP.number = 18
enum_item_descriptors.State_CANNOT_COUNTER.name = "CANNOT_COUNTER"
enum_item_descriptors.State_CANNOT_COUNTER.index = 18
enum_item_descriptors.State_CANNOT_COUNTER.number = 19
enum_item_descriptors.State_CANNOT_CHANGE_POSITION.name = "CANNOT_CHANGE_POSITION"
enum_item_descriptors.State_CANNOT_CHANGE_POSITION.index = 19
enum_item_descriptors.State_CANNOT_CHANGE_POSITION.number = 20
enum_item_descriptors.State_PIERCEABLE.name = "PIERCEABLE"
enum_item_descriptors.State_PIERCEABLE.index = 20
enum_item_descriptors.State_PIERCEABLE.number = 21
enum_item_descriptors.State_CHANGE_CAMP_WHEN_OVERDRAWN.name = "CHANGE_CAMP_WHEN_OVERDRAWN"
enum_item_descriptors.State_CHANGE_CAMP_WHEN_OVERDRAWN.index = 21
enum_item_descriptors.State_CHANGE_CAMP_WHEN_OVERDRAWN.number = 22
enum_item_descriptors.State_IGNORE_BARRIER.name = "IGNORE_BARRIER"
enum_item_descriptors.State_IGNORE_BARRIER.index = 22
enum_item_descriptors.State_IGNORE_BARRIER.number = 23
type_descriptors.State.name = "State"
type_descriptors.State.full_name = ".State"
type_descriptors.State.values = {
	enum_item_descriptors.State_CANNOT_NORMAL_ATTACK,
	enum_item_descriptors.State_CANNOT_MOVE,
	enum_item_descriptors.State_IGNORE_DISTANCE_WHEN_COUNTER,
	enum_item_descriptors.State_COUNTER_BEFORE_ATTACK,
	enum_item_descriptors.State_CHASE,
	enum_item_descriptors.State_DEFENDER_CANNOT_COUNTER,
	enum_item_descriptors.State_IGNORE_NEAR,
	enum_item_descriptors.State_NEXT_SKILL_ENHANCED,
	enum_item_descriptors.State_STEPPABLE_AGAIN,
	enum_item_descriptors.State_SNIPING,
	enum_item_descriptors.State_ALWAYS_CRITICAL,
	enum_item_descriptors.State_DOUBLE_ATTACK,
	enum_item_descriptors.State_SILENT,
	enum_item_descriptors.State_DAMAGING_ONE_HP,
	enum_item_descriptors.State_CANNOT_INCR_HP,
	enum_item_descriptors.State_INVINCIBLE,
	enum_item_descriptors.State_PHYSICAL_DAMAGING_ONE_HP,
	enum_item_descriptors.State_MAGICAL_DAMAGING_ONE_HP,
	enum_item_descriptors.State_CANNOT_COUNTER,
	enum_item_descriptors.State_CANNOT_CHANGE_POSITION,
	enum_item_descriptors.State_PIERCEABLE,
	enum_item_descriptors.State_CHANGE_CAMP_WHEN_OVERDRAWN,
	enum_item_descriptors.State_IGNORE_BARRIER
}
enum_item_descriptors.MonsterType_MONSTER_TYPE_NORMAL.name = "MONSTER_TYPE_NORMAL"
enum_item_descriptors.MonsterType_MONSTER_TYPE_NORMAL.index = 0
enum_item_descriptors.MonsterType_MONSTER_TYPE_NORMAL.number = 0
enum_item_descriptors.MonsterType_MONSTER_TYPE_ELITE.name = "MONSTER_TYPE_ELITE"
enum_item_descriptors.MonsterType_MONSTER_TYPE_ELITE.index = 1
enum_item_descriptors.MonsterType_MONSTER_TYPE_ELITE.number = 1
enum_item_descriptors.MonsterType_MONSTER_TYPE_BOSS.name = "MONSTER_TYPE_BOSS"
enum_item_descriptors.MonsterType_MONSTER_TYPE_BOSS.index = 2
enum_item_descriptors.MonsterType_MONSTER_TYPE_BOSS.number = 2
type_descriptors.MonsterType.name = "MonsterType"
type_descriptors.MonsterType.full_name = ".MonsterType"
type_descriptors.MonsterType.values = {
	enum_item_descriptors.MonsterType_MONSTER_TYPE_NORMAL,
	enum_item_descriptors.MonsterType_MONSTER_TYPE_ELITE,
	enum_item_descriptors.MonsterType_MONSTER_TYPE_BOSS
}
enum_item_descriptors.SkillType_SKILL_TYPE_NORMAL.name = "SKILL_TYPE_NORMAL"
enum_item_descriptors.SkillType_SKILL_TYPE_NORMAL.index = 0
enum_item_descriptors.SkillType_SKILL_TYPE_NORMAL.number = 1
enum_item_descriptors.SkillType_SKILL_TYPE_SPECIAL.name = "SKILL_TYPE_SPECIAL"
enum_item_descriptors.SkillType_SKILL_TYPE_SPECIAL.index = 1
enum_item_descriptors.SkillType_SKILL_TYPE_SPECIAL.number = 2
enum_item_descriptors.SkillType_SKILL_TYPE_TRUMP.name = "SKILL_TYPE_TRUMP"
enum_item_descriptors.SkillType_SKILL_TYPE_TRUMP.index = 2
enum_item_descriptors.SkillType_SKILL_TYPE_TRUMP.number = 3
enum_item_descriptors.SkillType_SKILL_TYPE_TALENT.name = "SKILL_TYPE_TALENT"
enum_item_descriptors.SkillType_SKILL_TYPE_TALENT.index = 3
enum_item_descriptors.SkillType_SKILL_TYPE_TALENT.number = 4
enum_item_descriptors.SkillType_SKILL_TYPE_ECHO.name = "SKILL_TYPE_ECHO"
enum_item_descriptors.SkillType_SKILL_TYPE_ECHO.index = 4
enum_item_descriptors.SkillType_SKILL_TYPE_ECHO.number = 5
enum_item_descriptors.SkillType_SKILL_TYPE_DEPUTY.name = "SKILL_TYPE_DEPUTY"
enum_item_descriptors.SkillType_SKILL_TYPE_DEPUTY.index = 5
enum_item_descriptors.SkillType_SKILL_TYPE_DEPUTY.number = 6
enum_item_descriptors.SkillType_SKILL_TYPE_EQUIPMENT.name = "SKILL_TYPE_EQUIPMENT"
enum_item_descriptors.SkillType_SKILL_TYPE_EQUIPMENT.index = 6
enum_item_descriptors.SkillType_SKILL_TYPE_EQUIPMENT.number = 7
enum_item_descriptors.SkillType_SKILL_TYPE_EXTRA.name = "SKILL_TYPE_EXTRA"
enum_item_descriptors.SkillType_SKILL_TYPE_EXTRA.index = 7
enum_item_descriptors.SkillType_SKILL_TYPE_EXTRA.number = 8
enum_item_descriptors.SkillType_SKILL_TYPE_GLOBAL.name = "SKILL_TYPE_GLOBAL"
enum_item_descriptors.SkillType_SKILL_TYPE_GLOBAL.index = 8
enum_item_descriptors.SkillType_SKILL_TYPE_GLOBAL.number = 9
enum_item_descriptors.SkillType_SKILL_TYPE_PASSIVE.name = "SKILL_TYPE_PASSIVE"
enum_item_descriptors.SkillType_SKILL_TYPE_PASSIVE.index = 9
enum_item_descriptors.SkillType_SKILL_TYPE_PASSIVE.number = 10
type_descriptors.SkillType.name = "SkillType"
type_descriptors.SkillType.full_name = ".SkillType"
type_descriptors.SkillType.values = {
	enum_item_descriptors.SkillType_SKILL_TYPE_NORMAL,
	enum_item_descriptors.SkillType_SKILL_TYPE_SPECIAL,
	enum_item_descriptors.SkillType_SKILL_TYPE_TRUMP,
	enum_item_descriptors.SkillType_SKILL_TYPE_TALENT,
	enum_item_descriptors.SkillType_SKILL_TYPE_ECHO,
	enum_item_descriptors.SkillType_SKILL_TYPE_DEPUTY,
	enum_item_descriptors.SkillType_SKILL_TYPE_EQUIPMENT,
	enum_item_descriptors.SkillType_SKILL_TYPE_EXTRA,
	enum_item_descriptors.SkillType_SKILL_TYPE_GLOBAL,
	enum_item_descriptors.SkillType_SKILL_TYPE_PASSIVE
}
enum_item_descriptors.AttackingDirection_ATTACKING_DIRECTION_ATTACK.name = "ATTACKING_DIRECTION_ATTACK"
enum_item_descriptors.AttackingDirection_ATTACKING_DIRECTION_ATTACK.index = 0
enum_item_descriptors.AttackingDirection_ATTACKING_DIRECTION_ATTACK.number = 1
enum_item_descriptors.AttackingDirection_ATTACKING_DIRECTION_COUNTER.name = "ATTACKING_DIRECTION_COUNTER"
enum_item_descriptors.AttackingDirection_ATTACKING_DIRECTION_COUNTER.index = 1
enum_item_descriptors.AttackingDirection_ATTACKING_DIRECTION_COUNTER.number = 2
enum_item_descriptors.AttackingDirection_ATTACKING_DIRECTION_CHASE.name = "ATTACKING_DIRECTION_CHASE"
enum_item_descriptors.AttackingDirection_ATTACKING_DIRECTION_CHASE.index = 2
enum_item_descriptors.AttackingDirection_ATTACKING_DIRECTION_CHASE.number = 3
enum_item_descriptors.AttackingDirection_ATTACKING_DIRECTION_DOUBLE.name = "ATTACKING_DIRECTION_DOUBLE"
enum_item_descriptors.AttackingDirection_ATTACKING_DIRECTION_DOUBLE.index = 3
enum_item_descriptors.AttackingDirection_ATTACKING_DIRECTION_DOUBLE.number = 4
type_descriptors.AttackingDirection.name = "AttackingDirection"
type_descriptors.AttackingDirection.full_name = ".AttackingDirection"
type_descriptors.AttackingDirection.values = {
	enum_item_descriptors.AttackingDirection_ATTACKING_DIRECTION_ATTACK,
	enum_item_descriptors.AttackingDirection_ATTACKING_DIRECTION_COUNTER,
	enum_item_descriptors.AttackingDirection_ATTACKING_DIRECTION_CHASE,
	enum_item_descriptors.AttackingDirection_ATTACKING_DIRECTION_DOUBLE
}
enum_item_descriptors.PositionChangingMethod_POSITION_CHANGING_METHOD_SUDDEN.name = "POSITION_CHANGING_METHOD_SUDDEN"
enum_item_descriptors.PositionChangingMethod_POSITION_CHANGING_METHOD_SUDDEN.index = 0
enum_item_descriptors.PositionChangingMethod_POSITION_CHANGING_METHOD_SUDDEN.number = 1
enum_item_descriptors.PositionChangingMethod_POSITION_CHANGING_METHOD_SMOOTH.name = "POSITION_CHANGING_METHOD_SMOOTH"
enum_item_descriptors.PositionChangingMethod_POSITION_CHANGING_METHOD_SMOOTH.index = 1
enum_item_descriptors.PositionChangingMethod_POSITION_CHANGING_METHOD_SMOOTH.number = 2
type_descriptors.PositionChangingMethod.name = "PositionChangingMethod"
type_descriptors.PositionChangingMethod.full_name = ".PositionChangingMethod"
type_descriptors.PositionChangingMethod.values = {
	enum_item_descriptors.PositionChangingMethod_POSITION_CHANGING_METHOD_SUDDEN,
	enum_item_descriptors.PositionChangingMethod_POSITION_CHANGING_METHOD_SMOOTH
}
enum_item_descriptors.SkillSourceType_ADDITIONAL_TERRAIN.name = "ADDITIONAL_TERRAIN"
enum_item_descriptors.SkillSourceType_ADDITIONAL_TERRAIN.index = 0
enum_item_descriptors.SkillSourceType_ADDITIONAL_TERRAIN.number = 1
enum_item_descriptors.SkillSourceType_ENTITY.name = "ENTITY"
enum_item_descriptors.SkillSourceType_ENTITY.index = 1
enum_item_descriptors.SkillSourceType_ENTITY.number = 2
enum_item_descriptors.SkillSourceType_BUFF.name = "BUFF"
enum_item_descriptors.SkillSourceType_BUFF.index = 2
enum_item_descriptors.SkillSourceType_BUFF.number = 3
enum_item_descriptors.SkillSourceType_OTHER.name = "OTHER"
enum_item_descriptors.SkillSourceType_OTHER.index = 3
enum_item_descriptors.SkillSourceType_OTHER.number = 4
type_descriptors.SkillSourceType.name = "SkillSourceType"
type_descriptors.SkillSourceType.full_name = ".SkillSourceType"
type_descriptors.SkillSourceType.values = {
	enum_item_descriptors.SkillSourceType_ADDITIONAL_TERRAIN,
	enum_item_descriptors.SkillSourceType_ENTITY,
	enum_item_descriptors.SkillSourceType_BUFF,
	enum_item_descriptors.SkillSourceType_OTHER
}
enum_item_descriptors.EndType_VICTORY.name = "VICTORY"
enum_item_descriptors.EndType_VICTORY.index = 0
enum_item_descriptors.EndType_VICTORY.number = 1
enum_item_descriptors.EndType_DEFEAT.name = "DEFEAT"
enum_item_descriptors.EndType_DEFEAT.index = 1
enum_item_descriptors.EndType_DEFEAT.number = 2
enum_item_descriptors.EndType_RESTART.name = "RESTART"
enum_item_descriptors.EndType_RESTART.index = 2
enum_item_descriptors.EndType_RESTART.number = 3
enum_item_descriptors.EndType_SURRENDER.name = "SURRENDER"
enum_item_descriptors.EndType_SURRENDER.index = 3
enum_item_descriptors.EndType_SURRENDER.number = 4
type_descriptors.EndType.name = "EndType"
type_descriptors.EndType.full_name = ".EndType"
type_descriptors.EndType.values = {
	enum_item_descriptors.EndType_VICTORY,
	enum_item_descriptors.EndType_DEFEAT,
	enum_item_descriptors.EndType_RESTART,
	enum_item_descriptors.EndType_SURRENDER
}
enum_item_descriptors.EntityType_ENTITY_HERO.name = "ENTITY_HERO"
enum_item_descriptors.EntityType_ENTITY_HERO.index = 0
enum_item_descriptors.EntityType_ENTITY_HERO.number = 1
enum_item_descriptors.EntityType_ENTITY_MONSTER.name = "ENTITY_MONSTER"
enum_item_descriptors.EntityType_ENTITY_MONSTER.index = 1
enum_item_descriptors.EntityType_ENTITY_MONSTER.number = 2
enum_item_descriptors.EntityType_ENTITY_HALO_TERRAIN.name = "ENTITY_HALO_TERRAIN"
enum_item_descriptors.EntityType_ENTITY_HALO_TERRAIN.index = 2
enum_item_descriptors.EntityType_ENTITY_HALO_TERRAIN.number = 3
enum_item_descriptors.EntityType_ENTITY_SYSTEM_NPC.name = "ENTITY_SYSTEM_NPC"
enum_item_descriptors.EntityType_ENTITY_SYSTEM_NPC.index = 3
enum_item_descriptors.EntityType_ENTITY_SYSTEM_NPC.number = 4
enum_item_descriptors.EntityType_ENTITY_INTANGIBLE.name = "ENTITY_INTANGIBLE"
enum_item_descriptors.EntityType_ENTITY_INTANGIBLE.index = 4
enum_item_descriptors.EntityType_ENTITY_INTANGIBLE.number = 5
enum_item_descriptors.EntityType_ENTITY_SUMMON.name = "ENTITY_SUMMON"
enum_item_descriptors.EntityType_ENTITY_SUMMON.index = 5
enum_item_descriptors.EntityType_ENTITY_SUMMON.number = 6
type_descriptors.EntityType.name = "EntityType"
type_descriptors.EntityType.full_name = ".EntityType"
type_descriptors.EntityType.values = {
	enum_item_descriptors.EntityType_ENTITY_HERO,
	enum_item_descriptors.EntityType_ENTITY_MONSTER,
	enum_item_descriptors.EntityType_ENTITY_HALO_TERRAIN,
	enum_item_descriptors.EntityType_ENTITY_SYSTEM_NPC,
	enum_item_descriptors.EntityType_ENTITY_INTANGIBLE,
	enum_item_descriptors.EntityType_ENTITY_SUMMON
}
enum_item_descriptors.RemoveReason_REASON_RETREAT.name = "REASON_RETREAT"
enum_item_descriptors.RemoveReason_REASON_RETREAT.index = 0
enum_item_descriptors.RemoveReason_REASON_RETREAT.number = 1
enum_item_descriptors.RemoveReason_REASON_OTHER.name = "REASON_OTHER"
enum_item_descriptors.RemoveReason_REASON_OTHER.index = 1
enum_item_descriptors.RemoveReason_REASON_OTHER.number = 2
type_descriptors.RemoveReason.name = "RemoveReason"
type_descriptors.RemoveReason.full_name = ".RemoveReason"
type_descriptors.RemoveReason.values = {
	enum_item_descriptors.RemoveReason_REASON_RETREAT,
	enum_item_descriptors.RemoveReason_REASON_OTHER
}
enum_item_descriptors.TagEnhanceCmd_REPLACE.name = "REPLACE"
enum_item_descriptors.TagEnhanceCmd_REPLACE.index = 0
enum_item_descriptors.TagEnhanceCmd_REPLACE.number = 1
enum_item_descriptors.TagEnhanceCmd_ADD.name = "ADD"
enum_item_descriptors.TagEnhanceCmd_ADD.index = 1
enum_item_descriptors.TagEnhanceCmd_ADD.number = 2
enum_item_descriptors.TagEnhanceCmd_MUL.name = "MUL"
enum_item_descriptors.TagEnhanceCmd_MUL.index = 2
enum_item_descriptors.TagEnhanceCmd_MUL.number = 3
type_descriptors.TagEnhanceCmd.name = "TagEnhanceCmd"
type_descriptors.TagEnhanceCmd.full_name = ".TagEnhanceCmd"
type_descriptors.TagEnhanceCmd.values = {
	enum_item_descriptors.TagEnhanceCmd_REPLACE,
	enum_item_descriptors.TagEnhanceCmd_ADD,
	enum_item_descriptors.TagEnhanceCmd_MUL
}
enum_item_descriptors.BattleType_DUNGEON.name = "DUNGEON"
enum_item_descriptors.BattleType_DUNGEON.index = 0
enum_item_descriptors.BattleType_DUNGEON.number = 1
enum_item_descriptors.BattleType_GM_CUSTOMIZE.name = "GM_CUSTOMIZE"
enum_item_descriptors.BattleType_GM_CUSTOMIZE.index = 1
enum_item_descriptors.BattleType_GM_CUSTOMIZE.number = 2
enum_item_descriptors.BattleType_GM_LEVEL.name = "GM_LEVEL"
enum_item_descriptors.BattleType_GM_LEVEL.index = 2
enum_item_descriptors.BattleType_GM_LEVEL.number = 3
enum_item_descriptors.BattleType_RODEO_AIR.name = "RODEO_AIR"
enum_item_descriptors.BattleType_RODEO_AIR.index = 3
enum_item_descriptors.BattleType_RODEO_AIR.number = 4
enum_item_descriptors.BattleType_TEST_AIR.name = "TEST_AIR"
enum_item_descriptors.BattleType_TEST_AIR.index = 4
enum_item_descriptors.BattleType_TEST_AIR.number = 5
enum_item_descriptors.BattleType_PVP.name = "PVP"
enum_item_descriptors.BattleType_PVP.index = 5
enum_item_descriptors.BattleType_PVP.number = 6
enum_item_descriptors.BattleType_FREE_AIR.name = "FREE_AIR"
enum_item_descriptors.BattleType_FREE_AIR.index = 6
enum_item_descriptors.BattleType_FREE_AIR.number = 7
enum_item_descriptors.BattleType_ENDLESS_AIR.name = "ENDLESS_AIR"
enum_item_descriptors.BattleType_ENDLESS_AIR.index = 7
enum_item_descriptors.BattleType_ENDLESS_AIR.number = 8
type_descriptors.BattleType.name = "BattleType"
type_descriptors.BattleType.full_name = ".BattleType"
type_descriptors.BattleType.values = {
	enum_item_descriptors.BattleType_DUNGEON,
	enum_item_descriptors.BattleType_GM_CUSTOMIZE,
	enum_item_descriptors.BattleType_GM_LEVEL,
	enum_item_descriptors.BattleType_RODEO_AIR,
	enum_item_descriptors.BattleType_TEST_AIR,
	enum_item_descriptors.BattleType_PVP,
	enum_item_descriptors.BattleType_FREE_AIR,
	enum_item_descriptors.BattleType_ENDLESS_AIR
}
enum_item_descriptors.PlayerChangeReason_OVERDRAWN_SANITY.name = "OVERDRAWN_SANITY"
enum_item_descriptors.PlayerChangeReason_OVERDRAWN_SANITY.index = 0
enum_item_descriptors.PlayerChangeReason_OVERDRAWN_SANITY.number = 1
enum_item_descriptors.PlayerChangeReason_PLOT.name = "PLOT"
enum_item_descriptors.PlayerChangeReason_PLOT.index = 1
enum_item_descriptors.PlayerChangeReason_PLOT.number = 2
type_descriptors.PlayerChangeReason.name = "PlayerChangeReason"
type_descriptors.PlayerChangeReason.full_name = ".PlayerChangeReason"
type_descriptors.PlayerChangeReason.values = {
	enum_item_descriptors.PlayerChangeReason_OVERDRAWN_SANITY,
	enum_item_descriptors.PlayerChangeReason_PLOT
}
enum_item_descriptors.AiMode_NONE.name = "NONE"
enum_item_descriptors.AiMode_NONE.index = 0
enum_item_descriptors.AiMode_NONE.number = 1
enum_item_descriptors.AiMode_BEHAVIOR_TREE.name = "BEHAVIOR_TREE"
enum_item_descriptors.AiMode_BEHAVIOR_TREE.index = 1
enum_item_descriptors.AiMode_BEHAVIOR_TREE.number = 2
enum_item_descriptors.AiMode_USER_RECORD.name = "USER_RECORD"
enum_item_descriptors.AiMode_USER_RECORD.index = 2
enum_item_descriptors.AiMode_USER_RECORD.number = 3
type_descriptors.AiMode.name = "AiMode"
type_descriptors.AiMode.full_name = ".AiMode"
type_descriptors.AiMode.values = {
	enum_item_descriptors.AiMode_NONE,
	enum_item_descriptors.AiMode_BEHAVIOR_TREE,
	enum_item_descriptors.AiMode_USER_RECORD
}
enum_item_descriptors.Gameplay_GAME_NORMAL.name = "GAME_NORMAL"
enum_item_descriptors.Gameplay_GAME_NORMAL.index = 0
enum_item_descriptors.Gameplay_GAME_NORMAL.number = 1
enum_item_descriptors.Gameplay_GAME_RECORD.name = "GAME_RECORD"
enum_item_descriptors.Gameplay_GAME_RECORD.index = 1
enum_item_descriptors.Gameplay_GAME_RECORD.number = 2
enum_item_descriptors.Gameplay_GAME_CONSECUTIVE.name = "GAME_CONSECUTIVE"
enum_item_descriptors.Gameplay_GAME_CONSECUTIVE.index = 2
enum_item_descriptors.Gameplay_GAME_CONSECUTIVE.number = 3
type_descriptors.Gameplay.name = "Gameplay"
type_descriptors.Gameplay.full_name = ".Gameplay"
type_descriptors.Gameplay.values = {
	enum_item_descriptors.Gameplay_GAME_NORMAL,
	enum_item_descriptors.Gameplay_GAME_RECORD,
	enum_item_descriptors.Gameplay_GAME_CONSECUTIVE
}
field_descriptors.BattleEndedEventNO_winner.name = "winner"
field_descriptors.BattleEndedEventNO_winner.full_name = ".BattleEndedEventNO.winner"
field_descriptors.BattleEndedEventNO_winner.number = 1
field_descriptors.BattleEndedEventNO_winner.index = 0
field_descriptors.BattleEndedEventNO_winner.label = 3
field_descriptors.BattleEndedEventNO_winner.has_default_value = false
field_descriptors.BattleEndedEventNO_winner.default_value = {}
field_descriptors.BattleEndedEventNO_winner.type = 5
field_descriptors.BattleEndedEventNO_winner.cpp_type = 1
field_descriptors.BattleEndedEventNO_loser.name = "loser"
field_descriptors.BattleEndedEventNO_loser.full_name = ".BattleEndedEventNO.loser"
field_descriptors.BattleEndedEventNO_loser.number = 2
field_descriptors.BattleEndedEventNO_loser.index = 1
field_descriptors.BattleEndedEventNO_loser.label = 3
field_descriptors.BattleEndedEventNO_loser.has_default_value = false
field_descriptors.BattleEndedEventNO_loser.default_value = {}
field_descriptors.BattleEndedEventNO_loser.type = 5
field_descriptors.BattleEndedEventNO_loser.cpp_type = 1
field_descriptors.BattleEndedEventNO_realEnd.name = "realEnd"
field_descriptors.BattleEndedEventNO_realEnd.full_name = ".BattleEndedEventNO.realEnd"
field_descriptors.BattleEndedEventNO_realEnd.number = 3
field_descriptors.BattleEndedEventNO_realEnd.index = 2
field_descriptors.BattleEndedEventNO_realEnd.label = 1
field_descriptors.BattleEndedEventNO_realEnd.has_default_value = false
field_descriptors.BattleEndedEventNO_realEnd.default_value = false
field_descriptors.BattleEndedEventNO_realEnd.type = 8
field_descriptors.BattleEndedEventNO_realEnd.cpp_type = 7
type_descriptors.BattleEndedEventNO.name = "BattleEndedEventNO"
type_descriptors.BattleEndedEventNO.full_name = ".BattleEndedEventNO"
type_descriptors.BattleEndedEventNO.nested_types = {}
type_descriptors.BattleEndedEventNO.enum_types = {}
type_descriptors.BattleEndedEventNO.fields = {
	field_descriptors.BattleEndedEventNO_winner,
	field_descriptors.BattleEndedEventNO_loser,
	field_descriptors.BattleEndedEventNO_realEnd
}
type_descriptors.BattleEndedEventNO.is_extendable = false
type_descriptors.BattleEndedEventNO.extensions = {}
field_descriptors.StageNO_players.name = "players"
field_descriptors.StageNO_players.full_name = ".StageNO.players"
field_descriptors.StageNO_players.number = 1
field_descriptors.StageNO_players.index = 0
field_descriptors.StageNO_players.label = 3
field_descriptors.StageNO_players.has_default_value = false
field_descriptors.StageNO_players.default_value = {}
field_descriptors.StageNO_players.message_type = type_descriptors.PlayerNO
field_descriptors.StageNO_players.type = 11
field_descriptors.StageNO_players.cpp_type = 10
type_descriptors.StageNO.name = "StageNO"
type_descriptors.StageNO.full_name = ".StageNO"
type_descriptors.StageNO.nested_types = {}
type_descriptors.StageNO.enum_types = {}
type_descriptors.StageNO.fields = {
	field_descriptors.StageNO_players
}
type_descriptors.StageNO.is_extendable = false
type_descriptors.StageNO.extensions = {}
type_descriptors.AnimationPostedPush.name = "AnimationPostedPush"
type_descriptors.AnimationPostedPush.full_name = ".AnimationPostedPush"
type_descriptors.AnimationPostedPush.nested_types = {}
type_descriptors.AnimationPostedPush.enum_types = {}
type_descriptors.AnimationPostedPush.fields = {}
type_descriptors.AnimationPostedPush.is_extendable = false
type_descriptors.AnimationPostedPush.extensions = {}
field_descriptors.MultiRoundAoeUpdateNO_aoe.name = "aoe"
field_descriptors.MultiRoundAoeUpdateNO_aoe.full_name = ".MultiRoundAoeUpdateNO.aoe"
field_descriptors.MultiRoundAoeUpdateNO_aoe.number = 1
field_descriptors.MultiRoundAoeUpdateNO_aoe.index = 0
field_descriptors.MultiRoundAoeUpdateNO_aoe.label = 1
field_descriptors.MultiRoundAoeUpdateNO_aoe.has_default_value = false
field_descriptors.MultiRoundAoeUpdateNO_aoe.default_value = nil
field_descriptors.MultiRoundAoeUpdateNO_aoe.message_type = type_descriptors.MultiRoundAoeNO
field_descriptors.MultiRoundAoeUpdateNO_aoe.type = 11
field_descriptors.MultiRoundAoeUpdateNO_aoe.cpp_type = 10
type_descriptors.MultiRoundAoeUpdateNO.name = "MultiRoundAoeUpdateNO"
type_descriptors.MultiRoundAoeUpdateNO.full_name = ".MultiRoundAoeUpdateNO"
type_descriptors.MultiRoundAoeUpdateNO.nested_types = {}
type_descriptors.MultiRoundAoeUpdateNO.enum_types = {}
type_descriptors.MultiRoundAoeUpdateNO.fields = {
	field_descriptors.MultiRoundAoeUpdateNO_aoe
}
type_descriptors.MultiRoundAoeUpdateNO.is_extendable = false
type_descriptors.MultiRoundAoeUpdateNO.extensions = {}
type_descriptors.ForecastReply.name = "ForecastReply"
type_descriptors.ForecastReply.full_name = ".ForecastReply"
type_descriptors.ForecastReply.nested_types = {}
type_descriptors.ForecastReply.enum_types = {}
type_descriptors.ForecastReply.fields = {}
type_descriptors.ForecastReply.is_extendable = false
type_descriptors.ForecastReply.extensions = {}
field_descriptors.EffectNO_timelineRes.name = "timelineRes"
field_descriptors.EffectNO_timelineRes.full_name = ".EffectNO.timelineRes"
field_descriptors.EffectNO_timelineRes.number = 1
field_descriptors.EffectNO_timelineRes.index = 0
field_descriptors.EffectNO_timelineRes.label = 1
field_descriptors.EffectNO_timelineRes.has_default_value = false
field_descriptors.EffectNO_timelineRes.default_value = ""
field_descriptors.EffectNO_timelineRes.type = 9
field_descriptors.EffectNO_timelineRes.cpp_type = 9
field_descriptors.EffectNO_events.name = "events"
field_descriptors.EffectNO_events.full_name = ".EffectNO.events"
field_descriptors.EffectNO_events.number = 2
field_descriptors.EffectNO_events.index = 1
field_descriptors.EffectNO_events.label = 3
field_descriptors.EffectNO_events.has_default_value = false
field_descriptors.EffectNO_events.default_value = {}
field_descriptors.EffectNO_events.message_type = type_descriptors.EventNO
field_descriptors.EffectNO_events.type = 11
field_descriptors.EffectNO_events.cpp_type = 10
type_descriptors.EffectNO.name = "EffectNO"
type_descriptors.EffectNO.full_name = ".EffectNO"
type_descriptors.EffectNO.nested_types = {}
type_descriptors.EffectNO.enum_types = {}
type_descriptors.EffectNO.fields = {
	field_descriptors.EffectNO_timelineRes,
	field_descriptors.EffectNO_events
}
type_descriptors.EffectNO.is_extendable = false
type_descriptors.EffectNO.extensions = {}
field_descriptors.PlotTriggered3D_plot.name = "plot"
field_descriptors.PlotTriggered3D_plot.full_name = ".PlotTriggered3D.plot"
field_descriptors.PlotTriggered3D_plot.number = 1
field_descriptors.PlotTriggered3D_plot.index = 0
field_descriptors.PlotTriggered3D_plot.label = 1
field_descriptors.PlotTriggered3D_plot.has_default_value = false
field_descriptors.PlotTriggered3D_plot.default_value = 0
field_descriptors.PlotTriggered3D_plot.type = 5
field_descriptors.PlotTriggered3D_plot.cpp_type = 1
field_descriptors.PlotTriggered3D_events.name = "events"
field_descriptors.PlotTriggered3D_events.full_name = ".PlotTriggered3D.events"
field_descriptors.PlotTriggered3D_events.number = 2
field_descriptors.PlotTriggered3D_events.index = 1
field_descriptors.PlotTriggered3D_events.label = 3
field_descriptors.PlotTriggered3D_events.has_default_value = false
field_descriptors.PlotTriggered3D_events.default_value = {}
field_descriptors.PlotTriggered3D_events.message_type = type_descriptors.EventNO
field_descriptors.PlotTriggered3D_events.type = 11
field_descriptors.PlotTriggered3D_events.cpp_type = 10
type_descriptors.PlotTriggered3D.name = "PlotTriggered3D"
type_descriptors.PlotTriggered3D.full_name = ".PlotTriggered3D"
type_descriptors.PlotTriggered3D.nested_types = {}
type_descriptors.PlotTriggered3D.enum_types = {}
type_descriptors.PlotTriggered3D.fields = {
	field_descriptors.PlotTriggered3D_plot,
	field_descriptors.PlotTriggered3D_events
}
type_descriptors.PlotTriggered3D.is_extendable = false
type_descriptors.PlotTriggered3D.extensions = {}
field_descriptors.AiModeChangeNO_aiMode.name = "aiMode"
field_descriptors.AiModeChangeNO_aiMode.full_name = ".AiModeChangeNO.aiMode"
field_descriptors.AiModeChangeNO_aiMode.number = 1
field_descriptors.AiModeChangeNO_aiMode.index = 0
field_descriptors.AiModeChangeNO_aiMode.label = 1
field_descriptors.AiModeChangeNO_aiMode.has_default_value = false
field_descriptors.AiModeChangeNO_aiMode.default_value = nil
field_descriptors.AiModeChangeNO_aiMode.enum_type = type_descriptors.AiMode
field_descriptors.AiModeChangeNO_aiMode.type = 14
field_descriptors.AiModeChangeNO_aiMode.cpp_type = 8
type_descriptors.AiModeChangeNO.name = "AiModeChangeNO"
type_descriptors.AiModeChangeNO.full_name = ".AiModeChangeNO"
type_descriptors.AiModeChangeNO.nested_types = {}
type_descriptors.AiModeChangeNO.enum_types = {}
type_descriptors.AiModeChangeNO.fields = {
	field_descriptors.AiModeChangeNO_aiMode
}
type_descriptors.AiModeChangeNO.is_extendable = false
type_descriptors.AiModeChangeNO.extensions = {}
type_descriptors.ConnectRequest.name = "ConnectRequest"
type_descriptors.ConnectRequest.full_name = ".ConnectRequest"
type_descriptors.ConnectRequest.nested_types = {}
type_descriptors.ConnectRequest.enum_types = {}
type_descriptors.ConnectRequest.fields = {}
type_descriptors.ConnectRequest.is_extendable = false
type_descriptors.ConnectRequest.extensions = {}
field_descriptors.ShapeTagNO_shape.name = "shape"
field_descriptors.ShapeTagNO_shape.full_name = ".ShapeTagNO.shape"
field_descriptors.ShapeTagNO_shape.number = 1
field_descriptors.ShapeTagNO_shape.index = 0
field_descriptors.ShapeTagNO_shape.label = 1
field_descriptors.ShapeTagNO_shape.has_default_value = false
field_descriptors.ShapeTagNO_shape.default_value = nil
field_descriptors.ShapeTagNO_shape.message_type = type_descriptors.ShapeNO
field_descriptors.ShapeTagNO_shape.type = 11
field_descriptors.ShapeTagNO_shape.cpp_type = 10
type_descriptors.ShapeTagNO.name = "ShapeTagNO"
type_descriptors.ShapeTagNO.full_name = ".ShapeTagNO"
type_descriptors.ShapeTagNO.nested_types = {}
type_descriptors.ShapeTagNO.enum_types = {}
type_descriptors.ShapeTagNO.fields = {
	field_descriptors.ShapeTagNO_shape
}
type_descriptors.ShapeTagNO.is_extendable = false
type_descriptors.ShapeTagNO.extensions = {}
type_descriptors.WholeBattleBoardNO.name = "WholeBattleBoardNO"
type_descriptors.WholeBattleBoardNO.full_name = ".WholeBattleBoardNO"
type_descriptors.WholeBattleBoardNO.nested_types = {}
type_descriptors.WholeBattleBoardNO.enum_types = {}
type_descriptors.WholeBattleBoardNO.fields = {}
type_descriptors.WholeBattleBoardNO.is_extendable = false
type_descriptors.WholeBattleBoardNO.extensions = {}
field_descriptors.LogBattleLogPush_log.name = "log"
field_descriptors.LogBattleLogPush_log.full_name = ".LogBattleLogPush.log"
field_descriptors.LogBattleLogPush_log.number = 1
field_descriptors.LogBattleLogPush_log.index = 0
field_descriptors.LogBattleLogPush_log.label = 3
field_descriptors.LogBattleLogPush_log.has_default_value = false
field_descriptors.LogBattleLogPush_log.default_value = {}
field_descriptors.LogBattleLogPush_log.type = 9
field_descriptors.LogBattleLogPush_log.cpp_type = 9
type_descriptors.LogBattleLogPush.name = "LogBattleLogPush"
type_descriptors.LogBattleLogPush.full_name = ".LogBattleLogPush"
type_descriptors.LogBattleLogPush.nested_types = {}
type_descriptors.LogBattleLogPush.enum_types = {}
type_descriptors.LogBattleLogPush.fields = {
	field_descriptors.LogBattleLogPush_log
}
type_descriptors.LogBattleLogPush.is_extendable = false
type_descriptors.LogBattleLogPush.extensions = {}
field_descriptors.ConnectStateChangePush_state.name = "state"
field_descriptors.ConnectStateChangePush_state.full_name = ".ConnectStateChangePush.state"
field_descriptors.ConnectStateChangePush_state.number = 1
field_descriptors.ConnectStateChangePush_state.index = 0
field_descriptors.ConnectStateChangePush_state.label = 3
field_descriptors.ConnectStateChangePush_state.has_default_value = false
field_descriptors.ConnectStateChangePush_state.default_value = {}
field_descriptors.ConnectStateChangePush_state.message_type = type_descriptors.ConnectStateNO
field_descriptors.ConnectStateChangePush_state.type = 11
field_descriptors.ConnectStateChangePush_state.cpp_type = 10
type_descriptors.ConnectStateChangePush.name = "ConnectStateChangePush"
type_descriptors.ConnectStateChangePush.full_name = ".ConnectStateChangePush"
type_descriptors.ConnectStateChangePush.nested_types = {}
type_descriptors.ConnectStateChangePush.enum_types = {}
type_descriptors.ConnectStateChangePush.fields = {
	field_descriptors.ConnectStateChangePush_state
}
type_descriptors.ConnectStateChangePush.is_extendable = false
type_descriptors.ConnectStateChangePush.extensions = {}
field_descriptors.MessageCompositeNO_textPart.name = "textPart"
field_descriptors.MessageCompositeNO_textPart.full_name = ".MessageCompositeNO.textPart"
field_descriptors.MessageCompositeNO_textPart.number = 1
field_descriptors.MessageCompositeNO_textPart.index = 0
field_descriptors.MessageCompositeNO_textPart.label = 3
field_descriptors.MessageCompositeNO_textPart.has_default_value = false
field_descriptors.MessageCompositeNO_textPart.default_value = {}
field_descriptors.MessageCompositeNO_textPart.message_type = type_descriptors.MessagePartNO
field_descriptors.MessageCompositeNO_textPart.type = 11
field_descriptors.MessageCompositeNO_textPart.cpp_type = 10
field_descriptors.MessageCompositeNO_voice.name = "voice"
field_descriptors.MessageCompositeNO_voice.full_name = ".MessageCompositeNO.voice"
field_descriptors.MessageCompositeNO_voice.number = 2
field_descriptors.MessageCompositeNO_voice.index = 1
field_descriptors.MessageCompositeNO_voice.label = 1
field_descriptors.MessageCompositeNO_voice.has_default_value = false
field_descriptors.MessageCompositeNO_voice.default_value = 0
field_descriptors.MessageCompositeNO_voice.type = 5
field_descriptors.MessageCompositeNO_voice.cpp_type = 1
field_descriptors.MessageCompositeNO_emoji.name = "emoji"
field_descriptors.MessageCompositeNO_emoji.full_name = ".MessageCompositeNO.emoji"
field_descriptors.MessageCompositeNO_emoji.number = 3
field_descriptors.MessageCompositeNO_emoji.index = 2
field_descriptors.MessageCompositeNO_emoji.label = 1
field_descriptors.MessageCompositeNO_emoji.has_default_value = false
field_descriptors.MessageCompositeNO_emoji.default_value = 0
field_descriptors.MessageCompositeNO_emoji.type = 5
field_descriptors.MessageCompositeNO_emoji.cpp_type = 1
type_descriptors.MessageCompositeNO.name = "MessageCompositeNO"
type_descriptors.MessageCompositeNO.full_name = ".MessageCompositeNO"
type_descriptors.MessageCompositeNO.nested_types = {}
type_descriptors.MessageCompositeNO.enum_types = {}
type_descriptors.MessageCompositeNO.fields = {
	field_descriptors.MessageCompositeNO_textPart,
	field_descriptors.MessageCompositeNO_voice,
	field_descriptors.MessageCompositeNO_emoji
}
type_descriptors.MessageCompositeNO.is_extendable = false
type_descriptors.MessageCompositeNO.extensions = {}
field_descriptors.MessagePartNO_type.name = "type"
field_descriptors.MessagePartNO_type.full_name = ".MessagePartNO.type"
field_descriptors.MessagePartNO_type.number = 1
field_descriptors.MessagePartNO_type.index = 0
field_descriptors.MessagePartNO_type.label = 2
field_descriptors.MessagePartNO_type.has_default_value = false
field_descriptors.MessagePartNO_type.default_value = 0
field_descriptors.MessagePartNO_type.type = 5
field_descriptors.MessagePartNO_type.cpp_type = 1
field_descriptors.MessagePartNO_id.name = "id"
field_descriptors.MessagePartNO_id.full_name = ".MessagePartNO.id"
field_descriptors.MessagePartNO_id.number = 2
field_descriptors.MessagePartNO_id.index = 1
field_descriptors.MessagePartNO_id.label = 2
field_descriptors.MessagePartNO_id.has_default_value = false
field_descriptors.MessagePartNO_id.default_value = 0
field_descriptors.MessagePartNO_id.type = 5
field_descriptors.MessagePartNO_id.cpp_type = 1
type_descriptors.MessagePartNO.name = "MessagePartNO"
type_descriptors.MessagePartNO.full_name = ".MessagePartNO"
type_descriptors.MessagePartNO.nested_types = {}
type_descriptors.MessagePartNO.enum_types = {}
type_descriptors.MessagePartNO.fields = {
	field_descriptors.MessagePartNO_type,
	field_descriptors.MessagePartNO_id
}
type_descriptors.MessagePartNO.is_extendable = false
type_descriptors.MessagePartNO.extensions = {}
field_descriptors.WinConditionNO_id.name = "id"
field_descriptors.WinConditionNO_id.full_name = ".WinConditionNO.id"
field_descriptors.WinConditionNO_id.number = 1
field_descriptors.WinConditionNO_id.index = 0
field_descriptors.WinConditionNO_id.label = 2
field_descriptors.WinConditionNO_id.has_default_value = false
field_descriptors.WinConditionNO_id.default_value = 0
field_descriptors.WinConditionNO_id.type = 5
field_descriptors.WinConditionNO_id.cpp_type = 1
field_descriptors.WinConditionNO_params.name = "params"
field_descriptors.WinConditionNO_params.full_name = ".WinConditionNO.params"
field_descriptors.WinConditionNO_params.number = 2
field_descriptors.WinConditionNO_params.index = 1
field_descriptors.WinConditionNO_params.label = 3
field_descriptors.WinConditionNO_params.has_default_value = false
field_descriptors.WinConditionNO_params.default_value = {}
field_descriptors.WinConditionNO_params.type = 5
field_descriptors.WinConditionNO_params.cpp_type = 1
type_descriptors.WinConditionNO.name = "WinConditionNO"
type_descriptors.WinConditionNO.full_name = ".WinConditionNO"
type_descriptors.WinConditionNO.nested_types = {}
type_descriptors.WinConditionNO.enum_types = {}
type_descriptors.WinConditionNO.fields = {
	field_descriptors.WinConditionNO_id,
	field_descriptors.WinConditionNO_params
}
type_descriptors.WinConditionNO.is_extendable = false
type_descriptors.WinConditionNO.extensions = {}
field_descriptors.ForecastTagNO_entity.name = "entity"
field_descriptors.ForecastTagNO_entity.full_name = ".ForecastTagNO.entity"
field_descriptors.ForecastTagNO_entity.number = 1
field_descriptors.ForecastTagNO_entity.index = 0
field_descriptors.ForecastTagNO_entity.label = 1
field_descriptors.ForecastTagNO_entity.has_default_value = false
field_descriptors.ForecastTagNO_entity.default_value = 0
field_descriptors.ForecastTagNO_entity.type = 5
field_descriptors.ForecastTagNO_entity.cpp_type = 1
field_descriptors.ForecastTagNO_tag.name = "tag"
field_descriptors.ForecastTagNO_tag.full_name = ".ForecastTagNO.tag"
field_descriptors.ForecastTagNO_tag.number = 2
field_descriptors.ForecastTagNO_tag.index = 1
field_descriptors.ForecastTagNO_tag.label = 1
field_descriptors.ForecastTagNO_tag.has_default_value = false
field_descriptors.ForecastTagNO_tag.default_value = ""
field_descriptors.ForecastTagNO_tag.type = 9
field_descriptors.ForecastTagNO_tag.cpp_type = 9
field_descriptors.ForecastTagNO_count.name = "count"
field_descriptors.ForecastTagNO_count.full_name = ".ForecastTagNO.count"
field_descriptors.ForecastTagNO_count.number = 3
field_descriptors.ForecastTagNO_count.index = 2
field_descriptors.ForecastTagNO_count.label = 1
field_descriptors.ForecastTagNO_count.has_default_value = false
field_descriptors.ForecastTagNO_count.default_value = 0
field_descriptors.ForecastTagNO_count.type = 5
field_descriptors.ForecastTagNO_count.cpp_type = 1
type_descriptors.ForecastTagNO.name = "ForecastTagNO"
type_descriptors.ForecastTagNO.full_name = ".ForecastTagNO"
type_descriptors.ForecastTagNO.nested_types = {}
type_descriptors.ForecastTagNO.enum_types = {}
type_descriptors.ForecastTagNO.fields = {
	field_descriptors.ForecastTagNO_entity,
	field_descriptors.ForecastTagNO_tag,
	field_descriptors.ForecastTagNO_count
}
type_descriptors.ForecastTagNO.is_extendable = false
type_descriptors.ForecastTagNO.extensions = {}
field_descriptors.ModelChangedNO_entity.name = "entity"
field_descriptors.ModelChangedNO_entity.full_name = ".ModelChangedNO.entity"
field_descriptors.ModelChangedNO_entity.number = 1
field_descriptors.ModelChangedNO_entity.index = 0
field_descriptors.ModelChangedNO_entity.label = 1
field_descriptors.ModelChangedNO_entity.has_default_value = false
field_descriptors.ModelChangedNO_entity.default_value = 0
field_descriptors.ModelChangedNO_entity.type = 5
field_descriptors.ModelChangedNO_entity.cpp_type = 1
field_descriptors.ModelChangedNO_modelId.name = "modelId"
field_descriptors.ModelChangedNO_modelId.full_name = ".ModelChangedNO.modelId"
field_descriptors.ModelChangedNO_modelId.number = 2
field_descriptors.ModelChangedNO_modelId.index = 1
field_descriptors.ModelChangedNO_modelId.label = 1
field_descriptors.ModelChangedNO_modelId.has_default_value = false
field_descriptors.ModelChangedNO_modelId.default_value = 0
field_descriptors.ModelChangedNO_modelId.type = 5
field_descriptors.ModelChangedNO_modelId.cpp_type = 1
field_descriptors.ModelChangedNO_action.name = "action"
field_descriptors.ModelChangedNO_action.full_name = ".ModelChangedNO.action"
field_descriptors.ModelChangedNO_action.number = 3
field_descriptors.ModelChangedNO_action.index = 2
field_descriptors.ModelChangedNO_action.label = 1
field_descriptors.ModelChangedNO_action.has_default_value = false
field_descriptors.ModelChangedNO_action.default_value = ""
field_descriptors.ModelChangedNO_action.type = 9
field_descriptors.ModelChangedNO_action.cpp_type = 9
type_descriptors.ModelChangedNO.name = "ModelChangedNO"
type_descriptors.ModelChangedNO.full_name = ".ModelChangedNO"
type_descriptors.ModelChangedNO.nested_types = {}
type_descriptors.ModelChangedNO.enum_types = {}
type_descriptors.ModelChangedNO.fields = {
	field_descriptors.ModelChangedNO_entity,
	field_descriptors.ModelChangedNO_modelId,
	field_descriptors.ModelChangedNO_action
}
type_descriptors.ModelChangedNO.is_extendable = false
type_descriptors.ModelChangedNO.extensions = {}
type_descriptors.UnfinishedBattleExpiredPush.name = "UnfinishedBattleExpiredPush"
type_descriptors.UnfinishedBattleExpiredPush.full_name = ".UnfinishedBattleExpiredPush"
type_descriptors.UnfinishedBattleExpiredPush.nested_types = {}
type_descriptors.UnfinishedBattleExpiredPush.enum_types = {}
type_descriptors.UnfinishedBattleExpiredPush.fields = {}
type_descriptors.UnfinishedBattleExpiredPush.is_extendable = false
type_descriptors.UnfinishedBattleExpiredPush.extensions = {}
field_descriptors.ForecastAiNO_entity.name = "entity"
field_descriptors.ForecastAiNO_entity.full_name = ".ForecastAiNO.entity"
field_descriptors.ForecastAiNO_entity.number = 1
field_descriptors.ForecastAiNO_entity.index = 0
field_descriptors.ForecastAiNO_entity.label = 1
field_descriptors.ForecastAiNO_entity.has_default_value = false
field_descriptors.ForecastAiNO_entity.default_value = 0
field_descriptors.ForecastAiNO_entity.type = 5
field_descriptors.ForecastAiNO_entity.cpp_type = 1
field_descriptors.ForecastAiNO_target.name = "target"
field_descriptors.ForecastAiNO_target.full_name = ".ForecastAiNO.target"
field_descriptors.ForecastAiNO_target.number = 2
field_descriptors.ForecastAiNO_target.index = 1
field_descriptors.ForecastAiNO_target.label = 1
field_descriptors.ForecastAiNO_target.has_default_value = false
field_descriptors.ForecastAiNO_target.default_value = 0
field_descriptors.ForecastAiNO_target.type = 5
field_descriptors.ForecastAiNO_target.cpp_type = 1
type_descriptors.ForecastAiNO.name = "ForecastAiNO"
type_descriptors.ForecastAiNO.full_name = ".ForecastAiNO"
type_descriptors.ForecastAiNO.nested_types = {}
type_descriptors.ForecastAiNO.enum_types = {}
type_descriptors.ForecastAiNO.fields = {
	field_descriptors.ForecastAiNO_entity,
	field_descriptors.ForecastAiNO_target
}
type_descriptors.ForecastAiNO.is_extendable = false
type_descriptors.ForecastAiNO.extensions = {}
field_descriptors.BuffTriggeredEventNO_entity.name = "entity"
field_descriptors.BuffTriggeredEventNO_entity.full_name = ".BuffTriggeredEventNO.entity"
field_descriptors.BuffTriggeredEventNO_entity.number = 1
field_descriptors.BuffTriggeredEventNO_entity.index = 0
field_descriptors.BuffTriggeredEventNO_entity.label = 1
field_descriptors.BuffTriggeredEventNO_entity.has_default_value = false
field_descriptors.BuffTriggeredEventNO_entity.default_value = 0
field_descriptors.BuffTriggeredEventNO_entity.type = 5
field_descriptors.BuffTriggeredEventNO_entity.cpp_type = 1
field_descriptors.BuffTriggeredEventNO_code.name = "code"
field_descriptors.BuffTriggeredEventNO_code.full_name = ".BuffTriggeredEventNO.code"
field_descriptors.BuffTriggeredEventNO_code.number = 2
field_descriptors.BuffTriggeredEventNO_code.index = 1
field_descriptors.BuffTriggeredEventNO_code.label = 1
field_descriptors.BuffTriggeredEventNO_code.has_default_value = false
field_descriptors.BuffTriggeredEventNO_code.default_value = 0
field_descriptors.BuffTriggeredEventNO_code.type = 5
field_descriptors.BuffTriggeredEventNO_code.cpp_type = 1
field_descriptors.BuffTriggeredEventNO_effects.name = "effects"
field_descriptors.BuffTriggeredEventNO_effects.full_name = ".BuffTriggeredEventNO.effects"
field_descriptors.BuffTriggeredEventNO_effects.number = 3
field_descriptors.BuffTriggeredEventNO_effects.index = 2
field_descriptors.BuffTriggeredEventNO_effects.label = 3
field_descriptors.BuffTriggeredEventNO_effects.has_default_value = false
field_descriptors.BuffTriggeredEventNO_effects.default_value = {}
field_descriptors.BuffTriggeredEventNO_effects.message_type = type_descriptors.EventNO
field_descriptors.BuffTriggeredEventNO_effects.type = 11
field_descriptors.BuffTriggeredEventNO_effects.cpp_type = 10
type_descriptors.BuffTriggeredEventNO.name = "BuffTriggeredEventNO"
type_descriptors.BuffTriggeredEventNO.full_name = ".BuffTriggeredEventNO"
type_descriptors.BuffTriggeredEventNO.nested_types = {}
type_descriptors.BuffTriggeredEventNO.enum_types = {}
type_descriptors.BuffTriggeredEventNO.fields = {
	field_descriptors.BuffTriggeredEventNO_entity,
	field_descriptors.BuffTriggeredEventNO_code,
	field_descriptors.BuffTriggeredEventNO_effects
}
type_descriptors.BuffTriggeredEventNO.is_extendable = false
type_descriptors.BuffTriggeredEventNO.extensions = {}
field_descriptors.EntityHoldNO_entity.name = "entity"
field_descriptors.EntityHoldNO_entity.full_name = ".EntityHoldNO.entity"
field_descriptors.EntityHoldNO_entity.number = 1
field_descriptors.EntityHoldNO_entity.index = 0
field_descriptors.EntityHoldNO_entity.label = 1
field_descriptors.EntityHoldNO_entity.has_default_value = false
field_descriptors.EntityHoldNO_entity.default_value = 0
field_descriptors.EntityHoldNO_entity.type = 5
field_descriptors.EntityHoldNO_entity.cpp_type = 1
field_descriptors.EntityHoldNO_effectTimeline.name = "effectTimeline"
field_descriptors.EntityHoldNO_effectTimeline.full_name = ".EntityHoldNO.effectTimeline"
field_descriptors.EntityHoldNO_effectTimeline.number = 2
field_descriptors.EntityHoldNO_effectTimeline.index = 1
field_descriptors.EntityHoldNO_effectTimeline.label = 1
field_descriptors.EntityHoldNO_effectTimeline.has_default_value = false
field_descriptors.EntityHoldNO_effectTimeline.default_value = ""
field_descriptors.EntityHoldNO_effectTimeline.type = 9
field_descriptors.EntityHoldNO_effectTimeline.cpp_type = 9
type_descriptors.EntityHoldNO.name = "EntityHoldNO"
type_descriptors.EntityHoldNO.full_name = ".EntityHoldNO"
type_descriptors.EntityHoldNO.nested_types = {}
type_descriptors.EntityHoldNO.enum_types = {}
type_descriptors.EntityHoldNO.fields = {
	field_descriptors.EntityHoldNO_entity,
	field_descriptors.EntityHoldNO_effectTimeline
}
type_descriptors.EntityHoldNO.is_extendable = false
type_descriptors.EntityHoldNO.extensions = {}
field_descriptors.MultiEntityHoldNO_entities.name = "entities"
field_descriptors.MultiEntityHoldNO_entities.full_name = ".MultiEntityHoldNO.entities"
field_descriptors.MultiEntityHoldNO_entities.number = 1
field_descriptors.MultiEntityHoldNO_entities.index = 0
field_descriptors.MultiEntityHoldNO_entities.label = 3
field_descriptors.MultiEntityHoldNO_entities.has_default_value = false
field_descriptors.MultiEntityHoldNO_entities.default_value = {}
field_descriptors.MultiEntityHoldNO_entities.message_type = type_descriptors.EntityHoldNO
field_descriptors.MultiEntityHoldNO_entities.type = 11
field_descriptors.MultiEntityHoldNO_entities.cpp_type = 10
type_descriptors.MultiEntityHoldNO.name = "MultiEntityHoldNO"
type_descriptors.MultiEntityHoldNO.full_name = ".MultiEntityHoldNO"
type_descriptors.MultiEntityHoldNO.nested_types = {}
type_descriptors.MultiEntityHoldNO.enum_types = {}
type_descriptors.MultiEntityHoldNO.fields = {
	field_descriptors.MultiEntityHoldNO_entities
}
type_descriptors.MultiEntityHoldNO.is_extendable = false
type_descriptors.MultiEntityHoldNO.extensions = {}
field_descriptors.PlotChainTriggeredEventNO_groupCode.name = "groupCode"
field_descriptors.PlotChainTriggeredEventNO_groupCode.full_name = ".PlotChainTriggeredEventNO.groupCode"
field_descriptors.PlotChainTriggeredEventNO_groupCode.number = 1
field_descriptors.PlotChainTriggeredEventNO_groupCode.index = 0
field_descriptors.PlotChainTriggeredEventNO_groupCode.label = 1
field_descriptors.PlotChainTriggeredEventNO_groupCode.has_default_value = false
field_descriptors.PlotChainTriggeredEventNO_groupCode.default_value = 0
field_descriptors.PlotChainTriggeredEventNO_groupCode.type = 5
field_descriptors.PlotChainTriggeredEventNO_groupCode.cpp_type = 1
field_descriptors.PlotChainTriggeredEventNO_chainCode.name = "chainCode"
field_descriptors.PlotChainTriggeredEventNO_chainCode.full_name = ".PlotChainTriggeredEventNO.chainCode"
field_descriptors.PlotChainTriggeredEventNO_chainCode.number = 2
field_descriptors.PlotChainTriggeredEventNO_chainCode.index = 1
field_descriptors.PlotChainTriggeredEventNO_chainCode.label = 1
field_descriptors.PlotChainTriggeredEventNO_chainCode.has_default_value = false
field_descriptors.PlotChainTriggeredEventNO_chainCode.default_value = 0
field_descriptors.PlotChainTriggeredEventNO_chainCode.type = 5
field_descriptors.PlotChainTriggeredEventNO_chainCode.cpp_type = 1
field_descriptors.PlotChainTriggeredEventNO_events.name = "events"
field_descriptors.PlotChainTriggeredEventNO_events.full_name = ".PlotChainTriggeredEventNO.events"
field_descriptors.PlotChainTriggeredEventNO_events.number = 3
field_descriptors.PlotChainTriggeredEventNO_events.index = 2
field_descriptors.PlotChainTriggeredEventNO_events.label = 3
field_descriptors.PlotChainTriggeredEventNO_events.has_default_value = false
field_descriptors.PlotChainTriggeredEventNO_events.default_value = {}
field_descriptors.PlotChainTriggeredEventNO_events.message_type = type_descriptors.EventNO
field_descriptors.PlotChainTriggeredEventNO_events.type = 11
field_descriptors.PlotChainTriggeredEventNO_events.cpp_type = 10
type_descriptors.PlotChainTriggeredEventNO.name = "PlotChainTriggeredEventNO"
type_descriptors.PlotChainTriggeredEventNO.full_name = ".PlotChainTriggeredEventNO"
type_descriptors.PlotChainTriggeredEventNO.nested_types = {}
type_descriptors.PlotChainTriggeredEventNO.enum_types = {}
type_descriptors.PlotChainTriggeredEventNO.fields = {
	field_descriptors.PlotChainTriggeredEventNO_groupCode,
	field_descriptors.PlotChainTriggeredEventNO_chainCode,
	field_descriptors.PlotChainTriggeredEventNO_events
}
type_descriptors.PlotChainTriggeredEventNO.is_extendable = false
type_descriptors.PlotChainTriggeredEventNO.extensions = {}
field_descriptors.WeakPointAddedEventNO_entity.name = "entity"
field_descriptors.WeakPointAddedEventNO_entity.full_name = ".WeakPointAddedEventNO.entity"
field_descriptors.WeakPointAddedEventNO_entity.number = 1
field_descriptors.WeakPointAddedEventNO_entity.index = 0
field_descriptors.WeakPointAddedEventNO_entity.label = 1
field_descriptors.WeakPointAddedEventNO_entity.has_default_value = false
field_descriptors.WeakPointAddedEventNO_entity.default_value = 0
field_descriptors.WeakPointAddedEventNO_entity.type = 5
field_descriptors.WeakPointAddedEventNO_entity.cpp_type = 1
field_descriptors.WeakPointAddedEventNO_hp.name = "hp"
field_descriptors.WeakPointAddedEventNO_hp.full_name = ".WeakPointAddedEventNO.hp"
field_descriptors.WeakPointAddedEventNO_hp.number = 2
field_descriptors.WeakPointAddedEventNO_hp.index = 1
field_descriptors.WeakPointAddedEventNO_hp.label = 1
field_descriptors.WeakPointAddedEventNO_hp.has_default_value = false
field_descriptors.WeakPointAddedEventNO_hp.default_value = 0
field_descriptors.WeakPointAddedEventNO_hp.type = 5
field_descriptors.WeakPointAddedEventNO_hp.cpp_type = 1
field_descriptors.WeakPointAddedEventNO_type.name = "type"
field_descriptors.WeakPointAddedEventNO_type.full_name = ".WeakPointAddedEventNO.type"
field_descriptors.WeakPointAddedEventNO_type.number = 3
field_descriptors.WeakPointAddedEventNO_type.index = 2
field_descriptors.WeakPointAddedEventNO_type.label = 1
field_descriptors.WeakPointAddedEventNO_type.has_default_value = false
field_descriptors.WeakPointAddedEventNO_type.default_value = 0
field_descriptors.WeakPointAddedEventNO_type.type = 5
field_descriptors.WeakPointAddedEventNO_type.cpp_type = 1
type_descriptors.WeakPointAddedEventNO.name = "WeakPointAddedEventNO"
type_descriptors.WeakPointAddedEventNO.full_name = ".WeakPointAddedEventNO"
type_descriptors.WeakPointAddedEventNO.nested_types = {}
type_descriptors.WeakPointAddedEventNO.enum_types = {}
type_descriptors.WeakPointAddedEventNO.fields = {
	field_descriptors.WeakPointAddedEventNO_entity,
	field_descriptors.WeakPointAddedEventNO_hp,
	field_descriptors.WeakPointAddedEventNO_type
}
type_descriptors.WeakPointAddedEventNO.is_extendable = false
type_descriptors.WeakPointAddedEventNO.extensions = {}
field_descriptors.HaloRefreshedEventNO_linked.name = "linked"
field_descriptors.HaloRefreshedEventNO_linked.full_name = ".HaloRefreshedEventNO.linked"
field_descriptors.HaloRefreshedEventNO_linked.number = 1
field_descriptors.HaloRefreshedEventNO_linked.index = 0
field_descriptors.HaloRefreshedEventNO_linked.label = 3
field_descriptors.HaloRefreshedEventNO_linked.has_default_value = false
field_descriptors.HaloRefreshedEventNO_linked.default_value = {}
field_descriptors.HaloRefreshedEventNO_linked.message_type = type_descriptors.HaloLinkedNO
field_descriptors.HaloRefreshedEventNO_linked.type = 11
field_descriptors.HaloRefreshedEventNO_linked.cpp_type = 10
field_descriptors.HaloRefreshedEventNO_unlinked.name = "unlinked"
field_descriptors.HaloRefreshedEventNO_unlinked.full_name = ".HaloRefreshedEventNO.unlinked"
field_descriptors.HaloRefreshedEventNO_unlinked.number = 2
field_descriptors.HaloRefreshedEventNO_unlinked.index = 1
field_descriptors.HaloRefreshedEventNO_unlinked.label = 3
field_descriptors.HaloRefreshedEventNO_unlinked.has_default_value = false
field_descriptors.HaloRefreshedEventNO_unlinked.default_value = {}
field_descriptors.HaloRefreshedEventNO_unlinked.message_type = type_descriptors.HaloLinkedNO
field_descriptors.HaloRefreshedEventNO_unlinked.type = 11
field_descriptors.HaloRefreshedEventNO_unlinked.cpp_type = 10
type_descriptors.HaloRefreshedEventNO.name = "HaloRefreshedEventNO"
type_descriptors.HaloRefreshedEventNO.full_name = ".HaloRefreshedEventNO"
type_descriptors.HaloRefreshedEventNO.nested_types = {}
type_descriptors.HaloRefreshedEventNO.enum_types = {}
type_descriptors.HaloRefreshedEventNO.fields = {
	field_descriptors.HaloRefreshedEventNO_linked,
	field_descriptors.HaloRefreshedEventNO_unlinked
}
type_descriptors.HaloRefreshedEventNO.is_extendable = false
type_descriptors.HaloRefreshedEventNO.extensions = {}
field_descriptors.EntityDeadEventNO_entity.name = "entity"
field_descriptors.EntityDeadEventNO_entity.full_name = ".EntityDeadEventNO.entity"
field_descriptors.EntityDeadEventNO_entity.number = 1
field_descriptors.EntityDeadEventNO_entity.index = 0
field_descriptors.EntityDeadEventNO_entity.label = 1
field_descriptors.EntityDeadEventNO_entity.has_default_value = false
field_descriptors.EntityDeadEventNO_entity.default_value = 0
field_descriptors.EntityDeadEventNO_entity.type = 5
field_descriptors.EntityDeadEventNO_entity.cpp_type = 1
field_descriptors.EntityDeadEventNO_reason.name = "reason"
field_descriptors.EntityDeadEventNO_reason.full_name = ".EntityDeadEventNO.reason"
field_descriptors.EntityDeadEventNO_reason.number = 2
field_descriptors.EntityDeadEventNO_reason.index = 1
field_descriptors.EntityDeadEventNO_reason.label = 1
field_descriptors.EntityDeadEventNO_reason.has_default_value = false
field_descriptors.EntityDeadEventNO_reason.default_value = nil
field_descriptors.EntityDeadEventNO_reason.enum_type = type_descriptors.DeadReason
field_descriptors.EntityDeadEventNO_reason.type = 14
field_descriptors.EntityDeadEventNO_reason.cpp_type = 8
type_descriptors.EntityDeadEventNO.name = "EntityDeadEventNO"
type_descriptors.EntityDeadEventNO.full_name = ".EntityDeadEventNO"
type_descriptors.EntityDeadEventNO.nested_types = {}
type_descriptors.EntityDeadEventNO.enum_types = {}
type_descriptors.EntityDeadEventNO.fields = {
	field_descriptors.EntityDeadEventNO_entity,
	field_descriptors.EntityDeadEventNO_reason
}
type_descriptors.EntityDeadEventNO.is_extendable = false
type_descriptors.EntityDeadEventNO.extensions = {}
type_descriptors.BackToReply.name = "BackToReply"
type_descriptors.BackToReply.full_name = ".BackToReply"
type_descriptors.BackToReply.nested_types = {}
type_descriptors.BackToReply.enum_types = {}
type_descriptors.BackToReply.fields = {}
type_descriptors.BackToReply.is_extendable = false
type_descriptors.BackToReply.extensions = {}
type_descriptors.ConnectCompleteReply.name = "ConnectCompleteReply"
type_descriptors.ConnectCompleteReply.full_name = ".ConnectCompleteReply"
type_descriptors.ConnectCompleteReply.nested_types = {}
type_descriptors.ConnectCompleteReply.enum_types = {}
type_descriptors.ConnectCompleteReply.fields = {}
type_descriptors.ConnectCompleteReply.is_extendable = false
type_descriptors.ConnectCompleteReply.extensions = {}
type_descriptors.PostEventAnimationRequest.name = "PostEventAnimationRequest"
type_descriptors.PostEventAnimationRequest.full_name = ".PostEventAnimationRequest"
type_descriptors.PostEventAnimationRequest.nested_types = {}
type_descriptors.PostEventAnimationRequest.enum_types = {}
type_descriptors.PostEventAnimationRequest.fields = {}
type_descriptors.PostEventAnimationRequest.is_extendable = false
type_descriptors.PostEventAnimationRequest.extensions = {}
field_descriptors.CenterShapeNO_center.name = "center"
field_descriptors.CenterShapeNO_center.full_name = ".CenterShapeNO.center"
field_descriptors.CenterShapeNO_center.number = 1
field_descriptors.CenterShapeNO_center.index = 0
field_descriptors.CenterShapeNO_center.label = 1
field_descriptors.CenterShapeNO_center.has_default_value = false
field_descriptors.CenterShapeNO_center.default_value = nil
field_descriptors.CenterShapeNO_center.message_type = type_descriptors.CellNO
field_descriptors.CenterShapeNO_center.type = 11
field_descriptors.CenterShapeNO_center.cpp_type = 10
field_descriptors.CenterShapeNO_shape.name = "shape"
field_descriptors.CenterShapeNO_shape.full_name = ".CenterShapeNO.shape"
field_descriptors.CenterShapeNO_shape.number = 2
field_descriptors.CenterShapeNO_shape.index = 1
field_descriptors.CenterShapeNO_shape.label = 1
field_descriptors.CenterShapeNO_shape.has_default_value = false
field_descriptors.CenterShapeNO_shape.default_value = nil
field_descriptors.CenterShapeNO_shape.message_type = type_descriptors.ShapeNO
field_descriptors.CenterShapeNO_shape.type = 11
field_descriptors.CenterShapeNO_shape.cpp_type = 10
type_descriptors.CenterShapeNO.name = "CenterShapeNO"
type_descriptors.CenterShapeNO.full_name = ".CenterShapeNO"
type_descriptors.CenterShapeNO.nested_types = {}
type_descriptors.CenterShapeNO.enum_types = {}
type_descriptors.CenterShapeNO.fields = {
	field_descriptors.CenterShapeNO_center,
	field_descriptors.CenterShapeNO_shape
}
type_descriptors.CenterShapeNO.is_extendable = false
type_descriptors.CenterShapeNO.extensions = {}
field_descriptors.TriggeringNO_events.name = "events"
field_descriptors.TriggeringNO_events.full_name = ".TriggeringNO.events"
field_descriptors.TriggeringNO_events.number = 1
field_descriptors.TriggeringNO_events.index = 0
field_descriptors.TriggeringNO_events.label = 3
field_descriptors.TriggeringNO_events.has_default_value = false
field_descriptors.TriggeringNO_events.default_value = {}
field_descriptors.TriggeringNO_events.message_type = type_descriptors.EventNO
field_descriptors.TriggeringNO_events.type = 11
field_descriptors.TriggeringNO_events.cpp_type = 10
type_descriptors.TriggeringNO.name = "TriggeringNO"
type_descriptors.TriggeringNO.full_name = ".TriggeringNO"
type_descriptors.TriggeringNO.nested_types = {}
type_descriptors.TriggeringNO.enum_types = {}
type_descriptors.TriggeringNO.fields = {
	field_descriptors.TriggeringNO_events
}
type_descriptors.TriggeringNO.is_extendable = false
type_descriptors.TriggeringNO.extensions = {}
type_descriptors.PostEventAnimationReply.name = "PostEventAnimationReply"
type_descriptors.PostEventAnimationReply.full_name = ".PostEventAnimationReply"
type_descriptors.PostEventAnimationReply.nested_types = {}
type_descriptors.PostEventAnimationReply.enum_types = {}
type_descriptors.PostEventAnimationReply.fields = {}
type_descriptors.PostEventAnimationReply.is_extendable = false
type_descriptors.PostEventAnimationReply.extensions = {}
field_descriptors.SkillSourceNO_type.name = "type"
field_descriptors.SkillSourceNO_type.full_name = ".SkillSourceNO.type"
field_descriptors.SkillSourceNO_type.number = 1
field_descriptors.SkillSourceNO_type.index = 0
field_descriptors.SkillSourceNO_type.label = 1
field_descriptors.SkillSourceNO_type.has_default_value = false
field_descriptors.SkillSourceNO_type.default_value = nil
field_descriptors.SkillSourceNO_type.enum_type = type_descriptors.SkillSourceType
field_descriptors.SkillSourceNO_type.type = 14
field_descriptors.SkillSourceNO_type.cpp_type = 8
field_descriptors.SkillSourceNO_id.name = "id"
field_descriptors.SkillSourceNO_id.full_name = ".SkillSourceNO.id"
field_descriptors.SkillSourceNO_id.number = 2
field_descriptors.SkillSourceNO_id.index = 1
field_descriptors.SkillSourceNO_id.label = 1
field_descriptors.SkillSourceNO_id.has_default_value = false
field_descriptors.SkillSourceNO_id.default_value = 0
field_descriptors.SkillSourceNO_id.type = 5
field_descriptors.SkillSourceNO_id.cpp_type = 1
type_descriptors.SkillSourceNO.name = "SkillSourceNO"
type_descriptors.SkillSourceNO.full_name = ".SkillSourceNO"
type_descriptors.SkillSourceNO.nested_types = {}
type_descriptors.SkillSourceNO.enum_types = {}
type_descriptors.SkillSourceNO.fields = {
	field_descriptors.SkillSourceNO_type,
	field_descriptors.SkillSourceNO_id
}
type_descriptors.SkillSourceNO.is_extendable = false
type_descriptors.SkillSourceNO.extensions = {}
field_descriptors.CircleNO_radius.name = "radius"
field_descriptors.CircleNO_radius.full_name = ".CircleNO.radius"
field_descriptors.CircleNO_radius.number = 1
field_descriptors.CircleNO_radius.index = 0
field_descriptors.CircleNO_radius.label = 1
field_descriptors.CircleNO_radius.has_default_value = false
field_descriptors.CircleNO_radius.default_value = 0
field_descriptors.CircleNO_radius.type = 5
field_descriptors.CircleNO_radius.cpp_type = 1
type_descriptors.CircleNO.name = "CircleNO"
type_descriptors.CircleNO.full_name = ".CircleNO"
type_descriptors.CircleNO.nested_types = {}
type_descriptors.CircleNO.enum_types = {}
type_descriptors.CircleNO.fields = {
	field_descriptors.CircleNO_radius
}
type_descriptors.CircleNO.is_extendable = false
type_descriptors.CircleNO.extensions = {}
field_descriptors.BattlefieldNO_id.name = "id"
field_descriptors.BattlefieldNO_id.full_name = ".BattlefieldNO.id"
field_descriptors.BattlefieldNO_id.number = 1
field_descriptors.BattlefieldNO_id.index = 0
field_descriptors.BattlefieldNO_id.label = 1
field_descriptors.BattlefieldNO_id.has_default_value = false
field_descriptors.BattlefieldNO_id.default_value = 0
field_descriptors.BattlefieldNO_id.type = 5
field_descriptors.BattlefieldNO_id.cpp_type = 1
field_descriptors.BattlefieldNO_map.name = "map"
field_descriptors.BattlefieldNO_map.full_name = ".BattlefieldNO.map"
field_descriptors.BattlefieldNO_map.number = 2
field_descriptors.BattlefieldNO_map.index = 1
field_descriptors.BattlefieldNO_map.label = 1
field_descriptors.BattlefieldNO_map.has_default_value = false
field_descriptors.BattlefieldNO_map.default_value = 0
field_descriptors.BattlefieldNO_map.type = 5
field_descriptors.BattlefieldNO_map.cpp_type = 1
field_descriptors.BattlefieldNO_myPlayerId.name = "myPlayerId"
field_descriptors.BattlefieldNO_myPlayerId.full_name = ".BattlefieldNO.myPlayerId"
field_descriptors.BattlefieldNO_myPlayerId.number = 3
field_descriptors.BattlefieldNO_myPlayerId.index = 2
field_descriptors.BattlefieldNO_myPlayerId.label = 1
field_descriptors.BattlefieldNO_myPlayerId.has_default_value = false
field_descriptors.BattlefieldNO_myPlayerId.default_value = 0
field_descriptors.BattlefieldNO_myPlayerId.type = 5
field_descriptors.BattlefieldNO_myPlayerId.cpp_type = 1
field_descriptors.BattlefieldNO_entities.name = "entities"
field_descriptors.BattlefieldNO_entities.full_name = ".BattlefieldNO.entities"
field_descriptors.BattlefieldNO_entities.number = 4
field_descriptors.BattlefieldNO_entities.index = 3
field_descriptors.BattlefieldNO_entities.label = 3
field_descriptors.BattlefieldNO_entities.has_default_value = false
field_descriptors.BattlefieldNO_entities.default_value = {}
field_descriptors.BattlefieldNO_entities.message_type = type_descriptors.EntityNO
field_descriptors.BattlefieldNO_entities.type = 11
field_descriptors.BattlefieldNO_entities.cpp_type = 10
field_descriptors.BattlefieldNO_stages.name = "stages"
field_descriptors.BattlefieldNO_stages.full_name = ".BattlefieldNO.stages"
field_descriptors.BattlefieldNO_stages.number = 5
field_descriptors.BattlefieldNO_stages.index = 4
field_descriptors.BattlefieldNO_stages.label = 3
field_descriptors.BattlefieldNO_stages.has_default_value = false
field_descriptors.BattlefieldNO_stages.default_value = {}
field_descriptors.BattlefieldNO_stages.message_type = type_descriptors.StageNO
field_descriptors.BattlefieldNO_stages.type = 11
field_descriptors.BattlefieldNO_stages.cpp_type = 10
field_descriptors.BattlefieldNO_cells.name = "cells"
field_descriptors.BattlefieldNO_cells.full_name = ".BattlefieldNO.cells"
field_descriptors.BattlefieldNO_cells.number = 6
field_descriptors.BattlefieldNO_cells.index = 5
field_descriptors.BattlefieldNO_cells.label = 3
field_descriptors.BattlefieldNO_cells.has_default_value = false
field_descriptors.BattlefieldNO_cells.default_value = {}
field_descriptors.BattlefieldNO_cells.message_type = type_descriptors.CellNO
field_descriptors.BattlefieldNO_cells.type = 11
field_descriptors.BattlefieldNO_cells.cpp_type = 10
field_descriptors.BattlefieldNO_haloLinks.name = "haloLinks"
field_descriptors.BattlefieldNO_haloLinks.full_name = ".BattlefieldNO.haloLinks"
field_descriptors.BattlefieldNO_haloLinks.number = 7
field_descriptors.BattlefieldNO_haloLinks.index = 6
field_descriptors.BattlefieldNO_haloLinks.label = 3
field_descriptors.BattlefieldNO_haloLinks.has_default_value = false
field_descriptors.BattlefieldNO_haloLinks.default_value = {}
field_descriptors.BattlefieldNO_haloLinks.message_type = type_descriptors.HaloLinkedNO
field_descriptors.BattlefieldNO_haloLinks.type = 11
field_descriptors.BattlefieldNO_haloLinks.cpp_type = 10
field_descriptors.BattlefieldNO_systemPlayer.name = "systemPlayer"
field_descriptors.BattlefieldNO_systemPlayer.full_name = ".BattlefieldNO.systemPlayer"
field_descriptors.BattlefieldNO_systemPlayer.number = 8
field_descriptors.BattlefieldNO_systemPlayer.index = 7
field_descriptors.BattlefieldNO_systemPlayer.label = 1
field_descriptors.BattlefieldNO_systemPlayer.has_default_value = false
field_descriptors.BattlefieldNO_systemPlayer.default_value = nil
field_descriptors.BattlefieldNO_systemPlayer.message_type = type_descriptors.PlayerNO
field_descriptors.BattlefieldNO_systemPlayer.type = 11
field_descriptors.BattlefieldNO_systemPlayer.cpp_type = 10
field_descriptors.BattlefieldNO_multiRoundAoes.name = "multiRoundAoes"
field_descriptors.BattlefieldNO_multiRoundAoes.full_name = ".BattlefieldNO.multiRoundAoes"
field_descriptors.BattlefieldNO_multiRoundAoes.number = 9
field_descriptors.BattlefieldNO_multiRoundAoes.index = 8
field_descriptors.BattlefieldNO_multiRoundAoes.label = 3
field_descriptors.BattlefieldNO_multiRoundAoes.has_default_value = false
field_descriptors.BattlefieldNO_multiRoundAoes.default_value = {}
field_descriptors.BattlefieldNO_multiRoundAoes.message_type = type_descriptors.MultiRoundAoeNO
field_descriptors.BattlefieldNO_multiRoundAoes.type = 11
field_descriptors.BattlefieldNO_multiRoundAoes.cpp_type = 10
field_descriptors.BattlefieldNO_round.name = "round"
field_descriptors.BattlefieldNO_round.full_name = ".BattlefieldNO.round"
field_descriptors.BattlefieldNO_round.number = 10
field_descriptors.BattlefieldNO_round.index = 9
field_descriptors.BattlefieldNO_round.label = 1
field_descriptors.BattlefieldNO_round.has_default_value = false
field_descriptors.BattlefieldNO_round.default_value = 0
field_descriptors.BattlefieldNO_round.type = 5
field_descriptors.BattlefieldNO_round.cpp_type = 1
field_descriptors.BattlefieldNO_battleExtra.name = "battleExtra"
field_descriptors.BattlefieldNO_battleExtra.full_name = ".BattlefieldNO.battleExtra"
field_descriptors.BattlefieldNO_battleExtra.number = 11
field_descriptors.BattlefieldNO_battleExtra.index = 10
field_descriptors.BattlefieldNO_battleExtra.label = 3
field_descriptors.BattlefieldNO_battleExtra.has_default_value = false
field_descriptors.BattlefieldNO_battleExtra.default_value = {}
field_descriptors.BattlefieldNO_battleExtra.message_type = type_descriptors.BattleExtraNO
field_descriptors.BattlefieldNO_battleExtra.type = 11
field_descriptors.BattlefieldNO_battleExtra.cpp_type = 10
field_descriptors.BattlefieldNO_stepPlayer.name = "stepPlayer"
field_descriptors.BattlefieldNO_stepPlayer.full_name = ".BattlefieldNO.stepPlayer"
field_descriptors.BattlefieldNO_stepPlayer.number = 12
field_descriptors.BattlefieldNO_stepPlayer.index = 11
field_descriptors.BattlefieldNO_stepPlayer.label = 1
field_descriptors.BattlefieldNO_stepPlayer.has_default_value = false
field_descriptors.BattlefieldNO_stepPlayer.default_value = 0
field_descriptors.BattlefieldNO_stepPlayer.type = 5
field_descriptors.BattlefieldNO_stepPlayer.cpp_type = 1
field_descriptors.BattlefieldNO_stepHistory.name = "stepHistory"
field_descriptors.BattlefieldNO_stepHistory.full_name = ".BattlefieldNO.stepHistory"
field_descriptors.BattlefieldNO_stepHistory.number = 13
field_descriptors.BattlefieldNO_stepHistory.index = 12
field_descriptors.BattlefieldNO_stepHistory.label = 3
field_descriptors.BattlefieldNO_stepHistory.has_default_value = false
field_descriptors.BattlefieldNO_stepHistory.default_value = {}
field_descriptors.BattlefieldNO_stepHistory.message_type = type_descriptors.StepHistoryNO
field_descriptors.BattlefieldNO_stepHistory.type = 11
field_descriptors.BattlefieldNO_stepHistory.cpp_type = 10
field_descriptors.BattlefieldNO_leftBackCount.name = "leftBackCount"
field_descriptors.BattlefieldNO_leftBackCount.full_name = ".BattlefieldNO.leftBackCount"
field_descriptors.BattlefieldNO_leftBackCount.number = 14
field_descriptors.BattlefieldNO_leftBackCount.index = 13
field_descriptors.BattlefieldNO_leftBackCount.label = 1
field_descriptors.BattlefieldNO_leftBackCount.has_default_value = false
field_descriptors.BattlefieldNO_leftBackCount.default_value = 0
field_descriptors.BattlefieldNO_leftBackCount.type = 5
field_descriptors.BattlefieldNO_leftBackCount.cpp_type = 1
field_descriptors.BattlefieldNO_aiMode.name = "aiMode"
field_descriptors.BattlefieldNO_aiMode.full_name = ".BattlefieldNO.aiMode"
field_descriptors.BattlefieldNO_aiMode.number = 15
field_descriptors.BattlefieldNO_aiMode.index = 14
field_descriptors.BattlefieldNO_aiMode.label = 1
field_descriptors.BattlefieldNO_aiMode.has_default_value = false
field_descriptors.BattlefieldNO_aiMode.default_value = nil
field_descriptors.BattlefieldNO_aiMode.enum_type = type_descriptors.AiMode
field_descriptors.BattlefieldNO_aiMode.type = 14
field_descriptors.BattlefieldNO_aiMode.cpp_type = 8
field_descriptors.BattlefieldNO_heros.name = "heros"
field_descriptors.BattlefieldNO_heros.full_name = ".BattlefieldNO.heros"
field_descriptors.BattlefieldNO_heros.number = 16
field_descriptors.BattlefieldNO_heros.index = 15
field_descriptors.BattlefieldNO_heros.label = 3
field_descriptors.BattlefieldNO_heros.has_default_value = false
field_descriptors.BattlefieldNO_heros.default_value = {}
field_descriptors.BattlefieldNO_heros.type = 5
field_descriptors.BattlefieldNO_heros.cpp_type = 1
type_descriptors.BattlefieldNO.name = "BattlefieldNO"
type_descriptors.BattlefieldNO.full_name = ".BattlefieldNO"
type_descriptors.BattlefieldNO.nested_types = {}
type_descriptors.BattlefieldNO.enum_types = {}
type_descriptors.BattlefieldNO.fields = {
	field_descriptors.BattlefieldNO_id,
	field_descriptors.BattlefieldNO_map,
	field_descriptors.BattlefieldNO_myPlayerId,
	field_descriptors.BattlefieldNO_entities,
	field_descriptors.BattlefieldNO_stages,
	field_descriptors.BattlefieldNO_cells,
	field_descriptors.BattlefieldNO_haloLinks,
	field_descriptors.BattlefieldNO_systemPlayer,
	field_descriptors.BattlefieldNO_multiRoundAoes,
	field_descriptors.BattlefieldNO_round,
	field_descriptors.BattlefieldNO_battleExtra,
	field_descriptors.BattlefieldNO_stepPlayer,
	field_descriptors.BattlefieldNO_stepHistory,
	field_descriptors.BattlefieldNO_leftBackCount,
	field_descriptors.BattlefieldNO_aiMode,
	field_descriptors.BattlefieldNO_heros
}
type_descriptors.BattlefieldNO.is_extendable = false
type_descriptors.BattlefieldNO.extensions = {}
field_descriptors.TagEnhanceAddNO_entity.name = "entity"
field_descriptors.TagEnhanceAddNO_entity.full_name = ".TagEnhanceAddNO.entity"
field_descriptors.TagEnhanceAddNO_entity.number = 1
field_descriptors.TagEnhanceAddNO_entity.index = 0
field_descriptors.TagEnhanceAddNO_entity.label = 2
field_descriptors.TagEnhanceAddNO_entity.has_default_value = false
field_descriptors.TagEnhanceAddNO_entity.default_value = 0
field_descriptors.TagEnhanceAddNO_entity.type = 5
field_descriptors.TagEnhanceAddNO_entity.cpp_type = 1
field_descriptors.TagEnhanceAddNO_contexts.name = "contexts"
field_descriptors.TagEnhanceAddNO_contexts.full_name = ".TagEnhanceAddNO.contexts"
field_descriptors.TagEnhanceAddNO_contexts.number = 2
field_descriptors.TagEnhanceAddNO_contexts.index = 1
field_descriptors.TagEnhanceAddNO_contexts.label = 3
field_descriptors.TagEnhanceAddNO_contexts.has_default_value = false
field_descriptors.TagEnhanceAddNO_contexts.default_value = {}
field_descriptors.TagEnhanceAddNO_contexts.message_type = type_descriptors.TagEnhanceNO
field_descriptors.TagEnhanceAddNO_contexts.type = 11
field_descriptors.TagEnhanceAddNO_contexts.cpp_type = 10
type_descriptors.TagEnhanceAddNO.name = "TagEnhanceAddNO"
type_descriptors.TagEnhanceAddNO.full_name = ".TagEnhanceAddNO"
type_descriptors.TagEnhanceAddNO.nested_types = {}
type_descriptors.TagEnhanceAddNO.enum_types = {}
type_descriptors.TagEnhanceAddNO.fields = {
	field_descriptors.TagEnhanceAddNO_entity,
	field_descriptors.TagEnhanceAddNO_contexts
}
type_descriptors.TagEnhanceAddNO.is_extendable = false
type_descriptors.TagEnhanceAddNO.extensions = {}
field_descriptors.ShapeWithRootNO_root.name = "root"
field_descriptors.ShapeWithRootNO_root.full_name = ".ShapeWithRootNO.root"
field_descriptors.ShapeWithRootNO_root.number = 1
field_descriptors.ShapeWithRootNO_root.index = 0
field_descriptors.ShapeWithRootNO_root.label = 1
field_descriptors.ShapeWithRootNO_root.has_default_value = false
field_descriptors.ShapeWithRootNO_root.default_value = nil
field_descriptors.ShapeWithRootNO_root.message_type = type_descriptors.CellNO
field_descriptors.ShapeWithRootNO_root.type = 11
field_descriptors.ShapeWithRootNO_root.cpp_type = 10
field_descriptors.ShapeWithRootNO_entity.name = "entity"
field_descriptors.ShapeWithRootNO_entity.full_name = ".ShapeWithRootNO.entity"
field_descriptors.ShapeWithRootNO_entity.number = 2
field_descriptors.ShapeWithRootNO_entity.index = 1
field_descriptors.ShapeWithRootNO_entity.label = 1
field_descriptors.ShapeWithRootNO_entity.has_default_value = false
field_descriptors.ShapeWithRootNO_entity.default_value = 0
field_descriptors.ShapeWithRootNO_entity.type = 5
field_descriptors.ShapeWithRootNO_entity.cpp_type = 1
field_descriptors.ShapeWithRootNO_shape.name = "shape"
field_descriptors.ShapeWithRootNO_shape.full_name = ".ShapeWithRootNO.shape"
field_descriptors.ShapeWithRootNO_shape.number = 3
field_descriptors.ShapeWithRootNO_shape.index = 2
field_descriptors.ShapeWithRootNO_shape.label = 1
field_descriptors.ShapeWithRootNO_shape.has_default_value = false
field_descriptors.ShapeWithRootNO_shape.default_value = nil
field_descriptors.ShapeWithRootNO_shape.message_type = type_descriptors.ShapeNO
field_descriptors.ShapeWithRootNO_shape.type = 11
field_descriptors.ShapeWithRootNO_shape.cpp_type = 10
type_descriptors.ShapeWithRootNO.name = "ShapeWithRootNO"
type_descriptors.ShapeWithRootNO.full_name = ".ShapeWithRootNO"
type_descriptors.ShapeWithRootNO.nested_types = {}
type_descriptors.ShapeWithRootNO.enum_types = {}
type_descriptors.ShapeWithRootNO.fields = {
	field_descriptors.ShapeWithRootNO_root,
	field_descriptors.ShapeWithRootNO_entity,
	field_descriptors.ShapeWithRootNO_shape
}
type_descriptors.ShapeWithRootNO.is_extendable = false
type_descriptors.ShapeWithRootNO.extensions = {}
field_descriptors.HaloLinkedNO_fromEntity.name = "fromEntity"
field_descriptors.HaloLinkedNO_fromEntity.full_name = ".HaloLinkedNO.fromEntity"
field_descriptors.HaloLinkedNO_fromEntity.number = 1
field_descriptors.HaloLinkedNO_fromEntity.index = 0
field_descriptors.HaloLinkedNO_fromEntity.label = 1
field_descriptors.HaloLinkedNO_fromEntity.has_default_value = false
field_descriptors.HaloLinkedNO_fromEntity.default_value = 0
field_descriptors.HaloLinkedNO_fromEntity.type = 5
field_descriptors.HaloLinkedNO_fromEntity.cpp_type = 1
field_descriptors.HaloLinkedNO_fromSkill.name = "fromSkill"
field_descriptors.HaloLinkedNO_fromSkill.full_name = ".HaloLinkedNO.fromSkill"
field_descriptors.HaloLinkedNO_fromSkill.number = 2
field_descriptors.HaloLinkedNO_fromSkill.index = 1
field_descriptors.HaloLinkedNO_fromSkill.label = 1
field_descriptors.HaloLinkedNO_fromSkill.has_default_value = false
field_descriptors.HaloLinkedNO_fromSkill.default_value = 0
field_descriptors.HaloLinkedNO_fromSkill.type = 5
field_descriptors.HaloLinkedNO_fromSkill.cpp_type = 1
field_descriptors.HaloLinkedNO_toEntity.name = "toEntity"
field_descriptors.HaloLinkedNO_toEntity.full_name = ".HaloLinkedNO.toEntity"
field_descriptors.HaloLinkedNO_toEntity.number = 3
field_descriptors.HaloLinkedNO_toEntity.index = 2
field_descriptors.HaloLinkedNO_toEntity.label = 1
field_descriptors.HaloLinkedNO_toEntity.has_default_value = false
field_descriptors.HaloLinkedNO_toEntity.default_value = 0
field_descriptors.HaloLinkedNO_toEntity.type = 5
field_descriptors.HaloLinkedNO_toEntity.cpp_type = 1
field_descriptors.HaloLinkedNO_effects.name = "effects"
field_descriptors.HaloLinkedNO_effects.full_name = ".HaloLinkedNO.effects"
field_descriptors.HaloLinkedNO_effects.number = 4
field_descriptors.HaloLinkedNO_effects.index = 3
field_descriptors.HaloLinkedNO_effects.label = 3
field_descriptors.HaloLinkedNO_effects.has_default_value = false
field_descriptors.HaloLinkedNO_effects.default_value = {}
field_descriptors.HaloLinkedNO_effects.message_type = type_descriptors.EventNO
field_descriptors.HaloLinkedNO_effects.type = 11
field_descriptors.HaloLinkedNO_effects.cpp_type = 10
type_descriptors.HaloLinkedNO.name = "HaloLinkedNO"
type_descriptors.HaloLinkedNO.full_name = ".HaloLinkedNO"
type_descriptors.HaloLinkedNO.nested_types = {}
type_descriptors.HaloLinkedNO.enum_types = {}
type_descriptors.HaloLinkedNO.fields = {
	field_descriptors.HaloLinkedNO_fromEntity,
	field_descriptors.HaloLinkedNO_fromSkill,
	field_descriptors.HaloLinkedNO_toEntity,
	field_descriptors.HaloLinkedNO_effects
}
type_descriptors.HaloLinkedNO.is_extendable = false
type_descriptors.HaloLinkedNO.extensions = {}
field_descriptors.AttributeModifiedEventNO_entity.name = "entity"
field_descriptors.AttributeModifiedEventNO_entity.full_name = ".AttributeModifiedEventNO.entity"
field_descriptors.AttributeModifiedEventNO_entity.number = 1
field_descriptors.AttributeModifiedEventNO_entity.index = 0
field_descriptors.AttributeModifiedEventNO_entity.label = 1
field_descriptors.AttributeModifiedEventNO_entity.has_default_value = false
field_descriptors.AttributeModifiedEventNO_entity.default_value = 0
field_descriptors.AttributeModifiedEventNO_entity.type = 5
field_descriptors.AttributeModifiedEventNO_entity.cpp_type = 1
field_descriptors.AttributeModifiedEventNO_attr.name = "attr"
field_descriptors.AttributeModifiedEventNO_attr.full_name = ".AttributeModifiedEventNO.attr"
field_descriptors.AttributeModifiedEventNO_attr.number = 2
field_descriptors.AttributeModifiedEventNO_attr.index = 1
field_descriptors.AttributeModifiedEventNO_attr.label = 1
field_descriptors.AttributeModifiedEventNO_attr.has_default_value = false
field_descriptors.AttributeModifiedEventNO_attr.default_value = nil
field_descriptors.AttributeModifiedEventNO_attr.enum_type = type_descriptors.Attribute
field_descriptors.AttributeModifiedEventNO_attr.type = 14
field_descriptors.AttributeModifiedEventNO_attr.cpp_type = 8
field_descriptors.AttributeModifiedEventNO_value.name = "value"
field_descriptors.AttributeModifiedEventNO_value.full_name = ".AttributeModifiedEventNO.value"
field_descriptors.AttributeModifiedEventNO_value.number = 3
field_descriptors.AttributeModifiedEventNO_value.index = 2
field_descriptors.AttributeModifiedEventNO_value.label = 1
field_descriptors.AttributeModifiedEventNO_value.has_default_value = false
field_descriptors.AttributeModifiedEventNO_value.default_value = 0
field_descriptors.AttributeModifiedEventNO_value.type = 5
field_descriptors.AttributeModifiedEventNO_value.cpp_type = 1
field_descriptors.AttributeModifiedEventNO_initial.name = "initial"
field_descriptors.AttributeModifiedEventNO_initial.full_name = ".AttributeModifiedEventNO.initial"
field_descriptors.AttributeModifiedEventNO_initial.number = 4
field_descriptors.AttributeModifiedEventNO_initial.index = 3
field_descriptors.AttributeModifiedEventNO_initial.label = 1
field_descriptors.AttributeModifiedEventNO_initial.has_default_value = false
field_descriptors.AttributeModifiedEventNO_initial.default_value = 0
field_descriptors.AttributeModifiedEventNO_initial.type = 5
field_descriptors.AttributeModifiedEventNO_initial.cpp_type = 1
type_descriptors.AttributeModifiedEventNO.name = "AttributeModifiedEventNO"
type_descriptors.AttributeModifiedEventNO.full_name = ".AttributeModifiedEventNO"
type_descriptors.AttributeModifiedEventNO.nested_types = {}
type_descriptors.AttributeModifiedEventNO.enum_types = {}
type_descriptors.AttributeModifiedEventNO.fields = {
	field_descriptors.AttributeModifiedEventNO_entity,
	field_descriptors.AttributeModifiedEventNO_attr,
	field_descriptors.AttributeModifiedEventNO_value,
	field_descriptors.AttributeModifiedEventNO_initial
}
type_descriptors.AttributeModifiedEventNO.is_extendable = false
type_descriptors.AttributeModifiedEventNO.extensions = {}
type_descriptors.ForecastAiRequest.name = "ForecastAiRequest"
type_descriptors.ForecastAiRequest.full_name = ".ForecastAiRequest"
type_descriptors.ForecastAiRequest.nested_types = {}
type_descriptors.ForecastAiRequest.enum_types = {}
type_descriptors.ForecastAiRequest.fields = {}
type_descriptors.ForecastAiRequest.is_extendable = false
type_descriptors.ForecastAiRequest.extensions = {}
field_descriptors.CellsBlockedEventNO_cells.name = "cells"
field_descriptors.CellsBlockedEventNO_cells.full_name = ".CellsBlockedEventNO.cells"
field_descriptors.CellsBlockedEventNO_cells.number = 1
field_descriptors.CellsBlockedEventNO_cells.index = 0
field_descriptors.CellsBlockedEventNO_cells.label = 3
field_descriptors.CellsBlockedEventNO_cells.has_default_value = false
field_descriptors.CellsBlockedEventNO_cells.default_value = {}
field_descriptors.CellsBlockedEventNO_cells.message_type = type_descriptors.CellNO
field_descriptors.CellsBlockedEventNO_cells.type = 11
field_descriptors.CellsBlockedEventNO_cells.cpp_type = 10
field_descriptors.CellsBlockedEventNO_entity.name = "entity"
field_descriptors.CellsBlockedEventNO_entity.full_name = ".CellsBlockedEventNO.entity"
field_descriptors.CellsBlockedEventNO_entity.number = 2
field_descriptors.CellsBlockedEventNO_entity.index = 1
field_descriptors.CellsBlockedEventNO_entity.label = 1
field_descriptors.CellsBlockedEventNO_entity.has_default_value = false
field_descriptors.CellsBlockedEventNO_entity.default_value = 0
field_descriptors.CellsBlockedEventNO_entity.type = 5
field_descriptors.CellsBlockedEventNO_entity.cpp_type = 1
field_descriptors.CellsBlockedEventNO_skill.name = "skill"
field_descriptors.CellsBlockedEventNO_skill.full_name = ".CellsBlockedEventNO.skill"
field_descriptors.CellsBlockedEventNO_skill.number = 3
field_descriptors.CellsBlockedEventNO_skill.index = 2
field_descriptors.CellsBlockedEventNO_skill.label = 1
field_descriptors.CellsBlockedEventNO_skill.has_default_value = false
field_descriptors.CellsBlockedEventNO_skill.default_value = 0
field_descriptors.CellsBlockedEventNO_skill.type = 5
field_descriptors.CellsBlockedEventNO_skill.cpp_type = 1
type_descriptors.CellsBlockedEventNO.name = "CellsBlockedEventNO"
type_descriptors.CellsBlockedEventNO.full_name = ".CellsBlockedEventNO"
type_descriptors.CellsBlockedEventNO.nested_types = {}
type_descriptors.CellsBlockedEventNO.enum_types = {}
type_descriptors.CellsBlockedEventNO.fields = {
	field_descriptors.CellsBlockedEventNO_cells,
	field_descriptors.CellsBlockedEventNO_entity,
	field_descriptors.CellsBlockedEventNO_skill
}
type_descriptors.CellsBlockedEventNO.is_extendable = false
type_descriptors.CellsBlockedEventNO.extensions = {}
type_descriptors.SetAiControlledReply.name = "SetAiControlledReply"
type_descriptors.SetAiControlledReply.full_name = ".SetAiControlledReply"
type_descriptors.SetAiControlledReply.nested_types = {}
type_descriptors.SetAiControlledReply.enum_types = {}
type_descriptors.SetAiControlledReply.fields = {}
type_descriptors.SetAiControlledReply.is_extendable = false
type_descriptors.SetAiControlledReply.extensions = {}
field_descriptors.PlotTriggered_type.name = "type"
field_descriptors.PlotTriggered_type.full_name = ".PlotTriggered.type"
field_descriptors.PlotTriggered_type.number = 1
field_descriptors.PlotTriggered_type.index = 0
field_descriptors.PlotTriggered_type.label = 1
field_descriptors.PlotTriggered_type.has_default_value = false
field_descriptors.PlotTriggered_type.default_value = 0
field_descriptors.PlotTriggered_type.type = 5
field_descriptors.PlotTriggered_type.cpp_type = 1
field_descriptors.PlotTriggered_id.name = "id"
field_descriptors.PlotTriggered_id.full_name = ".PlotTriggered.id"
field_descriptors.PlotTriggered_id.number = 2
field_descriptors.PlotTriggered_id.index = 1
field_descriptors.PlotTriggered_id.label = 1
field_descriptors.PlotTriggered_id.has_default_value = false
field_descriptors.PlotTriggered_id.default_value = 0
field_descriptors.PlotTriggered_id.type = 5
field_descriptors.PlotTriggered_id.cpp_type = 1
type_descriptors.PlotTriggered.name = "PlotTriggered"
type_descriptors.PlotTriggered.full_name = ".PlotTriggered"
type_descriptors.PlotTriggered.nested_types = {}
type_descriptors.PlotTriggered.enum_types = {}
type_descriptors.PlotTriggered.fields = {
	field_descriptors.PlotTriggered_type,
	field_descriptors.PlotTriggered_id
}
type_descriptors.PlotTriggered.is_extendable = false
type_descriptors.PlotTriggered.extensions = {}
type_descriptors.DeleteUnfinishedBattleRequest.name = "DeleteUnfinishedBattleRequest"
type_descriptors.DeleteUnfinishedBattleRequest.full_name = ".DeleteUnfinishedBattleRequest"
type_descriptors.DeleteUnfinishedBattleRequest.nested_types = {}
type_descriptors.DeleteUnfinishedBattleRequest.enum_types = {}
type_descriptors.DeleteUnfinishedBattleRequest.fields = {}
type_descriptors.DeleteUnfinishedBattleRequest.is_extendable = false
type_descriptors.DeleteUnfinishedBattleRequest.extensions = {}
field_descriptors.WeakPointRemovedEventNO_entity.name = "entity"
field_descriptors.WeakPointRemovedEventNO_entity.full_name = ".WeakPointRemovedEventNO.entity"
field_descriptors.WeakPointRemovedEventNO_entity.number = 1
field_descriptors.WeakPointRemovedEventNO_entity.index = 0
field_descriptors.WeakPointRemovedEventNO_entity.label = 1
field_descriptors.WeakPointRemovedEventNO_entity.has_default_value = false
field_descriptors.WeakPointRemovedEventNO_entity.default_value = 0
field_descriptors.WeakPointRemovedEventNO_entity.type = 5
field_descriptors.WeakPointRemovedEventNO_entity.cpp_type = 1
type_descriptors.WeakPointRemovedEventNO.name = "WeakPointRemovedEventNO"
type_descriptors.WeakPointRemovedEventNO.full_name = ".WeakPointRemovedEventNO"
type_descriptors.WeakPointRemovedEventNO.nested_types = {}
type_descriptors.WeakPointRemovedEventNO.enum_types = {}
type_descriptors.WeakPointRemovedEventNO.fields = {
	field_descriptors.WeakPointRemovedEventNO_entity
}
type_descriptors.WeakPointRemovedEventNO.is_extendable = false
type_descriptors.WeakPointRemovedEventNO.extensions = {}
field_descriptors.AdditionalTerrainNO_code.name = "code"
field_descriptors.AdditionalTerrainNO_code.full_name = ".AdditionalTerrainNO.code"
field_descriptors.AdditionalTerrainNO_code.number = 1
field_descriptors.AdditionalTerrainNO_code.index = 0
field_descriptors.AdditionalTerrainNO_code.label = 1
field_descriptors.AdditionalTerrainNO_code.has_default_value = false
field_descriptors.AdditionalTerrainNO_code.default_value = 0
field_descriptors.AdditionalTerrainNO_code.type = 5
field_descriptors.AdditionalTerrainNO_code.cpp_type = 1
field_descriptors.AdditionalTerrainNO_round.name = "round"
field_descriptors.AdditionalTerrainNO_round.full_name = ".AdditionalTerrainNO.round"
field_descriptors.AdditionalTerrainNO_round.number = 2
field_descriptors.AdditionalTerrainNO_round.index = 1
field_descriptors.AdditionalTerrainNO_round.label = 1
field_descriptors.AdditionalTerrainNO_round.has_default_value = false
field_descriptors.AdditionalTerrainNO_round.default_value = 0
field_descriptors.AdditionalTerrainNO_round.type = 5
field_descriptors.AdditionalTerrainNO_round.cpp_type = 1
field_descriptors.AdditionalTerrainNO_triggered.name = "triggered"
field_descriptors.AdditionalTerrainNO_triggered.full_name = ".AdditionalTerrainNO.triggered"
field_descriptors.AdditionalTerrainNO_triggered.number = 3
field_descriptors.AdditionalTerrainNO_triggered.index = 2
field_descriptors.AdditionalTerrainNO_triggered.label = 1
field_descriptors.AdditionalTerrainNO_triggered.has_default_value = false
field_descriptors.AdditionalTerrainNO_triggered.default_value = 0
field_descriptors.AdditionalTerrainNO_triggered.type = 5
field_descriptors.AdditionalTerrainNO_triggered.cpp_type = 1
type_descriptors.AdditionalTerrainNO.name = "AdditionalTerrainNO"
type_descriptors.AdditionalTerrainNO.full_name = ".AdditionalTerrainNO"
type_descriptors.AdditionalTerrainNO.nested_types = {}
type_descriptors.AdditionalTerrainNO.enum_types = {}
type_descriptors.AdditionalTerrainNO.fields = {
	field_descriptors.AdditionalTerrainNO_code,
	field_descriptors.AdditionalTerrainNO_round,
	field_descriptors.AdditionalTerrainNO_triggered
}
type_descriptors.AdditionalTerrainNO.is_extendable = false
type_descriptors.AdditionalTerrainNO.extensions = {}
field_descriptors.NoteCellNO_scale.name = "scale"
field_descriptors.NoteCellNO_scale.full_name = ".NoteCellNO.scale"
field_descriptors.NoteCellNO_scale.number = 1
field_descriptors.NoteCellNO_scale.index = 0
field_descriptors.NoteCellNO_scale.label = 2
field_descriptors.NoteCellNO_scale.has_default_value = false
field_descriptors.NoteCellNO_scale.default_value = 0
field_descriptors.NoteCellNO_scale.type = 5
field_descriptors.NoteCellNO_scale.cpp_type = 1
field_descriptors.NoteCellNO_specialEffectPath.name = "specialEffectPath"
field_descriptors.NoteCellNO_specialEffectPath.full_name = ".NoteCellNO.specialEffectPath"
field_descriptors.NoteCellNO_specialEffectPath.number = 2
field_descriptors.NoteCellNO_specialEffectPath.index = 1
field_descriptors.NoteCellNO_specialEffectPath.label = 2
field_descriptors.NoteCellNO_specialEffectPath.has_default_value = false
field_descriptors.NoteCellNO_specialEffectPath.default_value = ""
field_descriptors.NoteCellNO_specialEffectPath.type = 9
field_descriptors.NoteCellNO_specialEffectPath.cpp_type = 9
field_descriptors.NoteCellNO_cells.name = "cells"
field_descriptors.NoteCellNO_cells.full_name = ".NoteCellNO.cells"
field_descriptors.NoteCellNO_cells.number = 3
field_descriptors.NoteCellNO_cells.index = 2
field_descriptors.NoteCellNO_cells.label = 3
field_descriptors.NoteCellNO_cells.has_default_value = false
field_descriptors.NoteCellNO_cells.default_value = {}
field_descriptors.NoteCellNO_cells.message_type = type_descriptors.CellNO
field_descriptors.NoteCellNO_cells.type = 11
field_descriptors.NoteCellNO_cells.cpp_type = 10
type_descriptors.NoteCellNO.name = "NoteCellNO"
type_descriptors.NoteCellNO.full_name = ".NoteCellNO"
type_descriptors.NoteCellNO.nested_types = {}
type_descriptors.NoteCellNO.enum_types = {}
type_descriptors.NoteCellNO.fields = {
	field_descriptors.NoteCellNO_scale,
	field_descriptors.NoteCellNO_specialEffectPath,
	field_descriptors.NoteCellNO_cells
}
type_descriptors.NoteCellNO.is_extendable = false
type_descriptors.NoteCellNO.extensions = {}
field_descriptors.PlayerStatisticNO_totalDamageToEnemy.name = "totalDamageToEnemy"
field_descriptors.PlayerStatisticNO_totalDamageToEnemy.full_name = ".PlayerStatisticNO.totalDamageToEnemy"
field_descriptors.PlayerStatisticNO_totalDamageToEnemy.number = 1
field_descriptors.PlayerStatisticNO_totalDamageToEnemy.index = 0
field_descriptors.PlayerStatisticNO_totalDamageToEnemy.label = 1
field_descriptors.PlayerStatisticNO_totalDamageToEnemy.has_default_value = false
field_descriptors.PlayerStatisticNO_totalDamageToEnemy.default_value = 0
field_descriptors.PlayerStatisticNO_totalDamageToEnemy.type = 5
field_descriptors.PlayerStatisticNO_totalDamageToEnemy.cpp_type = 1
field_descriptors.PlayerStatisticNO_totalEnemyKilled.name = "totalEnemyKilled"
field_descriptors.PlayerStatisticNO_totalEnemyKilled.full_name = ".PlayerStatisticNO.totalEnemyKilled"
field_descriptors.PlayerStatisticNO_totalEnemyKilled.number = 2
field_descriptors.PlayerStatisticNO_totalEnemyKilled.index = 1
field_descriptors.PlayerStatisticNO_totalEnemyKilled.label = 1
field_descriptors.PlayerStatisticNO_totalEnemyKilled.has_default_value = false
field_descriptors.PlayerStatisticNO_totalEnemyKilled.default_value = 0
field_descriptors.PlayerStatisticNO_totalEnemyKilled.type = 5
field_descriptors.PlayerStatisticNO_totalEnemyKilled.cpp_type = 1
field_descriptors.PlayerStatisticNO_deadHeroes.name = "deadHeroes"
field_descriptors.PlayerStatisticNO_deadHeroes.full_name = ".PlayerStatisticNO.deadHeroes"
field_descriptors.PlayerStatisticNO_deadHeroes.number = 3
field_descriptors.PlayerStatisticNO_deadHeroes.index = 2
field_descriptors.PlayerStatisticNO_deadHeroes.label = 3
field_descriptors.PlayerStatisticNO_deadHeroes.has_default_value = false
field_descriptors.PlayerStatisticNO_deadHeroes.default_value = {}
field_descriptors.PlayerStatisticNO_deadHeroes.type = 5
field_descriptors.PlayerStatisticNO_deadHeroes.cpp_type = 1
field_descriptors.PlayerStatisticNO_deadEnemies.name = "deadEnemies"
field_descriptors.PlayerStatisticNO_deadEnemies.full_name = ".PlayerStatisticNO.deadEnemies"
field_descriptors.PlayerStatisticNO_deadEnemies.number = 4
field_descriptors.PlayerStatisticNO_deadEnemies.index = 3
field_descriptors.PlayerStatisticNO_deadEnemies.label = 3
field_descriptors.PlayerStatisticNO_deadEnemies.has_default_value = false
field_descriptors.PlayerStatisticNO_deadEnemies.default_value = {}
field_descriptors.PlayerStatisticNO_deadEnemies.type = 5
field_descriptors.PlayerStatisticNO_deadEnemies.cpp_type = 1
field_descriptors.PlayerStatisticNO_weakBroken.name = "weakBroken"
field_descriptors.PlayerStatisticNO_weakBroken.full_name = ".PlayerStatisticNO.weakBroken"
field_descriptors.PlayerStatisticNO_weakBroken.number = 5
field_descriptors.PlayerStatisticNO_weakBroken.index = 4
field_descriptors.PlayerStatisticNO_weakBroken.label = 3
field_descriptors.PlayerStatisticNO_weakBroken.has_default_value = false
field_descriptors.PlayerStatisticNO_weakBroken.default_value = {}
field_descriptors.PlayerStatisticNO_weakBroken.type = 5
field_descriptors.PlayerStatisticNO_weakBroken.cpp_type = 1
field_descriptors.PlayerStatisticNO_exitHeroes.name = "exitHeroes"
field_descriptors.PlayerStatisticNO_exitHeroes.full_name = ".PlayerStatisticNO.exitHeroes"
field_descriptors.PlayerStatisticNO_exitHeroes.number = 6
field_descriptors.PlayerStatisticNO_exitHeroes.index = 5
field_descriptors.PlayerStatisticNO_exitHeroes.label = 3
field_descriptors.PlayerStatisticNO_exitHeroes.has_default_value = false
field_descriptors.PlayerStatisticNO_exitHeroes.default_value = {}
field_descriptors.PlayerStatisticNO_exitHeroes.type = 5
field_descriptors.PlayerStatisticNO_exitHeroes.cpp_type = 1
field_descriptors.PlayerStatisticNO_exitEnemies.name = "exitEnemies"
field_descriptors.PlayerStatisticNO_exitEnemies.full_name = ".PlayerStatisticNO.exitEnemies"
field_descriptors.PlayerStatisticNO_exitEnemies.number = 7
field_descriptors.PlayerStatisticNO_exitEnemies.index = 6
field_descriptors.PlayerStatisticNO_exitEnemies.label = 3
field_descriptors.PlayerStatisticNO_exitEnemies.has_default_value = false
field_descriptors.PlayerStatisticNO_exitEnemies.default_value = {}
field_descriptors.PlayerStatisticNO_exitEnemies.type = 5
field_descriptors.PlayerStatisticNO_exitEnemies.cpp_type = 1
type_descriptors.PlayerStatisticNO.name = "PlayerStatisticNO"
type_descriptors.PlayerStatisticNO.full_name = ".PlayerStatisticNO"
type_descriptors.PlayerStatisticNO.nested_types = {}
type_descriptors.PlayerStatisticNO.enum_types = {}
type_descriptors.PlayerStatisticNO.fields = {
	field_descriptors.PlayerStatisticNO_totalDamageToEnemy,
	field_descriptors.PlayerStatisticNO_totalEnemyKilled,
	field_descriptors.PlayerStatisticNO_deadHeroes,
	field_descriptors.PlayerStatisticNO_deadEnemies,
	field_descriptors.PlayerStatisticNO_weakBroken,
	field_descriptors.PlayerStatisticNO_exitHeroes,
	field_descriptors.PlayerStatisticNO_exitEnemies
}
type_descriptors.PlayerStatisticNO.is_extendable = false
type_descriptors.PlayerStatisticNO.extensions = {}
field_descriptors.MovedEventNO_entity.name = "entity"
field_descriptors.MovedEventNO_entity.full_name = ".MovedEventNO.entity"
field_descriptors.MovedEventNO_entity.number = 1
field_descriptors.MovedEventNO_entity.index = 0
field_descriptors.MovedEventNO_entity.label = 1
field_descriptors.MovedEventNO_entity.has_default_value = false
field_descriptors.MovedEventNO_entity.default_value = 0
field_descriptors.MovedEventNO_entity.type = 5
field_descriptors.MovedEventNO_entity.cpp_type = 1
field_descriptors.MovedEventNO_before.name = "before"
field_descriptors.MovedEventNO_before.full_name = ".MovedEventNO.before"
field_descriptors.MovedEventNO_before.number = 2
field_descriptors.MovedEventNO_before.index = 1
field_descriptors.MovedEventNO_before.label = 3
field_descriptors.MovedEventNO_before.has_default_value = false
field_descriptors.MovedEventNO_before.default_value = {}
field_descriptors.MovedEventNO_before.message_type = type_descriptors.EventNO
field_descriptors.MovedEventNO_before.type = 11
field_descriptors.MovedEventNO_before.cpp_type = 10
field_descriptors.MovedEventNO_movement.name = "movement"
field_descriptors.MovedEventNO_movement.full_name = ".MovedEventNO.movement"
field_descriptors.MovedEventNO_movement.number = 3
field_descriptors.MovedEventNO_movement.index = 2
field_descriptors.MovedEventNO_movement.label = 3
field_descriptors.MovedEventNO_movement.has_default_value = false
field_descriptors.MovedEventNO_movement.default_value = {}
field_descriptors.MovedEventNO_movement.message_type = type_descriptors.CellNO
field_descriptors.MovedEventNO_movement.type = 11
field_descriptors.MovedEventNO_movement.cpp_type = 10
field_descriptors.MovedEventNO_after.name = "after"
field_descriptors.MovedEventNO_after.full_name = ".MovedEventNO.after"
field_descriptors.MovedEventNO_after.number = 4
field_descriptors.MovedEventNO_after.index = 3
field_descriptors.MovedEventNO_after.label = 3
field_descriptors.MovedEventNO_after.has_default_value = false
field_descriptors.MovedEventNO_after.default_value = {}
field_descriptors.MovedEventNO_after.message_type = type_descriptors.EventNO
field_descriptors.MovedEventNO_after.type = 11
field_descriptors.MovedEventNO_after.cpp_type = 10
type_descriptors.MovedEventNO.name = "MovedEventNO"
type_descriptors.MovedEventNO.full_name = ".MovedEventNO"
type_descriptors.MovedEventNO.nested_types = {}
type_descriptors.MovedEventNO.enum_types = {}
type_descriptors.MovedEventNO.fields = {
	field_descriptors.MovedEventNO_entity,
	field_descriptors.MovedEventNO_before,
	field_descriptors.MovedEventNO_movement,
	field_descriptors.MovedEventNO_after
}
type_descriptors.MovedEventNO.is_extendable = false
type_descriptors.MovedEventNO.extensions = {}
field_descriptors.RemoveEntityRequest_entity.name = "entity"
field_descriptors.RemoveEntityRequest_entity.full_name = ".RemoveEntityRequest.entity"
field_descriptors.RemoveEntityRequest_entity.number = 1
field_descriptors.RemoveEntityRequest_entity.index = 0
field_descriptors.RemoveEntityRequest_entity.label = 1
field_descriptors.RemoveEntityRequest_entity.has_default_value = false
field_descriptors.RemoveEntityRequest_entity.default_value = 0
field_descriptors.RemoveEntityRequest_entity.type = 5
field_descriptors.RemoveEntityRequest_entity.cpp_type = 1
type_descriptors.RemoveEntityRequest.name = "RemoveEntityRequest"
type_descriptors.RemoveEntityRequest.full_name = ".RemoveEntityRequest"
type_descriptors.RemoveEntityRequest.nested_types = {}
type_descriptors.RemoveEntityRequest.enum_types = {}
type_descriptors.RemoveEntityRequest.fields = {
	field_descriptors.RemoveEntityRequest_entity
}
type_descriptors.RemoveEntityRequest.is_extendable = false
type_descriptors.RemoveEntityRequest.extensions = {}
field_descriptors.PlayerNO_id.name = "id"
field_descriptors.PlayerNO_id.full_name = ".PlayerNO.id"
field_descriptors.PlayerNO_id.number = 1
field_descriptors.PlayerNO_id.index = 0
field_descriptors.PlayerNO_id.label = 1
field_descriptors.PlayerNO_id.has_default_value = false
field_descriptors.PlayerNO_id.default_value = 0
field_descriptors.PlayerNO_id.type = 5
field_descriptors.PlayerNO_id.cpp_type = 1
field_descriptors.PlayerNO_playerStatistic.name = "playerStatistic"
field_descriptors.PlayerNO_playerStatistic.full_name = ".PlayerNO.playerStatistic"
field_descriptors.PlayerNO_playerStatistic.number = 2
field_descriptors.PlayerNO_playerStatistic.index = 1
field_descriptors.PlayerNO_playerStatistic.label = 1
field_descriptors.PlayerNO_playerStatistic.has_default_value = false
field_descriptors.PlayerNO_playerStatistic.default_value = nil
field_descriptors.PlayerNO_playerStatistic.message_type = type_descriptors.PlayerStatisticNO
field_descriptors.PlayerNO_playerStatistic.type = 11
field_descriptors.PlayerNO_playerStatistic.cpp_type = 10
type_descriptors.PlayerNO.name = "PlayerNO"
type_descriptors.PlayerNO.full_name = ".PlayerNO"
type_descriptors.PlayerNO.nested_types = {}
type_descriptors.PlayerNO.enum_types = {}
type_descriptors.PlayerNO.fields = {
	field_descriptors.PlayerNO_id,
	field_descriptors.PlayerNO_playerStatistic
}
type_descriptors.PlayerNO.is_extendable = false
type_descriptors.PlayerNO.extensions = {}
field_descriptors.AttributePartNO_attr.name = "attr"
field_descriptors.AttributePartNO_attr.full_name = ".AttributePartNO.attr"
field_descriptors.AttributePartNO_attr.number = 1
field_descriptors.AttributePartNO_attr.index = 0
field_descriptors.AttributePartNO_attr.label = 1
field_descriptors.AttributePartNO_attr.has_default_value = false
field_descriptors.AttributePartNO_attr.default_value = nil
field_descriptors.AttributePartNO_attr.enum_type = type_descriptors.AttributePart
field_descriptors.AttributePartNO_attr.type = 14
field_descriptors.AttributePartNO_attr.cpp_type = 8
field_descriptors.AttributePartNO_value.name = "value"
field_descriptors.AttributePartNO_value.full_name = ".AttributePartNO.value"
field_descriptors.AttributePartNO_value.number = 2
field_descriptors.AttributePartNO_value.index = 1
field_descriptors.AttributePartNO_value.label = 1
field_descriptors.AttributePartNO_value.has_default_value = false
field_descriptors.AttributePartNO_value.default_value = 0
field_descriptors.AttributePartNO_value.type = 1
field_descriptors.AttributePartNO_value.cpp_type = 5
type_descriptors.AttributePartNO.name = "AttributePartNO"
type_descriptors.AttributePartNO.full_name = ".AttributePartNO"
type_descriptors.AttributePartNO.nested_types = {}
type_descriptors.AttributePartNO.enum_types = {}
type_descriptors.AttributePartNO.fields = {
	field_descriptors.AttributePartNO_attr,
	field_descriptors.AttributePartNO_value
}
type_descriptors.AttributePartNO.is_extendable = false
type_descriptors.AttributePartNO.extensions = {}
field_descriptors.BackEventNO_info.name = "info"
field_descriptors.BackEventNO_info.full_name = ".BackEventNO.info"
field_descriptors.BackEventNO_info.number = 1
field_descriptors.BackEventNO_info.index = 0
field_descriptors.BackEventNO_info.label = 1
field_descriptors.BackEventNO_info.has_default_value = false
field_descriptors.BackEventNO_info.default_value = nil
field_descriptors.BackEventNO_info.message_type = type_descriptors.BattleInfoNO
field_descriptors.BackEventNO_info.type = 11
field_descriptors.BackEventNO_info.cpp_type = 10
type_descriptors.BackEventNO.name = "BackEventNO"
type_descriptors.BackEventNO.full_name = ".BackEventNO"
type_descriptors.BackEventNO.nested_types = {}
type_descriptors.BackEventNO.enum_types = {}
type_descriptors.BackEventNO.fields = {
	field_descriptors.BackEventNO_info
}
type_descriptors.BackEventNO.is_extendable = false
type_descriptors.BackEventNO.extensions = {}
type_descriptors.PlaceEntityReply.name = "PlaceEntityReply"
type_descriptors.PlaceEntityReply.full_name = ".PlaceEntityReply"
type_descriptors.PlaceEntityReply.nested_types = {}
type_descriptors.PlaceEntityReply.enum_types = {}
type_descriptors.PlaceEntityReply.fields = {}
type_descriptors.PlaceEntityReply.is_extendable = false
type_descriptors.PlaceEntityReply.extensions = {}
field_descriptors.EntitySteppedEventNO_entity.name = "entity"
field_descriptors.EntitySteppedEventNO_entity.full_name = ".EntitySteppedEventNO.entity"
field_descriptors.EntitySteppedEventNO_entity.number = 1
field_descriptors.EntitySteppedEventNO_entity.index = 0
field_descriptors.EntitySteppedEventNO_entity.label = 1
field_descriptors.EntitySteppedEventNO_entity.has_default_value = false
field_descriptors.EntitySteppedEventNO_entity.default_value = 0
field_descriptors.EntitySteppedEventNO_entity.type = 5
field_descriptors.EntitySteppedEventNO_entity.cpp_type = 1
field_descriptors.EntitySteppedEventNO_moved.name = "moved"
field_descriptors.EntitySteppedEventNO_moved.full_name = ".EntitySteppedEventNO.moved"
field_descriptors.EntitySteppedEventNO_moved.number = 2
field_descriptors.EntitySteppedEventNO_moved.index = 1
field_descriptors.EntitySteppedEventNO_moved.label = 1
field_descriptors.EntitySteppedEventNO_moved.has_default_value = false
field_descriptors.EntitySteppedEventNO_moved.default_value = nil
field_descriptors.EntitySteppedEventNO_moved.message_type = type_descriptors.MovedEventNO
field_descriptors.EntitySteppedEventNO_moved.type = 11
field_descriptors.EntitySteppedEventNO_moved.cpp_type = 10
field_descriptors.EntitySteppedEventNO_releasingSkill.name = "releasingSkill"
field_descriptors.EntitySteppedEventNO_releasingSkill.full_name = ".EntitySteppedEventNO.releasingSkill"
field_descriptors.EntitySteppedEventNO_releasingSkill.number = 3
field_descriptors.EntitySteppedEventNO_releasingSkill.index = 2
field_descriptors.EntitySteppedEventNO_releasingSkill.label = 1
field_descriptors.EntitySteppedEventNO_releasingSkill.has_default_value = false
field_descriptors.EntitySteppedEventNO_releasingSkill.default_value = 0
field_descriptors.EntitySteppedEventNO_releasingSkill.type = 5
field_descriptors.EntitySteppedEventNO_releasingSkill.cpp_type = 1
field_descriptors.EntitySteppedEventNO_target.name = "target"
field_descriptors.EntitySteppedEventNO_target.full_name = ".EntitySteppedEventNO.target"
field_descriptors.EntitySteppedEventNO_target.number = 4
field_descriptors.EntitySteppedEventNO_target.index = 3
field_descriptors.EntitySteppedEventNO_target.label = 1
field_descriptors.EntitySteppedEventNO_target.has_default_value = false
field_descriptors.EntitySteppedEventNO_target.default_value = nil
field_descriptors.EntitySteppedEventNO_target.message_type = type_descriptors.CellNO
field_descriptors.EntitySteppedEventNO_target.type = 11
field_descriptors.EntitySteppedEventNO_target.cpp_type = 10
field_descriptors.EntitySteppedEventNO_beforeMain.name = "beforeMain"
field_descriptors.EntitySteppedEventNO_beforeMain.full_name = ".EntitySteppedEventNO.beforeMain"
field_descriptors.EntitySteppedEventNO_beforeMain.number = 5
field_descriptors.EntitySteppedEventNO_beforeMain.index = 4
field_descriptors.EntitySteppedEventNO_beforeMain.label = 3
field_descriptors.EntitySteppedEventNO_beforeMain.has_default_value = false
field_descriptors.EntitySteppedEventNO_beforeMain.default_value = {}
field_descriptors.EntitySteppedEventNO_beforeMain.message_type = type_descriptors.EventNO
field_descriptors.EntitySteppedEventNO_beforeMain.type = 11
field_descriptors.EntitySteppedEventNO_beforeMain.cpp_type = 10
field_descriptors.EntitySteppedEventNO_main.name = "main"
field_descriptors.EntitySteppedEventNO_main.full_name = ".EntitySteppedEventNO.main"
field_descriptors.EntitySteppedEventNO_main.number = 6
field_descriptors.EntitySteppedEventNO_main.index = 5
field_descriptors.EntitySteppedEventNO_main.label = 3
field_descriptors.EntitySteppedEventNO_main.has_default_value = false
field_descriptors.EntitySteppedEventNO_main.default_value = {}
field_descriptors.EntitySteppedEventNO_main.message_type = type_descriptors.EventNO
field_descriptors.EntitySteppedEventNO_main.type = 11
field_descriptors.EntitySteppedEventNO_main.cpp_type = 10
field_descriptors.EntitySteppedEventNO_afterMain.name = "afterMain"
field_descriptors.EntitySteppedEventNO_afterMain.full_name = ".EntitySteppedEventNO.afterMain"
field_descriptors.EntitySteppedEventNO_afterMain.number = 7
field_descriptors.EntitySteppedEventNO_afterMain.index = 6
field_descriptors.EntitySteppedEventNO_afterMain.label = 3
field_descriptors.EntitySteppedEventNO_afterMain.has_default_value = false
field_descriptors.EntitySteppedEventNO_afterMain.default_value = {}
field_descriptors.EntitySteppedEventNO_afterMain.message_type = type_descriptors.EventNO
field_descriptors.EntitySteppedEventNO_afterMain.type = 11
field_descriptors.EntitySteppedEventNO_afterMain.cpp_type = 10
field_descriptors.EntitySteppedEventNO_round.name = "round"
field_descriptors.EntitySteppedEventNO_round.full_name = ".EntitySteppedEventNO.round"
field_descriptors.EntitySteppedEventNO_round.number = 8
field_descriptors.EntitySteppedEventNO_round.index = 7
field_descriptors.EntitySteppedEventNO_round.label = 1
field_descriptors.EntitySteppedEventNO_round.has_default_value = false
field_descriptors.EntitySteppedEventNO_round.default_value = 0
field_descriptors.EntitySteppedEventNO_round.type = 5
field_descriptors.EntitySteppedEventNO_round.cpp_type = 1
field_descriptors.EntitySteppedEventNO_skillCd.name = "skillCd"
field_descriptors.EntitySteppedEventNO_skillCd.full_name = ".EntitySteppedEventNO.skillCd"
field_descriptors.EntitySteppedEventNO_skillCd.number = 9
field_descriptors.EntitySteppedEventNO_skillCd.index = 8
field_descriptors.EntitySteppedEventNO_skillCd.label = 1
field_descriptors.EntitySteppedEventNO_skillCd.has_default_value = false
field_descriptors.EntitySteppedEventNO_skillCd.default_value = 0
field_descriptors.EntitySteppedEventNO_skillCd.type = 5
field_descriptors.EntitySteppedEventNO_skillCd.cpp_type = 1
field_descriptors.EntitySteppedEventNO_strengthening.name = "strengthening"
field_descriptors.EntitySteppedEventNO_strengthening.full_name = ".EntitySteppedEventNO.strengthening"
field_descriptors.EntitySteppedEventNO_strengthening.number = 10
field_descriptors.EntitySteppedEventNO_strengthening.index = 9
field_descriptors.EntitySteppedEventNO_strengthening.label = 1
field_descriptors.EntitySteppedEventNO_strengthening.has_default_value = false
field_descriptors.EntitySteppedEventNO_strengthening.default_value = false
field_descriptors.EntitySteppedEventNO_strengthening.type = 8
field_descriptors.EntitySteppedEventNO_strengthening.cpp_type = 7
field_descriptors.EntitySteppedEventNO_turn.name = "turn"
field_descriptors.EntitySteppedEventNO_turn.full_name = ".EntitySteppedEventNO.turn"
field_descriptors.EntitySteppedEventNO_turn.number = 11
field_descriptors.EntitySteppedEventNO_turn.index = 10
field_descriptors.EntitySteppedEventNO_turn.label = 3
field_descriptors.EntitySteppedEventNO_turn.has_default_value = false
field_descriptors.EntitySteppedEventNO_turn.default_value = {}
field_descriptors.EntitySteppedEventNO_turn.message_type = type_descriptors.TurnNO
field_descriptors.EntitySteppedEventNO_turn.type = 11
field_descriptors.EntitySteppedEventNO_turn.cpp_type = 10
type_descriptors.EntitySteppedEventNO.name = "EntitySteppedEventNO"
type_descriptors.EntitySteppedEventNO.full_name = ".EntitySteppedEventNO"
type_descriptors.EntitySteppedEventNO.nested_types = {}
type_descriptors.EntitySteppedEventNO.enum_types = {}
type_descriptors.EntitySteppedEventNO.fields = {
	field_descriptors.EntitySteppedEventNO_entity,
	field_descriptors.EntitySteppedEventNO_moved,
	field_descriptors.EntitySteppedEventNO_releasingSkill,
	field_descriptors.EntitySteppedEventNO_target,
	field_descriptors.EntitySteppedEventNO_beforeMain,
	field_descriptors.EntitySteppedEventNO_main,
	field_descriptors.EntitySteppedEventNO_afterMain,
	field_descriptors.EntitySteppedEventNO_round,
	field_descriptors.EntitySteppedEventNO_skillCd,
	field_descriptors.EntitySteppedEventNO_strengthening,
	field_descriptors.EntitySteppedEventNO_turn
}
type_descriptors.EntitySteppedEventNO.is_extendable = false
type_descriptors.EntitySteppedEventNO.extensions = {}
field_descriptors.ConnectReply_info.name = "info"
field_descriptors.ConnectReply_info.full_name = ".ConnectReply.info"
field_descriptors.ConnectReply_info.number = 1
field_descriptors.ConnectReply_info.index = 0
field_descriptors.ConnectReply_info.label = 2
field_descriptors.ConnectReply_info.has_default_value = false
field_descriptors.ConnectReply_info.default_value = nil
field_descriptors.ConnectReply_info.message_type = type_descriptors.BattleInfoNO
field_descriptors.ConnectReply_info.type = 11
field_descriptors.ConnectReply_info.cpp_type = 10
type_descriptors.ConnectReply.name = "ConnectReply"
type_descriptors.ConnectReply.full_name = ".ConnectReply"
type_descriptors.ConnectReply.nested_types = {}
type_descriptors.ConnectReply.enum_types = {}
type_descriptors.ConnectReply.fields = {
	field_descriptors.ConnectReply_info
}
type_descriptors.ConnectReply.is_extendable = false
type_descriptors.ConnectReply.extensions = {}
type_descriptors.PointNO.name = "PointNO"
type_descriptors.PointNO.full_name = ".PointNO"
type_descriptors.PointNO.nested_types = {}
type_descriptors.PointNO.enum_types = {}
type_descriptors.PointNO.fields = {}
type_descriptors.PointNO.is_extendable = false
type_descriptors.PointNO.extensions = {}
field_descriptors.MultiRoundAoeNO_shape.name = "shape"
field_descriptors.MultiRoundAoeNO_shape.full_name = ".MultiRoundAoeNO.shape"
field_descriptors.MultiRoundAoeNO_shape.number = 1
field_descriptors.MultiRoundAoeNO_shape.index = 0
field_descriptors.MultiRoundAoeNO_shape.label = 3
field_descriptors.MultiRoundAoeNO_shape.has_default_value = false
field_descriptors.MultiRoundAoeNO_shape.default_value = {}
field_descriptors.MultiRoundAoeNO_shape.message_type = type_descriptors.ShapeWithRootNO
field_descriptors.MultiRoundAoeNO_shape.type = 11
field_descriptors.MultiRoundAoeNO_shape.cpp_type = 10
field_descriptors.MultiRoundAoeNO_entity.name = "entity"
field_descriptors.MultiRoundAoeNO_entity.full_name = ".MultiRoundAoeNO.entity"
field_descriptors.MultiRoundAoeNO_entity.number = 2
field_descriptors.MultiRoundAoeNO_entity.index = 1
field_descriptors.MultiRoundAoeNO_entity.label = 1
field_descriptors.MultiRoundAoeNO_entity.has_default_value = false
field_descriptors.MultiRoundAoeNO_entity.default_value = 0
field_descriptors.MultiRoundAoeNO_entity.type = 5
field_descriptors.MultiRoundAoeNO_entity.cpp_type = 1
field_descriptors.MultiRoundAoeNO_skill.name = "skill"
field_descriptors.MultiRoundAoeNO_skill.full_name = ".MultiRoundAoeNO.skill"
field_descriptors.MultiRoundAoeNO_skill.number = 3
field_descriptors.MultiRoundAoeNO_skill.index = 2
field_descriptors.MultiRoundAoeNO_skill.label = 1
field_descriptors.MultiRoundAoeNO_skill.has_default_value = false
field_descriptors.MultiRoundAoeNO_skill.default_value = 0
field_descriptors.MultiRoundAoeNO_skill.type = 5
field_descriptors.MultiRoundAoeNO_skill.cpp_type = 1
field_descriptors.MultiRoundAoeNO_id.name = "id"
field_descriptors.MultiRoundAoeNO_id.full_name = ".MultiRoundAoeNO.id"
field_descriptors.MultiRoundAoeNO_id.number = 4
field_descriptors.MultiRoundAoeNO_id.index = 3
field_descriptors.MultiRoundAoeNO_id.label = 1
field_descriptors.MultiRoundAoeNO_id.has_default_value = false
field_descriptors.MultiRoundAoeNO_id.default_value = 0
field_descriptors.MultiRoundAoeNO_id.type = 5
field_descriptors.MultiRoundAoeNO_id.cpp_type = 1
field_descriptors.MultiRoundAoeNO_targetEntity.name = "targetEntity"
field_descriptors.MultiRoundAoeNO_targetEntity.full_name = ".MultiRoundAoeNO.targetEntity"
field_descriptors.MultiRoundAoeNO_targetEntity.number = 5
field_descriptors.MultiRoundAoeNO_targetEntity.index = 4
field_descriptors.MultiRoundAoeNO_targetEntity.label = 1
field_descriptors.MultiRoundAoeNO_targetEntity.has_default_value = false
field_descriptors.MultiRoundAoeNO_targetEntity.default_value = 0
field_descriptors.MultiRoundAoeNO_targetEntity.type = 5
field_descriptors.MultiRoundAoeNO_targetEntity.cpp_type = 1
field_descriptors.MultiRoundAoeNO_targetCell.name = "targetCell"
field_descriptors.MultiRoundAoeNO_targetCell.full_name = ".MultiRoundAoeNO.targetCell"
field_descriptors.MultiRoundAoeNO_targetCell.number = 6
field_descriptors.MultiRoundAoeNO_targetCell.index = 5
field_descriptors.MultiRoundAoeNO_targetCell.label = 1
field_descriptors.MultiRoundAoeNO_targetCell.has_default_value = false
field_descriptors.MultiRoundAoeNO_targetCell.default_value = nil
field_descriptors.MultiRoundAoeNO_targetCell.message_type = type_descriptors.CellNO
field_descriptors.MultiRoundAoeNO_targetCell.type = 11
field_descriptors.MultiRoundAoeNO_targetCell.cpp_type = 10
field_descriptors.MultiRoundAoeNO_strengthening.name = "strengthening"
field_descriptors.MultiRoundAoeNO_strengthening.full_name = ".MultiRoundAoeNO.strengthening"
field_descriptors.MultiRoundAoeNO_strengthening.number = 7
field_descriptors.MultiRoundAoeNO_strengthening.index = 6
field_descriptors.MultiRoundAoeNO_strengthening.label = 1
field_descriptors.MultiRoundAoeNO_strengthening.has_default_value = false
field_descriptors.MultiRoundAoeNO_strengthening.default_value = false
field_descriptors.MultiRoundAoeNO_strengthening.type = 8
field_descriptors.MultiRoundAoeNO_strengthening.cpp_type = 7
field_descriptors.MultiRoundAoeNO_MultiEntityHold.name = "MultiEntityHold"
field_descriptors.MultiRoundAoeNO_MultiEntityHold.full_name = ".MultiRoundAoeNO.MultiEntityHold"
field_descriptors.MultiRoundAoeNO_MultiEntityHold.number = 8
field_descriptors.MultiRoundAoeNO_MultiEntityHold.index = 7
field_descriptors.MultiRoundAoeNO_MultiEntityHold.label = 1
field_descriptors.MultiRoundAoeNO_MultiEntityHold.has_default_value = false
field_descriptors.MultiRoundAoeNO_MultiEntityHold.default_value = nil
field_descriptors.MultiRoundAoeNO_MultiEntityHold.message_type = type_descriptors.MultiEntityHoldNO
field_descriptors.MultiRoundAoeNO_MultiEntityHold.type = 11
field_descriptors.MultiRoundAoeNO_MultiEntityHold.cpp_type = 10
type_descriptors.MultiRoundAoeNO.name = "MultiRoundAoeNO"
type_descriptors.MultiRoundAoeNO.full_name = ".MultiRoundAoeNO"
type_descriptors.MultiRoundAoeNO.nested_types = {}
type_descriptors.MultiRoundAoeNO.enum_types = {}
type_descriptors.MultiRoundAoeNO.fields = {
	field_descriptors.MultiRoundAoeNO_shape,
	field_descriptors.MultiRoundAoeNO_entity,
	field_descriptors.MultiRoundAoeNO_skill,
	field_descriptors.MultiRoundAoeNO_id,
	field_descriptors.MultiRoundAoeNO_targetEntity,
	field_descriptors.MultiRoundAoeNO_targetCell,
	field_descriptors.MultiRoundAoeNO_strengthening,
	field_descriptors.MultiRoundAoeNO_MultiEntityHold
}
type_descriptors.MultiRoundAoeNO.is_extendable = false
type_descriptors.MultiRoundAoeNO.extensions = {}
field_descriptors.StepHistoryNO_round.name = "round"
field_descriptors.StepHistoryNO_round.full_name = ".StepHistoryNO.round"
field_descriptors.StepHistoryNO_round.number = 1
field_descriptors.StepHistoryNO_round.index = 0
field_descriptors.StepHistoryNO_round.label = 2
field_descriptors.StepHistoryNO_round.has_default_value = false
field_descriptors.StepHistoryNO_round.default_value = 0
field_descriptors.StepHistoryNO_round.type = 5
field_descriptors.StepHistoryNO_round.cpp_type = 1
field_descriptors.StepHistoryNO_entityId.name = "entityId"
field_descriptors.StepHistoryNO_entityId.full_name = ".StepHistoryNO.entityId"
field_descriptors.StepHistoryNO_entityId.number = 2
field_descriptors.StepHistoryNO_entityId.index = 1
field_descriptors.StepHistoryNO_entityId.label = 2
field_descriptors.StepHistoryNO_entityId.has_default_value = false
field_descriptors.StepHistoryNO_entityId.default_value = 0
field_descriptors.StepHistoryNO_entityId.type = 5
field_descriptors.StepHistoryNO_entityId.cpp_type = 1
field_descriptors.StepHistoryNO_entityCode.name = "entityCode"
field_descriptors.StepHistoryNO_entityCode.full_name = ".StepHistoryNO.entityCode"
field_descriptors.StepHistoryNO_entityCode.number = 3
field_descriptors.StepHistoryNO_entityCode.index = 2
field_descriptors.StepHistoryNO_entityCode.label = 2
field_descriptors.StepHistoryNO_entityCode.has_default_value = false
field_descriptors.StepHistoryNO_entityCode.default_value = 0
field_descriptors.StepHistoryNO_entityCode.type = 5
field_descriptors.StepHistoryNO_entityCode.cpp_type = 1
field_descriptors.StepHistoryNO_entityType.name = "entityType"
field_descriptors.StepHistoryNO_entityType.full_name = ".StepHistoryNO.entityType"
field_descriptors.StepHistoryNO_entityType.number = 4
field_descriptors.StepHistoryNO_entityType.index = 3
field_descriptors.StepHistoryNO_entityType.label = 1
field_descriptors.StepHistoryNO_entityType.has_default_value = false
field_descriptors.StepHistoryNO_entityType.default_value = nil
field_descriptors.StepHistoryNO_entityType.enum_type = type_descriptors.EntityType
field_descriptors.StepHistoryNO_entityType.type = 14
field_descriptors.StepHistoryNO_entityType.cpp_type = 8
field_descriptors.StepHistoryNO_movement.name = "movement"
field_descriptors.StepHistoryNO_movement.full_name = ".StepHistoryNO.movement"
field_descriptors.StepHistoryNO_movement.number = 5
field_descriptors.StepHistoryNO_movement.index = 4
field_descriptors.StepHistoryNO_movement.label = 3
field_descriptors.StepHistoryNO_movement.has_default_value = false
field_descriptors.StepHistoryNO_movement.default_value = {}
field_descriptors.StepHistoryNO_movement.message_type = type_descriptors.CellNO
field_descriptors.StepHistoryNO_movement.type = 11
field_descriptors.StepHistoryNO_movement.cpp_type = 10
field_descriptors.StepHistoryNO_releasingSkill.name = "releasingSkill"
field_descriptors.StepHistoryNO_releasingSkill.full_name = ".StepHistoryNO.releasingSkill"
field_descriptors.StepHistoryNO_releasingSkill.number = 6
field_descriptors.StepHistoryNO_releasingSkill.index = 5
field_descriptors.StepHistoryNO_releasingSkill.label = 1
field_descriptors.StepHistoryNO_releasingSkill.has_default_value = false
field_descriptors.StepHistoryNO_releasingSkill.default_value = 0
field_descriptors.StepHistoryNO_releasingSkill.type = 5
field_descriptors.StepHistoryNO_releasingSkill.cpp_type = 1
type_descriptors.StepHistoryNO.name = "StepHistoryNO"
type_descriptors.StepHistoryNO.full_name = ".StepHistoryNO"
type_descriptors.StepHistoryNO.nested_types = {}
type_descriptors.StepHistoryNO.enum_types = {}
type_descriptors.StepHistoryNO.fields = {
	field_descriptors.StepHistoryNO_round,
	field_descriptors.StepHistoryNO_entityId,
	field_descriptors.StepHistoryNO_entityCode,
	field_descriptors.StepHistoryNO_entityType,
	field_descriptors.StepHistoryNO_movement,
	field_descriptors.StepHistoryNO_releasingSkill
}
type_descriptors.StepHistoryNO.is_extendable = false
type_descriptors.StepHistoryNO.extensions = {}
field_descriptors.TagEnhanceNO_tag.name = "tag"
field_descriptors.TagEnhanceNO_tag.full_name = ".TagEnhanceNO.tag"
field_descriptors.TagEnhanceNO_tag.number = 1
field_descriptors.TagEnhanceNO_tag.index = 0
field_descriptors.TagEnhanceNO_tag.label = 2
field_descriptors.TagEnhanceNO_tag.has_default_value = false
field_descriptors.TagEnhanceNO_tag.default_value = ""
field_descriptors.TagEnhanceNO_tag.type = 9
field_descriptors.TagEnhanceNO_tag.cpp_type = 9
field_descriptors.TagEnhanceNO_field.name = "field"
field_descriptors.TagEnhanceNO_field.full_name = ".TagEnhanceNO.field"
field_descriptors.TagEnhanceNO_field.number = 2
field_descriptors.TagEnhanceNO_field.index = 1
field_descriptors.TagEnhanceNO_field.label = 2
field_descriptors.TagEnhanceNO_field.has_default_value = false
field_descriptors.TagEnhanceNO_field.default_value = ""
field_descriptors.TagEnhanceNO_field.type = 9
field_descriptors.TagEnhanceNO_field.cpp_type = 9
field_descriptors.TagEnhanceNO_contexts.name = "contexts"
field_descriptors.TagEnhanceNO_contexts.full_name = ".TagEnhanceNO.contexts"
field_descriptors.TagEnhanceNO_contexts.number = 3
field_descriptors.TagEnhanceNO_contexts.index = 2
field_descriptors.TagEnhanceNO_contexts.label = 3
field_descriptors.TagEnhanceNO_contexts.has_default_value = false
field_descriptors.TagEnhanceNO_contexts.default_value = {}
field_descriptors.TagEnhanceNO_contexts.message_type = type_descriptors.TagEnhanceContextNO
field_descriptors.TagEnhanceNO_contexts.type = 11
field_descriptors.TagEnhanceNO_contexts.cpp_type = 10
type_descriptors.TagEnhanceNO.name = "TagEnhanceNO"
type_descriptors.TagEnhanceNO.full_name = ".TagEnhanceNO"
type_descriptors.TagEnhanceNO.nested_types = {}
type_descriptors.TagEnhanceNO.enum_types = {}
type_descriptors.TagEnhanceNO.fields = {
	field_descriptors.TagEnhanceNO_tag,
	field_descriptors.TagEnhanceNO_field,
	field_descriptors.TagEnhanceNO_contexts
}
type_descriptors.TagEnhanceNO.is_extendable = false
type_descriptors.TagEnhanceNO.extensions = {}
type_descriptors.EndStageReply.name = "EndStageReply"
type_descriptors.EndStageReply.full_name = ".EndStageReply"
type_descriptors.EndStageReply.nested_types = {}
type_descriptors.EndStageReply.enum_types = {}
type_descriptors.EndStageReply.fields = {}
type_descriptors.EndStageReply.is_extendable = false
type_descriptors.EndStageReply.extensions = {}
field_descriptors.PlaceEntityNO_entity.name = "entity"
field_descriptors.PlaceEntityNO_entity.full_name = ".PlaceEntityNO.entity"
field_descriptors.PlaceEntityNO_entity.number = 1
field_descriptors.PlaceEntityNO_entity.index = 0
field_descriptors.PlaceEntityNO_entity.label = 1
field_descriptors.PlaceEntityNO_entity.has_default_value = false
field_descriptors.PlaceEntityNO_entity.default_value = 0
field_descriptors.PlaceEntityNO_entity.type = 5
field_descriptors.PlaceEntityNO_entity.cpp_type = 1
field_descriptors.PlaceEntityNO_cell.name = "cell"
field_descriptors.PlaceEntityNO_cell.full_name = ".PlaceEntityNO.cell"
field_descriptors.PlaceEntityNO_cell.number = 2
field_descriptors.PlaceEntityNO_cell.index = 1
field_descriptors.PlaceEntityNO_cell.label = 1
field_descriptors.PlaceEntityNO_cell.has_default_value = false
field_descriptors.PlaceEntityNO_cell.default_value = nil
field_descriptors.PlaceEntityNO_cell.message_type = type_descriptors.CellNO
field_descriptors.PlaceEntityNO_cell.type = 11
field_descriptors.PlaceEntityNO_cell.cpp_type = 10
type_descriptors.PlaceEntityNO.name = "PlaceEntityNO"
type_descriptors.PlaceEntityNO.full_name = ".PlaceEntityNO"
type_descriptors.PlaceEntityNO.nested_types = {}
type_descriptors.PlaceEntityNO.enum_types = {}
type_descriptors.PlaceEntityNO.fields = {
	field_descriptors.PlaceEntityNO_entity,
	field_descriptors.PlaceEntityNO_cell
}
type_descriptors.PlaceEntityNO.is_extendable = false
type_descriptors.PlaceEntityNO.extensions = {}
field_descriptors.AirMapInfoNO_sceneId.name = "sceneId"
field_descriptors.AirMapInfoNO_sceneId.full_name = ".AirMapInfoNO.sceneId"
field_descriptors.AirMapInfoNO_sceneId.number = 1
field_descriptors.AirMapInfoNO_sceneId.index = 0
field_descriptors.AirMapInfoNO_sceneId.label = 2
field_descriptors.AirMapInfoNO_sceneId.has_default_value = false
field_descriptors.AirMapInfoNO_sceneId.default_value = 0
field_descriptors.AirMapInfoNO_sceneId.type = 5
field_descriptors.AirMapInfoNO_sceneId.cpp_type = 1
field_descriptors.AirMapInfoNO_building.name = "building"
field_descriptors.AirMapInfoNO_building.full_name = ".AirMapInfoNO.building"
field_descriptors.AirMapInfoNO_building.number = 2
field_descriptors.AirMapInfoNO_building.index = 1
field_descriptors.AirMapInfoNO_building.label = 3
field_descriptors.AirMapInfoNO_building.has_default_value = false
field_descriptors.AirMapInfoNO_building.default_value = {}
field_descriptors.AirMapInfoNO_building.message_type = type_descriptors.BuildingNO
field_descriptors.AirMapInfoNO_building.type = 11
field_descriptors.AirMapInfoNO_building.cpp_type = 10
field_descriptors.AirMapInfoNO_extraWinCondition.name = "extraWinCondition"
field_descriptors.AirMapInfoNO_extraWinCondition.full_name = ".AirMapInfoNO.extraWinCondition"
field_descriptors.AirMapInfoNO_extraWinCondition.number = 3
field_descriptors.AirMapInfoNO_extraWinCondition.index = 2
field_descriptors.AirMapInfoNO_extraWinCondition.label = 1
field_descriptors.AirMapInfoNO_extraWinCondition.has_default_value = false
field_descriptors.AirMapInfoNO_extraWinCondition.default_value = nil
field_descriptors.AirMapInfoNO_extraWinCondition.message_type = type_descriptors.WinConditionNO
field_descriptors.AirMapInfoNO_extraWinCondition.type = 11
field_descriptors.AirMapInfoNO_extraWinCondition.cpp_type = 10
field_descriptors.AirMapInfoNO_ambushUnit.name = "ambushUnit"
field_descriptors.AirMapInfoNO_ambushUnit.full_name = ".AirMapInfoNO.ambushUnit"
field_descriptors.AirMapInfoNO_ambushUnit.number = 4
field_descriptors.AirMapInfoNO_ambushUnit.index = 3
field_descriptors.AirMapInfoNO_ambushUnit.label = 3
field_descriptors.AirMapInfoNO_ambushUnit.has_default_value = false
field_descriptors.AirMapInfoNO_ambushUnit.default_value = {}
field_descriptors.AirMapInfoNO_ambushUnit.message_type = type_descriptors.AmbushNO
field_descriptors.AirMapInfoNO_ambushUnit.type = 11
field_descriptors.AirMapInfoNO_ambushUnit.cpp_type = 10
field_descriptors.AirMapInfoNO_normalUnit.name = "normalUnit"
field_descriptors.AirMapInfoNO_normalUnit.full_name = ".AirMapInfoNO.normalUnit"
field_descriptors.AirMapInfoNO_normalUnit.number = 5
field_descriptors.AirMapInfoNO_normalUnit.index = 4
field_descriptors.AirMapInfoNO_normalUnit.label = 3
field_descriptors.AirMapInfoNO_normalUnit.has_default_value = false
field_descriptors.AirMapInfoNO_normalUnit.default_value = {}
field_descriptors.AirMapInfoNO_normalUnit.message_type = type_descriptors.HeroNO
field_descriptors.AirMapInfoNO_normalUnit.type = 11
field_descriptors.AirMapInfoNO_normalUnit.cpp_type = 10
field_descriptors.AirMapInfoNO_initTags.name = "initTags"
field_descriptors.AirMapInfoNO_initTags.full_name = ".AirMapInfoNO.initTags"
field_descriptors.AirMapInfoNO_initTags.number = 6
field_descriptors.AirMapInfoNO_initTags.index = 5
field_descriptors.AirMapInfoNO_initTags.label = 3
field_descriptors.AirMapInfoNO_initTags.has_default_value = false
field_descriptors.AirMapInfoNO_initTags.default_value = {}
field_descriptors.AirMapInfoNO_initTags.type = 5
field_descriptors.AirMapInfoNO_initTags.cpp_type = 1
field_descriptors.AirMapInfoNO_bornCell.name = "bornCell"
field_descriptors.AirMapInfoNO_bornCell.full_name = ".AirMapInfoNO.bornCell"
field_descriptors.AirMapInfoNO_bornCell.number = 7
field_descriptors.AirMapInfoNO_bornCell.index = 6
field_descriptors.AirMapInfoNO_bornCell.label = 3
field_descriptors.AirMapInfoNO_bornCell.has_default_value = false
field_descriptors.AirMapInfoNO_bornCell.default_value = {}
field_descriptors.AirMapInfoNO_bornCell.message_type = type_descriptors.BornCellNO
field_descriptors.AirMapInfoNO_bornCell.type = 11
field_descriptors.AirMapInfoNO_bornCell.cpp_type = 10
type_descriptors.AirMapInfoNO.name = "AirMapInfoNO"
type_descriptors.AirMapInfoNO.full_name = ".AirMapInfoNO"
type_descriptors.AirMapInfoNO.nested_types = {}
type_descriptors.AirMapInfoNO.enum_types = {}
type_descriptors.AirMapInfoNO.fields = {
	field_descriptors.AirMapInfoNO_sceneId,
	field_descriptors.AirMapInfoNO_building,
	field_descriptors.AirMapInfoNO_extraWinCondition,
	field_descriptors.AirMapInfoNO_ambushUnit,
	field_descriptors.AirMapInfoNO_normalUnit,
	field_descriptors.AirMapInfoNO_initTags,
	field_descriptors.AirMapInfoNO_bornCell
}
type_descriptors.AirMapInfoNO.is_extendable = false
type_descriptors.AirMapInfoNO.extensions = {}
field_descriptors.ShootNO_eId.name = "eId"
field_descriptors.ShootNO_eId.full_name = ".ShootNO.eId"
field_descriptors.ShootNO_eId.number = 1
field_descriptors.ShootNO_eId.index = 0
field_descriptors.ShootNO_eId.label = 1
field_descriptors.ShootNO_eId.has_default_value = false
field_descriptors.ShootNO_eId.default_value = 0
field_descriptors.ShootNO_eId.type = 5
field_descriptors.ShootNO_eId.cpp_type = 1
field_descriptors.ShootNO_events.name = "events"
field_descriptors.ShootNO_events.full_name = ".ShootNO.events"
field_descriptors.ShootNO_events.number = 2
field_descriptors.ShootNO_events.index = 1
field_descriptors.ShootNO_events.label = 3
field_descriptors.ShootNO_events.has_default_value = false
field_descriptors.ShootNO_events.default_value = {}
field_descriptors.ShootNO_events.message_type = type_descriptors.EventNO
field_descriptors.ShootNO_events.type = 11
field_descriptors.ShootNO_events.cpp_type = 10
field_descriptors.ShootNO_chain.name = "chain"
field_descriptors.ShootNO_chain.full_name = ".ShootNO.chain"
field_descriptors.ShootNO_chain.number = 3
field_descriptors.ShootNO_chain.index = 2
field_descriptors.ShootNO_chain.label = 1
field_descriptors.ShootNO_chain.has_default_value = false
field_descriptors.ShootNO_chain.default_value = 0
field_descriptors.ShootNO_chain.type = 5
field_descriptors.ShootNO_chain.cpp_type = 1
type_descriptors.ShootNO.name = "ShootNO"
type_descriptors.ShootNO.full_name = ".ShootNO"
type_descriptors.ShootNO.nested_types = {}
type_descriptors.ShootNO.enum_types = {}
type_descriptors.ShootNO.fields = {
	field_descriptors.ShootNO_eId,
	field_descriptors.ShootNO_events,
	field_descriptors.ShootNO_chain
}
type_descriptors.ShootNO.is_extendable = false
type_descriptors.ShootNO.extensions = {}
field_descriptors.SurrenderRequest_type.name = "type"
field_descriptors.SurrenderRequest_type.full_name = ".SurrenderRequest.type"
field_descriptors.SurrenderRequest_type.number = 1
field_descriptors.SurrenderRequest_type.index = 0
field_descriptors.SurrenderRequest_type.label = 1
field_descriptors.SurrenderRequest_type.has_default_value = false
field_descriptors.SurrenderRequest_type.default_value = nil
field_descriptors.SurrenderRequest_type.enum_type = type_descriptors.EndType
field_descriptors.SurrenderRequest_type.type = 14
field_descriptors.SurrenderRequest_type.cpp_type = 8
type_descriptors.SurrenderRequest.name = "SurrenderRequest"
type_descriptors.SurrenderRequest.full_name = ".SurrenderRequest"
type_descriptors.SurrenderRequest.nested_types = {}
type_descriptors.SurrenderRequest.enum_types = {}
type_descriptors.SurrenderRequest.fields = {
	field_descriptors.SurrenderRequest_type
}
type_descriptors.SurrenderRequest.is_extendable = false
type_descriptors.SurrenderRequest.extensions = {}
field_descriptors.FractionPointNO_x.name = "x"
field_descriptors.FractionPointNO_x.full_name = ".FractionPointNO.x"
field_descriptors.FractionPointNO_x.number = 1
field_descriptors.FractionPointNO_x.index = 0
field_descriptors.FractionPointNO_x.label = 1
field_descriptors.FractionPointNO_x.has_default_value = false
field_descriptors.FractionPointNO_x.default_value = nil
field_descriptors.FractionPointNO_x.message_type = type_descriptors.FractionNO
field_descriptors.FractionPointNO_x.type = 11
field_descriptors.FractionPointNO_x.cpp_type = 10
field_descriptors.FractionPointNO_z.name = "z"
field_descriptors.FractionPointNO_z.full_name = ".FractionPointNO.z"
field_descriptors.FractionPointNO_z.number = 2
field_descriptors.FractionPointNO_z.index = 1
field_descriptors.FractionPointNO_z.label = 1
field_descriptors.FractionPointNO_z.has_default_value = false
field_descriptors.FractionPointNO_z.default_value = nil
field_descriptors.FractionPointNO_z.message_type = type_descriptors.FractionNO
field_descriptors.FractionPointNO_z.type = 11
field_descriptors.FractionPointNO_z.cpp_type = 10
type_descriptors.FractionPointNO.name = "FractionPointNO"
type_descriptors.FractionPointNO.full_name = ".FractionPointNO"
type_descriptors.FractionPointNO.nested_types = {}
type_descriptors.FractionPointNO.enum_types = {}
type_descriptors.FractionPointNO.fields = {
	field_descriptors.FractionPointNO_x,
	field_descriptors.FractionPointNO_z
}
type_descriptors.FractionPointNO.is_extendable = false
type_descriptors.FractionPointNO.extensions = {}
field_descriptors.WeakPointHpChangedEventNO_entity.name = "entity"
field_descriptors.WeakPointHpChangedEventNO_entity.full_name = ".WeakPointHpChangedEventNO.entity"
field_descriptors.WeakPointHpChangedEventNO_entity.number = 1
field_descriptors.WeakPointHpChangedEventNO_entity.index = 0
field_descriptors.WeakPointHpChangedEventNO_entity.label = 1
field_descriptors.WeakPointHpChangedEventNO_entity.has_default_value = false
field_descriptors.WeakPointHpChangedEventNO_entity.default_value = 0
field_descriptors.WeakPointHpChangedEventNO_entity.type = 5
field_descriptors.WeakPointHpChangedEventNO_entity.cpp_type = 1
field_descriptors.WeakPointHpChangedEventNO_hp.name = "hp"
field_descriptors.WeakPointHpChangedEventNO_hp.full_name = ".WeakPointHpChangedEventNO.hp"
field_descriptors.WeakPointHpChangedEventNO_hp.number = 2
field_descriptors.WeakPointHpChangedEventNO_hp.index = 1
field_descriptors.WeakPointHpChangedEventNO_hp.label = 1
field_descriptors.WeakPointHpChangedEventNO_hp.has_default_value = false
field_descriptors.WeakPointHpChangedEventNO_hp.default_value = 0
field_descriptors.WeakPointHpChangedEventNO_hp.type = 5
field_descriptors.WeakPointHpChangedEventNO_hp.cpp_type = 1
type_descriptors.WeakPointHpChangedEventNO.name = "WeakPointHpChangedEventNO"
type_descriptors.WeakPointHpChangedEventNO.full_name = ".WeakPointHpChangedEventNO"
type_descriptors.WeakPointHpChangedEventNO.nested_types = {}
type_descriptors.WeakPointHpChangedEventNO.enum_types = {}
type_descriptors.WeakPointHpChangedEventNO.fields = {
	field_descriptors.WeakPointHpChangedEventNO_entity,
	field_descriptors.WeakPointHpChangedEventNO_hp
}
type_descriptors.WeakPointHpChangedEventNO.is_extendable = false
type_descriptors.WeakPointHpChangedEventNO.extensions = {}
field_descriptors.ModelRectangleNO_modelId.name = "modelId"
field_descriptors.ModelRectangleNO_modelId.full_name = ".ModelRectangleNO.modelId"
field_descriptors.ModelRectangleNO_modelId.number = 1
field_descriptors.ModelRectangleNO_modelId.index = 0
field_descriptors.ModelRectangleNO_modelId.label = 1
field_descriptors.ModelRectangleNO_modelId.has_default_value = false
field_descriptors.ModelRectangleNO_modelId.default_value = 0
field_descriptors.ModelRectangleNO_modelId.type = 5
field_descriptors.ModelRectangleNO_modelId.cpp_type = 1
type_descriptors.ModelRectangleNO.name = "ModelRectangleNO"
type_descriptors.ModelRectangleNO.full_name = ".ModelRectangleNO"
type_descriptors.ModelRectangleNO.nested_types = {}
type_descriptors.ModelRectangleNO.enum_types = {}
type_descriptors.ModelRectangleNO.fields = {
	field_descriptors.ModelRectangleNO_modelId
}
type_descriptors.ModelRectangleNO.is_extendable = false
type_descriptors.ModelRectangleNO.extensions = {}
field_descriptors.TagNO_base.name = "base"
field_descriptors.TagNO_base.full_name = ".TagNO.base"
field_descriptors.TagNO_base.number = 1
field_descriptors.TagNO_base.index = 0
field_descriptors.TagNO_base.label = 1
field_descriptors.TagNO_base.has_default_value = false
field_descriptors.TagNO_base.default_value = nil
field_descriptors.TagNO_base.message_type = type_descriptors.TagBaseNO
field_descriptors.TagNO_base.type = 11
field_descriptors.TagNO_base.cpp_type = 10
field_descriptors.TagNO_events.name = "events"
field_descriptors.TagNO_events.full_name = ".TagNO.events"
field_descriptors.TagNO_events.number = 2
field_descriptors.TagNO_events.index = 1
field_descriptors.TagNO_events.label = 3
field_descriptors.TagNO_events.has_default_value = false
field_descriptors.TagNO_events.default_value = {}
field_descriptors.TagNO_events.message_type = type_descriptors.EventNO
field_descriptors.TagNO_events.type = 11
field_descriptors.TagNO_events.cpp_type = 10
type_descriptors.TagNO.name = "TagNO"
type_descriptors.TagNO.full_name = ".TagNO"
type_descriptors.TagNO.nested_types = {}
type_descriptors.TagNO.enum_types = {}
type_descriptors.TagNO.fields = {
	field_descriptors.TagNO_base,
	field_descriptors.TagNO_events
}
type_descriptors.TagNO.is_extendable = false
type_descriptors.TagNO.extensions = {}
field_descriptors.BuffAddedEventNO_entity.name = "entity"
field_descriptors.BuffAddedEventNO_entity.full_name = ".BuffAddedEventNO.entity"
field_descriptors.BuffAddedEventNO_entity.number = 1
field_descriptors.BuffAddedEventNO_entity.index = 0
field_descriptors.BuffAddedEventNO_entity.label = 1
field_descriptors.BuffAddedEventNO_entity.has_default_value = false
field_descriptors.BuffAddedEventNO_entity.default_value = 0
field_descriptors.BuffAddedEventNO_entity.type = 5
field_descriptors.BuffAddedEventNO_entity.cpp_type = 1
field_descriptors.BuffAddedEventNO_code.name = "code"
field_descriptors.BuffAddedEventNO_code.full_name = ".BuffAddedEventNO.code"
field_descriptors.BuffAddedEventNO_code.number = 2
field_descriptors.BuffAddedEventNO_code.index = 1
field_descriptors.BuffAddedEventNO_code.label = 1
field_descriptors.BuffAddedEventNO_code.has_default_value = false
field_descriptors.BuffAddedEventNO_code.default_value = 0
field_descriptors.BuffAddedEventNO_code.type = 5
field_descriptors.BuffAddedEventNO_code.cpp_type = 1
field_descriptors.BuffAddedEventNO_round.name = "round"
field_descriptors.BuffAddedEventNO_round.full_name = ".BuffAddedEventNO.round"
field_descriptors.BuffAddedEventNO_round.number = 3
field_descriptors.BuffAddedEventNO_round.index = 2
field_descriptors.BuffAddedEventNO_round.label = 1
field_descriptors.BuffAddedEventNO_round.has_default_value = false
field_descriptors.BuffAddedEventNO_round.default_value = 0
field_descriptors.BuffAddedEventNO_round.type = 5
field_descriptors.BuffAddedEventNO_round.cpp_type = 1
field_descriptors.BuffAddedEventNO_id.name = "id"
field_descriptors.BuffAddedEventNO_id.full_name = ".BuffAddedEventNO.id"
field_descriptors.BuffAddedEventNO_id.number = 4
field_descriptors.BuffAddedEventNO_id.index = 3
field_descriptors.BuffAddedEventNO_id.label = 1
field_descriptors.BuffAddedEventNO_id.has_default_value = false
field_descriptors.BuffAddedEventNO_id.default_value = 0
field_descriptors.BuffAddedEventNO_id.type = 5
field_descriptors.BuffAddedEventNO_id.cpp_type = 1
field_descriptors.BuffAddedEventNO_layer.name = "layer"
field_descriptors.BuffAddedEventNO_layer.full_name = ".BuffAddedEventNO.layer"
field_descriptors.BuffAddedEventNO_layer.number = 5
field_descriptors.BuffAddedEventNO_layer.index = 4
field_descriptors.BuffAddedEventNO_layer.label = 1
field_descriptors.BuffAddedEventNO_layer.has_default_value = false
field_descriptors.BuffAddedEventNO_layer.default_value = 0
field_descriptors.BuffAddedEventNO_layer.type = 5
field_descriptors.BuffAddedEventNO_layer.cpp_type = 1
type_descriptors.BuffAddedEventNO.name = "BuffAddedEventNO"
type_descriptors.BuffAddedEventNO.full_name = ".BuffAddedEventNO"
type_descriptors.BuffAddedEventNO.nested_types = {}
type_descriptors.BuffAddedEventNO.enum_types = {}
type_descriptors.BuffAddedEventNO.fields = {
	field_descriptors.BuffAddedEventNO_entity,
	field_descriptors.BuffAddedEventNO_code,
	field_descriptors.BuffAddedEventNO_round,
	field_descriptors.BuffAddedEventNO_id,
	field_descriptors.BuffAddedEventNO_layer
}
type_descriptors.BuffAddedEventNO.is_extendable = false
type_descriptors.BuffAddedEventNO.extensions = {}
field_descriptors.WonConditionsChangedEventNO_added.name = "added"
field_descriptors.WonConditionsChangedEventNO_added.full_name = ".WonConditionsChangedEventNO.added"
field_descriptors.WonConditionsChangedEventNO_added.number = 1
field_descriptors.WonConditionsChangedEventNO_added.index = 0
field_descriptors.WonConditionsChangedEventNO_added.label = 3
field_descriptors.WonConditionsChangedEventNO_added.has_default_value = false
field_descriptors.WonConditionsChangedEventNO_added.default_value = {}
field_descriptors.WonConditionsChangedEventNO_added.type = 9
field_descriptors.WonConditionsChangedEventNO_added.cpp_type = 9
field_descriptors.WonConditionsChangedEventNO_removed.name = "removed"
field_descriptors.WonConditionsChangedEventNO_removed.full_name = ".WonConditionsChangedEventNO.removed"
field_descriptors.WonConditionsChangedEventNO_removed.number = 2
field_descriptors.WonConditionsChangedEventNO_removed.index = 1
field_descriptors.WonConditionsChangedEventNO_removed.label = 3
field_descriptors.WonConditionsChangedEventNO_removed.has_default_value = false
field_descriptors.WonConditionsChangedEventNO_removed.default_value = {}
field_descriptors.WonConditionsChangedEventNO_removed.type = 9
field_descriptors.WonConditionsChangedEventNO_removed.cpp_type = 9
type_descriptors.WonConditionsChangedEventNO.name = "WonConditionsChangedEventNO"
type_descriptors.WonConditionsChangedEventNO.full_name = ".WonConditionsChangedEventNO"
type_descriptors.WonConditionsChangedEventNO.nested_types = {}
type_descriptors.WonConditionsChangedEventNO.enum_types = {}
type_descriptors.WonConditionsChangedEventNO.fields = {
	field_descriptors.WonConditionsChangedEventNO_added,
	field_descriptors.WonConditionsChangedEventNO_removed
}
type_descriptors.WonConditionsChangedEventNO.is_extendable = false
type_descriptors.WonConditionsChangedEventNO.extensions = {}
field_descriptors.ParallelRectangleNO_width.name = "width"
field_descriptors.ParallelRectangleNO_width.full_name = ".ParallelRectangleNO.width"
field_descriptors.ParallelRectangleNO_width.number = 1
field_descriptors.ParallelRectangleNO_width.index = 0
field_descriptors.ParallelRectangleNO_width.label = 1
field_descriptors.ParallelRectangleNO_width.has_default_value = false
field_descriptors.ParallelRectangleNO_width.default_value = 0
field_descriptors.ParallelRectangleNO_width.type = 5
field_descriptors.ParallelRectangleNO_width.cpp_type = 1
field_descriptors.ParallelRectangleNO_height.name = "height"
field_descriptors.ParallelRectangleNO_height.full_name = ".ParallelRectangleNO.height"
field_descriptors.ParallelRectangleNO_height.number = 2
field_descriptors.ParallelRectangleNO_height.index = 1
field_descriptors.ParallelRectangleNO_height.label = 1
field_descriptors.ParallelRectangleNO_height.has_default_value = false
field_descriptors.ParallelRectangleNO_height.default_value = 0
field_descriptors.ParallelRectangleNO_height.type = 5
field_descriptors.ParallelRectangleNO_height.cpp_type = 1
field_descriptors.ParallelRectangleNO_offset.name = "offset"
field_descriptors.ParallelRectangleNO_offset.full_name = ".ParallelRectangleNO.offset"
field_descriptors.ParallelRectangleNO_offset.number = 3
field_descriptors.ParallelRectangleNO_offset.index = 2
field_descriptors.ParallelRectangleNO_offset.label = 1
field_descriptors.ParallelRectangleNO_offset.has_default_value = false
field_descriptors.ParallelRectangleNO_offset.default_value = 0
field_descriptors.ParallelRectangleNO_offset.type = 5
field_descriptors.ParallelRectangleNO_offset.cpp_type = 1
type_descriptors.ParallelRectangleNO.name = "ParallelRectangleNO"
type_descriptors.ParallelRectangleNO.full_name = ".ParallelRectangleNO"
type_descriptors.ParallelRectangleNO.nested_types = {}
type_descriptors.ParallelRectangleNO.enum_types = {}
type_descriptors.ParallelRectangleNO.fields = {
	field_descriptors.ParallelRectangleNO_width,
	field_descriptors.ParallelRectangleNO_height,
	field_descriptors.ParallelRectangleNO_offset
}
type_descriptors.ParallelRectangleNO.is_extendable = false
type_descriptors.ParallelRectangleNO.extensions = {}
field_descriptors.ResultForecastAiPush_fromForecast.name = "fromForecast"
field_descriptors.ResultForecastAiPush_fromForecast.full_name = ".ResultForecastAiPush.fromForecast"
field_descriptors.ResultForecastAiPush_fromForecast.number = 1
field_descriptors.ResultForecastAiPush_fromForecast.index = 0
field_descriptors.ResultForecastAiPush_fromForecast.label = 1
field_descriptors.ResultForecastAiPush_fromForecast.has_default_value = false
field_descriptors.ResultForecastAiPush_fromForecast.default_value = false
field_descriptors.ResultForecastAiPush_fromForecast.type = 8
field_descriptors.ResultForecastAiPush_fromForecast.cpp_type = 7
field_descriptors.ResultForecastAiPush_forecastAis.name = "forecastAis"
field_descriptors.ResultForecastAiPush_forecastAis.full_name = ".ResultForecastAiPush.forecastAis"
field_descriptors.ResultForecastAiPush_forecastAis.number = 2
field_descriptors.ResultForecastAiPush_forecastAis.index = 1
field_descriptors.ResultForecastAiPush_forecastAis.label = 3
field_descriptors.ResultForecastAiPush_forecastAis.has_default_value = false
field_descriptors.ResultForecastAiPush_forecastAis.default_value = {}
field_descriptors.ResultForecastAiPush_forecastAis.message_type = type_descriptors.ForecastAiNO
field_descriptors.ResultForecastAiPush_forecastAis.type = 11
field_descriptors.ResultForecastAiPush_forecastAis.cpp_type = 10
type_descriptors.ResultForecastAiPush.name = "ResultForecastAiPush"
type_descriptors.ResultForecastAiPush.full_name = ".ResultForecastAiPush"
type_descriptors.ResultForecastAiPush.nested_types = {}
type_descriptors.ResultForecastAiPush.enum_types = {}
type_descriptors.ResultForecastAiPush.fields = {
	field_descriptors.ResultForecastAiPush_fromForecast,
	field_descriptors.ResultForecastAiPush_forecastAis
}
type_descriptors.ResultForecastAiPush.is_extendable = false
type_descriptors.ResultForecastAiPush.extensions = {}
field_descriptors.StepRequest_entity.name = "entity"
field_descriptors.StepRequest_entity.full_name = ".StepRequest.entity"
field_descriptors.StepRequest_entity.number = 1
field_descriptors.StepRequest_entity.index = 0
field_descriptors.StepRequest_entity.label = 1
field_descriptors.StepRequest_entity.has_default_value = false
field_descriptors.StepRequest_entity.default_value = 0
field_descriptors.StepRequest_entity.type = 5
field_descriptors.StepRequest_entity.cpp_type = 1
field_descriptors.StepRequest_movement.name = "movement"
field_descriptors.StepRequest_movement.full_name = ".StepRequest.movement"
field_descriptors.StepRequest_movement.number = 2
field_descriptors.StepRequest_movement.index = 1
field_descriptors.StepRequest_movement.label = 3
field_descriptors.StepRequest_movement.has_default_value = false
field_descriptors.StepRequest_movement.default_value = {}
field_descriptors.StepRequest_movement.message_type = type_descriptors.CellNO
field_descriptors.StepRequest_movement.type = 11
field_descriptors.StepRequest_movement.cpp_type = 10
field_descriptors.StepRequest_releasingSkill.name = "releasingSkill"
field_descriptors.StepRequest_releasingSkill.full_name = ".StepRequest.releasingSkill"
field_descriptors.StepRequest_releasingSkill.number = 3
field_descriptors.StepRequest_releasingSkill.index = 2
field_descriptors.StepRequest_releasingSkill.label = 1
field_descriptors.StepRequest_releasingSkill.has_default_value = false
field_descriptors.StepRequest_releasingSkill.default_value = 0
field_descriptors.StepRequest_releasingSkill.type = 5
field_descriptors.StepRequest_releasingSkill.cpp_type = 1
field_descriptors.StepRequest_target.name = "target"
field_descriptors.StepRequest_target.full_name = ".StepRequest.target"
field_descriptors.StepRequest_target.number = 4
field_descriptors.StepRequest_target.index = 3
field_descriptors.StepRequest_target.label = 1
field_descriptors.StepRequest_target.has_default_value = false
field_descriptors.StepRequest_target.default_value = nil
field_descriptors.StepRequest_target.message_type = type_descriptors.CellNO
field_descriptors.StepRequest_target.type = 11
field_descriptors.StepRequest_target.cpp_type = 10
field_descriptors.StepRequest_position.name = "position"
field_descriptors.StepRequest_position.full_name = ".StepRequest.position"
field_descriptors.StepRequest_position.number = 5
field_descriptors.StepRequest_position.index = 4
field_descriptors.StepRequest_position.label = 1
field_descriptors.StepRequest_position.has_default_value = false
field_descriptors.StepRequest_position.default_value = nil
field_descriptors.StepRequest_position.message_type = type_descriptors.CellNO
field_descriptors.StepRequest_position.type = 11
field_descriptors.StepRequest_position.cpp_type = 10
field_descriptors.StepRequest_strengthening.name = "strengthening"
field_descriptors.StepRequest_strengthening.full_name = ".StepRequest.strengthening"
field_descriptors.StepRequest_strengthening.number = 6
field_descriptors.StepRequest_strengthening.index = 5
field_descriptors.StepRequest_strengthening.label = 1
field_descriptors.StepRequest_strengthening.has_default_value = false
field_descriptors.StepRequest_strengthening.default_value = false
field_descriptors.StepRequest_strengthening.type = 8
field_descriptors.StepRequest_strengthening.cpp_type = 7
field_descriptors.StepRequest_lookAt.name = "lookAt"
field_descriptors.StepRequest_lookAt.full_name = ".StepRequest.lookAt"
field_descriptors.StepRequest_lookAt.number = 7
field_descriptors.StepRequest_lookAt.index = 6
field_descriptors.StepRequest_lookAt.label = 1
field_descriptors.StepRequest_lookAt.has_default_value = false
field_descriptors.StepRequest_lookAt.default_value = nil
field_descriptors.StepRequest_lookAt.message_type = type_descriptors.CellNO
field_descriptors.StepRequest_lookAt.type = 11
field_descriptors.StepRequest_lookAt.cpp_type = 10
type_descriptors.StepRequest.name = "StepRequest"
type_descriptors.StepRequest.full_name = ".StepRequest"
type_descriptors.StepRequest.nested_types = {}
type_descriptors.StepRequest.enum_types = {}
type_descriptors.StepRequest.fields = {
	field_descriptors.StepRequest_entity,
	field_descriptors.StepRequest_movement,
	field_descriptors.StepRequest_releasingSkill,
	field_descriptors.StepRequest_target,
	field_descriptors.StepRequest_position,
	field_descriptors.StepRequest_strengthening,
	field_descriptors.StepRequest_lookAt
}
type_descriptors.StepRequest.is_extendable = false
type_descriptors.StepRequest.extensions = {}
field_descriptors.LineNO_start.name = "start"
field_descriptors.LineNO_start.full_name = ".LineNO.start"
field_descriptors.LineNO_start.number = 1
field_descriptors.LineNO_start.index = 0
field_descriptors.LineNO_start.label = 1
field_descriptors.LineNO_start.has_default_value = false
field_descriptors.LineNO_start.default_value = nil
field_descriptors.LineNO_start.message_type = type_descriptors.CellNO
field_descriptors.LineNO_start.type = 11
field_descriptors.LineNO_start.cpp_type = 10
field_descriptors.LineNO_end.name = "end"
field_descriptors.LineNO_end.full_name = ".LineNO.end"
field_descriptors.LineNO_end.number = 2
field_descriptors.LineNO_end.index = 1
field_descriptors.LineNO_end.label = 1
field_descriptors.LineNO_end.has_default_value = false
field_descriptors.LineNO_end.default_value = nil
field_descriptors.LineNO_end.message_type = type_descriptors.CellNO
field_descriptors.LineNO_end.type = 11
field_descriptors.LineNO_end.cpp_type = 10
type_descriptors.LineNO.name = "LineNO"
type_descriptors.LineNO.full_name = ".LineNO"
type_descriptors.LineNO.nested_types = {}
type_descriptors.LineNO.enum_types = {}
type_descriptors.LineNO.fields = {
	field_descriptors.LineNO_start,
	field_descriptors.LineNO_end
}
type_descriptors.LineNO.is_extendable = false
type_descriptors.LineNO.extensions = {}
field_descriptors.EntityPlayerChangedEventNO_entity.name = "entity"
field_descriptors.EntityPlayerChangedEventNO_entity.full_name = ".EntityPlayerChangedEventNO.entity"
field_descriptors.EntityPlayerChangedEventNO_entity.number = 1
field_descriptors.EntityPlayerChangedEventNO_entity.index = 0
field_descriptors.EntityPlayerChangedEventNO_entity.label = 1
field_descriptors.EntityPlayerChangedEventNO_entity.has_default_value = false
field_descriptors.EntityPlayerChangedEventNO_entity.default_value = 0
field_descriptors.EntityPlayerChangedEventNO_entity.type = 5
field_descriptors.EntityPlayerChangedEventNO_entity.cpp_type = 1
field_descriptors.EntityPlayerChangedEventNO_player.name = "player"
field_descriptors.EntityPlayerChangedEventNO_player.full_name = ".EntityPlayerChangedEventNO.player"
field_descriptors.EntityPlayerChangedEventNO_player.number = 2
field_descriptors.EntityPlayerChangedEventNO_player.index = 1
field_descriptors.EntityPlayerChangedEventNO_player.label = 1
field_descriptors.EntityPlayerChangedEventNO_player.has_default_value = false
field_descriptors.EntityPlayerChangedEventNO_player.default_value = 0
field_descriptors.EntityPlayerChangedEventNO_player.type = 5
field_descriptors.EntityPlayerChangedEventNO_player.cpp_type = 1
field_descriptors.EntityPlayerChangedEventNO_battleCamp.name = "battleCamp"
field_descriptors.EntityPlayerChangedEventNO_battleCamp.full_name = ".EntityPlayerChangedEventNO.battleCamp"
field_descriptors.EntityPlayerChangedEventNO_battleCamp.number = 3
field_descriptors.EntityPlayerChangedEventNO_battleCamp.index = 2
field_descriptors.EntityPlayerChangedEventNO_battleCamp.label = 1
field_descriptors.EntityPlayerChangedEventNO_battleCamp.has_default_value = false
field_descriptors.EntityPlayerChangedEventNO_battleCamp.default_value = 0
field_descriptors.EntityPlayerChangedEventNO_battleCamp.type = 5
field_descriptors.EntityPlayerChangedEventNO_battleCamp.cpp_type = 1
field_descriptors.EntityPlayerChangedEventNO_reason.name = "reason"
field_descriptors.EntityPlayerChangedEventNO_reason.full_name = ".EntityPlayerChangedEventNO.reason"
field_descriptors.EntityPlayerChangedEventNO_reason.number = 4
field_descriptors.EntityPlayerChangedEventNO_reason.index = 3
field_descriptors.EntityPlayerChangedEventNO_reason.label = 1
field_descriptors.EntityPlayerChangedEventNO_reason.has_default_value = false
field_descriptors.EntityPlayerChangedEventNO_reason.default_value = nil
field_descriptors.EntityPlayerChangedEventNO_reason.enum_type = type_descriptors.PlayerChangeReason
field_descriptors.EntityPlayerChangedEventNO_reason.type = 14
field_descriptors.EntityPlayerChangedEventNO_reason.cpp_type = 8
type_descriptors.EntityPlayerChangedEventNO.name = "EntityPlayerChangedEventNO"
type_descriptors.EntityPlayerChangedEventNO.full_name = ".EntityPlayerChangedEventNO"
type_descriptors.EntityPlayerChangedEventNO.nested_types = {}
type_descriptors.EntityPlayerChangedEventNO.enum_types = {}
type_descriptors.EntityPlayerChangedEventNO.fields = {
	field_descriptors.EntityPlayerChangedEventNO_entity,
	field_descriptors.EntityPlayerChangedEventNO_player,
	field_descriptors.EntityPlayerChangedEventNO_battleCamp,
	field_descriptors.EntityPlayerChangedEventNO_reason
}
type_descriptors.EntityPlayerChangedEventNO.is_extendable = false
type_descriptors.EntityPlayerChangedEventNO.extensions = {}
field_descriptors.ImmuneBuffAddNO_entity.name = "entity"
field_descriptors.ImmuneBuffAddNO_entity.full_name = ".ImmuneBuffAddNO.entity"
field_descriptors.ImmuneBuffAddNO_entity.number = 1
field_descriptors.ImmuneBuffAddNO_entity.index = 0
field_descriptors.ImmuneBuffAddNO_entity.label = 1
field_descriptors.ImmuneBuffAddNO_entity.has_default_value = false
field_descriptors.ImmuneBuffAddNO_entity.default_value = 0
field_descriptors.ImmuneBuffAddNO_entity.type = 5
field_descriptors.ImmuneBuffAddNO_entity.cpp_type = 1
field_descriptors.ImmuneBuffAddNO_buffs.name = "buffs"
field_descriptors.ImmuneBuffAddNO_buffs.full_name = ".ImmuneBuffAddNO.buffs"
field_descriptors.ImmuneBuffAddNO_buffs.number = 2
field_descriptors.ImmuneBuffAddNO_buffs.index = 1
field_descriptors.ImmuneBuffAddNO_buffs.label = 3
field_descriptors.ImmuneBuffAddNO_buffs.has_default_value = false
field_descriptors.ImmuneBuffAddNO_buffs.default_value = {}
field_descriptors.ImmuneBuffAddNO_buffs.type = 5
field_descriptors.ImmuneBuffAddNO_buffs.cpp_type = 1
type_descriptors.ImmuneBuffAddNO.name = "ImmuneBuffAddNO"
type_descriptors.ImmuneBuffAddNO.full_name = ".ImmuneBuffAddNO"
type_descriptors.ImmuneBuffAddNO.nested_types = {}
type_descriptors.ImmuneBuffAddNO.enum_types = {}
type_descriptors.ImmuneBuffAddNO.fields = {
	field_descriptors.ImmuneBuffAddNO_entity,
	field_descriptors.ImmuneBuffAddNO_buffs
}
type_descriptors.ImmuneBuffAddNO.is_extendable = false
type_descriptors.ImmuneBuffAddNO.extensions = {}
type_descriptors.StepReply.name = "StepReply"
type_descriptors.StepReply.full_name = ".StepReply"
type_descriptors.StepReply.nested_types = {}
type_descriptors.StepReply.enum_types = {}
type_descriptors.StepReply.fields = {}
type_descriptors.StepReply.is_extendable = false
type_descriptors.StepReply.extensions = {}
type_descriptors.DisconnectRequest.name = "DisconnectRequest"
type_descriptors.DisconnectRequest.full_name = ".DisconnectRequest"
type_descriptors.DisconnectRequest.nested_types = {}
type_descriptors.DisconnectRequest.enum_types = {}
type_descriptors.DisconnectRequest.fields = {}
type_descriptors.DisconnectRequest.is_extendable = false
type_descriptors.DisconnectRequest.extensions = {}
type_descriptors.EndReadyRequest.name = "EndReadyRequest"
type_descriptors.EndReadyRequest.full_name = ".EndReadyRequest"
type_descriptors.EndReadyRequest.nested_types = {}
type_descriptors.EndReadyRequest.enum_types = {}
type_descriptors.EndReadyRequest.fields = {}
type_descriptors.EndReadyRequest.is_extendable = false
type_descriptors.EndReadyRequest.extensions = {}
field_descriptors.SkillNO_code.name = "code"
field_descriptors.SkillNO_code.full_name = ".SkillNO.code"
field_descriptors.SkillNO_code.number = 1
field_descriptors.SkillNO_code.index = 0
field_descriptors.SkillNO_code.label = 1
field_descriptors.SkillNO_code.has_default_value = false
field_descriptors.SkillNO_code.default_value = 0
field_descriptors.SkillNO_code.type = 5
field_descriptors.SkillNO_code.cpp_type = 1
field_descriptors.SkillNO_enhanced.name = "enhanced"
field_descriptors.SkillNO_enhanced.full_name = ".SkillNO.enhanced"
field_descriptors.SkillNO_enhanced.number = 2
field_descriptors.SkillNO_enhanced.index = 1
field_descriptors.SkillNO_enhanced.label = 3
field_descriptors.SkillNO_enhanced.has_default_value = false
field_descriptors.SkillNO_enhanced.default_value = {}
field_descriptors.SkillNO_enhanced.type = 5
field_descriptors.SkillNO_enhanced.cpp_type = 1
field_descriptors.SkillNO_source.name = "source"
field_descriptors.SkillNO_source.full_name = ".SkillNO.source"
field_descriptors.SkillNO_source.number = 3
field_descriptors.SkillNO_source.index = 2
field_descriptors.SkillNO_source.label = 1
field_descriptors.SkillNO_source.has_default_value = false
field_descriptors.SkillNO_source.default_value = nil
field_descriptors.SkillNO_source.message_type = type_descriptors.SkillSourceNO
field_descriptors.SkillNO_source.type = 11
field_descriptors.SkillNO_source.cpp_type = 10
field_descriptors.SkillNO_cd.name = "cd"
field_descriptors.SkillNO_cd.full_name = ".SkillNO.cd"
field_descriptors.SkillNO_cd.number = 4
field_descriptors.SkillNO_cd.index = 3
field_descriptors.SkillNO_cd.label = 1
field_descriptors.SkillNO_cd.has_default_value = false
field_descriptors.SkillNO_cd.default_value = 0
field_descriptors.SkillNO_cd.type = 5
field_descriptors.SkillNO_cd.cpp_type = 1
type_descriptors.SkillNO.name = "SkillNO"
type_descriptors.SkillNO.full_name = ".SkillNO"
type_descriptors.SkillNO.nested_types = {}
type_descriptors.SkillNO.enum_types = {}
type_descriptors.SkillNO.fields = {
	field_descriptors.SkillNO_code,
	field_descriptors.SkillNO_enhanced,
	field_descriptors.SkillNO_source,
	field_descriptors.SkillNO_cd
}
type_descriptors.SkillNO.is_extendable = false
type_descriptors.SkillNO.extensions = {}
field_descriptors.BattleInfoNO_type.name = "type"
field_descriptors.BattleInfoNO_type.full_name = ".BattleInfoNO.type"
field_descriptors.BattleInfoNO_type.number = 1
field_descriptors.BattleInfoNO_type.index = 0
field_descriptors.BattleInfoNO_type.label = 1
field_descriptors.BattleInfoNO_type.has_default_value = false
field_descriptors.BattleInfoNO_type.default_value = nil
field_descriptors.BattleInfoNO_type.enum_type = type_descriptors.BattleType
field_descriptors.BattleInfoNO_type.type = 14
field_descriptors.BattleInfoNO_type.cpp_type = 8
field_descriptors.BattleInfoNO_battlefield.name = "battlefield"
field_descriptors.BattleInfoNO_battlefield.full_name = ".BattleInfoNO.battlefield"
field_descriptors.BattleInfoNO_battlefield.number = 2
field_descriptors.BattleInfoNO_battlefield.index = 1
field_descriptors.BattleInfoNO_battlefield.label = 1
field_descriptors.BattleInfoNO_battlefield.has_default_value = false
field_descriptors.BattleInfoNO_battlefield.default_value = nil
field_descriptors.BattleInfoNO_battlefield.message_type = type_descriptors.BattlefieldNO
field_descriptors.BattleInfoNO_battlefield.type = 11
field_descriptors.BattleInfoNO_battlefield.cpp_type = 10
field_descriptors.BattleInfoNO_passId.name = "passId"
field_descriptors.BattleInfoNO_passId.full_name = ".BattleInfoNO.passId"
field_descriptors.BattleInfoNO_passId.number = 3
field_descriptors.BattleInfoNO_passId.index = 2
field_descriptors.BattleInfoNO_passId.label = 1
field_descriptors.BattleInfoNO_passId.has_default_value = false
field_descriptors.BattleInfoNO_passId.default_value = 0
field_descriptors.BattleInfoNO_passId.type = 5
field_descriptors.BattleInfoNO_passId.cpp_type = 1
field_descriptors.BattleInfoNO_levelId.name = "levelId"
field_descriptors.BattleInfoNO_levelId.full_name = ".BattleInfoNO.levelId"
field_descriptors.BattleInfoNO_levelId.number = 4
field_descriptors.BattleInfoNO_levelId.index = 3
field_descriptors.BattleInfoNO_levelId.label = 1
field_descriptors.BattleInfoNO_levelId.has_default_value = false
field_descriptors.BattleInfoNO_levelId.default_value = 0
field_descriptors.BattleInfoNO_levelId.type = 5
field_descriptors.BattleInfoNO_levelId.cpp_type = 1
field_descriptors.BattleInfoNO_map.name = "map"
field_descriptors.BattleInfoNO_map.full_name = ".BattleInfoNO.map"
field_descriptors.BattleInfoNO_map.number = 5
field_descriptors.BattleInfoNO_map.index = 4
field_descriptors.BattleInfoNO_map.label = 1
field_descriptors.BattleInfoNO_map.has_default_value = false
field_descriptors.BattleInfoNO_map.default_value = nil
field_descriptors.BattleInfoNO_map.message_type = type_descriptors.AirMapInfoNO
field_descriptors.BattleInfoNO_map.type = 11
field_descriptors.BattleInfoNO_map.cpp_type = 10
field_descriptors.BattleInfoNO_mapId.name = "mapId"
field_descriptors.BattleInfoNO_mapId.full_name = ".BattleInfoNO.mapId"
field_descriptors.BattleInfoNO_mapId.number = 6
field_descriptors.BattleInfoNO_mapId.index = 5
field_descriptors.BattleInfoNO_mapId.label = 1
field_descriptors.BattleInfoNO_mapId.has_default_value = false
field_descriptors.BattleInfoNO_mapId.default_value = 0
field_descriptors.BattleInfoNO_mapId.type = 3
field_descriptors.BattleInfoNO_mapId.cpp_type = 2
field_descriptors.BattleInfoNO_pvpType.name = "pvpType"
field_descriptors.BattleInfoNO_pvpType.full_name = ".BattleInfoNO.pvpType"
field_descriptors.BattleInfoNO_pvpType.number = 7
field_descriptors.BattleInfoNO_pvpType.index = 6
field_descriptors.BattleInfoNO_pvpType.label = 1
field_descriptors.BattleInfoNO_pvpType.has_default_value = false
field_descriptors.BattleInfoNO_pvpType.default_value = nil
field_descriptors.BattleInfoNO_pvpType.enum_type = type_descriptors.GameType
field_descriptors.BattleInfoNO_pvpType.type = 14
field_descriptors.BattleInfoNO_pvpType.cpp_type = 8
field_descriptors.BattleInfoNO_players.name = "players"
field_descriptors.BattleInfoNO_players.full_name = ".BattleInfoNO.players"
field_descriptors.BattleInfoNO_players.number = 8
field_descriptors.BattleInfoNO_players.index = 7
field_descriptors.BattleInfoNO_players.label = 3
field_descriptors.BattleInfoNO_players.has_default_value = false
field_descriptors.BattleInfoNO_players.default_value = {}
field_descriptors.BattleInfoNO_players.message_type = type_descriptors.PvpPlayerNO
field_descriptors.BattleInfoNO_players.type = 11
field_descriptors.BattleInfoNO_players.cpp_type = 10
field_descriptors.BattleInfoNO_startTime.name = "startTime"
field_descriptors.BattleInfoNO_startTime.full_name = ".BattleInfoNO.startTime"
field_descriptors.BattleInfoNO_startTime.number = 9
field_descriptors.BattleInfoNO_startTime.index = 8
field_descriptors.BattleInfoNO_startTime.label = 1
field_descriptors.BattleInfoNO_startTime.has_default_value = false
field_descriptors.BattleInfoNO_startTime.default_value = 0
field_descriptors.BattleInfoNO_startTime.type = 3
field_descriptors.BattleInfoNO_startTime.cpp_type = 2
field_descriptors.BattleInfoNO_multiplied.name = "multiplied"
field_descriptors.BattleInfoNO_multiplied.full_name = ".BattleInfoNO.multiplied"
field_descriptors.BattleInfoNO_multiplied.number = 10
field_descriptors.BattleInfoNO_multiplied.index = 9
field_descriptors.BattleInfoNO_multiplied.label = 1
field_descriptors.BattleInfoNO_multiplied.has_default_value = false
field_descriptors.BattleInfoNO_multiplied.default_value = 0
field_descriptors.BattleInfoNO_multiplied.type = 5
field_descriptors.BattleInfoNO_multiplied.cpp_type = 1
field_descriptors.BattleInfoNO_gameplay.name = "gameplay"
field_descriptors.BattleInfoNO_gameplay.full_name = ".BattleInfoNO.gameplay"
field_descriptors.BattleInfoNO_gameplay.number = 11
field_descriptors.BattleInfoNO_gameplay.index = 10
field_descriptors.BattleInfoNO_gameplay.label = 1
field_descriptors.BattleInfoNO_gameplay.has_default_value = false
field_descriptors.BattleInfoNO_gameplay.default_value = nil
field_descriptors.BattleInfoNO_gameplay.enum_type = type_descriptors.Gameplay
field_descriptors.BattleInfoNO_gameplay.type = 14
field_descriptors.BattleInfoNO_gameplay.cpp_type = 8
type_descriptors.BattleInfoNO.name = "BattleInfoNO"
type_descriptors.BattleInfoNO.full_name = ".BattleInfoNO"
type_descriptors.BattleInfoNO.nested_types = {}
type_descriptors.BattleInfoNO.enum_types = {}
type_descriptors.BattleInfoNO.fields = {
	field_descriptors.BattleInfoNO_type,
	field_descriptors.BattleInfoNO_battlefield,
	field_descriptors.BattleInfoNO_passId,
	field_descriptors.BattleInfoNO_levelId,
	field_descriptors.BattleInfoNO_map,
	field_descriptors.BattleInfoNO_mapId,
	field_descriptors.BattleInfoNO_pvpType,
	field_descriptors.BattleInfoNO_players,
	field_descriptors.BattleInfoNO_startTime,
	field_descriptors.BattleInfoNO_multiplied,
	field_descriptors.BattleInfoNO_gameplay
}
type_descriptors.BattleInfoNO.is_extendable = false
type_descriptors.BattleInfoNO.extensions = {}
field_descriptors.OnEventTriggeredPush_endReason.name = "endReason"
field_descriptors.OnEventTriggeredPush_endReason.full_name = ".OnEventTriggeredPush.endReason"
field_descriptors.OnEventTriggeredPush_endReason.number = 1
field_descriptors.OnEventTriggeredPush_endReason.index = 0
field_descriptors.OnEventTriggeredPush_endReason.label = 1
field_descriptors.OnEventTriggeredPush_endReason.has_default_value = false
field_descriptors.OnEventTriggeredPush_endReason.default_value = ""
field_descriptors.OnEventTriggeredPush_endReason.type = 9
field_descriptors.OnEventTriggeredPush_endReason.cpp_type = 9
field_descriptors.OnEventTriggeredPush_events.name = "events"
field_descriptors.OnEventTriggeredPush_events.full_name = ".OnEventTriggeredPush.events"
field_descriptors.OnEventTriggeredPush_events.number = 2
field_descriptors.OnEventTriggeredPush_events.index = 1
field_descriptors.OnEventTriggeredPush_events.label = 3
field_descriptors.OnEventTriggeredPush_events.has_default_value = false
field_descriptors.OnEventTriggeredPush_events.default_value = {}
field_descriptors.OnEventTriggeredPush_events.message_type = type_descriptors.EventNO
field_descriptors.OnEventTriggeredPush_events.type = 11
field_descriptors.OnEventTriggeredPush_events.cpp_type = 10
type_descriptors.OnEventTriggeredPush.name = "OnEventTriggeredPush"
type_descriptors.OnEventTriggeredPush.full_name = ".OnEventTriggeredPush"
type_descriptors.OnEventTriggeredPush.nested_types = {}
type_descriptors.OnEventTriggeredPush.enum_types = {}
type_descriptors.OnEventTriggeredPush.fields = {
	field_descriptors.OnEventTriggeredPush_endReason,
	field_descriptors.OnEventTriggeredPush_events
}
type_descriptors.OnEventTriggeredPush.is_extendable = false
type_descriptors.OnEventTriggeredPush.extensions = {}
field_descriptors.MoonRingTagNO_shape.name = "shape"
field_descriptors.MoonRingTagNO_shape.full_name = ".MoonRingTagNO.shape"
field_descriptors.MoonRingTagNO_shape.number = 1
field_descriptors.MoonRingTagNO_shape.index = 0
field_descriptors.MoonRingTagNO_shape.label = 1
field_descriptors.MoonRingTagNO_shape.has_default_value = false
field_descriptors.MoonRingTagNO_shape.default_value = nil
field_descriptors.MoonRingTagNO_shape.message_type = type_descriptors.ShapeNO
field_descriptors.MoonRingTagNO_shape.type = 11
field_descriptors.MoonRingTagNO_shape.cpp_type = 10
type_descriptors.MoonRingTagNO.name = "MoonRingTagNO"
type_descriptors.MoonRingTagNO.full_name = ".MoonRingTagNO"
type_descriptors.MoonRingTagNO.nested_types = {}
type_descriptors.MoonRingTagNO.enum_types = {}
type_descriptors.MoonRingTagNO.fields = {
	field_descriptors.MoonRingTagNO_shape
}
type_descriptors.MoonRingTagNO.is_extendable = false
type_descriptors.MoonRingTagNO.extensions = {}
field_descriptors.AssistTagNO_shape.name = "shape"
field_descriptors.AssistTagNO_shape.full_name = ".AssistTagNO.shape"
field_descriptors.AssistTagNO_shape.number = 1
field_descriptors.AssistTagNO_shape.index = 0
field_descriptors.AssistTagNO_shape.label = 1
field_descriptors.AssistTagNO_shape.has_default_value = false
field_descriptors.AssistTagNO_shape.default_value = nil
field_descriptors.AssistTagNO_shape.message_type = type_descriptors.ShapeNO
field_descriptors.AssistTagNO_shape.type = 11
field_descriptors.AssistTagNO_shape.cpp_type = 10
type_descriptors.AssistTagNO.name = "AssistTagNO"
type_descriptors.AssistTagNO.full_name = ".AssistTagNO"
type_descriptors.AssistTagNO.nested_types = {}
type_descriptors.AssistTagNO.enum_types = {}
type_descriptors.AssistTagNO.fields = {
	field_descriptors.AssistTagNO_shape
}
type_descriptors.AssistTagNO.is_extendable = false
type_descriptors.AssistTagNO.extensions = {}
field_descriptors.SheetMusicNO_sheetMusicCode.name = "sheetMusicCode"
field_descriptors.SheetMusicNO_sheetMusicCode.full_name = ".SheetMusicNO.sheetMusicCode"
field_descriptors.SheetMusicNO_sheetMusicCode.number = 1
field_descriptors.SheetMusicNO_sheetMusicCode.index = 0
field_descriptors.SheetMusicNO_sheetMusicCode.label = 2
field_descriptors.SheetMusicNO_sheetMusicCode.has_default_value = false
field_descriptors.SheetMusicNO_sheetMusicCode.default_value = 0
field_descriptors.SheetMusicNO_sheetMusicCode.type = 5
field_descriptors.SheetMusicNO_sheetMusicCode.cpp_type = 1
field_descriptors.SheetMusicNO_entity.name = "entity"
field_descriptors.SheetMusicNO_entity.full_name = ".SheetMusicNO.entity"
field_descriptors.SheetMusicNO_entity.number = 2
field_descriptors.SheetMusicNO_entity.index = 1
field_descriptors.SheetMusicNO_entity.label = 2
field_descriptors.SheetMusicNO_entity.has_default_value = false
field_descriptors.SheetMusicNO_entity.default_value = 0
field_descriptors.SheetMusicNO_entity.type = 5
field_descriptors.SheetMusicNO_entity.cpp_type = 1
field_descriptors.SheetMusicNO_skill.name = "skill"
field_descriptors.SheetMusicNO_skill.full_name = ".SheetMusicNO.skill"
field_descriptors.SheetMusicNO_skill.number = 3
field_descriptors.SheetMusicNO_skill.index = 2
field_descriptors.SheetMusicNO_skill.label = 2
field_descriptors.SheetMusicNO_skill.has_default_value = false
field_descriptors.SheetMusicNO_skill.default_value = 0
field_descriptors.SheetMusicNO_skill.type = 5
field_descriptors.SheetMusicNO_skill.cpp_type = 1
field_descriptors.SheetMusicNO_notes.name = "notes"
field_descriptors.SheetMusicNO_notes.full_name = ".SheetMusicNO.notes"
field_descriptors.SheetMusicNO_notes.number = 4
field_descriptors.SheetMusicNO_notes.index = 3
field_descriptors.SheetMusicNO_notes.label = 3
field_descriptors.SheetMusicNO_notes.has_default_value = false
field_descriptors.SheetMusicNO_notes.default_value = {}
field_descriptors.SheetMusicNO_notes.message_type = type_descriptors.NoteCellNO
field_descriptors.SheetMusicNO_notes.type = 11
field_descriptors.SheetMusicNO_notes.cpp_type = 10
type_descriptors.SheetMusicNO.name = "SheetMusicNO"
type_descriptors.SheetMusicNO.full_name = ".SheetMusicNO"
type_descriptors.SheetMusicNO.nested_types = {}
type_descriptors.SheetMusicNO.enum_types = {}
type_descriptors.SheetMusicNO.fields = {
	field_descriptors.SheetMusicNO_sheetMusicCode,
	field_descriptors.SheetMusicNO_entity,
	field_descriptors.SheetMusicNO_skill,
	field_descriptors.SheetMusicNO_notes
}
type_descriptors.SheetMusicNO.is_extendable = false
type_descriptors.SheetMusicNO.extensions = {}
field_descriptors.EntityConfigChangedEventNO_id.name = "id"
field_descriptors.EntityConfigChangedEventNO_id.full_name = ".EntityConfigChangedEventNO.id"
field_descriptors.EntityConfigChangedEventNO_id.number = 1
field_descriptors.EntityConfigChangedEventNO_id.index = 0
field_descriptors.EntityConfigChangedEventNO_id.label = 1
field_descriptors.EntityConfigChangedEventNO_id.has_default_value = false
field_descriptors.EntityConfigChangedEventNO_id.default_value = 0
field_descriptors.EntityConfigChangedEventNO_id.type = 5
field_descriptors.EntityConfigChangedEventNO_id.cpp_type = 1
field_descriptors.EntityConfigChangedEventNO_career.name = "career"
field_descriptors.EntityConfigChangedEventNO_career.full_name = ".EntityConfigChangedEventNO.career"
field_descriptors.EntityConfigChangedEventNO_career.number = 2
field_descriptors.EntityConfigChangedEventNO_career.index = 1
field_descriptors.EntityConfigChangedEventNO_career.label = 1
field_descriptors.EntityConfigChangedEventNO_career.has_default_value = false
field_descriptors.EntityConfigChangedEventNO_career.default_value = 0
field_descriptors.EntityConfigChangedEventNO_career.type = 5
field_descriptors.EntityConfigChangedEventNO_career.cpp_type = 1
field_descriptors.EntityConfigChangedEventNO_color.name = "color"
field_descriptors.EntityConfigChangedEventNO_color.full_name = ".EntityConfigChangedEventNO.color"
field_descriptors.EntityConfigChangedEventNO_color.number = 3
field_descriptors.EntityConfigChangedEventNO_color.index = 2
field_descriptors.EntityConfigChangedEventNO_color.label = 1
field_descriptors.EntityConfigChangedEventNO_color.has_default_value = false
field_descriptors.EntityConfigChangedEventNO_color.default_value = 0
field_descriptors.EntityConfigChangedEventNO_color.type = 5
field_descriptors.EntityConfigChangedEventNO_color.cpp_type = 1
field_descriptors.EntityConfigChangedEventNO_camp.name = "camp"
field_descriptors.EntityConfigChangedEventNO_camp.full_name = ".EntityConfigChangedEventNO.camp"
field_descriptors.EntityConfigChangedEventNO_camp.number = 4
field_descriptors.EntityConfigChangedEventNO_camp.index = 3
field_descriptors.EntityConfigChangedEventNO_camp.label = 1
field_descriptors.EntityConfigChangedEventNO_camp.has_default_value = false
field_descriptors.EntityConfigChangedEventNO_camp.default_value = 0
field_descriptors.EntityConfigChangedEventNO_camp.type = 5
field_descriptors.EntityConfigChangedEventNO_camp.cpp_type = 1
field_descriptors.EntityConfigChangedEventNO_monsterType.name = "monsterType"
field_descriptors.EntityConfigChangedEventNO_monsterType.full_name = ".EntityConfigChangedEventNO.monsterType"
field_descriptors.EntityConfigChangedEventNO_monsterType.number = 5
field_descriptors.EntityConfigChangedEventNO_monsterType.index = 4
field_descriptors.EntityConfigChangedEventNO_monsterType.label = 1
field_descriptors.EntityConfigChangedEventNO_monsterType.has_default_value = false
field_descriptors.EntityConfigChangedEventNO_monsterType.default_value = nil
field_descriptors.EntityConfigChangedEventNO_monsterType.enum_type = type_descriptors.MonsterType
field_descriptors.EntityConfigChangedEventNO_monsterType.type = 14
field_descriptors.EntityConfigChangedEventNO_monsterType.cpp_type = 8
type_descriptors.EntityConfigChangedEventNO.name = "EntityConfigChangedEventNO"
type_descriptors.EntityConfigChangedEventNO.full_name = ".EntityConfigChangedEventNO"
type_descriptors.EntityConfigChangedEventNO.nested_types = {}
type_descriptors.EntityConfigChangedEventNO.enum_types = {}
type_descriptors.EntityConfigChangedEventNO.fields = {
	field_descriptors.EntityConfigChangedEventNO_id,
	field_descriptors.EntityConfigChangedEventNO_career,
	field_descriptors.EntityConfigChangedEventNO_color,
	field_descriptors.EntityConfigChangedEventNO_camp,
	field_descriptors.EntityConfigChangedEventNO_monsterType
}
type_descriptors.EntityConfigChangedEventNO.is_extendable = false
type_descriptors.EntityConfigChangedEventNO.extensions = {}
field_descriptors.BornCellNO_cell.name = "cell"
field_descriptors.BornCellNO_cell.full_name = ".BornCellNO.cell"
field_descriptors.BornCellNO_cell.number = 1
field_descriptors.BornCellNO_cell.index = 0
field_descriptors.BornCellNO_cell.label = 2
field_descriptors.BornCellNO_cell.has_default_value = false
field_descriptors.BornCellNO_cell.default_value = nil
field_descriptors.BornCellNO_cell.message_type = type_descriptors.CellNO
field_descriptors.BornCellNO_cell.type = 11
field_descriptors.BornCellNO_cell.cpp_type = 10
field_descriptors.BornCellNO_direction.name = "direction"
field_descriptors.BornCellNO_direction.full_name = ".BornCellNO.direction"
field_descriptors.BornCellNO_direction.number = 2
field_descriptors.BornCellNO_direction.index = 1
field_descriptors.BornCellNO_direction.label = 2
field_descriptors.BornCellNO_direction.has_default_value = false
field_descriptors.BornCellNO_direction.default_value = 0
field_descriptors.BornCellNO_direction.type = 5
field_descriptors.BornCellNO_direction.cpp_type = 1
type_descriptors.BornCellNO.name = "BornCellNO"
type_descriptors.BornCellNO.full_name = ".BornCellNO"
type_descriptors.BornCellNO.nested_types = {}
type_descriptors.BornCellNO.enum_types = {}
type_descriptors.BornCellNO.fields = {
	field_descriptors.BornCellNO_cell,
	field_descriptors.BornCellNO_direction
}
type_descriptors.BornCellNO.is_extendable = false
type_descriptors.BornCellNO.extensions = {}
field_descriptors.EntityNO_id.name = "id"
field_descriptors.EntityNO_id.full_name = ".EntityNO.id"
field_descriptors.EntityNO_id.number = 1
field_descriptors.EntityNO_id.index = 0
field_descriptors.EntityNO_id.label = 1
field_descriptors.EntityNO_id.has_default_value = false
field_descriptors.EntityNO_id.default_value = 0
field_descriptors.EntityNO_id.type = 5
field_descriptors.EntityNO_id.cpp_type = 1
field_descriptors.EntityNO_code.name = "code"
field_descriptors.EntityNO_code.full_name = ".EntityNO.code"
field_descriptors.EntityNO_code.number = 2
field_descriptors.EntityNO_code.index = 1
field_descriptors.EntityNO_code.label = 1
field_descriptors.EntityNO_code.has_default_value = false
field_descriptors.EntityNO_code.default_value = 0
field_descriptors.EntityNO_code.type = 5
field_descriptors.EntityNO_code.cpp_type = 1
field_descriptors.EntityNO_player.name = "player"
field_descriptors.EntityNO_player.full_name = ".EntityNO.player"
field_descriptors.EntityNO_player.number = 3
field_descriptors.EntityNO_player.index = 2
field_descriptors.EntityNO_player.label = 1
field_descriptors.EntityNO_player.has_default_value = false
field_descriptors.EntityNO_player.default_value = 0
field_descriptors.EntityNO_player.type = 5
field_descriptors.EntityNO_player.cpp_type = 1
field_descriptors.EntityNO_attributes.name = "attributes"
field_descriptors.EntityNO_attributes.full_name = ".EntityNO.attributes"
field_descriptors.EntityNO_attributes.number = 4
field_descriptors.EntityNO_attributes.index = 3
field_descriptors.EntityNO_attributes.label = 3
field_descriptors.EntityNO_attributes.has_default_value = false
field_descriptors.EntityNO_attributes.default_value = {}
field_descriptors.EntityNO_attributes.message_type = type_descriptors.AttributeNO
field_descriptors.EntityNO_attributes.type = 11
field_descriptors.EntityNO_attributes.cpp_type = 10
field_descriptors.EntityNO_cell.name = "cell"
field_descriptors.EntityNO_cell.full_name = ".EntityNO.cell"
field_descriptors.EntityNO_cell.number = 5
field_descriptors.EntityNO_cell.index = 4
field_descriptors.EntityNO_cell.label = 1
field_descriptors.EntityNO_cell.has_default_value = false
field_descriptors.EntityNO_cell.default_value = nil
field_descriptors.EntityNO_cell.message_type = type_descriptors.CellNO
field_descriptors.EntityNO_cell.type = 11
field_descriptors.EntityNO_cell.cpp_type = 10
field_descriptors.EntityNO_level.name = "level"
field_descriptors.EntityNO_level.full_name = ".EntityNO.level"
field_descriptors.EntityNO_level.number = 7
field_descriptors.EntityNO_level.index = 5
field_descriptors.EntityNO_level.label = 1
field_descriptors.EntityNO_level.has_default_value = false
field_descriptors.EntityNO_level.default_value = 0
field_descriptors.EntityNO_level.type = 5
field_descriptors.EntityNO_level.cpp_type = 1
field_descriptors.EntityNO_tags.name = "tags"
field_descriptors.EntityNO_tags.full_name = ".EntityNO.tags"
field_descriptors.EntityNO_tags.number = 8
field_descriptors.EntityNO_tags.index = 6
field_descriptors.EntityNO_tags.label = 3
field_descriptors.EntityNO_tags.has_default_value = false
field_descriptors.EntityNO_tags.default_value = {}
field_descriptors.EntityNO_tags.type = 9
field_descriptors.EntityNO_tags.cpp_type = 9
field_descriptors.EntityNO_skills.name = "skills"
field_descriptors.EntityNO_skills.full_name = ".EntityNO.skills"
field_descriptors.EntityNO_skills.number = 9
field_descriptors.EntityNO_skills.index = 7
field_descriptors.EntityNO_skills.label = 3
field_descriptors.EntityNO_skills.has_default_value = false
field_descriptors.EntityNO_skills.default_value = {}
field_descriptors.EntityNO_skills.message_type = type_descriptors.SkillNO
field_descriptors.EntityNO_skills.type = 11
field_descriptors.EntityNO_skills.cpp_type = 10
field_descriptors.EntityNO_buffs.name = "buffs"
field_descriptors.EntityNO_buffs.full_name = ".EntityNO.buffs"
field_descriptors.EntityNO_buffs.number = 10
field_descriptors.EntityNO_buffs.index = 8
field_descriptors.EntityNO_buffs.label = 3
field_descriptors.EntityNO_buffs.has_default_value = false
field_descriptors.EntityNO_buffs.default_value = {}
field_descriptors.EntityNO_buffs.message_type = type_descriptors.BuffAddedEventNO
field_descriptors.EntityNO_buffs.type = 11
field_descriptors.EntityNO_buffs.cpp_type = 10
field_descriptors.EntityNO_state.name = "state"
field_descriptors.EntityNO_state.full_name = ".EntityNO.state"
field_descriptors.EntityNO_state.number = 11
field_descriptors.EntityNO_state.index = 9
field_descriptors.EntityNO_state.label = 3
field_descriptors.EntityNO_state.has_default_value = false
field_descriptors.EntityNO_state.default_value = {}
field_descriptors.EntityNO_state.enum_type = type_descriptors.State
field_descriptors.EntityNO_state.type = 14
field_descriptors.EntityNO_state.cpp_type = 8
field_descriptors.EntityNO_viewCode.name = "viewCode"
field_descriptors.EntityNO_viewCode.full_name = ".EntityNO.viewCode"
field_descriptors.EntityNO_viewCode.number = 12
field_descriptors.EntityNO_viewCode.index = 10
field_descriptors.EntityNO_viewCode.label = 1
field_descriptors.EntityNO_viewCode.has_default_value = false
field_descriptors.EntityNO_viewCode.default_value = 0
field_descriptors.EntityNO_viewCode.type = 5
field_descriptors.EntityNO_viewCode.cpp_type = 1
field_descriptors.EntityNO_extra.name = "extra"
field_descriptors.EntityNO_extra.full_name = ".EntityNO.extra"
field_descriptors.EntityNO_extra.number = 13
field_descriptors.EntityNO_extra.index = 11
field_descriptors.EntityNO_extra.label = 1
field_descriptors.EntityNO_extra.has_default_value = false
field_descriptors.EntityNO_extra.default_value = nil
field_descriptors.EntityNO_extra.message_type = type_descriptors.ExtraNO
field_descriptors.EntityNO_extra.type = 11
field_descriptors.EntityNO_extra.cpp_type = 10
field_descriptors.EntityNO_weakPointType.name = "weakPointType"
field_descriptors.EntityNO_weakPointType.full_name = ".EntityNO.weakPointType"
field_descriptors.EntityNO_weakPointType.number = 14
field_descriptors.EntityNO_weakPointType.index = 12
field_descriptors.EntityNO_weakPointType.label = 1
field_descriptors.EntityNO_weakPointType.has_default_value = false
field_descriptors.EntityNO_weakPointType.default_value = 0
field_descriptors.EntityNO_weakPointType.type = 5
field_descriptors.EntityNO_weakPointType.cpp_type = 1
field_descriptors.EntityNO_maxWeakPointHp.name = "maxWeakPointHp"
field_descriptors.EntityNO_maxWeakPointHp.full_name = ".EntityNO.maxWeakPointHp"
field_descriptors.EntityNO_maxWeakPointHp.number = 15
field_descriptors.EntityNO_maxWeakPointHp.index = 13
field_descriptors.EntityNO_maxWeakPointHp.label = 1
field_descriptors.EntityNO_maxWeakPointHp.has_default_value = false
field_descriptors.EntityNO_maxWeakPointHp.default_value = 0
field_descriptors.EntityNO_maxWeakPointHp.type = 5
field_descriptors.EntityNO_maxWeakPointHp.cpp_type = 1
field_descriptors.EntityNO_weakPointHp.name = "weakPointHp"
field_descriptors.EntityNO_weakPointHp.full_name = ".EntityNO.weakPointHp"
field_descriptors.EntityNO_weakPointHp.number = 16
field_descriptors.EntityNO_weakPointHp.index = 14
field_descriptors.EntityNO_weakPointHp.label = 1
field_descriptors.EntityNO_weakPointHp.has_default_value = false
field_descriptors.EntityNO_weakPointHp.default_value = 0
field_descriptors.EntityNO_weakPointHp.type = 5
field_descriptors.EntityNO_weakPointHp.cpp_type = 1
field_descriptors.EntityNO_type.name = "type"
field_descriptors.EntityNO_type.full_name = ".EntityNO.type"
field_descriptors.EntityNO_type.number = 17
field_descriptors.EntityNO_type.index = 15
field_descriptors.EntityNO_type.label = 1
field_descriptors.EntityNO_type.has_default_value = false
field_descriptors.EntityNO_type.default_value = nil
field_descriptors.EntityNO_type.enum_type = type_descriptors.EntityType
field_descriptors.EntityNO_type.type = 14
field_descriptors.EntityNO_type.cpp_type = 8
field_descriptors.EntityNO_battleCamp.name = "battleCamp"
field_descriptors.EntityNO_battleCamp.full_name = ".EntityNO.battleCamp"
field_descriptors.EntityNO_battleCamp.number = 18
field_descriptors.EntityNO_battleCamp.index = 16
field_descriptors.EntityNO_battleCamp.label = 1
field_descriptors.EntityNO_battleCamp.has_default_value = false
field_descriptors.EntityNO_battleCamp.default_value = 0
field_descriptors.EntityNO_battleCamp.type = 5
field_descriptors.EntityNO_battleCamp.cpp_type = 1
field_descriptors.EntityNO_tagEnhances.name = "tagEnhances"
field_descriptors.EntityNO_tagEnhances.full_name = ".EntityNO.tagEnhances"
field_descriptors.EntityNO_tagEnhances.number = 19
field_descriptors.EntityNO_tagEnhances.index = 17
field_descriptors.EntityNO_tagEnhances.label = 3
field_descriptors.EntityNO_tagEnhances.has_default_value = false
field_descriptors.EntityNO_tagEnhances.default_value = {}
field_descriptors.EntityNO_tagEnhances.message_type = type_descriptors.TagEnhanceNO
field_descriptors.EntityNO_tagEnhances.type = 11
field_descriptors.EntityNO_tagEnhances.cpp_type = 10
field_descriptors.EntityNO_steppable.name = "steppable"
field_descriptors.EntityNO_steppable.full_name = ".EntityNO.steppable"
field_descriptors.EntityNO_steppable.number = 20
field_descriptors.EntityNO_steppable.index = 18
field_descriptors.EntityNO_steppable.label = 1
field_descriptors.EntityNO_steppable.has_default_value = false
field_descriptors.EntityNO_steppable.default_value = false
field_descriptors.EntityNO_steppable.type = 8
field_descriptors.EntityNO_steppable.cpp_type = 7
field_descriptors.EntityNO_modelId.name = "modelId"
field_descriptors.EntityNO_modelId.full_name = ".EntityNO.modelId"
field_descriptors.EntityNO_modelId.number = 21
field_descriptors.EntityNO_modelId.index = 19
field_descriptors.EntityNO_modelId.label = 1
field_descriptors.EntityNO_modelId.has_default_value = false
field_descriptors.EntityNO_modelId.default_value = 0
field_descriptors.EntityNO_modelId.type = 5
field_descriptors.EntityNO_modelId.cpp_type = 1
field_descriptors.EntityNO_immuneBuffs.name = "immuneBuffs"
field_descriptors.EntityNO_immuneBuffs.full_name = ".EntityNO.immuneBuffs"
field_descriptors.EntityNO_immuneBuffs.number = 22
field_descriptors.EntityNO_immuneBuffs.index = 20
field_descriptors.EntityNO_immuneBuffs.label = 3
field_descriptors.EntityNO_immuneBuffs.has_default_value = false
field_descriptors.EntityNO_immuneBuffs.default_value = {}
field_descriptors.EntityNO_immuneBuffs.type = 5
field_descriptors.EntityNO_immuneBuffs.cpp_type = 1
type_descriptors.EntityNO.name = "EntityNO"
type_descriptors.EntityNO.full_name = ".EntityNO"
type_descriptors.EntityNO.nested_types = {}
type_descriptors.EntityNO.enum_types = {}
type_descriptors.EntityNO.fields = {
	field_descriptors.EntityNO_id,
	field_descriptors.EntityNO_code,
	field_descriptors.EntityNO_player,
	field_descriptors.EntityNO_attributes,
	field_descriptors.EntityNO_cell,
	field_descriptors.EntityNO_level,
	field_descriptors.EntityNO_tags,
	field_descriptors.EntityNO_skills,
	field_descriptors.EntityNO_buffs,
	field_descriptors.EntityNO_state,
	field_descriptors.EntityNO_viewCode,
	field_descriptors.EntityNO_extra,
	field_descriptors.EntityNO_weakPointType,
	field_descriptors.EntityNO_maxWeakPointHp,
	field_descriptors.EntityNO_weakPointHp,
	field_descriptors.EntityNO_type,
	field_descriptors.EntityNO_battleCamp,
	field_descriptors.EntityNO_tagEnhances,
	field_descriptors.EntityNO_steppable,
	field_descriptors.EntityNO_modelId,
	field_descriptors.EntityNO_immuneBuffs
}
type_descriptors.EntityNO.is_extendable = false
type_descriptors.EntityNO.extensions = {}
field_descriptors.ImmuneBuffRemoveNO_entity.name = "entity"
field_descriptors.ImmuneBuffRemoveNO_entity.full_name = ".ImmuneBuffRemoveNO.entity"
field_descriptors.ImmuneBuffRemoveNO_entity.number = 1
field_descriptors.ImmuneBuffRemoveNO_entity.index = 0
field_descriptors.ImmuneBuffRemoveNO_entity.label = 1
field_descriptors.ImmuneBuffRemoveNO_entity.has_default_value = false
field_descriptors.ImmuneBuffRemoveNO_entity.default_value = 0
field_descriptors.ImmuneBuffRemoveNO_entity.type = 5
field_descriptors.ImmuneBuffRemoveNO_entity.cpp_type = 1
field_descriptors.ImmuneBuffRemoveNO_buffs.name = "buffs"
field_descriptors.ImmuneBuffRemoveNO_buffs.full_name = ".ImmuneBuffRemoveNO.buffs"
field_descriptors.ImmuneBuffRemoveNO_buffs.number = 2
field_descriptors.ImmuneBuffRemoveNO_buffs.index = 1
field_descriptors.ImmuneBuffRemoveNO_buffs.label = 3
field_descriptors.ImmuneBuffRemoveNO_buffs.has_default_value = false
field_descriptors.ImmuneBuffRemoveNO_buffs.default_value = {}
field_descriptors.ImmuneBuffRemoveNO_buffs.type = 5
field_descriptors.ImmuneBuffRemoveNO_buffs.cpp_type = 1
type_descriptors.ImmuneBuffRemoveNO.name = "ImmuneBuffRemoveNO"
type_descriptors.ImmuneBuffRemoveNO.full_name = ".ImmuneBuffRemoveNO"
type_descriptors.ImmuneBuffRemoveNO.nested_types = {}
type_descriptors.ImmuneBuffRemoveNO.enum_types = {}
type_descriptors.ImmuneBuffRemoveNO.fields = {
	field_descriptors.ImmuneBuffRemoveNO_entity,
	field_descriptors.ImmuneBuffRemoveNO_buffs
}
type_descriptors.ImmuneBuffRemoveNO.is_extendable = false
type_descriptors.ImmuneBuffRemoveNO.extensions = {}
field_descriptors.CrossLineNO_width.name = "width"
field_descriptors.CrossLineNO_width.full_name = ".CrossLineNO.width"
field_descriptors.CrossLineNO_width.number = 1
field_descriptors.CrossLineNO_width.index = 0
field_descriptors.CrossLineNO_width.label = 1
field_descriptors.CrossLineNO_width.has_default_value = false
field_descriptors.CrossLineNO_width.default_value = 0
field_descriptors.CrossLineNO_width.type = 5
field_descriptors.CrossLineNO_width.cpp_type = 1
field_descriptors.CrossLineNO_height.name = "height"
field_descriptors.CrossLineNO_height.full_name = ".CrossLineNO.height"
field_descriptors.CrossLineNO_height.number = 2
field_descriptors.CrossLineNO_height.index = 1
field_descriptors.CrossLineNO_height.label = 1
field_descriptors.CrossLineNO_height.has_default_value = false
field_descriptors.CrossLineNO_height.default_value = 0
field_descriptors.CrossLineNO_height.type = 5
field_descriptors.CrossLineNO_height.cpp_type = 1
type_descriptors.CrossLineNO.name = "CrossLineNO"
type_descriptors.CrossLineNO.full_name = ".CrossLineNO"
type_descriptors.CrossLineNO.nested_types = {}
type_descriptors.CrossLineNO.enum_types = {}
type_descriptors.CrossLineNO.fields = {
	field_descriptors.CrossLineNO_width,
	field_descriptors.CrossLineNO_height
}
type_descriptors.CrossLineNO.is_extendable = false
type_descriptors.CrossLineNO.extensions = {}
type_descriptors.CancelReadyReply.name = "CancelReadyReply"
type_descriptors.CancelReadyReply.full_name = ".CancelReadyReply"
type_descriptors.CancelReadyReply.nested_types = {}
type_descriptors.CancelReadyReply.enum_types = {}
type_descriptors.CancelReadyReply.fields = {}
type_descriptors.CancelReadyReply.is_extendable = false
type_descriptors.CancelReadyReply.extensions = {}
field_descriptors.BuffRoundDecredEventNO_entity.name = "entity"
field_descriptors.BuffRoundDecredEventNO_entity.full_name = ".BuffRoundDecredEventNO.entity"
field_descriptors.BuffRoundDecredEventNO_entity.number = 1
field_descriptors.BuffRoundDecredEventNO_entity.index = 0
field_descriptors.BuffRoundDecredEventNO_entity.label = 1
field_descriptors.BuffRoundDecredEventNO_entity.has_default_value = false
field_descriptors.BuffRoundDecredEventNO_entity.default_value = 0
field_descriptors.BuffRoundDecredEventNO_entity.type = 5
field_descriptors.BuffRoundDecredEventNO_entity.cpp_type = 1
field_descriptors.BuffRoundDecredEventNO_ids.name = "ids"
field_descriptors.BuffRoundDecredEventNO_ids.full_name = ".BuffRoundDecredEventNO.ids"
field_descriptors.BuffRoundDecredEventNO_ids.number = 3
field_descriptors.BuffRoundDecredEventNO_ids.index = 1
field_descriptors.BuffRoundDecredEventNO_ids.label = 3
field_descriptors.BuffRoundDecredEventNO_ids.has_default_value = false
field_descriptors.BuffRoundDecredEventNO_ids.default_value = {}
field_descriptors.BuffRoundDecredEventNO_ids.type = 5
field_descriptors.BuffRoundDecredEventNO_ids.cpp_type = 1
field_descriptors.BuffRoundDecredEventNO_decrement.name = "decrement"
field_descriptors.BuffRoundDecredEventNO_decrement.full_name = ".BuffRoundDecredEventNO.decrement"
field_descriptors.BuffRoundDecredEventNO_decrement.number = 4
field_descriptors.BuffRoundDecredEventNO_decrement.index = 2
field_descriptors.BuffRoundDecredEventNO_decrement.label = 1
field_descriptors.BuffRoundDecredEventNO_decrement.has_default_value = false
field_descriptors.BuffRoundDecredEventNO_decrement.default_value = 0
field_descriptors.BuffRoundDecredEventNO_decrement.type = 5
field_descriptors.BuffRoundDecredEventNO_decrement.cpp_type = 1
type_descriptors.BuffRoundDecredEventNO.name = "BuffRoundDecredEventNO"
type_descriptors.BuffRoundDecredEventNO.full_name = ".BuffRoundDecredEventNO"
type_descriptors.BuffRoundDecredEventNO.nested_types = {}
type_descriptors.BuffRoundDecredEventNO.enum_types = {}
type_descriptors.BuffRoundDecredEventNO.fields = {
	field_descriptors.BuffRoundDecredEventNO_entity,
	field_descriptors.BuffRoundDecredEventNO_ids,
	field_descriptors.BuffRoundDecredEventNO_decrement
}
type_descriptors.BuffRoundDecredEventNO.is_extendable = false
type_descriptors.BuffRoundDecredEventNO.extensions = {}
field_descriptors.BackToRequest_round.name = "round"
field_descriptors.BackToRequest_round.full_name = ".BackToRequest.round"
field_descriptors.BackToRequest_round.number = 1
field_descriptors.BackToRequest_round.index = 0
field_descriptors.BackToRequest_round.label = 2
field_descriptors.BackToRequest_round.has_default_value = false
field_descriptors.BackToRequest_round.default_value = 0
field_descriptors.BackToRequest_round.type = 5
field_descriptors.BackToRequest_round.cpp_type = 1
field_descriptors.BackToRequest_step.name = "step"
field_descriptors.BackToRequest_step.full_name = ".BackToRequest.step"
field_descriptors.BackToRequest_step.number = 2
field_descriptors.BackToRequest_step.index = 1
field_descriptors.BackToRequest_step.label = 2
field_descriptors.BackToRequest_step.has_default_value = false
field_descriptors.BackToRequest_step.default_value = 0
field_descriptors.BackToRequest_step.type = 5
field_descriptors.BackToRequest_step.cpp_type = 1
type_descriptors.BackToRequest.name = "BackToRequest"
type_descriptors.BackToRequest.full_name = ".BackToRequest"
type_descriptors.BackToRequest.nested_types = {}
type_descriptors.BackToRequest.enum_types = {}
type_descriptors.BackToRequest.fields = {
	field_descriptors.BackToRequest_round,
	field_descriptors.BackToRequest_step
}
type_descriptors.BackToRequest.is_extendable = false
type_descriptors.BackToRequest.extensions = {}
field_descriptors.UnfinishedBattlePush_battleInfo.name = "battleInfo"
field_descriptors.UnfinishedBattlePush_battleInfo.full_name = ".UnfinishedBattlePush.battleInfo"
field_descriptors.UnfinishedBattlePush_battleInfo.number = 1
field_descriptors.UnfinishedBattlePush_battleInfo.index = 0
field_descriptors.UnfinishedBattlePush_battleInfo.label = 1
field_descriptors.UnfinishedBattlePush_battleInfo.has_default_value = false
field_descriptors.UnfinishedBattlePush_battleInfo.default_value = nil
field_descriptors.UnfinishedBattlePush_battleInfo.message_type = type_descriptors.BattleInfoNO
field_descriptors.UnfinishedBattlePush_battleInfo.type = 11
field_descriptors.UnfinishedBattlePush_battleInfo.cpp_type = 10
field_descriptors.UnfinishedBattlePush_canReconnect.name = "canReconnect"
field_descriptors.UnfinishedBattlePush_canReconnect.full_name = ".UnfinishedBattlePush.canReconnect"
field_descriptors.UnfinishedBattlePush_canReconnect.number = 2
field_descriptors.UnfinishedBattlePush_canReconnect.index = 1
field_descriptors.UnfinishedBattlePush_canReconnect.label = 1
field_descriptors.UnfinishedBattlePush_canReconnect.has_default_value = false
field_descriptors.UnfinishedBattlePush_canReconnect.default_value = false
field_descriptors.UnfinishedBattlePush_canReconnect.type = 8
field_descriptors.UnfinishedBattlePush_canReconnect.cpp_type = 7
type_descriptors.UnfinishedBattlePush.name = "UnfinishedBattlePush"
type_descriptors.UnfinishedBattlePush.full_name = ".UnfinishedBattlePush"
type_descriptors.UnfinishedBattlePush.nested_types = {}
type_descriptors.UnfinishedBattlePush.enum_types = {}
type_descriptors.UnfinishedBattlePush.fields = {
	field_descriptors.UnfinishedBattlePush_battleInfo,
	field_descriptors.UnfinishedBattlePush_canReconnect
}
type_descriptors.UnfinishedBattlePush.is_extendable = false
type_descriptors.UnfinishedBattlePush.extensions = {}
field_descriptors.EventNO_stageStarted.name = "stageStarted"
field_descriptors.EventNO_stageStarted.full_name = ".EventNO.stageStarted"
field_descriptors.EventNO_stageStarted.number = 1
field_descriptors.EventNO_stageStarted.index = 0
field_descriptors.EventNO_stageStarted.label = 1
field_descriptors.EventNO_stageStarted.has_default_value = false
field_descriptors.EventNO_stageStarted.default_value = 0
field_descriptors.EventNO_stageStarted.type = 5
field_descriptors.EventNO_stageStarted.cpp_type = 1
field_descriptors.EventNO_stageEnded.name = "stageEnded"
field_descriptors.EventNO_stageEnded.full_name = ".EventNO.stageEnded"
field_descriptors.EventNO_stageEnded.number = 2
field_descriptors.EventNO_stageEnded.index = 1
field_descriptors.EventNO_stageEnded.label = 1
field_descriptors.EventNO_stageEnded.has_default_value = false
field_descriptors.EventNO_stageEnded.default_value = 0
field_descriptors.EventNO_stageEnded.type = 5
field_descriptors.EventNO_stageEnded.cpp_type = 1
field_descriptors.EventNO_battleEnded.name = "battleEnded"
field_descriptors.EventNO_battleEnded.full_name = ".EventNO.battleEnded"
field_descriptors.EventNO_battleEnded.number = 3
field_descriptors.EventNO_battleEnded.index = 2
field_descriptors.EventNO_battleEnded.label = 1
field_descriptors.EventNO_battleEnded.has_default_value = false
field_descriptors.EventNO_battleEnded.default_value = nil
field_descriptors.EventNO_battleEnded.message_type = type_descriptors.BattleEndedEventNO
field_descriptors.EventNO_battleEnded.type = 11
field_descriptors.EventNO_battleEnded.cpp_type = 10
field_descriptors.EventNO_skillTriggered.name = "skillTriggered"
field_descriptors.EventNO_skillTriggered.full_name = ".EventNO.skillTriggered"
field_descriptors.EventNO_skillTriggered.number = 6
field_descriptors.EventNO_skillTriggered.index = 3
field_descriptors.EventNO_skillTriggered.label = 1
field_descriptors.EventNO_skillTriggered.has_default_value = false
field_descriptors.EventNO_skillTriggered.default_value = nil
field_descriptors.EventNO_skillTriggered.message_type = type_descriptors.SkillTriggeredEventNO
field_descriptors.EventNO_skillTriggered.type = 11
field_descriptors.EventNO_skillTriggered.cpp_type = 10
field_descriptors.EventNO_buffTriggered.name = "buffTriggered"
field_descriptors.EventNO_buffTriggered.full_name = ".EventNO.buffTriggered"
field_descriptors.EventNO_buffTriggered.number = 7
field_descriptors.EventNO_buffTriggered.index = 4
field_descriptors.EventNO_buffTriggered.label = 1
field_descriptors.EventNO_buffTriggered.has_default_value = false
field_descriptors.EventNO_buffTriggered.default_value = nil
field_descriptors.EventNO_buffTriggered.message_type = type_descriptors.BuffTriggeredEventNO
field_descriptors.EventNO_buffTriggered.type = 11
field_descriptors.EventNO_buffTriggered.cpp_type = 10
field_descriptors.EventNO_attributeModified.name = "attributeModified"
field_descriptors.EventNO_attributeModified.full_name = ".EventNO.attributeModified"
field_descriptors.EventNO_attributeModified.number = 8
field_descriptors.EventNO_attributeModified.index = 5
field_descriptors.EventNO_attributeModified.label = 1
field_descriptors.EventNO_attributeModified.has_default_value = false
field_descriptors.EventNO_attributeModified.default_value = nil
field_descriptors.EventNO_attributeModified.message_type = type_descriptors.AttributeModifiedEventNO
field_descriptors.EventNO_attributeModified.type = 11
field_descriptors.EventNO_attributeModified.cpp_type = 10
field_descriptors.EventNO_buffAdded.name = "buffAdded"
field_descriptors.EventNO_buffAdded.full_name = ".EventNO.buffAdded"
field_descriptors.EventNO_buffAdded.number = 9
field_descriptors.EventNO_buffAdded.index = 6
field_descriptors.EventNO_buffAdded.label = 1
field_descriptors.EventNO_buffAdded.has_default_value = false
field_descriptors.EventNO_buffAdded.default_value = nil
field_descriptors.EventNO_buffAdded.message_type = type_descriptors.BuffAddedEventNO
field_descriptors.EventNO_buffAdded.type = 11
field_descriptors.EventNO_buffAdded.cpp_type = 10
field_descriptors.EventNO_buffRemoved.name = "buffRemoved"
field_descriptors.EventNO_buffRemoved.full_name = ".EventNO.buffRemoved"
field_descriptors.EventNO_buffRemoved.number = 10
field_descriptors.EventNO_buffRemoved.index = 7
field_descriptors.EventNO_buffRemoved.label = 1
field_descriptors.EventNO_buffRemoved.has_default_value = false
field_descriptors.EventNO_buffRemoved.default_value = nil
field_descriptors.EventNO_buffRemoved.message_type = type_descriptors.BuffRemovedEventNO
field_descriptors.EventNO_buffRemoved.type = 11
field_descriptors.EventNO_buffRemoved.cpp_type = 10
field_descriptors.EventNO_buffRoundDecred.name = "buffRoundDecred"
field_descriptors.EventNO_buffRoundDecred.full_name = ".EventNO.buffRoundDecred"
field_descriptors.EventNO_buffRoundDecred.number = 11
field_descriptors.EventNO_buffRoundDecred.index = 8
field_descriptors.EventNO_buffRoundDecred.label = 1
field_descriptors.EventNO_buffRoundDecred.has_default_value = false
field_descriptors.EventNO_buffRoundDecred.default_value = nil
field_descriptors.EventNO_buffRoundDecred.message_type = type_descriptors.BuffRoundDecredEventNO
field_descriptors.EventNO_buffRoundDecred.type = 11
field_descriptors.EventNO_buffRoundDecred.cpp_type = 10
field_descriptors.EventNO_cured.name = "cured"
field_descriptors.EventNO_cured.full_name = ".EventNO.cured"
field_descriptors.EventNO_cured.number = 13
field_descriptors.EventNO_cured.index = 9
field_descriptors.EventNO_cured.label = 1
field_descriptors.EventNO_cured.has_default_value = false
field_descriptors.EventNO_cured.default_value = nil
field_descriptors.EventNO_cured.message_type = type_descriptors.CuredEventNO
field_descriptors.EventNO_cured.type = 11
field_descriptors.EventNO_cured.cpp_type = 10
field_descriptors.EventNO_entityDead.name = "entityDead"
field_descriptors.EventNO_entityDead.full_name = ".EventNO.entityDead"
field_descriptors.EventNO_entityDead.number = 14
field_descriptors.EventNO_entityDead.index = 10
field_descriptors.EventNO_entityDead.label = 1
field_descriptors.EventNO_entityDead.has_default_value = false
field_descriptors.EventNO_entityDead.default_value = nil
field_descriptors.EventNO_entityDead.message_type = type_descriptors.EntityDeadEventNO
field_descriptors.EventNO_entityDead.type = 11
field_descriptors.EventNO_entityDead.cpp_type = 10
field_descriptors.EventNO_entityStepped.name = "entityStepped"
field_descriptors.EventNO_entityStepped.full_name = ".EventNO.entityStepped"
field_descriptors.EventNO_entityStepped.number = 15
field_descriptors.EventNO_entityStepped.index = 11
field_descriptors.EventNO_entityStepped.label = 1
field_descriptors.EventNO_entityStepped.has_default_value = false
field_descriptors.EventNO_entityStepped.default_value = nil
field_descriptors.EventNO_entityStepped.message_type = type_descriptors.EntitySteppedEventNO
field_descriptors.EventNO_entityStepped.type = 11
field_descriptors.EventNO_entityStepped.cpp_type = 10
field_descriptors.EventNO_weakPointHpChanged.name = "weakPointHpChanged"
field_descriptors.EventNO_weakPointHpChanged.full_name = ".EventNO.weakPointHpChanged"
field_descriptors.EventNO_weakPointHpChanged.number = 16
field_descriptors.EventNO_weakPointHpChanged.index = 12
field_descriptors.EventNO_weakPointHpChanged.label = 1
field_descriptors.EventNO_weakPointHpChanged.has_default_value = false
field_descriptors.EventNO_weakPointHpChanged.default_value = nil
field_descriptors.EventNO_weakPointHpChanged.message_type = type_descriptors.WeakPointHpChangedEventNO
field_descriptors.EventNO_weakPointHpChanged.type = 11
field_descriptors.EventNO_weakPointHpChanged.cpp_type = 10
field_descriptors.EventNO_positionChanged.name = "positionChanged"
field_descriptors.EventNO_positionChanged.full_name = ".EventNO.positionChanged"
field_descriptors.EventNO_positionChanged.number = 18
field_descriptors.EventNO_positionChanged.index = 13
field_descriptors.EventNO_positionChanged.label = 1
field_descriptors.EventNO_positionChanged.has_default_value = false
field_descriptors.EventNO_positionChanged.default_value = nil
field_descriptors.EventNO_positionChanged.message_type = type_descriptors.PositionChangedEventNO
field_descriptors.EventNO_positionChanged.type = 11
field_descriptors.EventNO_positionChanged.cpp_type = 10
field_descriptors.EventNO_entitiesAdded.name = "entitiesAdded"
field_descriptors.EventNO_entitiesAdded.full_name = ".EventNO.entitiesAdded"
field_descriptors.EventNO_entitiesAdded.number = 19
field_descriptors.EventNO_entitiesAdded.index = 14
field_descriptors.EventNO_entitiesAdded.label = 3
field_descriptors.EventNO_entitiesAdded.has_default_value = false
field_descriptors.EventNO_entitiesAdded.default_value = {}
field_descriptors.EventNO_entitiesAdded.message_type = type_descriptors.EntityNO
field_descriptors.EventNO_entitiesAdded.type = 11
field_descriptors.EventNO_entitiesAdded.cpp_type = 10
field_descriptors.EventNO_entityRemoved.name = "entityRemoved"
field_descriptors.EventNO_entityRemoved.full_name = ".EventNO.entityRemoved"
field_descriptors.EventNO_entityRemoved.number = 20
field_descriptors.EventNO_entityRemoved.index = 15
field_descriptors.EventNO_entityRemoved.label = 1
field_descriptors.EventNO_entityRemoved.has_default_value = false
field_descriptors.EventNO_entityRemoved.default_value = nil
field_descriptors.EventNO_entityRemoved.message_type = type_descriptors.EntityRemovedNO
field_descriptors.EventNO_entityRemoved.type = 11
field_descriptors.EventNO_entityRemoved.cpp_type = 10
field_descriptors.EventNO_entitiesSwapped.name = "entitiesSwapped"
field_descriptors.EventNO_entitiesSwapped.full_name = ".EventNO.entitiesSwapped"
field_descriptors.EventNO_entitiesSwapped.number = 21
field_descriptors.EventNO_entitiesSwapped.index = 16
field_descriptors.EventNO_entitiesSwapped.label = 3
field_descriptors.EventNO_entitiesSwapped.has_default_value = false
field_descriptors.EventNO_entitiesSwapped.default_value = {}
field_descriptors.EventNO_entitiesSwapped.type = 5
field_descriptors.EventNO_entitiesSwapped.cpp_type = 1
field_descriptors.EventNO_roundStarted.name = "roundStarted"
field_descriptors.EventNO_roundStarted.full_name = ".EventNO.roundStarted"
field_descriptors.EventNO_roundStarted.number = 22
field_descriptors.EventNO_roundStarted.index = 17
field_descriptors.EventNO_roundStarted.label = 1
field_descriptors.EventNO_roundStarted.has_default_value = false
field_descriptors.EventNO_roundStarted.default_value = 0
field_descriptors.EventNO_roundStarted.type = 5
field_descriptors.EventNO_roundStarted.cpp_type = 1
field_descriptors.EventNO_plotChainTriggered.name = "plotChainTriggered"
field_descriptors.EventNO_plotChainTriggered.full_name = ".EventNO.plotChainTriggered"
field_descriptors.EventNO_plotChainTriggered.number = 23
field_descriptors.EventNO_plotChainTriggered.index = 18
field_descriptors.EventNO_plotChainTriggered.label = 1
field_descriptors.EventNO_plotChainTriggered.has_default_value = false
field_descriptors.EventNO_plotChainTriggered.default_value = nil
field_descriptors.EventNO_plotChainTriggered.message_type = type_descriptors.PlotChainTriggeredEventNO
field_descriptors.EventNO_plotChainTriggered.type = 11
field_descriptors.EventNO_plotChainTriggered.cpp_type = 10
field_descriptors.EventNO_plotTriggered.name = "plotTriggered"
field_descriptors.EventNO_plotTriggered.full_name = ".EventNO.plotTriggered"
field_descriptors.EventNO_plotTriggered.number = 24
field_descriptors.EventNO_plotTriggered.index = 19
field_descriptors.EventNO_plotTriggered.label = 1
field_descriptors.EventNO_plotTriggered.has_default_value = false
field_descriptors.EventNO_plotTriggered.default_value = nil
field_descriptors.EventNO_plotTriggered.message_type = type_descriptors.PlotTriggered
field_descriptors.EventNO_plotTriggered.type = 11
field_descriptors.EventNO_plotTriggered.cpp_type = 10
field_descriptors.EventNO_damaged.name = "damaged"
field_descriptors.EventNO_damaged.full_name = ".EventNO.damaged"
field_descriptors.EventNO_damaged.number = 25
field_descriptors.EventNO_damaged.index = 20
field_descriptors.EventNO_damaged.label = 1
field_descriptors.EventNO_damaged.has_default_value = false
field_descriptors.EventNO_damaged.default_value = nil
field_descriptors.EventNO_damaged.message_type = type_descriptors.DamagedEventNO
field_descriptors.EventNO_damaged.type = 11
field_descriptors.EventNO_damaged.cpp_type = 10
field_descriptors.EventNO_stateAdded.name = "stateAdded"
field_descriptors.EventNO_stateAdded.full_name = ".EventNO.stateAdded"
field_descriptors.EventNO_stateAdded.number = 26
field_descriptors.EventNO_stateAdded.index = 21
field_descriptors.EventNO_stateAdded.label = 1
field_descriptors.EventNO_stateAdded.has_default_value = false
field_descriptors.EventNO_stateAdded.default_value = nil
field_descriptors.EventNO_stateAdded.message_type = type_descriptors.StateChangedEventNO
field_descriptors.EventNO_stateAdded.type = 11
field_descriptors.EventNO_stateAdded.cpp_type = 10
field_descriptors.EventNO_stateRemoved.name = "stateRemoved"
field_descriptors.EventNO_stateRemoved.full_name = ".EventNO.stateRemoved"
field_descriptors.EventNO_stateRemoved.number = 27
field_descriptors.EventNO_stateRemoved.index = 22
field_descriptors.EventNO_stateRemoved.label = 1
field_descriptors.EventNO_stateRemoved.has_default_value = false
field_descriptors.EventNO_stateRemoved.default_value = nil
field_descriptors.EventNO_stateRemoved.message_type = type_descriptors.StateChangedEventNO
field_descriptors.EventNO_stateRemoved.type = 11
field_descriptors.EventNO_stateRemoved.cpp_type = 10
field_descriptors.EventNO_cellsBlocked.name = "cellsBlocked"
field_descriptors.EventNO_cellsBlocked.full_name = ".EventNO.cellsBlocked"
field_descriptors.EventNO_cellsBlocked.number = 28
field_descriptors.EventNO_cellsBlocked.index = 23
field_descriptors.EventNO_cellsBlocked.label = 1
field_descriptors.EventNO_cellsBlocked.has_default_value = false
field_descriptors.EventNO_cellsBlocked.default_value = nil
field_descriptors.EventNO_cellsBlocked.message_type = type_descriptors.CellsBlockedEventNO
field_descriptors.EventNO_cellsBlocked.type = 11
field_descriptors.EventNO_cellsBlocked.cpp_type = 10
field_descriptors.EventNO_cellsUnblocked.name = "cellsUnblocked"
field_descriptors.EventNO_cellsUnblocked.full_name = ".EventNO.cellsUnblocked"
field_descriptors.EventNO_cellsUnblocked.number = 29
field_descriptors.EventNO_cellsUnblocked.index = 24
field_descriptors.EventNO_cellsUnblocked.label = 1
field_descriptors.EventNO_cellsUnblocked.has_default_value = false
field_descriptors.EventNO_cellsUnblocked.default_value = nil
field_descriptors.EventNO_cellsUnblocked.message_type = type_descriptors.CellsBlockedEventNO
field_descriptors.EventNO_cellsUnblocked.type = 11
field_descriptors.EventNO_cellsUnblocked.cpp_type = 10
field_descriptors.EventNO_cup.name = "cup"
field_descriptors.EventNO_cup.full_name = ".EventNO.cup"
field_descriptors.EventNO_cup.number = 30
field_descriptors.EventNO_cup.index = 25
field_descriptors.EventNO_cup.label = 1
field_descriptors.EventNO_cup.has_default_value = false
field_descriptors.EventNO_cup.default_value = nil
field_descriptors.EventNO_cup.message_type = dependencies.AchievementExtension.type_descriptors.CupNO
field_descriptors.EventNO_cup.type = 11
field_descriptors.EventNO_cup.cpp_type = 10
field_descriptors.EventNO_playerStarted.name = "playerStarted"
field_descriptors.EventNO_playerStarted.full_name = ".EventNO.playerStarted"
field_descriptors.EventNO_playerStarted.number = 31
field_descriptors.EventNO_playerStarted.index = 26
field_descriptors.EventNO_playerStarted.label = 1
field_descriptors.EventNO_playerStarted.has_default_value = false
field_descriptors.EventNO_playerStarted.default_value = 0
field_descriptors.EventNO_playerStarted.type = 5
field_descriptors.EventNO_playerStarted.cpp_type = 1
field_descriptors.EventNO_playerEnded.name = "playerEnded"
field_descriptors.EventNO_playerEnded.full_name = ".EventNO.playerEnded"
field_descriptors.EventNO_playerEnded.number = 32
field_descriptors.EventNO_playerEnded.index = 27
field_descriptors.EventNO_playerEnded.label = 1
field_descriptors.EventNO_playerEnded.has_default_value = false
field_descriptors.EventNO_playerEnded.default_value = 0
field_descriptors.EventNO_playerEnded.type = 5
field_descriptors.EventNO_playerEnded.cpp_type = 1
field_descriptors.EventNO_haloRefreshed.name = "haloRefreshed"
field_descriptors.EventNO_haloRefreshed.full_name = ".EventNO.haloRefreshed"
field_descriptors.EventNO_haloRefreshed.number = 33
field_descriptors.EventNO_haloRefreshed.index = 28
field_descriptors.EventNO_haloRefreshed.label = 1
field_descriptors.EventNO_haloRefreshed.has_default_value = false
field_descriptors.EventNO_haloRefreshed.default_value = nil
field_descriptors.EventNO_haloRefreshed.message_type = type_descriptors.HaloRefreshedEventNO
field_descriptors.EventNO_haloRefreshed.type = 11
field_descriptors.EventNO_haloRefreshed.cpp_type = 10
field_descriptors.EventNO_entityConfigChanged.name = "entityConfigChanged"
field_descriptors.EventNO_entityConfigChanged.full_name = ".EventNO.entityConfigChanged"
field_descriptors.EventNO_entityConfigChanged.number = 34
field_descriptors.EventNO_entityConfigChanged.index = 29
field_descriptors.EventNO_entityConfigChanged.label = 1
field_descriptors.EventNO_entityConfigChanged.has_default_value = false
field_descriptors.EventNO_entityConfigChanged.default_value = nil
field_descriptors.EventNO_entityConfigChanged.message_type = type_descriptors.EntityConfigChangedEventNO
field_descriptors.EventNO_entityConfigChanged.type = 11
field_descriptors.EventNO_entityConfigChanged.cpp_type = 10
field_descriptors.EventNO_taskTrigger.name = "taskTrigger"
field_descriptors.EventNO_taskTrigger.full_name = ".EventNO.taskTrigger"
field_descriptors.EventNO_taskTrigger.number = 35
field_descriptors.EventNO_taskTrigger.index = 30
field_descriptors.EventNO_taskTrigger.label = 1
field_descriptors.EventNO_taskTrigger.has_default_value = false
field_descriptors.EventNO_taskTrigger.default_value = nil
field_descriptors.EventNO_taskTrigger.message_type = type_descriptors.TaskTriggerNO
field_descriptors.EventNO_taskTrigger.type = 11
field_descriptors.EventNO_taskTrigger.cpp_type = 10
field_descriptors.EventNO_userReady.name = "userReady"
field_descriptors.EventNO_userReady.full_name = ".EventNO.userReady"
field_descriptors.EventNO_userReady.number = 36
field_descriptors.EventNO_userReady.index = 31
field_descriptors.EventNO_userReady.label = 1
field_descriptors.EventNO_userReady.has_default_value = false
field_descriptors.EventNO_userReady.default_value = 0
field_descriptors.EventNO_userReady.type = 5
field_descriptors.EventNO_userReady.cpp_type = 1
field_descriptors.EventNO_cancelReady.name = "cancelReady"
field_descriptors.EventNO_cancelReady.full_name = ".EventNO.cancelReady"
field_descriptors.EventNO_cancelReady.number = 37
field_descriptors.EventNO_cancelReady.index = 32
field_descriptors.EventNO_cancelReady.label = 1
field_descriptors.EventNO_cancelReady.has_default_value = false
field_descriptors.EventNO_cancelReady.default_value = 0
field_descriptors.EventNO_cancelReady.type = 5
field_descriptors.EventNO_cancelReady.cpp_type = 1
field_descriptors.EventNO_tacitTaskProgress.name = "tacitTaskProgress"
field_descriptors.EventNO_tacitTaskProgress.full_name = ".EventNO.tacitTaskProgress"
field_descriptors.EventNO_tacitTaskProgress.number = 38
field_descriptors.EventNO_tacitTaskProgress.index = 33
field_descriptors.EventNO_tacitTaskProgress.label = 1
field_descriptors.EventNO_tacitTaskProgress.has_default_value = false
field_descriptors.EventNO_tacitTaskProgress.default_value = nil
field_descriptors.EventNO_tacitTaskProgress.message_type = type_descriptors.TacitTaskProgressEventNO
field_descriptors.EventNO_tacitTaskProgress.type = 11
field_descriptors.EventNO_tacitTaskProgress.cpp_type = 10
field_descriptors.EventNO_terrainChange.name = "terrainChange"
field_descriptors.EventNO_terrainChange.full_name = ".EventNO.terrainChange"
field_descriptors.EventNO_terrainChange.number = 39
field_descriptors.EventNO_terrainChange.index = 34
field_descriptors.EventNO_terrainChange.label = 1
field_descriptors.EventNO_terrainChange.has_default_value = false
field_descriptors.EventNO_terrainChange.default_value = nil
field_descriptors.EventNO_terrainChange.message_type = type_descriptors.TerrainChangeNO
field_descriptors.EventNO_terrainChange.type = 11
field_descriptors.EventNO_terrainChange.cpp_type = 10
field_descriptors.EventNO_skillAdded.name = "skillAdded"
field_descriptors.EventNO_skillAdded.full_name = ".EventNO.skillAdded"
field_descriptors.EventNO_skillAdded.number = 41
field_descriptors.EventNO_skillAdded.index = 35
field_descriptors.EventNO_skillAdded.label = 1
field_descriptors.EventNO_skillAdded.has_default_value = false
field_descriptors.EventNO_skillAdded.default_value = nil
field_descriptors.EventNO_skillAdded.message_type = type_descriptors.SkillChangedEventNO
field_descriptors.EventNO_skillAdded.type = 11
field_descriptors.EventNO_skillAdded.cpp_type = 10
field_descriptors.EventNO_skillRemoved.name = "skillRemoved"
field_descriptors.EventNO_skillRemoved.full_name = ".EventNO.skillRemoved"
field_descriptors.EventNO_skillRemoved.number = 42
field_descriptors.EventNO_skillRemoved.index = 36
field_descriptors.EventNO_skillRemoved.label = 1
field_descriptors.EventNO_skillRemoved.has_default_value = false
field_descriptors.EventNO_skillRemoved.default_value = nil
field_descriptors.EventNO_skillRemoved.message_type = type_descriptors.SkillChangedEventNO
field_descriptors.EventNO_skillRemoved.type = 11
field_descriptors.EventNO_skillRemoved.cpp_type = 10
field_descriptors.EventNO_entityPlayerChanged.name = "entityPlayerChanged"
field_descriptors.EventNO_entityPlayerChanged.full_name = ".EventNO.entityPlayerChanged"
field_descriptors.EventNO_entityPlayerChanged.number = 43
field_descriptors.EventNO_entityPlayerChanged.index = 37
field_descriptors.EventNO_entityPlayerChanged.label = 3
field_descriptors.EventNO_entityPlayerChanged.has_default_value = false
field_descriptors.EventNO_entityPlayerChanged.default_value = {}
field_descriptors.EventNO_entityPlayerChanged.message_type = type_descriptors.EntityPlayerChangedEventNO
field_descriptors.EventNO_entityPlayerChanged.type = 11
field_descriptors.EventNO_entityPlayerChanged.cpp_type = 10
field_descriptors.EventNO_wonConditionsChanged.name = "wonConditionsChanged"
field_descriptors.EventNO_wonConditionsChanged.full_name = ".EventNO.wonConditionsChanged"
field_descriptors.EventNO_wonConditionsChanged.number = 44
field_descriptors.EventNO_wonConditionsChanged.index = 38
field_descriptors.EventNO_wonConditionsChanged.label = 1
field_descriptors.EventNO_wonConditionsChanged.has_default_value = false
field_descriptors.EventNO_wonConditionsChanged.default_value = nil
field_descriptors.EventNO_wonConditionsChanged.message_type = type_descriptors.WonConditionsChangedEventNO
field_descriptors.EventNO_wonConditionsChanged.type = 11
field_descriptors.EventNO_wonConditionsChanged.cpp_type = 10
field_descriptors.EventNO_terrainUpdated.name = "terrainUpdated"
field_descriptors.EventNO_terrainUpdated.full_name = ".EventNO.terrainUpdated"
field_descriptors.EventNO_terrainUpdated.number = 45
field_descriptors.EventNO_terrainUpdated.index = 39
field_descriptors.EventNO_terrainUpdated.label = 3
field_descriptors.EventNO_terrainUpdated.has_default_value = false
field_descriptors.EventNO_terrainUpdated.default_value = {}
field_descriptors.EventNO_terrainUpdated.message_type = type_descriptors.CellNO
field_descriptors.EventNO_terrainUpdated.type = 11
field_descriptors.EventNO_terrainUpdated.cpp_type = 10
field_descriptors.EventNO_skillCdUpdate.name = "skillCdUpdate"
field_descriptors.EventNO_skillCdUpdate.full_name = ".EventNO.skillCdUpdate"
field_descriptors.EventNO_skillCdUpdate.number = 46
field_descriptors.EventNO_skillCdUpdate.index = 40
field_descriptors.EventNO_skillCdUpdate.label = 1
field_descriptors.EventNO_skillCdUpdate.has_default_value = false
field_descriptors.EventNO_skillCdUpdate.default_value = nil
field_descriptors.EventNO_skillCdUpdate.message_type = type_descriptors.SkillCdUpdateEventNO
field_descriptors.EventNO_skillCdUpdate.type = 11
field_descriptors.EventNO_skillCdUpdate.cpp_type = 10
field_descriptors.EventNO_weakPointStatusChanged.name = "weakPointStatusChanged"
field_descriptors.EventNO_weakPointStatusChanged.full_name = ".EventNO.weakPointStatusChanged"
field_descriptors.EventNO_weakPointStatusChanged.number = 47
field_descriptors.EventNO_weakPointStatusChanged.index = 41
field_descriptors.EventNO_weakPointStatusChanged.label = 1
field_descriptors.EventNO_weakPointStatusChanged.has_default_value = false
field_descriptors.EventNO_weakPointStatusChanged.default_value = nil
field_descriptors.EventNO_weakPointStatusChanged.message_type = type_descriptors.WeakPointStatusChangedEventNO
field_descriptors.EventNO_weakPointStatusChanged.type = 11
field_descriptors.EventNO_weakPointStatusChanged.cpp_type = 10
field_descriptors.EventNO_weakPointAdded.name = "weakPointAdded"
field_descriptors.EventNO_weakPointAdded.full_name = ".EventNO.weakPointAdded"
field_descriptors.EventNO_weakPointAdded.number = 48
field_descriptors.EventNO_weakPointAdded.index = 42
field_descriptors.EventNO_weakPointAdded.label = 1
field_descriptors.EventNO_weakPointAdded.has_default_value = false
field_descriptors.EventNO_weakPointAdded.default_value = nil
field_descriptors.EventNO_weakPointAdded.message_type = type_descriptors.WeakPointAddedEventNO
field_descriptors.EventNO_weakPointAdded.type = 11
field_descriptors.EventNO_weakPointAdded.cpp_type = 10
field_descriptors.EventNO_groupEvent.name = "groupEvent"
field_descriptors.EventNO_groupEvent.full_name = ".EventNO.groupEvent"
field_descriptors.EventNO_groupEvent.number = 49
field_descriptors.EventNO_groupEvent.index = 43
field_descriptors.EventNO_groupEvent.label = 1
field_descriptors.EventNO_groupEvent.has_default_value = false
field_descriptors.EventNO_groupEvent.default_value = nil
field_descriptors.EventNO_groupEvent.message_type = type_descriptors.GroupEventNO
field_descriptors.EventNO_groupEvent.type = 11
field_descriptors.EventNO_groupEvent.cpp_type = 10
field_descriptors.EventNO_plotTriggered3D.name = "plotTriggered3D"
field_descriptors.EventNO_plotTriggered3D.full_name = ".EventNO.plotTriggered3D"
field_descriptors.EventNO_plotTriggered3D.number = 50
field_descriptors.EventNO_plotTriggered3D.index = 44
field_descriptors.EventNO_plotTriggered3D.label = 1
field_descriptors.EventNO_plotTriggered3D.has_default_value = false
field_descriptors.EventNO_plotTriggered3D.default_value = nil
field_descriptors.EventNO_plotTriggered3D.message_type = type_descriptors.PlotTriggered3D
field_descriptors.EventNO_plotTriggered3D.type = 11
field_descriptors.EventNO_plotTriggered3D.cpp_type = 10
field_descriptors.EventNO_doomForecast.name = "doomForecast"
field_descriptors.EventNO_doomForecast.full_name = ".EventNO.doomForecast"
field_descriptors.EventNO_doomForecast.number = 51
field_descriptors.EventNO_doomForecast.index = 45
field_descriptors.EventNO_doomForecast.label = 1
field_descriptors.EventNO_doomForecast.has_default_value = false
field_descriptors.EventNO_doomForecast.default_value = nil
field_descriptors.EventNO_doomForecast.message_type = type_descriptors.DoomForecastNO
field_descriptors.EventNO_doomForecast.type = 11
field_descriptors.EventNO_doomForecast.cpp_type = 10
field_descriptors.EventNO_tag.name = "tag"
field_descriptors.EventNO_tag.full_name = ".EventNO.tag"
field_descriptors.EventNO_tag.number = 52
field_descriptors.EventNO_tag.index = 46
field_descriptors.EventNO_tag.label = 1
field_descriptors.EventNO_tag.has_default_value = false
field_descriptors.EventNO_tag.default_value = nil
field_descriptors.EventNO_tag.message_type = type_descriptors.TagNO
field_descriptors.EventNO_tag.type = 11
field_descriptors.EventNO_tag.cpp_type = 10
field_descriptors.EventNO_tagWithBase.name = "tagWithBase"
field_descriptors.EventNO_tagWithBase.full_name = ".EventNO.tagWithBase"
field_descriptors.EventNO_tagWithBase.number = 53
field_descriptors.EventNO_tagWithBase.index = 47
field_descriptors.EventNO_tagWithBase.label = 1
field_descriptors.EventNO_tagWithBase.has_default_value = false
field_descriptors.EventNO_tagWithBase.default_value = nil
field_descriptors.EventNO_tagWithBase.message_type = type_descriptors.TagEventWithBaseNO
field_descriptors.EventNO_tagWithBase.type = 11
field_descriptors.EventNO_tagWithBase.cpp_type = 10
field_descriptors.EventNO_lightColumn.name = "lightColumn"
field_descriptors.EventNO_lightColumn.full_name = ".EventNO.lightColumn"
field_descriptors.EventNO_lightColumn.number = 54
field_descriptors.EventNO_lightColumn.index = 48
field_descriptors.EventNO_lightColumn.label = 1
field_descriptors.EventNO_lightColumn.has_default_value = false
field_descriptors.EventNO_lightColumn.default_value = nil
field_descriptors.EventNO_lightColumn.message_type = type_descriptors.LightColumnNO
field_descriptors.EventNO_lightColumn.type = 11
field_descriptors.EventNO_lightColumn.cpp_type = 10
field_descriptors.EventNO_shoot.name = "shoot"
field_descriptors.EventNO_shoot.full_name = ".EventNO.shoot"
field_descriptors.EventNO_shoot.number = 55
field_descriptors.EventNO_shoot.index = 49
field_descriptors.EventNO_shoot.label = 1
field_descriptors.EventNO_shoot.has_default_value = false
field_descriptors.EventNO_shoot.default_value = nil
field_descriptors.EventNO_shoot.message_type = type_descriptors.ShootNO
field_descriptors.EventNO_shoot.type = 11
field_descriptors.EventNO_shoot.cpp_type = 10
field_descriptors.EventNO_sheetMusic.name = "sheetMusic"
field_descriptors.EventNO_sheetMusic.full_name = ".EventNO.sheetMusic"
field_descriptors.EventNO_sheetMusic.number = 56
field_descriptors.EventNO_sheetMusic.index = 50
field_descriptors.EventNO_sheetMusic.label = 1
field_descriptors.EventNO_sheetMusic.has_default_value = false
field_descriptors.EventNO_sheetMusic.default_value = nil
field_descriptors.EventNO_sheetMusic.message_type = type_descriptors.SheetMusicNO
field_descriptors.EventNO_sheetMusic.type = 11
field_descriptors.EventNO_sheetMusic.cpp_type = 10
field_descriptors.EventNO_pianoPlaying.name = "pianoPlaying"
field_descriptors.EventNO_pianoPlaying.full_name = ".EventNO.pianoPlaying"
field_descriptors.EventNO_pianoPlaying.number = 57
field_descriptors.EventNO_pianoPlaying.index = 51
field_descriptors.EventNO_pianoPlaying.label = 3
field_descriptors.EventNO_pianoPlaying.has_default_value = false
field_descriptors.EventNO_pianoPlaying.default_value = {}
field_descriptors.EventNO_pianoPlaying.message_type = type_descriptors.PianoPlayingEventNO
field_descriptors.EventNO_pianoPlaying.type = 11
field_descriptors.EventNO_pianoPlaying.cpp_type = 10
field_descriptors.EventNO_tagEnhanceAdds.name = "tagEnhanceAdds"
field_descriptors.EventNO_tagEnhanceAdds.full_name = ".EventNO.tagEnhanceAdds"
field_descriptors.EventNO_tagEnhanceAdds.number = 58
field_descriptors.EventNO_tagEnhanceAdds.index = 52
field_descriptors.EventNO_tagEnhanceAdds.label = 1
field_descriptors.EventNO_tagEnhanceAdds.has_default_value = false
field_descriptors.EventNO_tagEnhanceAdds.default_value = nil
field_descriptors.EventNO_tagEnhanceAdds.message_type = type_descriptors.TagEnhanceAddNO
field_descriptors.EventNO_tagEnhanceAdds.type = 11
field_descriptors.EventNO_tagEnhanceAdds.cpp_type = 10
field_descriptors.EventNO_tagEnhanceRemoves.name = "tagEnhanceRemoves"
field_descriptors.EventNO_tagEnhanceRemoves.full_name = ".EventNO.tagEnhanceRemoves"
field_descriptors.EventNO_tagEnhanceRemoves.number = 59
field_descriptors.EventNO_tagEnhanceRemoves.index = 53
field_descriptors.EventNO_tagEnhanceRemoves.label = 1
field_descriptors.EventNO_tagEnhanceRemoves.has_default_value = false
field_descriptors.EventNO_tagEnhanceRemoves.default_value = nil
field_descriptors.EventNO_tagEnhanceRemoves.message_type = type_descriptors.TagEnhanceRemoveNO
field_descriptors.EventNO_tagEnhanceRemoves.type = 11
field_descriptors.EventNO_tagEnhanceRemoves.cpp_type = 10
field_descriptors.EventNO_multiRoundAoeAdd.name = "multiRoundAoeAdd"
field_descriptors.EventNO_multiRoundAoeAdd.full_name = ".EventNO.multiRoundAoeAdd"
field_descriptors.EventNO_multiRoundAoeAdd.number = 60
field_descriptors.EventNO_multiRoundAoeAdd.index = 54
field_descriptors.EventNO_multiRoundAoeAdd.label = 1
field_descriptors.EventNO_multiRoundAoeAdd.has_default_value = false
field_descriptors.EventNO_multiRoundAoeAdd.default_value = nil
field_descriptors.EventNO_multiRoundAoeAdd.message_type = type_descriptors.MultiRoundAoeAddNO
field_descriptors.EventNO_multiRoundAoeAdd.type = 11
field_descriptors.EventNO_multiRoundAoeAdd.cpp_type = 10
field_descriptors.EventNO_multiRoundAoeUpdate.name = "multiRoundAoeUpdate"
field_descriptors.EventNO_multiRoundAoeUpdate.full_name = ".EventNO.multiRoundAoeUpdate"
field_descriptors.EventNO_multiRoundAoeUpdate.number = 61
field_descriptors.EventNO_multiRoundAoeUpdate.index = 55
field_descriptors.EventNO_multiRoundAoeUpdate.label = 1
field_descriptors.EventNO_multiRoundAoeUpdate.has_default_value = false
field_descriptors.EventNO_multiRoundAoeUpdate.default_value = nil
field_descriptors.EventNO_multiRoundAoeUpdate.message_type = type_descriptors.MultiRoundAoeUpdateNO
field_descriptors.EventNO_multiRoundAoeUpdate.type = 11
field_descriptors.EventNO_multiRoundAoeUpdate.cpp_type = 10
field_descriptors.EventNO_multiRoundAoeRemove.name = "multiRoundAoeRemove"
field_descriptors.EventNO_multiRoundAoeRemove.full_name = ".EventNO.multiRoundAoeRemove"
field_descriptors.EventNO_multiRoundAoeRemove.number = 62
field_descriptors.EventNO_multiRoundAoeRemove.index = 56
field_descriptors.EventNO_multiRoundAoeRemove.label = 1
field_descriptors.EventNO_multiRoundAoeRemove.has_default_value = false
field_descriptors.EventNO_multiRoundAoeRemove.default_value = nil
field_descriptors.EventNO_multiRoundAoeRemove.message_type = type_descriptors.MultiRoundAoeRemoveNO
field_descriptors.EventNO_multiRoundAoeRemove.type = 11
field_descriptors.EventNO_multiRoundAoeRemove.cpp_type = 10
field_descriptors.EventNO_attributeRemoved.name = "attributeRemoved"
field_descriptors.EventNO_attributeRemoved.full_name = ".EventNO.attributeRemoved"
field_descriptors.EventNO_attributeRemoved.number = 63
field_descriptors.EventNO_attributeRemoved.index = 57
field_descriptors.EventNO_attributeRemoved.label = 1
field_descriptors.EventNO_attributeRemoved.has_default_value = false
field_descriptors.EventNO_attributeRemoved.default_value = nil
field_descriptors.EventNO_attributeRemoved.message_type = type_descriptors.AttributeModifiedEventNO
field_descriptors.EventNO_attributeRemoved.type = 11
field_descriptors.EventNO_attributeRemoved.cpp_type = 10
field_descriptors.EventNO_steppableChange.name = "steppableChange"
field_descriptors.EventNO_steppableChange.full_name = ".EventNO.steppableChange"
field_descriptors.EventNO_steppableChange.number = 64
field_descriptors.EventNO_steppableChange.index = 58
field_descriptors.EventNO_steppableChange.label = 1
field_descriptors.EventNO_steppableChange.has_default_value = false
field_descriptors.EventNO_steppableChange.default_value = nil
field_descriptors.EventNO_steppableChange.message_type = type_descriptors.SteppableChangeNO
field_descriptors.EventNO_steppableChange.type = 11
field_descriptors.EventNO_steppableChange.cpp_type = 10
field_descriptors.EventNO_weakPointRemoved.name = "weakPointRemoved"
field_descriptors.EventNO_weakPointRemoved.full_name = ".EventNO.weakPointRemoved"
field_descriptors.EventNO_weakPointRemoved.number = 65
field_descriptors.EventNO_weakPointRemoved.index = 59
field_descriptors.EventNO_weakPointRemoved.label = 1
field_descriptors.EventNO_weakPointRemoved.has_default_value = false
field_descriptors.EventNO_weakPointRemoved.default_value = nil
field_descriptors.EventNO_weakPointRemoved.message_type = type_descriptors.WeakPointRemovedEventNO
field_descriptors.EventNO_weakPointRemoved.type = 11
field_descriptors.EventNO_weakPointRemoved.cpp_type = 10
field_descriptors.EventNO_back.name = "back"
field_descriptors.EventNO_back.full_name = ".EventNO.back"
field_descriptors.EventNO_back.number = 66
field_descriptors.EventNO_back.index = 60
field_descriptors.EventNO_back.label = 1
field_descriptors.EventNO_back.has_default_value = false
field_descriptors.EventNO_back.default_value = nil
field_descriptors.EventNO_back.message_type = type_descriptors.BackEventNO
field_descriptors.EventNO_back.type = 11
field_descriptors.EventNO_back.cpp_type = 10
field_descriptors.EventNO_modelChanged.name = "modelChanged"
field_descriptors.EventNO_modelChanged.full_name = ".EventNO.modelChanged"
field_descriptors.EventNO_modelChanged.number = 67
field_descriptors.EventNO_modelChanged.index = 61
field_descriptors.EventNO_modelChanged.label = 1
field_descriptors.EventNO_modelChanged.has_default_value = false
field_descriptors.EventNO_modelChanged.default_value = nil
field_descriptors.EventNO_modelChanged.message_type = type_descriptors.ModelChangedNO
field_descriptors.EventNO_modelChanged.type = 11
field_descriptors.EventNO_modelChanged.cpp_type = 10
field_descriptors.EventNO_multiEntityHold.name = "multiEntityHold"
field_descriptors.EventNO_multiEntityHold.full_name = ".EventNO.multiEntityHold"
field_descriptors.EventNO_multiEntityHold.number = 68
field_descriptors.EventNO_multiEntityHold.index = 62
field_descriptors.EventNO_multiEntityHold.label = 1
field_descriptors.EventNO_multiEntityHold.has_default_value = false
field_descriptors.EventNO_multiEntityHold.default_value = nil
field_descriptors.EventNO_multiEntityHold.message_type = type_descriptors.MultiEntityHoldNO
field_descriptors.EventNO_multiEntityHold.type = 11
field_descriptors.EventNO_multiEntityHold.cpp_type = 10
field_descriptors.EventNO_ImmuneBuffAdd.name = "ImmuneBuffAdd"
field_descriptors.EventNO_ImmuneBuffAdd.full_name = ".EventNO.ImmuneBuffAdd"
field_descriptors.EventNO_ImmuneBuffAdd.number = 69
field_descriptors.EventNO_ImmuneBuffAdd.index = 63
field_descriptors.EventNO_ImmuneBuffAdd.label = 1
field_descriptors.EventNO_ImmuneBuffAdd.has_default_value = false
field_descriptors.EventNO_ImmuneBuffAdd.default_value = nil
field_descriptors.EventNO_ImmuneBuffAdd.message_type = type_descriptors.ImmuneBuffAddNO
field_descriptors.EventNO_ImmuneBuffAdd.type = 11
field_descriptors.EventNO_ImmuneBuffAdd.cpp_type = 10
field_descriptors.EventNO_ImmuneBuffRemove.name = "ImmuneBuffRemove"
field_descriptors.EventNO_ImmuneBuffRemove.full_name = ".EventNO.ImmuneBuffRemove"
field_descriptors.EventNO_ImmuneBuffRemove.number = 70
field_descriptors.EventNO_ImmuneBuffRemove.index = 64
field_descriptors.EventNO_ImmuneBuffRemove.label = 1
field_descriptors.EventNO_ImmuneBuffRemove.has_default_value = false
field_descriptors.EventNO_ImmuneBuffRemove.default_value = nil
field_descriptors.EventNO_ImmuneBuffRemove.message_type = type_descriptors.ImmuneBuffRemoveNO
field_descriptors.EventNO_ImmuneBuffRemove.type = 11
field_descriptors.EventNO_ImmuneBuffRemove.cpp_type = 10
field_descriptors.EventNO_aiModeChangeNO.name = "aiModeChangeNO"
field_descriptors.EventNO_aiModeChangeNO.full_name = ".EventNO.aiModeChangeNO"
field_descriptors.EventNO_aiModeChangeNO.number = 71
field_descriptors.EventNO_aiModeChangeNO.index = 65
field_descriptors.EventNO_aiModeChangeNO.label = 1
field_descriptors.EventNO_aiModeChangeNO.has_default_value = false
field_descriptors.EventNO_aiModeChangeNO.default_value = nil
field_descriptors.EventNO_aiModeChangeNO.message_type = type_descriptors.AiModeChangeNO
field_descriptors.EventNO_aiModeChangeNO.type = 11
field_descriptors.EventNO_aiModeChangeNO.cpp_type = 10
field_descriptors.EventNO_triggering.name = "triggering"
field_descriptors.EventNO_triggering.full_name = ".EventNO.triggering"
field_descriptors.EventNO_triggering.number = 72
field_descriptors.EventNO_triggering.index = 66
field_descriptors.EventNO_triggering.label = 3
field_descriptors.EventNO_triggering.has_default_value = false
field_descriptors.EventNO_triggering.default_value = {}
field_descriptors.EventNO_triggering.message_type = type_descriptors.TriggeringNO
field_descriptors.EventNO_triggering.type = 11
field_descriptors.EventNO_triggering.cpp_type = 10
field_descriptors.EventNO_airMessage.name = "airMessage"
field_descriptors.EventNO_airMessage.full_name = ".EventNO.airMessage"
field_descriptors.EventNO_airMessage.number = 73
field_descriptors.EventNO_airMessage.index = 67
field_descriptors.EventNO_airMessage.label = 3
field_descriptors.EventNO_airMessage.has_default_value = false
field_descriptors.EventNO_airMessage.default_value = {}
field_descriptors.EventNO_airMessage.message_type = type_descriptors.AirMessageNO
field_descriptors.EventNO_airMessage.type = 11
field_descriptors.EventNO_airMessage.cpp_type = 10
type_descriptors.EventNO.name = "EventNO"
type_descriptors.EventNO.full_name = ".EventNO"
type_descriptors.EventNO.nested_types = {}
type_descriptors.EventNO.enum_types = {}
type_descriptors.EventNO.fields = {
	field_descriptors.EventNO_stageStarted,
	field_descriptors.EventNO_stageEnded,
	field_descriptors.EventNO_battleEnded,
	field_descriptors.EventNO_skillTriggered,
	field_descriptors.EventNO_buffTriggered,
	field_descriptors.EventNO_attributeModified,
	field_descriptors.EventNO_buffAdded,
	field_descriptors.EventNO_buffRemoved,
	field_descriptors.EventNO_buffRoundDecred,
	field_descriptors.EventNO_cured,
	field_descriptors.EventNO_entityDead,
	field_descriptors.EventNO_entityStepped,
	field_descriptors.EventNO_weakPointHpChanged,
	field_descriptors.EventNO_positionChanged,
	field_descriptors.EventNO_entitiesAdded,
	field_descriptors.EventNO_entityRemoved,
	field_descriptors.EventNO_entitiesSwapped,
	field_descriptors.EventNO_roundStarted,
	field_descriptors.EventNO_plotChainTriggered,
	field_descriptors.EventNO_plotTriggered,
	field_descriptors.EventNO_damaged,
	field_descriptors.EventNO_stateAdded,
	field_descriptors.EventNO_stateRemoved,
	field_descriptors.EventNO_cellsBlocked,
	field_descriptors.EventNO_cellsUnblocked,
	field_descriptors.EventNO_cup,
	field_descriptors.EventNO_playerStarted,
	field_descriptors.EventNO_playerEnded,
	field_descriptors.EventNO_haloRefreshed,
	field_descriptors.EventNO_entityConfigChanged,
	field_descriptors.EventNO_taskTrigger,
	field_descriptors.EventNO_userReady,
	field_descriptors.EventNO_cancelReady,
	field_descriptors.EventNO_tacitTaskProgress,
	field_descriptors.EventNO_terrainChange,
	field_descriptors.EventNO_skillAdded,
	field_descriptors.EventNO_skillRemoved,
	field_descriptors.EventNO_entityPlayerChanged,
	field_descriptors.EventNO_wonConditionsChanged,
	field_descriptors.EventNO_terrainUpdated,
	field_descriptors.EventNO_skillCdUpdate,
	field_descriptors.EventNO_weakPointStatusChanged,
	field_descriptors.EventNO_weakPointAdded,
	field_descriptors.EventNO_groupEvent,
	field_descriptors.EventNO_plotTriggered3D,
	field_descriptors.EventNO_doomForecast,
	field_descriptors.EventNO_tag,
	field_descriptors.EventNO_tagWithBase,
	field_descriptors.EventNO_lightColumn,
	field_descriptors.EventNO_shoot,
	field_descriptors.EventNO_sheetMusic,
	field_descriptors.EventNO_pianoPlaying,
	field_descriptors.EventNO_tagEnhanceAdds,
	field_descriptors.EventNO_tagEnhanceRemoves,
	field_descriptors.EventNO_multiRoundAoeAdd,
	field_descriptors.EventNO_multiRoundAoeUpdate,
	field_descriptors.EventNO_multiRoundAoeRemove,
	field_descriptors.EventNO_attributeRemoved,
	field_descriptors.EventNO_steppableChange,
	field_descriptors.EventNO_weakPointRemoved,
	field_descriptors.EventNO_back,
	field_descriptors.EventNO_modelChanged,
	field_descriptors.EventNO_multiEntityHold,
	field_descriptors.EventNO_ImmuneBuffAdd,
	field_descriptors.EventNO_ImmuneBuffRemove,
	field_descriptors.EventNO_aiModeChangeNO,
	field_descriptors.EventNO_triggering,
	field_descriptors.EventNO_airMessage
}
type_descriptors.EventNO.is_extendable = false
type_descriptors.EventNO.extensions = {}
field_descriptors.GroupEventNO_events.name = "events"
field_descriptors.GroupEventNO_events.full_name = ".GroupEventNO.events"
field_descriptors.GroupEventNO_events.number = 1
field_descriptors.GroupEventNO_events.index = 0
field_descriptors.GroupEventNO_events.label = 3
field_descriptors.GroupEventNO_events.has_default_value = false
field_descriptors.GroupEventNO_events.default_value = {}
field_descriptors.GroupEventNO_events.message_type = type_descriptors.EventNO
field_descriptors.GroupEventNO_events.type = 11
field_descriptors.GroupEventNO_events.cpp_type = 10
field_descriptors.GroupEventNO_center.name = "center"
field_descriptors.GroupEventNO_center.full_name = ".GroupEventNO.center"
field_descriptors.GroupEventNO_center.number = 2
field_descriptors.GroupEventNO_center.index = 1
field_descriptors.GroupEventNO_center.label = 1
field_descriptors.GroupEventNO_center.has_default_value = false
field_descriptors.GroupEventNO_center.default_value = nil
field_descriptors.GroupEventNO_center.message_type = type_descriptors.CellNO
field_descriptors.GroupEventNO_center.type = 11
field_descriptors.GroupEventNO_center.cpp_type = 10
field_descriptors.GroupEventNO_direction.name = "direction"
field_descriptors.GroupEventNO_direction.full_name = ".GroupEventNO.direction"
field_descriptors.GroupEventNO_direction.number = 3
field_descriptors.GroupEventNO_direction.index = 2
field_descriptors.GroupEventNO_direction.label = 1
field_descriptors.GroupEventNO_direction.has_default_value = false
field_descriptors.GroupEventNO_direction.default_value = nil
field_descriptors.GroupEventNO_direction.message_type = type_descriptors.CellNO
field_descriptors.GroupEventNO_direction.type = 11
field_descriptors.GroupEventNO_direction.cpp_type = 10
type_descriptors.GroupEventNO.name = "GroupEventNO"
type_descriptors.GroupEventNO.full_name = ".GroupEventNO"
type_descriptors.GroupEventNO.nested_types = {}
type_descriptors.GroupEventNO.enum_types = {}
type_descriptors.GroupEventNO.fields = {
	field_descriptors.GroupEventNO_events,
	field_descriptors.GroupEventNO_center,
	field_descriptors.GroupEventNO_direction
}
type_descriptors.GroupEventNO.is_extendable = false
type_descriptors.GroupEventNO.extensions = {}
field_descriptors.ResultForecastPush_endReason.name = "endReason"
field_descriptors.ResultForecastPush_endReason.full_name = ".ResultForecastPush.endReason"
field_descriptors.ResultForecastPush_endReason.number = 1
field_descriptors.ResultForecastPush_endReason.index = 0
field_descriptors.ResultForecastPush_endReason.label = 1
field_descriptors.ResultForecastPush_endReason.has_default_value = false
field_descriptors.ResultForecastPush_endReason.default_value = ""
field_descriptors.ResultForecastPush_endReason.type = 9
field_descriptors.ResultForecastPush_endReason.cpp_type = 9
field_descriptors.ResultForecastPush_myEntity.name = "myEntity"
field_descriptors.ResultForecastPush_myEntity.full_name = ".ResultForecastPush.myEntity"
field_descriptors.ResultForecastPush_myEntity.number = 2
field_descriptors.ResultForecastPush_myEntity.index = 1
field_descriptors.ResultForecastPush_myEntity.label = 1
field_descriptors.ResultForecastPush_myEntity.has_default_value = false
field_descriptors.ResultForecastPush_myEntity.default_value = nil
field_descriptors.ResultForecastPush_myEntity.message_type = type_descriptors.EntityNO
field_descriptors.ResultForecastPush_myEntity.type = 11
field_descriptors.ResultForecastPush_myEntity.cpp_type = 10
field_descriptors.ResultForecastPush_targetEntity.name = "targetEntity"
field_descriptors.ResultForecastPush_targetEntity.full_name = ".ResultForecastPush.targetEntity"
field_descriptors.ResultForecastPush_targetEntity.number = 3
field_descriptors.ResultForecastPush_targetEntity.index = 2
field_descriptors.ResultForecastPush_targetEntity.label = 1
field_descriptors.ResultForecastPush_targetEntity.has_default_value = false
field_descriptors.ResultForecastPush_targetEntity.default_value = nil
field_descriptors.ResultForecastPush_targetEntity.message_type = type_descriptors.EntityNO
field_descriptors.ResultForecastPush_targetEntity.type = 11
field_descriptors.ResultForecastPush_targetEntity.cpp_type = 10
field_descriptors.ResultForecastPush_critical.name = "critical"
field_descriptors.ResultForecastPush_critical.full_name = ".ResultForecastPush.critical"
field_descriptors.ResultForecastPush_critical.number = 4
field_descriptors.ResultForecastPush_critical.index = 3
field_descriptors.ResultForecastPush_critical.label = 1
field_descriptors.ResultForecastPush_critical.has_default_value = false
field_descriptors.ResultForecastPush_critical.default_value = false
field_descriptors.ResultForecastPush_critical.type = 8
field_descriptors.ResultForecastPush_critical.cpp_type = 7
field_descriptors.ResultForecastPush_immunized.name = "immunized"
field_descriptors.ResultForecastPush_immunized.full_name = ".ResultForecastPush.immunized"
field_descriptors.ResultForecastPush_immunized.number = 5
field_descriptors.ResultForecastPush_immunized.index = 4
field_descriptors.ResultForecastPush_immunized.label = 1
field_descriptors.ResultForecastPush_immunized.has_default_value = false
field_descriptors.ResultForecastPush_immunized.default_value = false
field_descriptors.ResultForecastPush_immunized.type = 8
field_descriptors.ResultForecastPush_immunized.cpp_type = 7
field_descriptors.ResultForecastPush_near.name = "near"
field_descriptors.ResultForecastPush_near.full_name = ".ResultForecastPush.near"
field_descriptors.ResultForecastPush_near.number = 6
field_descriptors.ResultForecastPush_near.index = 5
field_descriptors.ResultForecastPush_near.label = 1
field_descriptors.ResultForecastPush_near.has_default_value = false
field_descriptors.ResultForecastPush_near.default_value = false
field_descriptors.ResultForecastPush_near.type = 8
field_descriptors.ResultForecastPush_near.cpp_type = 7
field_descriptors.ResultForecastPush_countered.name = "countered"
field_descriptors.ResultForecastPush_countered.full_name = ".ResultForecastPush.countered"
field_descriptors.ResultForecastPush_countered.number = 7
field_descriptors.ResultForecastPush_countered.index = 6
field_descriptors.ResultForecastPush_countered.label = 1
field_descriptors.ResultForecastPush_countered.has_default_value = false
field_descriptors.ResultForecastPush_countered.default_value = false
field_descriptors.ResultForecastPush_countered.type = 8
field_descriptors.ResultForecastPush_countered.cpp_type = 7
field_descriptors.ResultForecastPush_haloLinked.name = "haloLinked"
field_descriptors.ResultForecastPush_haloLinked.full_name = ".ResultForecastPush.haloLinked"
field_descriptors.ResultForecastPush_haloLinked.number = 8
field_descriptors.ResultForecastPush_haloLinked.index = 7
field_descriptors.ResultForecastPush_haloLinked.label = 3
field_descriptors.ResultForecastPush_haloLinked.has_default_value = false
field_descriptors.ResultForecastPush_haloLinked.default_value = {}
field_descriptors.ResultForecastPush_haloLinked.message_type = type_descriptors.HaloLinkedNO
field_descriptors.ResultForecastPush_haloLinked.type = 11
field_descriptors.ResultForecastPush_haloLinked.cpp_type = 10
field_descriptors.ResultForecastPush_haloUnlinked.name = "haloUnlinked"
field_descriptors.ResultForecastPush_haloUnlinked.full_name = ".ResultForecastPush.haloUnlinked"
field_descriptors.ResultForecastPush_haloUnlinked.number = 9
field_descriptors.ResultForecastPush_haloUnlinked.index = 8
field_descriptors.ResultForecastPush_haloUnlinked.label = 3
field_descriptors.ResultForecastPush_haloUnlinked.has_default_value = false
field_descriptors.ResultForecastPush_haloUnlinked.default_value = {}
field_descriptors.ResultForecastPush_haloUnlinked.message_type = type_descriptors.HaloLinkedNO
field_descriptors.ResultForecastPush_haloUnlinked.type = 11
field_descriptors.ResultForecastPush_haloUnlinked.cpp_type = 10
field_descriptors.ResultForecastPush_cellsBlocked.name = "cellsBlocked"
field_descriptors.ResultForecastPush_cellsBlocked.full_name = ".ResultForecastPush.cellsBlocked"
field_descriptors.ResultForecastPush_cellsBlocked.number = 10
field_descriptors.ResultForecastPush_cellsBlocked.index = 9
field_descriptors.ResultForecastPush_cellsBlocked.label = 1
field_descriptors.ResultForecastPush_cellsBlocked.has_default_value = false
field_descriptors.ResultForecastPush_cellsBlocked.default_value = nil
field_descriptors.ResultForecastPush_cellsBlocked.message_type = type_descriptors.CellsBlockedEventNO
field_descriptors.ResultForecastPush_cellsBlocked.type = 11
field_descriptors.ResultForecastPush_cellsBlocked.cpp_type = 10
field_descriptors.ResultForecastPush_cellsUnblocked.name = "cellsUnblocked"
field_descriptors.ResultForecastPush_cellsUnblocked.full_name = ".ResultForecastPush.cellsUnblocked"
field_descriptors.ResultForecastPush_cellsUnblocked.number = 11
field_descriptors.ResultForecastPush_cellsUnblocked.index = 10
field_descriptors.ResultForecastPush_cellsUnblocked.label = 1
field_descriptors.ResultForecastPush_cellsUnblocked.has_default_value = false
field_descriptors.ResultForecastPush_cellsUnblocked.default_value = nil
field_descriptors.ResultForecastPush_cellsUnblocked.message_type = type_descriptors.CellsBlockedEventNO
field_descriptors.ResultForecastPush_cellsUnblocked.type = 11
field_descriptors.ResultForecastPush_cellsUnblocked.cpp_type = 10
field_descriptors.ResultForecastPush_myDamagedValue.name = "myDamagedValue"
field_descriptors.ResultForecastPush_myDamagedValue.full_name = ".ResultForecastPush.myDamagedValue"
field_descriptors.ResultForecastPush_myDamagedValue.number = 12
field_descriptors.ResultForecastPush_myDamagedValue.index = 11
field_descriptors.ResultForecastPush_myDamagedValue.label = 1
field_descriptors.ResultForecastPush_myDamagedValue.has_default_value = false
field_descriptors.ResultForecastPush_myDamagedValue.default_value = 0
field_descriptors.ResultForecastPush_myDamagedValue.type = 5
field_descriptors.ResultForecastPush_myDamagedValue.cpp_type = 1
field_descriptors.ResultForecastPush_targetDamagedValue.name = "targetDamagedValue"
field_descriptors.ResultForecastPush_targetDamagedValue.full_name = ".ResultForecastPush.targetDamagedValue"
field_descriptors.ResultForecastPush_targetDamagedValue.number = 13
field_descriptors.ResultForecastPush_targetDamagedValue.index = 12
field_descriptors.ResultForecastPush_targetDamagedValue.label = 1
field_descriptors.ResultForecastPush_targetDamagedValue.has_default_value = false
field_descriptors.ResultForecastPush_targetDamagedValue.default_value = 0
field_descriptors.ResultForecastPush_targetDamagedValue.type = 5
field_descriptors.ResultForecastPush_targetDamagedValue.cpp_type = 1
field_descriptors.ResultForecastPush_secondaryTargetEntities.name = "secondaryTargetEntities"
field_descriptors.ResultForecastPush_secondaryTargetEntities.full_name = ".ResultForecastPush.secondaryTargetEntities"
field_descriptors.ResultForecastPush_secondaryTargetEntities.number = 14
field_descriptors.ResultForecastPush_secondaryTargetEntities.index = 13
field_descriptors.ResultForecastPush_secondaryTargetEntities.label = 3
field_descriptors.ResultForecastPush_secondaryTargetEntities.has_default_value = false
field_descriptors.ResultForecastPush_secondaryTargetEntities.default_value = {}
field_descriptors.ResultForecastPush_secondaryTargetEntities.message_type = type_descriptors.EntityNO
field_descriptors.ResultForecastPush_secondaryTargetEntities.type = 11
field_descriptors.ResultForecastPush_secondaryTargetEntities.cpp_type = 10
field_descriptors.ResultForecastPush_counteredCritically.name = "counteredCritically"
field_descriptors.ResultForecastPush_counteredCritically.full_name = ".ResultForecastPush.counteredCritically"
field_descriptors.ResultForecastPush_counteredCritically.number = 15
field_descriptors.ResultForecastPush_counteredCritically.index = 14
field_descriptors.ResultForecastPush_counteredCritically.label = 1
field_descriptors.ResultForecastPush_counteredCritically.has_default_value = false
field_descriptors.ResultForecastPush_counteredCritically.default_value = false
field_descriptors.ResultForecastPush_counteredCritically.type = 8
field_descriptors.ResultForecastPush_counteredCritically.cpp_type = 7
field_descriptors.ResultForecastPush_counteredImmunizedly.name = "counteredImmunizedly"
field_descriptors.ResultForecastPush_counteredImmunizedly.full_name = ".ResultForecastPush.counteredImmunizedly"
field_descriptors.ResultForecastPush_counteredImmunizedly.number = 16
field_descriptors.ResultForecastPush_counteredImmunizedly.index = 15
field_descriptors.ResultForecastPush_counteredImmunizedly.label = 1
field_descriptors.ResultForecastPush_counteredImmunizedly.has_default_value = false
field_descriptors.ResultForecastPush_counteredImmunizedly.default_value = false
field_descriptors.ResultForecastPush_counteredImmunizedly.type = 8
field_descriptors.ResultForecastPush_counteredImmunizedly.cpp_type = 7
field_descriptors.ResultForecastPush_counteredNear.name = "counteredNear"
field_descriptors.ResultForecastPush_counteredNear.full_name = ".ResultForecastPush.counteredNear"
field_descriptors.ResultForecastPush_counteredNear.number = 17
field_descriptors.ResultForecastPush_counteredNear.index = 16
field_descriptors.ResultForecastPush_counteredNear.label = 1
field_descriptors.ResultForecastPush_counteredNear.has_default_value = false
field_descriptors.ResultForecastPush_counteredNear.default_value = false
field_descriptors.ResultForecastPush_counteredNear.type = 8
field_descriptors.ResultForecastPush_counteredNear.cpp_type = 7
field_descriptors.ResultForecastPush_tags.name = "tags"
field_descriptors.ResultForecastPush_tags.full_name = ".ResultForecastPush.tags"
field_descriptors.ResultForecastPush_tags.number = 18
field_descriptors.ResultForecastPush_tags.index = 17
field_descriptors.ResultForecastPush_tags.label = 3
field_descriptors.ResultForecastPush_tags.has_default_value = false
field_descriptors.ResultForecastPush_tags.default_value = {}
field_descriptors.ResultForecastPush_tags.message_type = type_descriptors.ForecastTagNO
field_descriptors.ResultForecastPush_tags.type = 11
field_descriptors.ResultForecastPush_tags.cpp_type = 10
field_descriptors.ResultForecastPush_counterBeforeAttack.name = "counterBeforeAttack"
field_descriptors.ResultForecastPush_counterBeforeAttack.full_name = ".ResultForecastPush.counterBeforeAttack"
field_descriptors.ResultForecastPush_counterBeforeAttack.number = 19
field_descriptors.ResultForecastPush_counterBeforeAttack.index = 18
field_descriptors.ResultForecastPush_counterBeforeAttack.label = 1
field_descriptors.ResultForecastPush_counterBeforeAttack.has_default_value = false
field_descriptors.ResultForecastPush_counterBeforeAttack.default_value = false
field_descriptors.ResultForecastPush_counterBeforeAttack.type = 8
field_descriptors.ResultForecastPush_counterBeforeAttack.cpp_type = 7
type_descriptors.ResultForecastPush.name = "ResultForecastPush"
type_descriptors.ResultForecastPush.full_name = ".ResultForecastPush"
type_descriptors.ResultForecastPush.nested_types = {}
type_descriptors.ResultForecastPush.enum_types = {}
type_descriptors.ResultForecastPush.fields = {
	field_descriptors.ResultForecastPush_endReason,
	field_descriptors.ResultForecastPush_myEntity,
	field_descriptors.ResultForecastPush_targetEntity,
	field_descriptors.ResultForecastPush_critical,
	field_descriptors.ResultForecastPush_immunized,
	field_descriptors.ResultForecastPush_near,
	field_descriptors.ResultForecastPush_countered,
	field_descriptors.ResultForecastPush_haloLinked,
	field_descriptors.ResultForecastPush_haloUnlinked,
	field_descriptors.ResultForecastPush_cellsBlocked,
	field_descriptors.ResultForecastPush_cellsUnblocked,
	field_descriptors.ResultForecastPush_myDamagedValue,
	field_descriptors.ResultForecastPush_targetDamagedValue,
	field_descriptors.ResultForecastPush_secondaryTargetEntities,
	field_descriptors.ResultForecastPush_counteredCritically,
	field_descriptors.ResultForecastPush_counteredImmunizedly,
	field_descriptors.ResultForecastPush_counteredNear,
	field_descriptors.ResultForecastPush_tags,
	field_descriptors.ResultForecastPush_counterBeforeAttack
}
type_descriptors.ResultForecastPush.is_extendable = false
type_descriptors.ResultForecastPush.extensions = {}
field_descriptors.ReconnectBattleReply_battleInfo.name = "battleInfo"
field_descriptors.ReconnectBattleReply_battleInfo.full_name = ".ReconnectBattleReply.battleInfo"
field_descriptors.ReconnectBattleReply_battleInfo.number = 1
field_descriptors.ReconnectBattleReply_battleInfo.index = 0
field_descriptors.ReconnectBattleReply_battleInfo.label = 1
field_descriptors.ReconnectBattleReply_battleInfo.has_default_value = false
field_descriptors.ReconnectBattleReply_battleInfo.default_value = nil
field_descriptors.ReconnectBattleReply_battleInfo.message_type = type_descriptors.BattleInfoNO
field_descriptors.ReconnectBattleReply_battleInfo.type = 11
field_descriptors.ReconnectBattleReply_battleInfo.cpp_type = 10
type_descriptors.ReconnectBattleReply.name = "ReconnectBattleReply"
type_descriptors.ReconnectBattleReply.full_name = ".ReconnectBattleReply"
type_descriptors.ReconnectBattleReply.nested_types = {}
type_descriptors.ReconnectBattleReply.enum_types = {}
type_descriptors.ReconnectBattleReply.fields = {
	field_descriptors.ReconnectBattleReply_battleInfo
}
type_descriptors.ReconnectBattleReply.is_extendable = false
type_descriptors.ReconnectBattleReply.extensions = {}
field_descriptors.SectorNO_radius.name = "radius"
field_descriptors.SectorNO_radius.full_name = ".SectorNO.radius"
field_descriptors.SectorNO_radius.number = 1
field_descriptors.SectorNO_radius.index = 0
field_descriptors.SectorNO_radius.label = 1
field_descriptors.SectorNO_radius.has_default_value = false
field_descriptors.SectorNO_radius.default_value = 0
field_descriptors.SectorNO_radius.type = 5
field_descriptors.SectorNO_radius.cpp_type = 1
field_descriptors.SectorNO_direction.name = "direction"
field_descriptors.SectorNO_direction.full_name = ".SectorNO.direction"
field_descriptors.SectorNO_direction.number = 2
field_descriptors.SectorNO_direction.index = 1
field_descriptors.SectorNO_direction.label = 1
field_descriptors.SectorNO_direction.has_default_value = false
field_descriptors.SectorNO_direction.default_value = nil
field_descriptors.SectorNO_direction.message_type = type_descriptors.CellNO
field_descriptors.SectorNO_direction.type = 11
field_descriptors.SectorNO_direction.cpp_type = 10
type_descriptors.SectorNO.name = "SectorNO"
type_descriptors.SectorNO.full_name = ".SectorNO"
type_descriptors.SectorNO.nested_types = {}
type_descriptors.SectorNO.enum_types = {}
type_descriptors.SectorNO.fields = {
	field_descriptors.SectorNO_radius,
	field_descriptors.SectorNO_direction
}
type_descriptors.SectorNO.is_extendable = false
type_descriptors.SectorNO.extensions = {}
field_descriptors.MultiRoundAoeRemoveNO_aoe.name = "aoe"
field_descriptors.MultiRoundAoeRemoveNO_aoe.full_name = ".MultiRoundAoeRemoveNO.aoe"
field_descriptors.MultiRoundAoeRemoveNO_aoe.number = 1
field_descriptors.MultiRoundAoeRemoveNO_aoe.index = 0
field_descriptors.MultiRoundAoeRemoveNO_aoe.label = 1
field_descriptors.MultiRoundAoeRemoveNO_aoe.has_default_value = false
field_descriptors.MultiRoundAoeRemoveNO_aoe.default_value = nil
field_descriptors.MultiRoundAoeRemoveNO_aoe.message_type = type_descriptors.MultiRoundAoeNO
field_descriptors.MultiRoundAoeRemoveNO_aoe.type = 11
field_descriptors.MultiRoundAoeRemoveNO_aoe.cpp_type = 10
type_descriptors.MultiRoundAoeRemoveNO.name = "MultiRoundAoeRemoveNO"
type_descriptors.MultiRoundAoeRemoveNO.full_name = ".MultiRoundAoeRemoveNO"
type_descriptors.MultiRoundAoeRemoveNO.nested_types = {}
type_descriptors.MultiRoundAoeRemoveNO.enum_types = {}
type_descriptors.MultiRoundAoeRemoveNO.fields = {
	field_descriptors.MultiRoundAoeRemoveNO_aoe
}
type_descriptors.MultiRoundAoeRemoveNO.is_extendable = false
type_descriptors.MultiRoundAoeRemoveNO.extensions = {}
type_descriptors.RemoveEntityReply.name = "RemoveEntityReply"
type_descriptors.RemoveEntityReply.full_name = ".RemoveEntityReply"
type_descriptors.RemoveEntityReply.nested_types = {}
type_descriptors.RemoveEntityReply.enum_types = {}
type_descriptors.RemoveEntityReply.fields = {}
type_descriptors.RemoveEntityReply.is_extendable = false
type_descriptors.RemoveEntityReply.extensions = {}
field_descriptors.SkillChangedEventNO_entity.name = "entity"
field_descriptors.SkillChangedEventNO_entity.full_name = ".SkillChangedEventNO.entity"
field_descriptors.SkillChangedEventNO_entity.number = 1
field_descriptors.SkillChangedEventNO_entity.index = 0
field_descriptors.SkillChangedEventNO_entity.label = 1
field_descriptors.SkillChangedEventNO_entity.has_default_value = false
field_descriptors.SkillChangedEventNO_entity.default_value = 0
field_descriptors.SkillChangedEventNO_entity.type = 5
field_descriptors.SkillChangedEventNO_entity.cpp_type = 1
field_descriptors.SkillChangedEventNO_skill.name = "skill"
field_descriptors.SkillChangedEventNO_skill.full_name = ".SkillChangedEventNO.skill"
field_descriptors.SkillChangedEventNO_skill.number = 2
field_descriptors.SkillChangedEventNO_skill.index = 1
field_descriptors.SkillChangedEventNO_skill.label = 1
field_descriptors.SkillChangedEventNO_skill.has_default_value = false
field_descriptors.SkillChangedEventNO_skill.default_value = nil
field_descriptors.SkillChangedEventNO_skill.message_type = type_descriptors.SkillNO
field_descriptors.SkillChangedEventNO_skill.type = 11
field_descriptors.SkillChangedEventNO_skill.cpp_type = 10
type_descriptors.SkillChangedEventNO.name = "SkillChangedEventNO"
type_descriptors.SkillChangedEventNO.full_name = ".SkillChangedEventNO"
type_descriptors.SkillChangedEventNO.nested_types = {}
type_descriptors.SkillChangedEventNO.enum_types = {}
type_descriptors.SkillChangedEventNO.fields = {
	field_descriptors.SkillChangedEventNO_entity,
	field_descriptors.SkillChangedEventNO_skill
}
type_descriptors.SkillChangedEventNO.is_extendable = false
type_descriptors.SkillChangedEventNO.extensions = {}
type_descriptors.EndStageRequest.name = "EndStageRequest"
type_descriptors.EndStageRequest.full_name = ".EndStageRequest"
type_descriptors.EndStageRequest.nested_types = {}
type_descriptors.EndStageRequest.enum_types = {}
type_descriptors.EndStageRequest.fields = {}
type_descriptors.EndStageRequest.is_extendable = false
type_descriptors.EndStageRequest.extensions = {}
type_descriptors.MoveEntityReply.name = "MoveEntityReply"
type_descriptors.MoveEntityReply.full_name = ".MoveEntityReply"
type_descriptors.MoveEntityReply.nested_types = {}
type_descriptors.MoveEntityReply.enum_types = {}
type_descriptors.MoveEntityReply.fields = {}
type_descriptors.MoveEntityReply.is_extendable = false
type_descriptors.MoveEntityReply.extensions = {}
type_descriptors.CancelReadyRequest.name = "CancelReadyRequest"
type_descriptors.CancelReadyRequest.full_name = ".CancelReadyRequest"
type_descriptors.CancelReadyRequest.nested_types = {}
type_descriptors.CancelReadyRequest.enum_types = {}
type_descriptors.CancelReadyRequest.fields = {}
type_descriptors.CancelReadyRequest.is_extendable = false
type_descriptors.CancelReadyRequest.extensions = {}
field_descriptors.ShapeNO_circle.name = "circle"
field_descriptors.ShapeNO_circle.full_name = ".ShapeNO.circle"
field_descriptors.ShapeNO_circle.number = 1
field_descriptors.ShapeNO_circle.index = 0
field_descriptors.ShapeNO_circle.label = 1
field_descriptors.ShapeNO_circle.has_default_value = false
field_descriptors.ShapeNO_circle.default_value = nil
field_descriptors.ShapeNO_circle.message_type = type_descriptors.CircleNO
field_descriptors.ShapeNO_circle.type = 11
field_descriptors.ShapeNO_circle.cpp_type = 10
field_descriptors.ShapeNO_rhombus.name = "rhombus"
field_descriptors.ShapeNO_rhombus.full_name = ".ShapeNO.rhombus"
field_descriptors.ShapeNO_rhombus.number = 2
field_descriptors.ShapeNO_rhombus.index = 1
field_descriptors.ShapeNO_rhombus.label = 1
field_descriptors.ShapeNO_rhombus.has_default_value = false
field_descriptors.ShapeNO_rhombus.default_value = nil
field_descriptors.ShapeNO_rhombus.message_type = type_descriptors.RhombusNO
field_descriptors.ShapeNO_rhombus.type = 11
field_descriptors.ShapeNO_rhombus.cpp_type = 10
field_descriptors.ShapeNO_rectangle.name = "rectangle"
field_descriptors.ShapeNO_rectangle.full_name = ".ShapeNO.rectangle"
field_descriptors.ShapeNO_rectangle.number = 3
field_descriptors.ShapeNO_rectangle.index = 2
field_descriptors.ShapeNO_rectangle.label = 1
field_descriptors.ShapeNO_rectangle.has_default_value = false
field_descriptors.ShapeNO_rectangle.default_value = nil
field_descriptors.ShapeNO_rectangle.message_type = type_descriptors.RectangleNO
field_descriptors.ShapeNO_rectangle.type = 11
field_descriptors.ShapeNO_rectangle.cpp_type = 10
field_descriptors.ShapeNO_point.name = "point"
field_descriptors.ShapeNO_point.full_name = ".ShapeNO.point"
field_descriptors.ShapeNO_point.number = 4
field_descriptors.ShapeNO_point.index = 3
field_descriptors.ShapeNO_point.label = 1
field_descriptors.ShapeNO_point.has_default_value = false
field_descriptors.ShapeNO_point.default_value = nil
field_descriptors.ShapeNO_point.message_type = type_descriptors.PointNO
field_descriptors.ShapeNO_point.type = 11
field_descriptors.ShapeNO_point.cpp_type = 10
field_descriptors.ShapeNO_wholeBattleBoard.name = "wholeBattleBoard"
field_descriptors.ShapeNO_wholeBattleBoard.full_name = ".ShapeNO.wholeBattleBoard"
field_descriptors.ShapeNO_wholeBattleBoard.number = 5
field_descriptors.ShapeNO_wholeBattleBoard.index = 4
field_descriptors.ShapeNO_wholeBattleBoard.label = 1
field_descriptors.ShapeNO_wholeBattleBoard.has_default_value = false
field_descriptors.ShapeNO_wholeBattleBoard.default_value = nil
field_descriptors.ShapeNO_wholeBattleBoard.message_type = type_descriptors.WholeBattleBoardNO
field_descriptors.ShapeNO_wholeBattleBoard.type = 11
field_descriptors.ShapeNO_wholeBattleBoard.cpp_type = 10
field_descriptors.ShapeNO_sector.name = "sector"
field_descriptors.ShapeNO_sector.full_name = ".ShapeNO.sector"
field_descriptors.ShapeNO_sector.number = 6
field_descriptors.ShapeNO_sector.index = 5
field_descriptors.ShapeNO_sector.label = 1
field_descriptors.ShapeNO_sector.has_default_value = false
field_descriptors.ShapeNO_sector.default_value = nil
field_descriptors.ShapeNO_sector.message_type = type_descriptors.SectorNO
field_descriptors.ShapeNO_sector.type = 11
field_descriptors.ShapeNO_sector.cpp_type = 10
field_descriptors.ShapeNO_multipleShape.name = "multipleShape"
field_descriptors.ShapeNO_multipleShape.full_name = ".ShapeNO.multipleShape"
field_descriptors.ShapeNO_multipleShape.number = 7
field_descriptors.ShapeNO_multipleShape.index = 6
field_descriptors.ShapeNO_multipleShape.label = 1
field_descriptors.ShapeNO_multipleShape.has_default_value = false
field_descriptors.ShapeNO_multipleShape.default_value = nil
field_descriptors.ShapeNO_multipleShape.message_type = type_descriptors.MultipleShapeNO
field_descriptors.ShapeNO_multipleShape.type = 11
field_descriptors.ShapeNO_multipleShape.cpp_type = 10
field_descriptors.ShapeNO_cells.name = "cells"
field_descriptors.ShapeNO_cells.full_name = ".ShapeNO.cells"
field_descriptors.ShapeNO_cells.number = 8
field_descriptors.ShapeNO_cells.index = 7
field_descriptors.ShapeNO_cells.label = 3
field_descriptors.ShapeNO_cells.has_default_value = false
field_descriptors.ShapeNO_cells.default_value = {}
field_descriptors.ShapeNO_cells.message_type = type_descriptors.CellNO
field_descriptors.ShapeNO_cells.type = 11
field_descriptors.ShapeNO_cells.cpp_type = 10
field_descriptors.ShapeNO_crossLine.name = "crossLine"
field_descriptors.ShapeNO_crossLine.full_name = ".ShapeNO.crossLine"
field_descriptors.ShapeNO_crossLine.number = 9
field_descriptors.ShapeNO_crossLine.index = 8
field_descriptors.ShapeNO_crossLine.label = 1
field_descriptors.ShapeNO_crossLine.has_default_value = false
field_descriptors.ShapeNO_crossLine.default_value = nil
field_descriptors.ShapeNO_crossLine.message_type = type_descriptors.CrossLineNO
field_descriptors.ShapeNO_crossLine.type = 11
field_descriptors.ShapeNO_crossLine.cpp_type = 10
field_descriptors.ShapeNO_parallelRectangle.name = "parallelRectangle"
field_descriptors.ShapeNO_parallelRectangle.full_name = ".ShapeNO.parallelRectangle"
field_descriptors.ShapeNO_parallelRectangle.number = 10
field_descriptors.ShapeNO_parallelRectangle.index = 9
field_descriptors.ShapeNO_parallelRectangle.label = 1
field_descriptors.ShapeNO_parallelRectangle.has_default_value = false
field_descriptors.ShapeNO_parallelRectangle.default_value = nil
field_descriptors.ShapeNO_parallelRectangle.message_type = type_descriptors.ParallelRectangleNO
field_descriptors.ShapeNO_parallelRectangle.type = 11
field_descriptors.ShapeNO_parallelRectangle.cpp_type = 10
field_descriptors.ShapeNO_modelRectangle.name = "modelRectangle"
field_descriptors.ShapeNO_modelRectangle.full_name = ".ShapeNO.modelRectangle"
field_descriptors.ShapeNO_modelRectangle.number = 11
field_descriptors.ShapeNO_modelRectangle.index = 10
field_descriptors.ShapeNO_modelRectangle.label = 1
field_descriptors.ShapeNO_modelRectangle.has_default_value = false
field_descriptors.ShapeNO_modelRectangle.default_value = nil
field_descriptors.ShapeNO_modelRectangle.message_type = type_descriptors.ModelRectangleNO
field_descriptors.ShapeNO_modelRectangle.type = 11
field_descriptors.ShapeNO_modelRectangle.cpp_type = 10
field_descriptors.ShapeNO_line.name = "line"
field_descriptors.ShapeNO_line.full_name = ".ShapeNO.line"
field_descriptors.ShapeNO_line.number = 12
field_descriptors.ShapeNO_line.index = 11
field_descriptors.ShapeNO_line.label = 1
field_descriptors.ShapeNO_line.has_default_value = false
field_descriptors.ShapeNO_line.default_value = nil
field_descriptors.ShapeNO_line.message_type = type_descriptors.LineNO
field_descriptors.ShapeNO_line.type = 11
field_descriptors.ShapeNO_line.cpp_type = 10
field_descriptors.ShapeNO_linkLine.name = "linkLine"
field_descriptors.ShapeNO_linkLine.full_name = ".ShapeNO.linkLine"
field_descriptors.ShapeNO_linkLine.number = 13
field_descriptors.ShapeNO_linkLine.index = 12
field_descriptors.ShapeNO_linkLine.label = 1
field_descriptors.ShapeNO_linkLine.has_default_value = false
field_descriptors.ShapeNO_linkLine.default_value = nil
field_descriptors.ShapeNO_linkLine.message_type = type_descriptors.LinkLineNO
field_descriptors.ShapeNO_linkLine.type = 11
field_descriptors.ShapeNO_linkLine.cpp_type = 10
type_descriptors.ShapeNO.name = "ShapeNO"
type_descriptors.ShapeNO.full_name = ".ShapeNO"
type_descriptors.ShapeNO.nested_types = {}
type_descriptors.ShapeNO.enum_types = {}
type_descriptors.ShapeNO.fields = {
	field_descriptors.ShapeNO_circle,
	field_descriptors.ShapeNO_rhombus,
	field_descriptors.ShapeNO_rectangle,
	field_descriptors.ShapeNO_point,
	field_descriptors.ShapeNO_wholeBattleBoard,
	field_descriptors.ShapeNO_sector,
	field_descriptors.ShapeNO_multipleShape,
	field_descriptors.ShapeNO_cells,
	field_descriptors.ShapeNO_crossLine,
	field_descriptors.ShapeNO_parallelRectangle,
	field_descriptors.ShapeNO_modelRectangle,
	field_descriptors.ShapeNO_line,
	field_descriptors.ShapeNO_linkLine
}
type_descriptors.ShapeNO.is_extendable = false
type_descriptors.ShapeNO.extensions = {}
field_descriptors.SkillCdNO_skill.name = "skill"
field_descriptors.SkillCdNO_skill.full_name = ".SkillCdNO.skill"
field_descriptors.SkillCdNO_skill.number = 1
field_descriptors.SkillCdNO_skill.index = 0
field_descriptors.SkillCdNO_skill.label = 1
field_descriptors.SkillCdNO_skill.has_default_value = false
field_descriptors.SkillCdNO_skill.default_value = 0
field_descriptors.SkillCdNO_skill.type = 5
field_descriptors.SkillCdNO_skill.cpp_type = 1
field_descriptors.SkillCdNO_cd.name = "cd"
field_descriptors.SkillCdNO_cd.full_name = ".SkillCdNO.cd"
field_descriptors.SkillCdNO_cd.number = 2
field_descriptors.SkillCdNO_cd.index = 1
field_descriptors.SkillCdNO_cd.label = 1
field_descriptors.SkillCdNO_cd.has_default_value = false
field_descriptors.SkillCdNO_cd.default_value = 0
field_descriptors.SkillCdNO_cd.type = 5
field_descriptors.SkillCdNO_cd.cpp_type = 1
type_descriptors.SkillCdNO.name = "SkillCdNO"
type_descriptors.SkillCdNO.full_name = ".SkillCdNO"
type_descriptors.SkillCdNO.nested_types = {}
type_descriptors.SkillCdNO.enum_types = {}
type_descriptors.SkillCdNO.fields = {
	field_descriptors.SkillCdNO_skill,
	field_descriptors.SkillCdNO_cd
}
type_descriptors.SkillCdNO.is_extendable = false
type_descriptors.SkillCdNO.extensions = {}
field_descriptors.PvpPlayerNO_playerId.name = "playerId"
field_descriptors.PvpPlayerNO_playerId.full_name = ".PvpPlayerNO.playerId"
field_descriptors.PvpPlayerNO_playerId.number = 1
field_descriptors.PvpPlayerNO_playerId.index = 0
field_descriptors.PvpPlayerNO_playerId.label = 2
field_descriptors.PvpPlayerNO_playerId.has_default_value = false
field_descriptors.PvpPlayerNO_playerId.default_value = 0
field_descriptors.PvpPlayerNO_playerId.type = 5
field_descriptors.PvpPlayerNO_playerId.cpp_type = 1
field_descriptors.PvpPlayerNO_teamId.name = "teamId"
field_descriptors.PvpPlayerNO_teamId.full_name = ".PvpPlayerNO.teamId"
field_descriptors.PvpPlayerNO_teamId.number = 2
field_descriptors.PvpPlayerNO_teamId.index = 1
field_descriptors.PvpPlayerNO_teamId.label = 2
field_descriptors.PvpPlayerNO_teamId.has_default_value = false
field_descriptors.PvpPlayerNO_teamId.default_value = 0
field_descriptors.PvpPlayerNO_teamId.type = 5
field_descriptors.PvpPlayerNO_teamId.cpp_type = 1
field_descriptors.PvpPlayerNO_userId.name = "userId"
field_descriptors.PvpPlayerNO_userId.full_name = ".PvpPlayerNO.userId"
field_descriptors.PvpPlayerNO_userId.number = 3
field_descriptors.PvpPlayerNO_userId.index = 2
field_descriptors.PvpPlayerNO_userId.label = 2
field_descriptors.PvpPlayerNO_userId.has_default_value = false
field_descriptors.PvpPlayerNO_userId.default_value = 0
field_descriptors.PvpPlayerNO_userId.type = 3
field_descriptors.PvpPlayerNO_userId.cpp_type = 2
type_descriptors.PvpPlayerNO.name = "PvpPlayerNO"
type_descriptors.PvpPlayerNO.full_name = ".PvpPlayerNO"
type_descriptors.PvpPlayerNO.nested_types = {}
type_descriptors.PvpPlayerNO.enum_types = {}
type_descriptors.PvpPlayerNO.fields = {
	field_descriptors.PvpPlayerNO_playerId,
	field_descriptors.PvpPlayerNO_teamId,
	field_descriptors.PvpPlayerNO_userId
}
type_descriptors.PvpPlayerNO.is_extendable = false
type_descriptors.PvpPlayerNO.extensions = {}
field_descriptors.TagEventWithBaseNO_base.name = "base"
field_descriptors.TagEventWithBaseNO_base.full_name = ".TagEventWithBaseNO.base"
field_descriptors.TagEventWithBaseNO_base.number = 1
field_descriptors.TagEventWithBaseNO_base.index = 0
field_descriptors.TagEventWithBaseNO_base.label = 1
field_descriptors.TagEventWithBaseNO_base.has_default_value = false
field_descriptors.TagEventWithBaseNO_base.default_value = nil
field_descriptors.TagEventWithBaseNO_base.message_type = type_descriptors.TagBaseNO
field_descriptors.TagEventWithBaseNO_base.type = 11
field_descriptors.TagEventWithBaseNO_base.cpp_type = 10
field_descriptors.TagEventWithBaseNO_events.name = "events"
field_descriptors.TagEventWithBaseNO_events.full_name = ".TagEventWithBaseNO.events"
field_descriptors.TagEventWithBaseNO_events.number = 2
field_descriptors.TagEventWithBaseNO_events.index = 1
field_descriptors.TagEventWithBaseNO_events.label = 3
field_descriptors.TagEventWithBaseNO_events.has_default_value = false
field_descriptors.TagEventWithBaseNO_events.default_value = {}
field_descriptors.TagEventWithBaseNO_events.message_type = type_descriptors.EventNO
field_descriptors.TagEventWithBaseNO_events.type = 11
field_descriptors.TagEventWithBaseNO_events.cpp_type = 10
type_descriptors.TagEventWithBaseNO.name = "TagEventWithBaseNO"
type_descriptors.TagEventWithBaseNO.full_name = ".TagEventWithBaseNO"
type_descriptors.TagEventWithBaseNO.nested_types = {}
type_descriptors.TagEventWithBaseNO.enum_types = {}
type_descriptors.TagEventWithBaseNO.fields = {
	field_descriptors.TagEventWithBaseNO_base,
	field_descriptors.TagEventWithBaseNO_events
}
type_descriptors.TagEventWithBaseNO.is_extendable = false
type_descriptors.TagEventWithBaseNO.extensions = {}
field_descriptors.WeakPointStatusChangedEventNO_entity.name = "entity"
field_descriptors.WeakPointStatusChangedEventNO_entity.full_name = ".WeakPointStatusChangedEventNO.entity"
field_descriptors.WeakPointStatusChangedEventNO_entity.number = 1
field_descriptors.WeakPointStatusChangedEventNO_entity.index = 0
field_descriptors.WeakPointStatusChangedEventNO_entity.label = 1
field_descriptors.WeakPointStatusChangedEventNO_entity.has_default_value = false
field_descriptors.WeakPointStatusChangedEventNO_entity.default_value = 0
field_descriptors.WeakPointStatusChangedEventNO_entity.type = 5
field_descriptors.WeakPointStatusChangedEventNO_entity.cpp_type = 1
field_descriptors.WeakPointStatusChangedEventNO_type.name = "type"
field_descriptors.WeakPointStatusChangedEventNO_type.full_name = ".WeakPointStatusChangedEventNO.type"
field_descriptors.WeakPointStatusChangedEventNO_type.number = 2
field_descriptors.WeakPointStatusChangedEventNO_type.index = 1
field_descriptors.WeakPointStatusChangedEventNO_type.label = 1
field_descriptors.WeakPointStatusChangedEventNO_type.has_default_value = false
field_descriptors.WeakPointStatusChangedEventNO_type.default_value = 0
field_descriptors.WeakPointStatusChangedEventNO_type.type = 5
field_descriptors.WeakPointStatusChangedEventNO_type.cpp_type = 1
field_descriptors.WeakPointStatusChangedEventNO_effects.name = "effects"
field_descriptors.WeakPointStatusChangedEventNO_effects.full_name = ".WeakPointStatusChangedEventNO.effects"
field_descriptors.WeakPointStatusChangedEventNO_effects.number = 3
field_descriptors.WeakPointStatusChangedEventNO_effects.index = 2
field_descriptors.WeakPointStatusChangedEventNO_effects.label = 3
field_descriptors.WeakPointStatusChangedEventNO_effects.has_default_value = false
field_descriptors.WeakPointStatusChangedEventNO_effects.default_value = {}
field_descriptors.WeakPointStatusChangedEventNO_effects.message_type = type_descriptors.EventNO
field_descriptors.WeakPointStatusChangedEventNO_effects.type = 11
field_descriptors.WeakPointStatusChangedEventNO_effects.cpp_type = 10
type_descriptors.WeakPointStatusChangedEventNO.name = "WeakPointStatusChangedEventNO"
type_descriptors.WeakPointStatusChangedEventNO.full_name = ".WeakPointStatusChangedEventNO"
type_descriptors.WeakPointStatusChangedEventNO.nested_types = {}
type_descriptors.WeakPointStatusChangedEventNO.enum_types = {}
type_descriptors.WeakPointStatusChangedEventNO.fields = {
	field_descriptors.WeakPointStatusChangedEventNO_entity,
	field_descriptors.WeakPointStatusChangedEventNO_type,
	field_descriptors.WeakPointStatusChangedEventNO_effects
}
type_descriptors.WeakPointStatusChangedEventNO.is_extendable = false
type_descriptors.WeakPointStatusChangedEventNO.extensions = {}
field_descriptors.SkillCdUpdateEventNO_entity.name = "entity"
field_descriptors.SkillCdUpdateEventNO_entity.full_name = ".SkillCdUpdateEventNO.entity"
field_descriptors.SkillCdUpdateEventNO_entity.number = 1
field_descriptors.SkillCdUpdateEventNO_entity.index = 0
field_descriptors.SkillCdUpdateEventNO_entity.label = 1
field_descriptors.SkillCdUpdateEventNO_entity.has_default_value = false
field_descriptors.SkillCdUpdateEventNO_entity.default_value = 0
field_descriptors.SkillCdUpdateEventNO_entity.type = 5
field_descriptors.SkillCdUpdateEventNO_entity.cpp_type = 1
field_descriptors.SkillCdUpdateEventNO_skills.name = "skills"
field_descriptors.SkillCdUpdateEventNO_skills.full_name = ".SkillCdUpdateEventNO.skills"
field_descriptors.SkillCdUpdateEventNO_skills.number = 2
field_descriptors.SkillCdUpdateEventNO_skills.index = 1
field_descriptors.SkillCdUpdateEventNO_skills.label = 3
field_descriptors.SkillCdUpdateEventNO_skills.has_default_value = false
field_descriptors.SkillCdUpdateEventNO_skills.default_value = {}
field_descriptors.SkillCdUpdateEventNO_skills.message_type = type_descriptors.SkillCdNO
field_descriptors.SkillCdUpdateEventNO_skills.type = 11
field_descriptors.SkillCdUpdateEventNO_skills.cpp_type = 10
type_descriptors.SkillCdUpdateEventNO.name = "SkillCdUpdateEventNO"
type_descriptors.SkillCdUpdateEventNO.full_name = ".SkillCdUpdateEventNO"
type_descriptors.SkillCdUpdateEventNO.nested_types = {}
type_descriptors.SkillCdUpdateEventNO.enum_types = {}
type_descriptors.SkillCdUpdateEventNO.fields = {
	field_descriptors.SkillCdUpdateEventNO_entity,
	field_descriptors.SkillCdUpdateEventNO_skills
}
type_descriptors.SkillCdUpdateEventNO.is_extendable = false
type_descriptors.SkillCdUpdateEventNO.extensions = {}
field_descriptors.StateChangedEventNO_entity.name = "entity"
field_descriptors.StateChangedEventNO_entity.full_name = ".StateChangedEventNO.entity"
field_descriptors.StateChangedEventNO_entity.number = 1
field_descriptors.StateChangedEventNO_entity.index = 0
field_descriptors.StateChangedEventNO_entity.label = 1
field_descriptors.StateChangedEventNO_entity.has_default_value = false
field_descriptors.StateChangedEventNO_entity.default_value = 0
field_descriptors.StateChangedEventNO_entity.type = 5
field_descriptors.StateChangedEventNO_entity.cpp_type = 1
field_descriptors.StateChangedEventNO_state.name = "state"
field_descriptors.StateChangedEventNO_state.full_name = ".StateChangedEventNO.state"
field_descriptors.StateChangedEventNO_state.number = 2
field_descriptors.StateChangedEventNO_state.index = 1
field_descriptors.StateChangedEventNO_state.label = 1
field_descriptors.StateChangedEventNO_state.has_default_value = false
field_descriptors.StateChangedEventNO_state.default_value = nil
field_descriptors.StateChangedEventNO_state.enum_type = type_descriptors.State
field_descriptors.StateChangedEventNO_state.type = 14
field_descriptors.StateChangedEventNO_state.cpp_type = 8
type_descriptors.StateChangedEventNO.name = "StateChangedEventNO"
type_descriptors.StateChangedEventNO.full_name = ".StateChangedEventNO"
type_descriptors.StateChangedEventNO.nested_types = {}
type_descriptors.StateChangedEventNO.enum_types = {}
type_descriptors.StateChangedEventNO.fields = {
	field_descriptors.StateChangedEventNO_entity,
	field_descriptors.StateChangedEventNO_state
}
type_descriptors.StateChangedEventNO.is_extendable = false
type_descriptors.StateChangedEventNO.extensions = {}
field_descriptors.FractionNO_numerator.name = "numerator"
field_descriptors.FractionNO_numerator.full_name = ".FractionNO.numerator"
field_descriptors.FractionNO_numerator.number = 1
field_descriptors.FractionNO_numerator.index = 0
field_descriptors.FractionNO_numerator.label = 1
field_descriptors.FractionNO_numerator.has_default_value = false
field_descriptors.FractionNO_numerator.default_value = 0
field_descriptors.FractionNO_numerator.type = 5
field_descriptors.FractionNO_numerator.cpp_type = 1
field_descriptors.FractionNO_denominator.name = "denominator"
field_descriptors.FractionNO_denominator.full_name = ".FractionNO.denominator"
field_descriptors.FractionNO_denominator.number = 2
field_descriptors.FractionNO_denominator.index = 1
field_descriptors.FractionNO_denominator.label = 1
field_descriptors.FractionNO_denominator.has_default_value = false
field_descriptors.FractionNO_denominator.default_value = 0
field_descriptors.FractionNO_denominator.type = 5
field_descriptors.FractionNO_denominator.cpp_type = 1
type_descriptors.FractionNO.name = "FractionNO"
type_descriptors.FractionNO.full_name = ".FractionNO"
type_descriptors.FractionNO.nested_types = {}
type_descriptors.FractionNO.enum_types = {}
type_descriptors.FractionNO.fields = {
	field_descriptors.FractionNO_numerator,
	field_descriptors.FractionNO_denominator
}
type_descriptors.FractionNO.is_extendable = false
type_descriptors.FractionNO.extensions = {}
type_descriptors.ConnectCompleteRequest.name = "ConnectCompleteRequest"
type_descriptors.ConnectCompleteRequest.full_name = ".ConnectCompleteRequest"
type_descriptors.ConnectCompleteRequest.nested_types = {}
type_descriptors.ConnectCompleteRequest.enum_types = {}
type_descriptors.ConnectCompleteRequest.fields = {}
type_descriptors.ConnectCompleteRequest.is_extendable = false
type_descriptors.ConnectCompleteRequest.extensions = {}
type_descriptors.ReconnectBattleRequest.name = "ReconnectBattleRequest"
type_descriptors.ReconnectBattleRequest.full_name = ".ReconnectBattleRequest"
type_descriptors.ReconnectBattleRequest.nested_types = {}
type_descriptors.ReconnectBattleRequest.enum_types = {}
type_descriptors.ReconnectBattleRequest.fields = {}
type_descriptors.ReconnectBattleRequest.is_extendable = false
type_descriptors.ReconnectBattleRequest.extensions = {}
field_descriptors.PositionChangedEventNO_method.name = "method"
field_descriptors.PositionChangedEventNO_method.full_name = ".PositionChangedEventNO.method"
field_descriptors.PositionChangedEventNO_method.number = 1
field_descriptors.PositionChangedEventNO_method.index = 0
field_descriptors.PositionChangedEventNO_method.label = 1
field_descriptors.PositionChangedEventNO_method.has_default_value = false
field_descriptors.PositionChangedEventNO_method.default_value = nil
field_descriptors.PositionChangedEventNO_method.enum_type = type_descriptors.PositionChangingMethod
field_descriptors.PositionChangedEventNO_method.type = 14
field_descriptors.PositionChangedEventNO_method.cpp_type = 8
field_descriptors.PositionChangedEventNO_entities.name = "entities"
field_descriptors.PositionChangedEventNO_entities.full_name = ".PositionChangedEventNO.entities"
field_descriptors.PositionChangedEventNO_entities.number = 2
field_descriptors.PositionChangedEventNO_entities.index = 1
field_descriptors.PositionChangedEventNO_entities.label = 3
field_descriptors.PositionChangedEventNO_entities.has_default_value = false
field_descriptors.PositionChangedEventNO_entities.default_value = {}
field_descriptors.PositionChangedEventNO_entities.message_type = type_descriptors.EntityNO
field_descriptors.PositionChangedEventNO_entities.type = 11
field_descriptors.PositionChangedEventNO_entities.cpp_type = 10
field_descriptors.PositionChangedEventNO_refCell.name = "refCell"
field_descriptors.PositionChangedEventNO_refCell.full_name = ".PositionChangedEventNO.refCell"
field_descriptors.PositionChangedEventNO_refCell.number = 3
field_descriptors.PositionChangedEventNO_refCell.index = 2
field_descriptors.PositionChangedEventNO_refCell.label = 1
field_descriptors.PositionChangedEventNO_refCell.has_default_value = false
field_descriptors.PositionChangedEventNO_refCell.default_value = nil
field_descriptors.PositionChangedEventNO_refCell.message_type = type_descriptors.CellNO
field_descriptors.PositionChangedEventNO_refCell.type = 11
field_descriptors.PositionChangedEventNO_refCell.cpp_type = 10
type_descriptors.PositionChangedEventNO.name = "PositionChangedEventNO"
type_descriptors.PositionChangedEventNO.full_name = ".PositionChangedEventNO"
type_descriptors.PositionChangedEventNO.nested_types = {}
type_descriptors.PositionChangedEventNO.enum_types = {}
type_descriptors.PositionChangedEventNO.fields = {
	field_descriptors.PositionChangedEventNO_method,
	field_descriptors.PositionChangedEventNO_entities,
	field_descriptors.PositionChangedEventNO_refCell
}
type_descriptors.PositionChangedEventNO.is_extendable = false
type_descriptors.PositionChangedEventNO.extensions = {}
field_descriptors.EntityRemovedNO_id.name = "id"
field_descriptors.EntityRemovedNO_id.full_name = ".EntityRemovedNO.id"
field_descriptors.EntityRemovedNO_id.number = 1
field_descriptors.EntityRemovedNO_id.index = 0
field_descriptors.EntityRemovedNO_id.label = 1
field_descriptors.EntityRemovedNO_id.has_default_value = false
field_descriptors.EntityRemovedNO_id.default_value = 0
field_descriptors.EntityRemovedNO_id.type = 5
field_descriptors.EntityRemovedNO_id.cpp_type = 1
field_descriptors.EntityRemovedNO_reason.name = "reason"
field_descriptors.EntityRemovedNO_reason.full_name = ".EntityRemovedNO.reason"
field_descriptors.EntityRemovedNO_reason.number = 2
field_descriptors.EntityRemovedNO_reason.index = 1
field_descriptors.EntityRemovedNO_reason.label = 1
field_descriptors.EntityRemovedNO_reason.has_default_value = false
field_descriptors.EntityRemovedNO_reason.default_value = nil
field_descriptors.EntityRemovedNO_reason.enum_type = type_descriptors.RemoveReason
field_descriptors.EntityRemovedNO_reason.type = 14
field_descriptors.EntityRemovedNO_reason.cpp_type = 8
type_descriptors.EntityRemovedNO.name = "EntityRemovedNO"
type_descriptors.EntityRemovedNO.full_name = ".EntityRemovedNO"
type_descriptors.EntityRemovedNO.nested_types = {}
type_descriptors.EntityRemovedNO.enum_types = {}
type_descriptors.EntityRemovedNO.fields = {
	field_descriptors.EntityRemovedNO_id,
	field_descriptors.EntityRemovedNO_reason
}
type_descriptors.EntityRemovedNO.is_extendable = false
type_descriptors.EntityRemovedNO.extensions = {}
field_descriptors.PlaceEntityRequest_placeEntities.name = "placeEntities"
field_descriptors.PlaceEntityRequest_placeEntities.full_name = ".PlaceEntityRequest.placeEntities"
field_descriptors.PlaceEntityRequest_placeEntities.number = 1
field_descriptors.PlaceEntityRequest_placeEntities.index = 0
field_descriptors.PlaceEntityRequest_placeEntities.label = 3
field_descriptors.PlaceEntityRequest_placeEntities.has_default_value = false
field_descriptors.PlaceEntityRequest_placeEntities.default_value = {}
field_descriptors.PlaceEntityRequest_placeEntities.message_type = type_descriptors.PlaceEntityNO
field_descriptors.PlaceEntityRequest_placeEntities.type = 11
field_descriptors.PlaceEntityRequest_placeEntities.cpp_type = 10
type_descriptors.PlaceEntityRequest.name = "PlaceEntityRequest"
type_descriptors.PlaceEntityRequest.full_name = ".PlaceEntityRequest"
type_descriptors.PlaceEntityRequest.nested_types = {}
type_descriptors.PlaceEntityRequest.enum_types = {}
type_descriptors.PlaceEntityRequest.fields = {
	field_descriptors.PlaceEntityRequest_placeEntities
}
type_descriptors.PlaceEntityRequest.is_extendable = false
type_descriptors.PlaceEntityRequest.extensions = {}
field_descriptors.MultipleShapeNO_offSetShapes.name = "offSetShapes"
field_descriptors.MultipleShapeNO_offSetShapes.full_name = ".MultipleShapeNO.offSetShapes"
field_descriptors.MultipleShapeNO_offSetShapes.number = 1
field_descriptors.MultipleShapeNO_offSetShapes.index = 0
field_descriptors.MultipleShapeNO_offSetShapes.label = 3
field_descriptors.MultipleShapeNO_offSetShapes.has_default_value = false
field_descriptors.MultipleShapeNO_offSetShapes.default_value = {}
field_descriptors.MultipleShapeNO_offSetShapes.message_type = type_descriptors.OffsetShapeNO
field_descriptors.MultipleShapeNO_offSetShapes.type = 11
field_descriptors.MultipleShapeNO_offSetShapes.cpp_type = 10
field_descriptors.MultipleShapeNO_centerShapes.name = "centerShapes"
field_descriptors.MultipleShapeNO_centerShapes.full_name = ".MultipleShapeNO.centerShapes"
field_descriptors.MultipleShapeNO_centerShapes.number = 2
field_descriptors.MultipleShapeNO_centerShapes.index = 1
field_descriptors.MultipleShapeNO_centerShapes.label = 3
field_descriptors.MultipleShapeNO_centerShapes.has_default_value = false
field_descriptors.MultipleShapeNO_centerShapes.default_value = {}
field_descriptors.MultipleShapeNO_centerShapes.message_type = type_descriptors.CenterShapeNO
field_descriptors.MultipleShapeNO_centerShapes.type = 11
field_descriptors.MultipleShapeNO_centerShapes.cpp_type = 10
type_descriptors.MultipleShapeNO.name = "MultipleShapeNO"
type_descriptors.MultipleShapeNO.full_name = ".MultipleShapeNO"
type_descriptors.MultipleShapeNO.nested_types = {}
type_descriptors.MultipleShapeNO.enum_types = {}
type_descriptors.MultipleShapeNO.fields = {
	field_descriptors.MultipleShapeNO_offSetShapes,
	field_descriptors.MultipleShapeNO_centerShapes
}
type_descriptors.MultipleShapeNO.is_extendable = false
type_descriptors.MultipleShapeNO.extensions = {}
field_descriptors.GetBackInfoReply_info.name = "info"
field_descriptors.GetBackInfoReply_info.full_name = ".GetBackInfoReply.info"
field_descriptors.GetBackInfoReply_info.number = 1
field_descriptors.GetBackInfoReply_info.index = 0
field_descriptors.GetBackInfoReply_info.label = 1
field_descriptors.GetBackInfoReply_info.has_default_value = false
field_descriptors.GetBackInfoReply_info.default_value = nil
field_descriptors.GetBackInfoReply_info.message_type = type_descriptors.BattleInfoNO
field_descriptors.GetBackInfoReply_info.type = 11
field_descriptors.GetBackInfoReply_info.cpp_type = 10
type_descriptors.GetBackInfoReply.name = "GetBackInfoReply"
type_descriptors.GetBackInfoReply.full_name = ".GetBackInfoReply"
type_descriptors.GetBackInfoReply.nested_types = {}
type_descriptors.GetBackInfoReply.enum_types = {}
type_descriptors.GetBackInfoReply.fields = {
	field_descriptors.GetBackInfoReply_info
}
type_descriptors.GetBackInfoReply.is_extendable = false
type_descriptors.GetBackInfoReply.extensions = {}
field_descriptors.SteppableChangeNO_entity.name = "entity"
field_descriptors.SteppableChangeNO_entity.full_name = ".SteppableChangeNO.entity"
field_descriptors.SteppableChangeNO_entity.number = 1
field_descriptors.SteppableChangeNO_entity.index = 0
field_descriptors.SteppableChangeNO_entity.label = 2
field_descriptors.SteppableChangeNO_entity.has_default_value = false
field_descriptors.SteppableChangeNO_entity.default_value = 0
field_descriptors.SteppableChangeNO_entity.type = 5
field_descriptors.SteppableChangeNO_entity.cpp_type = 1
field_descriptors.SteppableChangeNO_steppable.name = "steppable"
field_descriptors.SteppableChangeNO_steppable.full_name = ".SteppableChangeNO.steppable"
field_descriptors.SteppableChangeNO_steppable.number = 2
field_descriptors.SteppableChangeNO_steppable.index = 1
field_descriptors.SteppableChangeNO_steppable.label = 2
field_descriptors.SteppableChangeNO_steppable.has_default_value = false
field_descriptors.SteppableChangeNO_steppable.default_value = false
field_descriptors.SteppableChangeNO_steppable.type = 8
field_descriptors.SteppableChangeNO_steppable.cpp_type = 7
type_descriptors.SteppableChangeNO.name = "SteppableChangeNO"
type_descriptors.SteppableChangeNO.full_name = ".SteppableChangeNO"
type_descriptors.SteppableChangeNO.nested_types = {}
type_descriptors.SteppableChangeNO.enum_types = {}
type_descriptors.SteppableChangeNO.fields = {
	field_descriptors.SteppableChangeNO_entity,
	field_descriptors.SteppableChangeNO_steppable
}
type_descriptors.SteppableChangeNO.is_extendable = false
type_descriptors.SteppableChangeNO.extensions = {}
field_descriptors.TacitTaskProgressEventNO_taskId.name = "taskId"
field_descriptors.TacitTaskProgressEventNO_taskId.full_name = ".TacitTaskProgressEventNO.taskId"
field_descriptors.TacitTaskProgressEventNO_taskId.number = 1
field_descriptors.TacitTaskProgressEventNO_taskId.index = 0
field_descriptors.TacitTaskProgressEventNO_taskId.label = 1
field_descriptors.TacitTaskProgressEventNO_taskId.has_default_value = false
field_descriptors.TacitTaskProgressEventNO_taskId.default_value = 0
field_descriptors.TacitTaskProgressEventNO_taskId.type = 5
field_descriptors.TacitTaskProgressEventNO_taskId.cpp_type = 1
field_descriptors.TacitTaskProgressEventNO_progress.name = "progress"
field_descriptors.TacitTaskProgressEventNO_progress.full_name = ".TacitTaskProgressEventNO.progress"
field_descriptors.TacitTaskProgressEventNO_progress.number = 2
field_descriptors.TacitTaskProgressEventNO_progress.index = 1
field_descriptors.TacitTaskProgressEventNO_progress.label = 1
field_descriptors.TacitTaskProgressEventNO_progress.has_default_value = false
field_descriptors.TacitTaskProgressEventNO_progress.default_value = 0
field_descriptors.TacitTaskProgressEventNO_progress.type = 5
field_descriptors.TacitTaskProgressEventNO_progress.cpp_type = 1
type_descriptors.TacitTaskProgressEventNO.name = "TacitTaskProgressEventNO"
type_descriptors.TacitTaskProgressEventNO.full_name = ".TacitTaskProgressEventNO"
type_descriptors.TacitTaskProgressEventNO.nested_types = {}
type_descriptors.TacitTaskProgressEventNO.enum_types = {}
type_descriptors.TacitTaskProgressEventNO.fields = {
	field_descriptors.TacitTaskProgressEventNO_taskId,
	field_descriptors.TacitTaskProgressEventNO_progress
}
type_descriptors.TacitTaskProgressEventNO.is_extendable = false
type_descriptors.TacitTaskProgressEventNO.extensions = {}
field_descriptors.CuredEventNO_releaser.name = "releaser"
field_descriptors.CuredEventNO_releaser.full_name = ".CuredEventNO.releaser"
field_descriptors.CuredEventNO_releaser.number = 1
field_descriptors.CuredEventNO_releaser.index = 0
field_descriptors.CuredEventNO_releaser.label = 1
field_descriptors.CuredEventNO_releaser.has_default_value = false
field_descriptors.CuredEventNO_releaser.default_value = 0
field_descriptors.CuredEventNO_releaser.type = 5
field_descriptors.CuredEventNO_releaser.cpp_type = 1
field_descriptors.CuredEventNO_entity.name = "entity"
field_descriptors.CuredEventNO_entity.full_name = ".CuredEventNO.entity"
field_descriptors.CuredEventNO_entity.number = 2
field_descriptors.CuredEventNO_entity.index = 1
field_descriptors.CuredEventNO_entity.label = 1
field_descriptors.CuredEventNO_entity.has_default_value = false
field_descriptors.CuredEventNO_entity.default_value = 0
field_descriptors.CuredEventNO_entity.type = 5
field_descriptors.CuredEventNO_entity.cpp_type = 1
field_descriptors.CuredEventNO_value.name = "value"
field_descriptors.CuredEventNO_value.full_name = ".CuredEventNO.value"
field_descriptors.CuredEventNO_value.number = 3
field_descriptors.CuredEventNO_value.index = 2
field_descriptors.CuredEventNO_value.label = 1
field_descriptors.CuredEventNO_value.has_default_value = false
field_descriptors.CuredEventNO_value.default_value = 0
field_descriptors.CuredEventNO_value.type = 5
field_descriptors.CuredEventNO_value.cpp_type = 1
field_descriptors.CuredEventNO_skill.name = "skill"
field_descriptors.CuredEventNO_skill.full_name = ".CuredEventNO.skill"
field_descriptors.CuredEventNO_skill.number = 4
field_descriptors.CuredEventNO_skill.index = 3
field_descriptors.CuredEventNO_skill.label = 1
field_descriptors.CuredEventNO_skill.has_default_value = false
field_descriptors.CuredEventNO_skill.default_value = 0
field_descriptors.CuredEventNO_skill.type = 5
field_descriptors.CuredEventNO_skill.cpp_type = 1
field_descriptors.CuredEventNO_buff.name = "buff"
field_descriptors.CuredEventNO_buff.full_name = ".CuredEventNO.buff"
field_descriptors.CuredEventNO_buff.number = 5
field_descriptors.CuredEventNO_buff.index = 4
field_descriptors.CuredEventNO_buff.label = 1
field_descriptors.CuredEventNO_buff.has_default_value = false
field_descriptors.CuredEventNO_buff.default_value = 0
field_descriptors.CuredEventNO_buff.type = 5
field_descriptors.CuredEventNO_buff.cpp_type = 1
field_descriptors.CuredEventNO_hpIncrement.name = "hpIncrement"
field_descriptors.CuredEventNO_hpIncrement.full_name = ".CuredEventNO.hpIncrement"
field_descriptors.CuredEventNO_hpIncrement.number = 6
field_descriptors.CuredEventNO_hpIncrement.index = 5
field_descriptors.CuredEventNO_hpIncrement.label = 1
field_descriptors.CuredEventNO_hpIncrement.has_default_value = false
field_descriptors.CuredEventNO_hpIncrement.default_value = 0
field_descriptors.CuredEventNO_hpIncrement.type = 5
field_descriptors.CuredEventNO_hpIncrement.cpp_type = 1
type_descriptors.CuredEventNO.name = "CuredEventNO"
type_descriptors.CuredEventNO.full_name = ".CuredEventNO"
type_descriptors.CuredEventNO.nested_types = {}
type_descriptors.CuredEventNO.enum_types = {}
type_descriptors.CuredEventNO.fields = {
	field_descriptors.CuredEventNO_releaser,
	field_descriptors.CuredEventNO_entity,
	field_descriptors.CuredEventNO_value,
	field_descriptors.CuredEventNO_skill,
	field_descriptors.CuredEventNO_buff,
	field_descriptors.CuredEventNO_hpIncrement
}
type_descriptors.CuredEventNO.is_extendable = false
type_descriptors.CuredEventNO.extensions = {}
field_descriptors.BuildingNO_id.name = "id"
field_descriptors.BuildingNO_id.full_name = ".BuildingNO.id"
field_descriptors.BuildingNO_id.number = 1
field_descriptors.BuildingNO_id.index = 0
field_descriptors.BuildingNO_id.label = 2
field_descriptors.BuildingNO_id.has_default_value = false
field_descriptors.BuildingNO_id.default_value = 0
field_descriptors.BuildingNO_id.type = 5
field_descriptors.BuildingNO_id.cpp_type = 1
field_descriptors.BuildingNO_cell.name = "cell"
field_descriptors.BuildingNO_cell.full_name = ".BuildingNO.cell"
field_descriptors.BuildingNO_cell.number = 2
field_descriptors.BuildingNO_cell.index = 1
field_descriptors.BuildingNO_cell.label = 2
field_descriptors.BuildingNO_cell.has_default_value = false
field_descriptors.BuildingNO_cell.default_value = nil
field_descriptors.BuildingNO_cell.message_type = type_descriptors.CellNO
field_descriptors.BuildingNO_cell.type = 11
field_descriptors.BuildingNO_cell.cpp_type = 10
field_descriptors.BuildingNO_msg.name = "msg"
field_descriptors.BuildingNO_msg.full_name = ".BuildingNO.msg"
field_descriptors.BuildingNO_msg.number = 7
field_descriptors.BuildingNO_msg.index = 2
field_descriptors.BuildingNO_msg.label = 1
field_descriptors.BuildingNO_msg.has_default_value = false
field_descriptors.BuildingNO_msg.default_value = nil
field_descriptors.BuildingNO_msg.message_type = type_descriptors.MapMessageNO
field_descriptors.BuildingNO_msg.type = 11
field_descriptors.BuildingNO_msg.cpp_type = 10
type_descriptors.BuildingNO.name = "BuildingNO"
type_descriptors.BuildingNO.full_name = ".BuildingNO"
type_descriptors.BuildingNO.nested_types = {}
type_descriptors.BuildingNO.enum_types = {}
type_descriptors.BuildingNO.fields = {
	field_descriptors.BuildingNO_id,
	field_descriptors.BuildingNO_cell,
	field_descriptors.BuildingNO_msg
}
type_descriptors.BuildingNO.is_extendable = false
type_descriptors.BuildingNO.extensions = {}
field_descriptors.AirMessageNO_type.name = "type"
field_descriptors.AirMessageNO_type.full_name = ".AirMessageNO.type"
field_descriptors.AirMessageNO_type.number = 1
field_descriptors.AirMessageNO_type.index = 0
field_descriptors.AirMessageNO_type.label = 2
field_descriptors.AirMessageNO_type.has_default_value = false
field_descriptors.AirMessageNO_type.default_value = 0
field_descriptors.AirMessageNO_type.type = 5
field_descriptors.AirMessageNO_type.cpp_type = 1
field_descriptors.AirMessageNO_msg.name = "msg"
field_descriptors.AirMessageNO_msg.full_name = ".AirMessageNO.msg"
field_descriptors.AirMessageNO_msg.number = 2
field_descriptors.AirMessageNO_msg.index = 1
field_descriptors.AirMessageNO_msg.label = 2
field_descriptors.AirMessageNO_msg.has_default_value = false
field_descriptors.AirMessageNO_msg.default_value = nil
field_descriptors.AirMessageNO_msg.message_type = type_descriptors.MessageCompositeNO
field_descriptors.AirMessageNO_msg.type = 11
field_descriptors.AirMessageNO_msg.cpp_type = 10
field_descriptors.AirMessageNO_pos.name = "pos"
field_descriptors.AirMessageNO_pos.full_name = ".AirMessageNO.pos"
field_descriptors.AirMessageNO_pos.number = 3
field_descriptors.AirMessageNO_pos.index = 2
field_descriptors.AirMessageNO_pos.label = 2
field_descriptors.AirMessageNO_pos.has_default_value = false
field_descriptors.AirMessageNO_pos.default_value = nil
field_descriptors.AirMessageNO_pos.message_type = type_descriptors.CellNO
field_descriptors.AirMessageNO_pos.type = 11
field_descriptors.AirMessageNO_pos.cpp_type = 10
type_descriptors.AirMessageNO.name = "AirMessageNO"
type_descriptors.AirMessageNO.full_name = ".AirMessageNO"
type_descriptors.AirMessageNO.nested_types = {}
type_descriptors.AirMessageNO.enum_types = {}
type_descriptors.AirMessageNO.fields = {
	field_descriptors.AirMessageNO_type,
	field_descriptors.AirMessageNO_msg,
	field_descriptors.AirMessageNO_pos
}
type_descriptors.AirMessageNO.is_extendable = false
type_descriptors.AirMessageNO.extensions = {}
field_descriptors.SetAiControlledRequest_aiControlled.name = "aiControlled"
field_descriptors.SetAiControlledRequest_aiControlled.full_name = ".SetAiControlledRequest.aiControlled"
field_descriptors.SetAiControlledRequest_aiControlled.number = 1
field_descriptors.SetAiControlledRequest_aiControlled.index = 0
field_descriptors.SetAiControlledRequest_aiControlled.label = 1
field_descriptors.SetAiControlledRequest_aiControlled.has_default_value = false
field_descriptors.SetAiControlledRequest_aiControlled.default_value = false
field_descriptors.SetAiControlledRequest_aiControlled.type = 8
field_descriptors.SetAiControlledRequest_aiControlled.cpp_type = 7
type_descriptors.SetAiControlledRequest.name = "SetAiControlledRequest"
type_descriptors.SetAiControlledRequest.full_name = ".SetAiControlledRequest"
type_descriptors.SetAiControlledRequest.nested_types = {}
type_descriptors.SetAiControlledRequest.enum_types = {}
type_descriptors.SetAiControlledRequest.fields = {
	field_descriptors.SetAiControlledRequest_aiControlled
}
type_descriptors.SetAiControlledRequest.is_extendable = false
type_descriptors.SetAiControlledRequest.extensions = {}
type_descriptors.ReadyStartPush.name = "ReadyStartPush"
type_descriptors.ReadyStartPush.full_name = ".ReadyStartPush"
type_descriptors.ReadyStartPush.nested_types = {}
type_descriptors.ReadyStartPush.enum_types = {}
type_descriptors.ReadyStartPush.fields = {}
type_descriptors.ReadyStartPush.is_extendable = false
type_descriptors.ReadyStartPush.extensions = {}
field_descriptors.GetBackInfoRequest_round.name = "round"
field_descriptors.GetBackInfoRequest_round.full_name = ".GetBackInfoRequest.round"
field_descriptors.GetBackInfoRequest_round.number = 1
field_descriptors.GetBackInfoRequest_round.index = 0
field_descriptors.GetBackInfoRequest_round.label = 2
field_descriptors.GetBackInfoRequest_round.has_default_value = false
field_descriptors.GetBackInfoRequest_round.default_value = 0
field_descriptors.GetBackInfoRequest_round.type = 5
field_descriptors.GetBackInfoRequest_round.cpp_type = 1
field_descriptors.GetBackInfoRequest_step.name = "step"
field_descriptors.GetBackInfoRequest_step.full_name = ".GetBackInfoRequest.step"
field_descriptors.GetBackInfoRequest_step.number = 2
field_descriptors.GetBackInfoRequest_step.index = 1
field_descriptors.GetBackInfoRequest_step.label = 2
field_descriptors.GetBackInfoRequest_step.has_default_value = false
field_descriptors.GetBackInfoRequest_step.default_value = 0
field_descriptors.GetBackInfoRequest_step.type = 5
field_descriptors.GetBackInfoRequest_step.cpp_type = 1
type_descriptors.GetBackInfoRequest.name = "GetBackInfoRequest"
type_descriptors.GetBackInfoRequest.full_name = ".GetBackInfoRequest"
type_descriptors.GetBackInfoRequest.nested_types = {}
type_descriptors.GetBackInfoRequest.enum_types = {}
type_descriptors.GetBackInfoRequest.fields = {
	field_descriptors.GetBackInfoRequest_round,
	field_descriptors.GetBackInfoRequest_step
}
type_descriptors.GetBackInfoRequest.is_extendable = false
type_descriptors.GetBackInfoRequest.extensions = {}
field_descriptors.SkillTriggeredEventNO_entity.name = "entity"
field_descriptors.SkillTriggeredEventNO_entity.full_name = ".SkillTriggeredEventNO.entity"
field_descriptors.SkillTriggeredEventNO_entity.number = 1
field_descriptors.SkillTriggeredEventNO_entity.index = 0
field_descriptors.SkillTriggeredEventNO_entity.label = 1
field_descriptors.SkillTriggeredEventNO_entity.has_default_value = false
field_descriptors.SkillTriggeredEventNO_entity.default_value = 0
field_descriptors.SkillTriggeredEventNO_entity.type = 5
field_descriptors.SkillTriggeredEventNO_entity.cpp_type = 1
field_descriptors.SkillTriggeredEventNO_code.name = "code"
field_descriptors.SkillTriggeredEventNO_code.full_name = ".SkillTriggeredEventNO.code"
field_descriptors.SkillTriggeredEventNO_code.number = 2
field_descriptors.SkillTriggeredEventNO_code.index = 1
field_descriptors.SkillTriggeredEventNO_code.label = 1
field_descriptors.SkillTriggeredEventNO_code.has_default_value = false
field_descriptors.SkillTriggeredEventNO_code.default_value = 0
field_descriptors.SkillTriggeredEventNO_code.type = 5
field_descriptors.SkillTriggeredEventNO_code.cpp_type = 1
field_descriptors.SkillTriggeredEventNO_effects.name = "effects"
field_descriptors.SkillTriggeredEventNO_effects.full_name = ".SkillTriggeredEventNO.effects"
field_descriptors.SkillTriggeredEventNO_effects.number = 3
field_descriptors.SkillTriggeredEventNO_effects.index = 2
field_descriptors.SkillTriggeredEventNO_effects.label = 3
field_descriptors.SkillTriggeredEventNO_effects.has_default_value = false
field_descriptors.SkillTriggeredEventNO_effects.default_value = {}
field_descriptors.SkillTriggeredEventNO_effects.message_type = type_descriptors.EffectNO
field_descriptors.SkillTriggeredEventNO_effects.type = 11
field_descriptors.SkillTriggeredEventNO_effects.cpp_type = 10
field_descriptors.SkillTriggeredEventNO_attackingDirection.name = "attackingDirection"
field_descriptors.SkillTriggeredEventNO_attackingDirection.full_name = ".SkillTriggeredEventNO.attackingDirection"
field_descriptors.SkillTriggeredEventNO_attackingDirection.number = 4
field_descriptors.SkillTriggeredEventNO_attackingDirection.index = 3
field_descriptors.SkillTriggeredEventNO_attackingDirection.label = 1
field_descriptors.SkillTriggeredEventNO_attackingDirection.has_default_value = false
field_descriptors.SkillTriggeredEventNO_attackingDirection.default_value = nil
field_descriptors.SkillTriggeredEventNO_attackingDirection.enum_type = type_descriptors.AttackingDirection
field_descriptors.SkillTriggeredEventNO_attackingDirection.type = 14
field_descriptors.SkillTriggeredEventNO_attackingDirection.cpp_type = 8
field_descriptors.SkillTriggeredEventNO_strengthen.name = "strengthen"
field_descriptors.SkillTriggeredEventNO_strengthen.full_name = ".SkillTriggeredEventNO.strengthen"
field_descriptors.SkillTriggeredEventNO_strengthen.number = 5
field_descriptors.SkillTriggeredEventNO_strengthen.index = 4
field_descriptors.SkillTriggeredEventNO_strengthen.label = 1
field_descriptors.SkillTriggeredEventNO_strengthen.has_default_value = false
field_descriptors.SkillTriggeredEventNO_strengthen.default_value = false
field_descriptors.SkillTriggeredEventNO_strengthen.type = 8
field_descriptors.SkillTriggeredEventNO_strengthen.cpp_type = 7
type_descriptors.SkillTriggeredEventNO.name = "SkillTriggeredEventNO"
type_descriptors.SkillTriggeredEventNO.full_name = ".SkillTriggeredEventNO"
type_descriptors.SkillTriggeredEventNO.nested_types = {}
type_descriptors.SkillTriggeredEventNO.enum_types = {}
type_descriptors.SkillTriggeredEventNO.fields = {
	field_descriptors.SkillTriggeredEventNO_entity,
	field_descriptors.SkillTriggeredEventNO_code,
	field_descriptors.SkillTriggeredEventNO_effects,
	field_descriptors.SkillTriggeredEventNO_attackingDirection,
	field_descriptors.SkillTriggeredEventNO_strengthen
}
type_descriptors.SkillTriggeredEventNO.is_extendable = false
type_descriptors.SkillTriggeredEventNO.extensions = {}
field_descriptors.AttributeNO_attr.name = "attr"
field_descriptors.AttributeNO_attr.full_name = ".AttributeNO.attr"
field_descriptors.AttributeNO_attr.number = 1
field_descriptors.AttributeNO_attr.index = 0
field_descriptors.AttributeNO_attr.label = 1
field_descriptors.AttributeNO_attr.has_default_value = false
field_descriptors.AttributeNO_attr.default_value = nil
field_descriptors.AttributeNO_attr.enum_type = type_descriptors.Attribute
field_descriptors.AttributeNO_attr.type = 14
field_descriptors.AttributeNO_attr.cpp_type = 8
field_descriptors.AttributeNO_value.name = "value"
field_descriptors.AttributeNO_value.full_name = ".AttributeNO.value"
field_descriptors.AttributeNO_value.number = 2
field_descriptors.AttributeNO_value.index = 1
field_descriptors.AttributeNO_value.label = 1
field_descriptors.AttributeNO_value.has_default_value = false
field_descriptors.AttributeNO_value.default_value = 0
field_descriptors.AttributeNO_value.type = 5
field_descriptors.AttributeNO_value.cpp_type = 1
field_descriptors.AttributeNO_initial.name = "initial"
field_descriptors.AttributeNO_initial.full_name = ".AttributeNO.initial"
field_descriptors.AttributeNO_initial.number = 3
field_descriptors.AttributeNO_initial.index = 2
field_descriptors.AttributeNO_initial.label = 1
field_descriptors.AttributeNO_initial.has_default_value = false
field_descriptors.AttributeNO_initial.default_value = 0
field_descriptors.AttributeNO_initial.type = 5
field_descriptors.AttributeNO_initial.cpp_type = 1
type_descriptors.AttributeNO.name = "AttributeNO"
type_descriptors.AttributeNO.full_name = ".AttributeNO"
type_descriptors.AttributeNO.nested_types = {}
type_descriptors.AttributeNO.enum_types = {}
type_descriptors.AttributeNO.fields = {
	field_descriptors.AttributeNO_attr,
	field_descriptors.AttributeNO_value,
	field_descriptors.AttributeNO_initial
}
type_descriptors.AttributeNO.is_extendable = false
type_descriptors.AttributeNO.extensions = {}
type_descriptors.EndReadyReply.name = "EndReadyReply"
type_descriptors.EndReadyReply.full_name = ".EndReadyReply"
type_descriptors.EndReadyReply.nested_types = {}
type_descriptors.EndReadyReply.enum_types = {}
type_descriptors.EndReadyReply.fields = {}
type_descriptors.EndReadyReply.is_extendable = false
type_descriptors.EndReadyReply.extensions = {}
field_descriptors.CellNO_x.name = "x"
field_descriptors.CellNO_x.full_name = ".CellNO.x"
field_descriptors.CellNO_x.number = 1
field_descriptors.CellNO_x.index = 0
field_descriptors.CellNO_x.label = 1
field_descriptors.CellNO_x.has_default_value = false
field_descriptors.CellNO_x.default_value = 0
field_descriptors.CellNO_x.type = 5
field_descriptors.CellNO_x.cpp_type = 1
field_descriptors.CellNO_z.name = "z"
field_descriptors.CellNO_z.full_name = ".CellNO.z"
field_descriptors.CellNO_z.number = 2
field_descriptors.CellNO_z.index = 1
field_descriptors.CellNO_z.label = 1
field_descriptors.CellNO_z.has_default_value = false
field_descriptors.CellNO_z.default_value = 0
field_descriptors.CellNO_z.type = 5
field_descriptors.CellNO_z.cpp_type = 1
field_descriptors.CellNO_additionalTerrains.name = "additionalTerrains"
field_descriptors.CellNO_additionalTerrains.full_name = ".CellNO.additionalTerrains"
field_descriptors.CellNO_additionalTerrains.number = 3
field_descriptors.CellNO_additionalTerrains.index = 2
field_descriptors.CellNO_additionalTerrains.label = 3
field_descriptors.CellNO_additionalTerrains.has_default_value = false
field_descriptors.CellNO_additionalTerrains.default_value = {}
field_descriptors.CellNO_additionalTerrains.message_type = type_descriptors.AdditionalTerrainNO
field_descriptors.CellNO_additionalTerrains.type = 11
field_descriptors.CellNO_additionalTerrains.cpp_type = 10
field_descriptors.CellNO_blocked.name = "blocked"
field_descriptors.CellNO_blocked.full_name = ".CellNO.blocked"
field_descriptors.CellNO_blocked.number = 4
field_descriptors.CellNO_blocked.index = 3
field_descriptors.CellNO_blocked.label = 3
field_descriptors.CellNO_blocked.has_default_value = false
field_descriptors.CellNO_blocked.default_value = {}
field_descriptors.CellNO_blocked.message_type = type_descriptors.CellsBlockedEventNO
field_descriptors.CellNO_blocked.type = 11
field_descriptors.CellNO_blocked.cpp_type = 10
type_descriptors.CellNO.name = "CellNO"
type_descriptors.CellNO.full_name = ".CellNO"
type_descriptors.CellNO.nested_types = {}
type_descriptors.CellNO.enum_types = {}
type_descriptors.CellNO.fields = {
	field_descriptors.CellNO_x,
	field_descriptors.CellNO_z,
	field_descriptors.CellNO_additionalTerrains,
	field_descriptors.CellNO_blocked
}
type_descriptors.CellNO.is_extendable = false
type_descriptors.CellNO.extensions = {}
field_descriptors.TaskTriggerNO_name.name = "name"
field_descriptors.TaskTriggerNO_name.full_name = ".TaskTriggerNO.name"
field_descriptors.TaskTriggerNO_name.number = 1
field_descriptors.TaskTriggerNO_name.index = 0
field_descriptors.TaskTriggerNO_name.label = 1
field_descriptors.TaskTriggerNO_name.has_default_value = false
field_descriptors.TaskTriggerNO_name.default_value = ""
field_descriptors.TaskTriggerNO_name.type = 9
field_descriptors.TaskTriggerNO_name.cpp_type = 9
field_descriptors.TaskTriggerNO_params.name = "params"
field_descriptors.TaskTriggerNO_params.full_name = ".TaskTriggerNO.params"
field_descriptors.TaskTriggerNO_params.number = 2
field_descriptors.TaskTriggerNO_params.index = 1
field_descriptors.TaskTriggerNO_params.label = 3
field_descriptors.TaskTriggerNO_params.has_default_value = false
field_descriptors.TaskTriggerNO_params.default_value = {}
field_descriptors.TaskTriggerNO_params.type = 9
field_descriptors.TaskTriggerNO_params.cpp_type = 9
type_descriptors.TaskTriggerNO.name = "TaskTriggerNO"
type_descriptors.TaskTriggerNO.full_name = ".TaskTriggerNO"
type_descriptors.TaskTriggerNO.nested_types = {}
type_descriptors.TaskTriggerNO.enum_types = {}
type_descriptors.TaskTriggerNO.fields = {
	field_descriptors.TaskTriggerNO_name,
	field_descriptors.TaskTriggerNO_params
}
type_descriptors.TaskTriggerNO.is_extendable = false
type_descriptors.TaskTriggerNO.extensions = {}
type_descriptors.BattleStartPush.name = "BattleStartPush"
type_descriptors.BattleStartPush.full_name = ".BattleStartPush"
type_descriptors.BattleStartPush.nested_types = {}
type_descriptors.BattleStartPush.enum_types = {}
type_descriptors.BattleStartPush.fields = {}
type_descriptors.BattleStartPush.is_extendable = false
type_descriptors.BattleStartPush.extensions = {}
field_descriptors.RhombusNO_radius.name = "radius"
field_descriptors.RhombusNO_radius.full_name = ".RhombusNO.radius"
field_descriptors.RhombusNO_radius.number = 1
field_descriptors.RhombusNO_radius.index = 0
field_descriptors.RhombusNO_radius.label = 1
field_descriptors.RhombusNO_radius.has_default_value = false
field_descriptors.RhombusNO_radius.default_value = 0
field_descriptors.RhombusNO_radius.type = 5
field_descriptors.RhombusNO_radius.cpp_type = 1
type_descriptors.RhombusNO.name = "RhombusNO"
type_descriptors.RhombusNO.full_name = ".RhombusNO"
type_descriptors.RhombusNO.nested_types = {}
type_descriptors.RhombusNO.enum_types = {}
type_descriptors.RhombusNO.fields = {
	field_descriptors.RhombusNO_radius
}
type_descriptors.RhombusNO.is_extendable = false
type_descriptors.RhombusNO.extensions = {}
field_descriptors.RectangleNO_width.name = "width"
field_descriptors.RectangleNO_width.full_name = ".RectangleNO.width"
field_descriptors.RectangleNO_width.number = 1
field_descriptors.RectangleNO_width.index = 0
field_descriptors.RectangleNO_width.label = 1
field_descriptors.RectangleNO_width.has_default_value = false
field_descriptors.RectangleNO_width.default_value = 0
field_descriptors.RectangleNO_width.type = 5
field_descriptors.RectangleNO_width.cpp_type = 1
field_descriptors.RectangleNO_height.name = "height"
field_descriptors.RectangleNO_height.full_name = ".RectangleNO.height"
field_descriptors.RectangleNO_height.number = 2
field_descriptors.RectangleNO_height.index = 1
field_descriptors.RectangleNO_height.label = 1
field_descriptors.RectangleNO_height.has_default_value = false
field_descriptors.RectangleNO_height.default_value = 0
field_descriptors.RectangleNO_height.type = 5
field_descriptors.RectangleNO_height.cpp_type = 1
type_descriptors.RectangleNO.name = "RectangleNO"
type_descriptors.RectangleNO.full_name = ".RectangleNO"
type_descriptors.RectangleNO.nested_types = {}
type_descriptors.RectangleNO.enum_types = {}
type_descriptors.RectangleNO.fields = {
	field_descriptors.RectangleNO_width,
	field_descriptors.RectangleNO_height
}
type_descriptors.RectangleNO.is_extendable = false
type_descriptors.RectangleNO.extensions = {}
field_descriptors.ExtraNO_direction.name = "direction"
field_descriptors.ExtraNO_direction.full_name = ".ExtraNO.direction"
field_descriptors.ExtraNO_direction.number = 1
field_descriptors.ExtraNO_direction.index = 0
field_descriptors.ExtraNO_direction.label = 1
field_descriptors.ExtraNO_direction.has_default_value = false
field_descriptors.ExtraNO_direction.default_value = 0
field_descriptors.ExtraNO_direction.type = 5
field_descriptors.ExtraNO_direction.cpp_type = 1
field_descriptors.ExtraNO_lookAt.name = "lookAt"
field_descriptors.ExtraNO_lookAt.full_name = ".ExtraNO.lookAt"
field_descriptors.ExtraNO_lookAt.number = 2
field_descriptors.ExtraNO_lookAt.index = 1
field_descriptors.ExtraNO_lookAt.label = 1
field_descriptors.ExtraNO_lookAt.has_default_value = false
field_descriptors.ExtraNO_lookAt.default_value = nil
field_descriptors.ExtraNO_lookAt.message_type = type_descriptors.CellNO
field_descriptors.ExtraNO_lookAt.type = 11
field_descriptors.ExtraNO_lookAt.cpp_type = 10
field_descriptors.ExtraNO_bodyEffect.name = "bodyEffect"
field_descriptors.ExtraNO_bodyEffect.full_name = ".ExtraNO.bodyEffect"
field_descriptors.ExtraNO_bodyEffect.number = 3
field_descriptors.ExtraNO_bodyEffect.index = 2
field_descriptors.ExtraNO_bodyEffect.label = 1
field_descriptors.ExtraNO_bodyEffect.has_default_value = false
field_descriptors.ExtraNO_bodyEffect.default_value = ""
field_descriptors.ExtraNO_bodyEffect.type = 9
field_descriptors.ExtraNO_bodyEffect.cpp_type = 9
type_descriptors.ExtraNO.name = "ExtraNO"
type_descriptors.ExtraNO.full_name = ".ExtraNO"
type_descriptors.ExtraNO.nested_types = {}
type_descriptors.ExtraNO.enum_types = {}
type_descriptors.ExtraNO.fields = {
	field_descriptors.ExtraNO_direction,
	field_descriptors.ExtraNO_lookAt,
	field_descriptors.ExtraNO_bodyEffect
}
type_descriptors.ExtraNO.is_extendable = false
type_descriptors.ExtraNO.extensions = {}
field_descriptors.PianoPlayingEventNO_scale.name = "scale"
field_descriptors.PianoPlayingEventNO_scale.full_name = ".PianoPlayingEventNO.scale"
field_descriptors.PianoPlayingEventNO_scale.number = 1
field_descriptors.PianoPlayingEventNO_scale.index = 0
field_descriptors.PianoPlayingEventNO_scale.label = 2
field_descriptors.PianoPlayingEventNO_scale.has_default_value = false
field_descriptors.PianoPlayingEventNO_scale.default_value = 0
field_descriptors.PianoPlayingEventNO_scale.type = 5
field_descriptors.PianoPlayingEventNO_scale.cpp_type = 1
field_descriptors.PianoPlayingEventNO_events.name = "events"
field_descriptors.PianoPlayingEventNO_events.full_name = ".PianoPlayingEventNO.events"
field_descriptors.PianoPlayingEventNO_events.number = 2
field_descriptors.PianoPlayingEventNO_events.index = 1
field_descriptors.PianoPlayingEventNO_events.label = 3
field_descriptors.PianoPlayingEventNO_events.has_default_value = false
field_descriptors.PianoPlayingEventNO_events.default_value = {}
field_descriptors.PianoPlayingEventNO_events.message_type = type_descriptors.EventNO
field_descriptors.PianoPlayingEventNO_events.type = 11
field_descriptors.PianoPlayingEventNO_events.cpp_type = 10
type_descriptors.PianoPlayingEventNO.name = "PianoPlayingEventNO"
type_descriptors.PianoPlayingEventNO.full_name = ".PianoPlayingEventNO"
type_descriptors.PianoPlayingEventNO.nested_types = {}
type_descriptors.PianoPlayingEventNO.enum_types = {}
type_descriptors.PianoPlayingEventNO.fields = {
	field_descriptors.PianoPlayingEventNO_scale,
	field_descriptors.PianoPlayingEventNO_events
}
type_descriptors.PianoPlayingEventNO.is_extendable = false
type_descriptors.PianoPlayingEventNO.extensions = {}
field_descriptors.MultiRoundAoeAddNO_aoe.name = "aoe"
field_descriptors.MultiRoundAoeAddNO_aoe.full_name = ".MultiRoundAoeAddNO.aoe"
field_descriptors.MultiRoundAoeAddNO_aoe.number = 1
field_descriptors.MultiRoundAoeAddNO_aoe.index = 0
field_descriptors.MultiRoundAoeAddNO_aoe.label = 1
field_descriptors.MultiRoundAoeAddNO_aoe.has_default_value = false
field_descriptors.MultiRoundAoeAddNO_aoe.default_value = nil
field_descriptors.MultiRoundAoeAddNO_aoe.message_type = type_descriptors.MultiRoundAoeNO
field_descriptors.MultiRoundAoeAddNO_aoe.type = 11
field_descriptors.MultiRoundAoeAddNO_aoe.cpp_type = 10
type_descriptors.MultiRoundAoeAddNO.name = "MultiRoundAoeAddNO"
type_descriptors.MultiRoundAoeAddNO.full_name = ".MultiRoundAoeAddNO"
type_descriptors.MultiRoundAoeAddNO.nested_types = {}
type_descriptors.MultiRoundAoeAddNO.enum_types = {}
type_descriptors.MultiRoundAoeAddNO.fields = {
	field_descriptors.MultiRoundAoeAddNO_aoe
}
type_descriptors.MultiRoundAoeAddNO.is_extendable = false
type_descriptors.MultiRoundAoeAddNO.extensions = {}
field_descriptors.DoomForecastNO_effectIndex.name = "effectIndex"
field_descriptors.DoomForecastNO_effectIndex.full_name = ".DoomForecastNO.effectIndex"
field_descriptors.DoomForecastNO_effectIndex.number = 1
field_descriptors.DoomForecastNO_effectIndex.index = 0
field_descriptors.DoomForecastNO_effectIndex.label = 2
field_descriptors.DoomForecastNO_effectIndex.has_default_value = false
field_descriptors.DoomForecastNO_effectIndex.default_value = 0
field_descriptors.DoomForecastNO_effectIndex.type = 5
field_descriptors.DoomForecastNO_effectIndex.cpp_type = 1
field_descriptors.DoomForecastNO_actionIndex.name = "actionIndex"
field_descriptors.DoomForecastNO_actionIndex.full_name = ".DoomForecastNO.actionIndex"
field_descriptors.DoomForecastNO_actionIndex.number = 2
field_descriptors.DoomForecastNO_actionIndex.index = 1
field_descriptors.DoomForecastNO_actionIndex.label = 2
field_descriptors.DoomForecastNO_actionIndex.has_default_value = false
field_descriptors.DoomForecastNO_actionIndex.default_value = 0
field_descriptors.DoomForecastNO_actionIndex.type = 5
field_descriptors.DoomForecastNO_actionIndex.cpp_type = 1
field_descriptors.DoomForecastNO_collectorIndex.name = "collectorIndex"
field_descriptors.DoomForecastNO_collectorIndex.full_name = ".DoomForecastNO.collectorIndex"
field_descriptors.DoomForecastNO_collectorIndex.number = 3
field_descriptors.DoomForecastNO_collectorIndex.index = 2
field_descriptors.DoomForecastNO_collectorIndex.label = 2
field_descriptors.DoomForecastNO_collectorIndex.has_default_value = false
field_descriptors.DoomForecastNO_collectorIndex.default_value = 0
field_descriptors.DoomForecastNO_collectorIndex.type = 5
field_descriptors.DoomForecastNO_collectorIndex.cpp_type = 1
field_descriptors.DoomForecastNO_randomActionIndex.name = "randomActionIndex"
field_descriptors.DoomForecastNO_randomActionIndex.full_name = ".DoomForecastNO.randomActionIndex"
field_descriptors.DoomForecastNO_randomActionIndex.number = 4
field_descriptors.DoomForecastNO_randomActionIndex.index = 3
field_descriptors.DoomForecastNO_randomActionIndex.label = 2
field_descriptors.DoomForecastNO_randomActionIndex.has_default_value = false
field_descriptors.DoomForecastNO_randomActionIndex.default_value = 0
field_descriptors.DoomForecastNO_randomActionIndex.type = 5
field_descriptors.DoomForecastNO_randomActionIndex.cpp_type = 1
field_descriptors.DoomForecastNO_targets.name = "targets"
field_descriptors.DoomForecastNO_targets.full_name = ".DoomForecastNO.targets"
field_descriptors.DoomForecastNO_targets.number = 5
field_descriptors.DoomForecastNO_targets.index = 4
field_descriptors.DoomForecastNO_targets.label = 3
field_descriptors.DoomForecastNO_targets.has_default_value = false
field_descriptors.DoomForecastNO_targets.default_value = {}
field_descriptors.DoomForecastNO_targets.type = 5
field_descriptors.DoomForecastNO_targets.cpp_type = 1
type_descriptors.DoomForecastNO.name = "DoomForecastNO"
type_descriptors.DoomForecastNO.full_name = ".DoomForecastNO"
type_descriptors.DoomForecastNO.nested_types = {}
type_descriptors.DoomForecastNO.enum_types = {}
type_descriptors.DoomForecastNO.fields = {
	field_descriptors.DoomForecastNO_effectIndex,
	field_descriptors.DoomForecastNO_actionIndex,
	field_descriptors.DoomForecastNO_collectorIndex,
	field_descriptors.DoomForecastNO_randomActionIndex,
	field_descriptors.DoomForecastNO_targets
}
type_descriptors.DoomForecastNO.is_extendable = false
type_descriptors.DoomForecastNO.extensions = {}
type_descriptors.DeleteUnfinishedBattleReply.name = "DeleteUnfinishedBattleReply"
type_descriptors.DeleteUnfinishedBattleReply.full_name = ".DeleteUnfinishedBattleReply"
type_descriptors.DeleteUnfinishedBattleReply.nested_types = {}
type_descriptors.DeleteUnfinishedBattleReply.enum_types = {}
type_descriptors.DeleteUnfinishedBattleReply.fields = {}
type_descriptors.DeleteUnfinishedBattleReply.is_extendable = false
type_descriptors.DeleteUnfinishedBattleReply.extensions = {}
field_descriptors.ForecastRequest_step.name = "step"
field_descriptors.ForecastRequest_step.full_name = ".ForecastRequest.step"
field_descriptors.ForecastRequest_step.number = 1
field_descriptors.ForecastRequest_step.index = 0
field_descriptors.ForecastRequest_step.label = 1
field_descriptors.ForecastRequest_step.has_default_value = false
field_descriptors.ForecastRequest_step.default_value = nil
field_descriptors.ForecastRequest_step.message_type = type_descriptors.StepRequest
field_descriptors.ForecastRequest_step.type = 11
field_descriptors.ForecastRequest_step.cpp_type = 10
type_descriptors.ForecastRequest.name = "ForecastRequest"
type_descriptors.ForecastRequest.full_name = ".ForecastRequest"
type_descriptors.ForecastRequest.nested_types = {}
type_descriptors.ForecastRequest.enum_types = {}
type_descriptors.ForecastRequest.fields = {
	field_descriptors.ForecastRequest_step
}
type_descriptors.ForecastRequest.is_extendable = false
type_descriptors.ForecastRequest.extensions = {}
field_descriptors.BuffRemovedEventNO_entity.name = "entity"
field_descriptors.BuffRemovedEventNO_entity.full_name = ".BuffRemovedEventNO.entity"
field_descriptors.BuffRemovedEventNO_entity.number = 1
field_descriptors.BuffRemovedEventNO_entity.index = 0
field_descriptors.BuffRemovedEventNO_entity.label = 1
field_descriptors.BuffRemovedEventNO_entity.has_default_value = false
field_descriptors.BuffRemovedEventNO_entity.default_value = 0
field_descriptors.BuffRemovedEventNO_entity.type = 5
field_descriptors.BuffRemovedEventNO_entity.cpp_type = 1
field_descriptors.BuffRemovedEventNO_ids.name = "ids"
field_descriptors.BuffRemovedEventNO_ids.full_name = ".BuffRemovedEventNO.ids"
field_descriptors.BuffRemovedEventNO_ids.number = 3
field_descriptors.BuffRemovedEventNO_ids.index = 1
field_descriptors.BuffRemovedEventNO_ids.label = 3
field_descriptors.BuffRemovedEventNO_ids.has_default_value = false
field_descriptors.BuffRemovedEventNO_ids.default_value = {}
field_descriptors.BuffRemovedEventNO_ids.type = 5
field_descriptors.BuffRemovedEventNO_ids.cpp_type = 1
type_descriptors.BuffRemovedEventNO.name = "BuffRemovedEventNO"
type_descriptors.BuffRemovedEventNO.full_name = ".BuffRemovedEventNO"
type_descriptors.BuffRemovedEventNO.nested_types = {}
type_descriptors.BuffRemovedEventNO.enum_types = {}
type_descriptors.BuffRemovedEventNO.fields = {
	field_descriptors.BuffRemovedEventNO_entity,
	field_descriptors.BuffRemovedEventNO_ids
}
type_descriptors.BuffRemovedEventNO.is_extendable = false
type_descriptors.BuffRemovedEventNO.extensions = {}
field_descriptors.AmbushNO_hero.name = "hero"
field_descriptors.AmbushNO_hero.full_name = ".AmbushNO.hero"
field_descriptors.AmbushNO_hero.number = 1
field_descriptors.AmbushNO_hero.index = 0
field_descriptors.AmbushNO_hero.label = 2
field_descriptors.AmbushNO_hero.has_default_value = false
field_descriptors.AmbushNO_hero.default_value = nil
field_descriptors.AmbushNO_hero.message_type = type_descriptors.HeroNO
field_descriptors.AmbushNO_hero.type = 11
field_descriptors.AmbushNO_hero.cpp_type = 10
field_descriptors.AmbushNO_condition.name = "condition"
field_descriptors.AmbushNO_condition.full_name = ".AmbushNO.condition"
field_descriptors.AmbushNO_condition.number = 2
field_descriptors.AmbushNO_condition.index = 1
field_descriptors.AmbushNO_condition.label = 2
field_descriptors.AmbushNO_condition.has_default_value = false
field_descriptors.AmbushNO_condition.default_value = 0
field_descriptors.AmbushNO_condition.type = 5
field_descriptors.AmbushNO_condition.cpp_type = 1
field_descriptors.AmbushNO_params.name = "params"
field_descriptors.AmbushNO_params.full_name = ".AmbushNO.params"
field_descriptors.AmbushNO_params.number = 3
field_descriptors.AmbushNO_params.index = 2
field_descriptors.AmbushNO_params.label = 1
field_descriptors.AmbushNO_params.has_default_value = false
field_descriptors.AmbushNO_params.default_value = 0
field_descriptors.AmbushNO_params.type = 5
field_descriptors.AmbushNO_params.cpp_type = 1
type_descriptors.AmbushNO.name = "AmbushNO"
type_descriptors.AmbushNO.full_name = ".AmbushNO"
type_descriptors.AmbushNO.nested_types = {}
type_descriptors.AmbushNO.enum_types = {}
type_descriptors.AmbushNO.fields = {
	field_descriptors.AmbushNO_hero,
	field_descriptors.AmbushNO_condition,
	field_descriptors.AmbushNO_params
}
type_descriptors.AmbushNO.is_extendable = false
type_descriptors.AmbushNO.extensions = {}
type_descriptors.SurrenderReply.name = "SurrenderReply"
type_descriptors.SurrenderReply.full_name = ".SurrenderReply"
type_descriptors.SurrenderReply.nested_types = {}
type_descriptors.SurrenderReply.enum_types = {}
type_descriptors.SurrenderReply.fields = {}
type_descriptors.SurrenderReply.is_extendable = false
type_descriptors.SurrenderReply.extensions = {}
field_descriptors.TagEnhanceRemoveNO_entity.name = "entity"
field_descriptors.TagEnhanceRemoveNO_entity.full_name = ".TagEnhanceRemoveNO.entity"
field_descriptors.TagEnhanceRemoveNO_entity.number = 1
field_descriptors.TagEnhanceRemoveNO_entity.index = 0
field_descriptors.TagEnhanceRemoveNO_entity.label = 2
field_descriptors.TagEnhanceRemoveNO_entity.has_default_value = false
field_descriptors.TagEnhanceRemoveNO_entity.default_value = 0
field_descriptors.TagEnhanceRemoveNO_entity.type = 5
field_descriptors.TagEnhanceRemoveNO_entity.cpp_type = 1
field_descriptors.TagEnhanceRemoveNO_contexts.name = "contexts"
field_descriptors.TagEnhanceRemoveNO_contexts.full_name = ".TagEnhanceRemoveNO.contexts"
field_descriptors.TagEnhanceRemoveNO_contexts.number = 2
field_descriptors.TagEnhanceRemoveNO_contexts.index = 1
field_descriptors.TagEnhanceRemoveNO_contexts.label = 3
field_descriptors.TagEnhanceRemoveNO_contexts.has_default_value = false
field_descriptors.TagEnhanceRemoveNO_contexts.default_value = {}
field_descriptors.TagEnhanceRemoveNO_contexts.message_type = type_descriptors.TagEnhanceNO
field_descriptors.TagEnhanceRemoveNO_contexts.type = 11
field_descriptors.TagEnhanceRemoveNO_contexts.cpp_type = 10
type_descriptors.TagEnhanceRemoveNO.name = "TagEnhanceRemoveNO"
type_descriptors.TagEnhanceRemoveNO.full_name = ".TagEnhanceRemoveNO"
type_descriptors.TagEnhanceRemoveNO.nested_types = {}
type_descriptors.TagEnhanceRemoveNO.enum_types = {}
type_descriptors.TagEnhanceRemoveNO.fields = {
	field_descriptors.TagEnhanceRemoveNO_entity,
	field_descriptors.TagEnhanceRemoveNO_contexts
}
type_descriptors.TagEnhanceRemoveNO.is_extendable = false
type_descriptors.TagEnhanceRemoveNO.extensions = {}
field_descriptors.TurnNO_entity.name = "entity"
field_descriptors.TurnNO_entity.full_name = ".TurnNO.entity"
field_descriptors.TurnNO_entity.number = 1
field_descriptors.TurnNO_entity.index = 0
field_descriptors.TurnNO_entity.label = 1
field_descriptors.TurnNO_entity.has_default_value = false
field_descriptors.TurnNO_entity.default_value = 0
field_descriptors.TurnNO_entity.type = 5
field_descriptors.TurnNO_entity.cpp_type = 1
field_descriptors.TurnNO_lookAt.name = "lookAt"
field_descriptors.TurnNO_lookAt.full_name = ".TurnNO.lookAt"
field_descriptors.TurnNO_lookAt.number = 2
field_descriptors.TurnNO_lookAt.index = 1
field_descriptors.TurnNO_lookAt.label = 1
field_descriptors.TurnNO_lookAt.has_default_value = false
field_descriptors.TurnNO_lookAt.default_value = nil
field_descriptors.TurnNO_lookAt.message_type = type_descriptors.CellNO
field_descriptors.TurnNO_lookAt.type = 11
field_descriptors.TurnNO_lookAt.cpp_type = 10
type_descriptors.TurnNO.name = "TurnNO"
type_descriptors.TurnNO.full_name = ".TurnNO"
type_descriptors.TurnNO.nested_types = {}
type_descriptors.TurnNO.enum_types = {}
type_descriptors.TurnNO.fields = {
	field_descriptors.TurnNO_entity,
	field_descriptors.TurnNO_lookAt
}
type_descriptors.TurnNO.is_extendable = false
type_descriptors.TurnNO.extensions = {}
field_descriptors.MoveEntityRequest_entity.name = "entity"
field_descriptors.MoveEntityRequest_entity.full_name = ".MoveEntityRequest.entity"
field_descriptors.MoveEntityRequest_entity.number = 1
field_descriptors.MoveEntityRequest_entity.index = 0
field_descriptors.MoveEntityRequest_entity.label = 1
field_descriptors.MoveEntityRequest_entity.has_default_value = false
field_descriptors.MoveEntityRequest_entity.default_value = 0
field_descriptors.MoveEntityRequest_entity.type = 5
field_descriptors.MoveEntityRequest_entity.cpp_type = 1
field_descriptors.MoveEntityRequest_cell.name = "cell"
field_descriptors.MoveEntityRequest_cell.full_name = ".MoveEntityRequest.cell"
field_descriptors.MoveEntityRequest_cell.number = 2
field_descriptors.MoveEntityRequest_cell.index = 1
field_descriptors.MoveEntityRequest_cell.label = 1
field_descriptors.MoveEntityRequest_cell.has_default_value = false
field_descriptors.MoveEntityRequest_cell.default_value = nil
field_descriptors.MoveEntityRequest_cell.message_type = type_descriptors.CellNO
field_descriptors.MoveEntityRequest_cell.type = 11
field_descriptors.MoveEntityRequest_cell.cpp_type = 10
type_descriptors.MoveEntityRequest.name = "MoveEntityRequest"
type_descriptors.MoveEntityRequest.full_name = ".MoveEntityRequest"
type_descriptors.MoveEntityRequest.nested_types = {}
type_descriptors.MoveEntityRequest.enum_types = {}
type_descriptors.MoveEntityRequest.fields = {
	field_descriptors.MoveEntityRequest_entity,
	field_descriptors.MoveEntityRequest_cell
}
type_descriptors.MoveEntityRequest.is_extendable = false
type_descriptors.MoveEntityRequest.extensions = {}
field_descriptors.LinkLineNO_start.name = "start"
field_descriptors.LinkLineNO_start.full_name = ".LinkLineNO.start"
field_descriptors.LinkLineNO_start.number = 1
field_descriptors.LinkLineNO_start.index = 0
field_descriptors.LinkLineNO_start.label = 1
field_descriptors.LinkLineNO_start.has_default_value = false
field_descriptors.LinkLineNO_start.default_value = nil
field_descriptors.LinkLineNO_start.message_type = type_descriptors.FractionPointNO
field_descriptors.LinkLineNO_start.type = 11
field_descriptors.LinkLineNO_start.cpp_type = 10
field_descriptors.LinkLineNO_end.name = "end"
field_descriptors.LinkLineNO_end.full_name = ".LinkLineNO.end"
field_descriptors.LinkLineNO_end.number = 2
field_descriptors.LinkLineNO_end.index = 1
field_descriptors.LinkLineNO_end.label = 1
field_descriptors.LinkLineNO_end.has_default_value = false
field_descriptors.LinkLineNO_end.default_value = nil
field_descriptors.LinkLineNO_end.message_type = type_descriptors.FractionPointNO
field_descriptors.LinkLineNO_end.type = 11
field_descriptors.LinkLineNO_end.cpp_type = 10
type_descriptors.LinkLineNO.name = "LinkLineNO"
type_descriptors.LinkLineNO.full_name = ".LinkLineNO"
type_descriptors.LinkLineNO.nested_types = {}
type_descriptors.LinkLineNO.enum_types = {}
type_descriptors.LinkLineNO.fields = {
	field_descriptors.LinkLineNO_start,
	field_descriptors.LinkLineNO_end
}
type_descriptors.LinkLineNO.is_extendable = false
type_descriptors.LinkLineNO.extensions = {}
field_descriptors.OffsetShapeNO_offset.name = "offset"
field_descriptors.OffsetShapeNO_offset.full_name = ".OffsetShapeNO.offset"
field_descriptors.OffsetShapeNO_offset.number = 1
field_descriptors.OffsetShapeNO_offset.index = 0
field_descriptors.OffsetShapeNO_offset.label = 1
field_descriptors.OffsetShapeNO_offset.has_default_value = false
field_descriptors.OffsetShapeNO_offset.default_value = nil
field_descriptors.OffsetShapeNO_offset.message_type = type_descriptors.CellNO
field_descriptors.OffsetShapeNO_offset.type = 11
field_descriptors.OffsetShapeNO_offset.cpp_type = 10
field_descriptors.OffsetShapeNO_shape.name = "shape"
field_descriptors.OffsetShapeNO_shape.full_name = ".OffsetShapeNO.shape"
field_descriptors.OffsetShapeNO_shape.number = 2
field_descriptors.OffsetShapeNO_shape.index = 1
field_descriptors.OffsetShapeNO_shape.label = 1
field_descriptors.OffsetShapeNO_shape.has_default_value = false
field_descriptors.OffsetShapeNO_shape.default_value = nil
field_descriptors.OffsetShapeNO_shape.message_type = type_descriptors.ShapeNO
field_descriptors.OffsetShapeNO_shape.type = 11
field_descriptors.OffsetShapeNO_shape.cpp_type = 10
type_descriptors.OffsetShapeNO.name = "OffsetShapeNO"
type_descriptors.OffsetShapeNO.full_name = ".OffsetShapeNO"
type_descriptors.OffsetShapeNO.nested_types = {}
type_descriptors.OffsetShapeNO.enum_types = {}
type_descriptors.OffsetShapeNO.fields = {
	field_descriptors.OffsetShapeNO_offset,
	field_descriptors.OffsetShapeNO_shape
}
type_descriptors.OffsetShapeNO.is_extendable = false
type_descriptors.OffsetShapeNO.extensions = {}
field_descriptors.TagEnhanceContextNO_id.name = "id"
field_descriptors.TagEnhanceContextNO_id.full_name = ".TagEnhanceContextNO.id"
field_descriptors.TagEnhanceContextNO_id.number = 1
field_descriptors.TagEnhanceContextNO_id.index = 0
field_descriptors.TagEnhanceContextNO_id.label = 2
field_descriptors.TagEnhanceContextNO_id.has_default_value = false
field_descriptors.TagEnhanceContextNO_id.default_value = 0
field_descriptors.TagEnhanceContextNO_id.type = 5
field_descriptors.TagEnhanceContextNO_id.cpp_type = 1
field_descriptors.TagEnhanceContextNO_cmd.name = "cmd"
field_descriptors.TagEnhanceContextNO_cmd.full_name = ".TagEnhanceContextNO.cmd"
field_descriptors.TagEnhanceContextNO_cmd.number = 2
field_descriptors.TagEnhanceContextNO_cmd.index = 1
field_descriptors.TagEnhanceContextNO_cmd.label = 1
field_descriptors.TagEnhanceContextNO_cmd.has_default_value = false
field_descriptors.TagEnhanceContextNO_cmd.default_value = nil
field_descriptors.TagEnhanceContextNO_cmd.enum_type = type_descriptors.TagEnhanceCmd
field_descriptors.TagEnhanceContextNO_cmd.type = 14
field_descriptors.TagEnhanceContextNO_cmd.cpp_type = 8
field_descriptors.TagEnhanceContextNO_pType.name = "pType"
field_descriptors.TagEnhanceContextNO_pType.full_name = ".TagEnhanceContextNO.pType"
field_descriptors.TagEnhanceContextNO_pType.number = 3
field_descriptors.TagEnhanceContextNO_pType.index = 2
field_descriptors.TagEnhanceContextNO_pType.label = 1
field_descriptors.TagEnhanceContextNO_pType.has_default_value = false
field_descriptors.TagEnhanceContextNO_pType.default_value = ""
field_descriptors.TagEnhanceContextNO_pType.type = 9
field_descriptors.TagEnhanceContextNO_pType.cpp_type = 9
field_descriptors.TagEnhanceContextNO_param.name = "param"
field_descriptors.TagEnhanceContextNO_param.full_name = ".TagEnhanceContextNO.param"
field_descriptors.TagEnhanceContextNO_param.number = 4
field_descriptors.TagEnhanceContextNO_param.index = 3
field_descriptors.TagEnhanceContextNO_param.label = 1
field_descriptors.TagEnhanceContextNO_param.has_default_value = false
field_descriptors.TagEnhanceContextNO_param.default_value = ""
field_descriptors.TagEnhanceContextNO_param.type = 9
field_descriptors.TagEnhanceContextNO_param.cpp_type = 9
type_descriptors.TagEnhanceContextNO.name = "TagEnhanceContextNO"
type_descriptors.TagEnhanceContextNO.full_name = ".TagEnhanceContextNO"
type_descriptors.TagEnhanceContextNO.nested_types = {}
type_descriptors.TagEnhanceContextNO.enum_types = {}
type_descriptors.TagEnhanceContextNO.fields = {
	field_descriptors.TagEnhanceContextNO_id,
	field_descriptors.TagEnhanceContextNO_cmd,
	field_descriptors.TagEnhanceContextNO_pType,
	field_descriptors.TagEnhanceContextNO_param
}
type_descriptors.TagEnhanceContextNO.is_extendable = false
type_descriptors.TagEnhanceContextNO.extensions = {}
field_descriptors.DamagedEventNO_entity.name = "entity"
field_descriptors.DamagedEventNO_entity.full_name = ".DamagedEventNO.entity"
field_descriptors.DamagedEventNO_entity.number = 1
field_descriptors.DamagedEventNO_entity.index = 0
field_descriptors.DamagedEventNO_entity.label = 1
field_descriptors.DamagedEventNO_entity.has_default_value = false
field_descriptors.DamagedEventNO_entity.default_value = 0
field_descriptors.DamagedEventNO_entity.type = 5
field_descriptors.DamagedEventNO_entity.cpp_type = 1
field_descriptors.DamagedEventNO_damageValue.name = "damageValue"
field_descriptors.DamagedEventNO_damageValue.full_name = ".DamagedEventNO.damageValue"
field_descriptors.DamagedEventNO_damageValue.number = 2
field_descriptors.DamagedEventNO_damageValue.index = 1
field_descriptors.DamagedEventNO_damageValue.label = 1
field_descriptors.DamagedEventNO_damageValue.has_default_value = false
field_descriptors.DamagedEventNO_damageValue.default_value = 0
field_descriptors.DamagedEventNO_damageValue.type = 5
field_descriptors.DamagedEventNO_damageValue.cpp_type = 1
field_descriptors.DamagedEventNO_damageType.name = "damageType"
field_descriptors.DamagedEventNO_damageType.full_name = ".DamagedEventNO.damageType"
field_descriptors.DamagedEventNO_damageType.number = 3
field_descriptors.DamagedEventNO_damageType.index = 2
field_descriptors.DamagedEventNO_damageType.label = 1
field_descriptors.DamagedEventNO_damageType.has_default_value = false
field_descriptors.DamagedEventNO_damageType.default_value = 0
field_descriptors.DamagedEventNO_damageType.type = 5
field_descriptors.DamagedEventNO_damageType.cpp_type = 1
field_descriptors.DamagedEventNO_skill.name = "skill"
field_descriptors.DamagedEventNO_skill.full_name = ".DamagedEventNO.skill"
field_descriptors.DamagedEventNO_skill.number = 4
field_descriptors.DamagedEventNO_skill.index = 3
field_descriptors.DamagedEventNO_skill.label = 1
field_descriptors.DamagedEventNO_skill.has_default_value = false
field_descriptors.DamagedEventNO_skill.default_value = 0
field_descriptors.DamagedEventNO_skill.type = 5
field_descriptors.DamagedEventNO_skill.cpp_type = 1
field_descriptors.DamagedEventNO_buff.name = "buff"
field_descriptors.DamagedEventNO_buff.full_name = ".DamagedEventNO.buff"
field_descriptors.DamagedEventNO_buff.number = 5
field_descriptors.DamagedEventNO_buff.index = 4
field_descriptors.DamagedEventNO_buff.label = 1
field_descriptors.DamagedEventNO_buff.has_default_value = false
field_descriptors.DamagedEventNO_buff.default_value = 0
field_descriptors.DamagedEventNO_buff.type = 5
field_descriptors.DamagedEventNO_buff.cpp_type = 1
field_descriptors.DamagedEventNO_skillEntity.name = "skillEntity"
field_descriptors.DamagedEventNO_skillEntity.full_name = ".DamagedEventNO.skillEntity"
field_descriptors.DamagedEventNO_skillEntity.number = 6
field_descriptors.DamagedEventNO_skillEntity.index = 5
field_descriptors.DamagedEventNO_skillEntity.label = 1
field_descriptors.DamagedEventNO_skillEntity.has_default_value = false
field_descriptors.DamagedEventNO_skillEntity.default_value = 0
field_descriptors.DamagedEventNO_skillEntity.type = 5
field_descriptors.DamagedEventNO_skillEntity.cpp_type = 1
field_descriptors.DamagedEventNO_fromEntity.name = "fromEntity"
field_descriptors.DamagedEventNO_fromEntity.full_name = ".DamagedEventNO.fromEntity"
field_descriptors.DamagedEventNO_fromEntity.number = 7
field_descriptors.DamagedEventNO_fromEntity.index = 6
field_descriptors.DamagedEventNO_fromEntity.label = 1
field_descriptors.DamagedEventNO_fromEntity.has_default_value = false
field_descriptors.DamagedEventNO_fromEntity.default_value = 0
field_descriptors.DamagedEventNO_fromEntity.type = 5
field_descriptors.DamagedEventNO_fromEntity.cpp_type = 1
field_descriptors.DamagedEventNO_critical.name = "critical"
field_descriptors.DamagedEventNO_critical.full_name = ".DamagedEventNO.critical"
field_descriptors.DamagedEventNO_critical.number = 8
field_descriptors.DamagedEventNO_critical.index = 7
field_descriptors.DamagedEventNO_critical.label = 1
field_descriptors.DamagedEventNO_critical.has_default_value = false
field_descriptors.DamagedEventNO_critical.default_value = false
field_descriptors.DamagedEventNO_critical.type = 8
field_descriptors.DamagedEventNO_critical.cpp_type = 7
field_descriptors.DamagedEventNO_immunized.name = "immunized"
field_descriptors.DamagedEventNO_immunized.full_name = ".DamagedEventNO.immunized"
field_descriptors.DamagedEventNO_immunized.number = 9
field_descriptors.DamagedEventNO_immunized.index = 8
field_descriptors.DamagedEventNO_immunized.label = 1
field_descriptors.DamagedEventNO_immunized.has_default_value = false
field_descriptors.DamagedEventNO_immunized.default_value = false
field_descriptors.DamagedEventNO_immunized.type = 8
field_descriptors.DamagedEventNO_immunized.cpp_type = 7
field_descriptors.DamagedEventNO_weakPointDamage.name = "weakPointDamage"
field_descriptors.DamagedEventNO_weakPointDamage.full_name = ".DamagedEventNO.weakPointDamage"
field_descriptors.DamagedEventNO_weakPointDamage.number = 10
field_descriptors.DamagedEventNO_weakPointDamage.index = 9
field_descriptors.DamagedEventNO_weakPointDamage.label = 1
field_descriptors.DamagedEventNO_weakPointDamage.has_default_value = false
field_descriptors.DamagedEventNO_weakPointDamage.default_value = 0
field_descriptors.DamagedEventNO_weakPointDamage.type = 5
field_descriptors.DamagedEventNO_weakPointDamage.cpp_type = 1
field_descriptors.DamagedEventNO_hpDecrement.name = "hpDecrement"
field_descriptors.DamagedEventNO_hpDecrement.full_name = ".DamagedEventNO.hpDecrement"
field_descriptors.DamagedEventNO_hpDecrement.number = 11
field_descriptors.DamagedEventNO_hpDecrement.index = 10
field_descriptors.DamagedEventNO_hpDecrement.label = 1
field_descriptors.DamagedEventNO_hpDecrement.has_default_value = false
field_descriptors.DamagedEventNO_hpDecrement.default_value = 0
field_descriptors.DamagedEventNO_hpDecrement.type = 5
field_descriptors.DamagedEventNO_hpDecrement.cpp_type = 1
field_descriptors.DamagedEventNO_hpDecrementOverflow.name = "hpDecrementOverflow"
field_descriptors.DamagedEventNO_hpDecrementOverflow.full_name = ".DamagedEventNO.hpDecrementOverflow"
field_descriptors.DamagedEventNO_hpDecrementOverflow.number = 12
field_descriptors.DamagedEventNO_hpDecrementOverflow.index = 11
field_descriptors.DamagedEventNO_hpDecrementOverflow.label = 1
field_descriptors.DamagedEventNO_hpDecrementOverflow.has_default_value = false
field_descriptors.DamagedEventNO_hpDecrementOverflow.default_value = 0
field_descriptors.DamagedEventNO_hpDecrementOverflow.type = 5
field_descriptors.DamagedEventNO_hpDecrementOverflow.cpp_type = 1
type_descriptors.DamagedEventNO.name = "DamagedEventNO"
type_descriptors.DamagedEventNO.full_name = ".DamagedEventNO"
type_descriptors.DamagedEventNO.nested_types = {}
type_descriptors.DamagedEventNO.enum_types = {}
type_descriptors.DamagedEventNO.fields = {
	field_descriptors.DamagedEventNO_entity,
	field_descriptors.DamagedEventNO_damageValue,
	field_descriptors.DamagedEventNO_damageType,
	field_descriptors.DamagedEventNO_skill,
	field_descriptors.DamagedEventNO_buff,
	field_descriptors.DamagedEventNO_skillEntity,
	field_descriptors.DamagedEventNO_fromEntity,
	field_descriptors.DamagedEventNO_critical,
	field_descriptors.DamagedEventNO_immunized,
	field_descriptors.DamagedEventNO_weakPointDamage,
	field_descriptors.DamagedEventNO_hpDecrement,
	field_descriptors.DamagedEventNO_hpDecrementOverflow
}
type_descriptors.DamagedEventNO.is_extendable = false
type_descriptors.DamagedEventNO.extensions = {}
field_descriptors.TerrainChangeNO_removed.name = "removed"
field_descriptors.TerrainChangeNO_removed.full_name = ".TerrainChangeNO.removed"
field_descriptors.TerrainChangeNO_removed.number = 1
field_descriptors.TerrainChangeNO_removed.index = 0
field_descriptors.TerrainChangeNO_removed.label = 3
field_descriptors.TerrainChangeNO_removed.has_default_value = false
field_descriptors.TerrainChangeNO_removed.default_value = {}
field_descriptors.TerrainChangeNO_removed.message_type = type_descriptors.CellNO
field_descriptors.TerrainChangeNO_removed.type = 11
field_descriptors.TerrainChangeNO_removed.cpp_type = 10
field_descriptors.TerrainChangeNO_added.name = "added"
field_descriptors.TerrainChangeNO_added.full_name = ".TerrainChangeNO.added"
field_descriptors.TerrainChangeNO_added.number = 2
field_descriptors.TerrainChangeNO_added.index = 1
field_descriptors.TerrainChangeNO_added.label = 3
field_descriptors.TerrainChangeNO_added.has_default_value = false
field_descriptors.TerrainChangeNO_added.default_value = {}
field_descriptors.TerrainChangeNO_added.message_type = type_descriptors.CellNO
field_descriptors.TerrainChangeNO_added.type = 11
field_descriptors.TerrainChangeNO_added.cpp_type = 10
type_descriptors.TerrainChangeNO.name = "TerrainChangeNO"
type_descriptors.TerrainChangeNO.full_name = ".TerrainChangeNO"
type_descriptors.TerrainChangeNO.nested_types = {}
type_descriptors.TerrainChangeNO.enum_types = {}
type_descriptors.TerrainChangeNO.fields = {
	field_descriptors.TerrainChangeNO_removed,
	field_descriptors.TerrainChangeNO_added
}
type_descriptors.TerrainChangeNO.is_extendable = false
type_descriptors.TerrainChangeNO.extensions = {}
field_descriptors.TagBaseNO_tagId.name = "tagId"
field_descriptors.TagBaseNO_tagId.full_name = ".TagBaseNO.tagId"
field_descriptors.TagBaseNO_tagId.number = 1
field_descriptors.TagBaseNO_tagId.index = 0
field_descriptors.TagBaseNO_tagId.label = 1
field_descriptors.TagBaseNO_tagId.has_default_value = false
field_descriptors.TagBaseNO_tagId.default_value = 0
field_descriptors.TagBaseNO_tagId.type = 5
field_descriptors.TagBaseNO_tagId.cpp_type = 1
field_descriptors.TagBaseNO_variant.name = "variant"
field_descriptors.TagBaseNO_variant.full_name = ".TagBaseNO.variant"
field_descriptors.TagBaseNO_variant.number = 2
field_descriptors.TagBaseNO_variant.index = 1
field_descriptors.TagBaseNO_variant.label = 1
field_descriptors.TagBaseNO_variant.has_default_value = false
field_descriptors.TagBaseNO_variant.default_value = false
field_descriptors.TagBaseNO_variant.type = 8
field_descriptors.TagBaseNO_variant.cpp_type = 7
field_descriptors.TagBaseNO_moonRing.name = "moonRing"
field_descriptors.TagBaseNO_moonRing.full_name = ".TagBaseNO.moonRing"
field_descriptors.TagBaseNO_moonRing.number = 3
field_descriptors.TagBaseNO_moonRing.index = 2
field_descriptors.TagBaseNO_moonRing.label = 1
field_descriptors.TagBaseNO_moonRing.has_default_value = false
field_descriptors.TagBaseNO_moonRing.default_value = nil
field_descriptors.TagBaseNO_moonRing.message_type = type_descriptors.MoonRingTagNO
field_descriptors.TagBaseNO_moonRing.type = 11
field_descriptors.TagBaseNO_moonRing.cpp_type = 10
field_descriptors.TagBaseNO_assist.name = "assist"
field_descriptors.TagBaseNO_assist.full_name = ".TagBaseNO.assist"
field_descriptors.TagBaseNO_assist.number = 4
field_descriptors.TagBaseNO_assist.index = 3
field_descriptors.TagBaseNO_assist.label = 1
field_descriptors.TagBaseNO_assist.has_default_value = false
field_descriptors.TagBaseNO_assist.default_value = nil
field_descriptors.TagBaseNO_assist.message_type = type_descriptors.AssistTagNO
field_descriptors.TagBaseNO_assist.type = 11
field_descriptors.TagBaseNO_assist.cpp_type = 10
field_descriptors.TagBaseNO_shapeTag.name = "shapeTag"
field_descriptors.TagBaseNO_shapeTag.full_name = ".TagBaseNO.shapeTag"
field_descriptors.TagBaseNO_shapeTag.number = 5
field_descriptors.TagBaseNO_shapeTag.index = 4
field_descriptors.TagBaseNO_shapeTag.label = 1
field_descriptors.TagBaseNO_shapeTag.has_default_value = false
field_descriptors.TagBaseNO_shapeTag.default_value = nil
field_descriptors.TagBaseNO_shapeTag.message_type = type_descriptors.ShapeTagNO
field_descriptors.TagBaseNO_shapeTag.type = 11
field_descriptors.TagBaseNO_shapeTag.cpp_type = 10
type_descriptors.TagBaseNO.name = "TagBaseNO"
type_descriptors.TagBaseNO.full_name = ".TagBaseNO"
type_descriptors.TagBaseNO.nested_types = {}
type_descriptors.TagBaseNO.enum_types = {}
type_descriptors.TagBaseNO.fields = {
	field_descriptors.TagBaseNO_tagId,
	field_descriptors.TagBaseNO_variant,
	field_descriptors.TagBaseNO_moonRing,
	field_descriptors.TagBaseNO_assist,
	field_descriptors.TagBaseNO_shapeTag
}
type_descriptors.TagBaseNO.is_extendable = false
type_descriptors.TagBaseNO.extensions = {}
field_descriptors.BattleExtraNO_doomForecast.name = "doomForecast"
field_descriptors.BattleExtraNO_doomForecast.full_name = ".BattleExtraNO.doomForecast"
field_descriptors.BattleExtraNO_doomForecast.number = 1
field_descriptors.BattleExtraNO_doomForecast.index = 0
field_descriptors.BattleExtraNO_doomForecast.label = 1
field_descriptors.BattleExtraNO_doomForecast.has_default_value = false
field_descriptors.BattleExtraNO_doomForecast.default_value = nil
field_descriptors.BattleExtraNO_doomForecast.message_type = type_descriptors.DoomForecastNO
field_descriptors.BattleExtraNO_doomForecast.type = 11
field_descriptors.BattleExtraNO_doomForecast.cpp_type = 10
field_descriptors.BattleExtraNO_lightColumn.name = "lightColumn"
field_descriptors.BattleExtraNO_lightColumn.full_name = ".BattleExtraNO.lightColumn"
field_descriptors.BattleExtraNO_lightColumn.number = 2
field_descriptors.BattleExtraNO_lightColumn.index = 1
field_descriptors.BattleExtraNO_lightColumn.label = 1
field_descriptors.BattleExtraNO_lightColumn.has_default_value = false
field_descriptors.BattleExtraNO_lightColumn.default_value = nil
field_descriptors.BattleExtraNO_lightColumn.message_type = type_descriptors.LightColumnNO
field_descriptors.BattleExtraNO_lightColumn.type = 11
field_descriptors.BattleExtraNO_lightColumn.cpp_type = 10
field_descriptors.BattleExtraNO_sheetMusic.name = "sheetMusic"
field_descriptors.BattleExtraNO_sheetMusic.full_name = ".BattleExtraNO.sheetMusic"
field_descriptors.BattleExtraNO_sheetMusic.number = 3
field_descriptors.BattleExtraNO_sheetMusic.index = 2
field_descriptors.BattleExtraNO_sheetMusic.label = 1
field_descriptors.BattleExtraNO_sheetMusic.has_default_value = false
field_descriptors.BattleExtraNO_sheetMusic.default_value = nil
field_descriptors.BattleExtraNO_sheetMusic.message_type = type_descriptors.SheetMusicNO
field_descriptors.BattleExtraNO_sheetMusic.type = 11
field_descriptors.BattleExtraNO_sheetMusic.cpp_type = 10
type_descriptors.BattleExtraNO.name = "BattleExtraNO"
type_descriptors.BattleExtraNO.full_name = ".BattleExtraNO"
type_descriptors.BattleExtraNO.nested_types = {}
type_descriptors.BattleExtraNO.enum_types = {}
type_descriptors.BattleExtraNO.fields = {
	field_descriptors.BattleExtraNO_doomForecast,
	field_descriptors.BattleExtraNO_lightColumn,
	field_descriptors.BattleExtraNO_sheetMusic
}
type_descriptors.BattleExtraNO.is_extendable = false
type_descriptors.BattleExtraNO.extensions = {}
field_descriptors.MapMessageNO_msg.name = "msg"
field_descriptors.MapMessageNO_msg.full_name = ".MapMessageNO.msg"
field_descriptors.MapMessageNO_msg.number = 1
field_descriptors.MapMessageNO_msg.index = 0
field_descriptors.MapMessageNO_msg.label = 2
field_descriptors.MapMessageNO_msg.has_default_value = false
field_descriptors.MapMessageNO_msg.default_value = nil
field_descriptors.MapMessageNO_msg.message_type = type_descriptors.MessageCompositeNO
field_descriptors.MapMessageNO_msg.type = 11
field_descriptors.MapMessageNO_msg.cpp_type = 10
field_descriptors.MapMessageNO_time.name = "time"
field_descriptors.MapMessageNO_time.full_name = ".MapMessageNO.time"
field_descriptors.MapMessageNO_time.number = 2
field_descriptors.MapMessageNO_time.index = 1
field_descriptors.MapMessageNO_time.label = 2
field_descriptors.MapMessageNO_time.has_default_value = false
field_descriptors.MapMessageNO_time.default_value = 0
field_descriptors.MapMessageNO_time.type = 5
field_descriptors.MapMessageNO_time.cpp_type = 1
field_descriptors.MapMessageNO_params.name = "params"
field_descriptors.MapMessageNO_params.full_name = ".MapMessageNO.params"
field_descriptors.MapMessageNO_params.number = 3
field_descriptors.MapMessageNO_params.index = 2
field_descriptors.MapMessageNO_params.label = 1
field_descriptors.MapMessageNO_params.has_default_value = false
field_descriptors.MapMessageNO_params.default_value = 0
field_descriptors.MapMessageNO_params.type = 5
field_descriptors.MapMessageNO_params.cpp_type = 1
type_descriptors.MapMessageNO.name = "MapMessageNO"
type_descriptors.MapMessageNO.full_name = ".MapMessageNO"
type_descriptors.MapMessageNO.nested_types = {}
type_descriptors.MapMessageNO.enum_types = {}
type_descriptors.MapMessageNO.fields = {
	field_descriptors.MapMessageNO_msg,
	field_descriptors.MapMessageNO_time,
	field_descriptors.MapMessageNO_params
}
type_descriptors.MapMessageNO.is_extendable = false
type_descriptors.MapMessageNO.extensions = {}
field_descriptors.HeroNO_heroId.name = "heroId"
field_descriptors.HeroNO_heroId.full_name = ".HeroNO.heroId"
field_descriptors.HeroNO_heroId.number = 1
field_descriptors.HeroNO_heroId.index = 0
field_descriptors.HeroNO_heroId.label = 2
field_descriptors.HeroNO_heroId.has_default_value = false
field_descriptors.HeroNO_heroId.default_value = 0
field_descriptors.HeroNO_heroId.type = 5
field_descriptors.HeroNO_heroId.cpp_type = 1
field_descriptors.HeroNO_cell.name = "cell"
field_descriptors.HeroNO_cell.full_name = ".HeroNO.cell"
field_descriptors.HeroNO_cell.number = 2
field_descriptors.HeroNO_cell.index = 1
field_descriptors.HeroNO_cell.label = 2
field_descriptors.HeroNO_cell.has_default_value = false
field_descriptors.HeroNO_cell.default_value = nil
field_descriptors.HeroNO_cell.message_type = type_descriptors.CellNO
field_descriptors.HeroNO_cell.type = 11
field_descriptors.HeroNO_cell.cpp_type = 10
field_descriptors.HeroNO_msg.name = "msg"
field_descriptors.HeroNO_msg.full_name = ".HeroNO.msg"
field_descriptors.HeroNO_msg.number = 7
field_descriptors.HeroNO_msg.index = 2
field_descriptors.HeroNO_msg.label = 1
field_descriptors.HeroNO_msg.has_default_value = false
field_descriptors.HeroNO_msg.default_value = nil
field_descriptors.HeroNO_msg.message_type = type_descriptors.MapMessageNO
field_descriptors.HeroNO_msg.type = 11
field_descriptors.HeroNO_msg.cpp_type = 10
type_descriptors.HeroNO.name = "HeroNO"
type_descriptors.HeroNO.full_name = ".HeroNO"
type_descriptors.HeroNO.nested_types = {}
type_descriptors.HeroNO.enum_types = {}
type_descriptors.HeroNO.fields = {
	field_descriptors.HeroNO_heroId,
	field_descriptors.HeroNO_cell,
	field_descriptors.HeroNO_msg
}
type_descriptors.HeroNO.is_extendable = false
type_descriptors.HeroNO.extensions = {}
field_descriptors.ConnectStateNO_userId.name = "userId"
field_descriptors.ConnectStateNO_userId.full_name = ".ConnectStateNO.userId"
field_descriptors.ConnectStateNO_userId.number = 1
field_descriptors.ConnectStateNO_userId.index = 0
field_descriptors.ConnectStateNO_userId.label = 2
field_descriptors.ConnectStateNO_userId.has_default_value = false
field_descriptors.ConnectStateNO_userId.default_value = 0
field_descriptors.ConnectStateNO_userId.type = 3
field_descriptors.ConnectStateNO_userId.cpp_type = 2
field_descriptors.ConnectStateNO_online.name = "online"
field_descriptors.ConnectStateNO_online.full_name = ".ConnectStateNO.online"
field_descriptors.ConnectStateNO_online.number = 2
field_descriptors.ConnectStateNO_online.index = 1
field_descriptors.ConnectStateNO_online.label = 2
field_descriptors.ConnectStateNO_online.has_default_value = false
field_descriptors.ConnectStateNO_online.default_value = false
field_descriptors.ConnectStateNO_online.type = 8
field_descriptors.ConnectStateNO_online.cpp_type = 7
type_descriptors.ConnectStateNO.name = "ConnectStateNO"
type_descriptors.ConnectStateNO.full_name = ".ConnectStateNO"
type_descriptors.ConnectStateNO.nested_types = {}
type_descriptors.ConnectStateNO.enum_types = {}
type_descriptors.ConnectStateNO.fields = {
	field_descriptors.ConnectStateNO_userId,
	field_descriptors.ConnectStateNO_online
}
type_descriptors.ConnectStateNO.is_extendable = false
type_descriptors.ConnectStateNO.extensions = {}
field_descriptors.LightColumnNO_column.name = "column"
field_descriptors.LightColumnNO_column.full_name = ".LightColumnNO.column"
field_descriptors.LightColumnNO_column.number = 1
field_descriptors.LightColumnNO_column.index = 0
field_descriptors.LightColumnNO_column.label = 2
field_descriptors.LightColumnNO_column.has_default_value = false
field_descriptors.LightColumnNO_column.default_value = 0
field_descriptors.LightColumnNO_column.type = 5
field_descriptors.LightColumnNO_column.cpp_type = 1
field_descriptors.LightColumnNO_lightRes.name = "lightRes"
field_descriptors.LightColumnNO_lightRes.full_name = ".LightColumnNO.lightRes"
field_descriptors.LightColumnNO_lightRes.number = 2
field_descriptors.LightColumnNO_lightRes.index = 1
field_descriptors.LightColumnNO_lightRes.label = 2
field_descriptors.LightColumnNO_lightRes.has_default_value = false
field_descriptors.LightColumnNO_lightRes.default_value = ""
field_descriptors.LightColumnNO_lightRes.type = 9
field_descriptors.LightColumnNO_lightRes.cpp_type = 9
type_descriptors.LightColumnNO.name = "LightColumnNO"
type_descriptors.LightColumnNO.full_name = ".LightColumnNO"
type_descriptors.LightColumnNO.nested_types = {}
type_descriptors.LightColumnNO.enum_types = {}
type_descriptors.LightColumnNO.fields = {
	field_descriptors.LightColumnNO_column,
	field_descriptors.LightColumnNO_lightRes
}
type_descriptors.LightColumnNO.is_extendable = false
type_descriptors.LightColumnNO.extensions = {}
type_descriptors.DisconnectReply.name = "DisconnectReply"
type_descriptors.DisconnectReply.full_name = ".DisconnectReply"
type_descriptors.DisconnectReply.nested_types = {}
type_descriptors.DisconnectReply.enum_types = {}
type_descriptors.DisconnectReply.fields = {}
type_descriptors.DisconnectReply.is_extendable = false
type_descriptors.DisconnectReply.extensions = {}
type_descriptors.ForecastAiReply.name = "ForecastAiReply"
type_descriptors.ForecastAiReply.full_name = ".ForecastAiReply"
type_descriptors.ForecastAiReply.nested_types = {}
type_descriptors.ForecastAiReply.enum_types = {}
type_descriptors.ForecastAiReply.fields = {}
type_descriptors.ForecastAiReply.is_extendable = false
type_descriptors.ForecastAiReply.extensions = {}
AiMode = {
	BEHAVIOR_TREE = 2,
	USER_RECORD = 3,
	NONE = 1
}
AttackingDirection = {
	ATTACKING_DIRECTION_ATTACK = 1,
	ATTACKING_DIRECTION_COUNTER = 2,
	ATTACKING_DIRECTION_CHASE = 3,
	ATTACKING_DIRECTION_DOUBLE = 4
}
Attribute = {
	DAMAGE_ENHANCE_BORESPINE = 34,
	ROAR_MIN_LAYER = 48,
	BE_CURED = 16,
	ROAR_MAX_LAYER = 49,
	PIERCED_TIMES = 55,
	DAMAGE_ENHANCE_EXTRA = 30,
	DEF_MAG = 7,
	DAMAGE_REDUCE = 10,
	DAMAGE_ENHANCE = 9,
	CURRENT_SAN = 23,
	BLADE_EDGE_MAX_LAYER = 37,
	RESTRAIN_REDUCE = 14,
	AGILE_MIN_LAYER = 38,
	CURRENT_HP_RATE = 24,
	AGILE_MAX_LAYER = 39,
	BLADE_EDGE_MIN_LAYER = 36,
	CRIT_REDUCE = 12,
	MAX_HP = 3,
	SKILL_CD_OFFSET = 29,
	DECLINE_MAX_LAYER = 43,
	WEAK_MIN_LAYER = 44,
	WEAK_POINT_DAMAGE = 28,
	WEAK_MAX_LAYER = 45,
	EROSION_MIN_LAYER = 46,
	ATK_PHY = 4,
	DECLINE_MIN_LAYER = 42,
	IGNORE_PHY = 20,
	EROSION_MAX_LAYER = 47,
	INSPIRATION = 8,
	MAD_MIN_LAYER = 50,
	CURE = 15,
	DEFENSE_MAX_LAYER = 41,
	FIGHTING_CAPACITY = 27,
	SAN_BACK = 19,
	LOST_HP_RATE = 25,
	CURRENT_HP = 22,
	PENETRATE_MIN_LAYER = 52,
	MAD_MAX_LAYER = 51,
	PENETRATE_MAX_LAYER = 53,
	CRIT_ENHANCE = 11,
	ATK_MAG = 6,
	IGNORE_MAG = 21,
	DEFENSE_MIN_LAYER = 40,
	DAMAGE_ENHANCE_CHASE = 32,
	DAMAGE_ENHANCE_SNIPE = 54,
	NORMAL_SKILL_CD_OFFSET = 56,
	SPECIAL_SKILL_CD_OFFSET = 57,
	TRUMP_SKILL_CD_OFFSET = 58,
	DAMAGE_ENHANCE_MOONRING = 31,
	SUCK = 17,
	DAMAGE_ENHANCE_BOMB = 33,
	DAMAGE_ENHANCE_ARCLIGHT = 35,
	SAN_GROW = 18,
	RESTRAIN_ENHANCE = 13,
	DEF_PHY = 5,
	MOVE = 2
}
AttributePart = {
	PART_ATK_MAG_ADDITION = 30,
	PART_ATK_MAG_BASE = 28,
	PART_DEF_PHY_ADDITION = 27,
	PART_DEF_MAG_BASE = 31,
	PART_DEF_PHY_BASE = 25,
	PART_MOVE = 3,
	PART_SPECIAL_SKILL_CD_OFFSET = 63,
	PART_ATK_PHY_ADDITION = 24,
	PART_DAMAGE_REDUCE = 7,
	PART_EROSION_MIN_LAYER = 52,
	PART_DEF_PHY_MULTIPLICATION = 26,
	PART_DAMAGE_ENHANCE_EXTRA = 36,
	PART_SAN_GROW = 15,
	PART_CURE = 12,
	PART_DAMAGE_ENHANCE_ARCLIGHT = 41,
	PART_DEF_MAG_MULTIPLICATION = 32,
	PART_BLADE_EDGE_MIN_LAYER = 42,
	PART_BLADE_EDGE_MAX_LAYER = 43,
	PART_DAMAGE_ENHANCE_BOMB = 39,
	PART_MAX_HP_MULTIPLICATION = 20,
	PART_AGILE_MIN_LAYER = 44,
	PART_AGILE_MAX_LAYER = 45,
	PART_DEFENSE_MIN_LAYER = 46,
	PART_DEFENSE_MAX_LAYER = 47,
	PART_IGNORE_MAG = 18,
	PART_RESTRAIN_REDUCE = 11,
	PART_DEF_MAG_ADDITION = 33,
	PART_DECLINE_MIN_LAYER = 48,
	PART_DECLINE_MAX_LAYER = 49,
	PART_WEAK_MIN_LAYER = 50,
	PART_ATK_PHY_MULTIPLICATION = 23,
	PART_WEAK_MAX_LAYER = 51,
	PART_CRIT_ENHANCE = 8,
	PART_RESTRAIN_ENHANCE = 10,
	PART_SUCK = 14,
	PART_CURRENT_HP = 4,
	PART_SKILL_CD_OFFSET = 35,
	PART_ATK_PHY_BASE = 22,
	PART_CURRENT_SAN = 1,
	PART_DAMAGE_ENHANCE_BORESPINE = 40,
	PART_EROSION_MAX_LAYER = 53,
	PART_ROAR_MIN_LAYER = 54,
	PART_MAX_HP_BASE = 19,
	PART_PENETRATE_MIN_LAYER = 58,
	PART_MAD_MIN_LAYER = 56,
	PART_ROAR_MAX_LAYER = 55,
	PART_DAMAGE_ENHANCE = 6,
	PART_MAX_HP_ADDITION = 21,
	PART_IGNORE_PHY = 17,
	PART_ATK_MAG_MULTIPLICATION = 29,
	PART_WEAK_POINT_DAMAGE = 34,
	PART_PENETRATE_MAX_LAYER = 59,
	PART_SAN_BACK = 16,
	PART_DAMAGE_ENHANCE_SNIPE = 60,
	PART_PIERCED_TIMES = 61,
	PART_DAMAGE_ENHANCE_CHASE = 38,
	PART_BE_CURED = 13,
	PART_MAD_MAX_LAYER = 57,
	PART_NORMAL_SKILL_CD_OFFSET = 62,
	PART_INSPIRATION = 5,
	PART_TRUMP_SKILL_CD_OFFSET = 64,
	PART_DAMAGE_ENHANCE_MOONRING = 37,
	PART_CRIT_REDUCE = 9
}
BattleType = {
	ENDLESS_AIR = 8,
	TEST_AIR = 5,
	DUNGEON = 1,
	RODEO_AIR = 4,
	GM_LEVEL = 3,
	FREE_AIR = 7,
	PVP = 6,
	GM_CUSTOMIZE = 2
}
DeadReason = {
	HP_0_BY_BUFF = 2,
	SANITY_LOW = 3,
	HP_0_BY_ATTACK = 1,
	HP_0_BY_SKILL = 4
}
EndType = {
	RESTART = 3,
	DEFEAT = 2,
	SURRENDER = 4,
	VICTORY = 1
}
EntityType = {
	ENTITY_HALO_TERRAIN = 3,
	ENTITY_SYSTEM_NPC = 4,
	ENTITY_INTANGIBLE = 5,
	ENTITY_SUMMON = 6,
	ENTITY_MONSTER = 2,
	ENTITY_HERO = 1
}
GameType = {
	DEFAULT = 1,
	FOOTBALLPVP = 2
}
Gameplay = {
	GAME_RECORD = 2,
	GAME_CONSECUTIVE = 3,
	GAME_NORMAL = 1
}
MonsterType = {
	MONSTER_TYPE_BOSS = 2,
	MONSTER_TYPE_ELITE = 1,
	MONSTER_TYPE_NORMAL = 0
}
PlayerChangeReason = {
	PLOT = 2,
	OVERDRAWN_SANITY = 1
}
PositionChangingMethod = {
	POSITION_CHANGING_METHOD_SMOOTH = 2,
	POSITION_CHANGING_METHOD_SUDDEN = 1
}
Relation = {
	FRIEND = 2,
	NEUTRAL = 3,
	ENEMY = 1
}
RemoveReason = {
	REASON_OTHER = 2,
	REASON_RETREAT = 1
}
SkillSourceType = {
	ENTITY = 2,
	BUFF = 3,
	OTHER = 4,
	ADDITIONAL_TERRAIN = 1
}
SkillType = {
	SKILL_TYPE_DEPUTY = 6,
	SKILL_TYPE_TRUMP = 3,
	SKILL_TYPE_NORMAL = 1,
	SKILL_TYPE_GLOBAL = 9,
	SKILL_TYPE_ECHO = 5,
	SKILL_TYPE_EQUIPMENT = 7,
	SKILL_TYPE_PASSIVE = 10,
	SKILL_TYPE_SPECIAL = 2,
	SKILL_TYPE_TALENT = 4,
	SKILL_TYPE_EXTRA = 8
}
State = {
	STEPPABLE_AGAIN = 9,
	DEFENDER_CANNOT_COUNTER = 6,
	SILENT = 13,
	NEXT_SKILL_ENHANCED = 8,
	COUNTER_BEFORE_ATTACK = 4,
	SNIPING = 10,
	IGNORE_NEAR = 7,
	PHYSICAL_DAMAGING_ONE_HP = 17,
	CANNOT_INCR_HP = 15,
	MAGICAL_DAMAGING_ONE_HP = 18,
	CANNOT_CHANGE_POSITION = 20,
	DAMAGING_ONE_HP = 14,
	DOUBLE_ATTACK = 12,
	CANNOT_NORMAL_ATTACK = 1,
	CHASE = 5,
	PIERCEABLE = 21,
	ALWAYS_CRITICAL = 11,
	CANNOT_MOVE = 2,
	IGNORE_DISTANCE_WHEN_COUNTER = 3,
	CHANGE_CAMP_WHEN_OVERDRAWN = 22,
	INVINCIBLE = 16,
	CANNOT_COUNTER = 19,
	IGNORE_BARRIER = 23
}
TagEnhanceCmd = {
	REPLACE = 1,
	MUL = 3,
	ADD = 2
}
AdditionalTerrainNO = protobuf.Message(type_descriptors.AdditionalTerrainNO)
AiModeChangeNO = protobuf.Message(type_descriptors.AiModeChangeNO)
AirMapInfoNO = protobuf.Message(type_descriptors.AirMapInfoNO)
AirMessageNO = protobuf.Message(type_descriptors.AirMessageNO)
AmbushNO = protobuf.Message(type_descriptors.AmbushNO)
AnimationPostedPush = protobuf.Message(type_descriptors.AnimationPostedPush)
AssistTagNO = protobuf.Message(type_descriptors.AssistTagNO)
AttributeModifiedEventNO = protobuf.Message(type_descriptors.AttributeModifiedEventNO)
AttributeNO = protobuf.Message(type_descriptors.AttributeNO)
AttributePartNO = protobuf.Message(type_descriptors.AttributePartNO)
BackEventNO = protobuf.Message(type_descriptors.BackEventNO)
BackToReply = protobuf.Message(type_descriptors.BackToReply)
BackToRequest = protobuf.Message(type_descriptors.BackToRequest)
BattleEndedEventNO = protobuf.Message(type_descriptors.BattleEndedEventNO)
BattleExtraNO = protobuf.Message(type_descriptors.BattleExtraNO)
BattleInfoNO = protobuf.Message(type_descriptors.BattleInfoNO)
BattleStartPush = protobuf.Message(type_descriptors.BattleStartPush)
BattlefieldNO = protobuf.Message(type_descriptors.BattlefieldNO)
BornCellNO = protobuf.Message(type_descriptors.BornCellNO)
BuffAddedEventNO = protobuf.Message(type_descriptors.BuffAddedEventNO)
BuffRemovedEventNO = protobuf.Message(type_descriptors.BuffRemovedEventNO)
BuffRoundDecredEventNO = protobuf.Message(type_descriptors.BuffRoundDecredEventNO)
BuffTriggeredEventNO = protobuf.Message(type_descriptors.BuffTriggeredEventNO)
BuildingNO = protobuf.Message(type_descriptors.BuildingNO)
CancelReadyReply = protobuf.Message(type_descriptors.CancelReadyReply)
CancelReadyRequest = protobuf.Message(type_descriptors.CancelReadyRequest)
CellNO = protobuf.Message(type_descriptors.CellNO)
CellsBlockedEventNO = protobuf.Message(type_descriptors.CellsBlockedEventNO)
CenterShapeNO = protobuf.Message(type_descriptors.CenterShapeNO)
CircleNO = protobuf.Message(type_descriptors.CircleNO)
ConnectCompleteReply = protobuf.Message(type_descriptors.ConnectCompleteReply)
ConnectCompleteRequest = protobuf.Message(type_descriptors.ConnectCompleteRequest)
ConnectReply = protobuf.Message(type_descriptors.ConnectReply)
ConnectRequest = protobuf.Message(type_descriptors.ConnectRequest)
ConnectStateChangePush = protobuf.Message(type_descriptors.ConnectStateChangePush)
ConnectStateNO = protobuf.Message(type_descriptors.ConnectStateNO)
CrossLineNO = protobuf.Message(type_descriptors.CrossLineNO)
CuredEventNO = protobuf.Message(type_descriptors.CuredEventNO)
DamagedEventNO = protobuf.Message(type_descriptors.DamagedEventNO)
DeleteUnfinishedBattleReply = protobuf.Message(type_descriptors.DeleteUnfinishedBattleReply)
DeleteUnfinishedBattleRequest = protobuf.Message(type_descriptors.DeleteUnfinishedBattleRequest)
DisconnectReply = protobuf.Message(type_descriptors.DisconnectReply)
DisconnectRequest = protobuf.Message(type_descriptors.DisconnectRequest)
DoomForecastNO = protobuf.Message(type_descriptors.DoomForecastNO)
EffectNO = protobuf.Message(type_descriptors.EffectNO)
EndReadyReply = protobuf.Message(type_descriptors.EndReadyReply)
EndReadyRequest = protobuf.Message(type_descriptors.EndReadyRequest)
EndStageReply = protobuf.Message(type_descriptors.EndStageReply)
EndStageRequest = protobuf.Message(type_descriptors.EndStageRequest)
EntityConfigChangedEventNO = protobuf.Message(type_descriptors.EntityConfigChangedEventNO)
EntityDeadEventNO = protobuf.Message(type_descriptors.EntityDeadEventNO)
EntityHoldNO = protobuf.Message(type_descriptors.EntityHoldNO)
EntityNO = protobuf.Message(type_descriptors.EntityNO)
EntityPlayerChangedEventNO = protobuf.Message(type_descriptors.EntityPlayerChangedEventNO)
EntityRemovedNO = protobuf.Message(type_descriptors.EntityRemovedNO)
EntitySteppedEventNO = protobuf.Message(type_descriptors.EntitySteppedEventNO)
EventNO = protobuf.Message(type_descriptors.EventNO)
ExtraNO = protobuf.Message(type_descriptors.ExtraNO)
ForecastAiNO = protobuf.Message(type_descriptors.ForecastAiNO)
ForecastAiReply = protobuf.Message(type_descriptors.ForecastAiReply)
ForecastAiRequest = protobuf.Message(type_descriptors.ForecastAiRequest)
ForecastReply = protobuf.Message(type_descriptors.ForecastReply)
ForecastRequest = protobuf.Message(type_descriptors.ForecastRequest)
ForecastTagNO = protobuf.Message(type_descriptors.ForecastTagNO)
FractionNO = protobuf.Message(type_descriptors.FractionNO)
FractionPointNO = protobuf.Message(type_descriptors.FractionPointNO)
GetBackInfoReply = protobuf.Message(type_descriptors.GetBackInfoReply)
GetBackInfoRequest = protobuf.Message(type_descriptors.GetBackInfoRequest)
GroupEventNO = protobuf.Message(type_descriptors.GroupEventNO)
HaloLinkedNO = protobuf.Message(type_descriptors.HaloLinkedNO)
HaloRefreshedEventNO = protobuf.Message(type_descriptors.HaloRefreshedEventNO)
HeroNO = protobuf.Message(type_descriptors.HeroNO)
ImmuneBuffAddNO = protobuf.Message(type_descriptors.ImmuneBuffAddNO)
ImmuneBuffRemoveNO = protobuf.Message(type_descriptors.ImmuneBuffRemoveNO)
LightColumnNO = protobuf.Message(type_descriptors.LightColumnNO)
LineNO = protobuf.Message(type_descriptors.LineNO)
LinkLineNO = protobuf.Message(type_descriptors.LinkLineNO)
LogBattleLogPush = protobuf.Message(type_descriptors.LogBattleLogPush)
MapMessageNO = protobuf.Message(type_descriptors.MapMessageNO)
MessageCompositeNO = protobuf.Message(type_descriptors.MessageCompositeNO)
MessagePartNO = protobuf.Message(type_descriptors.MessagePartNO)
ModelChangedNO = protobuf.Message(type_descriptors.ModelChangedNO)
ModelRectangleNO = protobuf.Message(type_descriptors.ModelRectangleNO)
MoonRingTagNO = protobuf.Message(type_descriptors.MoonRingTagNO)
MoveEntityReply = protobuf.Message(type_descriptors.MoveEntityReply)
MoveEntityRequest = protobuf.Message(type_descriptors.MoveEntityRequest)
MovedEventNO = protobuf.Message(type_descriptors.MovedEventNO)
MultiEntityHoldNO = protobuf.Message(type_descriptors.MultiEntityHoldNO)
MultiRoundAoeAddNO = protobuf.Message(type_descriptors.MultiRoundAoeAddNO)
MultiRoundAoeNO = protobuf.Message(type_descriptors.MultiRoundAoeNO)
MultiRoundAoeRemoveNO = protobuf.Message(type_descriptors.MultiRoundAoeRemoveNO)
MultiRoundAoeUpdateNO = protobuf.Message(type_descriptors.MultiRoundAoeUpdateNO)
MultipleShapeNO = protobuf.Message(type_descriptors.MultipleShapeNO)
NoteCellNO = protobuf.Message(type_descriptors.NoteCellNO)
OffsetShapeNO = protobuf.Message(type_descriptors.OffsetShapeNO)
OnEventTriggeredPush = protobuf.Message(type_descriptors.OnEventTriggeredPush)
ParallelRectangleNO = protobuf.Message(type_descriptors.ParallelRectangleNO)
PianoPlayingEventNO = protobuf.Message(type_descriptors.PianoPlayingEventNO)
PlaceEntityNO = protobuf.Message(type_descriptors.PlaceEntityNO)
PlaceEntityReply = protobuf.Message(type_descriptors.PlaceEntityReply)
PlaceEntityRequest = protobuf.Message(type_descriptors.PlaceEntityRequest)
PlayerNO = protobuf.Message(type_descriptors.PlayerNO)
PlayerStatisticNO = protobuf.Message(type_descriptors.PlayerStatisticNO)
PlotChainTriggeredEventNO = protobuf.Message(type_descriptors.PlotChainTriggeredEventNO)
PlotTriggered = protobuf.Message(type_descriptors.PlotTriggered)
PlotTriggered3D = protobuf.Message(type_descriptors.PlotTriggered3D)
PointNO = protobuf.Message(type_descriptors.PointNO)
PositionChangedEventNO = protobuf.Message(type_descriptors.PositionChangedEventNO)
PostEventAnimationReply = protobuf.Message(type_descriptors.PostEventAnimationReply)
PostEventAnimationRequest = protobuf.Message(type_descriptors.PostEventAnimationRequest)
PvpPlayerNO = protobuf.Message(type_descriptors.PvpPlayerNO)
ReadyStartPush = protobuf.Message(type_descriptors.ReadyStartPush)
ReconnectBattleReply = protobuf.Message(type_descriptors.ReconnectBattleReply)
ReconnectBattleRequest = protobuf.Message(type_descriptors.ReconnectBattleRequest)
RectangleNO = protobuf.Message(type_descriptors.RectangleNO)
RemoveEntityReply = protobuf.Message(type_descriptors.RemoveEntityReply)
RemoveEntityRequest = protobuf.Message(type_descriptors.RemoveEntityRequest)
ResultForecastAiPush = protobuf.Message(type_descriptors.ResultForecastAiPush)
ResultForecastPush = protobuf.Message(type_descriptors.ResultForecastPush)
RhombusNO = protobuf.Message(type_descriptors.RhombusNO)
SectorNO = protobuf.Message(type_descriptors.SectorNO)
SetAiControlledReply = protobuf.Message(type_descriptors.SetAiControlledReply)
SetAiControlledRequest = protobuf.Message(type_descriptors.SetAiControlledRequest)
ShapeNO = protobuf.Message(type_descriptors.ShapeNO)
ShapeTagNO = protobuf.Message(type_descriptors.ShapeTagNO)
ShapeWithRootNO = protobuf.Message(type_descriptors.ShapeWithRootNO)
SheetMusicNO = protobuf.Message(type_descriptors.SheetMusicNO)
ShootNO = protobuf.Message(type_descriptors.ShootNO)
SkillCdNO = protobuf.Message(type_descriptors.SkillCdNO)
SkillCdUpdateEventNO = protobuf.Message(type_descriptors.SkillCdUpdateEventNO)
SkillChangedEventNO = protobuf.Message(type_descriptors.SkillChangedEventNO)
SkillNO = protobuf.Message(type_descriptors.SkillNO)
SkillSourceNO = protobuf.Message(type_descriptors.SkillSourceNO)
SkillTriggeredEventNO = protobuf.Message(type_descriptors.SkillTriggeredEventNO)
StageNO = protobuf.Message(type_descriptors.StageNO)
StateChangedEventNO = protobuf.Message(type_descriptors.StateChangedEventNO)
StepHistoryNO = protobuf.Message(type_descriptors.StepHistoryNO)
StepReply = protobuf.Message(type_descriptors.StepReply)
StepRequest = protobuf.Message(type_descriptors.StepRequest)
SteppableChangeNO = protobuf.Message(type_descriptors.SteppableChangeNO)
SurrenderReply = protobuf.Message(type_descriptors.SurrenderReply)
SurrenderRequest = protobuf.Message(type_descriptors.SurrenderRequest)
TacitTaskProgressEventNO = protobuf.Message(type_descriptors.TacitTaskProgressEventNO)
TagBaseNO = protobuf.Message(type_descriptors.TagBaseNO)
TagEnhanceAddNO = protobuf.Message(type_descriptors.TagEnhanceAddNO)
TagEnhanceContextNO = protobuf.Message(type_descriptors.TagEnhanceContextNO)
TagEnhanceNO = protobuf.Message(type_descriptors.TagEnhanceNO)
TagEnhanceRemoveNO = protobuf.Message(type_descriptors.TagEnhanceRemoveNO)
TagEventWithBaseNO = protobuf.Message(type_descriptors.TagEventWithBaseNO)
TagNO = protobuf.Message(type_descriptors.TagNO)
TaskTriggerNO = protobuf.Message(type_descriptors.TaskTriggerNO)
TerrainChangeNO = protobuf.Message(type_descriptors.TerrainChangeNO)
TriggeringNO = protobuf.Message(type_descriptors.TriggeringNO)
TurnNO = protobuf.Message(type_descriptors.TurnNO)
UnfinishedBattleExpiredPush = protobuf.Message(type_descriptors.UnfinishedBattleExpiredPush)
UnfinishedBattlePush = protobuf.Message(type_descriptors.UnfinishedBattlePush)
WeakPointAddedEventNO = protobuf.Message(type_descriptors.WeakPointAddedEventNO)
WeakPointHpChangedEventNO = protobuf.Message(type_descriptors.WeakPointHpChangedEventNO)
WeakPointRemovedEventNO = protobuf.Message(type_descriptors.WeakPointRemovedEventNO)
WeakPointStatusChangedEventNO = protobuf.Message(type_descriptors.WeakPointStatusChangedEventNO)
WholeBattleBoardNO = protobuf.Message(type_descriptors.WholeBattleBoardNO)
WinConditionNO = protobuf.Message(type_descriptors.WinConditionNO)
WonConditionsChangedEventNO = protobuf.Message(type_descriptors.WonConditionsChangedEventNO)

return _G["logic.proto.BattleExtension_pb"]
