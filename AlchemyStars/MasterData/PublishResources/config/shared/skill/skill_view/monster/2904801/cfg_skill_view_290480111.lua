LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2904801/cfg_skill_view_290480111.lua         0   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A� �� � �B� �@��AA �A �� �  A�  �B �� � �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               &PlayAudio,audioID = 5096,audioType=1;�r       PlayCasterBindEffect,effectID=582; PlayCasterAnimation,animName=Skill02_down; Wait,waitTime=1830; PlaySummonTrap,trapID=400; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; PlayEffectAtCasterPos,effectID=583; Wait,waitTime=1000; PlayRoleTeleport,type=6, onlySelf=1; PlayCasterAnimation,animName=Skill02_up; PlayCasterBindEffect,effectID=578; d       ��       DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=0,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=0; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;         0                                                                                                                                                      key   0   config+   0      _ENV