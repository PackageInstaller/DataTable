LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/homeland/ui/wishing/collect/ui_build_collect_coin_item.lua         +    @ A@  ��@ $@�@@  ��@@ l   
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
@ �& �    _classUIBuildCollectCoinItemUICustomWidgetConstructorOnShowRefreshGetCoinDataSetSelectStatusBtnOnClickCollectCoroCollectCoroCheckStoryOnHomeLandEventChangedClearWishingPlotAttachModelReleaseAttachedModel                  K   
@ �L@@ d@ & �    _wishingPlotClearWishingPlot                             self            
       !   �@@ �  A�  �� 
� ��@@ A A� �� 
� �� B A ���
���� B � ���
� �� B A ���
� ��@@ �  A� �� 
� �� D AD �DG�D �@ & �    _nameLabelGetUIComponentUILocalizationTextName_iconLoaderRawImageLoaderIcon
_selectGoGetGameObjectSelect_canCollectGoCanCollect_canCollectLableCanCollectLable_canCollectTextCanCollectTextAttachEventGameEventTypeHomeLandEventChangeOnHomeLandEventChanged         !                                                                                                         self    !   	uiParams    !      _ENV    &    A   
� �
@��ǀ@ ���G@ L�d �@  �@A ���F�A G��� d �@  �@B ̀�G@ L��d �@  � @ � �� �    ��@C ̀�C  �@���C ̀�C  �@�@��@C ̀�FD GA��@ ��D� d  �@  ��C ̀�FD GA��@ ��D� d  �@  ��D ̀�GA@ L�d� �@ _��  �CA  C� �@�& �    
_coinData_collectCoin_nameLabelSetTextGetName_canCollectTextStringTableGetstr_homeland_throw_coin_iconLoader
LoadImageGetIconHasCollect_canCollectGo
SetActive_canCollectLableHomelandWishingConstCanCollectCoin
GetCoinId
_selectGoGetCurrentSelectCoinData         A                                                                                                                 "   "   "   "   "   "   "   "   "   #   #   #   #   #   #   #   #   #   %   %   %   %   %   %   %   %   %   %   %   &      self    A   collectCoin    A   	coinData    A      _ENV (   *       G @ f  & �    
_coinData           )   )   *      self            ,   .       � @ �@@ � �@�& �    
_selectGo
SetActive           -   -   -   -   .      self       	selected            0   6       G @ L@� d� b@  ��F�@ G�� � @ � A�  d�  b   ��F@A G�� d�� L�� � B    d@ & � G@B L�� �   d@�& �    
_coinDataHasCollectHomelandWishingConstCanCollectCoin
GetCoinIdGameGlobalTaskManager
StartTaskCollectCoro_collectCoinSelectItem            1   1   1   1   1   1   1   1   1   1   1   1   1   2   2   2   2   2   2   2   3   5   5   5   5   6      self          _ENV 8   z    �   � @ ������@ � A�@A ǀ��@ ��A  �@��@B ��B��B �� � C@� �AC ��C� �  �C � $A��$� "   �AD �D�  $A�AB �D$�� E�AE ��E�  � $A�AB �EF�B $� LFd� �A��� ��F�� ��FA �A��AG GBC L��d� �BC ��G� �  BG �BC �H�� �BC �B�� $�  F�H �� �� dB��  � �L�dB �  F�H �� �B	 dB�"  � �LIdB   l  ��I ��I�� �J� �   �C�$� F�J G��d�� !@@��$� K  �C � D �����K ��K	�� ���D�	J��	�D�D�	����DǄ�	�Ą������L  @��D  �C�^�� �$C� ^���AM $A �M �MA �A�� $A  & � :   _wishingPlot
recvEventAudioHelperControllerPlayUISoundAutoReleaseCriAudioIDConstHomelandAudioThrowCoinLock#UIBuildCollectCoinItem_CollectCoroGameGlobal
GetModuleHomelandModuleApplyCollectItem
_coinData
GetCoinIdUnLockGetSucc_collectCoin
SetStatusEventDispatcher	DispatchGameEventTypeShowHideHomelandMainUIGetUIModule
GetClientCharacterManagerMainCharacterControllerSetAnimatorTriggerthrow_coinsAttachModelGetEffect1GetEffect1AttachPathGetEffect2GetEffect2AttachPathYIELD�      Dispose@      _collectCoinGetCollectCoinRewardsGetCurrentTaskGetWishingCoinCountHomelandWishingConstGetCollectCoinCountsGetRewards       
RoleAssetNewassetidcount       ShowDialogUIHomeShowAwardsClearWishingPlotLogerror投放许愿币错误
GetResult         Z   c     '    @ @@ $�� �@ ��@ � A� � � $@� @ @@ $�� �@ ��@ �@Aƀ� ����  $@   � @B � � $@� � �B � � $@� � �B $@  �  C $@  � @C �  � �$@ & �    GameGlobalEventDispatcher	DispatchGameEventTypeShowHideHomelandMainUIWishingAddCollectCoin
_coinData
GetCoinId_collectCoinSelectItem
SetStatusRefershData
RefreshUICollectCoroCheckStory          '   [   [   [   [   [   [   [   [   [   \   \   \   \   \   \   \   \   \   \   ]   ]   ]   ]   ^   ^   ^   ^   _   _   _   `   `   `   b   b   b   b   b   c          _ENVselfTThomelandModule p   r           $@� & �        	       q   q   r          func�   :   :   <   <   <   <   <   =   =   =   ?   ?   ?   ?   A   A   A   A   A   A   B   B   B   C   C   C   C   D   D   D   D   E   E   E   E   E   E   E   E   E   G   G   G   G   I   I   K   K   K   K   L   L   L   M   M   M   M   M   M   M   M   N   N   N   N   N   N   N   N   O   O   O   O   P   P   Q   Q   R   T   T   T   T   U   U   V   V   W   c   e   e   e   f   f   g   g   g   g   g   g   g   g   g   h   h   i   j   j   j   j   k   k   k   l   l   l   m   m   m   n   n   n   j   p   p   p   r   p   r   t   t   u   u   w   w   x   x   x   x   x   x   z      self    �   TT    �   homelandModule   �   ret   �   homeLandModule,   �   homelandClient.   �   characterController2   �   effect1=   �   effect2E   �   funcX   �   collectRewards[   �   currentTask]   �   currentRewardsh      rewardsi      (for index)l   z   (for limit)l   z   (for step)l   z   im   y   
roleAssetp   y      _ENV |   �       �   @ A@"  ��F�@ G���  d� �@ �Aǀ��   @�G@ G��AA́A� ,  lB  ��A �B�BB ǂ�,�  �B����L�B dA & �    _wishingPlot
playStoryCfgcfg_homeland_eventeventID	uiModule
GetClientCutsceneManagerExcuteCutsceneInUIStateTypeUIHomeStoryControllerClearWishingPlot         �   �     
#      E   L � d� �@� �� ƀ�   � ����$� F� GB�@@ �  �@ ��  jA�ƀ� ���䀀 � �FA� G���@�ƀ� ���䀀 � �AA �  �@ & �    BuildManagerGetBuildingspairsGetBuildTypeArchitectureSubTypeWishing_PoolGameGlobalEventDispatcher	DispatchGameEventTypeShowInteractUIUIStateManagerShowDialogUIBuildCollectCoin         #   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      wishBuilding   #   buildManager   #   
buildings   #   (for generator)	      (for state)	      (for control)	      k
      v
         homelandClient_ENV �   �            @ $� L@@ � � d@�& �    HomeEventManagerSetFinishStoryEvent          �   �   �   �   �   �   �      homelandEventMgr         homelandClientfnFinishEvent �   �     
    @ @@ $�� �@ ��@ � A� �  $@�& �    GameGlobalUIStateManagerSwitchStateUIStateTypeUIHomeStoryController     	    
   �   �   �   �   �   �   �   �   �   �          _ENVeventIDfnStoryEnd   }   ~   ~         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       TT       homelandModule       cfg      
