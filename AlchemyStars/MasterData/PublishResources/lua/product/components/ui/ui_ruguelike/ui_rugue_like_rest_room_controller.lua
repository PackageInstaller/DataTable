LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/ui_ruguelike/ui_rugue_like_rest_room_controller.lua         +    @ A@  ��@ $@�@@  ��@@ l   
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
@ �& �    _classUIRugueLikeRestRoomControllerUIControllerOnShowOnHideGetComponentsOnValueRequestRest	OnUpdate
PlayVideo
StopVideoLifeBtnOnClickReplyBtnOnClick	LockBusyBtnOnClickByParam           &    #   �@� 
� �
�@�
@A��   
� �� @ �A �� B �@B�� �@ & � � C �@CƀC �� 
���� C �@C� D �� 
�����D ��  � ���
���
�@��@E �@ ��E �@ & �    
_roomInfo       _isLife        _rested _rest_pets Logfatal$[error] maze --> _roomInfo == nil !_moduleGameGlobal
GetModuleMazeModule_petModule
PetModule
_originalVector2,      powerAddValueGetComponentsOnValue         #         
                                                                                 !   #   #   %   %   &      self    #   uiParam    #      _ENV (   -       G @ b   ��G @ L@� d� b   � �G @ L�� d@ 
�@�& �    	_tweener
IsPlayingKill            )   )   )   )   )   )   )   )   *   *   *   ,   -      self            /   ;    )   L@@ ��  �  d� 
@ �L@@ �@ � d� 
@ �L@@ ��   d� 
@��L@@ �@ � d� 
@��L@@ �  A d� 
@��L@@ ��  d� 
@ �L@@ �@ � d� 
@��L@@ �@  d� 
@��& �    _toastRootHpGetUIComponentRectTransformtoastHp_toastTextHpUILocalizationTexttoastMsgHp_toastRootPowertoastPower_toastTextPowertoastMsgPower_toastPowerIconImage
toastIcon_videoPlayerVideoPlayervideo	_lifeTexlifeTex
_relpyTex	relpyTex        )   0   0   0   0   0   1   1   1   1   1   3   3   3   3   3   4   4   4   4   4   5   5   5   5   5   7   7   7   7   7   9   9   9   9   9   :   :   :   :   :   ;      self    )        =   �    x   L @ �@  �@ �@d� � A ̀� F�A G��AB ��BG��G��䀀����� C �@C��A ǀ�ǀ��   �	���DG��GA������D��D ��FBE G���� ��  d� � �BE ǂ�C @ 䂀]�A����ǁ��F E�BE ��E�  ����� CE �EAC � $���$B� �AG �GA� � $A�AH �H� ��H ́�l  �	 � BI �H��	 ��	 $� F�H L���B  
 d� �BI ��HC
 A�
 �� ��H ̂�l�  ��
 � CI �H� �C $� F�H L����  �
 d� �CI ��H� A� �� ��H ̃�l � � �A  �A $� 
 �& � 2   	GetAssetUICommon.spriteatlas	LoadTypeSpriteAtlas_toastPowerIconsprite
