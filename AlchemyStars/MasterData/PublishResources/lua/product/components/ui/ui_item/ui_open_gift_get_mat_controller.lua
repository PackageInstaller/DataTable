LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/b/150/client/Assets/../PublishResources/lua/product/components/ui/ui_item/ui_open_gift_get_mat_controller.lua             @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ &     _classUIOpenGiftGetMatControllerUIControllerOnShow
ItemClickbtnOnClick
StartOpenGetAwardIdShowGetItemController
bgOnClick	OpenSucc           !    9   @@ @ ¤
  Á 
Á 
 B A A ¤ 
ÀA ÀBAA ¤@ B A A ¤ 
  B A AÁ ¤ Ì@DA ä
À ÇÀ@ Ü C ÁD À$A C AE$ A  Á hGÂ@ GÅÇÂÅLFÀ   @¬  dC gÁü&     _itemModule
GetModuleItemModule_itemInfos       _title       
_titleTexGetUIComponentUILocalizationTexttitleSetText_poolUISelectObjectPathpoolselectInfoPool
_itemInfoSpawnObjectUISelectInfoSpawnObjectsUIOpenGiftGetMatItemGetAllSpawnListidcountSetData                       @   @ ¤@ &     
ItemClick                                id       pos          self9                     	   	                                                                                                                                                   !      self    9   	uiParams    9   	itemInfo   9   
itemCount    9   items(   9   (for index)+   8   (for limit)+   8   (for step)+   8   i,   7   	itemInfo.   7   giftId/   7   
itemCount0   7   item1   7      _ENV "   $       Ç @ Ì@À@  ä@ &     
_itemInfoSetData           #   #   #   #   #   $      self       id       pos            %   +    	      
 
À A   
@A ¤@ &     	_rewards	_openIdx        
_maxCount_itemInfos
StartOpen        	   &   &   '   (   (   (   *   *   +      self    	   go    	        ,   F       L @ Á@  d@A  À@   Á  hGÁ@ GÁÇAÁÁGÂÁÀÌB l  äBÁÿgÀü&  	   Lock%UIOpenGiftGetMatController:StartOpen       _itemInfosidpstidcountidx
StartTask         6   D    ?   F @ G@À   ÆÀÀ  E A Å E Â d@ F Â L@Â À   E  dÀ ÆÀÀ ÍÂHÀÌÀÂ ä â    Æ C Ì@Ãä  D Å $ÁÊ@Ê AD DFÁÄ $AÀÌ Å ä @ AEA ÁÀ ÁÁ  AB Á  A ÁÃ $A Å  Ì@Æä@ &     LogdebugC###[UIOpenGiftGetMatController] RequestChooseGift start ! openIdx[	_openIdx] id[] idx[	] count[]_itemModuleRequestChooseGift       GetSucc
RoleAssetNewassetidcountGetAwardIdtableinsert	_rewards
GetResulterrorB###[UIOpenGiftGetMatController] RequestChooseGift fail ! openIdx[
] giftId[
] result[ShowGetItemController      	
    ?   8   8   8   8   8   8   8   8   8   8   8   8   9   9   9   9   9   9   9   :   :   :   ;   ;   ;   ;   <   <   <   =   =   =   =   =   =   =   =   >   >   >   >   >   >   @   @   A   A   A   A   A   A   A   A   A   A   A   A   A   A   C   C   C   D      TT    ?   res   ?   msg   ?   ra   *   result-   ;      _ENVselfgiftIdidxcount
giftPstId
chooseIdx   -   -   -   .   .   .   .   .   /   /   0   1   2   3   4   6   D   6   D   .   F      self       (for index)      (for limit)      (for step)      i      	itemInfo
      giftId      
giftPstId      count      idx      
chooseIdx         _ENV G   Q       @ A@A "A   F@ GÁÀ À dAGAAÇAÂAÂ @ f&     Cfgcfg_item_giftLogerror:###[UIOpenGiftGetMatController] cfg_gift is nil ! id --> 	ItemList                          H   H   H   I   I   J   J   J   J   J   L   M   N   O   O   P   P   P   Q   	   self       giftid       idx       count       	cfg_gift      	itemList      item      itemid      count         _ENV R   Y       G @ @@  L@ ÁÀ  d@L A Á@ A d@ LÀA d@ L B d@ &  	   	_openIdx
_maxCountUnLock%UIOpenGiftGetMatController:StartOpenShowDialogUIGetItemController	_rewards	OpenSuccCloseDialog           S   S   S   S   T   T   T   U   U   U   U   V   V   W   W   Y      self            Z   \        @ ¤@ &     CloseDialog           [   [   \      self       go            ]   _       F @ G@À d LÀ ÆÀ@ Ç Ád@&     GameGlobalEventDispatcher	DispatchGameEventTypeOnOpenGiftsSucc            ^   ^   ^   ^   ^   ^   ^   _      self          _ENV                        !      "   $   "   %   +   %   ,   F   ,   G   Q   G   R   Y   R   Z   \   Z   ]   _   ]   _          _ENV