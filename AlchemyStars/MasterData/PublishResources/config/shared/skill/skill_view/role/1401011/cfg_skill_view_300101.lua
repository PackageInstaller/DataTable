LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1401011/cfg_skill_view_300101.lua         5     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K �� ��@  A  A �A  �  K� �B kB� �@��  �  A�  � ��  B  A �� �� �B� � � A �B �@ �AA �A � B  A�  �B �� � �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               � PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1401011,waitTime = 2000;g PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=2283; PlayAudio,audioID = 2234; 1,0�      �c       PlaySkillAttackRange,showTime=200; DataSelectScopeGridRange,effectType=58; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; DataSelectDamage,damageIndex = 1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=58,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1; PlayGridRangeEffect,effectID=2284; DataSelectNextScopeGridRange,label=selectNextGridRange; Wait,waitTime=100; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=500;         5                                                                                                                                                                     key	   5   config0   5      _ENV