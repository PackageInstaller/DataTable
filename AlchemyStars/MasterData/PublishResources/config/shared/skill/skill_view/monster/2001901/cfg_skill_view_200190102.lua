LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/b/1140/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/2001901/cfg_skill_view_200190102.lua            Ŕ 
@@
Ŕ@
@A
ŔA
@B
ŔB
@CK   Á@  A  A A  Á  K Â kB Ť@k@   Á      Ś  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ˙	       PlayCasterAnimation,animName=Skill02; PlayAudio,audioID =7011,audioType=1; PlayCasterBindEffect,effectID=200190105; DataSelectDamage,damageIndex=1; PlayEffectAtTargetPos,effectID=200190106; Wait,waitTime=500; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3827,turnToTarget=1,deathClear=0; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; Wait,waitTime=1000;                                                                                             key      config         _ENV