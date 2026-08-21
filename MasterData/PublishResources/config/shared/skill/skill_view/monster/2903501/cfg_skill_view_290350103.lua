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
    23,
    1,
    0,
    0,
    {showTime = 0}
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " PlayChargeAndStoneBreak,beginAnim=skill02_1,beginEffectID=290350103,beginAnimTime=800,chargeAnim=skill02_2,chargeEffectID=290350104,chargeTime=300,attackAnim=skill02_3,attackEffectID=290350105; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290350109,turnToTarget=1,deathClear=0; PlayHitBackAndStoneBreak; Wait,waitTime=500; DataSelectBuff,buffIndex=1; PlayAddBuffView,buffID=4119,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; Wait,waitTime=300; "
    }
  },
  {
    3,
    3,
    43,
    1,
    0,
    200,
    {audioID = 6235, audioType = 1}
  },
  {
    4,
    4,
    43,
    1,
    0,
    1500,
    {audioID = 6236, audioType = 1}
  }
}
return config, "ID", key
