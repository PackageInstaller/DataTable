LuaS �

xV           (w@P@../PublishResources/lua/product/core_game/logic/helper/ai/action_move_base.lua         =    @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��A l�  
@ �@B l�  
@ �@B l  
@��@B l@ 
@ �@B l� 
@��@B l� 
@ �@B l  
@��@B l@ 
@ �@B l� 
@��@B l� 
@ �@B l  
@��@B l@ 
@ �@B l� 
@��@B l� 
@ �@B l  
@��& �    requireai_node_new_classActionMoveBase
AINewNodeConstructorInitializeNodeActionMoveBaseResetActionMoveBaseCheckCanMoveOnBeginBeforeCalcMovePosAfterCalcMovePos	OnUpdate_CalcMovePosOnEnd_ComputeSkillRangeInitTargetPosListFindNewTargetPosFindNewWalkPosFindPosByNearCenter_OnArrivePosisDuplicate        
          
@@�F�@ G � �@ �@ d��
@ �& �    m_posMoveTarget m_posTargetVector2New                                               self          _ENV        
   F@ GA�G���  ��   @�� dA & �    ActionMoveBasesuperInitializeNode         
                                    self    
   cfg    
   context    
   parentNode    
   configData    
      _ENV           F @ G@� G�� �   d@ F A G@� �� �� d��
@��& �    ActionMoveBasesuperResetm_posTargetVector2New                                                           self          _ENV    !       G @ L@� d� ��� �  �   & �    m_entityOwnAICanMove                                !      self       aiCmpt           #   A    D   G @ L@� d� ��@ ��@� � � � � ��@A � �@�& � � B �� ������@� �@ �@�@��@A � �@�& � � @ ��B�� �   ���@� F�@ G���@��@A A �@�& � �@� F�@ GA��@�̀� � �   @���$� "  @��$� LA�d� L��d� �@ ��D�� �E @ ���A � �AA �A $A�& �    m_entityOwnAIAIMoveStateMoveEndGetMoveState	PrintLog移动结束等待中 CheckCanMoveSetMoveState启动移动<不允许>Trap机关不能以AI移动MovingGetTargetEntityHasGridLocationGetCoverAreaListGridLocationCenterGetGridPositionInitTargetPosList没有找到目标         D   %   %   %   &   &   &   &   &   &   '   '   '   (   *   *   *   *   +   +   +   +   ,   ,   ,   -   0   0   0   1   1   2   2   2   2   3   3   3   4   7   7   7   7   8   8   9   9   9   9   9   9   :   :   ;   ;   ;   ;   <   <   <   =   =   =   =   =   ?   ?   ?   A      self    D   aiCmpt   D   	trapCmpt   D   targetEntity,   D   listPosTarget4   ?   targetEntityPosCenter8   ?   posSelf;   ?      _ENV C   E       & �                E      self            G   I       & �                I      self            K   �    �   G @ �@� �� ƀ@ ���A$�  �@��@A A� �@���A � ��  ̀B � ���� ���A � ��  ��B � �@ � �   � ���A � ��  �@C ̀�A� 䀀D $A AD �� $��L�D dA GAC L��d� L�d� �AE ��E�� _�E���� � BF��$B����� ��  $B��� � $B�� ��$B�B� $� L�G� dB�L���   dB LH � dB�GBC LB�d� L���B �ɑ�I ���C� $� ���CJ @�$� A�
 �CJ � �� ���CJ GK $� ���dB�LBA �B �K ��$��A� �B��K � $��A ��K K ��dB  LBL �B �K ��$��A� �B��K � $��A ��K K ��dB  ́L� �B CG@ $� "  ���L��@ ��@$B��A B&  � ��� ��A BM& ���L��@ ��@$B��A B& & � 6   m_entityOwnAIAIMoveStateMoveEndGetMoveState	PrintLog移动结束等待中AINewNodeStatusSuccess CheckCanMove
AINewNodeIsEntityDead_worldGetServiceBoardLogicBeforeCalcMovePos_CalcMovePosAfterCalcMovePosGetBoardEntityAIRecorderMonsterWalkResultNew GetGridPositionSetLastMovePosUpdateEntityBlockFlagSetGridPositionSetGridDirectionGetIDSetWalkPosAddWalkResult_OnArrivePosGetSyncLoggerTracekeyAIMoveaiNode_className	entityIDfromTo	tostring->targetm_posTarget移动位置 _MakePosString=>, 选择目标PrintDebugLogGetMobilityValidSetMoveState       Failure         �   M   O   O   P   P   P   P   P   P   Q   Q   Q   R   R   R   T   T   T   T   U   U   U   X   X   X   X   X   X   Y   Y   Y   ]   ]   ]   ]   ^   ^   `   `   `   a   a   d   d   d   d   d   f   f   f   g   g   i   i   l   l   l   n   n   n   n   n   o   o   o   p   p   p   r   r   t   t   t   u   u   u   u   w   w   w   y   y   y   y   y   {   |   |   }   }   }   ~   ~   ~   ~   ~   ~   ~   ~   ~               y   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
   self    �   entityWork   �   aiComponent   �   sBoard#   �   posWalk(   �   aiRecorderCmpt/   �   walkRes2   �   posSelf6   �   	entityIDF   �   nMobilityToalRemain�   �      _ENV �   �    F   � � �� �@� � ǀ��@ $� 
 � �@�LAA �� �A ��$�dA  LB �� �A ��$�dA  D  f LABd� ��B  �@��� �����B @ � ��䁀�  ����@�BA � ��A @�䂀C L�A ��d�$B  B � ��A @�䂀C L�A ��d�$B    & B �� ��A @���$B  � & �    AIGridLocation	PositionFindNewTargetPosm_posTarget	PrintLog+不需要移动，当前就是目标坐标_MakePosStringPrintDebugLogGetMobilityValidComputeWalkRangeFindNewWalkPos不需要移动 >===>
移动到        F   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    F   entityWork    F   aiComponent   F   posSelf   F   
posTarget   F   nWalkTotal   F   posWalkList   F   posWalk$   F        �   �       & �                �      self            �   �        � @ �K  f @ �����@���@ ��  �  ���M�������� ���@ �A B ���M����A  � @�� ��� �  & �                   Vector2��������	       ��������CalculateSkillRange            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       	nSkillID       
posCenter       	bodyArea       dir       workCenter         _ENV �   �       & �                �      self       listPosTarget            �   �       G @ L@� d� f  & �    m_entityOwnGetGridPosition           �   �   �   �   �      self       posDefault           �   �    
   @ �� �  �AB  % &  & �    FindPosByNearCenter                  �   �   �   �   �   �   �   �      self       
walkRange       
posCenter       posDef            �   
   B   _@ �@�FA@ G���� d� !��  ��  FA LA�ƁA ���B BBd� ����A ��B �C�� �AC� �C �C� $��AB �� �B h��G� ����� _� ��_ �� ����� � ��E@�� ��B 䃀_�@�@����E �E@�� �   $D���g��LF �� �e f  & �     tablecount        SortedArrayNew
AlgorithmCOMPARE_CUSTOMAiSortByDistance_ComparerByNearAllowDuplicatem_entityOwnAIGetLastMovePos_worldGetService	UtilData       GetPosGetStepIsBlockMoveWithTrapWall 
AINewNodeInsertSortedArrayFindPosValid         B   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                     �   	  	  	  	  	  
     self    B   listPlanPos    B   
posCenter    B   posDef    B   nCheckStep    B   	listWalk   B   aiCmpt   B   lastMovePos   B   utilDataSvc   B   (for index)   <   (for limit)   <   (for step)   <   i   ;   posData    ;   posWalk"   ;   isBlockMoveWithTrapWall/   ;      _ENV   G   r   � @ �@@�� ǀ@ ���A 䀀�@�A $��G@ L��d� ��A@ FB GB��� �B @ $��@ �Â��B ��� D�� $D��C$� F�C G��D �@ ̄�	� � @�� ̅�� F L�Ed� G��dD�L� ̄��  �dD )�  ���BF �F@ $� K  �@ ��F�� �G�� �@ �B�� ̂�� @ �A$� F�B � d���D��	�DF ���	 �@ 	䄀�D  � ������	J��	i�  �C�G@ L�d� �C��� ƃH ��G@ ����� �   � �@�	 $��DI��$D��� ��$D�& � '   m_entityOwnGetOwnerWorld_worldGetServiceSkillLogic
TrapLogicGetGridPositionTriggerTrapByEntityTrapTriggerOriginMoveipairsAISkillResultNewSetResultContainerGetScopeResultLogdebug [AIMove] OnArrivePos() monster=GetID pos= trigger trapid= defender=GetTargetIDs       AddWalkTraptablecount	BodyAreaGetAreaGridLocationGetGridDirVector2IncludeAIGetLastMovePosNTMonsterMoveOneFinishGetWalkPosTriggerNotifySetWalkPassedGrid         r                                                            !  !  !  #  #  $  $  %  &  &  &  '  (  )  *  *  +  ,  ,  -  $  .  .  .  .  .      1  1  1  1  4  5  5  5  5  5  6  6  6  6  6  7  7  7  8  8  8  8  9  9  :  :  :  :  :  :  :  ;  ;  ;  8  8  @  @  @  A  A  B  B  B  B  B  B  B  B  C  C  C  C  C  C  F  F  F  G     self    r   walkRes    r   world   r   skillLogicSvc   r   trapServiceLogic
   r   pos   r   listTrapWork   r   listTrapResult   r   (for generator)   7   (for state)   7   (for control)   7   i   5   e   5   trapEntity   5   skillEffectResultContainer   5   	aiResult   5   	scopeRes    5   nTrapCount;   r   
passGrids<   r   	bodyAreaA   r   dirF   r   curPosI   r   (for generator)L   [   (for state)L   [   (for control)L   [   _M   Y   valueM   Y   posO   Y   aiCmpt^   r   lastMovePos`   r   nth   r      _ENV I  P   
   � @   � @�B�GB� @@���G�� @@ �� & �  j���   �  & �    ipairsxy            J  J  J  J  K  K  K  K  K  K  K  K  L  L  J  J  O  O  P     self       pos       
passGrids       (for generator)      (for state)      (for control)      _      value         _ENV=                              
      
                        !      #   A   #   C   E   C   G   I   G   K   �   K   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
  �     G    I  P  I  P         _ENV