LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/b/1140/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/2903401/cfg_skill_view_290340101.lua            Ŕ 
@@
Ŕ@
@A
ŔA
@B
ŔB
@CK   Á@  A  A A  Á  K Â kB Ť@k@   Á      Ś  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ˙Î       PlayCasterAnimation,animName =Skill05; PlayAudio,audioID = 6233,audioType=1; PlayCasterBindEffect,effectID=290340101; PlayCasterBindEffect,effectID=290340102; DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=290340103; PlayTargetMaterialAnim,animName=eff_2903401_atk05_hit02; PlayCasterMaterialAnim,animName=eff_2903401_atk05_hit; Wait,waitTime=600; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID1; PlayTargetAddBuff,buffID=PARAM.buffID2; PlayTargetAddBuff,buffID=PARAM.buffID3; PlayTargetAddBuff,buffID=PARAM.buffID4; PlayTargetAddBuff,buffID=PARAM.buffID5; PlayTargetAddBuff,buffID=PARAM.buffID6,remove=1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; Wait,waitTime=1000;                                                                                             key      config         _ENV