LuaS �

xV           (w@\@../PublishResources/lua/product/core_game/logic/svc/auto_fight/pick_up_policy_pet_moye.lua         .    @ A@  $@ �@ A�  � A $@��@  ���@ l   
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
@ �& �    requirepick_up_policy_base_classPickUpPolicy_PetMoyePickUpPolicy_BaseCalcAutoFightPickUpPolicy FindPath_MonsterMoveGridByParam _BuildConnectMapByPieceTypeList_CanMatchPieceTypeList_Offset2Index_ConnectMapByPieceTypeList _CalcAllMovePathByPieceTypeList_NextMoveByPieceTypeList_FindPathNearToTarget4_GetPosIndexListByOffset_CalcHighConnectRateCutLen_CalcChainPathComplexityLen        	   �    3\  � � �@@� ̀�� �� K  �  �  A BA$� FBA G��@� � �@ ��& A �A� $��LBB� d������� ��B�B    �� CC"C  @ ��C �CGDbC    �A _��  �CC  C�  �� ����  �� �CD�C    ��  ǃD�C    ��  � @ +D� D  �A ��A	� ����E	@��E �� GA L��
�� d���  �A ���GA G�GF�䅀�F L��d $  �LGd� bG   �FGG G������G� ��� d�  b  ��LG@d� �GH ��H���� �GG ���  @ �G�)�  ���BIG�BGF���B��I��B���J	$� LGJ�  �@���J�� ��J�� �K�  	 @	��	 d� �G��� ƇF   
� �IG �K@	 �	�$I��  j��    �  @
�\�	 @��	�F�F ��	d ������ ��J�� �I�� �F @
 $
��M����
 ����  ��KG ǋ�  @�䋀�K  ���KG ���  @��K�@ �)�  ���b  ��i�  ��FHG G�� d�  @���F�F � d ������ ��J�� �I�� �F @
 $
��M����
 ����  ��KG ��� �@��K�)�  ���JG JL@
��
  $J���FJG GJ��
 �J  dJ�G�B@��
  ̊��
 �J  � ��L   @�� �� �@ �����@ ��b  މ��JG �
L�
���  ����	��
��
  ��
 ���i�  ���  � �\�	 @�  �G��	bD  � �@�� ��f K  ���� kH  ��@������ ��J�� �H�� 	  � �F @	 $	 �M
��JG ��H�
� ��J��JG ��G�
  �����
  ��)�  �	�IG IL@	���  $I���FIG GI��	 ��  dI�G�BL�L �	  
�@
 �
