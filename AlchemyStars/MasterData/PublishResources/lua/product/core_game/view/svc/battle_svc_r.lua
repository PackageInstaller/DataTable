LuaS �

xV           (w@E@../PublishResources/lua/product/core_game/view/svc/battle_svc_r.lua         �    @ A@  $@  @ A�  $@ � F A G@� 
�� F A G�� 
 � F A G@� 
�� F A G�� 
 � F A G@� 
�� F A G�� 
 � F A G@� 
�� F A G�� 
 � F A G@� 
�� F A G�� 
 � F A G@� 
�� F A G�� 
�� F A G � 
@� F A G�� 
�� F A G � 
 �  ��@H A�  ��@ $@��H A� � I $@��H  ���H l   
@���H l@  
@ ��H l�  
@���H l�  
@ ��H l  
@���H l@ 
@ ��H l� 
@���H l� 
@ ��H l  
@���H l@ 
@ ��H l� 
@���H l� 
@ ��H l  
@���H l@ 
@ ��H l� 
@���H l� 
@ ��H l  
@���H l@ 
@ ��H l� 
@���H l� 
@ ��H l  
@���H l@ 
@ ��H l� 
@���H l� 
@ ��H l  
@���H l@ 
@ ��H l� 
@���H l� 
@ ��H l  
@���H l@ 
@ �& � C   requirebase_service*battle_ui_active_skill_cannot_cast_reason ActiveSkillCannotCastReasonText$BattleUIActiveSkillCannotCastReason	NotReady#str_match_cannot_cast_skill_reason	SanValuestr_battle_skill_not_useable_4SanByScopeGridCountsstr_battle_skill_not_useable_5DecreaseHPPercentAsSanstr_battle_skill_not_useable_6HPValPercentstr_battle_skill_not_useable_7SanNotFullstr_battle_skill_not_useable_8CardNotFullstr_battle_skill_not_useable_9CardNotEnough str_battle_skill_not_useable_10CardTarPetHasBuff str_battle_skill_not_useable_11NotUnlockByBuffLayer str_battle_skill_not_useable_12NotUnlockByAurora str_battle_skill_not_useable_13NotEnoughFeatureStepPointNotEnoughRound"str_battle_skill_not_enough_roundSanMaxLimit str_battle_skill_not_useable_14SanMinLimit_enum_classRenderBattleServiceBaseServiceConstructorHideUIPetInfoShowUIPetInfoPlayAnimationStopAnimation!ClearChainSkillPreviewRenderDataSetComboNumGetComboNumChangeTeamLeaderRenderGridPos2HudWorldPosGridRenderPos2HudWorldPosRenderChangeTeamLeaderNotifyUIBattleGameOverPlaySnipeEffectAnimationPlayAnimationByGameObjectDisableTeamOrderChangeViewEnableTeamOrderChangeViewTryPopNextChangeTeamOrderView%GetCurrentChangeTeamOrderViewRequestRequestUIChangeTeamOrderViewCalcHPBarPosCalcSkinnedMeshPosFindFirstSkinedMeshRenderCalcGridHUDWorldPosGetMeshRendererInChildrenGetH3dRenderSettingDefaultEnvColorSetGlobalOutLineSetAllViewOutLineSetActorOutLine           (       
@@�
�@��   
� ��   
���& �    
_comboNum        _sendGameOver _firstSkinedMeshRenders_childMeshRenderers               !   %   %   '   '   (      self       world            *   5       � @ �@ �@@ � � �@ �@�@��  !@A �ƀA ���䀀 � �FAB G���� �@ � C�@@  � �@  ��@C ǀ�� �@ & �    DisableTeamOrderChangeViewYIELDBattleConstRefreshPetInfoTick        
       GameGlobalEventDispatcher	DispatchGameEventTypeShowPetInfo��������       Logdebug[refresh] HidePetInfo end             +   +   -   -   -   -   -   .   /   /   0   0   0   0   0   0   0   0   1   2   2   2   2   4   4   4   4   5      self       TT       delay         _ENV 7   @       � @ � � A@ �@�@���  ! A ��@A ǀ�䀀 ���FB GA��� �@ ��B� @  � �@  �� C �@ & �    YIELDBattleConstRefreshPetInfoTick        
       GameGlobalEventDispatcher	DispatchGameEventTypeShowPetInfo�������?       EnableTeamOrderChangeView            8   8   8   8   8   9   :   :   ;   ;   ;   ;   ;   ;   ;   ;   <   =   =   =   =   ?   ?   @      self       TT       delay         _ENV D   h    <   b    �� � � �    �� � � �@�ǀ����A �AA ǁ�� $�  "A   �F�A G��A �� �A �B$� dA  & � LCd� !@�  �& � �C  �& � � !@C  �& � �  ��� ��D � �@��BD@ �CA ��D��D�B ��  *��� ���C�E@ �A�& �    ViewViewWrapperGameObjectGetComponentInChildrentypeofUnityEngine
AnimationLogfatal!Can not find animation componentTrace:
tracebackGetClipCount                ipairsPlayQueued
QueueModeCompleteOthersPlay         <   E   E   E   E   E   E   G   G   G   G   J   J   J   J   J   J   K   K   L   L   L   L   L   L   L   L   M   Q   Q   R   R   S   V   V   W   Z   Z   Z   [   ^   ^   ^   _   _   _   _   `   `   `   `   `   `   _   _   a   d   e   e   e   h      self    <   entity    <   	animList    <   gridGameObj
   ;   u3dAnimCmpt   ;   
clipCount   ;   (for generator)-   6   (for state)-   6   (for control)-   6   _.   4   v.   4   curAnim8   ;      _ENV j   }    #   b   ��� � �� �   ��� � �� �@@��@��@FA �AA ��Ad �  �@   ��A BAA �� ��A ����� $A  & � �$� !@C  �& � L��dA & �    ViewViewWrapperGameObjectGetComponentInChildrentypeofUnityEngine
AnimationLogfatal!Can not find animation componentTrace:
tracebackGetClipCount        Stop         #   k   k   k   k   k   k   m   m   m   m   p   p   p   p   p   p   q   q   r   r   r   r   r   r   r   r   s   w   w   x   x   y   {   {   }      self    #   entity    #   gridGameObj
   "   u3dAnimCmpt   "   
clipCount   "      _ENV    �    R   G @ L@� d� ��� �� ��@� �$� "A    �& � G@ LA��� d����A � � ��  ����A   � �@ B��$��LD�� �B �B
dD �  j���  *��@ �C@ BC�@���ƁC �C$ � @���$� L�@d� ���C �  j���@ �A�� ́�� ��$� LEdB LBEd� ��A ���� ��@ ̃�@ �C���  *C���E�B & �    _worldGetRenderBoardEntityPreviewChainSkillRangeGetChainSkillRangeOutlineDicGetChainSkillOutlineEntityDicGetServiceEntityPoolpairsGetEntityByIDDestroyCacheEntityEntityConfigIDRenderSkillRangeOutline	GetGroupBW_WEMatchersipairsGetEntities ClearChainSkillOutlineEntityDicPlayerGetLocalTeamEntityGetTeamLeaderPetEntityStopCurePreAnimGetSnipeEffectListDestroyEntityClearPreviewChainSkill         R   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   !   self    R   reBoard   R   previewChainSkillRangeCmpt   R   chainSkillRangeDic   R   chainSkillOutLineEntityDic	   R   entityPoolService   R   (for generator)   '   (for state)   '   (for control)   '   _   %   lineEntityList   %   (for generator)   %   (for state)   %   (for control)   %   _   #   	entityId   #   entity   #   previewChainSkillGroup-   R   (for generator)1   :   (for state)1   :   (for control)1   :   _2   8   entity2   8   previewChainSkillRangeCmpt4   8   chainSkillRangeDic6   8   teamEntity?   R   teamLeaderEntityA   R   effectListE   R   (for generator)H   O   (for state)H   O   (for control)H   O   kI   M   effectEntityI   M      _ENV �   �       
@ �& �    
_comboNum           �   �      self       	comboNum            �   �       G @ f  & �    
_comboNum           �   �   �      self            �   �       & �                �      self       TT       teamEntity            �   �       � @ �@@�  �����@@� 䀀A ��%�&  & �    _worldGetServiceBoardRenderGridPos2RenderPosGridRenderPos2HudWorldPos           �   �   �   �   �   �   �   �   �   �   �   �      self       gridPos       boardRenderSvc      gridRenderPos           �   �       � @ �@@�� ��@�� ��@@� 䀀@ A@$� A$� LAA��d��f & �    _worldMainCameraCameraWorldToScreenPoint
HUDCameraScreenToWorldPoint           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       gridRenderPos       camera      
screenPos      
hudCamera      hudWorldPos           �   �    
   � @ �@�� ̀�@� 䀀@ A@$� �@� $��L���� dA�L�@�  dA�G@ L��A d����� �C� �A & �    _worldPlayerGetPetEntityByPetPstIDSetViewVisibleGetServiceRenderEntitySetTeamLeaderRender           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       newPetPstID       oldPetPstID       
petEntity      teamLeaderEntity      renderEntityService           �   �       � @ �     �& � 
@@���@ ��@�� � AAA �A@� �@ & �    _sendGameOver_worldEventDispatcher	DispatchGameEventTypeOnGameOver            �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       battleResult          _ENV �   �       � @ �@  @��   
� �� @ A@ �@��@� @ A@ A�@A� @ A@ �A��A� @ A@ B�@B̀B @� �� �@ ǁ��A� �@ & �    _snipeEffectList
PieceTypeBlueeff_ingame_locking_1Redeff_ingame_locking_2Greeneff_ingame_locking_3Yelloweff_ingame_locking_4PlayAnimation            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       entity       element          _ENV �      2   � � FA@ ��@ ��@d �  �@   �A AAA� �� �A ���� $A  & � A�$� !�B  �& � �B  �& � \ !��  �& � \  @� �FAC � d@���� �F�@ G��G��B i�  ���� �GC�A� ��A�& �    GetComponentInChildrentypeofUnityEngine
AnimationLogfatal!Can not find animation componentTrace:
tracebackGetClipCount                ipairsPlayQueued
QueueModeCompleteOthersPlay         2   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                 	  	  	  
  
  
  
              
  
                 self    2   go    2   	animList    2   u3dAnimCmpt   2   
clipCount   2   (for generator)#   ,   (for state)#   ,   (for control)#   ,   _$   *   v$   *   curAnim.   1      _ENV         G @ L@� d� L�� � � d@�& �    _worldRenderBattleStatSetChangeTeamOrderViewDisabled                            self              D   <   F @ G@� ��  d@ G�@ L � d� �@�   �@���� �� �  �� �� @ �@� �@ & � �@� � �     �& � �B"A    �& � F�B G�d�� �AC ��C�C$� @��D �BD���ƁD   �@�@ C@A� ��� $C  �  j���A� �A ́� @ �A���E �A & �    Loginfo6[RenderBattleService] enabling change team order view_worldRenderBattleStatSetChangeTeamOrderViewDisabledGetChangeTeamOrderViewQueue        >[RenderBattleService] change team order view queue is empty. GetCurrentTeamOrderRequest       BattleStatHelperGetLogicCurrentLocalTeamOrderBattleTeamOrderViewRequestNewGetOldTeamOrderBattleTeamOrderViewTypeShuffleTeamOrderipairsK[RenderBattleService] change team order view merged, dropping request seq GetRequestSequenceNoClearChangeTeamOrderViewQueueAddChangeTeamOrderViewRequestTryPopNextChangeTeamOrderView         <                             "  "  "  #  #  #  #  $  '  '  (  (  *  .  /  /  0  3  3  3  5  5  6  6  7  8  9  5  <  <  <  <  =  =  =  =  =  =  <  <  @  @  A  A  A  C  C  D     self    <   renderStat   <   
viewQueue   <   currentRequest   <   firstRequest   <   currentTeamOrder    <   
mergedReq(   <   (for generator)+   4   (for state)+   4   (for control)+   4   _,   2   req,   2      _ENV F  X   "   G @ L@� d� ��� �� �    ���@ � A�@ �@ & � ��� �� �    ���@ � A�� �@ & � � � �� �   ���@B ǀ�䀀 ���FC GA�� �@ & �    _worldRenderBattleStatIsChangeTeamOrderViewDisabledLoginfoU[InnerGameHelperRender] change team order view disabled, skip popping next request. GetCurrentTeamOrderRequest@[InnerGameHelperRender] there is already a presenting request. "PopFirstTeamOrderRequestAsCurrentGameGlobalEventDispatcher	DispatchGameEventTypeCallUIChangeTeamOrderView         "   H  H  H  J  J  J  J  K  K  K  K  L  O  O  O  O  P  P  P  P  Q  T  T  U  U  V  V  V  V  V  V  V  V  X     self    "   renderStat   "   current   "      _ENV Z  ^      G @ L@� d� ��� �  �   & �    _worldRenderBattleStatGetCurrentTeamOrderRequest           \  \  \  ]  ]  ]  ^     self       renderStat           a  i      � @ �@@�� ̀@@� �@���@� �     �& � � A �@ & �    _worldRenderBattleStatAddChangeTeamOrderViewRequestGetCurrentTeamOrderRequestTryPopNextChangeTeamOrderView           c  c  c  d  d  d  e  e  e  e  f  h  h  i     self       request       renderStat           k  v   
   � � AA  䀀�   @���G�@G�����AA @ 䁀@�f  ��A �� � % &  & �    
