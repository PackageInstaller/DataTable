LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/b/1110/client/Assets/../PublishResources/lua/product/components/ui/homeland/3dui/home_3dui_manager.lua         U    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ @@ l  
@@@ l@ 
@  @ A@ @ $@@C  @C l 
@@C lÀ 
@ @C l  
@@C l@ 
@ @C l 
@@C lÀ 
@ @C l  
@@C l@ 
@  @ A@ @ $@@E  @E l 
@@E lÀ 
@ @E l  
@@E l@ 
@ &     _classHome3DUIManagerObjectConstructorInitCreateTalkUnitGetTalkUnitReturnTalkUnitUpdateDisposeCopyAddNameBoardAddInteractBoardHomeTalkUnitSetPosSetRotationSetTexActive	GetUsing	SetUsing	_SetTextHome3DUIQueueEnqueueDequeueCount                  
@@
À@F@A LÁ d 
@ K   
@K   
@ &  	   
_talkUnit _talkCount
       _talkUnitQueueHome3DUIQueueNew_nameBoardList_interactList                                                self          _ENV    ,    
F   
@ 
À   ÆÀ@ Ç ÁÇ@Á ä  ¢@  @ÆÀA Ì Âä Ì@ÂA ÁB Aä 
ÀÇ@@  ÃÌ@CC ä@ÇCD AA A ÁA $ Ê ÇCÌ@ÁA äAÁ $
 ÁD AA $ÁE
 AE AC  $A GAF  (A F $B 'ÿÁF GAA AF $AÁF GA ÁG H¤ $A  &  !   _homelandClient	_3duiReq UnityEngineGameObjectFind3DUIResourceManagerGetInstanceSyncLoadAssetUIHome3DUI.prefab	LoadTypeObj
SetActive
transform	positionVector3        3DUICanvas
_talkRoot	TalkRoot
_talkUnit	TalkUnitgameObject       _talkCountCreateTalkUnitLogdebug*###[Home3DUIManager] Init ! maxCount --> -###[Home3DUIManager] Init ! queue count --> _talkUnitQueueCount         F                                                                                                                   !   !   !   !   #   #   #   #   #   #   $   $   $   $   &   &   &   &   '   '   &   *   *   *   *   *   +   +   +   +   +   +   +   ,      self    F   homelandClient    F   _3dui   F   _3duiCanvas$   F   (for index)5   9   (for limit)5   9   (for step)5   9   i6   8      _ENV -   9          b   @   ÀÌ @ GA@ ä@ Á@$  Ì AC  ä@Ì@AC  ä@ÇA ÌÀÁ@ ä@Æ B Ç@Â GA LÁÂd ä@  &     Copy
_talkUnitHomeTalkUnitNewActive	SetUsing_talkUnitQueueEnqueueLogdebug0###[Home3DUIManager] Enqueue ! queue count --> Count            .   /   /   0   0   2   2   2   3   3   3   3   3   5   5   5   6   6   6   7   7   7   7   8   8   8   8   8   8   8   9      self       unit       	talkUnit      go         _ENV :   F    !   G @ L@À d !À @À@ ¤@  A @A
 A ÀAÁ  A ¤@ @ @B¤ ÆA ÇÀÁ G@ LAÀd ä@  ÌÀBC ä@Ì CC ä@¦  &     _talkUnitQueueCount        CreateTalkUnit_talkCount       Logdebug2###[Home3DUIManager] maxCount + 1 ! maxCount --> Dequeue0###[Home3DUIManager] Dequeue ! queue count --> Active	SetUsing         !   ;   ;   ;   <   <   =   =   >   >   >   ?   ?   ?   ?   ?   A   A   A   B   B   B   B   B   B   B   C   C   C   D   D   D   E   F      self    !   count   !   	talkUnit   !      _ENV G   I        @   ¤@&     CreateTalkUnit           H   H   H   I      self       unit            J   K       &                 K      self       deltaTimeMS            L   a    ,   F @ G@À   ÇÀ@ Ì Áä  d@  G@A b   À G@A LÁ d@ 
ÀÁA  @B   Á  hÀ GAB GLÁdA gþ
ÀÁA  B   Á  hÀ GB GLÁdA gþ
ÀAGÀB b   À 
ÀÁG C LÁ d@ &     Logdebug0###[Home3DUIManager] Dispose ! queue count --> _talkUnitQueueCount	_3duiReqDispose        _nameBoardList_interactList_nameBoardAtlas_nameBoardAtlasResReq         ,   M   M   M   M   M   M   M   N   N   N   O   O   O   P   S   S   S   S   S   T   T   T   T   S   V   X   X   X   X   X   Y   Y   Y   Y   X   [   ]   ]   ]   ^   _   _   _   a   	   self    ,   (for index)      (for limit)      (for step)      i      (for index)   #   (for limit)   #   (for step)   #   i   "      _ENV b   e        @ @@@À  Á@ A  Á $ FAA GÁÁA ¤¦  &     UnityEngineGameObjectInstantiateVector3        Quaternion	identity
_talkRoot            c   c   c   c   c   c   c   c   c   c   c   c   c   d   e      self       go       copy         _ENV g   }    >   @ A@$ @Á  ÆA ÇAÁ$ GAÁÁB FBB GÂGÂÂ$ ¤  ÌÁÁFB C d ä  BC "B  À@ B@$ @Â ÆA ÇÄ$ 
 C A
 BÄ $BÄÂD Ã  $B BC BE $ÅÂE FÀ¤ $B  BF FGÂF  $Bf &     ResourceManagerGetInstanceSyncLoadAssetUIHomelandNameBoard.prefab	LoadTypeGameObjectObjGetComponentInChildrentypeofUnityEngineUIImageUILocalizationText_nameBoardAtlas_nameBoardAtlasResReqUIHomeland3D.spriteatlasSpriteAtlas
