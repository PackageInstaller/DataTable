LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1401021/cfg_skill_view_300102.lua         H   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@��AA �A �A �  AB  �� �B  � A +C� ���+A�K��� �� � A�  �B  �� � AC +C� kA����A B A� ��  �B  � K� �� kC� �A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ~ PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1401021,waitTime = 2000;L PlayCasterBindEffect,effectID=2342; PlayAudio,audioID = 2237,audioType=1; &       �      effectIDList&	      � PlayTurnToPickUpDirection; PlayCasterAnimation,animName=AtkUlt; PlayCasterBindEffect,effectID=2343; PlayCasterBindEffect,effectID=2344; Wait,waitTime=300; PlayCasterBindEffect,effectID=2345; �	      ��       PlayMultiTraction; Wait,waitTime=500; DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1500;         H                                                                                                                                                                                                            	   	   	   	   	      key   H   configC   H      _ENV