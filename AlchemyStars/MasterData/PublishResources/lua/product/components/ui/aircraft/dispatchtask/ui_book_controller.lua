LuaS 

xV           (w@@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/aircraft/dispatchtask/ui_book_controller.lua         %    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lΐ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lΐ 
@ @@ l  
@@@ l@ 
@ &     _classUIBookControllerUIControllerOnShowSelectBook
_InitData_InitUI_OnGetBookItem_RefreshBookItemInfo_OnGetChapterItem_RefreshChapterItemInfoOnBackOnHome    
           -   @@   AΑ  € 
  @ @A €
  A ΐA,  D  ¬A  €@@@ A A € 
 @@ A A € 
C Α €
@@ A A € 
 @@ A A € 
@E €@ E €@ &     _topBarLoaderGetUIComponentUISelectObjectPathTopBarLoadertopButtonWidgetSpawnObjectUICommonTopButtonSetData_bookScrollViewUIDynamicScrollView	BookList_chapterScrollViewChapterList_chapterPanelGetGameObjectChapterPanel_bookNameLabelUILocalizationText	BookName_bookDesLabelBookDes
_InitData_InitUI                       @ $@ &     OnBack                              self                @ $@ &     OnHome                              self-                  	   	   	   	   	   
   
            
                                                                                             self    -   	uiParams    -           *    *    @ ’   ΐ  @ @@  €@
@  @ @@ €@@ ΐ@€@  A Η @ ΜΑδ ΐΐA Η @ Μ Βδ ΐ@B B €@ @  C€ 
@C CΑB C €@ @C ΐ@€@ &     _currentSelectBookSetSelectedStatus_bookScrollViewRefreshAllShownItem_bookNameLabeltextGetName_bookDesLabelGetDes_chapterPanel
SetActive_chapterCountGetChapterCount_chapterScrollViewSetListItemCount        *                        !   "   "   "   "   #   #   #   $   $   $   $   $   %   %   %   %   %   &   &   &   &   '   '   '   '   (   (   (   (   (   )   )   )   *      self    *   	bookData    *        ,   9    "   
@@F@ Gΐΐ    d @A Aΐ  € 
    

@BB ΐ  €  ΗΑA ΒA  ΒBFC LBΓΐ dΚA©  *ύ@A CΗΐA ,  €@&     _currentSelectBook Cfg	cfg_book
bookCounttablecount_bookDatas_chapterCount        pairs       	BookDataNewsort         6   8    
    @ € Μ ΐ δ `ΐ   @    ¦  &     	GetIndex        
   7   7   7   7   7   7   7   7   7   8      a    
   b    
       "   .   /   /   /   /   0   0   0   0   0   1   1   2   3   3   3   3   4   4   4   4   4   4   4   4   4   3   3   6   6   6   8   6   9      self    "   bookCfg   "   (for generator)      (for state)      (for control)      k      v         _ENV ;   L       G @ L@ΐ Η@ ,  d@ Gΐ@ L Α Γ   d@G@A L@ΐ ΗA ,A  d@ GΐA \   @ ΐ L@B ΗΐA ΗΒd@&     _bookScrollViewInitListView
bookCount_chapterPanel
SetActive_chapterScrollView_chapterCount_bookDatas        SelectBook               >   @           @   @ ₯  ¦   &     _OnGetBookItem           ?   ?   ?   ?   ?   ?   @      scrollview       index          self E   G           @   @ ₯  ¦   &     _OnGetChapterItem           F   F   F   F   F   F   G      scrollview       index          self   <   <   =   @   <   B   B   B   B   C   C   D   G   C   I   I   I   I   J   J   J   J   L      self            N   b    /   Μ ΐ AA  δ@ Α  ΗΑ$ GAΑΑ ΚΐΑLBΑA  dA LΑBd Β’  ΝBC  ΐ@BC$ C  $B ΒC  ΐ$B BC$ C $BΖD ΗAΔΔΒ $δA  ζ  &     NewListViewItemRowItemGetUIComponentDynamicUISelectObjectPathgameObjectIsInitHandlerCalled SpawnObjectsUIBookItem       GetAllSpawnList
bookCountGetGameObject
SetActive_RefreshBookItemInfo	UIHelperRefreshLayoutGetComponentRectTransform         /   O   O   O   P   P   P   P   Q   Q   Q   R   S   S   S   S   U   U   V   W   W   X   Y   Y   Y   Z   Z   Z   Z   Z   Z   \   \   \   \   ]   ]   ]   ]   ]   `   `   `   `   `   `   a   b      self    /   scrollView    /   index    /   item   /   rowPool   /   rowList   /   itemWidget   /   
itemIndex   '      _ENV e   h       Μ ΐ @  A@  δ@ &     Refresh_bookDatas           g   g   g   g   g   h      self       itemWidget       index            j       3     @@ Δ   ζ  Μ@ΐ A  δΑ@  ΗAΑ$ GΑΐΑ Κ BLABΑ Β dA LCd ΑΒ’  ΝΑBBC  ΐ@C$ ΒC  $B D  ΐ$B C$ ΒC $BΖAD ΗΔΒΔ $δA  ζ  &             NewListViewItemRowItemGetUIComponentDynamicUISelectObjectPathgameObjectIsInitHandlerCalled SpawnObjectsUIBookChapterItem       GetAllSpawnList_chapterCountGetGameObject
SetActive_RefreshChapterItemInfo	UIHelperRefreshLayoutGetComponentRectTransform         3   k   k   l   l   n   n   n   o   o   o   o   p   p   p   q   r   r   r   r   t   t   u   v   v   w   x   x   x   y   y   y   y   y   y   {   {   {   {   |   |   |   |   |                              self    3   scrollView    3   index    3   item   3   rowPool   3   rowList   3   itemWidget   3   
itemIndex   +      _ENV        	   Η @ β@    &  Η @ Μ@ΐδ ΐ @ Η  $A&     _currentSelectBookGetChaptersRefresh                                                     self       itemWidget       index       	chapters                  
   F @ G@ΐ d Lΐ Ζΐ@ Η Αd@L@A d@ &     GameGlobalEventDispatcher	DispatchGameEventTypeUpdateBookRedPointStatusCloseDialog         
                                    self    
      _ENV           F @ G@ΐ d Lΐ Ζΐ@ Η Αd@F @ G@Α d LΑ ΖΐA Η ΒA d@ &  
   GameGlobalEventDispatcher	DispatchGameEventTypeAircraftLeaveAircraftLoadingManagerStartLoadingLoadingHandlerNameAircraft_ExitUI                                                               self          _ENV%                                 *      ,   9   ,   ;   L   ;   N   b   N   e   h   e   j      j                                        _ENV