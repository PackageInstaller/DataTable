LuaS 

xV           (w@f@../PublishResources/lua/product/components/ui/activity/favour_pet/vote2/ui_favour_pet_vote2_item.lua             @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lΐ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lΐ 
@ &     _classUIFavourPetVote2ItemUICustomWidgetSetDataPlayAnimationInSequence
_SetCrown	_SetName_SetCg	_SetVoteDetailBtnOnClickBtnOnClick               	   
@ 

ΐ 
@A   €AAA  €AA  €AΑA  €A&     
_campaign_component_voteId_clickCallback
_SetCrown	_SetName_SetCg	_SetVote              	   
                                                self       	campaign       
component       voteId       isChampion       clickCallback                         Α@  ΐ FΑ@ GΑ  ΑA  @  ΐ  C dA&      uieff_UIFavourPet_Vote2_Item_in      d       UIWidgetHelperPlayAnimationInSequence_anim_root                                                            self       index       	animName      	duration      delay         _ENV        
   b@    C    @ A  €@  €@&     GetGameObject_crown
SetActive        
                                    self    
   isShow    
           *    	       Α   A@ @GΑ@  $"  @FA GAΑAd ΐ FA@ GΑΑBd  FAB GΒ  ΑΑ   dA FAB GΒ  Α  dA &     UIFavourPetHelperGetSkinInfo_componentStringTableGet	SkinNameGetPetNamePetIdUIWidgetHelperSetLocalizationText	_petName
_skinName                    "   "   "   "   "   #   #   $   $   $   $   $   %   %   %   %   %   (   (   (   (   (   (   )   )   )   )   )   )   *      self        voteId        petName       	skinName       cfg          _ENV ,   >    *      Ζ@@ ΗΐΑ@ @ δ Α  A   LAA ΐ dLΑΐ dA"  LΑA Α   d ΒJΓJΓJΑΓΖD ΗAΔ  δ βA  @ΖD ΗΑΔ   @  δA &     _skinCgUIFavourPetHelperGetPetCgInfo_component GetGameObject
SetActiveGetUIComponentRectTransform
sizeDeltasizelocalScalescaleanchoredPositionposrawImageNamestringisnulloremptyUIWidgetHelperSetRawImage         *   -   .   .   .   .   .   /   /   /   /   0   0   0   0   0   0   2   2   4   4   4   4   5   5   6   6   7   7   9   :   :   :   :   :   :   ;   ;   ;   ;   ;   ;   >      self    *   voteId    *   widgetName   *   info   *   isShow
   *   trans   )   rawImageName   )      _ENV @   O    '    @ @@Η@ € Η@ Μΐΐ@ δ  
AA
ΑA’    _ Β GAbA    GAAB Bΐ  Β FC GBΓd €A  @ C  €ΖAB ΗΒ   AΒ  δA &     UIFavourPetHelperNotEnoughVoteItem_componentGetPetVote       str_favour_pet_vote       str_favour_pet_vote_finish        UIWidgetHelperSetLocalizationText_txtVoteBtnStringTableGetGetZonePetVote_totalVote         '   A   A   A   A   B   B   B   B   E   F   G   I   I   I   I   I   I   I   I   J   J   J   J   J   J   J   J   J   M   M   M   M   N   N   N   N   N   N   O      self    '   voteId    '   isVoted   '   myVote   '   tb   '   strId   '   
totalVote    '      _ENV S   U        @ A  G@ Α@ €@&     ShowDialogUIFavourPetVote2Detail_component_voteId           T   T   T   T   T   U      self       go            W   [        @ ’     @ Η@@ €@ &     _clickCallback_voteId           X   X   X   Y   Y   Y   [      self       go                                                              *      ,   >   ,   @   O   @   S   U   S   W   [   W   [          _ENV