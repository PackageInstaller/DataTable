LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/180/client/Assets/../PublishResources/lua/product/components/ui/aircraft/tactic/ui_tactic_tape_info.lua         7    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@A l�  
@ �@A l�  
@��@A l  
@ �@A l@ 
@��@A l� 
@ �@A l� 
@��@A l  
@ �@A l@ 
@��@A l� 
@ �@A l� 
@��@A l  
@ �@A l@ 
@��@A l� 
@ �@A l� 
@��& �    _classUITacticTapeInfoUIControllerOnShow_TriggerGuideUITacticTapeInfoOnHide
cancelNewchangeDiffrefreshDiffInitWidgetdeleteTapedeleteTapeN8playBtnOnClickOnplayBtnOnClick	_FightN8delBtnOnClickcloseBtnOnClickrestrainBtnOnClickGetGuideBtn           L    �   � @ �@ ��� 
���� � 
�����A �A ���
����@A �@B�B �B���
� ���@ �    ��@C ��C�� 
� �� C ��CD AD�@��@@ �D� ���D �  �@ & � �@E �� A@ �E$� A �A@ �AF� �@  ��F � G�@@ ���� �� 
� ���F ��G��G � �_� ����F ��G��G �@�_�   ��@  � � 
�����H ��HI AIGA@ L��d� G��$ �@  � J ��HI AIGA@ L��d� G��$ �@  �@J ��HI AIGA@ L��d� G��$ �@  ��J � KA@ �I$� AK�@���K ��H�F �K�@��@L ��L� ���
� �
�@��@M �@ �@@ ��M�� �   � ���M N @  �@ �@N �� ��N�N FO GA�$ ��  ��O ̀�� 
� ��@P ̀�K ��P ��C,  �����P ́�@ � � �P �C�B  $��F�P L��� C d� ��P ��C,�  ��kA  �� � 
� ���Q �@ & � H   InitWidget_item       _activityN8       _module
GetModuleAircraftModule_tacticRoomGetRoomByRoomTypeAirRoomTypeTacticRoom
_campaignUIActivityCampaignNewLoadCampaignInfo_LocalECampaignTypeCAMPAIGN_TYPE_N8 	AirError传入的卡带数据为空AirLog打开卡带详情:GetTemplateID
，pstid:GetID_cfgCfgcfg_item_cartridge_isBlackFistMatchComIdECampaignMissionComponentId.ECampaignMissionComponentId_AircraftBlackfist/ECampaignMissionComponentId_SimulatorBlackfisttitleSetTextStringTableGetGetTemplateName_titleOutlinedesIntroicon
LoadImageIcon	_qualityQuality
_enemyMsg	enemyMsgSpawnObjectUIEnemyMsg_difficultyrefreshDiffIsNewOverlay
StartTask
cancelNewGetGameObjectGetComponenttypeofUnityEngine
Animation_playerEZTL_Player_tlEZTL_SequenceEZTL_CallbackEZTL_PlayAnimationuieff_TapeInfo_Switch1uieff_TapeInfo_Switch2难度切换动画_TriggerGuide         8   :            @ �@  $@�& �    LockPlaySwitchDiffAnim           9   9   9   9   :          self >   @            @ $@ & �    refreshDiff           ?   ?   ?   @          self D   F            @ �@  $@�& �    UnLockPlaySwitchDiffAnim           E   E   E   E   F          self�               	   	                                                                                                                                                                                                   "   "   "   "   "   "   "   "   "   "   #   #   #   #   #   #   #   #   #   #   $   $   $   $   $   $   $   $   $   $   %   %   %   %   %   %   %   &   &   &   &   &   )   )   )   )   )   +   ,   ,   .   .   .   .   .   /   /   /   /   2   2   2   2   2   2   2   2   3   3   3   3   5   5   5   7   7   :   7   <   <   <   <   <   =   =   @   =   B   B   B   B   B   C   C   F   C   H   J   5   J   K   K   L      self    �   	uiParams    �   anim�   �      _ENV N   P    
   F @ G@� d�� L�� ��@ � �A AAd@ & �    GameGlobalEventDispatcher	DispatchGameEventTypeGuideOpenUIUITacticTapeInfo         
   O   O   O   O   O   O   O   O   O   P      self    
      _ENV R   V    	   G @ L@� d� b   � �G @ L�� d@ & �    _player
