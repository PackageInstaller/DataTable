LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1602141/cfg_skill_view_2002141.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� B  AB  �� �� � �B� +A�K��� �� � A�  �B  � � A +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayAudio,audioID = 160214102,audioType=1; PlayCasterAnimation,animName = AtkChain; PlayCasterBindEffect,effectID=160214103; Wait,waitTime=2000; �
      ��      DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=1; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160214104,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=80; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; �      o PlayFlyEffectCrossToGridEdges,flyEffectID=160214105,flySpeed=200,flyTrace=1,offsetx=0,offsety=0.5,offsetz=0; � DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd; PlayTargetAddBuff,buffID=200221,label=buffAgain; PlayTargetAddBuff,buffID=4302141; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffAgain;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV