LuaS 

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2003001/cfg_skill_view_200300101.lua         ;   ΐ 
@@
ΐ@
@A
ΐA
@B
ΐB
@CK   Α@  A  A A  Α  K Β kB «@Λ Α  AΑ   ΑA  B  A  ΑB «B λ@AA A Α B  AB   Λ  λB +AKΑ ΑΑ  AB  B  ΑΒ  A +C kAk@   Α      ¦  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam                PlayAudio,audioID=7047,audioType=1; PlayCasterAnimation,animName = Skill01; Wait,waitTime=500; PlayCasterBindEffect,effectID=200300101; &      φ DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200300102,turnToTarget=0,deathClear=false,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=500;  DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=20011,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; 0      #PlaySummonTrap,trapID=2003001011;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV