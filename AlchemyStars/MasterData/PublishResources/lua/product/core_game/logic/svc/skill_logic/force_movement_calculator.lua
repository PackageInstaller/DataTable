LuaS �

xV           (w@_@../PublishResources/lua/product/core_game/logic/svc/skill_logic/force_movement_calculator.lua         7    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@A l�  
@ �@A l�  
@��@A l  
@ �@A l@ 
@��@A l� 
@ �@A l� 
@��@A l  
@ �@A l@ 
@��@A l� 
@ ��C l� 
@ ��C l  
@���C l@ 
@ ��C l� 
@���C l� 
@ �& �    _classForceMovementCalculatorObjectConstructorGetEntitySortFunctionByDirForceMovementCalculatorSortEntityByDir_LTSortEntityByDir_RTSortEntityByDir_LBSortEntityByDir_RBSortEntityByDir_LeftSortEntityByDir_RightSortEntityByDir_TopSortEntityByDir_Bottom
CalculateForceMovementCalculatorIsEntityTarget_NewPieceBlockBlackboardIsPosFitFullBodyArea_ReCalcMoveDirByTargetAndPickCalcTargetForceMovementStep                  
@ �& �    _world                    self       world               %    P   G @  @� ��G�@  @��� �F�@ G � f   �G @ @� ��G�@  @��� �F�@ G@� f  ��G @  @����G�@  @��� �F�@ G�� f   �G @  @� ��G�@ @� � �F�@ G�� f  �	�G @  @����G�@ @� � �F�@ G � f   �G @  @� ��G�@  @� � �F�@ G@� f  ��G @ @� ��G�@  @� � �F�@ G�� f   �G @  @��@�G�@  @� � �F�@ G�� f  & �    x        yForceMovementCalculatorSortEntityByDir_LTSortEntityByDir_TopSortEntityByDir_RTSortEntityByDir_LeftSortEntityByDir_RightSortEntityByDir_LBSortEntityByDir_BottomSortEntityByDir_RB         P                                                                                                                                                                                                               !   !   !   !   "   "   "   "   "   "   #   #   #   %      dir    P      _ENV )   3        � @ �� � � � A@ �@�@� $��LAAd� ��A ��A�  ����ƁA �A�  @ 䁀�A BB@�� $��`�  ��A  �� � & � 
   GetGridPositionself_worldGetServiceBoardLogicGetCurBoardMaxYVector2New       	Distance             *   *   +   +   .   .   .   .   .   /   /   1   1   1   1   1   2   2   2   2   2   2   2   2   2   2   2   2   2   2   2   3      left        right        
v2LeftPos       v2RightPos       boardServiceLogic	       
boardMaxY       
v2SortPov          _ENV 7   A    "   � @ �� � � � A@ �@�@� $��LAAd� ��A�� ��A �� �@ 䁀�A BB@ ��$��F�A GB�����d��` �  �B  � & & � 
   GetGridPositionself_worldGetServiceBoardLogicGetCurBoardMaxXGetCurBoardMaxYVector2New	Distance         "   8   8   9   9   <   <   <   <   <   =   =   >   >   ?   ?   ?   ?   ?   @   @   @   @   @   @   @   @   @   @   @   @   @   @   @   A      left    "   right    "   
v2LeftPos   "   v2RightPos   "   boardServiceLogic	   "   
boardMaxX   "   
boardMaxY   "   
v2SortPov   "      _ENV E   K    	   � @ �� � � � A@ �@A�  ��  $��FA@ G�� � d���A@ �A��  ���`@  �CA  C� f & �    GetGridPositionVector2New       	Distance            F   F   G   G   I   I   I   I   I   J   J   J   J   J   J   J   J   J   J   J   J   J   J   J   K      left       right       
v2LeftPos      v2RightPos      
v2SortPov	         _ENV O   X        � @ �� � � � A@ �@�@� $��LAAd� ��A ��A�� ���ƁA �A�  @ 䁀�A BB@�� $��`�  ��A  �� � & � 
   GetGridPositionself_worldGetServiceBoardLogicGetCurBoardMaxXVector2New       	Distance             P   P   Q   Q   S   S   S   S   S   T   T   V   V   V   V   V   W   W   W   W   W   W   W   W   W   W   W   W   W   W   W   X      left        right        
v2LeftPos       v2RightPos       boardServiceLogic	       
boardMaxX       
v2SortPov          _ENV \   e       � @ �� � � � A@GA�_@��A@GA�` �  �A  � & ���@G��` �  �A  � & & �    GetGridPositionxy           ]   ]   ^   ^   `   `   `   `   a   a   a   a   a   a   a   a   c   c   c   c   c   c   c   e      left       right       
v2LeftPos      v2RightPos           i   r       � @ �� � � � A@GA�_@��A@GA�`@  �A  � & ���@G��` �  �A  � & & �    GetGridPositionxy           j   j   k   k   m   m   m   m   n   n   n   n   n   n   n   n   p   p   p   p   p   p   p   r      left       right       
v2LeftPos      v2RightPos           v          � @ �� � � � A@GA�_@��A@GA�`@  �A  � & ���@G��` �  �A  � & & �    GetGridPositionyx           w   w   x   x   z   z   z   z   {   {   {   {   {   {   {   {   }   }   }   }   }   }   }         left       right       
v2LeftPos      v2RightPos           �   �       � @ �� � � � A@GA�_@��A@GA�` �  �A  � & ���@G��` �  �A  � & & �    GetGridPositionyx           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      left       right       
v2LeftPos      v2RightPos           �   V   4�  � � � �@  @�A@ �@G�@ � $A�& � A�$� \ ��@�FA@ G����@ �� dA�& � L� d� �AB�     ��� �GAB��B�� ��L�� d� L�d� �B��� ̂C� �C$� LDd� �  �CD  �����D �D
��	$��LE � 
  @�d��b   �FEE G��
� � 
dE��  jD���E ��@ �
B� ���E ��  �
Ƌ�CF ��@ �
B� ��CF ��  �
ƌƃF ���  � DE G@ ��$D��D DG�� $��G�D LD��� d����D �DG	 ���ǄD �D�	AE 䄀�D EG
�� $��G�D L��
d� �I�� �EI� �I �I$� FFD � d�D��J�� �   ��GJ @����  	 @	 �ǀ�  ���� ��$� �J$� D  �H � I �H��I	����I���	�ɉ
K JKL��d� b
   �L��d� L
�d� �JL ��L�J  �J���� �JB�
MKM �M �@ ��
K ��C
� "  @��
  ������
  �
��
 �J  ̊N D  � � 
���ǊD �J�A� 䊀����$��LO �  �@ �  d� bK  @�C
  �����JO  ���̊O@ 䊀�
   ��
  �����@ � � �J    �@ �C
  ���
P �@ ������
  @ �C
  @�b
  ��@ �  ���J� � � L��� d��bK    �A� MK���  @��K   �  ����  b  ���� 	�@	��I� 
�@
 �� 
  L�Q	�
  �@�d��_��@��
R �
��
���K�@ ���K ƋR ���@���R �S� 䋀LE �E@ ��$L���  *K��JS ��I �
@ �� ̊SF�S G��J��JTL�Td �J  ��T
@ �J��
�@��J���T
FKU L����  @�d��J  ̊�� �
  @����� �
�� KD @�$��LU��dL�LLVd� L����dL�)�  �K�_ ������	@��W �KW� KD @�$ �\ ML��N�� ���)�  ��̊W@�䊀��$� "  ������$��"  @ ��R �
SK������ $K  ����� �$K��HXL	�d� �	��I�  ��	� 
 �H i�  ꆺL�� d� L�d� L��� dF�& � c   ActiveSkillPickUpComponentLogerror_className*施法者没有ActiveSkillPickupComponentGetAllValidPickUpGridPos        没有点选位置记录GetGridPosition              SkillContextGetResultContainerGetScopeResultGetTargetIDsIsIncludeMultiSizeIsIncludeTrapipairs_worldGetEntityByIDIsEntityTargettableinsertx��������yForceMovementCalculatorGetEntitySortFunctionByDirsortGetService	UtilDataBoardLogicSkillEffectCalc
TrapLogicTriggerGetBoardEntityIsCalcStepByPickIsRecordCurRoundForceMoveStep SkillEffectResult_ForceMovementNewGetStep_ReCalcMoveDirByTargetAndPick	BodyAreaGetArea
BlockFlagMonsterLandHasMonsterID
MonsterIDGetMonsterClassIDCfgcfg_monster_classID	RaceTypeMonsterRaceTypeFlyMonsterFlyGetID_pieceBlockBlackboard_NewPieceBlockBlackboardGetEntityMoveBlockFlagIsPosFitFullBodyAreaFindBlockByPosIsValidPiecePosIsPosBlockIsBlockMoveWithTrapWallBuffComponentCurRoundForceMoveStepGetBuffValueSetBuffValueRemoveEntityBlockFlag_CalcHitbackPieceChangeTable pairsSetPieceTypeLogicNTGridConvert_ConvertInfo
PieceTypeNoneNTGridConvertSetConvertEffectTypeSkillEffectTypeForceMovementSetSkillTypeGetSkillTypeNotifySetGridPositionNTForceMovementHasTeamTeamGetTeamPetEntitiesGridLocationSetMoveLastPositionTriggerTrapByEntityTrapTriggerOriginHitbackFindPieceElementGetCanConvertGridElementSetEntityBlockFlagAppendMoveResultAddEffectResult         �  �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                                               �                           #  $  $  $  $  $  %  %  &  &  &  &  '  '  '  '  (  (  (  (  (  (  (  )  )  )  )  )  &  &  -  -  -  -  -  .  .  .  .  /  /  /  /  0  0  0  3  3  3  5  5  5  5  5  5  5  5  7  7  7  7  8  8  8  8  :  :  :  :  ;  ;  ;  <  <  <  <  <  :  :  A  A  B  B  B  B  B  C  C  C  C  D  D  D  D  D  C  C  I  I  I  J  J  J  J  J  J  J  J  J  K  K  M  M  M  M  M  P  P  P  P  P  R  R  R  R  R  R  R  R  R  �   �   U  U  U  U  U  U  U  V  W   self    �  casterEntity    �  skillEffectParam    �  pickupComponent   �  pickupPosArray   �  moveCenterPos   �  pickupDirPos   �  isPickTargetMove   �  v2Dir    �  skillEffectResultContainer$   �  scopeResult&   �  
targetIDs(   �  includeMultiSize*   �  includeTrap,   �  tSelectedTarget-   �  (for generator)0   C   (for state)0   C   (for control)0   C   _1   A   	targetID1   A   e5   A   sortFunctionY   �  	utilDatab   �  boardServiceLogicf   �  skillEffectCalcSvcj   �  trapServiceLogicn   �  triggerSvcr   �  boardEntityu   �  isCalcStepByPickw   �  isRecordCurRoundForceMoveStepy   �  result|   �  (for generator)   �  (for state)   �  (for control)   �  _�   �  e�   �  maxStep�   �  v2Begin�   �  	bodyArea�   �  final�   �  (for index)�     (for limit)�     (for step)�     i�     v2�     posLast�     
blockFlag�     monsterClassID�   �   cfgMonsterClass�   �   canMove�     blockExceptTarget�   �   	boardsvc�   �   	blockVal�   �   fitFullBodyArea�   �   pieceBlock�   �   isBlockMoveWithTrapWall�     recordBuffCmpt�     buffValueKey�     curRoundForceMoveStep�     trapIds  �  	defender  �  defenderPos  �  
targetPos  �  	bodyArea  �  
blockFlag  �  tConvertInfo  �  pieceChangeTable  �  (for generator)  /  (for state)  /  (for control)  /  pos  -  
pieceType  -  convertInfo(  -  ntGridConvert4  �  petsR  `  (for generator)U  `  (for state)U  `  (for control)U  `  iV  ^  
petEntityV  ^  triggerTrapsg  r  (for generator)j  r  (for state)j  r  (for control)j  r  ik  p  ek  p  	colorNewu  �     _ENV Y  ^   
   @ A@��  $��L�@��   @�e�f  & �    _worldGetService	UtilDataIsEntityForceMovementTarget           [  [  [  [  ]  ]  ]  ]  ]  ]  ^     self       e       includeMultiSize       includeTrap       	utilData           _  e   	   � @ �@�A�  䀀��� $��& & �    _worldGetService	UtilDataCreatePieceBlockBlackboard        	   a  a  a  a  b  b  b  d  e     self    	   
centerPos    	   
targetIDs    	   	utilData   	   blackboard   	        i  ~   :   @� �@�� �A@�� "    �� Ɓ@   � 
�ÂG�@ �AG��b  ��G�@ �AG���CAG��bC  @ �C  f G�@ �AG���CAG��L��d� TÀ_��@ �C  f LBd� LC��� d�����  @�� ����  @ ��  � �  j��� � & �    	BodyAreaGetAreaipairs_pieceBlockBlackboardxy	GetBlock        GetOwnerWorldGetService	UtilDataIsPosBlockWithEntityRace         :   j  k  k  k  k  l  l  m  o  o  o  o  p  q  q  q  q  q  q  q  q  q  q  q  q  r  r  t  t  t  t  t  t  t  t  t  t  u  u  x  x  x  x  x  y  y  y  y  y  y  y  z  z  o  o  }  }  ~     self    :   gridPos    :   entity    :   testBlockVal    :   bodyAreaByOff    :   	checkPos   :   
areaArray   :   (for generator)   7   (for state)   7   (for control)   7   _   5   v2RelativeBody   5   v2   5   	utilData,   5      _ENV �  �   �   �  � � $� LB� d� L��d� b  �����@ �����A �BAǂA�� �A �B��A� ����A ��@ ���@�� ���A  B  ��AB���A ��@ ���������A  B ��A������B ��� �̈́�B  @ ����	� ���	    ����	�B  @ ����	� ���	 �
  ����	"C  @ ���	� ���	    ���	bC  @ �G��	� ���	 @
  �G��	��  *���� �����B �Cb  �����΁ ���� �����B �ACb  @����΁������ �����B ��Cb  ������ ���� @@���B ��Cb  @ ����΁���A ��@ ���@�� ���A  B  ��AB���A ��@ ������ ���A  B  ��A�AB� ����& �    GetGridPosition	BodyAreaGetArea       mathabsxy        ��������ipairsVector2updownrightleft         �   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    �   targetEntity    �   pickPos    �   dirPos    �   defaultStep    �   isCalcStepByPick    �   dir   �   step   �   
targetPos   �   	bodyArea   �   upMaxY+   y   	downMinY+   y   
rightMaxX+   y   	leftMinX+   y   (for generator).   R   (for state).   R   (for control).   R   index/   P   off/   P   bodyPos0   P      _ENV �     o   b@    �& �   GA@ L����  d���A@ ��@ �����   LB�d� L��d� �  ��  �A� ����� ���DB �BL��d� b   �L�d� LD�d� ��C ��C	�D  �D��� ��A	�DD	�D �D
 �	@ ��DB �	C� b  @��� ������  �D�� �D  ��E D  � 	� 
���D@ ̄�	A 䄀�	��$��LEF �� �@ 
�  d� bE  @�C  ������� �������@�䄀�   ��  ���G@�� � �D    �@ �C  ��b   ���    �  ��B�& & �            _worldGetService	UtilDataBoardLogic	BodyAreaGetArea       GetGridPosition
BlockFlagMonsterLandHasMonsterID
MonsterIDGetMonsterClassIDCfgcfg_monster_classID	RaceTypeMonsterRaceTypeFlyMonsterFlyGetID_pieceBlockBlackboard_NewPieceBlockBlackboardGetEntityMoveBlockFlagIsPosFitFullBodyAreaFindBlockByPosIsValidPiecePosIsPosBlock         o   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                    �         self    o   targetEntity    o   dir    o   maxStep    o   	moveStep   o   	utilData   o   lbsvc   o   e   o   v2Dir   o   	bodyArea   o   final   o   (for index)   m   (for limit)   m   (for step)   m   i   l   v2   l   
blockFlag   l   monsterClassID%   2   cfgMonsterClass+   2   canMove3   l   blockExceptTarget<   R   	boardsvcE   R   	blockValH   R   fitFullBodyAreaN   R   pieceBlockV   f      _ENV7               	   	               %      )   3   )   7   A   7   E   K   E   O   X   O   \   e   \   i   r   i   v      v   �   �   �   �   V  �   Y  ^  Y  _  e  _  i  ~  i  �  �  �  �    �           _ENV