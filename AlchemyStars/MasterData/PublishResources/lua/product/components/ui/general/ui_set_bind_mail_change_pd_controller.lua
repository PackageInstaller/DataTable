LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/general/ui_set_bind_mail_change_pd_controller.lua         .    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��& �    _class&UISetBindMailChangePasswordControllerUIControllerOnShowOnHideRefreshPasswdShowStatusViewPasswordBtnOnClickCancelBtnOnClickSendCodeBtnOnClickSendCodeBtnOnClickCoroStartCDTimerStartCDTimerCoroBindBtnOnClickBindBtnOnClickCoroCheckEmailCheckPassWordValid           P    �   �@@ �  A�  �� 
� ��@@ �  AA �� 
� ���A  ���
� ��@@ �  A� �� 
����@@ �  A �� 
�����A � ���
�����A  ���
�����A � ���
�����A  ���
�����A � ���
�����A  ���
�����A � ���
�����A  ���
�����A � ���
�����A  ���
�����A � ���
�����A 	 ���
������ 
���� @ �@I ������A A
 ���
� ���A �
 ���
� ��@@ A A�
 �� 
� ���J ��K  �@�
 ̗
�̘
 ̙�@D ��K  �@���A ��K  �@�� M �@ �@M �M �MG�D $� FN GA��  �@��@M �M �MG�D $� FN G���A  �@��@M �M �MGAF $� FN GA���  �@��@M �M �MGAF $� FN G����  �@��@M    FN G��� �@���B � O�@O�O �@�� P �@P��� ��P��P
���& � D   _mailInputGetUIComponentInputFieldMail_codeInputCode
_codeTipsGetGameObject	CodeTips_passwordInput	Password_passwordAgainInputPasswordAgain_onGoOn_offGoOff_passwordTipsGoPasswordTips_cancelBtn
CancelBtn_cancelBtnNormalCancelBtnNormal_cancelBtnClickCancelBtnClick	_bindBtnBindBtn_bindBtnNormalBindBtnNormal_bindBtnClickBindBtnClick_busyGoBusyEffect_passWordTextPassWordText_passwordAgainPlaceHolderPasswordAgainPlaceHolder_mailAccount       text_sendCodeBtnNameSendCodeBtnName	_timerGoTimer_timerLabelUILocalizationText
SetActive_isInCD _timerCoro _isShowPasswdRefreshPasswdShowStatusAddUICustomEventListenerUICustomUIEventListenerGetUIEventPressReleaseInputFieldChangedonValueChangedAddListenerOnIptValueChanged_oldChannelIdGameGlobal
GameLogicClientInfom_login_source         '   *    	   F @ L@� �   d@�F�@ L@� � � d@�& �    _cancelBtnNormal
SetActive_cancelBtnClick        	   (   (   (   (   )   )   )   )   *      go    	      self /   2    	   F @ L@� � � d@�F�@ L@� �   d@�& �    _cancelBtnNormal
SetActive_cancelBtnClick        	   0   0   0   0   1   1   1   1   2      go    	      self 8   ;    	   F @ L@� �   d@�F�@ L@� � � d@�& �    _bindBtnNormal
SetActive_bindBtnClick        	   9   9   9   9   :   :   :   :   ;      go    	      self @   C    	   F @ L@� � � d@�F�@ L@� �   d@�& �    _bindBtnNormal
SetActive_bindBtnClick        	   A   A   A   A   B   B   B   B   C      go    	      self H   L         @ @@ � � $@��@ @@ � � $@��@ @@ �   $@�& �    _passwordAgainPlaceHolder
SetActive_passWordText_passwordTipsGo           I   I   I   I   J   J   J   J   K   K   K   K   L          self�                                             	   	   	   	   	   
   
   
   
   
                                                                                                                                                                                                                               !   !   !   !   "   "   "   "   #   #   $   %   %   %   %   &   &   *   $   ,   -   -   -   -   .   .   2   ,   5   6   6   6   6   7   7   ;   5   =   >   >   >   >   ?   ?   C   =   E   F   G   G   L   E   N   N   N   N   N   O   O   O   O   O   O   P      self    �   	uiParams    �      _ENV R   W       G @ b   ��F@@ G�� d�� L�� � @ d@�
 A�& �    _timerCoroGameGlobalTaskManager	KillTask             S   S   S   T   T   T   T   T   T   U   W      self          _ENV Y   g    >   G @ L@� ǀ@ d@�G�@ L@� ǀ@ � �d@�G�@ b   ��G A ��A ��A� B�@B��BJ���G�B ��A ��A� B�@B��BJ���@�G A ��A ��A� B�@B� CJ���G�B ��A ��A� B�@B� CJ���G A G@� L@� �   d@�G A G@� L@� � � d@�G�B G@� L@� �   d@�G�B G@� L@� � � d@�& �    _onGo
