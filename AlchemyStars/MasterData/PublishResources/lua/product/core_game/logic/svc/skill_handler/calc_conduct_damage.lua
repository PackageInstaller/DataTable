LuaS 

xV           (w@[@../PublishResources/lua/product/core_game/logic/svc/skill_handler/calc_conduct_damage.lua             @ A@  $@ @ AÀ   A $@À@  À@ l   
@À@ l@  
@ À@ l  
@À@ lÀ  
@ &  	   require
calc_base_classSkillEffectCalc_ConductDamageSkillEffectCalc_BaseDoSkillEffectCalculatorCalculateOnSingleTargetCalculateResultCalcConductScope                     Ì À ä A@ @$ L@ À   d Â@ AÀ  ¤B)  ªý¦  &     GetTargetEntityIDsipairsCalculateOnSingleTargettableappendArray               	   	   
   
   
   
                              
   
         
   self       skillEffectCalcParam       tResultArray      teidTarget      (for generator)      (for state)      (for control)      _      	targetID      results         _ENV    &    $   Ç À A@ @ÁÀ $K  A¤ ÌAAä ÁÂA B$FBB  d@Â¤  @ÃB CÀDC  À   @$ ¤C  i  êÂûf &     skillEffectParam_worldGetEntityByIDcasterEntityIDSkillContextGetResultContainerGetEffectResultByArrayAllSkillEffectTypeDamageipairsGetTargetIDtableinsertCalculateResult         $                                                                         !   !   !   !   !   !   !   !   !   !         %   &      self    $   
calcParam    $   	targetID    $   effectParam   $   	attacker   $   tConductResult   $   cSkillContext   $   resultContainer
   $   tDamageResultArray   $   (for generator)   "   (for state)   "   (for control)   "   damageIndex       damageResult          _ENV )       $o   L@d A@   @¤ Ì@ä Â@$ GÁ BÁ¤ ÆA ÌÂÁ@ä B$ GCB LÂÁÃ d ÆCC   ä@ `
 C"   D  EB ÅC 	¤â  ÀÆEC  ä@ FD GGÄDÀ	db  @ GÅD@ é  jÆüb  ÀÌÅä FEE¤ $F  ÆE 
$FF ÆAÆ  Ë   
ëF ÆÌÆÆä ÆÌÅä Æ$LFÇÀ Ç @ 
ÇÇÇ   FH GHÈÅ¤ dÆ  ÌÈ@
	À  @äÇÈ À$G é  jÄëæ &  $   GetTargetIDCalcConductScopeGetGridPosTargetIDRecordListGetTargetIDsskillEffectParamGetConductRateListSkillEffectConductDamageResultNewSkillContext_worldGetServiceSkillEffectCalc        ipairs       GetEntityByIDtable
icontainsidList
recordPosGetSkillEffectDamageStageIndexSetConductBaseDamageGetTotalDamageSetCurrentConductRateSkillDamageEffectParampercent
formulaIDGetFormulaIDdamageStageIndexComputeSkillDamage
attackPosskillIDSkillEffectTypeConductDamageNewSkillDamageEffectResultCreateAtomData         o   *   *   ,   ,   ,   ,   0   0   1   1   4   5   5   7   7   7   7   7   :   :   =   =   =   =   ?   @   @   @   @   A   A   A   E   F   H   H   L   M   M   M   M   O   O   P   P   P   P   R   S   S   S   S   S   S   S   T   T   P   P   `   `   c   c   e   e   e   e   f   f   f   h   h   h   i   i   i   i   j   j   j   k   k   k   h   n   o   p   q   r   s   t   u   u   v   v   n   z   {   |   }   ~      z               @   @         "   self    o   
calcParam    o   	attacker    o   damageIndex    o   damageResult    o   	targetID   o   scopeResult   o   targetPosIdRecordList   o   
targetIDs
   o   effectParam   o   tConductRate   o   conductResult   o   cSkillContext   o   effectCalcSvc   o   conductCount   o   (for generator)   m   (for state)   m   (for control)   m   _   k   	targetID   k   fConductRate"   k   gridPos%   k   	defender)   k   (for generator).   ;   (for state).   ;   (for control).   ;   index/   9   value/   9   record0   9   damageStageIndex?   k   damageParamT   k   nTotalDamage`   k   listDamageInfo`   k   damageEffectResultg   k      _ENV    Î    'm   Ç À A@ @ÁÀ $GA@ LÁÁA dÁ¤ ÇÁÁ Â$ LBÂd B ÂB¤ ÌC@ ä @ÌBCä ÌÃä ÃC$ LÄd CD  @À  @¤ÆD ÌÃÂGD@ äÄÄ À  $K  E¤ ÆDE   	ä Å$ JÄEé  jþÆDE   ä	_ 	F@ @$"  LFd b  LFFd FC¤ ÌCä GE @$MHÅ¤ Çâ   ÌF@		äH ÌÈF@		äH @ )  ªûé  jõ¦ &     skillEffectParam_worldGetEntityByIDcasterEntityIDGetServiceUtilScopeCalcGetSkillScopeCalcgridPosGetConductScopeTypeGetConductScopeParamSkillScopeParamParserNewParseScopeParam	BodyAreaGetAreaGetGridDirectionGetConductTargetTypeComputeScopeRangeSkillScopeTargetSelectorDoSelectSkillTargetGetAttackRangeipairs
Pos2IndexHasBodyAreaGetGridPositionAddTargetIDAndPos AddTargetIDAndPosAllowDuplicate         m                                                                                                          ¡   ¢   £   ¤   ¥   §      ©   ©   ©   ©   ª   «   «   ¬   ª   ®   °   °   ±   ±   ±   ±   ²   ²   ³   ±   ±   ¶   ¶   ¶   ¶   ·   ·   ¸   ¸   ¸   ¸   ¹   ¹   ¹   ¹   ¹   ¹   º   º   ¼   ¼   ½   ½   ¾   ¾   ¾   ¾   ¿   À   À   Á   Á   Á   Ã   Ã   Ã   Ã   Å   Å   Å   Å   Å   ¾   ¾   ¶   ¶   Í   Î   )   self    m   
calcParam    m   conductCenterEntityID    m   effectParam   m   	attacker   m   utilScopeSvc	   m   
calcScope   m   lastHitpoint   m   
scopeType   m   scopeParam   m   parser   m   casterBodyArea   m   casterDirection   m   targetType    m   scopeResult)   m   	selector-   m   targetArray2   m   	rangeMap3   m   tv2AttackRange5   m   (for generator)8   >   (for state)8   >   (for control)8   >   _9   <   v29   <   index;   <   (for generator)A   k   (for state)A   k   (for control)A   k   _B   i   	targetIDB   i   entityH   i   
v2GridPosP   i   
cBodyAreaR   i   tv2BodyAreaT   i   (for generator)W   i   (for state)W   i   (for control)W   i   _X   g   
v2AreaPosX   g   v2AbsAreaPosY   g   index[   g      _ENV                                          &      )      )      Î      Î          _ENV