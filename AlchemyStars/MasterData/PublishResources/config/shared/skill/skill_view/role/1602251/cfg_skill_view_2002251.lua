LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1602251/cfg_skill_view_2002251.lua         &     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � �A  B  A� �� �� �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               � PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 160225102,audioType=1; PlayCasterBindEffect,effectID=160225103; Wait,waitTime=1000; PlayCasterBindEffect,effectID=160225104; Wait,waitTime=2600;�      ��       DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=160225105,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=50; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; PlayDetonateMonsterWeak; Wait,waitTime=1000;         &                                                                                                                        key	   &   config!   &      _ENV