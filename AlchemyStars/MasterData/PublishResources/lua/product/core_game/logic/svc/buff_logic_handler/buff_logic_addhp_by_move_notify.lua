LuaS �

xV           (w@l@../PublishResources/lua/product/core_game/logic/svc/buff_logic_handler/buff_logic_addhp_by_move_notify.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��& �    _classBuffLogicAddHPByMoveNotifyBuffLogicBaseConstructorDoLogic_CalcMoveLength                  �@@�@    ���  
� �� A�@    ���  
���ǀA_��  ��@  � � 
����@B�@    ��� 
� ���B�@    ���  
� �& �    
_mulValue	mulValue        
_addValue	addValue	_headOutheadout       
_baseType	baseType_delaydelay           	   	   	   	   	   
   
   
   
   
                                                         self       buffInstance       logicParam               {    �   � @ �@@�� b   @�̀� � �@ A_ � �̀� � �@ AA_ �� �& �   �& � ̀� � �@ A ���̀� � �@ �A_ �@��@ B_ �@��@ AB_ �@��@ �B_ �@��@ �B_ �@��@ C �  �  �& � �@C @� 䀀!��  �& � �C$� LDd� �AD�� �  ����D �D���AD�� �E�� �AE ́�@ 䁀��$� @  ���D  F���AD�� �E�� �AE ́�@ 䁀B�$� @ @���D �F� ���F�� @ �AD�� �   ��G�� �AG�� �  ��C�� ��G�� !�C  �& � ��C� ���A 䁀�    �& � ���C$� �G�B $��"B    �� A� ��H �����H M�O��O���BI ��I���� @ ��I �J�BE �B�A�
 䂀�J K��� $� LC�̃K�   d� �CE ��K�� �LDL �K$� G@ L��d �C  �CE ��K�� ��LGDL L��d� �D �DM���M��DL ̄�	� ����DL ̄�	� �Ą��D����ǄH �����H �Ą��� ��C �CE ���� ���GDL L��d �C  �P ��@ �DP ǄP 䃀�� $� L�� dD�� & � E   _buffInstanceEntityGetNotifyTypeNotifyTypeEntityMoveEndPlayerEachMoveEndGetParentNotifyTypeHitBackEnd	TeleportDimensionTransportTractionEndTransportEachMoveEndForceMovement_CalcMoveLength        Attributes
CalcMaxHp	PetPstID
_baseType       	GetPstID_worldGetPetDataGetPetHealth       GetPetAttack       
GetAttackPetGetOwnerTeamEntityGetCurrentHPGetAttributeBuffForbidCureAddBloodRate
_mulValue
_addValue       mathfloorDamageTypeRecoverGetServiceCalcDamageDamageInfoNewAddTargetHPGetIDGetMatchLogger
BeginBuff_entityBuffIDAddBloodLogkeyCalcAddBlooddesc�BUFF加血 攻击者[attacker] 被击者[defender] 加血量[blood] 回血系数[rate] 回血比例[mulValue] 回血加值[addValue] 距离[moveLength]	attacker	defenderbloodrate	mulValue	addValuemoveLengthEndBuffBuffResultAddHPByMoveNotify	_headOut_delay
GetPosNew
SetPosNew         �                                                                                                                               !   !   !   !   "   "   "   "   #   #   #   #   $   &   +   +   +   ,   ,   -   1   1   2   2   5   5   5   5   6   6   6   7   7   7   7   9   9   9   9   :   :   :   :   ;   ;   ;   <   <   <   <   >   >   >   >   ?   ?   ?   ?   @   @   @   A   A   A   F   F   F   F   G   G   G   G   G   J   J   J   J   K   K   L   P   P   P   P   P   P   P   Q   T   U   U   U   U   U   U   U   U   X   Y   Y   Y   Y   Z   [   [   \   \   \   \   \   ^   ^   `   `   `   `   b   b   b   b   b   c   c   c   c   c   e   e   e   e   e   e   e   e   e   e   e   f   f   f   g   h   h   h   h   j   k   l   l   l   l   m   m   m   m   n   o   p   p   q   q   r   g   u   u   u   u   u   u   u   u   w   w   w   w   w   w   x   x   y   y   y   z   {      self    �   notify    �   e   �   parentNotifyType   6   moveLength9   �   	attrCmpt>   �   max_hp@   �   pstIdK   R   petDataO   R   pstIdZ   a   petData^   a   cur_hpu   �   times�   �   rate�   �   
add_value�   �   damageType�   �   svc�   �   damageInfo�   �   curHp�   �   logger�   �   res�   �   posNew�   �      _ENV }   �    <   � @ �@@�  �����  � $� FAA G��@�	��� $� FAA G�_@��FAA GA�_@��FAA G��_@��FAA G��_@��FAA G�_@� �FAA GA�@ �L�� d� ��� �� b  ���   ��D@�� � � ���� $� FAA GA�@  ��� �  & �    _worldGetService	UtilCalc        GetNotifyTypeNotifyTypeEntityMoveEndGetParentNotifyTypeHitBackEnd	TeleportDimensionTransportTractionEndTransportEachMoveEndForceMovement
GetPosNew
GetPosOldGetGridRingNumPlayerEachMoveEnd                <               �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    <   notify    <   utilCalcSvc   <   length   <   parentNotifyType   2   posNew'   2   posOld)   2   ringNum1   2      _ENV                                 {      }   �   }   �          _ENV