LuaS 

xV           (w@j@../PublishResources/lua/product/components/ui/season/explore/collection/ui_season_music_control_view.lua         4    @ A@  @ $@@@  @@ l   
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
@&     _classUISeasonMusicControlViewUICustomWidgetOnShowInitWidgetGetCfgPauseResumeSetMainMusicNameSetDataPlay
RefreshUIRefreshPlayStatePauseBtnOnClickResumeBtnOnClickLastBtnOnClickNextBtnOnClickSetMainOnClick                   @ ¤@ &     InitWidget                       self       	uiParams            
          L@@ Á    d 
@ L@@ Á  Á  d 
@L@@ Á  A d 
@L@@ Á  Á d 
@ L@B Á d
@ L@B Á  d
@&     coverGetUIComponentRawImageLoader	nameTextRollingTextauthorTextmainMusicTextMainMusicTextpauseBtnGoGetGameObject	pauseBtnresumeBtnGo
resumeBtn                                                                                                     self                      G @ f  &     _cfg                       self                "       F@@ GÀ 
@ &     _playStateUISeasonExploreHelperplayingStatePause            !   !   !   "      self          _ENV %   '       F@@ GÀ 
@ &     _playStateUISeasonExploreHelperplayingStatePlaying            &   &   &   '      self          _ENV )   +        @ @@  ¤@&     mainMusicTextRefreshText           *   *   *   *   +      self       txt            /   6       
@ 

À 
 
@A ÁAÆB ¤ 
&  	   _preClickCb_nextClickCb_pauseClickCb_resumeClickCb_setMainClickCb_roleModuleGameGlobal
GetModuleRoleModule            0   1   2   3   4   5   5   5   5   5   6      self       preClickCb       nextClickCb       pauseClickCb       resumeClickCb       setMainClickCb          _ENV 8   ?       
@ 
ÆÀ@ Ç Á
À Ì@A ä@ ÇA ÌÀÁFB GAÂA@ BGä@&     _index_cfg_playStateUISeasonExploreHelperplayingStatePlaying
RefreshUI_roleModuleUI_MusicOnclickCfgcfg_role_musicID            9   :   ;   ;   ;   <   <   >   >   >   >   >   >   >   >   ?      self       index       cfg          _ENV B   G       G @ L@À Ç@ ÇÀÀd@G A L@Á ÆA ÇÀÁ@ Bä  d@  G@B L@Á ÆA ÇÀÁ@ Bä  d@  LÀB d@ &     cover
LoadImage_cfgIcon	nameTextRefreshTextStringTableGetNameauthorTextAuthorRefreshPlayState            C   C   C   C   C   D   D   D   D   D   D   D   D   E   E   E   E   E   E   E   E   F   F   G      self          _ENV I   L       G @ L@À Ç@ Á@ A   Ã@  Ã  d@G@A L@À Ç@ Á@ A_   Ã@  Ã  d@&     pauseBtnGo
SetActive_playStateUISeasonExploreHelperplayingStatePauseresumeBtnGo            J   J   J   J   J   J   J   J   J   J   K   K   K   K   K   K   K   K   K   K   L      self          _ENV P   W       @@ @
 À@  A¤@ @A ¤@ A ¢   À A ÇÀA B ¤@&  	   _playStateUISeasonExploreHelperplayingStatePauseAudioHelperController	PauseBGMRefreshPlayState_pauseClickCb_index_cfg            Q   Q   Q   R   R   R   S   S   T   T   T   U   U   U   U   W      self       go          _ENV Z   a       @@ @
 À@  A¤@ @A ¤@ A ¢   À A ÇÀA B ¤@&  	   _playStateUISeasonExploreHelperplayingStatePlayingAudioHelperControllerUnpauseBGMRefreshPlayState_resumeClickCb_index_cfg            [   [   [   \   \   \   ]   ]   ^   ^   ^   _   _   _   _   a      self       go          _ENV d   h        @ ¢   À  @ Ç@@ @ ¤@&     _preClickCb_index_cfg           e   e   e   f   f   f   f   h      self       go            k   o        @ ¢   À  @ Ç@@ @ ¤@&     _nextClickCb_index_cfg           l   l   l   m   m   m   m   o      self       go            r   v        @ ¢   À  @ Ç@@ @ ¤@&     _setMainClickCb_index_cfg           s   s   s   t   t   t   t   v      self       go           4                              
      
                "       %   '   %   )   +   )   /   6   /   8   ?   8   B   G   B   I   L   I   P   W   P   Z   a   Z   d   h   d   k   o   k   r   v   r   v          _ENV