LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2905501/cfg_skill_view_290550121.lua         0   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@��AA �A �� �  AB  �B �� � �B� +A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ��       PlayCasterTurnToPlayer; PlayCasterAnimation,animName=AtkChain; PlayAudio,audioID=2615,audioType=1; PlayCasterTurnToPlayer; PlayCasterBindEffect,effectID=160191103; PlayCasterMaterialAnim,animName=eff_1601911_atkchain_chuxian; Wait,waitTime=410; PlayRoleTeleport, type=5; PlayCasterBindEffect,effectID=160191104; PlayCasterTurnToPlayer; Wait,waitTime=50; PlayRoleTeleport, type=6; PlayRoleTeleport, type=9; Wait,waitTime=430; PlayAudio,audioID=2616,audioType=1; Wait,waitTime=300; � DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=600; d       �G       DataSelectDamage,damageIndex=1,damageStageIndex = 2; DataSelectScopeGridRange,effectType=1,damageInfoIndex=2; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160191105,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=1,damageStageIndex = 2; Wait,waitTime=150; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;         0                                                                                                                                                      key   0   config+   0      _ENV