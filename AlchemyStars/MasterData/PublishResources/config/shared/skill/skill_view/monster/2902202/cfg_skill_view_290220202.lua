LuaS 

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2902202/cfg_skill_view_290220202.lua         Q   ภ 
@@
ภ@
@A
ภA
@B
ภB
@CK   ม@  A  A A  ม  K ย kB ซ@ห ม  Aม   มA   A  ม ซB ๋@AA A ม B  A  ห C ๋B +AKม มม  AB   ม  A +C kAมA B A B  ม  K ร kC ซAหย Aย  มB   A  ม ซC ๋Ak@   ม      ฆ  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam                PlayAudio,audioID=6181,audioType=1; PlayCasterTeleportByAnim,leftAnim=Skill02_2,rightAnim=Skill02_1,leftAnimLen=1667,rightAnimLen=1733; Wait,waitTime=500; d DataSelectResult,effectType=8,index=1; Wait,waitTime=800; PlayEffectTeleportNewPos,effectID=3528; ๋ Wait,waitTime=1000; DataSelectDamage,damageIndex=1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; ๋ Wait,waitTime=1000; DataSelectDamage,damageIndex=1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; & Wait,waitTime=1000; PlayAllHitBack; ฝ Wait,waitTime=800; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach;         Q                                                                                                                                                                                                                                    	   
   
   
   
   
      key   Q   configL   Q      _ENV