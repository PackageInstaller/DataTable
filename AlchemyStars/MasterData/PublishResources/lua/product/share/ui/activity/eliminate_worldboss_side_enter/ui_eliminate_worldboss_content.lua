LuaS �

xV           (w@u@../PublishResources/lua/product/share/ui/activity/eliminate_worldboss_side_enter/ui_eliminate_worldboss_content.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@���@ l�  
@ ��@ l  
@���@ l@ 
@ �& �    require"ui_side_enter_center_content_base_classUIEliminateWorldBossContentUISideEnterCenterContentBaseDoInitDoShowDoHide
DoDestroyBattleOnClick_Countdown                  L@@ ��  �  d� 
@ �F A G@� G�� G�� �@B ��B��B �� � C � FAC G���� 
� �& �    _countdownGetUIComponentUILocalizationText
CountdownCfgcfg_main_side_enter_btnEliminateWorldBossEndTime	_endTimeGameGlobal
GetModuleLoginModuleGetTimeStampByTimeStrEnum_DateTimeZoneTypeE_ZoneType_GMT                                                                           self       endTime	         _ENV        
   F @ G@� d�� L�� ��@ � �d@�L@A d@ & �    GameGlobalEventDispatcher	DispatchGameEventTypeOnShowEliminateWorldBoss_Countdown         
                                    self    
      _ENV            G @ b   ��F@@ G�� d�� L�� � @ d@�
 A�
 ��& �    _timerGameGlobalTimerCancelEvent 	_timeStr                                                    self          _ENV #   )       G @ b   ��F@@ G�� d�� L�� � @ d@�
 A�
 ��& �    _timerGameGlobalTimerCancelEvent 	_timeStr            $   $   $   %   %   %   %   %   %   &   '   )      self          _ENV +   D    7   F @ G@� ��@ d� ��� A AA����  �   ��ƀA ���B ABA� $ �@  & � � @ ���䀀 � �AA 䀀��$� F@ G��d�� L��A d��
A��LADd� ��D ��D�E�D BE�EF�D GB�G��� ���ƁD ǁ���������G l  �A�& �    GameGlobal
GetModuleRoleModuleCheckModuleUnlockGameModuleIDMD_WorldBossToastManager
ShowToastStringTableGet!str_function_lock_worldboss_tipsUIStateManagerGetControllerUISideEnterCenterControllerGetScreenShotOwnerCameraGetControllerCameraRefreshBlurTextureUnityEngineRenderTextureNewScreenwidthheight       formatRenderTextureFormatRGB111110Float
StartTask         ;   B       F @ �   d@ F@� b   ��F�@ G�� G � �  � �d@�E � L@� �� �d@ & �    YIELDviewUnityEngine	GraphicsBlitShowDialogUIWorldBossController             <   <   <   =   =   =   >   >   >   >   >   >   @   @   @   @   @   B      TT          _ENVselfrt	cache_rt7   ,   ,   ,   ,   -   -   -   -   -   .   .   /   /   /   /   /   /   /   0   4   4   4   4   4   4   5   5   6   6   6   6   6   6   6   7   7   8   8   8   8   8   8   8   8   8   8   8   9   9   9   9   :   B   :   D      self    7   module   7   isLock	   7   controller   7   screenShot   7   rt$   7   	cache_rt/   7      _ENV F   `    9   G @ �@@ ��� N�� ��@ ��@�� � A � ����@A _�� �ǀA ���FB GA��� � d��@  
���!�� ��� C �    ��@C ǀ�䀀 ���GC �@�
 D�
 Ă�@C �@�䀀 ̀�F�D G��@� �� C �@  @��@C ǀ�䀀 �@�A� ��E �F�  䀀
� �& �    	_endTimeGetSvrTimeNowHelperProxyGetInstanceFormatTime_3	_timeStr_countdownSetTextStringTableGet$str_activity_common_remainingtime_3        _timerGameGlobalTimerCancelEvent EventDispatcher	DispatchGameEventTypeOnEliminateWorldBossClosedAddEventTimes�      TimerTriggerCount	Infinite         Z   \            @ $@ & �    _Countdown           [   [   [   \          self9   G   G   G   G   H   H   H   H   H   H   I   I   I   J   J   J   J   J   J   J   J   K   M   M   N   N   N   O   O   O   O   O   O   P   Q   S   S   S   S   S   S   S   T   V   V   V   W   W   W   W   X   Y   Y   \   W   ]   `      self    9   
delatTime   9   str
   9      _ENV                        	   	                               #   )   #   +   D   +   F   `   F   `          _ENV