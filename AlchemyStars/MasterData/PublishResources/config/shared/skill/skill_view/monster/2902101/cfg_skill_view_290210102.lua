LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/b/1705/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/2902101/cfg_skill_view_290210102.lua         0   À 
@@
À@
@A
ÀA
@B
ÀB
@CK  Á@  A  A A  Á  K Â kB «@Ë Á  AÁ   ÁÁ  B  A  Á «B ë@AA A Á Â  AÂ   Ë C ëB +Ak@  Á      ¦  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam                DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=PARAM.buffID,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; ÿ¿       PlayCasterAnimation,animName=Skill02; PlayAudio,audioID=6179,audioType=1; Wait,waitTime=300; PlayCasterBindEffect,effectID=3414; Wait,waitTime=30; PlayCasterMaterialAnim,animName=eff_2902101_skill02_main; Wait,waitTime=700; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3413,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; PlayShuffleTeamOrder; Ã DataSelectResult,effectType=120,index=1; PlayDestroyMonster,label=foreach; DataSelectNextResult,effectType=120; Jump,condition=CheckEffectResultIndex,param=120,goto=foreach; Wait,waitTime=800;         0                                                                                                                                                      key   0   config+   0      _ENV