LuaS 

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2905801/cfg_skill_view_290580112.lua         0   Ŕ 
@@
Ŕ@
@A
ŔA
@B
ŔB
@CK  Á@  A  A A  Á  K Â kB Ť@Ë Á  AÁ   ÁA  B  A  ÁB ŤB ë@AA A Á B  AB   Ë  ëB +Ak@  Á      Ś  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam                PlayCasterAnimation,animName=Atk2; PlayAudio,audioID =290580103,audioType=1; PlayCasterBindEffect,effectID=290580104; Wait,waitTime=3200; :      ˙V       DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 290580105,flyTime=200,flyTrace = 1,offsetx=-0.134,offsety=1.529,offsetz=0.33,targetPos=Root ; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290580106,turnToTarget=0,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; ű DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=5361005,label=doAgain; PlayTargetAddBuff,buffID=5361006; PlayTargetAddBuff,buffID=29058014; PlayTargetAddBuff,buffID=29058013; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain;         0                                                                                                                                                      key   0   config+   0      _ENV