LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/aircraft/old/ui_aircraft_room_base.lua         a    @ A@  ��@ $@�@@  ��@@ l   
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
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �& � !   _classUIAircraftRoomBaseObjectConstructorGetNavLayerBySpaceID_Init_InitPositions_InitAreaAndPointsGetAvailableAreaAndPointsOccupyRestPointReleaseRestPointGetAreaAndRestPointCountGetAreaIndexRefreshPetsDispose
CreatePetUpdateGetGroundPosCheckGroundGetFadeObjectsGetRoomGameObjectGetRoomLogicDataLogicRoomTypeStatusSpaceIDTryClickPet
TryGetPetSetColliderEnableSetVisibleOnEnterOnFocusOnExitCreateRoom           B    ;   
@ �
���
�@��   
� �� @ ̀�F�A �B �ABd �  
�����B � �ǀ��@�
� ��   
� ��   
����   
� �
�Ĉ
 ŉˀ ��E��@F��@F��@ƍ�@F��@ǋ�@ǌ�@ǎ�@G��@Ǐ��E���Ő��E���ő� G�� ǒ� G�� Ǔ� G���Ɣ��F���ƕ��F���Ɩ��F�ʀƗʀF�ʀƘ
���̀L �@ & � 3   _roomGO_roomLogicData_groundTrans 	_petList	colliderGetComponenttypeofUnityEngineBoxCollider	petScaleCfgcfg_aircraft_cameraValue_interactiveAreaList_restPointList_restPointOccupiedDic_areaAndRestPointCount        	_visible_spaceID2NavLayer                                                        	       
                                                                                                                                     _Init         ;      	                                                                           "   #   $   %   &   '   (   )   *   +   ,   -   .   /   0   1   2   3   4   5   6   7   8   9   :   ;   <   =   >   ?   A   A   B      self    ;   roomGameObject    ;   roomLogicData    ;      _ENV D   F       � @ �@ �  & �    _spaceID2NavLayer           E   E   E   F      self       spaceID            H   �    �   G @ L@� d� �   b     ���� �@ �� A �@�� �@ & � ��A � �  AA 䀀�!�B �A AAA� $A & �   A ��� h��F�A G����B d������_�@����C ǂ��� �D � _�  �g���@ �FA GA��A dA & � FA G���� � dA�FAE L��d� L���  ��BF �Fd� 
