LuaS �

xV           (w@R@../PublishResources/lua/product/components/ui/battle/ui_widget_color_palette.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ �& � 	   _classUIWidgetColorPaletteUICustomWidgetOnShowInitWidgetSetDataOnColorPaletteChange_ClearPlayAnimation               (   �   
� ��  ƀ@ ��� A �A +A � �ƀ@ ǀ� A� � +A � �ƀ@ �@� A� �� +A � �ƀ@ � � AA �� +A � �
�����C �@ � D AD �DG�D �@ & �    _curPieceTypes_animationNames
PieceTypeBlue%uieff_UIWidgetColorPalette_blue_open%uieff_UIWidgetColorPalette_blue_loopRed$uieff_UIWidgetColorPalette_red_open$uieff_UIWidgetColorPalette_red_loopGreen&uieff_UIWidgetColorPalette_green_open&uieff_UIWidgetColorPalette_green_loopYellow'uieff_UIWidgetColorPalette_yellow_open'uieff_UIWidgetColorPalette_yellow_loopInitWidgetAttachEventGameEventTypeColorPaletteRefreshOnColorPaletteChange         (         	   
   
   
   
   
   
   
                                                                                                self    (   	uiParams    (      _ENV           K   
@ �G @ �@@ ��@��@ A�  䀀J� G @ �@@ � A��@ A 䀀J� G @ �@@ �@A��@ AA 䀀J� G @ �@@ ��A��@ A� 䀀J� & �    	_colorGO
PieceTypeBlueGetGameObjectRedGreenYellow                                                                                                            self          _ENV           
@ ��@@ �@ & �    _pstID_Clear                          self       pstID            "   C    J   � @ @�@��   ���   ������   �@ @ $ �F�@ G�_@ �FBA G����A � d��bB  @�FBA G���� dB�FBA G���A � dB�)�  ���@ @�$��GBB G�b  ��GBB G����� �B���� ����BC ����C��D�CD�����D ���C�$C CD�����D �����$C )�  �A�@ �� F �@ & �    _pstID        ipairs
PieceTypeAnytable
icontains_curPieceTypesinsert	_colorGO
SetActiveGetComponent
Animation_animationNamesenabled PlayQueued       UnityEngine
QueueModePlayNow       CompleteOthers_Clear         J   #   #   #   $   $   %   %   %   '   (   (   (   (   )   )   )   )   *   *   *   *   *   *   *   +   +   +   +   +   ,   ,   ,   ,   ,   (   (   0   0   0   0   1   1   1   1   3   3   4   4   4   6   6   6   7   7   8   9   :   :   :   :   :   :   ;   ;   ;   ;   ;   ;   0   0   =   ?   ?   C      self    J   pstID    J   pieceTypes    J   newPieceTypes	   F   (for generator)   $   (for state)   $   (for control)   $   _   "   
pieceType   "   (for generator)'   F   (for state)'   F   (for control)'   F   _(   D   
pieceType(   D   go.   D   
animation4   D   animationNames6   D      _ENV E   J    	   F @ �@@ d � ����  �A�i�  ��F�@ G � �@A d@ & �    pairs	_colorGO
SetActivetableclear_curPieceTypes            F   F   F   F   G   G   G   F   F   I   I   I   I   J      self       (for generator)   	   (for state)   	   (for control)   	   _      go         _ENV L   [       F @ �@@ d ����@ �A�  ����@ �A��@�  @��AAB 䁀�A B��AL����BdB�i�  ��& �    ipairs_curPieceTypes	_colorGOactiveSelfGetComponent
Animation_animationNamesenabled Play                   M   M   M   M   N   N   N   N   P   P   Q   Q   Q   S   S   S   T   T   U   V   W   W   W   M   M   [   	   self       (for generator)      (for state)      (for control)      _      
pieceType      go
      
animation      animationNames         _ENV                                                "   C   "   E   J   E   L   [   L   [          _ENV