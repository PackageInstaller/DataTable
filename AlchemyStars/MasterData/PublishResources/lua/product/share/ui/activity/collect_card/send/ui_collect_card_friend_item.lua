LuaS 

xV           (w@e@../PublishResources/lua/product/share/ui/activity/collect_card/send/ui_collect_card_friend_item.lua         (    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lÀ 
@@@ l  
@ @@ l@ 
@@@ l 
@ &     _classUICollectCardFriendItemUICustomWidgetOnShowSetDataSetLvSetFriendNameGetHeadBgNameGetHeadIconNameGetHeadFrameNameSetHeadSelectBtnOnClick               [   @@   AÁ  ¤ 
 @@   AA ¤ 
 @@   AÁ ¤ 
 @B  ¤
 @B  ¤
@B  ¤
@@  AA ¤ 
@@  AÁ ¤ 
 @@  AA ¤ 
 @@  AÁ ¤ 
 @@ A AÁ ¤ 
 @@ A AÁ ¤ 
 @@ A AA ¤ 
 @@  AÁ ¤ 
  B ÀG  ¤@ÀB ÀG ¤@ @  HÀG  ¤@ A  HÀG ¤@@H H ÁHGI ¤@ &  %   	_nameTexGetUIComponentUILocalizationTextNameTex
_nameTex2	NameTex2_lvTexLv
_selectGoGetGameObject	SelectGo
_noSelect	NoSelect_btnGoBtn_headBgRectRectTransformheadbg
_headRoot	headRoot_headBgMaskRectmask
_headRecthead_headRawImageLoader_frame
headFrame_headBgUICircleMaskLoader_frameRect
SetActivegameObjectAttachEventGameEventTypeOnCollectCardSelectFriendSelect         [                                                            	   	   	   	   
   
   
   
                                                                                                                                                                                                      self    [   uiParam    [      _ENV    &       
@ 

À LÁ@ dA LA dA LAA dA LA À dA&     _idx_info
_callbackSetLvSetFriendNameSetHeadSelect                     "   "   #   #   $   $   %   %   %   &      self       idx       info       	callback       currentSelectIdx            '   )    
   G @ L@À Æ@ ÇÀÀ GAA GÁä d@  &     _lvTexSetTextStringTableGetstr_collect_card_friend_tips3_infolevel         
   (   (   (   (   (   (   (   (   (   )      self    
      _ENV *   3       D    @ @@Ç@ ÇÀÀ¤ ¢    @ G A@ @ GÀ@@A A  ¤@ÀA A  ¤@&     stringisnullorempty_inforemark_namenick	_nameTexSetText
_nameTex2            +   ,   ,   ,   ,   ,   ,   ,   -   -   -   /   /   1   1   1   1   2   2   2   2   3      self       	showName         _ENV 4   <       F @ G@À @ À@G b@  À A @A¤ A¤ Æ @ Ç@ÀGÀÁ ¦  &     Cfgcfg_player_head_bg_infohead_bgHelperProxyGetInstanceGetHeadBgDefaultIDIcon            5   5   5   5   5   6   6   7   7   7   7   7   9   9   9   ;   ;   <      self       cfg_head_bg      bid         _ENV =   G       F @ G@À @ À@G b@  À A @A¤ A¤ Æ @ Ç@ÀGb@   À ÁÀ ¦  Â Ç@Â ¦ &  
   Cfgcfg_role_head_image_infoheadHelperProxyGetInstanceGetHeadIconDefaultIDIconTag            >   >   >   >   >   ?   ?   @   @   @   @   @   A   A   A   C   C   D   D   D   F   F   F   G      self       	cfg_head      id         _ENV H   O       F @ G@À @ À@G b@  À A @A¤ A¤ Æ @ Ç@ÀGÀÁ ¦  &     Cfgcfg_role_head_frame_info	frame_idHelperProxyGetInstanceGetHeadFrameDefaultIDIcon            I   I   I   I   I   J   J   K   K   K   K   K   L   L   L   N   N   O      self       cfg_head_frame      id         _ENV P   X       F @ G@À @ À@G b@  À A @A¤ A¤ Æ @ Ç@ÀGÀÁ ¦  &     Cfgcfg_player_head_bg_infohead_bgHelperProxyGetInstanceGetHeadBgDefaultIDIcon            Q   Q   Q   Q   Q   R   R   S   S   S   S   S   U   U   U   W   W   X      self       cfg_head_bg      bid         _ENV Y   h    8   L @ dÀ Ç@@ ÌÀLÁ@ d ä@  Ç A ÌÀ@ ä@Æ@A ÇÁ  ä â@  ÆÀA Ì Âä Ì@ÂGB  ä@ ÇÀB ÌÀLC d ä@  ÆÀA Ì Âä Ì@ÃGC ä@ÆÀA Ì Âä ÌÀÃGD ä@ÆÀA Ì Âä Ì@ÄGD ä@ÆÀA Ì Âä ÌÀÄGE AE Eä@ &     GetHeadIconName_headBg
LoadImageGetHeadBgName_headstringisnulloremptyHelperProxyGetInstanceGetHeadIconSizeWithTag
_headRect_frameGetHeadFrameNameGetHeadBgSizeWithTag_headBgRectGetHeadBgMaskSizeWithTag_headBgMaskRectGetHeadFrameSizeWithTag_frameRectGetHeadRootSizeWithTag
_headRootRoleHeadFrameSizeTypeSize4         8   Z   Z   \   \   \   \   \   ^   ^   ^   ^   _   _   _   _   _   _   `   `   `   `   `   `   `   b   b   b   b   b   d   d   d   d   d   d   e   e   e   e   e   e   f   f   f   f   f   f   g   g   g   g   g   g   g   g   h      self    8   	iconName   8   iconTag   8      _ENV i   n    #    @ @@@ _    A   ¤@À@ @@@     A   ¤@ A @A@@@ _    A   ¤@A @A@@@     A   ¤@&     
_selectGo
SetActive_idx
_noSelect	_nameTexgameObject
_nameTex2        #   j   j   j   j   j   j   j   j   k   k   k   k   k   k   k   k   l   l   l   l   l   l   l   l   l   m   m   m   m   m   m   m   m   m   n      self    #   idx    #        o   s        @ ¢     @ Ç@@ ¤@ &     
_callback_idx           p   p   p   q   q   q   s      self       go           (                                 &      '   )   '   *   3   *   4   <   4   =   G   =   H   O   H   P   X   P   Y   h   Y   i   n   i   o   s   o   s          _ENV