LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1905/client/Assets/../PublishResources/lua/product/components/ui/aircraft/new/social/air_social_area.lua         �    @ A@  ��@ $@�@@  ���  A  �  �@ A@ l  
A�A@ lA  
A��A@ l�  
A�A@ l�  
A��A@ l 
A�A@ lA 
A��A@ l� 
A�A@ l� 
A��A@ l 
A�A@ lA 
A��A@ l� 
A�A@ l� 
A��A@ l 
A�A@ lA 
A��A@ l� 
A�A@ l� 
A��A@ l 
A�A@ lA 
A��A@ l� 
A�A@ l� 
A��A@ l 
A�A@ lA 
A��A@ l� 
A�A@ l� 
A��A@ l 
A�A@ lA 
A��A@ l� 
A�A@ l� 
A��A@ l 
A�A@ lA 
A��A@ l� 
A�@ AA	 �A@ $A�AI  ��AI l� 
A�AI l 
A��AI lA 
A�AI l� 
A�@ AA
 �A@ $A�AJ  ��AJ l� 
A�AJ l	 
A�AJ lA	 
A��AJ l�	 
A�& � ,   _classAirSocialAreaObject��            �      ConstructorDisposeRandomAllPetStartAllPetActionSetAllPetSocialStateGetAreaTypeGetPetsAddPet
RemovePetAddLibGetLibs
RemoveLibGetRoomSetFurnitureGetFurnitureIsFurnitureInteractGetMainLibTypeInitLibMakerInitMaxRoundGetLibMakerGetStateTypesSetSocialRoundGetSocialRound_SetRemainTimeGetMaxRoundCalRemainTimeByRoundGetRemainTimeSetSocialPointHolderIndexGetSocialPointHolderIndexSetSocialPetCountGetSocialPetCountAirSocialWorkAreaGetAreaTypeSetSpaceIdGetSpaceIdAirSocialHappyAreaSetRestAreaTypeGetRestAreaType    '              
@ ��   
����   
� �
 ��
 ��
�A�
�A�
�& �    
m_AirMainm_Petsm_LibTypesm_LibMaker m_Furniturem_SocialRound        m_RemainTimelog                                               self       aircraftMain               '    
   � @ @� �@��   
���ǀ@ �   � �ǀ@ ����@ 
 A��@  ���@A �A � @ ���$B �  j��� B �@��A �@ & � 
   RandomAllPetm_LibTypesm_LibMakerDispose pairsm_PetsResetSocialParamtableclear                                                        "   "   "   "   #   #   "   "   &   &   &   &   '      self       needRandom       isLeave       (for generator)      (for state)      (for control)      key      pet         _ENV *   6       � @ �   @��@@ � @ � ��� b    ���$� "   ��@ A��$B�����  *A�& �    m_PetspairsIsAlive
