LuaS �

xV           (w@@../PublishResources/lua/product/components/ui/homeland/pet/behavior/component/homelandpet_component_interaction_animation.lua         C    @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���A l@  
@���A l�  
@ ��A l�  
@���A l  
@ ��A l@ 
@���A l� 
@ �@C l� 
@ �@C l  
@��@C l@ 
@ �@D l� 
@ �@D l� 
@��@D l  
@ �@D l@ 
@��@D l� 
@ �@D l� 
@��@D l  
@ �@D l@ 
@��@D l� 
@ �& �    requirehomelandpet_component_base_class)HomelandPetComponentInteractionAnimationHomelandPetComponentBaseConstructor)HomelandPetComponentInteractionAnimationReLoadPetComponentInit	OnExcute_PlayInteractionBubblePlayExit)HomelandPetComponentInteractionAnimation_PlayAnimationAndEffect_RandomAnimationAndEffectDispose)HomelandPetComponentInteractionAnimation
PlayStand_PlayAnimation_PlayEffect_IsFirstInteractObject_StopBuildingAnimation_AnimationStateZeroSetInteractVisible_GetInterruptCfg_BindingSkeleton           &    	%   @ A@�@@  �� �  �$A�A AA$� 
 ��
�A�
�A�
���
�A�
���
�A�
���
�C�  
 �  
 ��  
 �
���
@E�
�A�  
 ��A AF$� 
 �
