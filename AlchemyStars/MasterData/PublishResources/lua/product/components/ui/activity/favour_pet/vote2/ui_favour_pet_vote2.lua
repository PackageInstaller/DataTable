LuaS 

xV           (w@a@../PublishResources/lua/product/components/ui/activity/favour_pet/vote2/ui_favour_pet_vote2.lua         @    @ A@  $@ @ AÀ   A $@À@  À@ l   
@À@ l@  
@ À@ l  
@À@ lÀ  
@ À@ l  
@À@ l@ 
@ À@ l 
@À@ lÀ 
@ À@ l  
@À@ l@ 
@ À@ l 
@À@ lÀ 
@ À@ l  
@À@ l@ 
@ À@ l 
@À@ lÀ 
@ À@ l  
@À@ l@ 
@ &     require"ui_side_enter_center_content_base_classUIFavourPetVote2UISideEnterCenterContentBaseDoInitDoShowDoHide
DoDestroy_ForceRefresh	_Refresh_SetRemainingTime	_SetCoin
_SetQuest	_SetList_PlayAnim_List_SetReqTime_VoteBtnOnClick_Start_HandleVoteIntroBtnOnClick_AttachEvent_DetachEventOnUIGetItemCloseInQuest                  @@ @
  A @A
£    ÀÁ 
 @B 
  B ÀBÁ@ ¤
  C ¤@ &     _campaignTypeECampaignTypeCAMPAIGN_TYPE_INLAND_VOTE_componentIdECampaignVoteComponentIDECAMPAIGN_VOTE_campaignIdcampaign_id
_campaign_data_componentGetComponent_ForceRefresh                     	   	   	   
   
   
   
                                    self       params          _ENV    .    '   G @ L@À d b     &  L@ ì   d@l@  
@L A d@ G @ L@Á d GÁ ÀA  AA  ¤@ ÁÀ C AC@   À  D   $AÁC  $AD $A &     
_campaign#CheckCampaignClose_ShowClientError
StartTask_tipsCallback_SetReqTime
GetSample	end_time_SetRemainingTime_timestr_favour_pet_remain_timeuieff_UIFavourPet_Vote2_inÓ      UIWidgetHelperPlayAnimation_anim	_Refresh_AttachEvent                   F @ L@À À   d@&     
_campaignClearCampaignNew                             TT          self    !        @ @@Å    @   ¤@&     UIWidgetHelperSetAwardItemTips
_tipsPool                                         !      matid       pos          _ENVself'                              !   !   #   #   %   %   %   %   &   &   &   &   &   (   (   )   )   )   )   )   )   )   )   )   +   +   +   -   -   .      self    '   
closeTime   '   	animName   '   	duration   '      _ENV 0   3       F @ G@À    Á  d@LÀ@ d@ &     UIWidgetHelperClearWidgets
_tipsPool_DetachEvent            1   1   1   1   1   2   2   3      self          _ENV 5   6       &                 6      self            :   J    
   G @ _@À   &  L@ ì      d 
@ &     _refreshTaskID 
StartTask         ?   G       F @ L@À d À  ¤@ÀÀ  A   @ ¤@ b   @Á ¤ ¢      A¤@ H Â&  	   AsyncRequestResNewSetSucc
_campaignReLoadCampaignInfo_ForceGetSucc	_Refresh_refreshTaskID              @   @   @   A   A   A   B   B   B   B   B   C   C   C   C   C   C   D   D   D   F   G      TT       res         _ENVself
   ;   ;   ;   <   ?   G   I   ?   I   J      self    
      _ENV L   U        @ ¢@    &  @@ ¤@ @ ¤@ À@ ¤@  A   ¤@&     view	_SetCoin
_SetQuest	_SetList_PlayAnim_List           M   M   M   N   Q   Q   R   R   S   S   T   T   T   U      self       	playAnim            W   `       F@ GAÀ  À   d ÁÀ  ¤AÁ D   ¤A&     UIWidgetHelperSpawnObjectUIActivityCommonRemainingTimeSetAdvanceTextSetData            Y   Y   Y   Y   Y   Y   ]   ]   ]   _   _   _   _   _   `      self       widgetName       descId       endTime       stopCallback       obj         _ENV b   f       F @ G@À    Á  Á  d  Á AA GA ¤@ &     UIWidgetHelperSpawnObject_coinUIFavourPetCoinSetData_component_tipsCallback            d   d   d   d   d   d   e   e   e   e   f      self       obj         _ENV h   l       F @ G@À    Á  Á  d  Á AA GA ¤@ &     UIWidgetHelperSpawnObject_questUIFavourPetVote2QuestCellSetData
_campaign_tipsCallback            j   j   j   j   j   j   k   k   k   k   l      self       obj         _ENV p       "   G @ L@À d  @ @¤ ì   Á@ A@  A Á  $FÁA  dÀ _  ÃB  Ã ÂCB Ç@   @$Ci  êAü
 &     _componentGetAllVoteItemIdCalcZonePetVoteChampionUIWidgetHelperSpawnObjects_itemUIFavourPetVote2ItemipairsSetData
_campaign_list         t   v       E   L À À   d@&     _VoteBtnOnClick           u   u   u   u   v      voteId          self"   q   q   q   r   r   r   v   x   x   x   x   x   x   x   y   y   y   y   z   {   {   {   {   |   |   |   |   |   |   |   y   y   ~         self    "   	listData   "   	champion   "   clickCallback   "   objs   "   (for generator)       (for state)       (for control)       i      v      voteId      isChampion         _ENV        
   b@    &   @ Ç@@ ¤  Ì@@äA©  *þ&     ipairs_listPlayAnimationInSequence                                                      self       isPlay       (for generator)      (for state)      (for control)      i   
   v   
      _ENV        	   G @ b@    &  F@@ GÀ À@ d L Á d R@Á Á ÌÀA A   À ,  ä@ &  	   viewGameGlobal
GetModuleSvrTimeModuleGetServerTimeè      ´       _SetRemainingTime	_reqTime                     @ "@    &  @@ @ ¬   $@   À@ $@ &     view_componentStart_HandleGetZoneInfo_SetReqTime                       @ $@ &     	_Refresh                               self                                              self                                                               self       curTime      reqTime         _ENV     ª    	    @ @@Ç@ ¤ ¢    ÆÀ@ Ç ÁA ä A ÁA@$A @Ì B AA @ À ,  ä@ &  
   UIFavourPetHelperNotEnoughVoteItem_componentStringTableGetstr_favour_pet_2_vote_fin_msgToastManager
ShowToastShowDialogUIFavourPetVote2Confirm         ¦   ¨            @   $@&     _Start_HandleVote           §   §   §   §   ¨          selfvoteId   ¡   ¡   ¡   ¡   ¢   ¢   £   £   £   £   ¤   ¤   ¤   ¤   ¤   ¦   ¦   ¦   ¦   ¨   ¦   ª      self       voteId       isVoted      text
         _ENV ¬   »        @ @@  A  ¬  ¤@&     _componentStart_HandleVote                ­   º         @ ¤ ¢   @@@ @ÆÀÀ  ¤Æ A Ç@ÁAä A AAAÁ $FB GAÂ dA E LÂdA  ÀÂ  CAC l  ¤@ &     GetSuccUIFavourPetHelperGetSkinInfo_componentStringTableGet	SkinNamestr_favour_pet_2_vote_succ_msgToastManager
ShowToast	_Refresh
_campaignCheckErrorCode	m_result          ¶   ¸            @ $@ &     	_Refresh           ·   ·   ·   ¸          self    ®   ®   ®   ®   ¯   ¯   ¯   ¯   ¯   °   °   °   °   ±   ±   ±   ±   ±   ²   ²   ²   ²   ´   ´   ´   ´   ¶   ¶   ¶   ¸   ¶   º      res        ret        cfg	      	skinName      text         _ENVselfvoteId   ­   ­   ­   ­   º   ­   »      self       voteId          _ENV ¿   Á        @ A  A  ¤@ &     ShowDialogUIIntroLoaderUIFavourPetVote2Intro           À   À   À   À   Á      self       go            Ç   É       L @ Æ@@ ÇÀ@ d@ &     AttachEventGameEventTypeOnUIGetItemCloseInQuest            È   È   È   È   È   É      self          _ENV Ë   Í       L @ Æ@@ ÇÀ@ d@ &     DetachEventGameEventTypeOnUIGetItemCloseInQuest            Ì   Ì   Ì   Ì   Ì   Í      self          _ENV Ï   Ñ       L @ d@ &     	_Refresh           Ð   Ð   Ñ      self           @                                          .      0   3   0   5   6   5   :   J   :   L   U   L   W   `   W   b   f   b   h   l   h   p      p                         ª       ¬   »   ¬   ¿   Á   ¿   Ç   É   Ç   Ë   Í   Ë   Ï   Ñ   Ï   Ñ          _ENV