LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/b/180/client/Assets/../PublishResources/lua/product/components/ui/battle/ui_widget_battle_word_affix_cell.lua             @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ @@ l 
@&  
   _classUIBattleWordAffixCellUICustomWidgetOnShowInitWidgetSetData	ShowDescmazeAffixShowBtnOnClick_FillBgSetDataForRoll                   @ ¤@ &     InitWidget                       self       	uiParams                   #   L@@ Á  Á@ Ad 
@ LA ÁÀ  d 
@LA ÁÀ  d 
@LA Á   d 
@LA Á Á d 
@L@D Á d
@ G D LÀÄ Ã   d@&     _atlas	GetAssetUIBattle.spriteatlas	LoadTypeSpriteAtlas_mazeAffixNameGetUIComponentUILocalizationTextmazeAffixName_mazeAffixDescmazeAffixDesc_mazeAffixDescLayoutLayoutElement_mazeAffixBgImagemazeAffixShowBtn	_arrowGoGetGameObjectmazeRollArrowDown
SetActive         #   	   	   	   	   	   	                                                                                             self    #      _ENV    "    
   Ç@ ÌAÀ@äAÇ@ ÌAÀ@ äAÇ@ ÇÁÀÌÁC  äA

@ ¢  À ÇÁA ÌÁ@ äAãA  Ã  
ÀÌAB äA &  
   _mazeAffixNameSetText_mazeAffixDescgameObject
SetActive	_clickCb_index	_arrowGo_isRoolCell_FillBg                                                                                          !   !   "      self       index       clickCb       name       desc       isRollCell       
showArrow            #   4        @ @@@  ¤@b   À À@ ,  @  ¤@ &     _mazeAffixDescgameObject
SetActive
StartTask         '   0       F @    d@ F@À GÀ À   @  Æ Á Ê @ Æ Á Ê@A&     YIELD_mazeAffixDescpreferredWidthè      _mazeAffixDescLayoutÿÿÿÿÿÿÿÿ             (   (   (   )   )   *   +   +   ,   ,   ,   .   .   0      TT       
textWidth      	maxWidth         _ENVself   $   $   $   $   $   %   %   &   0   2   &   4      self       bShow          _ENV 5   9        @ ¢   @  @ ¤@ &     	_clickCb           6   6   6   7   7   9      self       go            ;   L    +   G @ b   @G@@ À À
ÀG A A ÀA ¤JÀG A A ÀAA ¤J G@@ B ÀBÀ   ¤@Ç A A ÁA $Ê @Ç A A ÁAA $Ê &     _isRoolCell_index       _rollBgIndex_mazeAffixBgsprite_atlas
GetSpritethread_cizhui_framethread_cizhui_frame02mathfmod       thread_cizhui_frame01         +   <   <   <   =   =   =   >   ?   ?   ?   ?   ?   ?   ?   A   A   A   A   A   A   B   D   E   E   E   E   E   F   F   G   G   G   G   G   G   G   I   I   I   I   I   I   L      self    +   tmpIdx   *   md   *      _ENV N   [    !   Ç @ Ì@À@ ä@¢   @Ç@ â   Ç@ ÍÀÀ
À Ç@  À   
À@Ç@ ÀÀÇ@A ÁA BA $Ê @Ç@A ÁA B $Ê &     _mazeAffixNameSetText_rollBgIndex              _mazeAffixBgsprite_atlas
GetSpritethread_cizhui_framethread_cizhui_frame01        !   O   O   O   O   P   P   P   P   P   Q   Q   Q   R   R   R   S   U   U   U   V   V   V   V   V   V   V   X   X   X   X   X   X   [      self    !   name    !   	switchBg    !                                                 "      #   4   #   5   9   5   ;   L   ;   N   [   N   [          _ENV