LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/core_game/view/svc/phase/play_skill_sphere_trajectory_multi_stage_damage_phase_r.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@���@ l�  
@ �& � 	   requireplay_skill_phase_base_r_class/PlaySkillSphereTrajectoryMultiStageDamagePhasePlaySkillPhaseBasePlayFlight_TransformTrajectory_TrajectoryFinish_SortDistanceForFinalAttack           �    5a   �L@d� �A@�� ́@� �@$� LBAd� 
@�L�Ad� 
@�LBBd� 
@�L�Bd� 
@�LBCd� 
@�L�Cd� 
@�LBDd� 
@�L�Dd� ��D�� �  E$� CEL�Ed� L��d� ���� �C�F�F G��䃀 �  �& �   
 ���G @�$ �K  � 
��G� H FH��$��L�H�� d���I�� "  @�J���J�H��  Jņ�JEJ�ƆJ ���GG @�
�F�)�  ���J KGDG $� @K  �& �  �L��d� ����� ƄJ ��	  	� L AE �E $��A� ��	�� hE �G	E
g�FL �EL
��ǅL
�ńd���H ��L ����EM@�
䅀�J K@�$� F�M G��� � d����J �K�FG �� �����   A� ���ƇM ��� @ 䇀HG �GHG GȇG��M��
H����F�� �  @�G AG �� ƇJ ��HG � � ���HG �HǈI ��� �IIL�H�� d������� @ �G���� ��G�H �L� $��A� ��J �K�GG �� �� h��GHG G�����H����� $��LIO�	  
 @
