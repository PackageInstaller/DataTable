LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1500761/cfg_skill_view_200762.lua         2     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K �� ��@  A  A�  �A  �  K�  J�ĈJŉJ�Ŋ�@�� ��  A�  � �A  B  A �� �� �B� �@��AA �A � B  AB  � �� C �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               effectparam
1365,1367castAnimationName	AtkChainfinishDelayTime<      &PlayAudio,audioID = 3011,audioType=1;(
      ��       DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=1366,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=100; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;         2                                                                                                                                                            key	   2   config-   2      _ENV