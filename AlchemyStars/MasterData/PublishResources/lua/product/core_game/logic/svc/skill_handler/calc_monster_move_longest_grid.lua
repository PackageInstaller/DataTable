LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1905/client/Assets/../PublishResources/lua/product/core_game/logic/svc/skill_handler/calc_monster_move_longest_grid.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��& �    _class'SkillEffectCalc_MonsterMoveLongestGridObjectConstructorDoSkillEffectCalculator_OnArrivePos_OnFinished_Attack        	       	   
@ �� @ ��@�  ���
����   
� �& �    _world_skillEffectServiceGetServiceSkillEffectCalc_arriveTrapIDs        	                                 self    	   world    	           q    $�   � @ �@@�� $ ��  ��� �   FA GA���d� !@�  ���"  @ ��A@�FB GA��� ��� � dA  G@ L��A d���@ �C� ������ � 
 �@ B@� $��K  �BD�� �B   	������ ��D ��� ��B�@ 䂀@�@���D ǂ�������� �$� LC��   @�d��@�����D ǂ�������� �� ��$� @ �  �    K  �@ �CD �����_�� ��  �G @�$��LHd� �EH ��H�� ��H@ ��
� 
�E��I@ 
�E��EINF
�E�̅I� A �I@�� $F�J� 
$F�FJ��J ��H  ��$F  �J � �  �@ $F FJ�K ��H  ��$F  A �I@�� 
$F�FD$� "  @ ��� ��F�$� "   ��K��$��G@ L��d� ���� �FL@ �F���G  ��� ��L����LdH��  jG�)�  �D�DJ�M ��H	  \�� $D  DM � �� �@�� $Ā �@ DJ��M ��H	  ��$D  �H� H$� N��DI ��D��DJ�M �H
� $��D  �N ��H	 �@ � ���� ��   	�D� � & � 9   _worldGetEntityByIDGetCasterEntityIDGetTargetEntityIDstablecount       ��������LogfatalNeed Target SkillIDGetSkillIDGetService	UtilCalcBoardLogicskillEffectParamskillIDHasDeadMarkGetFindTypeMonsterMoveLongestGridFindTypeNormalFindMonsterLongestGridPathMoreSpTrapsGetLineNeedTrapIDGetLineCount#FindMonsterLongestGridPathByTrapIDSpiralGetRunCountListFindMinosMoveGridPathTrigger        ipairsGetGridPositionMonsterMoveLongestGridResultNewUpdateEntityBlockFlagSetGridPositionSetGridDirectionGetIDinsertSetWalkPosNotifyNTEffect156MoveOneGridBegin_OnArrivePosNTEffect156MoveOneGridEndIsResetGridSupplyPieceListGetBoardEntityBoardFillPiecesSetNewGridTypecolorNTEffect156MoveFinishBegin_OnFinishedNTEffect156MoveFinishEndNTEffect156MoveFinish(SkillEffectMonsterMoveLongestGridResult         �                                                                                              "   "   "   "   %   &   &   (   (   (   (   )   *   *   *   *   ,   ,   -   -   -   -   .   .   .   .   .   /   /   /   /   0   0   1   1   2   2   2   2   2   2   2   3   3   3   3   4   4   5   5   5   5   5   8   :   <   >   @   @   @   @   A   A   A   B   C   C   C   C   D   D   F   F   F   H   H   H   H   H   I   I   I   J   J   J   L   L   M   M   M   M   M   N   N   N   O   O   O   O   O   O   Q   Q   Q   Q   Q   Q   R   R   R   R   R   R   S   S   S   S   S   T   T   T   T   U   U   X   X   X   X   Y   Y   Y   [   [   [   ]   ]   ^   ^   ^   _   _   _   _   `   a   a   a   _   _   C   C   e   e   e   e   e   e   e   f   f   f   f   f   f   f   f   f   g   g   g   g   g   g   i   i   j   j   k   l   l   l   n   n   n   n   n   n   o   o   o   o   o   o   o   p   p   p   p   q   )   self    �   skillEffectCalcParam    �   casterEntity   �   targetIDList   �   	targetID   �   utilCalcSvc   �   sBoard!   �   param"   �   targetEntity(   �   	movePath)   �   	findType/   R   trapID>   F   
lineCount@   F   runCountListM   R   isCasterDeadS   �   posWalkResultListT   �   finalAttackResultU   �   summonTrapResultListV   �   triggerServiceZ   �   oldPosList^   �   (for generator)a   �   (for state)a   �   (for control)a   �   ib   �   posb   �   posSelfd   �   walkResg   �   	entityIDt   �   newPosList�   �   boardEntity�   �   
boardCmpt�   �   (for generator)�   �   (for state)�   �   (for control)�   �   i�   �   walkRes�   �   newPos�   �   
casterPos�   �   
targetPos�   �   dir�   �   result�   �      _ENV t   �    �   G@ LA���  d���@ �A@�  ����� � BA��$��G����A � FB GC��� �B @ $ �@ �ă��B ��	� E�	� 	$E��C����� ��	$E )�  ��@ C@� $��LC�d� �@ �C@� �����D@�䃀�B @�$@�"  ��LE
d� �E�
�� ����   ���E
�� ��E AF �E ��F  
L��d �E  �G�C
$ �E  �EG�G C� 
$��E  )�  ���@ D@� $��LDG��G ��	@� ��� dD  FH GD�� d� ��B � �@��@ ̅�@ 䅀�$� FE$� FH G���I � dF�FFI G��@� �L��d� ���  ���J  � @ ������FJ@ �F���  *��& � *   _worldGetServiceSkillLogic
TrapLogicGetGridPositionFindTrapByPos_arrivePosTypeTriggerTrapByEntityTrapTriggerOriginMoveipairsAISkillResultNewSetResultContainerAddWalkTrapGetIDTriggerGetFlushTrapIDs	UtilDataGetTrapsAtPosTrapID
GetTrapIDAttributesModifyHP        AddTrapDeadMarkGetDisableDieSkillSetFlushTrapIDNotifyNTMinosAbsorbTrapNTEffect156MoveOneGridtablecountGetEntityByIDinsert_arriveTrapIDs$MonsterMoveLongestGridArrivePosTypeNormalAndAttackAtSpTrapsGetAttackTrapIDs_AttackSetAttackResult         �   w   w   w   w   z   z   z   z   {   {   |   |   |   }   ~   ~   ~   ~   ~               �   �   �   �   �   �   �   �   �   �   �   �   �         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   )   self    �   casterEntity    �   walkRes    �   param    �   targetEntity    �   skillLogicSvc   �   trapServiceLogic   �   pos
   �   trapIDsOnPos   �   arriveType   �   listTrapWork   �   listTrapResult   �   (for generator)   &   (for state)   &   (for control)   &   i   $   e   $   trapEntity   $   skillEffectResultContainer   $   	aiResult   $   triggerSvc*   �   flushTrapIDs,   �   utilSvc0   �   array3   �   (for generator)6   W   (for state)6   W   (for control)6   W   _7   U   eTrap7   U   trapIDCmpt;   U   triggerService[   �   nTrapCountf   �   (for generator)i   �   (for state)i   �   (for control)i   �   ij   �   	entityIDj   �   trapEntityn   �   trapIDr   �   attackTrapIDs}   �   attackResult�   �      _ENV �   �    �   ���� �A@ ́�A�  䁀�$� K  �  �BA ǂ��@��B@ ̂�A� 䂀�� $��GC@ LC�d� ����� ��B@ �C��C   �� ��LE�	ǅC
