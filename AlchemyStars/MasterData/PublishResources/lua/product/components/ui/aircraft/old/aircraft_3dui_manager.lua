LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/aircraft/old/aircraft_3dui_manager.lua         1    @ A@  ��@ $@�@@  ��@@ l   
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
@ �& �    _classAircraft3DUIManagerObjectConstructorDispose
RefreshUILoadUIAsset	GetStateOnEnterRoomOnExitRoom	CreateUIIsShowSetUIActiveGetUIIndexGetUIStateCanConnectToSpaceGetBtnGuide                  F@@ G�� G�� �  d� G@� 
@ �F�A G � �@B d� 
@ �
�B�K   
@ �
�Æ& �    canvasRootUnityEngineGameObjectFindAircraft3DUICanvas
transformaircraftModuleGameGlobal
GetModuleAircraftModulescale���Q��?uiDic_isShow                                                	                  self          _ENV        	   F @ �@@ d @ �����A i�  ���& �    pairsuiDic
OnDestroy         	                                 self    	   (for generator)      (for state)      (for control)      _      ui         _ENV    8       @ A LA@ �� d��"   ���@  @��A ����@  �@���   �A  @��� �A��@ �� & �    uiDicGetUIStateRefresh	CreateUIShow                 !   !   !   "   "   0   0   0   0   0   4   4   4   4   4   5   5   5   5   5   6   6   8      self       spaceId       	roomData       roomGo       ui      state           <   K    C   � � A@ F�@ G��$ ��  � � �@��A� �� �AGBGA�R��A� �BF�B L�d� LA��� �C Dd� �A��A��D�D �A��A��A�����A��A�AE � A� �� � ����A���E� �A��A��@B@ F�@ G�$ ��  ƁF �FGG BGBG�G R��䁀������ ǁ����f & �    GetComponenttypeofUnityEngineBoxCollider
transform	positioncenterforwardsizez       ResourceManagerGetInstanceSyncLoadAssetRoomUIBase.prefab	LoadTypeGameObjectObj
SetParentcanvasRootlocalScaleVector3       
SetActiveRectTransform
sizeDeltaVector2xscaleyeulerAngles         C   >   >   >   >   >   >   ?   ?   ?   ?   ?   ?   ?   ?   ?   ?   ?   A   B   B   B   B   B   B   B   B   C   C   C   C   C   D   D   D   E   E   E   E   E   E   E   E   F   F   F   F   G   G   G   G   G   G   G   H   H   H   H   H   H   H   H   H   I   I   I   J   K      self    C   roomGo    C   box   C   pos   C   size   C   req   C   rect5   C      _ENV M   O       � @ �@ �@@�  �   & �    uiDic	GetState           N   N   N   N   N   O      self       idx            Q   S       � @ �@ �@@�@ & �    uiDic
EnterRoom           R   R   R   R   S      self       spaceID            U   W       � @ �@ �@@�@ & �    uiDic	ExitRoom           V   V   V   V   W      self       spaceID            Z   ]    
   � @ @ 䀀A@ �@��� % &  & �    LoadUIAssetAircraftRoom3DUINew         
   [   [   [   \   \   \   \   \   \   ]      self    
   state    
   roomGo    
   uiReq   
      _ENV _   a       G @ f  & �    _isShow           `   `   a      self            c   f       � @ �@@��@ � �@�
@��& �    canvasRootgameObject
SetActive_isShow           d   d   d   d   d   e   f      self       active            h   o       �   �@@ � �  � ��A@ �A@   �f �@��   �  & �           uiViews           i   i   i   i   i   j   j   j   j   k   i   n   n   o      self       _uiGo       (for index)      (for limit)      (for step)      i   
        r   �      � @ �@@ � ���ƀ@ ����@�� ��@��A ������A BAA �� $A�  & �B �B �� �C AC&  9�C �C&  8��CG@ L��� d����B ��B_��  ��A  �� �   ��AD ǁ�� ���D @� 䁀�  � ��C ��� �1��C �A�� �0��AD �A�� ���A ǁ�� �A @.��AD ���� ��C �A�� @,��AD ǁ��� ��C ���� @*���A �� AB �� ��   �A �  � �'��AD ǁ�� ���D @� 䁀�  � ��C ���� @$��C ǁ�� @#��AD �A��� ��C ��� @!��AD �A��� ��C ǁ�� @��AD ���� ��C ���� @��AD ���� ��C �A�� @��AD ǁ�������� !@�� ��C ��� @��C �A�� @��AD ǁ����́�� �B �J �@	��$� FBK G��_@� �FBK G��@� �FC G�f @�FBK GB�@� �FC G��f @�FBK G��@� �FC G�f @�F�A G��B � dB�D  f @��B �M_ ����B �M_ �� ��B N ���B�$� "  � �C �N& @���$� "  � �C O& @�C L& @�C L& @���A �� AB �� �B   �A �  � & � >   aircraftModuleGetSpaceInfoCfgcfg_aircraft_space
BuildType        Logfatal[aircraft] space idx error: AirRoomType
AisleRoomAirUIStateAisleNotOpenSpaceNotOpenspace_statusGetRoomSpaceStateSpaceStateNeedCleanCanConnectToSpaceAisleUncleanSpaceStateCleaning
exception3[Aircraft] 严重错误，过道状态为清理中SpaceStateEmptyAisleUnbuildSpaceStateFullAisle[aircraft] space state error: Idx:  SpaceState: SpaceUncleanSpaceCleaningSpaceStateBuildingRoomBuildingSpaceUnbuildSpaceStateUpgradingRoomUpgradingSpaceStateDegradingLevelRoomTearingRoomDegradingGetRoomTypePurifyRoomPurifyStatusPurifyRoomStatusEVIL_WITHOUT_PURIFYNO_EVIL	RoomIdle	PURIFINGEvilClearingWAITING_COLLECT_AWARDEvilClearEnd-[aircraft] purify room state error: state-->	MazeRoom
PrismRoom
TowerRoomCanCollectAwardCollectAwardHasNewTaskHaveNewTask	 state:            t   t   t   t   u   u   u   u   u   w   w   {   {   |   |   |   |   |   }   }               �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   	   self      _idx      
spaceData     
buildType	     spaceState!     	roomData%     isAisle+     	roomType�   �   purityState�   �      _ENV �   �       � � �  & �                �   �   �      self       spaceID            �   �       � @ �@ �@@�  �   & �    uiDicGetBtnGuide           �   �   �   �   �   �      self       spaceId           1                                          8      <   K   <   M   O   M   Q   S   Q   U   W   U   Z   ]   Z   _   a   _   c   f   c   h   o   h   r   �   r   �   �   �   �   �   �   �          _ENV