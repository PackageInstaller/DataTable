LuaS �

xV           (w@\@../PublishResources/config/shared/skill/skill_view/role/1602041/cfg_skill_view_3032041.lua         R     
@@�
�@�
@A�
�A�
@B�
�B�
@C�
�C�K  � ��@  A  A �A  �  K� �B kB� �@�� ��  A�  � ��  B  A �� �� �B� �@��AA �A � �  AB  � �� � �B� +A�K��� ��  A�  �B  � � AC +C� kA����A B A ��  �B  � K� �� kC� �A���� A� � ��  C  A �� � �C� �A�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam       PhasePosDir                PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1600601,waitTime = 2000; ��       PlayAudio,audioID = 2654,audioType=1; PlayTurnToPickUpPosDirection,pickUpIndex=1; PlayCasterBindEffect,effectID =160204111; PlayCasterBindEffect,effectID =160204112; PlayCasterMaterialAnim,animName=eff_1602041_atkult_rongjie_in; PlayCasterAnimation,animName = AtkUlt; Wait,waitTime=1267; PlayShowCasterOnPickPosWithOff,disToPickPos=-2; Wait,waitTime=767; PlayShowCasterOnPickPosWithOff,reset=1; Wait,waitTime=1000; 8 PlayBeHitEffectAtPickUpMonster,hitEffectID=160204113; �      �Z       DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd; PlayTargetAddBuff,buffID=3002040,label=buffAgain; PlayTargetAddBuff,buffID=3062041; PlayTargetAddBuff,buffID=3002042; PlayTargetAddBuff,buffID=3502041; PlayTargetAddBuff,buffID=3532041; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffAgain; �      � DataSelectBuff,buffIndex=1; PlayTargetTurnToCaster; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd; PlayTargetAddBuff,buffID=43002042,label=buffAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffAgain; � DataSelectDamage,damageIndex = 1; Jump,condition=CheckDamageIndexValid; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0;         R                                                                                                                                                                                                                                       	   
   
   
   
   
      key	   R   configM   R      _ENV