LuaS �

xV           (w@c@../PublishResources/lua/product/core_game/view/svc/preview/effect/preview_calc_multi_traction.lua         ?    @ A@  ��@ $@�@@ l   
@��@@ l@  
@ �@@ l�  
@�� @ A� ��@ $@��A   ��A l�  
@���A l  
@�� @ A  ��@ $@� B   � B l@ 
@�� B l� 
@�� B l� 
@ � B l  
@�� B l@ 
@ � B l� 
@�� B l� 
@ � B l  
@��,@ F B �� J� �F B �� J���& �    _classCPreviewPreviewSkillEffectCalc_MultiTraction_SingleTargetPossessionObjectConstructorSetTriggerTrapsGetTriggerTraps=PreviewPreviewSkillEffectCalc_MultiTraction_GridPossessorMapMarkPossessInfo%PreviewSkillEffectCalc_MultiTraction_LogIsPosObstructed_FetchCandidatesInDoSkillEffectCalculator_DoSingleTractionGetGridPath%GetPassedGridPositionByIntersectionsSnapContinuousPath_PetANaTuoLiFindTractionCenter                  
@ �
���
� �
 ��& �    	entityIDpath	finalPos	beginPos                 	   
         self       	entityID       path       	finalPos       	beginPos                      
@ �& �    _triggerTraps                    self       triggerTraps                      G @ f  & �    _triggerTraps                       self                      K   
@ �K   
@��K   
@ �& �    allarraydimensionMap                                   self            "   G    :   @$� LA@d� ��@ b  ������  \�� (��ÂC GCA��A�C�C  @ ��  ����C���A ��DB @ �C�'��@��A� �� G�bB  @ �K  �A�G�JF�A G��BB �� dB���A ���B F�B L��  �@� �CC� d  �A  & �    GetID	BodyAreadimensionMapGetArea       xytableinsertallarrayCPreviewPreviewSkillEffectCalc_MultiTraction_SingleTargetPossessionNewGetGridPosition         :   #   #   $   $   &   (   (   )   )   *   *   *   *   +   +   ,   -   .   .   .   /   /   1   1   2   2   2   2   2   *   3   5   6   7   7   7   8   8   :   :   ;   ;   ;   ;   ;   >   >   ?   @   @   A   B   C   D   D   @   >   G      self    :   pos    :   entity    :   path    :   	entityID   :   bodyAreaComponent   :   dimensionMap   :   
areaArray	      (for index)      (for limit)      (for step)      i      absoluteAreaPos      absX      absY      absX    -   absY!   -      _ENV L   V       
@ �� @ ��@�  ���
����@A ��A�� 
� �
 & � 	   _world_configServiceGetServiceConfig_gridPossessionMap=PreviewPreviewSkillEffectCalc_MultiTraction_GridPossessorMapNew	_logFlag            N   Q   Q   Q   Q   Q   S   S   S   S   U   V      self       world          _ENV X   _      � @ �@    �& � b   � ��@� �� �@    ���  ��@ � �AA @ �� �  �@  & �    	_logFlagGetIDnilLognotice_className:             Y   Y   Y   Z   ]   ]   ]   ]   ]   ]   ]   ^   ^   ^   ^   ^   ^   ^   _      self       entity       eid         _ENV b   �    =   � @ �@�� ̀�� ���� $��"A  @ �C� f A �AA ��A� � ���A GB ��AA �AB� � ���A G�B@ ���A G�B�C �AC��� @����@ ̂�@�䂀�  ����$� "  ��C  ���� &  ��B ��@ ��� � ��  *���  � & �    _worldGetPreviewEntityPreviewEnvGetPosBlockData        MonsterRaceTypeLand
