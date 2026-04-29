require("logic_cmpt_register")
require("render_cmpt_register")
require("shared_cmpt_register")
_staticClass("MatchPackInstaller")

function MatchPackInstaller:InstallEntityComponentsLookup(weComponents)
  weComponents:MergeLookup(LogicComponentsRegister)
  weComponents:MergeLookup(SharedComponentsRegister)
  weComponents:MergeLookup(RenderComponentsRegister)
end

function MatchPackInstaller:InstallUniqueComponentsLookup(uniqueComponents)
  uniqueComponents:MergeLookup(LogicUniqueComponentsRegister)
  uniqueComponents:MergeLookup(SharedUniqueComponentsRegister)
  uniqueComponents:MergeLookup(RenderUniqueComponentsRegister)
end

function MatchPackInstaller:InstallEntityMatchers(entityMatchers, weComponents)
  entityMatchers.Pet = Matcher:New({
    weComponents.Pet
  }, {}, {})
  entityMatchers.HP = Matcher:New({
    weComponents.HP
  }, {}, {})
  entityMatchers.AI = Matcher:New({
    weComponents.AI
  }, {}, {})
  entityMatchers.GridLocation = Matcher:New({
    weComponents.GridLocation
  }, {}, {})
  entityMatchers.Piece = Matcher:New({
    weComponents.Piece
  }, {}, {})
  entityMatchers.MoveFSM = Matcher:New({
    weComponents.MoveFSM
  }, {}, {})
  entityMatchers.LinkLineIndex = Matcher:New({
    weComponents.LinkLineIndex
  }, {}, {})
  entityMatchers.GridMove = Matcher:New({
    weComponents.GridMove
  }, {}, {})
  entityMatchers.AnimatorController = Matcher:New({
    weComponents.AnimatorController
  }, {}, {})
  entityMatchers.ConnectPieces = Matcher:New({
    weComponents.ConnectPieces
  }, {}, {})
  entityMatchers.ChainMove = Matcher:New({
    weComponents.ChainMove,
    weComponents.MoveFSM
  }, {}, {})
  entityMatchers.MonsterAttackRange = Matcher:New({
    weComponents.MonsterAttackRange
  }, {}, {})
  entityMatchers.Buff = Matcher:New({
    weComponents.Buff
  }, {}, {})
  entityMatchers.HP = Matcher:New({
    weComponents.HP
  }, {}, {})
  entityMatchers.EntityType = Matcher:New({
    weComponents.EntityType
  }, {}, {})
  entityMatchers.BlockFlag = Matcher:New({
    weComponents.BlockFlag
  }, {}, {})
  entityMatchers.EffectController = Matcher:New({
    weComponents.EffectController
  }, {}, {})
  entityMatchers.EffectHolder = Matcher:New({
    weComponents.EffectHolder
  }, {}, {})
  entityMatchers.EffectLineRenderer = Matcher:New({
    weComponents.EffectLineRenderer
  }, {}, {})
  entityMatchers.ChainSkill = Matcher:New({
    weComponents.ChainSkill
  }, {}, {})
  entityMatchers.PreviewActiveSkill = Matcher:New({
    weComponents.PreviewActiveSkill
  }, {}, {})
  entityMatchers.PreviewStageEffectRecord = Matcher:New({
    weComponents.PreviewStageEffectRecord
  }, {}, {})
  entityMatchers.ChainSkillFlag = Matcher:New({
    weComponents.ChainSkillFlag
  }, {}, {})
  entityMatchers.ChainSkillSequence = Matcher:New({
    weComponents.ChainSkillSequence
  }, {}, {})
  entityMatchers.MaterialFlash = Matcher:New({
    weComponents.MaterialFlash
  }, {}, {})
  entityMatchers.PreviewPieceTurn = Matcher:New({
    weComponents.PreviewPieceTurn
  }, {}, {})
  entityMatchers.LinkageInfo = Matcher:New({
    weComponents.LinkageInfo
  }, {}, {})
  entityMatchers.PreviewChainSkill = Matcher:New({
    weComponents.PreviewChainSkill
  }, {}, {})
  entityMatchers.PreviewChainSkillRange = Matcher:New({
    weComponents.PreviewChainSkillRange
  }, {}, {})
  entityMatchers.ChainPreviewMonsterBehavior = Matcher:New({
    weComponents.ChainPreviewMonsterBehavior
  }, {}, {})
  entityMatchers.LinkageNum = Matcher:New({
    weComponents.LinkageNum
  }, {}, {})
  entityMatchers.LinkLineRender = Matcher:New({
    weComponents.LinkLineRender
  }, {}, {})
  entityMatchers.GridEffect = Matcher:New({
    weComponents.GridEffect
  }, {}, {})
  entityMatchers.Element = Matcher:New({
    weComponents.Element
  }, {}, {})
  entityMatchers.SkillRoutine = Matcher:New({
    weComponents.SkillRoutine
  }, {}, {})
  entityMatchers.Team = Matcher:New({
    weComponents.Team
  }, {}, {})
  entityMatchers.Trap = Matcher:New({
    weComponents.Trap
  }, {}, {})
  entityMatchers.TrapID = Matcher:New({
    weComponents.TrapID
  }, {}, {})
  entityMatchers.PetPstID = Matcher:New({
    weComponents.PetPstID
  }, {}, {})
  entityMatchers.MonsterID = Matcher:New({
    weComponents.MonsterID
  }, {}, {})
  entityMatchers.PreviewConvertElement = Matcher:New({
    weComponents.PreviewConvertElement
  }, {}, {})
  entityMatchers.PreviewMonsterAction = Matcher:New({
    weComponents.PreviewMonsterAction
  }, {}, {})
  entityMatchers.PreviewTrapAction = Matcher:New({
    weComponents.PreviewTrapAction
  }, {}, {})
  entityMatchers.SkillTips = Matcher:New({
    weComponents.SkillTips
  }, {}, {})
  entityMatchers.HUD = Matcher:New({
    weComponents.HUD
  }, {}, {})
  entityMatchers.Boss = Matcher:New({
    weComponents.Boss
  }, {}, {})
  entityMatchers.FadeController = Matcher:New({
    weComponents.FadeController
  }, {}, {})
  entityMatchers.PreviewBrightGrid = Matcher:New({
    weComponents.PreviewBrightGrid
  }, {}, {})
  entityMatchers.PickUpTarget = Matcher:New({
    weComponents.PickUpTarget
  }, {}, {})
  entityMatchers.DeadFlag = Matcher:New({
    weComponents.DeadFlag
  }, {}, {})
  entityMatchers.PetDeadMark = Matcher:New({
    weComponents.PetDeadMark
  }, {}, {})
  entityMatchers.DamageWarningAreaElement = Matcher:New({
    weComponents.DamageWarningAreaElement
  }, {}, {})
  entityMatchers.TrapRoundInfo = Matcher:New({
    weComponents.TrapRoundInfo
  }, {}, {})
  entityMatchers.TrapRoundInfoRender = Matcher:New({
    weComponents.TrapRoundInfoRender
  }, {}, {})
  entityMatchers.EntityTypeAndView = Matcher:New({
    weComponents.EntityType,
    weComponents.View
  }, {}, {})
  entityMatchers.GuidePath = Matcher:New({
    weComponents.GuidePath
  }, {}, {})
  entityMatchers.GuidePreviewLinkLine = Matcher:New({
    weComponents.GuidePreviewLinkLine
  }, {}, {})
  entityMatchers.GuideWeakPath = Matcher:New({
    weComponents.GuideWeakPath
  }, {}, {})
  entityMatchers.GuideFinger = Matcher:New({
    weComponents.GuideFinger
  }, {}, {})
  entityMatchers.GuideLinkLine = Matcher:New({
    weComponents.GuideLinkLine
  }, {}, {})
  entityMatchers.GuideSpot = Matcher:New({
    weComponents.GuideSpot
  }, {}, {})
  entityMatchers.GuidePiece = Matcher:New({
    weComponents.GuidePiece
  }, {}, {})
  entityMatchers.Hitback = Matcher:New({
    weComponents.Hitback
  }, {}, {
    weComponents.Ghost
  })
  entityMatchers.PreviewHitback = Matcher:New({
    weComponents.Hitback,
    weComponents.Ghost
  }, {}, {})
  entityMatchers.MaterialAnimation = Matcher:New({
    weComponents.MaterialAnimation
  }, {}, {})
  entityMatchers.InnerStoryTips = Matcher:New({
    weComponents.InnerStoryTips
  }, {}, {})
  entityMatchers.BoardOutline = Matcher:New({
    weComponents.BoardOutline
  }, {}, {})
  entityMatchers.Ghost = Matcher:New({
    weComponents.Ghost
  }, {}, {})
  entityMatchers.GuideGhost = Matcher:New({
    weComponents.GuideGhost
  }, {}, {})
  entityMatchers.PickUpArrow = Matcher:New({
    weComponents.PickUpArrow
  }, {}, {})
  entityMatchers.MonsterEscape = Matcher:New({
    weComponents.MonsterEscape
  }, {}, {})
  entityMatchers.ElementRestrain = Matcher:New({
    weComponents.ElementRestrain
  }, {}, {})
  entityMatchers.BuffHeadEffect = Matcher:New({
    weComponents.BuffHeadEffect
  }, {}, {})
  entityMatchers.SuperEntity = Matcher:New({
    weComponents.SuperEntity
  }, {}, {})
  entityMatchers.BuffView = Matcher:New({
    weComponents.BuffView
  }, {}, {})
  entityMatchers.SkillRangeOutline = Matcher:New({
    weComponents.SkillRangeOutline
  }, {}, {})
  entityMatchers.LegacyAnimation = Matcher:New({
    weComponents.LegacyAnimation
  }, {}, {})
  entityMatchers.SkillContext = Matcher:New({
    weComponents.SkillContext
  }, {}, {})
  entityMatchers.SkillHolder = Matcher:New({
    weComponents.SkillHolder
  }, {}, {})
  entityMatchers.Phantom = Matcher:New({
    weComponents.Phantom
  }, {}, {})
  entityMatchers.EditorInfo = Matcher:New({
    weComponents.EditorInfo
  }, {}, {})
  entityMatchers.SkillRoutineHolder = Matcher:New({
    weComponents.SkillRoutineHolder
  }, {}, {})
  entityMatchers.BenumbEffect = Matcher:New({
    weComponents.BenumbEffect
  }, {}, {})
  entityMatchers.DeadMark = Matcher:New({
    weComponents.DeadMark
  }, {}, {})
  entityMatchers.ShowDeath = Matcher:New({
    weComponents.ShowDeath
  }, {}, {})
  entityMatchers.RenderState = Matcher:New({
    weComponents.RenderState
  }, {}, {})
  entityMatchers.FakeInput = Matcher:New({
    weComponents.FakeInput
  }, {}, {})
  entityMatchers.ScopeCenter = Matcher:New({
    weComponents.ScopeCenter
  }, {}, {})
  entityMatchers.LinkRendererData = Matcher:New({
    weComponents.LinkRendererData
  }, {}, {})
  entityMatchers.TestRobot = Matcher:New({
    weComponents.TestRobot
  }, {}, {})
  entityMatchers.PreviewEnv = Matcher:New({
    weComponents.PreviewEnv
  }, {}, {})
  entityMatchers.MatchPet = Matcher:New({
    weComponents.MatchPet
  }, {}, {})
  entityMatchers.PreviewChainPath = Matcher:New({
    weComponents.PreviewChainPath
  }, {}, {})
  entityMatchers.BulletTime = Matcher:New({
    weComponents.BulletTime
  }, {}, {})
  entityMatchers.AppearTriggerTrap = Matcher:New({
    weComponents.AppearTriggerTrap
  }, {}, {})
  entityMatchers.AffixData = Matcher:New({
    weComponents.AffixData
  }, {}, {})
  entityMatchers.CurseTower = Matcher:New({
    weComponents.CurseTower
  }, {}, {})
  entityMatchers.TrapExtendSkillScope = Matcher:New({
    weComponents.TrapExtendSkillScope
  }, {}, {})
  entityMatchers.SceneCameraScreenshot = Matcher:New({
    weComponents.SceneCameraScreenshot
  }, {}, {})
  entityMatchers.CutsceneMonster = Matcher:New({
    weComponents.CutsceneMonster
  }, {}, {})
  entityMatchers.AliveMonster = Matcher:New({
    weComponents.MonsterID
  }, {}, {
    weComponents.DeadMark
  })
  entityMatchers.Alignment = Matcher:New({
    weComponents.Alignment
  }, {}, {})
  entityMatchers.MarkGrid = Matcher:New({
    weComponents.MarkGrid
  }, {}, {})
  entityMatchers.DamageStatistics = Matcher:New({
    weComponents.DamageStatistics
  }, {}, {})
  entityMatchers.Skin = Matcher:New({
    weComponents.Skin
  }, {}, {})
  entityMatchers.ChessPet = Matcher:New({
    weComponents.ChessPet
  }, {}, {})
  entityMatchers.PickUpChessResult = Matcher:New({
    weComponents.PickUpChessResult
  }, {}, {})
  entityMatchers.ChessPetRender = Matcher:New({
    weComponents.ChessPetRender
  }, {}, {})
  entityMatchers.LogicFeature = Matcher:New({
    weComponents.LogicFeature
  }, {}, {})
  entityMatchers.RenderFeature = Matcher:New({
    weComponents.RenderFeature
  }, {}, {})
  entityMatchers.SyncMoveWithTeam = Matcher:New({
    weComponents.SyncMoveWithTeam
  }, {}, {})
  entityMatchers.RenderSyncMoveWithTeam = Matcher:New({
    weComponents.RenderSyncMoveWithTeam
  }, {}, {})
  entityMatchers.Ride = Matcher:New({
    weComponents.Ride
  }, {}, {})
  entityMatchers.TrapAreaElement = Matcher:New({
    weComponents.TrapAreaElement
  }, {}, {})
  entityMatchers.RideRender = Matcher:New({
    weComponents.RideRender
  }, {}, {})
  entityMatchers.TeleportRecord = Matcher:New({
    weComponents.TeleportRecord
  }, {}, {})
  entityMatchers.OutsideRegion = Matcher:New({
    weComponents.OutsideRegion
  }, {}, {})
  entityMatchers.TrapAurasOutline = Matcher:New({
    weComponents.TrapAurasOutline
  }, {}, {})
  entityMatchers.AuraRange = Matcher:New({
    weComponents.AuraRange
  }, {}, {})
  entityMatchers.LogicChainDamage = Matcher:New({
    weComponents.LogicChainDamage
  }, {}, {})
  entityMatchers.ShareSkillResult = Matcher:New({
    weComponents.ShareSkillResult
  }, {}, {})
  entityMatchers.Talent = Matcher:New({
    weComponents.Talent
  }, {}, {})
  entityMatchers.OffBoardMonster = Matcher:New({
    weComponents.OffBoardMonster
  }, {}, {})
  entityMatchers.Mirage = Matcher:New({
    weComponents.Mirage
  }, {}, {})
  entityMatchers.MoveScopeRecord = Matcher:New({
    weComponents.MoveScopeRecord
  }, {}, {})
  entityMatchers.PreviewLinkLine = Matcher:New({
    weComponents.PreviewLinkLine
  }, {}, {})
  entityMatchers.PreviewPickUp = Matcher:New({
    weComponents.PreviewPickUp
  }, {}, {})
  entityMatchers.RenderPickUp = Matcher:New({
    weComponents.RenderPickUp
  }, {}, {})
  entityMatchers.PopStarLogic = Matcher:New({
    weComponents.PopStarLogic
  }, {}, {})
  entityMatchers.PopStarPickUpResult = Matcher:New({
    weComponents.PopStarPickUpResult
  }, {}, {})
  entityMatchers.PreviewPuzzle = Matcher:New({
    weComponents.PreviewPuzzle
  }, {}, {})
  entityMatchers.UnscaledCountDownRender = Matcher:New({
    weComponents.UnscaledCountDownRender
  }, {}, {})
  entityMatchers.UnscaledCountDownLogic = Matcher:New({
    weComponents.UnscaledCountDownLogic
  }, {}, {})
  entityMatchers.Fetters = Matcher:New({
    weComponents.Fetters
  }, {}, {})
  entityMatchers.BattleDamageStatistics = Matcher:New({
    weComponents.BattleDamageStatistics
  }, {}, {})
  entityMatchers.BattleEnterData = Matcher:New({
    weComponents.BattleEnterData
  }, {}, {})
  entityMatchers.LogicAutoBead = Matcher:New({
    weComponents.LogicAutoBead
  }, {}, {})
end
