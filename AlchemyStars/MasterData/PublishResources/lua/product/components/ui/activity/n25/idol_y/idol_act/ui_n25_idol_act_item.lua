LuaS 

xV           (w@e@../PublishResources/lua/product/components/ui/activity/n25/idol_y/idol_act/ui_n25_idol_act_item.lua         %    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lΐ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lΐ 
@ @@ l  
@@@ l@ 
@ &     _classUIN25IdolActItemUICustomWidgetConstructorOnShowSetDataOnHideGetComponentsOnValue	BtnStateLimitGoToOnClickNotOnClick    
           	   K JΐJ ΑJΑJ ΒJΒJ Γ
@ &     type2sprite       n25_oxyc_oxhd_di01       n25_oxyc_oxhd_di05       n25_oxyc_oxhd_di03       n25_oxyc_oxhd_di06       n25_oxyc_oxhd_di02       n25_oxyc_oxhd_di04        	               	   
               self    	                   @ €@ &     GetComponents                       self       	uiParams                      
@ 

ΐ 
 LA dA &     _componentcfgstatus	callbackOnValue                                   self       
component       cfg       status       	callback                      &                       self               &    '   L@@ Α  Α  d 
@ L@@ Α   d 
@ LA Αΐ d
@LA Α@ d
@ LA Αΐ d
@ L@@ Α@  d 
@ L@@ Α  A d 
@LΐD Α  AE Ed 
@ &     nameTexGetUIComponentUILocalizationTexttxtName
fansValuegotoGoGetGameObjectgonotGonotgrayGogray
limitPoolUISelectObjectPathlayouticonImageimgIconatlas	GetAssetUIN25Idol.spriteatlas	LoadTypeSpriteAtlas         '                                                                         "   "   "   "   "   $   $   $   $   $   %   %   %   %   %   %   &      self    '      _ENV '   4    $   F @ G@ΐ @ ΐ@d b@    A  @A A  €@@ ΐA’@      Η@B ΜΑ@ δ@ΗB @ ΑBΗ C GC LΑΓΐd
AD $A AD $A &     StringTableGetcfgTitlenameTexSetTextFans        
fansValuetype2spriteActTypeiconspriteatlas
GetSpriteLimit	BtnState         $   (   (   (   (   (   (   (   (   )   )   )   )   +   +   +   +   +   ,   ,   ,   ,   .   .   .   .   /   /   /   /   /   /   1   1   3   3   4      self    $   nameStr   $   fans   $   sprite   $      _ENV 5   9       G @ L@ΐ Η@ Α@ A_   Γ@  Γ  d@G@A L@ΐ Η@ Α@ A_   Γ@  Γ  d@GΐA L@ΐ Η@ Α@ B_   Γ@  Γ  d@&  	   gotoGo
SetActivestatusUIIdolStatusGoTonotGoNotgrayGoFinish            6   6   6   6   6   6   6   6   6   6   7   7   7   7   7   7   7   7   7   7   8   8   8   8   8   8   8   8   8   8   9      self          _ENV :   F    '   A   @@ @Α  @ €@ @@  A€ Ζ@A ΗΑAA ΑAA θ@ΗAB ΜΒGΒB  δ BB CΒB ΐ $ "   A bB    AB C @ €Bη ϊ&            
limitPoolSpawnObjectsUIN25IdolCommonTrainPointGetAllSpawnListIdolTrainTypeIdolTrainType_MusicIdolTrainType_Perform       _componentUI_GetActLimitcfgUI_CheckActLimit        SetData         '   ;   <   <   <   <   <   >   >   >   ?   ?   ?   ?   ?   ?   @   @   @   @   @   A   A   A   A   A   C   C   C   C   C   C   D   D   D   D   D   D   ?   F   
   self    '   len   '   pools	   '   (for index)   &   (for limit)   &   (for step)   &   
trainType   %   limitValue   %   limitEnable   %   uiType   %      _ENV G   K    	    @ ’     @ Η@@ ΗΐΑ@ €@&     	callbackcfgActIdstatus        	   H   H   H   I   I   I   I   I   K      self    	   go    	        L   O    	    @ @@Α  € Ζΐ@ Η Α  δ@ &     StringTableGetstr_n25_idol_y_act_not_toastToastManager
ShowToast         	   M   M   M   M   N   N   N   N   O      self    	   go    	   tips   	      _ENV%                                                            &      '   4   '   5   9   5   :   F   :   G   K   G   L   O   L   O          _ENV