SetActive_isShowPasswd_offGo_passwordInputcontentTypeUnityEngineUIInputFieldContentType	Standard_passwordAgainInput	PasswordgameObject         >   Z   Z   Z   Z   [   [   [   [   [   \   \   \   ]   ]   ]   ]   ]   ]   ]   ^   ^   ^   ^   ^   ^   ^   ^   `   `   `   `   `   `   `   a   a   a   a   a   a   a   c   c   c   c   c   d   d   d   d   d   e   e   e   e   e   f   f   f   f   f   g      self    >      _ENV i   l       G @ [ � 
@ �L@@ d@ & �    _isShowPasswdRefreshPasswdShowStatus           j   j   j   k   k   l      self            n   p       L @ d@ & �    CloseDialog           o   o   p      self            r   �    ,   G @ b     �& � G@@ ��@ ��@� � �� �   ��� A �@AƀA ��� �  �@  & � �@B  � ����B��� A �@AƀA ���� �  �@  & � � C A �@���C ��C��� � DAD @  �� �@�& �    _isInCD_mailAccountstringisnulloremptyToastManager
ShowToastStringTableGet#str_set_change_passwd_mail_Is_nullCheckEmail (str_set_change_passwd_mail_format_errorLock9UISetBindMailChangePasswordController_SendCodeBtnOnClickGameGlobalTaskManager
StartTaskSendCodeBtnOnClickCoro         ,   s   s   s   t   v   x   x   x   x   x   x   y   y   y   y   y   y   y   z   }   }   }   }   }   ~   ~   ~   ~   ~   ~   ~      �   �   �   �   �   �   �   �   �   �   �   �      self    ,   mail   ,      _ENV �   �    	*   � @ �@�� ̀�@� � ��@ ���A�� � ��F�@ G�GA�@@��B �BFC GA��� d $A  �C D�� $A�AD $A ���D A@$� �D�����$A AE �� $A�& �    	SDKProxyGetInstanceRequestVerifyCodeINTLVerifyCodeTypeResetPasswordRetCodeINTLErrorCodeSUCCESSToastManager
ShowToastStringTableGetstr_login_code_tip
_codeTips
SetActiveStartCDTimerUICommonHelperHandleLoginErrorCode
ThirdCodeUnLock9UISetBindMailChangePasswordController_SendCodeBtnOnClick         *   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    *   TT    *   account    *   ret   *      _ENV �   �    	   F@@ G�� d�� L�� � A    d� 
@ �& �    _timerCoroGameGlobalTaskManager
StartTaskStartCDTimerCoro         	   �   �   �   �   �   �   �   �   �      self    	      _ENV �   �    	'   
@@���@ ��@� �@�� A ��@  �@��@ �� �A B�AB ��B�� ����$A  C @� �A $A���C!�� ��@ �@�  $A�A �@�� $A�
�C�
@D�  � �& �    _isInCD	_timerGo
SetActive_sendCodeBtnName        <       _timerLabelSetTextStringTableGetstr_set_send_code_cd_tipsYIELD�              _timerCoro          '   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    '   TT    '   timer
   '   CD   '      _ENV �   �    |   G @ �@@ ��@��@ ǀ�A �@FAA G���� d� b  ��F�A G��AB ��B�� � dA  & � LC �� d��@���F�A G��AB ��B�� � dA  & � FAA G��� d� b  ��F�A G��AB ��B�� � dA  & � FAA G��� d� b  ��F�A G��AB ��B� � dA  & � FAA GA�� d� `��@�FAA GA�� d�  @����F�A G��AB ��B� � dA  & � LAE � d��@���F�A G��AB ��B�� � dA  & � _�  �G�E L��� dA�GAF L��  dA�G�F L��  dA�& � L�F � dA�FAG G��d�� L���H    @� � � dA�& � !   _mailAccount_passwordInputtext_passwordAgainInput_codeInputstringisnulloremptyToastManager
ShowToastStringTableGet#str_set_change_passwd_mail_Is_nullCheckEmail (str_set_change_passwd_mail_format_error'str_login_msdk_intl_login_reg_vc_error6str_set_change_passwd_error_code_new_password_is_nulllen              3str_login_register_or_forget_password_length_errorCheckPassWordValid1str_set_change_passwd_error_code_pw_fomart_error_passwordTipsGo
SetActive_passwordAgainPlaceHolder_passWordTextLock5UISetBindMailChangePasswordController:BindBtnOnClickGameGlobalTaskManager
StartTaskBindBtnOnClickCoro         |   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    |   mail   |   	password   |   passwordAgain   |   code   |      _ENV �   �    ?   F@ LA�d� L����@ ���� d�  @�� ���A � �A�& � �@ �A@�� �B � @ � �B  ����ǁB�B CBC �@�ƁC ���D BDA� $ �A  ��D  � �A �E �A �AE ǁ�䁀 ���C� �F �B   �A ��ƁF �A�� ���G�B�G�A ́A A� �A�& �    	SDKProxyGetInstanceGetIntlChannelEngineGameHelperSAIchannelId UnLock5UISetBindMailChangePasswordController:BindBtnOnClickResetPasswordWithVerifyCodeRetCodeINTLINTLErrorCodeSUCCESSToastManager
ShowToastStringTableGetstr_set_change_passwd_successYIELDCloseDialogGameGlobal
GameLogicBackToLoginLoginModulebind accountUICommonHelperHandleLoginErrorCode
ThirdCode         ?   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    ?   TT    ?   mail    ?   	password    ?   code    ?   channelName   ?   ret   ?      _ENV �   �       b@  @ ��   �  � @ �@@� � ��  �@@ ��   �  ���  ����   � �� � �  @ ��   �  & �    stringlen       match6[A-Za-z0-9%.%%%+%-]+@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       strContent          _ENV �          � @ �@@� � �  ���_�@@ ��   �  � � �  & �    stringmatch*[^%w_!%[%]%-%+%(%)@#%$%%%^&%*=\/%?<>,:;|]             �   �   �   �   �   �   �   �   �   �   �         self       info       t         _ENV.                        P      R   W   R   Y   g   Y   i   l   i   n   p   n   r   �   r   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      �             _ENV