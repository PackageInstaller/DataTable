LuaS �

xV           (w@a@../PublishResources/lua/product/core_game/logic/svc/skill_handler/calc_summon_multiple_trap.lua         !    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ ��  
�B�
@C� ���C A@ �@B $@�& �    _class#SkillEffectCalc_SummonMultipleTrapObjectConstructorDoSkillEffectCalculatorIsPosHasBlockTrapSortValidPiecePos"_SortValidPiecePosByRingFarToNear"_SortValidPiecePosByColorPrioritySummonMultipleTrapSortTypeRingFarToNear       ByColorPriority       _enum                  
@ �� @ ��@�  ���
���& �    _world_skillEffectServiceGetServiceSkillEffectCalc           
                        self       world                  0�  � � �@@� �@$� L�@d� bA  @ �G� \��AA�� ́A� �A$� LBd� �BB�� ̂B� �B$� LCd� �CC�� ̃C� �C$� LDd� �DD ��D	"D  @ �b    ��� �E� �   ��DE ̄�	A� 䄀�	$� @ 
E�	$E �DE ̄�	A� 䄀EE �E
�� $��GEE L��
� d���EE ��EF ����EE ̅�� ���� H$� _@H��GFE L��d� L��d� ���� �FI�� ̆I� ����  J� �  �  � �  ��@�K  �� ���@ �@�@��FJ �� ���̇J@ 䇀ȇ"   ��J K@�� $H���  *��b  ���  �FJ  ����H�
���  	 	@	�$� "  ���K ��� $� "H   ��J K@ ��$H��  j��@ "   ��FE ��E� ����  GJ @�$@�L�K� d��b   �F�J G���� dH�)�  ����  ��  �@��  �FE ̆�A 䆀�   �GJ @ $��L�� d���� ��� ���J �HL�  	��H�)�  ���  K  �GJ ��� ���J ǈ� 	 @	 䈀�H   ���J �� 	�@	 �H���J �� 	 @	 �H���  *�@��  �����D���  ��� ��GE ��E� ����M� H�	�� ��$� G���M��M ��FIN G����N �	O� I�$I � \	��� (���O �O@
��
 �ʉ �$J�'��	�$� A� �	 �� h	�LJ��
 d��L��d� �J�
 �@ �� �
  @���J �
K�
� ��J�  �gI�"  ���GE ��E� ����M@�䇀��D ��P� ��$� � @��� �Q� HQ$� �   �F�Q L�d� ��� 	�@	 �� �HE ̈�A� 䈀	�$� LIR�	� 
 G�� �
� ��R �
��J� ��R �J��S IG�� d����S�� �IE ̉�A� 䉀JJ @
�$
��L�� d���K�    ���M)�  ���JT$� "J    � 
 F�T G���
 �
 d����K  �   ��  b  @ ���	  ��H�	��IU$� "	  ��b	  @��	 �	�	 
 @
��� � ͈��	� � ��	� ���@��	 �	�	� \
��� ��J ǉ� 
�@
 䉀�J 
K@
���U �
N  @��V� �
  $J  ����M���HV  	�@	���� �	 �� �HJ  	 �@�
�a � ��J 
K@
���U �
N  @��V� �
  $J  �  j��f & � Z   skillEffectParamGetSelectedColorTable
