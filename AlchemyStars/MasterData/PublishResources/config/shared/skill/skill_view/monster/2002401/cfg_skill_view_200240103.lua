LuaS 

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2002401/cfg_skill_view_200240103.lua         0   Ŕ 
@@
Ŕ@
@A
ŔA
@B
ŔB
@CK  Á@  A  A A  Á  K Â kB Ť@Ë Á  AÁ   ÁA   A  Á ŤB ë@AA A Á B  A  Ë C ëB +Ak@  Á      Ś  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               M Jump,condition=CheckHasTeleport,param=1,goto=phaseEnd; Wait,waitTime=2000; ö Jump,condition=CheckHasTeleport,param=0,goto=phaseEnd; PlayCasterAnimation,animName=skill02; PlayCasterBindEffect,effectID=200240104; PlayTeleportAsMoving,time=200,notifyBuff=1; Wait,waitTime=200; PlayDeleteCasterEffect,effectIDList=200240104; Č Wait,waitTime=200; DataSelectDamage,damageIndex = 1; PlayCasterTurnToTarget; PlayAudio,audioID = 6257,audioType=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200240103,turnToTarget=1,deathClear=0;         0                                                                                                                                                      key   0   config+   0      _ENV