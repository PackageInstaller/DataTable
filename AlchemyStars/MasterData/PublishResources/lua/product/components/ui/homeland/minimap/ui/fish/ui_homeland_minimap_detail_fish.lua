LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/homeland/minimap/ui/fish/ui_homeland_minimap_detail_fish.lua             @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lΐ  
@ @@ l  
@@@ l@ 
@ &  	   _classUIHomelandMinimapDetailFishUIHomelandMinimapDetailBaseOnShowOnInitDoneShowDetailContentExitOnClickBtnBGOnClickGetCloseAnimtionName               $   @@   €
 @@  €
@@  €
@@  €
@@  €
 C A A € 
 C A A € 
 C  AΑ € 
&     _fishGetGameObject	FishIcon
_goldFishGoldFishIcon_goldPetFishGoldPetFishIcon_boxBoxIcon
_detailGODetail	_nameTxtGetUIComponentUILocalizationTextNameTxt_commonContentTxtContentTxt_contentListUISelectObjectPathContent        $               	   	   	   	                                                                                          self    $   	uiParams    $           A       L @ d L@ΐ d ΐ@  Aΐ  € 
 @ A
@A ΖΐA Η Βΐ  @B B €@ΐB  CAC CAΑ $ €@   D  CAC CAA $ €@  D €@ @A ΖΐA ΗΐΔΐ   E B €@ΐB  CAC CAA $ €@   D  CAC CA $ €@  D €@  @A ΖΐA ΗΐΕΐ   F B €@ΐB  CAC CAA $ €@   D  CAC CA $ €@  D €@ @A ΖΐA ΗΐΖΐ @ G B €@ΐB  CAC CAA $ €@   D  CAC CA $ €@   H A A € 
ΐG ’    ΐB ΐH     	 ΗΐG I @ ΑG AIΑI$Κ &  (   GetIconData	GetParamcfgHomelandFishingConstGetFishingPositionCfgfishingPointTypeTypeHomelandFishingPointTypeNormal_fish
SetActive	_nameTxtSetTextStringTableGet'str_homeland_minimap_detail_title_fish_commonContentTxt&str_homeland_minimap_detail_desc_fishShowDetailContentGold
_goldFish+str_homeland_minimap_detail_title_goldfish*str_homeland_minimap_detail_desc_goldfishGoldPetFish_goldPetFish.str_homeland_minimap_detail_title_goldpetfish-str_homeland_minimap_detail_desc_goldpetfishBox_box&str_homeland_minimap_detail_title_box%str_homeland_minimap_detail_desc_box_titleRectGetUIComponentRectTransformTitlepreferredWidth^      
sizeDeltaVector2y                                                !   !   !   !   !   "   "   "   "   #   #   #   #   #   #   #   $   $   $   $   $   $   $   %   %   %   '   '   '   '   '   (   (   (   (   )   )   )   )   )   )   )   *   *   *   *   *   *   *   +   +   +   -   -   -   -   -   .   .   .   .   /   /   /   /   /   /   /   0   0   0   0   0   0   0   1   1   1   3   3   3   3   3   4   4   4   4   5   5   5   5   5   5   5   6   6   6   6   6   6   6   9   9   9   9   9   :   :   :   ;   ;   <   <   =   ?   ?   ?   ?   ?   ?   ?   ?   A      self       
fishCfgID      titleWidth{         _ENV C   P       G @ L@ΐ Γ  d@G@ Gΐΐ b       A  &  @A AΑ \ € Ζ B   δ @BΒ BΗ ΗΒΒ$B ι  jΑύ&     
_detailGO
SetActivecfg	DropInfo        _contentListSpawnObjects UIHomelandMinimapDetailFishItemipairsSetData                          D   D   D   D   E   E   G   G   G   G   G   H   L   L   L   L   L   M   M   M   M   N   N   N   N   N   N   M   M   P      self       	dropInfo      	itemList      (for generator)      (for state)      (for control)      i      item         _ENV R   U    
   F @ G@ΐ d Lΐ Ζΐ@ Η Αd@L@A d@ &     GameGlobalEventDispatcher	DispatchGameEventTypeMinimapCloseDetailUIOnClose         
   S   S   S   S   S   S   S   T   T   U      self    
      _ENV W   Z    
   F @ G@ΐ d Lΐ Ζΐ@ Η Αd@L@A d@ &     GameGlobalEventDispatcher	DispatchGameEventTypeMinimapCloseDetailUIOnClose         
   X   X   X   X   X   X   X   Y   Y   Z      self    
      _ENV \   ^       A   f  &      UIHomelandMinimapDetailFish_out           ]   ]   ^      self                                            A      C   P   C   R   U   R   W   Z   W   \   ^   \   ^          _ENV