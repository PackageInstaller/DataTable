LuaS �

xV           (w@j@../PublishResources/lua/product/core_game/logic/svc/buff_logic_handler/buff_logic_increase_add_blood.lua         $   �  
���
 ��
���  ��A A  �@B $@� B   � B l   
@ � B l@  
@�� B l�  
@ ��A A@ �@B $@�@C  ��@C l�  
@ �@C l  
@ �@C l@ 
@ �& �    AddBloodRateValueTypeConfigValue       BleedMonster       
BuffLayer       _classBuffLogicSetIncreaseAddBloodBuffLogicBaseConstructorDoLogic
DoOverlapBuffLogicResetIncreaseAddBloodDoLogic                  �@@�@    ���  
� �� A�@  @ ��@A ǀ�
���� B
���& � 	   
_mulValue	mulValue        	_valTypevalTypeAddBloodRateValueTypeConfigValue_specificModifyIDspecificModifyID                                                         self       buffInstance       logicParam          _ENV    0    [   G @ L@� d� ��� �� �    ���� �� � A�� @  �@ ǀA �A B �@ ��@B  �ǀA �A �B �����B � �G�B GA�G��䀀�C L�d $ @�LBDd� L����D ��d��b  @ �GBB �@)�  �����ǀA �A AE �����B ̀�A� 䀀��AF �@ ́�� � $A���AF �@ ́�� $�  GAB � �� @ �@�� �G "  � ��G G�G $� �  � $� AH�� �  �$A�& � #   _buffInstanceEntity	PetPstIDPetGetOwnerTeamEntity        	_valTypeAddBloodRateValueTypeConfigValue
_mulValueBleedMonster_world	GetGroupBW_WEMatchers
MonsterIDipairsGetEntitiesBuffComponentHasBuffEffectBuffEffectTypeBleed
BuffLayerGetService
BuffLogicAddBuffLayer_entityGetBuffEffectType       GetBuffLayerBuffSeq_specificModifyID	tonumberAttributesModifyAddBloodRate         [                                                                                                                                               !   !         #   $   $   $   $   $   &   &   &   &   '   '   '   '   '   '   '   (   (   (   (   (   (   )   )   +   +   +   ,   ,   ,   -   -   -   -   /   /   /   /   /   /   /   0      self    [   e   [   	mulValue   [   group   0   (for generator)#   0   (for state)#   0   (for control)#   0   i$   .   e$   .   svc:   I   layerG   I   	modifyIDL   [      _ENV 2   4       � @ �  �   & �    DoLogic           3   3   3   4      self       logicParam            :   <       �@@
� �& �    _specificModifyIDspecificModifyID           ;   ;   <      self       buffInstance       logicParam            >   L    	'   G @ L@� d� ��� �� �    ���� �� � A�� @  � @ �@A�� ǀA �   � ���A �A � � �� � � �@�A� � �@ ��B � �AA 䀀����C �@ ��� $A  & �    _buffInstanceEntity	PetPstIDPetGetOwnerTeamEntityBuffSeq_specificModifyID	tonumberAttributesRemoveModifyAddBloodRate_worldGetService
BuffLogicClearBuffLayer_entityGetBuffEffectType         '   ?   ?   ?   @   @   @   @   A   A   A   A   A   C   C   C   D   D   D   E   E   E   E   G   G   G   G   G   G   J   J   J   J   K   K   K   K   K   K   L      self    '   e   '   	modifyID   '   svc    '      _ENV N   O       & �                O      self           $                                                0      2   4   2   7   7   7   7   8   8   :   <   :   >   L   >   N   O   N   O          _ENV