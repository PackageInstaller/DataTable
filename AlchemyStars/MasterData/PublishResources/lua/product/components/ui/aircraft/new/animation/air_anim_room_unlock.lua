LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1705/client/Assets/../PublishResources/lua/product/components/ui/aircraft/new/animation/air_anim_room_unlock.lua             @ A@  ��@ $@�@@  ���  F@@ �   J� �F@@ �@  J���& �    _classAirAnimRoomUnlockObject       ConstructorPlay        
          
@ �
���
� �cA   �C  
@��FAA L��d� 
@�& �    _main	_spaceID
_onFinish_test_playerEZTL_PlayerNew                                                   self       main       spaceID       	onFinish       test          _ENV         F @ �@  ǀ@ d@�F�@ G � d�� L@� ƀA ���� A d@�F�@ G � d�� L@� ƀA �@�  d@ G�B L�� d� � � ǀB �@�C  �@�ƀC ����� �� ��� J� �ǀB �@�G�@ 䀀�D "  @ ���$A �B E���  B $A�  l  ���� �� �  ����D $��"  ��FF � d@����C �� ǃF�����ǃF���ǃF�G �G���ʁi�  ���@�� d� ����B�G�D 䂀��F�G �� �� 	 d� C������C����CI �I$� �I�
 �CJ ǃ�$� \ M��
�GK�C�� A� �C �C� A�
 �C �  �   FDL G��
