LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/b/1120/client/Assets/../PublishResources/lua/product/components/ui/ui_chat/ui_chat_delete_friend_controller.lua             @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lÀ  
@ @@ l  
@@@ l@ 
@ &  	   _classUIChatDeleteFriendControllerUIControllerOnShow_GetComponents_InitConfirmBtnOnClick_DeleteFriendCancelBtnOnClick               	   @À 
 ÀÀ 
  A ¤@ @A ¤@ &     _friendData       _chatFriendManager       _GetComponents_Init        	         	   	   
   
               self    	   	uiParams    	                  L@@ Á  Á  d 
@ &     _nameGetUIComponentUILocalizationTextName                                self                   
   G @ @ À@Á  AA A$ ¤  J&     _nametextStringTableGetstr_chat_delete_friend_confirm_friendDataGetName         
                                    self    
      _ENV            @ A  ¤@@ À@¤  AAA @  ¤@ &     LockConfirmBtnOnClickGameGlobalTaskManager
StartTask_DeleteFriend                                                self       go          _ENV    $        @ @@  G@ LÁÀd ¤@   A A ¤@A ¤@ ÀA  B¤ @BB ÁB¤@&     _chatFriendManagerDeleteFriend_friendDataGetFriendIdUnLockConfirmBtnOnClickCloseDialogGameGlobalEventDispatcher	DispatchGameEventTypeChangeFriendInfoSuccess                                        !   !   !   "   "   #   #   #   #   #   #   #   $      self       TT          _ENV &   (        @ ¤@ &     CloseDialog           '   '   (      self       go                                                                       $      &   (   &   (          _ENV