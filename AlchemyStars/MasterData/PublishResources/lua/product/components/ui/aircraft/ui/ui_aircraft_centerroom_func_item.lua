LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/lua/product/components/ui/aircraft/ui/ui_aircraft_centerroom_func_item.lua         "    @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �@@ l�  
@��@@ l�  
@ �@@ l  
@��@@ l@ 
@ �@@ l� 
@��@@ l� 
@ �@@ l  
@��& �    _classUIAircraftCenterRoomFuncItemUICustomWidgetOnShowOnCloseOnHideInitWidgetSetDataRefreshGetCurrentCycleTimeMINGetRequestTimeMSRequestUpdateAffinity    	       	       � @ �@ ��@ �@ ���
���
@A�& �    InitWidgettimeModule
GetModuleSvrTimeModule_enable                                 	      self       	uiParams          _ENV           
@@�G�@ b   ��F�@ G � d�� L@� ǀ@ d@�
�A�G�A b   ��F�@ G � d�� L@� ��A d@�
���& �    _enable sliderTimerGameGlobalTimerCancelEvent updateTimer                                                                                 self          _ENV           L @ d@ & �    OnClose                       self               !       L@@ ��  �  d� 
@ �L@@ ��  A d� 
@ �L@@ �� � d� 
@ �& �    
textValueGetUIComponentUILocalizationText
TextValue
textTitle
TextTitlesliderImage                                                        !      self            "   &       
@ ��@@ �@ & �    
_roomDataRefresh           $   %   %   &      self       	roomData            (   Q    
O   G @ ��@ ��@� A �@�� � �@ �@A� �B �AB� $  ��  J���G B L�� d� ��B � �AC� �C �� � $� G�C �� J��GAD ��@ ��@��   @��� J���G�D b  ��FE GA�d�� L����D dA�
�ŉGF b  ��FE GA�d�� L���F dA�
�E�FE GA�d�� LA��� �F Gl  d��
@��FE GA�d�� LA�́G @� 䁀,B  d� 
@�& �    
textTitletextstringformatStringTableGet!str_aircraft_centerroom_affinity%.2f
_roomDataGetPeriodAffinityGetAffinityUpdateTimemathfloor<       GetCurrentCycleTimeMINsliderfillAmount
textValue	%s/%sminsliderTimerGameGlobalTimerCancelEvent updateTimerAddEventTimes'      TimerTriggerCount	Infinite	AddEventGetRequestTimeMS         B   H     	    @ @@ $� ��� ��@� � �� �   �@�@  �� � �A R��
A��B F�� G��� ��  d� 
A��& �    
_roomDataGetAffinityUpdateTimemathfloor<       GetCurrentCycleTimeMINsliderfillAmount
textValuetextstringformat	%s/%smin             C   C   C   D   D   D   D   E   E   E   E   E   F   F   F   G   G   G   G   G   G   G   G   H      updateTime      updateCycle      	cycleMin      min         self_ENV M   O         @ @@ $�� �@ ��� � � $@ & �    GameGlobalTaskManager
StartTaskRequestUpdateAffinity             N   N   N   N   N   N   N   O          _ENVselfO   )   *   *   +   +   +   +   ,   ,   ,   ,   ,   ,   ,   *   -   /   /   /   0   0   0   0   1   1   1   1   2   2   2   3   3   3   3   3   3   3   3   5   5   5   6   6   6   6   6   6   7   9   9   9   :   :   :   :   :   :   ;   ?   ?   ?   ?   @   A   A   H   ?   I   K   K   K   K   L   L   L   O   K   P   Q      self    O   updateTime   O   updateCycle   O   	cycleMin   O   min   O      _ENV S   V       � @ �@�� Ҁ����A AAR�� ��@N��NA�% &  & �    timeModuleGetServerTime�      <       mathfloor            T   T   T   T   T   U   U   U   U   U   U   U   U   V      self       updateTime       updateCycle       now         _ENV X   [    
   � @ �@@ǀ@ ����  ��  � � ΀��  & �    mathfloortimeModuleGetServerTime�               
   Y   Y   Y   Y   Y   Y   Z   Z   Z   [      self    
   updateTime    
   now   
      _ENV ]   i    	   � @ A@ ���̀@@� 䀀��$� "  @�A "  @�AA $A ���A �ALB�A�� d  $A  & � 
   
GetModuleAircraftModuleUpdateAffinityGetSucc_enableRefreshToastManager
ShowToastGetErrorMsg
GetResult            _   _   _   `   `   `   a   a   a   a   b   b   b   d   d   e   g   g   g   g   g   g   g   i      self       TT       
airModule      result         _ENV"                        	                           !      "   &   "   (   Q   (   S   V   S   X   [   X   ]   i   ]   i          _ENV