LuaS �

xV           (w@f@../PublishResources/lua/product/core_game/view/svc/instruction/play_board_bind_effect_anim_ins_r.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@��& �    requirebase_ins_r_class#PlayBoardBindEffectAnimInstructionBaseInstructionConstructorDoInstruction_PlayAnimation                  � � ƀ@ ���  A 䀀
���ƀA �� "A    � � 
���& � 	   
animNames_animNamesstringsplit|
_effectID	tonumber	effectID                       	   	   	   	   	   	   
   
   
   
   
   
   
         self       
paramList       str         _ENV    '    2   @ @@ ��@ �@A $A & � AA$� L�Ad� �  ��A �  ����A  �� ��A�� ����A $��"  @�F�B � d���C �����CC ǃ�  @ �C�i�  �B���B   �� ��C ��$C��  j��& �    _animNames Logfatal Legacy animation params is nil!GetOwnerWorldGetRenderBoardEntity
_effectID        EffectHolderGetEffectEntityIDByEffectIDipairsGetEntityByIDtableinsert_PlayAnimation         2                                                                                                                           $   $   $   $   %   %   %   $   $   '      self    2   TT    2   casterEntity    2   phaseContext    2   world
   2   boardEntity   2   entityList   2   casterEffectHolderCmpt   (   effectEntityIDList   (   (for generator)   (   (for state)   (   (for control)   (   _   &   effectEntityID   &   effectEntity!   &   (for generator)+   1   (for state)+   1   (for control)+   1   _,   /   e,   /      _ENV *   =    /   � � �� �@    �& � �@� �� ��@�� ��@FA �AA ��Ad �  ��@�B ABA� ��B$A�& � C ACG�C $�   �� ��$A � G�C \��� (� �B���C ��$B�'��� �����C ��C$A�& �    HasViewViewGetGameObjectGetComponentInChildrentypeofUnityEngine
Animation Logfatal4Cant play legacy animation, animation not found in nametablecount_animNames       StopPlayQueuedPlay         /   +   +   +   +   ,   .   .   .   .   0   0   0   0   0   0   1   1   2   2   2   2   2   3   5   5   5   5   5   5   6   6   7   7   7   7   7   8   8   8   8   7   9   ;   ;   ;   ;   =      self    /   entity    /   go	   /   anim   /   (for index)#   )   (for limit)#   )   (for step)#   )   i$   (      _ENV                                          '      *   =   *   =          _ENV