��
�  @�d��@���@	��	 �	�f	 & � 4   
petEntityGetGridPositionCloneactiveSkillID_world
MatchTypeMT_BlackFistGetServiceConfigGetSkillConfigDataGetSkillPickParam                      
PieceTypeBlue       firstPickValidScopeListtrapIdListUtilScopeCalcSelectNearestMonsterOnPosc       	UtilData	GetGroupBW_WEMatchersTrapIDipairsGetEntitiesHasDeadMarktable
icontainsTrap
GetTrapIDVector2
Pos2Indexinsert
ScopeTypeScopeParamTargetTypeScopeCenterTypeGetSkillScopeCalcComputeScopeRange	BodyAreaGetAreaGetGridDirectionGetAttackRangeremovevGetPieceTypecountsortGetID FindPath_MonsterMoveGridByParam         �   �       � @ �@@� �    ���� @ �@�� @� 䀀`�   �A  � & & �    Vector2	Distance            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      a       b       disA      disB
         _ENVpetPos �   �       � @ �@@� �    ���� @ �@�� @� 䀀`�   �A  � & & �    Vector2	Distance     (       �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      a       b       disA      disB
         _ENVnearestBodyPos �   �       � @ �@@� �    ���� @ �@�� @� 䀀`�   �A  � & & �    Vector2	Distance            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      a       b       disA      disB
         _ENVpetPos �   �       � @ �@@� �    ���� @ �@�� @� 䀀`�   �A  � & & �    Vector2	Distance     $       �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      a       b       disA      disB
         _ENVnearestBodyPos\                                                                                                                                                    !   !   "   "   "   "   $   $   $   $   %   %   %   %   &   &   &   )   -   -   -   -   .   .   .   .   4   4   4   4   7   8   8   8   8   8   8   9   9   9   9   9   :   :   :   :   :   :   :   :   :   :   :   :   :   :   ;   ;   <   <   <   <   =   =   =   =   =   9   9   B   B   C   C   D   D   E   E   G   G   J   K   L   M   N   N   N   N   O   O   P   Q   S   J   T   T   W   W   W   W   X   X   X   X   X   W   W   [   ^   `   `   `   `   `   a   a   a   a   b   b   b   b   c   c   d   d   d   d   e   f   f   f   h   h   j   j   j   j   j   j   j   k   k   k   k   k   l   d   d   t   t   a   a   y   y   y   y   y   y   z   z   z   z   {   {   {   {   |   |   }   }   }   }   ~            �   �   �   �   �   �   �   }   }   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   z   z   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   U   self    \  
calcParam    \  
petEntity   \  petPos   \  activeSkillID   \  posList   \  attackPosList   \  targetIDList	   \  
configSvc   \  skillCfgData   \  pickUpParam   \  depth!   \  
pieceType&   \  canLinkMonster.   \  firstPickValidScopeParam8   \  trapIDList<   \  pieceTypeList?   \  targetEntity@   \  
utilScopeD   \  monsterListH   \  monsterPosListH   \  utilDataSvcL   \  trapPosIndexListM   \  
trapGroupS   \  (for generator)W   s   (for state)W   s   (for control)W   s   _X   q   trapX   q   trapPosh   q   trapPosIndexl   q   firstScopeTypeu   \  firstScopeParamw   \  firstTargetTypey   \  firstScopeCenterType{   \  scopeCalculator}   \  
tmpResult�   \  attackRange�   \  (for generator)�   �   (for state)�   �   (for control)�   �   i�   �   pos�   �   targetBodyAreaPosList�   \  canBeHitMonsterList�   \  (for generator)�   �   (for state)�   �   (for control)�   �   i�   �   monster�   �   targetBodyArea�   �   
targetPos�   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   value�   �   workPos�   �   pieceTypeWork�   �   (for generator)�     (for state)�     (for control)�     i�     monster�     targetBodyArea�     
targetPos�     (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   value�   �   workPos�   �   pieceTypeWork�   �   nearestBodyPos�     	posStart�     	posStart%  \  targetBodyArea)  \  
targetPos+  \  (for generator)0  @  (for state)0  @  (for control)0  @  _1  >  value1  >  workPos2  >  nearestBodyPosF  \     _ENV   A   a     K  
@�K  
@��
�@�K  
@�
���
���
�A�LBB ��  �@ ��dB L�B ��  �d� 
@��L�B ��  �@ � ��dB�LC �   d�  �\  @�� �K� ��kB�  �L�Cd� ��C �DC ���̂D@�䂀b  ���D E ��� FCE G��� d� �CE ��E���� ��E @ �F � DF �F@���$��"  � � DC
B !@C@ �      
 �  
 ��
�@�  
 �
���
���
�A�& & �    _diNaChainPaths_diNaChainIndexPaths_diNaMoveForward _diNaConnectMap_HighConnectRateCutLen        _maxlen_cutlen _BuildConnectMapByPieceTypeList_CalcHighConnectRateCutLen _CalcAllMovePathByPieceTypeList_FindPathNearToTarget4       GetGridPosition_worldGetService	UtilDataGetPieceType
PieceTypeBlueVector2
Pos2Index_GetPosIndexListByOffsetOffset8table
icontains         a   
                                                                          "  "  "  "  %  %  '  '  '  '  (  (  (  )  )  )  )  )  )  *  *  +  +  +  +  ,  ,  ,  ,  -  -  -  -  .  .  .  .  .  .  .  /  /  /  3  3  3  4  4  8  8  9  9  :  ;  ;  <  =  >  @  A     self    a   casterEntity    a   targetEntity    a   pieceTypeList    a   depth    a   canLinkMonster    a   trapPosIndexList    a   	posStart    a   	movePath   a   
targetPos+   a   utilDataSvc/   a   tpPieceType2   a   endPos:   P   endPosIndex>   P   	posIndexB   P   aroundPosListF   P      _ENV E  U      G@ LA�d� L��d� ��@ �A� �� �AA ǁ�����$��LB �   @�� ��dB�LB���dB�& � 
   _worldGetBoardEntityBoardVector2
Pos2Index
BlockFlag	LinkLineGetBlockFlagCanMoveMap_ConnectMapByPieceTypeListClearBlockFlagCanMoveMap            G  G  G  G  G  J  J  J  J  M  M  N  N  N  Q  Q  Q  Q  Q  Q  Q  T  T  T  U  	   self       entity       pieceTypeList       trapPosIndexList       	posStart       
boardCmpt      	posIndex	      
blockFlag      blockCanMoveMap         _ENV W  ]      � @ �@��� @ ��   �  ƀ@ ���  @� � ��   & �    
PieceTypeNonetable
icontains            X  X  X  X  Y  Y  \  \  \  \  \  \  ]     self       type       	typeList          _ENV _  f      ��  �AA  ��  ��  +A�� ��AA �� �  +A�� ��A �� � +A�� ��� �MAA& & � 	                                                                              `  a  a  a  a  a  a  b  b  b  b  b  b  c  c  c  c  c  c  e  e  e  e  e  f     self       i       j       t           i  �   7   �@ �A �    �& � �  �@ ʁ� �A@ �@ ��	��@ G��C�$��F�@ G��� d� MC� �C�  ����� �����B   @ 䃀�C  ���CB ǃ� �@�䃀�  ����B GC�DC� �A�̃C @�� ��  @��C��  jB�& �    _diNaConnectMapipairsOffset8Vector2              
Pos2IndexGetPieceTypeByIndexCanMatchPieceTypeListtable
icontains_Offset2Indexxy_ConnectMapByPieceTypeList         7   o  o  o  o  p  s  t  t  v  v  v  v  w  w  w  w  x  x  x  x  x  y  y  y  z  z  z  {  {  {  {  {  {  {  {  {  {  {  {  {  |  |  |  |  |  }  ~    �  �  �  }  v  v  �     self    7   	posIndex    7   pieceTypeList    7   
boardCmpt    7   blockCanMoveMap    7   trapPosIndexList    7   ct   7   (for generator)   6   (for state)   6   (for control)   6   _   4   offset   4   
offsetVec   4   surroundIndex   4   surroundPiece   4      _ENV �  �      ���@ �A�  � � @�+B� L�@ �   @�� dB & �    Vector2
Pos2Index_NextMoveByPieceTypeList            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  	   self       casterEntity       pieceTypeList       depth       trapPosIndexList       	posStart       pos      startPosIndex      chainPathIdx         _ENV �  �   �    �  �& � \� GA� �A@ �A�  @�Ɓ@ ���  �  �  �& � � B A ����� � _��  �& � ǂ�  ���@ �A@� ��$��"C   �� AJ��@ �A@� � $��
�L�B ��   N�� dC GCB b  @�\�  @���
 ÄK  � ��  ������A	�DC Ǆ�	E� � J�	�����@ ��A��C  � ����    �& � �D �D �����C���C ��C �����@ DD@� $� ����@ ��A��  ����� 
���E @� 䃀
���\� N�GC� @���\� J@���@ ��A��  ���G�D �� N������\� ��D �� h��\� J@���@ ��A	��  ���g����& �            _diNaConnectMaptablecount              
icontainsconcat _diNaMoveForward_NextMoveByPieceTypeList Vector2
Index2Pos_diNaChainIndexPaths_diNaChainPaths
cloneconf_maxlen_cutlen_CalcChainPathComplexityLen        ��������         �   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    �   chainPathIdx    �   pieceTypeList    �   depth    �   trapPosIndexList    �   startPosIdx   �   ct   �   (for index)   �   (for limit)   �   (for step)   �   i   �   posIdx   �   s+   �   
chainPath:   g   (for index)=   F   (for limit)=   F   (for step)=   F   n>   E   sa   g   lenm   s   ss   s   (for index){   �   (for limit){   �   (for step){   �   n|   �   len}   �   s�   �      _ENV �  >   3   � @ �   ���@@ ǀ�@ � ��@ ��   �  � A A� $� F�A G��� d� �  �  B@ BG@ �  $B�@� ��B BG@ �B  $B�@ �BFC � d ���A �CC���� ƃC ���  @ �C�i�  ��� & �    _diNaChainIndexPathstablecount        Offset4GetGridPositionVector2
Pos2Indexsort table       ipairs
Index2Postableinsert         �     *   �   �   A@ @  $��F�@ G���� � d��b    �� A)�  �A�A@ @� $��F�@ G���� � d��b    �� �)�  �A�`� �@ � � �@ �� 	 `��  �A  � & & �            ipairstableintable                *   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                 a    *   b    *   hasTrapCountA   *   hasTrapCountB   *   (for generator)      (for state)      (for control)      i      chainPosIndex      (for generator)      (for state)      (for control)      i      chainPosIndex         _ENVtrapPosIndexListcheckTrapSuc 	        � @ �@@�   �� � @ �@� � � `��  �A  � & & �    tablecount            
  
  
  
                         a       b       countA      countB         _ENV3   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �    �                                                  =  >     self    3   targetEntity    3   trapPosIndexList    3   offsetList   3   
targetPos   3   	posIndex   3   retPath   3   checkTrapSuc   3   selectPath"   3   (for generator)%   1   (for state)%   1   (for control)%   1   i&   /   chainPathIdx&   /   pos*   /      _ENV B  J      �   @ @ $@�FB@ ��@��@d���B@ �A���� ��� �BA ǂ� �@ �B�)�  ����  & �    ipairsVector2              
Pos2Indextableinsert            C  D  D  D  D  E  E  E  E  F  F  F  F  F  G  G  G  G  G  D  D  I  J     self       	posIndex       offsetList       posIndexList      (for generator)      (for state)      (for control)      _      offset      
offsetVec	      index         _ENV M  r   ,   � @ A@ �@@ $� K  ��  ��    l   �@ � dB R���  �A �B��  � ��� �B    ��� A B ���A CB� @@ �A ��B�B CAC ����  �$C�� & �    _diNaConnectMapVector2
Pos2Index        BattleConstAutoFightMoveEnhanced              AutoFightPathLengthCutPosNum"AutoFightPathLengthCutConnectRateAutoFightPathLengthCutLogdebug6[AutoFight] _CalcHighConnectRateCutLen() totalPosNum= ConnectRate=         W  d   	    @ E � M@� I � F  �@  ��  A  ����A� �   ����A���Ɓ �A  � ��   �A ���& �                            X  Y  Y  Y  Z  [  [  [  [  \  ]  ]  ^  ^  ^  _  _  _  `  `  `  [  d     	posIndex       ct      (for index)      (for limit)      (for step)      i	      nextIdx
         	touchIdxtotalPosNumconnectMaptotalConnectsearch,   N  P  P  P  P  R  S  T  V  d  d  f  f  f  g  h  i  i  i  i  i  i  i  i  k  k  k  k  l  l  l  l  l  n  n  p  p  p  p  p  p  p  q  r     self    ,   casterEntity    ,   	posStart    ,   connectMap   ,   playerPosIndex   ,   	touchIdx   ,   totalConnect   ,   totalPosNum   ,   search	   ,   rate   ,   cutlen   ,   idx   ,      _ENV t  �   $   � @  ���@ �� @ �  ��@ ��@�   � ��  �@    ��@ �@ � F�A �� d ���A �B�BB �B��� π���@ ��B��  � @ �AA@ �i�  ��& & �    _HighConnectRateCutLen        BattleConstAutoFightMoveEnhanced              ipairstablecount_diNaConnectMapAutoFightPathComplexity         $   u  u  u  v  v  x  x  x  x  x  x  x  x  y  z  {  {  {  {  |  |  |  |  |  |  }  }  }  }  }  ~  ~  {  {  �  �  
   self    $   chainPathIdx    $   m   $   cc   $   len   $   (for generator)   "   (for state)   "   (for control)   "   i       idx          _ENV.                              	   �   	     A    E  U  E  W  ]  W  _  f  _  i  �  i  �  �  �  �  �  �  �  >  �  B  J  B  M  r  M  t  �  t  �         _ENV