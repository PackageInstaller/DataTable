LuaS �

xV           (w@E@../PublishResources/lua/product/core_game/logic/svc/board_svc_l.lua         �    @ A@  $@ �@ A�  � A $@��@  ���@ l   
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
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l 	 
@���@ l@	 
@ ��@ l�	 
@���@ l�	 
@ ��@ l 
 
@���@ l@
 
@ ��@ l�
 
@���@ l�
 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ �& � ;   requirebase_service_classBoardServiceLogicBaseServiceConstructorIsValidPiecePosIsPosEmptyExceptConveyor#IsPosEmptyExceptConveyorNoDeadMarkGetMultiBodyAreaMonsterGetFlyMonsterGetValidSummonPos_GetOneValidSummonPos_IsValidSummonPosIsInAIAreaGetPieceTypeGetPieceTypeMapListGetPieceTypeMapListByPosIndexChangeGapTilesGetGapTilesIsPosDimensionDoor
IsPosExitIsObstacleTrapTileGetBoardCenterPosSetBoardCenterPosCanCreateMonsterAtPosGetTrapPosListIsPosListHaveTrapIsBoardPositionsEmptyCreateMonsterGetValidPosGetRandomPiecePos_GetValidPosGetPlayerAreaGetGridTilesGetPlayerAreaPosListGetGridPosByPieceTypeIsPlayerOnDimensionIsDoorGetCanConvertGridElement#GetCanConvertGridElementForTeamPosCanFallGridSetPieceTypeLogic.FindPieceElementByTypeCountAndCenterFromParamCheckBodyAreaInRangeCalcPieceEntitiesGetMonstersAtPosGetEntityMoveBlockFlagSetExtraBoardPosListGetExtraBoardPosListSaveMonsterIDCmptOffBoardApplyPrismUnapplyPrismResetPrismChangeRecordSetSpliceBoardPosListGetSpliceBoardPosListCalcPosRingIsInBoardEdgeInsertListValidPosCalcScopeColOrRowByEdgePos    6              �   
� ��  ��@��@A ǀ��� ������@A ǀ��� �
����@A �@B
����  ��B��@A � ��� ����@A � ��� �
� �& �    	GapTilesAIAreaminX        maxXBattleConstDefaultAIAreaSizeminYmaxYBoardCenterPosPlayerArea       DefaultPlayerAreaSize                  	   
                                                                        self       world          _ENV    "       � � �@� _�@@ ���  �& � �@ � "  ���@ � � "  @ �� &   & & �    xy 
GridTiles                                                                 !   !   "      self       pos       x      y           %   5       � @ �@@�� ��@�� �   �@�� ��$� \ _ �  �CA  C� f & �    _worldGetBoardEntityBoardGetPieceEntities                 )   1       L @ d� b@  � �L@@ d� b   @ �C � f  L�@ d� b   @�L�@ d� L � d� �@A ��A_�� @ �C � f  C   f  & �    HasTeamHasMonsterID
HasTrapIDTrapGetTrapType	TrapType	Conveyor            *   *   *   *   *   *   *   *   +   +   -   -   -   -   -   -   -   -   -   -   -   -   .   .   0   0   1      e          _ENV   '   '   '   '   '   1   3   3   3   3   4   4   4   4   4   4   5      self       pos       
boardCmpt      filter      es
         _ENV 7   J       � @ �@@�� ��@�� �   �@�� ��$� \ _ �  �CA  C� f & �    _worldGetBoardEntityBoardGetPieceEntities                 ;   F    !   L @ d� b   @ �C   f  L@@ d� b@  � �L�@ d� b   @ �C � f  L�@ d� b   @�L A d� L@� d� ��A ��A_�� @ �C � f  C   f  & �    HasDeadMarkHasTeamHasMonsterID
HasTrapIDTrapGetTrapType	TrapType	Conveyor         !   <   <   <   <   =   =   ?   ?   ?   ?   ?   ?   ?   ?   @   @   B   B   B   B   B   B   B   B   B   B   B   B   C   C   E   E   F      e    !      _ENV   9   9   9   9   9   F   H   H   H   H   I   I   I   I   I   I   J      self       pos       
boardCmpt      filter      es
         _ENV N   _       � @ �@@�� ��@�� �   �@�� ��$� GAf & �    _worldGetBoardEntityBoardGetPieceEntities               R   [       L @ d� b    �L@@ d� L�� d� � �  ���@ �� � �  C   f  & �    HasMonsterID	BodyAreaGetArea                  S   S   S   S   T   T   T   T   U   U   U   V   V   Z   Z   [      e       arr             P   P   P   P   P   [   ]   ]   ]   ]   ^   ^   _      self       pos       