dE��  jD��C   �������	� $� "   ��� ��	FD A� �� $��C� �  �� �$ $�  FEE L��
�  �	d� ���
  LF
d +F  �E��EF ��F�� �
�E��  j����F @� �����$ �  ���BA �B����̂� � ��$� FH GC�����   d� ����� �CF ���I @ 䃀�C  ���C@ ̃�AD	 䃀�  � � �������� ��$� G���� �@ �� �  @���  @��ED �� � �����   @� ��� ��  �DE ̄�	@ ��� ��	�  �F	� �E  $E�EF �F
@���	$E���D�DF ��I	��  �D�����  ��& � (   GetFinishType_worldGetService
TrapLogicGetSummonTrapID%MonsterMoveLongestGridMoveFinishTypeResetGridAndSummonTrapsBoardLogicSupplyPieceListGetBoardEntityBoardFillPiecesipairsSetNewGridTypecolorCanSummonTrapOnPosCreateTrapVector2               IsTransferDisabledSkillSummonTrapEffectResultNewSetTrapIDListGetIDtableinsert_AttackGetFinalAttackPercentNoTrapsSummonTrapsGetGridPositionGetSummonScopeRingCountComputeScopeRangeComputeRange_SquareRingGetSummonTrapCount
icontains_arriveTrapIDsRandomLogic
LogicRandremove         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   %   self    �   casterEntity    �   posWalkResultList    �   param    �   oldPosList    �   targetEntity    �   finishType   �   trapServiceLogic   �   summonTrapID   �   summonTrapResultArray	   �   attackResult
   �   sBoard   X   newPosList   X   boardEntity   X   
boardCmpt   X   (for generator)    '   (for state)    '   (for control)    '   i!   %   walkRes!   %   newPos"   %   (for generator)*   P   (for state)*   P   (for control)*   P   i+   N   pos+   N   trapEntity>   N   summonTrapResultC   N   
casterPos^   �   
ringCount`   �   
rangeListf   �   
trapCounth   �   
randomSvcs   �   index|   �   pos}   �   trapEntity�   �   summonTrapResult�   �      _ENV   '   *   G@ �A��� ́� � �@$� L��d� "    �@ �A �BA�  
C�L�d� 
C��
������̂�@� ���   G�B � �C �D�	  �� L��� �C$� @�� � d��f & �    _skillEffectServiceGetSkillEffectDamageStageIndexGetGridPositionGetDamagePercentSkillDamageEffectParamNewpercent
formulaIDGetDamageFormulaIDdamageStageIndexComputeSkillDamageskillIDSkillEffectTypeMonsterMoveLongestGridNewSkillDamageEffectResultGetID         *                     	  	  
                                               !  !  "  #  %    &  '     self    *   casterEntity    *   targetEntity    *   param    *   finalAttackPercent    *   effectCalcSvc   *   damageStageIndex   *   
attackPos   *   
targetPos   *   percent	   *   	tmpParam   *   nTotalDamage    *   listDamageInfo    *   skillResult(   *      _ENV                     	      	      q      t   �   t   �   �   �     '    '         _ENV