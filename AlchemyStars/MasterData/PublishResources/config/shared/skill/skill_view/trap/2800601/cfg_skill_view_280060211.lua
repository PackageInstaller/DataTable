LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/trap/2800601/cfg_skill_view_280060211.lua         G   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K � � � �� �@� k@� � �� �A  AA  �� �A  � A� �� � �B� �@��A�  ��  �� B  AB  �B �B� +A�K��A �A � A�  ��  �� � A� +C� kA����� � A� ��  ��  � K� � kC� �A���B AB �� �B  � A� �C� �A��@��    @  �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       � DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;         � PlayCasterAnimation,animName=Skill01; PlayAudio,audioID=8007,audioType=1; PlayCasterBindEffect,effectID=3471; Wait,waitTime=3000;       Y PlayMoveBoard,sceneRoot1=scxt_stage_01,sceneRoot2=scxt_stage_02,dirX=0,dirY=1,times=4; �      b PlayCasterAnimation,animName=MoveEnd; Wait,waitTime=500; PlayCasterAnimation,animName=MoveEnd2;         G                                                                                                                                                                                                      	   
   
   
   
   
      key   G   common   G   configB   G      _ENV