LuaS �

xV           (w@y@../PublishResources/lua/product/core_game/logic/svc/auto_fight/pick_up_policy_local_team_pickup_convert_with_weight.lua         h    @ A@  $@  �F�@ G�� �  �@ d����@ ��@�  � ���ƀ@ ���A A 䀀�@ �@A� � $��F�@ G���A �A d����@ ��@�� � ���Ɓ@ ���B A� 䁀�@ �@A� �B $�+@  F�A �  �@B d@�F B @ �F B �   J� �F B �@  J���F B ��  J� �l�  � B �  ����� B �@ �� ���A �� D �@���C �����C � ������C �� �� ���C �  ������C �@ �� ���C � ������ ��C ʀ ���C , � ����C ,A � �� �C 
���B l� 
A�& �    requirepick_up_policy_baseVector2New               ��������_class.PickUpPolicy_LocalTeamPickUpConvertWithWeightPickUpPolicy_BaseCalcAutoFightPickUpPolicy_CalcSinglePickResult_IsSuitableCandidate_CalcWeightGrids_CalcCandidatesAroundPlayer<PickUpPolicy_LocalTeamPickUpConvertWithWeight_LinkLineGroupObjectConstructorPosJoinMergeGroupSetLinkableByPlayer_IsPosLinkable__eqSetSurroundingGridsCacheSetPlayerLinkable__tostring_GetAllLinkableGroups           *    .   � � �@� �@ ��$��K  ��  � �  �A��A �BAǂA � @��B �B  � @��� �A �B��A A� ���C �B @ $ �B  �   ���B �� �@ �B��BC �� �B ������  � & �    policyParamactiveSkillID_GetPickUpNumByConfig       Loginfo_classNamecalculation #_CalcSinglePickResultresult=	tostringtableinsertYIELDTT         .                                                                   !   !   !   !   !   !   !   !   !   !   "   "   #   #   #   #   #   &   &   &      )   )   )   )   *      self    .   
calcParam    .   policyParam   .   activeSkillID   .   
pickUpNum   .   pickupResults   .   (for index)	   )   (for limit)	   )   (for step)	   )   i
   (   
pickUpPos   (      _ENV -   �    $*  � @ �@�A�  䀀�$� 
 ���@  @ �  �  AA �AA� �B �A $A �B @ $��FBA G���� �B C @ $ dB  G�@ �BC ��C� �� ��� ��J�)�  �A�AD �� $��F�D G��� �  dA�FE �A� dA G�� �@ ��E�� ��E�� �F GB� ��� ���K  ��B ��� ��CF �F���EC �F
@ 	$� LG � 
 �d� b    �JBG	�  j����  *���G  � ���ƂB   � �DC �CG��$� JBG�  j��  �B @ $��FDC G����Gd� �D��   ���D �H	��  �D�)�  �C�E GC� $C CH$� \� @�@�F�D G�����C  dC�FCA G���B �� C G�G��$ dC  G�G��f  &�K  ��B � ����DF �F	�@�JBG��"F  @ �  J�D FIG��� 	$��"F   ��D HG��� 	$F��  j����  *D��  �CF  ��@�EC �F
@ 	$� LG � 
 �d� b  ��F�D G��
� � 
d��bE   �F�I L�
� �d� �E�
  
