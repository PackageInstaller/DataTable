LuaS �

xV           (w@E@../PublishResources/lua/product/util/optimize/performance_world.lua         �    @ A@  $@ �  K  ��  � ������� ˀ  �@�@�  
�
�K�  J�J�k@ 
@ �K@  �   J���
@ �K �	��  ��Á� Ăˀ  �@āʀĂ�  
�ā
łK�  JAŁJ�ł��  ��Ł�Ƃˁ  �AƁʁƂ�  
�Ɓ
ǂK�  JBǁJ�ǂ��  �����ǂ˂  �ȁ�BȂ�  
�ȁ
�ȂK�  JɁJCɂ��  ��Ɂ��ɂ˃  �ʁ�Cʂ�  
�ʁ
�ʂK�  JˁJD˂��  ��ˁ��˂˄  �́�D̂�  
�́
�̂K�  J́JE͂��  ��́��͂˅  �΁�E΂k@ 
@ �F�N �� � O d@�F�N @��F�N �   J���F�N �@  J� �F�N ��  J���F�N ��  J� �F�N �  J���F�N �@ J� �F�N �� J���F�N �� J� �F�N �  J���F�N �@ J� �F�N �� J���F�N �� J� �F�N �  J���F�R �@ J���F�R �� J� �F�R �� J���F�R �  J� �F�R �@ J���F�R �� J� �F�R �� J� �F�R �  J���F�R �@ J� �F�R �� J���F�R �� J� �F�R �  J���F�R �@ J� �F�R �� J���F�R �� J� �F�R �  J���F�R �@ J� �& � [   requirebase_worldSystemsNameLoadingTypeLoadingSystemClientTypeClientLoadingSystem_RenderHitbackSystem_RenderGridMoveSystem_Render AnimatorControllerSystem_RenderUniqueComponentsMainCameraComponent	ServicesConfigConfigServiceBoardRenderBoardServiceRenderPiecePieceServiceRenderTransformRendererTransformServiceRendererTimeClientTimeServiceResourcesPoolResourcesPoolService	ResourceUnityResourceServiceRenderEntityRenderEntityServiceLoadingServiceRenderEffectEffectServiceCameraCameraServiceAffixAffixServiceTalentTalentServiceLogicEntityLogicEntityServicePerformanceListener!PerformanceListenerServiceRenderTrapRenderTrapServiceRenderRandomLogicRandomServiceLogicCreateMonsterPosCreateMonsterPosService	UtilDataUtilDataServiceShareBoardLogicBoardServiceLogicMazeMazeServiceBattleDamageStatisticsLogic#BattleDamageStatisticsServiceLogic_classPerformanceWorld
BaseWorldConstructorGetCameraObjSetSceneGOGetSceneGOGetRunningPositionEventDispatcherGetServiceInternal_CreateComponentsInternal_CreateSystemsInternal_CreateServices_CreateCutsceneServiceIDGeneratorUpdateWorldPerformanceWorldGetWorldTimerIsDevelopEnvSetEntityIdByEntityConfigIdSetRenderBoardEntityGetRenderBoardEntityGetBoardEntityGameFSMHasGameFSMAddGameFSMRemoveGameFSMMainCameraHasMainCameraAddMainCameraRemoveMainCamera
MatchTypeSetBoardEntity        =   K    	$   
@@�
�@�� A �@A  ���� A �@�K  䀀  F�A L��� dA�F�A L���dA�FAB L���   dA F�B L���   dA 
 �
���F�C G�
@�
���& �    _id        _checkCrossSide ComponentsLookupNewMatchPackInstallerInstallEntityComponentsLookupInstallUniqueComponentsLookupBasePackInstallerInstallEntityMatchersCombatPackInstallerBWCC_EMatchersBW_UniqueComponentsEnum_matchType
MatchTypeMT_MissionBW_WEComponentsEnum         $   >   ?   @   @   @   @   A   A   A   A   B   C   C   C   C   D   D   D   D   E   E   E   E   E   F   F   F   F   F   G   H   I   I   I   J   K      self    $   
worldInfo    $   wEComponents   $   wUniqueComponents
   $   wEMatchers   $      _ENV M   O       G @ G@� G�� f  & �    _world	_requestObj           N   N   N   N   O      self            P   R       
@ �& �    	_sceneGO           Q   R      self       sceneGO            S   U       G @ f  & �    	_sceneGO           T   T   U      self            W   Y       F @ G@� f  & �    WorldRunPostionPerformance            X   X   X   Y      self          _ENV \   ^       F @ G@� e � f   & �    GameGlobalEventDispatcher            ]   ]   ]   ]   ^      self          _ENV `   d    	   � @ �    �� @ �@@ � � ��   & �    BW_ServicesGetService        	   a   a   a   b   b   b   b   b   d      self    	   service_name    	        f   i    	   F @ G@� �   d@ F @ G�� �   d@ & �    CutsceneWorldAssembler$AssembleCutsceneWorldComponentsBase AssembleCutsceneWorldComponents         	   g   g   g   g   h   h   h   h   i      self    	      _ENV k   w       F@@ L�� d� 
@ �K   �   � � �  GA�\���  (��B��GA�BA �B��@   ����@ ̂�@ �B�'��& �    BW_SystemsSystemsNew       TypeClassesAdd             l   l   l   l   n   o   p   q   q   q   q   q   r   r   s   t   t   t   t   t   u   u   u   u   q   w      self       systemList      systemIndexList      gamemode_config      (for index)      (for limit)      (for step)      i      system_config      system_type      new_system         _ENVPerformanceModeConfig y   �       F@@ L�� d� 
@ �E � ��  � � � ��  ����� �A�AA @ 䁀�   �@ �A��A��$B ���� @ � B�@ & � 	   BW_ServicesServicesProviderNew       	Services_CreateCutsceneServiceAddServiceNameInitServices             z   z   z   z   {   |   |   |   |   |   }   }   ~   ~   ~         �   �   �   �   �   |   �   �   �   �      self       gamemode_config      (for index)	      (for limit)	      (for step)	      i
      service_config      newService         _ENVPerformanceModeConfig �   �    	   � � �@�   F�@ G��@�� ��A �AA��   �A����   ���  & & �    TypeNameClasses Logerror*-----------Services:Error, Add Service = New            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       serviceTypeConfig       service_type      service_name      newService      pClass         _ENV �   �       F @ G@� e � f   & �    GameGlobalGameEventListenerIDGenerator            �   �   �   �   �      self          _ENV �   �       � @ �@@��@�    � �@�& �    PerformanceWorldsuperUpdateWorld            �   �   �   �   �   �   �      self       deltaTimeMS          _ENV �   �       F @ G@� e � f   & �    GameGlobalTimer            �   �   �   �   �      self          _ENV �   �    
   F @ G@� ��@ ��@`��   �C@  C � f  & �    Log	loglevel
