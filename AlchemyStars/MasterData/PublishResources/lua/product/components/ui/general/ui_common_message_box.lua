LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1105/client/Assets/../PublishResources/lua/product/components/ui/general/ui_common_message_box.lua         #    @ A@  ��@ $@�@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �& �    _classUICommonMessageBoxUIMessageBoxConstructorDestructorOnShowClearCallbackAlertAlertOKAlertOKCancelButtonOnClickButtonOKOnClickButtonCancelOnClick    
    	          
@@�
@@�
@��
@@�
@��& �    
_okMsgBox _okCancelMsgBoxokCallbackcancelCallback_text           
                     self                      
@@�
@@�
@��
@@�
@��& �    
_okMsgBox _okCancelMsgBoxokCallbackcancelCallback_text                                self               *    *   L@@ ��  d��
@ �L@@ �  d��
@��L�A ��  d� 
@��L@@ �  d��
@��L�A �� � d� 
@ �G�B G � L@� �   d@�G@B L@� � � d@�F�C G�� d�� L � d� �@A �@���@A ��D�@ & �    
_okMsgBoxGetGameObjectOKMsgBoxRoot_okCancelMsgBoxOKCancelMsgBoxRoot
_blurMaskGetUIComponentH3DUIBlurHelper	BlurMask_blurMaskObjecttglNotRemindTogglegameObject
SetActiveGameGlobalUIStateManagerGetMessageBoxCameraOwnerCameraRefreshBlurTexture         *                                               !   !   !   !   #   #   #   #   #   $   $   $   $   $   &   &   &   &   '   '   '   '   '   (   (   )   )   )   *      self    *   camera$   *      _ENV ,   1       F @ G@� ��  d@ 
 ��
 ��& �    Logdebug[msgbox] ClearCallbackokCallback cancelCallback            -   -   -   -   .   /   1      self          _ENV 3   A       � @ �@��@ ǀ@�@ A � �AA �� � $A ���@ �A �� ��A �� � $A & �    
_blurMaskRefreshBlurTexture       PopupMsgBoxTypeOkAlertOK	OkCancelAlertOKCancel            4   4   4   5   6   6   6   6   7   7   7   7   7   8   8   8   8   9   9   9   9   A      self       popup       params       type         _ENV F   a    J   � @ �@��  G�@� �AA�@�ǀA ���C� �@�� B ���C  �@�̀B A� � � 
����@B �@�G�@�@�̀B A� �� � 
� �ǀC �@�GAA�@��@D @� ��D��D䀀
� �� E�   � �ǀC E� ��̀B A� � � 
� �ǀE �   ���@F�    �ǀE �@�GAF�@���ǀE �@�F�F G��� d �@  �@G ǀ����C  �@�& �    Logdebug&[msgbox] UICommonMessageBox AlertOK [       ]       
_okMsgBox
SetActive_okCancelMsgBox_titleGetUIComponentUIRichTextOKTitleSetText_textOKTextokCallbackGetCallBack                     onHrefClick_okBtnTextUILocalizationTextOkCancelOkBtnText       StringTableGetstr_common_oktglNotRemindgameObject         J   G   G   G   G   G   G   G   H   H   H   H   I   I   I   I   L   L   L   L   L   M   M   M   M   O   O   O   O   O   P   P   P   P   R   R   R   R   R   R   T   T   T   U   U   U   W   W   W   W   W   X   X   X   Y   Y   Y   Z   Z   Z   Z   Z   \   \   \   \   \   \   \   `   `   `   `   `   a      self    J   popup    J   params    J      _ENV p   �    r   � @ �@��  G�@� �AA�@�ǀA ���C  �@�� B ���C� �@�̀B A� � � 
����@B �@�G�@�@�̀B A� �� � 
� �ǀC �@�GAA�@��@D @� ��D��D䀀
� ��@D @� �AEǁE䀀
� ���E�   � �ǀC �E� �̀B A� �� � 
����@F �   ��� G�    ��@F �@�GG�@����@F �@�FAG G���� d �@  ̀B A� �A � 
� �� H �   ��ǀH�    �� H �@�G�H�@���� H �@�FAG G���� d �@  �@I
� �� I �   @�ǀI ������C� �@� �ǀI ������C  �@�& � (   Logdebug,[msgbox] UICommonMessageBox AlertOKCancel [       ]       
_okMsgBox
SetActive_okCancelMsgBox_titleGetUIComponentUIRichTextOKCancelTitleSetText_textOKCancelTextokCallbackGetCallBack              cancelCallback                     onHrefClick_okBtnTextUILocalizationTextOkCancelOkBtnText	       StringTableGetstr_common_ok_okCancelCancelBtnTextOkCancelCancelBtnText
       str_common_canceltoggleTrueCallback       tglNotRemindgameObject         r   q   q   q   q   q   q   q   r   r   r   r   s   s   s   s   v   v   v   v   v   w   w   w   w   y   y   y   y   y   z   z   z   z   |   |   |   |   |   |   }   }   }   }   }   }            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    r   popup    r   params    r      _ENV �   �    
   � @ �@@��  �@ ��@ �   @ ���@ �@� & �    Logdebug-[msgbox] UICommonMessageBox AlertOK click okokCallback         
   �   �   �   �   �   �   �   �   �   �      self    
   go    
      _ENV �   �       � @ �@@��  �@ ��@ � A�    ��@A �   @ ��@A �@� ��A �   @ ���A �@� & �    Logdebug3[msgbox] UICommonMessageBox AlertOKCancel click oktglNotRemindisOntoggleTrueCallbackokCallback            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       go          _ENV �   �       � @ �@@��  �@ ��@ �   @ ���@ �@� � A �@AƀA ����@ & �    Logdebug7[msgbox] UICommonMessageBox AlertOKCancel click cancelcancelCallbackAudioHelperControllerPlayUISoundAutoReleaseCriAudioIDConstSoundCancel            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       go          _ENV#               	      	               *      ,   1   ,   3   A   3   F   a   F   p   �   p   �   �   �   �   �   �   �   �   �   �          _ENV