LuaS �

xV           (w@Y@../PublishResources/config/shared/skill/skill_view/autobead/cfg_skill_view_20050022.lua         K   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K �� ��@  A  A� �A  �� � K�  JBD�JB@��@�� ��  A�  �� �A  B  A� �B  ˂  �  
C
�A����Ƌ���@��AA �A �� B  AB  �� �� C �B� +A�K��� �� � AB  �B  �� � A� +C� kA����A B A� �B  �B  � K� � kC� �A�k@�� � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       +               audioID�#      
audioType<       gridPosxy	effectID�c�    ; PlayCameraEffect,effectID=200500102; Wait,waitTime=3000; 2       � DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=80; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; � DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=10041,label=buffAgain; Wait,waitTime=80; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffAgain; Wait,waitTime=3000;         K                                                                                                                                                                                                                     	   	   	   	   	      key   K   configF   K      _ENV