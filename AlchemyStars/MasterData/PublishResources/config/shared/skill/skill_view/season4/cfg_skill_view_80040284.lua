LuaS 

xV           (w@X@../PublishResources/config/shared/skill/skill_view/season4/cfg_skill_view_80040284.lua            Ŕ 
@@
Ŕ@
@A
ŔA
@B
ŔB
@CK   Á@  A  A A  Á  K Â kB Ť@k@   Á      Ś  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ˙Ş       DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=80041902; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; PlayFixTrapWall; PlaySummonTrap,trapID=80040222; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach;                                                                                             key      config         _ENV