LuaS 

xV           (w@\@../PublishResources/lua/product/core_game/logic/svc/auto_fight/pick_up_policy_pet_dina.lua         .    @ A@  $@ @ AÀ   A $@À@  À@ l   
@À@ l@  
@ À@ l  
@À@ lÀ  
@ À@ l  
@À@ l@ 
@ À@ l 
@À@ lÀ 
@ À@ l  
@À@ l@ 
@ À@ l 
@À@ lÀ 
@ &     requirepick_up_policy_base_classPickUpPolicy_PetDiNaPickUpPolicy_BaseCalcAutoFightPickUpPolicy FindPath_MonsterMoveGridByParam _BuildConnectMapByPieceTypeList_CanMatchPieceTypeList_Offset2Index_ConnectMapByPieceTypeList _CalcAllMovePathByPieceTypeList_NextMoveByPieceTypeList_FindPathNearToTarget4_GetPosIndexListByOffset_CalcHighConnectRateCutLen_CalcChainPathComplexityLen        	   =    v    À Ì@@ä ÌÀä ÁÀ K    Ë  A BA $LÂAÀ dÂ¤ ÇBBâB    Á ÃB"C  @ C CCGCbC    A _@Â  CC  C ÂÀ À  ¦  ÆC ÇCÃC ÄCFC GÄC DD	«C ÆD ÇÃÄ  @ äCÄ  A E$ FE GDÅ@@E$ "  ÀÄE$ F$ DF$ F$ À @A DAÄ $LGÀE dÄ b  À Ü À  ÇCÂâC  À  @ & D DG@Ç¤ $D  ÄG  À  @$@  @ & &      
petEntityGetGridPositionCloneactiveSkillID_worldGetServiceConfigGetSkillConfigDataGetSkillPickParam                      
PieceTypeBlue       RedGreenYellowtableremovev
MatchTypeMT_BlackFistHasPetPetGetOwnerTeamEntityTeamGetEnemyTeamEntityUtilScopeCalcSelectNearestMonsterOnPosinsertGetID FindPath_MonsterMoveGridByParam         v                                                                                                                              !   !   !   !   !   !   !   !   !   !   "   "   "   "   "   %   &   &   &   &   &   &   &   (   (   (   (   )   )   )   )   )   )   )   )   )   *   .   .   .   .   /   /   /   /   0   0   0   0   0   1   4   4   5   5   5   5   7   7   7   7   7   7   9   9   9   9   9   9   9   9   :   <   <   <   <   =      self    v   
calcParam    v   
petEntity   v   petPos   v   activeSkillID   v   posList   v   attackPosList   v   targetIDList	   v   
configSvc   v   skillCfgData   v   pickUpParam   v   depth   v   
pieceType   v   canLinkMonster#   v   pieceTypeList3   v   targetEntity9   v   
utilScopeR   \   monsterListV   \   monsterPosListV   \      _ENV C   |    ]     Ë  
ÀË  
À
À@Ë  
À
Á
Á
AÌAB @ äA ÌB @ ä
ÀÌÁB @ À äAÌC @ äÜ  @Ã@ÌÃ ä  @+B  ÌCä ÂC DB $LDÀdb  ÀÂD E_À ÆBE ÇÅ  ä CE E@$ LÃE À F d CF FÀ ¤¢    CCÁ !@C@      
  

À@  

Á
Á
A¦ &     _diNaChainPaths_diNaChainIndexPaths_diNaMoveForward _diNaConnectMap_HighConnectRateCutLen        _maxlen_cutlen _BuildConnectMapByPieceTypeList_CalcHighConnectRateCutLen _CalcAllMovePathByPieceTypeList_FindPathNearToTarget4       GetGridPosition_worldGetService	UtilDataGetPieceType
PieceTypeNoneVector2
Pos2Index_GetPosIndexListByOffsetOffset8table
icontains         ]   E   G   G   H   H   I   J   J   K   L   M   P   P   P   P   R   R   R   R   U   U   U   U   U   X   X   X   X   Z   Z   Z   \   \   ]   ]   ]   ]   `   `   b   b   b   b   c   c   c   d   d   d   d   d   d   e   e   f   f   f   f   g   g   g   g   h   h   h   h   i   i   i   i   i   i   i   j   j   j   n   n   n   o   o   s   s   t   t   u   v   v   w   x   y   {   |      self    ]   casterEntity    ]   targetEntity    ]   pieceTypeList    ]   depth    ]   canLinkMonster    ]   	movePath   ]   pos!   %   
targetPos'   ]   utilDataSvc+   ]   tpPieceType.   ]   endPos6   L   endPosIndex:   L   	posIndex>   L   aroundPosListB   L      _ENV           Ç @ Ì@Àä ÌÀä ÁÀ $ FA GAÁ d A ÁAÌÂ@ äBB À  @$B Â $B&     _worldGetBoardEntityBoardGetGridPositionVector2
Pos2Index
BlockFlag	LinkLineGetBlockFlagCanMoveMap_ConnectMapByPieceTypeListClearBlockFlagCanMoveMap                                                                                             self       entity       pieceTypeList       
boardCmpt      pos      	posIndex      
blockFlag      blockCanMoveMap         _ENV           Æ @ Ç@ÀÀ @ Ã   æ  Æ@ ÇÀÀ  @ å æ   &     
PieceTypeNonetable
icontains                                                      self       type       	typeList          _ENV    ¡       ËÀ  AA    ÁÁ  +AÊ AA  Á  +AÊ A Á Á +AÊ Á MAA& &  	                                                                                                                                                           ¡      self       i       j       t           ¤   ·    /   G@ GAb    &  K  @ A A@ Æ@ ¤ÀÆÂ@ AGCAäÃ@ A@$  Gb  ÀLÃÁÀ dB À  ¤¢  CB ÂGÄÂ¤ JC   @ À ¤C ©  *B÷&     _diNaConnectMapipairsOffset8Vector2              
Pos2IndexGetPieceTypeByIndexCanMatchPieceTypeList_Offset2Indexxy_ConnectMapByPieceTypeList         /   ¥   ¥   ¥   ¥   ¦   ©   ª   ª   ¬   ¬   ¬   ¬   ­   ­   ­   ­   ®   ®   ®   ®   ®   ¯   ¯   ¯   °   °   °   ±   ±   ±   ±   ±   ±   ²   ²   ²   ²   ²   ³   ³   ³   ³   ³   ³   ¬   ¬   ·      self    /   	posIndex    /   pieceTypeList    /   
boardCmpt    /   blockCanMoveMap    /   ct   /   (for generator)   .   (for state)   .   (for control)   .   _   ,   offset   ,   
offsetVec   ,   surroundIndex   ,   surroundPiece   ,      _ENV º   À       À $ FA@ GÀ d  À«A ÌÁ@ @  ÀäA&     GetGridPositionVector2
Pos2Index_NextMoveByPieceTypeList            »   »   ¼   ¼   ¼   ¼   ½   ½   ½   ¿   ¿   ¿   ¿   ¿   À      self       casterEntity       pieceTypeList       depth       pos      startPosIndex      chainPathIdx	         _ENV Â          À  &    GA@ Gb  @@ Á@À¤  @  &   ÁA  ¨  _  &  B¢  Æ@ ÇÁ  @ äâB  ÀÜ ÍÁJÆ@ ÇÂÁ  A ä
ÂÃB  À Á$CCB "  @   
 Ã  A  Á h\ MÁDC C	Ç ¤ 
