LuaS �

xV           (w@N@../PublishResources/lua/product/util/optimize/performance_listener_svc_r.lua         O    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��  
�A�
@B�
�B�
@C�F�C �� �   d@�F@@ ��  J� �F@@ �  J���F@@ �@ J� �F@@ �� J���F@@ �� J� �F@@ �  J���F@@ �@ J� �F@@ �� J���F@@ �� J� �F@@ �  J���F@@ �@ J� �F@@ �� J���F@@ �� J� �F@@ �  J���F@@ �@ J� �F@@ �� J���F@@ �� J� �F@@ �  J���& � "   _class!PerformanceListenerServiceRenderBaseServiceConstructorDispose
SetCameraOnlySceneTheme       SceneAndMonster       SceneAndTexture       SceneAndStatsData       _enumScenePerfTestTypeOnBeginTestSceneOnStopTestSceneAddLogAddStatsDataLog	WriteLogWriteStatsDataLog_OnlySceneAddTextureLogWriteTextureLogTexturePixelPercentageData_SceneAndMonster_TestScene_SceneAndTexture_SceneAndStatsDataSwitchSceneUISwitchSceneWriteMonsterStatDataUIPerfMonsterStat        	       B   
@ ���@ ��@@ A$ ��  
����@A ��A�� �@ �@@ � BAB �B@  ��B �@��@@ � BAB C@  �AC �@��@@ � BAB �C@  ��C �@��@@ � BAB D@  �AD �@��@@ � BAB �D@  ��D �@��@@ � BAB E@  �AE �@���E ��@@ GA@ �� 
� �� @ �@F� ���
� �& �    _world_autoBinderAutoEventBinderNewEventDispatcherLognotice'PerformanceListenerServiceRender start
BindEventGameEventTypeBeginTestScenceOnBeginTestSceneStopTestScenceOnStopTestSceneUpdateTestScenceFPSAddLogSwitchSceneUISwitchScenePerfMonsterStatUIPerfMonsterStatSwitchMonsterUISwitchMonster_fightResultEventListenerFightResultEventListenerRender_cameraSvcGetServiceCamera         B                                                                                                                                                                                                            self    B   world    B      _ENV            G @ L@� d@ & �    _autoBinderUnBindAllEvents                           self            "   '    
   � @ �@@�� ̀@@� �@���@ � ��@ & �    _configServiceGetLevelConfigDataParseCameraParam_cameraSvc_InitSceneCamera        
   $   $   $   %   %   %   &   &   &   '      self    
   themeID    
   levelConfigData   
        1   4    
   
@@���@ ��@��� � AAA @  �� �@�& �    
_stopFlag GameGlobalTaskManagerCoreGameStartTask_TestScene         
   2   3   3   3   3   3   3   3   3   4      self    
   	testType    
      _ENV 6   8       
@@�& �    
_stopFlag           7   8      self            :   W    `     G@ bA  � �K� �A  kA� 
@�D  ��@ ��@ ���� � @��BA�� �ǂA�  @��A��A B� @����BA����ǂA�B  � ���A B� @���  *���  "  ���� B F�A � d� �B ��A  �� C @ �� �����@�b   ��� B F�A � d� �B ��A  �� � @��A����� B F�A � d� �B ��A  �� � ���C �A�@ @ �A�ƁC �  � ���C @� � �A & �    _logs'Scene,ThemeID,FPS,LevelCommits,LevelIDpairsCfg
cfg_levelThemecomment	tostringID,  ,, , tableinsertEDITORAddStatsDataLog         `   ;   <   <   <   =   =   =   =   ?   @   @   @   @   @   @   A   A   A   A   A   A   B   C   C   C   C   C   F   F   F   F   F   F   G   G   G   G   @   @   J   K   K   L   L   L   L   L   L   L   L   L   L   L   L   L   L   L   M   M   N   N   N   N   N   N   N   N   N   N   N   N   N   P   P   P   P   P   P   P   P   P   P   P   S   S   S   S   S   T   T   T   U   U   U   U   W      self    `   
sceneName    `   themeID    `   
fpsNumber    `   levelCommits   `   levelID	   `   (for generator)   '   (for state)   '   (for control)   '   k   %   v   %   s(   `      _ENV X   r    �   �   @ "A  � �� AA  +A� 
 �  F�@ ��@ �A�� d @��B��  �����  @�ǀ���A ����   ���B�� ������B  � ���A ����   i�  ���D  �    ��� �A �A @ $� AB � �B �B �BCAC ��B ��B�CC�C �B �B�CAD ��B ��B	��C	�D �B �B
D
] �"   ��� �A �A @ $� AB � �B �B �BCAC ��B ��B�CC�C �B �B�CAD ��B ��B	��C	�D �B �B
D
]@��� �A �A @ $� AB ��B ��B�C�B �B �BCCAC ��B ��B��C�C �B �B�CAD ��B ��B	�D	]���D ��D�@  ��A�& �    _statsDataLogsHScene,ThemeID,LevelID,DrawCalls,Batches,SetPassCalls,Triangles,VerticespairsCfg
cfg_levelThemecomment	tostringID,UnityEditorUnityStats
drawCallsbatchessetPassCalls
triangles	vertices, , tableinsert         �   Y   Z   Z   Z   [   [   [   [   ]   ^   ^   ^   ^   ^   ^   _   _   _   _   _   _   `   a   a   a   a   a   d   d   d   d   d   d   e   e   e   e   ^   ^   h   i   i   j   j   j   j   j   j   j   j   j   j   j   j   j   j   j   j   j   j   j   j   j   j   j   j   j   j   j   j   j   k   k   l   l   l   l   l   l   l   l   l   l   l   l   l   l   l   l   l   l   l   l   l   l   l   l   l   l   l   l   l   n   n   n   n   n   n   n   n   n   n   n   n   n   n   n   n   n   n   n   n   n   n   n   n   n   n   q   q   q   q   q   r      self    �   
sceneName    �   themeID    �   levelCommits   �   levelID	   �   (for generator)   '   (for state)   '   (for control)   '   k   %   v   %   s(   �      _ENV t   ~    &   F @ G@� ��  ]�� ��@ � A� � �@ � � �@ �A �AA $� AA �@ƀB ���  A 䀀AC G�C $@�L��� dB�L��� dB�)�  ����B AD@�$A & �    EngineGameHelperStoragePathPerformanceLog/AppMakeDirCoreGameScenePerformanceLogosdate%y%m%d%H%M%S.csvioopenwipairs_logswrite
close         &   u   u   u   u   v   v   v   v   w   w   w   w   w   w   w   w   x   x   x   x   x   y   y   y   y   z   z   z   {   {   {   y   y   }   }   }   }   ~   	   self    &   dir   &   	filePath   &   file   &   (for generator)   !   (for state)   !   (for control)   !   i      log         _ENV �   �    &   F @ G@� ��  ]�� ��@ � A� � �@ � � �@ �A �AA $� AA �@ƀB ���  A 䀀AC G�C $@�L��� dB�L��� dB�)�  ����B AD@�$A & �    EngineGameHelperStoragePathPerformanceLog/AppMakeDirCoreGameSceneStatsDataLogosdate%y%m%d%H%M%S.csvioopenwipairs_statsDataLogswrite
close         &   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   	   self    &   dir   &   	filePath   &   file   &   (for generator)   !   (for state)   !   (for control)   !   i      log         _ENV �   �    (   � @ �@@ ǀ�� � �   ���@ �A  ���ABA �� ǂA �$��"  @��A B$�� BB��B ��BǂA �$B�C @� �B $B�� ��C �CA $B ��  *��@D �@ & �    pairsCfg
cfg_theme
_stopFlagIDSwitchSceneSceneResPathGameGlobalEventDispatcher	DispatchGameEventTypeUpdateTestScenceInfoYIELDp      Logfatal	WriteLog         (   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    (   TT    (   (for generator)   %   (for state)   %   (for control)   %   k   #   v   #   themeID
   #      _ENV �   �       � @ @�@ ��   
� �� @ �@�@� �� @ � A�  +A� � � ��@ � �@ A @ �@�& �    _textureLogs P图片纹理,使用占比,图片尺寸,材质,使用该图占比最大的物体tableappendArray            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       scene       log          _ENV �   �    .   F @ G@� ��  ]�� ��@ � A� � �@ �@A ǀA � ���� � @�� �BB ǂ�� �  ��BC �C@��� $��FD � d@��CD ��C��CD� �C�i�  ���FBC G��� dB ��  *��& �    EngineGameHelperStoragePathPerformanceLog/AppMakeDirpairs_textureLogsSceneTextureLog__osdate%y%m%d%H%M%S.csvioopenwipairswrite
close         .   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    .   dir   .   (for generator)   -   (for state)   -   (for control)   -   
sceneName   +   v   +   	filePath   +   file   +   (for generator)   '   (for state)   '   (for control)   '   i   %   log   %      _ENV �   �    '   � @ �@�� �@ �@A $� "A   �FAA �� �� dA�F�@ G��� d�  �"  @�L�A�B BB �B� d�  ��� �� ��A� � @��� ���́C @ � �A & �    SceneStatsNewGameObjectHelperFind
SceneRootYIELD�      GetComponentsInChildrentypeofUnityEngineMeshRendererLength        )OnGetTexturePixelPercentageDataCoroutineAddTextureLog         '   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    '   TT    '   scene    '   sceneStats   '   goScene   '   meshRenderers   &   log"   &      _ENV �      .�   � @ �@@�  �����@ � �� @ A@�A $��G@ LA��� d����A �B �A��� � �)�ǂB �B  @)���B  K  ��A �B ���� �  &��DC	��	@%��  �C �C
$� D
ED
�� ǅD$E �@ �D
$� LE
��B	dE�LE�dE L�E
d� ��E
�� �F
AF ��
� @ F@�� $��L��d� �G �@��� �FG   � ���$� L��d� ���� �H�@	 䈀�H�	�$��"	  @
�G��NI��	��IF�II �	 A�	 �

 � JI @
���	 �
 $� �	�JJ�JF�J G
��
 �JJdJ�F�J G
��
��
 dJ�@
 �JI ��H�	 GI�� J���J�	��JI �J K AK �� J��� �K	   �F�A �	�d	@ ��
��J i�  ���K	  @��� �  j��D  @	�ƆC �F�䆀 ̆�F�L G���D���F��FM ǆ����N GN� �  � ����  $G��N ��$G�O @� �G $G�    �A @�$@ �LLdH )�  ���@ ���  *���  *����O �A & � ?   _worldGetServiceMonsterShowRender_configServiceGetMonsterConfigData	ResourceLogicEntitypairsCfg
cfg_theme
_stopFlagID
cfg_levelThemeGameGlobalGetInstance
gameLogic
LoadSceneSceneResPathGetLevelConfigDataParseLevelConfigGenerateBoardDataGetPlayerBornPosGetPlayerBornRotation%GetLevelWaveBeginRefreshMonsterParam       CreateMonsterPosGetMonsterRefreshPosTypeGetMonsterRefreshPosipairsGetMonsterIDGetPositionGetForwardGetMonsterResPathLoadGameObjectxyVector3��������        ��������Obj
transformtableinsertforward	positionlocalScaleDisposeEventDispatcher	DispatchGameEventTypeUpdateTestScenceInfoUnityEngineGameObjectFindGameResourceConstEffRuchangActorpoint
SetActive
SetCameraYIELD�      	WriteLog         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                               	  	  	  
  
  
  
                        �   �   �   �         5   self    �   TT    �   sMonsterShowRender   �   monsterConfigData   �   resourceSvc   �   
entitySvc   �   (for generator)   �   (for state)   �   (for control)   �   k   �   v   �   themeID   �   res   �   resQ   �   (for generator)    �   (for state)    �   (for control)    �   _!   �   	levelCfg!   �   bNext%   �   levelConfigData0   �   teamPos7   �   teamRotation9   �   monsterRefreshParam=   �   createMonsterPosServiceA   �   monsterRefreshPosTypeC   �   monsterArrayG   �   (for generator)J   �   (for state)J   �   (for control)J   �   _K   �   monsterK   �   
monsterIDM   �   monsterPositionO   �   dirQ   �   resPathT   �   requestW   �   xOffset[   �   zOffset]   �   realPosh   �   
transformj   �   tfu   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   req�   �   goEffRuchangActorpoint�   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   req�   �      _ENV   &   )   � @ �@�䀀 ̀�F�@ G��� �@ �@� � � �̀A @� �@���� � � �� B @� �@��@� � � �̀B @� �@���� � � �� C @� �@�� @ �@�䀀 ̀�F�@ G��  �@ & �    GameGlobalEventDispatcher	DispatchGameEventTypeTestSceneCloseButtonOnlySceneTheme_OnlySceneSceneAndMonster_SceneAndMonsterSceneAndTexture_SceneAndTextureSceneAndStatsData_SceneAndStatsData          )                                                          "  "  "  #  #  #  %  %  %  %  %  %  %  %  &     self    )   TT    )   	testType    )      _ENVScenePerfTestType (  D   F   � @ �@   ��@@ ��@��  �@ & � �  �@A �A �A$� �  ��B "B  ��`��� ���L�B �� �@ d��b  @�F@ b  ��FBC �� �� dB�L�C �� �dB FD GB�d�� L����D ���@ dB�FBC �� �B dB�FB@ G���� ��dB� �FB@ G��� ��dB��  jA��@F �@ ̀F �@ & �    EDITORLog
exception只能在编辑器下使用        pairsCfg
cfg_theme
_stopFlag       IDSwitchSceneSceneResPathYIELD�      TexturePixelPercentageDataGameGlobalEventDispatcher	DispatchGameEventTypeUpdateTestScenceInfo�      fatal场景结束 ：场景加载失败 ：	WriteLogWriteTextureLog         F   )  )  )  *  *  *  *  +  -  .  .  .  .  .  .  /  /  /  2  2  5  6  6  6  6  6  6  6  7  7  7  8  8  8  8  9  9  9  9  ;  ;  ;  ;  ;  ;  ;  ;  ;  <  <  <  <  =  =  =  =  =  =  ?  ?  ?  ?  ?  .  .  B  B  C  C  D  	   self    F   TT    F   count	   F   (for generator)   A   (for state)   A   (for control)   A   k   ?   v   ?   themeID   ?      _ENV F  R   #   � @ �@@ ǀ�� � �  ����@ �A  ���ABA �� ǂA �$��"   ��A B$�� BB��B ��BǂA �$B�C @� �B $B���  *A���C �@ & �    pairsCfg
cfg_theme
_stopFlagIDSwitchSceneSceneResPathGameGlobalEventDispatcher	DispatchGameEventTypeUpdateTestScenceInfoYIELD�      WriteStatsDataLog         #   G  G  G  G  G  G  H  H  H  K  L  L  L  L  L  L  L  M  M  M  M  M  M  M  M  M  N  N  N  N  G  G  Q  Q  R     self    #   TT    #   (for generator)       (for state)       (for control)       k      v      themeID
         _ENV T  t   X   @ A@$� �@�@�� � $� "  @�GA LA�� dA�F�A �� �� dA�GA L�d� �AB ��B��   �A��C �AC��C� �� ��C_ ���J�ĈJ�ĉ�E B �A ƁE ����A� �E B �A ƁE ����A� �E B �A ƁE ����A� ƁA  � A� �A���� �A @� �� $B�C BCBFF�F G��$� "  � �LG�  dB�LBG ��dB�C� f FAB G���� � dA�C  f & �    GameGlobalGetInstance
