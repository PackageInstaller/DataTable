LuaS �

xV           (w@O@../PublishResources/lua/product/share/season_maze/audio/season_maze_audio.lua         I    @ A@  ��@ $@�@@  ��@@ l   
@�� @ A  ��@ $@� A   � A l@  
@�� A l�  
@�� A l�  
@ � A l  
@�� A l@ 
@ � A l� 
@�� A l� 
@ � A l  
@�� A l@ 
@ � A l� 
@�� A l� 
@ � A l  
@�� A l@ 
@ � A l� 
@�� A l� 
@ � A l  
@�� A l@ 
@ � A l� 
@�� A l� 
@ �& �    _classSeasonMazeAudioPlayerObjectConstructorSeasonMazeAudioDisposeUpdate_PlayEnvSound_PlayRadiuSound_GetPlaneDistance_RequestSound_ReleaseAllSound_ReleaseSoundPlayStepSound
PlaySoundSetLizardVolumePlayLizardAudioPlayEventAudio_PlayVoiceStopSeasonUIVoiceStopSeasonSoundsResumeSeasonSounds
PlayVoice                  
@ �
���
� �
 ��
@�
���
��
 ��_@�@ ��B�  ��  
��
��& �    	playerID	distanceaudioID	positionstartRadiu	endRadiuhighVolume
lowVolumeisAnimationAudio AnimAudioID                    	   
                                       self       	playerID       	distance       audioID       	position       startRadiu       	endRadiu       highVolume       
lowVolume       isAnimationAudio       AnimAudioID               ;    r   F@@ G�� ��@ d� 
@ �G @ L � d� ��A ��A�@  �@ ��� 
�����A ��B�@ 
���� @ � C�� 
����   
����@A �    
���C �@A � ����CD BD�D@�$� "  ��G�DG��BEǂE�EGF�CFǃF�FFG LD��� � @����  �@ ���   d� �H �DH	�DC  ��D���  *����B ��H�� � I�� �@I�� 
� ���I ��I� 
 A
 ���`���  ��@  � � ƀA ǀ����� ��    ��I �IA� �� $���K� "A    �� 
 ��
�G�
�̘
 ͙AM $A �M �MFN GA�GA�$A & � :   _uiSeasonMazeModuleGameGlobalGetUIModuleSeasonMazeModuleGetSeasonID_cfgsCfgcfg_season_map_audio	SeasonID
_voiceCfgcfg_season_map_player_voice_seasonMazeManagerSeasonMazeManager_audioPlayerspairsnameUnityEngineGameObjectFind
transform	positionstartRadius
endRadiushighVolume
lowVolumeisAnimationAudioaudioIDAnimAudioIDSeasonMazeAudioPlayerNew��������        tableinsert_cameraTransformSeasonMazeCameraManagerSeasonCamera
TransformLocalDBGetIntSoundVolumeOnKey       cfg_globalsound_volumeFloatValue_sound_valueSoundVolumeKeyd       _stepTimer_stopAllAudio 
_curVoice _RequestSoundAudioHelperControllerSetInnerGameSoundPlaySpeedBattleConstTimeSpeedList         r                                                                                                    !   "   "   "   "   "   #   #   $   $   %   &   '   (   )   *   +   ,   ,   ,   ,   ,   ,   ,   ,   -   -   -   -   ,   .   .   .   .   .           2   2   2   2   2   2   2   2   3   3   3   3   3   3   3   3   3   4   4   4   4   5   5   5   5   5   5   5   5   5   5   5   5   5   6   7   8   9   9   :   :   :   :   :   :   ;      self    r   	seasonID   r   (for generator)   D   (for state)   D   (for control)   D   _   B   cfg   B   name    B   audioGO%   B   	position)   B   startRadius*   B   
endRadius+   B   highVolume,   B   
lowVolume-   B   isAnimationAudio.   B   audioID/   B   AnimAudioID0   B   audioPlayer=   B   soundOnU   r   soundGlobalY   r      _ENV =   C       L @ d@ G@@ b   ��F�@ G�� d�� L � �@@ d@�
@��& �    _ReleaseAllSound_eventGameGlobalTimerCancelEvent             >   >   ?   ?   ?   @   @   @   @   @   @   A   C      self          _ENV E   G       � @ �@ & �    _PlayEnvSound           F   F   G      self       
deltaTime            I   Q       G @ G@� ��@ ��@ � ���A�A  ��́A GB@�� � ������A @ �A���  *��& �    _cameraTransform	positionipairs_audioPlayersisAnimationAudio	distance_GetPlaneDistance_PlayRadiuSound            J   J   K   K   K   K   L   L   L   M   M   M   M   M   N   N   N   K   K   Q      self       
cameraPos      (for generator)      (for state)      (for control)      k      v         _ENV T   i    	S   � @ �   � ��@  �@    ���@ ��� �   ������ A�  � ��ǀ� �    �ǀ� _��@�� B �@��� G�� �� ��� ���� B� ����� C ACG�� ���$A��
�� C ǀ��� C� 䀀J� ������ A�   � �ǀ� �    �ǀ� _��@�� C �@��� G�� O���@���ǀ� �   ��ǀ� _����� C �@��� FD GA�G���@�� C ����� G�� �@�J�A�& �    _stopAllAudio        _sound_value	distancestartRadiu	endRadiu	playerID��������MathfLerp
lowVolumehighVolumeAudioHelperControllerSetInnerVolumeRuntimePlayInnerGameSfxaudioIDCriAudioManager	InstanceSoundVolumeStopInnerGameSfx         S   U   U   U   U   U   U   U   V   V   V   V   V   V   V   V   W   W   W   W   W   W   X   X   X   X   Y   Y   Y   Y   Y   Y   Y   X   Z   Z   Z   Z   Z   Z   \   \   \   \   \   \   ]   ^   ^   ^   ^   _   _   _   _   _   _   `   `   `   `   `   `   a   c   c   c   c   c   c   d   d   d   d   d   d   d   e   e   e   e   e   g   i      self    S   player    S   globalVolume   S   volume!   &      _ENV k   o    	   J@@��@@�ƀ@ ��� � @ � ��   & �    y        Vector3	Distance         	   l   m   n   n   n   n   n   n   o      self    	   
position1    	   
position2    	      _ENV q   �    /   F @ �@@ d ������   ���@ ���@�_@A� �ƂA ���  �B ��  *��� ���A ��A���A i�  �@�F�A G@� ��B ��Bd@ F�A G@� ��B � Cd@ F�A G@� ��B �@Cd@ F�A G@� ��B ��Cd@ & �    ipairs_audioPlayersisAnimationAudiopairsAnimAudioID��������AudioHelperControllerRequestInnerGameSoundaudioIDRequestUISoundSeasonCriAudioStepDefault
StepMetal
StepStone
StepWater         /   r   r   r   r   s   s   s   t   t   t   t   u   u   v   v   v   v   t   t   x   z   z   z   z   r   r   }   }   }   }   }   ~   ~   ~   ~   ~                  �   �   �   �   �   �      self    /   (for generator)      (for state)      (for control)      k      v      (for generator)
      (for state)
      (for control)
      key      value         _ENV �   �    	!   F @ G@� d@� F�@ ��@ d � ��A  ��A�i�  ��F @ G@� ��A ��Ad@ F @ G@� ��A � Bd@ F @ G@� ��A �@Bd@ F @ G@� ��A ��Bd@ & �    AudioHelperControllerStopAllUIVoiceipairs_audioPlayers_ReleaseSoundReleaseUISoundByIdSeasonCriAudioStepDefault
StepMetal
StepStone
StepWater         !   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    !   (for generator)      (for state)      (for control)      k   
   v   
      _ENV �   �       � � �   ��� � _@@����@ ��@� � A AA�A�@���@ ��A� � � �@��@B ��B� � �@ & �    	playerID��������AudioHelperControllerSetInnerVolumeRuntimeCriAudioManager	InstanceSoundVolumeStopInnerGameSfxaudioIDtableclear            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       player          _ENV �   �    <   � @ �     �& � �@@ ���	���@ � ��� @��@A ǀ��A B�@  ���@ �@��� @��@A ǀ��A �B�@ ����@ ����� @��@A ǀ��A C�@  ���@ �@���  ��@A ǀ��A �C�@ ��C �   @���C � ��@�A@ � 
 ��A@   �  �
���& �    _stopAllAudio_stepTimer        SeasonMapMaterialDefaultAudioHelperControllerPlayUISoundResourceSeasonCriAudioStepDefaultMetal
StepMetalStone
StepStoneWater
StepWater
_voiceCfgstepInterval�               <   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    <   mapMaterial    <   
deltaTime    <   clock4   ;      _ENV �   �       � @ �@@� � �@ & �    AudioHelperControllerPlayUISoundAutoRelease            �   �   �   �   �      self       	audio_id          _ENV �   �       G @ b   ��G @ G@� _�� ��G @ � A @ AAG�A GA��� J���L�A � @ d@�& �    _daxiyiPlayer	playerID��������	distance_GetPlaneDistance	position_cameraTransform_PlayRadiuSound           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self            �   �    4   � @ �    �� @ �@@_�@ ���@ � A� @ �@�@ AA�@�� @ ������A ��A � ���B�  ���AB �B�@��� � �
��@ 
Â�@ ��  j����  *��� @ �@A_�@ �� @ ��@ ���@ AAC  䀀����  �
 C�& �    _daxiyiPlayer	playerID��������AudioHelperControllerStopInnerGameSfxaudioIDipairs_audioPlayersisAnimationAudiopairsAnimAudioIDPlayInnerGameSfx          4   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    4   curName    4   (for generator)   %   (for state)   %   (for control)   %   k   #   v   #   (for generator)   #   (for state)   #   (for control)   #   key   !   value   !      _ENV �   �    (   � @ �@@�� @���@ ��@� A �@��@  �� @ ��A_�� � �� @ ��A��  �� B �@B��B� B �@����� ��@ �@FA G��$A �C �C$�� D���  $� 
 �����& �    SeasonEventPointType
MainLevelAudioHelperControllerPlayUISoundAutoReleaseSeasonCriAudioMonsterBoxSubBox
_voiceCfg
box1Audio              �      _eventGameGlobalTimer	AddEvent         �   �         @ "@  � �   @@ � � $@�& �    _stopAllAudio_PlayVoice           �   �   �   �   �   �   �   �          self
box1Audio(   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    (   eventPointType    (   
box1Audio   '   delay   '      _ENV �   �       � @ �@ �@@ �@   ���@ � A� � �� 
� �& �    StopSeasonUIVoice_stopAllAudio
_curVoiceAudioHelperControllerPlayUIVoiceByAudioId            �   �   �   �   �   �   �   �   �   �   �      self       audioID          _ENV �   �       G @ b   � �F@@ G�� � @ d@ & �    
_curVoiceAudioHelperControllerStopUIVoice            �   �   �   �   �   �   �   �      self          _ENV �   �       
@@�L�@ d@ F�@ G � d@� & �    _stopAllAudioStopSeasonUIVoiceAudioHelperController	PauseBGM            �   �   �   �   �   �   �      self          _ENV �   �       
@@�F�@ G�� d@� & �    _stopAllAudio AudioHelperControllerUnpauseBGM            �   �   �   �   �      self          _ENV �   �       
@ �b   @ ��@@ �@ & �    _stopAllAudioStopSeasonUIVoice           �   �   �   �   �   �      self       stop           I                                                   ;      =   C   =   E   G   E   I   Q   I   T   i   T   k   o   k   q   �   q   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �          _ENV