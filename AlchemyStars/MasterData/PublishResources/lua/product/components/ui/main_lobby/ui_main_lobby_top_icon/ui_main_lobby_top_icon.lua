LuaS �

xV           (w@l@../PublishResources/lua/product/components/ui/main_lobby/ui_main_lobby_top_icon/ui_main_lobby_top_icon.lua         R    @ A@  ��@ $@�@@  ��@@ l   
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
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��& �    _classUIMainLobbyTopIconUICustomWidgetOnShowOnItemCountChangeOnHideSetDataSetPanelShowGetCurrentPhyTimerOnGetCurrentPhyTimerStartPhyTimerStartPhyTimerLoopOnStartPhyTimerLoopPhyPowerTexBtnOnClickShowPhyPointOpenPhyTimerOnOpenPhyTimerClosePhyTimer	ShowTime	Time2StrChangeTimeTableToStrChangeSecondToTimeGoldOnClickPhyPowerOnClickDiamondOnClickDiamondAddOnClickPhyPowerAddOnClickGoldAddOnClick               G   F@@ G�� ��@ d� 
@ �L@A �� d��
@ �L B �@ � d� 
@��L B �@  d� 
@��L B �� � d� 
@��L B �@  d� 
@��L B �@ � d� 
@��L B �@  d� 
@��L B �@ � d� 
@��L�E � F �@��F d@ L�E � F ����F d@ L@A �@ d��
@ �L@A �� d��
@ �L@A �@ d��
@ �L@A �� d��
@ �& � $   _roleModuleGameGlobal
GetModuleRoleModule	_phyTimeGetGameObjectphyTime_diamondTextGetUIComponentUILocalizationTextDiamondText_phyPowerTextPhyPowerText_phyTimeCanvasGroupCanvasGroup
_nextTime	nextTime	_allTimeallTime
_goldText	GoldText_yaojingTextYaojingTextAttachEventGameEventTypeItemCountChangedOnItemCountChangeRolePropertyChanged_goldPanel
GoldPanel_phyPowerPanelPhyPowerPanel_diamondPanelDiamondPanel_yaojingPanelYaojingPanel         G                  	   	   	   	   
   
   
   
   
                                                                                                                                                                                 self    G      _ENV    !       L @ d@ G@@ L�� ��@ � ��  d@  G@A L�� ��@ ̀��  d@  G�@ L�� d� � B ��@AB �B$� �B�� $��@  & �    ShowPhyPoint_diamondTextSetText_roleModuleGetGlow_yaojingTextGetDiamondGetGold
_goldTextHelperProxyGetInstanceFormatGold                                                                                                   !      self       count         _ENV #   1    !   G @ b   ��F@@ G�� d�� L�� � @ d@�
 A�G@A b   ��F@@ G�� d�� L�� �@A d@�
 ��G�A b   ��F@@ G�� d�� L�� ǀA d@�
 A�L�A d@ & �    _startPhyTimerEventGameGlobal
RealTimerCancelEvent _startPhyTimerLoopEvent_showTimeEventClosePhyTimer         !   $   $   $   %   %   %   %   %   %   &   (   (   (   )   )   )   )   )   )   *   ,   ,   ,   -   -   -   -   -   -   .   0   0   1      self    !      _ENV 3   7       
@ ��@@ �@ ��@ �@ & �    _toptipsInfoGetCurrentPhyTimerOnItemCountChange           4   5   5   6   6   7      self       toptipsInfo            9   >       @ A@�� $A��@ A@� $A��@ A@��$A�A A@�  $A�& �    _goldPanel
SetActive_phyPowerPanel_diamondPanel_yaojingPanel           :   :   :   :   ;   ;   ;   ;   <   <   <   <   =   =   =   =   >      self       	goldShow       
powerShow       diamondShow            A   D       L @ �@  d@�F�@ G�� d�� L � �@A    d@ & �    Lock&UIMainLobbyTopIcon:GetCurrentPhyTimerGameGlobalTaskManager
StartTaskOnGetCurrentPhyTimer            B   B   B   C   C   C   C   C   C   C   D      self          _ENV F   c    0   � @ �@@ � A�  ����@ A �A��AA� �A   �ƁA ��� �A & � �ABB�G�B b  ��F�B G�d�� LB�ǂB dB�
�C�G@ L��d� �@ �D�� !@  �& � F�B G�d�� LB�� ,  @�d��
@�& �    _roleModuleGetRecoverData        UnLock&UIMainLobbyTopIcon:GetCurrentPhyTimerGetSuccLogfatal ###OnGetCurrentPhyTimer false !�      _startPhyTimerEventGameGlobal
RealTimerCancelEvent GetHealthPointGetHpLevelMax	AddEvent         ^   `       E   L � �   d@�& �    StartPhyTimer           _   _   _   _   `      gapTimeNum          self0   G   G   G   G   G   H   H   H   J   J   J   J   K   K   K   K   L   O   P   R   R   R   S   S   S   S   S   S   T   W   W   W   W   W   W   W   W   X   \   \   \   \   ]   `   b   \   b   c   	   self    0   TT    0   res   0   
startTime   0   intervalRecoverTime   0   leftRecoverTime   0   allRecoverTime   0   gapTimeNum   0   nextTimeNum   0      _ENV e   t       � @ �   ���@@ ��@��� ��@@ �@�
 A��@A �@ �@@ ��@��� ��A � F�A G��  ���
� �& � 	   _startPhyTimerLoopEventGameGlobal
RealTimerCancelEvent StartPhyTimerLoopAddEventTimesTimerTriggerCount	Infinite         p   r            @ $@ & �    StartPhyTimerLoop           q   q   q   r          self   f   f   f   g   g   g   g   g   g   h   j   j   m   m   m   m   n   o   o   r   m   s   t      self       gapTime          _ENV v   y       L @ �@  d@�F�@ G�� d�� L � �@A    d@ & �    Lock%UIMainLobbyTopIcon:StartPhyTimerLoopGameGlobalTaskManager
StartTaskOnStartPhyTimerLoop            w   w   w   x   x   x   x   x   x   x   y      self          _ENV {   �       � @ �@@ � A�  �� ��@ A �@��@A� �   � �̀A �@ @���A � �A L�Bd �@  & �    _roleModuleGetRecoverData        UnLock%UIMainLobbyTopIcon:StartPhyTimerLoopGetSuccShowPhyPointLogfatal(###GetRecoverData false --> result --> 
GetResult            |   |   |   |   |   }   }   }   ~   ~   ~   ~            �   �   �   �   �   �   �      self       TT       res         _ENV �   �       & � F @ G@� ��  � � �  �@� � d@ G A b@  � �L@A d@ L�A d@ & �    GameGlobalUAReportForceGuideEventUIMainClickClick_PhyPoint_phyPanelIsOpenShowPhyPointOpenPhyTimer            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �   �    	$   G @ L@� d� ��   �A�  � @ � A�� �@  ���  �    @   �� �  @��  �A� �   � �� @� � ]�AB "  ���B �B�� �   �$A�& �    _roleModuleGetHealthPoint         GetHpLevelMax�      999+<color=#00ffea>	</color>view_phyPowerTextSetText/        $   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    $   currentPhyPower   $   currentPhysicalPowerUpper	   $   	moreThan   $        �   �       L @ �@  d@�L�@ ��@    d@ & �    LockGetRecoverData
StartTaskOnOpenPhyTimer           �   �   �   �   �   �   �   �      self            �   �    M   � @ �@@ � A�  ����@ AB  �A��A� �A   ��AA ǁ�� �A & � 
 �
@��
��
 Å�AC �  ��ƁC ���䁀 ��GBC �A�
@ĆƁC ���䁀 ́�A� �  � 
����E �A�C� �A�ǁE ���LF �BB d��A  �AF ���LF ǂB d��A  ǁF �  ��ƁC ���䁀 ��G�F �A�
@D�ƁC ���䁀 ���A �BG ��G��G    � 
��& �     _roleModuleGetRecoverData        UnLockGetSuccLogfatal6### request fail -- self._roleModule:GetRecoverData !_gapTimeNum_nextTimeNum_allTimeNum_phyPanelIsOpen
_phyEventGameGlobal
RealTimerCancelEvent 	AddEvent�      	_phyTime
SetActive
_nextTimeSetText	Time2Str	_allTime_showTimeEventAddEventTimes�      TimerTriggerCount	Infinite	ShowTime         �   �            @ $@ & �    ClosePhyTimer           �   �   �   �          selfM   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    M   TT    M   res   M   
startTime   M   intervalRecoverTime   M   leftRecoverTime   M   allRecoverTime   M      _ENV �   �       G @ L@� �   d@�G�@ b   ��F�@ G � d�� L@� ǀ@ d@�
�A�G�A b   ��F�@ G � d�� L@� ��A d@�
���
@B�& � 
   	_phyTime
SetActive_showTimeEventGameGlobal
RealTimerCancelEvent 
_phyEvent_phyPanelIsOpen             �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �   �    *   G @ N@� 
@ �G�@ N@� 
@ �G @  ��  �G A N@� 
@ �L@A d@ G�@  �� ��
�@�G�A b   ��F�A G � d�� L@� ǀA d@�
�B�& � G�B L � �@C G@ � �d@  G�C L � �@C G�@ � �d@  & �    _nextTimeNum       _allTimeNum        _gapTimeNumOnItemCountChange_showTimeEventGameGlobal
RealTimerCancelEvent 
_nextTimeSetText	Time2Str	_allTime         *   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    *      _ENV �   �    
   �   �@@ @� 䀀�@ ��$���  �  & �    ChangeSecondToTimeChangeTimeTableToStr        
   �   �   �   �   �   �   �   �   �   �      self    
   time    
   str   
   timeTab   
             
!   �  G�  @��@ �� � � �A�  �� ���G��  @��@ ���� � �A�  ��� ݀�G�  @��@ �� � �A�  �� ��@ �A ��B @ ]A�f & �    hour	       0minsec:        !               
  
  
                                                     self    !   
timeTable    !   hourStr   !   minStr   !   secStr   !          0      ��  �@@��@@��@��@�   ��  � A �@��� � A AAN�� R��$� FA GA���Ad� �A �AA�Aҁ��� ����@������  & �    hour        minsecmathmodf<                               "  "  #  &  &  &  &  '  '  '  '  '  (  (  (  (  )  )  )  )  )  +  ,  -  /  0     self       second       
timeTable      sec      minAll      min      hour         _ENV 3  6   
   L @ �@  d����@ ��@A AA@� �@ & �    GetGameObjectGold_toptipsInfoSetDataRoleAssetIDRoleAssetGold         
   4  4  4  5  5  5  5  5  5  6     self    
   gold   
      _ENV 8  ;   
   L @ �@  d����@ ��@A AA@� �@ & �    GetGameObject	PhyPower_toptipsInfoSetDataRoleAssetIDRoleAssetPhyPoint         
   9  9  9  :  :  :  :  :  :  ;     self    
   power   
      _ENV =  K   	!   G @ L@� d�  �� @���@ � A�@ �A �AFB GA���B ��B� �� ƁB ���B � ,  �@� ���C � ���� D �@�F�D G��� �@ & �    _roleModuleGetGlow        PopupManagerAlertUICommonMessageBoxPopupPriorityNormalPopupMsgBoxTypeOkStringTableGetstr_shop_resourceerror_titlestr_shop_resourceerror_descGetGameObjectDiamond_toptipsInfoSetDataRoleAssetIDRoleAssetGlow         D  E      & �                E     param           !   >  >  >  ?  ?  @  @  @  @  @  A  A  B  B  B  B  C  C  C  C  E  @  F  H  H  H  I  I  I  I  I  I  K     self    !   count   !   diamond          _ENV M  P      F @ G@� ��@ d� L�� � A �@�d@�F @ G�� d�� L�� �  A d@ & � 
   GameGlobal
GetModuleRoleModuleOnHomePageEnterCLICKENTRANCECE_ADD_DIAMONDUIStateManagerShowDialogUIShopCurrency1To2                    N  N  N  N  N  N  N  N  O  O  O  O  O  O  O  P     self          _ENV S  V      � @ �@@ƀ@ �� ��@A AA�@���A � �@�& �    GameGlobal
GetModuleRoleModuleOnHomePageEnterCLICKENTRANCECE_ADD_PHYShowDialogUIGetPhyPointController            T  T  T  T  T  T  T  T  U  U  U  V     self       go          _ENV X  [      F @ G@� ��@ d� L�� � A �@�d@�L�A �� B ABd@ & � 
   GameGlobal
GetModuleRoleModuleOnHomePageEnterCLICKENTRANCECE_COINShowDialogUIItemGetPathControllerRoleAssetIDRoleAssetGold            Y  Y  Y  Y  Y  Y  Y  Y  Z  Z  Z  Z  Z  [     self          _ENVR                                 !      #   1   #   3   7   3   9   >   9   A   D   A   F   c   F   e   t   e   v   y   v   {   �   {   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �           0    3  6  3  8  ;  8  =  K  =  M  P  M  S  V  S  X  [  X  [         _ENV