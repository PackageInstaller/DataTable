LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1601211/cfg_skill_view_300121.lua         <     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � �  AB  �� ��  �B� +A�K��� ��  A�  �B  �B � A� +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               � PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1601211,waitTime = 2000;� PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=3050; PlayCasterBindEffect,effectID=3051; PlayAudio,audioID = 2340,audioType=1; �      ; PlayEffectAtPickUpIndexGrid,effectID=3052,pickUpIndex=1;       ��       DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=13; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=3053,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=3055,turnToTarget=1,deathClear=0; Wait,waitTime=33; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; PlaySummonTrap,trapID=14,effectID=0;         <                                                                                                                                                                                          key	   <   config7   <      _ENV