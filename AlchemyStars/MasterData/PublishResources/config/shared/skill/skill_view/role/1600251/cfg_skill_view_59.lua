LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1600251/cfg_skill_view_59.lua         *     
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
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               t PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID=137; PlayAudio,audioID = 2024,audioType=1; 1,0M      ��       DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=138,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=100; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=2500;         *                                                                                                                                    key	   *   config%   *      _ENV