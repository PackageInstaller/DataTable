LuaS �

xV           (w@Y@../PublishResources/lua/product/components/ui/season/s1/ui_season_s1_collection_tab.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �& �    _classUISeasonS1CollectionTabUICustomWidgetOnShowInitWidgetSetDataSetShow
_OnSelectFinalPlotEnterOnClickGetGuideItemPlayExitAnim           	       � @ �@ 
���& �    InitWidget_firstItem                     	      self       	uiParams                    9   L@@ ��    d� 
@ �L@@ ��  �  d� 
@��L@@ ��   d� 
@ �L@@ �� A d� 
@��L@@ ��  � d� 
@��L@@ �@ � d� 
@ �L@@ ��   d� 
@��L�C �� d��
@��L�C �@ d��
@ �L�C �� d��
@ �L�C d� L@� ƀE �E F�  d�  
@ �& �    titleGetUIComponentUILocalizationText
conditiontimeiconRawImageLoaderdescontentUISelectObjectPathContent_condition2condition2_unlockGetGameObjectUnlock_lockLock_finalPlotEnterGoFinalPlotEnter_animGetComponenttypeofUnityEngine
Animation         9                                                                                                                                                                                  self    9      _ENV #   6    +   
@ ���� �� 
����   � @ ���� AA �A�� ��$� 
 � @�� (��@ BB��$��GA GL���   dB G�B bB  � �GA G
@��'��
@C��C �@ �AB ��$A  & �    _collageData
_seasonIDGetSeasonIDGetCollectionCount_itemscontentSpawnObjects UISeasonS1CollageCollectionItem       GetCollectionByIndexSetData_firstItem_curSelectIdx 
_OnSelect        '   )       E   L � �   d@�& �    
_OnSelect           (   (   (   (   )      data          self+   %   &   &   &   )   *   *   *   ,   ,   ,   ,   ,   ,   -   -   -   -   .   .   .   .   /   /   /   /   /   /   0   0   0   1   1   1   -   4   5   5   5   5   5   5   6   	   self    +   data    +   onClick   +   count   +   (for index)   #   (for limit)   #   (for step)   #   i   "   data   "        8   :       � @ �� �@@ � �@�& �    GetGameObject
SetActive           9   9   9   9   9   :      self       show            =   t    �   � @ �@� � �   �& � � @ �   @���@ � @ �� ��@  �@��@� �� 
� ���@ �@� � �� ��@C� �@�� � � AA �A� L�� d� b  ��GB LA��� dA�L�B�  dA�L�B �C �A�dA�G�C L���DdA�GAD L���  dA�
 ŉLA� d� b  ��G�C L����E ��dA�FAA GA�G����F ��FG BGG�G$ �A  ��G ��FG BGG�$ �A  �AH ��FG BGG��$� A� �G �BG���� ��A��A� �� ǁI ���FG GB���	 �J   � d  �A  �AJ ́�C� �A�ǁJ ́�C  �A���J�  @�  FBA G��BK G��b    ���"  ���@��BD ��D� �B���K
���L BL$B L �L�� $B���G�C L����E  A � �B ��dA  G�M L���G �A��G� dA  GAJ L���  dA�G�J L���� dA�GL LA�dA GL L���� dA�& � 8   _curSelectIdxIndex_items
SetSelectIDCfgcfg_item_season_collectionIsNew_collageDataCollectionCancelNewSetNewDispatchEventGameEventTypeUISeasonS1OnSelectCollageItemicon
LoadImageHdImage_finalPlotEnterGo
SetActive_finalStoryID IsGot	SetColorColorwhite	cfg_item
conditionSetTextStringTableGetRequireDesctitleNamedesIntro
RpIntroGetTimetimestr_season_require_timeTimeToDate_unlock_lockComposeQuestIDcfg_season_campaign_client
_seasonIDFinalStoryQuestIDComposeStoryID_animStopPlay&uieffanim_UISeasonS1CollectionTab_in2        �������?_condition2)uieffanim_UISeasonS1CollectionTab_middle         �   >   >   >   >   >   ?   A   A   A   B   B   B   B   B   B   D   D   D   E   E   E   E   F   F   F   G   G   H   H   H   I   I   I   I   J   J   J   J   K   K   K   L   L   L   L   N   N   N   N   O   O   O   O   P   Q   Q   Q   Q   R   R   R   R   R   S   S   S   T   T   T   T   T   T   T   U   U   U   U   U   U   U   V   V   V   V   V   V   V   V   V   V   V   V   V   X   X   Y   Y   Y   Y   Y   Y   Y   Y   Y   Y   Z   Z   Z   Z   [   [   [   [   ]   ^   ^   _   `   `   `   `   a   a   b   d   d   d   d   f   f   f   f   g   g   j   j   j   k   k   k   k   k   m   m   m   m   m   m   m   m   m   n   n   n   n   n   n   n   o   o   o   o   p   p   p   p   q   q   q   r   r   r   r   t   
   self    �   data    �   item   �   cfgID   �   cfg   �   itemCfgB   �   time_   �   composeQuestIDr   �   finalStoryQuestIdu   �   seasonClientCfgy   �      _ENV v   }       � @ �@    �& � �   �@@ ǀ�@ @ �@�& �    _finalStoryIDUISeasonHelperPlayStoryInSeasonScence            w   w   w   x   z   |   |   |   |   |   }      self       go       cb         _ENV    �       G @ L@� ��  e �f   & �    _firstItemGetGameObjecticon           �   �   �   �   �   �      self            �   �       G @ L@� ��  d@�& �    _animPlay&uieffanim_UISeasonS1CollectionTab_out           �   �   �   �   �      self                                   	                #   6   #   8   :   8   =   t   =   v   }   v      �      �   �   �   �          _ENV