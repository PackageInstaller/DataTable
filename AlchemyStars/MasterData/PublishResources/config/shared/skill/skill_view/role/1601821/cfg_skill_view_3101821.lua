LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1601821/cfg_skill_view_3101821.lua         W     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A �� �  AB  � �B  �  K�  JCJCB�
C�
Ƌ���+A�K��� ��  A�  �B  � � AC +C� kA����A B A ��  �B  � K� �� kC� �A���� A� � ��  C  A �� �C �C� �A�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir               � PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1600141,waitTime = 2000; � PlayAudio,audioID = 2591,audioType=1; PlayCasterAnimation,animName = AtkUlt; PlayTurnToPickUpPosDirection,pickUpIndex=1; PlayCasterBindEffect,effectID =160182114; Wait,waitTime=6500; <       gridPosxy	effectID_/�	    � DataSelectDamage,damageIndex = 1; PlayTargetBeHitEffect,hitEffectID=160182113,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; <      � DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; �      �*       PlayEffectAtPickUpIndexGrid,effectID=160182112,pickUpIndex=1; Wait,waitTime=500; DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;         W                                                                                                                                                                                                                                                      	   
   
   
   
   
      key	   W   configR   W      _ENV