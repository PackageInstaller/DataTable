LuaS 

xV           (w@~@../PublishResources/lua/product/core_game/view/svc/preview/instruction/sp_play_create_ghost_or_summon_on_pickup_pos_inst.lua             @ A@  $@ @ Aΐ   A $@ΐ@  ΐ@ l   
@ΐ@ l@  
@ ΐ@ l  
@&     requiresp_base_inst_class:SkillPreviewPlayCreateGhostOrSummonOnPickupPosInstructionSkillPreviewBaseInstructionConstructorGetCacheResourceDoInstruction               $   @@ Ηΐ € 
 @@ Η Α € 
Α 
 Β ’@    @ 
  Ζ@@ Γ δ ΐΖ@@ Γ δ ΐΛ   A@ GΔ $ λ@  ΐΖ@@ Δ δ ΐ
 &     _trapID	tonumbertrapID
_effectID	effectID_prefabPrefab_animAnimAtkUltPreview_scopeParamTargetTypescopeTargetType
ScopeType
scopeTypeScopeParamscopeParamScopeCenterTypescopeCenterType         $                           	   	   
   
   
   
   
                                                                     self    $   params    $      _ENV           K    Ζ @ Η@ΐ@ Η Ηΐΐ «@ k@ f  &     Cfgcfg_effect
_effectIDResPath                                                          self          _ENV    i    W   @$ LA@Α  dΑΐ€ ΜAδ ΜAΑδ Α μ  $ \  @ΐLΒΐ   GCB B dB LB@ΑΒ dΓΗBCC ΓCD $LCΔΗD ΗΔD ΔDd E €CC@D €ΜE@  δ ΔΕΖ€ $D  D@D $LFΐ D ΕF
@dΗ €DΐLB@ΑB dLΗΗΒG   d H€ ΜBHLΘd δB  ΜΒΕD  δBΛ  Η$C&  #   GetOwnerWorldGetServiceRenderEntityGetPickUpPosGetBoardEntityBoardGetPieceEntities        CreateGhost_anim_prefabConfig_skillConfigHelper_scopeParamParserSkillPreviewScopeParamNew_scopeParamParseScopeParam
ScopeTypeScopeParamSetScopeParamDataPreviewActiveSkillCalcScopeResultSetScopeResultGetAttackRangeUtilScopeCalcSelectSkillTargetTargetTypeSetTargetEntityIDListEffectCreateWorldPositionEffect
_effectIDPreviewPickUpComponentAddPickUpEffectEntityIDGetID         '   F    E   C    @ € ’   @
@@ € @€ Ε   Μΐΐδ ΐ @ C  ΐ@@ € @€ Ε   Μ Αδ β   Ε   Μ@Αδ ΜΑδ ΜΐΑδ Β$ FAΒ  d@Βΐ€ @ C  ΐ i  κΑύ  C  £   B € ’    ΐB €  C€ Ζ@Cΐ ΐ C €   @ @    ¦  &     HasSummoner	SummonerGetSummonerEntityIDGetIDHasPetPetGetOwnerTeamEntityTeamGetTeamPetEntitiesipairsHasTrapRenderTrapRender
GetTrapID_trapIDHasDeadMark          E   (   +   +   +   +   ,   ,   ,   ,   ,   ,   ,   ,   ,   -   -   6   6   6   6   7   7   7   7   7   8   8   8   8   8   8   8   9   9   :   :   :   :   ;   ;   ;   ;   <   <   :   :   A   C   E   E   E   E   E   E   E   E   E   E   E   E   E   E   E   E   E   E   E   E   F   
   e    E   isOwner   E   summonerID   .   cTeam    .   	entities"   .   (for generator)%   .   (for state)%   .   (for control)%   .   _&   ,   
petEntity&   ,      casterEntity_ENVselfW                     "   "   #   #   #   #   %   &   F   %   I   I   I   J   J   J   J   J   J   M   M   M   O   Q   S   S   S   S   T   T   T   T   T   T   U   U   U   W   W   W   X   X   X   X   Y   Y   Y   Y   \   \   \   ]   ]   ]   ]   ]   ]   ^   ^   ^   ^   `   `   `   `   `   `   `   a   a   b   b   b   b   e   e   e   f   g   g   g   i      self    W   TT    W   casterEntity    W   previewContext    W   world   W   
entitySvc   W   
pickUpPos   W   
boardCmpt   W   traps   W   
configSvc   A   helper   A   parser   A   scopeParam!   A   param'   A   previewActiveSkillService-   A   scopeResult1   A   utilScopeSvc8   A   targetIDList>   A   effectEntityI   V   previewPickUpComponentK   V   targetListS   V      _ENV                                                   i      i          _ENV