LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1140/client/Assets/../PublishResources/lua/product/components/ui/homeland/task/homeland_task_npc.lua         |    @ A@  ��@ $@�@@  ���  
 ��
���F�A �  �   d@�K�  J ��J�A�J Å��A �@  � �@��@@ �   �� ��@@ �@  �����@@ �  �� ��@@ ��  �����@@ �  �� ��@@ �@ �����@@ � �� ��@@ �� �����@@ �  �� ��@@ �@ �����@@ � �� ��@@ �� �����@@ �  �� ��@@ �@ �����@@ � �� ��@@ �� �����@@ �  �� ��@@ �@ �����@@ � �� ��@@ �� �����@@ �  �� ��@@ �@ �����@@ � �� ��@@ �� �����@@ �  �� ��@@ �@ �����@@ � �� ��@@ �� �����@@ �  �� ��@@ �@ �����@@ � �� ��@@ �� �����@@ �  �� ��@@ �@ ����& � 0   _classHomelandTaskNPCObjectRole       Pet       _enumTaskNpcTypeBasePlayer
Appointed       TaskNpcPetSkinTypeConstructorInitPet	InitRoleDestroySetTaskOnTalkCheckOnUIHomePetInteractTaskCloseApplicationQuit
SetParentSetHoldBuildingSetLocation
SetChatIDSetCheckTalkIDInitInteractSetVisibleGetInteractPositionGetNameRefreshInteractPointResetInteractPoint	InteractInteract_PetInteractionInteract_NpcInteractionGetInteractRedStatusAgentTransformGetRotationSetRotationPetNameGetBodyPlayAnimAndReturnTimeGetPetConfigPlayBubbleNpcIDPetIDGetTask    "       4    $   �@� 
� �
@ �
����@A� 
� ���A� 
� ���@ �@�� 
� ���� 
� �
@C�
@C��   
���
@C�
@È��D � �
� �ǀB A�  �� �̀E �@ @ ���E �@ 
@C�& �    npcIDIdcfghomelandClientinteractPointManagerInteractPointManagertaskManagerGetHomelandTaskManager_homelandPetManagerPetManagernpcTypeTypetask chatIDresReqList
transformnpcAnim	positionVector3zeroPetInitPet	InitRole_holdBuilding          $                                                       "   %   %   '   )   +   +   +   ,   ,   ,   ,   -   -   -   /   /   3   4      self    $   cfg    $   homelandClient    $      _ENVTaskNpcType 6   �    �   G @ G@� ��  ]�� � @ ��@� A �  ��@� ��A�� �@  �� @ ��@� B � ���@� ��B��� �� � C@ A@����   � ��@C� @ �ǀC ���G@ GA�䀀�   ��ǀC � �G@ GA�䀀A� AD$�� �D��� �E�   �$A� �� @ ��@�@E � ����� ��E�� � F � FA� G���� ��� ���� � �@� �A� ��G� �� �E$� F���A� ǁ�$� F�� L��d� L��� B� �Gd� ��� ��E�� �F �FB� G���� �� �A��H @ �A��� �A��H @ �A��� �A��H @ �A���H��� $B�B�
 ��BI �I��I �J�� �BJ� $B  BI �J��
 $��GK�B ǂK���� �B��L �����C� ǃ��LA 䃀�  � ��K��C  �C����B��� F�� G�$ ��  �   ���� �B�ǂ�  �B ���F�� ��� �Od �  �HCM� $��F�� L��d� LC�� d���C ǃ����� ����D��O	���D� �P	�D �P A� ���D� ���E�GE�G��
