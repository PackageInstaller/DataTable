LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1105/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1501601/cfg_skill_view_2001601.lua         *     
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
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               � PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID = 3721; PlayCasterBindEffect,effectID = 3722; PlayAudio,audioID = 2485,audioType=1; Wait,waitTime = 2000; 1,0�      ��       DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=3720,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=50; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;         *                                                                                                                                    key	   *   config%   *      _ENV