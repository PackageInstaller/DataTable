local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7
}
local config = {
  {
    1,
    1,
    0,
    1,
    0,
    0,
    {
      " PlayControlMonsterTeleportAndAttack, teleportWaitTime=100, teleportAnim=idle, teleportMaterialAnim=eff_2910301_skill02_shadow_in, teleportDurationTime=200, teleportFinishAnim=Atk2, damageWaitTime=2000, damageAnim=Atk1, hitEffectID=0, damageEffectID=291030109, damageEffectWaitTime=660, damageTexttWaitTime=800, damageDurationTime=2000; PlayAllHitBack; "
    }
  }
}
return config, "ID", key
