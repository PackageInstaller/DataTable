LuaS �

xV           (w@_@../PublishResources/lua/product/core_game/logic/svc/buff_logic_handler/buff_logic_addbuff.lua         %    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ � @ A@ ��@ $@�@B  ��@B l� 
@��@B l� 
@ �& � 
   _classBuffLogicAddBuffBuffLogicBaseConstructor_DoSingleAddBuffRandomBuffIDDoLogic_GetTargetEntities%_GetTargetEntitiesFromNotifyDefenderBuffLogicRemoveBuff        	       6   �@@
� ���@�@  @ �� A �@�
� ���A�@    ��  
� �ǀB�@    ��   
���� C�@    ��  
���ǀC
���� D�@  @ ��@D ǀ�
���� E
���ǀE_��  ��@  � � 
����@F
� ���F
� ��@G
� ���G
� ��@H�@    ��  
� �
� �& � #   _buffIDbuffID_targetTypetargetTypeBuffTargetTypeSelf_targetParamtargetParam        _layerName
layerName_lightlight_saveDataNamesaveDataName_addBuffTypeaddTimesTypeSkillAddBuffTypeDefault_buffCountParamaddTimesParam_useNotifyBuffIDuseNotifyBuffID       _transmitAttacktransmitAttack_getFinalAtkisTransmitFinalAtk_transmitDefencetransmitDefence_getFinalDefenceisTransmitFinalDefense_ownerAsBuffSourceownerAsBuffSource_logicParam         6   
   
                                                                                                                                                                  self    6   buffInstance    6   logicParam    6      _ENV "   1    /   �@ �A@�A@ �@���@ �  @���@ �A�A B@ �A� ���@ ��A�A B@ �A���A �BBB �BG�BL�d ��  �A  �AB �A�̂� GC@ ���   � �  @��C���� ��� $C  ��& �    _buffInstance_buffIDEDITORLog
exception/Buff自己加自己循环了，请修改 Buff:fatalBuffSourceNewBuffSourceTypeBuffcasterEntityGetID       AddBuffAddBuffDataBuffSeq         /   #   #   #   #   #   $   $   $   %   %   %   %   %   %   '   '   '   '   '   *   *   *   *   *   *   *   *   +   +   +   +   ,   ,   ,   ,   ,   ,   -   -   .   .   .   .   .   .   +   1      self    /   buffSvc    /   result    /   target    /   context    /   times    /   buffSource   /   (for index)   .   (for limit)   .   (for step)   .   t   -   ins%   -      _ENV 3   O    -   K   �   �@@ �@ �@� ���� BA �A@� ��  ��������$B��  j��ǀB ���� ��A $��L�C�   d� �  ��C  � ���C��!��� ���
 �& � �  j��& �            pairs_targetParamrandomBuffIDs       tableinsertID       Weight_buffInstanceWorldGetServiceRandomLogic
LogicRandipairs_buffID         -   4   5   6   6   6   6   6   7   7   8   8   9   9   ;   ;   <   <   8   6   6   B   B   B   D   D   D   E   E   E   E   G   H   H   H   H   I   I   J   J   K   K   L   H   H   O      self    -   randomBuffIDs   -   totalWeight   -   (for generator)      (for state)      (for control)      _      value      world   -   
randomSvc   -   random   -   
curWeight   -   (for generator)"   ,   (for state)"   ,   (for control)"   ,   _#   *   	buffInfo#   *      _ENV Q   �    =  � @ �@@�� ��@G�@ 䀀
� �� A �    ��@A �� � ����� B �@��B A� �C �A �� $ �@  ̀� � 
� �ǀ@ �C �C �@ �� D �@ ǀ@ �C AD ���ǀD �    �ƀC ���
� ��@E �E �E��D $��  �@    ��  
� ��@F ̀�� @ �F$� LG�A d����G  �@ �� �����G   � � G�@ ��C �CH����GE  � ��B ��HǃB � �C��G	 ����CI� �I �IRD�$�    �L��CJ �J @ ����   d�  �G�J b   �LK d� �C��� ��K� ����L �   ��C�� �C�� ��̃�� ���A � �C GCM b   �LK d� �C��� ��K� �����M �   ��C�� ��� ��̃�� ���AD � �C G@ L��d� b  @�G@ L��d� G��bC    �@ �O �  � ��O  H  �@ �CO  �@����D  �D��  �C��  j�́�� �  ������P $B�B� "  ���� "  �����B� � $B  ���� � $B  B� "  ��B� $� "  � �L��� dB��@ F�C G��@@�B� $� L�� d� ���  �B��� ��B�� $� FBR G��@ ��� $� L�� dB�� $� FBR GB�@�� � L����S� dB  L��BT� dB  G�T�@�C � ��b   ��� $� FBR G�@ �B� $� L�� dB�� $� FBR G��@ � � L���V� dB  GBV L��d� ����� ��@ �B�B� "  ��B� $� "  � ����B� � $B  �� "  ���� $� "  � ����� � $B  �  & � a   _buffInstanceWorld_targetTypeReplaceBuffTarget_useNotifyBuffIDtype
GetBuffID	functionLoginfo_className!useNotifyBuffID=1, formerBuffID=_buffIDnewBuffID=BuffTargetTypeSkillTargetRandomBuffRandomBuffIDRandomMonsterByLayer_layerNameRandomMonster_targetParam	tonumber_buffComponentGetBuffValue        BuffResultAddBuffNewEntityGetService
BuffLogic_GetTargetEntitiesipairs       SelfLayerComboModX
exception4SelfLayerComboModX: Non-zero targetParam required. BattleGetLogicComboNummathmodfCalcAddTimesByParam_addBuffType_buffCountParam_transmitAttack
GetEntityAttributesGetAttributeAttack_getFinalAtk
GetAttackBuffComponentSetBuffValueGuestAttack_transmitDefenceDefense_getFinalDefenceGetDefenceGuestDefenceContextcasterEntity_ownerAsBuffSource_DoSingleAddBuffGetBuffArray	SetLight_lightGetAttackPosGetTargetPosSetAttackPosSetTargetPosGetRandHalfDamageIndexSetRandHalfDamageIndexSkillTargetXScopeTypeGetNotifyTypeNotifyTypeTeamLeaderEachMoveEndGetPosSetWalkPosNotifyLayerChangeSetNotifyLayerChange_EntityGetNotifyEntity SetNotifyLayerChange_TotalLayerGetTotalCount__oldFinalLayer	__buffIDEntityMoveEnd
GetPosNewAutoBeadSkillEachAttackEndSetAutoBeadSkillIndexGetAutoBeadSkillIndex_worldBattleStatGetLevelTotalRoundCountSetLevelTotalRoundCountGetNormalAttackIndexSetNormalAttackIndexGetSkillIDSetSkillID         =  S   S   S   U   U   U   U   W   W   W   W   W   W   W   W   X   X   X   X   X   X   X   X   X   Y   Y   Y   ]   ]   ]   ]   ]   ^   ^   a   a   a   a   a   a   a   a   b   b   b   c   c   c   c   c   c   c   c   c   c   f   f   f   g   g   g   i   i   i   k   k   k   k   k   l   l   l   l   m   n   n   n   n   n   q   r   r   s   s   s   s   s   v   v   v   w   w   x   x   x   x   x   x   z   z   z   z   z   z   z   z   z   }   }   }   ~   ~   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   l   l   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    =  notify    =  world   =  result:   =  owner=   =  buffSvc@   =  esE   =  (for generator)H   �   (for state)H   �   (for control)H   �   _I   �   eI   �   timesJ   �   xP   a   
battlesvcZ   a   	comboNum\   a   casterEntityp   �   actualAttacku   �   casterEntity�   �   actualDefense�   �   caster�   �   arr�   =  randHalfDamageIndex�   �   
attackPos�   �   
targetPos�   �   walkPos�   �   nt�     walkPos    nt  %  battleStatCmpt   %  round"  %     _ENV �   j   �    G@ �A@ ��@��� �\ M��
�� g�G@ �A@ �A����FAA G��� ��A @���dA  �c�G@ �A@ �B����L�A ��d���AA ��A� BA BB@�$ �A  �_�G@ �A@ ��B��@�L��d� ���� �A�� ��@\�ƁC ����GDB� ��@Z�ƁC ���B�GBDB� ��@X�� ���B�$� 
��V�G@ �A@ ��D��@�\ M������� 
�� T�G@ �A@ �E����GA�b   R�LA�d� ��E ���� �� ��F �AF ����@ � ��@
A N�G@ �A@ ��F��@�L��d� _ ��K�L��d� �A��� �  �  \ ��  (B ����'��G G�G L��BH d�$�  "B    �� GF L���	 d��  � E��� ��@D��B��  \��� ǂ�F CF��$��\ M��
�FCA G����� dC��@��@?�G@ �A@ ��I��@�L�A ��d����G �HJ ����  �;��  �� ;��AJ  ����CA �J@ ���� $�  "  � � �@
��  j���6�G@ �A@ �K����FAA G��� ��A @���dA  @3�G@ �A@ �AK��� �\ M��
�� 1�G@ �A@ ��K��� �\ M��
���.�G@ �A@ ��K�� �GL �  b   ���E  �� @�� ��A��    ��A��  �  � �   �  ��� F �L�F ��L�M$��LBMd� ��  ���  ����C�̃M� �  @���M� _��  �D  � "D  ���  @�L�d� b  @�LD�d� L��d� L��d� ���� �DJ   	�����$� L��d� @@ �� @ ��  jE�"  ���   �LMd� LD�d� �DA ��J	�  �����  ���DA ��O	�   �D� �FDA G��� � dD����@�G@ �A@ ��O�� �@��  b  �����  ����� F BF��$��"  ��LBPd� b  � �L�Pd�  �LNd� b    �� �  ��� ���
���
�G@ �A@ ��P�� �GF L��F ����A�d���AJ �����̂Q� �B  ���BQ� ��$� FCA G���L � d��b   �FCA G��� � dC���  *B�@�L� �@ L @ d�� �& & � I   _targetTypeBuffTargetTypeSelf       SkillTargettableappendArray%_GetTargetEntitiesFromNotifyDefenderSkillTargetNoRepeatIDuniqueSkillTargetXScopeTypeGetAttackPosGetTargetPosGetDefenderEntitymathabsxyNotifyTargetGetNotifyEntityTheOneLastHitMeGetDamageSrcEntitynumbertype_worldGetEntityByIDSkillTargetRandomByLayerGetScopeResult GetTargetIDs	tonumber_buffComponentGetBuffValue_layerName        GetServiceRandomLogic
LogicRandremoveAlreadySelectData_saveDataNameipairs
icontainsGetID	DefenderSelfLayerComboModXSkillTargetRandomBuffMyTrap_targetParamtrapIDs	GetGroupBW_WEMatchersTrapGetEntitiesHasSummonerGetSummonerEntityHasPetPetGetOwnerTeamEntityTeamGetTeamPetEntities
GetTrapIDinsertPetHpChangeSourcePetGetDamageSrcEntityIDHasSuperEntityGetSuperEntitySpCampTypeMonsterGetGroupEntities
MonsterIDHasDeadMarkGetCampTypeCalcBuffTargetEntities         �  �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                                    	  	  	  	  
  
  
  
  
                                                                                                                                                         !  #  #  #  #  #  #  $  $  %  %  %  %  &  '  '  '  '  (  (  )  )  )  )  0  0  0  0  0  0  0  0  1  1  1  1  1  1  2  2  3  3  3  3  4  4  4  4  4  4  5  5  3  3  :  :  ;  ;  <  <  <  <  =  =  =  =  =  =  =  >  >  >  >  >  ?  A  A  A  A  A  %  E  F  F  F  F  F  H  I  J  J  J  J  J  K  K  L  L  L  L  M  M  N  N  N  N  O  O  O  Q  Q  Q  Q  R  V  V  W  W  W  X  Y  Y  Y  Y  Y  Z  Z  Z  Z  Z  Z  [  [  [  [  \  \  \  \  ^  ^  _  _  `  `  `  `  `  `  `  a  a  a  a  a  [  [  d  f  f  f  f  f  f  i  j  <   self    �  buffSvc    �  owner    �  notify    �  es   �  targetFromNotify   '   
attackPos/   J   
targetPos1   J   damageSrcEntity`   m   scopeResulty   �   tmp{   �   
targetIDs|   �   (for index)   �   (for limit)   �   (for step)   �   i�   �   count�   �   
randomSvc�   �   index�   �   	targetID�   �   targetEntity�   �   
defenders�   �   
targetIDs�   �   (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   e�   �   buffTargetParam�   T  tarTrapIdList�   T  checkTrapId�   T  g
  T  	listTrap  T  (for index)  T  (for limit)  T  (for step)  T  i  S  trapEntity  S  summonerEntity  S  isOwner  S  cTeam)  9  petEntities+  9  (for generator).  9  (for state).  9  (for control).  9  _/  7  e/  7  trapIDA  M  nt[  z  targetEntity\  z  tarEntityIDc  u  sourceEntityg  u  MonsterEntityArray�  �  (for generator)�  �  (for state)�  �  (for control)�  �  k�  �  monsterEntity�  �  monsterIDCmpt�  �  	campType�  �     _ENV l  z      �   � � �   ��� � � A@ @�$��G�@ L��� d��� �A�@)�  ������@� �    ��  � �A� $� � ��  & �    GetDefenderEntityIDListipairs_worldGetEntityByID       GetDefenderEntity            m  o  o  o  p  p  q  q  q  q  r  r  r  r  s  s  s  q  q  t  u  u  u  v  v  v  v  v  y  z  
   self       notify       es      eids      (for generator)	      (for state)	      (for control)	      _
      eid
      e         _ENV �  �      �@@
� ���@
� ��@A
� �ǀ� 
� �� B�@    ��@ 
���& � 
   _buffEffectTypeListbuffEffectTypeList_targetTypetargetType_targetParamtargetParam_entity_blackblack                   �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       buffInstance       logicParam            �  �   �   � @ �@@�� � @ ̀�� ��� $��K  �AA ƁA ����� ����BJ� ���AA ƁA �A�� ���� �  ����� �� ��B   ���C CC��$��\�M�J��  j������� �   ����Bǁ� J������B��� � J� ��AA ƁA ���@��A� �  ����D ��D��B� $ �A  @��AA ƁA �������� �  ����� �� ��B   ���C CC��$��\�M�J��  j��@��EBA GBE � ���@ ��E ��E�� ��B  �� ��B GF $��LD�d� b  �����  F�F L��
d ��  �GLE�d� � 	�D )�  ����  j�b   @�ǁ� �  ��́� � �  � ��G��$B�b    ��� � BH �H_ �@��� � BH �H � ��� � BI��$B�b   ���� � BH �I � ���� � BI��$B��� � BH J �@��AJL�� d� LB�d �A  ́JL�� d �A  �KLB� d �A  ́KL�� d �A  �� � BH L �� ��ALL�� d �A  ��LGM �A�� & � 5   _buffInstanceEntityWorldGetService
BuffLogic_targetTypeBuffTargetTypeSelf       SkillTargetGetDefenderEntityIDListipairs_worldGetEntityByID
_defenderGetNotifyEntity	DefenderGetDefenderEntitytableinsertCalcBuffTargetEntities_targetParamBuffResultRemoveBuffNew_buffEffectTypeListBuffComponentRemoveBuffByEffectTypeNTBuffUnloadAddRemovedInfoGetIDGetRandHalfDamageIndexSetRandHalfDamageIndexGetNotifyTypeNotifyTypeTeamLeaderEachMoveEndTeamLeaderEachMoveStartGetPosSetWalkPosEntityMoveEnd
GetPosNewChainSkillAttackEndSetNotifyEntityIDSetNotifyChainSkillIdGetChainSkillIdSetNotifyChainSkillTimeIndexGetChainSkillTimeIndexSetNotifyChainSkillStageIndexGetChainSkillStageIndexAutoBeadSkillEachEndSetAutoBeadSkillIndexGetAutoBeadSkillIndex	SetBlack_black         �   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  $   self    �   notify    �   owner   �   w   �   buffSvc	   �   es
   �   eids   *   (for generator)    *   (for state)    *   (for control)    *   _!   (   id!   (   	defender%   (   eidsR   _   (for generator)U   _   (for state)U   _   (for control)U   _   _V   ]   eidV   ]   eZ   ]   resulti   �   (for generator)l   �   (for state)l   �   (for control)l   �   im   �   em   �   (for generator)p   �   (for state)p   �   (for control)p   �   _q   �   buffEffectTypeq   �   buffComponents   �   tSeqID{   �   randHalfDamageIndex�   �   walkPos�   �   walkPos�   �      _ENV%                     	      	   "   1   "   3   O   3   Q   �   Q   �   j  �   l  z  l  }  }  }  }  ~  ~  �  �  �  �  �  �  �         _ENV