LuaS �

xV           (w@Z@../PublishResources/lua/product/components/ui/aircraft/new/action/air_action_rs_look.lua         .    @ A@  ��@ $@�@@  ��@@ l   
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
@��& �    _classAirAction_RS_LookAirActionBaseConstructorStartReadyPlayStoryOnReadyPlayStory
ClickShowEndStoryDialogOnStoryFinishedOpenStroyDialogShowStoryDialogUpdateCloseIsOverStop           -    .   
@ ��A@ ��@��  @ A$ �A  
���
� �
 ��
@��AB ��BǁA ���A  @��A@ ��� G�A �A�& � �AB �A�����A  @�B@ �BA� ��$B�& � �
 ���D
 ��E
 ���E
 ��
 Ƌ
�ƌ& �    _petLogdebug6###[AirAction_RS_Look] 触发一个随机剧情-id-->TemplateID_main	_storyid_gotReward_gotAffinityCfgcfg_aircraft_pet_stroy_refresherrorG###[AirAction_RS_Look] cfg_aircraft_pet_stroy_refresh is nil ! id --> cfg_pet_story6###[AirAction_RS_Look] cfg_pet_story is nil ! id --> _storyEventIDStoryID_triggerTypeTriggerType_clickShowIDClickShowID_afterClickTimeAfterClick_startRandomStoryTimeOut�      _startTime                 .   
                                                                                                         "   "   $   $   &   &   (   (   *   ,   -      self    .   pet    .   main    .   storyid    .   
gotReward    .   gotAffinity    .   cfg   .   cfg_pet_story   .      _ENV 0   3       
@@�F�@ G�� �  d@ & �    	_runningLogdebug:###[AirAction_RS_Look] click story test --> start trigger            1   2   2   2   2   3      self          _ENV 5   C       G @ b   @�F@@ G�� ��  d@ G A b   � �
���L�A d@ @�L B d@ ��F@B G�� d�� L�� � C    d@ & �    _gotRewardLogdebug=###[AirAction_RS_Look] click story test --> trigger req succ_clickShowID_startTalk
ClickShowOpenStroyDialogGameGlobalTaskManager
StartTaskOnReadyPlayStory            6   6   6   7   7   7   7   8   8   8   :   ;   ;   ;   >   >   ?   A   A   A   A   A   A   A   C      self          _ENV E   ]    
@   � @ �@@��  �@ ��@ � A�@A �� ̀A@� ��A �B�� �AB �B � ��$� "  @�@ A@A $A AC "  � �
�C�D $A ��AD $A  �@ �DA� ���� ]��$A AE��� $�  F�E G��� dA F�@ G�d�� LA�ƁF ���  A dA�F@ G����� dA  & �    Logdebug8###[AirAction_RS_Look] click story test --> trigger reqGameGlobal
GetModule
PetModuleRequestPetViewTriggeredStory_petPstID_triggerType	_storyidGetSucc<###[AirAction_RS_Look]click story test --> trigger req succ_clickShowID_startTalk
ClickShowOpenStroyDialogerror8AirAction_RS_Look:OnReadyPlayStory-->res:GetResult()-->
GetResultGetErrorMsgToastManager
ShowToastEventDispatcher	DispatchGameEventTypeAircraftUILockReadyPlayStory         @   F   F   F   F   I   I   I   I   J   J   J   J   J   J   J   J   K   K   K   K   L   L   L   L   M   M   M   O   P   P   P   S   S   T   V   V   V   V   V   V   V   W   W   W   W   X   X   X   X   Y   Y   Y   Y   Y   Y   Y   Y   Y   [   [   [   [   [   ]      self    @   TT    @   
petModule   @   res   @   	errorMsg-   ?      _ENV _   �    Z   F @ G@� ��@ G�� b   @���� � � A� G�� ��� �B �A�� � �  @�A� � �� h�G��@ �    �gB�M�B�  �   @ ��B��b   ��C �B�C�� ���_�C@��D �B�GB � ǃD 䂀B �D��$C��    ��E �B�GB �C�� B CE��$C�"   �ƂE �B�GB �C� B CE��$C�b   ���E ��CF � ���C�$C� ���F � G�@ �@ �@�& �    Cfgcfg_aircraft_click_action_lib_clickShowID	SentenceBubbleAnimAudioSkinID_petClothSkinID               AudioHelperControllerGetCfgAudioContent AirActionSentenceNew_mainStartSentenceActionAirActionFaceStartViceActionAirAnimationActionGameGlobal
GetModulePetAudioModule
PlayAudioLogerrorE###[AirAction_RS_Look]cfg_aircraft_click_action_lib is nil ! id -->          Z   `   `   `   `   a   a   c   e   g   i   k   l   l   l   m   n   n   o   o   o   o   p   q   q   r   r   o   x   z   |   |   }   }         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    Z   cfg   Z   	sentence   S   bubble   S   anim	   S   audio
   S   	skinList   S   currSkinID   S   	_playIdx   S   (for index)      (for limit)      (for step)      i      skinid      playIdx   S   sentenceTex   S   
cfg_voice'   (   sentenceAction0   4   faceAction;   ?   animationActionF   J   audioModuleP   S      _ENV �   �    4   F @ G@� ��  d@ F�@ G � d�� L@� ƀA ���� A d@�F�@ G � d�� L@� ƀA �@�  A� d@�G�B L � �   � d@ G@C b   @�F�@ G � d�� L@� ƀA ���  A d@�L�C �@C �C d@ ��F�@ G � d�� L@� �      d@ & �    Logdebug6###[AirAction_RS_Look] click story test --> end storyGameGlobalEventDispatcher	DispatchGameEventTypeAircraftUILockEndStoryDialogRandomStoryStartOrEnd        _mainLookRandomStoryCameraAnimStart_gotRewardOnStoryFinished_gotAffinityTaskManager
StartTask         �   �    
*   F @ G@� ��@ d� ��� � A�� �@� @  � Ɓ� �� �� F@ G�d�� LA�ƁB ���  A dA�LA�d� b  @�E� L����CDdA FAD G���� dA  �FAD G��A�� dA  & �    GameGlobal
GetModule
PetModule_petPstIDRequestPetFinishTriggeredStory_triggerType	_storyidEventDispatcher	DispatchGameEventTypeAircraftUILockEndStoryDialogGetSuccOnStoryFinishedreward	affinityLogdebug&###[AirAction_RS_Look] story Look enderror
GetResult          *   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      TT    *   
petModule   *   pstid   *   res   *   replay   *      _ENVself4   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    4      _ENV �   �    6   �   �   �	� � � 	�A@ �@F�@ $� A�AA ��A� $�  L�Ad� �B�� �AB �@�ƁB ��� � � ���ƁB ���BC$ �  �C �CF�B G��� d� ��� $� �  AD �D�AA ��D�� ��  �l  $� LEdA & �            GameGlobal
GetModule
PetModuleGetPetByTemplateId_petTemplateIDGetPetAffinityMaxLevelGetPetAffinityLevel
_maxLevelStringTableGet)str_aircraft_room_affinity_add_value_maxGetPetNamestringformat)str_aircraft_room_pet_affinity_add_valueAircraftAffinityAnimNewGameObjectPlay         �   �         @ "@    �& � @� �@ A�  $@     A $@ & �    	_runningLogdebug11关闭获得物品动画Close             �   �   �   �   �   �   �   �   �   �   �   �          self_ENV6   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   	   self    6   award    6   	affinity    6   tip   6   petData   *   	maxLevel   *   level   *   petName    *   anim3   6      _ENV �   �       F @ G@� ��  d@ F�@ G � d�� L@� ƀA ���  A d@�F�@ G � d�� L@� ƀA �@�� G�B d@�G�B L � � � �B d@ 
�Æ& �    LogdebugC###[AirAction_RS_Look] click story test --> trigger and open storyGameGlobalEventDispatcher	DispatchGameEventTypeAircraftUILockReadyPlayStoryRandomStoryStartOrEnd_startRandomStoryTimeOut_mainLookRandomStoryCameraAnimStart_startRandomStory            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �   �       F @ G@� ��  d@ F�@ G � d�� L@� �� �A l  d@�& �    Logdebug7###[AirAction_RS_Look] click story test --> show storyGameGlobalUIStateManagerShowDialogUIStoryController_storyEventID         �   �            @ $@ & �    EndStoryDialog           �   �   �   �          self   �   �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �          � @ �   ���@@ �   ����@ �@ 
� ���@ ��@ !��� �
 ��
@A���A �@ ��A �   ����@ �@ 
� ���@ � B !��� �
 ��
@A��@B �@ & � 
   	_running_startTalk_startTime_afterClickTime         OpenStroyDialog_startRandomStory_startRandomStoryTimeOutShowStoryDialog            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                           	  	       self        deltaTimeMS                     G @ L@� ǀ@ d@�L�@ d@ & �    _mainRemoveOneRandomEvent	_storyidStop                            self                    G @ [ � f  & �    	_running                      self                    
@@�& �    	_running                   self           .                        -      0   3   0   5   C   5   E   ]   E   _   �   _   �   �   �   �   �   �   �   �   �   �   �   �   �     �                              _ENV