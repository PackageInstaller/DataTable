LuaS 

xV           (w@@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/general/ui_set_bind_mail_controller.lua         (    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lΐ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lΐ 
@ @@ l  
@@@ l@ 
@ @@ l 
@&     _classUISetBindMailControllerUIControllerOnShowOnHideCancelBtnOnClickSendCodeBtnOnClickSendCodeBtnOnClickCoroStartCDTimerStartCDTimerCoroBindBtnOnClickBindBtnOnClickCoroCheckEmailCheckPassWordValid           :    l   @@   AΑ  € 
 @@   AA € 
 ΐA  €
 ΐA  €
ΐA  €
ΐA  €
ΐA  €
ΐA  €
ΐA  €
ΐA  €
ΐA  €
ΐA  €
@@  A € 
@F @G  €@
ΐG
@HA @G  €@H ΑH IGAB $ FAI GΙ¬  €@H ΑH IGAB $ FAI GΑΙ¬A  €@H ΑH IGΑC $ FAI GΙ¬  €@H ΑH IGΑC $ FAI GΑΙ¬Α  €@@J J€ ΐJ K
 &  -   _mailInputGetUIComponentInputFieldMail_codeInputCode
_codeTipsGetGameObject	CodeTips_cancelBtn
CancelBtn_cancelBtnNormalCancelBtnNormal_cancelBtnClickCancelBtnClick	_bindBtnBindBtn_bindBtnNormalBindBtnNormal_bindBtnClickBindBtnClick_busyGoBusyEffect_sendCodeBtnNameSendCodeBtnName	_timerGoTimer_timerLabelUILocalizationText
SetActive_isInCD _timerCoro AddUICustomEventListenerUICustomUIEventListenerGetUIEventPressRelease_oldChannelIdGameGlobal
GameLogicClientInfom_login_source                	   F @ L@ΐ Γ   d@F@ L@ΐ Γ  d@&     _cancelBtnNormal
SetActive_cancelBtnClick        	                                 go    	      self #   &    	   F @ L@ΐ Γ  d@F@ L@ΐ Γ   d@&     _cancelBtnNormal
SetActive_cancelBtnClick        	   $   $   $   $   %   %   %   %   &      go    	      self ,   /    	   F @ L@ΐ Γ   d@F@ L@ΐ Γ  d@&     _bindBtnNormal
SetActive_bindBtnClick        	   -   -   -   -   .   .   .   .   /      go    	      self 4   7    	   F @ L@ΐ Γ  d@F@ L@ΐ Γ   d@&     _bindBtnNormal
SetActive_bindBtnClick        	   5   5   5   5   6   6   6   6   7      go    	      selfl                                             	   	   	   	   
   
   
   
                                                                                                                                                                   !   !   !   !   "   "   &       )   *   *   *   *   +   +   /   )   1   2   2   2   2   3   3   7   1   9   9   9   9   9   9   :      self    l   	uiParams    l      _ENV <   A       G @ b   F@@ Gΐ d Lΐΐ Η @ d@
 A&     _timerCoroGameGlobalTaskManager	KillTask             =   =   =   >   >   >   >   >   >   ?   A      self          _ENV C   E       L @ d@ &     CloseDialog           D   D   E      self            G   Y    -   G @ b     &  G@@ Gΐ ΐ@  Aΐ  € ’   ΐ@A AΖΐA Η ΒA δ  €@  &  B   €ΐBΐ@A AΖΐA Η Β δ  €@  &  @C  €@ΐC  D€ @DD @   €@&     _isInCD_mailInputtextstringisnulloremptyToastManager
