LuaS �

xV           (w@]@../PublishResources/lua/product/core_game/logic/svc/buff_logic_handler/buff_logic_addhp.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��& �    _classBuffLogicAddHPBuffLogicBaseConstructorDoLogic
DoOverlap        	          �@@�@    ���  
� �� A�@    ���  
���ǀA�@    ��� 
����@B�@    ���  
� ���B�@    ���  
� ��@C�@    ���  
� �& �    
_mulValue	mulValue        
_addValue	addValue
_baseType	baseType       _singlePet
singlePet_ignoreForbidCureignoreForbidCure_restoreToMaxHPPercentrestoreToMaxHPPercent           
   
   
   
   
                                                                                    self       buffInstance       logicParam               �    �  � @ �@@�� ̀@� ��$� L�d� !@�  �& � ��A ��A�� �  ���B @B����A ��A�� ��B�� ��B ��@ 䁀B�$�   � �B ��@ ��A� ��B ��  ����D� �A  � ��AD� �    �& � ́@� ́�A� 䁀�A    ��A B FE GB���E  ���� ���E ��B����E ���F ���E !��� ��F !���@ ������F ��F� ��   �G �BG�� �A �G$� A � �C   A� ��E ��  ��B�! ���
���B �I�� �BI�A �G$� G@ L��d �B  ��B �I�� ��IG�A L��d� � �CJ���J�ǃA ���� ���ǃA ���� �Ã����Á���E ����F �Ã��B ��B ��� ̂�G�A L��d �B  �B �  �B��L @A 	��  �M� �  @ ��  ��BM� �   �̂M� ���� ��  �����   �̂@� ̂�A 䂀�  @ �& � ��̂@� ̂�A 䂀�    �& �  @A� ��E GBN ��B ��N� ����O �B�@ ��� ����O $C�E CE ���  LCMd� b   �L�Md� L��d�  �LP��G�  �dC @��B I$� LCP��G� �G$ dC  L�P�   @�dC�L�P��G� dC  �B �N� $��LCQ� d����� ��C���Q �CO ����b   ���� � DR �R � ���� � �   ��B �N� $��LDS��d������� ��S   	�@��$� FFT G��@� ��T�� $F�@ ��  j��U�D� � $D  �U��� � $D  V�D� �� ��G	� $D  �V��� �� ��G	� $D  �� � DR W � ��C� � �W��$D��W�� � $D  �� � DR DX_ �@��� � DR �X � ��C� � �W��$D��W�� � $D  �� � DR �X ����� � �W��$D�D� $� �G$� L�W� dD��� � DR �Y � ��C� � �   ���$� L�W� dD�� & � g   _buffInstanceEntityAttributes
CalcMaxHpGetCurrentHP        _entity	PetPstID
_baseType       	GetPstID_worldGetPetDataGetPetHealth              HasDeadMarkHasPetDeadMarkGetAttributeAddBloodRateDamageTypeRecover_restoreToMaxHPPercent
_mulValue
_addValue       mathfloorLogdebugBuffLogicAddHP TargetID=GetIDadd_value= baseValue= mulValue= AddBloodRate=GetMatchLogger
BeginBuffBuffIDAddBloodLogkeyCalcAddBlooddesc�BUFF加血 攻击者[attacker] 被击者[defender] 加血量[blood] 回血系数[rate] 回血比例[mulValue] 回血加值[addValue]	attacker	defenderbloodrate	mulValue	addValueEndBuff_ignoreForbidCureHasTeamHasPetPetGetOwnerTeamEntityBuffForbidCureRealGetServiceCalcDamageDamageInfoNewSetSinglePet_singlePetAddTargetHPBeginDamageLog_DoDamageModifyHPEndDamageLog
BuffLogicGetHPShieldSetHPShieldBuffResultAddHPGetNotifyTypeNotifyTypeMonsterBeHitGetSkillIDConfigGetSkillConfigDataGetSkillEffectipairsGetEffectTypeSkillEffectType	TeleportSetMatchPassSetNotifyAttackerPosGetAttackPosSetNotifyDefenderPosGetTargetPosSetNotifyAttackerIDGetAttackerEntitySetNotifyDefenderIDGetDefenderEntityTeamEachMoveEndGetPosSetNotifyPosSetNotifyEntityIDGetEntityIDTeamLeaderEachMoveEndTeamLeaderEachMoveStartMonsterMoveOneFinishGetWalkPosGetNotifyEntityMonsterDead         �                                                                 !   !   !   !   !   #   #   #   #   $   $   $   '   (   (   (   )   )   *   *   *   +   .   .   .   .   .   .   .   .   /   2   2   2   2   2   2   2   2   3   4   4   5   5   5   7   7   7   7   9   9   9   9   ;   ;   ;   ;   ;   ;   <   <   ?   ?   ?   ?   ?   A   A   B   B   B   B   C   D   E   F   G   H   I   K   A   L   L   M   M   M   M   M   M   M   M   M   M   M   N   N   N   O   P   P   P   P   R   S   T   T   T   T   U   U   U   U   V   W   X   X   Y   Y   O   \   \   \   \   \   \   \   \   b   b   b   c   f   f   f   h   i   i   i   i   j   j   k   k   k   k   l   l   l   l   l   o   o   p   p   p   p   p   p   p   p   p   q   q   r   r   r   r   r   r   r   s   x   x   y   y   z   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   $   self    �  notify    �  e   �  	attrCmpt   �  max_hp   �  cur_hp	   �  pstId       petData       
baseValue!   �  rate;   �  
add_value<   �  damageType>   �  loggeru   �   teamEntity�   �   calcDamage�   �  damageInfo�   �  addHPTargetEntity�   �   logger�   �   buffLogicService�   �  curHPShield�   �  result  �  skillID  =  configService  )  skillConfigData  )  cfgEffectArray  )  (for generator)  )  (for state)  )  (for control)  )  index  '  cfgEffectParam  '  
notifyPosE  L  
notifyPosZ  a  
notifyPosi  s  monsterEntityIDp  s  monsterEntity{  �  monsterEntityID  �     _ENV �   �       � @ �  �   & �    DoLogic           �   �   �   �      self       logicParam                                	      	      �      �   �   �   �          _ENV