��
 d� JH	�J���g��K  �  �H ���A 䇀� @��� (H��M 	NAI �I $��F�M G����P�	Qd� OɁ��M �IQ��P�	��� ��ƉM �	�䉀 ω����
R @
��
��
 $� N��J������̊�@�� � �J �J@���$K�� F�J G��KG d� �� (K�LG �F�J G���Id� ��I �� �F�J G����I���� dL  LLM�LI��� d�  ��J ��J�  ��L�  �'�'��J K@�$� �S$� "H  � �HS @� $H � F�J G���d� �� (�Ɉ�S$� �S$� 	TF	R ��M �	N��� ƉM �	�䉀 �	��M 
N$
� d�  �IT�I	���Ɉ̉�@
 �I�'H�HS @� � $H��T �� �� 	 @	 $H & � T   	GetEftIDGetTrajectoryCountGetSphereRadiusGetStartWait_moveSpeedGetMoveSpeed_rotateSpeedGetRotateSpeed_turnToTargetGetTurnToTarget_hitAnimNameGetHitAnimName_hitEffectIDGetHitEffectID_intervalTimeGetIntervalTime_hitSoundIDGetHitSoundID
GetRandomGetRandomPercentGridLocation	PositionSkillRoutineGetResultContainerGetSkillIDGetEffectResultsAsArraySkillEffectTypeDamage _formatListipairsGetTargetID_worldGetEntityByIDGetDamageInfo       GetGridPosdamageResultattackCounteffectEntityIDListplayDamage tableinsertcount        GetScopeResultGetAttackRangeVector2xyGetServiceBoardRenderGridPos2RenderPosmathmaxrandomIsFinalAttackGetTargetEntityIDSetFinalAttackEntityID	UtilCalcDamageInfoSplitMultiStagedamageInfoListdamageStageValueListEffecth      cos��Q�	@�       sin             �?Vector3normalizedCreatePositionEffectGetIDHasViewYIELDViewGetGameObject
transform	positionSetDirection_TransformTrajectory         a  	   
   
                                                                                                                                              #   #   $   1   1   :   :   :   :   ;   =   >   >   ?   ?   ?   ?   A   A   A   B   B   E   E   F   G   H   H   I   K   K   K   K   K   :   :   P   P   P   P   P   P   Q   U   W   W   X   X   Y   Y   Y   Y   Z   Z   Z   Z   [   [   [   [   \   \   [   ^   ^   ^   ^   ^   ^   `   `   `   `   a   a   a   c   c   c   c   e   e   e   e   e   i   i   i   i   i   l   l   l   l   m   m   m   m   m   n   n   n   n   n   n   n   l   r   r   s   s   u   v   w   w   w   w   w   w   w   x   x   y   z   z   {   |   }   }   }   ~   ~   ~   w   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   a   self    a  TT    a  casterEntity    a  phaseParam    a  effectParam   a  eftID   a  trajectoryCount   a  sphereRadius   a  
startWait	   a  random    a  randomPercent"   a  	listTask#   a  castPos&   a  skillEffectResultContainer*   a  skillID,   a  damageResultArray0   a  (for generator)8   T   (for state)8   T   (for control)8   T   _9   R   v9   R   format:   R   damageResult;   R   targetEntityID=   R   targetEntityA   R   damageInfoD   R   
damagePosF   R   skillResult\   a  scopeResult^   a  skillRange`   a  rangeCountd   a  scopeTotalh   a  (for index)k   o   (for limit)k   o   (for step)k   o   il   n   scopeCenterPosu   a  boardServiceRendery   a  sphereCenterPos|   a  damageResultArrayCount�   a  needAttackCount�   a  needSupplementAttackCount�   a  (for index)�   �   (for limit)�   �   (for step)�   �   i�   �   random�   �   isFinalAttack�   a  attackCountLargest�   �   targetEntityIDLargest�   �   (for index)�   �   (for limit)�   �   (for step)�   �   i�   �   format�   �   attackCount�   �   damageResult�   �   damageInfo�   �   utilCalcSvc�   a  (for index)�   �   (for limit)�   �   (for step)�   �   i�   �   format�   �   attackCount�   �   damageResult�   �   damageInfo�   �   damageInfoList�   �   damageStageValueList�   �   eftEntityList�   a  eftTargetPosList�   a  effectService�   a  (for index)�   )  (for limit)�   )  (for step)�   )  i�   (  
randomDir�   (  tmpX�   (  tmpZ�   (  tmpY�   (  
randomPos�   (  dir�   (  workPos�   (  
eftEntity  (  (for index)  (  (for limit)  (  (for step)  (  i  '  format  '  renderGridPos!  '  (for index);  V  (for limit);  V  (for step);  V  i<  U  eftTansformB  U  offsetN  U  dirQ  U     _ENV �   ?   �   G@ RA���  ���@ B@K  �  ��  A CA@ $� A�  �B�ǃ��$� �A$� BGDB�A ��B	�� ��D������B��	�C	�DC Ǆ�	EB@ 	䄀A �B
@ ��	$E����  � FA GC�� d�  @���#�A�  �A �CA� �� ��  hC�G����L��d� L��
d� G�
���
��	�C�E�
_����EC ǅ�F�
@ 䅀�FFC G�� 
�   d� JE��  �MA��E���
FFC �F�
��D���F�
����ƅG�
E�d� FJ��g�A�  �A �CA� �� ��  h��G����� ��A	�� �B	�DB	J�g���@FCE �� dC FA GC�� d� ��  �� h��G����� ��A	�� �B	��EC �E
G�B	��	$��` F
� �G�B	G��
 ��
@
�FEF G��
��F dE FA G�
� � dE�FA G�
��� dE�FA G�
� � dE�FA G�
��� dE�LEG ��  d� b  �� @��@��A ǅ� �@�
�E��A ǅ� �@ �E�g����F�G L��d� L���d��bC  � �FCE �� dC ��& � !   _moveSpeed              _rotateSpeedtablecountViewGetGameObject
transformforwardinsert	positionnormalizedVector3Angle        Lerp       xyzYIELD��������	Distanceffffff�?AudioHelperControllerPlayInnerGameSfx_hitSoundIDremove_TrajectoryFinishTaskHelperGetInstanceIsAllTaskFinished         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                 
                                �                                     !  !  !  $  $  $  $  $  $  $  %  &  &  &  &  &  '  (  (  (  (  (  *  *  *  *  *  *  +  +  +  +  ,  ,  ,  ,  ,  -  -  -  -  -  .  .  .  .  .  /  /  /  /  /  1  1  1  1  2  2  2  2  3  3  3  3  3  4  4  4  4  4  $  7  <  <  <  <  <  <  <  <  =  =  =  =  ?  3   self    �   TT    �   eftEntityList    �   eftTargetPosList    �   casterEntity    �   
moveSpeed   �   moveSpeedMin   �   moveSpeedMax   �   rotateSpeed   �   lastFrameNormalizedList   �   finalAngleList   �   (for index)   *   (for limit)   *   (for step)   *   i   )   
eftEntity   )   eftTansform   )   lastFrameNormalized   )   finalForwardBefore   )   finalAngle$   )   	listTask+   �   
farmCount,   �   (for index)8   h   (for limit)8   h   (for step)8   h   i9   g   
eftEntity:   g   endPos;   g   finalAngle<   g   lastFrameNormalized=   g   eftTansformB   g   finalForwardE   g   angleOffsetM   V   tO   V   changeSpeedY   g   (for index)n   x   (for limit)n   x   (for step)n   x   io   w   
eftEntityp   w   eftTansformu   w   (for index)�   �   (for limit)�   �   (for step)�   �   i�   �   
eftEntity�   �   eftTansform�   �   endPos�   �   currentDist�   �   nTask�   �   nTaskDamage�   �      _ENV A  �   c   �     FA@ G����@ d� �  (���@ �GAbB  @�FB@ GB���A��� � d�  b  @ ��  
B�'��AB �B�� $A��@    �& � ��LC�  d���A�ǁ�  \ �  (���C�D �CD$C�'B��D$� �D$� LEd� �BE�� ̂E� CB �E��$��LFd� �CB �CF� ����CB �C�A� 䃀G DG$�� �G��G�   @ �H �EH   @ ��H �� �@���H $��FG GD�d�� L���  d��� ����& � $          tablecount_formatListplayDamageintableeffectEntityIDListGetID_worldDestroyEntitydamageResultGetDamageInfodamageInfoListdamageStageValueListSetShowTypeDamageShowTypeGridSkillRoutineGetResultContainerGetSkillIDGetGridPosGetTargetIDGetEntityByIDIsFinalAttackGetService
PlaySkillPlayDamageGameGlobalTaskManagerCoreGameStartTaskHandleBeHitMultiStage_hitAnimName_hitEffectID_turnToTarget_intervalTime         ~  �      F @ G@� � � d� N�� ��@ �   AA �@�� ��@A   E ���@�� ���A   E ����A�� ���@ & �    tablecount       YIELD_intervalTimeUpdateTargetHPBar_OnHpChangeNotifyBuffGetChangeHP                       �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     TT       intervalCount         _ENVdamageStageValueListselfplayDamageSvctargetEntitydamageInfoc   B  D  D  D  D  D  D  D  E  E  G  G  G  G  G  G  G  G  G  G  G  H  I  D  M  M  M  M  O  O  P  S  T  T  T  U  V  X  X  X  X  Y  Y  Y  Y  Y  X  ]  ]  ]  ]  ^  ^  _  _  a  a  b  b  b  b  c  c  f  f  f  f  h  h  h  h  l  l  l  l  m  n  o  p  q  r  s  t  u  v  w  x  z  l  }  }  }  }  �  }  �  �  �  �     self    c   
eftEntity    c   casterEntity    c   
curFormat   c   (for index)      (for limit)      (for step)      i      format
      damageResult    c   damageInfo#   c   damageInfoList$   c   damageStageValueList%   c   (for index)(   /   (for limit)(   /   (for step)(   /   i)   .   skillEffectResultContainer3   c   skillID5   c   damageGridPos7   c   	targetId9   c   targetEntity=   c   isFinalAttack?   c   playSkillServiceC   c   playDamageSvcG   c   nTaskY   c   nTaskDamage_   c      _ENV �  �      �   @ A@@ ��$A��@ @ $��@ ����� �A �B�@ 䂀��$� "    �� )�  �A�& �    tablesortipairsGetTargetID_worldGetEntityByIDHasDeadFlag         �  �   (   � @ �@@ƀ� �@ $� �@� ��� � @ �@�� L�@ d� G�A� �� � @ �@��� L�� d� G��A� @ A@F� ��� �� �AN��$� � �`��  �A  � & & �    mathabsxGetGridPosy         (   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     res1    (   res2    (   dis1   (   dis2"   (      _ENVcastPos   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       castPos       damageResultArray       CmpDistancefunc      (for generator)	      (for state)	      (for control)	      _
      v
      result      targetEntityID      targetEntity         _ENV                                 �      �   ?  �   A  �  A  �  �  �  �         _ENV