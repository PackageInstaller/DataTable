LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/role/1501491/cfg_skill_view_2001491.lua         Q   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  � �A  B  A� ��  ��Ĉ�B���@��AA �A �� B  AB  �� ��  �B� +A�K��� �� � AB  �B  �B � A� +C� kA����A B A� �B  �B  � K� � kC� �A���� A� �� �B  C  AC �� �� �C� �A�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               x PlayCasterAnimation,animName = AtkChain; Wait,waitTime=450; PlayCasterBindEffect,effectID = 3488; Wait,waitTime=3800; +       audioID�	      
audioType� DataSelectResult,effectType=5,index=1; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=41014901,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; �      �a       DataSelectDamage,damageIndex=1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayFlyEffectCasterToTarget,flyEffectID = 3490,flyTrace = 2,offsetx=0,offsety=0.3,offsetz=0,flyTime=230,isBlock=0,label=doAgain; PlayAudio,audioID = 2396,audioType=1; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; �      �       DataSelectDamage,damageIndex=1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3489,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=50; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; L      � DataSelectResult,effectType=142,index=1; Jump,condition=IsAddBloodValueGreaterThan,param=0,result=0,goto=phaseEnd; PlayCasterMaterialAnim,animName=eff_1501491_cure; PlayCasterBindEffect,effectID =3495; PlayDisplayAddHP;         Q                                                                                                                                                                                                                                    	   
   
   
   
   
      key   Q   configL   Q      _ENV