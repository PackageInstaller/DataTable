LuaS �

xV           (w@k@../PublishResources/lua/product/components/ui/ui_pet_forecast/ui_pet_forecast_new/ui_pet_forecast_new.lua         4    @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@���@ l�  
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ �& �    require"ui_side_enter_center_content_base_classUIPetForecastNewUISideEnterCenterContentBaseDoInitDoShowDoHide
DoDestroyInitUIComponentsLoadTmpMatRequestPredictionFlushFlushLeftTime_SetPieceBtn	ShowTipsCloseItemCountChangedGetRewards                  & �                      self       params            
   (    	:   G@@ 
@ �L�@ � A d��
@ �G @ G@� 
@��L�A d@ L�A � B �@��B d@ L�A � B ���C d@ F�C G�� �@C �   d��
@��
@D�G @ b   ��G @ G��  @����G @ G�� ��D � E� � �� �@E ǀ�  A� �@�� F �@�䀀 ̀�FB G��� �� �@ L@G d@ & �    _forecastData_datamSignIn
GetModuleSignInModulecfgInitUIComponentsAttachEventGameEventTypeShowItemTips	ShowTipsRolePropertyChangedItemCountChangedteUIActivityHelperStartTimerEventcurSelectDay        idUIPetForecastEnterNewGetLocalDBKeyLocalDBSetInt       GameGlobalEventDispatcher	DispatchCampaignComponentStepChange��������Flush                        @ $@ & �    FlushLeftTime                              self:                                                                                       !   !   !   !   !   !   !   "   "   #   #   #   #   $   $   $   $   $   %   %   %   %   %   %   %   %   %   '   '   (      self    :   id%   7   key)   7      _ENV *   5    '   F @ G@� �   ��  d@�L�@ d@ F@A G�� � A d� 
@ �L�A � B �@��B d@ L�A � B ���C d@ F @ G@� ��C d@ F @ G@� ��C d@ F @ G@� � D d@ F @ G@� �@D d@ & �    UIWidgetHelperClearWidgets
_tipsPoolCloseteUIActivityHelperCancelTimerEventDetachEventGameEventTypeShowItemTips	ShowTipsRolePropertyChangedItemCountChangedDisposeLocalizedTMPMaterialmatReq1matReq2matReq3matReq4         '   +   +   +   +   +   ,   ,   .   .   .   .   .   /   /   /   /   /   0   0   0   0   0   1   1   1   1   2   2   2   2   3   3   3   3   4   4   4   4   5      self    '      _ENV 7   8       & �                8      self            ;   X    �   L@@ ��  �  d� 
@ �L@@ �@ � d� 
@ �L@@ �@  d� 
@��L@@ �@ � d� 
@��L@@ �@  d� 
@��L@@ ��  A d� 
@��L@@ �� � d� 
@ �L@@ ��  d� 
@ �L@@ ��  A d� 
@��L@@ �� � d� 
@ �G @ L�� � E �@�d@�G E G�� b   ��F�E G � � E ��Ed� b@   �G�C L@� ƀF ���E �E�  d@  G D L@� ƀF ���E G�  d@  @�G�C G@� L�� �   d@�G D G@� L�� �   d@�G@C L�� � E �@�d@�G A L@� � E ���� �d@�G�A L@� � E ����@�d@�G@B L@� � E ǀ�� �d@�G�B L@� � E ǀ��@�d@�G@D L�� � E ���d@�G�D L@� ƀF ���	 �  d@  L@I d@ & � &   mainBgGetUIComponentRawImageLoadermainbgbeginMonthUILocalizedTMPstartmonth	beginDay	startday	endMonth	endmonthendDayenddayspineintroTitleUILocalizationTextintroContentletfTimeBgtips
LoadImagecfgmainBGforecastTitlestringisnulloremptySetTextStringTableGetforecastContentgameObject
SetActive
beginTime              endTimeleftTimeIconstr_prediction_infoLoadTmpMat         �   <   <   <   <   <   =   =   =   =   =   >   >   >   >   >   ?   ?   ?   ?   ?   @   @   @   @   @   A   A   A   A   A   B   B   B   B   B   C   C   C   C   C   D   D   D   D   D   E   E   E   E   E   G   G   G   G   G   H   H   H   H   H   H   H   H   H   H   H   I   I   I   I   I   I   I   I   J   J   J   J   J   J   J   J   J   L   L   L   L   L   M   M   M   M   M   O   O   O   O   O   Q   Q   Q   Q   Q   Q   R   R   R   R   R   R   S   S   S   S   S   S   T   T   T   T   T   T   U   U   U   U   U   V   V   V   V   V   V   V   W   W   X      self    �      _ENV Z   _       F@@ G�� �   ��   d� 
@ �F@@ G�� �   ��  d� 
@��F@@ G�� �   �   d� 
@��F@@ G�� �   ��  d� 
@��& �    matReq1UIWidgetHelperSetLocalizedTMPMaterialstartmonthPetForecastMat.matmatReq2	startdaymatReq3	endmonthmatReq4endday            [   [   [   [   [   [   [   \   \   \   \   \   \   \   ]   ]   ]   ]   ]   ]   ]   ^   ^   ^   ^   ^   ^   ^   _      self          _ENV a   p       �   �@@ @ �@�ƀ@ ���� ��� $A�AA "A  � ��A �@$� 
 ��AA B�� ��$� 
 ���A 
 ���B $A �B � $A�& �    #UIPetForecastNew_RequestPredictionLockAsyncRequestResNewSetSucc_dataLoaderUIPetForecastDataLoader_data	LoadData_forecastDataFlushUnLock            b   c   c   c   d   d   d   e   e   e   g   g   g   i   i   i   i   k   k   k   k   k   k   l   l   n   n   o   o   o   p      self       TT       	lockName      res         _ENV r   z       � @ �@   ��@@ ��@��  �@ & � � A �@ �@A  � �@�& �    _forecastDataLogwarn### self._forecastData nil.FlushLeftTime_SetPieceBtn            s   s   s   t   t   t   t   u   x   x   y   y   y   z      self       isShow          _ENV |   �    s   A   �@@ ��@��� ��@ � �@ 䀀�   � ��@A G�A �  �@ ��A �   @���A � � � @��@@ �@��A B� A@ �B@�$A! ��@�C BCA� ��C �D� �� ��C �� �� $�  @  @�!@��@�C BCAB ��C �D���� ��C ��  � $�  @  @�!���@�C BCA� ��C �D� � $�  @  @�C BCA� �� �� ��$��@   �� C �@� � @ ��@E ǀ��E �@ � F �@�C ACA� �� $��@  �   @�� @�� �� B ] �G �G@  � �� $A & � !   UICommonHelperGetNowTimestampHelperProxyIsCrossDayTo
StartTaskRequestPrediction_forecastDataendTimeCalcLeftSecondsS2DHMS       StringTableGetstr_prediction_left_time_d_hmathfloorstr_prediction_left_time_h_mstr_prediction_left_time_m<str_prediction_error_code_1UIActivityHelperCancelTimerEventtecfg	leftTime str_prediction_left_remain_time<color=>	</color>UIWidgetHelperSetLocalizationTexttxtLeftTime         s   }   ~   ~   ~                     �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   	   self    s   text   s   nowTimestamp   s   leftSeconds   R   d   R   h   R   m   R   s   R   color^   s      _ENV �   �    6   G @ L@� d� ��@ ��@� @ � ��� �@A A� �� �  B  �ʀ�B C@  �� �A   $��F�C � d ��@ �A���C�D�DCDL���  �@ �@ ��D	_ 	  ��D  �� �@ ��	��	��	,  dC ^ �^��i�  ��& �    _forecastDataIsAllAcceptedtablecountpiecesGetUIComponentHorizontalLayoutGroupRewards       spacing�       UIWidgetHelperSpawnObjectsUIPetForecastAwardItemNewipairsawards              FlushcurDaystate         �   �    "   F @ G@� � � G�� b   @�F @ G@� � � G�� G�� ��@� A��  �E   L@� � �d@� �F�AG�� d�� L � �@Bǀ� E�L��d� G�GA�d@�& �    _forecastDatapiecesstatePredictionStatusPRES_UnAcceptGetRewardsGameGlobalEventDispatcher	DispatchGameEventTypeShowItemTipsTrans
transform	position      	    "   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      TT    "      selfi_ENVlentplIdv6   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    6   isAllAccepted   6   len   6   horizonLayout   6   
pieceList   6   (for generator)   5   (for state)   5   (for control)   5   i   3   v   3   
awardInfo   2   tplId    2   count!   2      _ENV �   �       � @ �@�   A�  �� � �@�& �    UIWidgetHelperSetAwardItemTips
_tipsPool            �   �   �   �   �   �   �   �      self       matid       pos          _ENV �   �       & �                �      self            �   �       L @ �@@    d@ & �    
StartTaskRequestPrediction           �   �   �   �   �      self            �   	      � @ ,  @  �@ & �    
StartTask         �      �   A   �   �   �@�@� �@��     A�  �� ��  h�F�@ G�G�GB���A��A�� �FB LB��    F�@ G��d���� CCC � �ƂC���DCDA� $ �B  � � �
���D����$� C� 䂀�  ����@ �B�@ ��A��E�B ��@ ���@ 䂀�  ���"  ��CFG�$@�"  ��F�FL��d� ��@J����GJ�����G�H	�  ��D�)�  ���gA�FAH�  �� dA�"  @�F�GGA�� d�  @����FIGA�d�� L����	   l  dA�FIGA�d�� L���	 d��bA  � �FAH�  dA ��F�@ LA�d� � �FIG��d�� L���K�A�� D� dA E  L���� dA��   ��FIG��d�� L���K��dA��   ��FIGA�d�� L���	 d��b  � �FAH�  dA ��E  LA�d� & � 2   UIPetForecastBtn:_Start_ReqLock       _forecastDatapiecesstatePredictionStatusPRES_UnAcceptmSignInPredictionAwardReqid
GetResultPrediction_Result_CodePREDICTION_SWITCHToastManager
ShowToastStringTableGet'str_prediction_error_activity_finishedPetForecastData
CheckCodeUpdateStatePRES_Accepted	GetPieceawardsipairs
RoleAssetNewassetidcount       tableinsertYIELD               GameGlobalUIStateManagerShowDialogUIGetItemControllerIsShowIsAllAcceptedEventDispatcher	DispatchGameEventTypeCampaignComponentStepChange��������UnLockPredictionDataChangedRootUIOwner          �   �            @ $@ & �    Flush            �   �   �   �          self�   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                          TT    �   	lockName   �   toNewUnlockLastState   �   toClose   �   t   �   (for index)   V   (for limit)   V   (for step)   V   i   U   res   U   replyEvent   U   piece<   U   (for generator)D   U   (for state)D   U   (for control)D   U   iE   S   awardE   S   aJ   S   uiPetForecast�   �      selflen_ENV   �       �   	     self       len          _ENV4                                       
   (   
   *   5   *   7   8   7   ;   X   ;   Z   _   Z   a   p   a   r   z   r   |   �   |   �   �   �   �   �   �   �   �   �   �   �   �   �   	  �   	         _ENV