LuaS �

xV           (w@c@../PublishResources/lua/product/components/ui/aircraft/new/social/air_group_action_state_base.lua         �    @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@���@ l�  
@ ��@ l  
@���@ l@ 
@ ��@ A� ��@ $@��B  ���B l� 
@ ��B l� 
@���@ A� ��C $@��C   ��C l  
@ ��@ A  ��C $@� D   � D l@ 
@ ��@ A@ ��C $@�@D  ��@D l� 
@ ��@ A� ��C $@��D   ��D l� 
@���D l  
@ ��D l@ 
@���D l� 
@ ��D l� 
@���D l  
@ ��D l@ 
@���D l� 
@���@ A  �@F $@� F   � F l� 
@ � F l  
@���@ A� ��F $@��F   ��F l@ 
@ ��@ A  ��F $@� G   � G l� 
@ ��@ A@ ��F $@�@G  ��@G l� 
@ ��@ A� ��F $@��G   ��G l  
@ ��G l@ 
@���@ A  ��F $@� H   � H l� 
@ ��@ A@ ��F $@�@H  ��@H l� 
@ �@H l  
@��& � "   require
fsm_state_classAirGroupActionStateBase	FSMStateConstructorGetAirMain	AddChild
OnDisposeExcuteExitAirGroupActionNoneStateEnterExitAirGroupActionMoveStateAirGroupActionStateBaseAirGroupActionFollowStateAirGroupActionLookAtStateAirGroupActionTalkStateGetAirCamera3DCheckPetInCamCanRealTalkTalkExitAirGroupActionFurnitureStateAirGroupActionStateBaseAirGroupActionStandStateAirGroupActionStateBaseAirGroupActionCloserStateAirGroupActionLocatedStateAirGroupActionMoveTalkStateExcuteAirGroupActionCorrectState!AirGroupActionFurnitureTalkState                  K   
@ �G�@ L�� d� 
@��G@@ L@� d� 
@ �G@@ L�� d� 
@ �F@B G�� ��A d� 
@ �G@@ L � d� 
@��K   
@��& �    actionsownerstateMachine	GetOwnersocialAreaGetSocialAreapetsGetPetspetIdstablekeys	libMakerGetLibMakerchildMachines                                                                                             self          _ENV           G @ L@� e  f   & �    ownerGetAirMain                             self               $    	   @ A@��@ �� $� L�@�  �dA FA GA���A � dA�& �    AirGroupActionMachineNewownerSetProcessFinishtableinsertchildMachines                                !   !   !   !   #   #   #   #   #   $      self       stateTypes       	callBack       sender       m         _ENV &   +       F @ �@@ d @ �����A i�  ���K   
@��& �    ipairschildMachinesDispose            '   '   '   '   (   (   '   '   *   *   +      self       (for generator)      (for state)      (for control)      index      value         _ENV -   A    	*   G @ b   ��F@@ � @ d @������ �A  @���@ �� �A ��A�& � i�  ���A@ ��A ��A �  ��B� �    �M@� ��  *���A �   ����A �  �� � ���B ��B�@ & �    petspairsIsAliveGetAirMainStopSocialByPet        ipairsactionsIsOver       stateMachineChangeNextState         *   .   .   .   /   /   /   /   0   0   0   0   2   2   2   2   2   3   /   /   8   9   9   9   9   :   :   :   :   ;   9   9   >   >   >   >   >   >   >   ?   ?   ?   A      self    *   (for generator)      (for state)      (for control)      key      pet      count   *   (for generator)      (for state)      (for control)      index      action         _ENV B   E       F @ G@� �   d@ K   
@ �& �    	FSMStateExitactions            C   C   C   C   D   D   E      self          _ENV L   M       & �                M      self       machine            O   Q       F @ G@� �   d@ & �    AirGroupActionStateBaseExit            P   P   P   P   Q      self          _ENV W   b    *   G @ L@� ƀ@ ���A �  d�  �@A � A � ��́A� @ �A�B� $�  "  ��FBB L���   @���B �C� d�  ��B �BC  @��B ��@ ��C��C  ��B���  *A�& �    	libMaker	PopPointtablecountpetspairs	GetFloor
GetCurPosTemplateIDAirActionMoveNewownerGetAirMainPlayActioninsertactions         *   X   X   X   X   X   X   X   Y   Y   Y   Y   Z   Z   [   [   [   [   [   \   \   ]   ]   ]   ]   ]   ]   ]   ]   ]   ^   ^   ^   ^   ^   _   _   _   _   _   Y   Y   b   
   self    *   pos   *   (for generator)
   )   (for state)
   )   (for control)
   )   _   '   pet   '   floor   '   pos   '   action   '      _ENV g   �    ^   G @ L@� ƀ@ ���A �  d@  F�@ G@� � A d� ��� �   �   @��A$� FB LA�� @ �B��B� $�  @ �C �BC� d�  � �GC L���  �dA F�@ G���D ��dA�A� "   �L�Ad� �B �AB  G@ L����B� d�  ���C �B�� ��  �C ́�@ � �A Ɓ@ ���D @ �A�F�@ G���A d�  @��@�F�D �� d��  ��@��C �BC�� ��D ��B�i�  �A�FE GA��� dA & �    	libMaker	PopPointtablecountpetstoArray       	GetFloorAirActionMoveNew
GetCurPosTemplateIDownerGetAirMainPlayActioninsertactions       ipairsRandomActionForPetLog
exception并排走出现了三个人？         ^   h   h   h   h   h   h   h   i   i   i   i   j   k   l   l   m   m   o   o   p   q   q   q   q   q   r   s   s   s   o   t   u   u   u   u   u   v   v   v   v   v   y   z   z   {   {   }   }   ~                  �   �   �   �   }   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    ^   pets   ^   beFollowPet   ^   beFollowAction   ^   floor   )   
followPet*   ^   floor.   E   action;   E   (for generator)N   Y   (for state)N   Y   (for control)N   Y   indexO   W   petO   W      _ENV �   �       G @ L@� d� ��@ ��@ � ���A �A�@ �� �� 䁀�A B� ��$B BB �BG�B ��$B���  *A�& �    	libMakerGetTargetPospairspetsAirActionRotateNewd       ownerPlayActiontableinsertactions            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       pos      (for generator)      (for state)      (for control)      index      pet      action         _ENV �   �       
@@�
�@�
@A�F�A G � 
@ �
�& �    curPetIndex       	maxRound        
curAction 
takeStateAircraftSocialTalkTypeNormal	petInCam             �   �   �   �   �   �   �   �      self          _ENV �   �       
@@���@ � A�� 
� ��@� � ���@ ��A�� 
�����A �@ & �    curPetIndex       	curRoundsocialAreaGetSocialRound	maxRoundGetMaxRoundTalk           �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       	maxRound            �   �       L @ d� L@� e  f   & �    GetAirMainGetMainCamera           �   �   �   �   �   �      self            �   �    (   G @ b@  @�L@@ d� ��@ ��@ � @��A� B�L�� � d������B �B�ǂ�!�@���� ��������B �B��B�!� ��� ���@ �
�C�@ ���  *��G @ f  & �    	petInCamGetAirCamera3Dpairspets
Transform	positionWorldToScreenPointxUnityEngineScreenwidth        yheight         (   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
   self    (   	camera3d   %   (for generator)   %   (for state)   %   (for control)   %   id	   #   pet	   #   tr   #   petPos   #   
screenPos   #      _ENV �   �       L @ d� �@� �� ̀@ � #   � �& & �    GetAirMainGetCamNearbyStateCheckPetInCam           �   �   �   �   �   �   �   �   �   �   �      self       airMain      nearByState      	petInCam           �   �    I   D   � @ �@@ ǀ��  ���@ �� �    �� A �@AǀA   ���@  b   � ��@@ ��A
� �  �
@B�� @ �@@ ǀ�� ����A ǀB �B � ��� �    	�� C �@�@ ��C� �  �C D� ��$A 
������ @ �@@ ���� ����D �@C�A @� ��D � ��  
���� E �A � � �B�� $B��  j��̀E�@ & �    
takeStateAircraftSocialTalkTypeNormalCanRealTalk
AirHelperGetGroupTalkpets	RealTalkcanRealTalk petIdscurPetIndexAirActionFaceNewGetRandomFaceownerPlayAction
curActionAirActionGroupTalkGetAirMainpairsSetSocialGroupTalkStart         I   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
   self    I   talkCfg   I   pet!   /   action)   /   action<   H   (for generator)@   F   (for state)@   F   (for control)@   F   kA   D   petA   D      _ENV �   �    	   F @ G@� �   d@ 
�@�
@A�
@A�
 & � 	   AirGroupActionStateBaseExitcurPetIndex       	curRound        	maxRound
curAction          	   �   �   �   �   �   �   �   �   �      self    	      _ENV �      	F   G @ b   ��F@@ � @ d @������ �A  @���@ �� �A ��A�& � i�  ���G@A b   ��G@A L�� d� b   @
�G�A � B �@B�� � �G�B L�� d@  �G�A � B � C�� ��G@C ��C �   �� � �G@C M�� 
@��  �
�ÆG D M�� 
@ �G@D L�� � D � d@ G D ��D  @ � �G�B L�� d@ @ �L E d@ & �    petspairsIsAliveGetAirMainStopSocialByPet
curActionIsOver
takeStateAircraftSocialTalkType	RealTalkstateMachineChangeNextStateNormalcurPetIndexpetIds       	curRoundsocialAreaSetSocialRound	maxRoundTalk         F   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                                                 	                                           self    F   (for generator)      (for state)      (for control)      key      pet         _ENV   S   w   G @ L@� d� ��   ��@  � � 
� �b   @�� @ � A�� �   �
��@ �A G�A $��G@ L���d���B��� ��$� F�B L��   @�� ��  �GEC L��
d� �  �E  ,�  d� ��C �D  @��C �CD ��D��D  ��C��@� ���)�  �A�ހ�� E �@�� �@ ��E � ��@ ހ�@�� @ � A�� �   @	�ƀA �A � ��@ B� $��LB�d� ��F �C �@ �  � �� ��F ��@�� �   @�䂀�C D����$C CD �DG�D ��$C��  j����� E �@�� �@ ��E � ��@ & �    	libMakerGetSeqMakerisActionSeq GetFurniture       pairspetsGetFurniturePointInteractionPoint
MovePointAirActionSequenceNewsocialAreaGetSocialRoundownerPlayActiontableinsertactionsLogerror%没找到家具直接进入下回合stateMachineChangeNextStateGetSocialRemainTimeAircraftPetFurPointConditionAirActionOnFurniture         /  1           @ � � �@@�  $@  & �    SetFurnitureTypeType          0  0  0  0  0  0  1         petfurn 2  4      � @ �@@   C� �� �@�& �    socialAreaSetSocialRound           3  3  3  3  3  3  4     round       index          self 5  8    	       @ � � $@�  @@ ��  $@�& �    ReleasePointSetFurnitureType           	    	   6  6  6  6  7  7  7  7  8         furnpointpetw                                   !  "  "  "  "  #  #  #  #  $  $  %  %  '  '  (  )  *  +  ,  -  .  .  .  1  4  8  '  :  :  :  :  :  ;  ;  ;  ;  ;  <  <  <  "  "  =  ?  ?  ?  ?  @  @  @  A  A  D  D  D  E  E  F  F  F  F  G  G  G  G  H  H  I  I  I  I  I  I  I  J  J  J  J  J  J  J  J  K  K  K  K  K  L  L  L  L  L  F  F  M  O  O  O  O  P  P  P  S     self    w   	seqMaker   w   furn   C   index   :   (for generator)   :   (for state)   :   (for control)   :   
petTempId   8   pet   8   point   7   pos   7   rot   7   endPos   7   furnAction+   7   furnG   v   (for generator)L   n   (for state)L   n   (for control)L   n   
petTempIdM   l   petM   l   pointQ   l   	durationS   l   condZ   l   furnActionb   l      _ENV U  b      F @ G@� �   d@ G�@ b@  @�F�@ � A d ���A��� ́�� �A BN��$� LB�d� G��b  � ����  �B�i�  �@�& �    AirGroupActionStateBaseExcuteisActionSeqpairsactionsCurrentTime	DurationmathfloorGetPets       SetSocialRemainTime            V  V  V  V  W  W  W  X  X  X  X  Y  Y  Z  Z  [  [  [  [  \  \  \  ]  ]  ^  ^  ^  X  X  b  
   self       (for generator)
      (for state)
      (for control)
      _      action      time      	duration      remainTime      pet         _ENV g  m      F @ �@@ d ����@ ��@ �A �B ���ǁA ���@�� �A �B �A��B @ �A�i�  �@�& �    pairspetsAirActionStandNew�      X      ownerPlayActiontableinsertactions            h  h  h  h  i  i  i  i  i  i  j  j  j  j  j  k  k  k  k  k  h  h  m     self       (for generator)      (for state)      (for control)      _      pet      action
         _ENV s  }   !   F @ �@@ d @������ ��@ ��� �  ��BA �A����  G�A L�d $�  G�A LB���  dB F�B G���C � dB�i�  ���& �    pairspets	GetFloor	libMakerGetCloserPosAirActionMoveNewownerGetAirMainPlayActiontableinsertactions         !   t  t  t  t  u  u  v  v  v  w  w  x  x  x  x  x  x  x  x  x  y  y  y  y  y  z  z  z  z  z  t  t  }  	   self    !   (for generator)       (for state)       (for control)       _      pet      floor      pos	      action         _ENV �  �   '   G @ L@� ƀ@ ���A �  d�  �@A � A �  �́A� @ �A�B� $�  "  ��FBB L���   @�d����B �C  @��B ��@ �BCǂC  ��B���  *�& �    	libMaker	PopPointtablecountpetspairs	GetFloor
GetCurPosTemplateIDAirActionLocatedNewownerPlayActioninsertactions         '   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  
   self    '   pos   '   (for generator)
   &   (for state)
   &   (for control)
   &   _   $   pet   $   floor   $   pos   $   action   $      _ENV �  �      F @ �@@ �� G�� ��@  � l  �@ ��@ � F�@ G�+A� lA  �@ �@A ��A��A�@ �@A � B�@B�@ A�@�& � 
   AirSocialSubLibTypeGetStateType	AddChildAirGroupActionStateTypeTalkchildMachines       StartState       ChangeState         �  �        @ @@ �@ $@ �@  A $@ & �    childMachines       StartState	libMakerReleasePoint           �  �  �  �  �  �  �  �         self �  �        @ @@ $@ & �    ownerOnProcessFinish           �  �  �  �         self   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       
subStates         _ENV �  �      & �                �     self            �  �   W   F @ G@� ��@ d� ��� �   �   ��A AA� ́A� �A A � �B $� ��� $��G�B L��   dA F@ GA���C � dA��� "  ��LDd� �AD �AA  L�Ad� ��A �  AC �� M������B ̂�� ��  ��B ��@ � �A �@ �A��C @ �A�F@ G����@ d�  @��@�FE �� d��  ��@���B ��D�� �BE ��B�i�  �A�F�E G��� dA & �    tabletoArraypets       AirActionRotateNewWorldPositionVector3              ��d       ownerPlayActioninsertactions       	GetFloorAirActionMoveGetAirMaincountipairsRandomActionForPetLog
exception并排走出现了三个人？         W   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    W   pets   W   beFollowPet   W   beFollowAction   W   action      
followPet    W   floor$   >   action4   >   (for generator)G   R   (for state)G   R   (for control)G   R   indexH   P   petH   P      _ENV �  �      L @ � � A@ �@�@� ,  d@ L @ � � A@ �@�@� ,A  d@ G A G@� L�� d@ G A G�� L � �@@ ���A d@ & � 
   	AddChildAirGroupActionStateType
FurnitureTalkchildMachines       StartState       ChangeState���             �  �        @ @@ $@ & �    ownerOnProcessFinish           �  �  �  �         self �  �       & �                �             �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self          _ENV �  �      & �                �     self           �                        
   
                        $      &   +   &   -   A   -   B   E   B   J   J   J   J   K   K   L   M   L   O   Q   O   U   U   U   U   V   V   W   b   W   e   e   e   e   f   f   g   �   g   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �                 S    U  b  U  e  e  e  e  f  f  g  m  g  q  q  q  q  r  r  s  }  s  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �         _ENV