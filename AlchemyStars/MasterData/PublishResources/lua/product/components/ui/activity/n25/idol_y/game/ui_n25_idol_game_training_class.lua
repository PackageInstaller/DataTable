LuaS 

xV           (w@l@../PublishResources/lua/product/components/ui/activity/n25/idol_y/game/ui_n25_idol_game_training_class.lua             @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@ &     _classUIN25IdolGameTrainingClassUICustomWidgetSetData
_SetStateSetBtnState	_SetHead	_SetText_SetTrainPoint	_SetMuseStartBtnOnClick                  ãA   ÁA  
À
ÌÁ@ @ äAÌA AB  äAÌAA @ äAÌA @äAÌÁA @ À äAÌB @Â  CB  C äA&  
   _trainType       
_callback
_SetStateSetBtnState	_SetHead	_SetText_SetTrainPoint	_SetMuse                           
   
   
                                                                     self       
trainType       value       txtSong       head       muse       	callback                   
   @@ @À   K Á  Á kA  ÁA  «A Ë Â A ëA +AG@ ¤ 
 @@ @BÇ @   ¤@&  
   
_stateObjUIWidgetHelperGetObjGroupByWidgetName
_bg_music_headBg_music
_bg_dance_headBg_dance_bg_perform_headBg_performSetObjGroupShow                                                                                             self       state          _ENV     +       @@ @À    K Á  kA  Á «A +A G@ ¤ 
 @@ @AÇ @   ¤@&     _btnStateObjUIWidgetHelperGetObjGroupByWidgetName	StartBtnProcessBtnSetObjGroupShow            "   "   #   #   $   %   %   %   &   &   '   )   "   )   *   *   *   *   *   +      self       state          _ENV -   2       b   @ @ @@À     @ ¤@ À@  ¤@AÁ   A   ¤@&     UIWidgetHelperSetRawImage_headGetGameObject_headGroup
SetActive             .   .   /   /   /   /   /   /   1   1   1   1   1   1   1   1   1   2      self       head          _ENV 4   8       b     @ @@À     FÁ@ GÁ d ¤@  &     UIWidgetHelperSetLocalizationText	_txtSongStringTableGet            5   5   6   6   6   6   6   6   6   6   6   8      self       txtSong          _ENV :   ?       ã@ Àÿb      "A    A  F@ GÁÀ  Á B d Á  @ Ä  ¤A &                   UIWidgetHelperSpawnObject_trainPointUIN25IdolCommonTrainPointSetData            ;   ;   <   <   <   <   <   <   =   =   =   =   =   =   >   >   >   >   >   >   ?      self       muse       
trainType       value       uiType      obj         _ENV A   D        @ A  ¤@  ¤@À@  AÀ   A A ¤@ &     GetGameObject_muse
SetActiveUIWidgetHelperSetAnimationPlay_anim+uieff_UIN25IdolGameTrainingClass_muse_loop            B   B   B   B   B   B   C   C   C   C   C   C   D      self       isShow          _ENV F   J        @ ¢   À  @ Ç@@    ¤@&     
_callback_trainType           G   G   G   H   H   H   H   J      self       go                                                      +       -   2   -   4   8   4   :   ?   :   A   D   A   F   J   F   J          _ENV