ShowToastStringTableGet#str_set_change_passwd_mail_Is_nullCheckEmail (str_set_change_passwd_mail_format_errorLock+UISetBindMailController_SendCodeBtnOnClickGameGlobalTaskManager
StartTaskSendCodeBtnOnClickCoro         -   H   H   H   I   K   K   M   M   M   M   M   M   N   N   N   N   N   N   N   O   R   R   R   R   R   S   S   S   S   S   S   S   T   W   W   W   X   X   X   X   X   X   X   X   Y      self    -   mail   -      _ENV [   e    	*   Ζ @ Μ@ΐδ Μΐ@  ΖΑ@ ΗΑΗAΑ δ ΑΑFΑ@ GΒGAΒ@@B ΑBFC GAΓ d $A  ΑC D $AAD $A D A@$ ΑDΑΑΗΕ$A AE  $A&     	SDKProxyGetInstanceRequestVerifyCodeINTLVerifyCodeTypeLoginRetCodeINTLErrorCodeSUCCESSToastManager
ShowToastStringTableGetstr_login_code_tip
_codeTips
SetActiveStartCDTimerUICommonHelperHandleLoginErrorCode
ThirdCodeUnLock+UISetBindMailController_SendCodeBtnOnClick         *   \   \   \   \   \   \   \   \   \   \   \   ]   ]   ]   ]   ]   ]   ^   ^   ^   ^   ^   ^   ^   _   _   _   _   `   `   `   b   b   b   b   b   b   b   d   d   d   e      self    *   TT    *   account    *   ret   *      _ENV g   i    	   F@@ Gΐ d Lΐΐ Η A    d 
@ &     _timerCoroGameGlobalTaskManager
StartTaskStartCDTimerCoro         	   h   h   h   h   h   h   h   h   i      self    	      _ENV k   }    	'   
@@@ ΐ@ €@ A ΐ@  €@@ Α ΑA BAB BΑΑ €$A  C @ A $AC! ό@ Α@  $AA Α@ $A
ΐC
@D   ω&     _isInCD	_timerGo
SetActive_sendCodeBtnName        <       _timerLabelSetTextStringTableGetstr_set_send_code_cd_tipsYIELDθ              _timerCoro          '   l   m   m   m   m   n   n   n   n   o   p   r   r   r   r   r   r   r   r   s   s   s   s   t   u   u   v   v   v   v   w   w   w   w   x   y   y   {   }      self    '   TT    '   timer
   '   CD   '      _ENV        
>   G @ G@ΐ @ @@Ζΐ@ Η Α  δ β   ΐΖ@A ΗΑΑA BAA $ δ@  &  ΜB @ δΐΒΐΖ@A ΗΑΑA BA $ δ@  &  Ζΐ@ Η Α  δ β   ΐΖ@A ΗΑΑA BAA $ δ@  &  ΜC AΑ δ@Μ D C δ@Ζ@D ΗΔδ ΜΐΔGE   ΐ B @ δ@&     _mailInputtext_codeInputstringisnulloremptyToastManager
ShowToastStringTableGet#str_set_change_passwd_mail_Is_nullCheckEmail (str_set_change_passwd_mail_format_error'str_login_msdk_intl_login_reg_vc_errorLock'UISetBindMailController:BindBtnOnClickSetShowBusyGameGlobalTaskManager
StartTaskBindBtnOnClickCoro         >                                                                                                                                                                                                self    >   mail   >   code   >      _ENV    ­    Q   F@ LAΐd LΐΖΑ@ ΗΑδ d  @ΑA   €AΑA  €A&  @ A@€ AB  @ €Ζ@ ΜAΐδ ΜΒ@ ΐ δΒΒFC GBΓGΓ@ΐΒC DFBD GΔΒ d $B  E @ $B BE FE GΒΕ@@@ B@$ F $BBF $B F Β ΐ $B G B@$ BGΒΒΗΗ$B A   $BΒA  $B&     	SDKProxyGetInstanceGetIntlChannelEngineGameHelperSAIchannelId SetShowBusyUnLock'UISetBindMailController:BindBtnOnClickSerializeBindJsonBindChannelRetCodeINTLINTLErrorCodeSUCCESSToastManager
ShowToastStringTableGetstr_set_bind_bind_successYIELD_oldChannelIdMobileClientLoginChannelMCLC_GUESTResetGuestCloseDialogShowDialog&UISetBindMailChangePasswordControllerUICommonHelperHandleLoginErrorCode
ThirdCode         Q                                                                                                                              ‘   ‘   ‘   ‘   ‘   ‘   ‘   ’   ’   ’   £   £   £   £   £   €   €   €   €   €   €   ¦   ¦   §   §   §   §   §   ©   ©   ©   ©   ©   ©   ©   «   «   «   ¬   ¬   ¬   ­      self    Q   TT    Q   mail    Q   	password    Q   code    Q   channelName   Q   str   Q   ret!   Q      _ENV ―   ½       b@  @    ¦   @ @@ΐ  €  @@    ¦  ΐΐ  €’      ¦  @    ¦  &     stringlen       match6[A-Za-z0-9%.%%%+%-]+@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?            °   °   ±   ±   ΄   ΄   ΄   ΄   ΄   ΄   ΅   ΅   Έ   Έ   Έ   Έ   Έ   Ή   Ή   Ή   »   »   ½      self       strContent          _ENV Ώ   Ε        @ @@ΐ    €_ΐ@@ Γ   ζ  Γ  ζ  &     stringmatch*[^%w_!%[%]%-%+%(%)@#%$%%%^&%*=\/%?<>,:;|]             ΐ   ΐ   ΐ   ΐ   ΐ   Α   Α   Β   Β   Δ   Δ   Ε      self       info       t         _ENV(                        :      <   A   <   C   E   C   G   Y   G   [   e   [   g   i   g   k   }   k               ­      ―   ½   ―   Ώ   Ε   Ώ   Ε          _ENV