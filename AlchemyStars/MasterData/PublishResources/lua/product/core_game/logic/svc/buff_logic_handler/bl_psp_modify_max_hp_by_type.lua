LuaS �

xV           (w@i@../PublishResources/lua/product/core_game/logic/svc/buff_logic_handler/bl_psp_modify_max_hp_by_type.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �& �    _classBuffLogicPSPModifyMaxHPByTypeBuffLogicBaseConstructorDoLogic                  �@@�@    ���  
� �� A
���ǀA�@    ��� 
����@B�@    ���  
� �& � 
   
_mulValue	mulValue        _modifyTypemodifyType	_displaydisplay       
_notAddHP	notAddHP                                                                    self       buffInstance       logicParam               F    s   � @ �@@� �   @�ǀ@ ���FA GA�䀀�@ �A_ � ���A� � �� � ��@B� ̀�� AB$� �B$� �@    �& � LABd� L��d�  �  �& � G�@ LA��� d�����D ����A    �& � ǁ@ �A�AB 䁀@ LBBd� L���� d���E �BEǂE �ς������ �F �B�@ �� ��F � �  ����CG�� � �F $ $�  LCBd� L��d� �E �CE�À���À����� ƃG ���@ �H �DH	� �H _�H ���DG�� ��$D DI �G�DG�� ��  G�I ��H $��& & � '   _entityHasPetPstID_world
MatchTypeGetMatchTypeTypeSeasonMazeWorldBossMT_SeasonMazePetGetOwnerTeamEntityAttributesGetCurrentHP
CalcMaxHp        GetServiceBattleGetCountByModifyType_modifyTypeCalcDamageGetAttributeMaxHPmathfloor
_mulValue      �?_buffLogicServiceGetModifyValueByIDMaxHPConstantFixGetBuffSeqAddTargetMaxHPGetIDDamageInfoNewDamageTypeRecover
_notAddHP       AddTargetHPBuffResultAddHPMax_displayDamage         s                                                                                                                     !   $   $   $   $   %   %   %   &   &   '   *   *   *   *   -   /   /   /   /   /   1   1   1   1   1   1   1   4   4   4   4   4   4   4   5   8   8   8   8   8   8   8   ;   ;   ;   ;   =   =   =   =   =   =   =   @   @   @   @   @   @   A   A   A   B   B   B   B   B   D   D   D   D   D   D   D   D   D   E   F      self    s   notify    s   entity   s   curHp   s   	curMaxHP   s   
battleSvc)   s   count,   s   
damageSvc3   s   attributeEntity4   s   
baseMaxHP9   s   	addValue@   s   curModifyValG   s   retO   s   	newMaxHPS   s   	addRedHPZ   s   damageInfo`   s   buffResultq   s      _ENV               	   	               F      F          _ENV