GetTrapIDGetMaxCountskillRange	IsRandomGetAbsPosArrayIsEmptyPosOnlyIsUseBoardRandomGetBlockSummonTrapTypeGetSortValidPosTypeIsEmptyOrTrapGetFindPosTrapIdGetExcludeTrapsIsFindRandEmptyPosIfNoValidIgnoreBlockGetIgnoreAbyss
BlockFlagSummonTrap        IsUseTetrisFeatureCount_worldGetServiceFeatureLogicGetTetrisMainColorCountClearTetrisMainColorCountRandomLogicBoardLogic
TrapLogic	UtilDataGetBoardEntityBoardGetTeamLeaderElement PlayerGetCurrentTeamEntityTeamGetTeamLeaderEntityElementGetPrimaryTypeipairsFindPieceElementtableinsertCanSummonTrapOnPosIsPosHasBlockTrap#IsPosEmptyExceptConveyorNoDeadMarkFindTrapPosByTrapIDappendArray
icontainsUtilScopeCalcGetEmptyPieces
LogicRand       SortedArrayNew
AlgorithmCOMPARE_CUSTOMAiSortByDistance_ComparerByNearAllowDuplicate
AINewNodeInsertSortedArraySizeGetAtGetPosDataGetTrapPiecesExceptTrapIDGetAdditionalCountScopeTypeGetAdditionalCountScopeParamSkillScopeParamParserParseScopeParamGetSkillScopeCalcComputeScopeRange
centerPosVector2zeroupSkillTargetTypeGetAdditionalCountElementDicGetPieceTypeGetMaxAdditionalCountmathminBoardLogicRandGetRandCountremoveSkillSummonTrapEffectResultIsTransferDisabledSortValidPiecePos         �                                                                               !   !   "   "   #   #   %   %   &   &   '   '   (   (   (   (   )   ,   ,   ,   ,   .   .   .   .   /   /   /   0   0   4   4   4   4   7   7   7   7   9   9   9   9   ;   ;   ;   ;   >   >   >   >   >   A   A   B   B   C   C   C   C   C   D   D   D   D   F   F   F   F   G   G   H   H   I   I   K   O   P   P   P   Q   Q   S   S   S   S   T   T   T   U   U   U   V   V   V   V   V   S   S   Y   Y   Z   [   [   [   [   \   \   \   \   \   \   \   \   ]   ]   ]   ]   ]   ]   ^   ^   ^   ^   ^   [   [   b   f   f   h   h   h   h   i   j   j   j   j   k   k   k   k   k   l   l   l   l   l   j   j   p   p   p   q   u   x   x   x   x   y   y   z   z   z   z   {   {   {   |   |   |   }   }   }   }   }   z   z   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �        p   self    �  skillEffectCalcParam    �  summonMultipleTrapParam   �  	colorDic   �  trapID   �  	maxCount   �  randomSummon   �  absPosArray   �  isEmptyPosOnly   �  useBoardRandom   �  blockSummonTrapType   �  sortValidPosType   �  findPosEmptyOrTrap   �  findPosTrapId   �  excludeTraps   �  bFindRandEmptyPosIfNoValid   �  ignoreBlock!   �  ignoreAbyss#   �  
blockFlag%   �  featureSvcL2   7   
randomSvc;   �  boardServiceLogic?   �  trapServiceLogicC   �  	utilDataG   �  
boardCmptL   �  teamLeaderElementN   �  teamEntityU   d   teamLeaderY   d   element]   d   validPosArraye   �  (for generator)m   {   (for state)m   {   (for control)m   {   _n   y   gridPosn   y   checkPosTypeq   y   _validPosArray~   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   gridPos�   �   	boardsvc�   �   t�   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   gridPos�   �   excludePosList�   �  trapSvc�   �  (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   excludeTrapID�   �   trapPosList�   �   oriValidPosArray�   �  tmpPosList�   �  (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   pos�   �   utilScopeSvc�   &  pieces�   &  r�   &  dropPos�   &  
centerPos�   &  	listArea   &  (for index)    (for limit)    (for step)    i    posSize  &  (for index)  &  (for limit)  &  (for step)  &  i  %  nearestPos  %  utilScopeSvc,  8  pieces/  8  additionalCount9  �  
scopeType;  �  rawScopeParam=  �  parserB  x  scopeParamF  x  utilScopeSvcJ  x  
calcScopeL  x  additionalCountScopeResultZ  x  elementDic\  x  blsvc`  x  (for generator)c  m  (for state)c  m  (for control)c  m  _d  k  
v2GridPosd  k  
pieceTypeg  k  maxAdditionalCountr  x  summonTrapResultArrayy  �  randomFunc|  �  
randCount�  �  minRandCount�  �  maxRandCount�  �  randIdx�  �  gridPos�  �  sortedValidPosArray�  �  (for generator)�  �  (for state)�  �  (for control)�  �  _�  �  gridPos�  �     _ENV      1   �@  @ ��   �  � @ �@�A�  䀀���� $��"A  @ �C  f L��� d����@A@ ��  � ��A ��� ���A� �$� FCB G��� � d��b  @�L��d� b  @ �C� f ��  *��  � & �    _worldGetService	UtilDataIsValidPiecePosGetTrapsAtPos        ipairsTrapGetTrapTypetable
icontainsIsBlockSummon         1           	  	  	  	                                                                                       self    1   pos    1   blockSummonTrapType    1   utilSvc   1   isValidPos   1   samePosTraps   1   (for generator)   .   (for state)   .   (for control)   .   _   ,   e   ,   	trapCmpt   ,   type   ,      _ENV !  *   
   F@ GA�@� ��L�@ �  �@ d��f @�F@ G��@� @�LA �  �@ d��f �  & �    SummonMultipleTrapSortTypeRingFarToNear"_SortValidPiecePosByRingFarToNearByColorPriority"_SortValidPiecePosByColorPriority            "  "  "  "  #  #  #  #  #  $  $  %  %  %  %  &  &  &  &  &  '  )  *     self       type       array       
centerPos       summonMultipleTrapParam       t	   
   t         _ENV ,  X   X     K  �@ �� � 	��B@ ǂ��@G�@C� C@ �@GA�AN��$� FC@ GC���� d��N���C�C  @���  �  �Ã��C�
���CB ǃ� �@ �C��CB ��B�C���  �C���  *��AB ��B��,  �A��  �C �A�A� 䁀@ @�$ �FCB G����Ad� ��A� ��   A� �����A� � � ńG��JC�	J	��
C���CB ǃ�  @��C�)�  ��� & �    ipairsmathabsxymax       arrayringtableinsertsort_worldGetServiceRandomLogic
cloneconf
LogicRand	shuffledappendArray         A  D      � @ � � `��  ��@  � � �  & �    ring           C  C  C  C  C  C  C  D     a       b           X   -  .  1  1  1  1  2  2  2  2  2  2  3  3  3  3  3  3  4  4  4  4  4  4  5  5  5  6  7  7  8  :  ;  ;  ;  ;  ;  =  =  =  =  =  =  1  1  A  A  A  D  A  F  I  I  I  I  K  K  K  K  L  L  L  L  M  M  N  N  N  N  O  O  O  O  P  P  P  P  N  R  T  T  T  T  T  K  K  W  X     self    X   array    X   
centerPos    X   summonMultipleTrapParam    X   dicPosByRing   X   tablePosByRing   X   (for generator)   -   (for state)   -   (for control)   -   _   +   
candidate   +   disX   +   disY   +   disRingCount   +   t   %   t3   X   
randomSvc7   X   (for generator):   V   (for state):   V   (for control):   V   _;   T   data;   T   	shuffled?   T   maxnA   T   (for index)D   N   (for limit)D   N   (for step)D   N   iE   M   randI   M      _ENV Y  �   U   �$� "  ��GA@ L����  d���  �  A @� $ �LC�� d���C�  ��ǃ�C  @�˃    ��ʃ����B DB@���$D��B �C���A@ �C�)�  ��B �B@��  $B�  GB@ L���� d���A ��� ��B ���A� �A AD � �D h��L���E   d� �E����Å
ʃ
g���Ã�FB G�� ��dD���  *�& f  & �    GetColorPriorityDic_worldGetService	UtilDataipairsFindPieceElementarray	prioritytableinsertsortRandomLogic
cloneconf       
LogicRand	shuffledappendArray         q  s      � @ � � `��  ��@  � � �  & �    	priority           r  r  r  r  r  r  r  s     a       b           U   [  [  \  \  ^  ^  ^  ^  _  `  a  a  a  a  b  b  b  c  d  d  e  e  e  f  g  g  h  j  k  k  k  k  k  m  m  m  m  m  m  a  a  q  q  q  s  q  t  w  w  w  w  y  y  y  y  z  z  z  z  {  {  |  |  |  |  }  }  }  }  ~  ~  ~  ~  |  �  �  �  �  �  �  y  y  �  �  �     self    U   array    U   
centerPos    U   summonMultipleTrapParam    U   colorPriorityDic   U   	utilData   S   dicPosByPriority	   S   tablePosByPriority
   S   (for generator)   )   (for state)   )   (for control)   )   _   '   gridPos   '   posPieceType   '   piecePriority   '   t   !   t/   S   
randomSvc3   S   (for generator)6   R   (for state)6   R   (for control)6   R   _7   P   data7   P   	shuffled;   P   maxn=   P   (for index)@   J   (for limit)@   J   (for step)@   J   iA   I   randE   I      _ENV!                                            !  *  !  ,  X  ,  Y  �  Y  �  �  �  �  �  �  �  �  �         _ENV