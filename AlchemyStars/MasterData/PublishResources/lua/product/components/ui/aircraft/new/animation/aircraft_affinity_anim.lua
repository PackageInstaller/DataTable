LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/aircraft/new/animation/aircraft_affinity_anim.lua             @ A@  ��@ $@�@@  ��@@ l   
@�� A l@  
@�� A l�  
@ �& �    _classAircraftAffinityAnimObjectConstructorAircraftAffinityAnimPlayDispose           H    ^   K  
@�FA@ L��d� L��� BA �Ad� ��
�����A �AB�A� ǁ�����@ �@ ������A��  � ���C BC�  �� $� ��� ����C BC� �B $� ��� ���C BC�B  �� $� ���   ��� ���C BC��  �� $� ��� ����C BC� �B $� ���   ��� ���C BC��  �� $� ��� ���C BC� �� $� ���AF �A�@ �� � 
���G �A�� 
���& �    	_resReqsResourceManagerGetInstanceSyncLoadAssetuieff_other_light_1.prefab	LoadTypeGameObject
_lightEftObj
transform	position       EZTL_CallbackNew	打开ui
EZTL_Wait�      等3秒	关闭uitoast�      等toast1.5秒获得物品弹窗动画播完，析构
_timeLineEZTL_Sequence动画总时间线，串行_playerEZTL_Player                     @ @@ $�� �@ ��@ � A� � A $@��� �A � � $@� @  B $�� @B �� ��B � �A � �B CA� $ $@  & �    GameGlobalEventDispatcher	DispatchGameEventTypeAircraftUILockAircraftAffinityAnim
_lightEft
SetActiveUIStateManagerShowDialogUIAircraftUnlockFileControllerStringTableGetstr_aircraft_review_storystr_aircraft_review_story_en                                                                                                        _ENVself     #         @ @@ �   $@��� �@ $��  A �@ $@�& �    
_lightEft
SetActiveGameGlobalUIStateManagerCloseDialogUIAircraftUnlockFileController             !   !   !   !   "   "   "   "   "   "   #          self_ENV *   ,         @ @@ E � $@ & �    ToastManager
ShowToast            +   +   +   +   ,          _ENVaffinityTip 4   6     	    @ @@ $�� �@ ��  � �  $@�& �    GameGlobalUIStateManagerShowDialogUIGetItemController         	   5   5   5   5   5   5   5   5   6          _ENVaward	onFinish <   @            @ $@ @� �@ $�� �@ � � �@A�   � $@�& �    DisposeGameGlobalEventDispatcher	DispatchGameEventTypeAircraftUILockAircraftAffinityAnim             =   =   =   ?   ?   ?   ?   ?   ?   ?   ?   ?   @          self_ENV^   	   	   
   
   
   
   
   
   
   
                                                                                                      #   %      %   '   '   (   (   )   )   ,   .   )   .   /   /   /   /   /   /   /   /   1   1   2   2   3   3   6   8   3   8   :   :   ;   ;   @   B   ;   B   D   D   D   D   D   D   G   G   G   G   H      self    ^   petGameObject    ^   award    ^   affinityTip    ^   	onFinish    ^   req
   ^   tls   ^      _ENV J   P       G @ L@� d� b    �F�@ G�� �  d@ & � G @ L@� ǀA d@�& �    _player
IsPlayingLogfatal正在播放动画Play
_timeLine            K   K   K   K   K   L   L   L   L   M   O   O   O   O   P      self          _ENV R   V    	   F @ �@@ d @ �����A i�  ���& �    ipairs	_resReqsDispose         	   S   S   S   S   T   T   S   S   V      self    	   (for generator)      (for state)      (for control)      _      req         _ENV                        H      J   P   J   R   V   R   V          _ENV