��FDL G�
D�FDL G��
��FDL G�
D�L��d� GD�  � 	���	�N O
�E �E $� ��	� 	���	�O O
�E  �� $� ��	� 	���	�N O
� �E $� ��	� 	���	�O O
��  �� $� ��	� 	���	�N O
�� � $� ��	� 	���	�O O
��  �E $� ��	� 	̈́�	�N O
�� � $� ��	� 	̈́�	ER O
���� � A� � $����	� 	̈́�	�N O
�E �� $� ��	� 	̈́�	ER O
��� � A� � $����	� 	̈́�	�O O
� �E $� ��	� 	̈́�	�N O
�� �� $� ��	� 	̈́�	�O O
�E � $� ��	� 	̈́�	�N O
�E �� $� ��	� 	̈́�	�O O
�� �� $� ��	�V ��	@ 	�E � �V �V
��	$E�& � \   AirLog%开始休息区房间解锁动画：	_spaceIDGameGlobalEventDispatcher	DispatchGameEventTypeAircraftUILockAirAnimRoomUnlockAircraftShowRoomUI_mainGetMainCameracullingMaskSetHudCameraActiveAircraftLayerPet       GetRoomBySpaceID_testLoadLastGameObjectFocusRoomToAnimate�      eff_aircraft_PostProcess_PlaneGetFirflysipairseff_aircraft_guangchong1
transform	position	rotationlocalScaleVector3oneeff_aircraft_window
GetWindow��(\���?
ףp=
�?q=
ףp@ResourceManagerGetInstanceSyncLoadAsseteff_aircraft_BrightObject.mat	LoadTypeMat       Obj	SetFloat
_Dissolve       _AlphaAirRestAreaType	RestRoomstr_aircraft_unlock_restroomEntertainmentRoomstr_aircraft_unlock_gameroomBarstr_aircraft_unlock_barCoffeeHouse str_aircraft_unlock_coffeehouseArea
EZTL_WaitNew相机聚焦，先等0.7sEZTL_Callback(打开相机遮罩，播放关窗动画�      关窗等1s截屏�       截屏后等0.2s替换房间、家具换材质       �
      等2.8sEZTL_MatFloat        �      $材质Dissolve参数到0，时长2s�      材质Dissolve动画后等1.7s�      材质Alpha动画，0.5s切换回正常房间       析构前最后等2s显示修复ui动画�      动画等3s析构，结束回调EZTL_Sequence"解锁房间总时间线，串行_playerPlay         4   <       F @ L@� d� L�� �   �  � �A AAd� b@   ���A ��A�     �@�� � �  �@BH@ ��� �  & �    ResourceManagerGetInstanceSyncLoadAsset.prefab	LoadTypeGameObjectLog
exception加载不到特效：       Obj            5   5   5   5   5   5   5   5   5   5   6   6   7   7   7   7   7   9   9   9   9   :   ;   <      name       req
      go         _ENVreqs m   x     *    @ @@ � � $@� @ F�@�  �  A d� 
@ � @ F�AG � �@ �   d� 
@ � @ F�@G�� 
@ �    C � � $@� � C � � $@�   @C ��C��C� ��  $�  L@D �� d@�& �    
transform
SetParentlocalPositionVector3        333333+@localRotationQuaternionEuler��������localScaleone
SetActiveGetComponenttypeofUnityEngine
AnimationPlayeff_aircraft_PostProcess     	    *   n   n   n   n   o   o   o   o   o   o   o   p   p   p   p   p   p   p   p   q   q   q   q   r   r   r   r   t   t   t   t   v   v   v   v   v   v   v   w   w   w   x      anim&   *      postEffcamera_ENVcloseWindow ~   �     -    @ @@ E � ��@ ��@$@� �@A ��A ��A �  $�  	   ��  ���  �B � C �@C��C� C �@���� $��E � L@� ƀA C �D�  d�  ��� � EA @  �@ � @ �@@� � �@ �E�@�& �    GameObjectHelperSetGameObjectLayerAircraftLayerPetgameObjectAddComponenttypeofH3DUIBlurHelperOwnerCameraUseAllCamerasCaptureBlurTextureUnityEngineScreenwidthheight        GetComponentMeshRenderersharedMaterialSetTexture_CutTexDefault         -                     �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      rt   -   meshRender!   -      _ENVpostEffblurcamera �   �     T    @ "   � � � @@ $@ � ��@ �@ � A $@�@A�A $�� �A � B�@B� A $@ �@ �B � A $��F�B�   d � ���  �A�i�  ��F�B� �d � ��A�� �A�i�  ��F�B�   d ������� ��C�DBDF�DG��$ ��  �   ��E ���@��A E�EA� ���ǂ��K  �C �E΃�� ������DJ�	� 
���C����HA���i�  �@�& �    _testSwitchToNow_mainRefreshRestRoom	_spaceIDGameGlobalEventDispatcher	DispatchGameEventTypeAircraftRefreshDecorateAreaGetFurnituresBySpaceipairsSetEffectActive
SetActive
TransformgameObjectGetComponentsInChildrentypeofUnityEngine	RendererLength               
materials          T   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      furs   T   (for generator)       (for state)       (for control)       _      fur      (for generator)#   )   (for state)#   )   (for control)#   )   _$   '   firefly$   '   (for generator),   S   (for state),   S   (for control),   S   _-   Q   fur-   Q   meshRenders6   Q   (for index)?   Q   (for limit)?   Q   (for step)?   Q   i@   P   renderA   P   matsB   P   oldMatsC   P   (for index)G   N   (for limit)G   N   (for step)G   N   jH   M      selfroom_ENV	fireflysfurMatrenderMats �   �     0    @ A@  $@ �@ E � $ ��F@ ��  ��dA�GA��� ����� �� �����J������@��)�  ��� �� ���B�B � � $@��B C �@C$��F�C �   d � ����� �A�i�  ��E �L � �   d@�& �    AirLog恢复家具材质pairs恢复的家具render:name
materials        Length       cullingMask_mainSetHudCameraActiveGetFurnituresBySpace	_spaceIDipairsSetEffectActive
SetActive      	    0   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      (for generator)      (for state)      (for control)      render      mats      ms      (for index)      (for limit)      (for step)      i      furs"   0   (for generator)%   +   (for state)%   +   (for control)%   +   _&   )   fur&   )      _ENVrenderMatscameraoldMaskselfcloseWindow �   �         @ @@ $�� �@ ��  � A �@�� E� L��d �  A AAE $ $@  & �    GameGlobalUIStateManagerShowDialogUIAircraftUnlockFileControllerStringTableGetstr_aircraft_unlock_room	RoomName            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �          _ENVroomenTip �       <    @ E � $ @ �LA@dA )�  ����@ �@ $��  A �@ $@��A �A  B E  $@ @�"   @ �@�$@� ��"@  ���@ �B $��  C �@C ��C���$@  �@D ����   $@ �@ �B $��  C �@C ��D$@��@ �B $��  C �@C ��D�    $@�@E A� $@ & �    ipairsDisposeGameGlobalUIStateManagerCloseDialogUIAircraftUnlockFileControllerUnityEngineObjectDestroy
_onFinish_testEventDispatcher	DispatchGameEventTypeGuideEntertainmentRoomUnlock	_spaceID_mainSelectSpaceAircraftOnAmbientChangedAircraftUILockAirAnimRoomUnlockAirLog"休息区房间解锁动画完成          <   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                                             (for generator)      (for state)      (for control)      _      req         _ENVreqsblurself              !   !   !   !   !   !   !   !   !   #   #   #   #   #   #   #   #   &   &   &   '   (   (   (   (   *   *   *   *   *   *   ,   ,   ,   ,   -   -   -   .   .   1   1   1   1   1   1   3   <   >   >   >   @   A   A   A   B   B   C   C   C   C   E   E   E   F   F   F   G   G   G   H   H   H   H   I   C   C   M   M   M   N   O   O   O   Q   Q   Q   Q   Q   Q   Q   Q   R   R   S   S   U   U   U   U   U   U   U   U   V   V   V   X   Z   Z   Z   Z   [   [   [   [   ^   _   a   b   b   b   c   c   c   d   d   d   e   e   e   g   g   g   i   j   j   j   j   j   j   j   j   k   k   l   l   x   z   l   z   {   {   {   {   {   {   {   {   |   |   }   }   �   �   }   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �       �     
  
  
  
  
               self      camera     oldMask     room'     reqs3     loadEff4     postEff7     	fireflys8     fireflyTrans;     (for generator)@   Q   (for state)@   Q   (for control)@   Q   iA   O   fireTA   O   fireflyD   O   closeWindowT     windowTU     windX     reql     furMatp     renderMatsy     blurz     enTips�     enTip�     tls�     tl       _ENV                        
      
                index         _ENV