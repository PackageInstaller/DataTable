LuaS �

xV           (w@e@../PublishResources/lua/product/components/ui/activity/n32/main/ui_activity_n32_main_controller.lua         F    @ A@  ��@ $@�@@  ��@@ l   
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
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��& �    _classUIActivityN32MainControllerUIActivityMainBaseLoadDataOnEnterOnInit	PlayAnim	OnUpdateRefreshActivityRemainTime
OnRefreshGetCampaignTypeGetComponentIdsGetLoginComponentIdGetCustomTimeStrGetButtonStatusConfigLineOnClickHardOnClickShopOnClickMultilineOnClickEventOnClickLoginOnClickSetPanelStatus
OnReleaseClose_CheckGuide               	   @ A@@  �� �  �$A�& �    UIActivityMainBaseLoadDataOnEnter                                       self       TT       res       	uiParams          _ENV 	       )   �@@ �@ ���
� �� A A A� �� 
���� A A A �� 
���� A � A� �� 
���� A A A� �� 
� �� � 
������ 
�����D �@ �@D �    �� E � l  �@ @ ��@E �@ & �    _missionModule
GetModuleMissionModule_shopCountLabelGetUIComponentUILocalizationText
ShopCount_timeLabelTime_anim
AnimationAnimrt	RawImageEffimgRT       showAni       RefreshActivityRemainTime	PlayAnim_CheckGuide                        @ $@ & �    _CheckGuide                              self)                                                                                                                                 self    )   	uiParams    )      _ENV    <       �   b    �A@ �  �  $A � �A@ �A  �  $A & �    UIActivityN32MainController_in
StartTask         "   -       F @ b   @�F@@ b   ��E   L�� � � d@�F@@ � @ J���F A L@� �� d@�F�A�   �  d@�E   L@� � � d@�E �b   @ �E �d@� & � 
   imgRTrtLocktexture_animPlayUIActivityN32MainController_inYIELD+      UnLock             #   #   #   #   #   #   $   $   $   $   %   %   %   &   &   &   &   '   '   '   '   (   (   (   (   *   *   *   +   +   -      TT          selfkey_ENV	callback 2   8       F @ L@� ��  d@�E   L�� � � d@�E  b   @ �E  d@� & �    _animPlay UIActivityN32MainController_outUnLock           3   3   3   3   4   4   4   4   5   5   5   6   6   8      TT          selfkey	callback              !   -   /   !   /   1   8   :   1   <      self       isIn       	callback       key         _ENV >   @       � @ �@ & �    RefreshActivityRemainTime           ?   ?   @      self       deltaTimeMS            B   Y    
