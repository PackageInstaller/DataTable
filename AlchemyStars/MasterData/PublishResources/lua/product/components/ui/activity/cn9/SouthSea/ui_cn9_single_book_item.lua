LuaS 

xV           (w@a@../PublishResources/lua/product/components/ui/activity/cn9/SouthSea/ui_cn9_single_book_item.lua             @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ &  	   _classUICN9SingleBookItemUICustomWidgetOnShowInitWidgetSetData
BgOnClick
CheckHaveRefreshNew           	        @ ¤@ @ À@Æ A ¤ 
&     InitWidgetitemModuleGameGlobal
GetModuleItemModule                                 	      self       	uiParams          _ENV           L@@ Á  Á  d 
@ L@@ Á@  d 
@ L B Á@ d
@L B Á d
@ L B ÁÀ d
@&     	itemIconGetUIComponentRawImageLoader	ItemIconitemNameTextUILocalizationTextItemNameTextitemObjGetGameObjectItemmasknew                                                                                   self               (    -    @ @@@ ÇÀ@
À Ç@A
À ÇÀA
À Ç@B
À ÌB ä ÁB C$AAC C$AC $A â   ÀÁC DAD DÇ@ ¤ $A  ÁC DAD DÁÁ ¤ $A  E AEA $A&     Cfgcfg_south_sea_antique_nameName_IconIcon_ItemIDItemID_IntroIntro
CheckHaveitemObj
SetActivemaskRefreshNewitemNameTextSetTextStringTableGetstr_activity_intro_lock	itemIcon
LoadImage         -                                                                      !   !   "   "   #   #   #   #   #   #   #   #   %   %   %   %   %   %   %   '   '   '   '   (      self    -   id    -   cfg   -   own   -      _ENV +   8        @ ¤ ¢@    &  @@ @  ¤@À@ ,  ¤@ A A GA ÁA ÇB ¤@ &  	   
CheckHavenew
SetActive
StartTaskShowDialogUIActivityCN9BookDetailPop_name_Icon_Intro        1   5       F @ L@À d @ À@   @ ¤@ @  A   @ ¤@ &     itemGetIDitemModuleSetItemUnnewOverlaySetItemUnnew           2   2   2   3   3   3   3   3   4   4   4   4   4   5      TT       pstID         self   ,   ,   ,   ,   -   /   /   /   /   0   5   0   7   7   7   7   7   7   8      self       go            :   C       G @ L@À Ç@ db   @ ÀÀ     ¦  @ A @A ¤@A @A  ¤@  ¦  &     itemModuleGetItemCount_ItemID        itemObj
SetActivemask           ;   ;   ;   ;   <   <   <   <   =   =   =   ?   ?   ?   ?   @   @   @   @   A   A   C      self       count           E   X    $   G @ L@À Ç@ dÀ@  A  ¤@@A AÀ  ¤ !ÀA  &   B À  ¤   
©  *ÿ@B ¢   @@B B¤ ¢    
 ÃÀ@  A ¤@&     itemModuleGetItemByTempId_ItemIDnew
SetActivetablecount        pairsitemIsNewOverlayhasRed         $   F   F   F   F   G   G   G   G   H   H   H   H   H   H   I   L   L   L   L   M   L   L   P   P   P   Q   Q   Q   Q   Q   R   S   S   S   S   X      self    $   items   $   (for generator)      (for state)      (for control)      _      v         _ENV                        	                  (      +   8   +   :   C   :   E   X   E   X          _ENV