�E��	 ƅB  �	�����"G  @��� �GA �AA �B �G   	A� �C ��� $G  ��
��$G��  jF��EA ǅ� GB �F � 	 FC ��
d �E  ǅ�
�  ���EA ǅ�F GB �� �E ƅD ��  K J��J���� J��JF���E��E F� �E ��FEA G��
� �B � @ 	�� dE �  j��� ��  �& � ƃD ���  l�  �C��CA ǃ�B A �C �I���	� �C  �I���� & � 9   _worldGetService
AutoFight_boardPosPieces_CalcBoardPosPieceTypeLoginfo   -_classNameoverwritePosList: ipairs	       +	tostringVector2
Pos2IndexpolicyParamtargetPieceType_CalcWeightGridstablesortYIELDTTPlayerGetLocalTeamEntity_GetAllLinkableGroupspairssurroundingGridIndexDic
Index2Pos_IsSuitableCandidate_CalcCandidatesAroundPlayerposinsertGetGridPosition        winner weighted candidate:        
icontainsVector2Include<PickUpPolicy_LocalTeamPickUpConvertWithWeight_LinkLineGroupNewPosJoinisPlayerLinkablegrids	       -surrounding pos: add linking group: MergeGroupfinal group:            +#...can get player to linkable areaweight
sortIndexgroupskipping surrounding pos: 4because it's invalid or selected as result before. winner surrounding candidate:          :   D       � @ � � _� ��� @ � � `��  ��@  � � �  ���@@ �@� _� ���@@ �@� `��  ��@  � � �  ��@ ǀ� `�   ��@  � � �  & �    weight	distance
sortIndex           ;   ;   ;   ;   <   <   <   <   <   <   <   <   >   >   >   >   ?   ?   ?   ?   ?   ?   ?   C   C   C   C   C   C   C   D      a       b            j   t       � @ � � _� ��� @ � � `��  ��@  � � �  �@@ �@� _� ���@@ �@� `��  ��@  � � �  ��@ ǀ� `�   ��@  � � �  & �    weight	distance
sortIndex           k   k   k   k   l   l   l   l   l   l   l   o   o   o   o   p   p   p   p   p   p   p   s   s   s   s   s   s   s   t      a       b            �   �       � @ � � _� ��� @ � � `��  ��@  � � �  �@@ �@� `�   ��@  � � �  & �    weight
sortIndex           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      a       b           *  /   /   /   /   0   0   0   2   2   2   2   3   3   3   3   3   3   4   4   4   4   5   5   5   5   5   5   5   5   6   6   6   6   6   6   6   6   4   4   9   9   9   :   :   :   D   :   F   F   F   H   I   I   I   I   I   K   K   K   K   K   L   N   N   N   N   O   O   O   O   P   P   P   P   Q   Q   Q   Q   Q   Q   R   O   O   N   N   W   W   W   X   X   X   X   Y   Y   Y   Y   Y   X   X   ]   ^   ^   ^   ^   _   _   _   _   `   `   `   a   a   a   a   a   ^   ^   e   e   e   g   g   i   i   i   j   j   j   t   j   v   v   v   v   v   v   v   v   v   w   w   w   w   {   |   |   |   |   }   }   }   }   ~   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   }   }   |   |   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   A   self    *  
calcParam    *  overwritePosList    *  autoFightSvc   *  (for generator)   '   (for state)   '   (for control)   '   _   %   v2   %   weightedGrids*   *  policyParam3   *  eTeam8   *  playerLinkableGroups=   *  
allGroups=   *  candidatesGridDic>   *  (for generator)A   U   (for state)A   U   (for control)A   U   _B   S   groupB   S   (for generator)E   S   (for state)E   S   (for control)E   S   indexF   Q   _F   Q   v2J   Q   candidatesAroundPlayerX   *  (for generator)[   c   (for state)[   c   (for control)[   c   _\   a   info\   a   weightedCandidatesd   *  (for generator)g   v   (for state)g   v   (for control)g   v   _h   t   infoh   t   	posIndexl   t   teamPos{   *  surroundingGridsGroupByIndex�   )  (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   group�   �   (for generator)�   �   (for state)�   �   (for control)�   �   index�   �   _�   �   candidates�   )  (for generator)�     (for state)�     (for control)�     
gridIndex�     groups�     v2�     g�   	  convertCount�   	  (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   group�   �      _ENV �   �    
/   � @A@ �@��  $��LA�� d��bA  @ �C  f GAA ��A ��A�� �� G��_��� ��B �AB��@ ��  � ��B � F�B G��� �  @ ��  � ��B � F�B GB��� �  @ ��  � �� � & �    targetPieceType_worldGetService	UtilDataIsValidPiecePos_boardPosPiecesVector2
Pos2Index
PieceTypeAnyIsPosBlock
BlockFlag	LinkLineChangeElement         /   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    /   v2    /   policyParam    /   targetPieceType   /   	utilData   /   
pieceType   /      _ENV �   �       F @ G@� ��@ �� �   � �� @ G�@��� A �� �@A�� �   @ �� @ G�Af  & �    BattleConst,NormalMonsterAroundGridWeightWhenConvertingHasBoss#BossAroundGridWeightWhenConverting
MonsterIDIsEliteMonster+EliteMonsterAroundGridWeightWhenConverting            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      e       weight         _ENV �   /   )�   � � �@@ ̀�A�  䀀A AA��$��F�A LA�� d���A@ ��A�� �B�� �AB�   K  �B@ ��@� ����B@ ���GC@ G�GC�䂀�C @�$�#�L�Cd� bD  �"�E� � d� �D �DD	ǄD � LEd� �E ���D ����E F
AE �EB�� ̅F� ���� ��  �G	� �C @�	$��FFG G��� d� �D �FD�� �D A ���F��FH   @ �� �  ����H ��HƆH ��GIGG�G� �H IG�I���N��$ ��  ��	 �C E $��M�HG ��G���� �J ǈ�IJ_ ����J ǈ��J �J_ �  ��H  �� _����	K�	�$��"I  @��  ��	D IDAI ��D ��  
 $I��F�)�  ���D GDA� ��D �� ȆA ���HL$G�G"G  �� 
�Mǆ
G��\�MG�
G�
���F�M G����� dG�
�@�GGGG��MG�Mǆ
G��)�  �E�)�  ���f & � 8   policyParam_worldGetServiceUtilScopeCalcSkillScopeCalculatorNewSkillScopeCalculator_CrossPlayerGetLocalTeamEntityGetGridPosition	UtilDataGetGroupEntitiesBW_WEMatchers
MonsterIDipairsHasDeadMarkLoginfo_classNameweight calculation on entity GetIDbasic weight: 
CalcRangeSkillScopeTypeCross       	BodyAreaGetAreaGetAttackRangeVector2
Pos2Index   -pos in range: _IsSuitableCandidatemathmaxabsxy        _boardPosPiecestargetPieceType
PieceTypeAnyGetMonsterAtPos	       +7 additional weight for specific type of piece around: final weight:  sortIndex: po�     posweight
sortIndex	distancetableinsert          �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                                       
  
  
  
  
  
  
  
  
  
  
                                                                                                                                                                                                      !  !  !  "  $  $  $  $  $  %  %  '  '  '  '  '  '          .  /  %   self    �   
