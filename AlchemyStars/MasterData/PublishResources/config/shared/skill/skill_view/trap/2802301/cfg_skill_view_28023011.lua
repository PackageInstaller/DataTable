LuaS �

xV           (w@]@../PublishResources/config/shared/skill/skill_view/trap/2802301/cfg_skill_view_28023011.lua         @   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  � �A  B  A� �B  ˂  �  
CB�
C����BE����@��AA �A �� B  A�  �� �� � �B� +A�K��� �� � AB  ��  �� � A +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam                PlayDeleteWaringArea; <       gridPosxy	effectID���    d       � PlayDeleteWaringArea; PlayMonster2802301CentralEffect,effectID=280230104,posY=5,offset=0|0; Wait,waitTime=1850; PlayAudio,audioID = 8022,audioType=1; ��       DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=17; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=0,label=playRangeEffect1; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,deathClear=0; Wait,waitTime=100; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect1;         @                                                                                                                                                                                                      key   @   config;   @      _ENV