LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/cfg_skill_view_2801001.lua         ;   À 
@@
À@
@A
ÀA
@B
ÀB
@CK   Á@  A  A A  Á  K Â kB «@Ë Á  AÁ   ÁA   A  Á «B ë@AA A Á B  A  Ë C ëB +AKÁ ÁÁ  AB   Á  A +C kAk@   Á      ¦  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ÿ       Jump,condition=CheckTrapSummonMonsterByResult,result=1,param=1,goto=phaseEnd; Jump,condition=CheckTrapOpenStateChangeByResult,result=0,param=1,goto=phaseEnd; PlayDeleteCasterEffect,effectIDList=3849|3850; PlayCasterLegacyAnimation,animNames=eff_2801001_jiguan_transform_02; ÿ       Jump,condition=CheckTrapSummonMonsterByResult,result=1,param=1,goto=phaseEnd; Jump,condition=CheckTrapOpenStateChangeByResult,result=0,param=0,goto=phaseEnd; PlayDeleteCasterEffect,effectIDList=3849|3850; PlayCasterLegacyAnimation,animNames=eff_2801001_jiguan_transform_01; ÿ       Jump,condition=CheckTrapSummonMonsterByResult,param=0,result=1,goto=phaseEnd; PlayTrapSummonMonster,effectID=3848,materialAnimName=eff_2801001_zhaohuan_skin; PlayAudio,audioID =6217,audioType=1; Jump,condition=CheckTrapOpenStateChange,result=0,param=0,goto=phaseEnd; PlayDeleteCasterEffect,effectIDList=3849|3850; PlayCasterLegacyAnimation,animNames=eff_2801001_jiguan_transform_01; ÿ        Jump,condition=CheckCasterIsDead,result=0,goto=phaseEnd; Wait,waitTime=100; Jump,condition=CheckTrapOpenStateChange,result=0,param=1,goto=phaseEnd; PlayDeleteCasterEffect,effectIDList=3849|3850|3851; PlayCasterBindEffect,effectID=3852; DataSelectResult,effectType=79,index=1; PlayDestroyTrap; Jump,condition=CheckTrapOpenStateChange,result=0,param=0,goto=phaseEnd; PlayDeleteCasterEffect,effectIDList=3849|3850|3851; PlayCasterBindEffect,effectID=3853; DataSelectResult,effectType=79,index=1; PlayDestroyTrap;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV