LuaS �

xV           (w@`@../PublishResources/config/shared/skill/skill_view/monster/2904101/cfg_skill_view_29041014.lua         0   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� B  AB  �� �� � �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �T       PlayAudio,audioID = 6248,audioType=1; Wait,waitTime=1000; PlayCasterAnimation,animName = Skill03; PlayCasterBindEffect,effectID=PARAM.Disappear; PlayCasterMaterialAnim,animName=eff_2904101_skill01_main_role; Wait,waitTime=400; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; PlayCasterHUDVisible,visible=0; Wait,waitTime=1000; PlayCasterTurnToPlayer; PlayCasterHUDVisible,visible=1; PlayRoleTeleport,type=6, onlySelf=1; PlayCasterMaterialAnim,animName=eff_2904101_skill01_main_role01; PlayCasterAnimation,animName=Skill032; PlayCasterBindEffect,effectID=PARAM.Appear;        ��       DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=15; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=290410113,delayTime=70,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; �      O ShowSummonThingBySortPos, sortType=15, eachDelayTime=80; Wait,waitTime=1000;         0                                                                                                                                                      key   0   config+   0      _ENV