LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/trap/2800601/cfg_skill_view_280060213.lua         ;   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A �� �B �B� �@��AA �A �� �  A�  �� �� � �B� +A�K��� �� � A�  ��  �� � A +C� kA�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayCasterAnimation,animName=Skill01; PlayAudio,audioID=8007,audioType=1; PlayCasterBindEffect,effectID=3471; Wait,waitTime=3000;       � DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Z PlayMoveBoard,sceneRoot1=scxt_stage_01,sceneRoot2=scxt_stage_02,dirX=0,dirY=-1,times=4; �      b PlayCasterAnimation,animName=MoveEnd; Wait,waitTime=500; PlayCasterAnimation,animName=MoveEnd2;         ;                                                                                                                                                                                       key   ;   config6   ;      _ENV