LuaS �

xV           (w@d@../PublishResources/lua/product/components/ui/aircraft/dispatchtask/ui_dispatch_map_controller.lua         @    @ A@  ��@ $@�@@  ��@@ l   
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
@ �@D l� 
@ �@D l� 
@��@D l  
@ �@D l@ 
@��@D l� 
@ �& �    _classUIDispatchMapControllerUIControllerLoadDataOnEnterOnShowOnHide
RefreshUIReqDataAndRefreshRoomMsgRefreshTipsPanelGetRemaindTimeStr	_ReqDataRefreshTaskGetAllRewardsOnBack_RequestRoomDataOnHomeOnHelpUIDispatchMapControllerGetTaskBtnTipsBtnOnClickMaskOnClickCloseTipsBtnOnClickGetRoomInfoGameobject                  A@ �@F�@ $� 
 �@ A�� $A�@ AA�� $A�@ �A�B �AB$��
 ��A �B$� 
 �& �    _aircraftModuleGameGlobal
GetModuleAircraftModuleHandleCEventDispatchSiteHandleCEventDispatchLook
_roomDataGetRoomByRoomTypeAirRoomTypeDispatchRoom_maxPointCountGetSiteMaxNum                                       	   	   	   	                                       self       TT       res       	uiParams          _ENV    6    d   �@� 
� ���@ ��@� A �@��@ ��A ��A��� � BAB �BF�B G���@ � C AB ACG�C �@ � D A A� �� 
�����C � EA ���
�����D ��E,  lA  ��  �@�� D  AA �� 
���� D  A� �� 
� �� D  AA �� 
� �� D  A� �� 
� ��@H � ���
� ��@H 	 ���
����@H �	 ���
����@H 
 ���
����   
����@  ǀJ A  �@��D B F�J ��d ��  �EA 䁀BJ GBJ \�MB�
� �
�˖��C �@ ��K �@ & � 0   enterFromEasy       AudioHelperControllerPlayUISoundAutoReleaseCriAudioIDConst!SoundAircraftDispatchSceneChangeGameGlobalEventDispatcher	DispatchGameEventTypeGuideOpenUIUIDispatchMapAttachEventUpdateDispatchTaskSiteInfo
RefreshUI_topBarLoaderGetUIComponentUISelectObjectPathTopBarLoadertopButtonWidgetSpawnObjectUICommonTopButtonSetData_dispatchCountLabelUILocalizationTextDispatchCount_dispatchRevocerTimeLabelDispatchRecoverTime_dispatchTeamCountLabelDispatchTeamCount_timeRemaindLabelTimeRemaind_tipsGoGetGameObjectTips_closeTipsBtnCloseTipsBtn	_tipsBtnTipsBtn_maskMask_dispatchTaskItemList_maxPointCount	tostringUIDispatchTaskIcon_isShowTips RefreshTipsPanel                        @ $@ & �    OnBack                              self                @ $@ & �    OnHelp                              self     "            @ $@ & �    OnHome           !   !   !   "          selfd                                                                                                            "      $   $   $   $   $   %   %   %   %   %   &   &   &   &   &   '   '   '   '   '   (   (   (   (   )   )   )   )   *   *   *   *   +   +   +   +   ,   ,   -   -   -   -   .   .   .   .   .   .   0   0   0   1   1   1   1   1   -   3   4   4   5   5   6      self    d   	uiParams    d   (for index)N   ^   (for limit)N   ^   (for step)N   ^   iO   ]   taskPointLoaderU   ]   	taskIconX   ]      _ENV 8   >       G @ b   ��F@@ G�� d�� L�� � @ d@�
 A�L@A ƀA ���B d@ & � 	   _timerGameGlobalTimerCancelEvent DetachEventGameEventTypeUpdateDispatchTaskSiteInfo
RefreshUI            9   9   9   :   :   :   :   :   :   ;   =   =   =   =   =   >      self          _ENV @   m    
K   G @ L@� d� 
@ �� @ ��@�� � @ � �� AA @� �� �B]��
A�AB @��� ǁB]��
A�@ �B$�  C��GAC ��C ��C� �� J��@	�! ����@D� �GAC J�D���GAC ��D �E�� �AE�E �E@ $ ��  J��GF b  ��FAF G��d�� L���F dA�
 G�FAF G��d�� LA��� �G Hl  d��
@�LAH dA & � "   
_roomDataGetDispatchCount_currentDispatchCountGetRoomConfigGetDispatchTeamCount_dispatchCountLabeltext/DispatchMax_dispatchTeamCountLabelTeamMaxGetSurplusSecond��������_dispatchRevocerTimeLabelStringTableGet(str_dispatch_room_dispatch_stop_recover        	00:00:00HelperProxyGetInstanceFormatTimemathfloor_timerGameGlobalTimerCancelEvent AddEventTimesd       TimerTriggerCount	InfiniteRefreshTask         X   i     0      F @ L@� d� �� @���� � A�@ ��     �_�� @���A � @ � �� _� ���@B �   ����� ��B��� � CAB �@�@Ä� �   ��C�@ @�� � �@D�� ��D�� E@� $ ��     �@E �  �& �    
_roomDataGetSurplusSecond��������StringTableGet(str_dispatch_room_dispatch_stop_recover        _currentDispatchCountGetDispatchCount_timerGameGlobalTimerCancelEvent 	00:00:00ReqDataAndRefreshRoomMsgHelperProxyGetInstanceFormatTimemathfloor_dispatchRevocerTimeLabeltext          0   Y   Z   Z   Z   [   [   \   \   \   \   \   \   ]   ]   ]   ]   ]   ]   ]   ]   ^   ^   ^   _   _   _   _   _   _   `   b   d   d   d   d   f   f   f   f   f   f   f   f   f   f   h   h   i      _text   0   time   0      self_ENVK   A   A   A   B   C   C   C   D   D   D   E   E   E   E   E   E   F   F   F   F   F   F   G   G   G   H   H   I   I   I   I   I   I   I   J   J   K   K   L   L   L   N   N   N   N   N   N   N   N   N   N   N   P   P   P   Q   Q   Q   Q   Q   Q   R   U   U   U   U   V   W   W   i   U   j   l   l   m      self    K   dispatchCount   K   roomCfg   K   dispatchTeamCount
   K   time   K      _ENV o   q       F @ G@� d�� L�� ��@    d@ & �    GameGlobalTaskManager
StartTask	_ReqData            p   p   p   p   p   p   p   q      self          _ENV s   �    0   G @ L@� ǀ@ d@�G�@ L@� ǀ@ d@�G A L@� ǀ@ d@�G@A L@� ǀ@ � �d@�G�A b   ��F�A G � d�� L@� ǀA d@�
�B�G�@ b    �G�B �@C �C �C$ ��  J� �F�A G � d�� L � �@ �D �Dl  d��
@ �& �    _tipsGo
SetActive_isShowTips_mask_closeTipsBtn	_tipsBtn_remaindTimeTimerGameGlobalTimerCancelEvent _timeRemaindLabeltextGetRemaindTimeStr
_roomDataGetDispatchRecoverTotalTimeAddEventTimesd       TimerTriggerCount	Infinite         �   �     	    @ E   L�� ��@ � ��  d�  
@��& �    _timeRemaindLabeltextGetRemaindTimeStr
_roomDataGetDispatchRecoverTotalTime        	   �   �   �   �   �   �   �   �   �          self0   t   t   t   t   u   u   u   u   v   v   v   v   w   w   w   w   w   x   x   x   y   y   y   y   y   y   z   |   |   |   }   }   }   }   }   }   }               �   �   �   �      �   �      self    0      _ENV �   �    I   ! � @�A   �@@ ��@��  �  �   � A �@AҀ� �� πAN�� � A �@��� � ��N �  �  �� �AA ����FA GA���� d� ���N�� ��  �� ��A  �����  � � �� �! �   �A�   � � �B @� �A  A � �  � � ���FB@ G���B � d��� ��FB@ G���� � e�f  & �            StringTableGet'str_dispatch_room_has_recover_completemathfloor�Q           
       0<              :str_dispatch_room_day)str_dispatch_room_task_remaind_time_tips         I   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   	   self    I   seconds    I   day   I   hour   I   hourStr   I   min   I   minStr!   I   
secondStr'   I   timeStr9   I      _ENV �   �       � @ A  �@���@ ��@ � ���� A� �   � ��@A �@ ��ƀA ����@ B�AB� $  �@  ̀B AA  �@�& �    Lock UIDispatchMapController_ReqData_aircraftModuleAircraftUpdateGetSucc
RefreshUIToastManager
ShowToastGetErrorMsg
GetResultUnLock            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       TT       ack         _ENV �   �    
   A   �@@ �   h��G�@ G�L��d� L��  dA�g��A   �@@ �   h@�G�@ G��A�@@  �A g �& �           _maxPointCount_dispatchTaskItemListGetGameObject
SetActiveRefresh           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
   self       (for index)      (for limit)      (for step)      i      (for index)      (for limit)      (for step)      i      dispatchTaskIconItem           �   �       D   �   �   @ ��@@ ǀ�䀀 ���@� �@�& �           GameGlobalTaskManager
StartTask         �   �       E   � �  @   �& � F@� �   G�� ��� ��@� A�@��  ����    l  �@ @��   ��A�   � ��   �@ & �    _maxPointCount_dispatchTaskItemList
_siteInfostateDispatchTaskStateTypeDTST_Complete_GetReward                 �   �            @ 	    � E  $@ & �                         �   �   �   �   �   �   �          indextaskTT   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      TT       dispatchTaskIconItem         indexself_ENVtask   �   �   �   �   �   �   �   �   �   �   �      self       task      index         _ENV �   �       L @ d@ F@@ G�� d�� L�� � A �@�d@�G�A b@  @�F@@ G�� d�� L�� � A ���B AB$ d@  & � 
   CloseDialogGameGlobalEventDispatcher	DispatchGameEventTypeAircraftRefreshMainUIenterFromEasyAircraftShowRoomUI
_roomDataSpaceId            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �   �       & �                �      self       TT            �   �       F @ G@� d�� L�� ��@ � �d@�F @ G@� d�� L�� ��A � �A d@ & � 
   GameGlobalEventDispatcher	DispatchGameEventTypeAircraftLeaveAircraftLoadingManagerStartLoadingLoadingHandlerNameAircraft_ExitUI            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �   �       L @ �@  �  d@ & �    ShowDialogUIHelpControllerUIDispatchMapController           �   �   �   �   �      self            �   �    	   �   �@@ � �  � ��A@ �A́@� @�� ���@� �  �@��   �  & �           _dispatchTaskItemListGetStarCountGetTaskBtn           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       
taskLevel       (for index)      (for limit)      (for step)      i      taskUI           �   �       
@@�L�@ d@ & �    _isShowTipsRefreshTipsPanel           �   �   �   �      self            �         
@@�L�@ d@ & �    _isShowTips RefreshTipsPanel           �              self                    
@@�L�@ d@ & �    _isShowTips RefreshTipsPanel                      self                 	'   L @ �@  �  d� � @ A  A�  �� � @ AA  � � @ �A  �A $� G�AG�������A ��@ ����G�A��A��A ��@ ���AG�A�B ���� BB���J����� � & �    GetUIComponentRectTransformInfo_GuideDispatchCountPanelDispatchRecoverTimePanelDispatchTeamPanel
sizeDeltaxVector2ygameObject         '   	  	  	  	                                                                           self    '   leftBottomRect   '   countPanelRect   '   recoverTimePanelRect   '   teamPanelRect   '   	maxWidth   '      _ENV@                                 6      8   >   8   @   m   @   o   q   o   s   �   s   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �                        _ENV