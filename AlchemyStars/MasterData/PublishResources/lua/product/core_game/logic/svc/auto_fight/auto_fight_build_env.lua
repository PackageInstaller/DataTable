LuaS �

xV           (w@Y@../PublishResources/lua/product/core_game/logic/svc/auto_fight/auto_fight_build_env.lua         U    @ A@  $@ �@ l   
@���@ l@  
@ ��@ l�  
@���@ l�  
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@��& �    requireauto_fight_serviceAutoFightService_BuildMoveEnv_CalcPieceMovePets_PosIndexAddOffset_DiffPosIndex21_PosIndexDistance_Pos2Index_Index2Pos_Offset2Index_CalcPosIndex_CalcBoardPosPieceType_CalcBoardPosCanMove_CalcMonsterPos_CalcMonsterElementBuffPos_CalcBoardPosEvalue_CalcTrapPosEvalue_FindTriggeredTrap_CalcSurroundPos_DoPrismChange_UndoPrismChange_DoRemoveMapPosIdx_DoAddMapPosIdx_CalcOppositeDir_CalcConnectMap	_Search8_CalcHighConnectRateCutLen_CalcMapByPositionGetAutoFightEnvironment           %    Q   �   
� �� @ �@@ ̀��   � ��  � �  � ��  � �  � ��  � �  � ��  � �  � ��  � ���$� �@�� ���@ ��� $� �D� ��A� $� �E��E �E$��� �AF $� � �  � �G $� � ���G $� � ��H $� � ���H $� � ��I $� � ���I $� � ��J $� � ���J $� � ��K $� � ��  � ����K��@L��L $A & � 3   _env_configServiceGetLevelConfigData
UnlockPosDimensionDoorPos	PrismPosPrismEntityIDsLockGridPosMonsterPosBossPosMonsterDictChainSkillAttackOffsetChainSkillAttackCountLevelPolicyLevelPolicyParamGetAutoFightLevelPolicyTeamEntity
PlayerPosGridLocation	PositionBenumbBuffComponentHasFlag
BuffFlags
Index2Pos_CalcPosIndexBoardPosCanAttackBoardPosPieces_CalcBoardPosPieceTypeBoardPosCanMove_CalcBoardPosCanMoveBoardPosEvalue_CalcBoardPosEvalueTrapPosEvalue_CalcTrapPosEvalueElementBuffPos_CalcMonsterElementBuffPosPieceTypeMovePets_CalcPieceMovePetsMapByPosition_CalcMapByPositionConnectMap_CalcConnectMapHighConnectRateCutLen_CalcHighConnectRateCutLenChainPathsMVP ThinkStartTime        _CalcMonsterPos         Q                           	   	   
   
                                                                                                                                                                                                !   !   "   #   $   $   %      self    Q   teamEntity    Q   env   Q   	levelCfg   Q      _ENV (   1    -   K   � @ �@@̀@ F@ GA�䀀J� � @ ��@̀@ F@ G��䀀J� � @ � A̀@ F@ G�䀀J� � @ �@A̀@ F@ GA�䀀J� � @ ��A̀@ F@ G��䀀J� � @ ��A̀@ F@ G��䀀J� f  & �    
PieceTypeBlue_CalcMoveEntitiesRedGreenYellowAnyNone         -   )   *   *   *   *   *   *   *   +   +   +   +   +   +   +   ,   ,   ,   ,   ,   ,   ,   -   -   -   -   -   -   -   .   .   .   .   .   .   .   /   /   /   /   /   /   /   0   1      self    -   t   -      _ENV 3   5       � @�@���� �@� ��  & �           d                         4   4   4   4   4   4   5      self       posIdx       offset            7   9    
   �  @S� AP@�� N���@ �  & �    d               
   8   8   8   8   8   8   8   8   8   9      self    
   posIdx1    
   posIdx2    
        ;   =       � � @� ��@�� P@AA@� ��  & �    d                         <   <   <   <   <   <   <   <   <   <   =      self       posIdx1       posIdx2            ?   A       � � �@@ǀ� �� �  & �    xd       y           @   @   @   @   @   A      self       pos            C   F       � @ �@@�@ �  & �    _env
