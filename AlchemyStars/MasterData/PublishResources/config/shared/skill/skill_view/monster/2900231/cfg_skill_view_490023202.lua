LuaS 

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2900231/cfg_skill_view_490023202.lua         0   Ŕ 
@@
Ŕ@
@A
ŔA
@B
ŔB
@CK  Á@  A  A A  Á  K Â kB Ť@Ë Á  AÁ   ÁA   A   ÄBŔë@AA A Á B  AB   Ë C ëB +Ak@  Á      Ś  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               I PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID=828; +       audioIDá      
audioType      ˙­       DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID = 829,flySpeed = 50,flyTrace = 1,offsety=0.65,offsetz=0.75; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=830,turnToTarget=1,deathClear=false; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop;         0                                                                                                                                                      key   0   config+   0      _ENV