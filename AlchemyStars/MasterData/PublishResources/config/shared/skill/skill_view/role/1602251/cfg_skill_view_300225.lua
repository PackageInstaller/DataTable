LuaS �

xV           (w@[@../PublishResources/config/shared/skill/skill_view/role/1602251/cfg_skill_view_300225.lua         0   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@��AA �A �� �  AB  �B �� � �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam                PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1501351,waitTime = 2000;� PlayTurnToPickUpPosDirection,pickUpIndex=1,waitTime=0; PlayAudio,audioID = 160225103,audioType=1; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID = 160225106; PlayCasterBindEffect,effectID = 160225107; Wait,waitTime=4000; @      ��       PlayAddMonsterWeak; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=playRangeEffect1; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect1; PlayAddMonsterWeak,hitEffectID=160225110;         0                                                                                                                                                      key   0   config+   0      _ENV