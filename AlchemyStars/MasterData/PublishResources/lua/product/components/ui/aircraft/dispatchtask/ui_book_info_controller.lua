LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/aircraft/dispatchtask/ui_book_info_controller.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ �& � 	   _classUIBookInfoControllerUIControllerOnShow
_InitData_InitUI_OnGetChapterInfoItem_RefreshChapterItemInfoMaskOnClick                  �@� 
� ���� 
� ��@A � A� �� 
� ��@A A A� �� 
� ���B �@ � C �@ & �    
_bookData       _chapterIndex       _contentScrollViewGetUIComponentUIDynamicScrollViewContentList_bookNameLabelUILocalizationText	BookName
_InitData_InitUI                       	   	   	   	   	   
   
   
   
   
                     self       	uiParams               #    J   G @ L@� d� �   
� ��   
����  � �  �@���@ ��@ ������A� �AA� �  ��ƁA ��� @�B� BB$� ���@ G�@ \�M���B ��BC CC@�� C  �� 
���C$� A � � hB�G�@ ��@ � �A�J�g� ���@ �@  AF�B L���C ��� � � d� �A� ���@ �  
� �& �    
_bookDataGetChapters_chapterIndexs_chapterContents       IsOpenStringTableGetstr_dispatch_book_chapterGetNameBookParagraphDataNewBookParagraphTypeTitleGetContentsUnOpen_chapterContentCount         J                                                                                                                                                                                                                     "   "   "   #      self    J   chapterDatas   J   (for index)
   F   (for limit)
   F   (for step)
   F   i   E   chapterData   E   title   7   	contents,   7   (for index)/   7   (for limit)/   7   (for step)/   7   j0   6      _ENV %   0       G @ ��@ ��@�� J���G A L@� ǀA ,  d@ G�A � B G�� � A �@B � A� �@ & �    _bookNameLabeltext
_bookDataGetName_contentScrollViewInitListView_chapterContentCount_chapterIndexs_chapterIndexMovePanelToItemIndex                )   +       �   � @   @� �  �   & �    _OnGetChapterInfoItem           *   *   *   *   *   *   +      scrollview       index          self   &   &   &   &   &   '   '   (   +   '   -   -   -   .   .   .   .   .   0      self       index           2   =    	   � � AA  䀀�@G�@   � �G�LA��  dA���L�A ��  dA G�LA��� dA�F�A G��A�� ��dA  �  & �    NewListViewItemUIBookInfoItem       _chapterContentCountgameObject
SetActive_RefreshChapterItemInfo	UIHelperRefreshLayoutGetComponentRectTransform            3   3   3   4   5   5   5   6   6   6   6   6   8   8   8   8   9   9   9   9   ;   ;   ;   ;   ;   ;   <   =      self       scrollView       index       item      
itemIndex         _ENV @   �      � @ �@�� �@ � G�� ��B �����A��A� 䁀ǁ��� $���AL��B d��G����B�� ��B ���@��BCC  �B��B�C� �B��BCC  �B��B�C  �B���A� 䂀��CC�  $C���� $��G�ALC��� dC�L�� d������CC� �C���D ���ǃA�C�C� �C���AD 䃀̃�A� 䃀DE$� �� /���B ǂ�����BCC  �B��B�C� �B��BCC  �B���AC 䂀��CC�  $C���� $��G�ALC��  dC�L��� d������CC� �C���� �����D� �����E� ����F� �  � ��C�C� �C�@"��C�C  �C�@!���B �B�����BCC  �B��B�C  �B��BCC� �B���A� 䂀̂�A� 䂀��CG� $C  ��� $���D�� $��G�GG�GC���G�H��H��A� 䃀̃�A� 䃀�C�ʃ��F$� "  � �D��� $D���D��  $D�����B �B�����BCC� �B��B�C� �B��B�C  �B��BCC  �B���A�	 䂀̂�A� 䂀���	 $���D�� $��L��
 d��L���� d���CJ�� ƃJ ��� LDKd� D� �K$� �����ƃJ ���� � L DL@��� �� $� �  �LMd� D
��J �JAD $� FL GD�� �� � d�  �@ ��M�� ]��JC�& � 7   
_bookDataGetChapters_chapterContents
transformFindUnOpengameObjectContentTextureSliderGetParagraphTypeBookParagraphTypeTitle
SetActiveContent/ContentContent/SliderContent/EmptyContent/NameGetComponentUILocalizationTexttext	GetTitleTextGetTextIsEndImageTexture/ImageRawImageLoader
LoadImage	GetImage	RawImage	materialmainTexturewidthheightLayoutElementpreferredWidthpreferredHeightUnOpen/NameUnOpen/DesUnOpen/GetDesGetChapterDataStringTableGetstr_dispatch_book_chapterGetChapterIdGetNamestr_dispatch_book_des_titlestringgsub  GetDes str_dispatch_book_get_des_title
GetGetDes           B   B   B   D   D   E   G   G   G   G   H   H   H   H   I   I   I   I   J   J   J   J   L   L   M   M   M   M   N   N   N   O   O   O   P   P   P   Q   Q   Q   R   R   R   S   S   S   S   T   T   T   U   U   U   U   V   V   V   W   W   W   W   X   X   X   Y   Y   Y   Y   Z   Z   Z   Z   Z   Z   [   [   [   [   \   \   \   \   ]   ]   ]   ^   ^   ^   _   _   _   `   `   `   a   a   a   a   b   b   b   c   c   c   c   d   d   d   e   e   e   e   f   f   f   f   f   f   g   g   g   h   h   h   h   i   i   i   i   k   k   k   l   m   m   m   m   n   n   n   o   o   o   p   p   p   q   q   q   q   q   q   r   r   r   r   s   s   s   s   s   s   t   t   t   u   u   u   v   v   v   v   v   v   w   x   y   y   y   y   z   z   z   z   |   |   |   }   ~   ~   ~   ~            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self      itemGo      index      chapterDatas     paragraphData     tran     	unOpenGo
     
contentGo     
textureGo     	sliderGo     paragraphType     contentTran+   M   sliderTran2   M   
emptyTran9   M   	nameTran@   M   
nameLabelJ   M   	nameTran^   �   sliderTrane   �   contentTranl   �   contentLabelv   �   image�   �   	rawImage�   �   width�   �   height�   �   layoutElement�   �   unOpenName�     
unOpenDes�     unOpenGetDes�     chapterData�     des�     getDes�        _ENV �   �       � @ �@ & �    CloseDialog           �   �   �      self       go                                            #      %   0   %   2   =   2   @   �   @   �   �   �   �          _ENV