boardCmpt      filter      es
           c   t       � @ �@@�� ��@�� �   �@�� ��$� GAf & �    _worldGetBoardEntityBoardGetPieceEntities                g   p       L @ d� b   @�L@@ d� L�� d� ��@ � A�� @ �� � �  C   f  & �    HasMonsterID
MonsterIDGetMonsterRaceTypeMonsterRaceTypeFly            h   h   h   h   i   i   i   i   j   j   j   j   k   k   o   o   p      e       	raceType         _ENV   e   e   e   e   e   p   r   r   r   r   s   s   t      self       pos       
boardCmpt      filter      es
         _ENV w   �    7   �  @ B@@��� $B��@ @�$ �F@ G����� dC�)�  ���A  ��A BA�� $��L�A��dB��@ @�$@�LB �   @ ����d��b   ��C � D ����D����@ Ǆ�	 �@ 	�D����f )�  ���& �    tableappendArrayipairsremovev_worldGetServiceRandomLogicShuffle_GetOneValidSummonPos       insert         7   x   y   y   y   y   y   z   z   z   z   {   {   {   {   {   z   z   }   }   ~   ~   ~   ~            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    7   	posTable    7   	bodyArea    7   posArrayHaveDown    7   nBlockFlag    7   searchRing9    7   	noRandom    7   posList   7   (for generator)	      (for state)	      (for control)	      i
      v
      randSvc      (for generator)   6   (for state)   6   (for control)   6   i   4   pos   4   pos%   4   (for index)*   3   (for limit)*   3   (for step)*   3   i+   2   	posCheck-   2      _ENV �   �    "   �@  � @ ��� �� �    �f  b  @��A@ �� Ɓ@   �@��@ G��C�$��� L@ �   @�� d� b    �& �  j��& �    _IsValidSummonPosGetCurBoardRingMaxipairsVector2                       "   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    "   
centerPos    "   nBlockFlag    "   	bodyArea    "   posArrayHaveDown    "   searchRing9    "   ringMax   !   (for generator)   !   (for state)   !   (for control)   !   i      v      pos         _ENV �   �       A  ���  h��G�MB� �B@ ��@�  �����  @ ��  � g��L�@ ��   @�d��b  @ �C  f C� f & �           table
icontainsIsPosBlockByArea            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
   self       
centerPos       nBlockFlag       	bodyArea       posArrayHaveDown       (for index)      (for limit)      (for step)      i      	posCheck         _ENV �   �       � � �@� _�@@ ���  �& � �@ A!� ���@ AA! ���@ �A!� � ��@ �Aa �  �A  � & & �    xy AIAreaminXmaxXminYmaxY           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       pos       x      y           �   �    
   � @ �@@�� ̀@� ���@� � ��   & �    _worldGetBoardEntityBoardGetPieceType        
   �   �   �   �   �   �   �   �   �   �      self    
   pos    
   boardEntity   
        �   �    
   � @ �@@�� ̀@� ���� %�&  & �    _worldGetBoardEntityBoardGetPieceTypeMapList        
   �   �   �   �   �   �   �   �   �   �      self    
   pos    
   boardEntity   
   
boardCmpt   
        �   �    
   � @ �@@�� ̀@� ���� %�&  & �    _worldGetBoardEntityBoardGetPieceTypeMapListByPosIndex        
   �   �   �   �   �   �   �   �   �   �      self    
   	posIndex    
   boardEntity   
   
boardCmpt   
        �   �       
@ �& �    	GapTiles           �   �      self       GapTilesList            �   �       G @ f  & �    	GapTiles           �   �   �      self            �   �    
   � @ �@@�� ̀@� ���� %�&  & �    _worldGetBoardEntityBoardIsPosDimensionDoor        
   �   �   �   �   �   �   �   �   �   �      self    
   pos    
   boardEntity   
   cBoard   
        �   �    
   � @ �@@�� ̀@� ���� %�&  & �    _worldGetBoardEntityBoard
IsPosExit        
   �   �   �   �   �   �   �   �   �   �      self    
   pos    
   boardEntity   
   cBoard   
        �      X   � @ �@@�� ƀ@ ���� @ ��   �  � @ � A@ AA�A�����A   � ����$� LBd� �BB ��B_��� ��BB ��B�����  ��� �B���$� "  ����$� �C$� F�A � d���D �DD	� �D G�����M��
������$��D  i�  �C� �D CD@ ��$C��A @ $@�G�D��� ��@�GE�� ��@ �C� f )�  ����  jA��   �  & �    _worldGetRunningPositionWorldRunPostionPerformanceGetGroupEntitiesBW_WEMatchersTrapipairsGetTrapType	TrapType	Obstacle
BlockGridGridLocation	Position	BodyAreaGetAreatableinsertVector2xy         X   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         �   �   �   �            self    X   pos    X   	listTrap   X   (for generator)   U   (for state)   U   (for control)   U   _   S   e   S   	trapCmpt   S   	trapType   S   trapPosList    S   trapPos#   S   	bodyArea+   =   (for generator).   =   (for state).   =   (for control).   =   i/   ;   v/   ;   (for generator)F   S   (for state)F   S   (for control)F   S   iG   Q   vG   Q      _ENV 
        G @ f  & �    BoardCenterPos                    self                    
@ �& �    BoardCenterPos                  self       boardCenterPos              '   6   �@  @�� @ �@��  �@ �   �  ��@ � �AA 䀀�A @� $ �L��� d��bB  @ �C  f FB GB�@ �L�B � �B Cd� b  @ �C  f FB GB�@ �L�B � �B �Cd� b  @ �C  f )�  ��� & & �    Logfatal'function Param monsterRaceType is Nil _worldGetService	UtilDataipairsIsValidPiecePosMonsterRaceTypeLandIsPosBlock
BlockFlagMonsterLandFlyMonsterFly         6                                                                             "  "  "  "  "  "  "  "  "  "  "  #  #      &  &  '  	   self    6   posList    6   monsterRaceType    6   	utilData   6   (for generator)   3   (for state)   3   (for control)   3   _   1   pos   1      _ENV *  C   D   K   � @ �@@�� ƀ@ ���� @ ��   �  � @ � A@ AA�A�����A B$ �  �
���$� LBBd� ��B ��B_�������� �BC̂�� �  ��̂�� ���� �A @�$��FD GD��� ƄD �DG�DE
GE�EM��
��dD  )�  �C� ��D �B� � @ �B��  j��f  & �    _worldGetRunningPositionWorldRunPostionPerformance	GetGroupBW_WEMatchersTrapipairsGetEntitiesGetTrapType	TrapType	ConveyorGridLocation	Position	BodyAreaGetAreatableinsertVector2xy         D   ,  -  -  -  -  -  -  -  .  .  0  0  0  0  0  0  1  1  1  1  1  3  3  4  4  5  5  5  5  6  6  6  7  7  7  7  8  8  8  8  9  9  9  9  :  :  :  :  :  :  :  :  :  :  :  :  9  9  ;  =  =  =  =  =  1  1  B  C     self    D   	posTable   D   
trapGroup   D   (for generator)   B   (for state)   B   (for control)   B   _   @   e   @   	trapCmpt   @   	trapType   @   trapPos    @   	bodyArea(   :   (for generator)+   :   (for state)+   :   (for control)+   :   i,   8   v,   8      _ENV G  O      � @ �� �@@  � �  ��@ �@@ ��$��"  @ �� & �  j��   �  & �    GetTrapPosListipairstable
icontains            H  H  I  I  I  I  J  J  J  J  J  J  J  K  K  I  I  N  N  O     self       posList       trapPosList      (for generator)      (for state)      (for control)      k      v         _ENV U  �   e   @ A@$� G@ L����  d��"  ���� � ����A   ��AA  � ����  @ ��  � ��� � @��� �  @ ��  � ��A  � @��� �A  @ ��  � �  �@ ��� BB �B � ���B ���  BCL��d� �A���@ ���� ��� BD @�$ �\ MC���D�� ���)�  ���AD  � �@�CD @ $� ��@ �C  f )�  �C��   @�CD @ $� ��@ �C  f )�  �C��  j���� � & �    _worldGetBoardEntityGetService	UtilDataIsPosListHaveMonsterIsPosListHaveTrapIsPosListBlockWithTrapWallCanCreateMonsterAtPosGetRunningPositionWorldRunPostionPerformance_configServiceGetLevelConfigData       GetPlayerBornPosPlayerGetAllTeamEntitiesipairsGetGridPosition         e   V  V  V  Y  Y  Y  Y  Z  Z  Z  Z  Z  Z  Z  Z  Z  Z  Z  Z  [  [  ^  ^  ^  ^  ^  ^  _  _  a  a  a  a  a  a  b  b  e  f  f  f  f  f  f  f  g  g  g  h  h  h  h  h  h  j  j  j  j  j  k  k  k  k  l  l  l  l  l  k  k  q  q  q  q  r  r  r  r  s  s  t  t  r  r  w  w  x  x  x  x  y  y  z  z  x  x  q  q      �     self    e   posList    e   extendMonsterAreaPosList    e   monsterRaceType    e   boardEntity   e   utilDataSvc   e   playerPosList&   e   levelConfigData0   5   teamEntities;   F   (for generator)>   F   (for state)>   F   (for control)>   F   _?   D   teamEntity?   D   (for generator)I   b   (for state)I   b   (for control)I   b   _J   `   posJ   `   (for generator)M   T   (for state)M   T   (for control)M   T   _N   R   vN   R   (for generator)Y   `   (for state)Y   `   (for control)Y   `   kZ   ^   vZ   ^      _ENV �  �      L@ ��   @�� e f  & �    _GetValidPos           �  �  �  �  �  �  �  �     self       	posTable       	bodyArea       monsterBodyPosArray       monsterRaceType            �  �   E   @ A@$� K  "  ����@�� ��@ A�@��@ @�$��FDA G������A   @���dD  )�  �C��  j�����B �AB�� ́B� �B $� LC d� �B � C ���C ��D ����DA ��A	���A @���$��D  ����B��AA ��C��,  �A���C  �@� � ��� �  & �    _worldGetBoardEntityBoardpairsPiecestableinsertVector2_configServiceGetLevelConfigDataGetPlayerBornPosGetCurBoardMaxXGetCurBoardMaxY       sort_GetValidPos         �  �      � @ �@@ǀ@ �� � � �@��� � �`�   ��@  � � �  & �    xd       y           �  �  �  �  �  �  �  �  �  �  �  �  �  �     a       b           E   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    E   	bodyArea    E   monsterBodyPosArray    E   monsterRaceType    E   boardEntity   E   piecePosTable   E   boardComponent      (for generator)      (for state)      (for control)      x      piece      (for generator)      (for state)      (for control)      y      
pieceType      levelConfigData    8   
playerPos"   8   maxX$   8   maxY&   8   (for index))   8   (for limit))   8   (for step))   8   x*   7   (for index)-   7   (for limit)-   7   (for step)-   7   y.   6      _ENV �     �   �@ �A@�� �  �@ @� $��F�@ G����CA �AG�A��dC  )�  �B�  K  �BA �  ����  @��@ �B�� �B �B_ ����@ ��AC 䂀��$�   �@ @ $��F�C G��D ƄD   � dD  F�@ G����� dD�)�  �C�E $� @ �@ @�$��F�C G��D ƄD   � dD  F�@ G����� dD�)�  �C�@ �E�@ ��E�F$��F�@ �CF� d ������� ��@ ���	 �@ 	�D�i�  ��@���F ��� C�$� � �C DA� ��D � � $C  �@ �D@�� $C���_ ����� bA   �H �� ��$� � ÂK  �   @���@ � �����@ ��	 �FEA ��AǅA	����A�A	��d��D  ��  *D��CH  �D  � ����  ���  �   ��ƃ@  �� ��@ �H
@���	$��"E  ���@ �H
@ ��	$��"E   ��@ �H
@���	$��"E  @ ���	@ ��� @ ��  j��H@���@ ��� � @ �C���C ��	 F�D � d �C  & @���@ �C� �@��C�����@ �CI�� ��C�@��  � & � &   _worldGetBoardEntityipairstableinsertVector2xy        GetRunningPositionWorldRunPostionPerformanceGetService	UtilDataGetAllMonsterPosLognotice#[CreateMonsterPos] BlockPiece Pos:	tostringremovevGetTrapPosList[CreateMonsterPos] Trap Pos:	GetGroupBW_WEMatchersTeamGetEntitiesGetGridPosition_configServiceGetLevelConfigDataGetPlayerBornPos[CreateMonsterPos] Player Pos:       _GetRandomNumberIsBoardPositionsEmpty
icontains Find Valid Pos:remove         �   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                                1   self    �   	posTable    �   	bodyArea    �   monsterBodyPosArray    �   monsterRaceType    �   	noRandom    �   boardEntity   �   piecePosTable   �   (for generator)      (for state)      (for control)      k      p      blockedPieces   �   trapPosTable   �   
playerPos   �   utilDataSvc%   c   (for generator)+   :   (for state)+   :   (for control)+   :   k,   8   pos,   8   (for generator)@   O   (for state)@   O   (for control)@   O   kA   M   posA   M   
teamGroupU   c   (for generator)Y   c   (for state)Y   c   (for control)Y   c   _Z   a   teamZ   a   teamPos\   a   levelConfigDatag   v   indexz   �   pos�   �   bodyPosTable�   �   (for generator)�   �   (for state)�   �   (for control)�   �   k�   �   p�   �   isFind�   �   (for generator)�   �   (for state)�   �   (for control)�   �   k�   �   p�   �      _ENV 
        G @ f  & �    PlayerArea                    self                    G @ f  & �    
GridTiles                    self                 !   G @ L@� ��  d���   ��@ � ��@ AAA� ����@ ����@ BA� ����BB   @ 䂀�� ��$��"  � � �A��������  & �    _worldGetService	UtilDataPlayerAreaminXmaxX       minYmaxYVector2IsValidPiecePos         !                                                                        self    !   	utilData   !   ret   !   (for index)
      (for limit)
      (for step)
      x      (for index)      (for limit)      (for step)      y      pos         _ENV #  (   
   � @ �@@�� ̀@� ���� %�&  & �    _worldGetBoardEntityBoardGetPiecePosByType        
   $  $  $  &  &  '  '  '  '  (     self    
   pieceTypeList    
   boardEntity   
   boardComponent   
        +  8       � @ ��   �  �@@ ��@�� ��@�� � ALA� d �  �@  @ �̀� �@ ��� � �  & �     _worldGetBoardEntityBoardIsPosDimensionDoorGetGridPositionRemoveDimensionFlagHasDimensionFlag           ,  ,  -  -  2  2  2  2  2  3  3  3  3  3  3  4  4  6  6  7  8     self       eTeam       
boardCmpt	      hasDimensionFlag           :  A   
   � @  � ����   @ �� � �  �   �  & �    IsPosDimensionDoor        
   ;  ;  ;  <  <  =  =  @  @  A     self    
   pos    
   isDimensionDoor   
        D  L      b@  @ ��   �  � @  � FA@ G���� �   @ ��   �  � � �  & �    IsPosBlock
BlockFlagChangeElement            E  E  F  F  H  H  H  H  H  H  H  I  I  K  K  L     self       pos          _ENV O  b   '   b@  @ ��   �  � @ �@@�  �����@� �@  @ ��   �  � A @� �AA ��A� �   ����A @� 䀀�@   �� B @� 䀀�   � ��   �  @ �� � �  � � �  & � 	   _worldGetService	UtilDataCanChangePieceToGrayIsPosBlock
BlockFlagChangeElementIsDoor
IsPosExit         '   P  P  Q  Q  U  U  U  U  V  V  V  V  W  W  Z  Z  Z  Z  Z  Z  Z  [  [  [  [  [  [  [  [  [  [  \  \  \  ^  ^  a  a  b     self    '   pos    '   utilDataSvc   '      _ENV e  m      b@  @ ��   �  � @  � FA@ G���� �   @ ��   �  � � �  & �    IsPosBlock
BlockFlag	FallGrid            f  f  g  g  i  i  i  i  i  i  i  j  j  l  l  m     self       pos          _ENV q  u   
   � @ �@�� ̀�� ��� �� $A & �    _worldGetBoardEntityBoardSetPieceElement        
   s  s  s  s  s  t  t  t  t  u     self    
   
pieceType    
   gridPos    
   
boardCmpt   
        }  �   A   F@ � d� _@�� �K� � kA� � �G�@ L��d� ���� �  BA @ $��G�A��AG��b  @�G�A��AG���BG��b  ��FC@ GC�� ǃA�A��B��d��b  ��FC@ G������B �AGB��dC  )�  ���C BC�� ��$B ��\��� ( ����'B�� & �    typetable_worldGetBoardEntityBoardipairsPiecesxy
icontainsinsertVector2HelperProxySortPosByCenterPosDistance                 A   ~  ~  ~  ~  ~          �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    A   
centerPos    A   pieceTypeList    A   	maxCount    A   
pieceList    A   boardEntity   A   board   A   retPieceList   A   (for generator)   4   (for state)   4   (for control)   4   k   2   pos   2   (for index)<   ?   (for limit)<   ?   (for step)<   ?   i=   >      _ENV �  �   *   � � � �@  @ �  & A� $� "A  @ �C  f K  ����� ��@   � ��FA GC�� � d��b   �FA G����� dC��  j���`���  ��A  ��  ���& �    	BodyAreaGetGridPositionGetAreaipairstable
icontainsinsert                 *   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    *   entity    *   range    *   
cBodyArea   *   
v2GridPos   *   tv2AbsolutePosInRange   *   tv2RelativeBody   *   (for generator)   "   (for state)   "   (for control)   "   _       v2RelativeBodyPos       v2AbsoluteBodyPos          _ENV �  �   S   K   � @ �@@@ �@�@���� A AA$ �  @���$� F�A G�� d� �� ���B� J���  j��� @ �@�G@ G��GA�䀀@ A@�@ ��@��B$��LA�d� ��B �C��BA$ �A  �A ������BC� �B  ��̂C� ���� D$� CD$� FA � d ��D���A ��	  	� ń "E    �  \ 
M��

��
J �	i�  ����  *��f  & �    _world	GetGroupBW_WEMatchersTeamipairsGetEntitiesGetGridPositionVector2
Pos2Index
MonsterIDTrapIDtableappendArrayHasOutsideRegionGridLocationGetGridPos	BodyAreaGetArea                S   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    S   posEntities   S   
teamGroup   S   (for generator)      (for state)      (for control)      _      team      teamPos      monsterGroup   S   
trapGroup$   S   es&   S   (for generator)/   Q   (for state)/   Q   (for control)/   Q   i0   O   e0   O   pos8   O   	bodyArea<   O   (for generator)?   O   (for state)?   O   (for control)?   O   i@   M   area@   M   posWorkA   M   	posIndexE   M   tI   M      _ENV �  �      � @ �@@�� ��@�� ��@@� �  � �  & �    _worldGetBoardEntityBoardGetPieceEntities        �  �      L @ e  f   & �    HasMonsterID           �  �  �  �     e              �  �  �  �  �  �  �  �  �  �  �     self       pos       
boardCmpt      es	           �  �   	    �   �@� � �   ��ǀ@ ���A 䀀A�$� L�� d� L��d� �B �����AB ǁ��� ���B � � ���B �@�@ ���B ����  & �            HasMonsterID_worldGetServiceConfigGetMonsterConfigData
MonsterIDGetMonsterIDGetMonsterRaceTypeMonsterRaceTypeFly
BlockFlagMonsterFlyMonsterLand	LinkLine             �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self        entity        	blockVal       configService	      monsterConfigData      
monsterID      monsterRaceType         _ENV �  �      
@ �& �    _extraBoardPosList           �  �     self       ExtraBoard            �  �      G @ b@    �K   f  & �    _extraBoardPosList           �  �  �  �  �  �     self            �     %   G @ L@� � @ ǀ����d���   � A A� $ �  @���$� "  @�L��d� ��A ��B��B �BB�  ��B��  j��� A   � @ ���$B �  j��& �    _world	GetGroupBW_WEMatchers
MonsterIDipairsGetEntitiesOffBoardMonsterSetMonsterIDtableinsertRemoveMonsterID         %   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                 �  �                       self    %   monsterGroup   %   removeList   %   (for generator)      (for state)      (for control)      i      e      offBoardCmpt      monsterIDCmpt      (for generator)   $   (for state)   $   (for control)   $   i    "   e    "      _ENV 	  S   �   � @ �@�� ̀�� �@ A@ $� LA�� d��bA    �& � G@ L���� d���@ ��A ����A�� ��� $��NB �  ���@ 䂀���$À"   ��CC ��C  �����C@ ��� � F�@ G�
+E� � D�$� "D    �  F�D � d����� �
FE GF��� � �   ����E �E ����  @��F �E�  K�  JF���E ��EJ������ �
���J���E���̅�@�
䅀�  @��E FG_ �@��  ��F FF@ ��  �F�������$F�i�  �D� ��� ��G ��� ����D���̄�@ 	䄀��� 	�E �E�$�  
�  @�G���E ��E��
 �"  ��FF GE�
� ��  ʅ��E �E������dE����  @�F�E GE�
_@�	@�"  ��FF GE�
� ��  ʅ�������dE�����@ ��AD �����H�H �C� $��C  ��D � �@�ǄF	�F	L���	  
dE ��  *���C�  @ �C & � &   _worldGetBoardEntityBoardVector2
Pos2IndexIsPrismPieceGetService	UtilDataUtilScopeCalcGetMapByPositionGetPieceTypeGetPrismEntityIDAtPosGetPrismCustomScopeConfigSkillScopeCalculatorNewComputeScopeRangezeroGetAttackRangeipairsIsPosBlock
BlockFlagChangeElement
PieceTypeAnytableinsertpos
pieceTypeoriPieceTypeNone       BattleConstPrismEffectPieceCountTriggerNotifyNTCovCrystalPrismSetPieceElementRecordPrismChangeGrid         �   
  
  
  
  
                                                                                                             !  !  !  !  "  "  "  "  "  "  $  $  $  $  $  $  $  $  $  %  %  %  %  &  '  '  '  (  (  (  (  %  )  +  +  +  ,  ,  ,  ,  ,  ,  ,  ,  -  -  -  -  .  /  0  -  !  !  4  6  6  6  6  6  7  7  8  8  8  9  9  9  9  9  9  ;  ;  ;  ;  ;  ;  ;  ;  ;  <  <  <  <  =  >  >  >  ?  <  @  B  B  B  B  B  B  B  B  C  C  C  C  D  E  F  C  6  L  L  L  L  L  L  L  L  L  L  M  M  M  M  N  O  P  P  P  P  M  M  R  R  R  R  S  &   self    �   prePos    �   	prismPos    �   board   �   posIdx	   �   	utilData   �   
utilScope   �   mapByPosition   �   prismPieceType   �   dir   �   tTargetPieces   �   prismEntityID!   �   
scopeType$   �   scopeParam$   �   calc*   n   result3   n   range8   n   (for generator);   n   (for state);   n   (for control);   n   _<   l   v2<   l   
canChangeB   l   targetPieceType\   l   (for index)s   �   (for limit)s   �   (for step)s   �   it   �   
targetPosv   �   targetPieceTypey   �   
canChange   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   data�   �   
targetPos�   �   
pieceType�   �      _ENV T  W   	   � @ �@@�� ��@�� ��@@� �@�& �    _worldGetBoardEntityBoardUnapplyPrism        	   U  U  U  U  U  V  V  V  W     self    	   	prismPos    	   board   	        X  [      G @ L@� d� L�� d� ��� �@ & �    _worldGetBoardEntityBoardResetPrismChangeRecord           Y  Y  Y  Y  Y  Z  Z  [     self       board           `  b      
@ �& �    _spliceBoardPosList           a  b     self       spliceBoard            d  f      G @ b@    �K   f  & �    _spliceBoardPosList           e  e  e  e  e  f     self            k  w      �� @ ��   �  �@@ ǀ��@ $� LA d �  A @��A (A��A �A@� �B ��$� FB GB�� � d��b    �� '�& � 
           mathmaxGetCurBoardMaxXGetCurBoardMaxY       ComputeScopeRangeComputeRange_SquareRingtableVector2Include            l  l  m  m  o  o  o  o  o  o  o  p  p  p  p  r  r  r  r  r  r  s  s  s  s  s  s  s  t  p  w  	   self       pos1       pos2       	boardLen      (for index)      (for limit)      (for step)      i      range         _ENV z  �      � @ A� ���̀@ GA� 䀀�@ �� $��LAA �� d���A� _  ��A� _@@��� _� � ��� � @ ��� � �  � & �    GetMinYOfColXxGetMaxYOfColXGetMinXOfRowYyGetMaxXOfRowY           {  {  {  |  |  |  }  }  }  ~  ~  ~                          �  �  �  �  �     self       
casterPos       up      down      left	      right           �  �      � @ @ 䀀�    ��@@ ǀ� � @ �@�& �    IsValidPiecePostableinsert            �  �  �  �  �  �  �  �  �  �  �     self       posList       	validPos          _ENV �  �   }   � @ @� 䀀�@  @ ��   �  �   A@ $� L�@ d� ��@ � ����AA G� 䁀�A ��� $��LB ��� d�����  @��BB�� � ����C  �FDC �� ��d��C  ����   @��C  �FCC �� �C d��B  @���� @B@��B �BBC ����C  �FDC �� ��d��C  ����    ��C  �FCC �� � d��B   ��� @B@��B �B�C ����C  �FDC ����� d��C  ����   ���C  �FCC ����� d��B  ���� @ ��B��� � ����C  �FDC ����� d��C  ����   ���C  �FCC �C ��� d��B  �  & �    IsInBoardEdgeGetCurBoardMaxYGetCurBoardMaxXGetMinYOfColXxGetMaxYOfColXGetMinXOfRowYyGetMaxXOfRowY              ��������InsertListValidPosVector2         }   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    }   
casterPos    }   needFinalPos    }   ret   }   maxY
   }   maxX   }   up   }   down   }   left   }   right   }   (for index)   '   (for limit)   '   (for step)   '   i   &   (for index)7   @   (for limit)7   @   (for step)7   @   i8   ?   (for index)P   Y   (for limit)P   Y   (for step)P   Y   iQ   X   (for index)i   r   (for limit)i   r   (for step)i   r   ij   q      _ENV�                                          "      %   5   %   7   J   7   N   _   N   c   t   c   w   �   w   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �   
    
          '    *  C  *  G  O  G  U  �  U  �  �  �  �  �  �  �    �  
    
              #  (  #  +  8  +  :  A  :  D  L  D  O  b  O  e  m  e  q  u  q  }  �  }  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �    �  	  S  	  T  W  T  X  [  X  `  b  `  d  f  d  k  w  k  z  �  z  �  �  �  �  �  �  �         _ENV