Index2Pos           D   D   D   E   F      self       index       pos           H   O       ��  �AA  ��  ��  +A�� ��AA �� �  +A�� ��A �� � +A�� ��� �MAA& & � 	                                                                              I   J   J   J   J   J   J   K   K   K   K   K   K   L   L   L   L   L   L   N   N   N   N   N   O      self       i       j       t           Q   _       G @ L@� ��  d����� �� � � �   AA � �A h�AB ���B h��F�A � � d����A  ����
Ag��gA�& & �    _worldGetServiceBoardLogicGetCurBoardMaxXGetCurBoardMaxY       Vector2_Pos2Index            S   S   S   S   T   T   U   U   V   W   W   W   W   X   X   X   X   Y   Y   Y   Y   Z   Z   Z   [   X   W   ^   _      self       boardServiceLogic      
boardMaxX      
boardMaxY      	posIndex	      (for index)      (for limit)      (for step)      x      (for index)      (for limit)      (for step)      y      pos      posIdx         _ENV a   n       K   � @ �@@�� ��@�� ��@� A   �  �A @�$� �OCAMÂJ �)�  ����  j�̀A G�A G�䀀AB �BJ �f  & �    _worldGetBoardEntityBoardPiecespairsd       _Pos2Index_env
PlayerPos
PieceTypeAny            b   d   d   d   d   d   d   e   e   e   e   f   f   f   f   g   g   h   f   f   e   e   k   k   k   k   l   l   l   m   n      self       	posColor      pieces      (for generator)
      (for state)
      (for control)
      x      row      (for generator)      (for state)      (for control)      y      color      posIdx      playerPosIdx         _ENV p   �    L   K   � @ �@@�  ���� @ ���� � �� @ A@�A $��L�Ad� ��A�� �  �A ���   A �B��CB̓��B �B�LC� d��bD  ��G�B GD�Gă��C ��C	_��  �J �LD�� d��b  ��L��� d����D �E	ǄB �D�	 ��D���B ��E	�D�l  ���  @��� � 	 ��� �ǄB �D�	�������f  & �    _worldGetService	UtilDataGetBoardEntityBoardBoardLogicGetCurBoardMaxXGetCurBoardMaxY       d       _env
Index2PosIsPosBlockLinkLineForChainBoardPosPieces
PieceTypeNoneIsPrismPieceGetPrismEntityIDAtPostableinsert	PrismPosPrismEntityIDsGetPieceEntities        LockGridPos         �   �    
   L @ d� b   � �L @ d� L@� d� f  & �    TrapIsLockedGrid        
   �   �   �   �   �   �   �   �   �   �      e    
       L   q   s   s   s   s   t   t   t   t   t   v   v   v   v   w   w   x   x   y   y   y   y   z   z   z   z   {   {   |   |   |   }   }   }   }   }   ~   ~   ~   ~   ~   ~   ~      �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   z   y   �   �      self    L   posCanMove   L   	utilData   L   board
   L   boardServiceLogic   L   