SetActive
transform
SetParentsprite
GetSpriteSetTextStringTableGettableinsert_nameBoardList         >   h   h   h   h   h   h   h   h   j   l   l   l   l   l   l   l   n   n   n   n   n   p   p   p   q   q   q   q   q   q   q   q   q   r   r   r   u   u   u   v   v   v   v   v   w   w   w   w   w   x   x   x   x   x   x   z   z   z   z   z   |   }      self    >   root    >   spriteName    >   
stringKey    >   resReq   >   go	   >   image   >   text   >      _ENV        2    @ @@¤ @Á  FA GAÁ¤ ÆA ÇÀÁB @ ä@Ç@BÂ $AÁÂC Ã  $A @ A@$ @A ÆA ÇAÁ$ FA GÁÁB À dAGABÂ ¤AÁÂCÂ ¤ÇÁÂÌÃ@   äA æ  &     ResourceManagerGetInstanceSyncLoadAssetUIHomelandInteractBoard.prefab	LoadTypeGameObjecttableinsert_interactListObj
SetActive
transform
SetParenteff_jy_meme_tanhao.prefabFindeffRoot         2                                                                                                                                                            self    2   root    2   resReq   2   go   2   resReq   2   goEff$   2   effRoot+   2      _ENV    £    +   
@@
@  Á 
À@ AÁ ¤
@A @B ¤
 @A A ¤@C@B ¤
@A A ¤@C@B ¤
@A @B ¤
@A @B ¤
&     _selfMsgWidth5      _go_tr
transform_layoutFindlayout_layoutGroupGetComponentVerticalLayoutGroup_textalkTexgameObjectUILocalizationText	_texRectRectTransform_filterContentSizeFitter_layoutRect        +                                                                                                            ¡   ¡   ¡   ¡   ¡   ¢   ¢   ¢   ¢   ¢   £      self    +   go    +        ¤   ¦        @ @&     _tr	position           ¥   ¥   ¦      self       pos            §   ©        @ @&     _tr	rotation           ¨   ¨   ©      self       rot            ª   ­        @   ¤@&     	_SetText           ¬   ¬   ¬   ­      self       tex            ®   °        @ @@  ¤@&     _go
SetActive           ¯   ¯   ¯   ¯   °      self       active            ±   ³       G @ f  &     _using           ²   ²   ³      self            ´   ¶       
@ &     _using           µ   ¶      self       using            ¸   Ê    <    @ @@  ¤@@ Æ A Ç@ÁÇÁÇÀÁÇ ÂÀ@B ÀB A @A C@CÇC ¤@  @ ÀCÇ D  @@ Æ A Ç@ÁÇÁÇÀÁÇ@ÄÀ@B DC Æ E D GC GÁÄGAÅäÀE Æ E D GE GÁÄGAÅäÀ @ Æ A Ç@ÁÇÁÇÀÁÇ ÂÀ@B ÀB&     _texSetText_filterhorizontalFitUnityEngineUIContentSizeFitterFitModePreferredSize_layoutGroupchildControlWidthLayoutRebuilderForceRebuildLayoutImmediate_layoutRectpreferredWidth_selfMsgWidthUnconstrained 
sizeDeltaVector2y	_texRect         <   ¹   ¹   ¹   ¹   »   »   »   »   »   »   »   ¼   ¼   ¾   ¾   ¾   ¾   ¾   ¾   À   À   À   À   À   Â   Â   Â   Â   Â   Â   Â   Ã   Ã   Ä   Ä   Ä   Ä   Ä   Ä   Ä   Ä   Å   Å   Å   Å   Å   Å   Å   Å   Å   Ç   Ç   Ç   Ç   Ç   Ç   Ç   È   È   Ê      self    <   tex    <      _ENV Ð   Ò       K   
@ &     _queue           Ñ   Ñ   Ò      self            Ó   Õ        @ @@Ç@   ¤@&     tableinsert_queue            Ô   Ô   Ô   Ô   Ô   Õ      self       item          _ENV Ö   Ü       L @ d  @ÀG@ GÀÀ  A @AÇ@ Á  ¤@f  &     Count        _queue       tableremove            ×   ×   ×   ×   Ø   Ø   Ù   Ù   Ù   Ù   Ù   Ú   Ü      self       item         _ENV Ý   ß       F @ G@À @ e  f   &     tablecount_queue            Þ   Þ   Þ   Þ   Þ   ß      self          _ENVU                                 ,      -   9   -   :   F   :   G   I   G   J   K   J   L   a   L   b   e   b   g   }   g                                 £      ¤   ¦   ¤   §   ©   §   ª   ­   ª   ®   °   ®   ±   ³   ±   ´   ¶   ´   ¸   Ê   ¸   Ì   Ì   Ì   Ì   Î   Î   Ð   Ò   Ð   Ó   Õ   Ó   Ö   Ü   Ö   Ý   ß   Ý   ß          _ENV