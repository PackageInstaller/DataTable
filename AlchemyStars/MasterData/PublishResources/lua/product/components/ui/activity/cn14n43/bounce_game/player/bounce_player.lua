LuaS 

xV           (w@e@../PublishResources/lua/product/components/ui/activity/cn14n43/bounce_game/player/bounce_player.lua         F    @ A@  $@ @ Aภ   A $@ภ@  ภ@ l   
@ภ@ l@  
@ ภ@ l  
@ภ@ lภ  
@ ภ@ l  
@ภ@ l@ 
@ ภ@ l 
@ภ@ lภ 
@ ภ@ l  
@ภ@ l@ 
@ ภ@ l 
@ภ@ lภ 
@ ภ@ l  
@ภ@ l@ 
@ ภ@ l 
@ภ@ lภ 
@ ภ@ l  
@ภ@ l@ 
@ ภ@ l 
@ภ@ lภ 
@ &     require!bounce_player_behavior_animation_classBouncePlayerBehaviorMgrConstructorInitDestroyResetAddBehaviorGetBouncePlayerDataChgPlayerStateGetBounceDataOnJump	OnAttack	OnUpdateHandleMoveIsPlayerOnBoardSetVisibleGetRect	SetStateOnHurtIsDownGetPlayerStateTypeOnHurtMonsterWhenDown           	       &                 	      self                   
0   
@ ภ $ 
 A AA$ 
 ม@ A$A B AA ภย@ BB$ $  
 B มA $AB มB AAค $A  AC C$ มC ฦD $ 
 C AD  $AC AD A$AD $A &     _coreController_bounceDataGetDataplayerDataBouncePlayerDataNewInitviewBehaviorBouncePlayerBeHaviorViewGetInitPosAddBehaviorBouncePlayerBeHaviorAnimationplayerStateFsmStateMachineManagerGetInstanceCreateStateMachineStateBouncePlayerSetDataReset         0                                                                                                                                                      self    0   coreController    0   palyerPrefabName    0   	parentRt    0      _ENV            L @ d@ &     Release                        self            "   '       G @ L@ภ d@ L@ ร   d@F A G@ม 
@GA Lภม ว @ ฬ ยไ  d@  &  	   playerDataResetSetVisiblestateBounceObjStateAliveviewBehaviorSetPositionGetInitPos            #   #   #   $   $   $   %   %   %   &   &   &   &   &   &   '      self          _ENV )   ,    	    @ @@ภ     ค@ภ    ค@&     superAddBehavior
SetPlayer        	   *   *   *   *   *   +   +   +   ,      self    	   	behavior    	        0   2       G @ f  &     playerData           1   1   2      self            5   @    	5   ฬ @ ไ โ   @A@ @ @A@ ม@_  @A AAA  มม B BB]$A &  A AAA  มม B BB]$A มB C $AAC CA@ มC_  A@ D_  A@ AD_   A   $A&     GetPlayerStateTypeStateBouncePlayerDeadInitLogdebugQ[bounce] BouncePlayer chgPlayerfsmState failed for player is dead , newState =    -- _bounceDatadurationMs)[bounce] BouncePlayer chgPlayerfsmState playerStateFsmChangeState_coreControllerPlayerChangeStateJumpDownJumpAttack         5   6   6   7   7   7   7   7   7   7   7   7   7   8   8   8   8   8   8   8   8   8   9   ;   ;   ;   ;   ;   ;   ;   ;   ;   <   <   <   <   =   =   =   =   =   =   >   >   >   >   ?   ?   ?   ?   ?   ?   =   @      self    5   	newState    5   params    5   	lastType   5      _ENV C   E       G @ f  &     _bounceData           D   D   E      self            I   L       G @ L@ภ d ภ ค@ &     playerStateFsmGetCurStateOnJump           J   J   J   K   K   L      self       	curState           O   R       G @ L@ภ d ภ ค@ &     playerStateFsmGetCurState	OnAttack           P   P   P   Q   Q   R      self       	curState           U   ]        @ ข   ภ  @ @@  ค@@ ข@  @ภ@ A AA$ ค  
 @ @@  ค@&     playerStateFsm	OnUpdate_aniBehaviorGetBehaviorBouncePlayerBeHaviorAnimationName            V   V   V   W   W   W   W   Y   Y   Y   Z   Z   Z   Z   Z   Z   \   \   \   \   ]      self       deltaMS          _ENV `   w    ,   ว @ โ   ภ	ว @ ฬ@ภไ ภGม@ GมOARAมAส ม@ Gม@ Gมม@ AA AAN
A  Gภ!ภม สภAGม@ JมAFB AยG@ LยภdA"  @ข   ภ LมB ฦB วAยdA&     viewBehaviorGetPositionyplayerData	curSpeed่      gSpeed        StateBouncePlayerWalkSetPositionChgPlayerState         ,   a   a   a   c   c   c   d   d   d   d   d   d   d   g   g   g   g   g   g   g   g   g   i   k   k   k   l   m   m   n   n   p   p   p   p   s   s   s   s   t   t   t   t   w      self    ,   deltaMS    ,   	chgState    ,   pos   +   
nextState   +      _ENV ~          &                       self                       @ @@  ค@&     viewBehaviorSetVisible                             self       	bVisible                   	   G @ L@ภ d ภ คภ ข@  @   & ม@ A $D  โ    ม@ A ค@  ภฆ&     playerStateFsmGetCurStateGetRectNamesviewBehaviorGetRect                                                                                         self       	curState      baseRectName      weaponRectName      	baseRect      weaponRect                     
@ &     state                    self       state               ช        @ @@ข     &  @ ภ@ Aค ข     &  @A A มAค@@  Bค@ @B BฦภB ว รค@ &     BounceDebugPlayerLiveForever_coreControllerbounceDataGetIsGuidingChgPlayerStateStateBouncePlayerDead
StartOverAudioHelperControllerPlayUISoundAutoReleaseCriAudioIDConstN28BouncePlayerDead                            ก   ฃ   ฃ   ฃ   ฃ   ฃ   ฃ   ค   ง   ง   ง   ง   จ   จ   จ   ฉ   ฉ   ฉ   ฉ   ฉ   ช      self       ap          _ENV ญ   ณ       L @ d b@  @    ฆ  @@ @_  @@ ภ@_   @    ฆ  &     GetPlayerStateTypeStateBouncePlayerAccDownDown            ฎ   ฎ   ฏ   ฏ   ฐ   ฐ   ฒ   ฒ   ฒ   ฒ   ฒ   ฒ   ฒ   ฒ   ฒ   ฒ   ฒ   ณ      self       
stateType         _ENV ต   น       G @ L@ภ d ภ ค ฆ  &     playerStateFsmGetCurStateGetStateType           ถ   ถ   ถ   ท   ท   ธ   น      self       	curState      
stateType           ป   ว       L @ d b@    &  @@ @  ภ@ วภ@ ว@มภ A A@ มAค@ภ@@  B ภภ@ วภ@ ว@ยภ A A@ มAค@&  
   GetPlayerStateTypeStateBouncePlayerDownplayerData	curSpeedspeedWhenAttackAtDownChgPlayerStateJumpAccDownspeedWhenAttackAtAccDown            ผ   ผ   ฝ   ฝ   พ   ภ   ภ   ภ   ภ   ม   ม   ม   ม   ย   ย   ย   ย   ย   ร   ร   ร   ร   ฤ   ฤ   ฤ   ฤ   ล   ล   ล   ล   ว      self       
stateType         _ENVF                                 	                         "   '   "   )   ,   )   0   2   0   5   @   5   C   E   C   I   L   I   O   R   O   U   ]   U   `   w   `   ~      ~                                 ช      ญ   ณ   ญ   ต   น   ต   ป   ว   ป   ว          _ENV