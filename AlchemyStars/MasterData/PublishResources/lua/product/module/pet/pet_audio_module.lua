LuaS �

xV           (w@A@../PublishResources/lua/product/module/pet/pet_audio_module.lua         7    @ A@  ��@ $@�@@  ��@@ l   
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
@ �@D l� 
@ ��D l� 
@ �& �    _classPetAudioModuleGameModule%RequestAdx2VoiceCueSheetByAnyAudioId%ReleaseAdx2VoiceCueSheetByAnyAudioIdPlayPetAudioRandomPlayPetLoginVoiceStopAll	IsUnLock
ClearDataFildPriorityCheckPetDailyHasPlayAudioMultiChooseOne
PlayAudioUIStateHandleConstructorInitPetAudioModuleDisposePetAudioModuleUpdate               
$   � @ �@    �& � _@@@ �!�@ ���@ � �A �@ & � ̀A @ �� �  � C� 䀀@� ��@ AA� ���   $A�  & AB �B@�$A & �    USEADX2AUDIO         Logerror8RequestVoiceCueSheetByAnyAudioId petId invalid petResIdMultiChooseOne5RequestVoiceCueSheetByAnyAudioId not find voice id : petId:AudioHelperControllerRequestUIVoice         $            	                                                                                                      self    $   filed    $   	petResId    $   voiceId   $      _ENV    )    
$   � @ �@    �& � _@@@ �!�@ ���@ � �A �@ & � ̀A @ �� �  � C� 䀀@� ��@ AA� ���   $A�  & AB �B@�$A & �    USEADX2AUDIO         Logerror<ReleaseAdx2VoiceCueSheetByAnyAudioId petId invalid petResIdMultiChooseOne9ReleaseAdx2VoiceCueSheetByAnyAudioId not find voice id : petId:AudioHelperControllerReleaseUIVoiceByAudioId         $                                           #   #   #   #   #   #   #   $   $   %   %   %   %   %   %   %   &   &   (   (   (   (   )      self    $   filed    $   	petResId    $   voiceId   $      _ENV 0   a    J   @ � �� $� _@@@ ��  � �@� ���@ �A�� �  �BA ��A  �����A @ �� �  �@ ��� 䂀��@ �  & �    ���B ��$��_�@@ �@B@ �D  f 
� �
@��
@�
���
 �
