LuaS 

xV           (w@J@../PublishResources/lua/product/util/optimize/ui_corgame_performance.lua         4    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@@@ l@ 
@ @@ l 
@&     _class UICoreGamePerformanceControllerUIControllerOnShowCloseButtonDisposeDelaySendFPSInfoUpdateTestScenceInfoStopOnClickBeginOnClickBeginWithMonsterOnClickBeginWithTextureOnClickBeginWithStatsOnClickOutOnClickOpenCheatUIOnClickSwitchSceneOnClickBeginMonsterOnClickSwitchMonsterOnClick                  @@   AÁ  ¤ 
 @@   AA ¤ 
 A ÁA BGB ¤@ A ÁA ABGB ¤@  C A ¤
 C Á  ¤
 &     	_fpsTextGetUIComponentUILocalizationTextfps_infoinfoAttachEventGameEventTypeUpdateTestScenceInfoTestSceneCloseButtonCloseButton	buttonGOGetGameObjectButton_fpsTextGO                           	   	   	   	   	   
   
   
   
   
                                                self       	uiParams          _ENV           Æ @ Ç@À  ä b    Á@ A  $AÀ Á@ A $A¢    AA A  $AÀ AA A $A&     GameObjectHelperFindScript	buttonGO
SetActive_fpsTextGO                                                                                                self       state       	fpsState       
sceneRoot         _ENV !   #       L @ Æ@@ ÇÀd@&     DetachEventGameEventTypeUpdateTestScenceInfo            "   "   "   "   #      self          _ENV %   ,       @ @ A  $A  F@ GÁÀA AAÁ d    iA  êÿFÁA GÂd LAÂÆB ÇÁÂ  @ dA &     YIELD       stringgmatch	_fpsTexttext%d+GameGlobalEventDispatcher	DispatchGameEventTypeUpdateTestScenceFPS            &   &   &   &   '   (   (   (   (   (   (   (   )   (   (   +   +   +   +   +   +   +   +   +   +   ,   	   self       TT       
sceneName       themeID       
fpsNumber      (for generator)      (for state)      (for control)      s         _ENV .   5    	   b   @  À  Æ@@ ÇÀ  ä@ &  ÇÀ@ A @  ÆÁA   ä ÁÊ Æ B Ç@Âä ÌÂGÁB   À   ä@ &     Logfatal_infotextå½ååºæ¯ï¼  ThemeIDï¼	tostringGameGlobalTaskManagerCoreGameStartTaskDelaySendFPSInfo            /   /   /   /   0   0   0   0   1   3   3   3   3   3   3   3   3   3   4   4   4   4   4   4   4   4   4   5      self       
sceneName       themeID          _ENV 7   9        @ @@¤ @Á@ A¤@&     GameGlobalEventDispatcher	DispatchGameEventTypeStopTestScence            8   8   8   8   8   8   8   9      self       go          _ENV ;   =    
    @ @@¤ @Á@ AFAA GÁ¤@ &     GameGlobalEventDispatcher	DispatchGameEventTypeBeginTestScenceScenePerfTestTypeOnlySceneTheme         
   <   <   <   <   <   <   <   <   <   =      self    
   go    
      _ENV ?   A    
    @ @@¤ @Á@ AFAA GÁ¤@ &     GameGlobalEventDispatcher	DispatchGameEventTypeBeginTestScenceScenePerfTestTypeSceneAndMonster         
   @   @   @   @   @   @   @   @   @   A      self    
   go    
      _ENV C   E    
    @ @@¤ @Á@ AFAA GÁ¤@ &     GameGlobalEventDispatcher	DispatchGameEventTypeBeginTestScenceScenePerfTestTypeSceneAndTexture         
   D   D   D   D   D   D   D   D   D   E      self    
   go    
      _ENV G   I    
    @ @@¤ @Á@ AFAA GÁ¤@ &     GameGlobalEventDispatcher	DispatchGameEventTypeBeginTestScenceScenePerfTestTypeSceneAndStatsData         
   H   H   H   H   H   H   H   H   H   I      self    
   go    
      _ENV K   N    
    @ A@ @¤@À@  A¤ @A¤@ &     SwitchStateUIStateTypeUIMainGameGlobalGetInstanceExitPerformanceGame         
   L   L   L   L   M   M   M   M   M   N      self    
   go    
      _ENV P   R    	    @ A  D  ¤@&     ShowDialogUIBattleCheat           Q   Q   Q   Q   Q   R      self       go            T   [    	    @ A  A  ¤ À@Æ A @ A  ÁA $ Á@ä â@    Á ÁA B$ ABB ÁBÀ  $A&     GetUIComponentInputField
SceneNametext	tonumberThemeID       GameGlobalEventDispatcher	DispatchGameEventTypeSwitchScene            U   U   U   U   U   V   V   V   V   V   V   V   W   W   X   Z   Z   Z   Z   Z   Z   Z   Z   Z   [      self       go       
sceneName      themeID         _ENV ]   `        @ @@¤ @Á@ A¤@&     GameGlobalEventDispatcher	DispatchGameEventTypePerfMonsterStat            _   _   _   _   _   _   _   `      self       go          _ENV b   e        @ A  A  ¤ À@Æ A Ç@Áä ÌÁFÁA GÂ ä@ &  	   GetUIComponentInputFieldMonsterNametextGameGlobalEventDispatcher	DispatchGameEventTypeSwitchMonster            c   c   c   c   c   d   d   d   d   d   d   d   d   e      self       go       monsterName         _ENV4                                       !   #   !   %   ,   %   .   5   .   7   9   7   ;   =   ;   ?   A   ?   C   E   C   G   I   G   K   N   K   P   R   P   T   [   T   ]   `   ]   b   e   b   e          _ENV