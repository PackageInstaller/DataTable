LuaS �

xV           (w@X@../PublishResources/lua/product/module/campaign/component/random_lottery_component.lua         7    @ A@  ��@ $@�@@  ��@@ l   
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
@ �& �    _classRandomLotteryComponentICampaignComponentConstructorComponentInfoGetComponentInfoGetComponentTypeInitComponentInfo
ClearDrawHandleReceiveRandomLotteryCost!HandleRandomLotteryComponentDraw'HandleRandomLotteryComponentDrawRewardCampaignComponentPushNotify
GetCfgMapGetFirstCfgGetCfgMainGetProbablityCfgHasRedHasRewardRed                  F@@ L�� d� 
@ �& �    _componentInfoRandomLotteryComponentInfoNew                              self          _ENV 
       
   G @ b@  � �F@@ L�� d� 
@ �G @ f  & �    _componentInfoRandomLotteryComponentInfoNew         
                                    self    
      _ENV           L @ e  f   & �    ComponentInfo                          self                      F @ G@� f  & �    CampaignComTypeE_CAMPAIGN_RANDOM_LOTTERY                           self          _ENV           � @ �@@ǀ� �@ ����  & �    ComponentDataHelper
ParseDatam_data_componentInfo                                    self       a_load_info       ret         _ENV !   &       � @ �� �@� �����   �� �& �    ComponentInfodraw_refresh_timem_draw           #   #   $   $   %   %   &      self       msgInfo       ComponentInfo           +   H    &   F@ LA�d� J� �J���A �A@�� �AA � �A �A�� � �GC���� $B �B �BGC_@��BC �CA� �C$B�  & � �D��BD���� & �    RandomLotteryComponentCostReqNewcfg_idis_oneRandomLotteryComponentCostRepComponentInfom_campaign_com_moduleCampaignComProtoRequestm_campaign_idm_component_idCampaignErrorTypeE_CAMPAIGN_ERROR_TYPE_SUCCESS	m_resultLogerrorJ[CampaignCom][RandomLotteryComponent] HandleReceiveRandomLotteryCost ret:m_one_countm_multi_count         &   -   -   -   .   /   1   1   1   4   4   6   6   7   8   9   :   ;   =   6   ?   ?   ?   ?   ?   @   @   @   @   @   A   A   A   C   C   D   D   G   H      self    &   TT    &   	asyncRes    &   cfgID    &   isOne    &   request   &   	response   &   ComponentInfo
   &      _ENV M   j    *   @ A@$� 
� �F�@ LA�d� �A �� �AA ́�@� � ��AB@ ���A �AB ǁ��B_ ����C �A�� G�B�A��  �  ���C ��BDGB��A�ǁ�����������f & �    RandomLotteryComponentDrawReqNewcfg_idRandomLotteryComponentDrawRepComponentInfom_campaign_com_moduleCampaignComProtoRequestm_campaign_idm_component_idCampaignErrorTypeE_CAMPAIGN_ERROR_TYPE_SUCCESS	m_resultLogerror=RandomLotteryComponent:HandleRandomLotteryComponentDraw ret:tableinsertm_drawm_one_countm_multi_count         *   O   O   O   P   R   R   R   U   U   W   W   X   Y   Z   [   \   ^   W   `   `   `   `   `   a   a   a   a   a   b   b   b   d   d   d   d   d   e   e   f   f   i   j      self    *   TT    *   	asyncRes    *   cfgID    *   request   *   	response   *   ComponentInfo	   *      _ENV o   �    %   @ A@$� N��
A�FA LA�d� �AA �� ǁA ���@� � �BCB@ ���A ƁB ���C_ ����AC ǁ�� GC�A��  � � ��D���f & �    $RandomLotteryComponentDrawRewardReqNewindex       $RandomLotteryComponentDrawRewardRepComponentInfom_campaign_com_moduleCampaignComProtoRequestm_campaign_idm_component_idCampaignErrorTypeE_CAMPAIGN_ERROR_TYPE_SUCCESS	m_resultLogerror@RandomLotteryComponent:RandomLotteryComponentDrawRewardReq ret:m_draw         %   q   q   q   r   r   t   t   t   w   w   y   y   z   {   |   }   ~   �   y   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    %   TT    %   	asyncRes    %   index    %   request   %   	response   %   ComponentInfo
   %      _ENV �   �       � @ �@@ǀ� � ����@ � A�� �@A ǀ��� @ 䀀�   � �B � $A� �AB �BA� ��$A�& �    !RandomLotteryComponentNotifyType#RandomLotteryComponentNotify_Clearm_notify_type"NotifyRandomLotteryComponentClearNewComponentDataHelper
ParseDatam_data
ClearDrawLogerrorX[CampaignCom][RandomLotteryComponent] CampaignComponentPushNotify ParseData error! ret:            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       notify_data       ev      ret         _ENV �   �       L @ d� �@@ ��@�@  �@����  A���@A ǀ�� @� �@��   �  �  & �    GetComponentCfgIdCfgcfg_component_random_lotteryComponentID Log
exception3cfg_component_random_lottery 中找不到组件ID:            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       componentId      cfgMap         _ENV �   �       L @ d� �@@ ��@�@  �@����  A���@A ǀ�� @� �@��   �  � B�  & � 	   GetComponentCfgIdCfgcfg_component_random_lotteryComponentID Log
exception3cfg_component_random_lottery 中找不到组件ID:                   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       componentId      cfgMap         _ENV �   �       L @ d� �@@ ��@�@  �@����  A���@A ǀ�� @� �@��   �  � B�  & � 	   GetComponentCfgIdCfgcfg_junior_skin_drawComponentID Log
exception+cfg_junior_skin_draw 中找不到组件ID:                   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       componentId      cfg         _ENV �   �       L @ d� �@@ ��@�@  �@����  A���@A ǀ�� @� �@��   �  �  & �    GetComponentCfgIdCfg cfg_junior_skin_draw_probablityComponentID Log
exception6cfg_junior_skin_draw_probablity 中找不到组件ID:            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       componentId      cfgs         _ENV �   �    !   L @ d� @� @ ��   �  ��@ ��@� A �� �@A  � � @���  ����B���$��"B    �� GB�  �@ �C� f �  j���   �  & � 
   
GetCfgMap GameGlobal
GetModuleItemModulepairsCostItemID        GetItemCountOneCostCount         !   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   	   self    !   cfgMap   !   module
   !   (for generator)      (for state)      (for control)      key      value      count         _ENV �   �    	   L @ d� �@  ƀ@ �� � @�� AB��A@ �  & �  j��@@@ ��   �  � � �  & �    ComponentInfo        pairsm_draw       is_get            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       ComponentInfo      num      (for generator)      (for state)      (for control)      key      value         _ENV7                              
      
                              !   &   !   +   H   +   M   j   M   o   �   o   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �          _ENV