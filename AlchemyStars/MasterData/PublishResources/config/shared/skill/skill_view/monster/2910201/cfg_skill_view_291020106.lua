LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2910201/cfg_skill_view_291020106.lua         &     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               , PlayAudio,audioID = 29102011,audioType=1; �      DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=4,sortParam=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=291020107,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1; Wait,waitTime=40; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=500;         &                                                                                                                        key	   &   config!   &      _ENV