���"  @ �G�C 
@�GCD _��@�F�D G��d�� L��CD dC�F�D G��d�� LC�ǃE ,  d� 
@��@���C f�& �    FildPriority mRoleModule	GetResIdmPetModuleGetPetByTemplateIdMultiChooseOne
PlayAudio��������mCurrPetResId
mCurFiledmCurFiledPromCurrAudioResIdmCurIdmTimeFinishmLoginPlayerIdmTimeEventGameGlobalTimerCancelEvent	AddEvent
SSGAPTIME         [   ]        @@�& �    mTimeFinish           \   ]          selfJ   1   1   1   1   2   2   3   3   6   6   7   7   7   7   ;   ;   ;   ;   <   <   <   <   <   <   <   <   <   =   =   >   >   @   @   A   D   D   D   E   E   E   E   F   F   K   L   M   N   O   P   Q   Q   R   R   T   T   T   U   U   U   U   U   U   Y   Y   Y   Y   Z   ]   Y   ^   `   `   `   a      self    J   filed    J   	petResId    J   notRand    J   bLoginVoice    J   voiceSkinID    J   click    J   replaceVoiceID    J   rz   J   pro   J   petData   J   voiceId   J   oid%   J      _ENV c   y    *   F @ G@� �   d� ��@ ��@� � �� � A �@�  � � D  ��A �� � �� @ �@�� ��A��  *� �  �& � �@ �A@�A B  �& � �AB�B �� ��  C� $B & �    Cfgcfg_pet_voicetablecountmathrandom       pairs PetIDPlayPetAudioLoginVoice         *   d   d   d   d   e   e   e   e   f   f   f   f   g   h   i   i   i   i   j   j   k   k   n   i   i   p   p   q   s   s   s   t   t   u   w   x   x   x   x   x   x   y      self    *   cfg_pet_voice_table   *   l_TotalNum   *   l_random_num   *   	l_nIndex   *   l_Key   *   (for generator)      (for state)      (for control)      key      value      l_template   *   l_templateId#   *      _ENV {   �       G @ _@� � �G @ ��@ ��   �& � F�@ G � � @ d@ F@A G�� d�� L�� � B �@�  d@ L�B d@ & �    mCurId mLoginPlayerIdAudioHelperControllerStopUIVoiceGameGlobalEventDispatcher	DispatchGameEventTypeClosePetAudio
ClearData            |   |   |   |   |   |   |   }   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �   �    �   � @ �@��@���@ �  & ��FA GA�@���@@ �  & �A$� G�� @�&�  &  &���FA G�@���@@ �  & AB$� G�� @�"�  & �!���FA G��@���@@ �  & �B���$��"A  @�  & ����FA G�@��AC $�� G��`@� �G��  �@�C  f ����FA G��@ �D AD$�� �D��D $��"A  @ �C  f FE GA���E�� ��Ed� ���`��� ���� @���  �  ���FA G�@���@@ �  & �A$� G��_@��  & ����FA GA�@@�D AD$�� �D��D $��FE GA���E�� ��Ed� ��F ��F ��B @�����  ƁF �F GA� ��$��  �� � ���_ ���& �  ���FA G��@����FD G���H d� �A�  ����A  @ ��  � � & & � "   Cfgpet_intimacy_condition ConditionTypePetIntimacyCondition	AffinityGetPetAffinityLevelValueGradeGetPetGradeThreeIsFinishedStoryTimeTodayPastTimeSecValue2ServerTimeGameGlobal
GameLogic
GetModuleSvrTimeModulemathfloorGetServerTime�      AffinityEqual	DateLock	tonumberosdate%m%dSpeSkin
PetModule	HaveSkin         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    �   ruleId    �   petData    �   
condition   �   curtA   I   	time_modU   g   	tmSecond_   g   	time_mod�   �   	tmSecond�   �   l_month�   �   l_day�   �   skinid�   �   
petModule�   �   	haveSkin�   �      _ENV �   �       
@@�
@@�
@��
@@�
@��
@@�G�A _@� @�F B G@� d�� L�� ��A d@�
@��
@��& �    mCurrPetResId 
mCurFiledmCurFiledPromCurrAudioResIdmCurIdmLoginPlayerIdmTimeEventGameGlobalTimerCancelEventmTimeFinish            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �   �    .    @� ��     � ��@@ ǀ�ǀ� � ��@ AAA � �� $A   D  &��A  � ��B � ��AB _�B@�  D  &�@��B _ @���G�B  @� �  D  &�� G�&�& �     Cfgcfg_pet_voice_priorityLogerrorcfg_pet_voice_priority  errormCurrPetResId
mCurFiledmTimeFinishmCurFiledPro	Priority         .   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    .   	petResId    .   filed    .   cfgpvp   .      _ENV �   	   >   � @ �@��@ � ��$� F@ GA��A d� �AA ��A���� ���� �AB �B �BA � $��  BB F�B G���B � d�$�  FBB ��B ��B��   ��d�  � ��  �@ ��� ����C ���B�  � �  @ ��� � ��C ��ǂ�  A� �B��  � & �    GameGlobal
GetModuleRoleModule	GetPstIdSvrTimeModulemathfloorGetServerTime�      	tonumberosdate%y%m%dUnityEnginePlayerPrefsHasKeySetInt                >   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                                                                      	     self    >   petId    >   model    >   roleModule   >   pstId   >   	time_mod
   >   	tmSecond   >   l_year   >   l_month   >   l_day%   >   key,   >      _ENV   �     � �  @ �@  ��   � ����� @ �   @��B@ ��@˂  �B���B��� �  ���BA   � �  @ ��A ��B@ ǂ��  
C��
�A�� �   �CA @�$� "  ����@��B@ ��@˂  �B����A��� �  @��BA   � �    ��A"B  @��B �BB��  � �B�& � �  ���B ��C�  @�� @���ǂACCL�C �  �d� b  ��L�C ��  d� bC    �� �  �B@ �B�ǂ��  � ���"    ����  K  �  "  � �ǃ �    ��� �C  ���B ��D @� �� � �C�& � ��E   �  ����CF   ��
��F G��	@
  ��	�E�	_�A
� �E�	�F
 �  G��	
