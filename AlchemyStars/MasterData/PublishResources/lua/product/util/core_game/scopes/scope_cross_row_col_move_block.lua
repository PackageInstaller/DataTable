LuaS �

xV           (w@Z@../PublishResources/lua/product/util/core_game/scopes/scope_cross_row_col_move_block.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@��& �    requirescope_base_class*SkillScopeCalculator_CrossRowColMoveBlockSkillScopeCalculator_Base
CalcRange           �    +V  @GB@bB    �A�  �  ��@   ���A DA@ ��A �������	�G�E
��$D  �  jC��BB ǂ�CB �B$� GCB L�d� �C��� ��C�� ��C� A D@���$D�  FA GD�� � dD�FA GD�� ��dD�K  �  ��@   �����G��  �    C  �  �   �����A � I����ƈA  	 NI�䈀�A NI�	�$��F�A �I�	�d���F  ���	A ��D�	  
 ����I  @���D  
�@
 �
 	�I�@��� �	E  
 @
 	�I � ��	E  
 @
 	�I �F  ���	A ��D�	  
�����I  @���D  
�@
��
 	�I�@��� �	E  
�@
 	�I � ��	E  
�@
 	�I "G  ���	A ��D�	  
 ����I  @���D  
�@
 �
 	�I�@�� �	E  
 @
 	�I � ��	E  
 @
 	�I bG  ���	A ��D�	  
�����I  @���D  
�@
��
 	�I�@�C� �	E  
�@
 	�I � ��	E  
�@
 	�I ����  j���A �D�	 �@��D��A �D�	  	@��D��� ��DE ̄�	F�E G�
����  	� � �  A EF
@���$��"  �	�A D
@���$E� �F�@ ��d ���A ��F� 
 ����ƆA ǆ� �@�䆀 ��  � �i�  ��FEE L��
��E �� �K� � 
kF� �� � 
�F� d� ��
��  K  ��@ ��� ���A��_ �� ��B� � ��A �F� �
@ �F���  *���A �� � ����A �� �
�  ������@  �
� ��A �F@ ��$��F�A G������d��  �  ����  j�����@  �� ��A �F@ ��$��F�A G������d��  �  ����  j��EE ̅�F�E G�����   �F� � @ +G� � ��� & �                          ipairstableinsertVector2xy_gridFilter_worldGetBlockGridTrapPosListGetBlockMovePosListPlayerGetCurrentTeamEntityGetGridPositionremovevappendArray
icontains_InsertTargetGrid_InsertTargetGridIntoOneAreaSkillScopeResultNewSkillScopeTypeCrossRowColMoveBlockintable	Distancec       count         V                                                                                !   !   !   $   $   $   &   &   &   &   '   '   (   (   (   (   (   *   +   +   +   +   +   ,   ,   ,   ,   ,   /   0   1   1   1   1   3   5   7   8   9   :   <   <   <   <   =   =   =   =   >   >   >   >   ?   ?   ?   ?   @   @   @   @   B   B   C   C   C   C   C   C   C   D   D   D   D   D   D   F   G   G   G   G   H   J   J   J   J   L   L   M   M   M   M   M   M   M   N   N   N   N   N   N   P   Q   Q   Q   Q   R   T   T   T   T   V   V   W   W   W   W   W   W   W   X   X   X   X   X   X   Z   [   [   [   [   \   ^   ^   ^   ^   `   `   a   a   a   a   a   a   a   b   b   b   b   b   b   d   e   e   e   e   f   h   h   h   h   <   1   1   m   m   m   m   m   n   n   n   n   n   q   q   s   s   s   s   s   s   s   s   t   x   y   y   y   y   y   y   y   {   {   {   {   {   ~               �   �   �   �   �   �   �   �   �   �   �   �   �         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   K   self    V  
scopeType    V  scopeParam    V  
centerPos    V  	bodyArea    V  
casterDir    V  nTargetType    V  
casterPos    V  size   V  useTeleport   V  target_area_grid   V  (for generator)	      (for state)	      (for control)	      i
      p
      world   V  blockGridTrapPosList   V  blockMovePosList    V  teamLeader$   V  teamPos&   V  blocks,   V  cross_area7   V  
wholeArea8   V  (for generator);   �   (for state);   �   (for control);   �   i<   �   p<   �   	center_x=   �   	center_y>   �   
upBlocked?   �   downBlocked@   �   leftBlockedA   �   rightBlockedB   �   (for index)E   �   (for limit)E   �   (for step)E   �   indexF   �   upPosJ   �   downPosN   �   leftPosR   �   	rightPosV   �   useTeleportResult�   �   result�   V  nearestPos�      (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   pos�   �   lastPosToTargetPosDistance�   �   curPosToTargetPosDistance�   �   rowOrColPos  T  targetMovePosList  T  (for generator)    (for state)    (for control)    _    pos    nearestPos  T  (for generator)#  3  (for state)#  3  (for control)#  3  _$  1  pos$  1  lastPosToTargetPosDistance)  1  curPosToTargetPosDistance.  1  (for generator)7  G  (for state)7  G  (for control)7  G  _8  E  pos8  E  lastPosToTargetPosDistance=  E  curPosToTargetPosDistanceB  E     _ENV                                 �      �          _ENV