gÃýF@ GÁÃC À db    &  GD D  AJGÃC ÃC  AÆ@ ÇCÄ  ä JÃF@ GÃÁ Á d 
E   ¤
 A   J@EF@ GÃÁ Á dD \ CEÀ GÃD Ã ( J@EF@ GÄÁ Á d'Ãý§Áã&             _diNaConnectMaptablecount              
icontainsconcat _diNaMoveForward_NextMoveByPieceTypeList Vector2
Index2Pos_diNaChainIndexPaths_diNaChainPaths
cloneconf_maxlen_cutlen_CalcChainPathComplexityLen        ÿÿÿÿÿÿÿÿ            Ã   Ã   Ä   Ç   Ç   É   É   Ê   Ê   Ê   Ê   Ê   Ê   Ê   Ê   Ë   Î   Î   Î   Î   Ð   Ð   Ð   Ð   Ñ   Ó   Ô   Ô   Ô   Ô   Ô   Ô   Ô   Ô   Ô   Õ   Õ   Õ   Ö   Ö   Ö   Ö   Ö   Ø   Ù   Ù   Ù   Ù   Ù   Û   Û   Û   Û   Û   Û   Ü   Þ   ß   ß   ß   ß   à   à   à   à   à   à   à   ß   â   â   â   â   â   â   â   ã   å   å   å   å   å   æ   æ   æ   æ   æ   æ   æ   æ   æ   ç   ç   ç   ç   ç   ë   ë   ì   ì   ì   ì   ð   ð   ð   ð   ð   ñ   ò   ó   ó   ó   ó   ó   ø   ø   ø   ø   ø   ù   ù   ù   ù   ú   û   ü   ü   ü   ü   ü   ù   Î        self       chainPathIdx       pieceTypeList       depth       startPosIdx      ct      (for index)      (for limit)      (for step)      i      posIdx      s+      
chainPath9   f   (for index)<   E   (for limit)<   E   (for step)<   E   n=   D   s`   f   lenl   r   sr   r   (for index)z      (for limit)z      (for step)z      n{      len|      s         _ENV   4   >    @ Ì@À ä @ Á@@$ LA À   d   ÁA B FA ÂA d B CBÀ ¤Ü  À Ü   Ü_À@ i  êüFB B   @   ÆA ÃB äF@ GÃ Àd @@ @ é  jü @ ÇÂB ¦ &     Offset4GetGridPositionVector2
Pos2Index_GetPosIndexListByOffset        ipairs_diNaChainIndexPathstableunionMAX_INT_32_diNaChainPaths	Distance         >     	  	  
  
  
  
                                                          !  !  "  "  %  %  %  %  &  &  '  '  '  '  '  (  (  )  *  %  %  /  /  0  0  3  4     self    >   targetEntity    >   offsetList   >   
targetPos   >   	posIndex   >   highValuePosIdxList   >   retPath   >   unionCount   >   	retIndex   >   (for generator)   !   (for state)   !   (for control)   !   i      chainPathIdx      targetInPath      disMin"   >   chainPathIndex#   >   (for generator)*   8   (for state)*   8   (for control)*   8   i+   6   
chainPath+   6   	chainPos-   6   dis2   6      _ENV 8  @      Ë   @ @ $@FB@ @ÇÂ@dB@ AÀ¤  ÆBA ÇÁ @ äB)  ªÁûæ  &     ipairsVector2              
Pos2Indextableinsert            9  :  :  :  :  ;  ;  ;  ;  <  <  <  <  <  =  =  =  =  =  :  :  ?  @     self       	posIndex       offsetList       posIndexList      (for generator)      (for state)      (for control)      _      offset      
offsetVec	      index         _ENV C  f   .    @ Ì@À ä @ Á@@$ K   Á   l   @  dB RÂ ÆBA ÇÁâ   ÁÂ âB    Á CA CB ÀCA BÃ @@ CA ÂBC CCA ÁÃ  $C¦ &     _diNaConnectMapGetGridPositionVector2
Pos2Index        BattleConstAutoFightMoveEnhanced              AutoFightPathLengthCutPosNum"AutoFightPathLengthCutConnectRateAutoFightPathLengthCutLogdebug6[AutoFight] _CalcHighConnectRateCutLen() totalPosNum= ConnectRate=         M  Z   	    @ E  M@À I  F  @  Á  A  ¨ÀA ¢   ÅÍAÀÉÆ âA   Å   äA §ü&                             N  O  O  O  P  Q  Q  Q  Q  R  S  S  T  T  T  U  U  U  V  V  V  Q  Z     	posIndex       ct      (for index)      (for limit)      (for step)      i	      nextIdx
         	touchIdxtotalPosNumconnectMaptotalConnectsearch.   D  E  E  F  F  F  F  H  I  J  L  Z  Z  \  \  \  ]  ^  _  _  _  _  _  _  _  _  `  `  `  `  a  a  a  a  a  b  b  d  d  d  d  d  d  d  e  f     self    .   casterEntity    .   connectMap   .   
playerPos   .   playerPosIndex   .   	touchIdx   .   totalConnect	   .   totalPosNum
   .   search   .   rate   .   cutlen   .   idx   .      _ENV h  w   $    @  @  @ ¦  @ À@¢      ¢@    @ Á@  FA  d ÂA BÇBB ÇB¤ Ï@ B  À @ AA@ i  êü& &     _HighConnectRateCutLen        BattleConstAutoFightMoveEnhanced              ipairstablecount_diNaConnectMapAutoFightPathComplexity         $   i  i  i  j  j  l  l  l  l  l  l  l  l  m  n  o  o  o  o  p  p  p  p  p  p  q  q  q  q  q  r  r  o  o  v  w  
   self    $   chainPathIdx    $   m   $   cc   $   len   $   (for generator)   "   (for state)   "   (for control)   "   i       idx          _ENV.                              	   =   	   C   |   C                        ¡      ¤   ·   ¤   º   À   º   Â     Â     4    8  @  8  C  f  C  h  w  h  w         _ENV