LuaS �

xV           (w@P@../PublishResources/lua/product/components/ui/ui_music/ui_album_controller.lua         S    @ A@  ��@ $@�@@  ��   F@@ �   J���F@@ �@  J� �F@@ ��  J���F@@ ��  J� �F@@ �  J���F@@ �@ J� �F@@ �� J���F@@ �� J� �F@@ �  J���F@@ �@ J� �F@@ �� J���F@@ �� J� �F@@ �  J���F@@ �@ J� �F@@ �� J���F@@ �� J� �F@@ �  J���F@@ �@ J� �F@@ �� J���F@@ �� J� �F@@ �  J���F@@ �@ J� �F@@ �� J���F@@ �� J� �F@@ �  J���& �    _classUIAlbumControllerUIControllerOnShowOnHideInitWidget
changeTabonClickItemrefreshBtmBarrefreshSetBtn_RefreshSetBtnVisiblechangeSelectmusicTimeTickTab1OnClickTab2OnClickTab3OnClickTab4OnClickTab5OnClickPauseBtnOnClickResumeBtnOnClickLastBtnOnClickNextBtnOnClickSetMainOnClickSetAircraftOnClickSetHomelandOnClickreqChangeBgm_ChangeBlurBgBegin_ChangeBlurBgEnd           �    3  �@� �@    ��   
� ��   �   ��@ �@ � � �@A��� 
���
���� B �@B� ���
�����A ��B,A  D� �@ �@ �@C �� ���
� ���� � D�   �� � �  K  �  �    �@��K �A �A kA � �A B �A � B AB �A  AB �B +B K �B �B kB +A�K  ��� � �@��C ���@ 䂀�  ��C E� $��FC� G����E���� dC�G�EGC��E���C@�C@J���"C  ��G�EGC��E���F�C@J��GCFJ���  *����F ��FB@FA �B@�B@��A��AG ��FFFA �F�B@��A���G ��F�GFA ��G�B@��A��H ��FBHFA �BH�B@��A���H ��F�HFA ��H�B@��A���  
����  �A� �A�B�@ �A��A� �A��@ �A��A� �A���@ �A��A� �A�B�@ �A��A� �A���@ �A��A���@�@�ǁI �A������C  �A������@�@�ǁI ��������C  �A�
����C ���F� GB�䁀
���C ���F� G��䁀
���C ���F� GB�䁀
��Ɓ� ���䁀 �� DKB  J��$� AB "  ����� � �� �  @ ��B@G�M��� �D�B�M_����� �BN��  �A� ���B�� �B O CO�� ��$C 
@��
�A�
�Р
�С�� DG�O C�E
 �CQ �� $C��� GR �Q G��$ �GDR@�@ �
��@ �)�  ���R ��� �D��O ��$C�S $C CS $C �S ��� �D��O ����S$C�C� �T$�� �T� �C� ǃ�,� $��
 �& � W   _isHomeland       InitWidget_developmentEngineGameHelperIsDevelopmentBuild topButtonWidgettopButtonsSpawnObjectUICommonTopButtonSetData_roleModule
