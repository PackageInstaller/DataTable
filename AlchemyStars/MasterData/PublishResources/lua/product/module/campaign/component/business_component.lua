LuaS �

xV           (w@R@../PublishResources/lua/product/module/campaign/component/business_component.lua         @    @ A@  ��@ $@�@@  ��@@ l   
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
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��& �    _classBusinessComponentICampaignComponentConstructorComponentInfoGetComponentInfoGetComponentTypeInitComponentInfoGetInfoGetHarborEventGetNeedProGetFinalProHandleBusinessSelectReqHandleBusinessHarborReqHandleBusinessShipReqHandleBusinessHireSeamanReqHandleBusinessWorkSeamanReqHandleBusinessSailingReqGetServerTimeHasRedHasRedHarborLvHasRedShipLv                  F@@ L�� d� 
@ �& �    _componentInfoBusinessComponentInfoNew                              self          _ENV 
       
   G @ b@  � �F@@ L�� d� 
@ �G @ f  & �    _componentInfoBusinessComponentInfoNew         
                                    self    
      _ENV           L @ e  f   & �    ComponentInfo                          self                      F @ G@� f  & �    CampaignComTypeE_CAMPAIGN_BUSINESS                           self          _ENV           � @ �@@ǀ� �@ ����  & �    ComponentDataHelper
ParseDatam_data_componentInfo                                    self       a_load_info       ret         _ENV "   @    
B   � @ �� �@@�@�_��� � �G�@GA�&�A $� FAA G����  ����A ���d� _��� �����@����B �C�A   �A��� ��G�������B ���@��D �ADƁD �� ��D���B���ǁ���!�@ ��� ���AE ��E�� ���A@ʁ� �F ́�� ʁ�@
   @�&�& �    ComponentInfoharborInfo 	shipInfoGetComponentCfgIdCfgcfg_component_business_harborComponentID	HarborIDLv       Log
exception6cfg_component_business_harbor 中找不到组件, ID:	LockItem        GameGlobal
GetModuleItemModuleGetItemCount       BusinessHarborInfoNewlvBusinessShipInfo         B   #   #   $   $   %   %   &   &   &   &   )   )   *   *   *   *   *   *   *   +   +   +   +   +   ,   ,   ,   ,   ,   -   -   /   0   0   0   0   1   1   1   1   1   1   1   1   2   2   2   2   3   3   7   7   7   8   9   9   ;   ;   ;   <   =   =   ?   ?   ?   @   	   self    B   
harbor_id    B   ComponentInfo   B   info   B   componentId   B   
cfgHarbor   B   count,   2   hinfo5   B   sinfo;   B      _ENV F   r    C   �   � @ � A@ �� $���@  ��  �@ $� FA GA����G��_��� �����@@��B �AB�� ���A��  ��B �C�A��� �  � G���� (�  @�� dC \ ��@��B �CB�   �C��  �CD ��D��  ����ǃ�D E@ ��$D��D E@ ��$D�'B��  & �    ComponentInfoGetInfo GetComponentCfgIdCfgcfg_component_business_global	globalId       Log
exception0cfg_component_business_global 中找不到, ID:tablecloneeventIdCom
OnceRound        @cfg_component_business_global [table.count(randomIds) == 0] ID:mathrandomtableinsert         V   _    	   F @ G@� � � d� � @ �@@ƀ@�� �� @ �K   I � F�@ ��@d ���@ �A��  ����@A ��@ ��A�   ��A�i�  �@�& �    tablecount
EventPoolpairsintable insert            W   W   W   W   W   W   W   W   W   W   X   X   Z   Z   Z   Z   [   [   [   [   [   [   [   \   \   \   \   \   Z   Z   _      
randomIds       (for generator)      (for state)      (for control)      k1      v1         _ENVecomcfgC   G   H   H   I   I   I   I   I   J   M   M   N   N   N   N   O   O   O   O   O   P   P   P   P   P   Q   T   T   T   T   _   a   a   a   a   b   c   c   c   e   f   f   g   g   g   g   g   h   k   k   k   k   k   l   m   m   m   m   m   n   n   n   n   n   a   q   r      self    C   
harbor_id    C   ids   C   ComponentInfo   C   componentId   C   cfg   C   ecom   C   cb   C   (for index)"   A   (for limit)"   A   (for step)"   A   i#   @   
randomIds$   @   len(   @   index5   @   newId6   @      _ENV x   �    P   @ �� $��_@@@ �@�@ ���  � ��@ �� �A �A��  
��
B���   @ �cB   �GBB
B�� _@�� ���@@���B CAB � $B��  & A �CK�  J��JB���   @ ��B�  ��B�J��$� _@@� �G�B@���F�B G�� � dB�A�  f ǁ��BGBD��D ��D��BG���BDƂD ��͂����BD�D CE�B����G�Ef & �    GetInfo         GetComponentCfgIdCfgcfg_component_business_harborComponentID	HarborIDLvlv       Log
exception6cfg_component_business_harbor 中找不到组件, ID:cfg_component_business_shipShipID4cfg_component_business_ship 中找不到组件, ID:
NeedValueBusinessProTypeBPT_Command	BPT_SailBPT_FixUnloadSpeed	Boatload         P   y   y   y   z   z   z   z   {   {   ~   ~                                       �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   	   self    P   
harbor_id    P   
harbor_lv    P   ship_lv    P   harborInfo   P   	shipInfo   P   componentId   P   
cfgHarbor   P   cfgShip/   P      _ENV �   �    �   @ �� $_@@@ �@�@ ���  � ��@ �� �A �B��  
��
C���  @ �cC   �GCB
C�� _@�� ���@@���B CAC � $C��  & A �CK�  J��JC���  @ ��C�  ��C�J��$� _@@� �G�B@���F�B G�� � dC�A�  f ǂ��B�   @ ��@    ���  �   @ ��@    ���  "  @ �"A    ��  b  @ �bA    �A�  GCD�@ �@  ���  G�D��D �E��BG���@�G�D��D �CE��BG��AG�D��D ��E��BG��MA�F�E ��d@��A �DF	�D	@@	����B ��	� @��D���  � ��F	�D E
�B
��	�����F	�D EE
�B
��	���F	�D �E
�B
��	M��i�  ���l  ����GF�D G�M��D�����  GG��D �DE	��B	G��䃀���� �GG��D ��E	��B	G��䃀����D �C����G�F�G G�� d�  �GDD�D�S����G �H	���� O�H	� ��  @����  �� & � #   GetInfo         GetComponentCfgIdCfgcfg_component_business_harborComponentID	HarborIDLvlv       Log
exception6cfg_component_business_harbor 中找不到组件, ID:cfg_component_business_shipShipID4cfg_component_business_ship 中找不到组件, ID:	Boatload
BaseValueBusinessProTypeBPT_Command	BPT_SailBPT_Fixpairsseamanscfg_component_business_seaman0cfg_component_business_seaman 中找不到, ID:	ProValue
NeedValueBPT_MaxBaseRewardValuemathfloorUnloadSpeed               �   �       ! � ���@  � @�@@ �� � @�   ��@  ƀ@ �� ��@ � ��� ��@ �� �  & �          �?	PassRateNoPassRateMinRate          �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      inValue       inNeed          cfgShip�   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    �   
harbor_id    �   boatloadValue    �   commandValue    �   
sailValue    �   	fixValue    �   
harbor_lv    �   ship_lv    �   harborInfo   �   	shipInfo   �   componentId   �   
cfgHarbor   �   cfgShip/   �   (for generator)k   �   (for state)k   �   (for control)k   �   keyl   �   valuel   �   
cfgSeamano   �   	callBack�   �   a�   �   incomeRate�   �   income�   �   cdValue�   �      _ENV �   �    "   @ A@$� 
� �F�@ LA�d� �A �� �AA ́�@� � ��AB@ ���A �AB ǁ��B_ ����C �A�� G�B�A��  �   �����f & �    BusinessSelectReqNew
harbor_idBusinessSelectResultComponentInfom_campaign_com_moduleCampaignComProtoRequestm_campaign_idm_component_idCampaignErrorTypeE_CAMPAIGN_ERROR_TYPE_SUCCESS	m_resultLogerror>[CampaignCom][BusinessComponent] HandleBusinessSelectReq ret:	harborId         "   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    "   TT    "   	asyncRes    "   
harbor_id    "   request   "   	response   "   ComponentInfo	   "      _ENV �      )   @ A@$� 
� �F�@ LA�d� �A �� �AA ́�@� � ��AB@ ���A �AB ǁ��B_ ����C �A�� G�B�A��  � ����C ��@ �CD
��  j��f & �    BusinessHarborReqNewcfg_idBusinessHarborResultComponentInfom_campaign_com_moduleCampaignComProtoRequestm_campaign_idm_component_idCampaignErrorTypeE_CAMPAIGN_ERROR_TYPE_SUCCESS	m_resultLogerror>[CampaignCom][BusinessComponent] HandleBusinessHarborReq ret:pairsinfoharborInfo         )                            	  
                                                             self    )   TT    )   	asyncRes    )   cfgID    )   request   )   	response   )   ComponentInfo	   )   (for generator)"   '   (for state)"   '   (for control)"   '   key#   %   value#   %      _ENV    =   )   @ A@$� 
� �F�@ LA�d� �A �� �AA ́�@� � ��AB@ ���A �AB ǁ��B_ ����C �A�� G�B�A��  � ����C ��@ �CD
��  j��f & �    BusinessShipReqNewcfg_idBusinessShipResultComponentInfom_campaign_com_moduleCampaignComProtoRequestm_campaign_idm_component_idCampaignErrorTypeE_CAMPAIGN_ERROR_TYPE_SUCCESS	m_resultLogerror<[CampaignCom][BusinessComponent] HandleBusinessShipReq ret:pairsinfo	shipInfo         )   "  "  "  #  %  %  %  (  (  *  *  +  ,  -  .  /  1  *  3  3  3  3  3  4  4  4  4  4  5  5  5  7  7  7  7  8  8  7  7  <  =     self    )   TT    )   	asyncRes    )   cfgID    )   request   )   	response   )   ComponentInfo	   )   (for generator)"   '   (for state)"   '   (for control)"   '   key#   %   value#   %      _ENV C  a   *   F@ LA�d� J� �J���A �A@�� �AA � �A �A�� � �GC���� $B �B �BGC_@��BC �CA� �C$B�  & ��D GBD$@ �G��J�)�  ���� & �    BusinessHireSeamanReqNewcfg_id_harborcfg_id_seamanBusinessHireSeamanResultComponentInfom_campaign_com_moduleCampaignComProtoRequestm_campaign_idm_component_idCampaignErrorTypeE_CAMPAIGN_ERROR_TYPE_SUCCESS	m_resultLogerrorB[CampaignCom][BusinessComponent] HandleBusinessHireSeamanReq ret:pairsinfoseamanInfo         *   E  E  E  F  G  I  I  I  L  L  N  N  O  P  Q  R  S  U  N  W  W  W  W  W  X  X  X  X  X  Y  Y  Y  [  [  [  [  \  \  [  [  `  a     self    *   TT    *   	asyncRes    *   cfg_id_harbor    *   cfg_id_seaman    *   request   *   	response   *   ComponentInfo
   *   (for generator)#   (   (for state)#   (   (for control)#   (   key$   &   value$   &      _ENV g  �   2   F@ LA�d� J� �J���A �A@�� �AA � �A �A�� � �GC���� $B �B �BGC_@��BC �CA� �C$B�  & ��D GBD$@ �GC�J�)�  ���D G�D$@ �G��J�)�  ���� & �    BusinessWorkSeamanReqNewwork_idseamansBusinessWorkSeamanResultComponentInfom_campaign_com_moduleCampaignComProtoRequestm_campaign_idm_component_idCampaignErrorTypeE_CAMPAIGN_ERROR_TYPE_SUCCESS	m_resultLogerrorB[CampaignCom][BusinessComponent] HandleBusinessWorkSeamanReq ret:pairs	shipInfoseamanInfo         2   i  i  i  j  k  m  m  m  p  p  r  r  s  t  u  v  w  y  r  {  {  {  {  {  |  |  |  |  |  }  }  }          �  �      �  �  �  �  �  �  �  �  �  �     self    2   TT    2   	asyncRes    2   work_id    2   seamans    2   request   2   	response   2   ComponentInfo
   2   (for generator)#   (   (for state)#   (   (for control)#   (   key$   &   value$   &   (for generator)+   0   (for state)+   0   (for control)+   0   key,   .   value,   .      _ENV �  �   C   @ B@$� 
� �
��
B�
���
��F�A LB�d� �B �� �BB ̂�@� � ��BC@ ���B �BC ǂ��C_ ����D �B�� G�C�B��  � @���D ��@ �E
��  j����D C��@ �DE
��  j����D ���@ ��E
��  j�������������B���f & �    BusinessSailingReqNew
harbor_id
event_ids	event_opincomecd_timeBusinessSailingResultComponentInfom_campaign_com_moduleCampaignComProtoRequestm_campaign_idm_component_idCampaignErrorTypeE_CAMPAIGN_ERROR_TYPE_SUCCESS	m_resultLogerror?[CampaignCom][BusinessComponent] HandleBusinessSailingReq ret:pairsharborInfoglobalInfo
eventInfo	globalId
globalNumeventIdCom         C   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    C   TT    C   	asyncRes    C   
harbor_id    C   
event_ids    C   	event_op    C   income    C   cd_time    C   request   C   	response   C   ComponentInfo   C   (for generator)&   +   (for state)&   +   (for control)&   +   key'   )   value'   )   (for generator).   3   (for state).   3   (for control).   3   key/   1   value/   1   (for generator)6   ;   (for state)6   ;   (for control)6   ;   key7   9   value7   9      _ENV �  �      F @ G@� d�� L�� ��@ d��� A �@A̀� � ����� �  & �    GameGlobal
GameLogic
GetModuleSvrTimeModulemathmodfGetServerTime�                  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       	time_mod      	tmSecond      nMilliSecond         _ENV �  �   ,   L @ d� �@@ �� ƀ@ ���A  
� �� @����A �AA � $A�  &   FAB ��d�������@A�����
�B�C ���_@A �CC!@ @ �� & i�  �A�C  f & �    GetServerTimeGetComponentCfgIdCfgcfg_component_business_harborComponentID Log
exception6cfg_component_business_harbor 中找不到组件, ID:pairs	HarborIDGetInfocdEnd         ,   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    ,   curTime   ,   componentId   ,   
cfgHarbor	   ,   reTab   ,   (for generator)   )   (for state)   )   (for control)   )   key   '   value   '   harborInfo    '   	shipInfo    '      _ENV �     e   L @ d� �@@ �� ƀ@ ���A  
� �� @����A �AA � $A�  &   FAB ��d ������@A ����
�B�C ���_@A@��@ �@K�  J� ����J����C��CJ���$� _@A@�G�C_@���G�C�  ����� ���@�ƃD ���E � �C�G�G��䃀��E!�� ���   ��� �B�����@�� ��� � @��CB ������D �D
FE $� EE
���	$��G��	! �
@ �C� f �  jD�i�  ��C  f & �    GetServerTimeGetComponentCfgIdCfgcfg_component_business_harborComponentID Log
exception6cfg_component_business_harbor 中找不到组件, ID:pairs	HarborIDGetInfoLvlv       	LockItem        GameGlobal
GetModuleItemModuleGetItemCount       	CostItem         e   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �                                           	  	  
  
  
                                            �  �           self    e   curTime   e   componentId   e   
