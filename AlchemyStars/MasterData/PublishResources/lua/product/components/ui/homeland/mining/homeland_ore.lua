LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/1120/client/Assets/../PublishResources/lua/product/components/ui/homeland/mining/homeland_ore.lua         Z    @ A@  ��@ $@�@@  ���  
 ��
���
 F@B �� �   d@�F@@ �   J���F@@ �@  J� �F@@ ��  J���F@@ ��  J� �F@@ �  J���F@@ �@ J� �F@@ �� J���F@@ �� J� �F@@ �  J���F@@ �@ J� �F@@ �� J���F@@ �� J� �F@@ �  J���F@@ �@ J� �F@@ �� J���F@@ �� J� �F@@ �  J���F@@ �@ J� �F@@ �� J���F@@ �� J� �F@@ �  J���F@@ �@ J� �F@@ �� J���F@@ �� J� �F@@ �  J���& � $   _classHomelandOreObjectEmpty       Half       Full       _enum	OreStateConstructorDisposeIDGetInteractRedStatusEnterInteractScopeLeaveInteractScopeRefreshOnOreStateChangeSetOreServerDataSetDropTimesSetRefreshTimeIncreaseDropTimesResetClearTimerClearCutTimesIncreaseCutTimesGetInteractPositionRefreshOreStateClearRefreshTimeEventGetOreServerIdCheckCanCutCheckNeedRefreshGetOreStateGetPlayerDirectionGetCutRadiusGetOreEffectPos
Disappear           9    	9   
@ �
���
� �
 ��
