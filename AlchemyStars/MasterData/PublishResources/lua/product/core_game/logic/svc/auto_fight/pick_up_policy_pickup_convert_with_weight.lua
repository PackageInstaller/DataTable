LuaS �

xV           (w@n@../PublishResources/lua/product/core_game/logic/svc/auto_fight/pick_up_policy_pickup_convert_with_weight.lua         h    @ A@  $@  �F�@ G�� �  �@ d����@ ��@�  � ���ƀ@ ���A A 䀀�@ �@A� � $��F�@ G���A �A d����@ ��@�� � ���Ɓ@ ���B A� 䁀�@ �@A� �B $�+@  F�A �  �@B d@�F B @ �F B �   J� �F B �@  J���F B ��  J� �l�  � B �  ����� B �@ �� ���A �� D �@���C �����C � ������C �� �� ���C �  ������C �@ �� ���C � ������ ��C ʀ ���C , � ����C ,A � �� �C 
���B l� 
A�& �    requirepick_up_policy_baseVector2New               ��������_class%PickUpPolicy_PickUpConvertWithWeightPickUpPolicy_BaseCalcAutoFightPickUpPolicy_CalcSinglePickResult_IsSuitableCandidate_CalcWeightGrids_CalcCandidatesAroundPlayer3PickUpPolicy_PickUpConvertWithWeight_LinkLineGroupObjectConstructorPosJoinMergeGroupSetLinkableByPlayer_IsPosLinkable__eqSetSurroundingGridsCacheSetPlayerLinkable__tostring_GetAllLinkableGroups           *    .   � � �@� �@ ��$��K  ��  � �  �A��A �BAǂA � @��B �B  � @��� �A �B��A A� ���C �B @ $ �B  �   ���B �� �@ �B��BC �� �B ������  � & �    policyParamactiveSkillID_GetPickUpNumByConfig       Loginfo_classNamecalculation #_CalcSinglePickResultresult=	tostringtableinsertYIELDTT         .                                                                   !   !   !   !   !   !   !   !   !   !   "   "   #   #   #   #   #   &   &   &      )   )   )   )   *      self    .   
calcParam    .   policyParam   .   activeSkillID   .   
pickUpNum   .   pickupResults   .   (for index)	   )   (for limit)	   )   (for step)	   )   i
   (   
pickUpPos   (      _ENV -   �    $*  � @ �@�A�  䀀�$� 
 ���@  @ �  �  AA �AA� �B �A $A �B @ $��FBA G���� �B C @ $ dB  G�@ �BC ��C� �� ��� ��J�)�  �A�AD �� $��F�D G��� �  dA�FE �A� dA G�� ��� ��E�� �F�� �AF GB� ��� ���K  ��B ��� �ƃF �F���EC G
@ 	$� LEG � 
 �d� b    �J�G	�  j����  *���G  � ���ƂB   � �DC �CG�$� J�G�  j��  �B @ $��FDC G���Hd� �D��   ���D �DH	��  �D�)�  �C�E GC� $C �H$� \� @��@�F�D G�����C  dC�FCA G���B �	 C GD�G�$ dC  GC�G�f  &�K  ��B � ���ƄF �F	�@�J�G��"F  @ �  J�D �IG��� 	$��"F   ��D FHG��� 	$F��  j����  *D��  ƃF  ��@�EC G
@ 	$� LEG � 
 �d� b  ��F�D G��
� � 
d��bE   �FJ LE�
� �d� ���
  
�E��E	 ƅB  �	�����"G  @�� �GA �AAG �B ��   	A� �C ��� $G  �
��$G��  jF��EA ǅ�F GB �� � 	G FC ��
d �E  ���
�  ���EA ǅ�� GB �� �E ƅD �E�  K J�J��� J���JF��E��E F� �E ��FEA G��
�E �B � @ 	� dE �  j��� ��  �& � ƃD ���  l�  �C��CA ǃ�B AD �C �DI��	� �C  �CI��� & � :   _worldGetService
AutoFight_boardPosPieces_CalcBoardPosPieceTypeLoginfo   -_classNameoverwritePosList: ipairs	       +	tostringVector2
Pos2IndexpolicyParamtargetPieceType_CalcWeightGridstablesortYIELDTT
petEntityPetGetOwnerTeamEntity_GetAllLinkableGroupspairssurroundingGridIndexDic
Index2Pos_IsSuitableCandidate_CalcCandidatesAroundPlayerposinsertGetGridPosition        winner weighted candidate:        
icontainsVector2Include3PickUpPolicy_PickUpConvertWithWeight_LinkLineGroupNewPosJoinisPlayerLinkablegrids	       -surrounding pos: add linking group: MergeGroupfinal group:            +#...can get player to linkable areaweight
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
pieceType   /      _ENV �   �       F @ G@� ��@ �� �   � �� @ G�@��� A �� �   ���@A �� ��A�� �   @ �� @ G�Af  & �    BattleConst,NormalMonsterAroundGridWeightWhenConvertingHasBoss#BossAroundGridWeightWhenConvertingHasMonsterID
MonsterIDIsEliteMonster+EliteMonsterAroundGridWeightWhenConverting            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      e       weight         _ENV �   4   )�   � � �@@ ̀�A�  䀀A AA��$��F�A LA�� d����� �B�� �AB�� ́B�   K  �B@ ��@� ����B@ ��GC@ GC�G��䂀C@ �C$� F�C G�@��  G�� L�d� LC�d� LC�d� L��d +C  � �D @�$�#�LEd� bD  �"�E� � d� �DE ��E	��E  LEFd� �� ���D ���G EG
A� ��B�� ��G� ��� ��  �DH	� �D @�	$��F�H G��� d� �FE ��E�	 �E AG	 ���F���I   @ �� �  ����I �J��I �F��JG��G� �I GJG�J���N��$ ��  � �D E $��M��H ��H���� �HK ǈ��K_ ����HK ǈ��K 	L_ �  ��H  �� _����IL�	�$��"I  @��  ��IE �EA� ��E ��  
 $I�͆�)�  ���GE �EA	 ��E � ȆAH ����M$G�G"G  �� 
��Mǆ
G�\�M��
G��
��F�N G���� dG�
�@�GGGG�MG�Mǆ
G�)�  �E�)�  ���f & � =   policyParam_worldGetServiceUtilScopeCalcSkillScopeCalculatorNewSkillScopeCalculator_Cross
petEntityPetGetOwnerTeamEntityGetGridPosition	UtilDataGetGroupEntitiesBW_WEMatchers
MonsterID
MatchTypeMT_BlackFistTeamGetEnemyTeamEntityipairsHasDeadMarkLoginfo_classNameweight calculation on entity GetIDbasic weight: 
CalcRangeSkillScopeTypeCross       	BodyAreaGetAreaGetAttackRangeVector2
Pos2Index   -pos in range: _IsSuitableCandidatemathmaxabsxy        _boardPosPiecestargetPieceType
PieceTypeAnyGetMonsterAtPos	       +7 additional weight for specific type of piece around: final weight:  sortIndex: po�     posweight
sortIndex	distancetableinsert          �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                                             	  	  	  	  
  
  
                                                                                                                                                                                                          !  !  !  !  !  !  !  !  !  !  "  "  "  #  $  %  %  &  &  &  '  )  )  )  )  )  *  *  ,  ,  ,  ,  ,  ,          3  4  %   self    �   
calcParam    �   policyParam   �   utilScopeSvc   �   
scopeCalc	   �   
crossCalc   �   eTeam   �   teamPos   �   posIndexCheck   �   weightedGrids   �   	utilData   �   monsterGlobalEntityGroup    �   (for generator)6   �   (for state)6   �   (for control)6   �   _7   �   e7   �   weight>   �   crossScopeR   �   attackRangeT   �   (for generator)W   �   (for state)W   �   (for control)W   �   _X   �   	rangePosX   �   	posIndex\   �   disx   �   additionalWeighty   �   (for generator)|   �   (for state)|   �   (for control)|   �   _}   �   dir}   �   v2~   �   index�   �   isSpecificPieceType�   �   
candidate�   �      _ENVmonsterWeightdirections 8  W   G   � � �@@ ̀�A�  䀀A AA��$��K  �  ǁ� ���� ��� B�$� F�B LB�� d�����C CCK  � ̃�� ���� ��  �D� CD @�$ �F�D G��� d� �D�D  @��E   @ �� �  ���DE ��E	��E  @��D �DF ��F	���  
��
EG�\�
E��D����)�  ��f & �     policyParam_worldGetServiceUtilScopeCalcSkillScopeCalculatorNew
petEntityPetGetOwnerTeamEntityGetGridPosition$SkillScopeCalculator_AroundBodyArea
CalcRangeSkillScopeTypeAroundBodyArea	BodyAreaGetAreaGetAttackRangeipairsVector2
Pos2Index_IsSuitableCandidateLoginfo_className second class candidate: tableinsertposweight        
sortIndex         G   9  <  <  <  <  >  >  >  >  @  A  B  B  B  B  B  C  C  E  E  E  E  G  G  G  G  G  G  G  G  G  G  H  H  I  I  I  I  J  J  J  J  K  K  K  K  K  K  K  K  K  L  L  L  L  L  L  M  M  M  M  N  O  P  P  M  R  I  I  V  W     self    G   
calcParam    G   policyParam   G   utilScopeSvc   G   
scopeCalc	   G   candidates
   G   posIndexCheck   G   eTeam   G   teamPos   G   aroundBodyAreaCalc   G   aroundTeamScope    G   aroundAttackRange"   G   (for generator)%   E   (for state)%   E   (for control)%   E   _&   C   	rangePos&   C   	posIndex*   C      _ENV a  i      �   
� ��   
���
�@�
� �
@����� � 
� ��   
� �& � 	   gridsposIndexDicisPlayerLinkable _desirePieceType_eTeam_worldGetOwnerWorldsurroundingGridIndexDic           b  b  c  c  d  e  f  g  g  g  h  h  i     self       eTeam       desirePieceType            k  x      � @ �@@ǀ@  � ����     �& � � @ ��@ǀ@  � �@�� A �@A� � �� ǀA ��A� B �@  ���@B @� 䀀�   � �̀B C� �@�& �    tableVector2IncludegridsinsertVector2
Pos2IndexposIndexDicisPlayerLinkable_IsPosLinkableSetLinkableByPlayer            l  l  l  l  l  l  l  m  p  p  p  p  p  q  q  q  q  r  r  u  u  u  u  u  u  u  u  v  v  v  x     self       v2       	posIndex         _ENV {  �      � @ �@@ǀ@ �� �@���@ � � � @ ��A �AA��  *����� �   � ���A � �@�& �    tableappendArraygridspairsposIndexDicisPlayerLinkableSetLinkableByPlayer            |  |  |  |  |  }  }  }  }  ~  ~  }  }  �  �  �  �  �  �  �     self       group       (for generator)      (for state)      (for control)      _	      index	         _ENV �  �      
@ �& �    isPlayerLinkable           �  �     self       b            �  �   	   � @ �@@�� ƀ@ � �  � � @ �� & �  j��   �  & �    _eTeamGetGridPositionipairs             �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       v2       
v2TeamPos      (for generator)      (for state)      (for control)      _      dir         _ENVdirections �  �      � @ �@@ � @��A� ǁ��A  @ ��  � ��  *��� � �  & �    pairsposIndexDic            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     a       b       (for generator)      (for state)      (for control)      _   
   index   
      _ENV �  �      