BlockFlagMonsterLandFlyMonsterFly	LinkLinepairsm_listBlockGetEntityByIDTrapRender         =   d   d   d   d   d   f   f   f   g   g   h   h   l   n   n   n   n   o   o   o   p   p   p   p   q   q   q   s   s   v   v   v   v   w   w   x   x   x   x   y   y   y   y   y   y   y   y   y   z   z   {   ~   ~   ~         v   v   �   �   �      self    =   pos    =   targetType    =   env   =   
blockData   =   monsterBlockFlag   =   (for generator)    :   (for state)    :   (for control)    :   	entityID!   8   value!   8   entity'   2      _ENV �   �       �   @ @� $��LB@ �   d� bB   �F�@ G����� dB�)�  ����  & �    ipairsIsPosObstructedtableinsert            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   	   self       range       monsterRaceType       candidates      (for generator)      (for state)      (for control)      _      pos         _ENV �   !   *!  � � A@ �@��� $��D  ���� �AA ǁ�� ����� �  � ��B� @�@
�GA� bA  � �́B� @���B� �  ��GA� bA   �́B� @� �́B� @� ��AA ��� ��@    �& � ́B� � @C  �& � ��L�Cd� �D  �@ �� @ �A@ �A�A� 䁀B@ BD�� $��FE LB�� d����E �BE ������EFF GC��� ���F$� �F$� LGd� �DG ��G	��䂀������� ��$C FDH G��
�FDH G��
D�FDH G�
��FDH GD�
ă
 �H FDH G���� ���D� 
���� GD@ LD��
 d���D@ �DD	� ����DJ	� �� K  ���  @ �� �  � ��K� �E  @ ��EG ǅ�F�$� "    �� GF@ L��d� ��K ��K����LLd� LF�d� ����� ��L�� �B� M GM@ 
��$��"  @��M ����  @ $G ��FFG G��@� �GF@ L��d� L�d� ���� �M �F�  
@ 䆀�   �̆M @�� ��  �F @�FFN LF��F ǆ� �@ 
� 
d� ��N �FEG@ ����O@ �GG �GO��  K  䆀�O @�$  �J�O)�  ��P	���� $� K  ��O � � ��HP̈�� �Ȉ
�H  @���P GIP�	 �H �HP��� IQ �Q�	��IP
  $I� ��M ��� 	�@	 �H���  *���O ��� ��HP��� �M �	��	�JP@
 $I ��  *�FR LF��FQ e�f  & � I   skillEffectParam_worldGetEntityByIDcasterEntityIDGetTractionCenterTypeTractionCenterTypeNormalIsCasterCenteredGetGridPositiongridPosGetCenterPosHasPetPstIDPetANaTuoLi              GetAttackRange_PetANaTuoLiFindTractionCenterGetService	UtilCalcUtilScopeCalcSkillScopeCalculatorNew SkillScopeCalculator_FullScreen
CalcRangeSkillScopeTypeFullScreen	BodyAreaGetAreaGetGridDirectionSkillTargetTypeBoardDivideGridsByQuadrantrangeByQuadrantBoardQuadrant	RightTopRightBottomLeftBottomLeftTopCenterskillIDConfigGetSkillScopeCalcskillRangeGetSkillConfigDataGetSkillTargetTypeGetSkillEffectTargetType
MatchTypeMT_BlackFistPetGetOwnerTeamEntityTeamGetEnemyTeamEntitytable
icontains_DoSingleTractionPlayerGetPreviewTeamEntitySkillScopeResultNoneSkillScopeTargetSelectorDoSelectSkillTargetMonsteripairsSortMonstersByPos
monster_eGetID_Log$ Outside of skill range, skipping. _gridPossessionMapMarkPossessInfoinsertSkillEffectMultiTractionResult         !  �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                                            
  
  
  
                                                                                                               !  7   self    !  skillEffectCalcParam    !  scopeResult    !  tractionParam   !  casterEntity   !  
centerPos   !  tractionCenterType   !  scopeCenterPos2   >   mainPos7   >   scopeRange9   >   utilCalcSvcB   !  utilScopeSvcF   !  skillCalculaterJ   !  fullScreenCalcN   !  platformScopeResult]   !  rtb   !  rbb   !  lbb   !  ltb   !  skillIDx   !  configService|   !  utilScopeSvc�   !  
scopeCalc�   !  attackPosArray�   !  targetEntityIDMap�   !  skillConfig�   !  targetType�   !  overrideTargetType�   !  teamEntity�   �   
enemyTeam�   �   v2PosTL�   �   teamEntity�   �   v2PosTL�   �   scope�     	selector�     
targetIDs�     (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   id�   �   monsterDisList�     validMonsterDisList�     (for generator)�     (for state)�     (for control)�     _�   
  monsterDisInfo�   
  gridPos�     (for generator)    (for state)    (for control)    _    monsterDisInfo    gridPos       _ENV %     *�  G@ LA���  d������� ��� B�$� D� "  ��̂A� @���A@�䂀���  �$� "   �C�$� �B$� � C G@ LC��� d����  @� �����!@C��̃C @��� �C �D �C�@ ���  �C�& � �@ �C�A� 䃀����$��"D  ���C ���  �$D�D DD� ��  $D�& � D��� � $� L�C ��� @ dD�L���F ��	 � NECd���DF �D Ǆ�	� ���F �� �@ �E���  *���F �G	�� � �D��DB�� �   �̄B	� EG$� L�G
d� ��G ��	� ���F �� �MG�F���  *��H @�� � �  � ��	@H
���C ���� $E D ED
� ��  $E�& � �H$� K  �E ��	F �E��F�	�F �� �� $� C� ��G ���@�͈II �	��	 $� 	 @�  �CI  C	�  �  ��I  �	� ��F ǉ�
D �F@
�䉀�	�b  ��c  �c�� �c   �@���  *����I �J�GJ�� ��I ��H�� a��  ��G  �� ��I ���J� �I JG��$� a�  ��G  �� b   ��  ���   ��F �J@�
� $H�����
@H���D �ED  @��  �E�& � ����� �K �E�@ ��
� F�
L��  � d� ��F ��K��  �����G  �
� ������ $�  @ � �@ F�F G������d����@�F�F G������d�� @�� � �@ ���  j���K @ � �   F�F G��� ��H� dG  FGF �D ��Fd ���F ��J�  	��H�i�  ��LG�d� �L �GLb  ������ �L �L �� ��L ���G�@ ��L �G�̇�@�� b  @����� �L �L_ �� ��  @ ��H  �� ��$� "I  @ �	�$� @	 �	��� K  �  ���HC ��� ���F ǈ� 	�
G��䈀�  ����F ǈ�	D �FG��䈀�  @ ��HC ����H  	 AI ����F ��� 
�G���I��H�  �@���@H���D �HD 	 @	��	  �H�& � �D �HD 	 @	��	��H�& � 9   _worldGetServiceConfigGetMonsterConfigDataHasMonsterID
MonsterIDGetMonsterIDGetMonsterRaceTypeHasBodyArea	BodyAreaGetArea	UtilCalcGetGridRingNumWithBodyArea       _Log already in 1st ring, skipping. _gridPossessionMapMarkPossessInfo
BuffLogicCheckCanBeHitBackmonster cannot move: GetPosQuadranttarget quadrant: GetGridsByRingrangeByQuadrantpairsalltableremovevGridLocationGetGridPosipairs_FetchCandidatesIn        +no candidate in acceptable range, skippingGetGridPositionGetGridRingNumIsPosObstructed
icontainsmathabsxyinsertHelperProxySortPosByCenterPosDistanceikeyGetGridPath
BlockFlag	LinkLineMonsterRaceTypeFlyMonsterFlyMonsterLandGetFirstObstacleInPathHasTeamHasPetPstID         �  '  '  '  '  )  )  +  +  -  -  /  0  0  1  1  1  2  2  2  2  5  6  6  6  6  7  7  7  7  7  :  =  =  =  =  ?  ?  ?  ?  ?  A  A  B  B  B  B  C  C  C  C  C  C  D  P  P  P  P  Q  Q  Q  Q  Q  R  R  R  R  R  S  S  S  S  S  S  T  W  W  W  W  Y  Y  Y  Y  Y  ]  ]  ]  ]  ]  ]  _  _  _  _  _  `  `  `  `  `  _  _  c  c  c  c  c  g  g  h  h  i  i  j  j  k  k  l  l  l  l  m  m  m  m  m  l  l  q  q  q  q  t  t  t  t  t  u  u  u  u  v  v  v  v  v  v  w  z  z  }  ~  ~  ~  ~    �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  ~  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                              T   self    �  center    �  currentPos    �  entity    �  casterEntity    �  configService   �  monsterConfigData   �  isTargetMonster   �  monsterIDComponent
   �  
monsterID   �  monsterRaceType   �  
areaArray   �  relativePos   �  utilCalcSvc#   �  currentRingNum(   �  BuffLogicSvc9   �  monsterQuadrantN   �  acceptableRangeY   �  (for generator)]   e   (for state)]   e   (for control)]   e   _^   c   gridPos^   c   casterBodyAreal   �  casterBodyAreaArrayp      casterGridLocationComponentr      
casterPost      (for generator)w      (for state)w      (for control)w      _x   }   areaPosx   }   candidates�   �  
casterPos�   �  preselectCandidates�   �  (for index)�   �   (for limit)�   �   (for step)�   �   i�   �   candidateAbsolutePos�   �   candidateRelativePos�   �   candidateRingNum�   �   fitFullBodyArea�   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   areaPos�   �   areaAbsPos�   �   isNotObstacled�   �   isNotCastCenter�   �   isNotCasterPos�   �   isNotOccupied�   �   isRelativeXLE�   �   isRelativeYLE�   �   
targetPos�   �  sortedByDis�   �  	finalPos�   �  currentFinalPosRingNum�   �  currentFinalPosDisIndex  �  (for generator)  #  (for state)  #  (for control)  #  _  !  pos  !  ringNum  !  	disIndex  !  approachPath'  �  additionalObstacleArray(  �  (for generator)2  :  (for state)2  :  (for control)2  :  _3  8  pos3  8  monsterIDComponent<  �  
blockFlag>  �  obstacledPosd  �  obstacleIndexd  �  
finalPathe  �  
lastIndexh  �  (for index)  �  (for limit)  �  (for step)  �  i�  �     _ENV 	  Q    �   � � @GA� �A@Ɓ@ ���� GB� 䁀�@ �@G@�B@$��N��A �BA���� �A �B�C�� a��  ��B  �� �� � A� �  @�  �� ���BA�  ���BAC  � ��� ���BA� � ���BAC ��B ��B ����   �@ ��(���   �EC �C
@���  �����C@�� ��	䅀�Ņ�$E���EC �C
@���  �D@�� ��	䅀����ń�$E�'��� @�+D� A� ����A	�� h�G���A
����ED @�
� � �D @�$��FGC G��� � d��bG   �FGC G��� � dG�)�  �F�gD�FDC G��� � dD�LE � d��f & �    xyVector2Newmathabs                     �?��������_worldGetServiceMathtableinsert	LerpGetY	LerpGetX%GetPassedGridPositionByIntersectionsipairs
icontainsSnapContinuousPath         �   
                                                                            !  "  $  %  '  '  (  )  +  +  -  .  0  5  5  5  5  7  8  8  8  8  9  9  :  :  :  :  :  :  :  :  :  :  :  :  :  <  <  <  <  <  <  <  <  <  <  <  <  8  @  @  @  A  A  A  A  A  B  C  C  E  E  E  E  F  F  F  F  G  G  G  G  G  G  G  H  H  H  H  H  F  F  A  M  M  M  M  M  O  O  O  P  Q  "   self    �   	posBegin    �   posEnd    �   beginX   �   endX   �   beginY   �   endY   �   vFirst	   �   vLast   �   vDirection   �   	lerpXToY   �   independentVar   �   maxIndependentVar   �   step   �   mathService7   �   intersections8   �   (for index);   X   (for limit);   X   (for step);   X   idv<   W   path[   �   (for index)_   z   (for limit)_   z   (for step)_   z   index`   y   intersection1a   y   intersection2c   y   pointsg   y   (for generator)j   y   (for state)j   y   (for control)j   y   _k   w   posk   w   snappedPath�   �      _ENV S  |   q   � � A� G@�A@Ɓ@ ����@ �@FA GB���d� �A �BA͂��� ��@�FA GB���d� �A� �FA GB����d� �A�FA GB�� d� �A �BA͂A�� ��@�FA GB�� d� �A�� �FA GB���Ad� �A��FA GB���d� �A �BA͂��� ��@�FA GB���d� 
