LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1140/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1501141/cfg_skill_view_300114.lua         F   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@��AA �A �� �  AB  �� �� C �B� +A�K��� �� � A�  �B  �� � A� +C� kA����A B A� ��  �B � K� � kC� �A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ~ PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1501141,waitTime = 2000;' PlayAudio,audioID = 2316,audioType=1;��       PlayTurnToPickUpDirection; PlayCasterAnimation,animName = AtkUlt; PlayCasterChangeMaterial,type=0,part=1,mat=eff_1501141_weaponMatAnim.mat,nodeName=1501141_weapon; PlayCasterChangeMaterial,type=0,part=1,mat=eff_1501141_weaponMatAnim.mat,nodeName=1501142_weapon; PlayCasterBindEffect,effectID=2611; PlayCasterBindEffect,effectID=2612; Wait,waitTime=200; PlayCameraEffect,effectID=2614; Wait,waitTime=5600; �      ��       PlayChessKnightTeleport; PlayRoleTeleport, type=9; Wait,waitTime=1200; PlayCasterBindEffect,effectID =2613; Wait,waitTime=200; DataSelectScopeGridRange,effectType=1,damageInfoIndex=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=playRangeEffect; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1800; PlayTeleportResultTarget,type=5; PlayCasterChangeMaterial,type=1,part=1,nodeName=1501141_weapon; PlayCasterChangeMaterial,type=1,part=1,nodeName=1501142_weapon;  PlayModifyTimeScale,type=0;         F                                                                                                                                                                                                      	   	   	   	   	      key   F   configA   F      _ENV