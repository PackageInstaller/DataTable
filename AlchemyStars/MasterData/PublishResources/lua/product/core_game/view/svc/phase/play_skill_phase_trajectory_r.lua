LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/b/150/client/Assets/../PublishResources/lua/product/core_game/view/svc/phase/play_skill_phase_trajectory_r.lua         1    @ A@  $@ @ AÀ   A $@À@  À@ l   
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
@ À@ l  
@&     requireplay_skill_phase_base_r_classPlaySkillPhase_TrajectoryPlaySkillPhaseBasePlayFlight_PhaseWorkPos_TrajectoryAction_OnTrajectoryEnd_DelEffectEntity_GetEntityPosByView_CheckFlyAttack_PlayTargetEffect_PlayHitEffect_OnFlyAttack_InitFlyPosList_IsHaveFlyPosList_FindFlyDamageResult               0    L@d LAÀd À¤ ÌÁÀä A$ FBA GÁÂ ÁÂ dB CB$ LBd  À¤ ÌB LÃBd C¤ À  ä CC  À   @  À $LCd ÃC À  ¤C&     SkillRoutineGetResultContainerGetSkillIDIsFinalAttackGetGridPositionVector2New        _PhaseWorkPosGetCasterTypeGetCasterParamGetTargetTypeGetTargetParam_TrajectoryActionGetFinishDelayTimeYIELD         0   	                                                                                                                                                   self    0   TT    0   casterEntity    0   phaseParam    0   
paramWork   0   skillEffectResultContainer   0   skillID   0   isFinalHit	   0   
posCaster   0   
posTarget   0   	posStart   0   posEnd    0   	bHaveBit)   0   finishDelayTime+   0      _ENV    4    <   F@ GAÀ  Á  dÁ@ A@ @ @Á@ AA@  ÁJÁAJ@	Á@ B@  AJÁÁJ Á@ AB@ @ @ Á@ B@  AJÁAJ@Á@ ÁB@  AJÁAJ Á@ C@   @ f &     Vector2New        SkillPhaseParam_PointType
CasterPosCasterXxyCasterY
TargetPosTargetXTargetY
UserParam         <                                  !   !   "   "   "   "   #   #   $   $   $   %   %   %   %   &   &   '   '   '   (   (   (   (   )   )   *   *   *   *   +   +   ,   ,   ,   -   -   -   -   .   .   /   /   /   0   0   0   0   1   3   4      self    <   posType    <   	posParam    <   
posCaster    <   
posTarget    <   
posReturn   <      _ENV 8       %Ä   À$  @ C  f G@ LÂÀÁ d@ Â@C ¤Ä  CLÁd b  @_ÀÁÀÆB ÇCÂB BGÄB$ FB GÂCd D ä C GÄBRÄCÄ	$OCÌÃÃä DÀ   $À DD @ $D B BGÄBÄÂN$ FB GÂCÇÃÄ	d B D	ÏEÍ	¤ ÌÄÄä À Å$ Ï	EÅ	FE LÅÅ
d LÆ
d MÅ
EÆ¤ F¤ ÇÅFÇ $D  FG G  ÆÇ  @ 
  ¤HGH HÇHI¤@ À