FindChildHPPosgameObject
transform	positionCalcGridHUDWorldPosCalcSkinnedMeshPos           l  l  l  m  m  n  o  o  p  q  q  q  q  r  r  t  t  t  t  t  v     self       viewWrapper       
hp_offset       hpPosTransform      	hpPosObj      owner_entity_render_pos      hpPosition	           y  �   3   � �   LA� ��  d��b  @ ���  �� �A�AA́A @ ���_����G�GB�M���B �B �B�BAC �� ͂�C ��$���  �LBC ��d��b  @��� �C @ 䂀��@���C ��C� C�A� �B � & �    GameObject
FindChildRootgameObject
transform	positionFindFirstSkinedMeshRender Vector3        x       CalcGridHUDWorldPosGetMeshRendererInChildrenLogfatal	ownerObjnamehas no skinned mesh and mesh         3   z  {  |  |  |  }  }  ~  ~  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    3   viewWrapper    3   
hp_offset    3   	ownerObj   3   rootObj   3   rootTransform   3   owner_entity_render_pos   3   skinnedMeshRender   3   meshExtents   3   skinnedMeshPosition      convertExtents      
targetPos      meshRenderer#   1   meshPosition&   *      _ENV �  �      � @ �@ �@  @��@@ ��@� � �� �@@ ��� � � @ K � ��kA 
A� � @ �@ � AAA� �& �    _firstSkinedMeshRendersGameObjectHelperFindFirstSkinedMeshRender&FindFirstSkinedMeshRenderBoundsExtent                          �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       go       skinnedMeshRender      meshExtents      v         _ENV �  �      � @ �@@�� ��@�� � @ �@�� ���� A AA@ ���� �A �AF�A G���A �BBƂA ǂ�$� & & �    _worldMainCameraCamera
HUDCameraGameObjectHelperCalcGridHUDWorldPosBattleConstHUDEdgeLeftHUDEdgeRightHUDEdgeDownHUDEdgeUpper            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       gridRenderPos       camera      
hudCamera
      hudWorldPos         _ENV �  �      � @ �@ �@  ��� @ �@� F�@ ��@ �Ad �  ��� � @ �@ �  & �    _childMeshRenderersGetComponentInChildrentypeofUnityEngineMeshRenderer            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       go       v         _ENV �  �   
   F @ G@� G�� ��  d� � � A ����  & �    UnityEngineGameObjectFind[H3DRenderSetting]GetComponentH3DRenderSetting         
   �  �  �  �  �  �  �  �  �  �     self    
   goRenderSetting   
   csRenderSetting   
      _ENV �  �      F @ G@� G�� ��  � A A AA �A �A � �d@  & �    UnityEngineShaderSetGlobalColor_H3D_EnvColorColor                   �  �  �  �  �  �  �  �  �  �  �  �     self          _ENV �  �      b   � ��   �@    ��@  ƀ@ ���� �A @ �@�& �                   UnityEngineShaderSetGlobalFloat_fightCameraOutline            �  �  �  �  �  �  �  �  �  �  �  �  �     self       state       value         _ENV �  �      G @ L@� � @ ǀ����d��� A � � � @��AA� �  @�́A L�@d� L��d �A  ��  *��& �    _worldGetGroupEntitiesBW_WEMatchersViewipairsHasViewSetActorOutLineGetGameObject            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       viewEntities      (for generator)	      (for state)	      (for control)	      i
      entity
         _ENV �  �   3   � @ �@@�� ��@�� �@    �& � ��� A FAA G��$ ��  ��A � � ��  �AABAA ��ǁ G��G��NB��B (�����G�BG�@� �L�C�� d�� ����DD A� �C �D� A �C '�����& �    _worldRenderBattleStatIsActorOutLineGetComponentsInChildrentypeofUnityEngineSkinnedMeshRendererLength               
materialsshadernameH3D/Actor/Common	GetFloat_OutlineStencilTemp	SetFloat_StencilID       _StencilComp                3   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    3   go    3   skinnedmeshRenderers   3   (for index)   2   (for limit)   2   (for step)   2   i   1   mesh   1   (for index)   1   (for limit)   1   (for step)   1   j   0   	material   0   value&   0      _ENV�                        	   	   	   
   
   
                                                                                                                                                            (      *   5   *   7   @   7   D   h   D   j   }   j      �      �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �           D    F  X  F  Z  ^  Z  a  i  a  k  v  k  y  �  y  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �         _ENV