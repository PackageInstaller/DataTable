LuaS �

xV           (w@H@../PublishResources/lua/product/core_game/logic/svc/pop_star_svc_l.lua         a    @ A@  $@ �@ A�  � A $@��@  ���@ l   
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
@��& � "   requirebase_service_classPopStarServiceLogicBaseServiceConstructorGetPopStarLogicComponentGetPopGridNumAddPopGridNumGetChallengeIndexSetChallengeIndexGetTrapRandomDataSetTrapRandomDataGetTrapRandomCountAddTrapRandomCount
AddPropIDGetPropIDByPopNum_GetChallengeScoreByIndex_GetChallengeIndexByScoreGetPopStarStageInfo_CalculateChallengeStateCalculatePopStarConnectPiecesGetPopConnectPiecesSetPopConnectPiecesCalculatePopPiecesCalculate3StarProgressDoParseTrapRefreshDataDoParsePropRefreshData_DoParsePropRandomData_CalculateNewTraps_CalculateNewPropTrap_CalculateNewSpecialTrap_RandomSpecialTrapID_CalculateDestroyTrapAndPiece        
          
@ �& �    _world                    self       world                      G @ L@� d� L�� d� f  & �    _worldGetBoardEntityPopStarLogic                                   self       
component                  	   L @ d� b@    �& � �@� �  �   & �    GetPopStarLogicComponentGetPopGridNum        	                                 self    	   
component   	           '    	   � @ �� �@    �& � �@@@� �@�& �    GetPopStarLogicComponentAddPopGridNum        	   !   !   "   "   #   &   &   &   '      self    	   num    	   
component   	        )   1    	   L @ d� b@    �& � �@� �  �   & �    GetPopStarLogicComponentGetChallengeIndex        	   +   +   ,   ,   -   0   0   0   1      self    	   
component   	        3   ;    	   � @ �� �@    �& � �@@@� �@�& �    GetPopStarLogicComponentSetChallengeIndex        	   5   5   6   6   7   :   :   :   ;      self    	   index    	   
component   	        =   E    	   L @ d� b@    �& � �@� �  �   & �    GetPopStarLogicComponentGetTrapRandomData        	   ?   ?   @   @   A   D   D   D   E      self    	   
component   	        G   O    
   � @ � �@    �& � A��� � $A & �    GetPopStarLogicComponentSetTrapRandomData        
   I   I   J   J   K   N   N   N   N   O      self    
   totalWeight    
   trapRandomTab    
   
component   
        Q   Y    	   L @ d� b@    �& � �@� �  �   & �    GetPopStarLogicComponentGetTrapRandomCount        	   S   S   T   T   U   X   X   X   Y      self    	   
component   	        [   c    	   � @ �� �@    �& � �@@@� �@�& �    GetPopStarLogicComponentAddTrapRandomCount        	   ]   ]   ^   ^   _   b   b   b   c      self    	   trapID    	   
component   	        e   m    
   � @ � �@    �& � A��� � $A & �    GetPopStarLogicComponent
AddPropID        
   g   g   h   h   i   l   l   l   l   m      self    
   num    
   propID    
   
component   
        o   w    
   � @ �� �@    �& � �@@@� � ��   & �    GetPopStarLogicComponentGetPropIDByPopNum        
   q   q   r   r   s   v   v   v   v   w      self    
   num    
   
component   
        y   �       � @ �@@��@��@� A�@A�A �A� B"  � �\  @�@ �AA f GA f & � 
   _worldBW_WorldInfoclientCreateInfopopstar_mission_info       mission_idCfgcfg_popstar_missionChallengeIndexScoreList                    {   {   {   {   {   |   ~   ~   ~   ~                  �   �   �   �   �      self       index       popStarCreateInfo      
missionID      cfgList
         _ENV �   �       � @ �@@��@��@� A�@A�A �A� BFAB � d� � @�   �& i�  ��\ f & � 
   _worldBW_WorldInfoclientCreateInfopopstar_mission_info       mission_idCfgcfg_popstar_missionChallengeIndexScoreListipairs            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
   self       score       popStarCreateInfo      
missionID      cfgList
      (for generator)      (for state)      (for control)      index      	cfgScore         _ENV �   �       L @ d� �@@  � �����   @��� �A@ ��� $���   � @ ��& & �    GetChallengeIndex_GetChallengeScoreByIndex                          �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       index      challengeScore      	preScore           �   �    	   G @ G@� G�� G�� G � �@� �@  @ ��   �  ��A �� �A $� ! �@�LB � d�� @ ��AB  ��A��� � C  f & � 
   _worldBW_WorldInfoclientCreateInfopopstar_mission_info       is_challengeGetPopStarStageInfoGetPopGridNum_GetChallengeIndexByScoreSetChallengeIndex           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       popStarCreateInfo      index      score      	curScore      
nextIndex           �   �    #   � @ �@@�  �����@@� 䀀A$� K  �AA � �@ ��  J����  *���  ƁA ���  @� �A��� ���B� ʁB�   �@� ��$B�� & �    _worldGetService	UtilDataGetPieceTypeGetReplicaBoardPiecespairstableinsertxy         �   �    2   � @ �@@ � �
�Ɓ@ �@ GABGBA ��AM��䁀� �A��$��"   �� B��$��FBB � � d���������B����B  ��b   ���B ��B�  ��B��������B����� �� � �B���  *��& �    ipairsOffset4Vector2x       y       IsValidPiecePosGetPieceTypePopStarCanMatchPieceTypetableinsert         2   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
   center    2   next    2   (for generator)   1   (for state)   1   (for control)   1   _   /   offset   /   pos   /   connectPieceType   /   pieceMatch   /      _ENVutilDataSvc
pieceTypeconnMapconnectPieces#   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    #   gridPos    #   utilDataSvc   #   
pieceType   #   pieces	   #   connMap
   #   (for generator)      (for state)      (for control)      x      _      connectPieces   #   searchConnectPiece   #      _ENV �   �    	   L @ d� b@    �& � �@� �  �   & �    GetPopStarLogicComponentGetPopConnectPieces        	   �   �   �   �   �   �   �   �   �      self    	   
component   	        �   �    	   � @ �� �@    �& � �@@@� �@�& �    GetPopStarLogicComponentSetPopConnectPieces        	   �   �   �   �   �   �   �   �   �      self    	   connectPieces    	   
component   	        �   K   '�   � @ �@@�  �����@ � �� A��� $A�@ A@�� $��L�Ad� �B �A���@ ��A   �ƁB � A 䁀���� BC @� $��L�C��C ��  d� b  � ��� ���  ��A�)�  ���� �L�D d� ��D   �B���  �B���D �� �BE � �  @ ���$C @ C@�� $��LF�CF ��� dC  L�F �� dÀ���@��C��@ �C�A 䃀D�$D ��� � $���@ �D���@ 	�D��D�@��D��@ ̄�	� ��	$� FEC ��d ���G�F�B �����IǇ���d��F  i�  ��FEC � 	d ���G�F�B �G���I�G���d��F  i�  ��l  �  �EC   	����J
�����
$� FGC � d �� �HD��  �H������I�������H�I��H���� 	�G���I��H�i�  ���  j�����@ �E��L @���� 䅀F���$F�@ F@�� $��LFƆL ��@ ��dF  �  & � 3   _worldGetService	UtilDataDataPopStarResultNewSetPopConnectPiecesAffixReplacePieceRefreshTypePieceRefreshTypeFallingDownVector2        ��������ipairsFindTrapByTypeAndPos	TrapTypePopStar_Super       GetPopGridNumAddPopGridNum
SetPopNum_CalculateChallengeStateSetIndexChangeTriggerNotifyNTPopStarScoreChange_CalculateDestroyTrapAndPieceSetDelTrapListBoardLogicSyncGridTilesColorPopStarGridByFallDir
SetDelSetSetMoveSet
SetNewSetGetBoardEntityBoardSetPieceTypeLogiccolorposxytoGetPieceEntitiesfromentitySetGridPositionUpdateEntityBlockFlagSetMoveTrapList_CalculateNewTrapsSetNewTrapListNTPopStarEnd         3  5      L @ d� b    �L@@ d� L�� d� b   � �L�@ d� [ � f  & �    
HasTrapIDTrapFallWithGridHasDeadMark           4  4  4  4  4  4  4  4  4  4  4  4  4  4  5     e           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                    �   �                 	  	  	  
  
                                                                    !  !  !  "  "  "  #  #  #  &  &  &  (  (  +  +  +  +  ,  ,  ,  ,  ,  ,  ,  ,  ,  +  +  .  .  .  .  /  /  /  /  /  /  /  /  /  .  .  5  6  7  7  7  7  8  8  8  8  9  9  9  9  :  :  :  :  :  :  :  :  :  ;  ;  ;  <  <  <  <  <  9  9  7  7  ?  ?  ?  B  B  B  B  B  C  C  C  G  G  G  G  H  H  H  H  H  H  J  K  4   self    �   connectPieces    �   utilDataSvc   �   result   �   	affixSvc   �   refreshType   �   fallingDir   �   superGridNum   �   (for generator)   -   (for state)   -   (for control)   -   _    +   pos    +   trapIDList%   +   popNum/   �   	oldScore1   �   	newScore9   �   isIndexChange;   �   triggerSvcC   �   destroyTrapListK   �   posListK   �   boardLogicSvcR   �   delSetX   �   newSetX   �   moveSetX   �   boardEntityd   �   
boardCmptf   �   (for generator)i   u   (for state)i   u   (for control)i   u   _j   s   vj   s   (for generator)x   �   (for state)x   �   (for control)x   �   _y   �   vy   �   filter�   �   
moveTraps�   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   v�   �   es�   �   (for generator)�   �   (for state)�   �   (for control)�   �   i�   �   e�   �   	newTraps�   �   triggerSvc�   �      _ENV M  ^      G @ L@� ��  d��� @ ��@�� � � G@ GA�G��䀀@ A@�� $��FB ��d���BB ����̂B@�� �B i�  ��& �    _worldGetServiceConfigBattleStatGetPopStar3StarConditionBW_WorldInfo
missionID
Star3CalcipairsCalcProgressUpdateA3StarProgress            O  O  O  O  R  R  R  U  U  U  U  U  Y  Y  Y  Y  Z  Z  Z  Z  [  [  [  \  \  \  \  Z  Z  ^     self       configService      battleStatCmpt      threeStarConditions      star3CalcService      (for generator)      (for state)      (for control)      _      conditionId      ret         _ENV `  {   >   b@    �& � � @ �@@�@ �@  @�ƀ@ ��� @� �@�& � �@A�A �AGB$� F�A G���ABd� ��A ��AǁB�� � � �� ��  _ �@�Ɓ@ ���� @� �A�& � �  C @ $ �K�  J���ÂJ����J������D�A)�  ��BD ����$B & �    Cfgcfg_popstar_trap_refreshLog
exception1ParseTrapRefreshData error!!! trap refresh ID = TotalWeighttable
cloneconfTrapIDListWeightListCountLimitListBParseTrapRefreshData list size is not match!!! trap refresh ID = ipairstrapIDweightcountLimit       SetTrapRandomData         >   a  a  b  d  d  d  e  e  f  f  f  f  f  g  j  k  k  k  k  l  l  l  l  m  m  m  m  o  o  o  o  o  o  o  o  p  p  p  p  p  q  t  u  u  u  u  v  v  v  v  v  v  w  w  w  u  u  z  z  z  z  {     self    >   trapRefreshID    >   cfgRefresh   >   totalWeight   >   trapIDList   >   weightList   >   countLimitList   >   trapRandomTab*   >   (for generator)-   9   (for state)-   9   (for control)-   9   index.   7   trapID.   7   trapRandomData4   7      _ENV }  �      b@    �& � �   � @  � � ��B@ �@�"B  @�F�@ G��B ��dB�� �L�A �   dB �  j��& �    ipairsCfgcfg_popstar_prop_refreshLog
exception1ParsePropRefreshData error!!! prop refresh ID = _DoParsePropRandomData            ~  ~    �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  	   self       refreshIDList       popNumList      (for generator)      (for state)      (for control)      _      ID      cfgProp         _ENV �  �   7   � @ �@�A�  䀀�@ G� $�
�\ _@�@�F�A G��� �B� dB���G�B�BA��  !����F�B G�� ��d��bC  � �\ M��
Â͂�@�\  @��@�L����  d� �C��B ���  @ �C��D @ �D� �C )�  �A�& �    _worldGetServiceRandomLogicipairsPopNumRandomInterval       Log
exceptionKParsePropRefreshData PopNumRandomInterval size error!!! prop refresh ID = ID       table
icontains        
LogicRandinsert
AddPropIDTrapID         7   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    7   cfgProp    7   popNumList    7   
randomSvc   7   (for generator)   6   (for state)   6   (for control)   6   _   4   randomInterval   4   min   4   max   4   curNum   4   randomList   4   index*   4   popNum+   4      _ENV �  �        b   � �\�  �  �& LA@ �  � @ ��dA L�@ �  � dA & & �            _CalculateNewPropTrap_CalculateNewSpecialTrap           �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       newSet       	oldScore       	newScore       	newTraps           �  �   R   M��  ! �@��A@ @�䁀�  � � @��M���� ��  �f  ��@ ��  � BA �A�� $��GBA L��� d���BA ��AC ���ƂB   ��	��_�@�	��B�  ��$� G��� �GE���C ��    ����  �   ��� ��	�  
���G�
E�GE�
E��J �	�DD	GE��D�̄D@ 	���E��D���@ ���	 �@ �D��  jC�f  & �           GetPropIDByPopNum        table
cloneconf_worldGetServiceRandomLogic
TrapLogicBoardLogicipairs
LogicRandCreateTrapposVector2entityfromSetGridPositionUpdateEntityBlockFlagremove         R   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    R   	newTraps    R   newSet    R   	oldScore    R   	newScore    R   curNum   R   newPropIDList   R   propID      newSetCopy   R   
randomSvc   R   trapSvc   R   boardLogicSvc"   R   (for generator)%   P   (for state)%   P   (for control)%   P   _&   N   ID&   N   index-   N   posData.   N   trapEntity6   N      _ENV �     6   � @ �@�  � �@ �@� $��G�@ L���A d����A ���@���A � �  @�B���CB�B A� � $�$�  "  ��\� M���  ���ǃC����CB�Ã�J��L�C�CBdC�L�� �CGDBdC�LCD ��dC���  *��f  & �    table
cloneconf_worldGetService
TrapLogicBoardLogicipairs_RandomSpecialTrapIDCreateTrapposVector2               entityfromSetGridPositionUpdateEntityBlockFlagAddTrapRandomCount         6   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �         self    6   	newTraps    6   newSet    6   newSetCopy   6   trapSvc   6   boardLogicSvc   6   (for generator)   4   (for state)   4   (for control)   4   _   2   posData   2   trapID   2   trapEntity   2      _ENV      #   L @ d� b   @ �@�   �& � �   �@ �@� $��LAA��  � d� ��A � ����BN��!@����BB � �B  �� ���B@ ���  *���  & �    GetTrapRandomData        _worldGetServiceRandomLogic
LogicRand       ipairsweightGetTrapRandomCountcountLimittrapID         #   	  	  
  
  
  
                                                               self    #   totalWeight   #   randomDataTab   #   trapID   #   
randomSvc   #   randomIndex   #   (for generator)   !   (for state)   !   (for control)   !   _      data         _ENV   Q   s   � @ �@@�  ����     F�@ �� d���� �AFCA G����� �  �� �B CB@���$C�A�CA ��B��$� \  @�� �FB GC���� dC�LA�CA ��� �d� �� ��� ��B �CB�� ��C��ADA C@��� �  ���@��B �C� �@ �C��  �CC@�䃀�  ��@�B DB@���$D��  �  �� �CF�C ���D�d��
Ai�  ��\� @�� �G@ LA��� d����@ ������   ���D� ��AC �� �B ̂�@ �B���  *��@�� f�& �    _worldGetService	UtilDataipairsFindTrapByTypeAndPos	TrapTypePopStar_Prop        tableappendArrayPopStar_RunePopStar_SuperPopStar_LockFindMaintainColorTrapByPos       Vector2xy
TrapLogicAttributesModifyHPAddTrapDeadMark         s   !  !  !  !  "  #  $  $  $  $  %  &  &  &  &  &  '  '  '  (  (  (  (  (  +  +  +  +  +  ,  ,  ,  -  -  -  -  -  0  0  0  0  0  1  1  1  2  2  2  2  2  4  4  4  4  4  5  5  5  6  6  6  6  6  7  :  :  :  ;  ;  ;  <  <  <  <  <  =  ?  ?  @  @  @  @  @  @  @  $  $  E  E  E  G  G  G  G  H  H  H  H  I  I  J  J  J  J  J  J  K  K  K  H  H  P  P  P  Q     self    s   connectPieces    s   utilDataSvc   s   destroyTrapList   s   posList   s   (for generator)	   W   (for state)	   W   (for control)	   W   _
   U   pos
   U   	addPiece   U   propTrapList   U   runeTrapList   U   superTrapList*   U   lockTrapList7   U   maintainColorTrapListC   U   trapServiceLogic^   o   (for generator)a   o   (for state)a   o   (for control)a   o   _b   m   trapEntityb   m      _ENVa                              
      
                        '      )   1   )   3   ;   3   =   E   =   G   O   G   Q   Y   Q   [   c   [   e   m   e   o   w   o   y   �   y   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   K  �   M  ^  M  `  {  `  }  �  }  �  �  �  �  �  �  �  �  �  �    �          Q    Q         _ENV