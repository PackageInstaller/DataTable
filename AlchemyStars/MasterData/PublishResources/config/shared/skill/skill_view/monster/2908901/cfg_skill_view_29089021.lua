LuaS �

xV           (w@`@../PublishResources/config/shared/skill/skill_view/monster/2908901/cfg_skill_view_29089021.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayCasterTurnToRoundBeginPlayerPos; PlayCasterAnimation,animName=Skill01; PlayCasterBindEffect,effectID =290890106; PlayAudio,audioID = 290890104,audioType=1; Wait,waitTime=1200; Wait,waitTime=1000; �      ��      DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=3; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=290890107,isRotate=1,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=100; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect;        %                                                                                                                     key   %   config    %      _ENV