IsPlayingStop        	   S   S   S   S   S   T   T   T   V      self    	        X   [       � @ A@ �����@ � G�@ L�d �@  �@A ��A��� ��AB ABG�@ L�d �@  & � 
   
GetModuleItemModuleSetItemUnnewOverlay_itemGetIDGameGlobalEventDispatcher	DispatchGameEventTypeAircraftTacticTapeCancelNew            Y   Y   Y   Y   Y   Y   Y   Y   Y   Z   Z   Z   Z   Z   Z   Z   Z   Z   Z   [      self       TT          _ENV ]   h       � @ @   �& � �@@ ��  @ A�  �� �@�� @ �   @�� A � @ �� �@A  �@�
@ ���A ��AB �@�& � 	   _difficultyAirLog切换卡带难度:->_btns	OnSelect_playerPlay_tl            ^   ^   ^   _   a   a   a   a   a   a   b   b   b   c   c   c   c   c   c   e   g   g   g   g   h      self       diff          _ENV j   %   �  G @ �@@ G�� L�� � � d@�G�@ b    &�G A L@� �   d@�G�A L@� � � d@�F�A G � �@B ��B�@@ �� G�� ��A ��B�@B � �A@ � ��� �@C A� ��C �D� AD �D�� � $A AD AE$� K  �� � � ����  ��  ������A F�F�A GC���FG�����C��G �G$� H��A �DH	ǄH��	��H	$���  ����I ��� ���� ��I!�� ��C��G �G$� H��A �DH	�I��	��H	$���  ������ ������ ������� ������� ����C����������J������� � � ���B�M �@��B �A��AB �AM�A@ ���AB ǁ�B@ �� ��� ��M NBA�� $B��M BN��N ��N� �� �B   A� �B$B� ��M NBA�  $B��O BN� ����$B�BP BA�  $B��$�G A L@� � � d@�G�A L@� �   d@�F�A G�� �@B ��P�@@ �� G�� b@  ��� Q �@Q�� AB �PGA@ AA� �AB �R�@��@R � M�� �@��   ��� �   @�S @�$� @S@��  ��@��S @�$��F�A G��G�bB  ���Q �BQ�   AC ��� �B���N ��N����� �    ��  @ �@�  ��  )�  �A��� ��� ��A �S� "A  ��FQ GA�� ��B G�� dA�F�N G����Td� � ��    �AU AN� $A�AP AA�� $A�� �AP AA�  $A�AB AMGA@ AGAB G���A@ G��  �� ���U �N�AA� �A���U �AN�N �NA $� AB � �� ��A� ���U �N�AA  �A���U �AN @�B�A�K   � V ��G�� �@V�V �VKA  �AB �W�A@ ��J���  ����@W �@  @�ǀW ���GX LA�d �  �   @�AS �X@��  $A�  F�S ��d ���  ����ǂ����Z �B���
�i�  ��FAS G���� � dA��@S ǀ� � @ �@��@B ����   ���@S ǀ� � GAB G���A@ G���@�� [ ̀�AA �� �@ � [ �@�� �S @� $@
�GL����[ ��C\ �\dB F�\ G���XG��bB   ��Q �BQ�B �X�B���M� GCY
C�G��
C��G�X
C�G��
C��F_ GC���Yd� 
C��G�Y
C��B����_,C  �B���)�  ���& �    _btns_difficulty	OnSelect_isBlackFist_enemyInfo
SetActive_blackFistEnemyCfgcfg_blackfist_hard_cfg
HardProIDcfg_blackfist_squads	SquadsID	GetAssetProperty.spriteatlas	LoadTypeSpriteAtlas_blackFistEnemyInfoSpawnObjectsUIBlackfistEnemyItem       GetAllSpawnList       	CfgPetIdcfg_petcfg_pet_skinSkinIdpetidelemt1
GetSpriteUIPropertyHelperGetInstanceGetColorBlindSpritecfg_pet_elementFirstElementIconSecondElement        GradeElement2NeedGradeelemt2lvLv
awakening
AwakeninggradeequipEquipskin	TeamBody	battleMe
BattleMesSetDataRecommendAwakenRecommendLV
_bf_awakegameObjectSetTextStringTableGetstr_pet_config_common_advance
<size=29></size>
_bf_levelLv._wordParentcfg_campaign_mission
MissionIDLog
exception+cfg_campaign_mission表中找不到关卡:,卡带id:ID
_enemyMsgFightLevelBaseWordBufftypetableipairscfg_word_buff!cfg_word_buff中找不到词缀:，MissionID:CampaignMissionIdDesc

_wordTextawakelevelUICommonHelperGetDropByAwardType
AwardTypePassPassFixDropId_activityN8_tacticRoomGetCartridgeExtraAwards_itemGetIDsortItemIDassetidCountcountTypeUIItemRandomTypeTeBieDiaoLuoappendArrayCPassRandomAwardawardContentUIItemSetFormUIItemFormTacticUIItemScaleLevel3Cfg	cfg_itemcfg_item表中找不到配置:text1iconitemIdqualityColortopTextUIEnumItemRandomStrSetClickCallBack         �   �    &   � @ �@@ǀ@ �� � @ �@��� � ��@G��_@���@G��` �  �A  � & AG�_@��AG�` �  �A  � & AAGA�`@  �A  � & & �    Cfg	cfg_itemassetidColorBagSortIndexID         &   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      a    &   b    &   cfga   &   cfgb   &      _ENV   "      F @ @�  �F�@ L�� �  d��@ �F @ L@� ƀ� �A Bd@ & � 	   matTipInfo matTipSpawnObjectUISelectInfoSetDataItemID
transform	position                           !  !  !  !  !  !  "     go          selfitem�  k   k   k   k   k   k   n   n   n   o   o   o   o   p   p   p   p   r   r   r   r   r   r   r   s   s   s   s   s   s   s   t   t   t   t   t   u   u   u   u   u   w   w   w   x   y   y   y   y   z   {   {   {   {   |   |   |   }   }   }   }   ~   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   y   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                               	  	  	  
  
  
  
                                                                                "    #  
  
  %  1   self    �  hardCfg   �   	squadCfg   �   atlasProperty$   �   ememies,   �   datas-   �   (for index)0   m   (for limit)0   m   (for step)0   m   i1   l   dt2   l   petid6   l   petCfg9   l   skinCfg=   l   (for index)p   w   (for limit)p   w   (for step)p   w   iq   v   awake{   �   level   �   missionCfg�   5  	wordText�   5  buff�   5  (for generator)�   �   (for state)�   �   (for control)�   �   _�   �   wordId�   �   word�   �   desc�   �   word�      awake  5  level  5  
dropItems6  �  
fixedDropD  �  
extraDropM  i  tmpU  i  (for generator)X  d  (for state)X  d  (for control)X  d  iY  b  itemY  b  items�  �  (for generator)�  �  (for state)�  �  (for control)�  �  i�  �  item�  �  cfgItem�  �     _ENV '  X   
n   L@@ ��    d� 
@ �L@@ �  �  d� 
@��L@@ �  A d� 
@��L@@ �� � d� 
@ �L@@ �   d� 
@ �L@@ �� � d� 
@��L@@ �� � d� 
@��L@@ �   d� 
@ �L@@ �  A d� 
@��L@@ �� � d� ���  AA �@ ��� �� 
� ��  �@  �@���D �A�AE �l  �A � ��@@  A� �� 
� ��@F � ���
� ��@@  A �� 
����@@  A� �� 
����@F  ���
����@@ � A� �� 
����@F 	 ���
����@@  A�	 �� 
����@@  A
 �� 
���& � )   iconGetUIComponentRawImageLoadertitleUILocalizationTextdes	enemyMsgUISelectObjectPathrecommendLVawardContentAwardContentmatTipawakelevelbtnsSpawnObjectsUITacticDiffBtn       _btnsGetAllSpawnList       SetData_titleOutlinetitleoutline_wordParentGetGameObjectwords
_wordTextword	_qualityquality_blackFistEnemyblackFistEnemy_blackFistEnemyInfoblackfistEnemyInfo_enemyInfo
enemyInfo
_bf_awake	bf_awake
_bf_level	bf_level        C  E      E   L � �   d@�& �    changeDiff           D  D  D  D  E     diff          selfn   *  *  *  *  *  ,  ,  ,  ,  ,  .  .  .  .  .  0  0  0  0  0  2  2  2  2  2  4  4  4  4  4  6  6  6  6  6  7  7  7  7  7  8  8  8  8  8  ;  ;  ;  ;  =  =  =  =  ?  ?  ?  @  @  @  @  A  A  A  B  E  A  @  I  I  I  I  I  K  K  K  K  M  M  M  M  M  O  O  O  O  O  Q  Q  Q  Q  S  S  S  S  S  T  T  T  T  V  V  V  V  V  W  W  W  W  W  X     self    n   btns1   n   (for index);   C   (for limit);   C   (for step);   C   i<   B        Z  o   	O   � @ �   � ��@@  � �@�& � ��@ �@ $ �@  � A �@ �A �A$� A ��A �AB� �@  ��B ��B � G�A LA�d ��  � C L�@ d �@  �@C� �   @�̀C �@ ǀB ���FD GA�䀀�D �D$�� E�AE ��E$A��D �D$�� E�AE ��E���   $A��D �D$�� E�AE �AF��� $A  ��ƀF ����B G�AG� $  �@  & �    _activityN8deleteTapeN8LockGetNameAirLog删除卡带:_itemGetTemplateID
，pstid:GetID_moduleRequestDeleteCartridgeUnLockGetSuccCloseDialogGetRoomByRoomTypeAirRoomTypeTacticRoomGameGlobalEventDispatcher	DispatchGameEventTypeAircraftTacticRefreshTapeListAircraftTryRefreshRoomUISpaceIdAircraftRefreshRoomUIToastManager
ShowToastGetErrorMsg
GetResult         O   [  [  [  \  \  \  ]  `  `  `  `  a  a  a  a  a  a  a  a  a  a  b  b  b  b  b  b  b  c  c  c  c  d  d  d  d  e  e  f  f  f  f  f  g  g  g  g  g  g  g  i  i  i  i  i  i  i  i  i  i  k  k  k  k  k  k  k  k  k  k  m  m  m  m  m  m  m  m  o     self    O   TT    O   res   O   room+   E      _ENV q  �   
1   � @ �@@�@ �@A �� �@A L�A d� �� ]���@�� B �@�� �B�� ���B C$ $A  AC ��A �� �� ��$A���$� "A  ��@ �C���@ �A�� $A �D $A �D E$�� AE��E ��E$A�& �    
_campaignGetComponentByTypeCampaignComTypeE_CAMPAIGN_COM_CombatSimulator       LockGetName:deleteTapeN8()AsyncRequestResNew+HandleCombatSimulatorComponentDelCartridge_itemGetIDUnLockGetSuccCheckErrorCode	m_result_idCloseDialogGameGlobalEventDispatcher	DispatchGameEventTypeAircraftTacticRefreshTapeList         1   s  s  s  s  s  s  u  u  u  u  u  u  v  v  v  w  w  w  w  w  w  w  x  x  x  x  x  x  z  z  z  z  {  {  {  {  {  {  {  ~  ~                �     self    1   TT    1   
component   1   res   1      _ENV �  �   ?   � @ �@@ƀ@ ����@ � A �   � ��@A �@ & � ��A ��A� B �� �@B ̀�� B F�B � �AB �A�� � GBB L��d� �� � dA�FD GA���D d� ����� �E �A�@ ���� K�� ��  kB���E�E F@��B �BF � �B��D ��F��� �G�F @  �B & �    AudioHelperControllerPlayUISoundAutoReleaseCriAudioIDConstN8DefaultClick_activityN8	_FightN8_cfg
MissionID_difficulty_itemGetIDAirLog开始战斗:GetTemplateID
，pstid:，难度:GameGlobal
GetModuleMissionModuleTeamCtx_moduleGetCartridgeMatchParamInitTeamOpenerTypeAirLockOnplayBtnOnClickTaskManager
StartTask         ?   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  
   self    ?   go    ?   
missionID   ?   
cardPstID   ?   hardID   ?   module#   ?   ctx%   ?   matchComID*   ?   paramKetMap*   ?   param/   ?      _ENV �  �   
(   � @ �@@ � ����@ ��  $A�A$� "   �AA �AF�A $� LBd� �A� ��A���B � �A���C$� FAC G���� � dA�FD GA��@ ��DC$ �  dA  & �    _moduleRequestTacticFormationInfoUnLockOnplayBtnOnClickGetSuccGameGlobal
GetModuleMissionModuleTeamCtxInitAirTeamShowDialogUITeams
GetResultLogerrorD###[UITacticTapeInfo] RequestTacticFormationInfo fail ! result --> ToastManager
ShowToastGetErrorMsg         (   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    (   TT    (   res   (   	teamInfo   (   module      ctx      result   '      _ENV �  �   3   G @ G@� ��@ G�� ��@ � A�� ǀ@ AA A� ��@ ��A�� � �@ A$� AB ��$A��B ��B $��GC LA�ƁC ��� d� �AD�� ́DF�D G�� �� C�� $��L����  d �B  �A ��E A �A��AF�A & �    _cfg
MissionID_difficulty_itemGetIDAirLog开始N8战斗:GetTemplateID
，pstid:，难度:
GetModuleMissionModule
_campaignGetComponentByTypeCampaignComTypeE_CAMPAIGN_COM_CombatSimulator       TeamCtxInitTeamOpenerType	CampaignGetCampaignMissionComponentIdGetCampaignMissionParamKeyMapLockDoEnterTeamShowDialogUITeams         3   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    3   
missionID   3   
cardPstID   3   hardID   3   module   3   
component   3   ctx   3      _ENV �  �      � @ �@@ƀ@ ����@ � A �@A ǀ�� � ,  �@�& �    AudioHelperControllerPlayUISoundAutoReleaseCriAudioIDConstN8DefaultClick
PopMsgBoxStringTableGet$str_aircraft_tactic_delete_tape_tip         �  �      E   L � �@@   d@ & �    
StartTaskdeleteTape           �  �  �  �  �  �     param          self   �  �  �  �  �  �  �  �  �  �  �  �  �     self       go          _ENV �  �      � @ �@  �@ ��@ �@ & �    AirLog关闭卡带详情CloseDialog            �  �  �  �  �  �     self       go          _ENV �  �      L @ �@  d@�& �    ShowDialogUIRestrainTips           �  �  �  �     self            �  �      G @ b    �G @ \ � !@�� �G @ G@� G�� G�� f  D   f  & �    _btns       btngameObject           �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self           7                        L      N   P   N   R   V   R   X   [   X   ]   h   ]   j   %  j   '  X  '  Z  o  Z  q  �  q  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �         _ENV