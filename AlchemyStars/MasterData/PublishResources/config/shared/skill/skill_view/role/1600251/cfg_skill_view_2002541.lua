LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1130/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1600251/cfg_skill_view_2002541.lua         *     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  �  �@  A  A �A  �  K� �B kB� � �� � �B �@ � ��  A�  � �A  B  A �� �B �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               y PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID=16002545; PlayAudio,audioID = 2550,audioType=1; 1,0@      ��       DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=0,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=2500;         *                                                                                                                                    key	   *   config%   *      _ENV