LuaS �

xV           (w@S@../PublishResources/lua/product/components/ui/ui_we_chat/ui_we_chat_role_cell.lua         3    @ A@  ��@ $@�@@  ���@  A F@@ �   J���F@@ �@  J� �F@@ ��  J���F@@ ��  J� �F@@ �  J���F@@ �@ J� �F@@ �� J���F@@ �� J� �F@@ �  J���F@@ �@ J� �F@@ �� J���F@@ �� J� �F@@ �  J���F@@ �@ J� �& �    _classUIWeChatRoleCellUICustomWidgetStringTableGetOnShowCheckSpBtnSpBtnOnClickOnHideOnValueSetDataCheckTimeOutShowItemOutShowRedSelect_SelectbgbtnOnClickchangenamebtnOnClickChangeName           $    {   L@@ d� G�� 
@ �L A �@ � d� 
@��L A �@  d� 
@��L A �� � d� 
@��L@@ �@ d��
@ �L A �@ � d� 
@ �L A �@ � d� 
@ �L@@ �  d��
@��L A �@ � d� 
@��L@@ �  d��
@��G�E L@� �   d@�L@@ �� d��
@ �G�F L@� �   d@�L@@ �@ d��
@ �G G L@� �   d@�L@@ �� d��
@ �L@@ �@ d��
@ �G H L@� �   d@�L�H � 	 AI �Id� 
@ �L J �@J d��
@��G�I L�� d� 
@ �L@@ �@ d��L@� ƀK �K L�  d�  
@ �L@@ d� G�� 
@ �L@@ �� d��
@��L@@ �  d��
@��G�L L@� �   d@�G@L L@� �   d@�& � 5   transGetGameObject
transformnameTxtGetUIComponentUILocalizationTextname
enNameTxtennamepicImgRawImageLoaderpic	friendGOfriend
friendTxt
friendtxtfriendFillImageImagefriendfill	unReadGOunread
unReadTxt
unreadtxtchangeNameGOchangenamebtn
SetActive
choose1GOchoose1
choose2GOchoose2redGOred	_timeOuttimeOutatlas	GetAssetUIWeChat.spriteatlas	LoadTypeSpriteAtlasmodule
GetModuleQuestChatModuleweChatProxyGetWeChatProxyanimation2GetComponenttypeofUnityEngine
Animation_spBtnSpBtn_spRedspRed         {                              	   	   	   	   	   
   
   
   
   
                                                                                                                                                                                                                                                                                        !   !   !   !   "   "   "   "   #   #   #   #   $      self    {      _ENV %   +       G @ L@� d�  @ � �G�@ L � � � d@�� �G�@ L � �   d@�& �    _weChatRoleList
RoleCount       _spBtn
SetActive           &   &   &   &   &   '   '   '   '   '   )   )   )   )   +      self            ,   4       � @ �@@�@ � @ ��@�� 
� �� A �@ �@A �@ & �    _weChatRoleListAddIdxweChatRoleCurrentRoleOnValuebgbtnOnClick           -   -   -   /   /   /   /   1   1   3   3   4      self       go            5   6       & �                6      self            7   �    �   G @ L@� ǀ@ ����  d@  G A L@� ǀ@ �@��  d@  G�@ L�� d� ��A � B�@ @B@�ƀB ��� @� �@�& � �   AC�C ��C_ D@�FAD G����D d� ��  ����   ��AEF�E G��䁀� ��@    �� FAF �F��$A��@ �F$�   ���GG LA��� dA�G�G LA�� dA�L�G �  dA���GG LA��  dA�G�@ L�d� b  ���A��  � ���G � �A�� ���G   �A�G�@ L��d� !@� ���@ ��H�� �I �A�C� �A��AI �A�@��A�ǁI �@ J$� ���� ��I �AG  �A��  �AJ ́��  �����AJ ���� � \��� (��ÂL�Ad� ��@ ��A�� _����L�Fd�  @�� ��� �� ��H�� �   ��CH�  @ ���   �'���K �A�@ �A�& � -   nameTxtSetTextweChatRoleGetName
enNameTxt
GetEnNameGetSpeakerIdCfgcfg_quest_chat_speaker Logfatal>###[UIWeChatRoleCell] cfg_quest_chat_speaker is nil ! id --> SpeakerType       TemplateID        GameGlobal
GetModule
PetModuleGetPetByTemplateIdGetPetTeamBodyPetSkinEffectPathCARD_WE_CHAT_ROLEIconpicImg
LoadImageGetUnReadCount	unReadGO
SetActive
unReadTxtShowRedGetLastTalkoptionsGetFriendCountGetFriendMaxCount	friendGO
friendTxtfriendFillImagefillAmountGetFriendRate_weChatRoleList
RoleCount	RoleList_spRed         �   8   8   8   8   8   8   9   9   9   9   9   9   <   <   <   =   =   =   >   >   ?   ?   ?   ?   ?   @   B   C   C   C   D   E   E   G   G   G   G   I   I   I   J   J   K   K   K   K   K   O   O   P   R   R   R   R   U   U   U   V   V   W   W   W   W   X   X   X   X   Y   Y   Y   Y   [   [   [   [   \   \   \   ]   ]   ]   ]   ]   ^   ^   ^   ^   `   `   `   c   c   c   d   d   e   e   e   f   f   f   f   g   g   g   g   h   h   h   h   h   h   j   j   j   j   n   o   o   o   o   o   p   p   p   q   q   q   q   r   s   s   s   s   s   s   s   t   t   u   u   v   v   w   y   y   z   z   z   z   z   {   {   q   �   �   �   �   �      self    �   
speakerid   �   cfg_quest_chat_speaker   �   picName   �   petid   /   
petModule%   /   	matchPet(   /   unReadCount9   �   	lastTalkN   Z   friendCount]   �   	maxCountb   o   spRedu   �   	roleList}   �   (for index)�   �   (for limit)�   �   (for step)�   �   i�   �   item�   �   count�   �   	lastTalk�   �      _ENV �   �    -   b   ��
@ �C  �@ �A@�� ��   A�  ���ǂ��$�  ��C� 
��G@ LC�� dC�  ���bA  � ��@ ́�� 
����A @��� �A LB dA �     �
����     �
� �L�B dA & �    _weChatRoleList	RoleList       GetSpeakerIdweChatRoleSetIdxCurrentRoleSelectCheckSpBtnonClickCellonClickChangeNameOnValue        -   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    -   group    -   onClickCell    -   onClickChangeName    -   selectSpeakerId    -   select   "   	roleList   "   (for index)
      (for limit)
      (for step)
      i      role      
speakerid           �   �    	   G @ L@� d� � @ ��@�� �   ����@A AA� C  ��A�A� ��B�A    �C� �AB  ��A�& � 
   weChatRoleGetSpeakerIdGetLastTalkchatIdCfgcfg_quest_chatTriggerType       isEndShowItemOut            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       id      	lastTalk      chatid	      cfg      	isRandom         _ENV �   �       � @ �@@ � �@�& �    	_timeOut
SetActive           �   �   �   �   �      self       timeOut            �   �       � @ �@@ � �@�& �    redGO
SetActive           �   �   �   �   �      self       show            �   �    *   � @ @�  �& � 
@ ��@@ @� �@��   @�b   @�ǀ@ ���A �A �@ ��ǀ@ ���A� �A �@  �b   @���A � �AA �@�ǀ@ ���A �� �@  �ǀ@ ���A� �� �@ & �    select_SelecttransDOLocalMoveX
               ��������animation2PlayUieff_WeChatCell_In333333�?        *   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self    *   select    *   noAni    *        �   �       � @ �@@ � �@���@ �@@ � �@���@ �@@ � �@�& �    
choose1GO
SetActive
choose2GOchangeNameGO           �   �   �   �   �   �   �   �   �   �   �   �   �      self       select            �   �       � @ �@@ �@ & �    onClickCellweChatRole           �   �   �   �      self       go            �   �       � @ �@@ �@ & �    onClickChangeNameweChatRole           �   �   �   �      self       go            �   �       G @ L@� ǀ@ ����  d@  & �    nameTxtSetTextweChatRoleGetName           �   �   �   �   �   �   �      self           3                              $      %   +   %   ,   4   ,   5   6   5   7   �   7   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      
StringGet   3      _ENV