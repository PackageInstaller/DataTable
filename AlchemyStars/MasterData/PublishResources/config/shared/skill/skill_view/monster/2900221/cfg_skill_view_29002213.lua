LuaS �

xV           (w@`@../PublishResources/config/shared/skill/skill_view/monster/2900221/cfg_skill_view_29002213.lua         p   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  � �A  B  A� �B  ��� A� � �C � �B����@��AA �A �� B  A�  �� �� � �B� +A�K��� �� � AB  �B �� � A +C� kA����A B A ��  �� C KC  � �� � �C J����A���� A� �� �B  C AC �� � �C� �A��AB �B �� C  A� �� �� D �C� +B�K��� �� � AC  �C �� � A� +D� kB�k@ � � �      �  & �     ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam                 PlayCloseMonsterPreviewRange; &       effectIDList�      �      �      �      �      � PlayCasterAnimation,animName = Skill03L; PlayCasterBindEffect,effectID=955; Wait,waitTime=1800; PlayAudio,audioID = 6051,audioType=1; � PlayAbsorbPieceEffect,flyEffectID=817,offsetX=0,offsetY=0.5,offsetZ=0,flySpeed=1,targetPos=Hit,waitFlyEffectTime=500; PlayCasterAddBuff,buffID=40043; �      1      5      �       DataSelectScopeGridRange,effectType=1; DataSortScopeGridRange,sortType=2; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlayGridRangeEffect,effectID=967,label=playRangeEffect; PlayGridRangeBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,bodyArea=4; PlayTargetAddBuff,buffID=20011; Wait,waitTime=200; DataSelectNextScopeGridRange,label=selectNextGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; L PlayChangeElement; PlayCasterBindEffect,effectID=966; Wait,waitTime=1000;        T PlayCasterAddBuff,buffID=30181,remove=1; PlayCasterAddBuff,buffID=30186,remove=1;         p                                                                                                                                                                                                                                                                  	   	   	   	   	   	   	   	   	   	   	   
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