E�GE�	b    �
�G�FF G�
��� 
dE����C �E�	��$� _�G
@ �����  G��	
E�GE�	b    �
�G�FF G�
��� 
dE��  jD� ���E   � @�@ �� @��B ��� �C �  � �CA  �� �  ��"  ���C@ ���D  
D�� �   ���"  @�GIb  ��FF GD��IƄI ���	d��b  � �����G	� ��G& �
 �    �ǃA
 �    �DCK  �D
 �� �A� ��ǅ�  G�
F�G��b  � �M�	
F���	� �M	
F��	FF G���� dF������J ��	� @ 	䄀� \��� (E�ƅG�J!@�	@ ��G� '�& � -   
GetSkinIdCfgcfg_pet_voicePetIDSkinIDnext        Logdebug8###[PetAudioModule] cfg_pet_voice_skin is nil ! id --> MainLobbyInteractMainLobbyDailyInteract       	IsUnLockCheckPetDailyHasPlayAudiomainlobby1cfg_pet_voice_priorityRandomTypeRandomWeighterror-###[PetAudioModule] skinVal is nil ! id -->  | filed --> typetableipairsmCurrAudioResId��������id       skininsertnumber)PetAudioModule:MultiChooseOne type errorcfg_pet_skinUnlockType
icontainsPetSkinUnlockType
PSUT_BASE
               weightmathrandom                                                                                             !  #  #  #  #  #  #  $  $  $  $  $  $  $  %  (  (  )  )  )  )  )  *  .  .  .  .  /  0  0  0  0  0  1  2  4  4  4  4  4  4  6  6  6  6  7  7  8  Y  Z  Z  Z  [  [  [  [  [  ]  `  o  p  q  q  q  q  q  r  t  t  u  u  u  u  u  u  u  v  x  x  x  x  x  y  y  y  y  z  z  z  z  z  }  }  }  }  }  }  ~      �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  y  y  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  1   self      	petResId      filed      petData      notRand      ignorePetData      voiceSkinID      click      cfg_pet_voice_skin     checkSkinID     cfgs   )   _cfgs!   )   _cfgs0   8   	cfgDailyE   Y   dailyVoiceIdK   Y   
conditionL   Y   hasPlayV   Y   randomWightZ     cfg_priority]     cfgPetVoiced     idse     skinValf     (for generator)~   �   (for state)~   �   (for control)~   �   key   �   value   �   data�   �   data�   �   skinCfgList�   �   skinCfg�   �   	baseSkin�   �   skinWeight�     normWeight�     weightList�     _weight�     (for index)�      (for limit)�      (for step)�      i�   �   data�   �   unit�   �   
randomVal    (for index)    (for limit)    (for step)    i	    unit
    weight       _ENV �  �       � @ ��   �  �@@ _ @ ���@ ��@�@@ A �@���@ �@A� � �� �  & �     mCurIdAudioHelperControllerStopUIVoiceFADEOUTTIME!RequestAndPlayUIVoiceAutoRelease            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       audioResId       id         _ENV �  �      � @ �@ & �    StopAll           �  �  �     self       uiStateType            �  �      
@@�
@@�
@��
@@�
@��
@@�
@��
@@�
@��
@@�
 Å
�Æ& �    mCurrPetResId 
mCurFiledmCurFiledPromCurrAudioResIdmCurIdmLoginPlayerIdmTimeEventmTimeFinishmRoleModulemPetModule
SSGAPTIME�      FADEOUTTIME�                 �  �  �  �  �  �  �  �  �  �  �  �  �     self            �  �      F @ G@� G�� �   d@ L A �@A d��
@��L A ��A d��
@ �& �    PetAudioModulesuperInitmRoleModule
GetModuleRoleModulemPetModule
PetModule            �  �  �  �  �  �  �  �  �  �  �  �  �  �     self          _ENV �  �      F @ G@� G�� �   d@ & �    PetAudioModulesuperDispose            �  �  �  �  �  �     self          _ENV �  
      G @ @�   �& � F�@ G�� � @ d� _ �   �& � �@A ��A��� ��AB ABC� �@ ��B �@ & �    mCurId AudioHelperControllerCheckUIVoicePlaying GameGlobalEventDispatcher	DispatchGameEventTypeClosePetAudio
ClearData            �  �  �  �                                	  	  
     self       
isPlaying         _ENV7                                 )      0   a   0   c   y   c   {   �   {   �   �   �   �   �   �   �   �   �   �   	  �     �    �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  
  �  
         _ENV