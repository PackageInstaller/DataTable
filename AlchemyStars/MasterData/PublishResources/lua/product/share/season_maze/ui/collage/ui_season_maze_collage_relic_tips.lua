LuaS �

xV           (w@d@../PublishResources/lua/product/share/season_maze/ui/collage/ui_season_maze_collage_relic_tips.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��& �    _classUISeasonMazeCollageRelicTipsUICustomWidgetOnShowInitWidgetsSetDataCheckSuitAreaRefreshSuit           
    
   L @ d@ K   
@��F�@ G � �@A d� 
@ �& �    InitWidgets
my_relicsuiSeasonMazeModuleGameGlobalGetUIModuleSeasonMazeModule         
               	   	   	   	   	   
      self    
      _ENV        *   L@@ ��  �  d� 
@ �L@@ �@ � d� 
@ �G A �   J���L@@ ��  A d� 
@ �L�B �  d��
@ �G�B L@� �   d@�L@@ ��  � d� 
@ �L@@ �@ � d� 
@ �L@@ �@  d� 
@��& �    _DescTitleTextGetUIComponentUILocalizationTextDescTitleText
_DescTextUILocalizedTMP	DescTextonHrefClick_CustomSuitTipsCustomSuitTips_SuitAreaGoGetGameObject	SuitArea
SetActive_CustomSuitTitleCustomSuitTitle_contentScrollRectScrollRectContentScroll_suitScrollRectSuitScroll                   F @ G@� d�� L�� ��     d@ & �    GameGlobalUIStateManagerShowDialogUISeasonMaze_RelicHrefInfo                                       	hrefName          _ENV*                                                                                                                                    self    *      _ENV    ,    +   � @ �@@�@ �   ��ǀ@ ���FA GA���Ad �@   ���A � �A @� �@��   
� ���B � �� AC @�$ �F�C G����B ��dB�)�  ��D 
�Ĉ�D 
�ĈE �� %�&  & �    Cfg	cfg_item
_DescTextSetTextStringTableGetRpIntroLogfatalI###error -->UISeasonMazeCollageRelicTips - the cfg_item is nil ! id --> 
my_relicsuiSeasonMazeModuleGetSeasonMazeRelicspairstableinsert_contentScrollRectverticalNormalizedPosition       _suitScrollRectCheckSuitArea         +                                                  "   "   "   "   "   $   $   %   %   %   &   &   &   &   '   '   '   '   '   &   &   )   )   *   *   +   +   +   +   ,   	   self    +   itemId    +   cfg   +   mazList   +   (for generator)   "   (for state)   "   (for control)   "   k       v          _ENV .   7       � @ �@@�@ ǀ@_��� �ǀ@ � ��@A ̀�C  �@� ���A G�@�@�� � �  & �    Cfgcfg_item_relicSuiteID         _SuitAreaGo
SetActiveRefreshSuit            /   /   /   1   1   1   1   1   1   2   2   2   2   2   4   4   4   5   5   7      self       itemId       	cfg_prof         _ENV 9   X    C   � @ �@@� �@���  ��@ � ��@�@� �@ A@�  $A�& � ��A� � �� h�G�B �BBǂB  �����    ���AgA�A� � �  ]��AC ��C�C DGB�$� A� ���� ��A��� �� � A� ����ǂ�  F�C G���d� �C ���A�ǁE ́�@ �A�& �    _SuitAreaGo
SetActive        Cfgcfg_component_season_maze_suit 
RelicList       table
icontains
my_relics/_CustomSuitTitleSetTextStringTableGetName  ()Words
_CustomSuitTips         C   :   :   :   :   <   =   =   =   >   >   ?   ?   ?   ?   @   C   E   E   E   E   F   G   G   G   G   G   G   G   H   E   L   L   L   L   L   M   M   M   M   M   M   M   M   M   M   M   O   P   P   P   P   P   Q   Q   R   R   R   R   R   R   R   P   U   U   U   U   X      self    C   suiteID    C   curSuitCount   C   
suite_cfg   C   suits   C   (for index)      (for limit)      (for step)      i      id      suitPercent#   C   tips/   C   (for index)3   >   (for limit)3   >   (for step)3   >   j4   =   tip6   =      _ENV                        
                  ,      .   7   .   9   X   9   X          _ENV