D   G @ b@    �& � G @ L@� d� b@    �& � G @ L�� d� b   ��G�@ L � �@A ǀ�� �  d@  & � G @ L � d� �@B ��B�� ��B� C �@��� � !��  ��� �C D@��A �� � A $� G@ LA�ƁE ���d���F �AF��� �A� bA    �A� �AA ��A��  �����@ ��@ �A�& �    _activityConstGetInitStateIsActivityEnd_timeLabelSetTextStringTableGetstr_n32_activity_endGetActiveEndTime_timeModuleGetServerTime�      mathfloor        UIActivityCustomHelperGetTimeStringstr_n32_daystr_n32_hourstr_n32_minusstr_n32_less_one_minusGetComponentStatusECampaignN32ComponentID ECAMPAIGN_N32_DIFFICULT_MISSIONActivityComponentStatusClose'str_n32_activity_getreward_remain_timestr_n32_activity_remain_time         D   C   C   C   D   F   F   F   F   F   G   I   I   I   I   I   J   J   J   J   J   J   J   K   N   N   N   O   O   O   O   P   P   P   P   Q   Q   R   U   U   U   U   U   U   U   U   V   V   V   V   V   V   V   V   V   V   V   V   V   W   W   W   W   W   X   X   X   X   Y      self    D   endTime   D   nowTime   D   seconds"   D   timeStr-   D   str:   D   	timeTips?   D      _ENV [   f       D � � @ �@�F�@ G������  @ �� � ��   ��  �A G�A L���B �A�� @ �� � ��dA  & �    _activityConstGetComponentECampaignN32ComponentIDECAMPAIGN_N32_LOTTERYGetLotteryCostItemIconText��     _shopCountLabelSetTextUIActivityCustomHelperGetItemCountStr       #533d2f#f2f0e9            ]   `   `   `   `   `   `   `   a   a   b   b   c   e   e   e   e   e   e   e   e   e   e   f      self       com      comInfo      icon
      count
         _ENV g   i       F @ G@� f  & �    ECampaignTypeCAMPAIGN_TYPE_N32            h   h   h   i      self          _ENV k   t    !   K   � � � @�@@ ǀ�J� � � � @�@@ ���J� � � � @�@@ � �J� � � � @�@@ �@�J� � � � @�@@ ǀ�J� � � � @�@@ ���J� f  & �           ECampaignN32ComponentIDECAMPAIGN_N32_CUMULATIVE_LOGINECAMPAIGN_N32_POWER2ITEM ECAMPAIGN_N32_DIFFICULT_MISSION&ECAMPAIGN_N32_BLACK_DIFFICULT_MISSIONECAMPAIGN_N32_LOTTERY ECAMPAIGN_N32_MULTILINE_MISSION         !   l   m   m   m   m   m   n   n   n   n   n   o   o   o   o   o   p   p   p   p   p   q   q   q   q   q   r   r   r   r   r   s   t      self    !   componentIds   !      _ENV v   x       F @ G@� f  & �    ECampaignN32ComponentIDECAMPAIGN_N32_CUMULATIVE_LOGIN            w   w   w   x      self          _ENV z   |       A   �@  ��  �  f �& �    str_n32_daystr_n32_hourstr_n32_minusstr_n32_less_one_minus           {   {   {   {   {   |      self            ~   �    ;   K   �   �@@���@ � ��� ������   �����@B���B��@C�� � ̀�J���   ��C��@ D� �ʀ��,A  � ���@D�ʀD���D�� �CJ�   
E�F�@ GA�
A�
���l�  
A��
AB�
�B�
AC�\� M��J �K  J�E���@ ��EJ��J�����  J���JAD�J�D�J�D��� ��CJ@f  & �    NameShopComponentIdECampaignN32ComponentIDECAMPAIGN_N32_LOTTERYCheckRedComponentIds 	CallbackRemainTimeStr"str_n32_activity_shop_remain_timeUnlockTimeStrstr_n32_shop_close_time_tipsUnlockMissionStr#str_n32_activity_shop_mission_lock       Hard ECAMPAIGN_N32_DIFFICULT_MISSION"str_n32_activity_hard_remain_time+str_n32_activity_hard_level_lock_time_tips.str_n32_activity_hard_level_lock_mission_tipsLoginECAMPAIGN_N32_CUMULATIVE_LOGIN
Multiline ECAMPAIGN_N32_MULTILINE_MISSION         �   �            @ �@� ��@$@�& �    SwitchStateUIStateTypeUIN32ShopController             �   �   �   �   �   �          self_ENV �   �            @ �@� ��@$@�& �    SwitchStateUIStateTypeUIActivityN32HardLevelMain             �   �   �   �   �   �          self_ENV �   �            @ $@ & �    LoginOnClick           �   �   �   �          self �   �            @ �@� ��@�   $@ & �    PlayComponentPlotECampaignN32ComponentID ECAMPAIGN_N32_MULTILINE_MISSION          �   �            @ �@� ��@$@�& �    SwitchStateUIStateTypeUIN32MultiLineMain             �   �   �   �   �   �          self_ENV   �   �   �   �   �   �   �          self_ENV;      �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    ;   configs   ;   shop   ;   hard   ;   login   ;   
multiLine,   ;      _ENV �   �       L @ �@  d@�& �    ClickButton
Peridales           �   �   �   �      self            �   �       L @ �@  d@�& �    ClickButtonHard           �   �   �   �      self            �   �       G @ L@� d� b   ��F�@ G�� � A �@A�� �  d@  L�A � B �@�d@�& � L�B �� d@�& �    _activityConstIsActivityEndToastManager
ShowToastStringTableGetstr_activity_finishedSwitchStateUIStateTypeUIMainClickButtonShop            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �   �       L @ �@  d@�& �    ClickButton
Multiline           �   �   �   �      self            �   �       G @ L@� d� b   ��F�@ G�� � A �@A�� �  d@  L�A � B �@�d@�& � F�B G�� d@� & �    _activityConstIsActivityEndToastManager
ShowToastStringTableGetstr_activity_finishedSwitchStateUIStateTypeUIMainUIActivityBattlePassHelperOpenMainController            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �   �    
/   G @ L@� d� b   ��F�@ G�� � A �@A�� �  d@  L�A � B �@�d@�& � G @ L�� ��B �  d�  � C �@�_�� � �� C ǀ��� ��ƀ@ ���A AAA� $ �@  & � ��C A �  �AD � �B $ �@  & �    _activityConstIsActivityEndToastManager
ShowToastStringTableGetstr_activity_finishedSwitchStateUIStateTypeUIMainGetComponentStatusGetLoginComponentIdActivityComponentStatusCloseActivityEndShowDialog$UIActivityTotalLoginAwardControllerGetCampaignType         /   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    /   status   /   time   /      _ENV �          � @ �@�[ �@��    �ǀ@ ���A �@�� �ǀ@ ���AA �@�& �    	_showBtn
SetActive_animPlay!UIActivityN32MainController_show!UIActivityN32MainController_hide           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �         self       TT       isShow                    G @ b   � �G @ L@� d@ 
�@�& �    imgRTRelease                               self            	        � @   l  �@ & �    	PlayAnim         
             @ �@� ��@$@�& �    SwitchStateUIStateTypeUIMain                                self_ENV   
  
    
       self       TT          _ENV      
   F @ G@� d�� L�� ��@ � �A AAd@ & �    GameGlobalEventDispatcher	DispatchGameEventTypeGuideOpenUIUIActivityN32MainController         
                          self    
      _ENVF                              	      	      <      >   @   >   B   Y   B   [   f   [   g   i   g   k   t   k   v   x   v   z   |   z   ~   �   ~   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      �         	    	                 _ENV