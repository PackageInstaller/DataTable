LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1600111/cfg_skill_view_300011.lua         u     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K �� ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � �  AB  � �� � �B� +A�K��� ��  A�  �B  �B C  K� �� kC� 
C�kA����A B A ��  �B  C K� � kC� �A���� A� � ��  C  AC �� �� �C� �A��AB �B � �  AC  �C �� � �C� +B�K��� ��  AC  �� � � AD +D� kB����� � A �C  ��  K� �� kD� �B�k@�� � �      �  & �     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir                PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1600111,waitTime = 2000;&PlayAudio,audioID = 2169,audioType=1;3PlayRoleTeleport, type=3; PlayRoleTeleport, type=5&       �       effectIDList�      1PlayEffectAtCasterPos, effectID=419,isGridPos=0;M      � PlayRoleTeleport, type=6; PlayRoleTeleport, type=9; PlayCasterAnimation,animName = AtkUlt; PlayEffectAtCasterPos, effectID=420; Wait,waitTime=5500;  PlayCameraEffect, effectID=421;�      ��      DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=422,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=100; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;	       �DataSelectRefreshBuff,Index=1; PlayTargetRefreshBuffView,buffEffectType=3029,label=doAgain; DataSelectRefreshNextBuff; Jump,condition=CheckBuffRefreshValid,goto=doAgain;        u                                                                                                                                                                                                                                                	   	   	   	   	   	   	   	   	   	   	   
   
   
   
   
   
   
   
   
   
   
                                                      key	   u   configp   u      _ENV