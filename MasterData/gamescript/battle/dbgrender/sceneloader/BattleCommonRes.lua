local BattleCommonRes = {}
BattleCommonRes.ResourcesList = {
  "UI/UI_Common/UI_Common_Prefab/UI_Common_Mask_Panel.prefab",
  "Effects/CommonPrefab/E_RE_Co_shield_broken.prefab",
  "UI/UI_Battle/UI_Battle_New/UI_Battle_Popup_Anger.prefab",
  "UI/UI_Battle/UI_Battle_Prefab/UI_Battle_Popup_Record_Tip_New.prefab",
  "UI/UI_Battle/UI_Battle_Prefab/UI_Battle_Popup_Keeper_Skill_Tip.prefab",
  "UI/UI_Battle/UI_Battle_Prefab/Func_Battle_CardDisplay.prefab",
  "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Battle_B11_Support.prefab",
  "UI/UI_Card/UI_Card_Prefab/UI_Vx_Card_ChangeAppear.prefab",
  "UI/UI_Card/UI_Card_Prefab/Item_Card_Rune.prefab",
  "UI/UI_Card/UI_Card_Prefab/UI_Vx_Card_Burn.prefab",
  "UI/UI_Battle/UI_Battle_Prefab/UI_Battle_Panel_CardStackLess.prefab",
  "UI/UI_Common/UI_Common_Prefab/UI_Common_Card_Keyword.prefab",
  "UI/UI_Battle/UI_Battle_Prefab/UI_Battle_Panel_CardStack.prefab",
  "UI/UI_Battle/UI_Battle_Prefab/UI_Battle_Popup_SelectAwaker.prefab",
  "Effects/CommonPrefab/E_Co_Poisoning.prefab",
  "Effects/CommonPrefab/E_RE_Co_shield_hit.prefab"
}
BattleCommonRes.ScoolResources = {
  [CommonDefine.AwakerSchool.Caro] = {
    BloodEffectPath = "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Battle_XueRou_01.prefab",
    BloodCardEffectPath = "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Battle_XueRou_02.prefab",
    BloodSwallowEffectPath = "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Battle_XueRou_03.prefab",
    BloodLineEffectPath = "UI/UI_Battle/UI_Battle_Prefab/UI_Vx_Battle_XueRou_04.prefab"
  },
  [CommonDefine.AwakerSchool.NewAequor] = {
    UI_Battle_ShenHai_Switch = "UI/UI_Battle/UI_Battle_Prefab/UI_Battle_ShenHai_Switch.prefab",
    E_SE_Tentacle_hit_blister = "Effects/Effect_Scene/E_SE_Tentacle_hit_blister.prefab",
    E_SE_Tentacle_Attack_01 = "Effects/Effect_Scene/E_SE_Tentacle_Attack_01.prefab",
    E_SE_Tentacle_Attack_02 = "Effects/Effect_Scene/E_SE_Tentacle_Attack_02.prefab",
    E_SE_Tentacle_Attack_03 = "Effects/Effect_Scene/E_SE_Tentacle_Attack_03.prefab",
    E_SE_Tentacle_Attack_04 = "Effects/Effect_Scene/E_SE_Tentacle_Attack_04.prefab"
  }
}
return BattleCommonRes
