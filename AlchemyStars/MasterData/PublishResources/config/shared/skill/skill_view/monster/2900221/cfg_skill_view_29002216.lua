LuaS �

xV           (w@`@../PublishResources/config/shared/skill/skill_view/monster/2900221/cfg_skill_view_29002216.lua         p   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  � �A  B  A� �B  ��� A� � �C � �B����@��AA �A �� B  A�  �� �� � �B� +A�K��� �� � AB  �B �� � A +C� kA����A B A �B  �� C KC  � �� � �C J����A���� A� �� �B  C AC �� � �C� �A��AB �B �� C  A� �C �� � �C� +B�K��� �� � AC  �C �� � A +D� kB�k@ � � �      �  & � !   ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam                 PlayCloseMonsterPreviewRange; &       effectIDList�      �      �      �      �      � PlayCasterAnimation,animName = Skill03R; PlayAudio,audioID = 6053,audioType=1; PlayCasterBindEffect,effectID=965; PlayAudio,audioID = 5038,audioType=1; x PlayAbsorbPieceEffect,flyEffectID=819,offsetX=0,offsetY=0.5,offsetZ=0,flySpeed=1,targetPos=Hit,waitFlyEffectTime=500; �      3      7      �       DataSelectDamage,damageIndex = 1; PlayCasterBindEffect,effectID=963; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=964,turnToTarget=1,deathClear=0,label=doAgain; PlayTargetAddBuff,buffID=30061; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; �      � PlayChangeElement; PlayCasterBindEffect,effectID=956; PlayCasterBindEffect,effectID=957; PlayCasterBindEffect,effectID=958; Wait,waitTime=1000;        T PlayCasterAddBuff,buffID=30181,remove=1; PlayCasterAddBuff,buffID=30186,remove=1;         p                                                                                                                                                                                                                                                                  	   	   	   	   	   	   	   	   	   	   	   
   
   
   
   
   
   
   
   
   
                        key   p   configk   p      _ENV