FG FI  ÉÆÆI ÇÊÏFÃÆÊB DÍF¤ ÌFÊ@  ÁG   
C  äÈGH HÇHI$@ FG J ÆÊ  	@ 
¤ ÌHFGH GÈGÇÈGÉä@FG G  K   @ À  @
À  	¤FFK   @ ¤FÀb   Ë,  ¤FE ÆE¤ F¤  @À FD À ¤F  ý ¦ &  /   GetTrajectoryType _worldGetServiceBoardRenderEffectGetTrajectoryEffectOffset        mathmaxabsxy       Vector2GetTrajectoryEffectID#CreateWorldPositionDirectionEffectYIELDsqrtGetTotalTimeGetTrajectoryTime     @@GameGlobalGetInstanceGetCurrentTimeViewGetGameObject
transformGridPos2RenderPosSkillPhaseParam_TrajectoryTypeLineDOMoveSetEaseDG	TweeningEase
InOutSine	Parabola	positionVector3upDOJumpLaser	DOScaleZ_CheckFlyAttack_DelEffectEntityOnComplete                 	       @   Å  E Å $@   @@   Å  $@&     _OnTrajectoryEnd_DelEffectEntity
                                                                  
   selfTT	nSkillIDphaseParamentityCaster	posStartposEndisFinalHittrajectoryObjectentityEffectÄ   @   @   A   A   B   B   E   E   E   E   G   G   G   G   K   M   N   N   O   P   P   P   P   Q   Q   Q   Q   Q   Q   Q   Q   Q   Q   Q   Q   R   R   R   R   R   R   S   S   U   U   V   V   V   V   V   V   W   W   W   Y   Y   Y   Y   Y   Y   Z   Z   Z   Z   Z   Z   [   [   [   [   [   [   \   \   ]   ]   ^   ^   _   a   c   c   c   c   c   c   f   f   f   f   g   h   h   h   i   j   j   j   j   k   k   k   k   k   k   k   k   k   k   k   k   k   l   l   l   l   m   m   m   m   m   m   n   n   n   n   p   p   p   p   p   p   p   q   q   q   q   q   q   q   q   r   r   r   r   t   t   t   t   u   u   u   u   u   u   u   w   w   w   w   x   y   z   {   |   }   ~            x                                                                                  self    Ä   TT    Ä   	nSkillID    Ä   phaseParam    Ä   entityCaster    Ä   	posStart    Ä   posEnd    Ä   isFinalHit    Ä   nTrajectoryType   Ä   boardServiceRender
   Ä   effectService   Ä   entityEffect   Ä   posDirectory   Ä   nEffectOffset   Ä   
posCreate   Ä   nDirectoryLen#   +   effectDirector)   +   nTrajectoryEffectID-   Ä   disx<   Ä   disyB   Ä   disH   Ä   nTotalTimeJ   Ä   nTrajectoryTimeN   O   	nFlyTimeP   Ä   	nEndTimeV   Ä   trajectoryObjectZ   Ä   
transWork[   Ä   gridWorldpos^   Ä   	easeWork_   Ä   
jumpPower~      	sequence      	sequence         _ENV    «    "   @$ B@$ L@ÆÂ@ ÇÁ  d b  @BÁÁ$ ¤  ¢  ÀÇÂA ÌÂLCÂd ä  B  À  @ À  @ $C&     SkillRoutineGetResultContainerGetEffectResultByPosSkillEffectTypeDamageGetDamageInfoGetDamageIndex_worldGetEntityByIDGetTargetID_OnFlyAttack         "                                                                               ¡   ¢   £   ¤   ¥   ¦   ¨      «      self    "   TT    "   	nSkillID    "   phaseParam    "   entityCaster    "   	posStart    "   posEnd    "   isFinalHit    "   skillEffectResultContainer   "   damageResult	   "   damageData   !   entityTarget   !      _ENV ¬   ¯       @  $AA@ @$A&     
SetActive_worldDestroyEntity           ­   ­   ­   ®   ®   ®   ®   ¯      self       TT       trajectoryObject       entityEffect            ±   Â    	    À ¤ @ Ä   æ  Ì@ä À@   & ÁÀGA LAÁÁ dÁÁB¤¦ &  	   View GetGameObject
transform_worldGetServiceBoardRenderBoardRenderPos2GridPos	position           ³   ³   ´   ´   µ   µ   ¸   ¸   ¹   ¹   º   º   ½   ¿   ¿   ¿   ¿   À   À   À   Á   Â      self       entityWork       effectViewCmpt      effectObject      effectTrans      boardServiceRender      
posReturn           Å   ÿ   
 &[   @  &  B@ @Ã  ¤ÌÁä CÁ$ LÁd ÃÁ¤ ¢C     ÌCBä ÌÂä ÄB $D  FC LDÃd LÃd  @LÄC Àdb   D  @À F ¤ÆD   	äÀÆÄÅ¤ $  "  @GF@ LFÅÌÅä d  "     ÆE   @ ¤F C F¤ FFF @   À  @ À 	 @	¤ ÌÆF@ äFé  jEöG À ¤D ï&      _worldGetService
PlaySkillGetHitAnimationGetHitEffectIDGetHitEffectTimeGetTargetWaitTime        SkillRoutineGetResultContainer_InitFlyPosListGameGlobalGetInstanceGetCurrentTime_GetEntityPosByView_FindFlyDamageResult       pairsGetDamageInfoGetDamageIndexGetEntityByIDGetTargetID_DelayTimeTaskManagerCoreGameStartTask_OnFlyAttackAddWaitFreeTaskYIELD         [   Ï   Ï   Ð   Ó   Ó   Ó   Ó   Ô   Ô   Õ   Õ   Ö   Ö   ×   ×   ×   ×   ×   Ú   Ú   Ú   Ú   Û   Û   Ü   Ý   Ý   Ý   Ý   Ý   Ý   Ý   Þ   Þ   Þ   ß   ß   á   á   á   á   á   á   á   â   â   â   â   ä   ä   ä   ä   å   å   ç   ç   ç   ç   ç   è   è   é   ê   ê   ê   ê   í   í   í   í   î   ï   ð   ñ   ò   ó   ô   õ   ö   ø   í   ù   ù   ù   â   â   ý   ý   ý   ý   ÿ      self    [   TT    [   	nSkillID    [   phaseParam    [   entityCaster    [   entityEffect    [   	nEndTime    [   	posStart    [   posEnd    [   isFinalHit    [   playSkillService   [   hitAnimName	   [   hitEffectID   [   hitEffectTime   [   
nWaitTime   [   skillEffectResultContainer   [   bFirstAttack   [   posFly#   Y   listDamageData,   V   (for generator)/   V   (for state)/   V   (for control)/   V   
posDamage0   T   damageResult0   T   damageData4   T   entityTarget;   T   nTaskIDQ   T      _ENV         L@d A@¤ _@@ !ÀÀ  &  ÇA ÌAÁA äÂ LÂÁÀ  @ dB À   ¤B&  	   GetTargetEffectIDGetTargetDelayTime         _worldGetServiceEffect#CreateWorldPositionDirectionEffectYIELD                                      	  
  
  
  
  
            
   self       TT       phaseParam       	posStart       posEnd       
nEffectID      
nShowTime      effectService      posDirectory      entityEffect         _ENV   *  	 *   L@d B@¤ Ì@ ä Ã@ A$ CA$A $ÃA$B $CB$B $ÃBC¤ $  CC$C $LÃÃÀ   dC &     GetHitAnimationGetHitEffectIDSkillServiceHandleBeHitParamNew!SetHandleBeHitParam_CasterEntity!SetHandleBeHitParam_TargetEntity SetHandleBeHitParam_HitAnimName SetHandleBeHitParam_HitEffectIDSetHandleBeHitParam_DamageInfoSetHandleBeHitParam_DamagePosSetHandleBeHitParam_DeathClearIsClearBodyNowSetHandleBeHitParam_IsFinalHitSetHandleBeHitParam_SkillIDHandleBeHit         *                                   !  !    "  "    #  #    $  $    %  %  %    &  &    '  '    )  )  )  )  *     self    *   TT    *   phaseParam    *   entityCast    *   entityTarget    *   damageData    *   
damagePos    *   isFinalHit    *   	nSkillID    *   hitAnimationName   *   hitEffectID   *   skillService   *   beHitParam%   *      _ENV ,  :  
    @   @À ¤B ¢  @B@   @ À  @ À ¤B &     _PlayTargetEffect_PlayHitEffect           6  6  6  6  6  6  7  7  8  8  8  8  8  8  8  8  8  8  :  
   self       TT       	nSkillID       phaseParam       entityCaster       entityTarget       damageData       	posStart       posEnd       isFinalHit            <  >      K   
@ &     m_listFlyPos           =  =  >     self            @  F       @ @@Ç@   ¤¢   @   ¦  @ Ç@ Ü ÍÀÀ@   ¦  &     table
icontainsm_listFlyPos                   A  A  A  A  A  A  A  B  B  D  D  D  D  D  E  E  F     self       pos          _ENV H  d   8   Æ@ ÇAÀ@ Â@GA$ F@ GÂÀBAd ä  Á  À AGÁBBÁ  À BAGBÁB  A ÁÂ hBNOCMCÁ ÀCÁ  Â DB B@¤ ¢  @ÌC @äÀ  
gú& &     Vector2Newmathabsxy               GetEffectResultByPosSkillEffectTypeDamage _IsHaveFlyPosList         8   N  O  O  O  O  O  O  O  O  O  O  O  P  P  P  Q  Q  Q  Q  S  S  S  T  T  T  T  V  W  W  W  W  X  X  X  Y  Y  Y  Y  Y  Y  [  [  [  [  [  \  \  ]  ]  ]  ]  ]  ^  W  c  d     self    8   skillEffectResultContainer    8   posFly    8   	posStart    8   posEnd    8   nCheckRange    8   dir   8   dirTemp   8   listDamageData   8   (for index)   6   (for limit)   6   (for step)   6   i   5   posNew"   5   damageResult-   5      _ENV1                                          4      8      8      «      ¬   ¯   ¬   ±   Â   ±   Å   ÿ   Å           *    ,  :  ,  <  >  <  @  F  @  H  d  H  d         _ENV