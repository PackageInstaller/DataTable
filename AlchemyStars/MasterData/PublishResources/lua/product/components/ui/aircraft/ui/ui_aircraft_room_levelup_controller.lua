LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/150/client/Assets/../PublishResources/lua/product/components/ui/aircraft/ui/ui_aircraft_room_levelup_controller.lua         1    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ �@B l� 
@ �@B l� 
@��@B l  
@ �@B l@ 
@��@B l� 
@ �@B l� 
@��@B l  
@ �@B l@ 
@��& �    _class UIAircraftRoomLevelUpControllerUIControllerOnShowOnHideInitWidgetNewMatItemOnMatClickSetRoomMsg UIAircraftRoomLevelUpControllerCheckPreconditionButtonCancelOnClickButtonLevelUpOnClickButtonConditionConfirmOnClickButtonConditionCancelOnClick
RequestUpHandleDataToUI	FlushMat           0    
�   � @ �@ ��� 
����@@ � A�� 
�����A ��A��� � BAB ���
����@@ ��B�� 
� ��@C ��C� ���
� �� C � D  D � �@��@D ��DA@ �D$ �@  � E ƀE ���A@ F$ �  ������E ��E�@ �� ƀE ���� � �F @ �G �AG�A@ ́�� B@ �G$� ���� ]��
A��H @��AH ��H�� ��HB@ I$� BI���]��
A��  
 ��I $A J  !@J 	��J ��
 � $� 
�˖�K 
�˖�J � �A $� F�L � � d��
A�F�L ��  ��  d��
A��F�L � � d��
A�GNLA�ƁN �N L� d�  G�
A��GAO J�ϖA@ �O$� "A  @�P �A ƁP ���$� GQ ��Q� ���J���R $A AR $A & � J   InitWidget	roomData       	_spaceIDSpaceIdairDataGameGlobal
GameLogic
GetModuleAircraftModule	roomTypeGetRoomTypetopBarWidgettopbarSpawnObjectUIAircraftTopBarItemSetDatarawImageRoomIcon
LoadImageGetRoomIcon1textRoomNametextStringTableGetGetRoomName#str_aircraft_tip_levelup_needpower"str_aircraft_tip_levelup_needtimetextNeedPowermathceilGetUpgradeNeedPowerGetCurrentPowertextNeedTimeHelperProxyGetInstanceFormatTimeGetUpgradeNeedTime<       _matWidgets	FlushMatmats       GetUIComponentScrollRectScrollViewNeedMatsenabled scrollViewNeedMatsRectTransformMatContent
anchorMinVector2        
anchorMax
offsetMin
offsetMaxparentGetComponenttypeofUnityEngine
sizeDeltamatContentEnoughPowerToUpgrade	GetAssetUIAircraftLevel.spriteatlas	LoadTypeSpriteAtlaspowerBgsprite
GetSpritewind_shengjiang_gezi3SetRoomMsgCheckPrecondition         �               	   	   	   	                                                                                                                                                                                                                                                                    !   !   "   "   "   "   #   #   #   #   #   $   $   $   $   $   %   %   %   %   %   &   &   &   &   &   &   &   &   &   '   '   *   *   *   *   *   +   +   +   +   +   ,   ,   ,   ,   ,   .   .   /   /   0      self    �   	uiParams    �   strNeedPower0   �   strNeedTime4   �   rectb   |   atlas�   �      _ENV 1   2       & �                2      self            5   @    .   L@@ ��  �  d� 
@ �L@@ �@ � d� 
@ �L@@ �  A d� 
@��L@@ ��  � d� 
@ �L@@ �  A d� 
@ �L@@ �  � d� 
@ �L@@ �@ � d� 
@ �L@@ �  � d� 
@��L@@ �� � d� 
@��& �    topbarGetUIComponentUISelectObjectPathTopbarrawImageRoomIconRawImageLoaderRawImageRoomIcontextRoomNameUILocalizationTextTextRoomNameimageRoomPropertiesImageRoomPropertiestextNeedPowerTextNeedPowertextNeedTimeTextNeedTimescrollViewNeedMatsUIDynamicScrollViewScrollViewNeedMatspowerBgImagematContentHorizontalLayoutGroupMatContent        .   6   6   6   6   6   7   7   7   7   7   8   8   8   8   8   9   9   9   9   9   :   :   :   :   :   ;   ;   ;   ;   ;   =   =   =   =   =   >   >   >   >   >   ?   ?   ?   ?   ?   @      self    .        B   W         @@ ��   �  �@� A�  䀀�@ � �A�$� L�A�� d���B �AB���AB�BL����  l  �  dB GC �BBJB�  & �            NewListViewItemmatGetUIComponentDynamicUISelectObjectPathgameObjectSpawnObjectUIItemsWidgetmats              SetData_matWidgets        P   R       �   � @   @� �@ & �    OnMatClick           Q   Q   Q   Q   Q   R      _id       pos          self   C   C   D   D   F   F   F   G   G   G   G   I   I   I   J   J   J   K   L   M   N   O   R   T   M   U   U   U   V   W   	   self       _scrollView       _index       item      rowPool      mat      matData      id      need           Y   [       � @ AA  �� �@ & �    ShowDialogUIItemGetPathController           Z   Z   Z   Z   [      self       matId       pos            ]   g       F @ G@� � � ǀ@ d����@ � AA \� �@ ��@ ��A�� ��  A� ���ǁ� �B�B��� ��G��$B ��& �     UIAircraftRoomLevelUpControllerHandleDataToUI	roomDataimageRoomPropertiesSpawnObjectsUIAircraftLevelInfoItemGetAllSpawnList       SetDatatitlefirstsecond            ^   ^   ^   ^   ^   `   `   `   `   `   b   b   b   c   c   c   c   d   e   e   e   e   e   e   e   c   g      self       uiInfos      items      (for index)      (for limit)      (for step)      i      msg         _ENV i   r       G @ L@� ǀ@ d��� �  ������ A AA ��A �� �@��   �  � � �  & �    airDataGetRoomLevelUpPreCondition	_spaceID        ShowDialog!UIAircraftPreconditionController	roomData           j   j   j   j   k   l   l   n   n   n   n   n   o   o   q   q   r      self       conds      count           t   v       � @ �@ & �    CloseDialog           u   u   v      self       go            x   �    
,   � @ �� �@    �& � �@@ ��@�� �@  ����@ � A�@A ǀ�� �  �@  & � � � � B AB � ����$� "B  � ��   ��$B @ ��  jA��@    �& � � C �@�䀀 ̀�G�C �  �@ & �    CheckPrecondition	roomDataEnoughPowerToUpgradeToastManager
ShowToastStringTableGet+str_toast_manager_star_power_is_not_enoughipairs_matWidgetsIsMatEnoughShakeAndHighlightGameGlobalTaskManager
StartTask
RequestUp         ,   z   z   z   z   {   ~   ~   ~   ~   ~                        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    ,   go    ,   enough   ,   (for generator)   !   (for state)   !   (for control)   !   _      widget         _ENV �   �       � @ �@ & �    CloseDialog           �   �   �      self       go            �   �       � @ �@ & �    CloseDialog           �   �   �      self       go            �   �    <   � @ A@ $ �@  ��@ ��@ � GA �� �@A� �   @�̀A �@ ��A � �䀀 �@�F�B G���@���A � �䀀 �@�F�B G��@���A � �䀀 �@�F�B GA���C ��C�A �@�� D �@��D �DA $ �@  ��� D �@��@ AE��E� $  �@  ��E LA@ d �@  & �    LockGetNameairDataRequestRoomUpgrade	_spaceIDGetSuccCloseDialogGameGlobalEventDispatcher	DispatchGameEventTypeAircraftRefreshTopbarAircraftSettledPetChangedAircraftPlayDoorAnimAircraftDoorAnimLevelUpToastManager
ShowToastStringTableGetstr_aircraft_upgrade_successGetErrorMsg
GetResultUnLock         <   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    <   TT    <   result	   <      _ENV �      $  � � �� �     "   @�LA� d� � �K  ��@ �A�AA ǁ��@ AL�� d $  ��  J��JAB��� � ��J���� �AC��J����C ��C�  ��A� �L� d� � �K  ��@ �A�AA ǁ��@ AL�� d $  ��  J��JAD��� � ��J���� �AC��J����C ��C�  ��A�AA ���A h�6�G��B�ǂ���G��CE ��E�� �_@ 4��  ��@ ��  � ���� ����C�ƃC ���  @ �C�@0��CE ��E����_@�.��  ��@ ��  � ���� ��F �C�� @ 䃀����F �C�� @�䃀���ƃC ���  @ �C��(��CE ��F��@��  � �"  ����@ ��  @ 䃀��� ���@ ��  � ���ƃC ���  @ �C� "��CE �G�� �_@� ��  ��@ ��  � ���� ��CG ǃ��G�  ������CG ǃ����  �����ƃC ���  @ �C����CE �CH�� ��������@ �_��@�  F�@ G�� d� 
D�
 �@ �	 ��]Ą
D�@ �	 ��]Ą
D�F�C G��� � dD����CE �CI�� �_@ ��  ��@ ��  � ���� �ƃI ���� ��@ 䃀���ƃI ���� ��@�䃀���ƃC ���  @ �C�@	��CE �CJ��@�_@���  ��@ ��  � ���� ���@ ���
 FF GD���
 �Kd��  �����@ ���
 FF GD���
 ��d��  ���ƃC ���  @ �C�g��& & � -   LevelGetUpgradeInfotitleStringTableGetAirLevelInfoTitle
RoomLevelGetRoomName
isLevelupfirstLv.second       tableinsertGetDegradeInfo                      AirRoomChangeLevelDataType
NumberIntNumberFloatstringformat%.2f	TextDataNumberPercentmathfloord       %CurAndLimit              /TimeHelperProxyGetInstanceFormatTime_2Hour str_aircraft_level_hour_formate%.1f               $  �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                                                  	  	  	  	  	  	  	  
  
  
  
  
  
  
                                                                                          �          levelUp    $  	roomData    $  level   $  infos   $  uiInfos   $  uiinfo
   #   uiinfo(   A   (for index)D   "  (for limit)D   "  (for step)D   "  iE   !  dataF   !  titleG   !  typeH   !  value1I   !  value2J   !  uiinfoQ   ^   uiinfof   }   uiinfo�   �   uiinfo�   �   value3�   �   value4�   �   uiinfo�   �   uiinfo�   �   uiinfo  !     _ENV   #      G@@ L�� d� 
@ �G�@ L � � @ � �,  d@ & �    mats	roomDataGetUpgradeNeedscrollViewNeedMatsInitListView          !      �   � @   @� �  �   & �    NewMatItem                             !     _scrollView       _index          self                   !    #     self           1                        0      1   2   1   5   @   5   B   W   B   Y   [   Y   ]   g   ]   i   r   i   t   v   t   x   �   x   �   �   �   �   �   �   �   �   �   �     �     #    #         _ENV