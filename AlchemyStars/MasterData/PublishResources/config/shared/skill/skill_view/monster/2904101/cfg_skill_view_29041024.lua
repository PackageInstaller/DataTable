LuaS �

xV           (w@`@../PublishResources/config/shared/skill/skill_view/monster/2904101/cfg_skill_view_29041024.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� B  AB  �� �� � �B� +A�K��� �� � A�  �B �� � A +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �"       PlayAudio,audioID = 6248,audioType=1; Wait,waitTime=1000; PlayCasterAnimation,animName = Skill03; PlayCasterBindEffect,effectID=PARAM.Disappear; PlayCasterMaterialAnim,animName=eff_2904101_skill01_main_role; Wait,waitTime=400; PlayCasterVisible,visible=0; PlayCasterHUDVisible,visible=0;        ��       DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=15; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=290410113,delayTime=70,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; �      O ShowSummonThingBySortPos, sortType=15, eachDelayTime=80; Wait,waitTime=1000;  PlayCasterSuicide;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV