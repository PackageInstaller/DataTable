LuaS �

xV           (w@v@../PublishResources/lua/product/core_game/logic/svc/buff_logic_handler/buff_logic_add_layer_by_damage_of_team_hp.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ �& �    requirebuff_logic_base_class"BuffLogicAddLayerByDamageOfTeamHpBuffLogicBaseConstructorDoLogic        
          �@@�@  � �ǀ@ ���� 
� ��@A�@    ��� 
� �� B�@    ��@ 
���& � 
   _layerType
layerType_buffInstanceGetBuffEffectType
_mulValue	mulValue       
_addValue	addValue                                                                            self       buffInstance       logicParam               7    K   � � �@    �& � � � �� !@@  �& � ǀ@ ���� � �� �@ AA�� $��L�A��d��ǁ@ ��� B BB_ � �ǁ@ ��F�B G��䁀B C � ��AC ́�� ��$� � �$� @ ҁBD �DG�D RB�$� GE B@@  �& � G�@ LB��B d�����CC G�E � �F CF� ̃��   $��& & �    
GetDamage        _worldPlayerGetCurrentTeamEntityGetServiceCalcDamageGetTeamLogicHP
MatchTypeMT_MazeGetMatchTypeTypeSeasonMazeWorldBossMT_SeasonMaze_entityAttributes
CalcMaxHpGetCurrentHPmathceil
_mulValue
_addValue
BuffLogicAddBuffLayer_layerType#BuffResultAddLayerByDamageOfTeamHpNewBuffSeq         K                                                                  "   "   "   "   "   "   "   "   "   "   "   "   "   "   "   "   $   $   $   %   %   %   &   &   &   )   +   +   +   +   +   +   +   -   -   .   2   2   2   2   3   3   3   3   3   5   5   5   5   5   5   5   6   7      self    K   notify    K   damage   K   teamEntity   K   calcDamageService   K   curHp   K   maxHp   K   	attrCmpt(   .   losePercent/   K   	addLayer6   K   svc=   K   curMarkLayerB   K   	buffinstB   K   buffResultI   K      _ENV                              
      
      7      7          _ENV