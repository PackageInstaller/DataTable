LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/2001001/cfg_skill_view_1007001.lua         0   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� B  A�  �� �� � �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayCasterAnimation,animName = Skill01; PlayAudio,audioID = 7006,audioType=1; PlayCasterBindEffect,effectID=PARAM.effectID1; Wait,waitTime=500; PlayCasterHUDVisible,visible=0; Wait,waitTime=700; PlayRoleTeleport,type=5,onlySelf=0; �      ��       PlayRoleTeleport, type=6; PlayCasterHUDVisible,visible=1; PlayCasterAnimation,animName = Skill012; PlayCasterBindEffect,effectID=PARAM.effectID2; Wait,waitTime=550; DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=PARAM.effectID3,label=playRangeEffect; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=PARAM.effectID4,turnToTarget=1,deathClear=0; �        PlaySummonTrap,trapID=60;         0                                                                                                                                                      key   0   config+   0      _ENV