@ �& �    surroundingGridIndexDic           �  �     self       dic            �  �      
@ �& �    isPlayerLinkable           �  �     self       b            �  �   (   K � �   k@� �@@ ǀ@ �  ���@ �� � FBA G��� d �A  ��@ �� � A� �A���  *���@ � A� �  �@���@ � A� � AB G�B $ �@  ��@ ��B� � �  �   & �    grids: ipairsgridstableinsertVector2
Pos2Index , isPlayerLinkable: 	tostringisPlayerLinkableconcat         (   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     group    (   t   (   (for generator)      (for state)      (for control)      _      grid         _ENV �  :   )x  @ A@��  $��L��d� �A �AA���� �  �A G�A $��FA G���d� �CB_� ���B ��B_�  ��C  �� �C@�䃀DC��ƄC ���	$�  _����   ��  ��"   �FD GD�����dD�)�  ���  F�D ��d�4���D E� ��CE �� �C �A �B���� �C�E �EGF �D ��� F�F ��d $D  �D E� $�*�M�A �EA��
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
BlockFlag	LinkLinetableinsertipairs               YIELDLoginfo_classNameCalculating group for pos group: 	tostring   -around pos: isSpecificPieceType: isValidPos: isNotLinkLineBlocked:  isNotPlayerPos: 	       +found group: %...same group with calculating pos. 3calculating pos has no group, joining to found onePosJoin.both calculating pos and around pos has groupcalculating pos: MergeGroup...merged group: ,has no group, creating new group for them. 3PickUpPolicy_PickUpConvertWithWeight_LinkLineGroupNew#joining group of calculating pos. gridsSetSurroundingGridsCacheSetPlayerLinkable
icontainsall groups:           x  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                                                            �  �                          �  �                                                               !  !  !  !  !  !  "  "  "  "  #  #  #  #  $          (  (  (  )  )  )  *  *  *  +  +  +  +  +  +  +  ,  ,  ,  ,  ,  /  /  /  /  /  /  /  0  0  0  0  0      4  4  4  4  4  5  5  5  5  6  6  6  6  6  6  6  6  5  5  9  9  9  :  G   self    x  TT    x  policyParam    x  eTeam    x  	utilData   x  teamPos   x  teamPosIndex
   x  posIndexOfSpecificPieceType   x  (for generator)   4   (for state)   4   (for control)   4   	posIndex   2   
pieceType   2   v2   2   isSpecificPieceType   2   isValidPos   2   isNotLinkLineBlocked%   2   	groupDic5   x  (for generator)8     (for state)8     (for control)8     
dataIndex9     	posIndex9     currentC     groupD     (for generator)Q      (for state)Q      (for control)Q      _R   �   dirR   �   
aroundPosS   �   vindexW   �   isSpecificPieceTyped   �   isValidPosg   �   isNotLinkLineBlockedm   �   isNotPlayerPosq   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   index�   �   teamGridPos  x  teamGridIndex  x  playerLinkableFromPosGroup  x  
allGroups  x  (for generator)  a  (for state)  a  (for control)  a  _  _  group  _  dic  _  (for generator)  >  (for state)  >  (for control)  >  _  <  grid  <  (for generator)"  <  (for state)"  <  (for control)"  <  _#  :  dir#  :  v2$  :  vindex(  :  isValidPos+  :  isNotLinkLineBlocked1  :  	posIndex9  :  (for generator)i  t  (for state)i  t  (for control)i  t  _j  r  gj  r     _ENVdirectionsh                                                                           	   	   	   	   	   
   
   
   
   
                                                         *      -   �   -   �   �   �   �   �   4  �   8  W  8  \  \  \  \  ^  ^  a  i  a  k  x  k  {  �  {  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  :  �  :     directions-   h   monsterWeight=   h   eqY   h   strifyb   h      _ENV