B� �FA GB����d� 
B�FA GB�� d� �A �BA͂A�� ��@�FA GB�� d� 
B�� �FA GB���Ad� 
B��K   �@��B �BB�� ��B�@��B �BB�� ��B��B �BB��  �B�f & � 
   xyVector2zeromathfloor      �?       tableinsert         q   T  U  V  W  Y  Y  Z  Z  \  \  \  \  \  \  \  \  \  \  ]  ]  ]  ]  ]  ]  _  _  _  _  _  a  a  a  a  a  a  a  a  a  a  b  b  b  b  b  b  d  d  d  d  d  g  g  g  g  g  g  g  g  g  g  h  h  h  h  h  h  j  j  j  j  j  l  l  l  l  l  l  l  l  l  l  m  m  m  m  m  m  o  o  o  o  o  r  t  t  u  u  u  u  u  u  w  w  w  w  w  x  x  x  x  x  {  |  
   self    q   intersection1    q   intersection2    q   x1   q   y1   q   x2   q   y2   q   grid1   q   grid2   q   blocks]   q      _ENV   �      F @ G@� ��@  ���@ �J A�� ���@  �@  �J@A���A  ���@ �J A�� ���A  �@  �J@A�f  & �    Vector2zerox               ��������y            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     dir       ret         _ENV �  �   C   �   � @  � � @�_@@�� F�@ G��� ��d��!@�@��A �BA�  ��B� 