GetModuleRoleModuleCfgcfg_role_music        pairsUI_CheckMusicShowUI_CheckMusicLocktableinsertTag       ID
tab1CountSetText/
tab2Count
tab3Count       
tab4Count       
tab5Count       _isLocksort	_tabBtnsgameObject
SetActive_music_curMainMusicUI_GetMusicEnumBgmTypeE_Bgm_Main_curAircraftMusicE_Bgm_AirCraft_curHomelandMusicE_Bgm_HomelandAudioHelperControllerGetCurrentBgmAudioID��������nextIDLog
exception当前的背景音不正确：，应该播放：scrollListInitListView        _curPlaying	_isPause_curSelectCfgID _curTab_curPlayingTab
changeTab       ipairs_musicID_curPlayingIndexrefreshBtmBarrefreshSetBtn_RefreshSetBtnVisible_ChangeBlurBgBeginIcon_timerEventGameGlobalTimerAddEventTimes�      TimerTriggerCount	Infinite          	           @ @@ A�  �   $@  & �    Logdebug	[Album]            
   
   
   
   
             _ENV                @ $@ & �    CloseDialog                              self 8   :       F   f  & �               9   9   :      id          	lockInfo <   B       � @ �@@ �� � @ A� � � ���@@ �@� `�   ��@  � � �   �� @ �@@ �� �  �  & �    _isLockID           =   =   =   =   =   =   =   =   >   >   >   >   >   >   >   >   @   @   @   @   @   B      a       b          self i   k       E   L � �   d@�& �    onClickItem           j   j   j   j   k      idx          self l       +     � @ ��   �  �@@ �  ����   ���A �AA� ���� $��FB �AB G����� G����B �M�� �C �B��� �� �C GC�_@  �C  � F�C �C�_��  �CC  C� �D �A��  & �            NewListViewItemitemGetUIComponentDynamicUISelectObjectPathgameObjectSpawnObjectUIAlbumItem_music_curTab       SetData_isLockID_curSelectCfgID_curPlaying	_isPause    
    +   m   m   n   n   p   p   p   q   q   q   q   q   s   s   s   t   t   t   t   t   u   v   w   x   x   x   y   z   z   z   z   z   z   {   {   {   {   {   {   }   u   ~         scrollView    +   index    +   item   +   rowPool   +   m   +   cfg   +      selfonClickItem �   �            @ $@ & �    musicTimeTick           �   �   �   �          self3                                                                                                     !   !   !   !   !   !   !   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   $   %   %   %   %   &   &   &   &   '   '   (   (   (   (   )   )   )   )   )   )   *   *   *   *   *   *   *   +   +   ,   ,   ,   ,   ,   ,   ,   .   .   %   %   2   2   2   2   2   2   2   2   2   3   3   3   3   3   3   3   3   3   4   4   4   4   4   4   4   4   4   5   5   5   5   5   5   5   5   5   6   6   6   6   6   6   6   6   6   :   :   B   D   D   D   D   D   E   E   E   E   E   F   F   F   F   F   G   G   G   G   G   H   H   H   H   H   J   J   J   J   K   K   K   K   K   K   M   M   M   M   N   N   N   N   N   N   Q   S   S   S   S   S   S   T   T   T   T   T   T   U   U   U   U   U   U   W   W   W   Y   Y   Y   Y   Y   Z   [   [   [   [   [   [   [   \   \   d   d   d   d   d   d   f   f   f   f   f   f   f   k      �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    3  	uiParams    3  allCfg!   3  musics(   3  counts>   3  	lockInfo?   3  (for generator)B   g   (for state)B   g   (for control)B   g   _C   e   cfgC   e   showG   e   lockM   e   sorter�   3  playing�   3  cfgs�   3  
curMainID�   3  onClickItem�   3  getItem�   3  (for generator)    (for state)    (for control)    idx    cfg       alog_ENV �   �    <   F @ G@� d�� L�� ��@ d@�G A b   ��G@A ��A _�� �
�D   �@A !�A@�� B �@BƀB ���G� � �� B �@B�@A G� � C �@Cǀ� �@  �G�C ��A _��  �D   ��C !�A �� B �@B� D �@��D �D� G� � �� B �@B��C G� � C �@Cǀ� �@ D   I � & �    GameGlobalTimerCancelEvent_timerEvent_isHomeland_curHomelandMusic_curPlaying        Cfgcfg_role_musicCriAudioIDConstBGMEnterHomelandAudioHelperControllerPlayBGMAudioID_curMainMusicUIBgmHelperGetDefaultBgmEnumBgmTypeE_Bgm_Main          <   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    <   cfg      cfg%   9      _ENValog �   �    
�   L@@ ��  �  d� 
@ �L@@ �@ � d� 
@ �L@@ �@  d� 
@��L@@ �@ � d� 
@��L@@ �  � d� 
@��L@@ �� � d� 
@��L@@ �@  d� 
@ �L@@ �@ � d� 
@ �L@@ �  � d� 
@��L@E �� d��
@ �L@E �  d��
@��L@@ �� A d� 
@��L@@ �� � d� 
@��L@@ �� A d� 
@ �L@@ �� � d� 
@ �L@@ �� A d� 
@ �L@@ �@ � d� 
@ �L@@ �@ A	 d� 
@ �K  �@@ �	 A
 �� �@@ A�	 �A
 � A@ ��	 ��
 $� LA@ ��	 �
 d� �A@ �	 A � k@  
@ �K �� A ��A AB G�H �I k@�
@��L@@ �  � d� 
@ �L@@ �  A d� 
@ �L@@ �� A d� 
@ �L@@ �@ � d� 
@ �K   
@��G�M � N �@N�@E A� 䀀J� G�M � N ��N�@E A 䀀J� G�M � N �@O�@E A� 䀀J� & � ?   topButtonsGetUIComponentUISelectObjectPathTopButtons
tab1CountUILocalizationText
Tab1Count
tab2Count
Tab2Count
tab3Count
Tab3CountcoverRawImageLoaderscrollListUIDynamicScrollViewScrollList	progressImagetimecover_small	pauseBtnGetGameObject	PauseBtn
resumeBtn
ResumeBtn	nameTextRollingTextauthorTextmainMusicTextMainMusicTextaircraftMusicTextAircraftMusicTexthomelandMusicTextHomelandMusicText
tab4Count
Tab4Count
tab5Count
Tab5Count	_tabBtnsButtonTab1Tab2Tab3Tab4Tab5
_tabTexts_blurBgblurBg_blurBgNew
blurBgNew_blurBgNewImg	RawImage_anim
AnimationUIAlbum	_setBtnsEnumBgmTypeE_Bgm_MainSetMainE_Bgm_AirCraftSetAircraftE_Bgm_HomelandSetHomeland         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    �      _ENV �      2   � @ @   �& � � @ �    ��@@ � @ �� ��@�� A � @ �� ƀA � A� �� � ����� B �@B� �@�
@ ��@@ � @ �� ��B�� A � @ �� ƀA  A � � �����@C ��C�C G@ A C� �@ � D  �@�& �    _curTab	_tabBtnsinteractable
_tabTextscolorColor;;;;;;�?_animPlayuieff_Album_Switch        scrollListSetListItemCount_musiconClickItem         2   �   �   �   �                                                                       	  	  	  	  	  	  	  	             self    2   tab    2      _ENV   9   V   � @ �@@ �� �@ ��@��@ ����� A �� 	��@A �    ��   � @� �@���� � ��@� �@B ̀�C� �@���B ̀�C  �@�
 Â���   A @� �@���� ǀ��@� �@B ̀�C  �@���B ̀�C� �@�
�Â@��    @� �@��@� ǀ�ǀ�
� �
 Â
@��A�
 ��� �EG��$A F ��$A�AF ���$A����   � @� �@��@� ǀ�ǀ�
���G ��$A��@G ̀��@ & �    _music_curTabID_curSelectCfgID_curPlaying	_isPause当前暂停，继续播:AudioHelperControllerUnpauseBGM	pauseBtn
SetActive
resumeBtn 当前正在播，暂停:	PauseBGM切音乐，开始播:Cfgcfg_role_music_curPlayingIndex_curPlayingTabTagPlayBGMAudioIDrefreshBtmBar_ChangeBlurBgBeginIcon 点了不同的音乐，切换:changeSelectscrollListRefreshAllShownItem          V                                                                                                  !  $  $  $  $  %  %  %  &  '  (  )  )  *  *  *  *  +  +  +  -  -  -  .  2  2  2  2  3  3  3  4  5  5  5  8  8  8  9     self    V   idx    V   cfgID   V   cfg7   F   cfgN   R      alog_ENV ;  C   !   �   �   �@ �@@ ��@�� �@�� A �@A�A  �@���A �@A�A �@�� B �@ �@B ��B�� CGA� $ �@  ��C ��B�� CG�� $ �@  & �    刷新底条信息cover_small
LoadImageIcon	pauseBtn
SetActive	_isPause
resumeBtnmusicTimeTick	nameTextRefreshTextStringTableGetNameauthorTextAuthor          !   <  <  <  =  =  =  =  >  >  >  >  >  ?  ?  ?  ?  @  @  A  A  A  A  A  A  A  B  B  B  B  B  B  B  C     self    !   cfg    !      alog_ENV E  t   �   �   �   �@ �@� ��@�� ����@  A���@A ��A�� BAA $ �@  � ���� ��B��@ �� �@A ̀�F�� G��Cd �@  ���@� �@C�� ����C  A����C ��A�� BA $ �@   ���� ��BǀC �� ��C ̀�F�� G��Cd �@   ��@� �@D�� ����D  A����D ��A�� BA $ �@  @���� ��BǀD �� ��D ̀�F�� G��Cd �@  @���@  A���@A ��A�� BAA $ �@  ����� ��B��@ �� �@A ̀�F�� G��Cd �@  ��C  A����C ��A�� BA $ �@  ����� ��BǀC �� ��C ̀�F�� G��Cd �@  ��D  A����D ��A�� BA $ �@  ����� ��BǀD �� ��D ̀�F�� G��Cd �@  & �    刷新底部按钮EnumBgmTypeE_Bgm_Main_curMainMusic        mainMusicTextRefreshTextStringTableGetstr_album_mainCfgcfg_role_musicNameE_Bgm_AirCraft_curAircraftMusicaircraftMusicTextstr_album_aircraftE_Bgm_Homeland_curHomelandMusichomelandMusicTextstr_album_homeland          �   F  F  F  G  G  G  G  H  H  H  J  J  J  J  J  J  J  J  L  L  L  L  M  M  M  M  M  M  M  N  O  O  O  O  P  P  P  Q  Q  Q  Q  Q  Q  Q  Q  S  S  S  S  T  T  T  T  T  T  T  U  V  V  V  V  W  W  W  X  X  X  X  X  X  X  X  Z  Z  Z  Z  [  [  [  [  [  [  [  \  ^  ^  ^  `  `  `  `  `  `  `  `  b  b  b  b  c  c  c  c  c  c  c  f  f  f  g  g  g  g  g  g  g  g  i  i  i  i  j  j  j  j  j  j  j  m  m  m  n  n  n  n  n  n  n  n  p  p  p  p  q  q  q  q  q  q  q  t     self    �   type    �   cfg      cfg1   8   cfgL   S   cfgc   j   cfgy   �   cfg�   �      alog_ENV v  ~   	   F @ �@@ d ����@ �  ����@ �A�AB@ BA_ �  �B  � �A�@���@ �A�AB@ BA �  �B  � �A�i�  �@�& �    pairsEnumBgmType_isHomeland	_setBtns
SetActiveE_Bgm_Homeland            w  w  w  w  x  x  x  y  y  y  y  y  y  y  y  y  y  y  {  {  {  {  {  {  {  {  {  {  w  w  ~     self       (for generator)      (for state)      (for control)      _      bgmType         _ENV �  �      � @ �@@�� �@�& �    cover
LoadImageIcon           �  �  �  �  �     self       cfg            �  �   	?   F @ G@� d�� b    �F @ G�� d��  ��   �A�  � A �@AǀA �� ��A� B �   ��� @ �@�䀀  ������B �BR�N��$�   �����C �CA ��A �A �]�$A ƀB ǀ�� � � @ ���D � �FAE G���� d� �� �AE ǁ�  �  ]��@��@F �� � �& �    AudioHelperControllerBGMPlayerIsPlaying!GetPlayingBGMTimeSyncedWithAudio        Cfgcfg_role_music_curPlaying	Duration_developmentGetPlayingBGMTotalTimeMsmathabs�            �?ToastManager
ShowToast音乐配置时长错误！ID:，真实时长:floortimeSetTextUIBgmHelperFormatTime/<color=#9d9d9d>	</color>	progressfillAmount         ?   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    ?   time   >   	duration   >   realDua   '      _ENV �  �      �   �   �@ �@@ �  �@�& �    切换tab1
changeTab                  �  �  �  �  �  �  �     self       go          alog �  �      �   �   �@ �@@ �  �@�& �    切换tab2
changeTab                  �  �  �  �  �  �  �     self       go          alog �  �      �   �   �@ �@@ �  �@�& �    切换tab3
changeTab                  �  �  �  �  �  �  �     self       go          alog �  �      �   �   �@ �@@ �  �@�& �    切换tab4
changeTab                  �  �  �  �  �  �  �     self       go          alog �  �      �   �   �@ �@@ �  �@�& �    切换tab5
changeTab                  �  �  �  �  �  �  �     self       go          alog �  �      �   �   �@ 
�����@ � A  �@��@A � A� �@���� ��A�@� � B �@B�@ & � 
   暂停	_isPause	pauseBtn
SetActive
resumeBtnAudioHelperController	PauseBGMscrollListRefreshAllShownItem             �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       go          alog_ENV �  �      �   �   �@ 
�����@ � A� �@��@A � A  �@���� ��A�@� � B �@B�@ & � 
   继续播放	_isPause 	pauseBtn
SetActive
resumeBtnAudioHelperControllerUnpauseBGMscrollListRefreshAllShownItem             �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       go          alog_ENV �  �   5   �   �   �@ �@@ ��@ �@ ���@ A � �� �� ���@ A � �ǀ��@�A G�A @@��A � � �B � $A���B � $A�B � $A� ��@ GA A� GAA
@��
���F�� G���CdA LAC � dA�L�C ��CdA�& �    
上一首_curPlayingIndex       _music_curPlayingTabID_curTab_curSelectCfgIDonClickItem_curPlayingAudioHelperControllerPlayBGMAudioIDrefreshBtmBar_ChangeBlurBgBeginIcon          5   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    5   go    5   index   5   count      
lastCfgID   5   cfg'   4      alog_ENV �  �   	5   �   �   �@ �@@ ��@��@ A � �� � ��  ���  �@ GA A� AAGA ��A ��@�G�A  �� �LB � dA���LB � dA�LB � dA� �G�@ �A G��G���A�
���
������ ��B���A �AC  ��A���C ���A�& �    
下一首_curPlayingIndex       _music_curPlayingTabID_curTab_curSelectCfgIDonClickItem_curPlayingAudioHelperControllerPlayBGMAudioIDrefreshBtmBar_ChangeBlurBgBeginIcon          5   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    5   go    5   index   5   count	   5   
nextCfgID   5   cfg'   4      alog_ENV �     	   �   �   �@ �@  ǀ@ @�@ ���@ ��ǀ@ �@  �@ ��@    ���@ � A GAA �  Ɓ� ���  �@ & �    设置主页背景音        _curMainMusic_curPlaying
StartTaskreqChangeBgmEnumBgmTypeE_Bgm_Main             �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                            self       go       id         alog_ENV      	   �   �   �@ �@  ǀ@ @�@ ���@ ��ǀ@ �@  �@ ��@    ���@ � A GAA �  Ɓ� ���  �@ & �    设置风船背景音        _curAircraftMusic_curPlaying
StartTaskreqChangeBgmEnumBgmTypeE_Bgm_AirCraft                               	  	  	  	  
  
                       self       go       id         alog_ENV          E   �   d@ A@  ��@ @@@ �G�@ ����@ ��@ � @ �A@    �G�@ � A AA @  ��� ��A�� �@ & �    设置家园背景音        _curHomelandMusic_curPlaying
StartTaskreqChangeBgmEnumBgmTypeE_Bgm_Homeland                                                                 self       id         alog_ENV "  A   	p   @ �A@ � $A  �@ �@�� �  �$��LAd� b  ��G�@ L����A ��d��
@��G�@ L����A ǁ�d��
@��G�@ L����A ��d��
@��LAC � dA�F�A G�@@�����F�C G��AD ��D�� � dA  @�F�C G��AD ��D� � dA  @�F�A G��@@�����F�C G��AD ��D�A � dA  ��F�C G��AD ��D�� � dA  ��F�A G�@������F�C G��AD ��D�� � dA  @�F�C G��AD ��D� � dA  @�F�C G��A ́F� dA  L�F �A@ � dA  & �    LockGetName_roleModuleRequestRole_MusicGetSucc_curMainMusicUI_GetMusicEnumBgmTypeE_Bgm_Main_curAircraftMusicE_Bgm_AirCraft_curHomelandMusicE_Bgm_HomelandrefreshSetBtn        ToastManager
ShowToastStringTableGetstr_album_main_defaultstr_album_main_changedstr_album_aircraft_defaultstr_album_aircraft_changedstr_album_homeland_defaultstr_album_homeland_changedunkown error:
GetResultUnLock         p   #  #  #  #  $  $  $  $  $  $  %  %  %  %  &  &  &  &  &  &  '  '  '  '  '  '  (  (  (  (  (  (  )  )  )  *  *  *  *  +  +  ,  ,  ,  ,  ,  ,  ,  ,  .  .  .  .  .  .  .  /  0  0  0  0  1  1  2  2  2  2  2  2  2  2  4  4  4  4  4  4  4  5  6  6  6  6  7  7  8  8  8  8  8  8  8  8  :  :  :  :  :  :  :  <  >  >  >  >  >  >  @  @  @  @  A     self    p   TT    p   type    p   id    p   res
   p      _ENV C  T   	"   � @ �@@ � �@�� @ ��@��@  �@�� @ ��@��@� �@��  �@A @ �@�ǀA ���A � �@ �@ � G�A L����  d� L���  dA�& �    _blurBgNew
LoadImagegameObject
SetActive UIAlbumController:_ChangeBlurBgLock_blurBgNewImgDOFade                     �?OnComplete        O  R    	       @ � � $@�   @@ �  $@�& �    _ChangeBlurBgEndUnLock        	   P  P  P  P  Q  Q  Q  Q  R         selficonlockId"   D  D  D  D  F  F  F  F  F  G  G  G  G  G  I  J  J  J  K  K  K  K  K  L  M  N  N  N  N  N  N  R  N  T     self    "   icon    "   lockId   "   targetFade   "   	duration   "        V  ]      � @ �@@ � �@�� @ ��@��@  �@�� @ ��@��@� �@�� A ��@��@  �@�& �    _blurBg
LoadImagegameObject
SetActive_blurBgNew           W  W  W  W  Y  Y  Y  Y  Y  Z  Z  Z  Z  Z  \  \  \  \  \  ]     self       icon           S                           �      �   �   �   �   �   �   �     �     9    ;  C  ;  E  t  E  v  ~  v  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �    �               "  A  "  C  T  C  V  ]  V  ]     alog   S      _ENV