@A�
@A�
@��
@B�
@B�
���
@C�K��� �� � kA�
@�FAD �A �A B d� 
@�
@B�
@
@E�
@B�GA@ G�LA��� d��
@��GA@ G�LA�� d��
@��G�E @���FAG G���� �@ B@ HdA G�E L����H I � d�  
@��& � %   _oreID_oreGO_oreCfg_miningManager_dropTimes        _nextRefreshTime
_cutTimes_timerEvent _refreshEvent_oreStateGo_clearCutTimesTime@w     _oreGoNameCutForbidden.prefab_oreStateGoOffsetVector3_serverData_refreshTimesTime_needRefresh
_oreState_stoneLod0
transformFind`model/hl_envpfb_props_ore_01/meshroot/hl_envmod_props_ore_01_LOD0/hl_envmod_props_ore_01_part01_stoneLod1`model/hl_envpfb_props_ore_01/meshroot/hl_envmod_props_ore_01_LOD1/hl_envmod_props_ore_01_part01Logerror,HomelandOre:Constructor _stone = nil oreID name_objFadeCpt0GetComponenttypeofFadeComponent         9                              !   $   &   &   &   &   &   &   (   (   (   (   (   (   +   -   /   1   2   2   2   2   2   2   3   3   3   3   3   3   4   4   4   5   5   5   5   5   5   5   8   8   8   8   8   8   8   9      self    9   oreID    9   oreGO    9   oreCfg    9   miningManager    9      _ENV <   E       G @ b   � �G @ L@� d@ G�@ b    �F�@ G � ��@ d@ 
@A�& �    _timerEventCancel_oreStateGo	UIHelperDestroyGameObject             =   =   =   >   >   >   A   A   A   B   B   B   B   C   E      self          _ENV G   I       G @ f  & �    _oreID           H   H   I      self            K   M       C   f  & �                L   L   M      self            O   Q       L @ d@ & �    RefreshOnOreStateChange           P   P   Q      self            S   X       G @ b   ��& �    _oreStateGo           T   T   T   X      self            Z   l    %   G @ b@  � �L@@ d� 
@ �@�L@@ d� � @ �� @ �& � � �L@@ d� 
@ �G @ ��@ �� � �L�@ d@ ��G A J���G�A G � L@� � � d@�G�B G � L@� � � d@�& �    
_oreStateGetOreStateEmpty
Disappear_objFadeCpt0Alpha       _stoneLod0gameObject
SetActive_stoneLod1        %   [   [   [   \   \   \   \   ^   ^   ^   ^   ^   _   _   a   a   a   e   e   e   e   f   f   f   h   h   i   i   i   i   i   j   j   j   j   j   l      self    %      	OreState n   u       
@ ��@@ �� �@�� A �� 
���& �    _serverDataSetDropTimesdrop_times_needRefreshCheckNeedRefresh           o   s   s   s   t   t   t   u      self       data            w   z       
@ ��@@ �@ & �    _dropTimesRefreshOnOreStateChange           x   y   y   z      self       
dropTimes            |   �       �@@ ��@��@ �� 
� �� @ � A�� π� ΀�
����@A  ������ B �@  ���@@ �@�䀀 ̀�GAA �  � 
� �& �    _timeModuleGameGlobal
GetModuleSvrTimeModuleGetServerTime_nextRefreshTime�              _refreshEventTimer	AddEvent         �   �         @ @@ $@ �@� ��@� �A $�� �A � � �@B$@�& � 
   _refreshEventCancel _needRefreshGameGlobalEventDispatcher	DispatchGameEventTypeHomelandRefreshOreInfo             �   �   �   �   �   �   �   �   �   �   �   �   �          self_ENV   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       	nextTime       nowTime         _ENV �   �    	   G @ M@� 
@ �L�@ d@ L A d� 
@��& �    _dropTimes       RefreshOnOreStateChange_needRefreshCheckNeedRefresh        	   �   �   �   �   �   �   �   �   �      self    	        �   �       G @ b   � �G @ L@� d@ 
�@�F�@ G � d�� L@� ǀA ,  d� 
@ �& �    _timerEventCancel GameGlobalTimer	AddEvent_clearCutTimesTime         �   �        @@�& �    
_cutTimes                   �   �          self   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �   �    	   
@@�G�@ b   � �G�@ L�� d@ 
 A�& �    
_cutTimes        _timerEventCancel         	   �   �   �   �   �   �   �   �   �      self    	        �   �       G @ M@� 
@ �G @ f  & �    
_cutTimes                  �   �   �   �   �   �      self            �   �    
   � @ @@� ���@ ��@� A
� �� @ �  & �    _interactpos _oreGO
transform	position        
   �   �   �   �   �   �   �   �   �   �      self    
   index    
        �   �       � @ ��   ����@@ ��   �� ���@ �� ��& �    FullHalfEmpty           �   �   �   �   �   �   �   �   �   �   �   �      self       state          	OreState �   �       
@@�& �    _refreshEvent            �   �      self            �   �       G @ b   � �G @ G@� f  & �    _serverDatamine_id           �   �   �   �   �   �   �      self            �   �    	   G @ �@@ ��@!@   �C@  C � f  & �    _dropTimes_oreCfg
DropLimit        	   �   �   �   �   �   �   �   �   �      self    	        �   �       G @ �@@ ��@!@  �F�@ G � d�� L@� ƀA ���d@�C � f  C   f  & �    _dropTimes_oreCfg
DropLimitGameGlobalEventDispatcher	DispatchGameEventTypeHomelandOreRefresh            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self          _ENV �   �       F @ �@@ ǀ@ ���!��@ �F @ @��@@ ǀ@ ���� �!�����@@ ǀ@ ��� � @ �F@A   �F�A f  & �    Empty_dropTimes_oreCfg
DropLimit       HalfFull           �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       	curState         	OreState �   �    	   � @ �@  @ ��@� �  � @ ��@��@� A AAA� ��A� A L� d� G��GA��� �� � ������$� N�f & � 	   _oreStateGo_currentForward
transform	positionVector3x        z
Transform            �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       chara       pos      vec      	charaPos         _ENV �   �       G @ G@� f  & �    _oreCfg
CutRadius           �   �   �   �      self            �   �       �   �@@ �   ��ƀ@ ���A � �@�F�A G��䀀� �AB �BG��� $��@ �A ǁC]��f �  & �    _oreStateGoGameGlobalGetUIModuleHomelandModuleGetCurrentToolCfg	ToolTypeTT_PICKAttachPathstringsplitRes.prefab/                   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �      self       chara       path      cfg      data         _ENV �   	      F @ L@� d� L�� �   d@�& �    TaskManagerGetInstance
StartTask         �         A   �@  ��   �� ���@ F�@ G�N��
A�M�� A� @  �� $A����@ 
@��A BAB�  $A��B BAB�  $A�& �                   �������?_objFadeCpt0AlphaYIELD
       _stoneLod0gameObject
SetActive_stoneLod1             �   �   �   �   �   �   �   �   �   �                                             TT       addtime      anitime      aptime         self_ENV   �   �   �   �     �   	     self          _ENVZ                              	                  9      <   E   <   G   I   G   K   M   K   O   Q   O   S   X   S   Z   l   Z   n   u   n   w   z   w   |   �   |   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   �   	  �   	     	OreState
   Z      _ENV