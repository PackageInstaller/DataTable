LuaS 

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2902801/cfg_skill_view_290280152.lua            Ŕ 
@@
Ŕ@
@A
ŔA
@B
ŔB
@CK   Á@  A  A A  Á  K Â kB Ť@k@   Á      Ś  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ˙       PlayAudio,audioID = 6304,audioType=1; Wait,waitTime=100; PlayCasterAnimation,animName = skill05; PlayCasterBindEffect,effectID=290280110; Wait,waitTime=800; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,label=foreach; PlayEffectAtTargetGrid,effectID=290280112; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach; Wait,waitTime=500; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,label=goo; PlayFlyEffectCasterToTarget,flyEffectID=290280111,flyTime=200,flyTrace=1,offsety=0.939,isBlock=0,caster=Target,target=Caster; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=goo; Wait,waitTime=150; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290280109,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=2550;                                                                                             key      config         _ENV