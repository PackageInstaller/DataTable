LuaS �

xV           (w@_@../PublishResources/lua/product/core_game/view/svc/phase/play_skill_scope_forward_phase_r.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@���@ l�  
@ ��@ l  
@��& � 
   requireplay_skill_phase_base_r_classPlaySkillScopeForwardPhasePlaySkillPhaseBasePlayFlight_ShowDamage_GetDirection_SortDistanceForFinalAttack_CalcDistanceToCaster           �    6   �L@d� �A@�� ́@� �@$� LAd� �BA�� ̂A� �A$� LBd� GC���B�� �  �  � ��B$� � C��$��LDCd� L��d� ����� ��� E�	$� D  �  b  @�̅�F�D G�䅀F�$� @ ��$� � ��E ��@ 
����F��� �  ��̆�F�D G��䆀G ����$� LG�� dG�ǆG ���A 䆀  K  �  �G  �AH �G��H � AI ��ǉ� 
 "  � �G��\
��JH��  
� �G��\
�!@
 �G��G
�b  ���JI ��I�
  �����
   
���I �
J�J�@�䊀�$� L�Jd� �
�F�J L���  @�
d���KI �KK�  ��K���K ��K��� �LLL $� �LLLL d� ����  @�
�� �KI �K� �@ �K�@�����
M @ 䊀��
ǊG ���AK 䊀̊�@������M � $�����J�"   �����D �F@��� �
  @��
N @ ���  �@ ���LN�   	� �
   �KI KK@ ��$K����_@� �ƈN  	� @	��H�����N� �N @� ��$H��G �G� $��G�G L���H d����O ��O�� �P 	�����H  � ���N �� �H ����O ��O�� �P 	 ����H  � ���N �� �H ���HP �K 	 @	 �� ̈PF�D G	��H����@	� �	 �H & � D   GetGridEffectIDGetBestEffectTimeGetGridIntervalTime
HasDamageHasConvertGetHitAnimationNameGetHitEffectIDGetEffectDirectionGridLocation	PositionRenderPickUpComponentGetAllValidPickUpGridPosCountIsBackwardSkillRoutineGetResultContainerGetSkillIDGetScopeResultGetAttackRangeGetEffectResultByArraySkillEffectTypeConvertGridElementGetTargetElementTypeGetTargetGridArrayInnerGameSortGridHelperRender	SortGridIsFinalAttackGetEffectResultsAsArrayDamage_SortDistanceForFinalAttackSetFinalAttackEntityID_worldGetServicePiece              	gridList        table
icontains
PieceTypeNoneFindPieceEntityGetPieceTypeNTGridConvert_ConvertInfoNewinsertGameGlobalTaskManagerCoreGameStartTaskSkillService_SingleGridEffect
direction_GetDirectionEffect#CreateWorldPositionDirectionEffectGetEffectResultByPos_ShowDamageHitTurnToTargetYIELDGetFinishDelayTime
PlaySkill	PlayBuffTaskHelperGetInstanceIsAllTaskFinishedNTGridConvertSetConvertEffectTypePlayBuffView              	   	   
   
                                                                                                 !   !   #   #   $   $   %   &   '   '   )   )   )   )   *   *   *   +   +   +   .   .   .   .   .   0   0   1   1   2   2   2   2   3   3   3   3   4   4   4   8   8   8   8   :   ;   <   >   >   >   >   ?   ?   ?   ?   @   A   B   B   C   C   C   C   E   E   E   E   E   E   F   F   H   H   H   H   H   H   H   H   H   I   I   J   J   J   L   L   M   M   M   O   O   O   O   O   O   P   P   P   P   P   R   R   R   R   S   S   S   T   T   U   V   W   Y   R   Z   Z   Z   Z   Z   Z   ]   ]   ]   ]   ]   ^   ^   ^   ^   ^   _   `   a   a   a   a   a   ^   d   d   f   f   f   f   f   g   g   i   j   k   l   m   n   o   p   p   r   i   s   s   t   t   t   t   t   ?   z   z   {   {   {   {   >   ~   ~               �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   9   self      TT      casterEntity      phaseParam      scopeForwardParam     gridEffectID     bestEffectTime     gridIntervalTime     
hasDamage	     hasConvert     hitAnimationName     hitEffectID     effectDirection     castPos     renderPickUpComponent     pickNum     
bBackward     skillEffectResultContainer#     skillID%     scopeResult'     gridDataArray)     targetGridType*     convertGridList+     convertResult1   7   targetGirdList<     _<     maxGridCount<     isFinalAttack>     damageResultArrayD   K   targetEntityIDH   K   pieceServiceO     tConvertInfoP     tnConvertTaskIDQ     tidHitTaskR     (for index)U   �   (for limit)U   �   (for step)U   �   iV   �   (for index)Y   �   (for limit)Y   �   (for step)Y   �   dirZ   �   t[   �   
gridIndex\   �   gridPosj   �   oldGridTypeu   �   gridEntityx   �   
pieceCmptz   �   convertInfo�   �   tid�   �   gridDir�   �   damageResult�   �   tid�   �   finishDelayTime�     playSkillService�     svcPlayBuff�     nt�        _ENV �   �   	 ?   L� d� �B@ ��@ ����_�@@��� AC 䂀�A �AA ����$C CB �B$� �B��$��C� $��CC��$���C� $���C��$��D� $��CD��$���D�  $���D�E� $�  CE� $��F�E G��d�� L��CF � ǃ�DF $� @ dC�& �    GetTargetID_worldGetEntityByID GetDamageInfo       Logdebug/[skill] PlaySkillService:_HandlePlayFlyAttack HandleBeHitParamNew!SetHandleBeHitParam_CasterEntity!SetHandleBeHitParam_TargetEntity SetHandleBeHitParam_HitAnimName SetHandleBeHitParam_HitEffectIDSetHandleBeHitParam_DamageInfoSetHandleBeHitParam_DamagePos"SetHandleBeHitParam_HitTurnTargetSetHandleBeHitParam_DeathClearSetHandleBeHitParam_IsFinalHitIsFinalAttackSetHandleBeHitParam_SkillIDGameGlobalTaskManagerCoreGameStartTaskSkillServiceHandleBeHit         ?   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    ?   damageResult    ?   skillEffectResultContainer    ?   hitAnimName    ?   hitEffectID    ?   casterEntity    ?   gridPos    ?   hitTurnToTarget    ?   skillID    ?   targetEntityID   ?   targetEntity   ?   targetDamage   >   beHitParam3   >      _ENV �   �    &    � @��@@ ��  �  � ��    � � @��@@ ��  �  � ��    �@� @��@@ �� �  � ��    ��� @��@@ ��  �  � ��    ��@@ ��  �  � ��   & �    BottomVector2        ��������UpLeft       Right         &   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    &   effectDirection    &      _ENV �   �       �   @ A@@ ��$A��@ @ $��@ ����� �A �B�@ 䂀��$� "    �� )�  �A�& �    tablesortipairsGetTargetID_worldGetEntityByIDHasDeadFlag         �   �       �   � @� @  �� �   � �E� �� � `��  �A  � & & �    _CalcDistanceToCaster           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      skillDamageEffectResult1       skillDamageEffectResult2       dis1      dis2
         selfcastPos   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       castPos       damageResultArray       CmpDistancefunc      (for generator)	      (for state)	      (for control)	      _
      v
      result      targetEntityID      targetEntity         _ENV �   �    	   � @� A@ �@@��� %�&  & �    GetGridPosVector2	Distance         	   �   �   �   �   �   �   �   �   �      self    	   castPos    	   skillDamageResult    	   gridPos   	      _ENV                                 �      �   �   �   �   �   �   �   �   �   �   �   �   �          _ENV