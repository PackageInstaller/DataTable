LuaS 

xV           (w@n@../PublishResources/lua/product/components/ui/activity/battle_pass_cn1/common/ui_battlepass_cn1_exp_info.lua         .    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lภ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lภ 
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lภ 
@ @@ l  
@&     _classUIBattlePassCN1ExpInfoUICustomWidgetOnShowOnHideSetData
_SetState_SetBuyLevelBtn
_SetTitle_SetExp_SetMaxObj	_SetIcon_SetExpNormal_SetExpUpgrade_PlayFillAmountBuyLevelBtnOnClick                  L@@ ม  ม  d 
@ F A G@ม d A ม ค B  ค@A A ค B ค@ภB  C@CCค 
 &     _imgProgressValueGetUIComponentImageimgProgressValueUIActivityZhHelperIsZhGetGameObjecttxtTitle1_zh
SetActive
txtTitle1_seqDG	TweeningDOTween	Sequence                                    	   	   	   	   	   	   
   
   
   
   
   
                           self       isZh         _ENV           &                       self               *        
@ 
FAA GมA@ d
ภ

@
 FB GAยA@ ภ  dALB ภ dALมB dA LC วA วAรdAโ@   LC dA @ LมC dA &     _type
_campaign_cmptId_component_componentInfoUIActivityBattlePassHelperComponent_LVReward_refreshCallbackUIBattlePassStyleHelperFitStyle_Widget
_SetState_SetBuyLevelBtn	_SetIcon
m_item_id_SetExpNormal_SetExpUpgrade                                                               "   "   "   #   #   $   $   $   $   %   %   &   &   &   (   (   *      self        type        	campaign        upgrade        refreshCallback           _ENV ,   3         ห    AA  ๋@  A  ม  +A ซ@ ฦ@A วม   @ A ไ 
ภ ฦ@A วภมA @ ไ@&     _width1_space1_width2_space2
_stateObjUIWidgetHelperGetObjGroupByWidgetNameSetObjGroupShow            -   -   .   .   .   .   /   /   /   0   1   1   1   1   1   1   1   2   2   2   2   2   3      self       state       widgetGroup
         _ENV 5   8       G @ G@ภ  @ @`   C@  C  ภ@  ค@A  ค@&     _componentInfom_current_levelm_max_levelGetGameObject
_buyLevel
SetActive           6   6   6   6   6   6   6   6   7   7   7   7   7   7   8      self       flag           :   @        @ @@ภ     Aม  ค@  A @Aม   ค@   @ @@ภ   ม @ ค@  B @Bม ค ฦ @ ว@ภ   Aม  ไ@ &     UIWidgetHelperSetLocalizationText
txtTitle1Lv.UIActivityHelperFormatNumber_PreZero       
txtTitle2StringTableGet&str_activity_battlepass_n5_main_title
txtTitle3            ;   ;   ;   ;   ;   ;   <   <   <   <   <   <   =   =   =   =   =   =   >   >   >   >   ?   ?   ?   ?   ?   ?   @      self       lv       txt3         _ENV B   Q    
!   ฬ @ @ ไ@ว@@ วภม@ AAA  ภ$ FA Gมม  ม   dA Rม _@ย@!@ภ !ภย@ C AC มCค ฬD @ ไA&     
_SetTitle_componentInfom_level_max_progressstringformat%s/%sUIWidgetHelperSetLocalizationTexttxtProgress                _imgProgressValuefillAmount_componentCheckIsLevelMax_SetMaxObj         !   C   C   C   E   E   G   G   G   G   G   G   H   H   H   H   H   H   J   K   K   K   K   K   K   L   L   O   O   O   P   P   P   Q      self    !   lv    !   	progress    !   maxProgress   !   text   !   rate   !   max   !      _ENV S   W        @ @@ค ฬ@ Aม  ไฬ มc   @ ไ@ฬ@ AA ไฬ มข@  @ @ @ CA  C ไ@&     UIActivityZhHelperIsZhGetGameObjectmax_zh
SetActivemax            T   T   T   U   U   U   U   U   U   U   U   V   V   V   V   V   V   V   V   V   V   V   W      self       isShow       isZh         _ENV Y   [        @ @@ภ     A  ค@ &     UIWidgetHelperSetItemIconimgIcon            Z   Z   Z   Z   Z   Z   [      self       itemId          _ENV ]   b       G@@ Gภ 
@ G@@ G ม 
@L@A ว @ ม@ d@ &     _curLv_componentInfom_current_level_curProgressm_current_progress_SetExp           ^   ^   ^   _   _   _   a   a   a   a   b      self            d          
@@G@ ภ@ ว A ว@มA Aภ    LมA dA &  GA Gย ภ @AB   @ฌ  คAภ B  @ คA 
ภ 
 &     _expIncreaseAnimTime       _curLv_curProgress_componentInfom_current_levelm_current_progress_SetExpNormalm_level_max_progress_PlayFillAmount_PlayFillAmount        w   }            @   ม@  $@    @   ล  $@ &     _SetExp        _PlayFillAmount           y   y   y   y   y   |   |   |   |   |   }          self	targetLvtargetProgress   e   g   h   i   i   j   j   k   k   k   k   l   l   m   p   p   r   r   t   u   v   }   t   ~                           self       curLv      curProgress      	targetLv      targetProgress      maxProgress                  
   @ A@R@ ม@ GA ค AA,  คA,B  ควมA ฬย@ ไA&  	   _componentInfom_level_max_progress_imgProgressValueDOFillAmount_expIncreaseAnimTime	OnUpdateOnComplete_seqAppend                     @ @@ Fภ Gภภ   O $ E  L ม ล    d@ &     mathfloor_imgProgressValuefillAmount_SetExp                                                       value         _ENVselfmaxProgresslv                @   ล  $@  "   @  $@ &     _SetExp                                                   selflv	progress	callback                                                               self       lv       	progress       	callback       maxProgress      rate      tweener         _ENV    ก    	    @ @@ม  ค@ ภ@  Aว@A ค@ &     Loginfo*UIBattlePassCN1ExpInfo:BuyLevelBtnOnClickUIActivityBattlePassHelperOpenBuyLevelController_refreshCallback         	                               ก      self    	   go    	      _ENV.                                          *      ,   3   ,   5   8   5   :   @   :   B   Q   B   S   W   S   Y   [   Y   ]   b   ]   d      d               ก      ก          _ENV