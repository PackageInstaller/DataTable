LuaS 

xV           (w@]@../PublishResources/lua/product/components/ui/ui_world_boss/ui_world_boss_record_choice.lua         3    @ A@  @ $@@@  À  
 Á
Á
 ÂF@B  À   d@F@@ ¬   JF@@ ¬@  J F@@ ¬  JF@@ ¬À  J F@@ ¬  JF@@ ¬@ J F@@ ¬ JF@@ ¬À J F@@ ¬  JF@@ ¬@ J F@@ ¬ JF@@ ¬À J &     _classUIWorldBossRecordChoiceUIControllerNew       Old       None       _enumChoiceTypeConstructorOnShow_GetComponents	_OnValue_CreateTeamPetsNewBtnOnClickOldBtnOnClickPlaySelectAniConfirmBtnOnClick_ChoiceRecord_CheckSeasonEndCloseWithAnimation                  L@@ Æ@ d
@ L@@ Æ A d
@
ÁF Â 
@
Â
Â&     _missionModule
GetModuleMissionModule_worldBossModuleWorldBossModule_maxPetsCount       _choiceTypeNone_newDamage        _oldDamage                                                          self          _ENVChoiceType           @À 
 ÀÀ 
  A ¤@ @A ¤@ A ¤@ &     _newDamage       