�D �����H�CM ������ ���� �C�@ 䃀@��C ���KA� ���Ǆ���	���D� ��	E G�P �� � 	�D� ���G�������L�D ���CQ��̃�F�� G��C�
���ǃR ���G@ GD��C�& � L   cfgPetId.prefabPetSkinType
AppointedLogfatal暂不支持指定皮肤PlayerGameGlobal
GetModule
PetModuleGetPetByTemplateIdGetPetPrefab_homelandPetManagerHasPetGetPetEventDispatcher	DispatchGameEventTypeOnHomeInteractFollowBaseResourceManagerGetInstanceSyncLoadAsset	LoadTypeGameObjectHelperProxyGetPetAnimatorControllerNamePetAnimatorControllerType	Aircraft	HomelandtableinsertresReqListObj
SetActive
transform
SetParenthomelandClientSceneManagerRuntimeRootTransFindRootgameObject        childCount       	GetChildstringfindnameweaponGetComponenttypeofUnityEngine	AnimatorObjectDestroyAddComponent
AnimationGetAllAnimationClipLength errorPet animation is null:_petID	, index:AddClipclipPlayHomelandPetAnimNameStandnpcAnimtaskManagerAddNpcOccupyingPet         �   7   7   7   7   8   8   8   8   8   9   9   9   9   9   :   :   :   :   :   ;   ;   ;   ;   ;   ;   ;   ;   <   <   =   =   =   ?   ?   ?   ?   ?   ?   ?   @   @   @   @   @   A   A   A   A   A   A   A   A   A   B   C   C   C   C   C   G   G   G   G   G   G   G   G   H   H   H   H   H   I   I   H   J   J   J   J   J   J   J   J   K   K   K   K   K   L   L   K   M   M   M   M   M   M   M   M   O   O   O   O   O   P   P   P   P   P   Q   Q   Q   Q   Q   S   T   T   T   V   V   W   W   W   W   W   W   W   W   X   X   X   X   Y   \   \   \   \   \   ]   ]   ]   ^   ^   ^   ^   ^   ^   ^   _   _   _   _   \   c   c   c   c   c   c   d   d   e   e   e   e   e   h   h   h   h   h   h   j   j   j   j   k   k   k   k   k   k   l   l   l   l   l   m   m   m   n   n   n   n   n   n   n   n   p   p   p   p   p   l   t   t   t   t   u   u   u   u   u   u   u   v   v   v   v   v   w   w   w   x   x   x   x   x   x   x   x   z   z   z   z   z   v   ~   ~               �   �   �   �   �   �   �      self    �   resName   �   pet   5   pet,   5   petReqC   �   petAirPrefabK   �   petAnimReqS   �   petHomePrefab[   �   petHomelandAnimReqc   �   petGameObjects   �   
rootTrans�   �   root�   �   (for index)�   �   (for limit)�   �   (for step)�   �   i�   �   child�   �   	animator�   �   petAnim�   �   aircraftAnimation�   �   clips�   �   (for index)�   �   (for limit)�   �   (for step)�   �   i�   �   homelandAnimation�   �   (for index)�   �   (for limit)�   �   (for step)�   �   i�   �      TaskNpcPetSkinType_ENV �   �    	*   G @ G@� ��@ ��@�� � A � FAA G���� ��A � �AB @ �@�ǀB���� $A��
 �C AC��C ��C�� �D� $A  C AD�� $���DLE�AE �E �E� d�  
@�& �    cfgResResourceManagerGetInstanceSyncLoadAsset	LoadTypeGameObjecttableinsertresReqListObj
SetActive
transform
SetParenthomelandClientSceneManagerRuntimeRootTransFindRootgameObjectGetComponenttypeofUnityEngine
AnimationnpcAnim         *   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    *   rolePrefab   *   roleReq
   *   roleGameObject   *   root"   *   	roleAnim(   *      _ENV �   �    .   L @ d@ F@@ ��@ d @ �����A i�  ���K   
@ �G A �@� ��  �G�A L�� � B �@�d@�G�B b    �F�B G � d�� L@� ƀC ����B d@ 
 D�G@D b    �F�B G � d�� L@� ƀC ǀ�AD d@ 
 Ĉ& �    ResetInteractPointipairsresReqListDisposenpcTypePettaskManagerRemoveNpcOccupyingPetcfgPetId_onTalkCheckGameGlobalEventDispatcherRemoveCallbackListenerGameEventTypeOnTalkCheck _onUIHomePetInteractTaskCloseOnUIHomePetInteractTaskClose          .   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    .   (for generator)   
   (for state)   
   (for control)   
   _      req         _ENVTaskNpcType �   �    "   
@ ���@ ��@�� � AAA @  �� 
�����A ��A��� � BAB AAGA@ �@ ��@ ��@�� � A�B @  �� 
� ���A ��A��� � BAB �BG�B �@ & �    task_onTalkCheckGameHelperGetInstanceCreateCallbackOnTalkCheckGameGlobalEventDispatcherAddCallbackListenerGameEventType_onUIHomePetInteractTaskCloseOnUIHomePetInteractTaskClose         "   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    "   task    "      _ENV �   �    <   @ _ �   �& � A@ �@$� G�@�A �AA�� �G�A ��@�G�A ��� �GA@ L�dA G�@�A �AB��@�GA@ L��d� b   �G�A ��@�G�A ��� �GA@ L�dA G�@�A ��B��@�GA@ L�d� b   �G�A ��@�G�A ��� �GA@ L�dA & �    npcIDtaskGetConditionInfoFinishTypeFinishConditionEnumDialogcheckchatIdchecktalkIdStartSubmitTaskImmediatelyCoro
PetSearchCheckPetSearchPetNeedCheckPetNeed         <   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    <   checkNpcId    <   chatId    <   talkId    <   conditionInfo   <      _ENV �   �    5   @ _@   �& � A@ �@$� G�@�A �AA��@�G�A ����G�A ��� �GA@ L��  dA�G�@�A �AB��@�G�A ����G�A ��� �GA@ L��  dA�G�@�A ��B��@�G�A ����G�A ��� �GA@ L��  dA�& �    npcIDtaskGetConditionInfoFinishTypeFinishConditionEnumDialogcheckchatIdchecktalkIdGetRewardsImmediately
PetSearchPetNeed         5   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    5   checkNpcId    5   chatId    5   talkId    5   conditionInfo   5      _ENV �   �    	   � @ �@@�� ǀ@�@ A ���& �    taskGetConditionInfoFinishTypeFinishConditionEnumDialog         	   �   �   �   �   �   �   �   �   �      self    	   talkId    	   conditionInfo   	      _ENV �   �       � @ �@@ � �@�& �    
transform
SetParent           �   �   �   �   �      self       parent            �   �       
@ �& �    _holdBuilding           �   �      self       	building               $   j   �@ ��   @��� b  ���A@ ʁ��A@ @ A � � $� ����A@ �A�
����A@ ǁ�
�����A@ ʁ���A@ @ A � � $� ���A@ �A�
����A@ ǁ�
����A �A   ��A@ ���A�F�B ��B �C�BCd �  
�����A �C D$� BD��D ��D$������A �AE���A ��E���A �AF���B ��ǁ����B@ BAD  � �B ����  ��GB@ �BAJ���G�A J�ǎG�A J�ǎGH LB�ƂH ���dB�GB@ GB�
@��GB@ G�L�ƂB �B CCI� d�  b    �J�ǎ& � &   Vector3
transformlocalPositionlocalEulerAngles        	positioneulerAnglesnavMeshAgentgameObjectAddComponenttypeofUnityEngineAINavMeshAgentagentTypeIDHelperProxyGetInstanceGetNavAgentIDAircraftNavAgentNormalavoidancePriority       radius�������?	areaMask       NavMeshSamplePosition
       enabled npcAnimPlayHomelandPetAnimNameStandGetComponentNavMeshObstacle         j                                                     	  	  	  	  	  	  	  
  
  
                                                                                                                                                 !  !  "  $  
   self    j   x    j   y    j   z    j   
rotationY    j   isLocal    j   vec   j   hitL   j   navMeshHitL   j   navMeshObstaclef   j      _ENV &  (      
@ �& �    chatID           '  (     self       chatID            *  -      
@ �
���& �    checkchatIdchecktalkId           +  ,  -     self       chatId       talkId            /  1      L @ d@ & �    RefreshInteractPoint           0  0  1     self            3  E   &   � @ �    �� @ �@@��@ � �@�b   ����@ � A�@A��A� @ ���  A �A ����   ��@ G��
A���B 
Å�B 
AÅ�C �C�D �AD$A�@ �A
 ��& �    
transformgameObject
SetActiveUnityEngineAINavMeshSamplePosition	position
              navMeshAgentenabled npcAnimPlayHomelandPetAnimNameStand         &   4  4  4  5  5  5  5  5  8  8  :  :  :  :  :  :  :  :  :  :  ;  ;  <  <  <  =  =  >  >  B  B  B  B  B  C  C  C  E     self    &   visible    &   hit   %   navMeshHit   %      _ENV H  J      G @ G@� f  & �    
transform	position           I  I  I  J     self            L  N      F @ G@� ��@ ��@e  f   & �    StringTableGetcfgName            M  M  M  M  M  M  N     self          _ENV P  U      G @ b   � �G@@ L�� � @ d@�G@@ L�� �     FA GA�d��
@ �& �    interactPointinteractPointManagerRemoveBuildInteractPointAddBuildInteractPointInteractPointTypeTaskNpc            Q  Q  Q  R  R  R  R  T  T  T  T  T  T  T  T  U     self          _ENV W  ^      G @ b@    �& � G @ b   � �G@@ L�� � @ d@�& �    interactPointinteractPointManagerRemoveBuildInteractPoint           X  X  X  Y  [  [  [  \  \  \  \  ^     self            a  �   A   K�  � @ �@@ǀ@ J� � @ ��@� A J� �@A ��A�� ��A��� �   �� �@  � $A��AF@ GA�@@�B GABG��@  �& � �B "  @��GB �C �AC +A�G�A�@ ��C_�� �G�A�@ ��C�� �GAA L�d� 
A��
��F�D G�d�� LA���    D  ��B � dA�& �    FinishConditionEnumPetInteractionInteract_PetInteractionNpcInteractionInteract_NpcInteractiontaskGetConditionInfoFinishTypenpcIDChatTargetId       chatIDcheckchatIdchecktalkId
PetSearchPetNeedGetCheckItem              GameGlobalUIStateManagerShowDialogUIHomePetInteract         A   b  c  c  c  c  d  d  d  d  f  f  f  g  g  h  h  i  i  i  i  j  j  j  j  j  k  k  k  k  k  l  z  z  z  {  {  {  {  {  |  |  |  |  |  }  }  }  }  }  ~  ~  ~    �  �  �  �  �  �  �  �  �  �  �  �     self    A   custom	   A   conditionInfo   A   func   A   args'   @   item4   6   
itemcount4   6      _ENV �  �      � @ �@� ǀ�� ����@ � A�� �@A�� ǀA�A �A� ��@B��A �B��B �C���� �AC�� $A �C D�� �  $A & �    npcIDChatTargetId       homelandClientCharacterManagerGetCharacterTransform	position
transformy        	DORotateQuaternionLookRotationeulerAngles�������?taskSubmitTask            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       conditionInfo       
charTrans
      toward         _ENV �  �   
   � @ �@� ǀ�� ����� � A �@�䀀 ̀�A� � �B B BBl  �@�& � 
   npcIDChatTargetId       FinishEffectIdGameGlobalUIStateManagerShowDialogUIHomelandTaskFinishEffect
transform	position         �  �        @ @@ � � �   $@ & �    taskSubmitTask           �  �  �  �  �  �         self   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       conditionInfo       id         _ENV �  �      �   �  & �                �  �  �     self       
pointType       index            �  �      G @ f  & �    
transform           �  �  �     self            �  �      G @ G@� f  & �    
transform	rotation           �  �  �  �     self            �  �      � @ �@��& �    
transform	rotation           �  �  �     self       	rotation            �  �      F @ G@� ��@ ��@e  f   & �    StringTableGetcfgName            �  �  �  �  �  �  �     self          _ENV �  �   R   � @ �@@ � @��   b   @ �� �   ���  ��  A AAF�� G��G�G��A �ABƁB� ���� �C�A �A ���A �ABƁC�@���� �D�A� �� ��DA BA����   ���D� @� ��A �AB�E������ �AE�A�  ��ǀ �@   ���  ��� ǁ�� @�� � �A����A   � ���� ǁ�� @��A��  � �� A ��F�  & �    npcTypePetNormcfgPetIdCfgcfg_petSkinIdPetSkinType
AppointedLogfatal暂不支持指定皮肤PlayerGameGlobal
GetModule
PetModuleGetPetByTemplateId
GetSkinIdBasecfg_home_pet_story_faceerror+###[HomelandTaskNPC] icon is nil ! id --> ,_face --> base_icon_*###[HomelandTaskNPC] cfg is nil ! id --> ResIcon          R   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    R   face    R   lFace   M   icon   M   tid   M   skinid   M   pet(   -   cfg6   M      TaskNpcType_ENVTaskNpcPetSkinType �  �      �   �@@ ̀�@� 䀀�     ����A@ A�� �A $A �  & �            npcAnimGetCliplength
CrossFade�������?           �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       	animName       time      clip           �  �      G @ f  & �    cfg           �  �  �     self            �  �      A   f  & �                       �  �  �     self            �  �      G @ f  & �    npcID           �  �  �     self            �  �      G @ G@� f  & �    cfgPetId           �  �  �  �     self            �         G @ f  & �    task           �  �        self           |                              
   
   
   
                              4      6   �   6   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      $     &  (  &  *  -  *  /  1  /  3  E  3  H  J  H  L  N  L  P  U  P  W  ^  W  a  �  a  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     �        TaskNpcType	   |   TaskNpcPetSkinType   |      _ENV