boardMaxX   L   
boardMaxY   L   (for index)   J   (for limit)   J   (for step)   J   x   I   (for index)   I   (for limit)   I   (for step)   I   y   H   posIdx   H   pos   H   eid4   =   filter>   H   esB   H      _ENV �   �    E   G @ G@� ��@ ��@�@ AAA���̀A� �@ �A$� F�A G�@ ��ABG@ G��L��d� L�d� �@AC @�$��L�Cd� G���D�� �BD�� �BC   ����D �ă$��L�Dd� b  ��FE GD��@ ��E	� dD�@�FE GD��@ ��E	� dD�G@ G�J�  j��)�  �A�& �    _envBoardPosCanMove_world	GetGroupBW_WEMatchers
MonsterIDGetEntities
MatchTypeMT_BlackFist       TeamEntityTeamGetEnemyTeamEntityipairsGridLocation	Position	BodyAreaGetArea_Pos2IndexHasBosstableinsertBossPosMonsterPosMonsterDict         E   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    E   posCanMove   E   monsterGroup   E   enemies
   E   (for generator)   D   (for state)   D   (for control)   D   i   B   e   B   center!   B   	bodyArea%   B   (for generator)(   B   (for state)(   B   (for control)(   B   _)   @   area)   @   posIdx,   @      _ENV �   �    "q   K   � @ �@@ǀ@ ���A 䀀�@ �@�A $��G�@ L��ǁ@ �����d���AB ́�� � ����B� ��AC 䂀�  ��̂C� ���� D�CD ��D��$� LD�CD ��� �d� �DDD E@��� �DFDD GD���� �E$� �ELFd� LD�d� �DB ����
�ͅ�F ��$��FFB ��F d ��G   @��� Ǉ�  @�� HD �DFHG G��G��GHD �DFHG G��GH��GHD EFHG G��G���GHD HEFHG G��Gȃ�GJ�i�  ����  *����  *��f  & �    _envBoardPosCanMove_worldGetService	UtilCalcFormula	GetGroupBW_WEMatchers
MonsterIDipairsGetEntitiesAttributesGetAttributeElementReinforceElementGetPrimaryTypeGetRestrainFlag
PieceTypeBlueRedGreenYellowGridLocation	Position	BodyAreaGetArea_Pos2IndexOffset4_PosIndexAddOffsetBattleConst$AutoFightElementBuffFlagAddPosValue         q   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    q   elementPos   q   posCanMove   q   utilCalcSvc   q   	sFormula   q   monsterGroup   q   (for generator)   o   (for state)   o   (for control)   o   i   m   e   m   elementType!   m   flag1&   m   flag2+   m   flag30   m   flag45   m   center8   m   area<   m   (for generator)?   m   (for state)?   m   (for control)?   m   _@   k   v@   k   mposA   k   mposIdxD   k   (for generator)G   k   (for state)G   k   (for control)G   k   _H   i   offH   i   posIdxL   i      _ENV �   .   +�   G @ G@� � @ ��@��@ �$� K  �AA ��A� ����B� BB$� A� ���� h�A� � �� h��O�BM��D� �  � ��C �DC	J��g��gB�A� �BA ��CCA DCD���̂D� CA �D$� F�D G�@ ���BG@ GC�L��d� L��d� �BF @�$��LDFd� L����F ��	d��bD  ��G@ GD���G ��G	����LHd� b  ��FDH G���@ ��H	�I	�DD� �D�	� d�  b  � �G@ G��G��L�Id� G��DJ�� ��J	�� �F   	� �ƅL�J � d���F �K ����GK @�� � ȇ "  � �ȇHJ������  *���  j�)�  ���CA �C�CA �D��K$��FF ��D� d ������� �L	�� ���� �D�	� ��$� J
LE�d� L��
d� �@ �EGƅG ǅ������L �M��	���@ ��H��I�EM @ 
��
ƆM 䅀  FF ��D� d ������� �J�G�� ̇�� � \��� (��Ɉ�L�J �	 d���I��B���IM  
 @
���M ����IH �	� 
 @
 �I�  �'��i�  ��FFN � d@��� �  � �����J�i�  ���i�  �C�f & � :   _envBoardPosCanMoveBoardPosCanAttack_configServiceGetTrapConfigData_worldGetServiceBoardLogicGetCurBoardMaxXGetCurBoardMaxY       d       BattleConstAutoFightNoAttackPosValue        	GetGroupBW_WEMatchers
MonsterIDGetEntities
MatchTypeMT_BlackFistTeamEntityTeamGetEnemyTeamEntityipairsBuffComponentHasBuffEffectBuffEffectTypeAttackImmunedLevelPolicyLevelPosPolicyKillMonsterHasMonsterIDtable
icontainsLevelPolicyParammonsterIdsGetMonsterID	addValueGridLocation	Position	BodyAreaGetArea_Pos2IndexOffset4_PosIndexAddOffsetTrap
GetTrapIDGetTrapTypeProtectTrap	TrapType
Protected_CalcSurroundPosRing2Offset8appendpairs         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                     �   �   �   �                                                                                                                                                            !  !  !  !  !  !        &  &  &  &  '  '  '  (  (  (  &  &      -  .  I   self    �   posCanMove   �   posCanAttack   �   configService   �   trapCfg   �   posEValues   �   boardServiceLogic   �   
boardMaxX   �   
boardMaxY   �   (for index)   "   (for limit)   "   (for step)   "   x   !   (for index)   !   (for limit)   !   (for step)   !   y       posIdx       posVal#   �   monsterGroup)   �   enemies+   �   (for generator)>   �   (for state)>   �   (for control)>   �   i?   �   e?   �   centerc   �   areag   �   (for generator)j   �   (for state)j   �   (for control)j   �   _k   �   vk   �   mposl   �   mposIdxo   �   (for generator)r   �   (for state)r   �   (for control)r   �   _s   ~   offs   ~   posIdxw   ~   group�   �   (for generator)�   �   (for state)�   �   (for control)�   �   i�   �   e�   �   trapID�   �   	trapType�   �   center�   �   area�   �   posVal�   �   surroundArea�   �   monsterSurroundArea�   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   e�   �   monsterGridPos�   �   
areaArray�   �   (for index)�   �   (for limit)�   �   (for step)�   �   i�   �   pos�   �   posIdx�   �   monsterSurround�   �   (for generator)�   �   (for state)�   �   (for control)�   �   posIdx�   �   _�   �      _ENV 0  m   �   G @ G@� ��@ ��@� @ AAA$� K  ��A ��A�A BBB���ƁB �B$ �  �C�$� LCd� �CC�� ̃�@�䃀����C    �� D�$� �DL��d� L�d� �DE   ���̄E� �  @���E ��	_�  ��D  �� �  ��@ 
��@ �F
F�F G�

E	@����G$�  D
���G H
G@ GE�
� 	$E�@ �F
F�F G�

E	�H$� "  � �@ �H

I	_ � 
�EI ��$��"   �L�I ��I
J
d� �  �@ �� ����G �E�  @ 䅀�    ���F�B ��d ��F�FE @ 䆀ǆ "  @�ǆ"G    � �J�i�  ���  j�f & � *   _envBoardPosCanMove_configServiceGetTrapConfigDataTeamEntityGetID_world	GetGroupBW_WEMatchersTrapipairsGetEntities
GetTrapIDGetTrapTypeGetTrapDataAutoFightAddPathValue        GridLocation	Position	BodyAreaGetArea_Pos2IndexIsExit	TrapTypeGroudTriggerExitPosBoardPosPieces
PieceTypeAnyqo�     GetCurrentTriggerCounttableinsert
UnlockPosIsDimensionDoorDimensionDoorPos_FindTriggeredTrap _CalcSkillScopeResultAndTargetstrapEntityskillId
icontains         �   1  1  2  3  3  4  4  4  4  5  8  8  8  8  8  8  9  9  9  9  9  :  :  ;  ;  <  <  >  >  >  >  >  >  >  ?  ?  ?  @  @  @  @  A  A  A  D  D  D  D  D  D  D  D  D  D  E  E  F  F  G  G  G  G  G  J  J  J  J  J  J  K  K  K  K  K  K  L  L  L  L  L  O  O  O  O  P  P  P  T  T  V  V  V  W  W  Y  Y  Y  Y  Z  Z  Z  [  [  \  \  \  \  \  \  \  ]  b  b  b  b  c  d  d  d  e  e  e  f  f  f  f  f  f  b  b  9  9  l  m     self    �   posCanMove   �   configService   �   trapCfg   �   teamEntityID	   �   posEValues
   �   group   �   (for generator)   �   (for state)   �   (for control)   �   i   �   e   �   cTrap   �   trapID   �   	trapType   �   posVal"   �   center%   �   area)   �   trapPosIdx,   �   isExitTrap6   �   triggerTrap\   �   resultb   o   
targetIdsb   o   (for generator)r   �   (for state)r   �   (for control)r   �   _s   �   vs   �   post   �   posIdxw   �      _ENV o  �   (   � � �� �@@�  � � ��@$� ! �  �& � A AA�� $��"  @�F�A G��� d�  @���FB � d@����� �BB� �  � ��  
C�
Â�& i�  ���& �    TrapGetTriggerMaxCount        GetCurrentTriggerCount	_utilSvcGetGroupTraptablecountipairsGetTriggerSkillIDtrapEntityskillId         (   p  p  q  q  r  r  r  r  r  r  s  v  v  v  v  w  w  w  w  w  w  w  w  x  x  x  x  y  y  z  z  {  {  |  |  |  |  x  x  �     self    (   eTrap    (   cTrap   (   maxTriggerCount   (   traps   (   (for generator)   '   (for state)   '   (for control)   '   _   %   e   %   cTriggeredTrap   %   skillId   %      _ENV �  �        F@ � d���B� �B@ @ 䂀@ @�$ �L�@ ��  d� 
��)�  ��i�  ��& & �    ipairs_Pos2Index_PosIndexAddOffset                   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       center       area       ring       surroundArea      (for generator)      (for state)      (for control)      _      v      pos      posIdx	      (for generator)      (for state)      (for control)      _      off      sIdx         _ENV �  �   ~   � @ @� 䀀@ � $��N��A@ ��@�A ��@ ��AB 䁀�@ A�� $��K  �B@ ��A�B ��@ ��  ��FCB L��� d����� �@ ���� C EC
�D� �� ̃C� �C    ��  �C @�$@�LD � 
d��b   ��E@ �ED�E�  ���E@ ��D�E�E  ����D �E���  
��
���E�)�  ���@�A� �F �CF�� h��O�MD��D  �����   ��D@ �D�	Ǆ�	�  ���D@ Ǆ�	Ǆ�	�D  ����D ��	 �K�  JE��J���D�g��F�C ��d���C ��F	�D��� �D@ Ǆ�	���	��F @ 	�D��G @ 	����D i�  ��& �    _Index2Pos_envBoardPosPieces_worldGetService	UtilDataUtilScopeCalcPrismEntityIDsGetPrismCustomScopeConfigSkillScopeCalculatorNewComputeScopeRangeVector2zeroGetAttackRangeipairs_Pos2IndexConnectMapLockGridPostableinsertpos
pieceType       BattleConstPrismEffectPieceCount
Pos2Index_DoRemoveMapPosIdx_DoAddMapPosIdx         ~   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  "   self    ~   prismPosIdx    ~   prevPosIdx    ~   	prismPos   ~   prevPos   ~   dir   ~   prismPieceType
   ~   	utilData   ~   
utilScope   ~   tTargetPieces   ~   prismEntityID   ~   
scopeType   ~   scopeParam   ~   calc   I   result(   I   range-   I   (for generator)0   I   (for state)0   I   (for control)0   I   _1   G   v21   G   
tarPosIdx4   G   (for index)N   h   (for limit)N   h   (for step)N   h   iO   g   
targetPosQ   g   
tarPosIdxT   g   (for generator)k   }   (for state)k   }   (for control)k   }   _l   {   datal   {   	posIndexp   {      _ENV �  �   �   � @ �@�� ̀�� ���A �� $��LA � d���A�AA ǁ��A�@ �A� $��G@ L���B d���  �BA ǂ��B��B��$À"  ���C �CC ����̃C@ ��� � F�C G�
+E� � D�$� "D    �  F�D � d@���D  �
����   ��EA ��ǅ��  ���EA �E�ǅ��E  ��ǅ�
�Ņ��
��F FF@ ��  �F��ƅ�$F�i�  ���@�� �CG ǃ� ����D����D @ 	䄀�   �EA E
�
"  ��EA EE
�
"E  ���E	�G�E	E
FF GE�
� ˅  ʅ����dE������D � �����C ���	�F	� EA �A
G�F	
E�	H ��	$E�EH ��	��F	$E ��  *��& � "   _worldGetBoardEntityBoardPieces_Index2Pos_envBoardPosPiecesGetService	UtilDataUtilScopeCalcPrismEntityIDsGetPrismCustomScopeConfigSkillScopeCalculatorNewComputeScopeRangeVector2zeroGetAttackRangeipairs_Pos2IndexConnectMapLockGridPosxytableinsertpos
pieceType       BattleConstPrismEffectPieceCount
Pos2Index_DoRemoveMapPosIdx_DoAddMapPosIdx         �   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  %   self    �   prismPosIdx    �   prevPosIdx    �   pieces   �   	prismPos	   �   prevPos   �   dir   �   prismPieceType   �   	utilData   �   
utilScope   �   tTargetPieces   �   prismEntityID   �   
scopeType   �   scopeParam   �   calc%   S   result.   S   range3   S   (for generator)6   S   (for state)6   S   (for control)6   S   _7   Q   v27   Q   
tarPosIdx:   Q   originalPieceTypeJ   Q   (for index)X   v   (for limit)X   v   (for step)X   v   iY   u   
targetPos[   u   
tarPosIdx^   u   originalPieceTypen   u   (for generator)y   �   (for state)y   �   (for control)y   �   _z   �   dataz   �   	posIndex~   �      _ENV         � @ �@@�@ ��  �& � �  A ��  (��"   �LBA ��d������'����� & �    _envConnectMap               _CalcOppositeDir                               	  
  
                  
   self       posIdx       connectMap      ct      (for index)	      (for limit)	      (for step)	      i
      roundPosIdx      oppDir             (   2   �   @ A@
�� �@ F�@ $�	�GA�BA̂A @� � � @ �A�"  ��@ B�LCB �   d� b  ��G@ GC�GÂ�� ��  @ �@ �C@�C���B  �@ �� ���C @ 䃀JC�)�  ���& �    _envConnectMapipairsOffset8              _PosIndexAddOffsetBoardPosCanMoveBoardPosPiecesCanMatchPieceType _Offset2Index_CalcOppositeDir         2                                                                               !  !  !  !  "  #  #  #  $      (     self    2   	posIndex    2   
pieceType    2   ct   2   (for generator)   1   (for state)   1   (for control)   1   _   /   offset   /   i
   /   j
   /   surroundIndex   /   surroundPiece   /   surround_ct   /   dir*   /   oppDir.   /      _ENV +  1      � � �@@�@  ��@  �  & �                                     ,  ,  -  -  .  0  1     self       dir       r           3  :      K   � @ �@@̀@ @ 䀀� L�@ ��A BA@� � dA f  & �    _env
PlayerPos_Pos2Index	_Search8
PieceTypeAny            4  5  5  6  6  6  7  8  8  8  8  8  8  8  9  :     self       connectMap      
playerPos      playerPosIndex      isFirstStep         _ENV <  m   j   GA�b    �& � G@ LA���  d���@ �A@�  ����  ��� A FBA $ �G�A��A�B @� � � DB �B�"  @����� ��$�  C��GDB GD�Gă"   ������ �    �@ 	��C  �@ �� �  ���D �DD	��  �@ ��D  �@ �� ��	��D  �@����D����E �DE	�DB Ǆ�	��  ��� ��F �����E �D�	  	FD GE�
䄀�D  ���E �D�	  	@ 䄀�  ��@ ̄D @�� � ���	��D @������D�)�  ��& �    _worldGetService	UtilDataBoardLogicipairsOffset8              _PosIndexAddOffset_envBoardPosCanMove"IsPosBlockMoveForTrapWallPosIndex BoardPosPiecesGetMapForFirstChainPathCanMatchPieceType
PieceTypeAny_Offset2Index	_Search8tablecountMapByPosition        GetPieceTypeMapListByPosIndexintable         j   =  =  =  >  B  B  B  B  D  D  D  D  F  G  I  I  I  I  J  J  K  K  K  K  L  L  L  L  L  N  N  N  N  O  O  P  P  P  Q  Q  R  R  S  S  T  X  X  X  X  X  X  Y  Y  Y  Y  Z  \  \  \  \  \  ]  ]  ]  ]  ]  ]  ^  ^  ^  ^  ^  ^  ^  `  `  `  b  b  b  b  b  b  b  b  c  c  c  c  c  d  d  e  f  f  f  f  f  g  g  g  g  g  I  I  m     self    j   	posIndex    j   
pieceType    j   connectMap    j   isFirstStep    j   	utilData   j   boardServiceLogic   j   ct   j   (for generator)   i   (for state)   i   (for control)   i   _   g   offset   g   i   g   j   g   surroundIndex   g   isBlockMoveWithTrapWall!   g   surroundPiece&   g   mapForFirstChainPath*   -   gridPieceTypeMapListM   g      _ENV o  �   .   G @ G@� � @ ��@��@ @ 䀀  A � �  ,  �  �@�$B ��A �BA ��A�  � ��� �B    �� �BA �B� �����BA ǂ�ǂ�  �@ ��BA G���C �B�� @ �� � �B�f & �    _envConnectMap
PlayerPos_Pos2Index        BattleConstAutoFightMoveEnhanced              AutoFightPathLengthCutPosNum"AutoFightPathLengthCutConnectRateAutoFightPathLengthCutLogdebug6[AutoFight] _CalcHighConnectRateCutLen() totalPosNum= ConnectRate=         |  �   	    @ E � M@� I � F  �@  ��  A  ����A� �   ����A���Ɓ �A  � ��   �A ���& �                            }  ~  ~  ~    �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     	posIndex       ct      (for index)      (for limit)      (for step)      i	      nextIdx
         	touchIdxtotalPosNumconnectMaptotalConnectsearch.   s  s  t  t  u  u  u  w  x  y  {  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    .   connectMap   .   
playerPos   .   playerPosIndex   .   	touchIdx   .   totalConnect	   .   totalPosNum
   .   search   .   rate   .   cutlen   .   idx   .      _ENV �  �   	   G @ L@� d� ��� �� ��@� �  & �    _worldGetBoardEntityBoardGetMapByPosition        	   �  �  �  �  �  �  �  �  �     self    	   boardEntity   	   boardComponent   	   mapByPosition   	        �  �      G @ f  & �    _env           �  �  �     self           U               %      (   1   (   3   5   3   7   9   7   ;   =   ;   ?   A   ?   C   F   C   H   O   H   Q   _   Q   a   n   a   p   �   p   �   �   �   �   �   �   �   .  �   0  m  0  o  �  o  �  �  �  �  �  �  �  �  �          (    +  1  +  3  :  3  <  m  <  o  �  o  �  �  �  �  �  �  �         _ENV