LuaS 

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2904901/cfg_skill_view_490490103.lua         0   À 
@@
À@
@A
ÀA
@B
ÀB
@CK  Á@  A  A A  Á  K Â kB «@Ë Á  AÁ   ÁÁ  B  A  Á «B ë@AA A Á Â  AÂ   Ë C ëB +Ak@  Á      ¦  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ÿ       PlayAudio,audioID=6253,audioType=1; PlayCasterBindEffect,effectID=290490103; PlayCasterMaterialAnim,animName=eff_2904901_idle_xiaoshi; Wait,waitTime=350; PlayRoleTeleport,type=3; PlayRoleTeleport,type=5; Wait,waitTime=250; PlayRoleTeleport,type=6; PlayCasterMaterialAnim,animName=eff_2904901_idle_chuxian; PlayCasterTurnToPlayer; PlayCasterBindEffect,effectID=290490104; Wait,waitTime=400; ÿ	       PlayAudio,audioID=6254,audioType=1; PlayCasterAnimation,animName=Skill01; PlayCasterBindEffect,effectID=290490105; Wait,waitTime=500; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=500; DataSelectBuff,buffIndex=1; PlayAddBuffView,buffID=PARAM.buffID1,label=buffLoop; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; Wait,waitTime=200; ® DataSelectBuff,buffIndex=1; PlayAddBuffView,buffID=PARAM.buffID2,label=buffLoopp; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoopp; Wait,waitTime=200;         0                                                                                                                                                      key   0   config+   0      _ENV