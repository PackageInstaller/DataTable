LuaS 

xV           (w@d@../PublishResources/lua/product/components/ui/activity/favour_pet/vote/ui_favour_pet_vote_item.lua             @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ @@ l 
@&  
   _classUIFavourPetVoteItemUICustomWidgetSetDataPlayAnimationInSequence
_SetCrown_SetPet
_SetPetCg	_SetVoteBtnOnClick               	   
@ 

À 
@A   ¤AAA  ¤AA  ¤AÁA  ¤A&     
_campaign_component_petId_clickCallback
_SetCrown_SetPet
_SetPetCg	_SetVote              	   
                                                self       	campaign       
component       petId       isChampion       clickCallback                         Á@  À FÁ@ GÁ  ÁA  @  À  C  dA&     uieff_UIFavourPet_Vote_Item_in      B       UIWidgetHelperPlayAnimationInSequence_anim_root                                                            self       index       	animName      	duration      delay         _ENV        
   b@    C    @ A  ¤@  ¤@&     GetGameObject_crown
SetActive        
                                    self    
   isShow    
           (    (    @ @@À  ¤ Æ@ ÇÀÀ   A  ä@ Æ @ Ç@Á  ä@Æ@ ÇÁ   AÂ À äAÆ@ ÇÁ   A À äAÆ@ ÇAÂ  ä @ B@  Â Á  $B&     UIFavourPetHelperGetPetNameUIWidgetHelperSetLocalizationText	_petNameGetPetFirstElementSetImageSprite_elementBox	_elementGetPetStarSpawnObjects_starUICustomWidget         (                                       "   "   "   "   #   #   #   #   #   #   #   $   $   $   $   $   $   $   &   &   &   &   '   '   '   '   '   '   '   (      self    (   petId    (   name   (   atlas1   (   sprite1   (   atlas2   (   sprite2   (   star    (      _ENV *   ;    
)    @ @@Ç@   ¤À@  Ã@  Ã  A A $A$Aâ   ÁA  ÁA $ GB
AGC
AGC
AGÁCD ADÀ¤ ¢A  @D ÁDÀ  B @¤A &     UIFavourPetHelperGetPetCgInfo_component GetGameObject_petCg
SetActiveGetUIComponentRectTransform
sizeDeltasizelocalScalescaleanchoredPositionposrawImageNamestringisnulloremptyUIWidgetHelperSetRawImage         )   +   +   +   +   +   ,   ,   ,   ,   -   -   -   -   -   -   /   /   1   1   1   1   2   2   3   3   4   4   6   7   7   7   7   7   7   8   8   8   8   8   8   ;      self    )   petId    )   info   )   isShow	   )   trans   (   rawImageName   (      _ENV =   F    +    @ @@¤ Æ@ ÇÀÀ   @  ä@ Ç @ Ì@Á@ ä@ A@  Á À$A @ B $F@ GÁ  ÁA B ÂBA  $dA  LAC ÁA dLÃÀC  ÃA  Ã dA&     _componentGetVoteCostItemIdUIWidgetHelperSetItemIcon
_costIconGetZonePetVoteSetLocalizationText_totalVoteGetPetVote_myVoteStringTableGetstr_favour_pet_vote_my_countGetGameObject
SetActive                 +   >   >   >   ?   ?   ?   ?   ?   ?   A   A   A   A   B   B   B   B   B   B   C   C   C   C   D   D   D   D   D   D   D   D   D   D   E   E   E   E   E   E   E   E   E   F      self    +   petId    +   costItemId   +   
totalVote   +   myVote   +      _ENV J   N        @ ¢     @ Ç@@ ¤@ &     _clickCallback_petId           K   K   K   L   L   L   N      self       go                                                              (      *   ;   *   =   F   =   J   N   J   N          _ENV