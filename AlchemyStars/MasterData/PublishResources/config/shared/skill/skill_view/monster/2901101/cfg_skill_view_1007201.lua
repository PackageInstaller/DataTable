LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/b/140/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/2901101/cfg_skill_view_1007201.lua         0   Ŕ 
@@
Ŕ@
@A
ŔA
@B
ŔB
@CK  Á@  A  A A  Á  K Â kB Ť@Ë Á  AÁ   ÁA   A  Á ŤB ë@AA A Á B  A  Ë C ëB +Ak@  Á      Ś  &     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ř DataSelectResult,effectType=120,index=1; Jump,condition=CheckEffectResultIndex,param=120,result=0,goto=phaseEnd; PlayDestroyMonster,label=foreach; DataSelectNextResult,effectType=120; Jump,condition=CheckEffectResultIndex,param=120,goto=foreach; ˙w       PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; PlayCasterAnimation,animName = Skill01; Wait,waitTime=700; PlayAudio,audioID = 7004,audioType=1; PlayCasterBindEffect,effectID=1075; Wait,waitTime=100; DataSelectSummonThing,index=1; ShowSummonThing,label=foreach; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=foreach; Wait,waitTime=1000; ˙w       Wait,waitTime=800; DataSelectScopeGridRange,effectType=34; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=1076,label=doAgain; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=doAgain; Wait,waitTime=800;         0                                                                                                                                                      key   0   config+   0      _ENV