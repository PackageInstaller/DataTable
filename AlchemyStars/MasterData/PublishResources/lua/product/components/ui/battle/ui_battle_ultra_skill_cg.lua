LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/battle/ui_battle_ultra_skill_cg.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@A l�  
@ �@A l�  
@��@A l  
@ �@A l@ 
@��& � 
   _classUIBattleUltraSkillCGUIControllerOnShowDisposeUIBattleUltraSkillCGSenityCheckSyncLoadAllAssetFetchUIComponentsRefresh               &   � � �@@ @ 䀀�@    �& � ̀@ @ �@�� A GAA G��䀀
�����A A 䀀�@ AB�B����  $A �@ ABFAC G��
A��@ ABFAC G�
A��AD � $A�& �           SenityCheckSyncLoadAllAssettoolboxFetchUIComponents
_fxresReqObjGetGameObject	SafeAreacsRTrsfmEffect
SetParent
transformlocalPositionVector3zerolocalScaleoneRefresh         &                     	                                                                                                   self    &   arg    &   	uiParams   &   go   &      _ENV    +       
@@�G�@ b   � �G�@ L�� d@ 
@@�G A b   � �G A L�� d@ 
@@�G@A b   � �G@A L�� d@ 
@��F�A G�� G�� �   d@ & �    toolbox 
_fxresReqDispose
_cgMatReq_iconMatReqUIBattleUltraSkillCGsuper                                                !   !   !   "   %   %   %   &   &   &   '   *   *   *   *   *   +      self          _ENV -   ?    3   � @ �@@�� ̀@G�� 䀀�@  @�� A �@��A A� �B ��� � �@  �   �  ̀@GA� 䀀�@  @�� A �@��A A� �B �A� � �@  �   �  ̀@G�� 䀀�@  @�� A �@��A A �B ��� � �@  �   �  � � �  & �    ResourceManagerGetInstanceHasResource
effectResLogfatal_classNameinvalid effectRes: 	tostring	petCGMatinvalid petCG: petIconMatinvalid petIcon:          3   .   .   .   /   /   /   /   /   0   0   0   0   0   0   0   0   1   1   4   4   4   4   4   5   5   5   5   5   5   5   5   6   6   9   9   9   9   9   :   :   :   :   :   :   :   :   ;   ;   >   >   ?      self    3   	uiParams    3   resmgr   3      _ENV A   I       � @ �@@�� ��@G� �AA ��A� 
� ���@G� �AA �AB� 
�����@G�� �AA �AB� 
� �& �    ResourceManagerGetInstance
_fxresReqSyncLoadAsset
effectRes	LoadTypeGameObject
_cgMatReq	petCGMatMat_iconMatReqpetIconMat            B   B   B   D   D   D   D   D   D   F   F   F   F   F   F   H   H   H   H   H   H   I      self       	uiParams       resmgr         _ENV K   `    
9   �   �@ �̀� A�  䀀����� � ���� $��B� ��AA�@�� $��� ����� $��B� ���B�@�� $��� ������ $��BL�@� d���@��L���A d��G���� ���������� ����B́@A 䁀���́� A� 䁀�����  & �    csGOEffectcsRTrsfmEffectGetComponentRectTransform
transformcsGORoleCGFindname/root/rolegameObjectcsRawImageRoleCG	RawImage	csGOIconname/name01/roleiconcsRawImageIconname/name01/skillcsTextSkillNameUILocalizationText
name/TextcsTextSkillNameDeco0name/Text1csTextSkillNameDeco1csEffectWithImageEffectEffectWithImageEffect        9   L   M   N   N   N   N   P   Q   Q   Q   Q   Q   R   R   R   R   R   S   S   S   S   S   T   T   T   T   T   V   V   V   V   W   W   W   W   X   X   X   X   Y   Y   Y   Y   Z   Z   Z   Z   [   [   [   [   ]   ]   ]   ]   _   `      self    9   go    9   toolbox   9   csTrsfmEffect   9   csGOSkillName   9   csGOSkillNameDeco0'   9   csGOSkillNameDeco1/   9        b   �    a   � @ �@@�    �ǀ@ �   @�ǀ@ ����   @��@@�@ �@� ��@@�@��A G� GA��� ��B�� $� � ��@@�@��A GA� �A� �� $� � ���C�   ��� D �   ��� D ����   � ���CD �@� ��@D ǀ�� G� A� AE"  � �AE�E��$A��E"  � ��E�E��$A�F"  � �F�E��$A�AF $� AAG�F�����FA 䁀�A���� $��G�Gb  @ �G�GJ�G@ GB�L���� dB�& � #   toolboxcsRawImageRoleCG
_cgMatReqObj	material
transformlocalPositionVector3
offsetPosxy        localScaleoffsetScale       csRawImageIcon_iconMatReqStringTableGetstr_skill_name_skillIDcsTextSkillNameSetTextcsTextSkillNameDeco0csTextSkillNameDeco1GetGameObjectparentFindCameragameObjectGetComponentcsEffectWithImageEffectimageCameracsGOEffect
SetActive         a   c   e   e   e   e   e   e   e   e   e   e   f   f   f   f   g   g   g   g   g   g   g   g   g   g   h   h   h   h   h   h   h   h   k   k   k   k   k   k   k   k   k   k   l   l   l   l   o   o   o   o   o   o   p   p   p   q   q   q   q   s   s   s   t   t   t   t   v   v   v   w   w   w   w   z   z   z   {   |   }   }   }   }   ~   ~   ~   �   �   �   �   �   �   �   �   �   �   �   	   self    a   	uiParams    a   toolbox   a   strSkillName5   a   csTrsfmM   a   csTrsfmUIContainerN   a   csTrsfmDepthO   a   csGOCameraS   a   	csCameraV   a      _ENV                                 +      -   ?   -   A   I   A   K   `   K   b   �   b   �          _ENV