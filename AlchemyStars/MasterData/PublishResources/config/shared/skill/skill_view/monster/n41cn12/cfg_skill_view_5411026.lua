LuaS 

xV           (w@_@../PublishResources/config/shared/skill/skill_view/monster/n41cn12/cfg_skill_view_5411026.lua            Ŕ 
@@
Ŕ@
@A
ŔA
@B
ŔB
@CK   Á@  A  A A  Á  K Â kB Ť@k@   Á      Ś  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ˙ź       DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCasterAnimation,animName = Atk; PlayAudio,audioID = 6014,audioType=1; PlayCasterBindEffect,effectID=PARAM.AtkEffectId; Wait,waitTime=1000; PlayTargetAddBuff,buffID=50001; PlayTargetAddBuff,buffID=50002; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1; Wait,waitTime=166; DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayTargetAddBuff,buffID=50001; PlayTargetAddBuff,buffID=50002; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=PARAM.Atk2EffectId,turnToTarget=1; DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow; Wait,waitTime=700;                                                                                             key      config         _ENV