LuaS 

xV           (w@@E:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/ui_we_chat/we_chat_local_storage.lua         %    @ A@  @ $@@@  @@ l   
@@@ l@  
@ @@ l  
@@@ lΐ  
@ @@ l  
@@@ l@ 
@ @@ l 
@@@ lΐ 
@ @@ l  
@@@ l@ 
@ &     _classWeChatLocalStorageObjectConstructorDispose_GetChatKey_GetTimeKeySaveSpeakerLastTimeGetSpeakerLastTimeSaveLocalSpeakerInitLocalSpeakerInitAllLocalSpeakerClearLocalSpeaker    
       	       
@    
&     weChatProxy	roleInit                    	      self       weChatProxy                      
@@&     weChatProxy                     self                      Η @ β@    
 Η @ β    Η @ !@ΐΖ@ ΗΐΐA δ Μ@Αδ 
ΐ Α Α G@ Α ΐ έΐζ  &     pstId        GameGlobal
GetModuleRoleModule	GetPstIdWeChat|                                                                                          self       
speakerId       pstId          _ENV            @ ’     @ !@@@ ΐ@Ζ A € @A€ 
  Αΐ @ AΑ  ¦  &     pstId        GameGlobal
GetModuleRoleModule	GetPstIdWeChatTime|                                                                              self       
speakerId          _ENV    "    	   Μ @ @ δA@ @@ $A&     _GetTimeKeyLocalDBSetInt         	               !   !   !   !   !   "      self    	   
speakerId    	   time    	   key   	      _ENV #   &    
    @   €Ζ@@ Ηΐ  AΑ  ε ζ   &     _GetTimeKeyLocalDBGetInt                 
   $   $   $   %   %   %   %   %   %   &      self    
   
speakerId    
   key   
      _ENV (   9    <   Μ @ @ δA@ @@$A A@ Α@@$ FA  d 	 ΗBΑ GΓΑ A ΗΒ€@ΗCBB ΔB   ΐΗΒά ΐ ΐ CA AΗΒάΐ ΐ C©  *Γω ΑB Αi  κφFA@ GΓΐ dA&     _GetChatKeyLocalDBDelete
GetStringipairschatId,triggerIndextalks	talkTypeWeChatTalkTypeStarttalkId|
SetString         <   )   )   )   *   *   *   *   +   +   +   +   ,   ,   ,   ,   -   -   -   -   -   -   .   .   .   .   /   /   /   /   /   /   0   0   0   0   1   1   1   1   1   2   2   2   2   3   3   3   .   .   6   6   6   ,   ,   8   8   8   8   8   9      self    <   
speakerId    <   chats    <   key   <   str   <   (for generator)   6   (for state)   6   (for control)   6   _   4   chat   4   (for generator)   1   (for state)   1   (for control)   1   index   /   talk   /      _ENV ;       ­   @ A "  @ A  & @ 
ΐ Α@  ΐ $ FA GAΑ d A ΑAΐ€ ’  @B AB  ₯¦     Λ  ΑAΖA ΗΓ AB δ FΒC GΔd  (A ΓAGΓ$ "C  A CGΓC $K    J ΖΓC ΗΔ  δ  ¨CA ΔA	ΗD€ ’D  ΐΓΐΔD ΗC€ ΖΔD EEδ JΓJΖF ΗDΖ	JΓ@@Ε    ΖΔD Eδ ΔΐΖΔC ΗΗ	Δ@ 	δD§χΓC GΗB €C'Bπ  FBG BdΐΕΖG ΗΓΗΗβ  @  @ i  κBύ"  @GB LΘΐ   C dBB AH  €’A  ΐΖH ΗΑΘ	 @ BδA ΑA  ζ ΗΒά@ΐ ΗAIβA  ΐΗB ΜAΒ@ εζ  @ΗΒΗΓBI"B   IGΕ_@ B BB %&  ΑA  ζ &  '   	roleInit        _GetChatKeyLocalDB
GetStringstringisnulloremptyweChatProxySendSpeakerHistorym_vecChatDatam_nSpeakerIDsplit|       tablecount,m_vecTalkData	tonumber	m_nCount       
m_nChatID
m_nStatusQuestChatStatusE_ChatState_Completed
m_nTalkID
m_bReadedinsertpairsCfgcfg_quest_chatUpdateRoleGetLastTalkLogfatalS[WeChat] WeChatLocalStorage:InitLocalSpeaker can not find local talk by speakerID:isEndchatId         ­   <   <   <   <   =   =   ?   ?   @   @   @   @   A   A   A   A   B   B   B   B   B   B   C   C   C   C   C   C   F   G   G   H   I   I   I   I   I   J   J   J   J   J   J   J   K   K   K   K   K   K   L   L   L   L   L   M   N   N   O   O   O   O   O   O   O   P   P   P   P   P   P   Q   Q   S   S   S   T   T   T   T   U   V   V   V   V   W   W   W   Y   Z   Z   Z   Z   [   \   \   \   \   \   O   `   `   `   `   `   J   d   e   e   e   e   f   g   g   g   g   g   h   h   e   e   l   l   m   m   m   m   m   m   r   r   r   r   u   u   v   v   v   v   v   v   w   w   |   |   |   |   }   }   }   ~   ~   ~   ~   ~                                                            self    ­   
speakerId    ­   pstId    ­   serverSpeakerData    ­   key   ­   str   ­   speaker      a%      (for index)+   j   (for limit)+   j   (for step)+   j   i,   i   b7   i   chat8   i   (for index)@   d   (for limit)@   d   (for step)@   d   jA   c   chatIdL   T   talkY   c   innerk      (for generator)n   y   (for state)n   y   (for control)n   y   keyo   w   valueo   w   chatidp   w   	lastTalk   ­   serverLastChatData   ͺ      _ENV            @ @@Α    έ Α  €!ΐ@ΐΖ @ Η Α  @ AAA δ@ΗA ΜΐΑε  ζ   @ Αΐ  ζ  &     LocalDBGetIntWeChatAllHistory        SetInt       weChatProxySendSpeakerAllHistory                                                                                       self       pstId       i         _ENV           &                       self       
speakerId           %                        	                                    "      #   &   #   (   9   (   ;      ;                               _ENV