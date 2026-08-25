local rc = {
  GameObjectLayer = {Actor = 10},
  SortingLayer = {
    Background = CS.UnityEngine.SortingLayer.NameToID("Background"),
    Effect1 = CS.UnityEngine.SortingLayer.NameToID("Effect1"),
    Actor = CS.UnityEngine.SortingLayer.NameToID("Actor"),
    Effect2 = CS.UnityEngine.SortingLayer.NameToID("Effect2")
  },
  OpMode = {
    Play = 1,
    Inspect = 2,
    SelectHandCard = 3,
    PlayDrama = 4
  },
  AnimatorType = {
    RemoveBuff = "RemoveBuff",
    Heal = "Heal",
    AddBuff = "AddBuff",
    Damage = "Damage",
    Immue = "Immue",
    Block = "Block"
  },
  CommonAnimator = {
    RemoveBuff = {
      prefab = "UIResources/UIEffects/Battle/E_se_buffdiushi_zi.prefab",
      animator = "UA_Battle_Buffdiushi",
      text = "Text"
    },
    Heal = {
      prefab = "UIResources/UIEffects/Battle/E_se_huifu_zi.prefab",
      animator = "UA_Battle_Huifu",
      text = "Text"
    },
    AddBuff = {
      prefab = "UIResources/UIEffects/Battle/E_se_huodebuff_zi.prefab",
      animator = "UA_Battle_huodebuff",
      text = "Text"
    },
    Damage = {
      prefab = "UIResources/UIEffects/Battle/E_se_kouxue_zi.prefab",
      animator = "UA_Battle_kouxue",
      text = "Text"
    },
    Immue = {
      prefab = "UI/UI_Battle/UI_Battle_Prefab/UI_Battle_Func_Anim_Block.prefab",
      animator = "UA_Battle_TextBlock",
      text = "Text_Anim_Block"
    },
    Block = {
      prefab = "UI/UI_Battle/UI_Battle_Prefab/UI_Battle_Func_Anim_Block.prefab",
      animator = "UA_Battle_TextBlock",
      text = "Text_Anim_Block"
    }
  },
  TimeLineEvent = {
    TargetSlashProgress = -131,
    ShaderGlobal = -130,
    ResumeSkill = -122,
    PauseSkill = -121,
    ShowSchoolTable = -120,
    HideSchoolTable = -119,
    ShowSuperUtlSkillPainting = -118,
    BanSpeedUp = -117,
    ShowAwakerPaintingById = -116,
    MainVMCamera = -115,
    StopVideo = -114,
    PlayVideo = -113,
    PrepareVideos = -112,
    ShowDimensionVideo = -111,
    HideDimensionVideo = -110,
    ShowBattleScene = -109,
    HideBattleScene = -108,
    SuperDimensionFinish = -107,
    SuperDimensionLoop = -106,
    SuperDimensionStart = -105,
    StateUIVisibleEvent = -104,
    SceneControlEvent = -103,
    StringEvent = -102,
    SceneTransEvent = -101,
    WWiseEvent = -100,
    MoveForward = 1,
    MoveBack = 2,
    HideUI = 3,
    ShowUI = 4,
    ShowAwakerPainting = 5,
    SwitchPortrait = 6,
    HideFollowEffect = 7,
    ShowFollowEffect = 8,
    SetAllAlpha = 9
  },
  AwakerMovingState = {
    StepForward = 1,
    Center = 2,
    StepBack = 3,
    Idle = 4
  },
  BattleEvent = {
    Start = "Start",
    StartStory = "StartStory",
    StartStoryDone = "StartStoryDone",
    LoadScene = "LoadScene",
    LoadSceneDone = "LoadSceneDone",
    EnterScene = "EnterScene",
    EntranceAnimationEnd = "EntranceAnimationEnd",
    BattleBeginAnimDone = "BattleBeginAnimDone",
    BattleEnd = "BattleEnd",
    FirstPlayedRecord = "FirstPlayedRecord",
    MoveCardToHand = "MoveCardToHand",
    InsertCard = "InsertCard",
    BattleSceneDispose = "BattleSceneDispose",
    ReceiveCmdWithNoBRender = "ReceiveCmdWithNoBRender",
    ReceiveCmdWithNoBRenderButResReady = "ReceiveCmdWithNoBRenderButResReady",
    DealInitBattle = "DealInitBattle",
    DealRecoverBattle = "DealRecoverBattle",
    DealResetBattleData = "DealResetBattleData",
    BattleUIOpen = "BattleUIOpen",
    BattleUIClose = "BattleUIClose",
    ShowReviveConfirm = "ShowReviveConfirm",
    OnReviveConfirm = "OnReviveConfirm"
  }
}
return rc