��� ���� Ƃ@ ǂ�_�@���A_ � ��BB_ �@��A �B�  F�@ G������CBd��B   ��A �B�  N��B�� ��� �� ���� �A BA@ ��$B��  j���  & �    ipairs       Vector2	Distancetableinsertzerox        yNew          C   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    C   path    C   
finalPath   C   (for generator)   A   (for state)   A   (for control)   A   index   ?   pos   ?   lastPos	   9   	distance   9   dir   9      _ENVGetLogicDirection �  �   #   � @ �@�F�@ G���A �AA� ��$A � \� �� (��B BB@�� �  �$B�'����$� F�B G���A�ACd� ��� ������C� � & �    SortedArrayNew
AlgorithmCOMPARE_CUSTOMAiSortByDistance_ComparerByNearAllowDuplicate       
AINewNodeInsertSortedArraySizemathfloor       GetAtGetPosData         #   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    #   skillRangePos    #   castPos    #   sortPosList   #   (for index)      (for limit)      (for step)      i      totalCount   #   centerIndex   #   centerElement   #   
centerPos!   #      _ENV?                                                                     "   G   "   J   J   J   J   K   K   L   V   L   X   _   X   b   �   b   �   �   �   �   !  �   %    %  	  Q  	  S  |  S  �  �  �  �  �  �  �  �     GetLogicDirection8   ?      _ENV