gameLogic
LoadScene_worldSetSceneGOYIELDd       MainCameraLogfatalLoadScene:UnityEngineGameObjectFindGameObjectsWithTagLength       camera 	_requestcollectgarbagecollectAppClearMemoryCameraFindGameResourceConstEffRuchangActorpoint
SetActive
SetCamera场景加载失败 :         X   U  U  U  U  U  U  U  U  V  V  W  W  W  W  X  X  X  X  Y  Y  Y  Z  Z  Z  Z  Z  [  [  [  [  [  \  \  \  ]  ^  _  _  _  `  `  `  a  a  a  b  b  b  c  c  c  d  d  d  e  e  e  e  h  h  i  i  i  i  k  k  k  k  k  k  l  l  m  m  m  o  o  o  p  p  r  r  r  r  r  s  s  t  	   self    X   TT    X   
sceneName    X   themeID    X   	newScene   X   camera_cmpt   P   tt   P   main_camera<   P   goEffRuchangActorpointF   P      _ENV v  �      � @ �@�䀀 ̀�l  �@�& �    GameGlobalTaskManagerCoreGameStartTask         w  �      C   � @ �@@ ǀ�� � �   ���@�  � ��A BA�  ��  �$B�C � @ ���  *�b@  @��  �@A   E� ���@�& �    pairsCfg
cfg_themeSceneResPathIDSwitchScene             x  y  y  y  y  y  y  z  z  z  z  {  |  |  |  |  |  |  }  }  y  y  �  �  �  �  �  �  �  �  �     TT       bFind      (for generator)      (for state)      (for control)      k      v      cfgThemeID         _ENV
sceneNameselfthemeID   w  w  w  w  �  w  �     self       
sceneName       themeID          _ENV �  �   D   F @ G@� ��  ]�� ��@ � A� � �@ � � �@ �A �AA $� AA �@ƀB ���  A 䀀AC G�C $@�L��� dB�L��� dB�)�  ����B AD@�$A  � A� ��A ��A� �� �A ���B �B@ � $���  AC G�D $@�L��� dB�L��� dB�)�  ����B AD@�$A & �    EngineGameHelperStoragePathPerformanceLog/AppMakeDirCoreGameMonsterStatsDataLogosdate%y%m%d%H%M%S.csvioopenwipairs_monsterStatLogwrite
closeCoreGameMonsterBonesLog_monsterBonesLog         D   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    D   dir   D   	filePath   D   file   D   (for generator)   !   (for state)   !   (for control)   !   i      log      (for generator)6   ?   (for state)6   ?   (for control)6   ?   i7   =   log7   =      _ENV �     >   K � �@  k@� 
@ �K � ��  k@� 
@ �K �� A �@ A AA �� � A A A� �A � A AA �� �A $� FA �A � B d� �A �A B AB �� �A B A� �B � A AB �� �B $� FA �B � C d k@  �   �@ �C �C$� FD GA�d�� L���  dA�& �    _monsterStatLogRPrefabName,MonsterID,DrawCalls,Batches,SetPassCalls,Triangles,Vertices,BonesCount_monsterBonesLog)PrefabName,MonsterID,SkinName,BonesCountVector3        -       Z       �       �       �             ;             _worldMainCameraGameGlobalTaskManagerCoreGameStartTask         �     3A  F @ G@� G�� � @ �@@��@�� @ � A�@A�� �� �   @ AAAA� $� "  ��LB�  dA�FAB G����� dA�F@ G�GA��� d�  ���F�� JAC�LB�  dA�F�C G��d�� L��AD ǁ�� C� dA�F�D �  � dA�FAE G��G���AE ��E�F�AE ǁ��A�BE �E�FFBE G��G���G �BG��  �A� � �  �AD � ��  ��B���H �I �B��� � @1�ƃI�C   1���IJ DJF�J ��d� ��
 � $� GDK_���-���K �L	�� �DL	 �����  �+�ǄL	�"E   &���	M
�EM �@ ǅ�� $�  L�M
d� � �EN  �
� ���L�Md� �� ��������G   ��G �O�G �I�G�� �� �J @�$� A� ����� �J \	�$� �	�GB Ǉ��O@ �G������  j��  ����FB �B@��FK$F������	FFP � � � d� 
F���	FFP � �  d� 
F���D @  $F � D  ��H � � ����	ʇ����D    �G �GE Ǉ���� ����GE Ǉ����GE Ǉ�����G�HE �EF�FHE G��GH�Nȁ�HE ��E��F��HE ǈ�����H�` ���` N@�` �� �` N@ �  �� �	G IGAI $I  	 A� ��J �	��� ��  
�A� �
 ��  �A� � ��  �A� � ]���  *��FB ��BƆQ ��F��D @  $E �Q A $E ER �R
$E� @ �R
S
@�	$E �D @  �E $E���  *����� ��S�� ��S�B �B� �B��BN ���� ��BC� �C���  *����C ��C��� �DCD �DC  �  �B�"  � ��B� �B��@ �B@�B �& � P   UnityEngineRenderSettingsskybox GameObjectFind
SceneRootEffect
SetActivetableinsert_postProcessingCmptenabled GameGlobalEventDispatcher	DispatchGameEventTypeTestSceneCloseButtonYIELDX      UnityEditorUnityStats
drawCallsbatchessetPassCalls
triangles	verticesLogfatalSourceDrawCalls：SourceBatches：SourceSetPassCall：SourceTriangles：SourceVertices：pairsCfgcfg_monster_class
_stopFlagResPathstringsub	tostring       ��������IDempty.prefabUnityResourceServiceGetInstanceLoadGameObjectObj
transformGetComponentsInChildrentypeofSkinnedMeshRendererToTable        ipairsbonesname
exceptionmeshRender.sharedMesh is nil ,_monsterBonesLog	positionVector3��������localEulerAngles�       _monsterStatLogcollectgarbagecollectAppClearMemoryObjectDestroyd       WriteMonsterStatData          A  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                                      �  �      	  	  	  
  
  
                                                        1   TT    A  sourceSkyBox   A  
sceneRoot   A  effectList   A  effect   A  sourceDrawCalls7   A  sourceBatches:   A  sourceSetPassCall=   A  sourceTriangles@   A  sourceVerticesC   A  (for generator)U     (for state)U     (for control)U     kV     vV     resNameZ     prefabNameb     classIDc     requestk     gon     skinnedMeshRenderArrayx   
  meshRenderersz   
  BonesCount{   
  (for generator)~   �   (for state)~   �   (for control)~   �   i   �   meshRender   �   bonesArray�   �   bones�   �   	bonesLog�   �   curPrefabNameDic�   
  dc�   
  log�   
  (for generator)�     (for state)�     (for control)�     _�     eulerAngles�     curDC�     curBT�     curSetPassCalls�     curTri�     curVer�     (for generator))  /  (for state))  /  (for control))  /  i*  -  effect*  -     _ENVmainCameraCmptselfprefabNameDiceulerAnglesList>   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �    �       self    >   eulerAnglesList2   >   prefabNameDic3   >   count4   >   mainCameraCmpt7   >      _ENVO                     	      	             "   '   "   )   *   +   ,   -   /   /   /   /   1   4   1   6   8   6   :   W   :   X   r   X   t   ~   t   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �     &    (  D  (  F  R  F  T  t  T  v  �  v  �  �  �  �    �       ScenePerfTestType   O      _ENV