playStory      
cfgEvents	      eventID      homelandModule      homelandClient      fnFinishEvent      fnStoryEnd         _ENV �   �       � @ �@��   ��_�@@�� @ ����� @ �@A�� @ ʀ �& �    _wishingPlot
recvEvent         
playStoryeventID           �   �   �   �   �   �   �   �   �   �   �   �   �      self       erase_event_id       trigger_immediately_event            �   �       G @ J���G @ J���G @ J@A�& �    _wishingPlot
recvEvent 
playStoryeventID                   �   �   �   �   �   �   �      self            �   �    6   � @ �@�� ̀�@� ��@ �A� �   � �A�"A  ���A �AA �� ]��$A   & A�LAB�� dA�F�B G���C d� �A��� ́C� ��$� LD� d���BD̂D@��  �B �E C AC �C � ����E ������  & �    ResourceManagerGetInstanceSyncLoadAsset	LoadTypeGameObjectObjLogerror加载资源失败:
SetActiveGameGlobalGetUIModuleHomelandModule
GetClientCharacterManagerGetCharacterTransformFind
transform
SetParentlocalPositionVector3        localRotationQuaternion	identity         6   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    6   res    6   
transPath    6   attachedModel   6   go   6   homeLandModule   6   homelandClient   6   characterManager!   6   playerTran#   6   parent&   6   modelTrans'   6      _ENV �   �       & �                �      self           +                              
      
      &      (   *   (   ,   .   ,   0   6   0   8   z   8   |   �   |   �   �   �   �   �   �   �   �   �   �   �   �   �          _ENV