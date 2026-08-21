GameResourceConst = {
  BookEffect = 338,
  GuideWeakPath = 446,
  MonsterAppearEffMultiBodyArea = {
    370,
    371,
    372,
    373
  },
  MonsterAppearEffSingleBodyArea = {
    319,
    320,
    321,
    322
  },
  PetAppearEff = {
    1322,
    1323,
    1324,
    1325
  },
  EffLinkLine2Exit = 319,
  EffRuchangKaichang = 325,
  EffRuchangGeziglow = 326,
  EffRuchuangPetBao = 327,
  EffRuchuangHeti = 328,
  EffRuchangActorpoint = "eff_ruchang_actorpoint",
  AnimRuchangCameratempLen = 3000,
  EffRuchangBlackboard = 1611,
  EffBoardShowLine = 1776,
  BrillantLine = "gezi_wangge.prefab",
  EnterFaceAnimCfgID = 3001,
  ChessPet_CanAction_SingleGridEffectID = 3481,
  ChessPet_CanAction_MultiGridEffectID = 3482,
  ChessPet_CanAction_Selected_SingleGridEffectID = 3483,
  ChessPet_CanAction_Selected_MultiGridEffectID = 3484,
  ChessPet_MoveRange_EffectID = 3478,
  ChessPet_AttackRange_EffectID = 3479,
  ChessPet_AttackTarget_EffectID = 3480,
  ChessPet_RecoverRange_EffectID = 34800,
  PrismEffectID = {
    62101,
    62102,
    62103,
    62104,
    62105
  },
  PrismEffectName = {
    "gezi_lingjing_blue_",
    "gezi_lingjing_red_",
    "gezi_lingjing_green_",
    "gezi_lingjing_yellow_",
    "gezi_lingjing_any_"
  },
  MaintainColorTrapEffectID = {
    28035011,
    28035012,
    28035013,
    28035014,
    28035015
  },
  MaintainColorTrapEffectName = {
    "eff_gezi_shense_",
    "eff_gezi_shense_",
    "eff_gezi_shense_",
    "eff_gezi_shense_",
    "eff_gezi_shense_"
  },
  End = 99999
}
_enum("GameResourceConst", GameResourceConst)
_class("GameCacheResGroup", Object)
GameCacheResGroup = GameCacheResGroup

function GameCacheResGroup:Constructor(t)
  self.EffectTable = {}
  self.EffectTable[GameResourceConst.BookEffect] = 1
  for _, eff in ipairs(GameResourceConst.MonsterAppearEffMultiBodyArea) do
    self.EffectTable[eff] = 2
  end
  for _, eff in ipairs(GameResourceConst.MonsterAppearEffSingleBodyArea) do
    self.EffectTable[eff] = 2
  end
  self.EffectTable[GameResourceConst.EffRuchangBlackboard] = 1
end
