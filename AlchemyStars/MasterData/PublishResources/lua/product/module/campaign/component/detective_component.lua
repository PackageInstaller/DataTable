LuaS �

xV           (w@S@../PublishResources/lua/product/module/campaign/component/detective_component.lua         (    @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ ��@ l�  
@���@ l�  
@ ��@ l  
@���@ l@ 
@ ��@ l� 
@���@ l� 
@ ��@ l  
@���@ l@ 
@ �& �    requirecomponent_base_classDetectiveComponentICampaignComponentConstructorComponentInfoGetComponentInfoGetComponentTypeInitComponentInfoHandleSubmitItemHandleSubmitEndingHandleAutoSaveHandleStartGameGetCurrentEndingId    
       
       F@@ L�� d� 
@ �
 ��& �    m_component_infoClientDetectiveComponentInfoNewm_endingId                                	   
      self          _ENV        
   G @ b@  � �F@@ L�� d� 
@ �G @ f  & �    m_component_infoClientDetectiveComponentInfoNew         
                                    self    
      _ENV           L @ e  f   & �    ComponentInfo                          self                      F @ G@� f  & �    CampaignComTypeE_CAMPAIGN_COM_DETECTIVE                           self          _ENV    "       � @ �@@ǀ� �@ ����  & �    ComponentDataHelper
ParseDatam_datam_component_info                                !   "      self       a_load_info       ret         _ENV +   F    +   �@ �A�� �� �����A�ʁ���A B@$� L�A d� �B �BB � @ ������ �@ �B �C �BCǂC_�@���C �D�B �C�B��  ��D�C �B��� ���D �E�����D� & �    DetectiveSubmitItemReqNewstage
clue_listfragment_list
talk_listDetectiveSubmitItemResComponentInfom_campaign_com_moduleCampaignComProtoRequestm_campaign_idm_component_idCampaignErrorTypeE_CAMPAIGN_ERROR_TYPE_SUCCESS	m_resultLogerror8[CampaignCom][DetectiveComponent] HandleSubmitItem ret:retm_component_info	cur_info         +   ,   ,   ,   -   .   /   0   1   1   1   3   3   5   5   6   7   8   9   :   <   5   >   >   >   >   >   ?   ?   ?   ?   ?   @   B   B   B   B   B   C   C   C   E   E   F   
   self    +   TT    +   	asyncRes    +   	stage_id    +   
clue_list    +   fragment_list    +   
talk_list    +   request   +   	response
   +   ComponentInfo   +      _ENV M   g    )   @ A@$� 
� �F�@ LA�d� �A �� �AA ́�@� � ��AB@ ���A 
���ƁB ���C_ �@��AC ǁ�� GC�A��  ���B �B �� ��AD ������� & �    DetectiveSubmitEndingReqNew
ending_idDetectiveSubmitEndingResComponentInfom_campaign_com_moduleCampaignComProtoRequestm_campaign_idm_component_idm_endingIdCampaignErrorTypeE_CAMPAIGN_ERROR_TYPE_SUCCESS	m_resultLogerror:[CampaignCom][DetectiveComponent] HandleSubmitEnding ret:retm_component_infocg_list         )   N   N   N   O   P   P   P   R   R   T   T   U   V   W   X   Y   [   T   ]   _   _   _   _   _   `   `   `   `   `   a   c   c   c   c   c   d   d   d   f   f   g      self    )   TT    )   	asyncRes    )   
ending_id    )   request   )   	response   )   ComponentInfo	   )      _ENV l   �    *   � @ �@�� �@ A@$� L�@ d� �A �AA � @ ������ �@ �A �B �ABǁB_�@���B �C�A �B�A��  ��C�B �A��@���C �D�����C �AD������C� & �    DetectiveAutoSaveReqNewDetectiveAutoSaveResComponentInfom_campaign_com_moduleCampaignComProtoRequestm_campaign_idm_component_idCampaignErrorTypeE_CAMPAIGN_ERROR_TYPE_SUCCESS	m_resultLogerror6[CampaignCom][DetectiveComponent] HandleAutoSave ret:retm_component_info
is_recordauto_save_record_time         *   m   m   m   n   n   n   p   p   r   r   s   t   u   v   w   y   r   {   {   {   {   {   |   |   |   |   |   }                  �   �   �   �   �   �   �   �   �      self    *   TT    *   	asyncRes    *   request   *   	response   *   ComponentInfo   *      _ENV �   �    (   @ A@$� 
� �F�@ LA�d� �A �� �AA ́�@� � ��AB@ ���A �AB ǁ��B_ �@��C �A�� G�B�A��  ���BB �B �� ��D �������� & �    DetectiveReadRecordPlayReqNew	cur_infoDetectiveReadRecordPlayResComponentInfom_campaign_com_moduleCampaignComProtoRequestm_campaign_idm_component_idCampaignErrorTypeE_CAMPAIGN_ERROR_TYPE_SUCCESS	m_resultLogerror7[CampaignCom][DetectiveComponent] HandleStartGame ret:retm_component_info         (   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    (   TT    (   	asyncRes    (   info    (   request   (   	response   (   ComponentInfo	   (      _ENV �   �       G @ f  & �    m_endingId           �   �   �      self           (                                 
                                    "      +   F   +   M   g   M   l   �   l   �   �   �   �   �   �   �          _ENV