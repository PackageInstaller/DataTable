LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/aircraft/new/manager/aircraft_random_action_manager.lua         D    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@ 
�C�
�C�
�È
�C�
�É
�C�
�Ê
�C�
�ËF @ �  ƀ@ d@�F F @ �F F �� J���F F �  J���F F �@ J� �F F �� J���& �    _classAircraftRandomActionManagerObjectConstructorInitUpdateDisposeRandomActionForPetRandomInitActionForPet_randomForPet
_1_getLib_2_getActionList_3_getValidAction_4_startActionIndex TypeArea	DurationFurTypeWeight
ConditionFur
PointCondAircraftPetFurPointCondition	PreCheckTakePointOnStartReleasePointOnStop        	          
@ �& �    _main                    self       aircraftMain                      G@@ L�� d� 
@ �& �    _boards_mainGetAllBoards                             self                      & �                      self       deltaTimeMS                      & �                      self                      � @  � C  �@ & �    _randomForPet                             self       pet                      � @  � C� �@ & �    _randomForPet                             self       pet                ,       � @ @� 䀀A@ �� ��$� L�@ ��   @ d����@  � @�� �A�& �    
_1_getLib_2_getActionList_3_getValidAction_4_startAction           (   (   (   )   )   )   )   *   *   *   *   *   +   +   +   +   +   ,      self       pet       isInit       lib      list      action           /   =    
"   � � �� �@  �� $� "A  � ��� $� "   �A AA� ǀA� �A AA� ��AA B� @B��F�B G��� � B @�dA�& & �    TemplateID��������
IsGiftPetIsVisitPetCfgcfg_aircraft_petGiftLib
ActionLibcfg_aircraft_random_actions Log
exception找不到行为，星灵id：，配置：         "   0   0   1   3   3   3   3   3   3   3   3   4   4   4   4   4   6   6   6   6   8   8   8   9   9   :   :   :   :   :   :   :   <   =      self    "   pet    "   petID   "   actionLibID   "   cfg   "      _ENV ?   �    �   �   @GA@AG@R��A@���  �@ GA$@ �GCA�A�)�  ����  F�@ ��Ad@ �����i�  ���A�  ��@ �B�@ ��CAM��  *����  �B �@ GA$��\�MD��� ����C �D�	�Ą��DB�����A�Ą��DA�ā	�D�	���ǄD�Ą�ʀ��B�GDARāOD��B)�  ����@ G�A$��G�AR���@ �B������E�� 
��FC G��
F��GFB
F�G�A
F��GFARF�OF�O��
F�GFB
F�G�D
F��� ��EA�E��E�υ����B���  *��)�  ���C AC �� �����E ��E��� �C��    @ ���	�DB	�D h��G�G�
�C�!�@ �  
  �g��G�G�NC�_ � �G���ʀ�@CB@��  & �    WWeightFWeight        ipairsWAreas       FAreas       FFurniture       IndexTypeAirRandomActionType
