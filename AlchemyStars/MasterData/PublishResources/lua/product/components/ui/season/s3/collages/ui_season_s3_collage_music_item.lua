LuaS �

xV           (w@f@../PublishResources/lua/product/components/ui/season/s3/collages/ui_season_s3_collage_music_item.lua         %    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@A l�  
@ �@A l�  
@��@A l  
@ �@A l@ 
@��@A l� 
@ �@A l� 
@��@A l  
@ �@A l@ 
@��& �    _classUISeasonS3CollageMusicItemUICustomWidgetOnShowInitWidgetUISeasonS3CollageMusicItemSetDataSetNewSelect	DeselectPlayEft	PauseEftRootOnClickPlayExitAnim    
              � @ �@ & �    InitWidget                       self       	uiParams               (    P   L@@ ��    d� 
@ �L@@ �  �  d� 
@��L@@ �  A d� 
@��L�A �  d��
@ �L�A �� d��
@��L@@ �  � d� 
@��L�A �  d��
@ �L@@ �� � d� 
@��L@@ �@  d� 
@ �L@@ �@ � d� 
@ �L@E �� �E Fd� 
@ �L�A �� d��
@��L@@ �  A d� 
@��L�A d� L�� � H AH �H�  d�  
@ �L@@ � 	 A	 d� 
@��G�H G�� 
@ �& � (   iconGetUIComponentRawImageLoader
musicNameUILocalizationTextauthorunlockGetGameObjectUnlocklockLock
conditionnew_layoutLayoutElementUISeasonS3CollageMusicItem_bgImage_maskmask_atlas	GetAssetUIS3Collages.spriteatlas	LoadTypeSpriteAtlas_lightLight_discRectTransformDisc_animGetComponenttypeofUnityEngine
Animation_playingEff	RawImage
eff_yinpu_playingMat	material         P                                                                                                                                                                  !   !   !   !   "   "   "   "   "   #   #   #   #   #   #   #   #   #   &   &   &   &   &   '   '   '   (      self    P      _ENV ,   A    O   
@ �
���̀@ G@ L��d �@  � @ � �� �@  ���@A ǀ�� G@ L�d �@  �@B ǀ�@ B$� � �@ �B$� "  ��C AC�� $A��C AC�  $A��C D�AD ��D���� $A  E D�AD ��D�A�� $A  �E �E��$A���C AC�  $A��C AC�� $A�AF D�AD ��Dǁ�� $A  �F $A G AG�� $A�& �    _data	_onClickSetNewIsNewIsValidLog
exception音乐未解锁无法显示:IDCfgcfg_role_music	IsUnlockunlock
SetActivelock
musicNameSetTextStringTableGetNameauthorAuthoricon
LoadImageIcon
condition
UnLockDes	Deselect_animPlay(uieffanim_UISeasonS3CollageMusicItem_in         O   -   .   /   /   /   /   /   0   0   0   0   0   1   1   1   1   1   1   1   3   3   3   3   3   3   4   4   4   4   4   5   5   5   5   6   6   6   6   7   7   7   7   7   7   7   8   8   8   8   8   8   8   9   9   9   9   9   ;   ;   ;   ;   <   <   <   <   =   =   =   =   =   =   =   ?   ?   @   @   @   @   A      self    O   data    O   onClick    O   cfg   O      _ENV C   E       � @ �@@ � �@�& �    new
SetActive           D   D   D   D   E      self       new            G   R    $   G @ ��@ ��@ ���J���G@A ��A �  A A� �� ���J� �G�B ��A �   A �� ���J� �G@C L�� � � d@�G�C L � d@ G�C L@� �� d@�L�D d@ & �    _bgsprite_atlas
GetSpriteexp_s3_book_fengmian_1
musicNamecolorColorV-���?ףp=
��?       author��v���?_light
SetActive_animStopPlay*uieffanim_UISeasonS3CollageMusicItem_playPlayEft         $   I   I   I   I   I   I   K   K   K   K   K   K   K   K   L   L   L   L   L   L   L   L   M   M   M   M   O   O   O   P   P   P   P   Q   Q   R      self    $      _ENV T   _    $   G @ ��@ ��@ ���J���G@A ��A �  A A� �� ���J� �G C ��A �@ A AA �� ���J� �G�C L�� �   d@�G D L@� d@ G D L�� �� d@�L E d@ & �    _bgsprite_atlas
GetSpriteexp_s3_book_fengmian_3
musicNamecolorColor���Mb�?u�V�?/�$���?       author���(\��?_light
SetActive_animStopPlay*uieffanim_UISeasonS3CollageMusicItem_stop	PauseEft         $   V   V   V   V   V   V   X   X   X   X   X   X   X   X   Y   Y   Y   Y   Y   Y   Y   Y   Z   Z   Z   Z   \   \   \   ]   ]   ]   ]   ^   ^   _      self    $      _ENV a   c       G @ L@� ��  �  d@ & �    _playingMat	SetFloat_Speed                  b   b   b   b   b   c      self            e   g       G @ L@� ��  �  d@ & �    _playingMat	SetFloat_Speed                   f   f   f   f   f   g      self            j   l       � @ �@@ �@ & �    	_onClick_data           k   k   k   l      self       go            n   q       G @ L@� d@ & �    _animStop           o   o   o   q      self           %                                 (      ,   A   ,   C   E   C   G   R   G   T   _   T   a   c   a   e   g   e   j   l   j   n   q   n   q          _ENV