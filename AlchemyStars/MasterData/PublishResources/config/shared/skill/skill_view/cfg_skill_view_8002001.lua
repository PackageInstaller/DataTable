LuaS �

xV           (w@O@../PublishResources/config/shared/skill/skill_view/cfg_skill_view_8002001.lua         W     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �A B KB  ��  ˂  �B�BB������ŊJ����@�� ��  A�  �A �A  B  AB �� �� �B� �@��AA �A �A B  AB  � �� C �B� +A�K��� �� B AB  �B  � � A� +C� kA����A B AB �B  �B  � K� � kC� �A���� A� �B �B  C  A� �� �C �C� �A�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir       <               gridPosxy	effectIDO	    L PlayAudio,audioID = 9040,audioType=1; PlayCameraEffect,effectID=52300112; ,      ��      DataSelectScopeGridRangeByResultIndex,effectType=4,index=1; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=52300113,label=playRangeEffect; PlaySummonTrap,trapID=14; Wait,waitTime=33; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1500;��      DataSelectScopeGridRangeByResultIndex,effectType=4,index=2; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=2; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=52300113,label=playRangeEffect; PlaySummonTrap,trapID=14; Wait,waitTime=33; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1500;       ��      DataSelectScopeGridRangeByResultIndex,effectType=4,index=1; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; Wait,waitTime=33; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1500;��      DataSelectScopeGridRangeByResultIndex,effectType=4,index=2; DataSortScopeGridRange,sortType=4; DataSelectScopeGridRangeIndex,index=2; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeConvert,dataSource=4,label=playRangeEffect; Wait,waitTime=33; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; Wait,waitTime=1500;        W                                                                                                                                                                                                                                                      	   
   
   
   
   
      key	   W   configR   W      _ENV