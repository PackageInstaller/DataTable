LuaS 

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2002001/cfg_skill_view_200200112.lua            Ŕ 
@@
Ŕ@
@A
ŔA
@B
ŔB
@CK   Á@  A  A A  Á  K Â kB Ť@k@   Á      Ś  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ˙r       DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow; Wait,waitTime=50; PlayCasterAnimation,animName = skill01; Wait,waitTime=700; PlayFlyEffectCasterToTarget,flyEffectID=200200101,flyTrace=1,flySpeed = 300,offsety=0.4,targetPos=Hit; Wait,waitTime=500; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectBuff,buffIndex=1; PlayAddBuffView,buffID=20021,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain;                                                                                             key      config         _ENV