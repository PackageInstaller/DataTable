LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1140/client/Assets/../PublishResources/lua/product/components/ui/homeland/pet/behavior/component/homelandpet_component_extra_animation.lua         O    @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���A l@  
@���A l�  
@ ��A l�  
@���A l  
@ ��A l@ 
@�� C l� 
@���C l� 
@���C l  
@ ��C l@ 
@���C l� 
@ ��C l� 
@���C l  
@ ��C l@ 
@���C l� 
@ ��C l� 
@���C l  
@ ��C l@ 
@���C l� 
@ ��C l� 
@���C l  
@ ��C l@ 
@���C l� 
@ �& �    requirehomelandpet_component_base_class#HomelandPetComponentExtraAnimationHomelandPetComponentBaseConstructor#HomelandPetComponentExtraAnimationReLoadPetComponentInitFishingManager	OnExcuteExit#HomelandPetComponentExtraAnimationDispose#HomelandPetComponentExtraAnimationPlayAnimationPlayEffect
GetEffectStopAllEffect	_GetData_RandomAnimationAndEffect_PlayAnimation_PlayAnimationOnce_DestroyAnimTask_PlayEffect_StopEffect_PlayEffectAnimation_LoadPetExtraAnimationStartFishToolsStopFishToolsDestroyFishTools               	   @ A@�@@  �� �  �$A�A AA$� 
 ��
�A�  
 �  
 ��& � 
   #HomelandPetComponentExtraAnimationsuperConstructor_animation_petGetAnimation_petExtraAnimationCfg _petEffectReqs_petEffectObj                                    
   
   
   
                        self       componentType       pet       	behavior          _ENV           G@@ L�� d� 
@ �& �    _animation_petGetAnimation                             self                      & �                      self               *       G @ b@   �F@@ G�� ��@ d� � � �� �@A� 
� �G @ f  & �    _fishingManagerGameGlobalGetUIModuleHomelandModule
GetClientFishingManager                        "   "   "   "   $   $   &   &   &   )   )   *      self       homeLandModule      homelandClient	         _ENV ,   8       G @ �@@ ��@�� @�G�@ b@    �& � G A b@  � �G@A L�� d� 
@ �G@A L�� � � d@�F@@ G � 
@ �& � 	   stateHomelandPetComponentStateResting_petExtraAnimationCfg_animation_petGetAnimationSetBipObstacleEnabledRunning            -   -   -   -   -   .   .   .   /   1   1   1   2   2   2   2   5   5   5   5   6   6   6   8      self          _ENV :   H    	    G @ �@@ ��@��@�   �@ � A �@A  �@�
�A�� B �@B � @ �́B�A ��  *����B � C�@B �@ ��B � C�@C �@ ��C �@ ��C �@ & �    state#HomelandPetComponentExtraAnimationsuperExit_petSetBipObstacleEnabled_petExtraAnimationCfg pairs_petEffectReqsDisposetableclear_petEffectObjDestroyFishTools_DestroyAnimTask             ;   <   <   <   <   <   >   >   >   >   ?   @   @   @   @   A   A   @   @   C   C   C   C   D   D   D   D   F   F   G   G   H      self        	preState       (for generator)      (for state)      (for control)      _      _req         _ENV J   L       F @ G@� G�� d@� & �    #HomelandPetComponentExtraAnimationsuperDispose            K   K   K   K   L      self          _ENV N   V       � @ @� 䀀#�  �A�L@ � d����  ��A��   � �́@ @ � �A & �    	_GetDataanim_PlayAnimation           O   O   O   P   P   P   Q   Q   Q   R   R   R   S   S   T   T   T   T   V      self       cfgId       
nextCfgId       data      anim      	nextData	      	nextAnim           X   a    	   � @ @� 䀀�   ���   @�A@ �������$A�� �AA ���$A�& �    	_GetData_PlayEffectpeffpholderpanim_StopEffect           Y   Y   Y   Z   Z   [   [   \   \   \   \   \   \   ^   ^   ^   a      self       cfgId       show       data           c   h       � @  � ����   ���@@�   � �ǀ@ A@� ��  & �    	_GetDatapeff_petEffectObj           d   d   d   e   e   e   e   e   f   f   f   f   h      self       cfgId       data           j   o    	   F @ �@@ d @����  �A���@  ��A�i�  ���& �    pairs_petEffectObj
SetActive_PlayEffectAnimation            k   k   k   k   l   l   l   m   m   m   k   k   o      self       (for generator)      (for state)      (for control)      _   
   gameObject   
      _ENV q   v       �@@ ��@�@ 
� �� @ �   @ �� @ ��@� A @ 䀀�  & �    _petExtraAnimationCfgCfg!cfg_homeland_pet_extra_animationAnim_RandomAnimationAndEffect            r   r   r   r   s   s   s   s   s   t   t   t   u   v      self       cfgId       info	      data         _ENV x   �    2   b@  @ ��   �  � @ �@@� � �� !�@@ ���� �  ��  �   A @� $@�GBAb  ��K � �BAkB �@�GBA�@)�  ����A �AA�  � $��FA ��d�����   ���!�@ ��� � i�  �A�& � 	   tablecount               pairsweightmathrandom                2   y   y   z   z   |   |   |   |   |   |   }   }      �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    2   info    2   totalWeight   2   weightArray   2   (for generator)      (for state)      (for control)      key      value      randomWeight#   2   (for generator)&   1   (for state)&   1   (for control)&   1   key'   /   value'   /      _ENV �   �       � @ �@  � ��@@ ̀�� 
� �� @ �   ���@@ ����@ � A @� � �@ & �    _animation_petGetAnimationLoadExtraAnimation_PlayAnimationOnce           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       	animName       nextAnimName            �   �       � @ �@ �@@ ̀�@� �@��@    �& � �@@ ���@� 䀀�    ��AA�AL@ dA FB LA�d� L���  d��
@��^��& �    _DestroyAnimTask_animationPlay	get_Itemcliplength�      
_animTaskTaskManagerGetInstance
StartTask         �   �    	   F @ �   � � d@�F@@L�� � �d@�& �    YIELD_animationPlay          	   �   �   �   �   �   �   �   �   �      TT    	      _ENVlengthselfnextAnimName   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       	animName       nextAnimName       state      length         _ENV �   �       G @ b   ��F@@ G�� d�� L�� � @ d@�
 A�& �    
_animTaskGameGlobalTaskManager	KillTask             �   �   �   �   �   �   �   �   �   �   �      self          _ENV �   �    A   b   ��@ A "A  �
�A@ �@� $��F�@ L�d� LA��� � ���A Bd� b  ���A��   ��A�ǁB���@ �A�ǁBBC �C��ǁBD BDA� �� �� $� ����@ �A� ��D B��� �E @ �A��D A "  @��D A AE�� $A��E ��D �A ��$A & �    _petEffectReqs_petGetBoneNodeResourceManagerGetInstanceSyncLoadAsset.prefab	LoadTypeGameObjectObj
transform
SetParentlocalPositionVector3zerolocalRotationQuaternionEuler        _petEffectObj_LoadPetExtraAnimation
SetActive_PlayEffectAnimation         A   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    A   peff    A   pholder    A   anim    A   bone
   2   req   2   effect   2      _ENV �   �       b    �� @ �@ �    �� @ �@ �@@  �@���@ @ A �@�& �    _petEffectObj
SetActive_PlayEffectAnimation           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       peff            �   �       � � FA@ ��@ ��@d �  �   � ��� $A�& �    GetComponentInChildrentypeofUnityEngine
AnimationPlay            �   �   �   �   �   �   �   �   �   �   �   �      self       obj       	animName       
animation         _ENV �   �       � � A@ F�@ G��$ ��  �   @�� A �@�� �A �A$� B��� $A & � 	   GetComponentInChildrentypeofUnityEngine
Animation_petGetExtraAnimationHelperProxyGetInstance
AddAnimTo            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       obj       
animation      extra         _ENV �   �       �@    ��   ƀ@ ���䀀 � �l  䀀
���& �            _startTaskGameGlobalTaskManager
StartTask         �   �    	    F @ �   � � d@�E  L@� � �d��� � ����� ��@ ����@A� ���� � � �ǀ� ���A� 䀀 B$� AB��B�  �$A�& �    YIELD
GetEffect
transformFindLineGetComponentLineRendererThl_tool_5012001_1/Dummy001/Bone0001/Bone002/Bone003/Bone004/Bone005/Bone006/Bone007FishingManagerStartFishTools_pet              �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      TT        
fishRodgo       	fishLine       fishLineFirstPointTran          _ENVdelayselfcfgId   �   �   �   �   �   �   �   �   �   �   �      self       cfgId       delay          _ENV �   �       b@    �A   ��@ ��@��� � A,  ���
���& �            
_stopTaskGameGlobalTaskManager
StartTask         �   �    
   F @ �   � � d@�E  L@� d� L�� d@ & �    YIELDFishingManagerStopFishTools          
   �   �   �   �   �   �   �   �   �   �      TT    
      _ENVdelayself   �   �   �   �   �   �   �   �   �   �   �      self       delay          _ENV �         G @ b   ��F@@ G�� d�� L�� � @ d@�
 A�G@A b   ��F@@ G�� d�� L�� �@A d@�
 ��L�A d� L�� d@ & �    _startTaskGameGlobalTaskManager	KillTask 
_stopTaskFishingManagerDestroyFishTools            �   �   �   �   �   �   �   �   �                                       self          _ENVO                                                            *      ,   8   ,   :   H   :   J   L   J   N   V   N   X   a   X   c   h   c   j   o   j   q   v   q   x   �   x   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �            _ENV