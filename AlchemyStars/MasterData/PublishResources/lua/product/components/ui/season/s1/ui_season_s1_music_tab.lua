LuaS �

xV           (w@T@../PublishResources/lua/product/components/ui/season/s1/ui_season_s1_music_tab.lua         4    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��& �    _classUISeasonS1MusicTabUICustomWidgetOnShowOnHideInitWidgetSetDataSetShow
_OnSelectPlayOnClickPauseOnClickLastOnClickNextOnClick_RefreshPlayBar_ResetProgress_PlayingTick_SnapToPlayExitAnim                  � @ �@ ��@ ��@��� 
���� A �@A�� A@ �@�� B �@B�� 
���
�B�& �    InitWidget_lastBGMAudioIDAudioHelperControllerGetCurrentBgmLoginfo正在播放的bgm:_timerHolderUITimerHolderNew_pause                              	   	   	   	   	                        self       	uiParams          _ENV        +   G @ b    �G @  @��@�G�@ L�� � @ d��L � d� �@A _��  ���A ��A�@A �@ � B �@B�� AA �@�G�B b   ��G�B L � d� b   � �G�B L@� d@ G�C b   � �G�C L�� d@ 
 D�& �    _curIdx        _collageDataGetMusicByIndexAudioID_lastBGMAudioIDAudioHelperControllerPlayBGMLoginfo恢复正在播放的bgm:	_tweener
IsPlayingKill_timerHolderDispose          +                                                                                                                                       self    +   audioID         _ENV !   @    M   L@@ ��  �  d� 
@ �L@@ �@  d� 
@ �L@@ �@ � d� 
@ �L@@ �  A d� 
@��L@@ �  � d� 
@ �L@@ �  A d� 
@ �L@@ �  � d� 
@ �L@@ �@  d� 
@ �L@@ �� A d� 
@��L@@ �� �  d� �@� ��E
� �
 Ƌ��� 
����@@  A�  �� 
����@@  A� �� ��G� H
�����H �� ��HI FAI G��$ ��  
���& � '   contentGetUIComponentUISelectObjectPathContent
musicNameUILocalizationTextauthorplayButtonPlaypausePausenextNextlastLasttime	progressImageHorizontalLayoutGroup_paddingLeftpaddingleft_cellSizeX�      _cellSpaceXspacing_contentRectRectTransform_viewPortWidth	Viewportrectwidth_animGetGameObjectGetComponenttypeofUnityEngine
Animation         M   $   $   $   $   $   &   &   &   &   &   (   (   (   (   (   *   *   *   *   *   ,   ,   ,   ,   ,   /   /   /   /   /   1   1   1   1   1   3   3   3   3   3   4   4   4   4   4   7   7   7   7   8   8   8   9   :   :   <   <   <   <   <   =   =   =   =   =   =   =   ?   ?   ?   ?   ?   ?   ?   ?   ?   @      self    M   contentLayout1   M      _ENV D   _    ;   
@ �� @ ��@�� 
���� A �@A� GA@ �� 
����   �   � GA@ �� (��@ B��$��G�@ GLB��   dB L�Bd� b  @�G�B �C�� ��  ��  '���   ��AC �CA� ��� $A  AD ���� $A @ ��D $A @ AE$� 
@�
 ��& �    _collageData_musicCountGetMusicCount_itemscontentSpawnObjectsUISeasonS1CollageMusicItem       GetMusicByIndexSetData	IsUnlock_lastBGMAudioIDAudioIDLoginfo选中默认bgm:ID
_OnSelect_RefreshPlayBar_unlockCount_totalCountGetMusicProgress         J   L       E   L � �   d@�& �    
_OnSelect           K   K   K   K   L      data          self;   E   F   F   F   F   H   H   H   H   H   H   L   N   O   O   O   O   P   P   P   P   Q   Q   Q   Q   Q   Q   R   R   R   R   R   R   R   R   R   S   O   W   W   X   X   X   X   X   X   Y   Y   Y   Y   Y   [   [   ^   ^   ^   ^   ^   _   	   self    ;   data    ;   	onSelect   ;   defaultData   ;   (for index)   &   (for limit)   &   (for step)   &   i   %   data   %      _ENV a   o       � @ �� �@@ � �@�b    ���@ ��@ AA �  �@���A �@ � ���@ ��A �@�& �    GetGameObject
SetActive_timerHolderStartTimerInfinitePlayingTick�      _PlayingTick
StopTimer        g   i            @ $@ & �    _PlayingTick           h   h   h   i          self   b   b   b   b   b   c   c   d   d   e   f   i   d   k   k   k   m   m   m   m   o      self       show            r   �    A   � � � �@    �& � �@� � �@    �& � ǀ@ �� $�  �  �& � � � � �   ���@A ̀�@� �@���A �� $� � �� �C  �@��@B F�B G���@�ǀ@ �    ���A �@ � �� ��@ ��� � 
� ���A �@ � ��@��@ �@  @�ƀC ���� $ �@  ��
�Ĉ��D �@ � E �@ & �    IsValid	IsUnlock_curIdxIndexIsNew_collageDataMusicCancelNew_itemsSetNewDispatchEventGameEventTypeUISeasonS1OnSelectCollageItem	DeselectSelectAudioHelperControllerPlayBGMAudioID_pause _RefreshPlayBar_ResetProgress         A   s   s   s   s   t   v   v   v   v   w   z   z   z   z   z   {   ~   ~   ~   ~               �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    A   data    A   isInit    A      _ENV �   �       � @ �@    �& � �@@ �@   ���@ ��@�  �@ & � 
@����A �@ ��A � @ �� � B�@ �@B ��B�@ & �    _curIdx_pauseLoginfo当前bgm正在播放 _RefreshPlayBar_itemsPlayEftAudioHelperControllerUnpauseBGM            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       go          _ENV �   �       � @ �@    �& � �@@ �    ���@ ��@�  �@ & � 
@����A �@ ��A � @ �� � B�@ �@B ��B�@� & �    _curIdx_pauseLoginfo当前bgm已暂停_RefreshPlayBar_items	PauseEftAudioHelperController	PauseBGM            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       go          _ENV �   �        � @ �@    �& � �@@ �@ ���@ � A�@ �@ & � �   � @ !��@���@ � �� �@ �@@ @ �� @ �����A � �@ 䀀AB ��$A�& � 
   _curIdx_unlockCount       Loginfo只有一首，别切了当前bgm是第一首_collageDataGetMusicByIndex
_OnSelect             �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self        go        target       data          _ENV �   �    !   � @ �@    �& � �@@ �@ ���@ � A�@ �@ & � �   � @ A@ !� @���@ � �� �@ ��  @ �� @ �����A � �@ 䀀AB ��$A�& � 
   _curIdx_unlockCount       Loginfo只有一首，别切了当前bgm是最后一首_collageDataGetMusicByIndex
_OnSelect         !   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    !   go    !   target   !   data   !      _ENV �   �    V   G @ b   ��G@@ L�� � @ d����@ � A�@� � �� ǀA ���FB GA���Bd �@  ��B ���FB GA��Cd �@  �@C �    �ǀC ���� �C� �@�ǀC ʀĈ��D ���� �C  �@���ǀC ���� �C  �@���D ���� �C� �@���D ʀĈ� E ʀĈ�@E ʀĈ@�G�A L�� �� d@�G�B L�� �� d@�G�C G�� L � � � d@�G�C J�ňG@E J�ňG E J�ňG�D G�� L � �   d@�L F d@ & �    _curIdx_collageDataGetMusicByIndexCfgcfg_role_musicID
musicNameSetTextStringTableGetNameauthorAuthor_pauseplaygameObject
SetActiveinteractablepauselastnext _ResetProgress         V   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    V   data   :   cfg   :      _ENV �   �       G @ J���G�@ L � �@ d@�& �    	progressfillAmount        timeSetText           �   �   �   �   �   �   �      self                 
K   G @ b     �& � G@@ L�� ��@ d��� � �� �@A ǀ�䀀 _�   �& � �@A ��A��� �    ��@A � B���  @B  ��@ ̀� � �B "  ��AA C$��   ����FAC G����C�� d�  @���FAD G���� �E B R�C�AdA AC �ER�CP��$� �  �E F�AF ��F� �� �� BF �F@�$� �$A�G R� 
A��& �    _pause_collageDataGetMusicByIndex_curIdxAudioIDAudioHelperControllerGetCurrentBgmBGMPlayerIsPlaying!GetPlayingBGMTimeSyncedWithAudio        	Duration_developmentGetPlayingBGMTotalTimeMsmathabs�            �?ToastManager
ShowToast音乐配置时长错误！ID:_curPlaying，真实时长:floortimeSetTextUIBgmHelperFormatTime/	progressfillAmount         K                                   	  	  	  	  	  
  
  
                                                                                                           self    K   data   K   time   J   	duration   J   realDua#   4      _ENV   .   	?   � @ �@�ǀ����A �@ � A �@�ǀ��A GB �AB M����� O��AGB R��AGC R��AFAC G��� �� C �d� ��   ��GD b  ��GD LA�d� b  � �GD L��dA GA L���  d� LA�ƁE ������A�d��
@�@�GA ��F � � ���J��& �    UnityEngineUILayoutRebuilderForceRebuildLayoutImmediate_contentRectrectwidth_paddingLeft_cellSizeX_cellSpaceX              _viewPortWidthMathfClamp        	_tweener
IsPlayingKillDOAnchorPosXffffff�?SetEaseDG	TweeningEase	OutCubicanchoredPositionVector2         ?                     !  !  !  #  #  #  #  #  #  #  #  #  #  $  $  #  %  %  %  %  %  %  %  %  &  &  '  '  '  '  '  '  '  '  (  (  (  *  *  *  *  *  *  *  *  *  *  *  *  *  ,  ,  ,  ,  ,  ,  .     self    ?   index    ?   animate    ?   width	   ?   x   ?      _ENV 0  5      G @ L@� ��  d@�A�  � A ��  h� �GAA G�L��dA g��& �    _animPlay!uieffanim_UISeasonS1MusicTab_out       _musicCount_itemsPlayExitAnim           1  1  1  1  2  2  2  2  3  3  3  3  2  5     self       (for index)      (for limit)      (for step)      i          4                                       !   @   !   D   _   D   a   o   a   r   �   r   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �           .    0  5  0  5         _ENV