GetSpriteCfgcfg_top_tipsRoleAssetIDRoleAssetLightIcon
_roomInforoom_idcfg_maze_roomParam                     
_relpyTexSetTextStringTableGet"str_maze_rest_room_btn_tex_health
!str_maze_rest_room_btn_tex_light       	_lifeTex str_maze_rest_room_btn_tex_lifeLogfatal<###[Maze] 进入了休息室，cfg_maze_room is nil ! id - 
_timeLineEZTL_SequenceNewEZTL_Callback
播视频
EZTL_Wait�      等1秒刷新路点发消息，刷新路点4      再等2.1秒视频播完	弹toast�      再等0.5秒再谈一个�      (等toast,看清楚是复活还是恢复关闭界面休息室动画         Y   \     	    @ @@ F�@ G�� $@  �  A $@ & �    AudioHelperControllerPlayUISoundAutoReleaseCriAudioIDConstSoundLevelUp
PlayVideo          	   Z   Z   Z   Z   Z   [   [   [   \          _ENVself a   c         @ @@ $�� �@ ��@ � A$@�& �    GameGlobalEventDispatcher	DispatchGameEventTypeOnPassRestRoom            b   b   b   b   b   b   b   c          _ENV h   w     #       @ $@ @� �@ A�  $� F A @  F@A G�� L�� � � d@�F@A �@B J� �F�B L�� �   d@�F@A G � L@� �@A � �ǀ����� �A d� L�� �   d@�& �    
StopVideoStringTableGetstr_maze_rest_room_reply_powerpowerAddValue_toastRootPowergameObject
SetActiveanchoredPosition
_original_toastTextPowerSetText
transformDOLocalMoveYlocalPositionyd             �?OnComplete          s   u        & �                u           #   i   i   i   j   j   j   j   j   j   k   k   k   k   k   l   l   l   m   m   m   m   o   o   o   p   p   p   p   p   r   o   r   u   o   w      textContentPower	   #      self_ENV |   �     �      F@@ �� ��F�@ b   ��F�@ \ �  @ ���A   �@ ��@ � �A � 
���@ �AƁA ���@ 䁀�$� @�@�FB� G��� d� @ � �F�@ \�@���FB� G���� �� C� �B@ $ d�  @ �@�FB� G��� �� C� �B@ $ d�  @ ��@��@� ��B�@  � ���   ��F@� G�� �� d�   �  �F�@ b   @�F�@ \ �  @ �@�A   �@ ��@ � �A � 
���@ �AƁA ���@ 䁀�$� @�@�FB� G��� d� @ � �F�@ \�@���FB� G���� �� C� �B@ $ d�  @ �@�FB� G��� �� C� �B@ $ d�  @ ��@��@� ��B��  � ���   F D G@� L�� � � d@�F D � E �@�  A� 䀀�� J���F�E L � �   d@�F D G@� L�� � D �@����� �̀�A d� L�� �   d@�& �    _isLife       _rest_pets               _petModuleGetPetGetPetNameStringTableGet str_maze_rest_room_show_tex_and)str_maze_rest_room_show_tex_append_point"str_maze_rest_room_show_tex_reply#str_maze_rest_room_all_pet_full_hp!str_maze_rest_room_show_tex_life_toastRootHpgameObject
SetActiveanchoredPosition
_originalVector2d       _toastTextHpSetText
transformDOLocalMoveYlocalPositiony      �?OnComplete          �   �        & �                �           �   }   ~   ~   ~                        �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      textContentPower   �   showStr   A   (for index)   ;   (for limit)   ;   (for step)   ;   i   :   pstid   :   pet   :   petName   :   showStrP   �   (for index)T      (for limit)T      (for step)T      iU   ~   pstidW   ~   pet[   ~   petName]   ~      self_ENV �   �     
       @ �   �@@�  $@     �@ $@ & �    UnLockGetNameCloseDialog        
   �   �   �   �   �   �   �   �   �   �          selfx   ?   ?   ?   ?   ?   @   @   @   @   @   @   @   @   @   @   B   B   C   C   C   D   D   E   E   F   F   G   G   H   H   I   I   I   I   I   I   J   J   J   J   J   J   J   H   L   L   M   M   N   N   N   N   N   O   O   O   O   O   O   O   M   P   R   R   R   R   R   V   V   V   X   X   \   ^   X   _   _   _   _   _   `   `   c   e   `   f   f   f   f   f   g   g   w   y   g   z   z   z   z   z   {   {   �   �   {   �   �   �   �   �   �   �   �   �   �   �   �   V   �   �      self    x   atlas   x   roomid   x   cfg_rest_room   x   hpTex   =   petCountTex   =   replyMS   =   
lifeCount.   =      _ENV �   �    
7   �   @ @@ ��@ �@A $A AA �  $A�& �  �@ �A@ �� � � �@ �A  ��   B AB�� �  �$����B   �A���B�� �   ���@ �C�A �A ���
���A�
����D ��D�A 
@E�@���@ ��@�� �E$ �A  & �    _isLife        Logfatal####休息信息不对，islife为0	LockBusy              _moduleRequestEnterRoomSetShowBusyGetSuccnotice7###UIRugueLikeRestRoomController:LifeBtnOnClick--replypowerAddValue
add_light_rest_petseffect_pstid
_timeLineStart_rested"###休息失败，错误代码：
GetResult         7   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    7   TT    7   
roomIndex    7   param   7   res   7   msg   7      _ENV �   �    
   � @ �@@�� �@  � �� @ ��@ � �@�& �    
_timeLineOverUpdate        
   �   �   �   �   �   �   �   �   �   �      self    
   deltaTimeMS    
        �   �       F @ L@� d� L�� ��  A AAd� ��A ��A� B� �@���A �@����A ��B � �䀀 �@�L�C d �  �� ���A ��C�@ & �    ResourceManagerGetInstanceGetAssetPathmijing_xiuxishi.mp4	LoadType
VideoClip_videoPlayergameObject
SetActiveurltargetCameraGameGlobalUIStateManagerGetControllerCameraGetNamePlay            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       url         _ENV �          G @ G@� L�� �   d@�& �    _videoPlayergameObject
SetActive           �   �   �   �   �         self                 D   G @ b    �F@@ G�� ��  d@ & � F@@ G�� �  d@ C   �@A �A �����A� �   ��B AB@�$�   � 
��B @�$��@ ���� �BC ̂�@ 䂀��"  @ �C � @ �)�  �A�b   @�
@D��D �� $A��D E$�� AE��E �  �E F$A���AF �FF�F G��A d $A  & �    _restedLognotice8###UIRugueLikeRestRoomController:LifeBtnOnClick--rested6###UIRugueLikeRestRoomController:LifeBtnOnClick--task
GetModule
PetModuleGetPetstablecount        pairs	GetPstID_moduleGetMazePetInfoByPstIdis_dead_isLife       	LockBusyGameGlobalTaskManager
StartTaskRequestRest
_roomInforoom_indexToastManager
ShowToastStringTableGet#str_maze_rest_room_has_not_pet_die         D                           	  
  
  
                                                                                                             self    D   hasDie   D   
petModule   D   pets   D   (for generator)   ,   (for state)   ,   (for control)   ,   key   *   value   *   pet   *   pstid!   *   mazePetInfo%   *      _ENV    '      G @ b     �& � 
���L�@ � � d@�F A G@� d�� L�� ��A    GB GA�d@�& � 
   _rested_isLife       	LockBusyGameGlobalTaskManager
StartTaskRequestRest
_roomInforoom_index            !  !  !  "  $  %  %  %  &  &  &  &  &  &  &  &  &  '     self          _ENV )  1      b   ��� @ A@ $ �@  ��@ � �@�����@ A@ $ �@  ��@   �@�& �    LockGetNameSetShowBusyUnLock           *  *  +  +  +  +  ,  ,  ,  ,  .  .  .  .  /  /  /  1     self       isLock            4  :   
   @ �� ��@@ �@ � �@ �@ ���@ �@ & �           ReplyBtnOnClick       LifeBtnOnClick        
   5  5  6  6  6  7  7  8  8  :     self    
   nParam    
       +                        &      (   -   (   /   ;   /   =   �   =   �   �   �   �   �   �   �   �   �   �      �            '     )  1  )  4  :  4  :         _ENV