LuaS �

xV           (w@[@../PublishResources/lua/product/core_game/logic/svc/skill_handler/calc_multi_traction.lua         F    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ � @ A� ��@ $@��A  ���A l  
@���A l@ 
@ � @ A@ ��@ $@�@B  ��@B l� 
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
@��& �    _class5SkillEffectCalc_MultiTraction_SingleTargetPossessionObjectConstructorSetTriggerTrapsGetTriggerTrapsGetTargetEntityID/SkillEffectCalc_MultiTraction_GridPossessorMapMarkPossessInfoSkillEffectCalc_MultiTraction_Log_NewPieceBlockBlackboardDoSkillEffectCalculator _SaveTargetEntityTractionResult_DoSingleTractionIsPosFitFullBodyAreaGetFirstObstacleInPathCutOutMaxStepRangeForSingleCheckApproachPathForMaxStep_PetANaTuoLiFindTractionCenter                  
@ �
���
� �
 ��& �    	entityIDpath	finalPos	beginPos                             self       	entityID       path       	finalPos       	beginPos                      
@ �& �    _triggerTraps                    self       triggerTraps                      G @ f  & �    _triggerTraps                       self                      G @ f  & �    	entityID                       self            !   %       K   
@ �K   
@��K   
@ �& �    allarraydimensionMap           "   "   #   #   $   $   %      self            *   O    :   @$� LA@d� ��@ b  ������  \�� (��ÂC GCA��A�C�C  @ ��  ����C���A ��DB @ �C�'��@��A� �� G�bB  @ �K  �A�G�JF�A G��BB �� dB���A ���B F�B L��  �@� �CC� d  �A  & �    GetID	BodyAreadimensionMapGetArea       xytableinsertallarray5SkillEffectCalc_MultiTraction_SingleTargetPossessionNewGetGridPosition         :   +   +   ,   ,   .   0   0   1   1   2   2   2   2   3   3   4   5   6   6   6   7   7   9   9   :   :   :   :   :   2   ;   =   >   ?   ?   ?   @   @   B   B   C   C   C   C   C   F   F   G   H   H   I   J   K   L   L   H   F   O      self    :   pos    :   entity    :   path    :   	entityID   :   bodyAreaComponent   :   dimensionMap   :   
areaArray	      (for index)      (for limit)      (for step)      i      absoluteAreaPos      absX      absY      absX    -   absY!   -      _ENV T   \       
@ �� @ ��@�  ���
���
@A�& �    _world_configServiceGetServiceConfig	_logFlag           V   Y   Y   Y   Y   Y   [   \      self       world            ^   e      � @ �@    �& � b   � ��@� �� �@    ���  ��@ � �AA @ �� �  �@  & �    	_logFlagGetIDnilLognotice_className:             _   _   _   `   c   c   c   c   c   c   c   d   d   d   d   d   d   d   e      self       entity       eid         _ENV g   o       @ A@��  $��L�@� d���@  ���� ����A� ����A� FB GB��B ��BU���B ��BU���A f & �    _worldGetService	UtilDataCreatePieceBlockBlackboardxy	AddBlock��������
BlockFlagMonsterLandMonsterFly	LinkLine            i   i   i   i   j   j   j   k   k   l   l   l   l   l   l   l   l   l   l   l   l   l   l   l   n   o      self       
centerPos       
targetIDs       canMoveToCenter       	utilData      blackboard         _ENV r   �   .]  � � �@@� �   ���@ @�$� G�@ L��A� d������� �   ���A� _ �  �& � AB �B$� 
 ��@ A�A� $��L�Bd� L�d� �A��� �  �C$� "  ��F�@ � d� ��@ �AC� ���̂A� �   ���$� @  ��� G�@ L��� d����@ ��CC ���̂D� � �  �  �D$� FE GD�@��L�Ed� b  � �L�Ed� �� %�LFd� b  ���C� �C  @#�L�Fd� ��@"�L�Fd� ��@!�FE G��@@�LGd� �  b  @ ��D� � �̄F� ��	� 	 @�	  �& � ǄG	  b  @ ��� � �LHd�  �
LEH � 
 �	d� ��
L�Hd� b  @�b  @���H�� �  ����A� ������ @���A�� �  @���A� ��@��� ��FE G�@��G�@ LD�d� L��d� ����� ���� ��	� �@ EJ
��@ ��J��J$��FK �EK
� d ������� �F  ������� ��K�� �@ � �@ �i�  �E�"C    �& � L�Ed� � � 	 �
�E @ �L ��B  ����ELF�L G��� ��G���ǚ�FG���Ǜ�   	@�
�F  �	� �$� LFH �   	d� ���� LDN��  C� d��
@�GN ��N ��N	��  ��D� J�	G�� �� ��@ ���	AE 䄀��	� 	$��"  � �L�O
d� bE  @ �FP GE�
��P�� �    �@ ��@ ���A� 䅀Q$� �A   M�G�@ LF�d� �FQ ��Q����D� ��Q� �  ����@ �F�� ̆�� @� ��R� �F�� @�̆�� ���� ����E� S GS@���$��"  �C�  FS G��� ��S� dG  D  �  ���R�� �GR�� @ �S ��S� ��$ �G  �GT  �@ � ���
���K � �@���@ ��@	 䈀��$� L�T �	�  
�@
 �
��
   dI ��  *���7�FP G��@�
��G�@ LF�d� L��d� ����� �S �F� �@ 䆀�   3��FT @��  ���� �G  � 䆀
��̆T @� ���  �@ �F��.�FP G�@�
@�FFU L��ƆL ǆ� �@���d� ��U ��B�@ ����V@ �P �U��  K  䆀GT ����  $��
 �K @�$ �G�@ L�� d������� ̈T @	� �	��	  
�@
 �H�)�  ��@"�K  �FU ��B�L �U@������� ��U ̆�G�@ 䆀  �  @�K  ��S� kG   � �L�� P HV@ �  �  d�� �D  �   ��R�� �   ��R�� �GR�� @ ��V�� �  @���@ �GI�� ��I�� @ �S ��S� ��$ �G  �K � �  �J�V��  *��W �C� �� �  K @ $ �GIWL��d� GI�bI  @�L�W �IW� dI GIWL��d� �	B �	X 
�GJW�
  �I� �F	S G���	��	 dI�)�  ���  ����$� K�  J�ذJH��J���S ��S�� 	��H�HT ���  	 $��
 �K @�$��GIWL��d� ��T  
� @
��
��JW  @ �I )�  ���FY L���B d���FY�� �  � �̆�@ �F�b  � ����@��F���@��F�f & � i   skillEffectParamGetEnableByPickNum	tonumber_worldGetEntityByIDcasterEntityIDActiveSkillPickUpComponentGetAllValidPickUpGridPosCount_gridPossessionMap/SkillEffectCalc_MultiTraction_GridPossessorMapNewSkillContextGetResultContainerGetScopeResultGetSkipTractionByPickNumGetService	UtilCalcUtilScopeCalc&GetBossANaTuoLiTractionMonsterClassIDGetTractionCenterTypeTractionCenterTypeNormalIsCasterCenteredGetGridPositionHasPetPstIDgridPosGetCenterPosPetANaTuoLiGetIsPreview              skillRangeGetAttackRange_PetANaTuoLiFindTractionCenterGetPetANaTuoLiCanTractionSelfPreviewPickUpComponentBossANaTuoLiPlayerGetLocalTeamEntity	BodyAreaGetArea	GetGroupBW_WEMatchers
MonsterIDipairsGetEntitiesHasDeadMarkGetMonsterClassIDSkillScopeCalculatorComputeScopeRangeSkillScopeTypePickupAngleFreeLine	noExtendinitdestuseCenterPosrangeByQuadrantGetBoardQuadrantsByCenterBoardQuadrantCenterskillIDConfigGetSkillConfigDataGetSkillTargetTypeSkillTargetTypeBoardGetSkillEffectTargetType	UtilDataGetCanMoveToCenter
MatchTypeMT_BlackFistHasTrapPetGetOwnerTeamEntityTeamGetEnemyTeamEntitytable
icontainsinsertGetID_pieceBlockBlackboard_NewPieceBlockBlackboard_DoSingleTractionGetPreviewTeamEntityMonsterAndChessPetSkillScopeResultNoneSkillScopeTargetSelectorDoSelectSkillTargetMonsterHasMonsterIDSortMonstersByPos
monster_e_Log$ Outside of skill range, skipping. MarkPossessInfodis�      posSkillEffectMultiTractionResultGetFinalDamageIncreaseRateSetDamageIncreaseRateSetReplaceScopeCenterPosSetTractionCenterPos         ]  t   u   u   v   v   w   w   w   y   y   y   y   {   {   |   |   }   }   ~   ~      �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                               	                                                                                                                 "  "  "  "  "  #  #  $  $  $  $  $  $  $  %  &  &  &  &  &  &  '  (  (  )  )  )  )  )  *  *  *  *  *  *  ,  ,  ,  ,  ,  ,  -  -  -  -  /  /  /  /  0  0  1  1  1  1  1  1  1  1  -  -  3  5  5  5  5  6  6  6  6  6  8  8  9  9  9  9  9  9  9  :  :  :  :  :  :  :  :  :  ;  ;  ;  ;  ;  ;  ;  <  =  =  =  =  >  >  >  >  >  >  >  >  ?  ?  ?  ?  A  A  A  A  A  A  A  A  C  C  C  C  C  C  D  D  D  D  F  F  F  F  G  G  H  H  H  H  H  H  H  D  D  I  K  N  N  N  N  N  N  N  N  O  O  O  O  P  Q  Q  R  R  R  R  R  R  T  T  T  T  T  T  T  T  T  W  X  X  Y  Y  Y  Y  Z  Z  Z  Z  Z  \  \  \  \  ]  ]  ]  ]  ]  ]  `  `  `  `  `  `  b  b  b  b  c  b  b  f  f  f  f  g  j  j  j  j  k  k  k  k  k  k  l  l  l  l  m  m  m  n  n  n  n  n  n  n  p  p  p  p  p  j  j  s  s  t  t  u  u  u  u  v  v  v  v  v  z  z  z  z  z  z  }  }  }  }  ~  ~  ~                  }  }  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  l   self    ]  skillEffectCalcParam    ]  tractionParam   ]  enableByPickNum   ]  	checkNum      	attacker      
component      curPickNum      casterEntity   ]  skillEffectResultContainer!   ]  scopeResult#   ]  skipTractionCalc$   ]  skipTractionByPickNum&   ]  	checkNum+   8   	attacker/   8   
component1   8   curPickNum5   8   utilCalcSvc<   ]  utilScopeSvc@   ]  #bossANaTuoLiTractionMonsterClassIDB   ]  bossANaTuoLiTractionMonsterC   ]  "bossANaTuoLiReplaceScopeCenterPosC   ]  includeCasterTeamD   ]  
centerPosE   ]  tractionCenterTypeG   ]  isCfgPreviewh   �   scopeCenterPosi   �   mainPosu   �   scopeRangev   �   petANaTuoLiCanTractionSelf�   �   
component�   �   curPickNum�   �   
component�   �   curPickNum�   �   teamEntity�   �   teamPos�   �   teamBodyArea�   �   monsterGroup�   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   e�   �   monsterClassID�   �   targetMonsterPos�   �   
scopeCalc�   �   scopeResult�   �   scopeRange�   �   attackPosArray�   ]  skillID�   ]  configService�   ]  skillConfig�   ]  targetType  ]  overrideTargetType  ]  	utilData  ]  canMoveToCenter  ]  teamEntity  h  
enemyTeam  h  v2PosTL2  h  
targetIDs:  h  casterTeamEntityA  h  (for generator)W  h  (for state)W  h  (for control)W  h  _X  f  	targetIDX  f  targetEntity\  f  gridPos^  f  teamEntityr  �  v2PosTLt  �  scope�  �  	selector�  �  
targetIDs�  �  (for generator)�  �  (for state)�  �  (for control)�  �  _�  �  	targetID�  �  targetEntity�  �  gridPos�  �  targetEntityIDMap�  H  scope�  H  	selector�  H  
targetIDs�  H  casterTeamEntity�  H  (for generator)�     (for state)�     (for control)�     _�  �  id�  �  monsterDisList  H  validMonsterDisList  H  (for generator)  $  (for state)  $  (for control)  $  _	  "  monsterDisInfo	  "  gridPos    
casterPos(  1  casterFakeInfo,  1  (for generator):  H  (for state):  H  (for control):  H  _;  F  monsterDisInfo;  F  gridPos>  F  resultL  ]  damageIncreaseRateN  ]     _ENV �  �   4   @ A@� ��  �$A��� $� �@$� FA � d���B�BA �A���   ��BA �A���A���  @��BA �A���A����LC� d� ��� �� ��B� �B  ���C �B��C A� �D � � �B  i�  ��& �    _gridPossessionMapMarkPossessInfo	BodyAreaGetAreaipairs_pieceBlockBlackboardxy	AddBlockGetID
BlockFlagGetBlockFlagLogerror_className out of board pos: 	tostring         4   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    4   targetEntity    4   	finalPos    4   path    4   
areaArray
   4   (for generator)   3   (for state)   3   (for control)   3   _   1   v2RelativeBody   1   v2   1      _ENV �  l   *�  �@� �A�� �� L�@d� �A�� �B  @��BA ��A� ����B@ 䂀�B   ��BB @ �� ��B� �B  �C @ ���  �B�& � ���BC�� �  ���BA ��A� �����C� D$� CD$� L��� d��b  ��LCB � � L�Bd dC  LC �  �K  dC�& � �BA ��A� ����E@ 䂀�  ���BB @ �C ��B� �B  �C @ ���  �B�& � �BA ��A� �����E@�� �����  �F  ��@�E�	FEF G��
� � 
dE��  j��bB  ��!��@��CB @ � �C �C @ ���  �C�& � �CG@ � � DB � ��  �$D��G�H ��	� ��$��b   �FDF G��� � dD�G�� �D���  ������H @ � 	�   �  �	�DA ̄�	A	 䄀E�	� $��F�I G��
@
��GEA L�
d� �J �EJ��
 �F�I G��
��I ��J��
N� �  �F   � ��J ���   
@ ���  	�$��"  @	�N���K �@ �� �GK Ǉ���
� HK �KG��$� a�  ��G  �� HK �KG�
$� FHK G����d� a �  �H  � �  ��"   �FHF G��� ��dH��  j��  � �� ��@��EB @ �F �E �C @ ���  �E�& � ƅL ���@ � � �FLK�   d� �FF �M��  ����FB   AG � ��  �A� � �F �F   ��
�K��� $�  @@�GHB � �  	 A� �	���  
 dH  �@ FHF G�����d������FHF G�����d�� @��� �@ ���HB � 	 @	 �� �	�� @
 �H �  j���FN@ � � �N ���   	$ǀ �� �N ���   
@ ���  	�$ǀ�  "  ����� ����ȇL�J �  	 @	 
�	 �	� 
 @
�d��bH  � ������  �@�Ƈ� @��� (�IF �F@	 �Ɉ$I�'H�  ���� ��@��C @ ���  �G�& � �  F @ $@�NI�IF ��F�	� 
��I�)�  ���H\� @����GHA L��� d���H� 	�@	 �� � ��ȈLC �  	 @	�dH�& � >   	BodyAreaGetAreaskillEffectParamGetCanMoveToCenterGetForceMove_worldGetService
BuffLogicCheckCanBeHitBack_Logtarget cannot move: GetID _SaveTargetEntityTractionResultHasMonsterIDConfigGetMonsterConfigData
MonsterIDGetMonsterIDIsBosstarget is boss, cannot move: CheckForceMoveImmunity+target is ForceMoveImmunity, cannot move: 	UtilCalcGetGridRingNumWithBodyAreaipairstableinsert        already in 1st ring, skipping. GetPosQuadranttarget quadrant: GetGridsByRingrangeByQuadrantGetMaxMoveStep        CutOutMaxStepRangeForSingleBoardLogicGetEntityMoveBlockFlag
BlockFlag	LinkLine
MatchTypeMT_BlackFistMonsterLandIsPosFitFullBodyAreaGetGridRingNummathabsxy+no candidate in acceptable range, skippingHelperProxySortPosByCenterPosDistanceikeyfirst target:  ring:  disIndex: new target: GetGridPathByVectorLerpCheckApproachPathForMaxStepGetFirstObstacleInPath	UtilData'CalcMovePathBlockForTrapWallWithEntity         �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                                                            	  	  	  	            �  �                                                                                            !  !  !  !  #  #  $  $  $  $  $  $  $  $  $  %  '  (  (  (  (  (  (  (  +  +  +  +  +  ,  ,  -  .  /  1  1  1  1  1  1  1  1  1        7  7  7  7  9  9  9  9  9  9  9  :  :  :  :  :  :  :  :  :  ;  <  <  >  A  A  B  C  C  C  C  C  C  C  C  C  E  E  F  F  G  I  L  M  M  M  M  N  N  N  N  N  M  O  Q  T  T  T  V  V  V  V  V  W  Z  [  [  [  [  \  ]  ]  ]  ]  ]  [  [  _  b  b  b  d  d  d  d  e  e  e  e  f  g  g  j  j  j  j  j  l  L   self    �  skillEffectCalcParam    �  center    �  currentPos    �  entity    �  casterEntity    �  includeCasterTeam    �  
areaArray   �  tractionParam   �  canMoveToCenter   �  	bufflsvc       cfgsvc)   @   monsterConfigData+   @   
monsterID/   @   	bufflsvcD   U   utilCalcSvcY   �  currentRingNum^   �  nearestPos^   �  	useOffV2^   �  bodyAreaByOff_   �  (for generator)b   k   (for state)b   k   (for control)b   k   indexc   i   valuec   i   newPosd   i   monsterQuadrant}   �  acceptableRange�   �  tractionParam�   �  maxStep�   �  	boardsvc�   �  	blockVal�   �  relativeCurrentPos�   �  candidates�   �  (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   gridPos�   �   fitFullBodyArea�   �   candidateRelativePos�   �   candidateRingNum�   �   isRelativeXLE�   �   isRelativeYLE�   �   sortedByDis�   �  	finalPos   �  currentFinalPosRingNum  �  currentFinalPosDisIndex	  �  (for generator)  C  (for state)  C  (for control)  C  _  A  pos  A  ringNum  A  	disIndex3  A  approachPathG  �  obstacledPosW  �  obstacleIndexW  �  
finalPathX  �  
lastIndex[  x  gridPos^  l  fitFullBodyAreag  l  (for index)q  x  (for limit)q  x  (for step)q  x  ir  w  finalPathNoOff�  �  (for generator)�  �  (for state)�  �  (for control)�  �  index�  �  value�  �  gridPos�  �  finalPosNoOff�  �  	utilData�  �  finalPathBlockForTrapWall�  �     _ENV r  �   �    � L@d� LB�d� "    �@ ���� �B@�� �  ��$� F�@ � d@��D�A �D�	 �@ 	�D�i�  ���D  ����  � ������ @ b  ����A �B�� �CB�� �@� �C�� �@$� F�@ ��d@��E�A �E� �@ �E�i�  �����@ ���@�̈́�B G��	E
"  ���B G��	E
G�	E
"E  @ �  & �B G��	E
G�	E
EC
$� � 
_�C
@ �  & � �  ��L��d� b  ��L�d� LE�
d� ��D�� ̅�
� �  �  L��d� b  ��G�A L�
d� LE�
d� ��D�� ̅�
� �  �  "   �FA G�
��� d��b  @ �C  f LEEd� L��
�� d����
 �	@�� ����  @ ��  � ��  *���� � & �    	BodyAreaGetAreaGetGridPositionipairstableinsert&GetBossANaTuoLiTractionMonsterClassID_worldPlayerGetLocalTeamEntity_pieceBlockBlackboardxy	GetBlock        HasPetPetGetOwnerTeamEntityGetIDHasMonsterIDintableGetOwnerWorldGetService	UtilDataIsPosBlockWithEntityRace         �   s  t  t  t  t  u  u  v  x  x  x  x  y  z  z  {  {  {  {  |  }  }  }  }  }  {  {  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  '   self    �   gridPos    �   entity    �   testBlockVal    �   bodyAreaByOff    �   casterEntity    �   includeCasterTeam    �   tractionParam    �   	checkPos   �   
areaArray   �   casterBodyAreaOff   �   casterBodyArea   �   
casterPos   �   (for generator)      (for state)      (for control)      _      area      workPos      #bossANaTuoLiTractionMonsterClassID   �   teamEntity)   ;   teamBodyAreaOff-   ;   teamPos/   ;   (for generator)2   ;   (for state)2   ;   (for control)2   ;   _3   9   area3   9   workPos4   9   (for generator)>   �   (for state)>   �   (for control)>   �   _?   �   v2RelativeBody?   �   v2@   �   checkCasterBodyArea[   �   teamEntitye   l   teamEntityu   |   	utilData�   �      _ENV �  �      @ @� $@�LC@ �   @�� ��  @�d��bC  � �@ ��f�)�  ���& �    ipairsIsPosFitFullBodyArea            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       approachPath       entity       testBlockVal       bodyAreaByOff       casterEntity       includeCasterTeam       tractionParam       (for generator)      (for state)      (for control)      index      v2         _ENV �  �      G@ LA���  d���   ��� �� !���@�A @� $��LC���  @ d��!�� ���A ��A�   �C�)�  �B�� & �    _worldGetService	UtilCalc        ipairsGetGridRingNumWithBodyAreatableinsert            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       	gridList       maxStep       center       	areaArry       utilCalcSvc      accpetRange      maxRing      (for generator)      (for state)      (for control)      index      value      	gridRing         _ENV �  �       � ���  FA@ �� d@����!� ���@ �A�  ��B�  �@ �i�  ���@  \� �@� @� � f�� � � @ &�& �            ipairs       tableinsert            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  
   self       approachPath       	finalPos       maxStep       
validPath      (for generator)      (for state)      (for control)      index      value         _ENV �  �   #   � @ �@�F�@ G���A �AA� ��$A � \� �� (��B BB@�� �  �$B�'����$� F�B G���A�ACd� ��� ������C� � & �    SortedArrayNew
AlgorithmCOMPARE_CUSTOMAiSortByDistance_ComparerByNearAllowDuplicate       
AINewNodeInsertSortedArraySizemathfloor       GetAtGetPosData         #   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    #   skillRangePos    #   castPos    #   sortPosList   #   (for index)      (for limit)      (for step)      i      totalCount   #   centerIndex   #   centerElement   #   
centerPos!   #      _ENVF                                                                             !   %   !   *   O   *   R   R   R   R   S   S   T   \   T   ^   e   ^   g   o   g   r   �  r   �  �  �  �  l  �  r  �  r  �  �  �  �  �  �  �  �  �  �  �  �  �         _ENV