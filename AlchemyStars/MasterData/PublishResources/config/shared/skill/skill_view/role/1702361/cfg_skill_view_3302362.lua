LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1702361/cfg_skill_view_3302362.lua         F   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@��AA �A �� �  AB  �B �� � �B� +A�K��� �� � A�  �B  �� � A +C� kA����A B A� ��  �B  � K� �C kC� �A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1400161,waitTime = 2000;�f       DataSelectResult,effectType=79,index=1; PlayDestroyTrap; PlayCasterInTrapPos,trapID=17023611; PlayAudio,audioID = 170236104,audioType=1; PlayCasterAnimation,animName = AtkUlt3; PlayCasterMaterialAnim,animName=eff_1702361_atkult2_main; PlayCasterBindEffect,effectID =17023621; Wait,waitTime=500; PlayCasterBindEffect,effectID =17023619; Wait,waitTime=2500; R      5PlayFromSPTrapMoveToCaster,trapID=17023611,time=100;�      ��       DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=9; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=17023620,randomRotateXYZ=180,offsetHigh=0.1,label=playRangeEffect; Wait,waitTime=60; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; ��       DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=9; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=playRangeEffect; Wait,waitTime=60; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;         F                                                                                                                                                                                                      	   	   	   	   	      key   F   configA   F      _ENV