LuaS �

xV           (w@f@../PublishResources/lua/product/components/ui/season/s2/collages/ui_season_s2_collage_music_item.lua         %    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@A l�  
@ �@A l�  
@��@A l  
@ �@A l@ 
@��@A l� 
@ �@A l� 
@��@A l  
@ �@C l@ 
@ �& �    _classUISeasonS2CollageMusicItemUICustomWidgetOnShowInitWidgetUISeasonS2CollageMusicItemSetDataSetNewSelect	DeselectPlayEft	PauseEftRootOnClickUISeasonS1CollageMusicItemPlayExitAnim    
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
conditionnew_layoutLayoutElementUISeasonS2CollageMusicItem_bgImage_maskmask_atlas	GetAssetUIS2Collages.spriteatlas	LoadTypeSpriteAtlas_lightLight_discRectTransformDisc_animGetComponenttypeofUnityEngine
Animation_playingEff	RawImage
eff_yinpu_playingMat	material         P                                                                                                                                                                  !   !   !   !   "   "   "   "   "   #   #   #   #   #   #   #   #   #   &   &   &   &   &   '   '   '   (      self    P      _ENV ,   @    K   
@ �
���̀@ G@ L��d �@  � @ � �� �@  ���@A ǀ�� G@ L�d �@  �@B ǀ�@ B$� � �@ �B$� "  ��C AC�� $A��C AC�  $A��C D�AD ��D���� $A  E D�AD ��D�A�� $A  �E �E��$A���C AC�  $A��C AC�� $A�AF D�AD ��Dǁ�� $A  �F $A & �    _data	_onClickSetNewIsNewIsValidLog
exception音乐未解锁无法显示:IDCfgcfg_role_music	IsUnlockunlock
SetActivelock
musicNameSetTextStringTableGetNameauthorAuthoricon
LoadImageIcon
condition
UnLockDes	Deselect         K   -   .   /   /   /   /   /   0   0   0   0   0   1   1   1   1   1   1   1   3   3   3   3   3   3   4   4   4   4   4   5   5   5   5   6   6   6   6   7   7   7   7   7   7   7   8   8   8   8   8   8   8   9   9   9   9   9   ;   ;   ;   ;   <   <   <   <   =   =   =   =   =   =   =   ?   ?   @      self    K   data    K   onClick    K   cfg   K      _ENV B   D       � @ �@@ � �@�& �    new
SetActive           C   C   C   C   D      self       new            F   Q    (   G @ ��@ ��@ ���J���G@A ��@ ��@� ���J���G�A �@B �� � A �� J� �G@C �@B �� � A �� J� �G@D L�� � � d@�G�D L � d@ G�D L@� �� d@�L�E d@ & �    _bgsprite_atlas
GetSpriteexp_s2_book_fengmian_2_maskexp_s2_book_fengmian_1
musicNamecolorColor�������?�?�?author�?�������?�?_light
SetActive_animStopPlay*uieffanim_UISeasonS1CollageMusicItem_playPlayEft         (   H   H   H   H   H   H   I   I   I   I   I   I   J   J   J   J   J   J   J   K   K   K   K   K   K   K   L   L   L   L   N   N   N   O   O   O   O   P   P   Q      self    (      _ENV S   ^    (   G @ ��@ ��@ ���J���G@A ��@ ��@� ���J���G�A �@B �� � A �� J� �G@C �@B �� � A �� J� �G@D L�� �   d@�G�D L � d@ G�D L@� �� d@�L�E d@ & �    _bgsprite_atlas
GetSpriteexp_s2_book_fengmian_4_maskexp_s2_book_fengmian_3
musicNamecolorColor�������?666666�?�������?author�?�������?�?_light
SetActive_animStopPlay*uieffanim_UISeasonS1CollageMusicItem_stop	PauseEft         (   U   U   U   U   U   U   V   V   V   V   V   V   W   W   W   W   W   W   W   X   X   X   X   X   X   X   Y   Y   Y   Y   [   [   [   \   \   \   \   ]   ]   ^      self    (      _ENV `   b       G @ L@� ��  �  d@ & �    _playingMat	SetFloat_Speed                  a   a   a   a   a   b      self            d   f       G @ L@� ��  �  d@ & �    _playingMat	SetFloat_Speed                   e   e   e   e   e   f      self            i   k       � @ �@@ �@ & �    	_onClick_data           j   j   j   k      self       go            m   p       G @ L@� d@ G @ L�� ��  d@�& �    _animStopPlay)uieffanim_UISeasonS1CollageMusicItem_out           n   n   n   o   o   o   o   p      self           %                                 (      ,   @   ,   B   D   B   F   Q   F   S   ^   S   `   b   `   d   f   d   i   k   i   m   p   m   p          _ENV