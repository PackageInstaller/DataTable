LuaS �

xV           (w@^@../PublishResources/lua/product/core_game/view/svc/instruction/play_trap_as_moving_ins_r.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@���@ l�  
@ �& � 	   requirebase_ins_r_classPlayTrapAsMovingInstructionBaseInstructionConstructorGetCacheResourceDoInstruction
_ShowTrap               5   �@@ ǀ� �� 
� ��@@ � � �� 
����@@ ǀ� �� �@    ��� 
���� B � @ �@    ���@ A �@��@@ ��� �� 
� ��@� 
� ��@@ ��� �� 
� ��@� 
� ��@@ ��� �� 
� ��@@ �@� �� 
� ���� 
� ��@@ �@� �� 
� ��@@ ��� �� 
� �& �    _time	tonumbertime_speedspeed_stageIndexstageIndex       assert-PlayTrapAsMoving指令需要配置time参数_summonOffsetsummonOffset	_moveAnimoveAni_moveEffID
moveEffID	_jumpAnijumpAni_jumpEffID
jumpEffID
_jumpTime	jumpTime	_fallAnifallAni_fallEffID
fallEffID
_fallTime	fallTime         5                           	   	   	   	   	   	   	   
   
   
   
   
   
   
                                                                                                   self    5   
paramList    5      _ENV    #    9   K   � @ �   ��� @  �������@ ��@� �  FA GA��@ G��G���� +A �@�� B �   ��� B  �������@ ��@� �  FA GA��B G��G���� +A �@��@B �   ���@B  �������@ ��@� �  FA GA��AB G��G���� +A �@�f  & � 
   _moveEffID        tableinsertCfgcfg_effectResPath       _jumpEffID_fallEffID         9                                                                                                                                                                                    "   #      self    9   t   9      _ENV (   �    �   @$� LA@d� L��d� ���A BAG�A �� ���FA G����A � ���A �BǂA $� LBB�� d����B �C��B ��CC$� L�Cd� �  �  ������ D �����CD� ��̃D� ��D  �& � E�D�$��� �E �� �   @ $D �E @� $D ���   ���� ���C�� ��̃�� E��$��� ���C$� @ ��"  @�̃F� E��$��� DC$� � � �C    �& � �  �& � ��B ��� �@ 䃀G GDG b  � �GDG RD���L�Gd� b  � �F�E �� dD ��LH�� EH �D� dD�G�H b  ��G�H _��� �L��ǄH   dD F�E �� �I dD�LH�� EI �D� dD�G�I b  ��G�I _��� �L��ǄI   dD LDB��	 d����  ����DJ@ ��� 	�D���G� �  � ���E  � �D ���HK� ��J kE� �D���J �  ����J _��	� ����G�J � �D ��E  � GK �D��D�� �K$� "    ���	L�K��	 �dE "  @�LEB� d���E�
 � K� � kF� �F �E��  @�LEB�� d����L �M�� �E�
@� � �E & � 6   GetOwnerWorldSkillRoutineGetResultContainerGetEffectResultByArraySkillEffectTypeSummonTrap_stageIndex	MoveTrapDestroyTrapGetServiceEffectVector2zeroGetRenderGridPositionGetRenderGridDirectionSetNormalize_summonOffsetGetPosGetTrapIDList        GetEntityByID       
_ShowTrapYIELD
GetPosOld
GetPosNewGetEntityID	Distance_speed_time�      HasGridMoveSetAnimatorControllerTriggers	_jumpAni_jumpEffIDCreateEffect
_jumpTime	_moveAni_moveEffIDBoardRenderGetRealEntityGridPosAddGridMove	_fallAni_fallEffID
_fallTimeCloneGetGridOffsetSetLocationTrapRenderPlayTrapDieSkill	PlayBuffNTMoveTrapNewPlayBuffView         �   *   *   ,   ,   ,   ,   .   .   .   .   .   0   0   0   0   0   2   2   2   2   2   4   4   4   6   6   7   7   8   8   9   9   ;   <   <   =   =   =   =   =   >   >   >   ?   ?   @   @   @   A   C   C   C   C   E   E   E   E   E   E   F   F   F   F   G   G   H   H   H   I   I   I   J   J   K   K   K   K   L   L   L   L   L   M   M   N   N   O   O   O   O   P   P   P   Q   T   T   U   X   X   Y   \   \   \   \   \   ]   ^   ^   ^   _   _   _   b   b   b   b   c   c   c   c   g   g   g   g   g   h   h   h   h   h   h   i   i   i   i   k   k   k   k   n   n   n   n   n   o   o   o   o   o   o   p   p   p   p   t   t   t   u   u   u   v   v   v   v   v   w   w   w   w   x   x   x   x   |   |   |   |   |   }   }   }   }   }   }   ~   ~   ~   ~   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    �   TT    �   casterEntity    �   phaseContext    �   world   �   routineComponent   �   summonResult   �   moveResult   �   destroyResult   �   effectService   �   posOld   �   posNew   �   
casterPos   �   
casterDir    �   trapEntity!   �   entityIDList-   >   	entityIDI   Q   	entityIDV   ^   	distancei   �   speedj   �   boardServiceRender�   �   gridPos�   �   viewPos�   �   offset�   �   trapServiceRender�   �   playBuffSvc�   �   NTMoveTrap�   �      _ENV �   �       L@�A  d����� � @��� �A����  �A�& �    GetServiceTrapRenderCreateSingleTrapRenderSetPosition           �   �   �   �   �   �   �   �   �   �   �   �      self       TT       world       trapEntity       
posSummon       trapServiceRender                                                    #      (   �   (   �   �   �   �          _ENV