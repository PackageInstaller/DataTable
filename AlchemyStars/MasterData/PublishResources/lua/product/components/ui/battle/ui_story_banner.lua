LuaS �

xV           (w@J@../PublishResources/lua/product/components/ui/battle/ui_story_banner.lua         .    @ A@  ��@ $@�@@  ��@@ l   
@�� A l@  
@�� A l�  
@ � A l�  
@�� A l  
@ � A l@ 
@�� A l� 
@ � A l� 
@�� A l  
@ � A l@ 
@�� A l� 
@ ��C l� 
@ ��C l  
@��& �    _classUIStoryBannerUIControllerOnShowUIStoryBannerGetStoryBannerListOnHideSetObjectAlphaSetTextLabelAlpha_OnFadeUpdate	_SetData_DoHideAnimation_DoShowAnimation	ShowText
bgOnClickUIStoryBannerSetSpineAlphaLockHomeLandInput           U    �   � @ �@@�   �  �@�� � 
����@A ��A�� � G�@ +A� C  �� �@��@� 
� ���� 
� ��@� 
� ���C  ���
� ���D � A �� 
�����D � A �� 
�����D  AA �� 
�����D  A� �� 
� ���D A A� �� 
� ���C  ���
�����D � A� �� 
�����D � A� �� 
�����C � ���
� �� I �@I  �@���D  A�	 �� 
� ���D  AA
 �� 
� ���D A A�
 �� 
� ���D A AA �� 
� ���D A A� �� 
� ���D A A� �� 
� ���C � ���
�����L �@I  �@�
@M���C � ���
� ���D � AA �� 
� ���D � AA �� 
� ���D  A �� 
�����D  A� �� 
�����D A A �� 
�����C � ���
����@P �@I  �@��@A ��P�� � Q�� �   ���@Q ��Q��� � RG�@ 䀀
���� �� R �@ ���
���
 ��
@M��   
�����R � S���R � ӄ
�Ӧ�   
�����C �@I  �@���G �@I  �@���M �@I  �@��@T � F�T G��� 
� ��@A ��U��� ��UV @  �  ���
����@V C �@��@A ��V��� ��VW AW�@��@A ��V��� ��VW �W�@�& � _   GuideHelperGuideLoadLockUIStoryBanner
_bannerID       GameGlobalUAReportForceGuideEventMissionStoryBanner_bannerType       _endCallback       _lock       _rootGOGetGameObjectroot_headIconElementGetUIComponentRawImageLoader	headIcon
_headIcon	RawImage_textUILocalizationTexttext_speakerNamespeakerName_bgImageduihuakuang_halfGOhalf_halfHeadIconElementhalf_headIcon_halfHeadIcon_halfHeadIconGO
SetActive
_halfText
half_text_halfSpeakerNamehalf_speakName_halfSpeakerNameLineLeft
line_left_halfSpeakerNameLineRightline_right_halfBghalf_duihuakuang_spineLoaderSpineLoaderspine_loader_spineLoaderGO	_isSpine _homelandGO	homeland_hlBodyElementhl_body_hlBody_hlContexthl_contexnt_hlNamehl_name_hlBghl_duihuakuang_blackBgGOblackbgGetInstanceIsCoreGameRunningConfigServiceHelperGetLevelConfigData_bannerListGetStoryBannerList_index
_canClick_speakerNameLinethread_duihua_kuang6_colorPattern<color=#%x*_bannerText_iconAtlas	GetAssetUIInnerStoryTips.spriteatlas	LoadTypeSpriteAtlas_showTextTaskIDTaskManager
StartTask	ShowTextLockHomeLandInputEventDispatcher	DispatchGameEventTypeCancelChainPathHideChainPathCancelArea         �                                                   	   	   
   
                                                                                                                                                                  !   !   !   !   !   #   #   #   #   #   %   %   %   %   %   '   '   '   '   '   )   )   )   )   )   +   +   +   +   +   -   -   -   -   .   .   .   .   0   3   3   3   3   4   4   4   4   4   5   5   5   5   5   6   6   6   6   6   7   7   7   7   7   8   8   8   8   8   :   :   :   :   ;   ;   ;   ;   =   =   =   =   =   =   =   >   >   >   ?   ?   ?   ?   ?   A   A   A   A   C   D   F   F   G   G   H   H   J   L   L   M   M   M   M   N   N   N   N   O   O   O   O   P   P   P   P   P   P   Q   Q   Q   Q   Q   Q   Q   Q   Q   R   R   R   S   S   S   S   S   S   S   T   T   T   T   T   T   T   U      self    �   	uiParams    �   levelConfigData�   �      _ENV X   d       � @ �@@�@ �   �@   ��@ �@A �� $A�AA G�A$ �F�A L�� d���BB ��B�� ��B�)�  ���  & �    Cfgcfg_story_bannerLogfatalbannerConfig is Nil BannerID:ipairsBannerListStoryBannerParamNewtableinsert            Y   Y   Y   [   \   \   ]   ]   ]   ]   ]   _   _   _   _   `   `   `   `   a   a   a   a   a   _   _   c   d   
   self       	bannerId       bannerConfig      bannerList      (for generator)      (for state)      (for control)      _      v      bannerParam         _ENV f   p    $   F @ G@� d�� L�� ��@ � �AA �Ad@ G�A b   @ �G�A d@� G B b   ��F @ G@� d�� L�� � B d��b   ��F @ G@� d�� L�� � B d@�
 C�L@C �   d@�& �    GameGlobalEventDispatcher	DispatchGameEventTypeFinishGuideStep
GuideTypeStoryBanner_endCallback_showTextTaskIDTaskManager	FindTask	KillTask LockHomeLandInput         $   g   g   g   g   g   g   g   g   g   h   h   h   i   i   k   k   k   k   k   k   k   k   k   k   k   l   l   l   l   l   l   m   o   o   o   p      self    $      _ENV q   s       � � ����& �    colora                   r   r   s      self       object            u   �    	   � @ @@  �& � ǀ� ���A AAA� ��A �B�A�� $�  FA G��� ��B ,  d� ��  ��A�& �    _bannerTextcolorastringformat%02xmathfloor�       gsub_colorPatternSetText         �   �       @   �   ]�� f  & �               �   �   �   �   �      s          	colorStr   v   w   w   x   z   z   {   {   {   {   {   {   {   {   }   }   ~      �   }   �   �   �   �      self       textObject       text      alpha      	colorStr      str         _ENV �   �       & �                �      self            �   �    �   � @ �@@ �� �    �ǀ@ ���GA�@�� �ǀ@ ���C  �@��@A� ���A ��A �����AB G�B ��B �C BC G�C �BB ��@� �B���C ��@  �B��D ��@  �B��B@ _@D@ ���D�B ��DE$ �B  ����A ��A �B��@��C G�E ��E �F BF ��F�� �  �
�
 Ǎ�BG ��@  �B���G ��@� �B�b@  ����G �H_@H� ���G ��H�B ��G ��HI$ �B  �BI�� �  ����G ��I�	 LCId� �� �B��J �BJǂG ǂ��J $� LId �B  ��
 ˍ�BG ��@� �B���G ��@  �B��B@ _@D@ ���D�B �F ��DE$ �B  GBK �BB ��@  �B���C ��@� �B��D ��@  �B�����A ��A ǂ����D G�K �L �AL �L G�L �BL ��DE$ �B  �BB ��@  �B���C ��@  �B��D ��@� �B��BM�� 
�����CM$ �B  ��M ��B���M  ��B���M  ��B��N  ��B���M   �B���M  ��B���@� �B�& � 9   _bannerList_index_blackBgGO
SetActive_showBlackBgGetSpeakerName_bannerTypeStoryBannerShowTypeNormal_rootGO_text
_headIcon_headIconElement_speakerName_bg_halfGO_homelandGO       DestoryLastImage
LoadImageGetHeadIconNameHalfPortrait
_halfText_halfHeadIcon_halfHeadIconElement_halfSpeakerNameIsSpine	_isSpine_halfHeadIconGO_spineLoaderGO_spineLoaderCurrentSkeleton DestroyCurrentSpine
LoadSpineGetSpineNameGetSpineAnimSetAnimation        UICGSetTransform
transformGetName _halfBgHomelandGuide_hlContext_hlBody_hlBodyElement_hlName_hlBg_bannerTextGetTextSetTextSetObjectAlphaSetTextLabelAlpha         �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   
   self    �   bSame    �   banner   �   speakerNameStr   �   go   �   text   �   headIconElement   �   	headIcon   �   speakerName   �   bg   �      _ENV �      	�   � @ �@@��@��@��� � A AA �A �����AGB LA��� � d �@  � CGAC LA��� � d �@  � CG�C LA��� � d �@  � CG�C LA��� � d� L��  d��@  �@D  � A� �@� &�� A AA �D ���� E �   ����AGAE LA��� � d �@  � CG�E LA��� � d �@  � CG�E LA��� � d �@  � CGF LA��� � d �@  � CGAF LA��� � d� L��A  d��@  ��  ��@��F ������$A�� �AD @� �A $A����F �� $A�@���AG�G LA��� � d �@  � CGAE LA��� � d �@  � CG�E LA��� � d �@  � CG�E LA��� � d �@  � CGF LA��� � d �@  � CG�G LA��� � d� L��  d��@  �@D  � A� �@��	�� A AA H �����AGAH LA��� � d �@  � CG�H LA��� � d �@  � CG�H LA��� � d �@  � CGI LA��� � d� L���  d��@  �@D  � A� �@�& � %   DG	TweeningDOTween	Sequence_bannerTypeStoryBannerShowTypeNormalAppend_bgDOFade        �������?Join
_headIcon_speakerName_text	OnUpdateYIELDd       HalfPortrait	_isSpine_halfBg_halfSpeakerNameLineLeft_halfSpeakerNameLineRight_halfSpeakerName
_halfText       SetSpineAlpha       !       _halfHeadIcon
_halfTextHomelandGuide_hlBody_hlBg_hlName_hlContext         �   �            @ �@@ $@�& �    SetTextLabelAlpha_text           �   �   �   �   �          self �   �            @ �@@ $@�& �    SetTextLabelAlpha
_halfText           �   �   �   �   �          self 	             @ �@@ $@�& �    SetTextLabelAlpha
_halfText           
  
  
  
           self              @ �@@ $@�& �    SetTextLabelAlpha_hlContext                            self�   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �                                                                                                                                                                                                        self    �   TT    �   	sequence   �   count]   l      _ENV   a   
�   � @ �@@��@��@��� � A AA �A �����AGB LA��� � d �@  ��AGC LA��� B d �@  ̀CG�C LA��� B d �@  ��AGD LA��� B d� LA��  d��@  ƀD  � A� �@� '�� A AA E ����@E �   ��̀E A� �@�� F �@�A� �� �@ ��  @� ��E �A�$A�̀��D @� �� $A� ��E �� $A��A��F �AB� AB � $A  �A�G �AB� AB � $A  �C�AG �AB� AB � $A  �A��G �AB� AB �� �AD,B  ��$A  �D @� �� $A�@���AGH LA��� � d �@  ̀CGF LA��� � d �@  ��AG�F LA��� B d �@  ��AGG LA��� B d �@  ̀CGAG LA��� B d �@  ��AGAH LA��� B d� LA��  d��@  ƀD  � A� �@��	�� A AA �H �����AG�H LA��� � d �@  ��AGI LA��� B d �@  ̀CGAI LA��� B d �@  ��AG�I LA��� B d� LA���  d��@  ƀD  � A� �@�& � '   DG	TweeningDOTween	Sequence_bannerTypeStoryBannerShowTypeNormalAppend_bgDOFade       �������?
_headIcon�������?Join_speakerName_text	OnUpdateYIELD�      HalfPortrait	_isSpineSetSpineAlpha        _halfBg       !       _halfSpeakerNameLineLeft_halfSpeakerNameLineRight_halfSpeakerName
_halfText�       _halfHeadIcon
_halfTextHomelandGuide_hlBg_hlBody_hlName_hlContext         (  *           @ �@@ $@�& �    SetTextLabelAlpha_text           )  )  )  )  *         self ?  A           @ �@@ $@�& �    SetTextLabelAlpha
_halfText           @  @  @  @  A         self M  O           @ �@@ $@�& �    SetTextLabelAlpha
_halfText           N  N  N  N  O         self Z  \           @ �@@ $@�& �    SetTextLabelAlpha_hlContext           [  [  [  [  \         self�   !  !  !  !  !  "  "  "  "  "  #  #  #  #  #  #  #  $  $  $  $  $  $  $  %  %  %  %  %  %  %  &  '  '  '  '  '  '  *  '  &  -  -  -  -  -  .  .  .  .  .  /  /  /  0  0  0  1  1  1  1  1  3  4  4  5  5  5  6  7  7  7  7  7  9  9  9  :  :  :  :  :  :  :  ;  ;  ;  ;  ;  ;  ;  <  <  <  <  <  <  <  =  >  >  >  >  >  >  A  >  =  D  D  D  D  D  F  F  F  F  F  F  F  G  G  G  G  G  G  G  H  H  H  H  H  H  H  I  I  I  I  I  I  I  J  J  J  J  J  J  J  K  L  L  L  L  L  L  O  L  K  R  R  R  R  S  T  T  T  T  T  U  U  U  U  U  U  U  V  V  V  V  V  V  V  W  W  W  W  W  W  W  X  Y  Y  Y  Y  Y  Y  \  Y  X  _  _  _  _  a     self    �   TT    �   	sequence   �   count?   p      _ENV c  �   R   � @ �@  ���@@ �@ ƀ@ ��� GAA �@��   ���   �A �ABAB$�� G�B ��B �C��@ ��@C ��G�B ��B ��C��@ ���C ��G�B ��B �D��@ ��@D  �F�@ G���� ǁB dA�L��A dA�L�E � dA�L�E ��dA�LF ��dA�FAF �� �� dA�L�F��AB �� � ���l  ��dA  A� �� H @� �@�̀E @ �@��@H @� �@�
�H�& � $   _bannerListCloseDialogLogfatalBannerID is invalid ID:
_bannerIDDG	TweeningDOTween	Sequence_bannerTypeStoryBannerShowTypeNormal_textHalfPortrait
_halfTextHomelandGuide_hlContexterror)UIStoryBanner:ShowText error bannerType SetText	_SetDataSetObjectAlphaSetTextLabelAlphaYIELDd       AppendDOFade       �������?	OnUpdate_DoHideAnimation_DoShowAnimation
_canClick         {  }           @ � � $@�& �    SetTextLabelAlpha           |  |  |  |  }         selftextR   d  d  d  e  e  f  f  f  f  f  h  h  i  j  j  j  j  j  k  k  k  k  k  l  l  m  m  m  m  m  n  n  o  o  o  o  o  p  p  r  r  r  r  r  t  t  t  u  u  u  v  v  v  w  w  w  x  x  x  x  y  z  z  z  z  z  }  z  y      �  �  �  �  �  �  �  �  �  �  �     self    R   TT    R   bSame    R   text   F   	sequence   F      _ENV �  �   	8   F @ G@� d�� L�� ��@ � ��  
���
K  
A��d@ G�B �� @ �& �   �
�B�G C �@C �  �� � �L�C d@  �G C M�� 
@ �G@C � C ��CG�� �@C � C �� �   � �AD� $�  "  @ �� �   ��   @ �D$�� E�AE �   �$��
 �& �    GameGlobalGameRecorderRecordActionGameRecordActionUIInputuiUIStoryBannerinput
bgOnClickargs
_canClick _index_bannerListCloseDialog       IsSameSpeakerGetSpeaker_showTextTaskIDTaskManager
StartTask	ShowText         8   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    8   
preBanner!   7   
curBanner$   7   bSame%   7      _ENV �  �   '   �@@ ��@�@ FA GA�G��$ ��  
� ��@@ ��@�@ FA GA�G�GA�$ ��  
���� @ �   @�� @ ��B�@��� @ ʀ �@���A �   ����A � C�   � ���A � C�@��& �    
_spineSke_spineLoaderGOGetComponentInChildrentypeofSpineUnitySkeletonGraphic_spineSkeMultipleTexModulesSkeletonGraphicMultiObjectcolora	SkeletonA         '   �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self    '   alpha    '   color         _ENV �  �      � @ �@@ƀ@ �� ��@� �   @��$� AA$� �A�� $A��$� �A$� �A�� $A�& �    GameGlobalGetUIModuleHomelandModule
GetClientInputManagerGetControllerCharSetGuideLockGetControllerBuild            �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     self       Lock       homeLandModule      homelandClient         _ENV.                        U      X   d   X   f   p   f   q   s   q   u   �   u   �   �   �   �   �   �   �     �     a    c  �  c  �  �  �  �  �  �  �  �  �  �         _ENV