ELogLevelNone         
   �   �   �   �   �   �   �   �   �   �      self    
      _ENV �   �       � @ �@�
� �̀� G@ �@���@ � �G@ �� �@ & �    _id       SetID
_entitiesInsert           �   �   �   �   �   �   �   �   �   �   �   �      self       entity       entityConfigId            �   �       
@ �& �    _renderBoardEntity           �   �      self       e            �   �       G @ f  & �    _renderBoardEntity           �   �   �      self            �   �       F @ G@� �   � � d@�& �    WorldAssemblerAssembleWorldComponents             �   �   �   �   �   �      self          _ENVPerformanceModeConfig �   �    	!   F @ b   ��F@@ b   ��F�@ G�� �  �@ d����� ��A � �  AA 䀀_�����B CAA � �� �B �C$� $A    & G D f  & �    EDITORCHECK_RENDER_ACCESS_LOGICdebuggetinfo       S
short_srcstringfind_r.lua Log
exceptionrender file : call GetBoardEntity() 
traceback_boardEntity         !   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    !   
debugInfo      	filePath      renderIndex         _ENV �   �    	$   F @ b   ��F@@ b   ��F�@ G�� �  �@ d����� ��A � �  AA 䀀_�����B CAA � �� �B �C$� $A    & L D �@D ǀ�e �f   & �    EDITORCHECK_RENDER_ACCESS_LOGICdebuggetinfo       S
short_srcstringfind_r.lua Log
exceptionrender file : call GameFSM() 
tracebackGetUniqueComponentBW_UniqueComponentsEnumGameFSM         $   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    $   
debugInfo      	filePath      renderIndex         _ENV �   �    
   L @ �@@ ǀ�d����   �C@  C � f  & �    GetUniqueComponentBW_UniqueComponentsEnumGameFSM         
   �   �   �   �   �   �   �   �   �   �      self    
        �   �       G @ G@� ��@ ��@   ���� A�@ �@A @� � �@ & �    BW_UniqueComponentsEnumGameFSMGameFSMComponentNewInitializeSetUniqueComponent            �   �   �   �   �   �   �   �   �   �   �   �   �      self       index      
component         _ENV �   �    
   L @ d� b    �L@@ ǀ@ ���  d@ & �    HasGameFSMSetUniqueComponentBW_UniqueComponentsEnumGameFSM        
   �   �   �   �   �   �   �   �   �   �      self    
        �   �       L @ �@@ ǀ�e �f   & �    GetUniqueComponentBW_UniqueComponentsEnumMainCamera           �   �   �   �   �   �      self            �   �    
   L @ �@@ ǀ�d����   �C@  C � f  & �    GetUniqueComponentBW_UniqueComponentsEnumMainCamera         
   �   �   �   �   �   �   �   �   �   �      self    
        �   �       G @ G@� ��@ ��@   ���� A�@ �@A @� � �@ & �    BW_UniqueComponentsEnumMainCameraMainCameraComponentNewInitializeSetUniqueComponent            �   �   �   �   �   �   �   �   �   �   �   �   �      self       index      
component         _ENV �   �    
   L @ d� b    �L@@ ǀ@ ���  d@ & �    HasMainCameraSetUniqueComponentBW_UniqueComponentsEnumMainCamera        
   �   �   �   �   �   �   �   �   �   �      self    
        �   �       G @ f  & �    _matchType           �   �   �      self                     
@ �& �    _boardEntity                  self       boardEntity           �            	   
   
                                                                                                               !   !   !   "   "   "   #   #   #   $   $   $   %   %   %   &   &   &   '   '   '   (   (   (   )   )   )   *   *   *   +   +   +   ,   ,   ,   -   -   -   .   .   .   /   /   /   0   0   0   1   1   4   4   9   9   9   9   :   :   =   K   =   M   O   M   P   R   P   S   U   S   W   Y   W   \   ^   \   `   d   `   f   i   f   k   w   k   y   �   y   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                PerformanceModeConfig]   �      _ENV