LuaS 

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2003101/cfg_skill_view_200310103.lua            Ŕ 
@@
Ŕ@
@A
ŔA
@B
ŔB
@CK   Á@  A  A A  Á  K Â kB Ť@k@   Á      Ś  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ˙đ       PlayCasterAnimation,animName =skill02; PlayAudio,audioID = 7052,audioType=1; PlayCasterBindEffect,effectID=200310104; PlayCasterMaterialAnim,animName=eff_2003101_skill02; Wait,waitTime=550; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=200310102; PlayTargetAddBuff,buffID=200310104; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; PlayTargetBindEffect,effectID=200310105; Wait,waitTime=850;                                                                                             key      config         _ENV