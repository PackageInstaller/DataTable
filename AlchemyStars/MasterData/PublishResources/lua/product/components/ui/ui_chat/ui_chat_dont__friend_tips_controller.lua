LuaS 

xV           (w@@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/ui_chat/ui_chat_dont__friend_tips_controller.lua             @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lΐ  
@ @@ l  
@@@ l@ 
@ @@ l 
@&  
   _classUIChatDontFriendTipsControllerUIControllerOnShow_GetComponents_InitSendAddFriendBtnOnClickConfirmBtnOnClick_SendAddFriendMsgCancelBtnOnClick               	   @ΐ 
 ΐΐ 
  A €@ @A €@ &     _friendData       _chatFriendManager       _GetComponents_Init        	         	   	   
   
               self    	   	uiParams    	               
   L@@ Α  Α  d 
@ L@A Α d
@ &     _tipsLabelGetUIComponentUILocalizationTextTips_sednAddFriendBtnOnGoGetGameObjectSendAddFriendBtnOn        
                                    self    
                  G @ @ ΐ@Α  € J
ΑGΐA L Β Η@A d@&  	   _tipsLabeltextStringTableGet!str_chat_is_not_your_friend_tips_sendAddFriendMessage _sednAddFriendBtnOnGo
SetActive                                                   self          _ENV    $        @ ’   @ 
@@  
@ΐ@  A@ €@&     _sendAddFriendMessage _sednAddFriendBtnOnGo
SetActive                          !   #   #   #   #   $      self       go            &   -        @ ’@   @@ €@ &  @ Α  €@ A @A€ AΑA @  €@ &     _sendAddFriendMessageCloseDialogLockConfirmBtnOnClickGameGlobalTaskManager
StartTask_SendAddFriendMsg            '   '   '   (   (   )   +   +   +   ,   ,   ,   ,   ,   ,   ,   -      self       go          _ENV /   @    .    @ @@Ζ@ € Μΐ@@ A AA€ δ  Α$ "A  ΑΑ$ FB GAΒ@ΐFB GΑΒC ACΑ € dA  ΐGΑC LΔΐ dAB ΑBFC GAΓA d $A  D Α $AE $A &     GameGlobal
GetModuleSocialModuleInvitationFriend_friendDataGetFriendIdGetSucc
GetResultSocialErrorCode!SOCIAL_INVITATION_MUTUAL_SUCCESSToastManager
ShowToastStringTableGetstr_chat_is_your_friend_chatFriendManagerHandleErrorMsgCode)str_chat_send_request_add_friend_successUnLockConfirmBtnOnClickCloseDialog         .   1   1   1   1   3   3   3   3   3   3   4   4   4   4   5   5   6   6   6   6   7   7   7   7   7   7   7   7   9   9   9   9   :   <   <   <   <   <   <   <   >   >   >   ?   ?   @      self    .   TT    .   socialModule   .   res
   .   retCode          _ENV B   D        @ €@ &     CloseDialog           C   C   D      self       go                                                              $      &   -   &   /   @   /   B   D   B   D          _ENV