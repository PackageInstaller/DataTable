LuaS 

xV           (w@Z@../PublishResources/lua/product/core_game/view/svc/instruction/play_boss_speak_ins_r.lua             @ A@  $@ @ Aΐ   A $@ΐ@  ΐ@ l   
@ΐ@ l@  
@ ΐ@ l  
@&     requirebase_ins_r_classPlayBossSpeakInstructionBaseInstructionConstructorGetCacheAudioDoInstruction           "    G   @ΐ 
 ΐΐ 
 @A ΗΑ € 
    
   
 @Β ΖB ΗΐΒ  A δAC @$ GΒA ΒA  CJ)  ͺώΐΓ B ΑB@  $ΐ  AC @$ΐGB B  CΖBA   δ JΒ)  ͺAύΑA  GB \_@ΐ D ADA $A AA GΕ $ 
 Ε 
 Ζ 
 Ζ 
 &     _bossCardImagebossCardImage
_bossName	bossName_prob	tonumberprob_speakList_audioList
speakListstringsplit|ipairs       
audioListLogerror*PlayBossSpeak speak and audio size error!
_duration	duration_inAnimNameinAnimName_loopAnimNameloopAnimName_outAnimNameoutAnimName         G               	   	   	   	   
   
                                                                                                                                                                                   !   !   "      self    G   
paramList    G   	paramStr   G   splitStrArray   G   (for generator)      (for state)      (for control)      _      v      (for generator)'   2   (for state)'   2   (for control)'   2   _(   0   v(   0      _ENV $   ,       K    @ Η@@ € ’     ά ΝΑΐJ©  *ύf  &     ipairs_audioList                           %   &   &   &   &   '   '   '   '   (   (   (   &   &   +   ,      self       t      (for generator)      (for state)      (for control)      _      v         _ENV 0   E    6   @ A@F@ $ Α@$ "    &  A$ FAA GΑΑ Α dAB !@AA AΑΑ B  €ΗB ΗΒB$ CBC CΛ ΓC GD λB CD GD ΗΓD E $BBE "     FΒE GΖ ΐ dB&     GameGlobal
GetModuleSkillPerfModuleIsBeginPerfGetOwnerWorldMathfRandom       d       _prob_speakListEventDispatcher	DispatchGameEventTypeUIShowBossSpeak_inAnimName_loopAnimName_bossCardImage
_bossName
_duration_outAnimName_audioList        InnerGameHelperRenderInnerGamePlayPetVoid         6   1   1   1   1   1   1   1   1   2   5   5   6   6   6   6   6   7   7   7   8   8   8   8   8   8   9   9   <   <   <   <   <   <   <   <   <   =   =   =   =   =   <   @   @   A   A   A   A   B   B   B   B   B   E   	   self    6   TT    6   casterEntity    6   phaseContext    6   world   6   rand   6   index   5   	curSpeak   5   curAudioID,   5      _ENV                                 "      $   ,   $   0   E   0   E          _ENV