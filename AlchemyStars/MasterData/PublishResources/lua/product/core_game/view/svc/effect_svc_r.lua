LuaS �

xV           (w@E@../PublishResources/lua/product/core_game/view/svc/effect_svc_r.lua         g    @ A@  ��@ $@�@@  ��@@ l   
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
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �& � #   _classEffectServiceObjectConstructorInitializeDestroyStaticEffect_DestroyEffectArrayGetEffectHolderCreateEffectEntityCreateEffectCreateBeHitEffectCreateWorldPositionEffect#CreateWorldPositionDirectionEffectCreateTransformEffect!CreateGridEffectWithEffectHolderCreateGridEffectWithBindPosCreateCommonGridEffectCreatePositionEffectCreateUIEffectShowEffectShowIdleEffectShowPermanentEffectShowChainMoveEffectDestroyWeakEffectDestroyEffectIDEntityDicEffectClearEntityEffectDestroyEntityEffectByIDDestroyEffectByIDGetPetShowEffIdByEntityGetMonsterShowEffIdByEntity%CreateScreenEffPointEffectWithHolderCreateScreenEffPointEffectGetEffectResPathCreateMonsterMoveLineEffectsCreateLineEffects                   
@ ���� �  ���
���& �    _world_configServiceGetServiceConfig           
                     self       world                      G@@ L�� ��  d��
@ �& �    _renderEntityService_worldGetServiceRenderEntity                                self               8    G   � � �� �@    �& � �@@� �@ ��$A��@$� L�@ � dA�LAd� ��@  ��A��AA�� ƁA   ����A @�$@�G�A L�� d��_@�� ���A ��B	 ��D�)�  ����  jB���B� �  @��A @�$��FC � d@���A �B	 �����  � ���A ̄�	@ 	�D�i�  ���)�  �B�& �    EffectHolderGetPermanentEffect_DestroyEffectArrayGetIdleEffectGetWeakEffectGetEffectIDEntityDicpairs_worldGetEntityByID DestroyEntityGetDictEffectIdipairs         G                                                        !   !   !   #   #   $   $   $   $   %   %   %   %   &   &   &   &   '   '   (   (   (   (   %   %   $   $   -   -   .   .   /   /   /   /   0   0   0   0   1   1   1   1   2   2   3   3   3   3   0   0   /   /   8      self    G   e    G   cEffectHolder   G   permanentEffectList   G   idleEffectList   G   weakEffectList   G   effectIDEntityDic   G   (for generator)   ,   (for state)   ,   (for control)   ,   _   *   entityIDList   *   (for generator)   *   (for state)   *   (for control)   *   _   (   	entityID   (   effectEntity"   (   dictEffectId.   G   (for generator)3   F   (for state)3   F   (for control)3   F   key4   D   list4   D   (for generator)7   D   (for state)7   D   (for control)7   D   index8   B   id8   B   eEffect<   B      _ENV :   A       � @ � � � @��A@ ́�@ 䁀_��� �B@ A��$B���  *��& �    ipairs_worldGetEntityByID DestroyEntity            ;   ;   ;   ;   <   <   <   <   =   =   >   >   >   >   ;   ;   A      self       effectIDArray       (for generator)      (for state)      (for control)      _      	effectID      effectEntity         _ENV C   I    
   � @ �@@�@ �@  @ ���  �  ��@�  & �    Cfgcfg_effectcasterHolder         
   D   D   D   E   E   F   F   H   H   I      self    
   	effectID    
   effectConfigItem   
      _ENV L   O       G @ L@� ƀ@ ���d��f  & �    _renderEntityServiceCreateRenderEntityEntityConfigIDRenderEffect            M   M   M   M   M   N   O      self       e         _ENV S   �    {     D  �@�� �   ��A@�� ́@A�  䁀�A    ��  �"  @ �G�� ��� _@�  ���ƁA ����A��A  ��B BBA� �� �� B C$� $B    & B�@A �B BBA� �� $B��C $� LD�BD ̂�GC�� � dB  L�D� �GC����dB L�Ed� ��_@A� ��B���B����_@A� �������B����  � ��B���B�����  � �������B��B@�� �B   ��H�B �B@� ���BH@� ��H� �B  b   ��@� �B  @ ��H�B �B@� C��� ̃H� $C  �H�	 � $C & & � %   HasEffectHolderEffectHolderGetEffectListBuffViewShowHidePetRoot        Cfgcfg_effectLogfatal#EffectService CreateEffect failed: 
tracebackResPath$cannot find effect res ,effectID isCreateEffectEntityReplaceAssetNativeUnityPrefabAssetNewAddEffectControllerBindPos	DurationTypeEffectControllerFollowMoveSetFollowMoveFollowRotateSetFollowRotate
BindLayerSetBindLayerFollowRotateCasterSetFollowRotateCasterAddEffectHolderAttachEffectByEffectIDGetIDAttachEffectEffectHolderReplacedByAvatar         {   T   U   V   V   V   V   W   W   X   X   X   X   X   X   Y   Y   Y   Z   [   _   `   `   a   c   c   c   d   d   e   e   e   e   e   e   e   e   e   f   f   i   i   i   j   j   j   j   j   n   n   o   o   o   o   o   o   o   p   q   r   s   u   p   v   v   w   w   w   x   x   x   z   z   z   {   {   {   }   }   }   ~   ~   ~   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    {   	effectID    {   holderEntity    {   state    {   eInitialHolder   {   eAvatar   {   cEffectHolder      	teAvatar      show   {   effectConfigItem   {   effectEntity1   {   effCtrl@   {   effectHolderZ   {   cInitialEffectHolderp   y      _ENV �   �    '   �   ��F@ GA�@���G�@ L��d� �A�� �  @��A�A$� �A$ ��  �  @���A  � @ � �A����B  � @ � �   �LB ��   e f  & � 	   DamageShowTypeGrid_configServiceGetMonsterConfigData
MonsterIDGetMonsterOffSetWithBindPosGetMonsterIDCreateGridEffectWithBindPosCreateEffect         '   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    '   hitEffectID    '   holderEntity    '   damageShowType    '   gridPos    '   monsterConfigData	          _ENV �   �       @ A@A "A  @ �D  f L�@ d� ���A BA��A��$ �A  ���  �A���BB�A�f & � 
   Cfgcfg_effectCreateEffectEntityReplaceAssetNativeUnityPrefabAssetNewResPathSetPosition
AddEffect	Duration            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       	effectID       	grid_pos       isShow       effectConfigItem      effectEntity	         _ENV �   �       @ �� � $� "  � �LA@��dA�& & �    CreateWorldPositionEffectSetDirection           �   �   �   �   �   �   �   �   �   �   �      self       	effectID       	grid_pos       	grid_dir       entity           �   �    	
   L@ ��   d� b  � ��A� ��A�& �    CreateWorldPositionEffectSetDirection        
   �   �   �   �   �   �   �   �   �   �      self    
   	effectID    
   	grid_pos    
   	grid_dir    
   localScale    
   entity   
        �   �    3   @ A@A "A  ��F�@ G��� �� B F�@ G��d� dA  D  f G�A � �F�@ G���A �� dA�L�B d� ���C BC��A$��A  ���  �A������ �A   ����A ���� ���AD@� ���� �A  f & �    Cfgcfg_effectLogfatal;EffectService CreateGridEffectWithBindPos failed EffectID: 
tracebackResPath $cannot find effect res ,effectID isCreateEffectEntityReplaceAssetNativeUnityPrefabAssetNewSetPositionEffectHolderAddEffectHolderAttachEffectByEffectIDGetID         3   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    3   	effectID    3   girdPos    3   monsterEntity    3   effectConfigItem   3   effectEntity   3   effectHolder%   3      _ENV �   C   �   �$� "  �!�A�$� "  � ���$� �@$� L�d� GA���A ��A�� �B@ ��� C�$� CB$ �  �A  ���B �BA � �B  � $B�& � �C �CB "B  ��F�B G��� �� C F�B G��d� dB  D  f G�D � �F�B G���B �� dB�L�E d� ���F CF��D$��B  ����  ����� �G��CGǃG�B @���� �GG�CGǃG�B ����  ������ �BH ̂�A� 䂀�� $��LCI� dC����� ǂI_ �� ���IG�I�B��J_ �� ��BJGJ�B�ǂJ�  � ���JG�J�B��K�  � ��BKGK�B�̂�� �B   ���$C ��$� � ��� �C�� $C  & � 2   HasMonsterID	BodyArea
MonsterIDGetMonsterIDGridLocation	Position_configServiceGetMonsterConfigDataGetMonsterBindPosGetAreaLogfatal+### get monster bindpos failed. monsterID=, effectID=Cfgcfg_effect;EffectService CreateGridEffectWithBindPos failed EffectID: 
tracebackResPath $cannot find effect res ,effectID isCreateEffectEntityReplaceAssetNativeUnityPrefabAssetNewbindPosAddEffectControllerBindPos	DurationTypeuseEffectConfigEffectController_worldGetServiceBoardRenderGridPos2RenderPosSetGirdRenderPosFollowMoveSetFollowMoveFollowRotateSetFollowRotate
BindLayerSetBindLayerFollowRotateCasterSetFollowRotateCasterEffectHolderAddEffectHolderAttachEffectByEffectIDGetID         �   �   �   �   �   �   �   �   �   �   �   �   �                                                        	  	  	  
  
                                                                                   !  #    %  %  %  '  '  )  )  )  )  *  *  *  ,  ,  ,  .  .  /  /  /  0  0  0  2  2  2  3  3  3  5  5  5  6  6  6  8  8  8  9  9  9  <  <  =  =  >  >  ?  ?  ?  A  A  A  A  A  C     self    �   	effectID    �   girdPos    �   monsterEntity    �   
monsterID   �   monsterGridPos   �   monsterConfigData   �   ret   �   effectConfigItem(   �   effectEntity?   �   effectControllerComponentZ   d   boardServiceRender^   d   gridRenderPosa   d   effCtrlf   �   effectHolder�   �      _ENV G  X   %   @ A@��  $��L�@� d���A �A���G���� @ �B �AB�A �A  @ ��  � ́B � ���C �BC�C��$B  ������$B ��BD$B�� & �    _worldGetServiceBoardRenderGridPos2RenderPosVector3xyzCfgcfg_effectCreateEffectEntityReplaceAssetNativeUnityPrefabAssetNewResPathSetLocation
AddEffect	Duration         %   I  I  I  I  J  J  J  L  L  L  L  L  L  N  N  N  O  O  P  P  S  S  T  T  T  T  T  T  U  U  U  U  V  V  V  W  X     self    %   	effectID    %   gridPos    %   gridDir    %   boardServiceRender   %   
renderPos   %   effectConfigItem   %   effectEntity   %      _ENV [  f   
   � @ �@��@��@  @ �  & �@ $� L�@�A �A�G����dA  L�A� dA�LB�A�dA�& & � 
   Cfgcfg_effectCreateEffectEntityReplaceAssetNativeUnityPrefabAssetNewResPathSetPosition
AddEffect	Duration            \  \  \  ]  ]  ^  ^  a  a  b  b  b  b  b  b  c  c  c  d  d  d  e  f     self       	effectID       
renderPos       effectConfigItem      effectEntity	         _ENV k  }   .   @ A@� "A  @ �D  f L�@ d� ���A BA��A$��A  ���B�A��A��� ��B ��A��A��� ��BC GBC$ �A  ��� �� �A   ���� �A ́� � ���D@ �B�� �A  f & �    Cfgcfg_effectCreateEffectEntityReplaceAssetNativeUnityPrefabAssetNewResPath
AddEffect	DurationEffectControllerSetTargetGridPosSetEffectType	tonumberTypeEffectHolderAddEffectHolderAttachEffectByEffectIDGetID         .   l  l  l  m  m  n  n  q  q  r  r  r  r  r  r  s  s  s  t  t  t  t  t  u  u  u  u  u  u  u  v  v  w  w  x  x  y  y  y  {  {  {  {  {  |  }     self    .   casterEntity    .   	effectID    .   girdPos    .   effectConfigItem   .   effectEntity	   .   effectHolder    .      _ENV �  �      b@    �& � � @  � � @�B@ �@��$��"  ��L�@d� b  ���A  �B�� �FBA G���� dB �  j��& �    ipairs_worldGetEntityByIDViewSetViewVisibleLogfatal.Show Effect Error,can not find effect entity!            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  
   self       idleEffectArray       isShow       (for generator)      (for state)      (for control)      _      	effectID      effectEntity      effectViewCmpt         _ENV �  �   
   � � � �    �A@ ����� � $A & �    EffectHolderShowEffectGetIdleEffect        
   �  �  �  �  �  �  �  �  �  �     self    
   targetEntity    
   isShow    
   cEffectHolder   
        �  �   
   � � � �    �A@ ����� � $A & �    EffectHolderShowEffectGetPermanentEffect        
   �  �  �  �  �  �  �  �  �  �     self    
   targetEntity    
   isShow    
   cEffectHolder   
        �  �   G   � � � �@�� ��$� "  @�F�@ G�� d� @�  �& � L�� d� bA   ���� �A ��� �� @ ��B ����A  ��́B G�B�� � �  @��$� LB��B   dB L��B d�����A �    ��C�A   ��A � ��C�A   ��A @� �D � � $B @�BD �D$�� �D�  $B�& �    	MatchPetGetMatchPetGetChainMoveEffecttablecount        EffectHolderAddEffectHolderGetEffectList
ChainMoveCreateEffect	EffectIDGetIDAttachEffect
ShowDelay
HideDelayShowEffectGameGlobalTaskManagerCoreGameStartTask         �  �   
   F @ �   � � d@�E  L@� � � d@ & �    YIELDShowEffect          
   �  �  �  �  �  �  �  �  �  �     TT    
      _ENVdelayselfeffectListshowG   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  
   self    G   
petEntity    G   show    G   petData   G   chainMoveEffect   G   cEffectHolder   G   effectList   G   
effEntity!   -   effEntityId%   -   delay.   G      _ENV �  �      � � �� @@  �& � ̀@� �@ @�$@�GA LB�� d��_@�� ��A ��A ��B�)�  ���& �    EffectHolder GetWeakEffectipairs_worldGetEntityByIDDestroyEntity            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  
   self       targetEntity       effectHolderCmpt      weakEffectArray      (for generator)
      (for state)
      (for control)
      _      	effectID      effectEntity         _ENV �  �      b@    �& � � � �� @@  �& � ̀@� �@ @�$� �LA � dB�)�  ���AA$A & �    EffectHolder GetEffectIDEntityDicpairs_DestroyEffectArrayClearEffectIDEntityDic            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  	   self       targetEntity       effectHolderCmpt      effDict
      (for generator)      (for state)      (for control)      k      v         _ENV �     L   b@  @�� @ �@@ǀ@ �  �@�& � � � �� @A@�� @ ǀ��@ A� �@�& � � B� AB ��$A��B$A �B$� LAB � dA�LCdA LACd� ��C ���� ��BB @ �B���  *����C�A �D�� ƁC   �� �CB ��$C��  j���AD�A ́D� BB ��$B��D$B � $� "  @�@ BEA� $B �� $B & �    Logerror_className, ClearEntityEffect: requires entity param. EffectHolder warnB ClearEntityEffect: no EffectHolderComponent on provided entity. GetIdleEffect_DestroyEffectArrayClearIdleEffectListGetWeakEffectClearWeakEffectListGetEffectIDEntityDicpairsClearEffectIDEntityDicGetDictEffectIdClearDictEffectIDGetBindEffectIDArrayClearBindEffectIDEffectLineRendererinfo$MonsterDeadRemoveEffectLineRendererRemoveEffectLineRenderer         L   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                                    	  	  	  	  
  
  
  	  	                                                                       self    L   targetEntity    L   
cFxHolder
   L   tIdleFx   L   tWeakFx   L   tFxDict"   L   (for generator)%   +   (for state)%   +   (for control)%   +   k&   )   v&   )   dicFx/   L   (for generator)2   8   (for state)2   8   (for control)2   8   _3   6   t3   6   tBindFx<   L      _ENV   8   %   �   @ �b@    �& � � � � @�  �& � ��$�  ��  �& � K  ��@ � ��  A@ �@   �J�����A � �@�ǂ�  � ��A ��$C���  *��& �    EffectHolder GetEffectIDEntityDictypetable       pairs_DestroyEffectArray         %               !  $  $  %  %  &  (  (  )  )  *  ,  -  -  -  -  -  .  .  0  2  2  2  2  3  4  4  5  5  5  2  2  8     self    %   targetEntity    %   
nEffectID    %   effectHolderCmpt   %   effDict   %   listWorkID   %   (for generator)   $   (for state)   $   (for control)   $   _   "   nID   "   entityList   "      _ENV ;  C      �   � @  � � @�@ �� �   ��@ ���@ @ � ��   & �    typetable       _DestroyEffectArray            <  =  =  =  =  =  >  >  @  B  B  B  B  C     self       
nEffectID       listWorkID         _ENV E  G      � @ �@@�@ �  & �    GameResourceConstPetAppearEff            F  F  F  F  G     self       elementType          _ENV I  V      �     �& � � $� A@$�   �  �& � ! �� �F�@ G�G��f F�@ GA�G��f & �    	BodyAreaGetAreaCount       GameResourceConstMonsterAppearEffMultiBodyAreaMonsterAppearEffSingleBodyArea            J  J  K  N  N  N  N  O  O  P  R  R  S  S  S  S  U  U  U  U  V     self       e       elementType       isBoss       count         _ENV Y  h   #   � @ �@��@��@  @ �  & �@$� "A   �L�@dA L�@d�  �LA d� �A��A �A��$��A  �A���G���A �C � LB�d �A  f & �    Cfgcfg_effectEffectHolderAddEffectHolderCreateEffectEntityReplaceAssetNativeUnityPrefabAssetNewResPathAddEffectTypeType	DurationAttachEffectByEffectIDGetID         #   Z  Z  Z  [  [  \  \  ^  ^  _  _  `  `  a  a  a  c  c  d  d  d  d  d  d  e  e  e  e  f  f  f  f  f  g  h     self    #   	effectID    #   holderEntity    #   effectConfigItem   #   cEffectHolder	   #   effectEntity   #      _ENV k  t   	   � @ �@@�@ �@  @ ��   �  ̀@ � ���A �AA�A��$A  ���B�AB$A �  & � 
   Cfgcfg_effectCreateEffectEntityReplaceAssetNativeUnityPrefabAssetNewResPathAddEffectTypeType	Duration            l  l  l  m  m  n  n  p  p  q  q  q  q  q  q  r  r  r  r  s  t     self       	effectID       effectConfigItem      effectEntity	         _ENV v  }   
   � @ �@@�@ �@  @ ��   �  ǀ@�  & �    Cfgcfg_effectResPath         
   w  w  w  x  x  y  y  |  |  }     self    
   	effectID    
   cfgItem   
      _ENV   �   #n   �$� "B   �LB�dB L�d�  �L�@�� dB�L��d� bB   ����B ����� @ �BA � �@�ǃA ���@ 䃀DG�A L��� d������ �DB	��B	��B	��� �D�	Ǆ�	���	C EC
@ 	��$��FC GE�
��	��d��"  ����C   @��� ���LDd �E  �B� �  �	�B$� FD$� D  ��D�D FE GG�$� C� �� @ �� ����� ����G��  � ��GF̇�C� �G������F  @ 
��
� 	 �LDd �F  �G  C� �F ��  *��& �    EffectLineRendererAddEffectLineRendererSetIgnoreEntityViewRootPosEffectHolderAddEffectHolderipairs_worldGetEntityByIDViewViewWrapperGameObject
transformGameObjectHelper
FindChildCreateEffectAttachPermanentEffectGetIDGetGameObjectGetComponentsInChildrentypeofUnityEngineLineRenderer        Length       gameObject
SetActiveInitEffectLineRendererSetEffectLineRendererShow         n   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    n   TT    n   	effectID    n   holderEntity    n   startEntities    n   
startBone    n   endEntities    n   endBone    n   effectLineRenderCmpt   n   effectHolderCmpt   n   (for generator)   m   (for state)   m   (for control)   m   i   k   	entityID   k   entity   k   targetEntityID   k   targetEntity"   k   entityViewRoot'   k   targetEntityViewRoot,   k   curRoot1   k   endRoot6   k   effect<   k   effViewB   k   goH   k   
renderersI   k   (for index)U   ^   (for limit)U   ^   (for step)U   ^   iV   ]   lineW   ]      _ENV �  �  	 !�   F@ GB������ ��@�A�BA� d��bB    �& � ��A �������A� B$� "   ��@$� �@ADAF@ GD�� � d��b   ��C   ��DB�D ��A�� � 	��B�� �D   ���B�D ̄B� ��	�C	� Ǆ�	  �   �GEC L��
���	d�� �
"E   �LD �   d�  �
LED	̅D
� dE  L�@
d� b  ����@
�� ��D�� �  E�FE ƆE ����� �� $� �  GF�N���� (��ǆ"  � �G�FL���� dG�'�������� �� �@ ��̇D
� $F  F������ �� $F "  � ���� $F��  � �����$F���  *��& �     GameObjectHelper
FindChildViewViewWrapperGameObject
transformipairsEffectLineRendererIsViewVisibleAddEffectLineRendererEffectHolderAddEffectHolderGetEffectIDEntityDic_worldGetEntityByID       CreateEffectAttachPermanentEffectGetIDGetGameObjectGetComponentsInChildrentypeofUnityEngineLineRenderer        LengthgameObject
SetActiveInitEffectLineRendererSetEffectLineRendererShowSetCurrentRootOffSetTargetRootOff         �   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    �   TT    �   	effectID    �   holderEntity    �   holderBone    �   startEntitys    �   
startBone    �   holderPosOff    �   startPosOff    �   targetRoot	   �   (for generator)   �   (for state)   �   (for control)   �   i      entity      effectLineRenderer      entityViewRoot      curRoot       effectHolderCmpt+      effectEntityIdList5      effect6      effViewJ      goP      
renderersQ      (for index)]   f   (for limit)]   f   (for step)]   f   i^   e   line_   e      _ENVg                                          8      :   A   :   C   I   C   L   O   L   S   �   S   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   C  �   G  X  G  [  f  [  k  }  k  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �    �    8    ;  C  ;  E  G  E  I  V  I  Y  h  Y  k  t  k  v  }  v    �    �  �  �  �         _ENV