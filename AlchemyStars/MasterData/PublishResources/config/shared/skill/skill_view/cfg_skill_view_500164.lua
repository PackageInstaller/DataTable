LuaS 

xV           (w@@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/cfg_skill_view_500164.lua            Ŕ 
@@
Ŕ@
@A
ŔA
@B
ŔB
@CK   Á@  A  A A  Á  K Â kB Ť@k@   Á      Ś  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ˙       DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=Finish; PlayFlyEffectCasterToTarget,flyEffectID=1021,flyTime=200,offsetx=0,offsety=0.7,offsetz=0,flyTrace=1,label=doAgain; Wait,waitTime=200; PlayTargetAddBuff,buffID=20021; PlayTargetBuffEffect,effectID=1022; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; Wait,waitTime=500,label=Finish;                                                                                             key      config         _ENV