m_AirMainRandomActionForPet            +   +   +   ,   ,   ,   ,   .   /   /   /   /   /   /   0   0   0   0   0   ,   ,   6      self       needRandom       (for generator)      (for state)      (for control)      key      _pet      pet         _ENV 8   @    	   G @ b    �F@@ � @ d � ���́@�A i�  ��& �    m_PetspairsStartIdleAction            9   9   9   :   :   :   :   <   =   =   :   :   @      self       (for generator)      (for state)      (for control)      key   
   _pet   
   pet   
      _ENV C   L       G @ b   ��F@@ � @ d @���Ɓ@ �  LAd �A  �AAF�A G���A�i�  ���& �    m_PetspairsAirLog星灵开始社交:TemplateID	SetStateAirPetStateSocial            D   D   D   E   E   E   E   G   H   H   H   H   H   I   I   I   I   E   E   L      self       (for generator)      (for state)      (for control)      key      _pet      pet         _ENV N   O       & �                O      self            R   T       G @ f  & �    m_Pets           S   S   T      self            W   Y       � @ ʀ� & �    m_Pets           X   X   Y      self       petId       pet            \   ^       � @ �@� & �    m_Pets            ]   ]   ^      self       petId            a   c       � @ �@� & �    m_LibTypes           b   b   c      self       libType            f   h       G @ f  & �    m_LibTypes           g   g   h      self            k   m       � @ �@� & �    m_LibTypes            l   l   m      self       libType            p   s       F @ G@� ��  d@ D   f  & �    Logerror&AirSocialArea:GetRoom() need override            q   q   q   q   r   r   s      self          _ENV v   �    (   
@ ��@    ����@@ ǀ��@ �@ �   
���� @ � �� A F�A � d���A!�  ��B C�$� @��B i�  �A�F�A ��@ d ����@ �B$ �B  i�  ��& �    m_Furnituretableclearm_PetsAvailableCount        pairs       AddPetTemplateIDSetSocialFurnitureKey
GetPstKey         (   x   y   y   y   |   |   |   |   ~   ~            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    (   f    (   pets    (   	allCount   '   index   '   (for generator)      (for state)      (for control)      _      pet      (for generator)   '   (for state)   '   (for control)   '   key    %   pet    %      _ENV �   �       G @ f  & �    m_Furniture           �   �   �      self            �   �       G @ @�   �C@  C � f  & �    m_Furniture            �   �   �   �   �   �   �      self            �   �       G @ b@  @�F@@ G�� ��@ d� G � 
@ �G @ f  & �    m_FinalLibTypetablekeysm_LibTypes                   �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �   �    P   b    �� @ �@@ǀ@ �� ��@ _��@ �� & �@A ��A   G�A �� 
� �� B �@ �@B ǀ@ � � �́BL�B d �A  ��  *A�� C @ A@G�@ $� C� �@ �@C �@ ��C �� ��C � �� ���@D � AB G�@ $� �L�D��dB�)�  �����D � �AE �E$�� �E�@ ��D � �A A� 䀀AB G�@ $@�L�B d� � ��]
B��)�  ���& �    tablecountm_Petsm_SocialPetCountm_LibMakerAirLibMakerNew
m_AirMainCalRemainTimeByRoundpairsSetSocialActionTypeGetMainLibTypeSetSocialPetCountInitMaxRoundGetAreaTypeAirSocialAreaTypeHappyGetRestAreaTypeSetSocialAreaTypemathrandomseedosclock@B     random       ��     a           P   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    P   isSerialize    P   	curCount      expectCount      (for generator)      (for state)      (for control)      key      pet      type(   P   type.   7   (for generator)1   7   (for state)1   7   (for control)1   7   key2   5   pet2   5   teamIdC   P   (for generator)F   O   (for state)F   O   (for control)F   O   keyG   M   valueG   M      _ENV �   �    0   
@@�F�@ ��@ d ������ �AA ǁ�ǁ��   ���"  @���D  �B �BB�@ �A� ���B ��B�@ �A  ��B �BC�  �A� �BA ��C�B�D�@ ͂�
��i�  �@�G @ @�   �
@D�& �    m_MaxRound        pairsm_PetsTemplateIDCfgcfg_aircraft_pet
SocialTagAircraftSocialTagHotaircraft_social_reqing_timeNormal aircraft_social_zhengchang_timeLoneaircraft_social_lengmo_timecfg_aircraft_const	IntValue                0   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    0   (for generator)   +   (for state)   +   (for control)   +   key   )   pet   )   id   )   cfg
   )   tag   )   key   )   value&   )      _ENV �   �       G @ f  & �    m_LibMaker           �   �   �      self            �      L   A   �@@ �� ƀ@ ���� ��� A  ���@�� ��A �AF�A G���A �AB�@��  ��� ��A �BF�A G���A �AB�@��   �ƀ@ ���� ��� A  ������  �A �AF�A G��@ �  @��  �A �BF�A G��@ �  @�ƀ@ �@�� @�� A  ������  �A �AF�A G���@ �  ���  �A �BF�A G���@ �  & �           GetMainLibTypeAirSocialActionTypeGatherm_SocialRound        AirGroupActionStateTypeLocatedLookAtTalkMove	WalkTalk	MoveTalk
FurnitureFurnitureTalk         L   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �        self    L   index   L   	mainType   L      _ENV         
@ ��   ���@@ �@ � � ����@ $B��  j��� A �@ & �    m_SocialRoundpairsm_PetsSetSocialRoundCalRemainTimeByRound              	  	  
  
  
  
        
  
           self       round       syn       (for generator)      (for state)      (for control)      key   
   pet   
      _ENV         G @ f  & �    m_SocialRound                    self                 
   
@ ��@@ ǀ@ � � ���@G@ �A���  *��& �    m_RemainTimepairsm_PetsSetSocialRemainTime                                     self       time       (for generator)   
   (for state)   
   (for control)   
   key      pet         _ENV   $      L @ d� �@@ ��@�� � ���@ �  @��@@ � A�� @ ���@ �  �@ �  & �    GetMainLibTypeAirSocialActionTypeGatherm_MaxRound	WalkTalk                                                  !  !  #  #  $     self       
finalType         _ENV &  =   9   A   �@@ �� ƀ@ ���� ��� A  � �@�� � A � � O � 	�E ���ƀ@ �@�� ��� A  � �@��  A � � O �@�E ���ƀ@ ǀ�� ����A � �AB � �    �ǀB ���� � �GA �A � @ �  �E �̀C @� �@�& �            GetMainLibTypeAirSocialActionTypeGatherm_SocialRound	WalkTalk
Furniture
AirHelperIsActionSeqFurniturem_Furniturem_LibMakerGetSeqMakerGetRemainTime       _SetRemainTime          9   '  (  (  )  )  )  )  *  *  *  +  +  +  +  +  +  -  .  /  /  /  /  0  0  0  1  1  1  1  1  1  3  4  5  5  5  5  6  6  6  6  6  6  7  7  7  7  7  7  7  7  7  9  <  <  <  =     self    9   remainTime   9   
finalType   9      _ENVGATHER_ROUND	PER_TIMESOCIAL_TIMEWALKTALK_ROUND ?  A      G @ f  & �    m_RemainTime           @  @  A     self            C  J      
@ ��    ��@@ �@ � � ����@ $B��  j��& �    m_SocialPointHolderIndexpairsm_PetsSetSocialPointHolderIndex            D  E  E  F  F  F  F  G  G  G  F  F  J     self       pointHolderIndex       syn       (for generator)      (for state)      (for control)      key   
   pet   
      _ENV L  N      G @ f  & �    m_SocialPointHolderIndex           M  M  N     self            P  W      
@ ��    ��@@ �@ � � ����@ $B��  j��& �    m_SocialPetCountpairsm_PetsSetSocialPetCount            Q  R  R  S  S  S  S  T  T  T  S  S  W     self       count       syn       (for generator)      (for state)      (for control)      key   
   pet   
      _ENV Y  [      G @ f  & �    m_SocialPetCount           Z  Z  [     self            c  e      F @ G@� f  & �    AirSocialAreaTypeWork            d  d  d  e     self          _ENV f  h      
@ �& �    
m_SpaceId           g  h     self       spaceId            j  l      G @ f  & �    
m_SpaceId           k  k  l     self            n  p      G @ L@� ǀ@ e �f   & �    
m_AirMainGetRoomBySpaceID
m_SpaceId           o  o  o  o  o  p     self            y  {      F @ G@� f  & �    AirSocialAreaTypeHappy            z  z  z  {     self          _ENV ~  �      
@ �& �    m_RestAreaType             �     self       type            �  �      G @ f  & �    m_RestAreaType           �  �  �     self            �  �      G @ L@� ǀ@ e �f   & �    
m_AirMainGetRoomByAream_RestAreaType           �  �  �  �  �  �     self           �                        	   
                  '      *   6   *   8   @   8   C   L   C   N   O   N   R   T   R   W   Y   W   \   ^   \   a   c   a   f   h   f   k   m   k   p   s   p   v   �   v   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �     �                       $    &  =  &  ?  A  ?  C  J  C  L  N  L  P  W  P  Y  [  Y  `  `  `  `  a  a  c  e  c  f  h  f  j  l  j  n  p  n  v  v  v  v  w  w  y  {  y  ~  �  ~  �  �  �  �  �  �  �     SOCIAL_TIME   �   GATHER_ROUND   �   WALKTALK_ROUND	   �   	PER_TIME
   �      _ENV