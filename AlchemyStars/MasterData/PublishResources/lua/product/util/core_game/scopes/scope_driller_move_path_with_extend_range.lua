LuaS 

xV           (w@e@../PublishResources/lua/product/util/core_game/scopes/scope_driller_move_path_with_extend_range.lua         %    @ A@  $@ @ AÀ   A $@À@  À@ l   
@À@ l@  
@ À@ l  
@À@ lÀ  
@ À@ l  
@À@ l@ 
@ À@ l 
@À@ lÀ 
@ À@ l  
@&     requirescope_base_class4SkillScopeCalculator_DrillerMovePathWithExtendRangeSkillScopeCalculator_Base
CalcRangeCalMoveResultList_CalcMovePosFindNewTargetPosComputeWalkRangeFindNewWalkPosFindPosByNearCenterFindPosValidIsPosAccessible    	    	   5   	 ![   G@ GBÀGÀ
@
 
 BA¢B     ÇB
ÀË  CB  À $ À   FB GÃÂ ÀdCFC LCÃÇ@ ÇCÀdC¢C  À  ÄË A  ëCÃ¢  	ÇÃCDDFÄD d
ÌÅ@ À   @ À  ä FÅ$ FÆD  dÀB EÀ  ¤¢G   B ÇEÀ  ¤Gi  êFüi  ê÷ÆF ÌCÃFDF GÆÀ  ä æ &     _hub_gridFilter_worldcasterEntitym_entityOwn	moveStep       _trapIDListtrapIDListCalMoveResultListtableappendArraySkillScopeCalculatorNewextendScope
scopeType       scopeParam        ipairsComputeScopeRangeGetAttackRange
icontainsinsertSkillScopeResultSkillScopeTypeDrillerMovePathWithExtendRange         [                                                                                               !   !   !   !   !   !   !   !   !   !   !   "   "   #   $   %   %   %   %   &   '   '   '   (   (   (   (   )   )   '   *   *   +   +   +   +   ,   ,   ,   ,   ,   ,   ,   -   -   -   -   -   +   +   %   %   3   3   3   3   3   3   3   3   4   5      self    [   
scopeType    [   scopeParam    [   
centerPos    [   	bodyArea    [   
casterDir    [   nTargetType    [   
casterPos    [   casterEntity    [   world   [   	moveStep
   [   posWalkList   [   totalPosList   [   calc   [   extendScopeParam(   [   
scopeType+   Q   scpoeParam,   Q   (for generator)/   Q   (for state)/   Q   (for control)/   Q   index0   O   walkPos0   O   transCenterPos1   O   result;   O   extendRange=   O   (for generator)@   O   (for state)@   O   (for control)@   O   extendIndexA   M   
extendPosA   M   resultY   [      _ENV 8   S    /   Ì À ä A@ @Á  $GA@ LÀÁ dA  ¤

À  ÆB ÇAÂ  @äAÁ   A èÌÂB @ BÇÃA äC@ C$ CC$ _Ã@
ÀFB GCÂ ÀdCçÁú¦ &     GetGridPosition_worldGetService	UtilCalcBoardLogic_tarPosFindNewTargetPos	_lastPostableinsert       _CalcMovePosGetBoardEntityAIRecorder          /   9   9   ;   ;   ;   ;   =   =   =   =   >   >   >   >   ?   @   A   A   A   A   A   B   B   B   B   D   D   D   D   D   D   G   G   G   G   G   H   H   J   O   O   O   O   O   B   R   S      self    /   casterEntity    /   	moveStep    /   
casterPos   /   utilCalcSvc   /   sBoard
   /   posWalkList   /   (for index)   -   (for limit)   -   (for step)   -   i   ,   posWalk   ,   aiRecorderCmpt$   ,      _ENV V   i        G@ @@   ¦ A@   @  ¤Ì@ @ À äâ  À  @   & æ &     _tarPosComputeWalkRangeFindNewWalkPos           X   Z   ]   ]   ^   ^   b   b   b   b   b   c   c   c   c   c   e   e   e   e   f   f   h   i      self       entityWork       nWalkTotal       curPos       posSelf      
posTarget      posWalkList      posWalk           k       3    @ À  A@ @Á  $LAÇAA dA@ @ ¤ÆÁA ÌÂ@ äBB B$LBÆÂB ÇÃC  
@CA C¤ ÃC¤ ÇCA ÌÄä DD D@DA d ÌÂÄä â  À     BÅ¦ &     _trapIDList_worldGetServiceBoardLogicGetEntityMoveBlockFlagm_entityOwnUtilScopeCalcSkillScopeCalculatorNew*SkillScopeCalculator_DrillerMoveTargetPos
CalcRangeSkillScopeTypeDrillerMoveTargetPostrapIDList	BodyAreaGetAreaGetGridDirectionSkillTargetTypeBoardGetAttackRange                        3   l   o   q   q   q   q   r   r   r   t   t   t   t   u   u   u   u   w   w   w   w   z   {   {   {   |   }   ~   ~   ~   ~   ~                        z                                       self    3   curPos    3   tarTrapIDList   3   posSelf   3   boardServiceLogic   3   
blockFlag	   3   utilScopeSvc   3   skillCalculater   3   
scopeCalc   3   scopeResult(   3   tarPos)   3   range+   3      _ENV        
   â@    Ã     â   F@ LAÀÁ  Â@ @  d FA GAÁ Á    @ ef  &     	CallbackNew       IsPosAccessibleComputeScopeRangeComputeRange_WalkMathPos                                                                                 self       
centerPos       
nWalkStep       bFilter       	cbFilter         _ENV        
   @  À  AB  % &  &     FindPosByNearCenter                                             self       
walkRange       
posCenter       posDef                ¸    >   _@ @FA@ GÀ d !ÀÀ  æ  GA LAÁÁ dÁA BBB BFÂB GÃ¤ ÌACäA ÇC Â \ Â (ÂÃ LDd _À_ À CD¤  Ä @ÄD ¤_À@ EÀÆCE ÇÅ  @ ÀäCÀÿ'øÂE  À% &  &      tablecount        _worldGetService	UtilDataSortedArrayNew
AlgorithmCOMPARE_CUSTOMAiSortByDistance_ComparerByNearAllowDuplicate	_lastPos       GetPosGetStepIsBlockMoveWithTrapWallcasterEntity 
AINewNodeInsertSortedArrayFindPosValid         >   ¡   ¡   ¡   ¡   ¡   ¡   ¡   ¡   ¢   ¥   ¥   ¥   ¥   ¦   ¦   ¦   ¦   ¦   ¦   ¦   §   §   ¨   ©   ©   ©   ©   «   ¬   ¬   ­   ­   ­   ­   ­   ­   ­   ­   ¯   ¯   ¯   ¯   ¯   °   °   °   °   ±   ±   ±   ±   ±   ±   ±   ±   ©   ·   ·   ·   ·   ·   ¸      self    >   listPlanPos    >   
posCenter    >   posDef    >   nCheckStep    >   utilDataSvc   >   	listWalk   >   lastMovePos   >   (for index)   8   (for limit)   8   (for step)   8   i   7   posData   7   posWalk   7   isBlockMoveWithTrapWall+   7      _ENV »   Ñ       _@ À Ì@À ä !À  ¦  À   LAÀ d Á  ÀÂ  ¨AÁ  ¤ÌBA GAäÀ@ A  §ý& &      Size               GetAtIsPosAccessibledata           ¼   ¼   ¼   ¼   ¼   ¼   ½   ¿   À   Á   Á   Â   Â   Â   Â   Ä   Ä   Ä   Å   Å   Å   Æ   Æ   Ç   Ç   Â   Ð   Ñ      self       planPosList       defPos       posSelf      
posReturn	      
nPosCount      (for index)      (for limit)      (for step)      i      posWork      bAccessible           Õ   è    2   @@ @¤  @   ¦  À@  AA ¤Ç@@ ÌÁä ÁÁ$ GA@ LÂÀ dA@ BB@ BB$ ¤  Á A èÁÇÃB C@ $"C  ÀCCÀ $ "  @   & çûÃ æ &      casterEntityHasBodyArea_worldGetServiceBoardLogic
MonsterIDGetMonsterBlockDataGetCoverAreaListGetGridPosition       table
icontainsIsPosBlock         2   Ö   Ö   Ö   Ö   Ö   ×   ×   Ú   Ú   Ú   Ú   Û   Û   Û   Ü   Ü   Ý   Ý   Ý   Ý   Þ   Þ   Þ   Þ   Þ   Þ   ß   ß   ß   ß   à   á   á   á   á   á   á   á   â   â   â   â   â   â   ã   ã   ß   ç   ç   è      self    2   pos    2   boardServiceLogic   2   monsterIDCmpt   2   nMonsterBlockData   2   
coverList   2   coverListSelf   2   (for index)   /   (for limit)   /   (for step)   /   i   .   posWork   .      _ENV%                              	   5   	   8   S   8   V   i   V   k      k                         ¸       »   Ñ   »   Õ   è   Õ   è          _ENV