cfgHarbor	   e   reTab   e   (for generator)   b   (for state)   b   (for control)   b   key   `   value   `   harborInfo    `   	shipInfo    `   cfgmap,   `   cfg2   `   isen3   `   count?   D   (for generator)Q   `   (for state)Q   `   (for control)Q   `   senKR   ^   sennVR   ^   countY   ^      _ENV   B   O   L @ d� �@@ �� ƀ@ ���A  
� �� @����A �AA � $A�  &   FAB ��d�������@A�����
�B�C ���_@��	��@ �@K�  J� ����J�������CJ���$� _@A��G�C_@� �G�C��@A� ��� � @��CB ������DD Ǆ�	�D � ��	G�C	䄀EE	!�
@ �� & ��  *D�i�  ��C  f & �    GetServerTimeGetComponentCfgIdCfgcfg_component_business_shipComponentID Log
exception4cfg_component_business_ship 中找不到组件, ID:pairsShipIDGetInfoLvlv       	CostItemGameGlobal
GetModuleItemModuleGetItemCount                O       !  !  "  "  "  "  "  #  #  $  $  $  $  $  %  %  (  )  )  )  )  *  *  *  *  +  +  -  -  -  .  .  /  /  /  /  /  /  /  /  /  /  0  0  0  0  0  1  2  2  2  3  3  3  5  5  5  5  6  6  6  6  6  6  6  7  7  7  8  8  5  5  )  )  A  A  B     self    O   curTime   O   componentId   O   cfgShip	   O   reTab   O   (for generator)   L   (for state)   L   (for control)   L   key   J   value   J   harborInfo    J   	shipInfo    J   cfgmap,   J   cfg2   J   (for generator);   J   (for state);   J   (for control);   J   senK<   H   sennV<   H   countC   H      _ENV@                              
      
                              "   @   "   F   r   F   x   �   x   �   �   �   �   �   �   �     �      =     C  a  C  g  �  g  �  �  �  �  �  �  �  �  �  �    �    B    B         _ENV