LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/190/client/Assets/../PublishResources/lua/product/components/ui/homeland/ui/wishing/raise/ui_build_raise_fish_model.lua         1    @ A@  ��@ $@�@@  ��@@ l   
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
@ �& �    _classUIBuildRaiseFishModelObjectConstructorCalcInitPosCalcInitDirUpdateFishCheckMoveToIdleCheckIdleToMoveMoveCheckFishColliderFishRayCastRandomMoveDirDoChangeDirDestroyGetFishingAreaPolygonIsFishInArea           ^    �   
� �
����@ �@� GA�A ]����A �B�� �AB �F�B G���� 
����A �A  @��C �A  ����A & � ��C  � ���
����A �AD
���D ��D� �A���A �AD�E
����A� � �����D ���@ �A���D BF �� $������D �F G��́G � 
����H�A�
����H���
����G 
��ǁI
���
 ʓƁJ ���䁀 ��AB ��K ��K�  䁀
���ƁJ ��� �A�� 
����L ��B AB 䁀
����M ��
��
�Μ
 ϝ
�Ϟ�  AB �A 
���
@K�ƁJ ��� �A�� 
���� � AB �A 
����L ��Q BKGQ G��䁀
��� B AB �A 
����L ��R BKGR G��䁀 A �� +B 
 ���L MGBR GB��BR ��Q$��K � �B kB 
@��
@S�K �B �� kB 
@�F�L G���S �BKǂS ���d��
@��K �B �B kB 
@�F�L G��T �BK�T ���d��� �� C �B 
����L �MǂT �B��T �Q���� C A� �B 
��
 ��
����R 
���& � W   _id_instaceIdCfgcfg_item_homeland_fishModel.prefab_reqResourceManagerGetInstanceSyncLoadAsset	LoadTypeGameObjectBuildError找不到鱼模型:_fishingAreaPointListGetFishingAreaPolygon_goObj
SetActive_transform
transformFind	FishRoot
SetParentlocalPositionCalcInitPoslocalRotationQuaternion	identity_dirCalcInitDir_moveSpeed
MoveSpeed�      _idleSpeed�      _speed_buildCenter	position_buildRadius      @_timerHandlerGameGlobalTimerAddEventTimes       TimerTriggerCount	Infinite_lastChangeDirTimeGetCurrentTime_changeDirInternalMathfRandom�      _targetDirVector3zero_changingDir _changeDirLen,      _changeDirStartTime _changeDirRange��������
       _fishState_moveStartTime_moveTimeRange'      	_moveLen       _moveChangeDirInternalRange_moveChangeDirLenRange�      _moveChangeDirRange_idleStartTime        _idleTimeRange	_idleLen_idleChangeDirInternalRange�      _idleChangeDirLenRange�      _idleChangeDirRange��������                (   *            @ $@ & �    UpdateFish           )   )   )   *          self�                  	   	   	   
   
   
   
   
   
   
   
   
                                                                                                                                                      !   !   #   #   $   %   %   %   %   &   '   '   *   %   +   -   -   -   -   -   -   .   .   .   .   .   .   1   1   1   4   7   8   :   :   :   :   :   <   ?   ?   ?   ?   ?   ?   A   A   A   A   A   B   B   B   B   B   B   B   B   D   D   D   D   D   E   E   E   E   E   E   E   G   G   G   G   G   H   H   H   H   H   H   H   J   J   J   J   J   L   N   N   N   N   N   O   O   O   O   O   O   O   O   Q   Q   Q   Q   Q   R   R   R   R   R   R   R   T   T   T   T   T   U   U   U   U   U   U   U   W   W   W   W   W   Z   [   ]   ]   ^      self    �   
buildTran    �   id    �   instanceId    �   fishCfg   �   prefabName   �   root,   �   moveChangeDirInternal�   �   moveChangeDirLen�   �   idleChangeDirInternal�   �   idleChangeDirLen�   �      _ENV `   x    3   � � A  ����   �  G�@N�� (��BA��$��\�M���Aʀ�'���F�A G�� � d���A��AB�B �BGC$� F�A G���  � d�����B���BC @ ��� �B  @��C A�  ��  ��  $� � � & �    FindFishingArea        childCount       	GetChildlocalPositionMathfRandomnormalizedmathfloor
magnitudeIsFishInAreaVector3         3   a   a   a   b   c   c   c   c   c   d   d   d   e   e   e   e   c   h   i   i   i   i   i   j   l   m   m   m   m   o   o   o   o   o   p   p   p   r   r   r   r   s   s   t   t   t   t   t   t   w   x      self    3   
buildTran    3   fishingAreaObj   3   pointPosList   3   (for index)      (for limit)      (for step)      i	      childTransform      count   3   randomIndex   3   	pointPos   3   dir   3   
magnitude   3   
randomLen"   3   
randomPos%   3   inFishingArea)   3      _ENV z   �    
)   F @ �@@ ��@��   ���� A�@ A@ �@A�  � $��Ad� G�� ��� � � A@ �@AA � $��FA@ G���A �� d�� @��@ ��   �� ��@ � B @��� ��A� & �    Vector3MathfRandom       
               normalizedxz��������                )   {   {   {   {   {   {   {   {   {   {   {   {   {   {   {   {   |   }                  �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    )   
targetDir   )   dirX   )   dirZ   )   randomDelta   )   xOrz   )      _ENV �   �       G @ @� � �L�@ d@  �G @ �� @ �L A d@ L@A d@ & �    _fishState       CheckMoveToIdle       CheckIdleToMoveMove           �   �   �   �   �   �   �   �   �   �   �   �   �   �      self            �   �    )   F @ L@� d� L�� d� ��@ ��� � A  ��@�
���� B 
���ƀB ���C ACGC G��䀀
���
@ �ƀB ����C ACG�C G��䀀�B �BGD GA��D ��A$��
���
 �GE 
@��& �    GameGlobalGetInstanceGetCurrentTime_moveStartTime	_moveLen_fishState       _speed_idleSpeed	_idleLenMathfRandom_idleTimeRange       _idleStartTime_idleChangeDirLenRange_idleChangeDirInternalRange_changeDirLen_changeDirInternal_changeDirRange_idleChangeDirRange         )   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    )   currentTime   )   	curDelta   )   idleChangeDirLen   (   idleChangeDirInternal$   (      _ENV �   �    )   F @ L@� d� L�� d� ��@ ��� � A  ��@�
���� B 
���ƀB ���C �AGC GA�䀀
���
@ �ƀB ����C �AG�C GA�䀀�B �BGD G���D �AC$��
���
 �GE 
@��& �    GameGlobalGetInstanceGetCurrentTime_idleStartTime	_idleLen_fishState       _speed_moveSpeed	_moveLenMathfRandom_moveTimeRange       _moveStartTime_moveChangeDirLenRange_moveChangeDirInternalRange_changeDirLen_changeDirInternal_changeDirRange_moveChangeDirRange         )   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    )   currentTime   )   	curDelta   )   moveChangeDirLen   (   moveChangeDirInternal$   (      _ENV �   �    J   G @ b   � �L@@ d@ @ �L�@ d@ G�@ G � �@A ǀA �� ��A � ��@��� M�� ��B  � G�B �� �@   
�� C �@ A� ��@�
����@A ǀ�AA �CFD GA��� �� d�����D �A�B A� 䁀 ���@ �̀�  ���E @��B � $� BC
 ��
 F��F �F$� G$� 
 ������@ �@ ���@ �G �GGAA $� � ��& �     _changingDirDoChangeDirRandomMoveDir_transform	position_dir_speedUnityEngineTime
deltaTimeIsFishInArea_fishingAreaPointList_buildCenternormalizedxzMathfRandom��������
       �                     Vector3 _lastChangeDirTimeGameGlobalGetInstanceGetCurrentTime	rotationQuaternionLookRotation         J   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    J   nextPos   J   inFishingArea   J   dirX    @   dirZ"   @   randomDelta'   @   delta(   @   xOrz-   @      _ENV �   
   ,   F @ G@� ��@ ��@d� ��@ � A�@A � G�� �� � �� ǀ@ � �AA A� ��� �� $� � �� ABL�B � �@ �B@ d����B  �G�@ G��� ���bA  @ ��  @ ��� � �  � & �    GameObjectHelper&FindFirstSkinedMeshRenderBoundsExtent_transformgameObject	positionVector3        yx�������?FishRayCastforward         ,   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                             	  	  
     self    ,   meshExtents   ,   rightOrigin   ,   leftOrigin   ,   	distance   ,   rightCastRes   ,   leftCastRes#   ,      _ENV         @ A@A�  $� ��FA GA�G���� �   @�� d� ��@ ��  ����  ��& �    
LayerMaskNameToLayerScene       UnityEnginePhysicsRaycast                                                           self       origin       forward       	distance       layMask      castRes      hitInfo         _ENV   6   1   F @ L@� d� L�� d� ��@ ��� � A  ��@	�
@���@A ǀ�AA �AFB GA���B ��BǁB ��d���B �AC����  ��  �R���B �AB�� � ��� ��@ ��@�  �AƁD  �A� � � ���
���
@E�
@ �& �    GameGlobalGetInstanceGetCurrentTime_lastChangeDirTime_changeDirInternal_dirxzMathfRandom_changeDirRange              Abs                     �?_targetDirVector3normalized_changingDir_changeDirStartTime         1                               !  !  #  #  #  #  #  #  #  $  $  $  $  $  $  %  (  (  (  (  (  )  )  +  +  .  0  0  0  0  0  0  0  2  4  6     self    1   currentTime   1   	curDelta   1   dirX   0   dirZ   0   delataValue   0   xOrz"   0      _ENV 8  C      F @ G@� ��@ ��@ d��  � @ �
���& � ��A � B�� �@B�� ǀB �� @ �BG�@ ��@ �C ���$� 
 �& �    Vector3Angle_dir_targetDir{�G�z�?_changingDir GameGlobalGetInstanceGetCurrentTime_changeDirStartTimeSlerp_changeDirLen            9  9  9  9  9  :  :  ;  <  ?  ?  ?  ?  ?  @  @  A  A  A  A  A  A  A  B  C     self       dotVal      currentTime      	curDelta      dirRes         _ENV E  P      
@@�
@@�G�@ b   � �G�@ L � d@ 
@��G@A b   ��F�A G�� d�� L � �@A d@�
@��& � 	   _go _transform_reqDispose_timerHandlerGameGlobalTimerCancelEvent            F  G  H  H  H  I  I  I  K  L  L  L  M  M  M  M  M  M  N  P     self          _ENV R  ]      � � A  ����   �  G�@N�� (��BA��$��\�M���Aʀ�'���  & �    FindFishingArea        childCount       	GetChild	position           T  T  T  V  W  W  W  W  W  X  X  X  Y  Y  Y  Y  W  \  ]  	   self       
buildTran       fishingAreaObj      	areaNode      (for index)      (for limit)      (for step)      i	      childTransform           `  �   D   �    AA  � �A  h��G�B@ �  ��B  ǂ�����@ AAC � ��   $C���G�� !@� ���G�� ` � ���G��   �� ���G�� a@  �C  � "   �G���� ���������������������M����  @  ��@�g��PA� �� �C  f @ �C� f & � 
                   Logfatalnext index : i:zx                D   a  b  d  d  d  d  e  f  g  g  h  k  l  l  m  m  m  m  m  m  m  p  p  p  p  p  p  p  p  q  q  q  q  q  q  q  q  q  q  s  s  u  u  u  u  u  u  u  u  u  u  u  u  u  v  v  v  w  d  |  |  |  }  }  }      �     self    D   fishPos    D   areaPointList    D   	crossNum   D   areaPointCount   D   (for index)   ;   (for limit)   ;   (for step)   ;   i   :   v1   :   
nextIndex   :   v2   :   underZ'   :   intersectX6   :      _ENV1                        ^      `   x   `   z   �   z   �   �   �   �   �   �   �   �   �   �   �   �   �   
  �           6    8  C  8  E  P  E  R  ]  R  `  �  `  �         _ENV