WanderingArea	DurationWeight
Condition       
FurnitureFurType      �?mathrandom         �   A   B   B   B   C   C   D   D   E   F   F   F   F   G   G   F   F   I   J   J   J   J   K   K   J   J   M   N   N   N   N   O   O   N   N   R   S   T   T   T   T   U   U   U   V   W   W   W   X   X   Y   Y   Z   Z   Z   Z   [   [   \   ]   ^   ^   ^   ^   T   T   `   `   `   `   a   a   b   b   b   b   c   c   c   d   e   e   e   f   f   g   g   h   h   h   h   h   i   i   j   j   k   l   l   l   l   l   m   b   b   `   `   r   s   t   t   t   u   u   u   u   v   w   x   x   x   x   x   x   y   y   y   z   z   {   {   x            �   �   �   �   �   �   �   �   �   �   5   self    �   pet    �   cfgLib    �   list   �   totalWeight1   �   wweight   �   fweight   �   totalWeightWander	   �   (for generator)      (for state)      (for control)      _      cfg      totalWeightFurArea   �   (for generator)      (for state)      (for control)      _      cfg      totalWeightFur   �   (for generator)   #   (for state)   #   (for control)   #   _   !   cfg   !   w$   �   idx%   �   (for generator)(   B   (for state)(   B   (for control)(   B   _)   @   cfg)   @   (for generator)E   k   (for state)E   k   (for control)E   k   _F   i   cfgF   i   aweightH   i   (for generator)K   i   (for state)K   i   (for control)K   i   __L   g   cfgFL   g   curl   �   weightm   �   rt   �   tempu   �   targetv   �   (for index){   �   (for limit){   �   (for step){   �   i|   �   t�   �      _ENV �   �    Q   � $� FA@ � d�����_  �����A �B�� ������A ��@ 䂀�   �f ������A �B�� ����ǂ��   ���B C ���CC A� ��� �� � ��$C�@��A CD� $��F�D � d@������ �	@�����E �D�	@� ��� 	䄀��	$� "  � �JB��J��f i�  ��� ��BF ��F�� ���B�i�  �A�& �    GetRandomActionCfgIDipairsIndexTypeAirRandomActionType
WanderingArea_mainCanWanderingInArea
FurnitureFurTypeAirFurnitureType
RestEmptyAirLog9初始化时随到了星灵去空地, 不处理, 星灵:TemplateID
, 索引:GetFurnituresByAreapairs
ConditionAircraftPetFurPointConditionNew	PreCheckFur
PointCondLog
exception星灵行为类型错误：         Q   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    Q   pet    Q   list    Q   isInit    Q   currentIdx   Q   (for generator)   P   (for state)   P   (for control)   P   _   N   action   N   area      area   H   furType   H   furs0   H   (for generator)3   H   (for state)3   H   (for control)3   H   _4   F   fur4   F   condCfg9   F   cond?   F      _ENV �      �    @��A@ �@A�  �� � $A  & � A� $� "   �G�A L��� d��b  � ���� $ �A  �A�   �A��   ��D  ��B��B ����	��ACǁA ́�@� � �A ǁA ���@ 䁀� �B�� $B  �� ��A ��D ���$B  E AB �� �� ��   A� �C�� $B  F BF�� ���FA� ��A $��@ �	���B��B ���@��AC�AG�GL�Gd� �� C�$ �B  �� CH �H�B��E �� � $� A	 �C��� ��	 ��$ �B  �J �BF � @���� �FC� �� @ ��A �AJ � @���I�A���� �I�A���L�� dA D  ��B��B ������ACǁA ́�@� � �A ǁA ���@ 䁀�$� FE �B �� � � @ �� �C�� dB  FL LB�ǂA  � @�� ǃFd��@�@���B��B ��� ��AC�AG�GL�Gd� �E �B � $� A	 ����� ��	 ��$� A� �D�� �B  ��L �BF�A @� ����  G�F�� @ ��  ��A���� �I�A�& � 5    Log
exception星灵没有可执行行为：TemplateIDGetWanderingArea_mainGetRoomByAreaPetLeaveWanderingSetWanderingAreaTypeAirRandomActionType
WanderingAreaEnterAreaToWanderingGetPointHolder	SetFloorFloorSetPositionGetInitPosAirLog 初始化，星灵开始漫游:，区域：，楼层：AirActionWanderingNew	Duration漫游-初始化
FurnitureFur
PointCondTakePointOnStart	SetStateAirPetStateOnFurniture#初始化，星灵与家具交互:，家具：
GetPstKey，索引点：IndexAirActionOnFurnitureStartInitActionSetRandomActionCfgIDStopMainAction	PopPoint#运行时，星灵走向漫游点:，区域:，楼层:AirActionMoveToWandering 运行时，星灵走向家具:CfgIDAirActionMoveToFurnitureStartMainAction         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �        self    �   pet    �   action    �   isInit    �   area   �   room      
petAction   z   area#   I   holder,   I   areaP   q   furnQ   q   condR   q   pointT   q   
petAction~   �   area�   �   holder�   �   point�   �   area�   �   furn�   �   cond�   �   point�   �      _ENV   *      "  � �
 �
���@��   ��FA GA�G��
@��G�@ �� �F�A G��A ��dA�
� �
@��& �    _point_social_cfgCfgcfg_aircraft_special_action Log
exception找不到特殊行为配置：_furniture_pet                                      !  !  !  "  "  "  "  "  '  )  *     self       pet       fur       cfgID       point          _ENV +  K   
R   G @ b   ��F@@ G�� ��  � A �@�� � d@  
�A�G B @�  �G�B L�� d� `@ �  �C@  C � 
@ ���G B G@� ��C ��C�� ��G B G � G@� G�� ��D � � �  �ǁB ��@ 䁀�  � �
���
�E� ���  *�@�G B G@� ��C ��E�� ��G�B L � d� b   ��G B G � G@� G�� ��D � � �  �ǁB ��@ 䁀�  � �
���
�E�@ ���  *�G�A f  & �    _socialLog
exception0社交反序列化行为不需要调用PreCheckdebug
traceback_available _cfg _furnitureAvailableCount        Type AircraftPetFurSpacialActionTypeWithGivenPointParams       pointsipairsHasAvailablePoint_availablePointNameOccupyFurnitureIsEmpty         R   ,  ,  ,  -  -  -  -  -  -  -  0  1  1  1  3  3  3  3  3  3  3  3  3  4  4  4  4  4  4  5  5  5  5  6  6  6  6  7  7  7  7  7  7  8  9  9  6  6  <  =  =  =  =  =  =  ?  ?  ?  ?  ?  @  @  @  @  A  A  A  A  B  B  B  B  B  B  C  D  D  A  A  J  J  K     self    R   pointNames!   0   (for generator)$   0   (for state)$   0   (for control)$   0   _%   .   name%   .   pointNames@   O   (for generator)C   O   (for state)C   O   (for control)C   O   _D   M   nameD   M      _ENV L  q   r   G @ b@   �F@@ G�� ��  d@ & � G A b   ��F@@ G�� �@ ƀA ���� � d@  G B b@  ��G�B L�� d� 
@��G@B  � ��F@@ G�� �@ ǀB ̀�� � GD LA�d d@  ��G B G�� ��D � E�� @�G�B L@� ǀE d��
@��G@B  �  	�F@@ G�� �� ǀE  G�B LA�d d@  ��G B G�� ��D ��F��  �G�B L�� ǀE d��
@��G@B  �  �F@@ G�� �  ǀE  G�B LA�d d@  G�B L@� � � d@�G D L�� ǀB ����  d@  G@B  � ��F@@ G�� �  ǀB ̀�� � GD LA�d d@  G@B f  & � !   _availableLog
exception5当前条件不可用，不可调用TakePointOnStart_social9社交反序列化行为不需要调用TakePointOnStart.debug
traceback_cfg_point_furniture	PopPoint Sit取不到家具点：
GetPstKey，星灵:_petTemplateIDType AircraftPetFurSpacialActionTypeWithGivenPointPopPointByName_availablePointName 找不到家具点，类型1：，家具：CfgIDOccupyFurnitureGetPointByName 找不到家具点，类型2：OccupyAllPointSetOccupyFurnitureInstanceID取不到家具点：         r   M  M  M  N  N  N  N  O  R  R  R  S  S  S  S  S  S  S  U  U  U  W  W  W  W  X  X  X  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Z  [  [  [  [  [  [  ]  ]  ]  ]  ]  ^  ^  ^  _  _  _  _  _  _  _  _  _  `  a  a  a  a  a  a  c  c  c  c  c  d  d  d  e  e  e  e  e  e  e  e  e  g  g  g  g  j  j  j  j  j  j  l  l  l  m  m  m  m  m  m  m  m  m  m  m  p  p  q     self    r      _ENV r  �   4   G @ b   � �F@@ ��  d@ ��G�@ b@  ��F A G@� �� ��A � �� � d@  & � G@B b@   �G�B L�� � C d@� �G@B G@� ��C ��C��  �G�B L�� � C d@�@�G@B G@� ��C � D�� � �G�B L@� �   d@�G�D L�� �   d@�& �    _socialAirLog(社交反序列化行为释放家具点_availableLog
exception8当前条件不可用，不可调用ReleasePointOnStop.debug
traceback_cfg_furnitureReleasePoint_pointType AircraftPetFurSpacialActionTypeWithGivenPointOccupyFurnitureOccupyAllPoint_petSetOccupyFurniture         4   s  s  s  t  t  t  t  v  v  v  w  w  w  w  w  w  w  x  {  {  {  |  |  |  |  |  }  }  }  }  }  }  ~  ~  ~  ~  ~              �  �  �  �  �  �  �  �  �     self    4      _ENVD                     	      	                                                    ,       /   =   /   ?   �   ?   �   �   �   �     �           	  
                        *    +  K  +  L  q  L  r  �  r  �     PetCfgAction1   D      _ENV