@E�& �    )HomelandPetComponentInteractionAnimationsuperConstructor_animation_petGetAnimation_buildingPetCfg 
_building_interactPoint_targetPosition_targetRotation_animationPosition_animationRotation
_loopTime        _petEffectReqs_petEffectObj_buildingEffects_bubbleComponent_moveToAnimationPosition _trFollowBuilding_animationStates_interactVisibleFinalVisible_bindingSkeletoned         %                           	   	   	   	                                                    !   #   #   $   $   $   $   %   &      self    %   componentType    %   pet    %   	behavior    %      _ENV )   ,       G@@ L�� d� 
@ �& �    _animation_petGetAnimation           +   +   +   +   ,      self            .   1       G@@ L�� ��@ � �d��
@ �& �    _bubbleComponent
_behaviorGetComponentHomelandPetComponentTypeBubble            0   0   0   0   0   0   1      self          _ENV 2   a    >   G @ �@@ ��@�� ��G�@ b@    �& � G A b@  � �G@A L�� d� 
@ �G�A b   @�G�A L � d� b@    �& � G@A L�� d� 
@��G�B b   ��G@A L � � � d@�G@A L@� �   d@�G@A L�� d@ F@@ G�� 
@ �
@D�
�D�G�A L � �@A �@��  d@  F�E G � d�� L@� �   d��
@ �& �    stateHomelandPetComponentStateResting_buildingPetCfg_animation_petGetAnimation
_buildingInteractable_interactVisibleFinalVisible
_isInviteSetBipObstacleEnabledSetNavMeshObstacleEnabledLoadExtraAnimationRunning_moveToAnimationPosition_trFollowBuilding AddInteractObjectSkinID_animationTaskGameGlobalTaskManager
StartTask         K   ^    E   E   L � �   A@ �@F�� G��d@�E   L � d@ E   L � �   A@ AAF�� GA�d@�E   L � �   A@ �AF�� G��d@�F�A _ � � �F@B L�� �   d@�F�� G � �@� d� ��� �� ��C�� �     �& � �@B � �� �@�F�D �� �@ �@B � �FAE �@��   ̀��@ �   ���FAB L�d �@  ƀ� ������& �    _PlayAnimationAndEffect_buildingPetCfgInHomelandInteractAnimationType_PlayInteractionBubbleLoopOut_trFollowBuilding _petFollowBuildingGameGlobalGetUIModuleHomelandModule
GetClientIsVisitAgentTransformDOMove_targetPosition        SetRotation_targetRotation
PlayStand_StopBuildingAnimationSkinIDstateHomelandPetComponentStateSuccess          E   L   L   L   L   L   L   L   L   M   M   M   N   N   N   N   N   N   N   N   O   O   O   O   O   O   O   O   P   P   P   Q   Q   Q   Q   T   T   T   T   U   U   U   U   V   V   W   Y   Y   Y   Y   Y   Y   Y   Z   Z   Z   Z   [   [   [   \   \   \   \   \   \   ]   ]   ]   ^      TT    E   	uiModule&   E   isVisit*   E      self_ENV>   3   3   3   3   3   4   4   4   5   7   7   7   8   8   8   8   :   :   :   :   :   :   :   :   ;   =   =   =   =   ?   ?   ?   B   B   B   B   C   C   C   C   D   D   D   E   E   E   F   G   H   H   H   H   H   H   J   J   J   J   ^   J   _   a      self    >      _ENV b   j       G @ G@� ��   �& � F�@ G � �@ � @ �@�� �d��� @ �@@�@ ƀA ���`� �  �A  � AA � �@ ǀB ���@ �@�& �    _buildingPetCfgInteractionBubbles mathrandom       Logassert        !_PlayInteractionBubble error id _bubbleComponentShowBubble            c   c   c   c   d   f   f   f   f   f   f   f   g   g   g   h   h   h   h   h   h   h   h   h   i   i   i   i   j      self       index      	bubbleid         _ENV q   �    	   
@ �
���
� �A
 ���A
 ���
 ����
 �#B   �� 
 ��
���& �    _buildingPetCfg
_building_interactPoint_targetPosition	position_targetRotation	rotation_animationPosition_animationRotation
_loopTime        
_isInvite           y   z   {   |   |   }   }   ~   ~         �   �   �   �   �   �      self       buildingPetCfg       	building       interactPoint       targetTransform       animationTransform       	loopTime       	isInvite            �   �    	w   G @ �@@ ��@��@�   �@ � A �   ���@A ��A��� ��AA �@�
 B��@B �   @
���B ��B�� @	�� C AC �C����   ����C � �� �@�G�D L���Ed��GA�䀀�D �E��$A��E "  ��F $A ��ǀD �@�� ̀�GAB �� �@ ��E �   @ �� F �@ 
@G���G ��G � � ��    ��AH���  *����D ��H  �@���D ��H� �@�� I �D AI$ �@  ��I   �@�
 
 
 B�
 
 B�
�ƕ��G � K � @ ��AK�A ��  *����K ��K� K �@ ��K ��K� L �@ ��K ��K�@L �@ ��K ��K��G �@ 
@G�& � 3   state)HomelandPetComponentInteractionAnimationsuperExit_animationTaskGameGlobalTaskManager	KillTask _targetPositionHomelandPetComponentStateRunning_GetInterruptCfg
_building_cfgIDHomelandNavmeshToolGetInstanceGetReachablePosition_petGetBoneNode       	positionSetPosition_animation
PlayStandAgentTransformDOMove        
_isInvite pairs_animationStatesspeed       SetBipObstacleEnabledSetNavMeshObstacleEnabled_StopBuildingAnimationSkinID_BindingSkeleton_buildingPetCfg_targetRotation_animationPosition_animationRotation
_loopTime_petEffectReqsDisposetableclear_petEffectObj_buildingEffects_bindingSkeletoned         w   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    w   	preState   w   
interrupt   =   	position'   0   (for generator)A   G   (for state)A   G   (for control)A   G   _B   E   animationStateB   E   (for generator)`   e   (for state)`   e   (for control)`   e   _a   c   _reqa   c      _ENV �   �    �   @ � $��@@  �& � F�@ G��@�@�GA_@�� �GAO��
@��F�@ G��@� �GB_@�@�GAB L��d� ��B �C �GB�� _@@� �ǁC
����D
���GAD_@���F�D G������B BD���
��G�B LA�d� b  ����@ ��@�� ���E �� �A   ���B ��E�� _� � ��F �� �A ����@ ��@�� ���E �� �A   ��AF  �����A  � ��F �� �A ����@ ��@��@���E �� �  ����B ��F�FGG LB�d� ���A���G   �A���G  � @ � ���A ����E �� �  ����@ �H��@���B ��F�FGG LB�d� ���A���G   �A���G  � @ � ���A @���@ ��A��@���B �AH�� �A   ���B ��F�FGG LB�d� ���A���G   �A���G  � @ � ���A ��B ��HG BG$ �A   ���E �� �  ����B ��F�FGG LB�d� ���A���G   �A���G  � @ � ���A & � #   _RandomAnimationAndEffect HomelandInteractAnimationTypeLoop	duration
_loopTime�      OutleaveTransform_interactPoint	GetIndex
_buildingGetInteractLeaveNode_targetPosition	position_targetRotation	rotationfollowBuildingHomeBuildingFindRecursively_trFollowBuildingGetCurAnimationState_IsFirstInteractObjectGetCurAnimationTypeYIELD_AnimationStateZeroPlayAnimationanim_petSkinID_PlayEffect_PlayAnimationInIsMultiInteractRemoveInteractObject         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   	   self    �   TT    �   info    �   animationType    �   data   �   index   %   leaveTransform   %   fnFindRecursively*   /   animationState2   �      _ENV �      2   b@  @ ��   �  � @ �@@� � �� !�@@ ���� �  ��  �   A @� $@�GBAb  ��K � �BAkB �@�GBA�@)�  ����A �AA�  � $��FA ��d�����   ���!�@ ��� � i�  �A�& � 	   tablecount               pairsweightmathrandom                2   �   �   �   �   �   �   �   �   �   �   �   �                                                  	  	  	  	  
  
  
  
  
  
      	  	       self    2   info    2   totalWeight   2   weightArray   2   (for generator)      (for state)      (for control)      key      value      randomWeight#   2   (for generator)&   1   (for state)&   1   (for control)&   1   key'   /   value'   /      _ENV         F @ G@� G�� d@� G�@ b   ��F A G@� d�� L�� ��@ d@�
���& �    )HomelandPetComponentInteractionAnimationsuperDispose_animationTaskGameGlobalTaskManager	KillTask                                              self          _ENV         G @ L@� d� ��@ ��@�� @�G A L@� ƀA ���d@� �G A L@� ƀA � �d@�& � 	   _petGetMotionTypeHomelandPetMotionTypeSwim_animationPlayHomelandPetAnimNameFloatStand                                                     self          _ENV "  L   
z   G@ �A�ǁ@ ���GB�䁀J�G@ �A�G��b   �GA LA�ǁA ���� B�dA G�b   �G�@ LA��@ B���ǁ��dA ��G�@ L���@ B���ǁ�dA�GC b   �G@ �A�G��J�Æ� �G@ �A�G��J�ÆLD d� bA  ��GA b  ��FAD �� dA GA L��d� b  ����D �E�� �AE�� ǁ�@ GB�BO�EMB�
B�GF b  ��G�A LA�d� L����F � dA G�A L��AG dA�
�G�L�G ��  � dA GH _@�� �G�A L���H dA�F�H G�@ �FAD �� �AI dA� �G@ �A�G��G��O���AD ��  ��A�& � (   _animationStatesanim_animation	get_Item
_buildingUpdateInteractObject_petSkinIDcrossFadeTime
CrossFadenamePlay_interactVisiblespeed               _IsFirstInteractObjectYIELDGetCurAnimationStateGameGlobalGetInstanceGetDeltaTimetime����MbP?_moveToAnimationPositionAgentTransformDOMove_animationPositionSetRotation_animationRotation _BindingSkeleton_trFollowBuilding FollowBuildingHomelandInteractAnimationTypeLoop
_loopTimelength�               z   $  $  $  $  $  $  $  %  %  %  %  %  &  &  &  &  &  &  &  '  '  '  (  (  (  (  (  (  (  (  (  *  *  *  *  *  *  *  ,  ,  ,  -  -  -  -  -  /  /  /  /  1  1  1  1  1  1  1  2  2  2  3  3  3  4  4  5  5  5  5  5  6  7  7  7  7  7  7  :  :  :  ;  ;  ;  ;  ;  ;  ;  <  <  <  <  =  >  >  >  >  A  A  A  B  B  B  B  E  E  E  E  F  F  F  F  F  H  H  H  H  H  I  I  I  I  L  	   self    z   TT    z   info    z   data    z   animationType    z   buildingAnimationState?   M   
deltaTimeF   M   offsetG   M   animationTimeu   y      _ENV N  f   U   � � �    ��@@ � � �� �@  ����@ ��@� ����@A ̀�� ���G� � ]���AB ��B� �   �
���"   
�C GAC $��"  @�G�Cb  � �L�C�  dB�)�  �A���L�C�� dA�GDLA�� dA�GD��D �EJ��GD��E ��E�  A �� J���GA@ �� J� GAC �� ���J��@� �    ���F �@� �� �@  ����F � GA� GA� �@ ��F �@� ���& �    peff_petEffectReqs_petGetBoneNodepholderResourceManagerGetInstanceSyncLoadAsset.prefab	LoadTypeGameObjectObjpairs_petEffectObjactiveSelf
SetActive
transform
SetParentlocalPositionVector3zerolocalRotationQuaternionEuler        beff_buildingEffects
_buildingPlayInteractEffectbholder         U   O  O  O  O  O  O  O  O  Q  Q  Q  Q  R  R  R  R  R  R  R  R  R  R  S  S  S  S  S  T  T  T  T  U  U  U  U  U  V  V  V  T  T  Y  Z  Z  Z  [  [  [  [  \  \  \  \  ]  ]  ]  ]  ]  ]  ]  ]  ^  ^  ^  _  _  _  _  b  b  b  b  b  b  b  b  c  c  c  c  c  d  d  d  f  
   self    U   data    U   bone   D   req   D   (for generator)   )   (for state)   )   (for control)   )   _   '   obj   '   effect*   D      _ENV h  j      G @ L@� ǀ@ ����  e   f   & �    
_buildingIsFirstInteractObject_petSkinID           i  i  i  i  i  i  i  j     self            m     2   � @ �   @�� @ �@@ � ����   @�� @ ��@�@ ��@ �   ��� A �@ AA����    �� @ ̀�G�A� �@ � @ �@B�B �B$ �@  � @ � C�B �B$ �@   �� @ �@B�B �B$ �@  � @ �@C�@ 
�C�& �    
_buildingIsLastInteractObjectStopInteractEffect_buildingPetCfg_RandomAnimationAndEffectInSetAnimTimeanim        RemoveInteractObject_petSkinIDStopAnimationTryStopAnimation         2   n  n  n  o  o  o  o  o  o  p  p  p  q  q  q  r  r  r  r  s  s  t  t  t  t  t  w  w  w  w  w  w  x  x  x  x  x  x  x  z  z  z  z  z  z  {  {  {  }       self    2   id    2   data           �  �      b   @�� @ �@@�� ��@�� ��� � � �AAa �  ��@  � � �  � � �  & �    GameGlobalGetInstanceGetDeltaTimetimelength����MbP?            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       animationState       
deltaTime         _ENV �  �   
    
@ ��@@ ǀ@ � � ���@G@ �A���  *���@@ � A � ���  @��@ �  @ �����  �������  *A�� B �   � �� B �@B@ �@�& � 
   _interactVisiblepairs_petEffectObj
SetActive_animationStatesspeed               
_buildingSetInteractVisible             �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self        visible        (for generator)   
   (for state)   
   (for control)   
   _      gameObject      (for generator)      (for state)      (for control)      _      animationState         _ENV �  �   	   � @ �@@��@��@�   @�� A   � � ���@   �� �  jA��   �  & �    
_behavior_cfgBehaviorLibInterruptInteraction       pairs            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       buildingCfgID       interrupts      (for generator)	      (for state)	      (for control)	      _
      value
         _ENV �  �   
(   b   @�� @ �@��    �ǀ@ ���� @ A@M�GAb  ��GAA L������d��b   ���A � �A �B �A@ � @��A 
����@B �   � �� B �@�@� �@�& �    _buildingPetCfgBindingSkeleton_interactPoint	GetIndex       
_buildingGetBoneNodeNoRootYIELD_pet_bindingSkeletoned         (   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    (   
isBinding    (   TT    (   index	      bindingSkeleton      	skeleton         _ENVC                                 &      )   ,   )   .   1   .   2   a   2   b   j   b   q   �   q   �   �   �   �   �   �   �     �               "  L  "  N  f  N  h  j  h  m    m  �  �  �  �  �  �  �  �  �  �  �  �  �         _ENV