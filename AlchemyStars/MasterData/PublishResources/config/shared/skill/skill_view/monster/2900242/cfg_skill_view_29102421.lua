LuaS �

xV           (w@`@../PublishResources/config/shared/skill/skill_view/monster/2900242/cfg_skill_view_29102421.lua         6     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K �� ��@  A  A �A  �  K� �B kB� �@�� ��  A�  �� �A  B  A �B  ˂  �  
CB�
C�����E����@��AA �A � B  AB  � �� C �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               �I       PlayCasterAnimation,animName = Skill01; PlayCasterBindEffect,effectID=2759; PlayAudio,audioID = 6094,audioType=1; Wait,waitTime=1220; DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=playRangeEffect; DataSelectNextScopeGridRange; Wait,waitTime=50; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1000; <       gridPosxy	effectID�
      x      � DataSelectSummonThing,index=1; ShowSummonThing,label=foreach; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=foreach;         6                                                                                                                                                                        key	   6   config1   6      _ENV