_callBack       _GetComponents	_OnValue_CheckSeasonEnd                                               self       	uiParams               (    4   L@@ Á  d
@ L@@ Á  d
@L@@ Á d
@L@@ Á  d
@LB ÁÀ  d 
@LB ÁÀ  d 
@LB Á  A d 
@LB ÁÀ Á d 
@ LB ÁÀ A d 
@ LB Á  Á d 
@ LB Á@  d 
@ &     _markGetGameObjectMark_newObjNew_oldObjOld	_blurObjBlur_newDamageValueGrayGetUIComponentUILocalizationTextNewDamageValueGray_newDamageValueNewDamageValue	_newPetsUISelectObjectPathNewPets_oldDamageValueGrayOldDamageValueGray_oldDamageValueOldDamageValue	_oldPetsOldPets
animaiton
Animation
animation        4                                                       !   !   !   !   !   "   "   "   "   "   #   #   #   #   #   $   $   $   $   $   %   %   %   %   %   &   &   &   &   &   '   '   '   '   '   (      self    4        )   8    
6   G @ L@À d À ¤ À@Á $ ¤  Ç@A ÌÁGAA LÁÁd ä    â    ÂGÂ
@LÁB ÇC  dA GAC LÃÆÁC ÇÄB GD ädA  GÁD LÃÇD dAGE LÃÆÁC ÇÄB GBB ädA  GAE LÃÇAB dAGE LÁÅÃ  dA&     _missionModuleTeamCtxTeamsGetGetCurrTeamId_worldBossModuleGetRecordByTeamIndexGetCurSelectTeamIndex	pet_list_oldDamageformation_damage_CreateTeamPetspets_newDamageValueGraySetTextUIActivityHelperAddZeroFrontNum       _newDamage_newDamageValue_oldDamageValueGray_oldDamageValue_mark
SetActive         6   *   *   *   +   +   +   +   +   +   ,   ,   ,   ,   ,   ,   -   .   .   /   0   0   2   2   2   2   3   3   3   3   3   3   3   3   4   4   4   4   5   5   5   5   5   5   5   5   6   6   6   6   7   7   7   7   8      self    6   teamsContext   6   newTeam	   6   record   6   oldTeamPets   6      _ENV 9   F    &   Ç @ Ì@ÀA  Á@ ä@ Ç @ Ì@Áä 
À ÇA Ì@ÀA  Á@ ä@ ÇA Ì@Áä 
ÀÁ  Á@ A è@ÇA ÇÌAÂG äAÁ ¢     ÇÂA BB$Bç ü&     	_newPetsSpawnObjectsUIWorldBossRecordPet_maxPetsCount_allNewPetsGetAllSpawnList	_oldPets_allOldPets       SetData                &   :   :   :   :   :   ;   ;   ;   ;   <   <   <   <   <   =   =   =   =   >   >   >   >   ?   ?   ?   ?   ?   @   A   A   B   D   D   D   D   D   >   F      self    &   newPets    &   OldPets    &   (for index)   %   (for limit)   %   (for step)   %   i   $   pstId   $        G   O        À @@@ ÁÇ@A Ç ÀÊ ÆÀA 
À Ç@A Ì ÂC ä@Ì@B ä@ &  
   
transformparentanchoredPositionx       _mark_choiceTypeNew
SetActivePlaySelectAni           H   H   H   I   J   J   J   L   L   M   M   M   M   N   N   O      self       go       pos         ChoiceType P   W        À @@@ ÁÇ@A Ç ÀÊ ÆÀA 
À Ç@A Ì ÂC ä@Ì@B ä@ &  
   
transformparentanchoredPositionxÿÿÿÿÿÿÿÿ_mark_choiceTypeOld
SetActivePlaySelectAni           Q   Q   Q   R   S   S   S   T   T   U   U   U   U   V   V   W      self       go       pos         ChoiceType Y   a       L @ ì   d@&     
StartTask         Z   `       A      @@  ¤@@ À@ ¤@@Á À    ¤@   ÀA  ¤@&     #UIWorldBossRecordChoice_select_aniLock
animaitonPlay"UIWorldBossRecordChoice_xuanzhongYIELD      UnLock             [   \   \   \   \   ]   ]   ]   ]   ^   ^   ^   ^   _   _   _   _   `      TT       key         self_ENV   Z   `   Z   a      self          _ENV b   o        @ Æ@@ À ÀÀ À@Æ Á Ç@Á ä  ¤@  &  À Ä   @ FB @@ @B   B ÁB  $A&     _choiceTypeNoneToastManager
ShowToastStringTableGetstr_world_boss_choice_record        New_newDamage_oldDamage_ChoiceRecord             c   c   c   c   d   d   d   d   d   d   d   e   g   h   i   i   i   i   j   j   l   n   n   n   o      self       go       damage      aniName         ChoiceType_ENV q   ~        @ ,  @  ¤@ &     
StartTask        s   {    !   F @ L@À À   @ FÁÀ _@  A   F@ LÁd  d @Á ¤ ¢   @   A¤@ ÀA ¢   ÀÀA Æ@ Â _   Ã@  Ã  ¤@ &  	   _worldBossModuleReqChoseRecord_choiceTypeNewGetCurSelectTeamIndexGetSuccCloseWithAnimation
_callBackOld          !   t   t   t   t   t   t   t   t   t   t   t   t   t   t   u   u   u   u   v   v   v   w   w   w   x   x   x   x   x   x   x   x   {      TT    !   res   !      selfChoiceTypedamage   r   {   }   r   ~      self       damage          ChoiceType        	   G @ L@À d b   @F@ GÀÀ   Æ@A ÇÁÁA BFAB GÂÁ d AB BÁ ¤ ì    d@ &     _worldBossModuleCurSeasonEndPopupManagerAlertUICommonMessageBoxPopupPriorityNormalPopupMsgBoxTypeOkStringTableGet!str_activity_common_notice_titlestr_world_boss_season_end                 	    @ @@ $ @ À@  AÄ  $@&     GameGlobalLoadingManagerStartLoadingLoadingHandlerNameExit_Core_Game         	                                     _ENV                                                                              self          _ENV    ¨       L @ ì   d@&     
StartTask             §    A   A      @@  ¤@@ À@ ¤@   Æ A AÁ  @ ÆÀAÇ Â@ ä@ ÆÀAÇ ÂAB ä@ ÆÀAÇ ÂB ä@  À ÆÀAÇ Â@ ä@ ÆÀAÇ ÂC ä@ ÆÀAÇ ÂB ä@ Æ@C ÌÃ@ ä@ÆÀC   A ä@Æ@C ÌÃAA ä@ÆÀC   A ä@Å   ÌÀÄ@ ä@Å   Ì Åä@ &     UIWorldBossRecordChoice_CloseLock	_blurObj
SetActive_choiceTypeNewUIWorldBossRecordChoice_down	UIHelperSetAsLastSibling_newObj_markUIWorldBossRecordChoice_up_oldObj
animaitonPlayYIELDL      UIWorldBossRecordChoice_out       UnLockCloseDialog           A                                                                                                                                              ¡   ¡   ¡   ¡   £   £   £   £   ¤   ¤   ¤   ¤   ¥   ¥   ¥   ¥   ¦   ¦   ¦   §      TT    A   key   A   aniName
   A      selfChoiceType_ENV      §      ¨      self          ChoiceType_ENV3                              	                                    (      )   8   )   9   F   9   G   O   G   P   W   P   Y   a   Y   b   o   b   q   ~   q               ¨      ¨      ChoiceType
   3      _ENV