calcParam    �   policyParam   �   utilScopeSvc   �   
scopeCalc	   �   
crossCalc   �   eTeam   �   teamPos   �   posIndexCheck   �   weightedGrids   �   	utilData   �   monsterGlobalEntityGroup    �   (for generator)#   �   (for state)#   �   (for control)#   �   _$   �   e$   �   weight+   �   crossScope?   �   attackRangeA   �   (for generator)D   �   (for state)D   �   (for control)D   �   _E   �   	rangePosE   �   	posIndexI   �   dise   �   additionalWeightf   �   (for generator)i   �   (for state)i   �   (for control)i   �   _j   �   dirj   �   v2k   �   indexo   �   isSpecificPieceType|   �   
candidate�   �      _ENVmonsterWeightdirections 3  R   G   � � �@@ ̀�A�  䀀A AA��$��K  �  �A@ ́�� ���� �$� FBB LB�� d������B CK  � �C�� ̃�� ��  ��C� D @�$ �FDD G��� d� �D�D  @���D   @ �� �  ���E �DE	ǄE � @��D �F �DF	���  
�
Ǎ\�
E���D����)�  ��f & �    policyParam_worldGetServiceUtilScopeCalcSkillScopeCalculatorNewPlayerGetLocalTeamEntityGetGridPosition$SkillScopeCalculator_AroundBodyArea
CalcRangeSkillScopeTypeAroundBodyArea	BodyAreaGetAreaGetAttackRangeipairsVector2
Pos2Index_IsSuitableCandidateLoginfo_className second class candidate: tableinsertposweight        
sortIndex         G   4  7  7  7  7  9  9  9  9  ;  <  =  =  =  =  =  >  >  @  @  @  @  B  B  B  B  B  B  B  B  B  B  C  C  D  D  D  D  E  E  E  E  F  F  F  F  F  F  F  F  F  G  G  G  G  G  G  H  H  H  H  I  J  K  K  H  M  D  D  Q  R     self    G   
calcParam    G   policyParam   G   utilScopeSvc   G   
scopeCalc	   G   candidates
   G   posIndexCheck   G   eTeam   G   teamPos   G   aroundBodyAreaCalc   G   aroundTeamScope    G   aroundAttackRange"   G   (for generator)%   E   (for state)%   E   (for control)%   E   _&   C   	rangePos&   C   	posIndex*   C      _ENV \  d      �   
� ��   
���
�@�
� �
@����� � 
� ��   
� �& � 	   gridsposIndexDicisPlayerLinkable _desirePieceType_eTeam_worldGetOwnerWorldsurroundingGridIndexDic           ]  ]  ^  ^  _  `  a  b  b  b  c  c  d     self       eTeam       desirePieceType            f  s      � @ �@@ǀ@  � ����     �& � � @ ��@ǀ@  � �@�� A �@A� � �� ǀA ��A� B �@  ���@B @� 䀀�   � �̀B C� �@�& �    tableVector2IncludegridsinsertVector2
Pos2IndexposIndexDicisPlayerLinkable_IsPosLinkableSetLinkableByPlayer            g  g  g  g  g  g  g  h  k  k  k  k  k  l  l  l  l  m  m  p  p  p  p  p  p  p  p  q  q  q  s     self       v2       	posIndex         _ENV v  ~      � @ �@@ǀ@ �� �@���@ � � � @ ��A �AA��  *����� �   � ���A � �@�& �    tableappendArraygridspairsposIndexDicisPlayerLinkableSetLinkableByPlayer            w  w  w  w  w  x  x  x  x  y  y  x  x  {  {  {  |  |  |  ~     self       group       (for generator)      (for state)      (for control)      _	      index	         _ENV �  �      
@ �& �    isPlayerLinkable           �  �     self       b            �  �   	   � @ �@@�� ƀ@ � �  � � @ �� & �  j��   �  & �    _eTeamGetGridPositionipairs             �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       v2       
v2TeamPos      (for generator)      (for state)      (for control)      _      dir         _ENVdirections �  �      � @ �@@ � @��A� ǁ��A  @ ��  � ��  *��� � �  & �    pairsposIndexDic            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     a       b       (for generator)      (for state)      (for control)      _   
   index   
      _ENV �  �      
@ �& �    surroundingGridIndexDic           �  �     self       dic            �  �      
@ �& �    isPlayerLinkable           �  �     self       b            �  �   (   K � �   k@� �@@ ǀ@ �  ���@ �� � FBA G��� d �A  ��@ �� � A� �A���  *���@ � A� �  �@���@ � A� � AB G�B $ �@  ��@ ��B� � �  �   & �    grids: ipairsgridstableinsertVector2
Pos2Index , isPlayerLinkable: 	tostringisPlayerLinkableconcat         (   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     group    (   t   (   (for generator)      (for state)      (for control)      _      grid         _ENV �  5   )x  @ A@��  $��L��d� �A �AA���� �  �A G�A $��FA G���d� �CB_� ���B ��B_�  ��C  �� �C@�䃀DC��ƄC ���	$�  _����   ��  ��"   �FD GD�����dD�)�  ���  F�D ��d�4���D E� ��CE �� �C �A �B���� �C�E �EGF �D ��� F�F ��d $D  �D E� $�*�M�A �EA��
�� ��A ǅ�FB_ �����A ǅ��B �B_ �  ��E  �� C��
$��LFC��
�C �Cd� [��  ��F  �� ƆE ��� GF �G � � F�F ��d� �� ��F  	 � 	 F�F �	�d� �I ��F  
 �	 �F  �  ��"  @�b  ���  @�ǆ�  ��ƆE ���� GF �� ��F �� �F  �  @�ǆ����ƆE ���� GF �	 �F @��C  ��ƆE ���� GF �G	 �F ǆ̆�@ �F�ǃ��ƆE ���� GF ��	 �F ƆE ���� GF �
 ��F  �� �F  ƆE ���� GF �G ��F �� �F  �F�G��F�ƆA  ��  �
�  j�ƆE ���� GF ��
 ��F  �� �F  ���C  ��ƆE ���� GF ��
 �F �K �F�@��GB� ��̆�@ �F�
̆�@�
�F�
�ƆE ���� GF �� �F )�  �D��C  @�K DK���DB$� � ��� $D�
i�  ��L��d� �A �BA���� �    F�A � d ��  ƄD ��� ��D E� $��M��A �GA���� �C@�䇀HC��ƈC ���$�  �  ��"   �FA GH���d� ��)�  ����  j��D�@ 	�D�Ǆ	�  ��̄�C� �D��D ���	 �@�䄀�D   ��D �D�	 �@��D��D ���	  @�䄀�D   ��D �D�	  @��D�i�  ��F�E G���F � dC�F�D � d����E ��E	� F F�F ��d �D  i�  �C�@�� f�& � 5   _worldGetService	UtilDataGetGridPositionVector2
Pos2Indexpairs_boardPosPieces
Index2PostargetPieceType
PieceTypeAnyIsValidPiecePosIsPosBlock
BlockFlag	LinkLinetableinsertipairs               YIELDLoginfo_classNameCalculating group for pos group: 	tostring   -around pos: isSpecificPieceType: isValidPos: isNotLinkLineBlocked:  isNotPlayerPos: 	       +found group: %...same group with calculating pos. 3calculating pos has no group, joining to found onePosJoin.both calculating pos and around pos has groupcalculating pos: MergeGroup...merged group: ,has no group, creating new group for them. <PickUpPolicy_LocalTeamPickUpConvertWithWeight_LinkLineGroupNew#joining group of calculating pos. gridsSetSurroundingGridsCacheSetPlayerLinkable
icontainsall groups:           x  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                      �  �  	  	  
  
  
  
  
  
          �  �                                                                                                  #  #  #  $  $  $  %  %  %  &  &  &  &  &  &  &  '  '  '  '  '  *  *  *  *  *  *  *  +  +  +  +  +      /  /  /  /  /  0  0  0  0  1  1  1  1  1  1  1  1  0  0  4  4  4  5  G   self    x  TT    x  policyParam    x  eTeam    x  	utilData   x  teamPos   x  teamPosIndex
   x  posIndexOfSpecificPieceType   x  (for generator)   4   (for state)   4   (for control)   4   	posIndex   2   
pieceType   2   v2   2   isSpecificPieceType   2   isValidPos   2   isNotLinkLineBlocked%   2   	groupDic5   x  (for generator)8     (for state)8     (for control)8     
dataIndex9     	posIndex9     currentC     groupD     (for generator)Q      (for state)Q      (for control)Q      _R   �   dirR   �   
aroundPosS   �   vindexW   �   isSpecificPieceTyped   �   isValidPosg   �   isNotLinkLineBlockedm   �   isNotPlayerPosq   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   index�   �   teamGridPos  x  teamGridIndex  x  playerLinkableFromPosGroup  x  
allGroups  x  (for generator)  a  (for state)  a  (for control)  a  _  _  group  _  dic  _  (for generator)  >  (for state)  >  (for control)  >  _  <  grid  <  (for generator)"  <  (for state)"  <  (for control)"  <  _#  :  dir#  :  v2$  :  vindex(  :  isValidPos+  :  isNotLinkLineBlocked1  :  	posIndex9  :  (for generator)i  t  (for state)i  t  (for control)i  t  _j  r  gj  r     _ENVdirectionsh                                                                           	   	   	   	   	   
   
   
   
   
                                                         *      -   �   -   �   �   �   �   �   /  �   3  R  3  W  W  W  W  Y  Y  \  d  \  f  s  f  v  ~  v  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  5  �  5     directions-   h   monsterWeight=   h   eqY   h   strifyb   h      _ENV