@�GE G����� �A��A���G�G BGC  �A �A��AH � A� �� � �����H �A �A���H	 ����AI́IA�	 䁀��@�A JAB
 ���$B�& � K �@ �BK� $�  ���� GBGG��N�� (��CG�K��$��CIG�� $C�'���$B � GBGG��N�� (��CG�K��$��CIG�  $C�'��@ BL$� F�L G��@��M �@ �BM�� ƂM ����  ��B  �� $B�& � N $B & � 9   _roomLogicData
GetConfigPrefab Logfatal%### aircraft -- modle param is nil !stringsplit|        '### aircraft -- modle param is error !       ,       	tonumberSpaceID$### aircraft -- modle name is nil !notice加载房间模型--_roomModleRequestResourceManagerGetInstanceSyncLoadAsset.prefab	LoadTypeGameObjectObj
SetActive
transform
SetParent_roomGOlocalPositionVector3_InitPositionsFindNavMeshRootgameObjectGetComponentNavMeshSurface
exception.找不到导航组件，房间prefab名称：namedefaultAreaGetNavLayerBySpaceIDSpaceIdchildCount	GetChildBuildNavMeshGetRoomTypeAirRoomType
AisleRoomSetColliderEnableGetSpaceStatusSpaceStateSpaceStateFullRefreshPets         �   K   K   K   L   M   M   N   P   P   Q   Q   Q   Q   R   T   T   T   T   T   U   U   U   V   V   V   V   W   Y   [   [   [   [   \   \   \   \   \   ]   ^   ^   ^   ^   ^   ^   ^   ^   ^   ^   [   c   c   d   d   d   d   e   h   h   h   h   h   i   i   i   i   i   i   i   i   i   i   i   k   k   l   l   l   m   m   m   m   m   m   n   n   n   n   n   n   n   q   q   t   t   t   t   t   v   v   v   x   x   y   y   y   y   y   z   }   }   }   }   }   }                     �   �   �   �   �   �   �   �      �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    �   cfg   �   modleParam   �   modleNameArr   �   
modleName   �   (for index)   1   (for limit)   1   (for step)   1   i    0   PerfabAndSpace%   0   moduleJ   �   navmeshObja   �   moduleNavMeshd   �   (for index)w   �   (for limit)w   �   (for step)w   �   ix   �   (for index)�   �   (for limit)�   �   (for step)�   �   i�   �      _ENV �   �    )   G @ G@� ���  ����@A� ���
� ���@ �A��� B �@B�� @ �B�@�& � �@�  ����   
� ��   ���@ �CAA �@��C �@�BC$���C�� �� D G�@ �@�& �    _roomGO
transform_groundTrans	GetChild        FindposRoot/Ground Log
exception1找不到房间内Ground，房间模型名称：namefadeObjects       childCountgameObject_InitAreaAndPoints         )   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    )   
rootTrans   )   fadeObjectsParent   )   (for index)   %   (for limit)   %   (for step)   %   i   $      _ENV �   �    N   b@    �& � � � A  ����    �ǀ@�  N�� (��BA��$��F�A L���Bd���BB �BB �����B�'���B � 
 �� � A� 䀀�   �
���A�  �A� hA�LB�� d�����BC ǂ���CA 䂀  A ��� h� �FDD ��d� 
Cg��F�D L���   @ d����D � �A��@ �C���D �Cg�G�B M�
@�& �    FindInteractiveAreachildCount               	GetChildUIAircraftInteractiveAreaNewgameObject_interactiveAreaList_areaAndRestPointCountRestPoints	positionstringsplitname|	tonumberUIAircraftInteractivePoint_restPointList	SetIndex         N   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    N   groundTrans    N   interactiveAreaRoot   N   
areaCount	      (for index)      (for limit)      (for step)      i      
areaTrans      interactiveArea      restPointRoot    N   pointCount#   M   (for index)&   J   (for limit)&   J   (for step)&   J   i'   I   point*   I   	pointPos+   I   faceIDStrList1   I   faceIDList2   I   (for index)5   ;   (for limit)5   ;   (for step)5   ;   i6   :   pointA   I   indexD   I      _ENV �   �    
$   K   �   �   A@  A  � ��A@ ǁ���$� "B  � �� @J��@��   �@  A  � ���@ ǁ�A �"B  � � @���@�� �   � �& �           _interactiveAreaListIsFull_restPointList_restPointOccupiedDic        $   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    $   	areaList   $   
pointList   $   (for index)      (for limit)      (for step)      i      area	      (for index)       (for limit)       (for step)       i      point           �   �       � @ �@� & �    _restPointOccupiedDic           �   �   �      self       pointIndex            �   �       � @ �@� & �    _restPointOccupiedDic            �   �   �      self       pointIndex            �   �       G @ f  & �    _areaAndRestPointCount           �   �   �      self            �   �       � @ �@@ǀ@  � � ��   & �    tableikey_interactiveAreaList            �   �   �   �   �   �   �      self       area          _ENV �      L   G @ L@� d� �   ��  � A�  � �ǁ� ���� A �@A@ ��� � ��@��   �A GA $��C  ��  �� �  ����C� ��@�� ��@ �C�   ����bB   ���A �B�� ��B�)�  �A��A @ $��LBB � d���A �B���B �  � �����B ���B )�  �A��  \���  (��GA G�LB�dB GA JBA'��& �    _roomLogicDataGetPets       GetTemplateID	_petList pairstableinsert
CreatePet	_visible
StartNaviForceInitAnimatorDispose         L   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                 �   �           	  	  	  
  
                                                 self    L   petData   L   addList   L   (for index)      (for limit)      (for step)      i      id      removeList   L   (for generator)   -   (for state)   -   (for control)   -   id   +   pet   +   contain   +   (for index)   $   (for limit)   $   (for step)   $   i   #   (for generator)0   ?   (for state)0   ?   (for control)0   ?   id1   =   data1   =   _pet4   =   (for index)B   K   (for limit)B   K   (for step)B   K   iC   J   keyD   J      _ENV         F @ �@@ d @ �����A i�  ���G�@ b   @�F A G@� d�� L�� ��@ d@�& �    pairs	_petListDispose_awardTimerGameGlobalTimerCancelEvent                                                   self       (for generator)      (for state)      (for control)      _      pet         _ENV "  3   =   � � A@ �@�����@ � �� �@�@ �  �� G��L���B   dA LA��� dA�G����B �  A �� �AC ��J��G��L���� d��� �A��� �A���� ������D ��CEA� 䂀�  � ��ECB�  $C����F �AF  @��� �  � �  & �    GetPetPrefabPetSkinEffectPathMODEL_AIRCRAFTHelperProxyGetInstanceLoadPet
transform
SetParent_groundTrans
SetActivelocalScaleVector3       	petScaleFindRoot        childCount	GetChildstringfindnameweapongameObjectUIAircraft3DPetNew         =   #  #  #  #  $  $  $  $  $  $  $  %  %  %  %  %  &  &  &  '  '  '  '  '  '  '  '  '  )  )  )  )  +  +  +  +  +  ,  ,  ,  -  -  -  -  -  .  .  /  /  /  /  +  2  2  2  2  2  2  2  2  3     self    =   _data    =   petPrefabResName   =   go   =   reqs   =   root    =   (for index)$   4   (for limit)$   4   (for step)$   4   i%   3   child(   3   	contains-   3      _ENV 5  =   
   � @ �@    �& � �@@ ǀ@ � � ���@@� �A���  *��& �    	_visiblepairs	_petListUpdate            6  6  6  7  :  :  :  :  ;  ;  ;  :  :  =     self       deltaTimeMS       (for generator)      (for state)      (for control)      k      v         _ENV ?  A      G @ G@� f  & �    _groundTrans	position           @  @  @  A     self            D  F      � @ _@   ��@  � � �  & �    _groundTrans           E  E  E  E  E  E  F     self       trans            H  J      G @ f  & �    fadeObjects           I  I  J     self            M  O      G @ f  & �    _roomGO           N  N  O     self            R  T      G @ f  & �    _roomLogicData           S  S  T     self            V  X      G @ L@� e  f   & �    _roomLogicDataGetRoomType           W  W  W  W  X     self            Z  \      G @ L@� e  f   & �    _roomLogicDataStatus           [  [  [  [  \     self            ^  `      G @ L@� e  f   & �    _roomLogicDataSpaceId           _  _  _  _  `     self            d  l   	   � @ �@@ � ��́@� @�� ���@�A �� � ��  *A��   �  & �    pairs	_petListPetGameObjectOnClick            e  e  e  e  f  f  f  f  g  g  h  h  e  e  k  k  l     self       _go       (for generator)      (for state)      (for control)      k      v         _ENV p  w   	   � @ �@@ �  �́@� @�  �� ��  *��   �  & �    pairs	_petListPetGameObject            q  q  q  q  r  r  r  r  s  q  q  v  v  w     self       _go       (for generator)      (for state)      (for control)      k   	   v   	      _ENV y  }      � @ �   @ �� @ �@��& �    	colliderenabled           z  z  z  {  {  }     self       enable              �      
@ �& �    	_visible           �  �     self       visible            �  �      
@@�L�@ �   d@�G�@ b    �G�@ G � L@� �   d@�& �    	_visibleSetColliderEnableceilinggameObject
SetActive           �  �  �  �  �  �  �  �  �  �  �  �  �     self            �  �      & �                �     self            �  �      L @ � � d@�& �    SetColliderEnable           �  �  �  �     self            �  �      � @ �@�@  �� � � ��   & �    UIAircraftRoomBaseNew            �  �  �  �  �  �  �  �     roomGameObject       roomLogicData       doorGO          _ENVa                        B      D   F   D   H   �   H   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �         "  3  "  5  =  5  ?  A  ?  D  F  D  H  J  H  M  O  M  R  T  R  V  X  V  Z  \  Z  ^  `  ^  d  l  d  p  w  p  y  }  y    �    �  �  �  �  �  �  �  �  �  �  �  �  �         _ENV