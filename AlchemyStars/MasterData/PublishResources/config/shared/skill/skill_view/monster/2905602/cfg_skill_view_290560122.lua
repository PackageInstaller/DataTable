LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2905602/cfg_skill_view_290560122.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �Q       PlayAudio,audioID=290560106,audioType=1; PlayCasterAnimation,animName=Skill02; Wait,waitTime=300; PlayCasterBindEffect,effectID =290560111; PlayCasterMaterialAnim,animName=PARAM.animName; Wait,waitTime=1800; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1000; �       DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=doAgain; PlayTargetAddBuff,buffID=20026212; PlayTargetAddBuff,buffID=20026211; PlayTargetAddBuff,buffID=29056012; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain;         %                                                                                                                     key   %   config    %      _ENV