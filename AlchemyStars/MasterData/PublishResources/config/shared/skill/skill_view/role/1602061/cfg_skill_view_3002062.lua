LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1602061/cfg_skill_view_3002062.lua         G     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K �� ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � B  A�  �� ��  �B� +A�K��� ��  AB  ��  �� � AC +C� kA����A B A �B  ��  � K� �� kC� �A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               ~PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1600061,waitTime = 2000;� PlayTurnToPickUpDirection; PlayCasterAnimation,animName=AtkUlt2; PlayAudio,audioID = 2670,audioType=1; PlayCasterBindEffect,effectID=160206112; PlayEffectAtPickUpIndexGrid,effectID=160206113,pickUpIndex=1; Wait,waitTime=2500; �      � DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;  PlaySummonTrap,trapID=60; �`      DataSelectScopeGridRange,effectType=4; DataSortScopeGridRange,sortType=18; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;         G                                                                                                                                                                                                         	   	   	   	   	      key	   G   configB   G      _ENV