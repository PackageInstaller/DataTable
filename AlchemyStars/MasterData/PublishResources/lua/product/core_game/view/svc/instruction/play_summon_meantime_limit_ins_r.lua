LuaS 

xV           (w@e@../PublishResources/lua/product/core_game/view/svc/instruction/play_summon_meantime_limit_ins_r.lua             @ A@  $@ @ AÀ   A $@À@  À@ l   
@À@ l@  
@ À@ l  
@&     requirebase_ins_r_class#PlaySummonMeantimeLimitInstructionBaseInstructionConstructorDoInstruction
_ShowTrap           
    	   @@ ÇÀ ¤ 
 @@ Ç Á ¤ 
&     _trapDieSkillID	tonumbertrapDieSkillID_forceMeanTimeforceMeanTime         	               	   	   	   	   
      self    	   
paramList    	      _ENV    N    r   @$ LA@d LÀd ÁÀA BA¤¢A    &  ÌAAÂ äA $LAÁB d  ÇB â  ÌÂÂGB  ä Ã$  ÆBC   ä@Ã$ FDC  dÅC 
¤¢  @À Ä$ "   LFÀd LFÄÀ dFGB b  @LDÀ  @ B dF LÆÄÀ  @ +G dF i  ê÷LÅd DÅ¤ Á A èÌÅCGäÆE "  @ÆE EF FF$ F¬  $FÆF  À  @ 	$F ÆÿçÄùÌÇäD ^Äÿé  jÃì&     GetOwnerWorldSkillRoutineGetResultContainerGetEffectResultsAsArraySkillEffectTypeSummonMeantimeLimitGetServiceTrapRender
PlaySkillConfig_trapDieSkillIDGetSkillConfigDataGetSkillPhaseArrayipairsGetDestroyEntityIDGetEntityByIDGetTrapDieSkillResultSetResultContainer_SkillRoutineTaskPlayTrapDieSkillGetTrapIDListGetReplaceAttr       _forceMeanTimeGameGlobalTaskManager
StartTask
_ShowTrapUpdateAllTrapSummonIndex         D   F            @   Å  E $@ &     
_ShowTrap           E   E   E   E   E   E   E   F          selfTTworldtrapEntityreplaceAttrr                                                                                    !   !   !   !   "   "   "   &   &   &   &   (   (   )   )   )   )   *   *   *   +   +   .   0   0   0   1   1   2   2   2   2   2   4   4   4   5   5   5   5   5   5   9   9   9   9   9   9   )   )   >   >   ?   ?   @   @   @   @   A   A   A   B   B   B   B   B   B   C   C   C   C   F   C   G   I   I   I   I   I   I   J   @   L   L   L   &   &   N   !   self    r   TT    r   casterEntity    r   phaseContext    r   world   r   routineCmpt   r   resultArray
   r   trapServiceRender   r   playSkillSvc   r   
configSvc   r   skillPhaseArray   r   skillConfigData   !   (for generator)$   q   (for state)$   q   (for control)$   q   _%   o   result%   o   destroyEntityID'   o   (for generator)*   L   (for state)*   L   (for control)*   L   i+   J   	entityID+   J   entity.   J   skillHolder1   J   skillResult4   J   trapIDListN   o   replaceAttrP   o   (for index)S   l   (for limit)S   l   (for step)S   l   iT   k   trapEntityW   k      _ENV Q   b       L@ÁA  dÀ  @ ¤A Â@ @ $ Á@ À  @Á   )  ªý¢  @â  À Á À$B &     GetServiceTrapRenderCreateSingleTrapRenderpairsMaxHPHPReplaceRedAndMaxHP            S   S   S   T   T   T   T   T   V   X   X   X   X   Y   Y   Z   Z   [   [   \   X   X   _   _   _   _   `   `   `   `   b      self       TT       world       trapEntity       replaceAttr       trapServiceRender      hp	      hpMax	      (for generator)      (for state)      (for control)      key      value         _ENV                                 
         N      Q   b   Q   b          _ENV