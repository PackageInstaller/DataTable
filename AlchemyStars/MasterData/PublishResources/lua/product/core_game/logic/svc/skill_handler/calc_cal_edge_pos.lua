LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/b/180/client/Assets/../PublishResources/lua/product/core_game/logic/svc/skill_handler/calc_cal_edge_pos.lua             @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ &     _classSkillEffectCalc_CalEdgePosObjectConstructorDoSkillEffectCalculator_CalculateSingleTargetCalNewPosArr                  
@  @ @Á  ¤
&     _world_skillEffectServiceGetServiceSkillEffectCalc           
                        self       world                         Ì À ä A@ @$L@ À   d b   Â@ AÀ  ¤B)  ªü¦  &     GetTargetEntityIDsipairs_CalculateSingleTargettableinsert                                                                              
   self       skillEffectCalcParam       results      targets      (for generator)      (for state)      (for control)      _      	targetID      result         _ENV     ;    Z   Ç À A@ @ÁÀ $GA@ LÀÀ dA¤ AAÁ  ÂA¤ B¤ ÇB@ ÌBÂA äÃÂ$ LÃd  @C AÎÁ K  JDCJÄ  ÄË  ÊDÊÁ  
A
EÃ+D K D ÎDkD  ÁD Ä«D Ë   
ÅD
ÅK  JEJÅÄ  ÅDÁË  ÊAÊÅÄëD @	ÌDE @ À  @ 	äÄÀ 
 	À E ÃEÁ ¤C CF F @ ¤¦ &     skillEffectParam_worldGetEntityByIDcasterEntityIDGridLocation	Position       	BodyAreaGetAreaGetServiceBoardLogicGetCurBoardMaxXGetCurBoardMaxY       xy                             ÿÿÿÿÿÿÿÿCalNewPosArrLogdebug### bodyarea == 1SkillEffectResultCalEdgePosNew         Z   "   $   $   $   $   &   &   &   &   '   '   '   (   )   +   +   +   +   -   -   -   -   .   .   /   /   0   0   0   1   1   2   2   2   2   2   2   2   2   2   2   2   2   2   2   3   3   3   3   3   3   3   3   4   4   4   4   4   4   4   4   4   4   4   4   4   4   4   5   5   5   5   5   5   5   5   5   5   7   7   7   7   9   9   9   9   9   9   :   ;      self    Z   skillEffectCalcParam    Z   defenderEntityID    Z   param   Z   casterEntity   Z   eTarget	   Z   
posCaster   Z   
farestIdx   Z   posArr   Z   dirArr   Z   area   Z   lbsvc   Z   
boardMaxX   Z   
boardMaxY   Z   maxX   M   maxY   M   center4PosArr-   M   clampX5   M   clampY5   M   skillResultX   Z      _ENV @   Z    G   @ A@  ¤Ç@ ÌAÀAÂ  äÁ$ K  B Á ÃA$ BFCB dÀ
B_@A	  D   ÆÄB ÃGEÃä¢   CÃÇCÅÇEAB$ÊÀCEÃÇECÅÇEÁÂ$ÊÅC D
@	$EÅB ED
LÅAd GÂ
	$  @ À 
 i  êCô@ f&     _worldGetServiceMath	UtilDataGetBoardCenterPos               GridLocation	Positionipairs       Vector2xyClampValuetableinsert	Distance         G   B   B   B   B   D   D   D   D   E   E   F   G   H   I   I   I   I   J   J   J   J   K   K   K   K   K   L   L   L   L   M   M   N   N   N   N   N   N   N   N   N   P   P   P   P   P   P   P   P   R   R   R   R   R   S   S   S   S   S   S   S   T   T   U   V   J   J   Y   Y   Y   Z      self    G   casterEntity    G   eTarget    G   center4PosArr    G   clampX    G   clampY    G   mathService   G   utilDataSvc   G   
centerPos
   G   arr   G   
farestIdx   G   	distance   G   vTC   G   (for generator)   C   (for state)   C   (for control)   C   i   A   v   A   odd   A   newPos   A   newDistance=   A      _ENV                                           ;       @   Z   @   Z          _ENV