LuaS �

xV           (w@W@../PublishResources/lua/product/components/ui/ui_guide/ui_guide_failed_controller.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ ��A l  
@ �& � 	   _classUIGuideFailedControllerUIControllerOnShowRefreshOnHide
bgOnClickUIGuideFailedControllerOnCancelSerialAutoFight           0    �   
@@���� 
� �� � ̀A A� 䀀
����@A � �C  �@�̀B A� � � 
���̀A A 䀀
���̀A A� 䀀
� �̀B A� �A � 
� �̀B A� �� � 
� �̀B A� �A � 
� �̀B A� �� � 
� �� F �@��  �� D ̀�F�F G��A d �@  � E ̀�F�F G��� d �@  ǀD ̀�F�F G��� d �@  ǀE ̀�F�F G�� d �@  ǀC � �C  �@�@�� F �@�� @�̀A A� 䀀� �C  �@�̀A A� 䀀� �C  �@�̀A A	 䀀� �C� �@�̀B A�	 ��	 � 
���� J �@��J � ��$� "   �AI AK�� $��
 ��K �L �ALǁL $A �L �  $A�M $A & � 5   	canClick 
missionId              continueGOGetGameObject	continue
SetActiveconditionTxtGetUIComponentUILocalizationTextcondition1conditionGOcondition2GOcondition2
titleTxt1title1
titleTxt2title2	descTxt1desc1	descTxt2desc2
MatchType	MT_ChessSetTextStringTableGetstr_guide_fail_9str_guide_fail_10str_guide_fail_11str_guide_fail_12MT_PopStarLine1Line2LinePopStar_autoBtnPoolUISelectObjectPathpoolGameGlobal
GetModuleSerialAutoFightModule
IsRunning	_autoBtnSpawnObjectUIWidgetSerialButtonAttachEventGameEventTypeCancelSerialAutoFightOnCancelSerialAutoFight
StartTaskRefresh         )   ,       F @ �   �@  d@�E � L�� d@ & �    YIELD�      
bgOnClick             *   *   *   *   +   +   +   ,      TT          _ENVself�            	                                                                                                                                                                                                                                                                                                               "   "   "   "   "   #   #   #   #   $   $   $   $   &   &   &   &   &   '   '   '   '   '   )   ,   )   /   /   0      self    �   	UIParams    �   
matchType   �   mdq   �      _ENV 2   g    r   G @ b   � �F@@ G�� � @ G�� b   ����@ A ����@A�� ̀A� �A B$�� AA �  b   � �ǁ� �A    ��� � AB ���� �B h�	�G��G�G���C�D� DD$� FD@ G��G��G�  @��� ���DE Ǆ�	�E$ �   ]	��  ��D� �	@��� ���DE Ǆ�	�E$ �   ]	��g���   �GBF L���� dB�F�F G����B �F CG@�$� �Gd� @�G�G L��BE ǂ�C �  ���dB� �GBF L���  dB�� ��@F ��F  �@���H ,  ���
� �& � $   
missionIdCfgcfg_waypoint
GetModuleMatchModuleGetMatchEnterDataGetLocalPlayerInfoInnerGameHelperRenderGetLocalMatchPetsRecommendLV        RecommendAwaken       	pet_list
pet_pstidGetPetLevelGetPetGradecfg_guide_constguide_team_min	IntValueStringTableGetGetPetName、conditionGO
SetActivestringsublen       conditionTxtSetTextstr_guide_fail_3taskId
StartTask         \   e       F @ �   �@  d@�H�@�F � L@� � � d@�F�A G�� � B d� L@� d� b   ��F @ �   �� d@�E � L�� d@ & �    YIELD�      	canClickcontinueGO
SetActiveGameGlobal
GetModuleSerialAutoFightModule
IsRunning�      CloseDialog             ]   ]   ]   ]   ^   _   _   _   _   a   a   a   a   a   a   a   a   b   b   b   b   c   c   c   e      TT          _ENVselfr   3   3   3   3   3   3   3   4   4   5   5   5   5   5   6   6   7   7   7   8   :   ;   ;   ;   ;   ;   ;   <   =   =   =   =   =   >   >   >   @   A   A   B   B   C   C   C   C   D   D   E   F   F   F   F   F   F   F   F   F   G   G   H   H   H   I   J   J   J   J   J   J   J   J   K   =   O   O   P   P   P   P   Q   Q   Q   Q   Q   Q   Q   Q   Q   Q   Q   R   R   R   R   R   R   R   R   R   R   T   T   T   T   U   W   W   W   W   [   e   [   f   g      self    r   cfg   r   matchEnterData   h   localPlayerInfo   h   
matchPets   h   name   h   show   h   recommendLevel   h   needGradeLevel   h   (for index)    I   (for limit)    I   (for step)    I   i!   H   petID$   H   pet%   H   	petLevel'   H   petGradeLevel)   H   	minLevel-   H      _ENV i   l       F @ L@� d� L�� ��@ d@�
@A�& �    TaskManagerGetInstance	KillTasktaskIdcontinueGO             j   j   j   j   j   j   k   l      self          _ENV n   v       F @ G@� d�� L�� ��@ � ��  
���
K  
A��d@ G�B b   @ �L�B d@ & �    GameGlobalGameRecorderRecordActionGameRecordActionUIInputuiUIGuideFailedControllerinput
bgOnClickargs	canClickCloseDialog            o   o   o   o   p   p   p   q   q   q   q   o   s   s   s   t   t   v      self          _ENV x   |       G @ b   � �G @ L@� d@ & �    	_autoBtnHide           y   y   y   z   z   z   |      self                                   0      2   g   2   i   l   i   n   v   n   x   |   x   |          _ENV