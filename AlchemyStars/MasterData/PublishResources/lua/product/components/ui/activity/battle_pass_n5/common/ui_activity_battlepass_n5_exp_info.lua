LuaS 

xV           (w@u@../PublishResources/lua/product/components/ui/activity/battle_pass_n5/common/ui_activity_battlepass_n5_exp_info.lua         (    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@@@ l@ 
@ @@ l 
@&     _classUIActivityBattlePassN5ExpInfoUICustomWidget_GetComponentsOnShowOnHideSetData
_SetTitle_SetExp_SetMaxObj	_SetIcon_SetExpNormal_SetExpUpgrade_PlayFillAmount               )   L@@ Á  Á  d 
@ L@@ Á  A d 
@ L@@ Á  Á d 
@ L@@ Á  A d 
@ L@@ ÁÀ  d 
@ L@@ ÁÀ  d 
@L@@ Á  A d 
@L@@ Á  Á d 
@ &     _txtTitle1GetUIComponentUILocalizationText
txtTitle1_txtTitle2
txtTitle2_txtTitle3
txtTitle3_txtTitle4
txtTitle4_imgProgressBgImageimgProgressBg_imgProgressValueimgProgressValue	_imgIconRawImageLoaderimgIcon_txtProgresstxtProgress        )                  	   	   	   	   	                                                                                                   self    )                   
@@L@ d@ FÀ@ G Á d @A  ¤ÀA  ¤@@A  ¤ÀA ¤@B ÀB C@C¤ 
&     _isOpen_GetComponentsUIActivityZhHelperIsZhGetGameObjecttxtTitle1_zh
SetActive
txtTitle1_seqDG	TweeningDOTween	Sequence                                                                                           self       isZh         _ENV "   $       
@@&     _isOpen            #   $      self            &   1       
@ 
@ A@ Á@$Aâ@   A $A @ AA $A &     
_campaign_componentInfo	_SetIcon
m_item_id_SetExpNormal_SetExpUpgrade           '   )   +   +   +   +   ,   ,   -   -   -   /   /   1      self       	campaign       componentInfo       upgrade            3   ?    !    @ @@  ¤@ ÀÀ    À  ]À @A @@  ¤@A @@ÁA BAA $ ¤@  B ÀBÇ C A ¤ÇC Ì@ÀFÁA GÂ d ä@  &     _txtTitle1SetTextLv.
       <color=#7f7f7f>0</color>_txtTitle2_txtTitle3StringTableGet&str_activity_battlepass_n5_main_titleUIActivityBattlePassHelperGetStrIdInCampaign
_campaign(str_activity_battlepass_n5_main_title_2_txtTitle4         !   4   4   4   4   5   5   6   6   6   8   8   8   8   9   9   9   9   9   9   9   =   =   =   =   =   >   >   >   >   >   >   >   ?      self    !   lv    !   strId   !      _ENV A   R    )   Ì @ @ ä@Ç@@ ÇÀA@ Á@A AA AÂA B@ À$ ¤A  Á _@B@!À !ÀB@ ÇC Ê  @ _À   ÃA  Ã BA CÂC$BD $B&     
_SetTitle_componentInfom_level_max_progressm_max_level-%s<color=#FF0000>/</color><size=30>%s</size>_txtProgressSetTextstringformat                _imgProgressValuefillAmountgameObject
SetActive_SetMaxObj         )   B   B   B   D   D   E   E   G   H   H   H   H   H   H   H   H   H   J   K   K   K   K   K   K   L   L   O   O   O   O   O   O   P   P   P   P   P   Q   Q   Q   R      self    )   lv    )   	progress    )   maxProgress   )   maxLv   )   
formatStr   )   rate   )   max    )      _ENV T   X        @ @@¤ Ì@ AÁ  äÌ Ác   @ ä@Ì@ AA äÌ Á¢@  @ @ @ CA  C ä@&     UIActivityZhHelperIsZhGetGameObjectmax_zh
SetActivemax            U   U   U   V   V   V   V   V   V   V   V   W   W   W   W   W   W   W   W   W   W   W   X      self       isShow       isZh         _ENV Z   c       @@ @@ 
  @ À@ A @AÁ   Ý ¤@ &   @ ÀAÇ B Ì@Â@ ä@&  
   
_cfg_itemCfg	cfg_item Logfatal,[quest] error --> cfg_item is nil ! id --> Icon	_imgIcon
LoadImage            [   [   [   [   \   \   \   ]   ]   ]   ]   ]   ]   ^   a   a   b   b   b   b   c      self       itemId       icon         _ENV e   j       G@@ GÀ 
@ G@@ G Á 
@L@A Ç @ Á@ d@ &     _curLv_componentInfom_current_level_curProgressm_current_progress_SetExp           f   f   f   g   g   g   i   i   i   i   j      self            l          
@@G@ À@ Ç A Ç@ÁA AGA GÁÁ À @B   @¬  ¤AÀ AB  @ ¤A 
À 
 &  
   _expIncreaseAnimTime       _curLv_curProgress_componentInfom_current_levelm_current_progressm_level_max_progress_PlayFillAmount_PlayFillAmount        {               @   Á@  $@    @   Å  $@ &     _SetExp        _PlayFillAmount           }   }   }   }   }                            self	targetLvtargetProgress   m   o   p   q   q   r   r   t   t   v   v   x   y   z      x                              self       curLv      curProgress      	targetLv      targetProgress      maxProgress	                   
   @ A@R@ Á@ GA ¤ AA,  ¤A,B  ¤ÇÁA ÌÂ@ äA&  	   _componentInfom_level_max_progress_imgProgressValueDOFillAmount_expIncreaseAnimTime	OnUpdateOnComplete_seqAppend                     @ @@ FÀ GÀÀ   O $ E  L Á Å    d@ &     mathfloor_imgProgressValuefillAmount_SetExp                                                       value         _ENVselfmaxProgresslv                @   Å  $@  "   @  $@ &     _SetExp                                                   selflv	progress	callback                                                                self       lv       	progress       	callback       maxProgress      rate      tweener         _ENV(                                        "   $   "   &   1   &   3   ?   3   A   R   A   T   X   T   Z   c   Z   e   j   e   l      l                        _ENV